Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261397AbVBWCsr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261397AbVBWCsr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 21:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261396AbVBWCsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 21:48:47 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51168 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261395AbVBWCsU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 21:48:20 -0500
Message-ID: <421BEEE1.5080005@pobox.com>
Date: Tue, 22 Feb 2005 21:48:01 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Justin Cormack <justin@street-vision.com>
CC: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Re: AHCI oops
References: <200502200256.j1K2uKJ23938@tench.street-vision.com>
In-Reply-To: <200502200256.j1K2uKJ23938@tench.street-vision.com>
Content-Type: multipart/mixed;
 boundary="------------020200070309000608060106"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020200070309000608060106
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Can you try this patch?

If it fixes the oops, I'll forward upstream ASAP.

	Jeff




--------------020200070309000608060106
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

===== drivers/scsi/ahci.c 1.14 vs edited =====
--- 1.14/drivers/scsi/ahci.c	2005-02-13 19:58:01 -05:00
+++ edited/drivers/scsi/ahci.c	2005-02-22 21:46:25 -05:00
@@ -179,6 +179,7 @@
 static void ahci_host_stop(struct ata_host_set *host_set);
 static void ahci_qc_prep(struct ata_queued_cmd *qc);
 static u8 ahci_check_status(struct ata_port *ap);
+static u8 ahci_check_err(struct ata_port *ap);
 static inline int ahci_host_intr(struct ata_port *ap, struct ata_queued_cmd *qc);
 
 static Scsi_Host_Template ahci_sht = {
@@ -204,6 +205,8 @@
 	.port_disable		= ata_port_disable,
 
 	.check_status		= ahci_check_status,
+	.check_altstatus	= ahci_check_status,
+	.check_err		= ahci_check_err,
 	.dev_select		= ata_noop_dev_select,
 
 	.phy_reset		= ahci_phy_reset,
@@ -450,6 +453,13 @@
 	void *mmio = (void *) ap->ioaddr.cmd_addr;
 
 	return readl(mmio + PORT_TFDATA) & 0xFF;
+}
+
+static u8 ahci_check_err(struct ata_port *ap)
+{
+	void *mmio = (void *) ap->ioaddr.cmd_addr;
+
+	return (readl(mmio + PORT_TFDATA) >> 8) & 0xFF;
 }
 
 static void ahci_fill_sg(struct ata_queued_cmd *qc)
===== drivers/scsi/libata-core.c 1.120 vs edited =====
--- 1.120/drivers/scsi/libata-core.c	2005-02-22 21:19:40 -05:00
+++ edited/drivers/scsi/libata-core.c	2005-02-22 21:45:16 -05:00
@@ -377,7 +377,7 @@
 }
 
 /**
- *	ata_check_status - Read device status reg & clear interrupt
+ *	ata_check_status_pio - Read device status reg & clear interrupt
  *	@ap: port where the device is
  *
  *	Reads ATA taskfile status register for currently-selected device
@@ -415,6 +415,27 @@
 	return ata_check_status_pio(ap);
 }
 
+u8 ata_altstatus(struct ata_port *ap)
+{
+	if (ap->ops->check_altstatus)
+		return ap->ops->check_altstatus(ap);
+
+	if (ap->flags & ATA_FLAG_MMIO)
+		return readb((void __iomem *)ap->ioaddr.altstatus_addr);
+	return inb(ap->ioaddr.altstatus_addr);
+}
+
+u8 ata_chk_err(struct ata_port *ap)
+{
+	if (ap->ops->check_err)
+		return ap->ops->check_err(ap);
+
+	if (ap->flags & ATA_FLAG_MMIO) {
+		return readb((void __iomem *) ap->ioaddr.error_addr);
+	}
+	return inb(ap->ioaddr.error_addr);
+}
+
 /**
  *	ata_tf_to_fis - Convert ATA taskfile to SATA FIS structure
  *	@tf: Taskfile to convert
@@ -1161,7 +1182,6 @@
 	printk(KERN_WARNING "ata%u: dev %u not supported, ignoring\n",
 	       ap->id, device);
 err_out:
-	ata_irq_on(ap);	/* re-enable interrupts */
 	dev->class++;	/* converts ATA_DEV_xxx into ATA_DEV_xxx_UNSUP */
 	DPRINTK("EXIT, err\n");
 }
@@ -1669,7 +1689,8 @@
 		ata_dev_try_classify(ap, 1);
 
 	/* re-enable interrupts */
-	ata_irq_on(ap);
+	if (ap->ioaddr.ctl_addr)	/* FIXME: hack. create a hook instead */
+		ata_irq_on(ap);
 
 	/* is double-select really necessary? */
 	if (ap->device[1].class != ATA_DEV_NONE)
@@ -3972,6 +3993,8 @@
 EXPORT_SYMBOL_GPL(ata_tf_to_fis);
 EXPORT_SYMBOL_GPL(ata_tf_from_fis);
 EXPORT_SYMBOL_GPL(ata_check_status);
+EXPORT_SYMBOL_GPL(ata_altstatus);
+EXPORT_SYMBOL_GPL(ata_chk_err);
 EXPORT_SYMBOL_GPL(ata_exec_command);
 EXPORT_SYMBOL_GPL(ata_port_start);
 EXPORT_SYMBOL_GPL(ata_port_stop);
===== include/linux/libata.h 1.64 vs edited =====
--- 1.64/include/linux/libata.h	2005-02-17 19:29:16 -05:00
+++ edited/include/linux/libata.h	2005-02-22 21:37:02 -05:00
@@ -334,6 +334,8 @@
 
 	void (*exec_command)(struct ata_port *ap, struct ata_taskfile *tf);
 	u8   (*check_status)(struct ata_port *ap);
+	u8   (*check_altstatus)(struct ata_port *ap);
+	u8   (*check_err)(struct ata_port *ap);
 	void (*dev_select)(struct ata_port *ap, unsigned int device);
 
 	void (*phy_reset) (struct ata_port *ap);
@@ -403,6 +405,8 @@
 extern void ata_noop_dev_select (struct ata_port *ap, unsigned int device);
 extern void ata_std_dev_select (struct ata_port *ap, unsigned int device);
 extern u8 ata_check_status(struct ata_port *ap);
+extern u8 ata_altstatus(struct ata_port *ap);
+extern u8 ata_chk_err(struct ata_port *ap);
 extern void ata_exec_command(struct ata_port *ap, struct ata_taskfile *tf);
 extern int ata_port_start (struct ata_port *ap);
 extern void ata_port_stop (struct ata_port *ap);
@@ -457,24 +461,9 @@
 		(dev->class == ATA_DEV_ATAPI));
 }
 
-static inline u8 ata_chk_err(struct ata_port *ap)
-{
-	if (ap->flags & ATA_FLAG_MMIO) {
-		return readb((void __iomem *) ap->ioaddr.error_addr);
-	}
-	return inb(ap->ioaddr.error_addr);
-}
-
 static inline u8 ata_chk_status(struct ata_port *ap)
 {
 	return ap->ops->check_status(ap);
-}
-
-static inline u8 ata_altstatus(struct ata_port *ap)
-{
-	if (ap->flags & ATA_FLAG_MMIO)
-		return readb((void __iomem *)ap->ioaddr.altstatus_addr);
-	return inb(ap->ioaddr.altstatus_addr);
 }
 
 static inline void ata_pause(struct ata_port *ap)

--------------020200070309000608060106--
