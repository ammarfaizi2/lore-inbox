Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269472AbUINQna@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269472AbUINQna (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 12:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269460AbUINQkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 12:40:40 -0400
Received: from holomorphy.com ([207.189.100.168]:50324 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269567AbUINQbP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 12:31:15 -0400
Date: Tue, 14 Sep 2004 09:31:06 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@novell.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] sched: fix scheduling latencies for !PREEMPT kernels
Message-ID: <20040914163106.GS9106@holomorphy.com>
References: <20040914105048.GA31238@elte.hu> <20040914105904.GB31370@elte.hu> <20040914110237.GC31370@elte.hu> <20040914110611.GA32077@elte.hu> <20040914112847.GA2804@elte.hu> <20040914114228.GD2804@elte.hu> <4146EA3E.4010804@yahoo.com.au> <20040914132225.GA9310@elte.hu> <4146F33C.9030504@yahoo.com.au> <20040914140905.GM4180@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040914140905.GM4180@dualathlon.random>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2004 at 04:09:05PM +0200, Andrea Arcangeli wrote:
> 1) cond_resched should become a noop if CONFIG_PREEMPT=y
>    (cond_resched_lock of course should still unlock/relock if
>     need_resched() is set, but not __cond_resched).
> 2) all Ingo's new and old might_sleep should be converted to
>    cond_resched (or optionally to cond_resched_costly, see point 5).
> 3) might_sleep should return a debug statement.
> 4) cond_resched should call might_sleep if need_resched is not set if
>    CONFIG_PREEMPT=n is disabled, and it should _only_ call might_sleep
>    if CONFIG_PREEMPT=y after we implement point 1.
> 5) no further config option should exist (if we really add an option
>    it should be called CONFIG_COND_RESCHED_COSTLY of similar to 
>    differentiate scheduling points in fast paths (like spinlock places
>    with CONFIG_PREEMPT=n) (so you can choose between cond_resched() and
>    cond_resched_costly())
> I recommended point 2,3,4,5 already (a few of them twice), point 1 (your
> point) looks lower prio (CONFIG_PREEMPT=y already does an overkill of
> implicit need_resched() checks anyways).

The might_sleep() in cond_resched() sounds particularly useful to pick
up misapplications of cond_resched().


On Tue, Sep 14, 2004 at 11:33:48PM +1000, Nick Piggin wrote:
>> Why would someone who really cares about latency not enable preempt?
>> cond_rescheds everywhere? Isn't this now the worst of both worlds?

On Tue, Sep 14, 2004 at 04:09:05PM +0200, Andrea Arcangeli wrote:
> to avoid lots of worthless cond_resched in all spin_unlock and to avoid
> kernel crashes if some driver is not preempt complaint?
> I've a better question for you, why would someone ever disable
> CONFIG_PREEMPT_VOLUNTARY? That config option is a nosense as far as I
> can tell. If something it should be renamed to
> "CONFIG_I_DON_T_WANT_TO_RUN_THE_OLD_KERNEL_CODE" ;)

Well, thankfully we've taken the whole of the preempt-related code in
spin_unlock() and all the other locking primitives out of line for the
CONFIG_PREEMPT case (and potentially more, though that would be at the
expense of x86(-64)).

preempt_schedule() is actually what's used in preempt_check_resched(),
not cond_resched(), and this inspired me to take a look at that. What
on earth are people smoking with all these loops done up with gotos?
I suppose this isn't even the half of it, but it's what I looked at.


-- wli

Nuke some superfluous gotos in preempt_schedule().

Index: mm5-2.6.9-rc1/kernel/sched.c
===================================================================
--- mm5-2.6.9-rc1.orig/kernel/sched.c	2004-09-13 16:27:46.998672328 -0700
+++ mm5-2.6.9-rc1/kernel/sched.c	2004-09-14 09:01:46.514087864 -0700
@@ -2464,18 +2464,19 @@
 	 * If there is a non-zero preempt_count or interrupts are disabled,
 	 * we do not want to preempt the current task.  Just return..
 	 */
-	if (unlikely(ti->preempt_count || irqs_disabled()))
-		return;
-
-need_resched:
-	ti->preempt_count = PREEMPT_ACTIVE;
-	schedule();
-	ti->preempt_count = 0;
+	if (likely(!ti->preempt_count && !irqs_disabled())) {
+		do {
+			ti->preempt_count = PREEMPT_ACTIVE;
+			schedule();
+			ti->preempt_count = 0;
 
-	/* we could miss a preemption opportunity between schedule and now */
-	barrier();
-	if (unlikely(test_thread_flag(TIF_NEED_RESCHED)))
-		goto need_resched;
+			/*
+			 * Without this barrier, we could miss a
+			 * preemption opportunity between schedule and now
+			 */
+			barrier();
+		} while (unlikely(test_thread_flag(TIF_NEED_RESCHED)));
+	}
 }
 
 EXPORT_SYMBOL(preempt_schedule);
