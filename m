Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262560AbTCRUPY>; Tue, 18 Mar 2003 15:15:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262567AbTCRUPY>; Tue, 18 Mar 2003 15:15:24 -0500
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:32153 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S262560AbTCRUPX>; Tue, 18 Mar 2003 15:15:23 -0500
Date: Tue, 18 Mar 2003 21:26:15 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Andrew Morton <akpm@digeo.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix nanosleep() granularity bumps
In-Reply-To: <Pine.LNX.4.33.0303181251130.28123-100000@gans.physik3.uni-rostock.de>
Message-ID: <Pine.LNX.4.33.0303182123510.30255-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Mar 2003, Tim Schmielau wrote:

> Please don't yet forward to Linus. After twisting my little brain a bit
> further, I see that the patch is still wrong if the lowest TVR_BITS of
> INITIAL_JIFFIES happen to be zero while others are not.

OK, this one looks ugly but should be correct, even in the case of a
partial timer cascade on the first timer interrupt:


--- linux-2.5.65/kernel/timer.c.orig	Tue Mar 18 13:02:39 2003
+++ linux-2.5.65/kernel/timer.c	Tue Mar 18 13:41:53 2003
@@ -1182,11 +1182,23 @@
 		INIT_LIST_HEAD(base->tv1.vec + j);

 	base->timer_jiffies = INITIAL_JIFFIES;
-	base->tv1.index = INITIAL_JIFFIES & TVR_MASK;
-	base->tv2.index = (INITIAL_JIFFIES >> TVR_BITS) & TVN_MASK;
-	base->tv3.index = (INITIAL_JIFFIES >> (TVR_BITS+TVN_BITS)) & TVN_MASK;
-	base->tv4.index = (INITIAL_JIFFIES >> (TVR_BITS+2*TVN_BITS)) & TVN_MASK;
-	base->tv5.index = (INITIAL_JIFFIES >> (TVR_BITS+3*TVN_BITS)) & TVN_MASK;
+	/*
+	 * The tv indices are always larger by one compared to the
+	 * respective parts of timer_jiffies. If all lower indices are
+	 * zero at initialisation, this is achieved by an (otherwise
+	 * unneccessary) invocation of the timer cascade on the first
+	 * timer interrupt. If not, we need to take it into account
+	 * here:
+	 */
+	j  = (base->tv1.index = INITIAL_JIFFIES & TVR_MASK) !=0;
+	j |= (base->tv2.index = ((INITIAL_JIFFIES >> TVR_BITS) + j)
+	                        & TVN_MASK) !=0;
+	j |= (base->tv3.index = ((INITIAL_JIFFIES >> (TVR_BITS+TVN_BITS)) + j)
+	                        & TVN_MASK) !=0;
+	j |= (base->tv4.index = ((INITIAL_JIFFIES >> (TVR_BITS+2*TVN_BITS)) + j)
+	                        & TVN_MASK) !=0;
+	      base->tv5.index = ((INITIAL_JIFFIES >> (TVR_BITS+3*TVN_BITS)) + j)
+	                        & TVN_MASK;
 }

 static int __devinit timer_cpu_notify(struct notifier_block *self,

