Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261156AbVCETMM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbVCETMM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 14:12:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261181AbVCETJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 14:09:39 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40163 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261169AbVCESqf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 13:46:35 -0500
Message-ID: <4229FE7C.9060409@pobox.com>
Date: Sat, 05 Mar 2005 13:46:20 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
CC: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [BK PATCHES] 2.6.x libata updates
Content-Type: multipart/mixed;
 boundary="------------060309040809060103040200"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060309040809060103040200
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------060309040809060103040200
Content-Type: text/plain;
 name="changelog.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="changelog.txt"

Please do a

	bk pull bk://gkernel.bkbits.net/libata-2.6

This will update the following files:

 drivers/scsi/ahci.c       |   12 +++++------
 drivers/scsi/sata_qstor.c |   50 +++++++++++++++++++++++++++++++---------------
 drivers/scsi/sata_vsc.c   |    4 +--
 3 files changed, 42 insertions(+), 24 deletions(-)

through these ChangeSets:

<liml:rtr.ca>:
  o sata_qstor: eh_timeout fix

<tklauser:nuerscht.ch>:
  o drivers/scsi/ahci: Use the DMA_{64,32}BIT_MASK constants
  o drivers/scsi/sata_vsc: Use the DMA_{64,32}BIT_MASK constants

Jeff Garzik:
  o [libata ahci] Print out port id on error messages

Mark Lord:
  o [libata qstor] minor update per LKML comments


--------------060309040809060103040200
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff -Nru a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
--- a/drivers/scsi/ahci.c	2005-03-05 13:45:12 -05:00
+++ b/drivers/scsi/ahci.c	2005-03-05 13:45:12 -05:00
@@ -574,7 +574,7 @@
 	writel(tmp, port_mmio + PORT_CMD);
 	readl(port_mmio + PORT_CMD); /* flush */
 
-	printk(KERN_WARNING "ata%u: error occurred, port reset\n", ap->port_no);
+	printk(KERN_WARNING "ata%u: error occurred, port reset\n", ap->id);
 }
 
 static void ahci_eng_timeout(struct ata_port *ap)
