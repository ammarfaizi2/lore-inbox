Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264430AbUGUXqM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264430AbUGUXqM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 19:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266774AbUGUXqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 19:46:12 -0400
Received: from mx2.elte.hu ([157.181.151.9]:40860 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S264430AbUGUXqI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 19:46:08 -0400
Date: Wed, 21 Jul 2004 23:45:34 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Scott Wood <scott@timesys.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Lee Revell <rlrevell@joe-job.com>,
       Andrew Morton <akpm@osdl.org>, linux-audio-dev@music.columbia.edu,
       arjanv@redhat.com, linux-kernel <linux-kernel@vger.kernel.org>,
       "La Monte H.P. Yarroll" <piggy@timesys.com>
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040721214534.GA31892@elte.hu>
References: <1090380467.1212.3.camel@mindpipe> <20040721000348.39dd3716.akpm@osdl.org> <20040721053007.GA8376@elte.hu> <1090389791.901.31.camel@mindpipe> <20040721082218.GA19013@elte.hu> <20040721085246.GA19393@elte.hu> <40FE545E.3050300@yahoo.com.au> <20040721183415.GC2206@yoda.timesys> <20040721184650.GA27375@elte.hu> <20040721195650.GA2186@yoda.timesys>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040721195650.GA2186@yoda.timesys>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-1.428, required 5.9,
	autolearn=not spam, BAYES_20 -1.43
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Scott Wood <scott@timesys.com> wrote:

> Likewise, interrupts are "designed" to be unpreemptible, but it is
> possible to run them in their own threads so as to further reduce
> sources of latency (at a throughput cost, of course).  This allows
> long-held spinlocks that an interrupt handler needs to acquire to be
> replaced with mutexes that don't inhibit preemption.
> 
> Of course, a better fix is to keep the interrupt handlers and critical
> sections short, but threading them can be very effective for producing
> low latencies in the short term (we were able to achieve worst
> measured case latencies of well under 100us on ordinary PC hardware
> under 2.4.x using this approach).

do you have a 2.6 patch for hardirq redirection too? I always thought
this to be the best approach to achive hard-RT class latency guarantees
under Linux (but never coded it up). The problem with RTLinux is that it
introduces a separate OS (with separate APIs). It is (much) further
ahead of Linux in terms of latencies, algorithms and guarantees but is
still a separate OS. I believe there is a natural synergy between low
latencies needed for good desktop and multiuser performance and
soft-RT/hard-RT needs, which we should use - RTLinux doesnt generate
this synergy.

if both hardirqs and softirqs are redirectable to process contexts then
the only unpredictable latency would be the very short IRQ entry stub of
a new hardirq costing ~5 usecs - which latency is limited in effect
unless the CPU is hopelessly bombarded with interrupts.

to solve the spinlock problem of hardirqs i'd propose a dual type
spinlock that is a spinlock if hardirqs are immediate (synchronous) and
it would be a mutex if hardirqs are redirected (asynchronous). Then some
simple driver could be converted to this RT-aware spinlock and we'd see
how well it works. Have you done experiments in this direction? I
believe this all could be merged upstream, given sufficient cleanliness.

	Ingo
