Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267804AbUIPHTL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267804AbUIPHTL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 03:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267826AbUIPHTK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 03:19:10 -0400
Received: from mx2.elte.hu ([157.181.151.9]:50105 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S267804AbUIPHSU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 03:18:20 -0400
Date: Thu, 16 Sep 2004 09:19:31 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Zwane Mwaikambo <zwane@fsmlabs.com>,
       linux-kernel@vger.kernel.org, wli@holomorphy.com
Subject: Re: [PATCH] remove LOCK_SECTION from x86_64 spin_lock asm
Message-ID: <20040916071931.GA12876@elte.hu>
References: <Pine.LNX.4.53.0409151458470.10849@musoma.fsmlabs.com> <20040915144523.0fec2070.akpm@osdl.org> <20040916061359.GA12915@wotan.suse.de> <20040916062759.GA10527@elte.hu> <20040916064428.GD12915@wotan.suse.de> <20040916065101.GA11726@elte.hu> <20040916065342.GE12915@wotan.suse.de> <20040916065805.GA12244@elte.hu> <20040916070902.GF12915@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040916070902.GF12915@wotan.suse.de>
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


* Andi Kleen <ak@suse.de> wrote:

> > is less pronounced on architectures with more registers, but even with
> > 15 registers, 14 or 15 can still be a difference.) While unwinding is
> > overhead to profiling only - if enabled. Also, there could be other
> > functionality (exception handling?) that could benefit from dwarf2
> > unwinding.
> 
> Your oopses could get better backtraces, but that could be done with
> frame pointers too (I'm surprised nobody did it already btw...) 

i did it for x86 a number of times. It gets really messy - you need to
save ebp across interrupt and exception contexts and the ptrace code has
deep assumptions there. But frame pointers on x86 are really really bad
- 6 instead of 7 registers, quite a number of more spills.  _Despite
this overhead_, there are distros that picked framepointers on x86 due
to the debuggability plus! So by not having a clean unwinding and
backtracing infrastructure we are forcing distributors to compile an
inferior kernel.

> You can try to write a dwarf2 unwinder for the kernel (actually I
> think IA64 already has one, but it's quite complex as expected and
> doesn't easily map to anything else). Even with that doing a dwarf2
> unwind interpretation will have much more overhead.  For me it doesn't
> look unreasonable to recompile the kernel for special profiles though. 

the main issue is production level distro kernels - they will pick the
profilable option. So we must work on this issue some more. My ->real_pc
solution solves the profiling problem at a minimal cost (the cost to
spin_lock is close to the cost of ebp saving (on x86), and the cost to
other functions is zero). If a distro has the option between compiling
with framepointers or compiling with ->real_pc i'm sure they will pick
the ->real_pc solution. I dont say it's an elegant solution but it will
work on all architectures - and kernel/spinlock.c is shared amongst all
architectures.

(likewise, they'd pick the dwarf2 unwinder over ->real_pc because that
removes the spin_lock overhead but a dwarf2 unwinder doesnt seem to be
in the works ...)

Even on x64, you really dont want profiling to break just because
someone compiles with spinlock debugging enabled and you happen to run
out of the 7 callee-saved registers ... I think your patch is dangerous
in this respect - it might work if you can detect for sure at build time
whether there's any local variable. Tricks like this really tend to
haunt us later.

	Ingo
