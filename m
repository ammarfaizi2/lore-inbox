Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263028AbRFEAZj>; Mon, 4 Jun 2001 20:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263035AbRFEAZ3>; Mon, 4 Jun 2001 20:25:29 -0400
Received: from nrg.org ([216.101.165.106]:21876 "EHLO nrg.org")
	by vger.kernel.org with ESMTP id <S263028AbRFEAZL>;
	Mon, 4 Jun 2001 20:25:11 -0400
Date: Mon, 4 Jun 2001 17:25:05 -0700 (PDT)
From: Nigel Gamble <nigel@nrg.org>
Reply-To: nigel@nrg.org
To: Mike Kravetz <mkravetz@sequent.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: reschedule_idle changes in ac kernels
In-Reply-To: <20010604160837.B15640@w-mikek2.des.sequent.com>
Message-ID: <Pine.LNX.4.05.10106041656430.3260-100000@cosmic.nrg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Jun 2001, Mike Kravetz wrote:
> I just noticed the changes to reschedule_idle() in the 2.4.5-ac
> kernel.  I suspect these are the changes made for:
> 
> o       Fix off by one on real time pre-emption in scheduler
> 
> I'm curious if anyone has ran any benchmarks before and after
> applying this fix.

I was running realtime benchmarks, which was how I found the bug.

> The reason I ask is that during the development of my multi-queue
> scheduler, I 'accidently' changed reschedule_idle code to trigger
> a preemption if preemption_goodness() was greater than 0, as
> opposed to greater than 1.  I believe this is the same change made
> to the ac kernel.  After this change, we saw a noticeable drop in
> performance for some benchmarks.
> 
> The drop in performance I saw could have been the result of a
> combination of the change, and my multi-queue scheduler.  However,
> in any case aren't we now going to trigger more preemptions?
> 
> I understand that we need to make the fig to get the realtime
> semantics correct,  but we also need to be aware of performance in
> the non-realtime case.

The realtime bug was caused by whoever decided, sometime in 2.4, that
the result of preemption_goodness() should be compared to 1 instead of 0
(without changing the comment above that function).

An alternative fix for the realtime bug would be 

	weight = 1000 + (p->rt_priority * 2);

in goodness(), so that two realtime tasks with priorities that differ by
1 would have goodness values that differ by more than one.

However, before anyone rushes to implement this, I'd like to suggest
that any performance problems that may be found with the SCHED_OTHER
goodness calculation should be fixed in goodness(), if at all possible,
and not leak out as an undocumented magic number into reschedule_idle().

Nigel Gamble                                    nigel@nrg.org
Mountain View, CA, USA.                         http://www.nrg.org/

MontaVista Software                             nigel@mvista.com

