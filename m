Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265471AbSJSCHn>; Fri, 18 Oct 2002 22:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265473AbSJSCHn>; Fri, 18 Oct 2002 22:07:43 -0400
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:59128 "EHLO
	www.kroptech.com") by vger.kernel.org with ESMTP id <S265471AbSJSCHm>;
	Fri, 18 Oct 2002 22:07:42 -0400
Date: Fri, 18 Oct 2002 22:13:40 -0400
From: Adam Kropelin <akropel1@rochester.rr.com>
To: jgarzik@pobox.com
Cc: VDA@port.imtp.ilyichevsk.odessa.ua, linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5: ewrk3 cli/sti removal by VDA
Message-ID: <20021019021340.GA8388@www.kroptech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Below is a patch from Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> which
removes cli/sti in the ewrk3 driver. It tests out fine here with SMP & preempt.

Applies against 2.5.34 + ewrk3-ethtool patch. Also applies without ethtool patch
with some offsets.

(Denis, I took the liberty of forwarding this to Jeff since it works fine for me
and the driver is pretty much useless without it. Scream if you don't want it
applied...)

--Adam
 
--- linux-2.5.43-mm1/drivers/net/ewrk3.c.orig	Fri Oct 18 21:55:44 2002
+++ linux-2.5.43-mm1/drivers/net/ewrk3.c	Fri Oct 18 22:02:41 2002
@@ -940,6 +940,7 @@
 	spin_unlock(&lp->hw_lock);
 }
 
+/* Called with lp->hw_lock held */
 static int ewrk3_rx(struct net_device *dev)
 {
 	struct ewrk3_private *lp = (struct ewrk3_private *) dev->priv;
@@ -1065,8 +1066,9 @@
 }
 
 /*
-   ** Buffer sent - check for TX buffer errors.
- */
+** Buffer sent - check for TX buffer errors.
+** Called with lp->hw_lock held
+*/
 static int ewrk3_tx(struct net_device *dev)
 {
 	struct ewrk3_private *lp = (struct ewrk3_private *) dev->priv;
@@ -1830,6 +1832,7 @@
 	u_long iobase = dev->base_addr;
 	int i, j, status = 0;
 	u_char csr;
+	unsigned long flags;
 	union ewrk3_addr {
 		u_char addr[HASH_TABLE_LEN * ETH_ALEN];
 		u_short val[(HASH_TABLE_LEN * ETH_ALEN) >> 1];
@@ -1953,19 +1956,26 @@
 		}
 
 		break;
-	case EWRK3_GET_STATS:	/* Get the driver statistics */
-		cli();
-		ioc->len = sizeof(lp->pktStats);
-		if (copy_to_user(ioc->data, &lp->pktStats, ioc->len))
-			status = -EFAULT;
-		sti();
+	case EWRK3_GET_STATS: { /* Get the driver statistics */
+		typeof(lp->pktStats) *tmp_stats =
+        		kmalloc(sizeof(lp->pktStats), GFP_KERNEL);
+		if (!tmp_stats) return -ENOMEM;
 
+		spin_lock_irqsave(&lp->hw_lock, flags);
+		memcpy(tmp_stats, &lp->pktStats, sizeof(lp->pktStats));
+		spin_unlock_irqrestore(&lp->hw_lock, flags);
+
+		ioc->len = sizeof(lp->pktStats);
+		if (copy_to_user(ioc->data, tmp_stats, sizeof(lp->pktStats)))
+    			status = -EFAULT;
+		kfree(tmp_stats);
 		break;
+	}
 	case EWRK3_CLR_STATS:	/* Zero out the driver statistics */
 		if (capable(CAP_NET_ADMIN)) {
-			cli();
+			spin_lock_irqsave(&lp->hw_lock, flags);
 			memset(&lp->pktStats, 0, sizeof(lp->pktStats));
-			sti();
+			spin_unlock_irqrestore(&lp->hw_lock,flags);
 		} else {
 			status = -EPERM;
 		}

