Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262609AbVBYDbC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262609AbVBYDbC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 22:31:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262610AbVBYDbC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 22:31:02 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:53646 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262609AbVBYDau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 22:30:50 -0500
Subject: Re: More latency regressions with 2.6.11-rc4-RT-V0.7.39-02
From: Lee Revell <rlrevell@joe-job.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0502240821060.5932@goblin.wat.veritas.com>
References: <1109182061.16201.6.camel@krustophenia.net>
	 <Pine.LNX.4.61.0502231908040.13491@goblin.wat.veritas.com>
	 <1109187381.3174.5.camel@krustophenia.net>
	 <Pine.LNX.4.61.0502231952250.14603@goblin.wat.veritas.com>
	 <Pine.LNX.4.61.0502232048330.14747@goblin.wat.veritas.com>
	 <1109196824.4009.1.camel@krustophenia.net>
	 <Pine.LNX.4.61.0502240441260.5427@goblin.wat.veritas.com>
	 <1109226724.4957.16.camel@krustophenia.net>
	 <Pine.LNX.4.61.0502240821060.5932@goblin.wat.veritas.com>
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Feb 2005 22:30:49 -0500
Message-Id: <1109302249.7807.1.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-02-24 at 08:26 +0000, Hugh Dickins wrote:
> On Thu, 24 Feb 2005, Lee Revell wrote:
> > On Thu, 2005-02-24 at 04:56 +0000, Hugh Dickins wrote:
> > > 
> > > In other mail, you do expect people still to be using Ingo's patches,
> > > so probably this patch should stick there (and in -mm) for now.
> > 
> > Well all of these were fixed in the past so it may not be unreasonable
> > to fix them for 2.6.11.
> 
> If we'd got to it earlier, yes.  But 2.6.11 looks to be just a day or
> two away, and we've no idea why zap_pte_range or clear_page_range
> would have reverted.  Nor have we heard from Ingo yet.
> 

It's also not clear that the patch completely fixes the copy_pte_range
latency.  This trace is from the Athlon XP.

Lee

preemption latency trace v1.1.4 on 2.6.11-rc4-RT-V0.7.39-02
--------------------------------------------------------------------
 latency: 284 �s, #25/25, CPU#0 | (M:preempt VP:0, KP:1, SP:1 HP:1 #P:1)
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
(T1/#0)             dpkg  9299 0 3 00000005 00000000 [0001017457529380] 0.000ms (+3633922.612ms): <676b7064> (<00746500>)
(T1/#2)             dpkg  9299 0 3 00000005 00000002 [0001017457529620] 0.000ms (+0.000ms): __trace_start_sched_wakeup+0x9a/0xd0 <c012eaca> (try_to_wake_up+0x90/0x160 <c0110350>)
(T1/#3)             dpkg  9299 0 3 00000004 00000003 [0001017457529825] 0.000ms (+0.000ms): preempt_schedule+0x11/0x80 <c02879d1> (try_to_wake_up+0x90/0x160 <c0110350>)
(T3/#4)     dpkg-9299  0dn.4    0�s : try_to_wake_up+0x118/0x160 <c01103d8> <<...>-2> (69 74): 
(T1/#5)             dpkg  9299 0 3 00000003 00000005 [0001017457530633] 0.000ms (+0.000ms): preempt_schedule+0x11/0x80 <c02879d1> (try_to_wake_up+0xf2/0x160 <c01103b2>)
(T1/#6)             dpkg  9299 0 3 00000003 00000006 [0001017457530809] 0.001ms (+0.000ms): wake_up_process+0x35/0x40 <c0110455> (do_softirq+0x3f/0x50 <c011aedf>)
(T6/#7)     dpkg-9299  0dn.2    1�s!< (1)
(T1/#8)             dpkg  9299 0 2 00000001 00000008 [0001017457898984] 0.276ms (+0.000ms): preempt_schedule+0x11/0x80 <c02879d1> (copy_pte_range+0xbc/0x1b0 <c014573c>)
(T1/#9)             dpkg  9299 0 2 00000001 00000009 [0001017457899172] 0.276ms (+0.000ms): __cond_resched_raw_spinlock+0xb/0x50 <c0111f9b> (copy_pte_range+0xad/0x1b0 <c014572d>)
(T1/#10)             dpkg  9299 0 2 00000000 0000000a [0001017457899575] 0.277ms (+0.000ms): __cond_resched+0xe/0x70 <c0111f2e> (__cond_resched_raw_spinlock+0x35/0x50 <c0111fc5>)
(T1/#11)             dpkg  9299 0 3 00000000 0000000b [0001017457900063] 0.277ms (+0.000ms): __schedule+0xe/0x680 <c028720e> (__cond_resched+0x4a/0x70 <c0111f6a>)
(T1/#12)             dpkg  9299 0 3 00000000 0000000c [0001017457900379] 0.277ms (+0.000ms): profile_hit+0x9/0x50 <c0116449> (__schedule+0x43/0x680 <c0287243>)
(T1/#13)             dpkg  9299 0 3 00000001 0000000d [0001017457900602] 0.277ms (+0.001ms): sched_clock+0x14/0x80 <c010cbb4> (__schedule+0x73/0x680 <c0287273>)
(T1/#14)             dpkg  9299 0 3 00000002 0000000e [0001017457902490] 0.279ms (+0.000ms): dequeue_task+0x12/0x60 <c010ff32> (__schedule+0x1e0/0x680 <c02873e0>)
(T1/#15)             dpkg  9299 0 3 00000002 0000000f [0001017457902687] 0.279ms (+0.000ms): recalc_task_prio+0xe/0x140 <c01100be> (__schedule+0x202/0x680 <c0287402>)
(T1/#16)             dpkg  9299 0 3 00000002 00000010 [0001017457902848] 0.279ms (+0.000ms): effective_prio+0x8/0x60 <c0110058> (recalc_task_prio+0x88/0x140 <c0110138>)
(T1/#17)             dpkg  9299 0 3 00000002 00000011 [0001017457902995] 0.279ms (+0.000ms): enqueue_task+0x11/0x80 <c010ff91> (__schedule+0x20e/0x680 <c028740e>)
(T4/#18) [ =>             dpkg ] 0.280ms (+0.000ms)
(T1/#19)            <...>     2 0 1 00000002 00000013 [0001017457905091] 0.281ms (+0.000ms): __switch_to+0xe/0x190 <c010110e> (__schedule+0x306/0x680 <c0287506>)
(T3/#20)    <...>-2     0d..2  281�s : __schedule+0x337/0x680 <c0287537> <dpkg-9299> (74 69): 
(T1/#21)            <...>     2 0 1 00000002 00000015 [0001017457906484] 0.282ms (+0.000ms): finish_task_switch+0x14/0xa0 <c0110844> (__schedule+0x33f/0x680 <c028753f>)
(T1/#22)            <...>     2 0 1 00000001 00000016 [0001017457906713] 0.282ms (+0.000ms): trace_stop_sched_switched+0x11/0x180 <c012eb11> (finish_task_switch+0x51/0xa0 <c0110881>)
(T3/#23)    <...>-2     0d..1  282�s : trace_stop_sched_switched+0x4c/0x180 <c012eb4c> <<...>-2> (69 0): 
(T1/#24)            <...>     2 0 1 00000001 00000018 [0001017457908107] 0.283ms (+0.000ms): trace_stop_sched_switched+0x11c/0x180 <c012ec1c> (finish_task_switch+0x51/0xa0 <c0110881>)


vim:ft=help



