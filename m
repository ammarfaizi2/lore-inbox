Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030186AbWBHJlv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030186AbWBHJlv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 04:41:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964918AbWBHJlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 04:41:51 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:30121 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S964858AbWBHJlu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 04:41:50 -0500
Date: Wed, 8 Feb 2006 04:41:42 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: preempt-rt, NUMA and strange latency traces
In-Reply-To: <1139311689.19708.36.camel@frecb000686>
Message-ID: <Pine.LNX.4.58.0602080436190.8578@gandalf.stny.rr.com>
References: <1139311689.19708.36.camel@frecb000686>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 7 Feb 2006, Sébastien Dugué wrote:

>   Hi,
>
>   I've been experimenting with 2.6.15-rt16 on a dual 2.8GHz Xeon box
> with quite good results and decided to make a run on a NUMA dual node
> IBM x440 (8 1.4GHz Xeon, 28GB ram).
>
>   However, the kernel crashes early when creating the slabs. Does the
> current preempt-rt patchset supports NUMA machines or has support
> been disabled until things settle down?

Yeah, currently the -rt patch doesn't work well with NUMA.

>
>   Going on, I compiled a non NUMA RT kernel which booted just fine,
> but when examining the latency traces, I came upon strange jumps
> in the latencies such as:
>
>
>    <...>-6459  2D.h1   42us : rcu_pending (update_process_times)
>    <...>-6459  2D.h1   42us : scheduler_tick (update_process_times)
>    <...>-6459  2D.h1   43us : sched_clock (scheduler_tick)
>    <...>-6459  2D.h1   44us!: _raw_spin_lock (scheduler_tick)
>    <...>-6459  2D.h2 28806us : _raw_spin_unlock (scheduler_tick)
>    <...>-6459  2D.h1 28806us : rebalance_tick (scheduler_tick)
>    <...>-6459  2D.h1 28807us : irq_exit (smp_apic_timer_interrupt)
>    <...>-6459  2D..1 28808us < (608)
>    <...>-6459  2D..1 28809us : smp_apic_timer_interrupt (c03e2a02 0 0)
>    <...>-6459  2D.h1 28810us : handle_nextevent_update (smp_apic_timer_interrupt)
>    <...>-6459  2D.h1 28810us : hrtimer_interrupt (handle_nextevent_update)

Hmm, are the TSC of the CPUS in sync?  If not, you will get bad
messurements of the latency tracer.  That is currently why we can't use
tracing with x86_64 x2 CPUS.

>
>   There does not seem to be a precise code path leading to those jumps,
> it seems
> they can appear anywhere. Furthermore the jump seems to always be of ~ 27 ms
>
>   I tried running on only 1 CPU, tried using the TSC instead of the cyclone
> timer but to no avail, the phenomenon is still there.

OK, this scares me.  You get these with only one CPU?  Is it still
compiled for SMP?  If not, see if the latencies go away if you turn off
SMP.

 >
>   My test program only consists in a thread running at max RT priority doing
> a nanosleep().
>
>   What could be going on here?

Good question.  Could you send your .config

-- Steve
