Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262207AbSLURU6>; Sat, 21 Dec 2002 12:20:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262214AbSLURU6>; Sat, 21 Dec 2002 12:20:58 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:11246 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S262207AbSLURU4>;
	Sat, 21 Dec 2002 12:20:56 -0500
Date: Sat, 21 Dec 2002 17:28:55 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Brian Gerst <bgerst@didntduck.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, davej@suse.de
Subject: Re: Intel P6 vs P7 system call performance
Message-ID: <20021221172855.GB23577@bjl1.asuk.net>
References: <Pine.LNX.4.44.0212172205590.1233-100000@home.transmeta.com> <Pine.LNX.4.44.0212211222580.32244-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0212211222580.32244-100000@localhost.localdomain>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> > > How about this patch?  Instead of making a per-cpu trampoline, write to
> > > the msr during each context switch.
> > 
> > I wanted to avoid slowing down the context switch, but I didn't actually
> > time how much the MSR write hurts you (it needs to be conditional,
> > though, I think).
> 
> this is the solution i took in the original vsyscall patches. The syscall
> entry cost is at least one factor more important than the context-switch
> cost. The MSR write was not all that slow when i measured it (it was on
> the range of 20 cycles), and it's definitely something the chip makers
> should keep fast.

I think it would be better to make NMI and Debug trap use task gates,
if that does actually work, and let the NMI and debug handlers fix the
stack if they trap in the entry paths.  They are much rarer after all.

My unreliable memory recalls about 40 cycles for an MSR write on my Celeron.

However, I think you still need MSR writes _sometimes_ in the context
switch to disable sysenter for vm86-mode tasks.

Could the context switch be written like this?:

	if (unlikely((prev_task->flags | next_task->flags) & PF_SLOW_SWITCH)) {
		// Do rare stuff including debug registers
		// and sysenter/syscall MSR change for vm86.
	}

	// Other stuff.

-- Jamie
