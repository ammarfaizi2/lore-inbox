Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261653AbVECOTL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261653AbVECOTL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 10:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbVECOSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 10:18:33 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:4544 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261575AbVECOKX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 10:10:23 -0400
Date: Tue, 3 May 2005 16:10:18 +0200
From: Jens Axboe <axboe@suse.de>
To: Jon Escombe <trial@dresco.co.uk>
Cc: linux-kernel@vger.kernel.org,
       James Bottomley <James.Bottomley@steeleye.com>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Suspend/Resume
Message-ID: <20050503141017.GD6115@suse.de>
References: <4267B5B0.8050608@davyandbeth.com> <loom.20050502T161322-252@post.gmane.org> <20050502144703.GA1882@suse.de> <loom.20050502T221228-244@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <loom.20050502T221228-244@post.gmane.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02 2005, Jon Escombe wrote:
> Jens Axboe <axboe <at> suse.de> writes:
> 
> > SATA suspend is completely broken right now, so I'm not surprised. You
> > can shoe-horn this patch onto 2.6.12-rcX - it will reject for every
> > ordered_flush addition, but should be trivial to fix up. If you have
> > problems, let me know and I'll generate a proper diff for you.
> > 
> 
> Thanks, will give that a go.. Is this a fix that's likely to make it
> into 2.6.12?

(remember to cc folks, or your post may go unnoticed)

I don't know, depends on what Jeff/James think of this approach. There
are many different way to solve this problem. I let the scsi bus called
suspend/resume for the devices on that bus, and let the scsi host
adapter perform any device dependent actions. The pci helpers are less
debatable.

Jeff/James? Here's a patch that applies to current git.

Signed-off-by: Jens Axboe <axboe@suse.de>

Index: drivers/scsi/ahci.c
===================================================================
--- b023d524fb0a3b71aa0b957ce7c5540611497370/drivers/scsi/ahci.c  (mode:100644 sha1:da5bd33d982d7e521b6b0603adcb0911395b184d)
+++ uncommitted/drivers/scsi/ahci.c  (mode:100644)
@@ -201,6 +201,8 @@
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
 	.ordered_flush		= 1,
+	.resume			= ata_scsi_device_resume,
+	.suspend		= ata_scsi_device_suspend,
 };
 
 static struct ata_port_operations ahci_ops = {
@@ -272,6 +274,8 @@
 	.id_table		= ahci_pci_tbl,
 	.probe			= ahci_init_one,
 	.remove			= ata_pci_remove_one,
+	.suspend		= ata_pci_device_suspend,
+	.resume			= ata_pci_device_resume,
 };
 
 
Index: drivers/scsi/ata_piix.c
===================================================================
--- b023d524fb0a3b71aa0b957ce7c5540611497370/drivers/scsi/ata_piix.c  (mode:100644 sha1:3867f91ef8c7bebe3d0edf0bd2e3b326a1d4061b)
+++ uncommitted/drivers/scsi/ata_piix.c  (mode:100644)
@@ -104,6 +104,8 @@
 	.id_table		= piix_pci_tbl,
 	.probe			= piix_init_one,
 	.remove			= ata_pci_remove_one,
+	.suspend		= ata_pci_device_suspend,
+	.resume			= ata_pci_device_resume,
 };
 
 static Scsi_Host_Template piix_sht = {
@@ -124,6 +126,8 @@
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
 	.ordered_flush		= 1,
+	.resume			= ata_scsi_device_resume,
+	.suspend		= ata_scsi_device_suspend,
 };
 
 static struct ata_port_operations piix_pata_ops = {
Index: drivers/scsi/libata-core.c
===================================================================
--- b023d524fb0a3b71aa0b957ce7c5540611497370/drivers/scsi/libata-core.c  (mode:100644 sha1:0b5d3a5b7edab5ce17889a0e698805ce346b4d1a)
+++ uncommitted/drivers/scsi/libata-core.c  (mode:100644)
@@ -3299,6 +3299,104 @@
 	ata_qc_complete(qc, ATA_ERR);
 }
 
