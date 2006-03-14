Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751199AbWCNSju@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbWCNSju (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 13:39:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbWCNSju
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 13:39:50 -0500
Received: from silver.veritas.com ([143.127.12.111]:58504 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1751199AbWCNSjt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 13:39:49 -0500
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.02,191,1139212800"; 
   d="scan'208"; a="35869181:sNHT26510308"
Date: Tue, 14 Mar 2006 18:40:46 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Lee Revell <rlrevell@joe-job.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.16-rc1: 28ms latency when process with lots of swapped memory
 exits
In-Reply-To: <1142352926.13256.117.camel@mindpipe>
Message-ID: <Pine.LNX.4.61.0603141812400.5882@goblin.wat.veritas.com>
References: <1142352926.13256.117.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 14 Mar 2006 18:39:48.0468 (UTC) FILETIME=[AC19DB40:01C64796]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Mar 2006, Lee Revell wrote:

> I've been testign for weeks with 2.6.16-rc1 + the latency trace patch
> and the longest latencies measured were 10-15ms due to the well known
> rt_run_flush issue.  Today I got one twice as long, when a Firefox
> process with a bunch of acroreads in tabs, from a new code path.
> 
> It seems to trigger when a process with a large amount of memory swapped
> out exits.
> 
> Can this be solved with a cond_resched?

Not that easily, I think.

Are you testing with CONFIG_PREEMPT=y, as I'd expect?  I thought
cond_resched() adds nothing to that case (and we keep on intending
but forgetting to make it compile away to nothing in that case).
Or am I confused?

This is an area (the most notable area) where CONFIG_PREEMPT on and
off make very different decisions on how best to proceed, PREEMPT
advancing in tiny steps and non-PREEMPT doing as much as it can
in one go with preemption disabled.

I suppose, if the swapper_space radix tree is deep, you might get
to see preemption held off for longer than expected, even when
CONFIG_PREEMPT=y; but it'd probably be painful to make those tiny
(8 at a time) steps even tinier.

Whereas if you're checking out CONFIG_PREEMPT undefined, yes,
it's entirely unsurprising that you see long latencies here.

Whichever you're trying, although this trace identifies a different
aspect from the regression you identified in free_pgtables, it is
(probably) another example of how the per-cpu mmu_gather limits us.

I'm still working intermittently on the patch to rework that,
which should improve the situation here as in free_pgtables.

Intermittently because I'm not thoroughly convinced by what I've
done so far, it's unsatisfactory in two different ways (one, leaving
sparc64 and powerpc out in the cold, since they deal with the TLB in
a different way, more deeply reliant on the per-cpu buffers; two,
failing to improve the rare but real truncation-of-mapped-file case).
Not ready to show to light of day yet.

I have put a cond_resched into release_pages in that patch, to
improve the CONFIG_PREEMPT off case; but that does depends on the
other changes, it cannot simply be extracted from the whole.

Hugh

> preemption latency trace v1.1.5 on 2.6.16-rc1
> --------------------------------------------------------------------
>  latency: 28130 us, #38020/38020, CPU#0 | (M:rt VP:0, KP:0, SP:0 HP:0)
>     -----------------
>     | task: acroread-29870 (uid:1000 nice:0 policy:0 rt_prio:0)
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
>     Xorg-18254 0d.s2    1us : __trace_start_sched_wakeup (try_to_wake_up)
>     Xorg-18254 0d.s2    1us : __trace_start_sched_wakeup <<...>-29870> (73 0)
>     Xorg-18254 0d.s.    2us : wake_up_process (process_timeout)
>     Xorg-18254 0dn.2    3us < (2110048)
>     Xorg-18254 0dn.2    4us : preempt_schedule (free_swap_and_cache)
>     Xorg-18254 0dn.2    5us : free_swap_and_cache (unmap_vmas)
>     Xorg-18254 0dn.2    6us : swap_info_get (free_swap_and_cache)
>     Xorg-18254 0dn.3    6us : swap_entry_free (free_swap_and_cache)
>     Xorg-18254 0dn.3    7us : find_trylock_page (free_swap_and_cache)
>     Xorg-18254 0dn.4    8us : radix_tree_lookup (find_trylock_page)
>     Xorg-18254 0dn.3    8us : preempt_schedule (find_trylock_page)
>     Xorg-18254 0dn.2    9us : preempt_schedule (free_swap_and_cache)
>     Xorg-18254 0dn.2   10us : free_swap_and_cache (unmap_vmas)
>     Xorg-18254 0dn.2   11us : swap_info_get (free_swap_and_cache)
>     Xorg-18254 0dn.3   12us : swap_entry_free (free_swap_and_cache)
>     Xorg-18254 0dn.3   12us : find_trylock_page (free_swap_and_cache)
>     Xorg-18254 0dn.4   13us : radix_tree_lookup (find_trylock_page)
>     Xorg-18254 0dn.3   14us : preempt_schedule (find_trylock_page)
>     Xorg-18254 0dn.2   14us : preempt_schedule (free_swap_and_cache)
>     Xorg-18254 0dn.2   15us : free_swap_and_cache (unmap_vmas)
>     Xorg-18254 0dn.2   16us : swap_info_get (free_swap_and_cache)
>     Xorg-18254 0dn.3   16us : swap_entry_free (free_swap_and_cache)
>     Xorg-18254 0dn.3   17us : find_trylock_page (free_swap_and_cache)
>     Xorg-18254 0dn.4   18us : radix_tree_lookup (find_trylock_page)
>     Xorg-18254 0dn.3   19us : preempt_schedule (find_trylock_page)
>     Xorg-18254 0dn.2   19us : preempt_schedule (free_swap_and_cache)
>     Xorg-18254 0dn.2   20us : free_swap_and_cache (unmap_vmas)
>     Xorg-18254 0dn.2   21us : swap_info_get (free_swap_and_cache)
>     Xorg-18254 0dn.3   21us : swap_entry_free (free_swap_and_cache)
>     Xorg-18254 0dn.3   22us : find_trylock_page (free_swap_and_cache)
>     Xorg-18254 0dn.4   23us : radix_tree_lookup (find_trylock_page)
>     Xorg-18254 0dn.3   23us : preempt_schedule (find_trylock_page)
>     Xorg-18254 0dn.2   24us : preempt_schedule (free_swap_and_cache)
>     Xorg-18254 0dn.2   25us : free_swap_and_cache (unmap_vmas)
>     Xorg-18254 0dn.2   25us : swap_info_get (free_swap_and_cache)
>     Xorg-18254 0dn.3   26us : swap_entry_free (free_swap_and_cache)
>     Xorg-18254 0dn.3   27us : find_trylock_page (free_swap_and_cache)
>     Xorg-18254 0dn.4   27us : radix_tree_lookup (find_trylock_page)
>     Xorg-18254 0dn.3   28us : preempt_schedule (find_trylock_page)
>     Xorg-18254 0dn.2   29us : preempt_schedule (free_swap_and_cache)
>     Xorg-18254 0dn.2   30us : free_swap_and_cache (unmap_vmas)
>     Xorg-18254 0dn.2   30us : swap_info_get (free_swap_and_cache)
>     Xorg-18254 0dn.3   31us : swap_entry_free (free_swap_and_cache)
>     Xorg-18254 0dn.3   32us : find_trylock_page (free_swap_and_cache)
>     Xorg-18254 0dn.4   32us : radix_tree_lookup (find_trylock_page)
>     Xorg-18254 0dn.3   33us : preempt_schedule (find_trylock_page)
>     Xorg-18254 0dn.2   34us : preempt_schedule (free_swap_and_cache)
>     Xorg-18254 0dn.2   35us : free_swap_and_cache (unmap_vmas)
>     Xorg-18254 0dn.2   35us : swap_info_get (free_swap_and_cache)
>     Xorg-18254 0dn.3   36us : swap_entry_free (free_swap_and_cache)
>     Xorg-18254 0dn.3   37us : find_trylock_page (free_swap_and_cache)
>     Xorg-18254 0dn.4   37us : radix_tree_lookup (find_trylock_page)
>     Xorg-18254 0dn.3   38us : preempt_schedule (find_trylock_page)
>     Xorg-18254 0dn.2   39us : preempt_schedule (free_swap_and_cache)
>     Xorg-18254 0dn.2   40us : free_swap_and_cache (unmap_vmas)
>     Xorg-18254 0dn.2   40us : swap_info_get (free_swap_and_cache)
>     Xorg-18254 0dn.3   41us : swap_entry_free (free_swap_and_cache)
>     Xorg-18254 0dn.3   42us : find_trylock_page (free_swap_and_cache)
>     Xorg-18254 0dn.4   42us : radix_tree_lookup (find_trylock_page)
> 
> [ etc ]
> 
>     Xorg-18254 0dn.2 28062us : free_swap_and_cache (unmap_vmas)
>     Xorg-18254 0dn.2 28062us : swap_info_get (free_swap_and_cache)
>     Xorg-18254 0dn.3 28063us : swap_entry_free (free_swap_and_cache)
>     Xorg-18254 0dn.3 28064us : find_trylock_page (free_swap_and_cache)
>     Xorg-18254 0dn.4 28064us : radix_tree_lookup (find_trylock_page)
>     Xorg-18254 0dn.3 28065us : preempt_schedule (find_trylock_page)
>     Xorg-18254 0dn.2 28066us : preempt_schedule (free_swap_and_cache)
>     Xorg-18254 0dn.1 28067us+: preempt_schedule (unmap_vmas)
>     Xorg-18254 0dn.1 28073us+: preempt_schedule (unmap_vmas)
>     Xorg-18254 0dn.1 28077us+: preempt_schedule (unmap_vmas)
>     Xorg-18254 0dn.1 28083us+: preempt_schedule (unmap_vmas)
>     Xorg-18254 0dn.1 28089us+: preempt_schedule (unmap_vmas)
>     Xorg-18254 0dn.1 28095us+: preempt_schedule (unmap_vmas)
>     Xorg-18254 0dn.1 28099us+: preempt_schedule (unmap_vmas)
>     Xorg-18254 0dn.1 28101us+: preempt_schedule (unmap_vmas)
>     Xorg-18254 0dn.1 28106us : preempt_schedule (unmap_vmas)
>     Xorg-18254 0dn.2 28107us : vm_normal_page (unmap_vmas)
>     Xorg-18254 0dn.2 28109us : vm_normal_page (unmap_vmas)
>     Xorg-18254 0dn.2 28109us : vm_normal_page (unmap_vmas)
>     Xorg-18254 0dn.2 28110us : vm_normal_page (unmap_vmas)
>     Xorg-18254 0dn.1 28111us : preempt_schedule (unmap_vmas)
>     Xorg-18254 0dn.. 28112us : preempt_schedule (unmap_vmas)
>     Xorg-18254 0dn.. 28113us : schedule (preempt_schedule)
>     Xorg-18254 0dn.. 28113us : stop_trace (schedule)
>     Xorg-18254 0dn.. 28114us : profile_hit (schedule)
>     Xorg-18254 0dn.1 28115us+: sched_clock (schedule)
>     Xorg-18254 0dn.2 28117us : recalc_task_prio (schedule)
>     Xorg-18254 0dn.2 28119us+: effective_prio (recalc_task_prio)
>    <...>-29870 0d..2 28123us+: __switch_to (schedule)
>    <...>-29870 0d..2 28126us : schedule <Xorg-18254> (76 73)
>    <...>-29870 0d..1 28127us : trace_stop_sched_switched (schedule)
>    <...>-29870 0d..2 28128us : trace_stop_sched_switched <<...>-29870> (73 0)
>    <...>-29870 0d..2 28130us : schedule (schedule)
