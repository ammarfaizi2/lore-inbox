Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932387AbVL0X1p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932387AbVL0X1p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 18:27:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932389AbVL0X1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 18:27:45 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:52369 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932387AbVL0X1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 18:27:44 -0500
Subject: 2.6.15-rc5: latency regression vs 2.6.14 in
	exit_mmap->free_pgtables
From: Lee Revell <rlrevell@joe-job.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Hugh Dickins <hugh@veritas.com>,
       Linus Torvalds <torvalds@osdl.org>
Content-Type: text/plain
Date: Tue, 27 Dec 2005 18:31:40 -0500
Message-Id: <1135726300.22744.25.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am seeing excessive latencies (2ms+) in free_pgtables, called from
exit_mmap with 2.6.15-rc5.  This is a significant regression from 2.6.14
where the maximum observed latency was less than 1ms with some tuning.
Here is the trace.

(Although the trace was captured with the -rt kernel I am only using it
for the instrumentation features - all preemption settings are the same
as mainline with PREEMPT)

preemption latency trace v1.1.5 on 2.6.15-rc5-rt4
--------------------------------------------------------------------
 latency: 2267 us, #2632/2632, CPU#0 | (M:preempt VP:0, KP:0, SP:0 HP:0)
    -----------------
    | task: softirq-timer/0-3 (uid:0 nice:0 policy:1 rt_prio:1)
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
evolutio-4728  0D.h2    0us : __trace_start_sched_wakeup (try_to_wake_up)
evolutio-4728  0D.h2    1us : __trace_start_sched_wakeup <<...>-3> (62 0)
evolutio-4728  0D.h.    2us : wake_up_process (wakeup_softirqd)
evolutio-4728  0D.h.    3us : scheduler_tick (update_process_times)
evolutio-4728  0D.h.    3us : sched_clock (scheduler_tick)
evolutio-4728  0D.h1    5us : task_timeslice (scheduler_tick)
evolutio-4728  0D.h.    6us : run_posix_cpu_timers (update_process_times)
evolutio-4728  0D.h1    7us : note_interrupt (__do_IRQ)
evolutio-4728  0D.h1    7us : end_8259A_irq (__do_IRQ)
evolutio-4728  0D.h1    8us : enable_8259A_irq (end_8259A_irq)
evolutio-4728  0Dnh1   10us : irq_exit (do_IRQ)
evolutio-4728  0Dn.1   11us < (608)
evolutio-4728  0.n.1   11us : unlink_file_vma (free_pgtables)
evolutio-4728  0.n.2   12us : __remove_shared_vm_struct (unlink_file_vma)
evolutio-4728  0.n.2   13us : vma_prio_tree_remove (__remove_shared_vm_struct)
evolutio-4728  0.n.2   13us : prio_tree_remove (vma_prio_tree_remove)
evolutio-4728  0.n.1   14us : preempt_schedule (unlink_file_vma)
evolutio-4728  0.n.1   15us : anon_vma_unlink (free_pgtables)
evolutio-4728  0.n.1   16us : unlink_file_vma (free_pgtables)
evolutio-4728  0.n.2   17us : __remove_shared_vm_struct (unlink_file_vma)
evolutio-4728  0.n.2   17us : vma_prio_tree_remove (__remove_shared_vm_struct)
evolutio-4728  0.n.2   18us : prio_tree_remove (vma_prio_tree_remove)
evolutio-4728  0.n.2   19us : prio_tree_replace (prio_tree_remove)
evolutio-4728  0.n.1   20us : preempt_schedule (unlink_file_vma)
evolutio-4728  0.n.1   21us : anon_vma_unlink (free_pgtables)
evolutio-4728  0.n.1   22us : preempt_schedule (anon_vma_unlink)
evolutio-4728  0.n.1   23us : kmem_cache_free (anon_vma_unlink)
evolutio-4728  0.n.1   24us : unlink_file_vma (free_pgtables)

[...]

evolutio-4728  0.n.1 2239us : unlink_file_vma (free_pgtables)
evolutio-4728  0.n.1 2240us : anon_vma_unlink (free_pgtables)
evolutio-4728  0.n.1 2241us : preempt_schedule (anon_vma_unlink)
evolutio-4728  0.n.1 2241us : kmem_cache_free (anon_vma_unlink)
evolutio-4728  0.n.1 2242us : unlink_file_vma (free_pgtables)
evolutio-4728  0.n.1 2243us : free_pgd_range (free_pgtables)
evolutio-4728  0.n.1 2243us : free_pte_range (free_pgd_range)
evolutio-4728  0.n.1 2244us : free_page_and_swap_cache (free_pte_range)
evolutio-4728  0.n.1 2245us : put_page (free_page_and_swap_cache)
evolutio-4728  0.n.1 2245us : __page_cache_release (put_page)
evolutio-4728  0.n.1 2246us : preempt_schedule (__page_cache_release)
evolutio-4728  0.n.1 2247us : free_hot_page (__page_cache_release)
evolutio-4728  0.n.1 2248us : free_hot_cold_page (free_hot_page)
evolutio-4728  0.n.1 2248us : __mod_page_state (free_hot_cold_page)
evolutio-4728  0.n.1 2250us : preempt_schedule (free_hot_cold_page)
evolutio-4728  0.n.1 2250us : __mod_page_state (free_pte_range)
evolutio-4728  0.n.. 2252us : preempt_schedule (exit_mmap)
evolutio-4728  0Dn.. 2252us : __schedule (preempt_schedule)
evolutio-4728  0Dn.. 2254us : profile_hit (__schedule)
evolutio-4728  0Dn.1 2255us+: sched_clock (__schedule)
   <...>-3     0D..2 2259us+: __switch_to (__schedule)
   <...>-3     0D..2 2262us : __schedule <evolutio-4728> (74 62)
   <...>-3     0...1 2263us : trace_stop_sched_switched (__schedule)
   <...>-3     0D..2 2264us+: trace_stop_sched_switched <<...>-3> (62 0)
   <...>-3     0D..2 2266us : trace_stop_sched_switched (__schedule)

The problem is that we now do a lot more work in free_pgtables under the
mm->page_table_lock spinlock so preemption can be delayed for a long
time.  Here is the change responsible:

--- ../linux-2.6.14-rt22/mm/memory.c    2005-12-05 14:47:02.000000000 -0500
+++ ../linux-2.6.15-rc5-rt2/mm/memory.c 2005-12-22 16:35:26.000000000 -0500
@@ -260,6 +261,12 @@
                struct vm_area_struct *next = vma->vm_next;
                unsigned long addr = vma->vm_start;
 
+               /*
+                * Hide vma from rmap and vmtruncate before freeing pgtables
+                */
+               anon_vma_unlink(vma);
+               unlink_file_vma(vma);
+
                if (is_hugepage_only_range(vma->vm_mm, addr, HPAGE_SIZE)) {
                        hugetlb_free_pgd_range(tlb, addr, vma->vm_end,
                                floor, next? next->vm_start: ceiling);
@@ -272,6 +279,8 @@
                                                        HPAGE_SIZE)) {
                                vma = next; 
                                next = vma->vm_next;
+                               anon_vma_unlink(vma);
+                               unlink_file_vma(vma);
                        }
                        free_pgd_range(tlb, addr, vma->vm_end,
                                floor, next? next->vm_start: ceiling);

What was the purpose of this change?

Lee



