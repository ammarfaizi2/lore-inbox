Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261917AbVCGRWB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261917AbVCGRWB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 12:22:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261929AbVCGRWA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 12:22:00 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64138 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261917AbVCGRNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 12:13:31 -0500
Message-ID: <422C8BAB.3000600@pobox.com>
Date: Mon, 07 Mar 2005 12:13:15 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [BK PATCHES] 2.4.x libata updates
Content-Type: multipart/mixed;
 boundary="------------060600040804020008080604"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060600040804020008080604
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------060600040804020008080604
Content-Type: text/plain;
 name="changelog.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="changelog.txt"

Please do a

	bk pull bk://kernel.bkbits.net/jgarzik/libata-upstream-2.4

This will update the following files:

 drivers/scsi/libata-core.c |    9 ++++-----
 drivers/scsi/sata_nv.c     |    6 ++++--
 drivers/scsi/sata_qstor.c  |   30 ++++++++++++++++++++++++------
 drivers/scsi/sata_sil.c    |    2 +-
 drivers/scsi/sata_svw.c    |    4 ++--
 drivers/scsi/sata_vsc.c    |    3 ++-
 6 files changed, 37 insertions(+), 17 deletions(-)

through these ChangeSets:

<liml:rtr.ca>:
  o sata_qstor: eh_timeout fix

Adrian Bunk:
  o drivers/scsi/sata_*: make code static

Jeff Garzik:
  o [libata] remove_one helper cleanup


--------------060600040804020008080604
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff -Nru a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c	2005-03-07 12:12:34 -05:00
+++ b/drivers/scsi/libata-core.c	2005-03-07 12:12:34 -05:00
@@ -3887,15 +3887,12 @@
 	if (host_set->mmio_base)
 		iounmap(host_set->mmio_base);
 
-	pci_release_regions(pdev);
-
 	for (i = 0; i < host_set->n_ports; i++) {
-		struct ata_ioports *ioaddr;
-
 		ap = host_set->ports[i];
-		ioaddr = &ap->ioaddr;
 
 		if ((ap->flags & ATA_FLAG_NO_LEGACY) == 0) {
+			struct ata_ioports *ioaddr = &ap->ioaddr;
+
 			if (ioaddr->cmd_addr == 0x1f0)
 				release_region(0x1f0, 8);
 			else if (ioaddr->cmd_addr == 0x170)
@@ -3904,6 +3901,8 @@
 	}
 
 	kfree(host_set);
+
+	pci_release_regions(pdev);
 	pci_disable_device(pdev);
 	dev_set_drvdata(dev, NULL);
 }
diff -Nru a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
--- a/drivers/scsi/sata_nv.c	2005-03-07 12:12:34 -05:00
+++ b/drivers/scsi/sata_nv.c	2005-03-07 12:12:34 -05:00
@@ -99,7 +99,8 @@
 #define NV_MCP_SATA_CFG_20_SATA_SPACE_EN	0x04
 
 static int nv_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
-irqreturn_t nv_interrupt (int irq, void *dev_instance, struct pt_regs *regs);
+static irqreturn_t nv_interrupt (int irq, void *dev_instance,
+				 struct pt_regs *regs);
 static u32 nv_scr_read (struct ata_port *ap, unsigned int sc_reg);
 static void nv_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
 static void nv_host_stop (struct ata_host_set *host_set);
@@ -258,7 +259,8 @@
 MODULE_DEVICE_TABLE(pci, nv_pci_tbl);
 MODULE_VERSION(DRV_VERSION);
 