+/*
+ * Execute a 'simple' command, that only consists of the opcode 'cmd' itself,
+ * without filling any other registers
+ */
+static int ata_do_simple_cmd(struct ata_port *ap, struct ata_device *dev,
+			     u8 cmd)
+{
+	DECLARE_COMPLETION(wait);
+	struct ata_queued_cmd *qc;
+	unsigned long flags;
+	int rc;
+
+	qc = ata_qc_new_init(ap, dev);
+	BUG_ON(qc == NULL);
+
+	qc->tf.command = cmd;
+	qc->tf.flags |= ATA_TFLAG_DEVICE;
+	qc->tf.protocol = ATA_PROT_NODATA;
+
+	qc->waiting = &wait;
+	qc->complete_fn = ata_qc_complete_noop;
+
+	spin_lock_irqsave(&ap->host_set->lock, flags);
+	rc = ata_qc_issue(qc);
+	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+
+	if (!rc)
+		wait_for_completion(&wait);
+
+	return rc;
+}
+
+static int ata_flush_cache(struct ata_port *ap, struct ata_device *dev)
+{
+	u8 cmd;
+
+	if (!ata_try_flush_cache(dev))
+		return 0;
+
+	if (ata_id_has_flush_ext(dev->id))
+		cmd = ATA_CMD_FLUSH_EXT;
+	else
+		cmd = ATA_CMD_FLUSH;
+
+	return ata_do_simple_cmd(ap, dev, cmd);
+}
+
+static int ata_standby_drive(struct ata_port *ap, struct ata_device *dev)
+{
+	return ata_do_simple_cmd(ap, dev, ATA_CMD_STANDBYNOW1);
+}
+
+static int ata_start_drive(struct ata_port *ap, struct ata_device *dev)
+{
+	return ata_do_simple_cmd(ap, dev, ATA_CMD_IDLEIMMEDIATE);
+}
+
+/**
+ *	ata_device_resume - wakeup a previously suspended devices
+ *
+ *	Kick the drive back into action, by sending it an idle immediate
+ *	command and making sure its transfer mode matches between drive
+ *	and host.
+ *
+ */
+int ata_device_resume(struct ata_port *ap, struct ata_device *dev)
+{
+	if (ap->flags & ATA_FLAG_SUSPENDED) {
+		ap->flags &= ~ATA_FLAG_SUSPENDED;
+		ata_set_mode(ap);
+	}
+	if (!ata_dev_present(dev))
+		return 0;
+	if (dev->class == ATA_DEV_ATA)
+		ata_start_drive(ap, dev);
+
+	return 0;
+}
+
+/**
+ *	ata_device_suspend - prepare a device for suspend
+ *
+ *	Flush the cache on the drive, if appropriate, then issue a
+ *	standbynow command.
+ *
+ */
+int ata_device_suspend(struct ata_port *ap, struct ata_device *dev)
+{
+	if (!ata_dev_present(dev))
+		return 0;
+	if (dev->class == ATA_DEV_ATA)
+		ata_flush_cache(ap, dev);
+
+	ata_standby_drive(ap, dev);
+	ap->flags |= ATA_FLAG_SUSPENDED;
+	return 0;
+}
+
 int ata_port_start (struct ata_port *ap)
 {
 	struct device *dev = ap->host_set->dev;
@@ -3937,6 +4035,23 @@
 
 	return (tmp == bits->val) ? 1 : 0;
 }
+
+int ata_pci_device_suspend(struct pci_dev *pdev, pm_message_t state)
+{
+	pci_save_state(pdev);
+	pci_disable_device(pdev);
+	pci_set_power_state(pdev, PCI_D3hot);
+	return 0;
+}
+
+int ata_pci_device_resume(struct pci_dev *pdev)
+{
+	pci_set_power_state(pdev, PCI_D0);
+	pci_restore_state(pdev);
+	pci_enable_device(pdev);
+	pci_set_master(pdev);
+	return 0;
+}
 #endif /* CONFIG_PCI */
 
 
@@ -4021,4 +4136,11 @@
 EXPORT_SYMBOL_GPL(ata_pci_init_native_mode);
 EXPORT_SYMBOL_GPL(ata_pci_init_one);
 EXPORT_SYMBOL_GPL(ata_pci_remove_one);
+EXPORT_SYMBOL_GPL(ata_pci_device_suspend);
+EXPORT_SYMBOL_GPL(ata_pci_device_resume);
 #endif /* CONFIG_PCI */
