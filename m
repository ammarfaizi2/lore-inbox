Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261291AbVEBOsC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261291AbVEBOsC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 10:48:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbVEBOsC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 10:48:02 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:56970 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261291AbVEBOrI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 10:47:08 -0400
Date: Mon, 2 May 2005 16:47:03 +0200
From: Jens Axboe <axboe@suse.de>
To: Jon Escombe <trial@dresco.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Suspend/Resume
Message-ID: <20050502144703.GA1882@suse.de>
References: <4267B5B0.8050608@davyandbeth.com> <loom.20050502T161322-252@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <loom.20050502T161322-252@post.gmane.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02 2005, Jon Escombe wrote:
> Davy Durham <pubaddr2 <at> davyandbeth.com> writes:
> 
> > 
> > Hi,
> >   I've been trying for the last few days to get my D810 to suspend and 
> > resume in linux.
> > 
> 
> I have the same problem with a 2.6.11 kernel on an IBM T43, also with
> the new Sonoma chipset. 
> 
> Although a PATA HDD, it appears to be presented as a SATA device
> (/dev/sda in Linux). It seems to be hanging on the first disk access
> following a resume, and I'm seeing the same behaviour with both APM
> and ACPI.
> 
> Happy to provide any information/assistance that I can to help resolve
> this..

SATA suspend is completely broken right now, so I'm not surprised. You
can shoe-horn this patch onto 2.6.12-rcX - it will reject for every
ordered_flush addition, but should be trivial to fix up. If you have
problems, let me know and I'll generate a proper diff for you.

diff -urp /opt/kernel/linux-2.6.11/drivers/scsi/ahci.c linux-2.6.11/drivers/scsi/ahci.c
--- /opt/kernel/linux-2.6.11/drivers/scsi/ahci.c	2005-04-28 09:40:35.000000000 +0200
+++ linux-2.6.11/drivers/scsi/ahci.c	2005-04-28 09:41:00.000000000 +0200
@@ -203,6 +203,8 @@ static Scsi_Host_Template ahci_sht = {
 	.dma_boundary		= AHCI_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
+	.resume			= ata_scsi_device_resume,
+	.suspend		= ata_scsi_device_suspend,
 };
 
 static struct ata_port_operations ahci_ops = {
@@ -270,6 +272,8 @@ static struct pci_driver ahci_pci_driver
 	.id_table		= ahci_pci_tbl,
 	.probe			= ahci_init_one,
 	.remove			= ahci_remove_one,
+	.suspend		= ata_pci_device_suspend,
+	.resume			= ata_pci_device_resume,
 };
 
 
diff -urp /opt/kernel/linux-2.6.11/drivers/scsi/ata_adma.c linux-2.6.11/drivers/scsi/ata_adma.c
--- /opt/kernel/linux-2.6.11/drivers/scsi/ata_adma.c	2005-04-28 09:40:35.000000000 +0200
+++ linux-2.6.11/drivers/scsi/ata_adma.c	2005-04-28 09:41:00.000000000 +0200
@@ -134,6 +134,8 @@ static Scsi_Host_Template adma_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
+	.resume			= ata_scsi_device_resume,
+	.suspend		= ata_scsi_device_suspend,
 };
 
 static struct ata_port_operations adma_ops = {
@@ -183,6 +185,8 @@ static struct pci_driver adma_pci_driver
 	.id_table		= adma_pci_tbl,
 	.probe			= adma_init_one,
 	.remove			= ata_pci_remove_one,
+	.suspend		= ata_pci_device_suspend,
+	.resume			= ata_pci_device_resume,
 };
 
 
diff -urp /opt/kernel/linux-2.6.11/drivers/scsi/ata_piix.c linux-2.6.11/drivers/scsi/ata_piix.c
--- /opt/kernel/linux-2.6.11/drivers/scsi/ata_piix.c	2005-04-28 09:40:35.000000000 +0200
+++ linux-2.6.11/drivers/scsi/ata_piix.c	2005-04-28 09:41:00.000000000 +0200
@@ -105,6 +105,8 @@ static struct pci_driver piix_pci_driver
 	.id_table		= piix_pci_tbl,
 	.probe			= piix_init_one,
 	.remove			= ata_pci_remove_one,
