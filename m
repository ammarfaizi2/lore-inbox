Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314280AbSEZXDf>; Sun, 26 May 2002 19:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316456AbSEZXDe>; Sun, 26 May 2002 19:03:34 -0400
Received: from holomorphy.com ([66.224.33.161]:55718 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S314280AbSEZXDe>;
	Sun, 26 May 2002 19:03:34 -0400
Date: Sun, 26 May 2002 16:03:19 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Robert Love <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, torvalds@transmeta.com
Subject: Re: O(1) count_active_tasks()
Message-ID: <20020526230319.GN14918@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org,
	mingo@elte.hu, torvalds@transmeta.com
In-Reply-To: <20020526035115.GM14918@holomorphy.com> <1022451477.20316.24.camel@sinai>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-05-25 at 20:51, William Lee Irwin III wrote:
>> rml, I heard you're interested in this, but regardless, here it is.
>> AFAICT it computes a faithful load average. Against latest 2.5.18 bk.
>> rml, don't worry about stomping on this if you need the counters
>> ticking for something else and you can do the same thing(s).

On Sun, May 26, 2002 at 03:17:52PM -0700, Robert Love wrote:
> I like.  Very clean.

Thanks, I took some time to go over it and make it so, as I don't
really do scheduling, I just needed a statistic there for this. It's
not actually claimed to have any optimization value (though it may as
a side-effect), it only addresses a pet peeve of mine. I originally
tried avoiding sched.c by having set_current_state() tick per-cpu
counters but that caused enormous code bloat (or did as I wrote it).


On Sun, May 26, 2002 at 03:17:52PM -0700, Robert Love wrote:
> One question...
>>  	rq = task_rq_lock(p, &flags);
>> +	if (p->state == TASK_UNINTERRUPTIBLE)
>> +		uninterruptible = 1;
>>  	p->state = TASK_RUNNING;
>>  	if (!p->array) {
>> +		if (uninterruptible)
>> +			rq->nr_uninterruptible--;
>>  		activate_task(p, rq);
>>  		if (p->prio < rq->curr->prio)
>>  			resched_task(rq->curr);
>
> Why only decrement nr_uninterruptible if it is not already on a
> runqueue?  I suspect because then you assume it is a spurious wakeup and
> did not have a corresponding deactivate_task?  Same reason we increment
> nr_running in activate_task and not here, I suspect... makes sense.

When it was not there load averages were dramatically unfaithful, and I
traced down the cause of that to this branch.


On Sun, May 26, 2002 at 03:17:52PM -0700, Robert Love wrote:
> One thought on a quick way to test if the new method is returning
> accurate results would be to leave the current count_active_task code
> and then add:
> 	if (nr != (nr_running() + nr_uninterruptible()))
> 		printk("Danger Will Robinson!\n");
> but you probably already did something similar.
> 	Robert Love

This is an approximate method. I did not collect detailed statistics on
how widely it varied from the prior method, though I did manually check
the results against mainline for large variations or gross unfaithfulness.
If you'd like to hold off on this until I do so, that's fine. I can get
back to my SMP targets Tuesday and follow up then.

Going back and looking at it, weaker memory consistency models may want
the increment/decrement to be atomic operations, which would probably
want some migration code to keep the counters positive. I can arrange
that for a follow-up as well.


Thanks,
Bill
