Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262476AbVCJJiy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262476AbVCJJiy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 04:38:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262478AbVCJJix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 04:38:53 -0500
Received: from cpe-24-94-57-164.stny.res.rr.com ([24.94.57.164]:59798 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262476AbVCJJh6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 04:37:58 -0500
Date: Thu, 10 Mar 2005 04:37:56 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
Reply-To: rostedt@goodmis.org
To: Lee Revell <rlrevell@joe-job.com>
cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc3-V0.7.38-01
In-Reply-To: <1108789704.8411.9.camel@krustophenia.net>
Message-ID: <Pine.LNX.4.58.0503100323370.14016@localhost.localdomain>
References: <20050204100347.GA13186@elte.hu> <1108789704.8411.9.camel@krustophenia.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Ingo,

I notice a problem with the bit_spin_locks that would probably explain the
kjournald latency problems. I'm working on a custom kernel based on your's
and I needed to temporarily remove the scheduler_tick from
update_process_times to implement some special scheduling needs.  This
caused kjournal to go into an infinite loop.

Here's your bit_spin_lock:

static inline void bit_spin_lock(int bitnum, unsigned long *addr)
{
	/*
	 * Assuming the lock is uncontended, this never enters
	 * the body of the outer loop. If it is contended, then
	 * within the inner loop a non-atomic test is used to
	 * busywait with less bus contention for a good time to
	 * attempt to acquire the lock bit.
	 */
#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK) ||
defined(CONFIG_PREEMPT)
	while (test_and_set_bit(bitnum, addr))
		while (test_bit(bitnum, addr))
			cpu_relax();
#endif
	__acquire(bitlock);
}


You removed the preempt disable and added the CONFIG_PREEMPT. What happens
if a lower priority process gets the bit lock and gets preempted by a
higher priority process that then tries to get this lock. It spins until
it's quota runs out.  This is what is happening to kjournald. A lower
priority process gets the bit lock and kjournald preempts it causing
kjournald to spin until it's quota is up to let the other process
release the lock.  Now, luckly your kernel kjournald is not realtime
FIFO. If it were, you would than have a deadlock, try it. I just set
kjournald (using your kernel) to FIFO prio 42 (prio 58 inside the kernel),
and with a non-rt task, I did a build of the kernel.  After a minute or
two, all processes under the priority of kjournald were starved out of the
CPU, and kjournald was spinning.  Make sure your kjournald has a lower
prioirty than your interrupt threads.

The culprit is jbd_lock_bh_state and jbd_lock_bh_journal_head which call
bit_spin_lock.

Example of long latency: (or deadlock)

journal_refile_buffer
   --> spin_lock(&journal->j_list_lock);
   --> journal_remove_journal_head(bh);
         --> jbd_lock_bh_journal_head(bh);
               --> bit_spin_lock(BH_JournalHead, &bh->b_state);

The short term fix is probably to put back the preempt_disables, the long
term is to get rid of these stupid bit_spin_lock busy loops.

-- Steve


On Sat, 19 Feb 2005, Lee Revell wrote:

> On Fri, 2005-02-04 at 11:03 +0100, Ingo Molnar wrote:
> >   http://redhat.com/~mingo/realtime-preempt/
> >
>
> Testing on an all SCSI 1.3Ghz Athlon XP system, I am seeing very long
> latencies in the journalling code with 2.6.11-rc4-RT-V0.7.39-02.
>
> preemption latency trace v1.1.4 on 2.6.11-rc4-RT-V0.7.39-02
> --------------------------------------------------------------------
>  latency: 713 탎, #3455/3455, CPU#0 | (M:preempt VP:0, KP:1, SP:1 HP:1 #P:1)
>     -----------------
>     | task: ksoftirqd/0-2 (uid:0 nice:-10 policy:0 rt_prio:0)
>     -----------------
>
>                  _------=> CPU#
>                 / _-----=> irqs-off
>                | / _----=> need-resched
>                || / _---=> hardirq/softirq
>                ||| / _--=> preempt-depth
>                |||| /
>                |||||     delay
>    cmd     pid ||||| time  |   caller
>       \   /    |||||   \   |   /
> kjournal-2478  0dn.4    0탎!: <756f6a6b> (<6c616e72>)
> kjournal-2478  0dn.4    0탎 : __trace_start_sched_wakeup (try_to_wake_up)
> kjournal-2478  0dn.3    0탎 : preempt_schedule (try_to_wake_up)
> kjournal-2478  0dn.3    0탎 : try_to_wake_up <<...>-2> (69 73):
> kjournal-2478  0dn.2    0탎 : preempt_schedule (try_to_wake_up)
> kjournal-2478  0dn.2    0탎 : wake_up_process (do_softirq)
> kjournal-2478  0dn.1    1탎 < (1)
>
> The repeating pattern is 8 of these:
>
> kjournal-2478  0.n.1    1탎 : inverted_lock (journal_commit_transaction)
> kjournal-2478  0.n.1    1탎 : __journal_unfile_buffer (journal_commit_transaction)
> kjournal-2478  0.n.1    1탎 : journal_remove_journal_head (journal_commit_transaction)
> kjournal-2478  0.n.1    1탎 : __journal_remove_journal_head (journal_remove_journal_head)
> kjournal-2478  0.n.1    1탎 : __brelse (__journal_remove_journal_head)
> kjournal-2478  0.n.1    1탎 : journal_free_journal_head (journal_remove_journal_head)
> kjournal-2478  0.n.1    2탎 : kmem_cache_free (journal_free_journal_head)
>
> and one of these:
>
> kjournal-2478  0dn.1    9탎 : cache_flusharray (kmem_cache_free)
> kjournal-2478  0dn.2    9탎 : free_block (cache_flusharray)
> kjournal-2478  0dn.1   11탎 : preempt_schedule (cache_flusharray)
> kjournal-2478  0dn.1   11탎 : memmove (cache_flusharray)
> kjournal-2478  0dn.1   11탎 : memcpy (memmove)
>
> etc.  Finally:
>
> kjournal-2478  0dn.1  704탎 : cache_flusharray (kmem_cache_free)
> kjournal-2478  0dn.2  704탎+: free_block (cache_flusharray)
> kjournal-2478  0dn.1  707탎 : preempt_schedule (cache_flusharray)
> kjournal-2478  0dn.1  707탎 : memmove (cache_flusharray)
> kjournal-2478  0dn.1  707탎 : memcpy (memmove)
> kjournal-2478  0.n.1  708탎 : inverted_lock (journal_commit_transaction)
> kjournal-2478  0.n.1  708탎 : __journal_unfile_buffer (journal_commit_transaction)
> kjournal-2478  0.n.1  709탎 : journal_remove_journal_head (journal_commit_transaction)
> kjournal-2478  0.n.1  709탎 : __journal_remove_journal_head (journal_remove_journal_head)
> kjournal-2478  0.n.1  709탎 : __brelse (__journal_remove_journal_head)
> kjournal-2478  0.n.1  709탎 : journal_free_journal_head (journal_remove_journal_head)
> kjournal-2478  0.n.1  709탎 : kmem_cache_free (journal_free_journal_head)
> kjournal-2478  0.n..  710탎 : preempt_schedule (journal_commit_transaction)
> kjournal-2478  0dn..  710탎 : __schedule (preempt_schedule)
> kjournal-2478  0dn..  710탎 : profile_hit (__schedule)
> kjournal-2478  0dn.1  710탎 : sched_clock (__schedule)
> kjournal-2478  0dn.2  711탎 : dequeue_task (__schedule)
> kjournal-2478  0dn.2  711탎 : recalc_task_prio (__schedule)
> kjournal-2478  0dn.2  711탎 : effective_prio (recalc_task_prio)
> kjournal-2478  0dn.2  711탎 : enqueue_task (__schedule)
>    <...>-2     0d..2  712탎 : __switch_to (__schedule)
>    <...>-2     0d..2  712탎 : __schedule <kjournal-2478> (73 69):
>    <...>-2     0d..2  712탎 : finish_task_switch (__schedule)
>    <...>-2     0d..1  712탎 : trace_stop_sched_switched (finish_task_switch)
>    <...>-2     0d..1  712탎 : trace_stop_sched_switched <<...>-2> (69 0):
>    <...>-2     0d..1  713탎 : trace_stop_sched_switched (finish_task_switch)
>
> Lee
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
