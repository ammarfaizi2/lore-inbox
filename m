Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262403AbVGGAXN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262403AbVGGAXN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 20:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262306AbVGFUAC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 16:00:02 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:187 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S262325AbVGFQhS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 12:37:18 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
Date: Wed, 6 Jul 2005 17:37:18 +0100
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
References: <200507061257.36738.s0348365@sms.ed.ac.uk> <200507061655.45801.s0348365@sms.ed.ac.uk> <20050706162457.GA24728@elte.hu>
In-Reply-To: <20050706162457.GA24728@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507061737.18322.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 06 Jul 2005 17:24, Ingo Molnar wrote:
> * Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:
> > > (generally i try to mark every message in the -RT kernel that signals
> > > some sort of anomaly with a 'BUG:' prefix - that makes it easy to do a
> > > 'dmesg | grep BUG:' to find out whether anything bad is going on. All
> > > other messages should be benign.)
> >
> > Okay, I've got multiple other BUG: messages within 2-3 minutes of
> > booting that highlight problems in areas other than ACPI. Are they
> > useful to you?
>
> yeah, please send them too - typically it's the first message that
> matters most (especially if the system crashes - which isnt the case
> here) - but sometimes the other ones are independent.

BUG: soft lockup detected on CPU#0!
 [<c010421f>] dump_stack+0x1f/0x30 (20)
 [<c0144a3a>] softlockup_tick+0x8a/0xb0 (24)
 [<c0108607>] timer_interrupt+0x57/0x100 (20)
 [<c0144ce5>] handle_IRQ_event+0x85/0x110 (52)
 [<c0144e4a>] __do_IRQ+0xda/0x170 (44)
 [<c0105b15>] do_IRQ+0x65/0xa0 (-196752)
 =======================
 [<c0103ceb>] common_interrupt+0x1f/0x24 (96)
 [<c0101145>] cpu_idle+0x65/0x90 (16)
 [<c03b0902>] start_kernel+0x182/0x1c0 (32)
 [<c010019f>] 0xc010019f (1076011023)

(I get this one semi-frequently)

>
> > > yes, this is a problem. You can probably work it around by disabling
> > > ACPI, but it would be better to debug and fix it. The message was
> > > generated because the kernel spent too much time [more than 10 seconds]
> > > in acpi_processor_idle(), and the softlockup-thread (which runs at
> > > SCHED_FIFO prio 99) was not scheduled for that amount of time. [or it
> > > thought it was not scheduled.] Was there any suspend/resume activity
> > > while you got that message?
> >
> > No, this is during bootup that it occurs. Suspend and resume do work
> > and are compiled in on my laptop, but were never utilised.
>
> was there a 10 seconds delay during bootup for such a message to be
> generated? Nothing should delay the softlockup threads. (but maybe their
> initial timekeeping is somehow impacted.)

I don't think so, the whole boot process takes about 11 seconds. I have 
noticed boot-time slow down since a few kernels ago, but I was never able to 
identify whether it's just hotplug or a real freeze.

I'll get back to you on this if I find anything definitive. The later 
messages, however, appear to happen sporadically and the machine does not 
freeze or idle at the same time.

>
> > I've got a pair of nearly identical traces that highlight a 2645us
> > latency in smp_apic_timer_interrupt. I don't know how the trace is
> > formatted, so I can't tell if it occurred before or after this
> > function call. I also can't see how a ~1000us latency translates to a
> > ~2600us latency in the trace.
> >
> > Since both traces were under 6K each, and I think the list limit is
> > higher, I risked it and have attached both.
>
> thanks. They do show a real regression. softirq--3 got woken up at
> timestamp 1us:
>
>   <idle>-0     0dnh2    1us : try_to_wake_up <softirq--3> (69 8c)
>
> then we return from the (presumably timer) interrupt at timestamp 3us:
>
>   <idle>-0     0dnh.    3us < (608)
>
> ( '<' in the trace signals return activity - can happen for syscalls and
> for interrupts.)
>
> but the ACPI code is busy going to sleep:
>
>   <idle>-0     0dn..    3us : acpi_hw_register_write (acpi_set_register)
>   <idle>-0     0dn..    4us : acpi_hw_low_level_write
> (acpi_hw_register_write) <idle>-0     0dn..    4us+: acpi_os_write_port
> (acpi_hw_low_level_write) <idle>-0     0dn..    7us!:
> acpi_hw_low_level_write (acpi_hw_register_write) <idle>-0     0dnh. 2645us
> : smp_apic_timer_interrupt (c0252485 0 0)
>
> and doesnt return for another 2638 microseconds!
>
> the bug is probably that the ACPI code became interruptible when we
> introduced the IRQ soft-flag. This is clearly visible from the "d" flag:
>
>                  _------=> CPU#
>                 / _-----=> irqs-off
>
>                | / _----=> need-resched
>                |
>                || / _---=> hardirq/softirq
>                ||
>                ||| / _--=> preempt-depth
>                |||
>                |||| /
>                ||||
>                |||||     delay
>
>    cmd     pid ||||| time  |   caller
>       \   /    |||||   \   |   /
>   <idle>-0     0dn..    3us : acpi_hw_register_write (acpi_set_register)
>     /-----------^
>  here
>
> small 'd' means the soft IRQ-flag was disabled. Capital 'D' means that
> the CPU's irq-flag got disabled too. The ACPI code, when it prepares to
> sleep, has to disable direct interrupts too, otherwise the above
> scenario may occur. If a timer interrupt hits the ACPI code in that
> small window where it has already checked for need_resched(), but has
> not gone to sleep yet (so it cannot react to the timer IRQ by waking
> up), then we lose the wakeup.
>
> could you try the patch below (or the -51-05 patch that i just
> uploaded), does it fix this latency?
>
> 	Ingo

I'm beginning to understand the issue, and I see why you think the proposed 
patch fixes it. I'll compile and boot V0.7.51-05 now.

-- 
Cheers,
Alistair.

personal:   alistair()devzero!co!uk
university: s0348365()sms!ed!ac!uk
student:    CS/CSim Undergraduate
contact:    1F2 55 South Clerk Street,
            Edinburgh. EH8 9PP.
