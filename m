Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266824AbUGVHjo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266824AbUGVHjo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 03:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266827AbUGVHjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 03:39:44 -0400
Received: from mx2.elte.hu ([157.181.151.9]:21662 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S266824AbUGVHjl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 03:39:41 -0400
Date: Thu, 22 Jul 2004 09:40:34 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Scott Wood <scott@timesys.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Lee Revell <rlrevell@joe-job.com>,
       Andrew Morton <akpm@osdl.org>, linux-audio-dev@music.columbia.edu,
       arjanv@redhat.com, linux-kernel <linux-kernel@vger.kernel.org>,
       "La Monte H.P. Yarroll" <piggy@timesys.com>
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040722074034.GC7553@elte.hu>
References: <20040721053007.GA8376@elte.hu> <1090389791.901.31.camel@mindpipe> <20040721082218.GA19013@elte.hu> <20040721085246.GA19393@elte.hu> <40FE545E.3050300@yahoo.com.au> <20040721183415.GC2206@yoda.timesys> <20040721184650.GA27375@elte.hu> <20040721195650.GA2186@yoda.timesys> <20040721214534.GA31892@elte.hu> <20040722022810.GA3298@yoda.timesys>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040722022810.GA3298@yoda.timesys>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-1.524, required 5.9,
	autolearn=not spam, BAYES_01 -1.52
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Scott Wood <scott@timesys.com> wrote:

> > if both hardirqs and softirqs are redirectable to process contexts then
> > the only unpredictable latency would be the very short IRQ entry stub of
> > a new hardirq costing ~5 usecs - which latency is limited in effect
> > unless the CPU is hopelessly bombarded with interrupts.
> 
> Those aren't the only sources; you also have preempt_disable() and
> such (as well as hardware weirdness, though there's not much we can do
> about that).

i did not say latency sources, i said unpredictable latency sources. 
hardirq and softirq processing introduces near arbitrary latency at any
(irqs-enabled) point in the kernel. Hence they make all kernel code
unbound in essence - even the most trivial kernel code, sys_getpid().

by (optionally) moving softirqs and hardirqs to a process context we've
removed this source of uncertainty by making all processing synchronous,
and what remains are ordinary algorithmic properties of the kernel code
- which we can predict and control. I.e. with those two fixed we now
have a _chance_ to guarantee latencies.

[the only remaining source of 'latency uncertainty' is the small
asynchronous hardirq stub that would still remain. This has an effect
that can be compared to e.g. cache effects and it cannot become unbound
unless the CPU is bombarded with a very high number of interrupts.]

> > to solve the spinlock problem of hardirqs i'd propose a dual type
> > spinlock that is a spinlock if hardirqs are immediate (synchronous) and
> > it would be a mutex if hardirqs are redirected (asynchronous). Then some
> > simple driver could be converted to this RT-aware spinlock and we'd see
> > how well it works. Have you done experiments in this direction? 
> 
> This sort of substitution is what we did in 2.4, though we made this
> type the default and gave the real spinlocks a new name to be used in
> those few places where it was really needed.  Of course, this resulted
> in a lot of places using a mutex where a spinlock would have been
> fine.

what are those few places where a spinlock was really needed?

I'm a bit uneasy about making mutexes the default not due to performance
but due to e.g. some hardware being very timing-sensitive. I dont think
we can make a blanket assumption that every code path is preemptable if
all processing is synchronous and the exclusions are listened to.

	Ingo
