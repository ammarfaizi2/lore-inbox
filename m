Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751091AbVLLEJ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbVLLEJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 23:09:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751086AbVLLEJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 23:09:58 -0500
Received: from mail.dvmed.net ([216.237.124.58]:47807 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751084AbVLLEJ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 23:09:57 -0500
Message-ID: <439CF812.8010107@pobox.com>
Date: Sun, 11 Dec 2005 23:09:54 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] AHCI SATA vendor update from VIA
Content-Type: multipart/mixed;
 boundary="------------070809000909030801010403"
X-Spam-Score: 0.6 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  I received this ahci.c patch from VIA, and pass it on
	for review, comment, and testing. This patch won't go in as-is, because
	it does too much special casing. But until we get around to that,
	people with VIA controllers probably want this... [...] 
	Content analysis details:   (0.6 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.5 TO_ADDRESS_EQ_REAL     To: repeats address as real name
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070809000909030801010403
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I received this ahci.c patch from VIA, and pass it on for review, 
comment, and testing.

This patch won't go in as-is, because it does too much special casing. 
But until we get around to that, people with VIA controllers probably 
want this...

	Jeff



--------------070809000909030801010403
Content-Type: text/plain;
 name="ahci.c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ahci.c.patch"

--- ahci.c.orig	2005-11-21 14:24:48.000000000 +0800
+++ ahci.c	2005-11-21 14:25:35.000000000 +0800
@@ -59,6 +59,7 @@
 	RX_FIS_D2H_REG		= 0x40,	/* offset of D2H Register FIS data */
 
 	board_ahci		= 0,
+	board_via_ahci		= 1,
 
 	/* global controller registers */
 	HOST_CAP		= 0x00, /* host capabilities */
@@ -126,6 +127,7 @@
 	PORT_CMD_LIST_ON	= (1 << 15), /* cmd list DMA engine running */
 	PORT_CMD_FIS_ON		= (1 << 14), /* FIS DMA engine running */
 	PORT_CMD_FIS_RX		= (1 << 4), /* Enable FIS receive DMA engine */
+	PORT_CMD_CLO		= (1 << 3), /* CLO */
 	PORT_CMD_POWER_ON	= (1 << 2), /* Power up device */
 	PORT_CMD_SPIN_UP	= (1 << 1), /* Spin up device */
 	PORT_CMD_START		= (1 << 0), /* Enable port DMA engine */
@@ -183,6 +185,14 @@
 static u8 ahci_check_err(struct ata_port *ap);
 static inline int ahci_host_intr(struct ata_port *ap, struct ata_queued_cmd *qc);
 
+static int via_ahci_qc_issue(struct ata_queued_cmd *qc);
+static void via_ahci_phy_reset(struct ata_port *ap);
+static void via_ahci_port_stop(struct ata_port *ap);
+static int via_ahci_softreset(struct ata_port *ap);
+static unsigned int via_ata_busy_sleep (struct ata_port *ap,
+				    unsigned long tmout_pat,
+			    	    unsigned long tmout);
+
 static Scsi_Host_Template ahci_sht = {
 	.module			= THIS_MODULE,
 	.name			= DRV_NAME,
@@ -231,6 +241,35 @@
 	.host_stop		= ahci_host_stop,
 };
 
+static struct ata_port_operations via_ahci_ops = {
+	.port_disable		= ata_port_disable,
+
+	.check_status		= ahci_check_status,
+	.check_altstatus	= ahci_check_status,
+	.check_err		= ahci_check_err,
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
+	.host_stop		= ahci_host_stop,
+
+	.phy_reset		= via_ahci_phy_reset,
+	.qc_issue		= via_ahci_qc_issue,
+	.port_stop		= via_ahci_port_stop,
+};
+
 static struct ata_port_info ahci_port_info[] = {
 	/* board_ahci */
 	{
@@ -242,6 +281,16 @@
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
 
 static struct pci_device_id ahci_pci_tbl[] = {
@@ -263,6 +312,8 @@
 	  board_ahci }, /* ESB2 */
 	{ PCI_VENDOR_ID_INTEL, 0x2683, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_ahci }, /* ESB2 */
+	{ PCI_VENDOR_ID_VIA, 0x3349, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_via_ahci }, /* VT8251*/
 	{ }	/* terminate list */
 };
 
@@ -1049,6 +1100,244 @@
 	return rc;
 }
 
+/* START: patch code for VIA VT8251 ahci controller */
+
+static int via_ahci_softreset(struct ata_port *ap)
+{
+	void __iomem *port_mmio = (void __iomem *) ap->ioaddr.cmd_addr;
+	struct ahci_port_priv *pp = ap->private_data;
+	u32 tmp,i;
+	u8 *fisbuf;
+
+	VPRINTK("ENTER\n");
+
+	writel(0x00000000, port_mmio + PORT_IRQ_MASK);  /*disable interrupt */
+	readl (port_mmio + PORT_IRQ_MASK);  /* flush */
+
+	/* prepare the software-reset commands */
+
+	/* prepare first command header */
+	memset(pp->cmd_slot, 0, 32);
+	pp->cmd_slot[0].opts = 0x00000505;
+	pp->cmd_slot[0].status = 0;
+	pp->cmd_slot[0].tbl_addr = cpu_to_le32(pp->cmd_tbl_dma & 0xffffffff);
+	pp->cmd_slot[0].tbl_addr_hi = cpu_to_le32((pp->cmd_tbl_dma >> 16) >> 16);
+
+	/* prepare CMDFIS struct */
+	fisbuf = pp->cmd_tbl;
+	memset(fisbuf, 0, 64);
+	fisbuf[0] = 0x27;
+	fisbuf[7] = 0xa0;
+	fisbuf[15] = 0x04;
+	
+	/* trigger the commands */
+	writel(0x1, port_mmio + PORT_CMD_ISSUE);
+	readl (port_mmio + PORT_CMD_ISSUE); /* flush */
+
+	udelay(20);
+    /* wait command complete */
+	for (i = 0; i < 2000; i++) {
+		tmp = readl(port_mmio + PORT_CMD_ISSUE);
+		if ((tmp & 1) == 0) break;
+		msleep(20);
+	}
+
+	if (i == 2000) {
+		printk(KERN_WARNING "TimeOut for Wait Command complete\n");
+		return 1;
+	}
+
+	/* prepare second command header */
+	pp->cmd_slot[0].opts = 0x00000005;
+	pp->cmd_slot[0].status = 0;
+	pp->cmd_slot[0].tbl_addr = cpu_to_le32(pp->cmd_tbl_dma & 0xffffffff);
+	pp->cmd_slot[0].tbl_addr_hi = cpu_to_le32((pp->cmd_tbl_dma >> 16) >> 16);
+
+	fisbuf = pp->cmd_tbl;
+	memset(fisbuf, 0, 64);
+	fisbuf[0] = 0x27;
+	fisbuf[7] = 0xa0;
+	fisbuf[15] = 0x00;
+
+	/* trigger the commands */
+	writel(0x1, port_mmio + PORT_CMD_ISSUE);
+	readl (port_mmio + PORT_CMD_ISSUE); /* flush */
+
+	udelay(20);
+    /* wait command complete */
+	for (i = 0; i < 2000; i++) {
+		tmp = readl(port_mmio + PORT_CMD_ISSUE);
+		if ((tmp & 1) == 0) break;
+		msleep(20);
+	}
+
+	if (i == 2000) {
+		printk(KERN_WARNING "TimeOut for Wait Command complete\n");
+		return 1;
+	}
+
+	// enable port interrupt
+	writel(0xffffffff, port_mmio + PORT_IRQ_MASK);
+	readl (port_mmio + PORT_IRQ_MASK);  /* flush */
+
+	return 0;
+}
+
+static unsigned int via_ata_busy_sleep (struct ata_port *ap,
+				    unsigned long tmout_pat,
+			    	    unsigned long tmout)
+{
+	unsigned long timer_start, timeout;
+	u8 status;
+
+	status = ata_busy_wait(ap, ATA_BUSY, 300);
+	timer_start = jiffies;
+	timeout = timer_start + tmout_pat;
+	while ((status & ATA_BUSY) && (time_before(jiffies, timeout))) {
+		msleep(50);
+		status = ata_busy_wait(ap, ATA_BUSY, 3);
+	}
+
+	if (status & ATA_BUSY)
+		printk(KERN_WARNING "ata%u is slow to respond, "
+		       "please be patient\n", ap->id);
+
+	timeout = timer_start + tmout;
+	while ((status & ATA_BUSY) && (time_before(jiffies, timeout))) {
+		msleep(50);
+		status = ata_chk_status(ap);
+	}
+
+	if (status & ATA_BUSY) {
+		printk(KERN_ERR "ata%u failed to respond (%lu secs)\n",
+		       ap->id, tmout / HZ);
+		return 1;
+	}
+
+	return 0;
+}
+
+static void via_ahci_phy_reset(struct ata_port *ap)
+{
+	void __iomem *port_mmio = (void __iomem *) ap->ioaddr.cmd_addr;
+	struct ata_taskfile tf;
+	struct ata_device *dev = &ap->device[0];
+	u32 tmp;
+
+	u32 sstatus,i;
+	unsigned long timeout = jiffies + (HZ * 5);
+	u8 tmp_status;
+	
+	if (ap->flags & ATA_FLAG_SATA_RESET) {
+		/* issue phy wake/reset */
+		scr_write_flush(ap, SCR_CONTROL, 0x301);
+		udelay(400);			/* FIXME: a guess */
+	}
+	scr_write_flush(ap, SCR_CONTROL, 0x300); /* phy wake/clear reset */
+
+	/* wait for phy to become ready, if necessary */
+	do {
+		msleep(200);
+		sstatus = scr_read(ap, SCR_STATUS);
+		if ((sstatus & 0xf) != 1)
+			break;
+	} while (time_before(jiffies, timeout));
+
+	/* TODO: phy layer with polling, timeouts, etc. */
+	if (sata_dev_present(ap))
+		ata_port_probe(ap);
+	else {
+		sstatus = scr_read(ap, SCR_STATUS);
+		printk(KERN_INFO "ata%u: no device found (phy stat %08x)\n",
+		       ap->id, sstatus);
+		ata_port_disable(ap);
+	}
+
+	if (ap->flags & ATA_FLAG_PORT_DISABLED)
+		return;
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
+	if (via_ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT)) {
+		ata_port_disable(ap);
+		return;
+	}
+
+	ap->cbl = ATA_CBL_SATA;
+
+	if (ap->flags & ATA_FLAG_PORT_DISABLED)
+		return;
+
+	tmp = readl(port_mmio + PORT_SIG);
+	tf.lbah		= (tmp >> 24)	& 0xff;
+	tf.lbam		= (tmp >> 16)	& 0xff;
+	tf.lbal		= (tmp >> 8)	& 0xff;
+	tf.nsect	= (tmp)		& 0xff;
+
+	dev->class = ata_dev_classify(&tf);
+	if (!ata_dev_present(dev))
+		ata_port_disable(ap);
+
+}
+
+static int via_ahci_qc_issue(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	void *port_mmio = (void *) ap->ioaddr.cmd_addr;
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
+	writel(1, port_mmio + PORT_CMD_ISSUE);
+	readl(port_mmio + PORT_CMD_ISSUE);	/* flush */
+
+	return 0;
+}
+
+static void via_ahci_port_stop(struct ata_port *ap)
+{
+	struct device *dev = ap->host_set->dev;
+	struct ahci_port_priv *pp = ap->private_data;
+
+	/* spec says 500 msecs for each PORT_CMD_{START,FIS_RX} bit, so
+	 * this is slightly incorrect.
+	 */
+	msleep(500);
+
+	ap->private_data = NULL;
+	dma_free_coherent(dev, AHCI_PORT_PRIV_DMA_SZ,
+			  pp->cmd_slot, pp->cmd_slot_dma);
+	kfree(pp);
+	ata_port_stop(ap);
+}
+
+/* END: patch code for VIA VT8251 ahci controller */
 
 static int __init ahci_init(void)
 {

--------------070809000909030801010403--
