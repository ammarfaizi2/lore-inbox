Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267815AbUIPHeg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267815AbUIPHeg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 03:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267819AbUIPHeg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 03:34:36 -0400
Received: from cantor.suse.de ([195.135.220.2]:51377 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267815AbUIPHec (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 03:34:32 -0400
Date: Thu, 16 Sep 2004 09:29:59 +0200
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Zwane Mwaikambo <zwane@fsmlabs.com>, linux-kernel@vger.kernel.org,
       wli@holomorphy.com
Subject: Re: [PATCH] remove LOCK_SECTION from x86_64 spin_lock asm
Message-ID: <20040916072959.GH12915@wotan.suse.de>
References: <Pine.LNX.4.53.0409151458470.10849@musoma.fsmlabs.com> <20040915144523.0fec2070.akpm@osdl.org> <20040916061359.GA12915@wotan.suse.de> <20040916062759.GA10527@elte.hu> <20040916064428.GD12915@wotan.suse.de> <20040916065101.GA11726@elte.hu> <20040916065342.GE12915@wotan.suse.de> <20040916065805.GA12244@elte.hu> <20040916070902.GF12915@wotan.suse.de> <20040916071931.GA12876@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040916071931.GA12876@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2004 at 09:19:31AM +0200, Ingo Molnar wrote:
> i did it for x86 a number of times. It gets really messy - you need to
> save ebp across interrupt and exception contexts and the ptrace code has
> deep assumptions there. But frame pointers on x86 are really really bad
> - 6 instead of 7 registers, quite a number of more spills.  _Despite
> this overhead_, there are distros that picked framepointers on x86 due
> to the debuggability plus! So by not having a clean unwinding and
> backtracing infrastructure we are forcing distributors to compile an
> inferior kernel.

I think you're overstating the case here. We certainly have adequate 
profiling and debugging infrastructure on x86-64 with frame pointer
off. 

In fact on x86-64 it works even better because kgdb actually
works properly with dwarf2 and without FP and the kernel has all the proper
unwind info.

I was talking about call graph profiling, but that's an additional
new feature that could be added in the future (oprofile already
supports it with an extra patch on i386). It may need it. But
not having it wasn't a big issue so far. 

I think most users of CG profiling want to have it for user space
anyways, not necessarily for the kernel.

> 
> > You can try to write a dwarf2 unwinder for the kernel (actually I
> > think IA64 already has one, but it's quite complex as expected and
> > doesn't easily map to anything else). Even with that doing a dwarf2
> > unwind interpretation will have much more overhead.  For me it doesn't
> > look unreasonable to recompile the kernel for special profiles though. 
> 
> the main issue is production level distro kernels - they will pick the
> profilable option. So we must work on this issue some more. My ->real_pc

Something is mixed up here:

The whole problem only happens on kernels using frame pointer. I never
saw it, simply because I don't use frame pointers.

On a frame pointer less kernel profiling works just fine, and 
with this fix it should work the same on a FP kernel.

> solution solves the profiling problem at a minimal cost (the cost to

I think my new profile_pc gives it at even smaller cost though :)


> (likewise, they'd pick the dwarf2 unwinder over ->real_pc because that
> removes the spin_lock overhead but a dwarf2 unwinder doesnt seem to be
> in the works ...)
> 
> Even on x64, you really dont want profiling to break just because
> someone compiles with spinlock debugging enabled and you happen to run
> out of the 7 callee-saved registers ... I think your patch is dangerous

If someone adds such bloated debug code they can deal with it
themselves. I don't think we should try to handle such extreme
cases by default.

Ok, adding a comment there may be fair to warn them in advance.

> in this respect - it might work if you can detect for sure at build time
> whether there's any local variable. Tricks like this really tend to
> haunt us later.

There are already lots of such assumptions in the kernel (e.g. WCHAN and 
others).  I don't think adding one more is a big issue.

-Andi

