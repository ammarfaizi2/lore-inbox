Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266368AbTBLEIL>; Tue, 11 Feb 2003 23:08:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266435AbTBLEIL>; Tue, 11 Feb 2003 23:08:11 -0500
Received: from bjl1.jlokier.co.uk ([81.29.64.88]:8576 "EHLO bjl1.jlokier.co.uk")
	by vger.kernel.org with ESMTP id <S266368AbTBLEIJ>;
	Tue, 11 Feb 2003 23:08:09 -0500
Date: Wed, 12 Feb 2003 04:18:48 +0000
From: Jamie Lokier <jamie@shareable.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 350] New: i386 context switch very slow compared to 2.4 due to wrmsr (performance)
Message-ID: <20030212041848.GA9273@bjl1.jlokier.co.uk>
References: <629040000.1045013743@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <629040000.1045013743@flay>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
> Since the SYSENTER/vsyscall support went in the 2.5 __switch_to/load_esp0
> function does two WRMSRs to rewrite MSR_IA32_SYSENTER_CS and
> MSR_IA32_SYSENTER_ESP. This is hidden in processor.h:load_esp0. WRMSR is
> very slow (60+ cycles) especially on a Pentium 4 and slows down the context
> switch considerably. This is a trade off between faster system calls using
> SYSENTER and slower context switches, but the context switches got unduly
> hit here.

<Boggle!>  I'm amazed this slipped in.

> The reason it rewrites SYSENTER_CS is non obviously vm86 which
> doesn't guarantee the MSR stays constant (sigh).

I am confused by your sentence.  Can vm86 code alter the sysenter
MSRs?  That should raise a GPF, surely...  Or do you mean that the
code in vm86.c alters sysenter, because it calls disable_sysenter()?

> I think this would be better handled by having a global flag or
> process flag when any process uses vm86 and not do it when this flag
> is not set (as in 99% of all normal use cases)

Is there bug?

I think there's a bug with CONFIG_PREEMPT - can someone confirm?  The
kernel can be preempted after the call to disable_sysenter() in
vm86.c, and it will reschedule (see resume_kernel), and reload the
MSRs if I understand entry.S correctly.

So there needs to be a different way to set/clear the MSRs anyway.

Perhaps the debug register loads, ts_io_bitmap loads, and MSR loads
could all be efficiently conditional on a flag?

I.e., in __switch_to:

#define SLOW_SWITCH_VM86	(1 << 0)
#define SLOW_SWITCH_IO_BITMAP	(1 << 1)
#define SLOW_SWITCH_DEBUG	(1 << 2)

	if (unlikely(prev->slow_switch | next->slow_switch)) {
		if (unlikely(next->slow_switch & SLOW_SWITCH_DEBUG)) {
			// ...
		}
		if (unlikely((prev->slow_switch ^ next->slow_switch)
			     & SLOW_SWITCH_IO_BITMAP)) {
			// ...
		}
		if (unlikely((prev->slow_switch ^ next->slow_switch)
			     & SLOW_SWITCH_VM86)) {
			if (next->slow_switch & SLOW_SWITCH_VM86)
				disable_sysenter();
			else
				enable_sysenter();
		}
	}

And whenever ts_io_bitmap or debugrg[7] are written to, recalculate
the value of slow_switch (bits 1 and 2).  And set bit 0 in
do_sys_vm86, clear it in save_v86_state, and recalculate that bit in
restore_sigcontext.

That captures the rare cases, and ensures that the MSRs are always
clear in vm86 mode even if it is preempted, always set otherwise, and
not changed normally.

(The above assumes we revert to a trampoline stack, so the MSRs don't
have to be rewritten during normal context switches).

> It rewrites SYSENTER_ESP to the stack page of the current process.
> Previous implements used an trampoline for that. The reason it was moved to
> the context was that an NMI could see the trampoline stack for one
> instruction and when it calls current (very unlikely) and references the
> stack pointer it  doesn't get a valid task_struct. The obvious solution
> would be to somehow check this case (e.g. by looking at esp) in the NMI
> slow path.

It's very easy to fix NMIs by either looking at EIP or ESP at the
start of the NMI handler.  EIP is a bit simpler, because the address
range is fixed at link time and does not vary between CPUs (each CPU
needs its own 6-word trampoline).

With a trampoline stack, it's also necessary to fixup the case where a
Debug trap occurs at the start of the sysenter handler (in the debug
path), and when an NMI interrupts that debug path before it has fixed
up the stack.

A cute and wonderful hack is to use the 6 words in the TSS prior to
&tss->es as the trampoline. Now that __switch_to is done in software,
those words are not used for anything else.  The nice thing is that a
single load from a fixed offset from ESP gets you the replacement
value of %esp0, i.e. the "real" kernel stack is loaded like this:

	movl -68(%esp),%esp

Other fixed offsets from &tss->esp0 are possible - especially nice
would be to share a cache line with the GDT's hot cache line.  (To do
this, place GDT before TSS, make KERNEL_CS near the end of the GDT,
and then the accesses to GDT, trampoline and tss->esp0 will all touch
the same cache line if you're lucky).

The fixup cases for NMI and debug are a bit tricky but not _that_
tricky.

Enjoy,
-- Jamie
