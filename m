Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263427AbTECV2O (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 17:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263428AbTECV2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 17:28:14 -0400
Received: from [12.47.58.20] ([12.47.58.20]:53258 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S263427AbTECV2M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 17:28:12 -0400
Date: Sat, 3 May 2003 14:41:52 -0700
From: Andrew Morton <akpm@digeo.com>
To: Kmt Sundqvist <rabbit80@mbnet.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.68-mm4 and 3c900 is a horror
Message-Id: <20030503144152.205e4dba.akpm@digeo.com>
In-Reply-To: <1571.194.100.165.159.1051990031.squirrel@webmail.mbnet.fi>
References: <20030502150402.26c4f3b3.akpm@digeo.com>
	<1571.194.100.165.159.1051990031.squirrel@webmail.mbnet.fi>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 May 2003 21:40:32.0625 (UTC) FILETIME=[9FA26610:01C311BC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kmt Sundqvist <rabbit80@mbnet.fi> wrote:
>
> > Kimmo Sundqvist <rabbit80@mbnet.fi> wrote:
> 
> >> May  2 20:34:10 minjami kernel: irq 19: nobody cared!
> 
> > Very odd.  How often does this happen?
> 
> Actually I was booting up for the first time with -mm4 as it happened. 
> The first 8 errors I copied verbatim, and the 22 that happened after the
> 8th but before the machine locked up I left out.  So my guess is that
> whatever happened there, happened every time.

Well I don't see anything wrong in there, but this should shut it up for you.

diff -puN drivers/net/3c59x.c~3c59x-irq-fix drivers/net/3c59x.c
--- 25/drivers/net/3c59x.c~3c59x-irq-fix	2003-05-03 14:39:17.000000000 -0700
+++ 25-akpm/drivers/net/3c59x.c	2003-05-03 14:39:50.000000000 -0700
@@ -2321,7 +2321,6 @@ boomerang_interrupt(int irq, void *dev_i
 	long ioaddr;
 	int status;
 	int work_done = max_interrupt_work;
-	int handled;
 
 	ioaddr = dev->base_addr;
 
@@ -2336,18 +2335,14 @@ boomerang_interrupt(int irq, void *dev_i
 	if (vortex_debug > 6)
 		printk(KERN_DEBUG "boomerang_interrupt. status=0x%4x\n", status);
 
-	if ((status & IntLatch) == 0) {
-		handled = 0;
+	if ((status & IntLatch) == 0)
 		goto handler_exit;		/* No interrupt: shared IRQs can cause this */
-	}
 
 	if (status == 0xffff) {		/* h/w no longer present (hotplug)? */
 		if (vortex_debug > 1)
 			printk(KERN_DEBUG "boomerang_interrupt(1): status = 0xffff\n");
-		handled = 0;
 		goto handler_exit;
 	}
-	handled = 1;
 
 	if (status & IntReq) {
 		status |= vp->deferred;
@@ -2442,7 +2437,7 @@ boomerang_interrupt(int irq, void *dev_i
 			   dev->name, status);
 handler_exit:
 	spin_unlock(&vp->lock);
-	return IRQ_RETVAL(handled);
+	return IRQ_HANDLED;
 }
 
 static int vortex_rx(struct net_device *dev)

_

