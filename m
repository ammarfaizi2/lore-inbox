Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964822AbWENA3z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964822AbWENA3z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 20:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964828AbWENA3z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 20:29:55 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:11989 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S964822AbWENA3y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 20:29:54 -0400
Subject: Re: [RFC, PATCH] cond_resched() added to close_files()
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, dada1@cosmosbay.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060512102057.GA22985@elte.hu>
References: <20060419112130.GA22648@elte.hu> <44577822.8050103@mbligh.org>
	 <20060502155244.GA5981@elte.hu> <200605022155.31990.dada1@cosmosbay.com>
	 <20060503070152.GB23921@elte.hu> <20060512024446.00a0b407.akpm@osdl.org>
	 <20060512102057.GA22985@elte.hu>
Content-Type: text/plain
Date: Sat, 13 May 2006 20:09:49 -0400
Message-Id: <1147565389.6535.331.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-05-12 at 12:20 +0200, Ingo Molnar wrote:
> * Andrew Morton <akpm@osdl.org> wrote:
> 
> > Makes my machine hang early during the startup of init.
> > 
> > The last process to pass through close_file() is `hostname', presuably 
> > parented by init.  `hostname' exits then everything stops.  init is 
> > left sleeping in select().
> > 
> > All very strange.
> 
> weird. This really shouldnt cause a hang - i think there must be a bug 
> hiding elsewhere, this cond_resched() ought to be fine.
> 

Ingo,

Would this be the latency it fixes? (seen with 2.6.16):

preemption latency trace v1.1.5 on 2.6.16
--------------------------------------------------------------------
 latency: 9313 us, #12766/12766, CPU#0 | (M:rt VP:0, KP:0, SP:0 HP:0)
    -----------------
    | task: jackd-26580 (uid:1000 nice:0 policy:1 rt_prio:80)
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
ldconfig-26779 0d.h5    0us : __trace_start_sched_wakeup
(try_to_wake_up)
ldconfig-26779 0d.h5    1us : __trace_start_sched_wakeup <<...>-26580>
(13 0)
ldconfig-26779 0d.h.    2us : kill_fasync (snd_pcm_period_elapsed)
ldconfig-26779 0d.h.    3us : snd_emu10k1_voice_intr_ack
(snd_emu10k1_interrupt)
ldconfig-26779 0d.h.    5us+: snd_emu10k1_ptr_read
(snd_emu10k1_interrupt)
ldconfig-26779 0d.h.    8us+: snd_emu10k1_ptr_read
(snd_emu10k1_interrupt)
ldconfig-26779 0d.h1   12us : note_interrupt (__do_IRQ)
ldconfig-26779 0d.h1   13us : end_8259A_irq (__do_IRQ)
ldconfig-26779 0d.h1   13us : enable_8259A_irq (end_8259A_irq)
ldconfig-26779 0dnh2   15us : irq_exit (do_IRQ)
ldconfig-26779 0dn.2   16us < (2097760)
ldconfig-26779 0dn.2   17us : preempt_schedule (find_get_page)
ldconfig-26779 0dn.2   18us : put_page (free_file)
ldconfig-26779 0dn.2   18us : free_file (unmap_vmas)
ldconfig-26779 0dn.2   19us : find_get_page (free_file)
ldconfig-26779 0dn.3   20us : radix_tree_lookup (find_get_page)
ldconfig-26779 0dn.2   20us : preempt_schedule (find_get_page)
ldconfig-26779 0dn.2   21us : put_page (free_file)
ldconfig-26779 0dn.2   22us : free_file (unmap_vmas)
ldconfig-26779 0dn.2   22us : find_get_page (free_file)
ldconfig-26779 0dn.3   23us : radix_tree_lookup (find_get_page)
ldconfig-26779 0dn.2   24us : preempt_schedule (find_get_page)
ldconfig-26779 0dn.2   24us : put_page (free_file)
ldconfig-26779 0dn.2   25us : free_file (unmap_vmas)
ldconfig-26779 0dn.2   26us : find_get_page (free_file)
ldconfig-26779 0dn.3   26us : radix_tree_lookup (find_get_page)
ldconfig-26779 0dn.2   27us : preempt_schedule (find_get_page)

(...)

