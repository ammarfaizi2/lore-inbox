Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751953AbWCNQPb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751953AbWCNQPb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 11:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752045AbWCNQPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 11:15:31 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:3787 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751953AbWCNQPb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 11:15:31 -0500
Subject: 2.6.16-rc1: 28ms latency when process with lots of swapped memory
	exits
From: Lee Revell <rlrevell@joe-job.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Hugh Dickins <hugh@veritas.com>
Content-Type: text/plain
Date: Tue, 14 Mar 2006 11:15:25 -0500
Message-Id: <1142352926.13256.117.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.92 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been testign for weeks with 2.6.16-rc1 + the latency trace patch
and the longest latencies measured were 10-15ms due to the well known
rt_run_flush issue.  Today I got one twice as long, when a Firefox
process with a bunch of acroreads in tabs, from a new code path.

It seems to trigger when a process with a large amount of memory swapped
out exits.

Can this be solved with a cond_resched?

preemption latency trace v1.1.5 on 2.6.16-rc1
--------------------------------------------------------------------
 latency: 28130 us, #38020/38020, CPU#0 | (M:rt VP:0, KP:0, SP:0 HP:0)
    -----------------
    | task: acroread-29870 (uid:1000 nice:0 policy:0 rt_prio:0)
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
    Xorg-18254 0d.s2    1us : __trace_start_sched_wakeup (try_to_wake_up)
    Xorg-18254 0d.s2    1us : __trace_start_sched_wakeup <<...>-29870> (73 0)
    Xorg-18254 0d.s.    2us : wake_up_process (process_timeout)
    Xorg-18254 0dn.2    3us < (2110048)
    Xorg-18254 0dn.2    4us : preempt_schedule (free_swap_and_cache)
    Xorg-18254 0dn.2    5us : free_swap_and_cache (unmap_vmas)
    Xorg-18254 0dn.2    6us : swap_info_get (free_swap_and_cache)
    Xorg-18254 0dn.3    6us : swap_entry_free (free_swap_and_cache)
    Xorg-18254 0dn.3    7us : find_trylock_page (free_swap_and_cache)
    Xorg-18254 0dn.4    8us : radix_tree_lookup (find_trylock_page)
    Xorg-18254 0dn.3    8us : preempt_schedule (find_trylock_page)
    Xorg-18254 0dn.2    9us : preempt_schedule (free_swap_and_cache)
    Xorg-18254 0dn.2   10us : free_swap_and_cache (unmap_vmas)
    Xorg-18254 0dn.2   11us : swap_info_get (free_swap_and_cache)
    Xorg-18254 0dn.3   12us : swap_entry_free (free_swap_and_cache)
    Xorg-18254 0dn.3   12us : find_trylock_page (free_swap_and_cache)
    Xorg-18254 0dn.4   13us : radix_tree_lookup (find_trylock_page)
    Xorg-18254 0dn.3   14us : preempt_schedule (find_trylock_page)
    Xorg-18254 0dn.2   14us : preempt_schedule (free_swap_and_cache)
    Xorg-18254 0dn.2   15us : free_swap_and_cache (unmap_vmas)
    Xorg-18254 0dn.2   16us : swap_info_get (free_swap_and_cache)
    Xorg-18254 0dn.3   16us : swap_entry_free (free_swap_and_cache)
    Xorg-18254 0dn.3   17us : find_trylock_page (free_swap_and_cache)
    Xorg-18254 0dn.4   18us : radix_tree_lookup (find_trylock_page)
    Xorg-18254 0dn.3   19us : preempt_schedule (find_trylock_page)
    Xorg-18254 0dn.2   19us : preempt_schedule (free_swap_and_cache)
    Xorg-18254 0dn.2   20us : free_swap_and_cache (unmap_vmas)
    Xorg-18254 0dn.2   21us : swap_info_get (free_swap_and_cache)
    Xorg-18254 0dn.3   21us : swap_entry_free (free_swap_and_cache)
    Xorg-18254 0dn.3   22us : find_trylock_page (free_swap_and_cache)
    Xorg-18254 0dn.4   23us : radix_tree_lookup (find_trylock_page)
    Xorg-18254 0dn.3   23us : preempt_schedule (find_trylock_page)
    Xorg-18254 0dn.2   24us : preempt_schedule (free_swap_and_cache)
    Xorg-18254 0dn.2   25us : free_swap_and_cache (unmap_vmas)
    Xorg-18254 0dn.2   25us : swap_info_get (free_swap_and_cache)
    Xorg-18254 0dn.3   26us : swap_entry_free (free_swap_and_cache)
    Xorg-18254 0dn.3   27us : find_trylock_page (free_swap_and_cache)
    Xorg-18254 0dn.4   27us : radix_tree_lookup (find_trylock_page)
    Xorg-18254 0dn.3   28us : preempt_schedule (find_trylock_page)
    Xorg-18254 0dn.2   29us : preempt_schedule (free_swap_and_cache)
    Xorg-18254 0dn.2   30us : free_swap_and_cache (unmap_vmas)
    Xorg-18254 0dn.2   30us : swap_info_get (free_swap_and_cache)
    Xorg-18254 0dn.3   31us : swap_entry_free (free_swap_and_cache)
    Xorg-18254 0dn.3   32us : find_trylock_page (free_swap_and_cache)
    Xorg-18254 0dn.4   32us : radix_tree_lookup (find_trylock_page)
    Xorg-18254 0dn.3   33us : preempt_schedule (find_trylock_page)
    Xorg-18254 0dn.2   34us : preempt_schedule (free_swap_and_cache)
    Xorg-18254 0dn.2   35us : free_swap_and_cache (unmap_vmas)
    Xorg-18254 0dn.2   35us : swap_info_get (free_swap_and_cache)
    Xorg-18254 0dn.3   36us : swap_entry_free (free_swap_and_cache)
    Xorg-18254 0dn.3   37us : find_trylock_page (free_swap_and_cache)
    Xorg-18254 0dn.4   37us : radix_tree_lookup (find_trylock_page)
    Xorg-18254 0dn.3   38us : preempt_schedule (find_trylock_page)
    Xorg-18254 0dn.2   39us : preempt_schedule (free_swap_and_cache)
    Xorg-18254 0dn.2   40us : free_swap_and_cache (unmap_vmas)
    Xorg-18254 0dn.2   40us : swap_info_get (free_swap_and_cache)
    Xorg-18254 0dn.3   41us : swap_entry_free (free_swap_and_cache)
    Xorg-18254 0dn.3   42us : find_trylock_page (free_swap_and_cache)
    Xorg-18254 0dn.4   42us : radix_tree_lookup (find_trylock_page)