+	.suspend		= ata_pci_device_suspend,
+	.resume			= ata_pci_device_resume,
 };
 
 static Scsi_Host_Template piix_sht = {
@@ -124,6 +126,8 @@ static Scsi_Host_Template piix_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
+	.resume			= ata_scsi_device_resume,
+	.suspend		= ata_scsi_device_suspend,
 };
 
 static struct ata_port_operations piix_pata_ops = {
diff -urp /opt/kernel/linux-2.6.11/drivers/scsi/libata-core.c linux-2.6.11/drivers/scsi/libata-core.c
--- /opt/kernel/linux-2.6.11/drivers/scsi/libata-core.c	2005-04-28 09:40:35.000000000 +0200
+++ linux-2.6.11/drivers/scsi/libata-core.c	2005-04-28 09:41:24.000000000 +0200
@@ -3338,6 +3338,104 @@ err_out:
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
@@ -3977,6 +4075,23 @@ int pci_test_config_bits(struct pci_dev 
 
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
 
 
@@ -4062,4 +4177,11 @@ EXPORT_SYMBOL_GPL(pci_test_config_bits);
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
diff -urp /opt/kernel/linux-2.6.11/drivers/scsi/libata-scsi.c linux-2.6.11/drivers/scsi/libata-scsi.c
--- /opt/kernel/linux-2.6.11/drivers/scsi/libata-scsi.c	2005-04-28 09:40:35.000000000 +0200
+++ linux-2.6.11/drivers/scsi/libata-scsi.c	2005-04-28 09:41:00.000000000 +0200
@@ -637,6 +637,22 @@ int ata_scsi_error(struct Scsi_Host *hos
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
diff -urp /opt/kernel/linux-2.6.11/drivers/scsi/pata_pdc2027x.c linux-2.6.11/drivers/scsi/pata_pdc2027x.c
--- /opt/kernel/linux-2.6.11/drivers/scsi/pata_pdc2027x.c	2005-04-28 09:40:35.000000000 +0200
+++ linux-2.6.11/drivers/scsi/pata_pdc2027x.c	2005-04-28 09:41:00.000000000 +0200
@@ -110,6 +110,8 @@ static struct pci_driver pdc2027x_pci_dr
 	.id_table		= pdc2027x_pci_tbl,
 	.probe			= pdc2027x_init_one,
 	.remove			= __devexit_p(pdc2027x_remove_one),
+	.suspend		= ata_pci_device_suspend,
+	.resume			= ata_pci_device_resume,
 };
 
 static Scsi_Host_Template pdc2027x_sht = {
@@ -128,6 +130,8 @@ static Scsi_Host_Template pdc2027x_sht =
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
+	.resume			= ata_scsi_device_resume,
+	.suspend		= ata_scsi_device_suspend,
 };
 
 static struct ata_port_operations pdc2027x_pata100_ops = {
diff -urp /opt/kernel/linux-2.6.11/drivers/scsi/sata_nv.c linux-2.6.11/drivers/scsi/sata_nv.c
--- /opt/kernel/linux-2.6.11/drivers/scsi/sata_nv.c	2005-04-28 09:40:35.000000000 +0200
+++ linux-2.6.11/drivers/scsi/sata_nv.c	2005-04-28 09:41:00.000000000 +0200
@@ -186,6 +186,8 @@ static struct pci_driver nv_pci_driver =
 	.id_table		= nv_pci_tbl,
 	.probe			= nv_init_one,
 	.remove			= ata_pci_remove_one,
+	.suspend		= ata_pci_device_suspend,
+	.resume			= ata_pci_device_resume,
 };
 
 static Scsi_Host_Template nv_sht = {
@@ -205,6 +207,8 @@ static Scsi_Host_Template nv_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
+	.resume			= ata_scsi_device_resume,
+	.suspend		= ata_scsi_device_suspend,
 };
 
 static struct ata_port_operations nv_ops = {
diff -urp /opt/kernel/linux-2.6.11/drivers/scsi/sata_promise.c linux-2.6.11/drivers/scsi/sata_promise.c
--- /opt/kernel/linux-2.6.11/drivers/scsi/sata_promise.c	2005-04-28 09:40:35.000000000 +0200
+++ linux-2.6.11/drivers/scsi/sata_promise.c	2005-04-28 09:41:00.000000000 +0200
@@ -105,6 +105,8 @@ static Scsi_Host_Template pdc_ata_sht = 
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
+	.resume			= ata_scsi_device_resume,
+	.suspend		= ata_scsi_device_suspend,
 };
 
 static struct ata_port_operations pdc_ata_ops = {
@@ -194,6 +196,8 @@ static struct pci_driver pdc_ata_pci_dri
 	.id_table		= pdc_ata_pci_tbl,
 	.probe			= pdc_ata_init_one,
 	.remove			= ata_pci_remove_one,
+	.suspend		= ata_pci_device_suspend,
+	.resume			= ata_pci_device_resume,
 };
 
 
diff -urp /opt/kernel/linux-2.6.11/drivers/scsi/sata_qstor.c linux-2.6.11/drivers/scsi/sata_qstor.c
--- /opt/kernel/linux-2.6.11/drivers/scsi/sata_qstor.c	2005-04-28 09:40:35.000000000 +0200
+++ linux-2.6.11/drivers/scsi/sata_qstor.c	2005-04-28 09:41:00.000000000 +0200
@@ -139,6 +139,8 @@ static Scsi_Host_Template qs_ata_sht = {
 	.dma_boundary		= QS_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
+	.resume			= ata_scsi_device_resume,
+	.suspend		= ata_scsi_device_suspend,
 };
 
 static struct ata_port_operations qs_ata_ops = {
@@ -190,6 +192,8 @@ static struct pci_driver qs_ata_pci_driv
 	.id_table		= qs_ata_pci_tbl,
 	.probe			= qs_ata_init_one,
 	.remove			= ata_pci_remove_one,
+	.suspend		= ata_pci_device_suspend,
+	.resume			= ata_pci_device_resume,
 };
 
 static int qs_check_atapi_dma(struct ata_queued_cmd *qc)
diff -urp /opt/kernel/linux-2.6.11/drivers/scsi/sata_sil.c linux-2.6.11/drivers/scsi/sata_sil.c
--- /opt/kernel/linux-2.6.11/drivers/scsi/sata_sil.c	2005-04-28 09:40:35.000000000 +0200
+++ linux-2.6.11/drivers/scsi/sata_sil.c	2005-04-28 09:41:00.000000000 +0200
@@ -115,6 +115,8 @@ static struct pci_driver sil_pci_driver 
 	.id_table		= sil_pci_tbl,
 	.probe			= sil_init_one,
 	.remove			= ata_pci_remove_one,
+	.suspend		= ata_pci_device_suspend,
+	.resume			= ata_pci_device_resume,
 };
 
 static Scsi_Host_Template sil_sht = {
@@ -134,6 +136,8 @@ static Scsi_Host_Template sil_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
+	.resume			= ata_scsi_device_resume,
+	.suspend		= ata_scsi_device_suspend,
 };
 
 static struct ata_port_operations sil_ops = {
diff -urp /opt/kernel/linux-2.6.11/drivers/scsi/sata_sis.c linux-2.6.11/drivers/scsi/sata_sis.c
--- /opt/kernel/linux-2.6.11/drivers/scsi/sata_sis.c	2005-04-28 09:40:35.000000000 +0200
+++ linux-2.6.11/drivers/scsi/sata_sis.c	2005-04-28 09:41:00.000000000 +0200
@@ -71,6 +71,8 @@ static struct pci_driver sis_pci_driver 
 	.id_table		= sis_pci_tbl,
 	.probe			= sis_init_one,
 	.remove			= ata_pci_remove_one,
+	.suspend		= ata_pci_device_suspend,
+	.resume			= ata_pci_device_resume,
 };
 
 static Scsi_Host_Template sis_sht = {
@@ -90,6 +92,8 @@ static Scsi_Host_Template sis_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
+	.resume			= ata_scsi_device_resume,
+	.suspend		= ata_scsi_device_suspend,
 };
 
 static struct ata_port_operations sis_ops = {
diff -urp /opt/kernel/linux-2.6.11/drivers/scsi/sata_svw.c linux-2.6.11/drivers/scsi/sata_svw.c
--- /opt/kernel/linux-2.6.11/drivers/scsi/sata_svw.c	2005-04-28 09:40:35.000000000 +0200
+++ linux-2.6.11/drivers/scsi/sata_svw.c	2005-04-28 09:41:00.000000000 +0200
@@ -288,6 +288,8 @@ static Scsi_Host_Template k2_sata_sht = 
 	.proc_info		= k2_sata_proc_info,
 #endif
 	.bios_param		= ata_std_bios_param,
+	.resume			= ata_scsi_device_resume,
+	.suspend		= ata_scsi_device_suspend,
 };
 
 
@@ -457,6 +459,8 @@ static struct pci_driver k2_sata_pci_dri
 	.id_table		= k2_sata_pci_tbl,
 	.probe			= k2_sata_init_one,
 	.remove			= ata_pci_remove_one,
+	.suspend		= ata_pci_device_suspend,
+	.resume			= ata_pci_device_resume,
 };
 
 
