Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261937AbSJIRoU>; Wed, 9 Oct 2002 13:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261935AbSJIRoU>; Wed, 9 Oct 2002 13:44:20 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:37903 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S261942AbSJIRnQ>; Wed, 9 Oct 2002 13:43:16 -0400
Message-Id: <200210091744.g99HiKp31184@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Adam Kropelin <akropel1@rochester.rr.com>
Subject: Re: Looking for testers with these NICs
Date: Wed, 9 Oct 2002 20:37:48 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <200210091637.g99Gbmp30784@Port.imtp.ilyichevsk.odessa.ua> <20021009171452.GA9682@www.kroptech.com>
In-Reply-To: <20021009171452.GA9682@www.kroptech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 October 2002 15:14, Adam Kropelin wrote:
> On Wed, Oct 09, 2002 at 07:31:17PM -0200, Denis Vlasenko wrote:
> > ewrk3.c
>
> I've got a few of these laying around. Send whatever patches you want
> tested and I'll give it a shot.

Please do your best in trying to break it, especially since you say you have
more than one. Can you plug them all in one box?

I'd suggest SMP/preempt heavy IO. Is there stress test software for NICs?
What is pktgen?
--
vda

diff -u --recursive linux-2.5.40org/drivers/net/ewrk3.c linux-2.5.40/drivers/net/ewrk3.c
--- linux-2.5.40org/drivers/net/ewrk3.c	Tue Oct  1 05:06:58 2002
+++ linux-2.5.40/drivers/net/ewrk3.c	Thu Oct  3 12:09:46 2002
@@ -930,6 +930,7 @@
 	spin_unlock(&lp->hw_lock);
 }

+/* Called with lp->hw_lock held */
 static int ewrk3_rx(struct net_device *dev)
 {
 	struct ewrk3_private *lp = (struct ewrk3_private *) dev->priv;
@@ -1055,8 +1056,9 @@
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
+		spin_lock_irqsave(&lp->hw_lock, flags);
+		memcpy(tmp_stats, &lp->pktStats, sizeof(lp->pktStats));
+		spin_unlock_irqrestore(&lp->hw_lock, flags);

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
