Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264164AbTCXLzD>; Mon, 24 Mar 2003 06:55:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264165AbTCXLzD>; Mon, 24 Mar 2003 06:55:03 -0500
Received: from lucifer.fast.no ([217.144.236.33]:55700 "HELO lucifer.fast.no")
	by vger.kernel.org with SMTP id <S264164AbTCXLzC>;
	Mon, 24 Mar 2003 06:55:02 -0500
Date: Mon, 24 Mar 2003 13:06:04 +0100
From: Finn Arne Gangstad <Finn.Gangstad@fast.no>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Cc: Andrew Morton <akpm@digeo.com>, Vitezslav Samel <samel@mail.cz>,
       Matthew Wilcox <willy@debian.org>, Eric Piel <Eric.Piel@Bull.Net>,
       davidm@hpl.hp.com, linux-ia64@linuxia64.org,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix nanosleep() granularity bumps
Message-ID: <20030324120604.GA3004@fast.no>
References: <Pine.LNX.4.33.0303172033150.25119-100000@gans.physik3.uni-rostock.de> <Pine.LNX.4.33.0303180954330.27487-100000@gans.physik3.uni-rostock.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0303180954330.27487-100000@gans.physik3.uni-rostock.de>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 18, 2003 at 10:05:56AM +0100, Tim Schmielau wrote:
> On Mon, 17 Mar 2003, Tim Schmielau wrote:
> 
> > I've re-checked that the problem does not occur with the original "initial
> > jiffies" patch for 2.4.
> 
> Stupid me - 2.4 with the patch has the same problem, it just takes 10x as
> long to show up, a range that was not covered by the testcase.
> 
> 
> The actual problem is that I didn't fully understand the, well,
> 'elaborated' way of counting jiffies in the timer cascade:
> 
> When starting out with timer_jiffies=0, the timer cascade is
> (unneccessarily) triggered on the first timer interrupt, incrementing all
> the higher indices.
> When starting with any other initial jiffies value, we miss that and end
> up with all higher indices being off by one.

Suggest the attached patch as a fix instead - easier to understand I
think and works for every possible start value. This is what I made for
Andrea Arcangeli many years ago...

diff -ur linux-2.5.65/kernel/timer.c linux-2.5.65-new/kernel/timer.c
--- linux-2.5.65/kernel/timer.c	2003-03-17 22:44:41.000000000 +0100
+++ linux-2.5.65-new/kernel/timer.c	2003-03-24 12:57:31.000000000 +0100
@@ -1182,11 +1182,14 @@
 		INIT_LIST_HEAD(base->tv1.vec + j);
 
 	base->timer_jiffies = INITIAL_JIFFIES;
-	base->tv1.index = INITIAL_JIFFIES & TVR_MASK;
-	base->tv2.index = (INITIAL_JIFFIES >> TVR_BITS) & TVN_MASK;
-	base->tv3.index = (INITIAL_JIFFIES >> (TVR_BITS+TVN_BITS)) & TVN_MASK;
-	base->tv4.index = (INITIAL_JIFFIES >> (TVR_BITS+2*TVN_BITS)) & TVN_MASK;
-	base->tv5.index = (INITIAL_JIFFIES >> (TVR_BITS+3*TVN_BITS)) & TVN_MASK;
+	base->tv1.index = (1 + (INITIAL_JIFFIES - 1)) & TVR_MASK;
+	base->tv2.index = (1 + ((INITIAL_JIFFIES - 1) >> TVR_BITS)) & TVN_MASK;
+	base->tv3.index = (1 + ((INITIAL_JIFFIES - 1)
+				>> (TVR_BITS + TVN_BITS))) & TVN_MASK;
+	base->tv4.index = (1 + ((INITIAL_JIFFIES - 1)
+				>> (TVR_BITS + 2 * TVN_BITS))) & TVN_MASK;
+	base->tv5.index = (1 + ((INITIAL_JIFFIES - 1)
+				>> (TVR_BITS + 3 * TVN_BITS))) & TVN_MASK;
 }
 	
 static int __devinit timer_cpu_notify(struct notifier_block *self, 


- Finn Arne
