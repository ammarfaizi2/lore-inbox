Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261626AbVBSFIe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261626AbVBSFIe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 00:08:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261632AbVBSFIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 00:08:34 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:7328 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261626AbVBSFI0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 00:08:26 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc3-V0.7.38-01
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050204100347.GA13186@elte.hu>
References: <20050204100347.GA13186@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1
Date: Sat, 19 Feb 2005 00:08:24 -0500
Message-Id: <1108789704.8411.9.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-02-04 at 11:03 +0100, Ingo Molnar wrote:
>   http://redhat.com/~mingo/realtime-preempt/
> 

Testing on an all SCSI 1.3Ghz Athlon XP system, I am seeing very long
latencies in the journalling code with 2.6.11-rc4-RT-V0.7.39-02.

preemption latency trace v1.1.4 on 2.6.11-rc4-RT-V0.7.39-02
--------------------------------------------------------------------
 latency: 713 탎, #3455/3455, CPU#0 | (M:preempt VP:0, KP:1, SP:1 HP:1 #P:1)
    -----------------
    | task: ksoftirqd/0-2 (uid:0 nice:-10 policy:0 rt_prio:0)
    -----------------

                 _------=> CPU#        
                / _-----=> irqs-off        
               | / _----=> need-resched    
               || / _---=> hardirq/softirq 
               ||| / _--=> preempt-depth   
               |||| /        
               |||||     delay        
   cmd     pid ||||| time  |   caller      
      \   /    |||||   \   |   /        
kjournal-2478  0dn.4    0탎!: <756f6a6b> (<6c616e72>)
kjournal-2478  0dn.4    0탎 : __trace_start_sched_wakeup (try_to_wake_up)
kjournal-2478  0dn.3    0탎 : preempt_schedule (try_to_wake_up)
kjournal-2478  0dn.3    0탎 : try_to_wake_up <<...>-2> (69 73): 
kjournal-2478  0dn.2    0탎 : preempt_schedule (try_to_wake_up)
kjournal-2478  0dn.2    0탎 : wake_up_process (do_softirq)
kjournal-2478  0dn.1    1탎 < (1)

The repeating pattern is 8 of these:

kjournal-2478  0.n.1    1탎 : inverted_lock (journal_commit_transaction)
kjournal-2478  0.n.1    1탎 : __journal_unfile_buffer (journal_commit_transaction)
kjournal-2478  0.n.1    1탎 : journal_remove_journal_head (journal_commit_transaction)
kjournal-2478  0.n.1    1탎 : __journal_remove_journal_head (journal_remove_journal_head)
kjournal-2478  0.n.1    1탎 : __brelse (__journal_remove_journal_head)
kjournal-2478  0.n.1    1탎 : journal_free_journal_head (journal_remove_journal_head)
kjournal-2478  0.n.1    2탎 : kmem_cache_free (journal_free_journal_head)

and one of these:

kjournal-2478  0dn.1    9탎 : cache_flusharray (kmem_cache_free)
kjournal-2478  0dn.2    9탎 : free_block (cache_flusharray)
kjournal-2478  0dn.1   11탎 : preempt_schedule (cache_flusharray)
kjournal-2478  0dn.1   11탎 : memmove (cache_flusharray)
kjournal-2478  0dn.1   11탎 : memcpy (memmove)

etc.  Finally:

kjournal-2478  0dn.1  704탎 : cache_flusharray (kmem_cache_free)
kjournal-2478  0dn.2  704탎+: free_block (cache_flusharray)
kjournal-2478  0dn.1  707탎 : preempt_schedule (cache_flusharray)
kjournal-2478  0dn.1  707탎 : memmove (cache_flusharray)
kjournal-2478  0dn.1  707탎 : memcpy (memmove)
kjournal-2478  0.n.1  708탎 : inverted_lock (journal_commit_transaction)
kjournal-2478  0.n.1  708탎 : __journal_unfile_buffer (journal_commit_transaction)
kjournal-2478  0.n.1  709탎 : journal_remove_journal_head (journal_commit_transaction)
kjournal-2478  0.n.1  709탎 : __journal_remove_journal_head (journal_remove_journal_head)
kjournal-2478  0.n.1  709탎 : __brelse (__journal_remove_journal_head)
kjournal-2478  0.n.1  709탎 : journal_free_journal_head (journal_remove_journal_head)
kjournal-2478  0.n.1  709탎 : kmem_cache_free (journal_free_journal_head)
kjournal-2478  0.n..  710탎 : preempt_schedule (journal_commit_transaction)
kjournal-2478  0dn..  710탎 : __schedule (preempt_schedule)
kjournal-2478  0dn..  710탎 : profile_hit (__schedule)
kjournal-2478  0dn.1  710탎 : sched_clock (__schedule)
kjournal-2478  0dn.2  711탎 : dequeue_task (__schedule)
kjournal-2478  0dn.2  711탎 : recalc_task_prio (__schedule)
kjournal-2478  0dn.2  711탎 : effective_prio (recalc_task_prio)
kjournal-2478  0dn.2  711탎 : enqueue_task (__schedule)
   <...>-2     0d..2  712탎 : __switch_to (__schedule)
   <...>-2     0d..2  712탎 : __schedule <kjournal-2478> (73 69):
   <...>-2     0d..2  712탎 : finish_task_switch (__schedule)
   <...>-2     0d..1  712탎 : trace_stop_sched_switched (finish_task_switch)
   <...>-2     0d..1  712탎 : trace_stop_sched_switched <<...>-2> (69 0):
   <...>-2     0d..1  713탎 : trace_stop_sched_switched (finish_task_switch)

Lee

