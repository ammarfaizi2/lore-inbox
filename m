Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263187AbSJCIAw>; Thu, 3 Oct 2002 04:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263189AbSJCIAw>; Thu, 3 Oct 2002 04:00:52 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:27666 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S263187AbSJCIAv>; Thu, 3 Oct 2002 04:00:51 -0400
Message-Id: <200210030801.g9381Vp01598@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Francois Romieu <romieu@cogenit.fr>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cli()/sti() fix for drivers/net/depca.c
Date: Thu, 3 Oct 2002 10:55:23 -0200
X-Mailer: KMail [version 1.3.2]
References: <200210022005.g92K5Fp31816@Port.imtp.ilyichevsk.odessa.ua> <200210022133.g92LX0p32156@Port.imtp.ilyichevsk.odessa.ua> <20021003001228.A18629@fafner.intra.cogenit.fr>
In-Reply-To: <20021003001228.A18629@fafner.intra.cogenit.fr>
Cc: acme@conectiva.com.br, peterd@pnd-pc.demon.co.uk
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2 October 2002 20:12, Francois Romieu wrote:
> Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> :
> [...]
>
> > Ho to do it properly? Make a copy on stack under lock, release
> > lock, proceed with copy_to_user? That's 88 bytes at least...
>
> Please see ETHTOOL_GSTATS usage in drivers/net/8139cp.c.
>
> > > - on SMP, pktStat can be updated while the copy progresses, see
> > > depca_rx().
> >
> > Should I place these pktStat updates under lp->lock?
>
> You may.

It's already under the lock: depca_rx is called from depca_interrupt
which acqures the lock.

New patch attached. Testers with hw wanted ;-)
--
vda

diff -u --recursive linux-2.5.40org/drivers/net/depca.c linux-2.5.40/drivers/net/depca.c
--- linux-2.5.40org/drivers/net/depca.c	Tue Oct  1 05:07:01 2002
+++ linux-2.5.40/drivers/net/depca.c	Thu Oct  3 10:52:09 2002
@@ -951,6 +951,7 @@
 }
 
 
+/* Called with lp->lock held */
 static int
 depca_rx(struct net_device *dev)
 {
@@ -1052,6 +1053,7 @@
 
 /*
 ** Buffer sent - check for buffer errors.
+** Called with lp->lock held
 */
 static int
 depca_tx(struct net_device *dev)
@@ -1910,6 +1912,7 @@
   struct depca_ioctl *ioc = (struct depca_ioctl *) &rq->ifr_data;
   int i, status = 0;
   u_long ioaddr = dev->base_addr;
+  unsigned long flags;
   union {
     u8  addr[(HASH_TABLE_LEN * ETH_ALEN)];
     u16 sval[(HASH_TABLE_LEN * ETH_ALEN) >> 1];
@@ -1998,19 +2001,27 @@
       set_multicast_list(dev);
     break;
 
-  case DEPCA_GET_STATS:              /* Get the driver statistics */
-    cli();
+  case DEPCA_GET_STATS: {            /* Get the driver statistics */
+    typeof(lp->pktStats) *tmp_stats =
+	    kmalloc(sizeof(lp->pktStats), GFP_KERNEL);
+    if (!tmp_stats) return -ENOMEM;
+
+    spin_lock_irqsave(&lp->lock, flags);
+    memcpy(tmp_stats, &lp->pktStats, sizeof(lp->pktStats));
+    spin_unlock_irqrestore(&lp->lock, flags);
+
     ioc->len = sizeof(lp->pktStats);
-    if (copy_to_user(ioc->data, &lp->pktStats, ioc->len))
+    if (copy_to_user(ioc->data, tmp_stats, sizeof(lp->pktStats)))
       status = -EFAULT;
-    sti();
+    kfree(tmp_stats);
     break;
+  }
 
   case DEPCA_CLR_STATS:              /* Zero out the driver statistics */
     if (!capable(CAP_NET_ADMIN)) return -EPERM;
-    cli();
+    spin_lock_irqsave(&lp->lock, flags);
     memset(&lp->pktStats, 0, sizeof(lp->pktStats));
-    sti();
+    spin_unlock_irqrestore(&lp->lock, flags);
     break;
 
   case DEPCA_GET_REG:                /* Get the DEPCA Registers */
