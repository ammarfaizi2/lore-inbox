Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262244AbTCRIzo>; Tue, 18 Mar 2003 03:55:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262258AbTCRIzo>; Tue, 18 Mar 2003 03:55:44 -0500
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:4242 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S262244AbTCRIzn>; Tue, 18 Mar 2003 03:55:43 -0500
Date: Tue, 18 Mar 2003 10:05:56 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Andrew Morton <akpm@digeo.com>, Vitezslav Samel <samel@mail.cz>
cc: Matthew Wilcox <willy@debian.org>, Eric Piel <Eric.Piel@Bull.Net>,
       <davidm@hpl.hp.com>, <linux-ia64@linuxia64.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix nanosleep() granularity bumps
In-Reply-To: <Pine.LNX.4.33.0303172033150.25119-100000@gans.physik3.uni-rostock.de>
Message-ID: <Pine.LNX.4.33.0303180954330.27487-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Mar 2003, Tim Schmielau wrote:

> I've re-checked that the problem does not occur with the original "initial
> jiffies" patch for 2.4.

Stupid me - 2.4 with the patch has the same problem, it just takes 10x as
long to show up, a range that was not covered by the testcase.


The actual problem is that I didn't fully understand the, well,
'elaborated' way of counting jiffies in the timer cascade:

When starting out with timer_jiffies=0, the timer cascade is
(unneccessarily) triggered on the first timer interrupt, incrementing all
the higher indices.
When starting with any other initial jiffies value, we miss that and end
up with all higher indices being off by one.

Fix is as follows:

--- linux-2.5.65/kernel/timer.c	Wed Mar  5 04:29:33 2003
+++ linux-2.5.65-jfix/kernel/timer.c	Tue Mar 18 09:40:13 2003
@@ -1183,10 +1183,14 @@

 	base->timer_jiffies = INITIAL_JIFFIES;
 	base->tv1.index = INITIAL_JIFFIES & TVR_MASK;
-	base->tv2.index = (INITIAL_JIFFIES >> TVR_BITS) & TVN_MASK;
-	base->tv3.index = (INITIAL_JIFFIES >> (TVR_BITS+TVN_BITS)) & TVN_MASK;
-	base->tv4.index = (INITIAL_JIFFIES >> (TVR_BITS+2*TVN_BITS)) & TVN_MASK;
-	base->tv5.index = (INITIAL_JIFFIES >> (TVR_BITS+3*TVN_BITS)) & TVN_MASK;
+	base->tv2.index = ((INITIAL_JIFFIES >> TVR_BITS)
+	                   + (INITIAL_JIFFIES!=0)) & TVN_MASK;
+	base->tv3.index = ((INITIAL_JIFFIES >> (TVR_BITS+TVN_BITS))
+	                   + (INITIAL_JIFFIES!=0)) & TVN_MASK;
+	base->tv4.index = ((INITIAL_JIFFIES >> (TVR_BITS+2*TVN_BITS))
+	                   + (INITIAL_JIFFIES!=0)) & TVN_MASK;
+	base->tv5.index = ((INITIAL_JIFFIES >> (TVR_BITS+3*TVN_BITS))
+	                   + (INITIAL_JIFFIES!=0)) & TVN_MASK;
 }

 static int __devinit timer_cpu_notify(struct notifier_block *self,


Sorry for all the trouble,
Tim

