Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269324AbUINO27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269324AbUINO27 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 10:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269325AbUINO26
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 10:28:58 -0400
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:442 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S269324AbUINO2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 10:28:54 -0400
Message-ID: <41470021.1030205@yahoo.com.au>
Date: Wed, 15 Sep 2004 00:28:49 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@novell.com>
CC: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] sched: fix scheduling latencies for !PREEMPT kernels
References: <20040914104449.GA30790@elte.hu> <20040914105048.GA31238@elte.hu> <20040914105904.GB31370@elte.hu> <20040914110237.GC31370@elte.hu> <20040914110611.GA32077@elte.hu> <20040914112847.GA2804@elte.hu> <20040914114228.GD2804@elte.hu> <4146EA3E.4010804@yahoo.com.au> <20040914132225.GA9310@elte.hu> <4146F33C.9030504@yahoo.com.au> <20040914140905.GM4180@dualathlon.random>
In-Reply-To: <20040914140905.GM4180@dualathlon.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> On Tue, Sep 14, 2004 at 11:33:48PM +1000, Nick Piggin wrote:
> 
>>cond_rescheds everywhere? Isn't this now the worst of both worlds?
> 
> 
> 1) cond_resched should become a noop if CONFIG_PREEMPT=y
>    (cond_resched_lock of course should still unlock/relock if
>     need_resched() is set, but not __cond_resched).

Unfortunately we need to keep the cond_rescheds that are called under
the bkl. Otherwise yes, this would be nice to be able to do.

> 2) all Ingo's new and old might_sleep should be converted to
>    cond_resched (or optionally to cond_resched_costly, see point 5).
> 3) might_sleep should return a debug statement.
> 4) cond_resched should call might_sleep if need_resched is not set if
>    CONFIG_PREEMPT=n is disabled, and it should _only_ call might_sleep
>    if CONFIG_PREEMPT=y after we implement point 1.
> 5) no further config option should exist (if we really add an option
>    it should be called CONFIG_COND_RESCHED_COSTLY of similar to 
>    differentiate scheduling points in fast paths (like spinlock places
>    with CONFIG_PREEMPT=n) (so you can choose between cond_resched() and
>    cond_resched_costly())
> 
> I recommended point 2,3,4,5 already (a few of them twice), point 1 (your
> point) looks lower prio (CONFIG_PREEMPT=y already does an overkill of
> implicit need_resched() checks anyways).
> 

Which is why we don't need more of them ;)

> 
>>Why would someone who really cares about latency not enable preempt?
> 
> 
> to avoid lots of worthless cond_resched in all spin_unlock and to avoid
> kernel crashes if some driver is not preempt complaint?
> 

Well I don't know how good an argument the crashes one is these days,
but generally (as far as I know) those who really care about latency
shouldn't mind about some extra overheads.

Now I don't disagree with some cond_rescheds for places where !PREEMPT
latency would otherwise be massive, but cases like doing cond_resched
for every page in the scanner is something that you could say is imposing
overhead on people who *don't* want it (ie !PREEMPT).

> I've a better question for you, why would someone ever disable
> CONFIG_PREEMPT_VOLUNTARY? That config option is a nosense as far as I
> can tell. If something it should be renamed to
> "CONFIG_I_DON_T_WANT_TO_RUN_THE_OLD_KERNEL_CODE" ;)
> 

:) I don't think Ingo intended this for merging as is. Maybe it is to
test how much progress he has made.
