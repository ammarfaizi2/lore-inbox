Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261405AbVCSV4p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbVCSV4p (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 16:56:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261859AbVCSV4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 16:56:45 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:19630 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261405AbVCSV4i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 16:56:38 -0500
Subject: Re: Latency tests with 2.6.12-rc1
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       "Jack O'Quin" <joq@io.com>
In-Reply-To: <1111218702.13039.5.camel@mindpipe>
References: <1111204984.12740.22.camel@mindpipe>
	 <20050319070810.GA20059@elte.hu>  <1111218702.13039.5.camel@mindpipe>
Content-Type: text/plain; charset=UTF-8
Date: Sat, 19 Mar 2005 16:56:32 -0500
Message-Id: <1111269392.15042.12.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-03-19 at 02:51 -0500, Lee Revell wrote:
> On Sat, 2005-03-19 at 08:08 +0100, Ingo Molnar wrote:
> > great! The change in question is most likely the copy_page_range() fix
> > that Hugh resurrected:
> > 
> > ChangeSet 1.2037, 2005/03/08 09:26:46-08:00, hugh@veritas.com
> > 
> > 	[PATCH] copy_pte_range latency fix
> > 	
> > 	Ingo's patch to reduce scheduling latencies, by checking for lockbreak in
> > 	copy_page_range, was in the -VP and -mm patchsets some months ago; but got
> > 	preempted by the 4level rework, and not reinstated since. Restore it now
> > 	in copy_pte_range - which mercifully makes it easier.
> > 
> > are the ext3 related latencies are gone as well - or are you working it
> > around by not using data=ordered?
> 
> As a matter of fact the ext3 latencies do not appear to be causing
> problems, at least not at those settings, even with data=ordered.
> 
> It's impossible to tell much more because the mainline kernel lacks the
> instrumentation that the realtime patchset provides.

Ingo,

I think I have nailed this down to a bug in the latency tracer.

I ran 2.6.12-rc1 all night with JACK at 64 frames.  Anything longer than
1.3 ms will cause xruns at this setting.  I did not get a single xrun
all night, despite running "dbench 64".

(The workload for all of the following tests was "dbench 16")

Then I tried 2.6.12-rc1-RT-V0.7.41-00 with PREEMPT_DESKTOP which should
be similar to mainline, with the addition of IRQ threading and the
latency instrumentation.  As soon as I ran "updatedb", the latency
tracer reported 3 and 4ms bumps in that same ext3 code path.  But, JACK
was not running at the time.

Next I tried the same test but with JACK running.  The longest latency
reported was only 200 usecs, and I did not get xruns.

Then, right after I stopped JACK, the latency tracer shot up to 1645
usecs.

So there seems to be a bug in the latency tracer where the timer is not
being reset on reschedule.  If an RT task like JACK is running,  the
task does wakeup properly and the counter is reset.  But if JACK is not
running then long latencies will be reported.

Lee

preemption latency trace v1.1.4 on 2.6.12-rc1-RT-V0.7.41-00
--------------------------------------------------------------------
 latency: 3402 �s, #4095/20285, CPU#0 | (M:preempt VP:0, KP:1, SP:1 HP:1 #P:1)
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
(T1/#0)            <...>  2576 0 3 00000004 00000000 [0002512920677720] 0.000ms (+3971052.610ms): <756f6a6b> (<6c616e72>)
(T1/#2)            <...>  2576 0 3 00000004 00000002 [0002512920677953] 0.000ms (+0.000ms): __trace_start_sched_wakeup+0x9a/0xd0 <c013150a> (try_to_wake_up+0x94/0x140 <c0110474>)
(T1/#3)            <...>  2576 0 3 00000003 00000003 [0002512920678126] 0.000ms (+0.000ms): preempt_schedule+0x11/0x80 <c02b57c1> (try_to_wake_up+0x94/0x140 <c0110474>)
(T3/#4)    <...>-2576  0dn.3    0�s : try_to_wake_up+0x11e/0x140 <c01104fe> <<...>-2> (69 73): 
(T1/#5)            <...>  2576 0 3 00000002 00000005 [0002512920678609] 0.000ms (+0.000ms): preempt_schedule+0x11/0x80 <c02b57c1> (try_to_wake_up+0xf8/0x140 <c01104d8>)
(T1/#6)            <...>  2576 0 3 00000002 00000006 [0002512920678807] 0.000ms (+0.000ms): wake_up_process+0x35/0x40 <c0110555> (do_softirq+0x3f/0x50 <c011b05f>)
(T6/#7)    <...>-2576  0dn.1    1�s < (1)
(T1/#8)            <...>  2576 0 2 00000001 00000008 [0002512920679575] 0.001ms (+0.000ms): __journal_unfile_buffer+0xe/0x1c0 <c01a9d2e> (journal_commit_transaction+0xda2/0x1170 <c01aba72>)
(T1/#9)            <...>  2576 0 2 00000001 00000009 [0002512920680035] 0.001ms (+0.000ms): journal_remove_journal_head+0xc/0x60 <c01b074c> (journal_commit_transaction+0xdb7/0x1170 <c01aba87>)
(T1/#10)            <...>  2576 0 2 00000001 0000000a [0002512920680231] 0.001ms (+0.000ms): __journal_remove_journal_head+0x11/0x180 <c01b05d1> (journal_remove_journal_head+0x3c/0x60 <c01b077c>)
(T1/#11)            <...>  2576 0 2 00000001 0000000b [0002512920680454] 0.002ms (+0.000ms): __brelse+0xb/0x70 <c015c10b> (__journal_remove_journal_head+0xb5/0x180 <c01b0675>)
(T1/#12)            <...>  2576 0 2 00000001 0000000c [0002512920680599] 0.002ms (+0.000ms): journal_free_journal_head+0xb/0x30 <c01b040b> (journal_remove_journal_head+0x3c/0x60 <c01b077c>)
(T1/#13)            <...>  2576 0 2 00000001 0000000d [0002512920680736] 0.002ms (+0.000ms): kmem_cache_free+0x14/0x60 <c01432c4> (journal_free_journal_head+0x1f/0x30 <c01b041f>)
(T1/#14)            <...>  2576 0 2 00000001 0000000e [0002512920681179] 0.002ms (+0.000ms): inverted_lock+0xb/0x50 <c01aab4b> (journal_commit_transaction+0x333/0x1170 <c01ab003>)
(T1/#15)            <...>  2576 0 2 00000001 0000000f [0002512920681438] 0.002ms (+0.000ms): __journal_unfile_buffer+0xe/0x1c0 <c01a9d2e> (journal_commit_transaction+0xda2/0x1170 <c01aba72>)
(T1/#16)            <...>  2576 0 2 00000001 00000010 [0002512920681752] 0.003ms (+0.000ms): journal_remove_journal_head+0xc/0x60 <c01b074c> (journal_commit_transaction+0xdb7/0x1170 <c01aba87>)
(T1/#17)            <...>  2576 0 2 00000001 00000011 [0002512920681919] 0.003ms (+0.000ms): __journal_remove_journal_head+0x11/0x180 <c01b05d1> (journal_remove_journal_head+0x3c/0x60 <c01b077c>)
(T1/#18)            <...>  2576 0 2 00000001 00000012 [0002512920682099] 0.003ms (+0.000ms): __brelse+0xb/0x70 <c015c10b> (__journal_remove_journal_head+0xb5/0x180 <c01b0675>)
(T1/#19)            <...>  2576 0 2 00000001 00000013 [0002512920682214] 0.003ms (+0.000ms): journal_free_journal_head+0xb/0x30 <c01b040b> (journal_remove_journal_head+0x3c/0x60 <c01b077c>)
(T1/#20)            <...>  2576 0 2 00000001 00000014 [0002512920682324] 0.003ms (+0.000ms): kmem_cache_free+0x14/0x60 <c01432c4> (journal_free_journal_head+0x1f/0x30 <c01b041f>)
(T1/#21)            <...>  2576 0 2 00000001 00000015 [0002512920682960] 0.003ms (+0.000ms): inverted_lock+0xb/0x50 <c01aab4b> (journal_commit_transaction+0x333/0x1170 <c01ab003>)
(T1/#22)            <...>  2576 0 2 00000001 00000016 [0002512920683128] 0.004ms (+0.000ms): __journal_unfile_buffer+0xe/0x1c0 <c01a9d2e> (journal_commit_transaction+0xda2/0x1170 <c01aba72>)
(T1/#23)            <...>  2576 0 2 00000001 00000017 [0002512920683821] 0.004ms (+0.000ms): journal_remove_journal_head+0xc/0x60 <c01b074c> (journal_commit_transaction+0xdb7/0x1170 <c01aba87>)
(T1/#24)            <...>  2576 0 2 00000001 00000018 [0002512920683933] 0.004ms (+0.000ms): __journal_remove_journal_head+0x11/0x180 <c01b05d1> (journal_remove_journal_head+0x3c/0x60 <c01b077c>)
(T1/#25)            <...>  2576 0 2 00000001 00000019 [0002512920684068] 0.004ms (+0.000ms): __brelse+0xb/0x70 <c015c10b> (__journal_remove_journal_head+0xb5/0x180 <c01b0675>)
(T1/#26)            <...>  2576 0 2 00000001 0000001a [0002512920684192] 0.004ms (+0.000ms): journal_free_journal_head+0xb/0x30 <c01b040b> (journal_remove_journal_head+0x3c/0x60 <c01b077c>)
(T1/#27)            <...>  2576 0 2 00000001 0000001b [0002512920684330] 0.004ms (+0.000ms): kmem_cache_free+0x14/0x60 <c01432c4> (journal_free_journal_head+0x1f/0x30 <c01b041f>)
(T1/#28)            <...>  2576 0 2 00000001 0000001c [0002512920685322] 0.005ms (+0.000ms): inverted_lock+0xb/0x50 <c01aab4b> (journal_commit_transaction+0x333/0x1170 <c01ab003>)
(T1/#29)            <...>  2576 0 2 00000001 0000001d [0002512920685528] 0.005ms (+0.000ms): __journal_unfile_buffer+0xe/0x1c0 <c01a9d2e> (journal_commit_transaction+0xda2/0x1170 <c01aba72>)
(T1/#30)            <...>  2576 0 2 00000001 0000001e [0002512920686007] 0.006ms (+0.000ms): journal_remove_journal_head+0xc/0x60 <c01b074c> (journal_commit_transaction+0xdb7/0x1170 <c01aba87>)
(T1/#31)            <...>  2576 0 2 00000001 0000001f [0002512920686121] 0.006ms (+0.000ms): __journal_remove_journal_head+0x11/0x180 <c01b05d1> (journal_remove_journal_head+0x3c/0x60 <c01b077c>)
(T1/#32)            <...>  2576 0 2 00000001 00000020 [0002512920686252] 0.006ms (+0.000ms): __brelse+0xb/0x70 <c015c10b> (__journal_remove_journal_head+0xb5/0x180 <c01b0675>)
(T1/#33)            <...>  2576 0 2 00000001 00000021 [0002512920686386] 0.006ms (+0.000ms): journal_free_journal_head+0xb/0x30 <c01b040b> (journal_remove_journal_head+0x3c/0x60 <c01b077c>)
(T1/#34)            <...>  2576 0 2 00000001 00000022 [0002512920686520] 0.006ms (+0.000ms): kmem_cache_free+0x14/0x60 <c01432c4> (journal_free_journal_head+0x1f/0x30 <c01b041f>)
(T1/#35)            <...>  2576 0 2 00000001 00000023 [0002512920687308] 0.007ms (+0.000ms): inverted_lock+0xb/0x50 <c01aab4b> (journal_commit_transaction+0x333/0x1170 <c01ab003>)
(T1/#36)            <...>  2576 0 2 00000001 00000024 [0002512920687446] 0.007ms (+0.000ms): __journal_unfile_buffer+0xe/0x1c0 <c01a9d2e> (journal_commit_transaction+0xda2/0x1170 <c01aba72>)
(T1/#37)            <...>  2576 0 2 00000001 00000025 [0002512920687924] 0.007ms (+0.000ms): journal_remove_journal_head+0xc/0x60 <c01b074c> (journal_commit_transaction+0xdb7/0x1170 <c01aba87>)
(T1/#38)            <...>  2576 0 2 00000001 00000026 [0002512920688036] 0.007ms (+0.000ms): __journal_remove_journal_head+0x11/0x180 <c01b05d1> (journal_remove_journal_head+0x3c/0x60 <c01b077c>)
(T1/#39)            <...>  2576 0 2 00000001 00000027 [0002512920688427] 0.008ms (+0.000ms): __brelse+0xb/0x70 <c015c10b> (__journal_remove_journal_head+0xb5/0x180 <c01b0675>)
(T1/#40)            <...>  2576 0 2 00000001 00000028 [0002512920688542] 0.008ms (+0.000ms): journal_free_journal_head+0xb/0x30 <c01b040b> (journal_remove_journal_head+0x3c/0x60 <c01b077c>)
(T1/#41)            <...>  2576 0 2 00000001 00000029 [0002512920688680] 0.008ms (+0.000ms): kmem_cache_free+0x14/0x60 <c01432c4> (journal_free_journal_head+0x1f/0x30 <c01b041f>)
(T1/#42)            <...>  2576 0 3 00000001 0000002a [0002512920688960] 0.008ms (+0.000ms): cache_flusharray+0xe/0x100 <c014301e> (kmem_cache_free+0x4f/0x60 <c01432ff>)
(T1/#43)            <...>  2576 0 3 00000002 0000002b [0002512920689162] 0.008ms (+0.001ms): free_block+0xe/0xe0 <c0142f3e> (cache_flusharray+0x54/0x100 <c0143064>)
(T1/#44)            <...>  2576 0 3 00000001 0000002c [0002512920690764] 0.009ms (+0.000ms): preempt_schedule+0x11/0x80 <c02b57c1> (cache_flusharray+0x9e/0x100 <c01430ae>)
(T1/#45)            <...>  2576 0 3 00000001 0000002d [0002512920690907] 0.009ms (+0.000ms): memmove+0x14/0x60 <c01e2b14> (cache_flusharray+0x91/0x100 <c01430a1>)
(T1/#46)            <...>  2576 0 3 00000001 0000002e [0002512920691038] 0.009ms (+0.000ms): memcpy+0x11/0x60 <c01e2a91> (memmove+0x50/0x60 <c01e2b50>)
(T1/#47)            <...>  2576 0 2 00000001 0000002f [0002512920692070] 0.010ms (+0.000ms): inverted_lock+0xb/0x50 <c01aab4b> (journal_commit_transaction+0x333/0x1170 <c01ab003>)
(T1/#48)            <...>  2576 0 2 00000001 00000030 [0002512920692254] 0.010ms (+0.000ms): __journal_unfile_buffer+0xe/0x1c0 <c01a9d2e> (journal_commit_transaction+0xda2/0x1170 <c01aba72>)
(T1/#49)            <...>  2576 0 2 00000001 00000031 [0002512920692401] 0.010ms (+0.000ms): journal_remove_journal_head+0xc/0x60 <c01b074c> (journal_commit_transaction+0xdb7/0x1170 <c01aba87>)
(T1/#50)            <...>  2576 0 2 00000001 00000032 [0002512920692513] 0.011ms (+0.000ms): __journal_remove_journal_head+0x11/0x180 <c01b05d1> (journal_remove_journal_head+0x3c/0x60 <c01b077c>)
(T1/#51)            <...>  2576 0 2 00000001 00000033 [0002512920692919] 0.011ms (+0.000ms): __brelse+0xb/0x70 <c015c10b> (__journal_remove_journal_head+0xb5/0x180 <c01b0675>)

etc

