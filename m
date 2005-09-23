Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751303AbVIWVLN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbVIWVLN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 17:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbVIWVLN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 17:11:13 -0400
Received: from thorn.pobox.com ([208.210.124.75]:53399 "EHLO thorn.pobox.com")
	by vger.kernel.org with ESMTP id S1751296AbVIWVLL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 17:11:11 -0400
Message-ID: <43346F67.4050806@rtr.ca>
Date: Fri, 23 Sep 2005 17:11:03 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050728
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Jens Axboe <axboe@suse.de>, torvalds@osdl.org, joshk@triplehelix.org,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH] updated version of Jens' SATA suspend-to-ram patch
References: <20050923163334.GA13567@triplehelix.org> <20050923180711.GH22655@suse.de> <433469DF.1060900@pobox.com>
In-Reply-To: <433469DF.1060900@pobox.com>
Content-Type: multipart/mixed;
 boundary="------------010900080705010205070902"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010900080705010205070902
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Jeff Garzik wrote:
>
> Very strange.  I cannot find this patch at all in my email folders.
> Can someone resend it to me?

(attached)

..
>> -    qc = ata_qc_new_init(ap, dev);
>> -    BUG_ON(qc == NULL);
>> +    while ((qc = ata_qc_new_init(ap, dev)) == NULL)
>> +        msleep(10);
>>  
..
> Worried now!

Hey, that code wasn't in the original patch last spring,
which I'm *still* using with zero problems this fall.

Mmmm...

--------------010900080705010205070902
Content-Type: text/plain;
 name="sata-suspend-to-ram.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sata-suspend-to-ram.patch"

diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -214,6 +214,8 @@ static Scsi_Host_Template ahci_sht = {
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
 	.ordered_flush		= 1,
+	.resume			= ata_scsi_device_resume,
+	.suspend		= ata_scsi_device_suspend,
 };
 
 static struct ata_port_operations ahci_ops = {
@@ -286,6 +288,8 @@ static struct pci_driver ahci_pci_driver
 	.id_table		= ahci_pci_tbl,
 	.probe			= ahci_init_one,
 	.remove			= ahci_remove_one,
+	.suspend		= ata_scsi_device_suspend,
+	.resume			= ata_scsi_device_resume,
 };
 
 
diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
--- a/drivers/scsi/ata_piix.c
+++ b/drivers/scsi/ata_piix.c
@@ -125,6 +125,8 @@ static struct pci_driver piix_pci_driver
 	.id_table		= piix_pci_tbl,
 	.probe			= piix_init_one,
 	.remove			= ata_pci_remove_one,
