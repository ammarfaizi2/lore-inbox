Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132465AbRDCTP4>; Tue, 3 Apr 2001 15:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132560AbRDCTPj>; Tue, 3 Apr 2001 15:15:39 -0400
Received: from gateway.sequent.com ([192.148.1.10]:21284 "EHLO
	gateway.sequent.com") by vger.kernel.org with ESMTP
	id <S132465AbRDCTOI>; Tue, 3 Apr 2001 15:14:08 -0400
Date: Tue, 3 Apr 2001 12:13:08 -0700
From: Mike Kravetz <mkravetz@sequent.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Fabio Riccardi <fabio@chromium.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: a quest for a better scheduler
Message-ID: <20010403121308.A1054@w-mikek2.sequent.com>
In-Reply-To: <3AC93417.7B7814FC@chromium.com> <Pine.LNX.4.30.0104031035271.2794-100000@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.30.0104031035271.2794-100000@elte.hu>; from mingo@elte.hu on Tue, Apr 03, 2001 at 10:55:12AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 03, 2001 at 10:55:12AM +0200, Ingo Molnar wrote:
> 
> you can easily make the scheduler fast in the many-processes case by
> sacrificing functionality in the much more realistic, few-processes case.
> None of the patch i've seen so far maintained the current scheduler's
> few-processes logic. But i invite you to improve the current scheduler's
> many-processes behavior, without hurting its behavior in the few-processes
> case.
> 

Maintaining the current scheduler's logic is exactly what we are trying
to do in the projects at:

http://lse.sourceforge.net/scheduling/

A common design goal for the the two alternative scheduler
implementations at this site is to maintain the current scheduler's
behavior/scheduling decisions.  In the case of the priority queue
scheduler, we have actually used a copy of the existing scheduler
running in parallel (in the same kernel) to determine if we are
making the same scheduling decisions.  Currently, in this implementation
we only deviate from the current scheduler in a small number of cases
where tasks get a boost due to having the same memory map.

The multi-queue implementation is more interesting.  It is also
designed to maintain the behavior of the current scheduler.  However,
as the runqueues get longer (and we start getting contention on the
runqueue locks) it starts to deviate from existing scheduler behavior
and make more local scheduling decisions.  Ideally, this implementation
will exhibit the behavior of the current scheduler at low thread
counts and make more localized decisions as pressure on the scheduler
is increased.

Neither of these implementations are at a point where I would advocate
their adoption; yet.

Can someone tell me what a good workload/benchmark would be to
examine 'low thread count' performance?  In the past people have
used the 'spinning on sched_yield' benchmark.  However, this now
makes little sense with the sched_yield optimizations introduced
in 2.4.  In addition, such a benchmark mostly ignores the
'reschedule_idle' component of the scheduler.  We have developed
a 'token passing' benchmark which attempts to address these issues
(called reflex at the above site).  However, I would really like
to get a pointer to a community acceptable workload/benchmark for
these low thread cases.

-- 
Mike Kravetz                                 mkravetz@sequent.com
IBM Linux Technology Center
