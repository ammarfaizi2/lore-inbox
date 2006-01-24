Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030456AbWAXMXL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030456AbWAXMXL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 07:23:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030461AbWAXMXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 07:23:11 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:46504 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1030456AbWAXMXK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 07:23:10 -0500
From: Geoff Rivell <grivell@comcast.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] ahci: vt8251 support
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Date: Tue, 24 Jan 2006 07:16:58 -0500
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_6qh1DZO8hskYX73"
Message-Id: <200601240716.58249.grivell@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_6qh1DZO8hskYX73
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Modified the Via patch for VT8251 sata support in the kernel.

I am hoping the patch is clean enough for kernel inclusion.  It has had 
limited testing by the viaarena.com forum people.

-- 
...."Have you mooed today?"...

--Boundary-00=_6qh1DZO8hskYX73
Content-Type: text/x-diff;
  charset="us-ascii";
  name="via_ahci.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="via_ahci.patch"

--- ahci.c.orig	2006-01-24 11:39:14.000000000 +0000
+++ ahci.c	2006-01-24 11:39:23.000000000 +0000
@@ -70,6 +70,7 @@
 	RX_FIS_D2H_REG		= 0x40,	/* offset of D2H Register FIS data */
 
 	board_ahci		= 0,
+	board_via_ahci		= 1,
 
 	/* global controller registers */
 	HOST_CAP		= 0x00, /* host capabilities */
@@ -138,6 +139,7 @@
 	PORT_CMD_LIST_ON	= (1 << 15), /* cmd list DMA engine running */
 	PORT_CMD_FIS_ON		= (1 << 14), /* FIS DMA engine running */
 	PORT_CMD_FIS_RX		= (1 << 4), /* Enable FIS receive DMA engine */
+	PORT_CMD_CLO		= (1 << 3), /* CLO */
 	PORT_CMD_POWER_ON	= (1 << 2), /* Power up device */
 	PORT_CMD_SPIN_UP	= (1 << 1), /* Spin up device */
 	PORT_CMD_START		= (1 << 0), /* Enable port DMA engine */
@@ -196,6 +198,10 @@
 static u8 ahci_check_status(struct ata_port *ap);
 static inline int ahci_host_intr(struct ata_port *ap, struct ata_queued_cmd *qc);
 static void ahci_remove_one (struct pci_dev *pdev);
+static int via_ahci_qc_issue(struct ata_queued_cmd *qc);
+static void via_ahci_phy_reset(struct ata_port *ap);
+static int via_ahci_softreset(struct ata_port *ap);
+
 
 static struct scsi_host_template ahci_sht = {
 	.module			= THIS_MODULE,
@@ -243,6 +249,33 @@
 	.port_stop		= ahci_port_stop,
 };
 
+static struct ata_port_operations via_ahci_ops = {
+	.port_disable		= ata_port_disable,
+
+	.check_status		= ahci_check_status,
+	.check_altstatus	= ahci_check_status,
+	.dev_select		= ata_noop_dev_select,
+
+	.tf_read		= ahci_tf_read,
+
+
+	.qc_prep		= ahci_qc_prep,
+
+	.eng_timeout		= ahci_eng_timeout,
+
+	.irq_handler		= ahci_interrupt,
+	.irq_clear		= ahci_irq_clear,
+
+	.scr_read		= ahci_scr_read,
+	.scr_write		= ahci_scr_write,
+
+	.port_start		= ahci_port_start,
+
+	.phy_reset		= via_ahci_phy_reset,
+	.qc_issue		= via_ahci_qc_issue,
+	.port_stop		= ahci_port_stop,
+};
+
 static struct ata_port_info ahci_port_info[] = {
 	/* board_ahci */
 	{
@@ -254,6 +287,16 @@
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
 		.port_ops	= &ahci_ops,
 	},
+	/* board_via_ahci */
+	{
+		.sht		= &ahci_sht,
+		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
+				  ATA_FLAG_SRST | ATA_FLAG_MMIO |
+				  ATA_FLAG_PIO_DMA,
+		.pio_mask	= 0x03, /* pio3-4 */
+		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
+		.port_ops	= &via_ahci_ops,
+	},
 };
 
 static const struct pci_device_id ahci_pci_tbl[] = {
@@ -277,6 +320,8 @@
 	  board_ahci }, /* ESB2 */
 	{ PCI_VENDOR_ID_INTEL, 0x27c6, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_ahci }, /* ICH7-M DH */