-irqreturn_t nv_interrupt (int irq, void *dev_instance, struct pt_regs *regs)
+static irqreturn_t nv_interrupt (int irq, void *dev_instance,
+				 struct pt_regs *regs)
 {
 	struct ata_host_set *host_set = dev_instance;
 	struct nv_host *host = host_set->private_data;
diff -Nru a/drivers/scsi/sata_qstor.c b/drivers/scsi/sata_qstor.c
--- a/drivers/scsi/sata_qstor.c	2005-03-07 12:12:34 -05:00
+++ b/drivers/scsi/sata_qstor.c	2005-03-07 12:12:34 -05:00
@@ -38,7 +38,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"sata_qstor"
-#define DRV_VERSION	"0.03"
+#define DRV_VERSION	"0.04"
 
 enum {
 	QS_PORTS		= 4,
@@ -120,6 +120,7 @@
 static void qs_bmdma_stop(struct ata_port *ap);
 static u8 qs_bmdma_status(struct ata_port *ap);
 static void qs_irq_clear(struct ata_port *ap);
+static void qs_eng_timeout(struct ata_port *ap);
 
 static Scsi_Host_Template qs_ata_sht = {
 	.module			= THIS_MODULE,
@@ -153,7 +154,7 @@
 	.phy_reset		= qs_phy_reset,
 	.qc_prep		= qs_qc_prep,
 	.qc_issue		= qs_qc_issue,
-	.eng_timeout		= ata_eng_timeout,
+	.eng_timeout		= qs_eng_timeout,
 	.irq_handler		= qs_intr,
 	.irq_clear		= qs_irq_clear,
 	.scr_read		= qs_scr_read,
@@ -213,7 +214,7 @@
 	/* nothing */
 }
 
-static void qs_enter_reg_mode(struct ata_port *ap)
+static inline void qs_enter_reg_mode(struct ata_port *ap)
 {
 	u8 __iomem *chan = ap->host_set->mmio_base + (ap->port_no * 0x4000);
 
@@ -221,15 +222,32 @@
 	readb(chan + QS_CCT_CTR0);        /* flush */
 }
 
-static void qs_phy_reset(struct ata_port *ap)
+static inline void qs_reset_channel_logic(struct ata_port *ap)
 {
 	u8 __iomem *chan = ap->host_set->mmio_base + (ap->port_no * 0x4000);
-	struct qs_port_priv *pp = ap->private_data;
 
-	pp->state = qs_state_idle;
 	writeb(QS_CTR1_RCHN, chan + QS_CCT_CTR1);
+	readb(chan + QS_CCT_CTR0);        /* flush */
 	qs_enter_reg_mode(ap);
+}
+
+static void qs_phy_reset(struct ata_port *ap)
+{
+	struct qs_port_priv *pp = ap->private_data;
+
+	pp->state = qs_state_idle;
+	qs_reset_channel_logic(ap);
 	sata_phy_reset(ap);
+}
+
+static void qs_eng_timeout(struct ata_port *ap)
+{
+	struct qs_port_priv *pp = ap->private_data;
+
+	if (pp->state != qs_state_idle) /* healthy paranoia */
+		pp->state = qs_state_mmio;
+	qs_reset_channel_logic(ap);
+	ata_eng_timeout(ap);
 }
 
 static u32 qs_scr_read (struct ata_port *ap, unsigned int sc_reg)
diff -Nru a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
--- a/drivers/scsi/sata_sil.c	2005-03-07 12:12:34 -05:00
+++ b/drivers/scsi/sata_sil.c	2005-03-07 12:12:34 -05:00
@@ -78,7 +78,7 @@
 
 
 /* TODO firmware versions should be added - eric */
-struct sil_drivelist {
+static const struct sil_drivelist {
 	const char * product;
 	unsigned int quirk;
 } sil_blacklist [] = {
diff -Nru a/drivers/scsi/sata_svw.c b/drivers/scsi/sata_svw.c
--- a/drivers/scsi/sata_svw.c	2005-03-07 12:12:34 -05:00
+++ b/drivers/scsi/sata_svw.c	2005-03-07 12:12:34 -05:00
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
--- a/drivers/scsi/sata_vsc.c	2005-03-07 12:12:34 -05:00
+++ b/drivers/scsi/sata_vsc.c	2005-03-07 12:12:34 -05:00
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

--------------060600040804020008080604--