+
+EXPORT_SYMBOL_GPL(ata_device_suspend);
+EXPORT_SYMBOL_GPL(ata_device_resume);
+EXPORT_SYMBOL_GPL(ata_scsi_device_suspend);
+EXPORT_SYMBOL_GPL(ata_scsi_device_resume);
Index: drivers/scsi/libata-scsi.c
===================================================================
--- b023d524fb0a3b71aa0b957ce7c5540611497370/drivers/scsi/libata-scsi.c  (mode:100644 sha1:4c96df060c3bad9af44ab4c4664d8cba38c63030)
+++ uncommitted/drivers/scsi/libata-scsi.c  (mode:100644)
@@ -387,6 +387,22 @@
 	return 0;
 }
 
+int ata_scsi_device_resume(struct scsi_device *sdev)
+{
+	struct ata_port *ap = (struct ata_port *) &sdev->host->hostdata[0];
+	struct ata_device *dev = &ap->device[sdev->id];
+
+	return ata_device_resume(ap, dev);
+}
+
+int ata_scsi_device_suspend(struct scsi_device *sdev)
+{
+	struct ata_port *ap = (struct ata_port *) &sdev->host->hostdata[0];
+	struct ata_device *dev = &ap->device[sdev->id];
+
+	return ata_device_suspend(ap, dev);
+}
+
 /**
  *	ata_scsi_flush_xlat - Translate SCSI SYNCHRONIZE CACHE command
  *	@qc: Storage for translated ATA taskfile
Index: drivers/scsi/sata_nv.c
===================================================================
--- b023d524fb0a3b71aa0b957ce7c5540611497370/drivers/scsi/sata_nv.c  (mode:100644 sha1:69009f853a4917f54a88aa0c2cf3e6fb0428c8f7)
+++ uncommitted/drivers/scsi/sata_nv.c  (mode:100644)
@@ -187,6 +187,8 @@
 	.id_table		= nv_pci_tbl,
 	.probe			= nv_init_one,
 	.remove			= ata_pci_remove_one,
+	.suspend		= ata_pci_device_suspend,
+	.resume			= ata_pci_device_resume,
 };
 
 static Scsi_Host_Template nv_sht = {
@@ -207,6 +209,8 @@
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
 	.ordered_flush		= 1,
+	.resume			= ata_scsi_device_resume,
+	.suspend		= ata_scsi_device_suspend,
 };
 
 static struct ata_port_operations nv_ops = {
Index: drivers/scsi/sata_promise.c
===================================================================
--- b023d524fb0a3b71aa0b957ce7c5540611497370/drivers/scsi/sata_promise.c  (mode:100644 sha1:19a13e3590f4eca5fab24675ffec12aaa56dd57f)
+++ uncommitted/drivers/scsi/sata_promise.c  (mode:100644)
@@ -103,6 +103,8 @@
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
 	.ordered_flush		= 1,
+	.resume			= ata_scsi_device_resume,
+	.suspend		= ata_scsi_device_suspend,
 };
 
 static struct ata_port_operations pdc_ata_ops = {
@@ -178,6 +180,8 @@
 	.id_table		= pdc_ata_pci_tbl,
 	.probe			= pdc_ata_init_one,
 	.remove			= ata_pci_remove_one,
+	.suspend		= ata_pci_device_suspend,
+	.resume			= ata_pci_device_resume,
 };
 
 
Index: drivers/scsi/sata_qstor.c
===================================================================
--- b023d524fb0a3b71aa0b957ce7c5540611497370/drivers/scsi/sata_qstor.c  (mode:100644 sha1:dfd3621047171dc748ba9a11c82a418f89faaed6)
+++ uncommitted/drivers/scsi/sata_qstor.c  (mode:100644)
@@ -140,6 +140,8 @@
 	.dma_boundary		= QS_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
+	.resume			= ata_scsi_device_resume,
+	.suspend		= ata_scsi_device_suspend,
 };
 
 static struct ata_port_operations qs_ata_ops = {
@@ -191,6 +193,8 @@
 	.id_table		= qs_ata_pci_tbl,
 	.probe			= qs_ata_init_one,
 	.remove			= ata_pci_remove_one,
+	.suspend		= ata_pci_device_suspend,
+	.resume			= ata_pci_device_resume,
 };
 
 static int qs_check_atapi_dma(struct ata_queued_cmd *qc)
Index: drivers/scsi/sata_sil.c
===================================================================
--- b023d524fb0a3b71aa0b957ce7c5540611497370/drivers/scsi/sata_sil.c  (mode:100644 sha1:f0489dc302a03054d6461ba54c9705f30190a8f4)
+++ uncommitted/drivers/scsi/sata_sil.c  (mode:100644)
@@ -115,6 +115,8 @@
 	.id_table		= sil_pci_tbl,
 	.probe			= sil_init_one,
 	.remove			= ata_pci_remove_one,
+	.suspend		= ata_pci_device_suspend,
+	.resume			= ata_pci_device_resume,
 };
 
 static Scsi_Host_Template sil_sht = {
@@ -135,6 +137,8 @@
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
 	.ordered_flush		= 1,
+	.resume			= ata_scsi_device_resume,
+	.suspend		= ata_scsi_device_suspend,
 };
 
 static struct ata_port_operations sil_ops = {
Index: drivers/scsi/sata_sis.c
===================================================================
--- b023d524fb0a3b71aa0b957ce7c5540611497370/drivers/scsi/sata_sis.c  (mode:100644 sha1:5105ddd08447807df3710492f70c31bf6f0d8767)
+++ uncommitted/drivers/scsi/sata_sis.c  (mode:100644)
@@ -71,6 +71,8 @@
 	.id_table		= sis_pci_tbl,
 	.probe			= sis_init_one,
 	.remove			= ata_pci_remove_one,
+	.suspend		= ata_pci_device_suspend,
+	.resume			= ata_pci_device_resume,
 };
 
 static Scsi_Host_Template sis_sht = {
@@ -91,6 +93,8 @@
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
 	.ordered_flush		= 1,
+	.resume			= ata_scsi_device_resume,
+	.suspend		= ata_scsi_device_suspend,
 };
 
 static struct ata_port_operations sis_ops = {
Index: drivers/scsi/sata_svw.c
===================================================================
--- b023d524fb0a3b71aa0b957ce7c5540611497370/drivers/scsi/sata_svw.c  (mode:100644 sha1:8d1a5d25c05364e41e7f98198b94335ed30d0046)
+++ uncommitted/drivers/scsi/sata_svw.c  (mode:100644)
@@ -289,6 +289,8 @@
 #endif
 	.bios_param		= ata_std_bios_param,
 	.ordered_flush		= 1,
+	.resume			= ata_scsi_device_resume,
+	.suspend		= ata_scsi_device_suspend,
 };
 
 
@@ -458,6 +460,8 @@
 	.id_table		= k2_sata_pci_tbl,
 	.probe			= k2_sata_init_one,
 	.remove			= ata_pci_remove_one,
+	.suspend		= ata_pci_device_suspend,
+	.resume			= ata_pci_device_resume,
 };
 
 
Index: drivers/scsi/sata_sx4.c
===================================================================
--- b023d524fb0a3b71aa0b957ce7c5540611497370/drivers/scsi/sata_sx4.c  (mode:100644 sha1:70118650c461e9d5d10ff0c3053ae5b49c6755a0)
+++ uncommitted/drivers/scsi/sata_sx4.c  (mode:100644)
@@ -189,6 +189,8 @@
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
 	.ordered_flush		= 1,
+	.resume			= ata_scsi_device_resume,
+	.suspend		= ata_scsi_device_suspend,
 };
 
 static struct ata_port_operations pdc_20621_ops = {
@@ -235,6 +237,8 @@
 	.id_table		= pdc_sata_pci_tbl,
 	.probe			= pdc_sata_init_one,
 	.remove			= ata_pci_remove_one,
+	.suspend		= ata_pci_device_suspend,
+	.resume			= ata_pci_device_resume,
 };
 
 
Index: drivers/scsi/sata_uli.c
===================================================================
--- b023d524fb0a3b71aa0b957ce7c5540611497370/drivers/scsi/sata_uli.c  (mode:100644 sha1:0bff4f475f262c5c40254aecf85bd6a7137bd04e)
+++ uncommitted/drivers/scsi/sata_uli.c  (mode:100644)
@@ -63,6 +63,8 @@
 	.id_table		= uli_pci_tbl,
 	.probe			= uli_init_one,
 	.remove			= ata_pci_remove_one,
+	.suspend		= ata_pci_device_suspend,
+	.resume			= ata_pci_device_resume,
 };
 
 static Scsi_Host_Template uli_sht = {
@@ -83,6 +85,8 @@
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
 	.ordered_flush		= 1,
+	.resume			= ata_scsi_device_resume,
+	.suspend		= ata_scsi_device_suspend,
 };
 
 static struct ata_port_operations uli_ops = {
Index: drivers/scsi/sata_via.c
===================================================================
--- b023d524fb0a3b71aa0b957ce7c5540611497370/drivers/scsi/sata_via.c  (mode:100644 sha1:3a7830667277f35f71a83db5705b8cb2d376bafc)
+++ uncommitted/drivers/scsi/sata_via.c  (mode:100644)
@@ -83,6 +83,8 @@
 	.id_table		= svia_pci_tbl,
 	.probe			= svia_init_one,
 	.remove			= ata_pci_remove_one,
+	.suspend		= ata_pci_device_suspend,
+	.resume			= ata_pci_device_resume,
 };
 
 static Scsi_Host_Template svia_sht = {
@@ -103,6 +105,8 @@
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
 	.ordered_flush		= 1,
+	.resume			= ata_scsi_device_resume,
+	.suspend		= ata_scsi_device_suspend,
 };
 
 static struct ata_port_operations svia_sata_ops = {
Index: drivers/scsi/sata_vsc.c
===================================================================
--- b023d524fb0a3b71aa0b957ce7c5540611497370/drivers/scsi/sata_vsc.c  (mode:100644 sha1:2c28f0ad73c204420aa4b419a60341a8b801d7fa)
+++ uncommitted/drivers/scsi/sata_vsc.c  (mode:100644)
@@ -206,6 +206,8 @@
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
 	.ordered_flush		= 1,
+	.resume			= ata_scsi_device_resume,
+	.suspend		= ata_scsi_device_suspend,
 };
 
 
@@ -382,6 +384,8 @@
 	.id_table		= vsc_sata_pci_tbl,
 	.probe			= vsc_sata_init_one,
 	.remove			= ata_pci_remove_one,
+	.suspend		= ata_pci_device_suspend,
+	.resume			= ata_pci_device_resume,
 };
 
 
Index: drivers/scsi/scsi_lib.c
===================================================================
--- b023d524fb0a3b71aa0b957ce7c5540611497370/drivers/scsi/scsi_lib.c  (mode:100644 sha1:d18da21c9c57e0ef590369ea815b7b1adba4042b)
+++ uncommitted/drivers/scsi/scsi_lib.c  (mode:100644)
@@ -1855,8 +1855,9 @@
 void
 scsi_device_resume(struct scsi_device *sdev)
 {
-	if(scsi_device_set_state(sdev, SDEV_RUNNING))
+	if (scsi_device_set_state(sdev, SDEV_RUNNING))
 		return;
+
 	scsi_run_queue(sdev->request_queue);
 }
 EXPORT_SYMBOL(scsi_device_resume);
Index: drivers/scsi/scsi_sysfs.c
===================================================================
--- b023d524fb0a3b71aa0b957ce7c5540611497370/drivers/scsi/scsi_sysfs.c  (mode:100644 sha1:e75ee4671ee3a0a6dcb608a73d6bd2f4007eff09)
+++ uncommitted/drivers/scsi/scsi_sysfs.c  (mode:100644)
@@ -199,9 +199,40 @@
 	return (sdp->inq_periph_qual == SCSI_INQ_PQ_CON)? 1: 0;
 }
 
+static int scsi_bus_suspend(struct device * dev, pm_message_t state)
+{
+	struct scsi_device *sdev = to_scsi_device(dev);
+	struct scsi_host_template *sht = sdev->host->hostt;
+	int err;
+
+	err = scsi_device_quiesce(sdev);
+	if (err)
+		return err;
+
+	if (sht->suspend)
+		err = sht->suspend(sdev);
+
+	return err;
+}
+
+static int scsi_bus_resume(struct device * dev)
+{
+	struct scsi_device *sdev = to_scsi_device(dev);
+	struct scsi_host_template *sht = sdev->host->hostt;
+	int err = 0;
+
+	if (sht->resume)
+		err = sht->resume(sdev);
+
+	scsi_device_resume(sdev);
+	return err;
+}
+
 struct bus_type scsi_bus_type = {
         .name		= "scsi",
         .match		= scsi_bus_match,
+	.suspend	= scsi_bus_suspend,
+	.resume		= scsi_bus_resume,
 };
 
 int scsi_sysfs_register(void)
Index: include/linux/ata.h
===================================================================
--- b023d524fb0a3b71aa0b957ce7c5540611497370/include/linux/ata.h  (mode:100644 sha1:f178894edd04f954a4f650661175b5fe009011c6)
+++ uncommitted/include/linux/ata.h  (mode:100644)
@@ -125,6 +125,8 @@
 	ATA_CMD_PACKET		= 0xA0,
 	ATA_CMD_VERIFY		= 0x40,
 	ATA_CMD_VERIFY_EXT	= 0x42,
+	ATA_CMD_STANDBYNOW1	= 0xE0,
+	ATA_CMD_IDLEIMMEDIATE	= 0xE1,
 
 	/* SETFEATURES stuff */
 	SETFEATURES_XFER	= 0x03,
