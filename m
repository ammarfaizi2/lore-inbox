Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263805AbTDGXWO (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 19:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263817AbTDGXOS (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 19:14:18 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:57984
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263807AbTDGXFD (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 19:05:03 -0400
Date: Tue, 8 Apr 2003 01:23:59 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200304080023.h380NxWg009095@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: fix arcnet locking for 2.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/drivers/net/arcnet/arcnet.c linux-2.5.67-ac1/drivers/net/arcnet/arcnet.c
--- linux-2.5.67/drivers/net/arcnet/arcnet.c	2003-02-10 18:38:45.000000000 +0000
+++ linux-2.5.67-ac1/drivers/net/arcnet/arcnet.c	2003-04-04 18:43:08.000000000 +0100
@@ -80,6 +80,7 @@
 	null_prepare_tx
 };
 
+static spinlock_t arcnet_lock = SPIN_LOCK_UNLOCKED;
 
 /* Exported function prototypes */
 int arcnet_debug = ARCNET_DEBUG;
@@ -186,10 +187,7 @@
 void arcnet_dump_skb(struct net_device *dev, struct sk_buff *skb, char *desc)
 {
 	int i;
-	unsigned long flags;
 
-	save_flags(flags);
-	cli();
 	printk(KERN_DEBUG "%6s: skb dump (%s) follows:", dev->name, desc);
 	for (i = 0; i < skb->len; i++) {
 		if (i % 16 == 0)
@@ -197,7 +195,6 @@
 		printk("%02X ", ((u_char *) skb->data)[i]);
 	}
 	printk("\n");
-	restore_flags(flags);
 }
 
 EXPORT_SYMBOL(arcnet_dump_skb);
@@ -215,10 +212,11 @@
 	unsigned long flags;
 	static uint8_t buf[512];
 
-	save_flags(flags);
-	cli();
-
+	/* hw.copy_from_card expects IRQ context so take the IRQ lock
+	   to keep it single threaded */
+	spin_lock_irqsave(&arcnet_lock, flags);
 	lp->hw.copy_from_card(dev, bufnum, 0, buf, 512);
+	spin_unlock_irqrestore(&arcnet_lock, flags);
 
 	/* if the offset[0] byte is nonzero, this is a 256-byte packet */
 	length = (buf[2] ? 256 : 512);
@@ -231,7 +229,6 @@
 	}
 	printk("\n");
 
-	restore_flags(flags);
 }
 
 EXPORT_SYMBOL(arcnet_dump_packet);
@@ -670,9 +667,7 @@
 	int status = ASTATUS();
 	char *msg;
 
-	save_flags(flags);
-	cli();
-
+	spin_lock_irqsave(&arcnet_lock, flags);
 	if (status & TXFREEflag) {	/* transmit _DID_ finish */
 		msg = " - missed IRQ?";
 	} else {
@@ -687,8 +682,8 @@
 	AINTMASK(0);
 	lp->intmask |= TXFREEflag;
 	AINTMASK(lp->intmask);
-
-	restore_flags(flags);
+	
+	spin_unlock_irqrestore(&arcnet_lock, flags);
 
 	if (jiffies - lp->last_timeout > 10*HZ) {
 		BUGMSG(D_EXTRA, "tx timed out%s (status=%Xh, intmask=%Xh, dest=%02Xh)\n",
@@ -714,17 +709,14 @@
 
 	BUGMSG(D_DURING, "\n");
 
-	if (dev == NULL) {
-		BUGMSG(D_DURING, "arcnet: irq %d for unknown device.\n", irq);
-		return;
-	}
 	BUGMSG(D_DURING, "in arcnet_interrupt\n");
 
+	spin_lock(&arcnet_lock);
+	
 	lp = (struct arcnet_local *) dev->priv;
-	if (!lp) {
-		BUGMSG(D_DURING, "arcnet: irq ignored due to missing lp.\n");
-		return;
-	}
+	if (!lp)
+		BUG();
+		
 	/*
 	 * RESET flag was enabled - if device is not running, we must clear it right
 	 * away (but nothing else).
@@ -733,6 +725,7 @@
 		if (ASTATUS() & RESETflag)
 			ACOMMAND(CFLAGScmd | RESETclear);
 		AINTMASK(0);
+		spin_unlock(&arcnet_lock);
 		return;
 	}
 
@@ -899,6 +892,8 @@
 	AINTMASK(0);
 	udelay(1);
 	AINTMASK(lp->intmask);
+	
+	spin_unlock(&arcnet_lock);
 }
 
 
