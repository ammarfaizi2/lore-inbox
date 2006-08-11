Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030671AbWHKCTx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030671AbWHKCTx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 22:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030674AbWHKCTx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 22:19:53 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:30137 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030671AbWHKCTu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 22:19:50 -0400
Message-ID: <44DBE943.4080303@us.ibm.com>
Date: Thu, 10 Aug 2006 19:19:47 -0700
From: "Darrick J. Wong" <djwong@us.ibm.com>
Reply-To: "Darrick J. Wong" <djwong@us.ibm.com>
Organization: IBM LTC
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: linux-scsi@vger.kernel.org
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexis Bruemmer <alexisb@us.ibm.com>
Subject: [PATCH 1/2] Add SATA support to libsas
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hook the scsi_host_template functions in libsas to delegate
functionality to libata when appropriate.

Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>

diff --git a/drivers/scsi/libsas/sas_discover.c b/drivers/scsi/libsas/sas_discover.c
index b0705ee..76bbb9f 100644
--- a/drivers/scsi/libsas/sas_discover.c
+++ b/drivers/scsi/libsas/sas_discover.c
@@ -255,6 +255,7 @@ static int sas_get_port_device(struct as
 
 	switch (dev->dev_type) {
 	case SAS_END_DEV:
+	case SATA_DEV:
 		rphy = sas_end_device_alloc(port->port);
 		break;
 	case EDGE_DEV:
@@ -265,7 +266,6 @@ static int sas_get_port_device(struct as
 		rphy = sas_expander_alloc(port->port,
 					  SAS_FANOUT_EXPANDER_DEVICE);
 		break;
-	case SATA_DEV:
 	default:
 		printk("ERROR: Unidentified device type %d\n", dev->dev_type);
 		rphy = NULL;
@@ -398,6 +398,15 @@ static void sas_sata_propagate_sas_addr(
 	spin_unlock_irqrestore(&port->phy_list_lock, flags);
 }
 
+static inline void sas_mark_dev_sata(struct domain_device *dev)
+{
+	dev->rphy->identify = dev->port->phy->identify;
+	dev->rphy->identify.initiator_port_protocols = SAS_PROTOCOL_SATA;
+	dev->rphy->identify.target_port_protocols = SAS_PROTOCOL_SATA;
+	dev->rphy->identify.device_type = SAS_END_DEVICE;
+	memcpy(&dev->rphy->identify.sas_address, dev->sas_addr, SAS_ADDR_SIZE);
+}
+
 #define ATA_IDENTIFY_DEV         0xEC
 #define ATA_IDENTIFY_PACKET_DEV  0xA1
 #define ATA_SET_FEATURES         0xEF
@@ -480,7 +489,14 @@ cont1:
 	   present.
 	sas_satl_register_dev(dev);
 	*/
-	return 0;
+	
+	sas_mark_dev_sata(dev);
+
+	res = sas_rphy_add(dev->rphy);
+	if (res)
+		goto out_err;
+
+	return res;
 out_err:
 	dev->sata_dev.identify_packet_device = NULL;
 	dev->sata_dev.identify_device = NULL;
diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
index a0d5133..38893a7 100644
--- a/drivers/scsi/libsas/sas_scsi_host.c
+++ b/drivers/scsi/libsas/sas_scsi_host.c
@@ -36,6 +36,7 @@
 #include <linux/err.h>
 #include <linux/blkdev.h>
 #include <linux/scatterlist.h>
+#include <linux/libata.h>
 
 /* ---------- SCSI Host glue ---------- */
 
@@ -185,6 +186,11 @@ static int sas_queue_up(struct sas_task 
 	return 0;
 }
 
+static inline int dev_is_sata(struct domain_device *dev)
+{
+	return (dev->rphy->identify.target_port_protocols & SAS_PROTOCOL_SATA);
+}
+
 /**
  * sas_queuecommand -- Enqueue a command for processing
  * @parameters: See SCSI Core documentation
@@ -206,6 +212,12 @@ int sas_queuecommand(struct scsi_cmnd *c
 		struct sas_ha_struct *sas_ha = dev->port->ha;
 		struct sas_task *task;
 
+		if (dev_is_sata(dev)) {
+			res = ata_sas_queuecmd(cmd, scsi_done,
+					       dev->sata_dev.ap);
+			goto out;
+		}
+
 		res = -ENOMEM;
 		task = sas_create_task(cmd, dev, GFP_ATOMIC);
 		if (!task)
@@ -529,7 +541,279 @@ enum scsi_eh_timer_return sas_scsi_timed
 	return EH_NOT_HANDLED;
 }
 
-int sas_target_alloc(struct scsi_target *starget)
+static enum ata_completion_errors sas_to_ata_err(struct task_status_struct *ts)
+{
+	/* Cheesy attempt to translate SAS errors into ATA.  Hah! */
+
+	/* transport error */
+	if (ts->resp == SAS_TASK_UNDELIVERED)
+		return AC_ERR_ATA_BUS;
+	
+	/* ts->resp == SAS_TASK_COMPLETE */
+	/* task delivered, what happened afterwards? */
+	switch (ts->stat) {
+		case SAS_DEV_NO_RESPONSE:
+			return AC_ERR_TIMEOUT;
+
+		case SAS_INTERRUPTED:
+		case SAS_PHY_DOWN:
+		case SAS_NAK_R_ERR:
+			return AC_ERR_ATA_BUS;
+
+
+		case SAS_DATA_UNDERRUN:
+			/*
+			 * Some programs that use the taskfile interface
+			 * (smartctl in particular) can cause underrun
+			 * problems.  Ignore these errors, perhaps at our
+			 * peril.
+			 */
+			return 0;
+
+		case SAS_DATA_OVERRUN:
+		case SAS_QUEUE_FULL:
+		case SAS_DEVICE_UNKNOWN:
+		case SAS_SG_ERR:
+			return AC_ERR_INVALID;
+
+		case SAM_CHECK_COND:
+		case SAS_OPEN_TO:
+		case SAS_OPEN_REJECT:
+		case SAS_PROTO_RESPONSE:
+			SAS_DPRINTK("%s: Saw error %d.  What to do?\n",
+				    __FUNCTION__, ts->stat);
+			return AC_ERR_OTHER;
+
+		case SAS_ABORTED_TASK:
+			return AC_ERR_DEV;
+
+		default:
+			return 0;
+	}
+}
+
+static void sas_ata_task_done(struct sas_task *task)
+{
+	struct ata_queued_cmd *qc = task->uldd_task;
+	struct domain_device *dev = qc->ap->private_data;
+	struct task_status_struct *stat = &task->task_status;
+	struct ata_task_resp *resp = (struct ata_task_resp *)stat->buf;
+	enum ata_completion_errors ac;
+
+	ac = sas_to_ata_err(stat);
+	if (ac) {
+		SAS_DPRINTK("%s: SAS error %x\n", __FUNCTION__, stat->stat);
+		/* We saw a SAS error. Send a vague error. */
+		qc->err_mask = ac;
+		dev->sata_dev.tf.feature = 0x04; /* status err */
+		dev->sata_dev.tf.command = ATA_ERR;
+		goto end;
+	}
+
+	ata_tf_from_fis(resp->ending_fis, &dev->sata_dev.tf);
+	qc->err_mask |= ac_err_mask(dev->sata_dev.tf.command);
+	dev->sata_dev.sstatus = resp->sstatus;
+	dev->sata_dev.serror = resp->serror;
+	dev->sata_dev.scontrol = resp->scontrol;
+	dev->sata_dev.ap->sactive = resp->sactive;
+end:
+	ata_qc_complete(qc);
+	list_del_init(&task->list);
+	sas_free_task(task);
+}
+
+int sas_ioctl(struct scsi_device *sdev, int cmd, void __user *arg)
+{
+	struct domain_device *dev = sdev_to_domain_dev(sdev);
+
+	if (dev_is_sata(dev))
+		return ata_scsi_ioctl(sdev, cmd, arg);
+	
+	return -EINVAL;
+}
+
+static unsigned int sas_ata_qc_issue(struct ata_queued_cmd *qc)
+{
+	int res = -ENOMEM;
+	struct sas_task *task;
+	struct domain_device *dev = qc->ap->private_data;
+	struct sas_ha_struct *sas_ha = dev->port->ha;
+	struct Scsi_Host *host = sas_ha->core.shost;
+	struct sas_internal *i = to_sas_internal(host->transportt);
+	struct scatterlist *sg;
+	unsigned int num = 0;
+	unsigned int xfer = 0;
+
+	task = sas_alloc_task(GFP_ATOMIC);
+	if (!task)
+		goto out;
+	task->dev = dev;
+	task->task_proto = SAS_PROTOCOL_STP;
+	task->task_done = sas_ata_task_done;
+
+	ata_tf_to_fis(&qc->tf, (u8*)&task->ata_task.fis, 0);
+	task->uldd_task = qc;
+	if (is_atapi_taskfile(&qc->tf)) {
+		memcpy(task->ata_task.atapi_packet, qc->cdb, ATAPI_CDB_LEN);
+		task->total_xfer_len = qc->nbytes + qc->pad_len;
+		task->num_scatter = qc->pad_len ? qc->n_elem + 1 : qc->n_elem;
+	} else {
+		ata_for_each_sg(sg, qc) {
+			num++;
+			xfer += sg->length;
+		}
+
+		task->total_xfer_len = xfer;
+		task->num_scatter = num;
+	}
+
+	task->data_dir = qc->dma_dir;
+	task->scatter = qc->__sg;
+	task->ata_task.retry_count = 1;
+	task->task_state_flags = SAS_TASK_STATE_PENDING;
+
+	if (qc->tf.protocol == ATA_PROT_DMA)
+		task->ata_task.dma_xfer = 1;
+
+	if (sas_ha->lldd_max_execute_num < 2)
+		res = i->dft->lldd_execute_task(task, 1, GFP_ATOMIC);
+	else
+		res = sas_queue_up(task);
+
+	/* Examine */
+	if (res) {
+		SAS_DPRINTK("lldd_execute_task returned: %d\n", res);
+
+		sas_free_task(task);
+		if (res == -SAS_QUEUE_FULL)
+			return -ENOMEM;
+	}
+
+out:
+	return res;
+}
+
+static u8 sas_ata_check_status(struct ata_port *ap)
+{
+	struct domain_device *dev = ap->private_data;
+	return dev->sata_dev.tf.command;
+}
+
+static void sas_ata_phy_reset(struct ata_port *ap)
+{
+	struct domain_device *dev = ap->private_data;
+	struct sas_internal *i =
+		to_sas_internal(dev->port->ha->core.shost->transportt);
+	int res = 0;
+
+	if (i->dft->lldd_I_T_nexus_reset)
+		res = i->dft->lldd_I_T_nexus_reset(dev);
+
+	if (res)
+		SAS_DPRINTK("%s: Unable to reset I T nexus?\n", __FUNCTION__);
+
+	switch (dev->sata_dev.command_set) {
+		case ATA_COMMAND_SET:
+			SAS_DPRINTK("%s: Found ATA device.\n", __FUNCTION__);
+			ap->device[0].class = ATA_DEV_ATA;
+			break;
+		case ATAPI_COMMAND_SET:
+			SAS_DPRINTK("%s: Found ATAPI device.\n", __FUNCTION__);
+			ap->device[0].class = ATA_DEV_ATAPI;
+			break;
+		default:
+			SAS_DPRINTK("%s: Unknown SATA command set: %d.\n",
+				    __FUNCTION__,
+				    dev->sata_dev.command_set);
+			ap->device[0].class = ATA_DEV_ATA;
+			break;
+	}
+
+	ap->cbl = ATA_CBL_SATA;
+}
+
+static void sas_ata_post_internal(struct ata_queued_cmd *qc)
+{
+	if (qc->flags & ATA_QCFLAG_FAILED)
+		qc->err_mask |= AC_ERR_OTHER;
+
+	if (qc->err_mask)
+		SAS_DPRINTK("%s: Failure; reset phy!\n", __FUNCTION__);
+}
+
+static void sas_ata_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
+{
+	struct domain_device *dev = ap->private_data;
+	memcpy(tf, &dev->sata_dev.tf, sizeof (*tf));
+}
+
+static void sas_ata_scr_write(struct ata_port *ap, unsigned int sc_reg_in,
+			      u32 val)
+{
+	struct domain_device *dev = ap->private_data;
+
+	SAS_DPRINTK("STUB %s\n", __FUNCTION__);
+	switch (sc_reg_in) {
+		case SCR_STATUS:
+			dev->sata_dev.sstatus = val;
+			break;
+		case SCR_CONTROL:
+			dev->sata_dev.scontrol = val;
+			break;
+		case SCR_ERROR:
+			dev->sata_dev.serror = val;
+			break;
+		case SCR_ACTIVE:
+			dev->sata_dev.ap->sactive = val;
+			break;
+	}
+}
+
+static u32 sas_ata_scr_read(struct ata_port *ap, unsigned int sc_reg_in)
+{
+	struct domain_device *dev = ap->private_data;
+
+	SAS_DPRINTK("STUB %s\n", __FUNCTION__);
+	switch (sc_reg_in) {
+		case SCR_STATUS:
+			return dev->sata_dev.sstatus;
+		case SCR_CONTROL:
+			return dev->sata_dev.scontrol;
+		case SCR_ERROR:
+			return dev->sata_dev.serror;
+		case SCR_ACTIVE:
+			return dev->sata_dev.ap->sactive;
+		default:
+			return 0xffffffffU;
+	}
+}
+
+static struct ata_port_operations sas_sata_ops = {
+	.port_disable		= ata_port_disable,
+	.check_status		= sas_ata_check_status,
+	.check_altstatus	= sas_ata_check_status,
+	.dev_select		= ata_noop_dev_select,
+	.phy_reset		= sas_ata_phy_reset,
+	.post_internal_cmd	= sas_ata_post_internal,
+	.tf_read		= sas_ata_tf_read,
+	.qc_prep		= ata_noop_qc_prep,
+	.qc_issue		= sas_ata_qc_issue,
+	.port_start		= ata_sas_port_start,
+	.port_stop		= ata_sas_port_stop,
+	.scr_read		= sas_ata_scr_read,
+	.scr_write		= sas_ata_scr_write
+};
+
+static struct ata_port_info sata_port_info = {
+	.host_flags = ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY | ATA_FLAG_SATA_RESET |
+		      ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA,
+	.pio_mask = 0x1f, /* PIO0-4 */
+	.mwdma_mask = 0x07, /* MWDMA0-2 */
+	.udma_mask = ATA_UDMA6,
+	.port_ops = &sas_sata_ops
+};
+
+static inline struct domain_device *sas_find_dev(struct scsi_target *starget)
 {
 	struct Scsi_Host *shost = dev_to_shost(&starget->dev);
 	struct sas_rphy *rphy = dev_to_rphy(starget->dev.parent);
@@ -554,9 +838,39 @@ int sas_target_alloc(struct scsi_target 
 	}
  found:
 	spin_unlock(&ha->phy_port_lock);
+
+	return found_dev;
+}
+
+int sas_target_alloc(struct scsi_target *starget)
+{
+	struct Scsi_Host *shost = dev_to_shost(&starget->dev);
+	struct sas_ha_struct *ha = SHOST_TO_SAS_HA(shost);
+	struct domain_device *found_dev = sas_find_dev(starget);
+
 	if (!found_dev)
 		return -ENODEV;
 
+	if (dev_is_sata(found_dev)) {
+		struct ata_port *ap;
+
+		ata_host_set_init(&found_dev->sata_dev.ata_host_set,
+				  &ha->pcidev->dev,
+				  sata_port_info.host_flags,
+				  &sas_sata_ops);
+		ap = ata_sas_port_alloc(&found_dev->sata_dev.ata_host_set,
+					&sata_port_info,
+					shost);
+		if (!ap) {
+			SAS_DPRINTK("ata_sas_port_alloc failed.\n");
+			return -ENODEV;
+		}
+
+		ap->private_data = found_dev;
+		ap->cbl = ATA_CBL_SATA;
+		found_dev->sata_dev.ap = ap;
+	}
+
 	starget->hostdata = found_dev;
 	return 0;
 }
@@ -571,6 +885,11 @@ int sas_slave_configure(struct scsi_devi
 
 	BUG_ON(dev->rphy->identify.device_type != SAS_END_DEVICE);
 
+	if (dev_is_sata(dev)) {
+		ata_sas_slave_configure(scsi_dev, dev->sata_dev.ap);
+		return 0;
+	}
+
 	sas_ha = dev->port->ha;
 
 	sas_read_port_mode_page(scsi_dev);
@@ -592,6 +911,10 @@ int sas_slave_configure(struct scsi_devi
 
 void sas_slave_destroy(struct scsi_device *scsi_dev)
 {
+	struct domain_device *dev = sdev_to_domain_dev(scsi_dev);
+
+	if (dev_is_sata(dev))
+		ata_port_disable(dev->sata_dev.ap);
 }
 
 int sas_change_queue_depth(struct scsi_device *scsi_dev, int new_depth)
@@ -763,6 +1086,29 @@ void sas_shutdown_queue(struct sas_ha_st
 	spin_unlock_irqrestore(&core->task_queue_lock, flags);
 }
 
+int sas_slave_alloc(struct scsi_device *scsi_dev)
+{
+	struct domain_device *dev = sdev_to_domain_dev(scsi_dev);
+
+	if (dev_is_sata(dev))
+		return ata_sas_port_init(dev->sata_dev.ap);
+
+	return 0;
+}
+
+void sas_target_destroy(struct scsi_target *starget)
+{
+	struct domain_device *found_dev = sas_find_dev(starget);
+
+	if (!found_dev)
+		return;
+
+	if (dev_is_sata(found_dev))
+		ata_sas_port_destroy(found_dev->sata_dev.ap);
+
+	return;
+}
+
 EXPORT_SYMBOL_GPL(sas_queuecommand);
 EXPORT_SYMBOL_GPL(sas_target_alloc);
 EXPORT_SYMBOL_GPL(sas_slave_configure);
@@ -770,3 +1116,6 @@ EXPORT_SYMBOL_GPL(sas_slave_destroy);
 EXPORT_SYMBOL_GPL(sas_change_queue_depth);
 EXPORT_SYMBOL_GPL(sas_change_queue_type);
 EXPORT_SYMBOL_GPL(sas_bios_param);
+EXPORT_SYMBOL_GPL(sas_slave_alloc);
+EXPORT_SYMBOL_GPL(sas_target_destroy);
+EXPORT_SYMBOL_GPL(sas_ioctl);
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index b109fe5..0aaac5c 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -30,6 +30,7 @@
 #include <linux/timer.h>
 #include <linux/pci.h>
 #include <scsi/sas.h>
+#include <linux/libata.h>
 #include <linux/list.h>
 #include <asm/semaphore.h>
 #include <scsi/scsi_device.h>
@@ -164,6 +165,13 @@ struct sata_device {
 
         u8     port_no;        /* port number, if this is a PM (Port) */
         struct list_head children; /* PM Ports if this is a PM */
+
+	struct ata_port *ap;
+	struct ata_host_set ata_host_set;
+	struct ata_taskfile tf;
+	u32 sstatus;
+	u32 serror;
+	u32 scontrol;
 };
 
 /* ---------- Domain device ---------- */
@@ -626,4 +634,8 @@ void sas_unregister_devices(struct sas_h
 
 void sas_init_dev(struct domain_device *);
 
+extern void sas_target_destroy(struct scsi_target *);
+extern int sas_slave_alloc(struct scsi_device *);
+extern int sas_ioctl(struct scsi_device *sdev, int cmd, void __user *arg);
+
 #endif /* _SASLIB_H_ */