diff -urp /opt/kernel/linux-2.6.11/drivers/scsi/sata_sx4.c linux-2.6.11/drivers/scsi/sata_sx4.c
--- /opt/kernel/linux-2.6.11/drivers/scsi/sata_sx4.c	2005-04-28 09:40:35.000000000 +0200
+++ linux-2.6.11/drivers/scsi/sata_sx4.c	2005-04-28 09:41:00.000000000 +0200
@@ -188,6 +188,8 @@ static Scsi_Host_Template pdc_sata_sht =
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
+	.resume			= ata_scsi_device_resume,
+	.suspend		= ata_scsi_device_suspend,
 };
 
 static struct ata_port_operations pdc_20621_ops = {
@@ -234,6 +236,8 @@ static struct pci_driver pdc_sata_pci_dr
 	.id_table		= pdc_sata_pci_tbl,
 	.probe			= pdc_sata_init_one,
 	.remove			= ata_pci_remove_one,
+	.suspend		= ata_pci_device_suspend,
+	.resume			= ata_pci_device_resume,
 };
 
 
diff -urp /opt/kernel/linux-2.6.11/drivers/scsi/sata_uli.c linux-2.6.11/drivers/scsi/sata_uli.c
--- /opt/kernel/linux-2.6.11/drivers/scsi/sata_uli.c	2005-04-28 09:40:35.000000000 +0200
+++ linux-2.6.11/drivers/scsi/sata_uli.c	2005-04-28 09:41:00.000000000 +0200
@@ -63,6 +63,8 @@ static struct pci_driver uli_pci_driver 
 	.id_table		= uli_pci_tbl,
 	.probe			= uli_init_one,
 	.remove			= ata_pci_remove_one,
