Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751630AbWEKMB7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751630AbWEKMB7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 08:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751632AbWEKMB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 08:01:59 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:26025 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751621AbWEKMB6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 08:01:58 -0400
Date: Thu, 11 May 2006 08:01:48 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Mark Hounschell <markh@compro.net>
cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: rt20 patch question
In-Reply-To: <44631F1B.8000100@compro.net>
Message-ID: <Pine.LNX.4.58.0605110739520.5610@gandalf.stny.rr.com>
References: <446089CF.3050809@compro.net> <1147185483.21536.13.camel@c-67-180-134-207.hsd1.ca.comcast.net>
 <4460ADF8.4040301@compro.net> <Pine.LNX.4.58.0605100827500.3282@gandalf.stny.rr.com>
 <4461E53B.7050905@compro.net> <Pine.LNX.4.58.0605100938100.4503@gandalf.stny.rr.com>
 <446207D6.2030602@compro.net> <Pine.LNX.4.58.0605101215220.19935@gandalf.stny.rr.com>
 <44623157.9090105@compro.net> <Pine.LNX.4.58.0605101446090.22959@gandalf.stny.rr.com>
 <44623ED4.1030103@compro.net> <44631F1B.8000100@compro.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 May 2006, Mark Hounschell wrote:

> Mark Hounschell wrote:
>
> This is with frame pointers on but doesn't look any more revealing to
> me. After this one my network connection into the emulation was broken
> BTW. And yes hard and soft irqs are threaded, preemptable-kernel, and
> classic RCU
>
> BUG: scheduling while atomic: softirq-timer/1/0x00000100/15
> caller is schedule+0x33/0xf0
>  [<b01041c9>] show_trace+0xd/0xf (8)
>  [<b01041e2>] dump_stack+0x17/0x19 (12)
>  [<b03112ec>] __schedule+0x517/0x95b (96)
>  [<b031188f>] schedule+0x33/0xf0 (28)
>  [<b014381f>] synchronize_irq+0x94/0xb9 (40)
>  [<b0143943>] disable_irq+0x31/0x35 (16)
>  [<f0a12715>] vortex_timer+0xa1/0x55b [3c59x] (72)
>  [<b01261d5>] run_timer_softirq+0x1ce/0x3de (56)
>  [<b012212c>] ksoftirqd+0x110/0x1cb (60)
>  [<b012f851>] kthread+0xc8/0xcc (32)
>  [<b0100e15>] kernel_thread_helper+0x5/0xb (268935196)

Nope, this trace is _a_lot_ better, the previous trace had a lot of
garbage in it.

Anyway, I already figured out the problem from the last dump. Could you
try the patch below to see if it fixes it.

>
> I hope it was OK to add Ingo to the CC list?
>

Yep, that's fine, in fact, he should have been added.

Try this patch to see if it fixes that bug.

-- Steve

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
+	    (!hardirq_preemption || (preempt_count() & PREEMPT_MASK))) {
 		stop_trace();
 		printk(KERN_ERR "BUG: scheduling while atomic: "
 			"%s/0x%08x/%d\n",