+	.suspend		= ata_pci_device_suspend,
+	.resume			= ata_pci_device_resume,
 };
 
 static Scsi_Host_Template piix_sht = {
@@ -145,6 +147,8 @@ static Scsi_Host_Template piix_sht = {
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
 	.ordered_flush		= 1,
+	.resume			= ata_scsi_device_resume,
+	.suspend		= ata_scsi_device_suspend,
 };
 
 static struct ata_port_operations piix_pata_ops = {
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -3829,6 +3829,104 @@ err_out:
  *	LOCKING:
  */
 
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
@@ -4542,6 +4640,23 @@ int pci_test_config_bits(struct pci_dev 
 
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
 
 
@@ -4620,4 +4735,11 @@ EXPORT_SYMBOL_GPL(ata_pci_host_stop);
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
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -402,6 +402,22 @@ int ata_scsi_error(struct Scsi_Host *hos
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
  *	ata_scsi_start_stop_xlat - Translate SCSI START STOP UNIT command
  *	@qc: Storage for translated ATA taskfile
diff --git a/drivers/scsi/sata_mv.c b/drivers/scsi/sata_mv.c
--- a/drivers/scsi/sata_mv.c
+++ b/drivers/scsi/sata_mv.c
@@ -208,6 +208,8 @@ static Scsi_Host_Template mv_sht = {
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
 	.ordered_flush		= 1,
+	.suspend		= ata_scsi_device_suspend,
+	.resume			= ata_scsi_device_resume,
 };
 
 static struct ata_port_operations mv_ops = {
@@ -294,6 +296,8 @@ static struct pci_driver mv_pci_driver =
 	.id_table		= mv_pci_tbl,
 	.probe			= mv_init_one,
 	.remove			= ata_pci_remove_one,
+	.suspend		= ata_scsi_device_suspend,
+	.resume			= ata_scsi_device_resume,
 };
 
 /*
diff --git a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
--- a/drivers/scsi/sata_nv.c
+++ b/drivers/scsi/sata_nv.c
@@ -214,6 +214,8 @@ static struct pci_driver nv_pci_driver =
 	.id_table		= nv_pci_tbl,
 	.probe			= nv_init_one,
 	.remove			= ata_pci_remove_one,
+	.suspend		= ata_pci_device_suspend,
+	.resume			= ata_pci_device_resume,
 };
 
 static Scsi_Host_Template nv_sht = {
@@ -234,6 +236,8 @@ static Scsi_Host_Template nv_sht = {
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
 	.ordered_flush		= 1,
+	.resume			= ata_scsi_device_resume,
+	.suspend		= ata_scsi_device_suspend,
 };
 
 static struct ata_port_operations nv_ops = {
diff --git a/drivers/scsi/sata_promise.c b/drivers/scsi/sata_promise.c
--- a/drivers/scsi/sata_promise.c
+++ b/drivers/scsi/sata_promise.c
@@ -111,6 +111,8 @@ static Scsi_Host_Template pdc_ata_sht = 
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
 	.ordered_flush		= 1,
+	.resume			= ata_scsi_device_resume,
+	.suspend		= ata_scsi_device_suspend,
 };
 
 static struct ata_port_operations pdc_sata_ops = {
@@ -231,6 +233,8 @@ static struct pci_driver pdc_ata_pci_dri
 	.id_table		= pdc_ata_pci_tbl,
 	.probe			= pdc_ata_init_one,
 	.remove			= ata_pci_remove_one,
+	.suspend		= ata_pci_device_suspend,
+	.resume			= ata_pci_device_resume,
 };
 
 
diff --git a/drivers/scsi/sata_qstor.c b/drivers/scsi/sata_qstor.c
--- a/drivers/scsi/sata_qstor.c
+++ b/drivers/scsi/sata_qstor.c
@@ -143,6 +143,8 @@ static Scsi_Host_Template qs_ata_sht = {
 	.dma_boundary		= QS_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
+	.resume			= ata_scsi_device_resume,
+	.suspend		= ata_scsi_device_suspend,
 };
 
 static struct ata_port_operations qs_ata_ops = {
@@ -194,6 +196,8 @@ static struct pci_driver qs_ata_pci_driv
 	.id_table		= qs_ata_pci_tbl,
 	.probe			= qs_ata_init_one,
 	.remove			= ata_pci_remove_one,
+	.suspend		= ata_pci_device_suspend,
+	.resume			= ata_pci_device_resume,
 };
 
 static int qs_check_atapi_dma(struct ata_queued_cmd *qc)
diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -128,6 +128,8 @@ static struct pci_driver sil_pci_driver 
 	.id_table		= sil_pci_tbl,
 	.probe			= sil_init_one,
 	.remove			= ata_pci_remove_one,
+	.suspend		= ata_pci_device_suspend,
+	.resume			= ata_pci_device_resume,
 };
 
 static Scsi_Host_Template sil_sht = {
@@ -148,6 +150,8 @@ static Scsi_Host_Template sil_sht = {
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
 	.ordered_flush		= 1,
+	.resume			= ata_scsi_device_resume,
+	.suspend		= ata_scsi_device_suspend,
 };
 
 static struct ata_port_operations sil_ops = {
diff --git a/drivers/scsi/sata_sis.c b/drivers/scsi/sata_sis.c
--- a/drivers/scsi/sata_sis.c
+++ b/drivers/scsi/sata_sis.c
@@ -80,6 +80,8 @@ static struct pci_driver sis_pci_driver 
 	.id_table		= sis_pci_tbl,
 	.probe			= sis_init_one,
 	.remove			= ata_pci_remove_one,
+	.suspend		= ata_pci_device_suspend,
+	.resume			= ata_pci_device_resume,
 };
 
 static Scsi_Host_Template sis_sht = {
@@ -100,6 +102,8 @@ static Scsi_Host_Template sis_sht = {
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
 	.ordered_flush		= 1,
+	.resume			= ata_scsi_device_resume,
+	.suspend		= ata_scsi_device_suspend,
 };
 
 static struct ata_port_operations sis_ops = {
diff --git a/drivers/scsi/sata_svw.c b/drivers/scsi/sata_svw.c
--- a/drivers/scsi/sata_svw.c
+++ b/drivers/scsi/sata_svw.c
@@ -294,6 +294,8 @@ static Scsi_Host_Template k2_sata_sht = 
 #endif
 	.bios_param		= ata_std_bios_param,
 	.ordered_flush		= 1,
+	.resume			= ata_scsi_device_resume,
+	.suspend		= ata_scsi_device_suspend,
 };
 
 
@@ -470,6 +472,8 @@ static struct pci_driver k2_sata_pci_dri
 	.id_table		= k2_sata_pci_tbl,
 	.probe			= k2_sata_init_one,
 	.remove			= ata_pci_remove_one,
+	.suspend		= ata_pci_device_suspend,
+	.resume			= ata_pci_device_resume,
 };
 
 
diff --git a/drivers/scsi/sata_sx4.c b/drivers/scsi/sata_sx4.c
--- a/drivers/scsi/sata_sx4.c
+++ b/drivers/scsi/sata_sx4.c
@@ -194,6 +194,8 @@ static Scsi_Host_Template pdc_sata_sht =
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
 	.ordered_flush		= 1,
+	.resume			= ata_scsi_device_resume,
+	.suspend		= ata_scsi_device_suspend,
 };
 
 static struct ata_port_operations pdc_20621_ops = {
@@ -240,6 +242,8 @@ static struct pci_driver pdc_sata_pci_dr
 	.id_table		= pdc_sata_pci_tbl,
 	.probe			= pdc_sata_init_one,
 	.remove			= ata_pci_remove_one,
+	.suspend		= ata_pci_device_suspend,
+	.resume			= ata_pci_device_resume,
 };
 
 
diff --git a/drivers/scsi/sata_uli.c b/drivers/scsi/sata_uli.c
--- a/drivers/scsi/sata_uli.c
+++ b/drivers/scsi/sata_uli.c
@@ -68,6 +68,8 @@ static struct pci_driver uli_pci_driver 
 	.id_table		= uli_pci_tbl,
 	.probe			= uli_init_one,
 	.remove			= ata_pci_remove_one,
+	.suspend		= ata_pci_device_suspend,
+	.resume			= ata_pci_device_resume,
 };
 
 static Scsi_Host_Template uli_sht = {
@@ -88,6 +90,8 @@ static Scsi_Host_Template uli_sht = {
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
 	.ordered_flush		= 1,
+	.resume			= ata_scsi_device_resume,
+	.suspend		= ata_scsi_device_suspend,
 };
 
 static struct ata_port_operations uli_ops = {
diff --git a/drivers/scsi/sata_via.c b/drivers/scsi/sata_via.c
--- a/drivers/scsi/sata_via.c
+++ b/drivers/scsi/sata_via.c
@@ -87,6 +87,8 @@ static struct pci_driver svia_pci_driver
 	.id_table		= svia_pci_tbl,
 	.probe			= svia_init_one,
 	.remove			= ata_pci_remove_one,
+	.suspend		= ata_pci_device_suspend,
+	.resume			= ata_pci_device_resume,
 };
 
 static Scsi_Host_Template svia_sht = {
@@ -107,6 +109,8 @@ static Scsi_Host_Template svia_sht = {
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
 	.ordered_flush		= 1,
+	.resume			= ata_scsi_device_resume,
+	.suspend		= ata_scsi_device_suspend,
 };
 
 static struct ata_port_operations svia_sata_ops = {
diff --git a/drivers/scsi/sata_vsc.c b/drivers/scsi/sata_vsc.c
--- a/drivers/scsi/sata_vsc.c
+++ b/drivers/scsi/sata_vsc.c
@@ -228,6 +228,8 @@ static Scsi_Host_Template vsc_sata_sht =
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
 	.ordered_flush		= 1,
+	.resume			= ata_scsi_device_resume,
+	.suspend		= ata_scsi_device_suspend,
 };
 
 
@@ -404,6 +406,8 @@ static struct pci_driver vsc_sata_pci_dr
 	.id_table		= vsc_sata_pci_tbl,
 	.probe			= vsc_sata_init_one,
 	.remove			= ata_pci_remove_one,
+	.suspend		= ata_pci_device_suspend,
+	.resume			= ata_pci_device_resume,
 };
 
 
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1944,8 +1944,9 @@ EXPORT_SYMBOL(scsi_device_quiesce);
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
diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -263,9 +263,40 @@ static int scsi_bus_match(struct device 
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
diff --git a/include/linux/ata.h b/include/linux/ata.h
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -132,6 +132,8 @@ enum {
 	ATA_CMD_PACKET		= 0xA0,
 	ATA_CMD_VERIFY		= 0x40,
 	ATA_CMD_VERIFY_EXT	= 0x42,
+	ATA_CMD_STANDBYNOW1	= 0xE0,
+	ATA_CMD_IDLEIMMEDIATE	= 0xE1,
 
 	/* SETFEATURES stuff */
 	SETFEATURES_XFER	= 0x03,
diff --git a/include/linux/libata.h b/include/linux/libata.h
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -117,6 +117,7 @@ enum {
 	ATA_FLAG_PIO_DMA	= (1 << 8), /* PIO cmds via DMA */
 	ATA_FLAG_NOINTR		= (1 << 9), /* FIXME: Remove this once
 					     * proper HSM is in place. */
+	ATA_FLAG_SUSPENDED	= (1 << 10), /* port is suspended */
 
 	ATA_QCFLAG_ACTIVE	= (1 << 1), /* cmd not yet ack'd to scsi lyer */
 	ATA_QCFLAG_SG		= (1 << 3), /* have s/g table? */
@@ -391,6 +392,8 @@ extern void ata_std_ports(struct ata_iop
 extern int ata_pci_init_one (struct pci_dev *pdev, struct ata_port_info **port_info,
 			     unsigned int n_ports);
 extern void ata_pci_remove_one (struct pci_dev *pdev);
+extern int ata_pci_device_suspend(struct pci_dev *pdev, pm_message_t state);
+extern int ata_pci_device_resume(struct pci_dev *pdev);
 #endif /* CONFIG_PCI */
 extern int ata_device_add(struct ata_probe_ent *ent);
 extern int ata_scsi_detect(Scsi_Host_Template *sht);
@@ -399,6 +402,10 @@ extern int ata_scsi_queuecmd(struct scsi
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
diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -295,6 +295,12 @@ struct scsi_host_template {
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

--------------010900080705010205070902--
