Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268578AbTCCQtA>; Mon, 3 Mar 2003 11:49:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268582AbTCCQs7>; Mon, 3 Mar 2003 11:48:59 -0500
Received: from zmamail01.zma.compaq.com ([161.114.64.101]:55056 "EHLO
	zmamail01.zma.compaq.com") by vger.kernel.org with ESMTP
	id <S268578AbTCCQsq>; Mon, 3 Mar 2003 11:48:46 -0500
Date: Mon, 3 Mar 2003 11:02:39 +0600
From: Stephen Cameron <steve.cameron@hp.com>
To: linux-kernel@vger.kernel.org
Cc: torben.mathiasen@hp.com, akpm@digeo.com
Subject: [PATCH] 2.5.63 cciss fix initialization for PCI hotplug
Message-ID: <20030303050239.GA840@zuul.cca.cpqcorp.net>
Reply-To: steve.cameron@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Fix driver to wait for firmware to indicate that it is ready.
  (Needed for PCI hotplug case, but for normal warm/cold reboot, by the
  time driver inits, firmware will already be ready.)

(Torben, I made one tiny change to remove the "ready" variable since
 the last time you saw this patch.)

-- steve

--- linux-2.5.63/drivers/block/cciss.c~hotplug_wait	2003-02-28 14:16:09.000000000 +0600
+++ linux-2.5.63-root/drivers/block/cciss.c	2003-03-03 10:58:56.000000000 +0600
@@ -2076,7 +2076,7 @@ static int cciss_pci_init(ctlr_info_t *c
 	unchar cache_line_size, latency_timer;
 	unchar irq, revision;
 	uint addr[6];
-	__u32 board_id;
+	__u32 board_id, scratchpad;
 	int cfg_offset;
 	int cfg_base_addr;
 	int cfg_base_addr_index;
@@ -2168,6 +2168,20 @@ static int cciss_pci_init(ctlr_info_t *c
 #endif /* CCISS_DEBUG */ 
 	c->vaddr = remap_pci_mem(c->paddr, 200);
 
+	/* Wait for the board to become ready.  (PCI hotplug needs this.)
+	 * We poll for up to 120 secs, once per 100ms. */
+	for (i=0; i < 1200; i++) {
+		scratchpad = readl(c->vaddr + SA5_SCRATCHPAD_OFFSET);
+		if (scratchpad == CCISS_FIRMWARE_READY)
+			break;
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule_timeout(HZ / 10); /* wait 100ms */
+	}
+	if (scratchpad != CCISS_FIRMWARE_READY) {
+		printk(KERN_WARNING "cciss: Board not ready.  Timed out.\n");
+		return -1;
+	}
+
 	/* get the address index number */
 	cfg_base_addr = readl(c->vaddr + SA5_CTCFG_OFFSET);
 	/* I am not prepared to deal with a 64 bit address value */
--- linux-2.5.63/drivers/block/cciss.h~hotplug_wait	2003-02-28 14:16:09.000000000 +0600
+++ linux-2.5.63-root/drivers/block/cciss.h	2003-03-03 10:42:36.000000000 +0600
@@ -95,6 +95,7 @@ struct ctlr_info 
 #define SA5_REPLY_INTR_MASK_OFFSET	0x34
 #define SA5_REPLY_PORT_OFFSET		0x44
 #define SA5_INTR_STATUS		0x30
+#define SA5_SCRATCHPAD_OFFSET	0xB0
 
 #define SA5_CTCFG_OFFSET	0xB4
 #define SA5_CTMEM_OFFSET	0xB8
@@ -104,6 +105,7 @@ struct ctlr_info 
 #define SA5_INTR_PENDING	0x08
 #define SA5B_INTR_PENDING	0x04
 #define FIFO_EMPTY		0xffffffff	
+#define CCISS_FIRMWARE_READY	0xffff0000 /* value in scratchpad register */
 
 #define  CISS_ERROR_BIT		0x02
 

_
