Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132612AbRDCTuB>; Tue, 3 Apr 2001 15:50:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132613AbRDCTtv>; Tue, 3 Apr 2001 15:49:51 -0400
Received: from chiara.elte.hu ([157.181.150.200]:9996 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S132612AbRDCTtn>;
	Tue, 3 Apr 2001 15:49:43 -0400
Date: Tue, 3 Apr 2001 20:47:52 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Mike Kravetz <mkravetz@sequent.com>
Cc: Fabio Riccardi <fabio@chromium.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: a quest for a better scheduler
In-Reply-To: <20010403121308.A1054@w-mikek2.sequent.com>
Message-ID: <Pine.LNX.4.30.0104032024290.9285-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 3 Apr 2001, Mike Kravetz wrote:

> [...] Currently, in this implementation we only deviate from the
> current scheduler in a small number of cases where tasks get a boost
> due to having the same memory map.

thread-thread-affinity pretty much makes it impossible to use a priority
queue. This 'small number of cases' is actually a fundamental issue: can
the 'goodness()' function be an arbitrary function of:

	goodness(process_prev,process_next) := f(process_prev,process_next)

, or is the queue design restricting the choice of goodness() functions?
Priority queues for example restrict the choice of the goodness() function
to subset of functions:

	goodness(process_prev,process_next) := f(process_next);

this restriction (independence of the priority from the previous process)
is a fundamentally bad property, scheduling is nonlinear and affinity
decisions depend on the previous context. [i had a priority-queue SMP
scheduler running 2-3 years ago but dropped the idea due to this issue.]
IMO it's more important to have a generic and flexible scheduler, and
arbitrary, nonnatural restrictions tend to bite us later on.

one issue regarding multiqueues is the ability of interactive processes to
preempt other, lower priority processes on other CPUs. These sort of
things tend to happen while using X. In a system where process priorities
are different, scheduling decisions cannot be localized per-CPU
(unfortunately), and 'the right to run' as such is a global thing.

> Can someone tell me what a good workload/benchmark would be to examine
> 'low thread count' performance? [...]

lmbench's lat_ctx for example, and other tools in lmbench trigger various
scheduler workloads as well.

	Ingo

