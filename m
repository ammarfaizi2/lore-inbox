Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262062AbUFVKsa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbUFVKsa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 06:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262079AbUFVKs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 06:48:29 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:16655 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S262062AbUFVKsZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 06:48:25 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: bernd-schubert@web.de (Bernd Schubert)
Subject: Re: 2.6.7 error message (oops)
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com, netdev@oss.sgi.com
Organization: Core
In-Reply-To: <200406212238.49959.bernd-schubert@web.de>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.26-1-686-smp (i686))
Message-Id: <E1Bcioi-000388-00@gondolin.me.apana.org.au>
Date: Tue, 22 Jun 2004 20:47:53 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd Schubert <bernd-schubert@web.de> wrote:
> 
> I just booted 2.6.7 on one of our systems and see this oops from dmesg:
> 
> eth11: network connection down
> Debug: sleeping function called from invalid context at 
> include/asm/semaphore.h:119
> in_atomic():0, irqs_disabled():1
> [<c01072ae>] dump_stack+0x1e/0x20
> [<c0121690>] __might_sleep+0xb0/0xe0
> [<c0433ecb>] netdev_run_todo+0x2b/0x290
> [<c04338e9>] dev_ioctl+0x269/0x300
> [<c0476e0c>] inet_ioctl+0x8c/0xa0
> [<c04292c8>] sock_ioctl+0x138/0x350
> [<c017e2b4>] sys_ioctl+0x144/0x2d0
> [<c01063bf>] syscall_call+0x7/0xb
> 
> The device eth11 is the (ifrename) mapped eth1:
> 
> sk98lin: Network Device Driver v6.23

OK the locking in this driver needs to be reviewed and simplified.

In this case it's doing two spin_lock_irqsave() calls in a row on the
same flags variable.

Does this patch fix your problem?

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
--
Index: drivers/net/sk98lin/skge.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/drivers/net/sk98lin/skge.c,v
retrieving revision 1.1.1.17
diff -u -r1.1.1.17 skge.c
--- drivers/net/sk98lin/skge.c	10 May 2004 09:47:55 -0000	1.1.1.17
+++ drivers/net/sk98lin/skge.c	22 Jun 2004 10:45:23 -0000
@@ -3093,8 +3093,7 @@
 	SkEventDispatcher(pAC, pAC->IoBase);
 
 	for (i=0; i<pAC->GIni.GIMacsFound; i++) {
-		spin_lock_irqsave(
-			&pAC->TxPort[i][TX_PRIO_LOW].TxDesRingLock, Flags);
+		spin_lock(&pAC->TxPort[i][TX_PRIO_LOW].TxDesRingLock);
 		netif_stop_queue(pAC->dev[i]);
 
 	}
@@ -4773,12 +4772,10 @@
 		spin_lock_irqsave(
 			&pAC->TxPort[FromPort][TX_PRIO_LOW].TxDesRingLock,
 			Flags);
-		spin_lock_irqsave(
-			&pAC->TxPort[ToPort][TX_PRIO_LOW].TxDesRingLock, Flags);
+		spin_lock(&pAC->TxPort[ToPort][TX_PRIO_LOW].TxDesRingLock);
 		SkGeStopPort(pAC, IoC, FromPort, SK_STOP_ALL, SK_SOFT_RST);
 		SkGeStopPort(pAC, IoC, ToPort, SK_STOP_ALL, SK_SOFT_RST);
-		spin_unlock_irqrestore(
-			&pAC->TxPort[ToPort][TX_PRIO_LOW].TxDesRingLock, Flags);
+		spin_unlock(&pAC->TxPort[ToPort][TX_PRIO_LOW].TxDesRingLock);
 		spin_unlock_irqrestore(
 			&pAC->TxPort[FromPort][TX_PRIO_LOW].TxDesRingLock,
 			Flags);
@@ -4791,8 +4788,7 @@
 		spin_lock_irqsave(
 			&pAC->TxPort[FromPort][TX_PRIO_LOW].TxDesRingLock,
 			Flags);
-		spin_lock_irqsave(
-			&pAC->TxPort[ToPort][TX_PRIO_LOW].TxDesRingLock, Flags);
+		spin_lock(&pAC->TxPort[ToPort][TX_PRIO_LOW].TxDesRingLock);
 		pAC->ActivePort = ToPort;
 #if 0
 		SetQueueSizes(pAC);
@@ -4807,8 +4803,7 @@
 			pAC,
 			pAC->ActivePort,
 			DualNet)) {
-			spin_unlock_irqrestore(
-				&pAC->TxPort[ToPort][TX_PRIO_LOW].TxDesRingLock, Flags);
+			spin_unlock(&pAC->TxPort[ToPort][TX_PRIO_LOW].TxDesRingLock);
 			spin_unlock_irqrestore(
 				&pAC->TxPort[FromPort][TX_PRIO_LOW].TxDesRingLock,
 				Flags);
@@ -4834,8 +4829,7 @@
 		SkGePollTxD(pAC, IoC, ToPort, SK_TRUE);
 		ClearAndStartRx(pAC, FromPort);
 		ClearAndStartRx(pAC, ToPort);
-		spin_unlock_irqrestore(
-			&pAC->TxPort[ToPort][TX_PRIO_LOW].TxDesRingLock, Flags);
+		spin_unlock(&pAC->TxPort[ToPort][TX_PRIO_LOW].TxDesRingLock);
 		spin_unlock_irqrestore(
 			&pAC->TxPort[FromPort][TX_PRIO_LOW].TxDesRingLock,
 			Flags);
