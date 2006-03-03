Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750894AbWCCV0w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750894AbWCCV0w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 16:26:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750904AbWCCV0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 16:26:52 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:23274 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750863AbWCCV0v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 16:26:51 -0500
Subject: Re: AMD64 X2 lost ticks on PM timer
From: Lee Revell <rlrevell@joe-job.com>
To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
Cc: Andi Kleen <ak@suse.de>, Jason Baron <jbaron@redhat.com>,
       linux-kernel@vger.kernel.org, john stultz <johnstul@us.ibm.com>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20060303191822.GE32407@ti64.telemetry-investments.com>
References: <200602280022.40769.darkray@ic3man.com>
	 <200603011647.34516.ak@suse.de>
	 <20060301180714.GD20092@ti64.telemetry-investments.com>
	 <200603011929.59307.ak@suse.de> <1141240611.5860.176.camel@mindpipe>
	 <20060303191822.GE32407@ti64.telemetry-investments.com>
Content-Type: text/plain
Date: Fri, 03 Mar 2006 16:26:43 -0500
Message-Id: <1141421204.3042.139.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.92 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All this tells me is that your system's timer is screwed up (not news).

John, Ingo, any ideas?

Lee

On Fri, 2006-03-03 at 14:18 -0500, Bill Rugolsky Jr. wrote:
> On Wed, Mar 01, 2006 at 02:16:50PM -0500, Lee Revell wrote:
> > On Wed, 2006-03-01 at 19:29 +0100, Andi Kleen wrote:
> > > Sprinkle WARN_ON(in_interrupt()) all over the parts that shouldn't
> > > have interrupts 
> > > off. 
> > 
> > Might be faster to just try the -rt kernel, it has tons of debugging
> > checks for stuff like this.
> 
> After several attempts where 2.6.15-rt18 reset on startup, I whittled
> my config down to something minimal (turned off NUMA, CPUSETS, PRINTK_TIME, ...)
> and got it up and running PREEMPT_RT:
> 
> rugolsky@ti94: uname -a
> Linux ti94 2.6.15-rt18-realtime #4 SMP PREEMPT Fri Mar 3 11:39:20 EST 2006 x86_64 x86_64 x86_64 GNU/Linux
> 
> rugolsky@ti94: egrep 'PREEMPT|LATENCY|HZ' .config
> # CONFIG_PREEMPT_NONE is not set
> # CONFIG_PREEMPT_VOLUNTARY is not set
> # CONFIG_PREEMPT_DESKTOP is not set
> CONFIG_PREEMPT_RT=y
> CONFIG_PREEMPT=y
> CONFIG_PREEMPT_SOFTIRQS=y
> CONFIG_PREEMPT_HARDIRQS=y
> CONFIG_PREEMPT_BKL=y
> CONFIG_PREEMPT_RCU=y
> # CONFIG_HZ_100 is not set
> # CONFIG_HZ_250 is not set
> CONFIG_HZ_1000=y
> CONFIG_HZ=1000
> CONFIG_DEBUG_PREEMPT=y
> # CONFIG_WAKEUP_LATENCY_HIST is not set
> CONFIG_PREEMPT_TRACE=y
> CONFIG_CRITICAL_PREEMPT_TIMING=y
> # CONFIG_PREEMPT_OFF_HIST is not set
> CONFIG_LATENCY_TIMING=y
> CONFIG_LATENCY_TRACE=y
> 
> % sudo sysctl -a | egrep 'kernel\.*(preempt|latency|trace|wakeup)'
> kernel.preempt_thresh = 0
> kernel.preempt_max_latency = 2483
> kernel.trace_all_cpus = 1
> kernel.trace_verbose = 1
> kernel.trace_print_at_crash = 1
> kernel.trace_freerunning = 0
> kernel.trace_user_trigger_irq = -1
> kernel.trace_user_trigger_irq = -1
> kernel.trace_user_triggered = 0
> kernel.trace_enabled = 1
> kernel.wakeup_timing = 1
> 
> % cat /sys/devices/system/clocksource/clocksource0/current_clocksource 
> acpi_pm 
> 
> Should I be compiling for a different preempt mode?  I've only cursorily
> followed the realtime-preempt patch discussion threads, so I am unclear as
> to what debugging facilities are available with each preemption level.
> [Is there a howto/tutorial floating around on using the debugging
> features?]
> 
> I got the following trace.  Since you have a great deal of experience
> interpreting these traces, perhaps you can help me interpret this one?
> 
> Thanks.
> 
> 	Bill Rugolsky
> 
> 
> preemption latency trace v1.1.5 on 2.6.15-rt18-realtime
> --------------------------------------------------------------------
>  latency: 2483 us, #238/238, CPU#1 | (M:rt VP:0, KP:0, SP:1 HP:1 #P:2)
>     -----------------
>     | task: softirq-timer/1-14 (uid:0 nice:0 policy:1 rt_prio:1)
>     -----------------
> 
> (T1/#0)            <...>   697 0 16 00000000 00000000 [00000424e86874c5] 0.000ms (+0.000ms): smp_apic_timer_interrupt+0xc/0x48 <ffffffff8011902a> (apic_timer_interrupt+0x84/0x8c <ffffffff8010ead0>)
> (T1/#1)            <...>   697 0 20 00000000 00000001 [00000424e86876a8] 0.000ms (+0.000ms): smp_local_timer_interrupt+0xc/0x32 <ffffffff80118ad5> (smp_apic_timer_interrupt+0x3e/0x48 <ffffffff8011905c>)
> (T1/#2)            <...>   697 0 20 00000000 00000002 [00000424e868778c] 0.000ms (+0.000ms): profile_tick+0xc/0x77 <ffffffff801334d4> (smp_local_timer_interrupt+0x1c/0x32 <ffffffff80118ae5>)
> (T1/#3)            <...>   697 0 20 00000000 00000003 [00000424e8687885] 0.000ms (+0.000ms): profile_pc+0xc/0x71 <ffffffff8011173c> (profile_tick+0x67/0x77 <ffffffff8013352f>)
> (T1/#4)            <...>   697 0 20 00000000 00000004 [00000424e86879a4] 0.000ms (+0.000ms): profile_hit+0x14/0x19f <ffffffff8013333d> (profile_tick+0x72/0x77 <ffffffff8013353a>)
> (T1/#5)            <...>   697 0 20 00000000 00000005 [00000424e8687aae] 0.000ms (+0.000ms): update_process_times+0xc/0x68 <ffffffff8013b457> (smp_local_timer_interrupt+0x2e/0x32 <ffffffff80118af7>)
> (T1/#6)            <...>   697 0 20 00000000 00000006 [00000424e8687baf] 0.000ms (+0.000ms): account_system_time+0x9/0x9e <ffffffff8012a19c> (update_process_times+0x3f/0x68 <ffffffff8013b48a>)
> (T1/#7)            <...>   697 0 20 00000000 00000007 [00000424e8687cb0] 0.001ms (+0.000ms): acct_update_integrals+0x9/0x59 <ffffffff801571a1> (account_system_time+0x9c/0x9e <ffffffff8012a22f>)
> (T1/#8)            <...>   697 0 20 00000000 00000008 [00000424e8687dca] 0.001ms (+0.000ms): run_local_timers+0x9/0x15 <ffffffff8013b0cd> (update_process_times+0x44/0x68 <ffffffff8013b48f>)
> (T1/#9)            <...>   697 0 20 00000000 00000009 [00000424e8687ea7] 0.001ms (+0.000ms): raise_softirq+0xc/0x91 <ffffffff80137cf8> (run_local_timers+0x13/0x15 <ffffffff8013b0d7>)
> (T1/#10)            <...>   697 0 20 00000000 0000000a [00000424e8687fce] 0.001ms (+0.000ms): wakeup_softirqd+0x9/0x38 <ffffffff801373e5> (raise_softirq+0x6f/0x91 <ffffffff80137d5b>)
> (T1/#11)            <...>   697 0 20 00000000 0000000b [00000424e86880c5] 0.001ms (+0.000ms): wake_up_process+0xb/0x31 <ffffffff8012cd66> (wakeup_softirqd+0x36/0x38 <ffffffff80137412>)
> (T1/#12)            <...>   697 0 20 00000000 0000000c [00000424e86881ab] 0.001ms (+0.000ms): check_preempt_wakeup+0xc/0xac <ffffffff8014a814> (wake_up_process+0x13/0x31 <ffffffff8012cd6e>)
> (T1/#13)            <...>   697 0 20 00000000 0000000d [00000424e86882b4] 0.001ms (+0.000ms): try_to_wake_up+0x16/0x560 <ffffffff8012c747> (wake_up_process+0x24/0x31 <ffffffff8012cd7f>)
> (T1/#14)            <...>   697 0 20 00000000 0000000e [00000424e86883ad] 0.001ms (+0.000ms): _raw_spin_lock+0xb/0x25 <ffffffff802fa1a7> (try_to_wake_up+0x5d/0x560 <ffffffff8012c78e>)
> (T1/#15)            <...>   697 0 20 00000001 0000000f [00000424e86884fd] 0.002ms (+0.000ms): idle_cpu+0x9/0x30 <ffffffff80129d37> (try_to_wake_up+0x292/0x560 <ffffffff8012c9c3>)
> (T1/#16)           <idle>     0 1 23 00000003 00000010 [00000424e86885b5] 0.002ms (+0.000ms): _raw_spin_unlock_irqrestore+0xb/0x62 <ffffffff802fa61d> (unmask_IO_APIC_irq+0x35/0x3a <ffffffff8011a854>)
> (T1/#17)            <...>   697 0 20 00000001 00000011 [00000424e868868b] 0.002ms (+0.000ms): smp_send_reschedule_allbutself+0x9/0x1a <ffffffff8011809b> (try_to_wake_up+0x3e9/0x560 <ffffffff8012cb1a>)
> (T1/#18)           <idle>     0 1 23 00000002 00000012 [00000424e86886b0] 0.002ms (+0.000ms): check_raw_flags+0x9/0x5b <ffffffff8014a6f5> (_raw_spin_unlock_irqrestore+0x26/0x62 <ffffffff802fa638>)
> (T1/#19)            <...>   697 0 20 00000001 00000013 [00000424e8688779] 0.002ms (+0.000ms): flat_send_IPI_allbutself+0xb/0x5b <ffffffff8011b644> (smp_send_reschedule_allbutself+0x18/0x1a <ffffffff801180aa>)
> (T1/#20)           <idle>     0 1 23 00000002 00000014 [00000424e86887ba] 0.002ms (+0.000ms): constant_test_bit+0x9/0x25 <ffffffff80152845> (_raw_spin_unlock_irqrestore+0x55/0x62 <ffffffff802fa667>)
> (T1/#21)            <...>   697 0 20 00000001 00000015 [00000424e8688855] 0.002ms (+0.000ms): __bitmap_weight+0xa/0x18b <ffffffff801fbce6> (flat_send_IPI_allbutself+0x1e/0x5b <ffffffff8011b657>)
> (T1/#22)           <idle>     0 1 23 00000002 00000016 [00000424e86888ab] 0.002ms (+0.000ms): preempt_schedule+0xc/0x9d <ffffffff802f82a1> (_raw_spin_unlock_irqrestore+0x5e/0x62 <ffffffff802fa670>)
> (T1/#23)           <idle>     0 1 23 00000002 00000017 [00000424e86889c7] 0.002ms (+0.000ms): _raw_spin_unlock+0x9/0x3e <ffffffff802fa6f7> (__do_IRQ+0x12a/0x141 <ffffffff8015deb9>)
> (T1/#24)            <...>   697 0 20 00000001 00000018 [00000424e8688a6c] 0.002ms (+0.000ms): activate_task+0x10/0xe0 <ffffffff8012bc38> (try_to_wake_up+0x491/0x560 <ffffffff8012cbc2>)
> (T1/#25)           <idle>     0 1 23 00000001 00000019 [00000424e8688abd] 0.002ms (+0.000ms): constant_test_bit+0x9/0x25 <ffffffff80152845> (_raw_spin_unlock+0x33/0x3e <ffffffff802fa721>)
> (T1/#26)            <...>   697 0 20 00000001 0000001a [00000424e8688b4b] 0.002ms (+0.000ms): sched_clock+0x9/0x26 <ffffffff8011180c> (activate_task+0x1d/0xe0 <ffffffff8012bc45>)
> (T1/#27)           <idle>     0 1 23 00000001 0000001b [00000424e8688bbc] 0.002ms (+0.000ms): preempt_schedule+0xc/0x9d <ffffffff802f82a1> (_raw_spin_unlock+0x3c/0x3e <ffffffff802fa72a>)
> (T3/#28)    <...>-697   0D.h1    2us : activate_task+0x9b/0xe0 <ffffffff8012bcc3> <<...>-4> (62 1)
> (T1/#29)           <idle>     0 1 23 00000001 0000001d [00000424e8688cd8] 0.003ms (+0.000ms): irq_exit+0x9/0x28 <ffffffff80137aaa> (do_IRQ+0x3a/0x44 <ffffffff80110767>)
> (T1/#30)            <...>   697 0 20 00000001 0000001e [00000424e8688d26] 0.003ms (+0.000ms): enqueue_task+0xc/0x95 <ffffffff80129be4> (activate_task+0xa7/0xe0 <ffffffff8012bccf>)
> (T1/#31)            <...>   697 0 20 00000001 0000001f [00000424e8688f26] 0.003ms (+0.000ms): _raw_spin_unlock_irqrestore+0xb/0x62 <ffffffff802fa61d> (try_to_wake_up+0x54f/0x560 <ffffffff8012cc80>)
> (T1/#32)           <idle>     0 1 19 00000001 00000020 [00000424e8688f9e] 0.003ms (+0.000ms): smp_reschedule_interrupt+0x9/0x16 <ffffffff801186ee> (reschedule_interrupt+0x84/0x8c <ffffffff8010e558>)
> (T1/#33)            <...>   697 0 20 00000000 00000021 [00000424e868901e] 0.003ms (+0.000ms): check_raw_flags+0x9/0x5b <ffffffff8014a6f5> (_raw_spin_unlock_irqrestore+0x26/0x62 <ffffffff802fa638>)
> (T1/#34)            <...>   697 0 20 00000000 00000022 [00000424e8689137] 0.003ms (+0.000ms): constant_test_bit+0x9/0x25 <ffffffff80152845> (_raw_spin_unlock_irqrestore+0x55/0x62 <ffffffff802fa667>)
> (T1/#35)           <idle>     0 1 19 00000001 00000023 [00000424e8689211] 0.003ms (+0.000ms): smp_apic_timer_interrupt+0xc/0x48 <ffffffff8011902a> (apic_timer_interrupt+0x84/0x8c <ffffffff8010ead0>)
> (T1/#36)            <...>   697 0 20 00000000 00000024 [00000424e8689254] 0.003ms (+0.000ms): wake_up_process+0x2b/0x31 <ffffffff8012cd86> (wakeup_softirqd+0x36/0x38 <ffffffff80137412>)
> (T1/#37)            <...>   697 0 20 00000000 00000025 [00000424e8689354] 0.003ms (+0.000ms): check_raw_flags+0x9/0x5b <ffffffff8014a6f5> (raise_softirq+0x77/0x91 <ffffffff80137d63>)
> (T1/#38)           <idle>     0 1 23 00000001 00000026 [00000424e8689354] 0.003ms (+0.000ms): smp_local_timer_interrupt+0xc/0x32 <ffffffff80118ad5> (smp_apic_timer_interrupt+0x3e/0x48 <ffffffff8011905c>)
> (T1/#39)           <idle>     0 1 23 00000001 00000027 [00000424e8689426] 0.003ms (+0.000ms): profile_tick+0xc/0x77 <ffffffff801334d4> (smp_local_timer_interrupt+0x1c/0x32 <ffffffff80118ae5>)
> (T1/#40)            <...>   697 0 20 00000000 00000028 [00000424e8689492] 0.004ms (+0.000ms): rcu_pending+0x9/0x30 <ffffffff801445e8> (update_process_times+0x4b/0x68 <ffffffff8013b496>)
> (T1/#41)           <idle>     0 1 23 00000001 00000029 [00000424e8689520] 0.004ms (+0.000ms): profile_pc+0xc/0x71 <ffffffff8011173c> (profile_tick+0x67/0x77 <ffffffff8013352f>)
> (T1/#42)            <...>   697 0 20 00000000 0000002a [00000424e86895c8] 0.004ms (+0.000ms): scheduler_tick+0x13/0x34c <ffffffff8012d1b9> (update_process_times+0x5e/0x68 <ffffffff8013b4a9>)
> (T1/#43)           <idle>     0 1 23 00000001 0000002b [00000424e8689636] 0.004ms (+0.000ms): profile_hit+0x14/0x19f <ffffffff8013333d> (profile_tick+0x72/0x77 <ffffffff8013353a>)
> (T1/#44)            <...>   697 0 20 00000000 0000002c [00000424e86896af] 0.004ms (+0.000ms): sched_clock+0x9/0x26 <ffffffff8011180c> (scheduler_tick+0x3d/0x34c <ffffffff8012d1e3>)
> (T1/#45)           <idle>     0 1 23 00000001 0000002d [00000424e8689754] 0.004ms (+0.000ms): update_process_times+0xc/0x68 <ffffffff8013b457> (smp_local_timer_interrupt+0x2e/0x32 <ffffffff80118af7>)
> (T1/#46)            <...>   697 0 20 00000000 0000002e [00000424e86897c5] 0.004ms (+0.000ms): _raw_spin_lock+0xb/0x25 <ffffffff802fa1a7> (scheduler_tick+0xce/0x34c <ffffffff8012d274>)
> (T1/#47)           <idle>     0 1 23 00000001 0000002f [00000424e868984a] 0.004ms (+0.000ms): account_system_time+0x9/0x9e <ffffffff8012a19c> (update_process_times+0x3f/0x68 <ffffffff8013b48a>)
> (T1/#48)            <...>   697 0 20 00000001 00000030 [00000424e86898f8] 0.004ms (+0.000ms): _raw_spin_unlock+0x9/0x3e <ffffffff802fa6f7> (scheduler_tick+0x330/0x34c <ffffffff8012d4d6>)
> (T1/#49)           <idle>     0 1 23 00000001 00000031 [00000424e868994c] 0.004ms (+0.000ms): acct_update_integrals+0x9/0x59 <ffffffff801571a1> (account_system_time+0x9c/0x9e <ffffffff8012a22f>)
> (T1/#50)            <...>   697 0 20 00000000 00000032 [00000424e8689a04] 0.004ms (+0.000ms): constant_test_bit+0x9/0x25 <ffffffff80152845> (_raw_spin_unlock+0x33/0x3e <ffffffff802fa721>)
> (T1/#51)           <idle>     0 1 23 00000001 00000033 [00000424e8689a5a] 0.004ms (+0.000ms): run_local_timers+0x9/0x15 <ffffffff8013b0cd> (update_process_times+0x44/0x68 <ffffffff8013b48f>)
> (T1/#52)            <...>   697 0 20 00000000 00000034 [00000424e8689b0b] 0.004ms (+0.000ms): rebalance_tick+0x16/0x2e8 <ffffffff8012ced4> (scheduler_tick+0x340/0x34c <ffffffff8012d4e6>)
> (T1/#53)           <idle>     0 1 23 00000001 00000035 [00000424e8689b36] 0.004ms (+0.000ms): raise_softirq+0xc/0x91 <ffffffff80137cf8> (run_local_timers+0x13/0x15 <ffffffff8013b0d7>)
> (T1/#54)           <idle>     0 1 23 00000001 00000036 [00000424e8689c41] 0.005ms (+0.000ms): wakeup_softirqd+0x9/0x38 <ffffffff801373e5> (raise_softirq+0x6f/0x91 <ffffffff80137d5b>)
> (T1/#55)           <idle>     0 1 23 00000001 00000037 [00000424e8689d50] 0.005ms (+0.000ms): check_raw_flags+0x9/0x5b <ffffffff8014a6f5> (raise_softirq+0x77/0x91 <ffffffff80137d63>)
> (T1/#56)            <...>   697 0 20 00000000 00000038 [00000424e8689dc9] 0.005ms (+0.000ms): softlockup_tick+0xf/0x11d <ffffffff8015d672> (update_process_times+0x63/0x68 <ffffffff8013b4ae>)
> (T1/#57)           <idle>     0 1 23 00000001 00000039 [00000424e8689e81] 0.005ms (+0.000ms): rcu_pending+0x9/0x30 <ffffffff801445e8> (update_process_times+0x4b/0x68 <ffffffff8013b496>)
> (T1/#58)            <...>   697 0 20 00000000 0000003a [00000424e8689ef2] 0.005ms (+0.000ms): irq_exit+0x9/0x28 <ffffffff80137aaa> (smp_apic_timer_interrupt+0x43/0x48 <ffffffff80119061>)
> (T1/#59)           <idle>     0 1 23 00000001 0000003b [00000424e8689f91] 0.005ms (+0.000ms): scheduler_tick+0x13/0x34c <ffffffff8012d1b9> (update_process_times+0x5e/0x68 <ffffffff8013b4a9>)
> (T1/#60)           <idle>     0 1 23 00000001 0000003c [00000424e868a078] 0.005ms (+0.000ms): sched_clock+0x9/0x26 <ffffffff8011180c> (scheduler_tick+0x3d/0x34c <ffffffff8012d1e3>)
> (T1/#61)           <idle>     0 1 23 00000001 0000003d [00000424e868a17d] 0.005ms (+0.000ms): _raw_spin_lock+0xb/0x25 <ffffffff802fa1a7> (scheduler_tick+0x81/0x34c <ffffffff8012d227>)
> (T1/#62)            <...>   697 0 16 00000000 0000003e [00000424e868a1e5] 0.005ms (+0.000ms): do_IRQ+0xc/0x44 <ffffffff80110739> (ret_from_intr+0x0/0x12 <ffffffff8010e276>)
> (T1/#63)           <idle>     0 1 23 00000002 0000003f [00000424e868a2cf] 0.005ms (+0.000ms): resched_task+0xc/0x79 <ffffffff8012a958> (scheduler_tick+0x95/0x34c <ffffffff8012d23b>)
> (T1/#64)            <...>   697 0 20 00000000 00000040 [00000424e868a332] 0.005ms (+0.000ms): _raw_spin_lock+0xb/0x25 <ffffffff802fa1a7> (__do_IRQ+0x5d/0x141 <ffffffff8015ddec>)
> (T1/#65)           <idle>     0 1 23 00000002 00000041 [00000424e868a3e6] 0.006ms (+0.000ms): _raw_spin_unlock+0x9/0x3e <ffffffff802fa6f7> (scheduler_tick+0x9d/0x34c <ffffffff8012d243>)
> (T1/#66)            <...>   697 0 20 00000001 00000042 [00000424e868a469] 0.006ms (+0.000ms): mask_and_ack_level_ioapic_irq+0x10/0xa2 <ffffffff8011aa2d> (__do_IRQ+0x72/0x141 <ffffffff8015de01>)
> (T1/#67)           <idle>     0 1 23 00000001 00000043 [00000424e868a4e0] 0.006ms (+0.000ms): constant_test_bit+0x9/0x25 <ffffffff80152845> (_raw_spin_unlock+0x33/0x3e <ffffffff802fa721>)
> (T1/#68)            <...>   697 0 20 00000001 00000044 [00000424e868a548] 0.006ms (+0.000ms): mask_IO_APIC_irq+0xb/0x11e <ffffffff8011a90a> (mask_and_ack_level_ioapic_irq+0x8e/0xa2 <ffffffff8011aaab>)
> (T1/#69)           <idle>     0 1 23 00000001 00000045 [00000424e868a5e8] 0.006ms (+0.000ms): preempt_schedule+0xc/0x9d <ffffffff802f82a1> (_raw_spin_unlock+0x3c/0x3e <ffffffff802fa72a>)
> (T1/#70)            <...>   697 0 20 00000001 00000046 [00000424e868a6bd] 0.006ms (+0.000ms): _raw_spin_lock_irqsave+0xc/0x33 <ffffffff802fa2ab> (mask_IO_APIC_irq+0x19/0x11e <ffffffff8011a918>)
> (T1/#71)           <idle>     0 1 23 00000001 00000047 [00000424e868a70c] 0.006ms (+0.000ms): rebalance_tick+0x16/0x2e8 <ffffffff8012ced4> (scheduler_tick+0x340/0x34c <ffffffff8012d4e6>)
> (T1/#72)           <idle>     0 1 23 00000001 00000048 [00000424e868a936] 0.006ms (+0.000ms): softlockup_tick+0xf/0x11d <ffffffff8015d672> (update_process_times+0x63/0x68 <ffffffff8013b4ae>)
> (T1/#73)           <idle>     0 1 23 00000001 00000049 [00000424e868aa5e] 0.006ms (+0.000ms): irq_exit+0x9/0x28 <ffffffff80137aaa> (smp_apic_timer_interrupt+0x43/0x48 <ffffffff80119061>)
> (T1/#74)           <idle>     0 1 19 00000001 0000004a [00000424e868ad2f] 0.007ms (+0.000ms): do_IRQ+0xc/0x44 <ffffffff80110739> (ret_from_intr+0x0/0x12 <ffffffff8010e276>)
> (T1/#75)           <idle>     0 1 23 00000001 0000004b [00000424e868ae68] 0.007ms (+0.000ms): _raw_spin_lock+0xb/0x25 <ffffffff802fa1a7> (__do_IRQ+0x5d/0x141 <ffffffff8015ddec>)
> (T1/#76)           <idle>     0 1 23 00000002 0000004c [00000424e868b067] 0.007ms (+0.000ms): ack_edge_ioapic_irq+0x10/0xba <ffffffff8011ab21> (__do_IRQ+0x72/0x141 <ffffffff8015de01>)
> (T1/#77)           <idle>     0 1 23 00000002 0000004d [00000424e868b16b] 0.007ms (+0.000ms): redirect_hardirq+0x9/0x53 <ffffffff8015d909> (__do_IRQ+0xb5/0x141 <ffffffff8015de44>)
> (T1/#78)           <idle>     0 1 23 00000002 0000004e [00000424e868b283] 0.007ms (+0.000ms): _raw_spin_unlock+0x9/0x3e <ffffffff802fa6f7> (__do_IRQ+0xc1/0x141 <ffffffff8015de50>)
> (T1/#79)           <idle>     0 1 23 00000001 0000004f [00000424e868b38d] 0.007ms (+0.000ms): constant_test_bit+0x9/0x25 <ffffffff80152845> (_raw_spin_unlock+0x33/0x3e <ffffffff802fa721>)
> (T1/#80)           <idle>     0 1 23 00000001 00000050 [00000424e868b4a0] 0.008ms (+0.000ms): preempt_schedule+0xc/0x9d <ffffffff802f82a1> (_raw_spin_unlock+0x3c/0x3e <ffffffff802fa72a>)
> (T1/#81)           <idle>     0 1 23 00000001 00000051 [00000424e868b5af] 0.008ms (+0.000ms): handle_IRQ_event+0x16/0x114 <ffffffff8015d96f> (__do_IRQ+0xd1/0x141 <ffffffff8015de60>)
> (T1/#82)           <idle>     0 1 23 00000001 00000052 [00000424e868b699] 0.008ms (+0.000ms): timer_interrupt+0xb/0x62 <ffffffff801117ac> (handle_IRQ_event+0x6a/0x114 <ffffffff8015d9c3>)
> (T1/#83)           <idle>     0 1 23 00000001 00000053 [00000424e868b789] 0.008ms (+0.000ms): _raw_spin_lock+0xb/0x25 <ffffffff802fa1a7> (timer_interrupt+0x1a/0x62 <ffffffff801117bb>)
> (T1/#84)           <idle>     0 1 23 00000002 00000054 [00000424e868b8c5] 0.008ms (+0.000ms): do_timer+0x9/0x12 <ffffffff8013b0e2> (timer_interrupt+0x28/0x62 <ffffffff801117c9>)
> (T1/#85)           <idle>     0 1 23 00000002 00000055 [00000424e868ba17] 0.008ms (+0.000ms): _raw_spin_unlock+0x9/0x3e <ffffffff802fa6f7> (timer_interrupt+0x4b/0x62 <ffffffff801117ec>)
> (T1/#86)            <...>   697 0 20 00000002 00000056 [00000424e868ba4b] 0.008ms (+0.000ms): _raw_spin_unlock_irqrestore+0xb/0x62 <ffffffff802fa61d> (mask_IO_APIC_irq+0x11a/0x11e <ffffffff8011aa19>)
> (T1/#87)           <idle>     0 1 23 00000001 00000057 [00000424e868bb18] 0.008ms (+0.000ms): constant_test_bit+0x9/0x25 <ffffffff80152845> (_raw_spin_unlock+0x33/0x3e <ffffffff802fa721>)
> (T1/#88)            <...>   697 0 20 00000001 00000058 [00000424e868bb4d] 0.008ms (+0.000ms): check_raw_flags+0x9/0x5b <ffffffff8014a6f5> (_raw_spin_unlock_irqrestore+0x26/0x62 <ffffffff802fa638>)
> (T1/#89)           <idle>     0 1 23 00000001 00000059 [00000424e868bc15] 0.009ms (+0.000ms): preempt_schedule+0xc/0x9d <ffffffff802f82a1> (_raw_spin_unlock+0x3c/0x3e <ffffffff802fa72a>)
> (T1/#90)            <...>   697 0 20 00000001 0000005a [00000424e868bc62] 0.009ms (+0.000ms): constant_test_bit+0x9/0x25 <ffffffff80152845> (_raw_spin_unlock_irqrestore+0x55/0x62 <ffffffff802fa667>)
> (T1/#91)           <idle>     0 1 23 00000001 0000005b [00000424e868bd30] 0.009ms (+0.000ms): smp_send_timer_broadcast_ipi+0x9/0x31 <ffffffff80118a91> (timer_interrupt+0x59/0x62 <ffffffff801117fa>)
> (T1/#92)            <...>   697 0 20 00000001 0000005c [00000424e868bd98] 0.009ms (+0.000ms): redirect_hardirq+0x9/0x53 <ffffffff8015d909> (__do_IRQ+0xb5/0x141 <ffffffff8015de44>)
> (T1/#93)           <idle>     0 1 23 00000001 0000005d [00000424e868be66] 0.009ms (+0.000ms): _raw_spin_lock+0xb/0x25 <ffffffff802fa1a7> (__do_IRQ+0xdb/0x141 <ffffffff8015de6a>)
> (T1/#94)            <...>   697 0 20 00000001 0000005e [00000424e868bed0] 0.009ms (+0.000ms): wake_up_process+0xb/0x31 <ffffffff8012cd66> (redirect_hardirq+0x46/0x53 <ffffffff8015d946>)
> (T1/#95)           <idle>     0 1 23 00000002 0000005f [00000424e868bfa8] 0.009ms (+0.000ms): note_interrupt+0x16/0x227 <ffffffff8015ec77> (__do_IRQ+0xf5/0x141 <ffffffff8015de84>)
> (T1/#96)            <...>   697 0 20 00000001 00000060 [00000424e868bfe2] 0.009ms (+0.000ms): check_preempt_wakeup+0xc/0xac <ffffffff8014a814> (wake_up_process+0x13/0x31 <ffffffff8012cd6e>)
> (T1/#97)           <idle>     0 1 23 00000002 00000061 [00000424e868c0a8] 0.009ms (+0.000ms): unmask_IO_APIC_irq+0xc/0x3a <ffffffff8011a82b> (__do_IRQ+0x122/0x141 <ffffffff8015deb1>)
> (T1/#98)            <...>   697 0 20 00000001 00000062 [00000424e868c0d6] 0.009ms (+0.000ms): try_to_wake_up+0x16/0x560 <ffffffff8012c747> (wake_up_process+0x24/0x31 <ffffffff8012cd7f>)
> (T1/#99)           <idle>     0 1 23 00000002 00000063 [00000424e868c19a] 0.009ms (+0.000ms): _raw_spin_lock_irqsave+0xc/0x33 <ffffffff802fa2ab> (unmask_IO_APIC_irq+0x1b/0x3a <ffffffff8011a83a>)
> (T1/#100)            <...>   697 0 20 00000001 00000064 [00000424e868c1f8] 0.009ms (+0.000ms): _raw_spin_lock+0xb/0x25 <ffffffff802fa1a7> (try_to_wake_up+0x5d/0x560 <ffffffff8012c78e>)
> (T1/#101)            <...>   697 0 20 00000002 00000065 [00000424e868c3d9] 0.010ms (+0.000ms): idle_cpu+0x9/0x30 <ffffffff80129d37> (try_to_wake_up+0x292/0x560 <ffffffff8012c9c3>)
> (T1/#102)           <idle>     0 1 23 00000003 00000066 [00000424e868c439] 0.010ms (+0.000ms): __unmask_IO_APIC_irq+0x9/0xff <ffffffff8011a729> (unmask_IO_APIC_irq+0x26/0x3a <ffffffff8011a845>)
> (T1/#103)            <...>   697 0 20 00000002 00000067 [00000424e868c538] 0.010ms (+0.000ms): smp_send_reschedule_allbutself+0x9/0x1a <ffffffff8011809b> (try_to_wake_up+0x3e9/0x560 <ffffffff8012cb1a>)
> (T1/#104)            <...>   697 0 20 00000002 00000068 [00000424e868c674] 0.010ms (+0.000ms): flat_send_IPI_allbutself+0xb/0x5b <ffffffff8011b644> (smp_send_reschedule_allbutself+0x18/0x1a <ffffffff801180aa>)
> (T1/#105)            <...>   697 0 20 00000002 00000069 [00000424e868c74e] 0.010ms (+0.000ms): __bitmap_weight+0xa/0x18b <ffffffff801fbce6> (flat_send_IPI_allbutself+0x1e/0x5b <ffffffff8011b657>)
> (T1/#106)            <...>   697 0 20 00000002 0000006a [00000424e868c95a] 0.010ms (+0.000ms): activate_task+0x10/0xe0 <ffffffff8012bc38> (try_to_wake_up+0x491/0x560 <ffffffff8012cbc2>)
> (T1/#107)            <...>   697 0 20 00000002 0000006b [00000424e868ca36] 0.010ms (+0.000ms): sched_clock+0x9/0x26 <ffffffff8011180c> (activate_task+0x1d/0xe0 <ffffffff8012bc45>)
> (T3/#108)    <...>-697   0D.h2   11us : activate_task+0x9b/0xe0 <ffffffff8012bcc3> <<...>-1432> (3a 2)
> (T1/#109)            <...>   697 0 20 00000002 0000006d [00000424e868cc15] 0.011ms (+0.000ms): enqueue_task+0xc/0x95 <ffffffff80129be4> (activate_task+0xa7/0xe0 <ffffffff8012bccf>)
> (T1/#110)            <...>   697 0 20 00000002 0000006e [00000424e868cdf1] 0.011ms (+0.000ms): _raw_spin_unlock_irqrestore+0xb/0x62 <ffffffff802fa61d> (try_to_wake_up+0x54f/0x560 <ffffffff8012cc80>)
> (T1/#111)            <...>   697 0 20 00000001 0000006f [00000424e868cf1a] 0.011ms (+0.000ms): check_raw_flags+0x9/0x5b <ffffffff8014a6f5> (_raw_spin_unlock_irqrestore+0x26/0x62 <ffffffff802fa638>)
> (T1/#112)            <...>   697 0 20 00000001 00000070 [00000424e868d02f] 0.011ms (+0.000ms): constant_test_bit+0x9/0x25 <ffffffff80152845> (_raw_spin_unlock_irqrestore+0x55/0x62 <ffffffff802fa667>)
> (T1/#113)            <...>   697 0 20 00000001 00000071 [00000424e868d147] 0.011ms (+0.000ms): wake_up_process+0x2b/0x31 <ffffffff8012cd86> (redirect_hardirq+0x46/0x53 <ffffffff8015d946>)
> (T1/#114)            <...>   697 0 20 00000001 00000072 [00000424e868d261] 0.011ms (+0.000ms): _raw_spin_unlock+0x9/0x3e <ffffffff802fa6f7> (__do_IRQ+0x12a/0x141 <ffffffff8015deb9>)
> (T1/#115)            <...>   697 0 20 00000000 00000073 [00000424e868d356] 0.012ms (+0.000ms): constant_test_bit+0x9/0x25 <ffffffff80152845> (_raw_spin_unlock+0x33/0x3e <ffffffff802fa721>)
> (T1/#116)            <...>   697 0 20 00000000 00000074 [00000424e868d470] 0.012ms (+0.000ms): irq_exit+0x9/0x28 <ffffffff80137aaa> (do_IRQ+0x3a/0x44 <ffffffff80110767>)
> (T1/#117)            <...>   697 0 0 00000000 00000075 [00000424e868d72e] 0.012ms (+0.000ms): ata_host_intr+0xf/0xb6 <ffffffff88033d99> (nv_interrupt+0x65/0xa6 <ffffffff88042065>)
> (T1/#118)            <...>   697 0 0 00000000 00000076 [00000424e868d81d] 0.012ms (+0.000ms): ata_bmdma_status+0x9/0x27 <ffffffff88031e66> (ata_host_intr+0x3e/0xb6 <ffffffff88033dc8>)
> (T1/#119)           <idle>     0 1 23 00000003 00000077 [00000424e868d846] 0.012ms (+0.000ms): _raw_spin_unlock_irqrestore+0xb/0x62 <ffffffff802fa61d> (unmask_IO_APIC_irq+0x35/0x3a <ffffffff8011a854>)
> (T1/#120)           <idle>     0 1 23 00000002 00000078 [00000424e868d958] 0.012ms (+0.000ms): check_raw_flags+0x9/0x5b <ffffffff8014a6f5> (_raw_spin_unlock_irqrestore+0x26/0x62 <ffffffff802fa638>)
> (T1/#121)           <idle>     0 1 23 00000002 00000079 [00000424e868da62] 0.012ms (+0.000ms): constant_test_bit+0x9/0x25 <ffffffff80152845> (_raw_spin_unlock_irqrestore+0x55/0x62 <ffffffff802fa667>)
> (T1/#122)            <...>   697 0 0 00000000 0000007a [00000424e868dacb] 0.012ms (+0.000ms): ata_bmdma_stop+0x9/0x32 <ffffffff88031e34> (ata_host_intr+0x52/0xb6 <ffffffff88033ddc>)
> (T1/#123)           <idle>     0 1 23 00000002 0000007b [00000424e868db53] 0.013ms (+0.000ms): preempt_schedule+0xc/0x9d <ffffffff802f82a1> (_raw_spin_unlock_irqrestore+0x5e/0x62 <ffffffff802fa670>)
> (T1/#124)           <idle>     0 1 23 00000002 0000007c [00000424e868dc6f] 0.013ms (+0.000ms): _raw_spin_unlock+0x9/0x3e <ffffffff802fa6f7> (__do_IRQ+0x12a/0x141 <ffffffff8015deb9>)
> (T1/#125)           <idle>     0 1 23 00000001 0000007d [00000424e868dd65] 0.013ms (+0.000ms): constant_test_bit+0x9/0x25 <ffffffff80152845> (_raw_spin_unlock+0x33/0x3e <ffffffff802fa721>)
> (T1/#126)           <idle>     0 1 23 00000001 0000007e [00000424e868de78] 0.013ms (+0.000ms): preempt_schedule+0xc/0x9d <ffffffff802f82a1> (_raw_spin_unlock+0x3c/0x3e <ffffffff802fa72a>)
> (T1/#127)            <...>   697 0 0 00000000 0000007f [00000424e868dec3] 0.013ms (+0.000ms): ata_altstatus+0x9/0x34 <ffffffff88031e00> (ata_bmdma_stop+0x30/0x32 <ffffffff88031e5b>)
> (T1/#128)           <idle>     0 1 23 00000001 00000080 [00000424e868df94] 0.013ms (+0.000ms): irq_exit+0x9/0x28 <ffffffff80137aaa> (do_IRQ+0x3a/0x44 <ffffffff80110767>)
> (T1/#129)            <...>   697 0 0 00000000 00000081 [00000424e868e150] 0.013ms (+0.000ms): ata_altstatus+0x9/0x34 <ffffffff88031e00> (ata_host_intr+0x5a/0xb6 <ffffffff88033de4>)
> (T1/#130)           <idle>     0 1 19 00000001 00000082 [00000424e868e25a] 0.013ms (+0.000ms): smp_reschedule_interrupt+0x9/0x16 <ffffffff801186ee> (reschedule_interrupt+0x84/0x8c <ffffffff8010e558>)
> (T1/#131)            <...>   697 0 0 00000000 00000083 [00000424e868e3d5] 0.014ms (+0.000ms): ata_check_status+0x9/0x23 <ffffffff88031ddd> (ata_host_intr+0x68/0xb6 <ffffffff88033df2>)
> (T1/#132)           <idle>     0 1 19 00000000 00000084 [00000424e868e465] 0.014ms (+0.000ms): __schedule+0x16/0xad6 <ffffffff802f7609> (cpu_idle+0xbe/0xd3 <ffffffff8010c6dd>)
> (T1/#133)           <idle>     0 1 19 00000000 00000085 [00000424e868e560] 0.014ms (+0.000ms): profile_hit+0x14/0x19f <ffffffff8013333d> (__schedule+0xb0/0xad6 <ffffffff802f76a3>)
> (T1/#134)           <idle>     0 1 19 00000001 00000086 [00000424e868e6a4] 0.014ms (+0.000ms): sched_clock+0x9/0x26 <ffffffff8011180c> (__schedule+0x110/0xad6 <ffffffff802f7703>)
> (T1/#135)            <...>   697 0 0 00000000 00000087 [00000424e868e737] 0.014ms (+0.000ms): ata_bmdma_irq_clear+0x9/0x2b <ffffffff88032170> (ata_host_intr+0x7c/0xb6 <ffffffff88033e06>)
> (T1/#136)           <idle>     0 1 19 00000001 00000088 [00000424e868e88e] 0.014ms (+0.000ms): _raw_spin_lock_irq+0xb/0x2c <ffffffff802fa2dd> (__schedule+0x18c/0xad6 <ffffffff802f777f>)
> (T1/#137)            <...>   697 0 0 00000000 00000089 [00000424e868eb5d] 0.015ms (+0.000ms): ata_qc_complete+0x13/0x20b <ffffffff88032870> (ata_host_intr+0x9e/0xb6 <ffffffff88033e28>)
> (T1/#138)           <idle>     0 1 19 00000002 0000008a [00000424e868ec85] 0.015ms (+0.000ms): double_lock_balance+0xc/0x43 <ffffffff80129cf7> (__schedule+0x2f8/0xad6 <ffffffff802f78eb>)
> (T1/#139)            <...>   697 0 0 00000000 0000008b [00000424e868ec87] 0.015ms (+0.000ms): dma_unmap_sg+0x14/0x6d <ffffffff8011c396> (ata_qc_complete+0x132/0x20b <ffffffff8803298f>)
> (T1/#140)           <idle>     0 1 19 00000002 0000008c [00000424e868ed68] 0.015ms (+0.000ms): _raw_spin_trylock+0xb/0x5d <ffffffff802fa8f7> (double_lock_balance+0x1a/0x43 <ffffffff80129d05>)
> (T1/#141)            <...>   697 0 0 00000000 0000008d [00000424e868ed93] 0.015ms (+0.000ms): dma_unmap_single+0xc/0xe6 <ffffffff8011c2a8> (dma_unmap_sg+0x5b/0x6d <ffffffff8011c3dd>)
> (T1/#142)            <...>   697 0 0 00000000 0000008e [00000424e868ef1d] 0.015ms (+0.000ms): ata_scsi_qc_complete+0x10/0x89 <ffffffff88036aa1> (ata_qc_complete+0x1f2/0x20b <ffffffff88032a4f>)
> (T1/#143)            <...>   697 0 0 00000000 0000008f [00000424e868f076] 0.015ms (+0.000ms): scsi_done+0xc/0x24 <ffffffff880028d4> (ata_scsi_qc_complete+0x7f/0x89 <ffffffff88036b10>)
> (T1/#144)            <...>   697 0 0 00000000 00000090 [00000424e868f16f] 0.015ms (+0.000ms): scsi_delete_timer+0xc/0x65 <ffffffff8800576d> (scsi_done+0x14/0x24 <ffffffff880028dc>)
> (T1/#145)           <idle>     0 1 19 00000003 00000091 [00000424e868f1ec] 0.015ms (+0.000ms): find_next_bit+0xc/0x74 <ffffffff80200598> (__schedule+0x3a2/0xad6 <ffffffff802f7995>)
> (T1/#146)            <...>   697 0 0 00000000 00000092 [00000424e868f268] 0.016ms (+0.000ms): del_timer+0xe/0x5e <ffffffff8013b7a8> (scsi_delete_timer+0x1b/0x65 <ffffffff8800577c>)
> (T1/#147)            <...>   697 0 0 00000000 00000093 [00000424e868f359] 0.016ms (+0.000ms): lock_timer_base+0xf/0x4c <ffffffff8013b5a6> (del_timer+0x23/0x5e <ffffffff8013b7bd>)
> (T1/#148)           <idle>     0 1 19 00000003 00000094 [00000424e868f46a] 0.016ms (+0.000ms): find_next_bit+0xc/0x74 <ffffffff80200598> (__schedule+0x3a2/0xad6 <ffffffff802f7995>)
> (T1/#149)           <idle>     0 1 19 00000003 00000095 [00000424e868f589] 0.016ms (+0.000ms): __find_first_bit+0x9/0x34 <ffffffff80200551> (find_next_bit+0x65/0x74 <ffffffff802005f1>)
> (T1/#150)            <...>   697 0 0 00000000 00000096 [00000424e868f5fc] 0.016ms (+0.000ms): _spin_lock_irqsave+0x9/0x4b <ffffffff802f9db4> (lock_timer_base+0x27/0x4c <ffffffff8013b5be>)
> (T1/#151)            <...>   697 0 0 00000000 00000097 [00000424e868f735] 0.016ms (+0.000ms): account_mutex_owner_down+0x9/0x4c <ffffffff8014a3fd> (_spin_lock_irqsave+0x3a/0x4b <ffffffff802f9de5>)
> (T1/#152)           <idle>     0 1 19 00000003 00000098 [00000424e868f850] 0.016ms (+0.000ms): find_next_bit+0xc/0x74 <ffffffff80200598> (__schedule+0x3a2/0xad6 <ffffffff802f7995>)
> (T1/#153)            <...>   697 0 0 00000000 00000099 [00000424e868f8df] 0.016ms (+0.000ms): _spin_unlock_irqrestore+0xc/0x6e <ffffffff802fa13a> (del_timer+0x54/0x5e <ffffffff8013b7ee>)
> (T1/#154)           <idle>     0 1 19 00000003 0000009a [00000424e868f945] 0.016ms (+0.000ms): __find_first_bit+0x9/0x34 <ffffffff80200551> (find_next_bit+0x65/0x74 <ffffffff802005f1>)
> (T1/#155)            <...>   697 0 0 00000000 0000009b [00000424e868f9c7] 0.016ms (+0.000ms): up_mutex+0x9/0x3f <ffffffff8014b0f4> (_spin_unlock_irqrestore+0x6a/0x6e <ffffffff802fa198>)
> (T1/#156)           <idle>     0 1 19 00000003 0000009c [00000424e868fa58] 0.017ms (+0.000ms): _raw_spin_unlock+0x9/0x3e <ffffffff802fa6f7> (__schedule+0x437/0xad6 <ffffffff802f7a2a>)
> (T1/#157)            <...>   697 0 0 00000000 0000009d [00000424e868fab1] 0.017ms (+0.000ms): account_mutex_owner_up+0x9/0x4b <ffffffff8014a449> (up_mutex+0x36/0x3f <ffffffff8014b121>)
> (T1/#158)           <idle>     0 1 19 00000002 0000009e [00000424e868fbed] 0.017ms (+0.000ms): constant_test_bit+0x9/0x25 <ffffffff80152845> (_raw_spin_unlock+0x33/0x3e <ffffffff802fa721>)
> (T1/#159)            <...>   697 0 0 00000000 0000009f [00000424e868fc11] 0.017ms (+0.000ms): __scsi_done+0xc/0x9b <ffffffff88002839> (scsi_done+0x20/0x24 <ffffffff880028e8>)
> (T1/#160)           <idle>     0 1 19 00000002 000000a0 [00000424e868fcec] 0.017ms (+0.000ms): preempt_schedule+0xc/0x9d <ffffffff802f82a1> (_raw_spin_unlock+0x3c/0x3e <ffffffff802fa72a>)
> (T1/#161)            <...>   697 0 16 00000000 000000a1 [00000424e868fdb2] 0.017ms (+0.000ms): raise_softirq_irqoff+0x9/0x5f <ffffffff80137ad2> (__scsi_done+0x73/0x9b <ffffffff880028a0>)
> (T1/#162)           <idle>     0 1 19 00000002 000000a2 [00000424e868fe1b] 0.017ms (+0.000ms): dependent_sleeper+0x16/0x3f1 <ffffffff8012d508> (__schedule+0x74c/0xad6 <ffffffff802f7d3f>)
> (T1/#163)            <...>   697 0 16 00000000 000000a3 [00000424e868fefd] 0.017ms (+0.000ms): wakeup_softirqd+0x9/0x38 <ffffffff801373e5> (raise_softirq_irqoff+0x5d/0x5f <ffffffff80137b26>)
> (T5/#164) [ =>          swapper ] 0.017ms (+0.000ms)
> (T1/#165)            <...>   697 0 16 00000000 000000a5 [00000424e8690058] 0.017ms (+0.000ms): wake_up_process+0xb/0x31 <ffffffff8012cd66> (wakeup_softirqd+0x36/0x38 <ffffffff80137412>)
> (T1/#166)           <idle>     0 1 17 00000002 000000a6 [00000424e8690071] 0.017ms (+0.000ms): __switch_to+0x13/0x212 <ffffffff8010c7d1> (thread_return+0x0/0x13f <ffffffff802f80c9>)
> (T1/#167)            <...>   697 0 16 00000000 000000a7 [00000424e8690136] 0.017ms (+0.000ms): check_preempt_wakeup+0xc/0xac <ffffffff8014a814> (wake_up_process+0x13/0x31 <ffffffff8012cd6e>)
> (T3/#168)    <...>-14    1D..2   17us : thread_return+0x4a/0x13f <ffffffff802f8113> <<idle>-0> (8c 62)
> (T1/#169)            <...>   697 0 16 00000000 000000a9 [00000424e8690245] 0.018ms (+0.000ms): try_to_wake_up+0x16/0x560 <ffffffff8012c747> (wake_up_process+0x24/0x31 <ffffffff8012cd7f>)
> (T1/#170)            <...>    14 1 16 00000002 000000aa [00000424e86902fc] 0.018ms (+0.000ms): _raw_spin_unlock_irq+0x9/0x44 <ffffffff802fa5d7> (thread_return+0xa3/0x13f <ffffffff802f816c>)
> (T1/#171)            <...>   697 0 16 00000000 000000ab [00000424e8690363] 0.018ms (+0.000ms): _raw_spin_lock+0xb/0x25 <ffffffff802fa1a7> (try_to_wake_up+0x5d/0x560 <ffffffff8012c78e>)
> (T1/#172)            <...>    14 1 0 00000001 000000ac [00000424e869042d] 0.018ms (+0.000ms): constant_test_bit+0x9/0x25 <ffffffff80152845> (_raw_spin_unlock_irq+0x39/0x44 <ffffffff802fa607>)
> (T1/#173)            <...>    14 1 0 00000001 000000ad [00000424e8690556] 0.018ms (+0.000ms): trace_stop_sched_switched+0x16/0x332 <ffffffff801504d0> (thread_return+0xb1/0x13f <ffffffff802f817a>)
> (T1/#174)            <...>   697 0 16 00000001 000000ae [00000424e86905a9] 0.018ms (+0.000ms): idle_cpu+0x9/0x30 <ffffffff80129d37> (try_to_wake_up+0x292/0x560 <ffffffff8012c9c3>)
> (T1/#175)            <...>    14 1 16 00000001 000000af [00000424e869065c] 0.018ms (+0.000ms): _raw_spin_lock+0xb/0x25 <ffffffff802fa1a7> (trace_stop_sched_switched+0x49/0x332 <ffffffff80150503>)
> (T1/#176)            <...>   697 0 16 00000001 000000b0 [00000424e86906b0] 0.018ms (+0.000ms): smp_send_reschedule_allbutself+0x9/0x1a <ffffffff8011809b> (try_to_wake_up+0x3e9/0x560 <ffffffff8012cb1a>)
> (T1/#177)            <...>   697 0 16 00000001 000000b1 [00000424e869078d] 0.018ms (+0.000ms): flat_send_IPI_allbutself+0xb/0x5b <ffffffff8011b644> (smp_send_reschedule_allbutself+0x18/0x1a <ffffffff801180aa>)
> (T3/#178)    <...>-14    1D..2   18us : trace_stop_sched_switched+0x6f/0x332 <ffffffff80150529> <<...>-14> (62 1)
> (T1/#179)            <...>   697 0 16 00000001 000000b3 [00000424e8690871] 0.018ms (+0.000ms): __bitmap_weight+0xa/0x18b <ffffffff801fbce6> (flat_send_IPI_allbutself+0x1e/0x5b <ffffffff8011b657>)
> (T1/#180)            <...>    14 1 16 00000003 000000b4 [00000424e8690898] 0.018ms (+0.000ms): _raw_spin_unlock+0x9/0x3e <ffffffff802fa6f7> (trace_stop_sched_switched+0xbf/0x332 <ffffffff80150579>)
> (T1/#181)            <...>    14 1 16 00000002 000000b5 [00000424e86909ac] 0.018ms (+0.000ms): constant_test_bit+0x9/0x25 <ffffffff80152845> (_raw_spin_unlock+0x33/0x3e <ffffffff802fa721>)
> (T1/#182)            <...>   697 0 16 00000001 000000b6 [00000424e8690a78] 0.019ms (+0.000ms): activate_task+0x10/0xe0 <ffffffff8012bc38> (try_to_wake_up+0x491/0x560 <ffffffff8012cbc2>)
> (T1/#183)            <...>   697 0 16 00000001 000000b7 [00000424e8690b50] 0.019ms (+0.000ms): sched_clock+0x9/0x26 <ffffffff8011180c> (activate_task+0x1d/0xe0 <ffffffff8012bc45>)
> (T1/#184)            <...>    14 1 16 00000002 000000b8 [00000424e8690b62] 0.019ms (+9177482346838.318ms): thread_return+0xb1/0x13f <ffffffff802f817a> (thread_return+0xb1/0x13f <ffffffff802f817a>)
> 
> 
> vim:ft=help
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

