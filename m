Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbVBLS6c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbVBLS6c (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Feb 2005 13:58:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261188AbVBLS6c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Feb 2005 13:58:32 -0500
Received: from fsmlabs.com ([168.103.115.128]:14982 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261184AbVBLS6V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Feb 2005 13:58:21 -0500
Date: Sat, 12 Feb 2005 11:59:04 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Nathan Lynch <ntl@pobox.com>
cc: lkml <linux-kernel@vger.kernel.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6-bk: cpu hotplug + preempt = smp_processor_id warnings galore
In-Reply-To: <20050211232821.GA14499@otto>
Message-ID: <Pine.LNX.4.61.0502121019080.26742@montezuma.fsmlabs.com>
References: <20050211232821.GA14499@otto>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Feb 2005, Nathan Lynch wrote:

> With 2.6.11-rc3-bk7 on ppc64 I am seeing lots of smp_processor_id
> warnings whenever I hotplug cpus:
> 
> # echo 0 > /sys/devices/system/cpu/cpu1/online 
> cpu 1 (hwid 1) Ready to die...
> BUG: using smp_processor_id() in preemptible [00000001] code:
> ksoftirqd/1/5
> caller is .ksoftirqd+0xbc/0x1f8
> Call Trace:
> [c0000000fffbbce0] [ffffffffffffffff] 0xffffffffffffffff (unreliable)
> [c0000000fffbbd60] [c0000000001c9f1c] .smp_processor_id+0x154/0x168
> [c0000000fffbbe20] [c00000000005f414] .ksoftirqd+0xbc/0x1f8
> [c0000000fffbbed0] [c0000000000764cc] .kthread+0x128/0x134
> [c0000000fffbbf90] [c000000000014248] .kernel_thread+0x4c/0x6c
> 
> I believe the above warning is caused by the local_softirq_pending
> call on a "foreign" cpu before ksoftirqd/1 has been stopped.  Looking
> at the code, I think this doesn't indicate a real bug, but it would be
> better if ksoftirqd didn't check local_softirq_pending after it's been
> kicked off its cpu, right?

How about;

Index: linux-2.6.11-rc3-mm2/kernel/softirq.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.11-rc3-mm2/kernel/softirq.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 softirq.c
--- linux-2.6.11-rc3-mm2/kernel/softirq.c	11 Feb 2005 05:14:57 -0000	1.1.1.1
+++ linux-2.6.11-rc3-mm2/kernel/softirq.c	12 Feb 2005 18:24:54 -0000
@@ -355,8 +355,12 @@ static int ksoftirqd(void * __bind_cpu)
 	set_current_state(TASK_INTERRUPTIBLE);
 
 	while (!kthread_should_stop()) {
-		if (!local_softirq_pending())
+		preempt_disable();
+		if (!local_softirq_pending()) {
+			preempt_enable_no_resched();
 			schedule();
+			preempt_disable();
+		}
 
 		__set_current_state(TASK_RUNNING);
 
@@ -364,14 +368,14 @@ static int ksoftirqd(void * __bind_cpu)
 			/* Preempt disable stops cpu going offline.
 			   If already offline, we'll be on wrong CPU:
 			   don't process */
-			preempt_disable();
 			if (cpu_is_offline((long)__bind_cpu))
 				goto wait_to_die;
 			do_softirq();
-			preempt_enable();
+			preempt_enable_no_resched();
 			cond_resched();
+			preempt_disable();
 		}
-
+		preempt_enable();
 		set_current_state(TASK_INTERRUPTIBLE);
 	}
 	__set_current_state(TASK_RUNNING);

> # echo 1 > /sys/devices/system/cpu/cpu1/online 
> BUG: using smp_processor_id() in preemptible [00000001] code:
> swapper/0
> caller is .dedicated_idle+0x68/0x22c
> Call Trace:
> [c0000000fffafc50] [ffffffffffffffff] 0xffffffffffffffff (unreliable)
> [c0000000fffafcd0] [c0000000001c9f1c] .smp_processor_id+0x154/0x168
> [c0000000fffafd90] [c00000000000f998] .dedicated_idle+0x68/0x22c
> [c0000000fffafe80] [c00000000000fce8] .cpu_idle+0x34/0x4c
> [c0000000fffaff00] [c00000000003a744] .start_secondary+0x10c/0x150
> [c0000000fffaff90] [c00000000000bd28] .enable_64b_mode+0x0/0x28
> 
> Should ppc64 simply use _smp_processor_id() in its idle loop code
> (like i386)?

I would say so, it's definitely safe.

> If I online and offline cpus rapidly enough I can eventually get the
> following:
> 
> printk: 49 messages suppressed.
> BUG: using smp_processor_id() in preemptible [00000001] code:
> events/3/1262
> caller is .cache_reap+0x21c/0x2b8
> Call Trace:
> [c0000000ed67bb90] [ffffffffffffffff] 0xffffffffffffffff (unreliable)
> [c0000000ed67bc10] [c0000000001c9f1c] .smp_processor_id+0x154/0x168
> [c0000000ed67bcd0] [c0000000000938e8] .cache_reap+0x21c/0x2b8
> [c0000000ed67bda0] [c00000000006f4bc] .worker_thread+0x230/0x310
> [c0000000ed67bed0] [c0000000000764cc] .kthread+0x128/0x134
> [c0000000ed67bf90] [c000000000014248] .kernel_thread+0x4c/0x6c
> 
> And this will repeat over and over even after I stop hotplugging
> cpus...  from the same events thread so I think it's somehow gotten
> "stuck"?

Hmm this should be covered by the local_bh_disable() in softirq 
processing.
