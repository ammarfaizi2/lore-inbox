Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262365AbSJTLOi>; Sun, 20 Oct 2002 07:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262368AbSJTLOi>; Sun, 20 Oct 2002 07:14:38 -0400
Received: from ns.suse.de ([213.95.15.193]:31496 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S262365AbSJTLOh>;
	Sun, 20 Oct 2002 07:14:37 -0400
Date: Sun, 20 Oct 2002 13:20:41 +0200
From: Andi Kleen <ak@suse.de>
To: Elladan <elladan@eskimo.com>
Cc: Andi Kleen <ak@suse.de>, Andi Kleen <ak@muc.de>,
       Andrea Arcangeli <andrea@suse.de>, Jeff Dike <jdike@karaya.com>,
       john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       george anzinger <george@mvista.com>,
       Stephen Hemminger <shemminger@osdl.org>, discuss@x86-64.org, aj@suse.de
Subject: Re: [discuss] Re: [PATCH] linux-2.5.43_vsyscall_A0
Message-ID: <20021020132041.A24024@wotan.suse.de>
References: <20021019031002.GA16404@averell> <200210190450.XAA06161@ccure.karaya.com> <20021019040238.GA21914@averell> <20021019041659.GK23930@dualathlon.random> <20021020025914.GB15342@averell> <20021020064433.GA32594@eskimo.com> <20021020112730.A29357@wotan.suse.de> <20021020105841.GA1024@eskimo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021020105841.GA1024@eskimo.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 20, 2002 at 03:58:41AM -0700, Elladan wrote:
> Not really any more tricky than turning it off globally with a flag.
> It's just more expensive, because you have to propagate the flag into
> vsyscall space on the context switch.  In the per-process case,
> self-modifying code would be a less non-viable approach than it is
> globally.

Umm, you forgot about SMP. Modifying it on context switch would require
per CPU mappings and vsyscall pages. Currently the kernel page tables
are shared globally, changing them to be CPU local would be somewhat
involved. While it would be doable as long as x86-64 is limited to three
level page tables for user space it would be a major pain as soon
as four level page tables were supported. In this case multiple threads
sharing the same mm but running on multiple CPUs couldn't share the same 
page table anymore, and changing that would make threading significantly
more complicated. On i386 this problem is always there.

Also the context switch is a very critical path, we don't want to add
random junk like this in there.

> Well, self modifying code certainly looked like what Andrea was talking
> about, to avoid the branch overhead on the userspace gettimeofday()
> call.

A test+branch here is completely lost in the noise, not even
worth thinking about.

> It seems that to fix this with proper data-hiding, it would really need
> to be possible to set the vsyscall pages as invalid for the UML process
> (so it could manually emulate the vsyscall), which would then either
> require expensive contex-switching costs to make it a per-process flag,
> or we're back to global self-modifying-code fixups.

I have no problems at all with a system global flag. After all vsyscalls
are just an optimization. When you use UML you can't use that optimization,
very simple. It's similar to other circumstances that have an impact
on the whole system, e.g. when you use floating point in any process 
then the context switch becomes slower for everybody. Not a big deal.


-Andi
