Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262605AbUFVMEh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262605AbUFVMEh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 08:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262909AbUFVMEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 08:04:33 -0400
Received: from smtp08.web.de ([217.72.192.226]:57822 "EHLO smtp08.web.de")
	by vger.kernel.org with ESMTP id S262605AbUFVMEB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 08:04:01 -0400
From: Bernd Schubert <bernd-schubert@web.de>
To: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: 2.6.7 error message (oops)
Date: Tue, 22 Jun 2004 14:03:16 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com, netdev@oss.sgi.com
References: <E1Bcioi-000388-00@gondolin.me.apana.org.au>
In-Reply-To: <E1Bcioi-000388-00@gondolin.me.apana.org.au>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_KAC2AnwKo52MMms"
Message-Id: <200406221403.22890.bernd-schubert@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_KAC2AnwKo52MMms
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 22 June 2004 12:47, Herbert Xu wrote:
> Bernd Schubert <bernd-schubert@web.de> wrote:
> > I just booted 2.6.7 on one of our systems and see this oops from dmesg:
> >
> > eth11: network connection down
> > Debug: sleeping function called from invalid context at
> > include/asm/semaphore.h:119
> > in_atomic():0, irqs_disabled():1
> > [<c01072ae>] dump_stack+0x1e/0x20
> > [<c0121690>] __might_sleep+0xb0/0xe0
> > [<c0433ecb>] netdev_run_todo+0x2b/0x290
> > [<c04338e9>] dev_ioctl+0x269/0x300
> > [<c0476e0c>] inet_ioctl+0x8c/0xa0
> > [<c04292c8>] sock_ioctl+0x138/0x350
> > [<c017e2b4>] sys_ioctl+0x144/0x2d0
> > [<c01063bf>] syscall_call+0x7/0xb
> >
> > The device eth11 is the (ifrename) mapped eth1:
> >
> > sk98lin: Network Device Driver v6.23
>
> OK the locking in this driver needs to be reviewed and simplified.
>
> In this case it's doing two spin_lock_irqsave() calls in a row on the
> same flags variable.
>
> Does this patch fix your problem?
>

Thanks a lot, your patch fixed this problem! Though I had to apply it 
manually, since patch somehow didn't like it. Maybe it got broken when you 
sent the mail?

Attached is the re-diffed patch (looks completely identical to me, but diff 
says the whitespace is different):


Thanks,
	Bernd



--Boundary-00=_KAC2AnwKo52MMms
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="diff.out"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff.out"

--- skge.c.bak	Tue Jun 22 13:13:51 2004
+++ skge.c	Tue Jun 22 13:30:40 2004
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

--Boundary-00=_KAC2AnwKo52MMms--
