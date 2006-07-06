Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965192AbWGFQzM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965192AbWGFQzM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 12:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbWGFQzL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 12:55:11 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:57116 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750793AbWGFQzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 12:55:10 -0400
Message-ID: <44AD406A.7090709@de.ibm.com>
Date: Thu, 06 Jul 2006 18:55:06 +0200
From: Martin Peschke <mp3@de.ibm.com>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: heiko.carstens@de.ibm.com, clg@fr.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [Patch] statistics infrastructure - update 9
References: <1151943862.2936.10.camel@dyn-9-152-230-71.boeblingen.de.ibm.com> <p73ac7qql4a.fsf@verdi.suse.de>
In-Reply-To: <p73ac7qql4a.fsf@verdi.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Martin Peschke <mp3@de.ibm.com> writes:
>>  {
>> -#ifdef CONFIG_STATISTICS
>>  	unsigned long flags;
>>  	local_irq_save(flags);
>>  	_statistic_add_as(type, stat, i, value, incr);
>>  	local_irq_restore(flags);
> 
> 
> Is there a particular reason you can't use local_t with cpu_local_*?
> It would be faster on many architectures than local_irq_save/restore
> 
> -Andi

Good question. Btw. - faster by what order of magnitude?
local_irq_save/restore seems to be fine for kernel/profile.c


Reason 1:
cpu_local_* uses __get_cpu_var, which conflicts with struct statistic
being embedded into struct xyz that is allocated whenever the client
needs it.

I could try to use local_t in conjunction with local_add etc.
(as seen in include/linux/dmaengine.h in 2.6.17-mm6).
Does this also yield a performance gain worth consideration?


Reason 2:
Then, the other use of local_irq_save/restore is to avoid races
regarding statistics being switched on or off, and it's underlying
buffers being released:

void _statistic_add(struct statistic *stat, int i, s64 value, u64 incr)
{
         if (stat[i].state == STATISTIC_STATE_ON)
                 stat[i].add(&stat[i], value, incr);
}

void statistic_add(struct statistic *stat, int i, s64 value, u64 incr)
{
         unsigned long flags;
         local_irq_save(flags);
         _statistic_add(stat, i, value, incr);
         local_irq_restore(flags);
}

static int statistic_stop(struct statistic *stat)
{
         stat->stopped = timestamp_clock();
         stat->state = STATISTIC_STATE_OFF;
         /* ensures that all CPUs have ceased updating statistics */
         smp_mb();
         on_each_cpu(_statistic_barrier, NULL, 0, 1);
         return 0;
}

So, removing local_irq_save/restore would require statistics to be
switched on and their buffers being available all the time. That is,
buffers holding counters etc. can't be allocated at run time - what
if allocation fails? (Should I leave this issue to clients?).

All the buffers for per-cpu counters etc. would need to be embedded
into the client's struct xyz. There would be no way that users
could change, for example, the number of buckets of a histogram.

Everything would be fixed. Which might be fine for some purposes;
particularly for a plain counter which will only be used as a
counter, and which will never be inflated to a histogram or whatever.

In short, I could try to add a per-cpu array of local_t's to struct
statistic and write up another statistic_add()-variant, which would be
limited to aggregating data into a counter using local_add(), without
doing local_irq_save/restore, and without checking whether data
gathering has been turned on. Which would resemble Christoph
Lameter's light-weight VM counters to some degree. With the downside
of struct statistic being inflated for everyone else.


Reason 3:
local_add() & friends won't suffice for some algorithms:

void statistic_add_util(struct statistic *stat, s64 value, u64 incr)
{
	/*...snip...*/
         if (unlikely(value < util->min))
                 util->min = value;
         if (unlikely(value > util->max))
                 util->max = value;
}

static void _statistic_add_sparse(struct statistic_sparse_list *slist,
                                   s64 value, u64 incr)
{
         struct list_head *head = &slist->entry_lh;
         struct statistic_entry_sparse *entry;

         list_for_each_entry(entry, head, list) {
                 if (likely(entry->value == value)) {
                         entry->hits += incr;
                         statistic_add_sparse_sort(head, entry);
                         return;
                 }
         }
         if (unlikely(statistic_add_sparse_new(slist, value, incr)))
                 slist->hits_missed += incr;
}


Reason 4:
The alleged overhead of local_irq_save/restore (as compared
to atomic operations) might be less significant for clients updating
a bunch of statistics in one go:

	unsigned long flags;

	local_irq_save(flags);
	_statistic_inc(dev->stat, MYSTAT_SIZE, size);
	_statistic_inc(dev->stat, MYSTAT_LATENCY, latency);
	_statistic_inc(dev->stat, MYSTAT_RESULT, result);
	local_irq_restore(flags);

