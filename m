Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264717AbUHMMB6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264717AbUHMMB6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 08:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264912AbUHMMB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 08:01:58 -0400
Received: from mx2.elte.hu ([157.181.151.9]:234 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S264717AbUHMMBe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 08:01:34 -0400
Date: Fri, 13 Aug 2004 14:03:02 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [patch] Latency Tracer, voluntary-preempt-2.6.8-rc4-O6
Message-ID: <20040813120302.GA18221@elte.hu>
References: <20040726124059.GA14005@elte.hu> <20040726204720.GA26561@elte.hu> <20040729222657.GA10449@elte.hu> <20040801193043.GA20277@elte.hu> <20040809104649.GA13299@elte.hu> <20040810132654.GA28915@elte.hu> <20040812235116.GA27838@elte.hu> <20040813124249.13066d94@mango.fruits.de> <20040813105406.GJ8135@elte.hu> <20040813140321.78da570d@mango.fruits.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040813140321.78da570d@mango.fruits.de>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Florian Schmidt <mista.tapas@gmx.net> wrote:

> On Fri, 13 Aug 2004 12:54:06 +0200
> Ingo Molnar <mingo@elte.hu> wrote:
> 
> > > (ksoftirqd/0/2): 307 us critical section violates 250 us threshold.
> > >  => started at: <___do_softirq+0x20/0x90>
> > >  => ended at: <cond_resched_softirq+0x59/0x70>
> > 
> > this is too opaque - could you try -O7, enable tracing and save a
> > /proc/latency_trace instance of such a latency? It looks like some
> > sort of softirq latency - perhaps one particular driver's timer fn
> > causes it- we'll be able to tell more from the trace.
> 
> Hi, this looks like one of them:
> 
> mango:~# cat /proc/latency_trace 
> preemption latency trace v1.0
> -----------------------------
>  latency: 308 us, entries: 12 (12)
>  process: ksoftirqd/0/2, uid: 0
>  nice: -10, policy: 0, rt_priority: 0
> =======>
>  0.000ms (+0.000ms): run_timer_softirq (___do_softirq)
>  0.000ms (+0.000ms): sis900_timer (run_timer_softirq)
>  0.001ms (+0.000ms): mdio_read (sis900_timer)
>  0.002ms (+0.000ms): mdio_reset (mdio_read)
>  0.071ms (+0.069ms): mdio_idle (mdio_read)
>  0.151ms (+0.079ms): mdio_read (sis900_timer)
>  0.151ms (+0.000ms): mdio_reset (mdio_read)
>  0.220ms (+0.069ms): mdio_idle (mdio_read)
>  0.300ms (+0.079ms): __mod_timer (sis900_timer)
>  0.300ms (+0.000ms): internal_add_timer (__mod_timer)
>  0.300ms (+0.000ms): cond_resched_softirq (run_timer_softirq)
>  0.301ms (+0.000ms): check_preempt_timing (touch_preempt_timing)

indeed this seems to be a driver related timer: driver/net/sis900.c's
sis900_timer() function. This timer polls your network card for link
status once every second. The mdio_read() function does alot of in/out
instructions which are quite slow.

could you try the following and disable mdio_delay():

	#define mdio_delay() do { } while (0)

normally it should work just fine. Worst-case you'd get a non-working
network driver. Does this change reduce the latency?

	Ingo