+	{ PCI_VENDOR_ID_VIA, 0x3349, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_via_ahci }, /* VT8251*/
 	{ }	/* terminate list */
 };
 
@@ -1100,6 +1145,113 @@
 	return rc;
 }
 
+/* START: patch code for VIA VT8251 ahci controller */
+
+static int via_ahci_softreset(struct ata_port *ap)
+{
+	void __iomem *port_mmio = (void __iomem *) ap->ioaddr.cmd_addr;
+	struct ahci_port_priv *pp = ap->private_data;
+	u32 tmp,i,j,via_opts[]={0x00000505,0x00000005};
+	u8 *fisbuf,via_fisbuf[]={0x04,0x00};
+
+	VPRINTK("ENTER\n");
+
+	writel(0x00000000, port_mmio + PORT_IRQ_MASK);  /*disable interrupt */
+	readl (port_mmio + PORT_IRQ_MASK);  /* flush */
+
+	/* prepare the software-reset commands */
+
+	memset(pp->cmd_slot, 0, 32);
+
+	for (j = 0; j < 2; j++) {
+		/* prepare the command header */
+		pp->cmd_slot[0].opts = via_opts[j];
+		pp->cmd_slot[0].status = 0;
+		pp->cmd_slot[0].tbl_addr = cpu_to_le32(pp->cmd_tbl_dma & 0xffffffff);
+		pp->cmd_slot[0].tbl_addr_hi = cpu_to_le32((pp->cmd_tbl_dma >> 16) >> 16);
+
+		/* prepare CMDFIS struct */
+		fisbuf = pp->cmd_tbl;
+		memset(fisbuf, 0, 64);
+		fisbuf[0] = 0x27;
+		fisbuf[7] = 0xa0;
+		fisbuf[15] = via_fisbuf[j];
+	
+		/* trigger the commands */
+		writel(0x1, port_mmio + PORT_CMD_ISSUE);
+		readl (port_mmio + PORT_CMD_ISSUE); /* flush */
+
+		udelay(20);
+		/* wait command complete */
+		for (i = 0; i < 2000; i++) {
+			tmp = readl(port_mmio + PORT_CMD_ISSUE);
+			if ((tmp & 1) == 0) break;
+			msleep(20);
+		}
+
+		if (i == 2000) {
+			printk(KERN_WARNING "TimeOut for Wait Command complete\n");
+			return 1;
+		}
+	}
+
+	// enable port interrupt
+	writel(0xffffffff, port_mmio + PORT_IRQ_MASK);
+	readl (port_mmio + PORT_IRQ_MASK);  /* flush */
+
+	return 0;
+}
+
+
+static void via_ahci_phy_reset(struct ata_port *ap)
+{
+	void __iomem *port_mmio = (void __iomem *) ap->ioaddr.cmd_addr;
+	u32 tmp,i;
+	u8 tmp_status;
+
+	/*Fix the VIA busy bug by a software reset*/
+	for (i = 0; i < 100; i++) {
+		tmp_status = ap->ops->check_status(ap);
+		if ((tmp_status & ATA_BUSY) == 0) break;
+		msleep(10);
+	}
+
+	if ((tmp_status & ATA_BUSY)) {
+		DPRINTK("Busy after CommReset, do softreset...\n"); 
+		/*set the PxCMD.CLO bit to clear BUSY and DRQ, to make the reset command sent out*/
+		tmp = readl(port_mmio + PORT_CMD);
+		tmp |= PORT_CMD_CLO;
+		writel(tmp, port_mmio + PORT_CMD);
+		readl(port_mmio + PORT_CMD); /* flush */
+
+		if (via_ahci_softreset(ap)) {
+			printk(KERN_WARNING "softreset failed\n");
+			return;
+		}
+	}
+
+	ahci_phy_reset(ap);
+}
+
+static int via_ahci_qc_issue(struct ata_queued_cmd *qc)
+{
+
+    if (qc &&
+        qc->tf.command == ATA_CMD_SET_FEATURES &&
+        qc->tf.feature == SETFEATURES_XFER) {
+        /* skip set xfer mode process */
+
+		ata_qc_complete(qc, 0);
+		qc = NULL;
+        return 0;
+    }
+
+	ahci_qc_issue(qc);
+
+	return 0;
+}
+
+
 static void ahci_remove_one (struct pci_dev *pdev)
 {
 	struct device *dev = pci_dev_to_dev(pdev);

--Boundary-00=_6qh1DZO8hskYX73--
