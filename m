Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261372AbSJHXIb>; Tue, 8 Oct 2002 19:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261368AbSJHXIF>; Tue, 8 Oct 2002 19:08:05 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:32439 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261398AbSJHXHU>; Tue, 8 Oct 2002 19:07:20 -0400
Message-ID: <3DA36673.30702@us.ibm.com>
Date: Tue, 08 Oct 2002 16:12:51 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: oops in 2.5.41-bk in tasklet_hi_action
References: <20021008223044.GB10837@kroah.com>
Content-Type: multipart/mixed;
 boundary="------------090500090808080000060709"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090500090808080000060709
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Greg KH wrote:
> I got the following oops on 2.5.41 + latest bk tree as of 3 pm PST under
> heavy ide load:
> 
> It's a UP box running with SMP and preempt enabled.
> 
> Unable to handle kernel NULL pointer dereference at virtual address 00000004
> *pde = 00000000
> Oops: 0002
> hid uhci-hcd usbcore  
> CPU:    0
> EIP:    0060:[<c0125292>]    Not tainted
> EFLAGS: 00010016
> EIP is at run_timer_tasklet+0x102/0x220
 > <snip>
> Call Trace:
>  [<c01215c0>] tasklet_hi_action+0x80/0xd0
>  [<c01212bb>] do_softirq+0x5b/0xc0
>  [<c01114d1>] smp_apic_timer_interrupt+0x111/0x140
>  [<c0109b0f>] do_IRQ+0x18f/0x230
>  [<c0108256>] apic_timer_interrupt+0x1a/0x20

Notice that eip is actually in run_timer_tasklet and __run_timers is 
inlined there.  You're actually crashing in __run_timers, in the same 
place as me, before Ingo's fix.  Try the attached patch that I got 
from Ingo this morning.  There is still some kind of problem for me, 
but it might be a completely different one.

My oops is while running Specweb, so high interrupt load for me too.
-- 
Dave Hansen
haveblue@us.ibm.com

--------------090500090808080000060709
Content-Type: text/plain;
 name="run_timers_fix-ingo-0.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="run_timers_fix-ingo-0.patch"

Received: from localhost (nighthawk [127.0.0.1])
	by nighthawk.sr71.net (8.11.6/8.11.6) with ESMTP id g98AuLc12011
	for <dave@localhost>; Tue, 8 Oct 2002 03:56:24 -0700
Received: from imap.linux.ibm.com [9.27.103.44]
	by localhost with IMAP (fetchmail-5.9.0)
	for dave@localhost (multi-drop); Tue, 08 Oct 2002 03:56:24 -0700 (PDT)
Received: from localhost ([unix socket])
	by imap.linux.ibm.com (Cyrus v2.1.9) with LMTP; Tue, 08 Oct 2002 06:55:42 -0400
X-Sieve: CMU Sieve 2.2
Received: from smtp.linux.ibm.com (linux.ibm.com [9.26.4.197])
	by imap.linux.ibm.com (Postfix) with ESMTP id 401627C017
	for <haveblue@imap.linux.ibm.com>; Tue,  8 Oct 2002 06:55:42 -0400 (EDT)
Received: from northrelay03.pok.ibm.com (northrelay03.pok.ibm.com [9.56.224.151])
	by smtp.linux.ibm.com (Postfix) with ESMTP id 02E323FE06
	for <haveblue@linux.ibm.com>; Tue,  8 Oct 2002 06:55:34 -0400 (EDT)
Received: from e31.co.us.ibm.com (d03av01.boulder.ibm.com [9.17.193.81])
	by northrelay03.pok.ibm.com (8.12.3/NCO/VER6.4) with ESMTP id g98AtVqY080584
	for <haveblue@us.ibm.com>; Tue, 8 Oct 2002 06:55:32 -0400
Received: from mx1.elte.hu (mx1.elte.hu [157.181.1.137])
	by e31.co.us.ibm.com (8.12.2/8.12.2) with ESMTP id g98AtRAs034788
	for <haveblue@us.ibm.com>; Tue, 8 Oct 2002 06:55:31 -0400
