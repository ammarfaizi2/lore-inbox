Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261546AbVBWThw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261546AbVBWThw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 14:37:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261549AbVBWThv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 14:37:51 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:10733 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261546AbVBWTgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 14:36:23 -0500
Subject: Re: More latency regressions with 2.6.11-rc4-RT-V0.7.39-02
From: Lee Revell <rlrevell@joe-job.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0502231908040.13491@goblin.wat.veritas.com>
References: <1109182061.16201.6.camel@krustophenia.net>
	 <Pine.LNX.4.61.0502231908040.13491@goblin.wat.veritas.com>
Content-Type: multipart/mixed; boundary="=-G72KGEW1lhujbI1iRR1A"
Date: Wed, 23 Feb 2005 14:36:21 -0500
Message-Id: <1109187381.3174.5.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-G72KGEW1lhujbI1iRR1A
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2005-02-23 at 19:16 +0000, Hugh Dickins wrote:
> On Wed, 23 Feb 2005, Lee Revell wrote:
> > 
> > Did something change recently in the VM that made copy_pte_range and
> > clear_page_range a lot more expensive?  I noticed a reference in the
> > "Page Table Iterators" thread to excessive overhead introduced by
> > aggressive page freeing.  That sure looks like what is going on in
> > trace2.  trace1 and trace3 look like big fork latencies associated with
> > copy_pte_range.
> 
> I'm just about to test this patch below: please give it a try: thanks...
> 
> Ingo's patch to reduce scheduling latencies, by checking for lockbreak
> in copy_page_range, was in the -VP and -mm patchsets some months ago;
> but got preempted by the 4level rework, and not reinstated since.
> Restore it now in copy_pte_range - which mercifully makes it easier.

Aha, that explains why all the latency regressions involve the VM
subsystem. 

Thanks, your patch fixes the copy_pte_range latency.  Now zap_pte_range,
which Ingo also fixed a few months ago, is the worst offender.  Can this
fix be easily ported too?

Lee

--=-G72KGEW1lhujbI1iRR1A
Content-Disposition: attachment; filename=trace5.txt
Content-Type: text/plain; name=trace5.txt; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit

