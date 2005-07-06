Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262427AbVGFScB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262427AbVGFScB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 14:32:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262438AbVGFS1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 14:27:12 -0400
Received: from mx1.elte.hu ([157.181.1.137]:12201 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262268AbVGFNba (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 09:31:30 -0400
Date: Wed, 6 Jul 2005 15:31:24 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
Message-ID: <20050706133124.GA19467@elte.hu>
References: <200507061257.36738.s0348365@sms.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507061257.36738.s0348365@sms.ed.ac.uk>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:

> Hi,
> 
> Today I decided to try Ingo's rt-preempt patch on 2.6.12 (V0.7.51-02). 
> I'm most interested in the CONFIG_PREEMPT_RT mode, so I selected this 
> option instead of the others. I enabled a couple of the debugging 
> options, but I wasn't totally clear on which options are most useful, 
> so I just enabled the ones that didn't have a warning about 
> significant overhead, namely..
> 
> CONFIG_DETECT_SOFTLOCKUP=y
> CONFIG_WAKEUP_TIMING=y
> CONFIG_CRITICAL_TIMING=y
> CONFIG_LATENCY_TIMING=y
> 
> Additionally (by mistake) I enabled:
> 
> CONFIG_CRITICAL_IRQSOFF_TIMING=y
> 
> Which does mention overhead.
> 
> Which debugging options are most useful for testing purposes? Is what 
> I've selected enough? [...]

for the first bootup it makes sense to enable most of them - just to 
make sure everything is ok. They have performance overhead, but it 
shouldnt show up during everyday use. (it will show up in benchmarks 
though) Here's the options i have enabled, typically:

 CONFIG_DETECT_SOFTLOCKUP=y
 # CONFIG_SCHEDSTATS is not set
 CONFIG_DEBUG_SLAB=y
 CONFIG_DEBUG_PREEMPT=y
 CONFIG_DEBUG_IRQ_FLAGS=y
 CONFIG_WAKEUP_TIMING=y
 CONFIG_PREEMPT_TRACE=y
 CONFIG_CRITICAL_PREEMPT_TIMING=y
 CONFIG_CRITICAL_IRQSOFF_TIMING=y
 CONFIG_CRITICAL_TIMING=y
 CONFIG_LATENCY_TIMING=y
 CONFIG_LATENCY_TRACE=y
 CONFIG_MCOUNT=y
 CONFIG_RT_DEADLOCK_DETECT=y
 # CONFIG_DEBUG_RT_LOCKING_MODE is not set
 # CONFIG_DEBUG_KOBJECT is not set
 CONFIG_DEBUG_BUGVERBOSE=y
 # CONFIG_DEBUG_INFO is not set
 # CONFIG_DEBUG_FS is not set
 CONFIG_FRAME_POINTER=y
 CONFIG_EARLY_PRINTK=y
 CONFIG_DEBUG_STACKOVERFLOW=y
 # CONFIG_KPROBES is not set
 CONFIG_DEBUG_STACK_USAGE=y
 # CONFIG_DEBUG_PAGEALLOC is not set

the 'big, costly ones' are LATENCY_TRACE, RT_DEADLOCK_DETECT, 
CRITICAL_PREEMPT_TIMING, CRITICAL_IRQSOFF_TIMING, DEBUG_PREEMPT, in cost 
order. The others are relatively low overhead. LATENCY_TRACE is useful 
if you want to send me latency traces - if enabled then you'll get 
/proc/latency_trace traces, whenever you see the 'latency detected' type 
of messages in the system log.

> [...] Also, I got a few unexpected messages in dmesg on bootup.
> Firstly;
>
> spawn_desched_task(00000000)
> desched cpu_callback 3/00000000
> ksoftirqd started up.
> softirq RT prio: 24.
> ksoftirqd started up.
> softirq RT prio: 24.
> [...]
> desched cpu_callback 2/00000000
> desched thread 0 started up.
> softlockup thread 0 started up.
> 
> Why does it print out the same ksoftirqd message six times? Is this 
> expected behaviour?

these messages are harmless status messages - they were added for 
debugging purposes. You are getting 6 of them because there are 6 
separate softirq threads. (but the message is the old one so it talks 
about ksoftirqd - very confusing.) In my tree i have removed these 
printks.

(generally i try to mark every message in the -RT kernel that signals 
some sort of anomaly with a 'BUG:' prefix - that makes it easy to do a 
'dmesg | grep BUG:' to find out whether anything bad is going on. All 
other messages should be benign.)

> [...] Next, I got a warning about CONFIG_CRITICAL_IRQSOFF_TIMING; 
> should this option be enabled?

do you mean the bootup warning about performance? That is just a warning 
to make sure the kernel is not misconfigured during benchmarks - the 
debugging options are otherwise safe and you should be able to use any 
variations of them.

> Finally, I got this:
> 
> BUG: soft lockup detected on CPU#0!
>  [<c013d7e9>] softlockup_tick+0x89/0xb0 (8)
>  [<c0108590>] timer_interrupt+0x50/0xf0 (20)
>  [<c013da91>] handle_IRQ_event+0x81/0x100 (16)
>  [<c013dbfc>] __do_IRQ+0xec/0x190 (48)
>  [<c0105a28>] do_IRQ+0x48/0x70 (40)
>  =======================
>  [<c024df3b>] acpi_processor_idle+0x0/0x258 (8)
>  [<c0103d03>] common_interrupt+0x1f/0x24 (12)
>  [<c024df3b>] acpi_processor_idle+0x0/0x258 (4)
>  [<c024e05e>] acpi_processor_idle+0x123/0x258 (40)
>  [<c024df3b>] acpi_processor_idle+0x0/0x258 (32)
>  [<c0101116>] cpu_idle+0x56/0x80 (16)
>  [<c03a486c>] start_kernel+0x17c/0x1c0 (12)
>  [<c03a43b0>] unknown_bootoption+0x0/0x1f0 (20)

yes, this is a problem. You can probably work it around by disabling 
ACPI, but it would be better to debug and fix it. The message was 
generated because the kernel spent too much time [more than 10 seconds] 
in acpi_processor_idle(), and the softlockup-thread (which runs at 
SCHED_FIFO prio 99) was not scheduled for that amount of time. [or it 
thought it was not scheduled.] Was there any suspend/resume activity 
while you got that message?

> I think it's when my scripts try to set up the IrDA port; the script 
> runs the following (I have a weird broken NC6000 IrDA port which needs 
> messing around with to work)..
> 
> /usr/bin/smcinit -v -s 0x3E8 -f 0x130 -i 4 -d 3 >/dev/null
> 
> Of course, the message could've just been coincidental, as it doesn't 
> actually refer to the smcs driver at all.
> 
> I set preempt_max_latency to zero, but the only messages I've got back 
> from the kernel so far are:
> 
> ( softirq-timer/0-3    |#0): new 3 us maximum-latency wakeup.
> ( softirq-timer/0-3    |#0): new 1003 us maximum-latency wakeup.
> ( softirq-timer/0-3    |#0): new 1001 us maximum-latency wakeup.
> 
> Which is presumably a good sign.

it's good in terms of stability, but the 1003 usecs maximum wakeup 
latency is bad - you should be getting much lower latencies. Could you 
enable LATENCY_TRACING and send me the /proc/latency_trace file? [if 
it's long then in bz2 format.] You can double-check that it's the right 
one: the trace is human-readable and should go roughly from 1 usec to 
1003 usecs. Looking at that trace i can probably tell more about how 
this latency happened.

	Ingo