Received: from chiara.elte.hu (chiara.elte.hu [157.181.150.200])
	by mx1.elte.hu (Postfix) with ESMTP
	id 08F0244732; Tue,  8 Oct 2002 12:55:11 +0200 (CEST)
Received: by chiara.elte.hu (Postfix, from userid 17806)
	id E70821FF1; Tue,  8 Oct 2002 12:54:44 +0200 (CEST)
Date: Tue, 8 Oct 2002 13:05:40 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Sender: mingo@localhost.localdomain
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Andrew Morton <akpm@digeo.com>, lkml <linux-kernel@vger.kernel.org>,
   "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: 2.5.40-mm2
In-Reply-To: <3DA0A144.8070301@us.ibm.com>
Message-ID: <Pine.LNX.4.44.0210081303090.29540-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-8.4 required=5.0
	tests=IN_REP_TO,UNIFIED_PATCH
	version=2.31
X-Spam-Level: 
X-Fetchmail-Warning: no recipient addresses matched declared local names


On Sun, 6 Oct 2002, Dave Hansen wrote:

> cc'ing Ingo, because I think this might be related to the timer bh
> removal.

could you try the attached patch against 2.5.41, does it help? It fixes
the bugs found so far plus makes del_timer_sync() a bit more robust by
re-checking timer pending-ness before exiting. There is one type of code
that might have relied on this kind of behavior of the old timer code.

	Ingo

--- linux/kernel/timer.c.orig	2002-10-08 12:39:46.000000000 +0200
+++ linux/kernel/timer.c	2002-10-08 12:49:50.000000000 +0200
@@ -266,29 +266,31 @@
 int del_timer_sync(timer_t *timer)
 {
 	tvec_base_t *base = tvec_bases;
-	int i, ret;
+	int i, ret = 0;
 
-	ret = del_timer(timer);
+del_again:
+	ret += del_timer(timer);
 
-	for (i = 0; i < NR_CPUS; i++) {
+	for (i = 0; i < NR_CPUS; i++, base++) {
 		if (!cpu_online(i))
 			continue;
 		if (base->running_timer == timer) {
 			while (base->running_timer == timer) {
 				cpu_relax();
-				preempt_disable();
-				preempt_enable();
+				preempt_check_resched();
 			}
 			break;
 		}
-		base++;
 	}
+	if (timer_pending(timer))
+		goto del_again;
+
 	return ret;
 }
 #endif
 
 
-static void cascade(tvec_base_t *base, tvec_t *tv)
+static int cascade(tvec_base_t *base, tvec_t *tv)
 {
 	/* cascade all the timers from tv up one level */
 	struct list_head *head, *curr, *next;
@@ -310,7 +312,8 @@
 		curr = next;
 	}
 	INIT_LIST_HEAD(head);
-	tv->index = (tv->index + 1) & TVN_MASK;
+
+	return tv->index = (tv->index + 1) & TVN_MASK;
 }
 
 /***
@@ -322,26 +325,18 @@
  */
 static inline void __run_timers(tvec_base_t *base)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&base->lock, flags);
+	spin_lock_irq(&base->lock);
 	while ((long)(jiffies - base->timer_jiffies) >= 0) {
 		struct list_head *head, *curr;
 
 		/*
 		 * Cascade timers:
 		 */
-		if (!base->tv1.index) {
-			cascade(base, &base->tv2);
-			if (base->tv2.index == 1) {
-				cascade(base, &base->tv3);
-				if (base->tv3.index == 1) {
-					cascade(base, &base->tv4);
-					if (base->tv4.index == 1)
-						cascade(base, &base->tv5);
-				}
-			}
-		}
+		if (!base->tv1.index &&
+			(cascade(base, &base->tv2) == 1) &&
+				(cascade(base, &base->tv3) == 1) &&
+					cascade(base, &base->tv4) == 1)
+			cascade(base, &base->tv5);
 repeat:
 		head = base->tv1.vec + base->tv1.index;
 		curr = head->next;
@@ -370,7 +365,7 @@
 #if CONFIG_SMP
 	base->running_timer = NULL;
 #endif
-	spin_unlock_irqrestore(&base->lock, flags);
+	spin_unlock_irq(&base->lock);
 }
 
 /******************************************************************/


--------------090500090808080000060709--