preemption latency trace v1.1.4 on 2.6.11-rc4-RT-V0.7.39-02
--------------------------------------------------------------------
 latency: 197 탎, #74/74, CPU#0 | (M:preempt VP:0, KP:1, SP:1 HP:1 #P:1)
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
(T1/#0)            dmesg  3249 0 9 00000002 00000000 [0000163455166655] 0.000ms (+886841.090ms): <73656d64> (<61700067>)
(T1/#2)            dmesg  3249 0 9 00000002 00000002 [0000163455167105] 0.000ms (+0.000ms): __trace_start_sched_wakeup+0x96/0xc0 <c012cbe6> (try_to_wake_up+0x81/0x150 <c010f911>)
(T1/#3)            dmesg  3249 0 9 00000000 00000003 [0000163455167685] 0.001ms (+0.001ms): wake_up_process+0x1c/0x30 <c010f9fc> (do_softirq+0x4b/0x60 <c01042fb>)
(T6/#4)    dmesg-3249  0dn.2    2탎 < (1)
(T1/#5)            dmesg  3249 0 2 00000002 00000005 [0000163455168677] 0.003ms (+0.000ms): page_remove_rmap+0x8/0x40 <c0149f78> (zap_pte_range+0x13a/0x250 <c0142f4a>)
(T1/#6)            dmesg  3249 0 2 00000002 00000006 [0000163455168975] 0.003ms (+0.000ms): __mod_page_state+0xa/0x30 <c013a09a> (page_remove_rmap+0x2c/0x40 <c0149f9c>)
(T1/#7)            dmesg  3249 0 2 00000002 00000007 [0000163455169390] 0.004ms (+0.000ms): free_page_and_swap_cache+0x9/0x70 <c014bbb9> (zap_pte_range+0x14c/0x250 <c0142f5c>)
(T1/#8)            dmesg  3249 0 2 00000002 00000008 [0000163455169687] 0.005ms (+0.001ms): __page_cache_release+0xb/0xc0 <c013ed4b> (zap_pte_range+0x14c/0x250 <c0142f5c>)
(T1/#9)            dmesg  3249 0 2 00000002 00000009 [0000163455170314] 0.006ms (+0.000ms): preempt_schedule+0xa/0x70 <c027d0fa> (__page_cache_release+0xad/0xc0 <c013eded>)
(T1/#10)            dmesg  3249 0 2 00000002 0000000a [0000163455170636] 0.006ms (+0.000ms): free_hot_page+0x8/0x10 <c0139608> (zap_pte_range+0x14c/0x250 <c0142f5c>)
(T1/#11)            dmesg  3249 0 2 00000002 0000000b [0000163455170944] 0.007ms (+0.000ms): free_hot_cold_page+0xe/0x130 <c01394de> (zap_pte_range+0x14c/0x250 <c0142f5c>)
(T1/#12)            dmesg  3249 0 2 00000002 0000000c [0000163455171314] 0.007ms (+0.001ms): __mod_page_state+0xa/0x30 <c013a09a> (free_hot_cold_page+0x2a/0x130 <c01394fa>)
(T1/#13)            dmesg  3249 0 2 00000002 0000000d [0000163455172090] 0.009ms (+0.000ms): preempt_schedule+0xa/0x70 <c027d0fa> (zap_pte_range+0x14c/0x250 <c0142f5c>)
(T1/#14)            dmesg  3249 0 2 00000002 0000000e [0000163455172432] 0.009ms (+0.000ms): set_page_dirty+0x8/0x60 <c013b428> (zap_pte_range+0x168/0x250 <c0142f78>)
(T1/#15)            dmesg  3249 0 2 00000002 0000000f [0000163455172774] 0.010ms (+0.000ms): page_remove_rmap+0x8/0x40 <c0149f78> (zap_pte_range+0x13a/0x250 <c0142f4a>)
(T1/#16)            dmesg  3249 0 2 00000002 00000010 [0000163455173040] 0.010ms (+0.000ms): __mod_page_state+0xa/0x30 <c013a09a> (page_remove_rmap+0x2c/0x40 <c0149f9c>)
(T1/#17)            dmesg  3249 0 2 00000002 00000011 [0000163455173421] 0.011ms (+0.000ms): free_page_and_swap_cache+0x9/0x70 <c014bbb9> (zap_pte_range+0x14c/0x250 <c0142f5c>)
(T1/#18)            dmesg  3249 0 2 00000002 00000012 [0000163455173704] 0.011ms (+0.001ms): __page_cache_release+0xb/0xc0 <c013ed4b> (zap_pte_range+0x14c/0x250 <c0142f5c>)
(T1/#19)            dmesg  3249 0 2 00000002 00000013 [0000163455174397] 0.012ms (+0.000ms): preempt_schedule+0xa/0x70 <c027d0fa> (__page_cache_release+0xad/0xc0 <c013eded>)
(T1/#20)            dmesg  3249 0 2 00000002 00000014 [0000163455174687] 0.013ms (+0.000ms): free_hot_page+0x8/0x10 <c0139608> (zap_pte_range+0x14c/0x250 <c0142f5c>)
(T1/#21)            dmesg  3249 0 2 00000002 00000015 [0000163455175101] 0.014ms (+0.000ms): free_hot_cold_page+0xe/0x130 <c01394de> (zap_pte_range+0x14c/0x250 <c0142f5c>)
(T1/#22)            dmesg  3249 0 2 00000002 00000016 [0000163455175436] 0.014ms (+0.001ms): __mod_page_state+0xa/0x30 <c013a09a> (free_hot_cold_page+0x2a/0x130 <c01394fa>)
(T1/#23)            dmesg  3249 0 2 00000002 00000017 [0000163455176191] 0.015ms (+0.001ms): preempt_schedule+0xa/0x70 <c027d0fa> (zap_pte_range+0x14c/0x250 <c0142f5c>)
(T1/#24)            dmesg  3249 0 2 00000002 00000018 [0000163455176892] 0.017ms (+0.007ms): clear_page_range+0xe/0x1d0 <c01426fe> (exit_mmap+0xa3/0x1b0 <c0148013>)
(T1/#25)            dmesg  3249 0 2 00000002 00000019 [0000163455181331] 0.024ms (+0.000ms): __mod_page_state+0xa/0x30 <c013a09a> (clear_page_range+0x183/0x1d0 <c0142873>)
(T1/#26)            dmesg  3249 0 2 00000002 0000001a [0000163455181781] 0.025ms (+0.000ms): free_page_and_swap_cache+0x9/0x70 <c014bbb9> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#27)            dmesg  3249 0 2 00000002 0000001b [0000163455182166] 0.025ms (+0.000ms): __page_cache_release+0xb/0xc0 <c013ed4b> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#28)            dmesg  3249 0 2 00000002 0000001c [0000163455182746] 0.026ms (+0.000ms): preempt_schedule+0xa/0x70 <c027d0fa> (__page_cache_release+0xad/0xc0 <c013eded>)
(T1/#29)            dmesg  3249 0 2 00000002 0000001d [0000163455183036] 0.027ms (+0.000ms): free_hot_page+0x8/0x10 <c0139608> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#30)            dmesg  3249 0 2 00000002 0000001e [0000163455183293] 0.027ms (+0.000ms): free_hot_cold_page+0xe/0x130 <c01394de> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#31)            dmesg  3249 0 2 00000002 0000001f [0000163455183557] 0.028ms (+0.001ms): __mod_page_state+0xa/0x30 <c013a09a> (free_hot_cold_page+0x2a/0x130 <c01394fa>)
(T1/#32)            dmesg  3249 0 2 00000002 00000020 [0000163455184330] 0.029ms (+0.042ms): preempt_schedule+0xa/0x70 <c027d0fa> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#33)            dmesg  3249 0 2 00000002 00000021 [0000163455210040] 0.072ms (+0.000ms): __mod_page_state+0xa/0x30 <c013a09a> (clear_page_range+0x183/0x1d0 <c0142873>)
(T1/#34)            dmesg  3249 0 2 00000002 00000022 [0000163455210487] 0.072ms (+0.000ms): free_page_and_swap_cache+0x9/0x70 <c014bbb9> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#35)            dmesg  3249 0 2 00000002 00000023 [0000163455210867] 0.073ms (+0.001ms): __page_cache_release+0xb/0xc0 <c013ed4b> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#36)            dmesg  3249 0 2 00000002 00000024 [0000163455211481] 0.074ms (+0.000ms): preempt_schedule+0xa/0x70 <c027d0fa> (__page_cache_release+0xad/0xc0 <c013eded>)
(T1/#37)            dmesg  3249 0 2 00000002 00000025 [0000163455211846] 0.075ms (+0.000ms): free_hot_page+0x8/0x10 <c0139608> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#38)            dmesg  3249 0 2 00000002 00000026 [0000163455212103] 0.075ms (+0.000ms): free_hot_cold_page+0xe/0x130 <c01394de> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#39)            dmesg  3249 0 2 00000002 00000027 [0000163455212367] 0.076ms (+0.001ms): __mod_page_state+0xa/0x30 <c013a09a> (free_hot_cold_page+0x2a/0x130 <c01394fa>)
(T1/#40)            dmesg  3249 0 2 00000002 00000028 [0000163455213164] 0.077ms (+0.088ms): preempt_schedule+0xa/0x70 <c027d0fa> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#41)            dmesg  3249 0 2 00000002 00000029 [0000163455266176] 0.165ms (+0.000ms): __mod_page_state+0xa/0x30 <c013a09a> (clear_page_range+0x183/0x1d0 <c0142873>)
(T1/#42)            dmesg  3249 0 2 00000002 0000002a [0000163455266536] 0.166ms (+0.000ms): free_page_and_swap_cache+0x9/0x70 <c014bbb9> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#43)            dmesg  3249 0 2 00000002 0000002b [0000163455267095] 0.167ms (+0.000ms): __page_cache_release+0xb/0xc0 <c013ed4b> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#44)            dmesg  3249 0 2 00000002 0000002c [0000163455267667] 0.168ms (+0.000ms): preempt_schedule+0xa/0x70 <c027d0fa> (__page_cache_release+0xad/0xc0 <c013eded>)
(T1/#45)            dmesg  3249 0 2 00000002 0000002d [0000163455268033] 0.168ms (+0.000ms): free_hot_page+0x8/0x10 <c0139608> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#46)            dmesg  3249 0 2 00000002 0000002e [0000163455268375] 0.169ms (+0.000ms): free_hot_cold_page+0xe/0x130 <c01394de> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#47)            dmesg  3249 0 2 00000002 0000002f [0000163455268717] 0.169ms (+0.001ms): __mod_page_state+0xa/0x30 <c013a09a> (free_hot_cold_page+0x2a/0x130 <c01394fa>)
(T1/#48)            dmesg  3249 0 2 00000002 00000030 [0000163455269434] 0.171ms (+0.006ms): preempt_schedule+0xa/0x70 <c027d0fa> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#49)            dmesg  3249 0 2 00000002 00000031 [0000163455273343] 0.177ms (+0.000ms): __mod_page_state+0xa/0x30 <c013a09a> (clear_page_range+0x183/0x1d0 <c0142873>)
(T1/#50)            dmesg  3249 0 2 00000002 00000032 [0000163455273779] 0.178ms (+0.000ms): free_page_and_swap_cache+0x9/0x70 <c014bbb9> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#51)            dmesg  3249 0 2 00000002 00000033 [0000163455274128] 0.178ms (+0.000ms): __page_cache_release+0xb/0xc0 <c013ed4b> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#52)            dmesg  3249 0 2 00000002 00000034 [0000163455274724] 0.179ms (+0.000ms): preempt_schedule+0xa/0x70 <c027d0fa> (__page_cache_release+0xad/0xc0 <c013eded>)
(T1/#53)            dmesg  3249 0 2 00000002 00000035 [0000163455275084] 0.180ms (+0.000ms): free_hot_page+0x8/0x10 <c0139608> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#54)            dmesg  3249 0 2 00000002 00000036 [0000163455275413] 0.180ms (+0.000ms): free_hot_cold_page+0xe/0x130 <c01394de> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#55)            dmesg  3249 0 2 00000002 00000037 [0000163455275677] 0.181ms (+0.001ms): __mod_page_state+0xa/0x30 <c013a09a> (free_hot_cold_page+0x2a/0x130 <c01394fa>)
(T1/#56)            dmesg  3249 0 2 00000002 00000038 [0000163455276470] 0.182ms (+0.001ms): preempt_schedule+0xa/0x70 <c027d0fa> (clear_page_range+0x1a0/0x1d0 <c0142890>)
(T1/#57)            dmesg  3249 0 2 00000002 00000039 [0000163455277321] 0.184ms (+0.000ms): preempt_schedule+0xa/0x70 <c027d0fa> (exit_mmap+0x190/0x1b0 <c0148100>)
(T1/#58)            dmesg  3249 0 2 00000001 0000003a [0000163455277715] 0.184ms (+0.000ms): preempt_schedule+0xa/0x70 <c027d0fa> (exit_mmap+0x164/0x1b0 <c01480d4>)
(T1/#59)            dmesg  3249 0 2 00000000 0000003b [0000163455278192] 0.185ms (+0.000ms): preempt_schedule+0xa/0x70 <c027d0fa> (exit_mmap+0x15d/0x1b0 <c01480cd>)
(T1/#60)            dmesg  3249 0 3 00000000 0000003c [0000163455278638] 0.186ms (+0.000ms): __schedule+0xe/0x630 <c027c9be> (preempt_schedule+0x4f/0x70 <c027d13f>)
(T1/#61)            dmesg  3249 0 3 00000000 0000003d [0000163455278977] 0.186ms (+0.000ms): profile_hit+0x9/0x50 <c0115749> (__schedule+0x3a/0x630 <c027c9ea>)
(T1/#62)            dmesg  3249 0 3 00000001 0000003e [0000163455279418] 0.187ms (+0.001ms): sched_clock+0xe/0xe0 <c010c3ae> (__schedule+0x62/0x630 <c027ca12>)
(T1/#63)            dmesg  3249 0 3 00000002 0000003f [0000163455280259] 0.189ms (+0.000ms): dequeue_task+0xa/0x50 <c010f4ea> (__schedule+0x1ab/0x630 <c027cb5b>)
(T1/#64)            dmesg  3249 0 3 00000002 00000040 [0000163455280596] 0.189ms (+0.000ms): recalc_task_prio+0xc/0x1a0 <c010f64c> (__schedule+0x1c5/0x630 <c027cb75>)
(T1/#65)            dmesg  3249 0 3 00000002 00000041 [0000163455280988] 0.190ms (+0.000ms): effective_prio+0x8/0x50 <c010f5f8> (recalc_task_prio+0xa6/0x1a0 <c010f6e6>)
(T1/#66)            dmesg  3249 0 3 00000002 00000042 [0000163455281297] 0.190ms (+0.000ms): enqueue_task+0xa/0x80 <c010f53a> (__schedule+0x1cc/0x630 <c027cb7c>)
(T4/#67) [ =>            dmesg ] 0.191ms (+0.000ms)
(T1/#68)            <...>     2 0 1 00000002 00000044 [0000163455282330] 0.192ms (+0.000ms): __switch_to+0xb/0x1a0 <c0100f5b> (__schedule+0x2bd/0x630 <c027cc6d>)
(T3/#69)    <...>-2     0d..2  193탎 : __schedule+0x2ea/0x630 <c027cc9a> <dmesg-3249> (75 69): 
(T1/#70)            <...>     2 0 1 00000002 00000046 [0000163455283124] 0.193ms (+0.000ms): finish_task_switch+0xc/0x90 <c010fdec> (__schedule+0x2f6/0x630 <c027cca6>)
(T1/#71)            <...>     2 0 1 00000001 00000047 [0000163455283506] 0.194ms (+0.000ms): trace_stop_sched_switched+0xa/0x150 <c012cc1a> (finish_task_switch+0x43/0x90 <c010fe23>)
(T3/#72)    <...>-2     0d..1  194탎 : trace_stop_sched_switched+0x42/0x150 <c012cc52> <<...>-2> (69 0): 
(T1/#73)            <...>     2 0 1 00000001 00000049 [0000163455284627] 0.196ms (+0.000ms): trace_stop_sched_switched+0xfe/0x150 <c012cd0e> (finish_task_switch+0x43/0x90 <c010fe23>)


vim:ft=help

--=-G72KGEW1lhujbI1iRR1A--

