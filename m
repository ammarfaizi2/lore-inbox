Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262587AbSJBUES>; Wed, 2 Oct 2002 16:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262589AbSJBUES>; Wed, 2 Oct 2002 16:04:18 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:12307 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S262587AbSJBUER>; Wed, 2 Oct 2002 16:04:17 -0400
Message-Id: <200210022005.g92K5Fp31816@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: linux-kernel@vger.kernel.org
Subject: [PATCH] cli()/sti() fix for drivers/net/depca.c
Date: Wed, 2 Oct 2002 22:58:50 -0200
X-Mailer: KMail [version 1.3.2]
Cc: Andrew Morton <akpm@zip.com.au>, Jeff Garzik <jgarzik@mandrakesoft.com>,
       "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These are my first patches for network drivers.
Please comment if I'm doing something wrong.
Compile tested. Testers with hw wanted.
--
vda

diff -u --recursive linux-2.5.38orig/drivers/net/depca.c linux-2.5.38/drivers/net/depca.c
--- linux-2.5.38orig/drivers/net/depca.c	Sun Sep 22 04:25:10 2002
+++ linux-2.5.38/drivers/net/depca.c	Wed Oct  2 01:16:57 2002
@@ -1910,6 +1910,7 @@
   struct depca_ioctl *ioc = (struct depca_ioctl *) &rq->ifr_data;
   int i, status = 0;
   u_long ioaddr = dev->base_addr;
+  unsigned long flags;
   union {
     u8  addr[(HASH_TABLE_LEN * ETH_ALEN)];
     u16 sval[(HASH_TABLE_LEN * ETH_ALEN) >> 1];
@@ -1999,18 +2000,19 @@
     break;

   case DEPCA_GET_STATS:              /* Get the driver statistics */
-    cli();
+
+    spin_lock_irqsave(&lp->lock, flags);
     ioc->len = sizeof(lp->pktStats);
     if (copy_to_user(ioc->data, &lp->pktStats, ioc->len))
       status = -EFAULT;
-    sti();
+    spin_unlock_irqrestore(&lp->lock, flags);
     break;

   case DEPCA_CLR_STATS:              /* Zero out the driver statistics */
     if (!capable(CAP_NET_ADMIN)) return -EPERM;
-    cli();
+    spin_lock_irqsave(&lp->lock, flags);
     memset(&lp->pktStats, 0, sizeof(lp->pktStats));
-    sti();
+    spin_unlock_irqrestore(&lp->lock, flags);
     break;

   case DEPCA_GET_REG:                /* Get the DEPCA Registers */
