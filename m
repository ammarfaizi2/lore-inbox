Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262588AbSJBUFR>; Wed, 2 Oct 2002 16:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262589AbSJBUEV>; Wed, 2 Oct 2002 16:04:21 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:12563 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S262588AbSJBUES>; Wed, 2 Oct 2002 16:04:18 -0400
Message-Id: <200210022005.g92K5Gp31819@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: linux-kernel@vger.kernel.org
Subject: [PATCH] cli()/sti() fix for drivers/net/ewrk3.c 
Date: Wed, 2 Oct 2002 22:59:01 -0200
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

diff -u --recursive linux-2.5.38orig/drivers/net/ewrk3.c linux-2.5.38/drivers/net/ewrk3.c
--- linux-2.5.38orig/drivers/net/ewrk3.c	Sun Sep 22 04:25:09 2002
+++ linux-2.5.38/drivers/net/ewrk3.c	Wed Oct  2 01:29:31 2002
@@ -1631,6 +1631,7 @@
 	u_long iobase = dev->base_addr;
 	int i, j, status = 0;
 	u_char csr;
+	unsigned long flags;
 	union ewrk3_addr {
 		u_char addr[HASH_TABLE_LEN * ETH_ALEN];
 		u_short val[(HASH_TABLE_LEN * ETH_ALEN) >> 1];
@@ -1746,18 +1747,18 @@

 		break;
 	case EWRK3_GET_STATS:	/* Get the driver statistics */
-		cli();
+		spin_lock_irqsave(&lp->hw_lock, flags);
 		ioc->len = sizeof(lp->pktStats);
 		if (copy_to_user(ioc->data, &lp->pktStats, ioc->len))
 			status = -EFAULT;
-		sti();
+		spin_unlock_irqrestore(&lp->hw_lock,flags);

 		break;
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