+	.suspend		= ata_pci_device_suspend,
+	.resume			= ata_pci_device_resume,
 };
 
 static Scsi_Host_Template uli_sht = {
@@ -82,6 +84,8 @@ static Scsi_Host_Template uli_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
+	.resume			= ata_scsi_device_resume,
+	.suspend		= ata_scsi_device_suspend,
 };
 
 static struct ata_port_operations uli_ops = {
diff -urp /opt/kernel/linux-2.6.11/drivers/scsi/sata_via.c linux-2.6.11/drivers/scsi/sata_via.c
--- /opt/kernel/linux-2.6.11/drivers/scsi/sata_via.c	2005-04-28 09:40:35.000000000 +0200
+++ linux-2.6.11/drivers/scsi/sata_via.c	2005-04-28 09:41:00.000000000 +0200
@@ -83,6 +83,8 @@ static struct pci_driver svia_pci_driver
 	.id_table		= svia_pci_tbl,
 	.probe			= svia_init_one,
 	.remove			= ata_pci_remove_one,
+	.suspend		= ata_pci_device_suspend,
+	.resume			= ata_pci_device_resume,
 };
 
 static Scsi_Host_Template svia_sht = {
@@ -102,6 +104,8 @@ static Scsi_Host_Template svia_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
+	.resume			= ata_scsi_device_resume,
+	.suspend		= ata_scsi_device_suspend,
 };
 
 static struct ata_port_operations svia_sata_ops = {
diff -urp /opt/kernel/linux-2.6.11/drivers/scsi/sata_vsc.c linux-2.6.11/drivers/scsi/sata_vsc.c
--- /opt/kernel/linux-2.6.11/drivers/scsi/sata_vsc.c	2005-04-28 09:40:35.000000000 +0200
+++ linux-2.6.11/drivers/scsi/sata_vsc.c	2005-04-28 09:41:00.000000000 +0200
@@ -204,6 +204,8 @@ static Scsi_Host_Template vsc_sata_sht =
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
+	.resume			= ata_scsi_device_resume,
+	.suspend		= ata_scsi_device_suspend,
 };
 
 
@@ -380,6 +382,8 @@ static struct pci_driver vsc_sata_pci_dr
 	.id_table		= vsc_sata_pci_tbl,
 	.probe			= vsc_sata_init_one,
 	.remove			= ata_pci_remove_one,
