Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266532AbUG1G42@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266532AbUG1G42 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 02:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266569AbUG1G42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 02:56:28 -0400
Received: from mx1.elte.hu ([157.181.1.137]:22707 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S266532AbUG1G4W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 02:56:22 -0400
Date: Wed, 28 Jul 2004 08:27:22 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Scott Wood <scott@timesys.com>
Cc: linux-kernel@vger.kernel.org, "La Monte H.P. Yarroll" <piggy@timesys.com>,
       Manas Saksena <manas.saksena@timesys.com>, Bill Huey <bhuey@lnxw.com>
Subject: Re: [patch] IRQ threads
Message-ID: <20040728062722.GA15283@elte.hu>
References: <20040727225040.GA4370@yoda.timesys>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040727225040.GA4370@yoda.timesys>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Scott Wood <scott@timesys.com> wrote:

> 2. This patch does not disable local interrupts when running a
> threaded handler.  SMP-safe drivers shouldn't be directly bothered by
> this (as the interrupt could as easily have happened on another CPU),
> but there may be some interactions with softirqs and per-cpu data, if
> a softirq thread preempts an IRQ thread, or an IRQ thread gets
> migrated to a different CPU. [...]

hardirqs (unlike softirqs) we might attempt to make preemptable. It
really should work because if they run with interrupts enabled then they
must be prepared to see interrupts coming from a similar device using
the same softirq facilities.

migration between CPUs we can prevent easily. While it's not common for
a driver to rely on per-CPU-ness _outside_ of a spinlocked region, it
could in theory happen.

for now i've gone the more conservative route of keeping irqs atomic
still, and applying lock-break methods to them.

> [...] I'm particularly worried about the network code.  If possible,
> I'd like to find and fix such breakages rather than use
> local_irq_disable(), as that would prevent IRQ proritization from
> working, and prevent IRQ threads from being used to isolate the rest
> of the system from long-running IRQs (such as non-DMA IDE).

this is not enough: DMA-IDE creates big latencies too, and those
latencies happen under a spinlock - so with your patch it would be
non-preemptible still.

> 3. The i8042 driver had to be marked SA_NOTHREAD, as there are
> non-preemptible regions where it spins, waiting for an interrupt.
> Ideally, this driver (and others like it) should be fixed to either do
> a cond_resched() or use a wait queue.

yeah, i fixed it via cond_resched_softirq(), _after_ making sure it's
safe to preempt there - softirqs are not generally preemption safe
because they are fundamentally per-CPU. (meanwhile Dmitry Torokhov has
posted a patch that fixes the atkbd.c problem for real by using
workqueues. The psmouse-base.c problem needs a similar fix.)

> 4. This might be a good time to get around to moving the bulk of the
> arch/whatever/kernel/irq.c into generic code, as the code said was
> supposed to happen in 2.5.  This patch is currently only for x86
> (though we've run IRQ threads on many different platforms in the
> past).

agreed. I punted this one for the time being as it's clearly separate
from the issue of latencies and it's deeply intrusive to 2.6.

> 5. Is there any reason why an IRQ controller might want to have its
> end() called even if IRQ_DISABLED or IRQ_INPROGRESS is set?  It'd be
> nice to merge those checks in with the
> IRQ_THREADPENDING/IRQ_THREADRUNNING checks.

e.g. in the IO-APIC case if we ack the local APIC only in the end()
function then we must do that - an un-acked local APIC prevents other
IRQs from being delivered. We do this for level-triggered IO-APIC irqs.

> 6. This patch causes in_irq() to return true if an IRQ thread is
> running, as some drivers use it in common code to determine how to
> act.  in_interrupt(), however, will return false in such a case. The
> exact meaning of these macros in the presence of IRQ threads isn't
> very well defined, and I hope this results in sane behavior.

this is an incorrect change, just grep for in_interrupt() in
linux/drivers/ ...

I agree with the concept of using multiple threads for interrupts - i'll
add that to the voluntary-preempt patch too. This is an essential
feature to prioritize interrupts.

what do you think about making the i8259A's interrupt priorities
configurable? (a'la rtirq patch) Does it make any sense, given how early
we mask the source irq and ack the interrupt controller [hence giving
all other interrupts a fair chance to arrive ASAP]?

Bernhard Kuhn's rtirq patch is for IO-APIC/APICs, but i think the
latency issues could be equally well fixed by not keeping the local APIC
un-ACK-ed during level triggered irqs, but doing the mask & ack thing.
This will be slightly slower but should make them both redirectable and
more symmetric and fair.

	Ingo
