Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262650AbUBYH2M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 02:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262658AbUBYH2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 02:28:12 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61405 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262650AbUBYH2A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 02:28:00 -0500
Message-ID: <403C4E73.9030805@pobox.com>
Date: Wed, 25 Feb 2004 02:27:47 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
CC: linux-ide@vger.kernel.org
Subject: [PATCH] fix Silicon Image SATA 4-port support
Content-Type: multipart/mixed;
 boundary="------------080909060405070407040203"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080909060405070407040203
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Do not be fooled, Silicon Image is still marked CONFIG_BROKEN for a 
reason...  :)  But this should (hopefully!) get 4-port support going.

Testing requested...



--------------080909060405070407040203
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

===== drivers/scsi/sata_sil.c 1.7 vs edited =====
--- 1.7/drivers/scsi/sata_sil.c	Wed Jan 14 18:34:44 2004
+++ edited/drivers/scsi/sata_sil.c	Wed Feb 25 02:24:24 2004
@@ -44,6 +44,11 @@
 	SIL_SYSCFG		= 0x48,
 	SIL_MASK_IDE0_INT	= (1 << 22),
 	SIL_MASK_IDE1_INT	= (1 << 23),
+	SIL_MASK_IDE2_INT	= (1 << 24),
+	SIL_MASK_IDE3_INT	= (1 << 25),
+	SIL_MASK_2PORT		= SIL_MASK_IDE0_INT | SIL_MASK_IDE1_INT,
+	SIL_MASK_4PORT		= SIL_MASK_2PORT |
+				  SIL_MASK_IDE2_INT | SIL_MASK_IDE3_INT,
 
 	SIL_IDE0_TF		= 0x80,
 	SIL_IDE0_CTL		= 0x8A,
@@ -59,6 +64,7 @@
 	SIL_IDE2_CTL		= 0x28A,
 	SIL_IDE2_BMDMA		= 0x200,
 	SIL_IDE2_SCR		= 0x300,
+	SIL_INTR_STEERING	= (1 << 1),
 
 	SIL_IDE3_TF		= 0x2C0,
 	SIL_IDE3_CTL		= 0x2CA,
@@ -304,7 +310,7 @@
 	unsigned long base;
 	void *mmio_base;
 	int rc;
-	u32 tmp;
+	u32 tmp, irq_mask;
 
 	if (!printed_version++)
 		printk(KERN_DEBUG DRV_NAME " version " DRV_VERSION "\n");
@@ -365,14 +371,6 @@
 	probe_ent->port[1].scr_addr = base + SIL_IDE1_SCR;
 	ata_std_ports(&probe_ent->port[1]);
 
-	/* make sure IDE0/1 interrupts are not masked */
-	tmp = readl(mmio_base + SIL_SYSCFG);
-	if (tmp & (SIL_MASK_IDE0_INT | SIL_MASK_IDE1_INT)) {
-		tmp &= ~(SIL_MASK_IDE0_INT | SIL_MASK_IDE1_INT);
-		writel(tmp, mmio_base + SIL_SYSCFG);
-		readl(mmio_base + SIL_SYSCFG);	/* flush */
-	}
-
 	if (ent->driver_data == sil_3114) {
 		probe_ent->port[2].cmd_addr = base + SIL_IDE2_TF;
 		probe_ent->port[2].ctl_addr = base + SIL_IDE2_CTL;
@@ -385,6 +383,25 @@
 		probe_ent->port[3].bmdma_addr = base + SIL_IDE3_BMDMA;
 		probe_ent->port[3].scr_addr = base + SIL_IDE3_SCR;
 		ata_std_ports(&probe_ent->port[3]);
+
+		irq_mask = SIL_MASK_4PORT;
+
+		/* flip the magic "make 4 ports work" bit */
+		tmp = readl(mmio_base + SIL_IDE2_BMDMA);
+		if ((tmp & SIL_INTR_STEERING) == 0)
+			writel(tmp | SIL_INTR_STEERING,
+			       mmio_base + SIL_IDE2_BMDMA);
+
+	} else {
+		irq_mask = SIL_MASK_2PORT;
+	}
+
+	/* make sure IDE0/1/2/3 interrupts are not masked */
+	tmp = readl(mmio_base + SIL_SYSCFG);
+	if (tmp & irq_mask) {
+		tmp &= ~irq_mask;
+		writel(tmp, mmio_base + SIL_SYSCFG);
+		readl(mmio_base + SIL_SYSCFG);	/* flush */
 	}
 
 	pci_set_master(pdev);

--------------080909060405070407040203--