Index: include/linux/libata.h
===================================================================
--- b023d524fb0a3b71aa0b957ce7c5540611497370/include/linux/libata.h  (mode:100644 sha1:505160ab472b0198ec5393380ce7c21b2fad85d1)
+++ uncommitted/include/linux/libata.h  (mode:100644)
@@ -113,6 +113,7 @@
 	ATA_FLAG_MMIO		= (1 << 6), /* use MMIO, not PIO */
 	ATA_FLAG_SATA_RESET	= (1 << 7), /* use COMRESET */
 	ATA_FLAG_PIO_DMA	= (1 << 8), /* PIO cmds via DMA */
+	ATA_FLAG_SUSPENDED	= (1 << 9), /* port is suspended */
 
 	ATA_QCFLAG_ACTIVE	= (1 << 1), /* cmd not yet ack'd to scsi lyer */
 	ATA_QCFLAG_SG		= (1 << 3), /* have s/g table? */
@@ -387,6 +388,8 @@
 extern int ata_pci_init_one (struct pci_dev *pdev, struct ata_port_info **port_info,
 			     unsigned int n_ports);
 extern void ata_pci_remove_one (struct pci_dev *pdev);
+extern int ata_pci_device_suspend(struct pci_dev *pdev, pm_message_t state);
+extern int ata_pci_device_resume(struct pci_dev *pdev);
 #endif /* CONFIG_PCI */
 extern int ata_device_add(struct ata_probe_ent *ent);
 extern int ata_scsi_detect(Scsi_Host_Template *sht);
