Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264771AbSLVPwe>; Sun, 22 Dec 2002 10:52:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264839AbSLVPwe>; Sun, 22 Dec 2002 10:52:34 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:39298 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S264771AbSLVPwd>;
	Sun, 22 Dec 2002 10:52:33 -0500
Date: Sun, 22 Dec 2002 16:00:34 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: mingo@elte.hu, drepper@redhat.com, jun.nakajima@intel.com,
       linux-kernel@vger.kernel.org
Subject: Re: Intel P6 vs P7 system call performance
Message-ID: <20021222160034.GB30269@bjl1.asuk.net>
References: <200212221233.NAA14598@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212221233.NAA14598@harpo.it.uu.se>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
> Manfred had a version with fixed MSR values and the varying data
> in memory. Maybe that's actually faster.

The stack pointer is already changed on context switches since Ingo
changed the kernel to use per-cpu TSS segments.

Manfred's code used a tiny stack (without a valid task struct,
a different method of recovering than Linus' code).  You can get that
stack down to 6 words, (3 for debug trap, 3 more for nested NMI).

Combining these leads to an IMHO beautiful hack, which does work btw:
the 6 words fit into unused parts of the per-CPU TSS (just before
tss->es).  The MSR has a constant value:

	wrmsr(MSR_IA32_SYSENTER_ESP, (u32) &tss->es, 0);

I found the fastest sysenter entry code looks like this:

sysenter_entry_point:
	cld			# Faster before sti.
	sti			# Re-enable interrupts after next insn.
	movl	-68(%esp),%esp	# Load per-CPU stack from tss->esp0.

with appropriate fixups at the start of the NMI and debug trap handlers.

enjoy,
-- Jamie
