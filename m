Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261310AbVCGRVh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261310AbVCGRVh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 12:21:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbVCGRVh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 12:21:37 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60810 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261310AbVCGRMT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 12:12:19 -0500
Message-ID: <422C8B64.1020404@pobox.com>
Date: Mon, 07 Mar 2005 12:12:04 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
CC: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [BK PATCHES] 2.6.x libata updates
Content-Type: multipart/mixed;
 boundary="------------090805060604010701020900"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090805060604010701020900
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------090805060604010701020900
Content-Type: text/plain;
 name="changelog.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="changelog.txt"

Please do a

	bk pull bk://gkernel.bkbits.net/libata-2.6

This will update the following files:

 drivers/scsi/libata-core.c |   16 ++++++----------
 drivers/scsi/sata_nv.c     |    6 ++++--
 drivers/scsi/sata_sil.c    |    2 +-
 drivers/scsi/sata_svw.c    |    4 ++--
 drivers/scsi/sata_vsc.c    |    3 ++-
 5 files changed, 15 insertions(+), 16 deletions(-)

through these ChangeSets:

Adam J. Richter:
  o ata_pci_remove_one used freed memory

Adrian Bunk:
  o drivers/scsi/sata_*: make code static


--------------090805060604010701020900
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff -Nru a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c	2005-03-07 12:11:31 -05:00
+++ b/drivers/scsi/libata-core.c	2005-03-07 12:11:31 -05:00
@@ -3884,26 +3884,22 @@
 		ap = host_set->ports[i];
 
 		ata_scsi_release(ap->host);
-		scsi_host_put(ap->host);
-	}
-
-	pci_release_regions(pdev);
-
-	for (i = 0; i < host_set->n_ports; i++) {
-		struct ata_ioports *ioaddr;
-
-		ap = host_set->ports[i];
-		ioaddr = &ap->ioaddr;
 
 		if ((ap->flags & ATA_FLAG_NO_LEGACY) == 0) {
+			struct ata_ioports *ioaddr = &ap->ioaddr;
+
 			if (ioaddr->cmd_addr == 0x1f0)
 				release_region(0x1f0, 8);
 			else if (ioaddr->cmd_addr == 0x170)
 				release_region(0x170, 8);
 		}
+
+		scsi_host_put(ap->host);
 	}
 
 	kfree(host_set);
+
+	pci_release_regions(pdev);
 	pci_disable_device(pdev);
 	dev_set_drvdata(dev, NULL);
 }
diff -Nru a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
--- a/drivers/scsi/sata_nv.c	2005-03-07 12:11:31 -05:00
+++ b/drivers/scsi/sata_nv.c	2005-03-07 12:11:31 -05:00
@@ -99,7 +99,8 @@
 #define NV_MCP_SATA_CFG_20_SATA_SPACE_EN	0x04
 
 static int nv_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
-irqreturn_t nv_interrupt (int irq, void *dev_instance, struct pt_regs *regs);
+static irqreturn_t nv_interrupt (int irq, void *dev_instance,
+				 struct pt_regs *regs);
 static u32 nv_scr_read (struct ata_port *ap, unsigned int sc_reg);
 static void nv_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
 static void nv_host_stop (struct ata_host_set *host_set);
@@ -257,7 +258,8 @@
 MODULE_DEVICE_TABLE(pci, nv_pci_tbl);
 MODULE_VERSION(DRV_VERSION);
 
-irqreturn_t nv_interrupt (int irq, void *dev_instance, struct pt_regs *regs)
+static irqreturn_t nv_interrupt (int irq, void *dev_instance,
+				 struct pt_regs *regs)
 {
 	struct ata_host_set *host_set = dev_instance;
 	struct nv_host *host = host_set->private_data;
diff -Nru a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
--- a/drivers/scsi/sata_sil.c	2005-03-07 12:11:31 -05:00
+++ b/drivers/scsi/sata_sil.c	2005-03-07 12:11:31 -05:00
@@ -78,7 +78,7 @@
 
 
 /* TODO firmware versions should be added - eric */
-struct sil_drivelist {
+static const struct sil_drivelist {
 	const char * product;
 	unsigned int quirk;
 } sil_blacklist [] = {
diff -Nru a/drivers/scsi/sata_svw.c b/drivers/scsi/sata_svw.c
--- a/drivers/scsi/sata_svw.c	2005-03-07 12:11:31 -05:00
+++ b/drivers/scsi/sata_svw.c	2005-03-07 12:11:31 -05:00
@@ -156,7 +156,7 @@
  *	spin_lock_irqsave(host_set lock)
  */
 
-void k2_bmdma_setup_mmio (struct ata_queued_cmd *qc)
+static void k2_bmdma_setup_mmio (struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 	unsigned int rw = (qc->tf.flags & ATA_TFLAG_WRITE);
@@ -186,7 +186,7 @@
  *	spin_lock_irqsave(host_set lock)
  */
 
-void k2_bmdma_start_mmio (struct ata_queued_cmd *qc)
+static void k2_bmdma_start_mmio (struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 	void *mmio = (void *) ap->ioaddr.bmdma_addr;
diff -Nru a/drivers/scsi/sata_vsc.c b/drivers/scsi/sata_vsc.c
--- a/drivers/scsi/sata_vsc.c	2005-03-07 12:11:31 -05:00
+++ b/drivers/scsi/sata_vsc.c	2005-03-07 12:11:31 -05:00
@@ -155,7 +155,8 @@
  *
  * Read the interrupt register and process for the devices that have them pending.
  */
-irqreturn_t vsc_sata_interrupt (int irq, void *dev_instance, struct pt_regs *regs)
+static irqreturn_t vsc_sata_interrupt (int irq, void *dev_instance,
+				       struct pt_regs *regs)
 {
 	struct ata_host_set *host_set = dev_instance;
 	unsigned int i;

--------------090805060604010701020900--