+	.suspend		= ata_pci_device_suspend,
+	.resume			= ata_pci_device_resume,
 };
 
 
diff -urp /opt/kernel/linux-2.6.11/drivers/scsi/scsi_lib.c linux-2.6.11/drivers/scsi/scsi_lib.c
--- /opt/kernel/linux-2.6.11/drivers/scsi/scsi_lib.c	2005-04-28 09:40:35.000000000 +0200
+++ linux-2.6.11/drivers/scsi/scsi_lib.c	2005-04-28 09:41:00.000000000 +0200
@@ -1843,8 +1843,9 @@ EXPORT_SYMBOL(scsi_device_quiesce);
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
diff -urp /opt/kernel/linux-2.6.11/drivers/scsi/scsi_sysfs.c linux-2.6.11/drivers/scsi/scsi_sysfs.c
--- /opt/kernel/linux-2.6.11/drivers/scsi/scsi_sysfs.c	2005-04-28 09:40:35.000000000 +0200
+++ linux-2.6.11/drivers/scsi/scsi_sysfs.c	2005-04-28 09:41:00.000000000 +0200
@@ -204,9 +204,40 @@ static int scsi_bus_match(struct device 
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
diff -urp /opt/kernel/linux-2.6.11/include/linux/ata.h linux-2.6.11/include/linux/ata.h
--- /opt/kernel/linux-2.6.11/include/linux/ata.h	2005-04-28 09:40:36.000000000 +0200
+++ linux-2.6.11/include/linux/ata.h	2005-04-28 09:41:00.000000000 +0200
@@ -126,6 +126,8 @@ enum {
 	ATA_CMD_VERIFY		= 0x40,
 	ATA_CMD_VERIFY_EXT	= 0x42,
 	ATA_CMD_INIT_DEV_PARAMS	= 0x91,
+	ATA_CMD_STANDBYNOW1	= 0xE0,
+	ATA_CMD_IDLEIMMEDIATE	= 0xE1,
 
 	/* SETFEATURES stuff */
 	SETFEATURES_XFER	= 0x03,
diff -urp /opt/kernel/linux-2.6.11/include/linux/libata.h linux-2.6.11/include/linux/libata.h
--- /opt/kernel/linux-2.6.11/include/linux/libata.h	2005-04-28 09:40:36.000000000 +0200
+++ linux-2.6.11/include/linux/libata.h	2005-04-28 09:41:45.000000000 +0200
@@ -114,6 +114,7 @@ enum {
 	ATA_FLAG_MMIO		= (1 << 6), /* use MMIO, not PIO */
 	ATA_FLAG_SATA_RESET	= (1 << 7), /* use COMRESET */
 	ATA_FLAG_PIO_DMA	= (1 << 8), /* PIO cmds via DMA */
+	ATA_FLAG_SUSPENDED	= (1 << 9), /* port is suspended */
 
 	ATA_QCFLAG_ACTIVE	= (1 << 1), /* cmd not yet ack'd to scsi lyer */
 	ATA_QCFLAG_SG		= (1 << 3), /* have s/g table? */
@@ -394,6 +395,8 @@ extern void ata_std_ports(struct ata_iop
 extern int ata_pci_init_one (struct pci_dev *pdev, struct ata_port_info **port_info,
 			     unsigned int n_ports);
 extern void ata_pci_remove_one (struct pci_dev *pdev);
+extern int ata_pci_device_suspend(struct pci_dev *pdev, pm_message_t state);
+extern int ata_pci_device_resume(struct pci_dev *pdev);
 #endif /* CONFIG_PCI */
 extern int ata_device_add(struct ata_probe_ent *ent);
 extern int ata_scsi_detect(Scsi_Host_Template *sht);
@@ -402,6 +405,10 @@ extern int ata_scsi_queuecmd(struct scsi
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
diff -urp /opt/kernel/linux-2.6.11/include/scsi/scsi_host.h linux-2.6.11/include/scsi/scsi_host.h
--- /opt/kernel/linux-2.6.11/include/scsi/scsi_host.h	2005-04-28 09:40:37.000000000 +0200
+++ linux-2.6.11/include/scsi/scsi_host.h	2005-04-28 09:41:00.000000000 +0200
@@ -269,6 +269,12 @@ struct scsi_host_template {
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

