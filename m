Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263429AbUIOIm4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263429AbUIOIm4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 04:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263893AbUIOIm4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 04:42:56 -0400
Received: from mx2.elte.hu ([157.181.151.9]:27326 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S263429AbUIOImx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 04:42:53 -0400
Date: Wed, 15 Sep 2004 10:43:55 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] sched: fix scheduling latencies for !PREEMPT kernels
Message-ID: <20040915084355.GA29752@elte.hu>
References: <20040914110611.GA32077@elte.hu> <20040914112847.GA2804@elte.hu> <20040914114228.GD2804@elte.hu> <4146EA3E.4010804@yahoo.com.au> <20040914132225.GA9310@elte.hu> <4146F33C.9030504@yahoo.com.au> <20040914145457.GA13113@elte.hu> <414776CE.5030302@yahoo.com.au> <20040915061922.GA11683@elte.hu> <4147FC14.2010205@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4147FC14.2010205@yahoo.com.au>
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


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> OK.
> 
> Alternatively, I'd say tell everyone who wants really low latency to
> enable CONFIG_PREEMPT, which automatically gives the minimum possible
> preempt latency, delimited (and defined) by critical sections, instead
> of the more ad-hoc "sprinkling" ;)

it's not ad-hoc. These are the 10 remaining points for which there is no
natural might_sleep() point nearby (according to measurements). That's
why i called them 'complementary'. They cause zero problems for the
normal kernel (we already have another 70 cond_resched() points), but
they _are_ the ones needed in addition if might_sleep() also does
cond_resched().

the 'reliability' of latency break-up depends on the basic preemption
model. Believe me, even with CONFIG_PREEMPT there were a boatload of
critical sections that had insanely long latencies that nobody fixed
until the VP patchset came along. Without CONFIG_PREEMPT the number of
possibly latency-paths increases, but the situation is the same as with
CONFIG_PREEMPT: you need tools, people that test stuff and lots of
manual work to break them up reliably. You will never be 'done' but you
can do a reasonably good job for workloads that people care about.

the 'final' preemption model [for hard-RT purposes] that i believe will
make it into the Linux kernel one nice day is total preemptability of
everything but the core preemption code (i.e. the scheduler and
interrupt controllers). _That_ might be something that has provable
latencies. Note that such a 'total preemption' model has prerequisites
too, like the deterministic execution of hardirqs/softirqs.

note that the current lock-break-up activities still make alot of sense
even under the total-preemption model: it decreases the latency of
kernel-using hard-RT applications. (raw total preemption only guarantees
quick scheduling of the hard-RT task - it doesnt guarantee that the task
can complete any useful kernel/syscall work.)

since we already see at least 4 different viable preemption models
placed on different points in the 'latency reliability' spectrum, it
makes little sense to settle for any of them. So i'm aiming to keep the
core code flexible to have them all without much fuss, and usage will
decide which ones are needed. Maybe CONFIG_PREEMPT will merge into
CONFIG_TOTAL_PREEMPT. Maybe CONFIG_NO_PREEMPT will merge into
CONFIG_PREEMPT_VOLUNTARY. Maybe CONFIG_PREEMPT_VOLUNTARY will go away
altogether. We cannot know at this point, it all depends on how usage
(and consequently, hardware) evolves.

	Ingo