[ etc ]

    Xorg-18254 0dn.2 28062us : free_swap_and_cache (unmap_vmas)
    Xorg-18254 0dn.2 28062us : swap_info_get (free_swap_and_cache)
    Xorg-18254 0dn.3 28063us : swap_entry_free (free_swap_and_cache)
    Xorg-18254 0dn.3 28064us : find_trylock_page (free_swap_and_cache)
    Xorg-18254 0dn.4 28064us : radix_tree_lookup (find_trylock_page)
    Xorg-18254 0dn.3 28065us : preempt_schedule (find_trylock_page)
    Xorg-18254 0dn.2 28066us : preempt_schedule (free_swap_and_cache)
    Xorg-18254 0dn.1 28067us+: preempt_schedule (unmap_vmas)
    Xorg-18254 0dn.1 28073us+: preempt_schedule (unmap_vmas)
    Xorg-18254 0dn.1 28077us+: preempt_schedule (unmap_vmas)
    Xorg-18254 0dn.1 28083us+: preempt_schedule (unmap_vmas)
    Xorg-18254 0dn.1 28089us+: preempt_schedule (unmap_vmas)
    Xorg-18254 0dn.1 28095us+: preempt_schedule (unmap_vmas)
    Xorg-18254 0dn.1 28099us+: preempt_schedule (unmap_vmas)
    Xorg-18254 0dn.1 28101us+: preempt_schedule (unmap_vmas)
    Xorg-18254 0dn.1 28106us : preempt_schedule (unmap_vmas)
    Xorg-18254 0dn.2 28107us : vm_normal_page (unmap_vmas)
    Xorg-18254 0dn.2 28109us : vm_normal_page (unmap_vmas)
    Xorg-18254 0dn.2 28109us : vm_normal_page (unmap_vmas)
    Xorg-18254 0dn.2 28110us : vm_normal_page (unmap_vmas)
    Xorg-18254 0dn.1 28111us : preempt_schedule (unmap_vmas)
    Xorg-18254 0dn.. 28112us : preempt_schedule (unmap_vmas)
    Xorg-18254 0dn.. 28113us : schedule (preempt_schedule)
    Xorg-18254 0dn.. 28113us : stop_trace (schedule)
    Xorg-18254 0dn.. 28114us : profile_hit (schedule)
    Xorg-18254 0dn.1 28115us+: sched_clock (schedule)
    Xorg-18254 0dn.2 28117us : recalc_task_prio (schedule)
    Xorg-18254 0dn.2 28119us+: effective_prio (recalc_task_prio)
   <...>-29870 0d..2 28123us+: __switch_to (schedule)
   <...>-29870 0d..2 28126us : schedule <Xorg-18254> (76 73)
   <...>-29870 0d..1 28127us : trace_stop_sched_switched (schedule)
   <...>-29870 0d..2 28128us : trace_stop_sched_switched <<...>-29870> (73 0)
   <...>-29870 0d..2 28130us : schedule (schedule)


vim:ft=help





