Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261785AbVCCOvY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261785AbVCCOvY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 09:51:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261786AbVCCOvY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 09:51:24 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:62564 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261785AbVCCOuz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 09:50:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=VirHJBKjDOwSv1b1C17Dqcc7tDkuWUXCKghvg+2Z/Z1RLA+PFlvFCBqZyPVV7XGe12uk0CfUEJGHR60GI3w+Y8PSH/2vWsBOwLfoE+uVEVu5wZpjh0fqzwTqCiyfzr2zuLNc2GTJrT3Y8Aj2TMB3+egtI5zixwUJehfEF6qS6uU=
Message-ID: <6c58e3190503030650595cbd5@mail.gmail.com>
Date: Thu, 3 Mar 2005 16:50:52 +0200
From: Dror Cohen <dror.xiv@gmail.com>
Reply-To: Dror Cohen <dror.xiv@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Time Drift Compensation on Linux Clusters
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
While working on a Linux cluster with kernel version 2.4.27 we've
encountered a consistent clock drift problem. We have devised a fix
for this problem which is based on the Pentium's TSC clock. We'd
appreciate any comments on the validity of the proposed solution and
on whether it might cause unexpected (and undesired) problems in other
parts of the kernel.

Following is a detailed description of the problem and the fix,

Thanks everyone,
Dror
XIV ltd.

------------------------------------------------------------------------------------------------------------

Time Drift Compensation on Linux Clusters


1. Background

During the operation of the 2.4.27 kernel under intense IO conditions a clock
drift was detected. The system time, as received by gettimeofday() began lagging
behind the wall clock.

All PCs have a battery driven hardware clock. This clock is used at boot time to
initialize the system time. Linux then uses the Programmable Interval
Timer (PIT)
to keep an internal accounting of the flow of time. The PIT is set to raise an
interrupt every fixed interval. The number of interrupt per second is defined by
the kernel constant HZ, which typically equals 100 (10 on Alpha machines). The
interrupt handler kernel/timer.c:do_timer() increments a kernel wide
variable named
jiffies and invokes the bottom half to take care of timers and scheduling.

2. Analysis

In IO intensive environments a many CPU cycles are spent handling interrupts.
This is done by the device driver code for the different IO devices.
Typically, while
dealing with the hardware, device drivers block other IRQs, including the PIT's
(timer) IRQ.

When debugging drivers it is not uncommon to use printk() inside
driver code while
IRQs are still blocked. This method is by nature blocking and can only
be run once
even on SMP machines. This is because messages printed by printk() must reach
the console before any other operation might cause the kernel to panic or block.

In cluster environments a serial console can be used to access
machines remotely.
One drawback of using such a console is its longer response time which
significantly
lengthens the blocking time of printk().

Putting all this together results in an interrupt rich environments in
which many
interrupt handlers block the IRQs for long periods of time. This
matters when 'long'
becomes longer than 1 second / HZ, which means that the CPU misses timer
interrupts.

Each time a time interrupt is missed the system looses one jiffy.
These lost jiffies
accumulate into a consisting clock drift.

3. Fix

The fix proposed here relies on a quality of the Pentium processor and thus is
irrelevant to other architectures or to older (80386, 80486) CPUs.

The Pentium has an internal cycles counter called the Time Stamp Counter (TSC).
This counter is a 64 bit register which is incremented internally
every CPU cycle and
can be read using a special assembly instruction. On a 1GHz machine
this register
wraps to zero once every 584 years.

The suggested fix adds code to the timer interrupt handler which
tracks the value
of this counter. When an interrupt occurs, the jiffies counter is
increased not just
by one but by the number of 1 second / HZ intervals that actually
passed according
to the TSC value change.

This involves modifying two kernel files:

kernel/timer.c:
	modify the interrupt handler do_timer()

	698a699,703
	> #ifdef X86_TSC_DRIFT_COMPENSATION
	> __u64 xtdc_step;
	> __u64 xtdc_last = 0;
	> #endif
	>
	700a706,712
	> #ifdef X86_TSC_DRIFT_COMPENSATION
	>       __u64 cycles = get_cycles();
	>       while (xtdc_last < cycles) {
	>               (*(unsigned long *)&jiffies)++;
	>               xtdc_last += xtdc_step;
	>       }
	> #else
	701a714,715
	> #endif
	>

arch/i386/kernel/time.c

	modify calibrate_tsc() to get the initial TSC count and to calculate the number
	of TSC cycles per 1 second / HZ interval

	768a769,777
	> #ifdef X86_TSC_DRIFT_COMPENSATION
	>
	> extern __u64 xtdc_step;
	> extern __u64 xtdc_last;
	> #define CALIBRATE_LATCH       (4 * LATCH)
	> #define CALIBRATE_TIME        (4 * 1000020/HZ)
	>
	> #else
	>
	771a781,782
	> #endif
	>
	805a817,820
	> #ifdef X86_TSC_DRIFT_COMPENSATION
	>               xtdc_last = (((__u64) endhigh) << 32) + (__u64) endlow;
	> #endif
	>
	811a827,830
	>
	> #ifdef X86_TSC_DRIFT_COMPENSATION
	>               xtdc_step = ((((__u64) endhigh) << 32) + (__u64) endlow) >> 2;
	> #endif