@@ -766,10 +766,10 @@
 
 	using_dac = hpriv->cap & HOST_CAP_64;
 	if (using_dac &&
-	    !pci_set_dma_mask(pdev, 0xffffffffffffffffULL)) {
-		rc = pci_set_consistent_dma_mask(pdev, 0xffffffffffffffffULL);
+	    !pci_set_dma_mask(pdev, DMA_64BIT_MASK)) {
+		rc = pci_set_consistent_dma_mask(pdev, DMA_64BIT_MASK);
 		if (rc) {
-			rc = pci_set_consistent_dma_mask(pdev, 0xffffffffULL);
+			rc = pci_set_consistent_dma_mask(pdev, DMA_32BIT_MASK);
 			if (rc) {
 				printk(KERN_ERR DRV_NAME "(%s): 64-bit DMA enable failed\n",
 					pci_name(pdev));
@@ -779,13 +779,13 @@
 
 		hpriv->flags |= HOST_CAP_64;
 	} else {
-		rc = pci_set_dma_mask(pdev, 0xffffffffULL);
+		rc = pci_set_dma_mask(pdev, DMA_32BIT_MASK);
 		if (rc) {
 			printk(KERN_ERR DRV_NAME "(%s): 32-bit DMA enable failed\n",
 				pci_name(pdev));
 			return rc;
 		}
-		rc = pci_set_consistent_dma_mask(pdev, 0xffffffffULL);
+		rc = pci_set_consistent_dma_mask(pdev, DMA_32BIT_MASK);
 		if (rc) {
 			printk(KERN_ERR DRV_NAME "(%s): 32-bit consistent DMA enable failed\n",
 				pci_name(pdev));
diff -Nru a/drivers/scsi/sata_qstor.c b/drivers/scsi/sata_qstor.c
--- a/drivers/scsi/sata_qstor.c	2005-03-05 13:45:12 -05:00
+++ b/drivers/scsi/sata_qstor.c	2005-03-05 13:45:12 -05:00
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
@@ -152,7 +153,7 @@
 	.phy_reset		= qs_phy_reset,
 	.qc_prep		= qs_qc_prep,
 	.qc_issue		= qs_qc_issue,
-	.eng_timeout		= ata_eng_timeout,
+	.eng_timeout		= qs_eng_timeout,
 	.irq_handler		= qs_intr,
 	.irq_clear		= qs_irq_clear,
 	.scr_read		= qs_scr_read,
@@ -212,7 +213,7 @@
 	/* nothing */
 }
 
-static void qs_enter_reg_mode(struct ata_port *ap)
+static inline void qs_enter_reg_mode(struct ata_port *ap)
 {
 	u8 __iomem *chan = ap->host_set->mmio_base + (ap->port_no * 0x4000);
 
@@ -220,17 +221,34 @@
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
 }
 
+static void qs_eng_timeout(struct ata_port *ap)
+{
+	struct qs_port_priv *pp = ap->private_data;
+
+	if (pp->state != qs_state_idle) /* healthy paranoia */
+		pp->state = qs_state_mmio;
+	qs_reset_channel_logic(ap);
+	ata_eng_timeout(ap);
+}
+
 static u32 qs_scr_read (struct ata_port *ap, unsigned int sc_reg)
 {
 	if (sc_reg > SCR_CONTROL)
@@ -261,11 +279,11 @@
 		u32 len;
 
 		addr = sg_dma_address(sg);
-		*(u64 *)prd = cpu_to_le64(addr);
+		*(__le64 *)prd = cpu_to_le64(addr);
 		prd += sizeof(u64);
 
 		len = sg_dma_len(sg);
-		*(u32 *)prd = cpu_to_le32(len);
+		*(__le32 *)prd = cpu_to_le32(len);
 		prd += sizeof(u64);
 
 		VPRINTK("PRD[%u] = (0x%llX, 0x%X)\n", nelem,
@@ -298,10 +316,10 @@
 	/* host control block (HCB) */
 	buf[ 0] = QS_HCB_HDR;
 	buf[ 1] = hflags;
-	*(u32 *)(&buf[ 4]) = cpu_to_le32(qc->nsect * ATA_SECT_SIZE);
-	*(u32 *)(&buf[ 8]) = cpu_to_le32(qc->n_elem);
+	*(__le32 *)(&buf[ 4]) = cpu_to_le32(qc->nsect * ATA_SECT_SIZE);
+	*(__le32 *)(&buf[ 8]) = cpu_to_le32(qc->n_elem);
 	addr = ((u64)pp->pkt_dma) + QS_CPB_BYTES;
-	*(u64 *)(&buf[16]) = cpu_to_le64(addr);
+	*(__le64 *)(&buf[16]) = cpu_to_le64(addr);
 
 	/* device control block (DCB) */
 	buf[24] = QS_DCB_HDR;
@@ -566,10 +584,10 @@
 	int rc, have_64bit_bus = (bus_info & QS_HPHY_64BIT);
 
 	if (have_64bit_bus &&
-	    !pci_set_dma_mask(pdev, 0xffffffffffffffffULL)) {
-		rc = pci_set_consistent_dma_mask(pdev, 0xffffffffffffffffULL);
+	    !pci_set_dma_mask(pdev, DMA_64BIT_MASK)) {
+		rc = pci_set_consistent_dma_mask(pdev, DMA_64BIT_MASK);
 		if (rc) {
-			rc = pci_set_consistent_dma_mask(pdev, 0xffffffffULL);
+			rc = pci_set_consistent_dma_mask(pdev, DMA_32BIT_MASK);
 			if (rc) {
 				printk(KERN_ERR DRV_NAME
 					"(%s): 64-bit DMA enable failed\n",
@@ -578,14 +596,14 @@
 			}
 		}
 	} else {
-		rc = pci_set_dma_mask(pdev, 0xffffffffULL);
+		rc = pci_set_dma_mask(pdev, DMA_32BIT_MASK);
 		if (rc) {
 			printk(KERN_ERR DRV_NAME
 				"(%s): 32-bit DMA enable failed\n",
 				pci_name(pdev));
 			return rc;
 		}
-		rc = pci_set_consistent_dma_mask(pdev, 0xffffffffULL);
+		rc = pci_set_consistent_dma_mask(pdev, DMA_32BIT_MASK);
 		if (rc) {
 			printk(KERN_ERR DRV_NAME
 				"(%s): 32-bit consistent DMA enable failed\n",
diff -Nru a/drivers/scsi/sata_vsc.c b/drivers/scsi/sata_vsc.c
--- a/drivers/scsi/sata_vsc.c	2005-03-05 13:45:12 -05:00
+++ b/drivers/scsi/sata_vsc.c	2005-03-05 13:45:12 -05:00
@@ -285,10 +285,10 @@
 	/*
 	 * Use 32 bit DMA mask, because 64 bit address support is poor.
 	 */
-	rc = pci_set_dma_mask(pdev, 0xFFFFFFFFULL);
+	rc = pci_set_dma_mask(pdev, DMA_32BIT_MASK);
 	if (rc)
 		goto err_out_regions;
-	rc = pci_set_consistent_dma_mask(pdev, 0xFFFFFFFFULL);
+	rc = pci_set_consistent_dma_mask(pdev, DMA_32BIT_MASK);
 	if (rc)
 		goto err_out_regions;
 

--------------060309040809060103040200--
