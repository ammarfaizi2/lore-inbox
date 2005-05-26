Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261717AbVEZTaG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261717AbVEZTaG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 15:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261713AbVEZT3z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 15:29:55 -0400
Received: from mail.dvmed.net ([216.237.124.58]:8155 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261710AbVEZT3D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 15:29:03 -0400
Message-ID: <42962379.5000206@pobox.com>
Date: Thu, 26 May 2005 15:28:57 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
CC: Jens Axboe <axboe@suse.de>, Mark Lord <mlord@pobox.com>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: [PATCH] libata: fix use-after-free during driver unload/unplug
Content-Type: multipart/mixed;
 boundary="------------070202010401090602070805"
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070202010401090602070805
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Jens Axboe pointed out that the iounmap() call in libata was occurring 
too early, and some drivers (ahci, probably others) were using ioremap'd 
memory after it had been unmapped.

The patch should address that problem by way of improving the libata 
driver API:

* move ->host_stop() call after all ->port_stop() calls have occurred.

* create default helper function ata_host_stop(), and move iounmap() 
call there.

* add ->host_stop_prewalk() hook, use it in sata_qstor.c (hi Mark). 
sata_qstor appears to require the host-stop-before-port-stop ordering 
that existed prior to applying the attached patch.


--------------070202010401090602070805
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -289,6 +289,8 @@ static void ahci_host_stop(struct ata_ho
 {
 	struct ahci_host_priv *hpriv = host_set->private_data;
 	kfree(hpriv);
+
+	ata_host_stop(host_set);
 }
 
 static int ahci_port_start(struct ata_port *ap)
diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
--- a/drivers/scsi/ata_piix.c
+++ b/drivers/scsi/ata_piix.c
@@ -153,6 +153,7 @@ static struct ata_port_operations piix_p
 
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
+	.host_stop		= ata_host_stop,
 };
 
 static struct ata_port_operations piix_sata_ops = {
@@ -180,6 +181,7 @@ static struct ata_port_operations piix_s
 
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
+	.host_stop		= ata_host_stop,
 };
 
 static struct ata_port_info piix_port_info[] = {
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -3321,6 +3321,13 @@ void ata_port_stop (struct ata_port *ap)
 	dma_free_coherent(dev, ATA_PRD_TBL_SZ, ap->prd, ap->prd_dma);
 }
 
+void ata_host_stop (struct ata_host_set *host_set)
+{
+	if (host_set->mmio_base)
+		iounmap(host_set->mmio_base);
+}
+
+
 /**
  *	ata_host_remove - Unregister SCSI host structure with upper layers
  *	@ap: Port to unregister
@@ -3877,10 +3884,9 @@ void ata_pci_remove_one (struct pci_dev 
 	}
 
 	free_irq(host_set->irq, host_set);
-	if (host_set->ops->host_stop)
-		host_set->ops->host_stop(host_set);
-	if (host_set->mmio_base)
-		iounmap(host_set->mmio_base);
+
+	if (host_set->ops->host_stop_prewalk)
+		host_set->ops->host_stop_prewalk(host_set);
 
 	for (i = 0; i < host_set->n_ports; i++) {
 		ap = host_set->ports[i];
@@ -3899,6 +3905,9 @@ void ata_pci_remove_one (struct pci_dev 
 		scsi_host_put(ap->host);
 	}
 
+	if (host_set->ops->host_stop)
+		host_set->ops->host_stop(host_set);
+
 	kfree(host_set);
 
 	pci_release_regions(pdev);
@@ -3996,6 +4005,7 @@ EXPORT_SYMBOL_GPL(ata_chk_err);
 EXPORT_SYMBOL_GPL(ata_exec_command);
 EXPORT_SYMBOL_GPL(ata_port_start);
 EXPORT_SYMBOL_GPL(ata_port_stop);
+EXPORT_SYMBOL_GPL(ata_host_stop);
 EXPORT_SYMBOL_GPL(ata_interrupt);
 EXPORT_SYMBOL_GPL(ata_qc_prep);
 EXPORT_SYMBOL_GPL(ata_bmdma_setup);
diff --git a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
--- a/drivers/scsi/sata_nv.c
+++ b/drivers/scsi/sata_nv.c
@@ -329,6 +329,8 @@ static void nv_host_stop (struct ata_hos
 		host->host_desc->disable_hotplug(host_set);
 
 	kfree(host);
+
+	ata_host_stop(host_set);
 }
 
 static int nv_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
diff --git a/drivers/scsi/sata_promise.c b/drivers/scsi/sata_promise.c
--- a/drivers/scsi/sata_promise.c
+++ b/drivers/scsi/sata_promise.c
@@ -122,6 +122,7 @@ static struct ata_port_operations pdc_at
 	.scr_write		= pdc_sata_scr_write,
 	.port_start		= pdc_port_start,
 	.port_stop		= pdc_port_stop,
+	.host_stop		= ata_host_stop,
 };
 
 static struct ata_port_info pdc_port_info[] = {
diff --git a/drivers/scsi/sata_qstor.c b/drivers/scsi/sata_qstor.c
--- a/drivers/scsi/sata_qstor.c
+++ b/drivers/scsi/sata_qstor.c
@@ -111,7 +111,7 @@ static void qs_scr_write (struct ata_por
 static int qs_ata_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
 static irqreturn_t qs_intr (int irq, void *dev_instance, struct pt_regs *regs);
 static int qs_port_start(struct ata_port *ap);
-static void qs_host_stop(struct ata_host_set *host_set);
+static void qs_host_stop_prewalk(struct ata_host_set *host_set);
 static void qs_port_stop(struct ata_port *ap);
 static void qs_phy_reset(struct ata_port *ap);
 static void qs_qc_prep(struct ata_queued_cmd *qc);
@@ -160,7 +160,8 @@ static struct ata_port_operations qs_ata
 	.scr_write		= qs_scr_write,
 	.port_start		= qs_port_start,
 	.port_stop		= qs_port_stop,
-	.host_stop		= qs_host_stop,
+	.host_stop		= ata_host_stop,
+	.host_stop_prewalk	= qs_host_stop_prewalk,
 	.bmdma_stop		= qs_bmdma_stop,
 	.bmdma_status		= qs_bmdma_status,
 };
@@ -530,7 +531,7 @@ static void qs_port_stop(struct ata_port
 	ata_port_stop(ap);
 }
 
-static void qs_host_stop(struct ata_host_set *host_set)
+static void qs_host_stop_prewalk(struct ata_host_set *host_set)
 {
 	void __iomem *mmio_base = host_set->mmio_base;
 
diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -161,6 +161,7 @@ static struct ata_port_operations sil_op
 	.scr_write		= sil_scr_write,
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
+	.host_stop		= ata_host_stop,
 };
 
 static struct ata_port_info sil_port_info[] = {
diff --git a/drivers/scsi/sata_sis.c b/drivers/scsi/sata_sis.c
--- a/drivers/scsi/sata_sis.c
+++ b/drivers/scsi/sata_sis.c
@@ -114,6 +114,7 @@ static struct ata_port_operations sis_op
 	.scr_write		= sis_scr_write,
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
+	.host_stop		= ata_host_stop,
 };
 
 static struct ata_port_info sis_port_info = {
diff --git a/drivers/scsi/sata_svw.c b/drivers/scsi/sata_svw.c
--- a/drivers/scsi/sata_svw.c
+++ b/drivers/scsi/sata_svw.c
@@ -313,6 +313,7 @@ static struct ata_port_operations k2_sat
 	.scr_write		= k2_sata_scr_write,
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
+	.host_stop		= ata_host_stop,
 };
 
 static void k2_sata_setup_port(struct ata_ioports *port, unsigned long base)
diff --git a/drivers/scsi/sata_sx4.c b/drivers/scsi/sata_sx4.c
--- a/drivers/scsi/sata_sx4.c
+++ b/drivers/scsi/sata_sx4.c
@@ -245,6 +245,8 @@ static void pdc20621_host_stop(struct at
 
 	iounmap(dimm_mmio);
 	kfree(hpriv);
+
+	ata_host_stop(host_set);
 }
 
 static int pdc_port_start(struct ata_port *ap)
diff --git a/drivers/scsi/sata_uli.c b/drivers/scsi/sata_uli.c
--- a/drivers/scsi/sata_uli.c
+++ b/drivers/scsi/sata_uli.c
@@ -113,6 +113,7 @@ static struct ata_port_operations uli_op
 
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
+	.host_stop		= ata_host_stop,
 };
 
 static struct ata_port_info uli_port_info = {
diff --git a/drivers/scsi/sata_via.c b/drivers/scsi/sata_via.c
--- a/drivers/scsi/sata_via.c
+++ b/drivers/scsi/sata_via.c
@@ -134,6 +134,7 @@ static struct ata_port_operations svia_s
 
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
+	.host_stop		= ata_host_stop,
 };
 
 static struct ata_port_info svia_port_info = {
diff --git a/drivers/scsi/sata_vsc.c b/drivers/scsi/sata_vsc.c
--- a/drivers/scsi/sata_vsc.c
+++ b/drivers/scsi/sata_vsc.c
@@ -230,6 +230,7 @@ static struct ata_port_operations vsc_sa
 	.scr_write		= vsc_sata_scr_write,
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
+	.host_stop		= ata_host_stop,
 };
 
 static void __devinit vsc_sata_setup_port(struct ata_ioports *port, unsigned long base)
diff --git a/include/linux/libata.h b/include/linux/libata.h
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -361,6 +361,7 @@ struct ata_port_operations {
 	int (*port_start) (struct ata_port *ap);
 	void (*port_stop) (struct ata_port *ap);
 
+	void (*host_stop_prewalk) (struct ata_host_set *host_set);
 	void (*host_stop) (struct ata_host_set *host_set);
 
 	void (*bmdma_stop) (struct ata_port *ap);
@@ -410,6 +411,7 @@ extern u8 ata_chk_err(struct ata_port *a
 extern void ata_exec_command(struct ata_port *ap, struct ata_taskfile *tf);
 extern int ata_port_start (struct ata_port *ap);
 extern void ata_port_stop (struct ata_port *ap);
+extern void ata_host_stop (struct ata_host_set *host_set);
 extern irqreturn_t ata_interrupt (int irq, void *dev_instance, struct pt_regs *regs);
 extern void ata_qc_prep(struct ata_queued_cmd *qc);
 extern int ata_qc_issue_prot(struct ata_queued_cmd *qc);

--------------070202010401090602070805--
