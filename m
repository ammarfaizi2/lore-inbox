Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261866AbUKWBCj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261866AbUKWBCj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 20:02:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261738AbUKWBAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 20:00:31 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:8205 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S261866AbUKWA7o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 19:59:44 -0500
Date: Mon, 22 Nov 2004 16:59:40 -0800
From: Tim Mann <mann@vmware.com>
To: linux-kernel@vger.kernel.org
Cc: mann@vmware.com
Subject: Spurious "lost ticks"
Message-Id: <20041122165940.465312ce@mann-lx.vmware.com>
Organization: VMware, Inc.
X-Mailer: Sylpheed-Claws 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.28.0.18; VDF: 6.28.0.86; host: mailout1.vmware.com)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[I posted a version of this bug report earlier to the
high-res-timers-discourse list, and John Stultz suggested passing it on
to LKML too.  Various major timer changes that John and others such as
George Anzinger are working on should fix it, but it's still a bug in
the present kernel code, and it seems likely to be there for quite a
while until the larger changes are ready to go into the mainstream
kernel.]

In 2.6, some code has been added to watch for "lost ticks" and
increment the jiffies counter to compensate for them.  A "lost tick"
is when timer interrupts are masked for so long that ticks pile up and
the kernel doesn't see each one individually, so it loses count.

Lost ticks are a real problem, especially in 2.6 with the base
interrupt rate having been increased to 1000 Hz, and it's good that
the kernel tries to correct for them.  However, detecting when a tick
has truly been lost is tricky. The code that has been added (both in
timer_tsc.c's mark_offset_tsc and timer_pm.c's mark_offset_pmtmr) is
overly simplistic and can get false positives.  Each time this
happens, a spurious extra tick gets added in, causing the kernel's
clock to go faster than real time.

The lost ticks code in timer_pm.c essentially works as follows.
Whenever we handle a timer tick interrupt, we note the current time as
measured on a finer-grained clock (namely the PM timer).  Let delta =
current_tick_time - last_tick_time.  If delta >= 2.0 ticks, then we
assume that the last floor(delta) - 1 ticks were lost and add this
amount into the jiffies counter.  The timer_tsc.c code is more complex
but shares the same basic concept.

What's wrong with this?  The problem is that when we get around to
reading the PM timer or TSC in the timer interrupt handler, there may
already be *another* timer interrupt pending.  As folks on this list
probably know, there is a very small amount of queuing in x86 interrupt
controllers (PIC or APIC), to handle the case where a device needs to
request another interrupt in the window between when its previous
interrupt request has been passed on from the controller to the CPU and
when the OS's interrupt handler has run to completion and unmasked the
interrupt. When this case happens, the CPU gets interrupted again as
soon as the interrupt is unmasked.  The queue length here is only 1, but
it's not 0.

This queuing means that if we are being slow about responding to timer
interrupts (due to having interrupts masked for too long, say), then
when we finally get into the interrupt handler for timer interrupt
number T, interrupt number T+1 may already be pending.  If we handled
interrupt T-1 on time, then at this point delta will be a little more
than 2.0 ticks, because it's now past time for tick T+1 to happen, so
the "lost ticks" code will fire and add an extra tick.  But no ticks
were really lost.  We are handling tick T right now, and as soon as we
return from the interrupt service routine and unmask the clock
interrupt, we will immediately get another clock interrupt, the one for
tick T+1.

So, checking whether delta >= 2.0 will give us false positives.  How to
fix this?  Because of the queuing, I believe there's no way to detect
lost ticks without either false positives or negatives just by looking
at the spacing between the current tick and the last tick. The best idea
I'm aware of is this: if we compare the number of ticks over a long
period with another clock, we can tell whether we're currently up to
date with all ticks we should have received or are behind by some number
of ticks. Because the interrupt queue length is only 1, I think if we're
behind by N ticks, we must have lost at least N-1 ticks and possibly
(but not certainly) N.  If we conservatively add N-1 ticks, in the worst
case we may lose one tick and never correct it, but we won't fall more
than 1 tick behind.

If we do this, there's a possibility of incorrectly adding/removing an
occasional tick if the other clock we're comparing with is less
accurate (or we know its rate less accurately) than the clock that's
generating timer interrupts.  In particular, a fairly common case is
that timer interrupts come from the PIT, which runs at a specified
rate, while the other clock we have to compare it with is the TSC,
whose rate we know only by measuring it against the PIT.  This is
tricky to deal with, and I don't really want to go into the issues in
this message.  Check the discussion at
http://sourceforge.net/mailarchive/forum.php?forum=high-res-timers-discourse
for more on this.

I should say that so far I haven't tried to test how much of an effect
this bug has on real hardware, but it certainly can happen on any
system where the lost ticks code is needed at all.  It has a big
effect in VMware VMs.  I've seen time in 2.6 kernels run as much as
10% fast using the code in timer_tsc.c (kernel command line option
clock=tsc), and I've seen a gain of roughly 1 second per hour with
clock=pmtmr.  I understand why VM's would tickle the bug a lot more
than real hardware does, and unfortunately it's not something I can do
enough about within the VM implementation.  Until it's fixed on the
Linux side all I can do is tell people to use timer=pit when they run
2.6 in a VM, which turns off all lost ticks compensation.

--
Tim Mann  work: mann@vmware.com  home: tim@tim-mann.org         
          http://www.vmware.com  http://tim-mann.org