@@ -395,6 +398,10 @@
 extern int ata_scsi_error(struct Scsi_Host *host);
 extern int ata_scsi_release(struct Scsi_Host *host);
 extern unsigned int ata_host_intr(struct ata_port *ap, struct ata_queued_cmd *qc);
+extern int ata_scsi_device_resume(struct scsi_device *);
+extern int ata_scsi_device_suspend(struct scsi_device *);
+extern int ata_device_resume(struct ata_port *, struct ata_device *);
+extern int ata_device_suspend(struct ata_port *, struct ata_device *);
 /*
  * Default driver ops implementations
  */
Index: include/scsi/scsi_host.h
===================================================================
--- b023d524fb0a3b71aa0b957ce7c5540611497370/include/scsi/scsi_host.h  (mode:100644 sha1:1cee1e100943dafe00c14d5329b73659062a4d1a)
+++ uncommitted/include/scsi/scsi_host.h  (mode:100644)
@@ -270,6 +270,12 @@
 	int (*proc_info)(struct Scsi_Host *, char *, char **, off_t, int, int);
 
 	/*
+	 * suspend support
+	 */
+	int (*resume)(struct scsi_device *);
+	int (*suspend)(struct scsi_device *);
+
+	/*
 	 * Name of proc directory
 	 */
 	char *proc_name;

-- 
Jens Axboe

