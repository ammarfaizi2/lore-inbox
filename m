Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263108AbVCXRNX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263108AbVCXRNX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 12:13:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263141AbVCXRNX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 12:13:23 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:16605 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S263108AbVCXRNC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 12:13:02 -0500
Subject: Re: Latency tests with 2.6.12-rc1
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       "Jack O'Quin" <joq@io.com>
In-Reply-To: <1111615961.3377.3.camel@mindpipe>
References: <1111204984.12740.22.camel@mindpipe>
	 <20050319070810.GA20059@elte.hu> <1111218702.13039.5.camel@mindpipe>
	 <1111269392.15042.12.camel@mindpipe>  <20050322082222.GB9497@elte.hu>
	 <1111615961.3377.3.camel@mindpipe>
Content-Type: text/plain
Date: Thu, 24 Mar 2005 12:13:00 -0500
Message-Id: <1111684380.23440.12.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-23 at 17:12 -0500, Lee Revell wrote:
> Now the longest latency I see with "dbench 16"
> and PREEMPT_DESKTOP is 591us in the ext3 reservation code.  Trace is
> attached (compressed) in case anyone is interested.  But I do not
> consider anything under a millisecond to be a problem with
> PREEMPT_DESKTOP.

I set the swappiness to 100 just to see what would happen (I usually use
0) and ran overnight, and got these swap-related latencies up to ~1.8
ms.

If I read the trace correctly the latency is in get_swap_page.

Also interesting, it's clear from this trace that call sequence the
timer ISR changed quite a bit from 2.6.11 to 2.6.12.  I am really
impressed the kernel works so well given the current rate of change.

