Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262009AbTLPX4j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 18:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262331AbTLPX4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 18:56:39 -0500
Received: from ztxmail03.ztx.compaq.com ([161.114.1.207]:24584 "EHLO
	ztxmail03.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S262009AbTLPX4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 18:56:31 -0500
Date: Tue, 16 Dec 2003 17:57:33 -0600 (CST)
From: mikem@beardog.cca.cpqcorp.net
To: axboe@suse.de, marcelo.tosatti@cyclades.com
Cc: linux-kernel@vger.kernel.org, mike.miller@hp.com, scott.benesh@hp.com
Subject: cciss update for 2.4.24-pre1, 2 of 2
Message-ID: <Pine.LNX.4.58.0312161750290.30010@beardog.cca.cpqcorp.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some older cciss controllers may take a long time to become ready after
hot replacing the controller. This patch addresses that problem by adding
a check of the scratchpad register. This patch is intended to supplement
the monitor thread when cciss is used in an md environment. In the event
of a controller failure the failed board can now be more reliably
replaced. This is patch #2 of 2.
Please consider this patch for inclusion in the 2.4.24 kernel.

Thanks,
mikem
mike.miller@hp.com
------------------------------------------------------------------------------
diff -burN lx2424pre1-p01/drivers/block/cciss.c lx2424pre1/drivers/block/cciss.c
--- lx2424pre1-p01/drivers/block/cciss.c	2003-12-16 17:25:50.000000000 -0600
+++ lx2424pre1/drivers/block/cciss.c	2003-12-16 17:30:41.000000000 -0600
@@ -2537,8 +2537,8 @@
 static int cciss_pci_init(ctlr_info_t *c, struct pci_dev *pdev)
 {
 	ushort subsystem_vendor_id, subsystem_device_id, command;
-	unchar irq = pdev->irq;
-	__u32 board_id;
+	unchar irq = pdev->irq, revision, ready = 0;
+	__u32 board_id, scratchpad;
 	__u64 cfg_offset;
 	__u32 cfg_base_addr;
 	__u64 cfg_base_addr_index;
@@ -2609,6 +2609,21 @@
 	printk("address 0 = %x\n", c->paddr);
 #endif /* CCISS_DEBUG */
 	c->vaddr = remap_pci_mem(c->paddr, 200);
+	/* Wait for the board to become ready.  (PCI hotplug needs this.)
+	 * We poll for up to 120 secs, once per 100ms. */
+	for (i=0; i < 1200; i++) {
+		scratchpad = readl(c->vaddr + SA5_SCRATCHPAD_OFFSET);
+		if (scratchpad == 0xffff0000) {
+			ready = 1;
+			break;
+		}
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule_timeout(HZ / 10); /* wait 100ms */
+	}
+	if (!ready) {
+		printk(KERN_WARNING "cciss: Board not ready.  Timed out.\n");
+		return -1;
+	}

 	/* get the address index number */
 	cfg_base_addr = readl(c->vaddr + SA5_CTCFG_OFFSET);
diff -burN lx2424pre1-p01/drivers/block/cciss.h lx2424pre1/drivers/block/cciss.h
--- lx2424pre1-p01/drivers/block/cciss.h	2003-11-28 12:26:19.000000000 -0600
+++ lx2424pre1/drivers/block/cciss.h	2003-12-16 17:30:41.000000000 -0600
@@ -137,6 +137,7 @@
 #define SA5_REPLY_INTR_MASK_OFFSET	0x34
 #define SA5_REPLY_PORT_OFFSET		0x44
 #define SA5_INTR_STATUS		0x30
+#define SA5_SCRATCHPAD_OFFSET	0xB0

 #define SA5_CTCFG_OFFSET	0xB4
 #define SA5_CTMEM_OFFSET	0xB8
------------------------------------------------------------------------------