ldconfig-26779 0dn.2 9256us : put_page (free_file)
ldconfig-26779 0dn.2 9256us : free_file (unmap_vmas)
ldconfig-26779 0dn.2 9257us : find_get_page (free_file)
ldconfig-26779 0dn.3 9258us : radix_tree_lookup (find_get_page)
ldconfig-26779 0dn.2 9259us : preempt_schedule (find_get_page)
ldconfig-26779 0dn.2 9259us : put_page (free_file)
ldconfig-26779 0dn.2 9260us : free_file (unmap_vmas)
ldconfig-26779 0dn.2 9261us : find_get_page (free_file)
ldconfig-26779 0dn.3 9261us : radix_tree_lookup (find_get_page)
ldconfig-26779 0dn.2 9262us : preempt_schedule (find_get_page)
ldconfig-26779 0dn.2 9263us : put_page (free_file)
ldconfig-26779 0dn.1 9263us+: preempt_schedule (unmap_vmas)
ldconfig-26779 0dn.1 9266us : free_pgtables (unmap_region)
ldconfig-26779 0dn.1 9267us : anon_vma_unlink (free_pgtables)
ldconfig-26779 0dn.1 9269us : unlink_file_vma (free_pgtables)
ldconfig-26779 0dn.2 9269us : __remove_shared_vm_struct
(unlink_file_vma)
ldconfig-26779 0dn.2 9270us : vma_prio_tree_remove
(__remove_shared_vm_struct)
ldconfig-26779 0dn.2 9271us : prio_tree_remove (vma_prio_tree_remove)
ldconfig-26779 0dn.1 9273us : preempt_schedule (unlink_file_vma)
ldconfig-26779 0dn.1 9274us : free_pgd_range (free_pgtables)
ldconfig-26779 0dn.1 9275us : free_page_and_swap_cache (free_pgd_range)
ldconfig-26779 0dn.1 9276us : put_page (free_page_and_swap_cache)
ldconfig-26779 0dn.1 9277us : __page_cache_release (put_page)
ldconfig-26779 0dn.1 9278us : preempt_schedule (__page_cache_release)
ldconfig-26779 0dn.1 9279us : free_hot_page (__page_cache_release)
ldconfig-26779 0dn.1 9279us : free_hot_cold_page (free_hot_page)
ldconfig-26779 0dn.2 9280us : __mod_page_state_offset
(free_hot_cold_page)
ldconfig-26779 0dn.1 9281us : preempt_schedule (free_hot_cold_page)
ldconfig-26779 0dn.1 9282us : mod_page_state_offset (free_pgd_range)
ldconfig-26779 0dn.1 9283us : free_page_and_swap_cache (free_pgd_range)
ldconfig-26779 0dn.1 9284us : put_page (free_page_and_swap_cache)
ldconfig-26779 0dn.1 9285us : __page_cache_release (put_page)
ldconfig-26779 0dn.1 9285us : preempt_schedule (__page_cache_release)
ldconfig-26779 0dn.1 9286us : free_hot_page (__page_cache_release)
ldconfig-26779 0dn.1 9287us : free_hot_cold_page (free_hot_page)
ldconfig-26779 0dn.2 9287us : __mod_page_state_offset
(free_hot_cold_page)
ldconfig-26779 0dn.1 9288us : preempt_schedule (free_hot_cold_page)
ldconfig-26779 0dn.1 9289us : mod_page_state_offset (free_pgd_range)
ldconfig-26779 0dn.1 9290us : free_page_and_swap_cache (free_pgd_range)
ldconfig-26779 0dn.1 9291us : put_page (free_page_and_swap_cache)
ldconfig-26779 0dn.1 9291us : __page_cache_release (put_page)
ldconfig-26779 0dn.1 9292us : preempt_schedule (__page_cache_release)
ldconfig-26779 0dn.1 9293us : free_hot_page (__page_cache_release)
ldconfig-26779 0dn.1 9293us : free_hot_cold_page (free_hot_page)
ldconfig-26779 0dn.2 9294us : __mod_page_state_offset
(free_hot_cold_page)
ldconfig-26779 0dn.1 9295us : preempt_schedule (free_hot_cold_page)
ldconfig-26779 0dn.1 9295us : mod_page_state_offset (free_pgd_range)
ldconfig-26779 0dn.. 9297us : preempt_schedule (unmap_region)
ldconfig-26779 0dn.. 9298us : schedule (preempt_schedule)
ldconfig-26779 0dn.. 9298us : profile_hit (schedule)
ldconfig-26779 0dn.1 9299us+: sched_clock (schedule)
   <...>-26580 0d..2 9306us+: __switch_to (schedule)
   <...>-26580 0d..2 9309us : schedule <ldconfig-26779> (76 13)
   <...>-26580 0d..1 9310us : trace_stop_sched_switched (schedule)
   <...>-26580 0d..2 9310us : trace_stop_sched_switched <<...>-26580>
(13 0)
   <...>-26580 0d..2 9312us : schedule (schedule)

Lee

