Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263198AbSJCIOE>; Thu, 3 Oct 2002 04:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263200AbSJCIOE>; Thu, 3 Oct 2002 04:14:04 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:41234 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S263198AbSJCIOC>; Thu, 3 Oct 2002 04:14:02 -0400
Message-Id: <200210030814.g938Ebp01657@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Francois Romieu <romieu@cogenit.fr>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cli()/sti() fix for drivers/net/ewrk3.c
Date: Thu, 3 Oct 2002 11:08:29 -0200
X-Mailer: KMail [version 1.3.2]
References: <200210022005.g92K5Gp31819@Port.imtp.ilyichevsk.odessa.ua> <20021002224559.B18518@fafner.intra.cogenit.fr>
In-Reply-To: <20021002224559.B18518@fafner.intra.cogenit.fr>
Cc: acme@conectiva.com.br, davies@maniac.ultranet.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2 October 2002 18:45, Francois Romieu wrote:
> Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> :
> [...]
>
> > diff -u --recursive linux-2.5.38orig/drivers/net/ewrk3.c
> > linux-2.5.38/drivers/net/ewrk3.c ---
> > linux-2.5.38orig/drivers/net/ewrk3.c	Sun Sep 22 04:25:09 2002 +++
> > linux-2.5.38/drivers/net/ewrk3.c	Wed Oct  2 01:29:31 2002
>
> [...]
>
> The remarks done for drivers/net/depca.c patch apply equally as well.

Fixes similar to depca.c applied :-)
Testers with hardware, anyone?
--
vda

diff -u --recursive linux-2.5.40org/drivers/net/ewrk3.c linux-2.5.40/drivers/net/ewrk3.c
--- linux-2.5.40org/drivers/net/ewrk3.c	Tue Oct  1 05:06:58 2002
+++ linux-2.5.40/drivers/net/ewrk3.c	Thu Oct  3 11:04:33 2002
@@ -930,6 +930,7 @@
 	spin_unlock(&lp->hw_lock);
 }
 
+/* Called with lp->lock held */
 static int ewrk3_rx(struct net_device *dev)
 {
 	struct ewrk3_private *lp = (struct ewrk3_private *) dev->priv;
@@ -1055,8 +1056,9 @@
 }
 
 /*
-   ** Buffer sent - check for TX buffer errors.
- */
+** Buffer sent - check for TX buffer errors.
+** Called with lp->lock held
+*/
 static int ewrk3_tx(struct net_device *dev)
 {
 	struct ewrk3_private *lp = (struct ewrk3_private *) dev->priv;
@@ -1631,6 +1633,7 @@
 	u_long iobase = dev->base_addr;
 	int i, j, status = 0;
 	u_char csr;
+	unsigned long flags;
 	union ewrk3_addr {
 		u_char addr[HASH_TABLE_LEN * ETH_ALEN];
 		u_short val[(HASH_TABLE_LEN * ETH_ALEN) >> 1];
@@ -1745,19 +1748,26 @@
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
+
+		spin_lock_irqsave(&lp->lock, flags);
+		memcpy(tmp_stats, &lp->pktStats, sizeof(lp->pktStats));
+		spin_unlock_irqrestore(&lp->lock, flags);
 
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
