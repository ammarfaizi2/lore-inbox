Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932306AbWEJUd1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbWEJUd1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 16:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932492AbWEJUd1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 16:33:27 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:62148 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932306AbWEJUdZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 16:33:25 -0400
Date: Wed, 10 May 2006 16:33:15 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Mark Hounschell <markh@compro.net>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Daniel Walker <dwalker@mvista.com>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: rt20 patch question
In-Reply-To: <44623157.9090105@compro.net>
Message-ID: <Pine.LNX.4.58.0605101556580.22959@gandalf.stny.rr.com>
References: <446089CF.3050809@compro.net> <1147185483.21536.13.camel@c-67-180-134-207.hsd1.ca.comcast.net>
 <4460ADF8.4040301@compro.net> <Pine.LNX.4.58.0605100827500.3282@gandalf.stny.rr.com>
 <4461E53B.7050905@compro.net> <Pine.LNX.4.58.0605100938100.4503@gandalf.stny.rr.com>
 <446207D6.2030602@compro.net> <Pine.LNX.4.58.0605101215220.19935@gandalf.stny.rr.com>
 <44623157.9090105@compro.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 10 May 2006, Mark Hounschell wrote:

>
> Configured for "Preempable Kernel" I got the following but no "stops"
> came with it.
>
> BUG: scheduling while atomic: softirq-timer/1/0x00000100/15
> caller is schedule+0x33/0xf0
>  [<b0309acc>] __schedule+0x517/0x95b (8)
>  [<f09d7627>] mdio_ctrl+0xaa/0x135 [e100] (48)
>  [<f09d7627>] mdio_ctrl+0xaa/0x135 [e100] (12)
>  [<b030a06c>] schedule+0x33/0xf0 (36)
>  [<b012eee5>] prepare_to_wait+0x12/0x4f (8)
>  [<b0142318>] synchronize_irq+0x96/0xba (20)
>  [<b012eda0>] autoremove_wake_function+0x0/0x37 (12)
>  [<f0a13677>] vortex_timer+0xa0/0x563 [3c59x] (24)
>  [<b0125b76>] __mod_timer+0x8c/0xc3 (12)
>  [<f09d8998>] e100_watchdog+0x0/0x39c [e100] (24)
>  [<b030a4cf>] cond_resched_softirq+0x64/0xaa (8)
>  [<b02a2dcd>] dev_watchdog+0x77/0xac (4)
>  [<f0a135d7>] vortex_timer+0x0/0x563 [3c59x] (12)
>  [<b0125902>] run_timer_softirq+0x1bf/0x3a7 (8)
>  [<b0121960>] ksoftirqd+0x112/0x1cc (52)
>  [<b012184e>] ksoftirqd+0x0/0x1cc (52)
>  [<b012eb9c>] kthread+0xc2/0xc6 (4)
>  [<b012eada>] kthread+0x0/0xc6 (12)
>  [<b0100e35>] kernel_thread_helper+0x5/0xb (16)
>

Ingo,

I traced this down.  It is caused by the disable_irq in vortex_timer that
is called via run_timer_softirq.

disable_irq can call synchronize_irq which can schedule.

And thus you get this bug since we are in a softirq.

This is the case where we are not in PREEMPT_RT but I'm guessing that Mark
has interrupts has threads. Which would allow for synchronize_irq to
schedule.

So I guess we have a case that we can schedule, but while atomic and BUG
when it's really not bad.  Should we add something like this:

Index: linux-2.6.16-rt20/kernel/sched.c
===================================================================
--- linux-2.6.16-rt20.orig/kernel/sched.c	2006-05-10 16:23:15.000000000 -0400
+++ linux-2.6.16-rt20/kernel/sched.c	2006-05-10 16:28:31.000000000 -0400
@@ -3316,7 +3316,8 @@ void __sched __schedule(void)
 	/*
 	 * Test if we are atomic.
 	 */
-	if (unlikely(in_atomic())) {
+	if (unlikely(in_atomic()) &&
+	    (!hardirq_preemption || preempt_count() & PREEMPT_MASK)) {
 		stop_trace();
 		printk(KERN_ERR "BUG: scheduling while atomic: "
 			"%s/0x%08x/%d\n",


-- Steve

