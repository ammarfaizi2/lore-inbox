Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751238AbWCFFAn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbWCFFAn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 00:00:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbWCFFAn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 00:00:43 -0500
Received: from smtp.osdl.org ([65.172.181.4]:51152 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751238AbWCFFAm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 00:00:42 -0500
Date: Sun, 5 Mar 2006 21:00:17 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Greg KH <greg@kroah.com>, Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@redhat.com>
Subject: Re: Fw: Re: oops in choose_configuration()
In-Reply-To: <20060305154858.0fb0006a.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0603052043170.13139@g5.osdl.org>
References: <20060304121723.19fe9b4b.akpm@osdl.org>
 <Pine.LNX.4.64.0603041235110.22647@g5.osdl.org> <20060304213447.GA4445@kroah.com>
 <20060304135138.613021bd.akpm@osdl.org> <20060304221810.GA20011@kroah.com>
 <20060305154858.0fb0006a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 5 Mar 2006, Andrew Morton wrote:
> 
> For several days I've been getting repeatable oopses in the -mm kernel. 
> They occur once per ~30 boots, during initscripts.

Actually, having thought about this some more, I wonder if the bug isn't a 
hell of a lot simpler than we've given it credit for.

I think you're running with CONFIG_PREEMPT_VOLUNTARY, right?

And looking more closely, that thing is BROKEN. DaveJ - do Fedora kernels 
also enable that thing?

Ingo: as far as I can see, CONFIG_PREEMPT_VOLUNTARY is totally and utterly 
broken during bootup. It does:

	# define might_resched() cond_resched()

and then we have

	# define might_sleep() do { might_resched(); } while (0)

and but the fact is, we _know_ that "might_sleep()" is broken during early 
bootup. We know this, because when we ahev __might_sleep() enabled to 
warn about cases where we must not sleep, we've had those tests disabled 
during early boot for a long time, in order to avoid irritating and nasty 
known "sleeping function called from invalid context" messages:

	...
        if ((in_atomic() || irqs_disabled()) &&
            system_state == SYSTEM_RUNNING && !oops_in_progress) {
                if (time_before(jiffies, prev_jiffy + HZ) && prev_jiffy)
	...

Note in particular the "system_state == SYSTEM_RUNNING". It's there for a 
reason. Namely that we know that we do things that aren't valid during 
early bootup, and that we call functions that might sleep while we have 
interrupts disabled, for example.

HOWEVER, the "cond_resched()" does not take that into account at all, and 
will happily conditionally reschedule things at early bootup before we 
have set system_state to SYSTEM_RUNNING.

In other words, unless I've totally lost it, I think that 
CONFIG_PREEMPT_VOLUNTARY currently makes us re-schedule at points in the 
early boot that we _know_ are unsafe. We happen to not hit it very often, 
because (a) some of the time it doesn't matter and (b) when it matters, we 
seldom have "need_resched()" returning true, but I would not be at all 
surprised if Andrew's problems are because the scheduler heuristics make 
it happen when it shouldn't.

And the end result? I don't know. But we've traditionally run _all_ of the 
early boot ignoring the "might_sleep()" warnings, up until the point where 
we unlock the kernel lock, long after things like kmem_cache_init().

So I would not be surprised, for example, if we had kmem_cache_init() 
doing bad things because it got interrupts enabled at a point where it 
shouldn't, because it went through the scheduler. 

I dunno. I can't actually see what would corrupt anything, but the point 
is that we definitely do scheduling in places that have gotten absolutely 
_zero_ coverage, because we turned off the checks on purpose during early 
boot because the checks gave false positives.

And CONFIG_PREEMPT_VOLUNTARY turns those false positives into potential 
rescheduling events.

Maybe I'm crazy. But it looks really really broken to me.

Andrew, if I'm right, then this ugly patch should make a difference.

Is there something else I've missed?

			Linus

----
diff --git a/kernel/sched.c b/kernel/sched.c
index 12d291b..3454bb8 100644
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -4028,6 +4028,8 @@ static inline void __cond_resched(void)
 	 */
 	if (unlikely(preempt_count()))
 		return;
+	if (unlikely(system_state != SYSTEM_RUNNING))
+		return;
 	do {
 		add_preempt_count(PREEMPT_ACTIVE);
 		schedule();
