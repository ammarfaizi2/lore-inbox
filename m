Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267423AbUIPBJ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267423AbUIPBJ0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 21:09:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267449AbUIPBGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 21:06:00 -0400
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:62365 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267445AbUIPBDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 21:03:15 -0400
Message-ID: <4148E64A.9000206@yahoo.com.au>
Date: Thu, 16 Sep 2004 11:03:06 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] sched: fix scheduling latencies for !PREEMPT kernels
References: <20040914110611.GA32077@elte.hu> <20040914112847.GA2804@elte.hu> <20040914114228.GD2804@elte.hu> <4146EA3E.4010804@yahoo.com.au> <20040914132225.GA9310@elte.hu> <4146F33C.9030504@yahoo.com.au> <20040914145457.GA13113@elte.hu> <414776CE.5030302@yahoo.com.au> <20040915061922.GA11683@elte.hu> <4147FC14.2010205@yahoo.com.au> <20040915084355.GA29752@elte.hu>
In-Reply-To: <20040915084355.GA29752@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> 
>>OK.
>>
>>Alternatively, I'd say tell everyone who wants really low latency to
>>enable CONFIG_PREEMPT, which automatically gives the minimum possible
>>preempt latency, delimited (and defined) by critical sections, instead
>>of the more ad-hoc "sprinkling" ;)
> 
> 
> it's not ad-hoc. These are the 10 remaining points for which there is no
> natural might_sleep() point nearby (according to measurements). That's
> why i called them 'complementary'. They cause zero problems for the
> normal kernel (we already have another 70 cond_resched() points), but
> they _are_ the ones needed in addition if might_sleep() also does
> cond_resched().
> 

No, I mean putting cond_resched in might_sleep is ad hoc. But that
doesn't mean it doesn't work - it obviously does ;)

> the 'reliability' of latency break-up depends on the basic preemption
> model. Believe me, even with CONFIG_PREEMPT there were a boatload of
> critical sections that had insanely long latencies that nobody fixed
> until the VP patchset came along. Without CONFIG_PREEMPT the number of
> possibly latency-paths increases, but the situation is the same as with
> CONFIG_PREEMPT: you need tools, people that test stuff and lots of
> manual work to break them up reliably. You will never be 'done' but you
> can do a reasonably good job for workloads that people care about.
> 

All the other stuff in your patches are obviously very important with
or without "full preempt", and make up the bulk of the *hard* work.
You have no arguments from me about that.

> the 'final' preemption model [for hard-RT purposes] that i believe will
> make it into the Linux kernel one nice day is total preemptability of
> everything but the core preemption code (i.e. the scheduler and
> interrupt controllers). _That_ might be something that has provable
> latencies. Note that such a 'total preemption' model has prerequisites
> too, like the deterministic execution of hardirqs/softirqs.
> 
> note that the current lock-break-up activities still make alot of sense
> even under the total-preemption model: it decreases the latency of
> kernel-using hard-RT applications. (raw total preemption only guarantees
> quick scheduling of the hard-RT task - it doesnt guarantee that the task
> can complete any useful kernel/syscall work.)
> 
> since we already see at least 4 different viable preemption models
> placed on different points in the 'latency reliability' spectrum, it
> makes little sense to settle for any of them. So i'm aiming to keep the
> core code flexible to have them all without much fuss, and usage will
> decide which ones are needed. Maybe CONFIG_PREEMPT will merge into
> CONFIG_TOTAL_PREEMPT. Maybe CONFIG_NO_PREEMPT will merge into
> CONFIG_PREEMPT_VOLUNTARY. Maybe CONFIG_PREEMPT_VOLUNTARY will go away
> altogether. We cannot know at this point, it all depends on how usage
> (and consequently, hardware) evolves.
> 

OK I'll leave it at that. We'll see what happens.