preemption latency trace v1.1.4 on 2.6.12-rc1-RT-V0.7.41-08
--------------------------------------------------------------------
 latency: 1820 us, #46/46, CPU#0 | (M:preempt VP:0, KP:1, SP:1 HP:1 #P:1)
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
(T1/#0)          kswapd0    66 0 9 00000002 00000000 [0038065890208203] 0.000ms (+903083.399ms): <6177736b> (<00306470>)
(T1/#2)          kswapd0    66 0 9 00000002 00000002 [0038065890208522] 0.000ms (+0.000ms): __trace_start_sched_wakeup+0x96/0xc0 <c012f806> (try_to_wake_up+0x84/0x140 <c010f9e4>)
(T1/#3)          kswapd0    66 0 9 00000000 00000003 [0038065890209061] 0.001ms (+0.000ms): wake_up_process+0x1c/0x30 <c010fabc> (do_softirq+0x4b/0x60 <c01047bb>)
(T6/#4)  kswapd0-66    0dn.2    2us!< (1)
(T2/#5)  kswapd0-66    0dnh2  978us : do_IRQ+0x2d/0x80 <c010467d> (c014e3d0 0 0)
(T1/#6)          kswapd0    66 0 5 00000001 00000006 [0038065890797005] 0.979ms (+0.002ms): mask_and_ack_8259A+0xb/0x110 <c010818b> (__do_IRQ+0x8b/0x160 <c01364ab>)
(T1/#7)          kswapd0    66 0 5 00000001 00000007 [0038065890798780] 0.982ms (+0.000ms): redirect_hardirq+0x8/0x90 <c0136288> (__do_IRQ+0xbc/0x160 <c01364dc>)
(T1/#8)          kswapd0    66 0 5 00000000 00000008 [0038065890799219] 0.983ms (+0.000ms): handle_IRQ_event+0xe/0xf0 <c013631e> (__do_IRQ+0xea/0x160 <c013650a>)
(T1/#9)          kswapd0    66 0 5 00000000 00000009 [0038065890799507] 0.983ms (+0.000ms): timer_interrupt+0xb/0x100 <c0106fcb> (handle_IRQ_event+0x61/0xf0 <c0136371>)
(T1/#10)          kswapd0    66 0 5 00000001 0000000a [0038065890799947] 0.984ms (+0.004ms): mark_offset_tsc+0xe/0x370 <c010c81e> (timer_interrupt+0x24/0x100 <c0106fe4>)
(T1/#11)          kswapd0    66 0 5 00000001 0000000b [0038065890802748] 0.989ms (+0.000ms): do_timer+0x8/0x20 <c011e718> (timer_interrupt+0x2a/0x100 <c0106fea>)
(T1/#12)          kswapd0    66 0 5 00000001 0000000c [0038065890803125] 0.989ms (+0.000ms): update_process_times+0xa/0x100 <c011e17a> (timer_interrupt+0x44/0x100 <c0107004>)
(T1/#13)          kswapd0    66 0 5 00000001 0000000d [0038065890803494] 0.990ms (+0.000ms): account_system_time+0xa/0xb0 <c011013a> (update_process_times+0xed/0x100 <c011e25d>)
(T1/#14)          kswapd0    66 0 5 00000001 0000000e [0038065890803863] 0.991ms (+0.000ms): acct_update_integrals+0xa/0x60 <c013609a> (account_system_time+0x40/0xb0 <c0110170>)
(T1/#15)          kswapd0    66 0 5 00000001 0000000f [0038065890804182] 0.991ms (+0.000ms): update_mem_hiwater+0x8/0x50 <c0147b68> (update_process_times+0xed/0x100 <c011e25d>)
(T1/#16)          kswapd0    66 0 5 00000001 00000010 [0038065890804497] 0.992ms (+0.000ms): run_local_timers+0x8/0x20 <c011e298> (update_process_times+0x2d/0x100 <c011e19d>)
(T1/#17)          kswapd0    66 0 5 00000001 00000011 [0038065890804910] 0.992ms (+0.000ms): raise_softirq+0xa/0x70 <c011a21a> (update_process_times+0x2d/0x100 <c011e19d>)
(T1/#18)          kswapd0    66 0 5 00000001 00000012 [0038065890805402] 0.993ms (+0.000ms): rcu_check_callbacks+0x8/0xc0 <c0126e18> (update_process_times+0x68/0x100 <c011e1d8>)
(T1/#19)          kswapd0    66 0 5 00000001 00000013 [0038065890805759] 0.994ms (+0.000ms): idle_cpu+0x8/0x20 <c0110c28> (rcu_check_callbacks+0x66/0xc0 <c0126e76>)
(T1/#20)          kswapd0    66 0 5 00000001 00000014 [0038065890806218] 0.995ms (+0.000ms): scheduler_tick+0xc/0x3e0 <c011024c> (update_process_times+0x6f/0x100 <c011e1df>)
(T1/#21)          kswapd0    66 0 5 00000001 00000015 [0038065890806546] 0.995ms (+0.001ms): sched_clock+0xe/0xe0 <c010c57e> (scheduler_tick+0x1d/0x3e0 <c011025d>)
(T1/#22)          kswapd0    66 0 5 00000001 00000016 [0038065890807424] 0.997ms (+0.000ms): run_posix_cpu_timers+0xe/0x1b0 <c012d04e> (timer_interrupt+0x44/0x100 <c0107004>)
(T1/#23)          kswapd0    66 0 5 00000001 00000017 [0038065890807932] 0.997ms (+0.001ms): profile_hit+0x9/0x50 <c0115a79> (timer_interrupt+0x4e/0x100 <c010700e>)
(T1/#24)          kswapd0    66 0 5 00000001 00000018 [0038065890808639] 0.999ms (+0.000ms): note_interrupt+0xb/0x90 <c0136e0b> (__do_IRQ+0x148/0x160 <c0136568>)
(T1/#25)          kswapd0    66 0 5 00000001 00000019 [0038065890809012] 0.999ms (+0.000ms): end_8259A_irq+0x8/0x40 <c0107f58> (__do_IRQ+0x110/0x160 <c0136530>)
(T1/#26)          kswapd0    66 0 5 00000001 0000001a [0038065890809359] 1.000ms (+0.002ms): enable_8259A_irq+0xb/0x80 <c010803b> (__do_IRQ+0x110/0x160 <c0136530>)
(T1/#27)          kswapd0    66 0 7 00000002 0000001b [0038065890810630] 1.002ms (+0.000ms): irq_exit+0x8/0x50 <c011a1c8> (do_IRQ+0x60/0x80 <c01046b0>)
(T1/#28)          kswapd0    66 0 3 00000003 0000001c [0038065890811106] 1.003ms (+0.000ms): do_softirq+0xb/0x60 <c010477b> (irq_exit+0x45/0x50 <c011a205>)
(T1/#29)          kswapd0    66 0 9 00000000 0000001d [0038065890811604] 1.003ms (+0.001ms): __do_softirq+0xa/0x90 <c011a05a> (do_softirq+0x4b/0x60 <c01047bb>)
(T6/#30)  kswapd0-66    0dn.2 1005us!< (1)
(T1/#31)          kswapd0    66 0 2 00000001 0000001f [0038065891293001] 1.804ms (+0.001ms): preempt_schedule+0xa/0x70 <c02a837a> (get_swap_page+0x208/0x290 <c014e488>)
(T1/#32)          kswapd0    66 0 2 00000000 00000020 [0038065891293653] 1.806ms (+0.000ms): preempt_schedule+0xa/0x70 <c02a837a> (get_swap_page+0xc4/0x290 <c014e344>)
(T1/#33)          kswapd0    66 0 3 00000000 00000021 [0038065891294198] 1.806ms (+0.000ms): __schedule+0xe/0x710 <c02a7b5e> (preempt_schedule+0x4f/0x70 <c02a83bf>)
(T1/#34)          kswapd0    66 0 3 00000000 00000022 [0038065891294675] 1.807ms (+0.000ms): profile_hit+0x9/0x50 <c0115a79> (__schedule+0x3a/0x710 <c02a7b8a>)
(T1/#35)          kswapd0    66 0 3 00000001 00000023 [0038065891295125] 1.808ms (+0.001ms): sched_clock+0xe/0xe0 <c010c57e> (__schedule+0x68/0x710 <c02a7bb8>)
(T1/#36)          kswapd0    66 0 3 00000002 00000024 [0038065891296151] 1.810ms (+0.000ms): dequeue_task+0xa/0x50 <c010f5ba> (__schedule+0x1ca/0x710 <c02a7d1a>)
(T1/#37)          kswapd0    66 0 3 00000002 00000025 [0038065891296676] 1.811ms (+0.000ms): recalc_task_prio+0xc/0x1a0 <c010f71c> (__schedule+0x1e4/0x710 <c02a7d34>)
(T1/#38)          kswapd0    66 0 3 00000002 00000026 [0038065891297091] 1.811ms (+0.000ms): effective_prio+0x8/0x50 <c010f6c8> (recalc_task_prio+0xa6/0x1a0 <c010f7b6>)
(T1/#39)          kswapd0    66 0 3 00000002 00000027 [0038065891297465] 1.812ms (+0.001ms): enqueue_task+0xa/0x80 <c010f60a> (__schedule+0x1eb/0x710 <c02a7d3b>)
(T4/#40) [ =>          kswapd0 ] 1.813ms (+0.001ms)
(T1/#41)            <...>     2 0 1 00000002 00000029 [0038065891299097] 1.815ms (+0.001ms): __switch_to+0xb/0x1a0 <c01013bb> (__schedule+0x329/0x710 <c02a7e79>)
(T3/#42)    <...>-2     0d..2 1816us : __schedule+0x356/0x710 <c02a7ea6> <kswapd0-66> (73 69): 
(T1/#43)            <...>     2 0 1 00000001 0000002b [0038065891300595] 1.817ms (+0.000ms): trace_stop_sched_switched+0xa/0x150 <c012f83a> (__schedule+0x38d/0x710 <c02a7edd>)
(T3/#44)    <...>-2     0d..1 1818us : trace_stop_sched_switched+0x42/0x150 <c012f872> <<...>-2> (69 0): 
(T1/#45)            <...>     2 0 1 00000001 0000002d [0038065891301715] 1.819ms (+0.000ms): trace_stop_sched_switched+0xfe/0x150 <c012f92e> (__schedule+0x38d/0x710 <c02a7edd>)


vim:ft=help

Lee

