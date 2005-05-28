Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261906AbVE1BHH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261906AbVE1BHH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 21:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261908AbVE1BHH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 21:07:07 -0400
Received: from mail.timesys.com ([65.117.135.102]:44927 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S261906AbVE1BGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 21:06:38 -0400
Message-ID: <4297C3BE.9010408@timesys.com>
Date: Fri, 27 May 2005 21:05:02 -0400
From: john cooper <john.cooper@timesys.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Nicol <davidnicol@gmail.com>
CC: linux-kernel@vger.kernel.org, john cooper <john.cooper@timesys.com>
Subject: Re: spinaphore conceptual draft (was discussion of RT patch)
References: <934f64a205052715315c21d722@mail.gmail.com>
In-Reply-To: <934f64a205052715315c21d722@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 May 2005 01:00:00.0921 (UTC) FILETIME=[932CB090:01C56320]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Nicol wrote:
> So if the normal, uncontended case,
> in a SMP system, is, check something visible to all CPUs, set that
> thing, do the protected thing, unset the visible thing, continue on, and
> the setting/unsetting is the same speed, there would be no difference
> in performance, except when there is actual contention?

Yes.

> On contention, and only on contention, we are faced with the question of what
> to do.  Do we wait, or do we go away and come back later?  What information is
> available to us to base the decision on?  We can't gather any more information, 
> because that would take longer than spin-waiting.  If the "spinaphore" told us,
> on acquisition failure, how many other threads were asking for it, we
> could implement
> a tunable lock, that surrenders context when there are more than N
> threads waiting for
> the resource, and that otherwise waits its turn, or its chance,  as a compromise
> and synthesis.

The trick is making the correct spin/block decision
every time as quickly as possible with as little
information as possible.  As that ideal is probably
not attainable partial solutions such as the adaptive
mutex have been used where the spin/block decision is
made upon simple heuristics such as whether the lock
owner is currently running on another cpu.

Pushing lock acquisition policy back to the lock user is
probably going to cause more confusion/misuse/bugs that
improving overall performance.  In any case it is unlikely
to become popular in general usage and consequently won't
have the opportunity to attempt its goal.

> So, some code would attempt try_and_obtain_or_abandon a few times,
> then would register itself with the spinaphore, and yield its CPU.  When the
> message comes from the spinaphore that it is now this code's turn, the CPU
> would either requeue the entry point if it is really busy --
> interrupting an interrupt
> or something like that -- or switch context back to whatever had registered with
> the spinaphore.

I think you may have answered your own question above.
Optimizing for the contended case is likely past the
point of diminishing returns.  The effort may be better
spent on avoiding contention in the first place
through partitioning, reader/writer semantics, etc..
After all a lock by definition is designed to effect
synchronization by introducing delay.

> Looking at the linux/spinlock.h file from 2.6.11, there are a lot of
> flavors of lock to
> choose between already.  What's one or two or ten more?

I'd hazard that was more a case of sprawling evolution
rather than a conscious design decision.

-john


-- 
john.cooper@timesys.com

