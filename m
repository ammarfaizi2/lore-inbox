Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbTHXOol (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 10:44:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261162AbTHXOol
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 10:44:41 -0400
Received: from [203.145.184.221] ([203.145.184.221]:13318 "EHLO naturesoft.net")
	by vger.kernel.org with ESMTP id S261152AbTHXOoj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 10:44:39 -0400
Subject: [PATCH 2.6.0-test4][NET] ni5010.c: remove cli/sti
From: Vinay K Nallamothu <vinay-rc@naturesoft.net>
To: netdev@oss.sgi.com
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-11) 
Date: 24 Aug 2003 20:37:04 +0530
Message-Id: <1061737624.1288.9.camel@lima.royalchallenge.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

drivers/net/ni5010.c:
This patch replaces cli/sti with spinlocks. Compiles fine though
untested.

Vinay

--- linux-2.6.0-test4/drivers/net/ni5010.c	2003-07-15 17:22:18.000000000 +0530
+++ linux-2.6.0-test4-nvk/drivers/net/ni5010.c	2003-08-24 20:29:35.000000000 +0530
@@ -96,6 +96,7 @@
 	struct net_device_stats stats;
 	int o_pkt_size;
 	int i_pkt_size;
+	spinlock_t tx_lock;
 };
 
 /* Index to functions, as function prototypes. */
@@ -280,11 +281,16 @@
 	/* DMA is not supported (yet?), so no use detecting it */
 
 	if (dev->priv == NULL) {
+		struct ni5010_local* lp;
+
 		dev->priv = kmalloc(sizeof(struct ni5010_local), GFP_KERNEL|GFP_DMA);
 		if (dev->priv == NULL) {
 			printk(KERN_WARNING "%s: Failed to allocate private memory\n", dev->name);
 			return -ENOMEM;
 		}
+
+		lp = (struct ni5010_local*)dev->priv;
+		spin_lock_init(&lp->tx_lock);
 	}
 
 	PRINTK2((KERN_DEBUG "%s: I/O #10 passed!\n", dev->name));
@@ -693,8 +699,7 @@
         buf_offs = NI5010_BUFSIZE - length - pad;
         lp->o_pkt_size = length + pad;
 
-	save_flags(flags);	
-	cli();
+	spin_lock_irqsave(&lp->tx_lock, flags);
 
 	outb(0, EDLC_RMASK);	/* Mask all receive interrupts */
 	outb(0, IE_MMODE);	/* Put Xmit buffer on system bus */
@@ -712,7 +717,7 @@
 	outb(MM_EN_XMT | MM_MUX, IE_MMODE); /* Begin transmission */
 	outb(XM_ALL, EDLC_XMASK); /* Cause interrupt after completion or fail */
 
-	restore_flags(flags);
+	spin_unlock_irqrestore(&lp->tx_lock, flags);
 
 	netif_wake_queue(dev);
 	


