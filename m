Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274813AbTHMNPQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 09:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274944AbTHMNPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 09:15:16 -0400
Received: from mail.suse.de ([213.95.15.193]:12805 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S274813AbTHMNO7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 09:14:59 -0400
Date: Wed, 13 Aug 2003 15:14:57 +0200
From: Andi Kleen <ak@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test3-mm1: scheduling while atomic (ext3?)
Message-ID: <20030813131457.GD32290@wotan.suse.de>
References: <20030813045638.GA9713@middle.of.nowhere.suse.lists.linux.kernel> <20030813014746.412660ae.akpm@osdl.org.suse.lists.linux.kernel> <20030813091958.GA30746@gates.of.nowhere.suse.lists.linux.kernel> <20030813025542.32429718.akpm@osdl.org.suse.lists.linux.kernel> <1060772769.8009.4.camel@localhost.localdomain.suse.lists.linux.kernel> <20030813042544.5064b3f4.akpm@osdl.org.suse.lists.linux.kernel> <1060774803.8008.24.camel@localhost.localdomain.suse.lists.linux.kernel> <p7365l17o70.fsf@oldwotan.suse.de> <1060778924.8008.39.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1060778924.8008.39.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 13, 2003 at 01:48:45PM +0100, Alan Cox wrote:
> On Mer, 2003-08-13 at 13:10, Andi Kleen wrote:
> > > Beats me, but then the prefetch code in 2.6 seems broken from
> > > 5 seconds of inspection anyway. We are testing the XMM feature
> > > and using prefetchnta for Athlon, thats wrong for lots of athlon
> > > processors that dont have XMM but do have prefetch/prefetchw,
> > > (which btw also seem to work properly on all these processors
> > >  while prefetchnta seems to do funky things)
> > 
> > The early Athlon Specific test was not done to avoid too much bloat.
> > (three alternatives instead of two)
> 
> Lets replace working code with broken macros whoooo.. progress. Lots of
> Athlons don't have XMM, most of the older ones where prefetch has the
> most impact in fact. (The XMM using ones have the hw prefetcher too).

hw prefetch has nothing to do with how the linux kernel uses prefetch.
It's only using it for data structures that cannot be handled by
the auto prefetcher.

[except the broken 3dnow! copy that was never enabled]


> 
> > Most Athlons in existence should have XMM already and the rest works.
> 
> Lots don't have XMM

All XPs have.

> 
> > You can hardly call that broken.
> 
> I just did. Its worse than 2.4 behaviour.

In 2.4 distribution users never got anything. That is what was really
broken.

> 
> > That's done for write prefetches correctly.
> > (as Intel does not have a write prefetch)
> 
> Actually its iffy too. 3Dnow doesnt imply prefetchw. You

My AMD manual lists it as part of 3dnow. If an CPU advertises 3dnow!
but doesn't have the instruction it's broken.


> must test 3Dnow && vendor==AMD && Athlon. (K6 prefetchw
> is slower than not using it, other 3Dnow chips dont have it
> eg the Cyrix MII which may explain a couple of things. I don't

I would consider the MII broken then. setup should clear the 3dnow
bit.

> see anywhere we mask the 3Dnow property by these but I've not
> dug through the CPU code right now to see if we have a "3Dnowplus"
> type definition we can check.

there is 3dnowext, set on Athlons, but K6 has prefetchw too and
it 

But if you only want Athlon you can check for X86_FEATURE_K7.
The problem is that it doesn't include K8 and K8
has prefetchw too (alternative currently only allows a single 
bit, not a bitmask). Better is to either clear 3dnow on the MII
or define a new pseudo bit that defines working and useful 
prefetchw


> 
> I suspect the best way to do prefetch cleanly would be something
> like this
> 
> #if defined(CONFIG_MK7)
>     alternative_input("prefetch" or "prefetchnta")
> #else
>     alternative_input(ASM_NOP4 or "prefetchnta");
> #endif

No for weird combinations you define a new pseudo CPUID capability 
bit, check for that in the CPU detection and use that in the alternative.

If you really want 3 way alternative you can just define a macro
for it. The basic data structure supports it - the macro
just needs to have two .altinstructions records and two replacement codes. 
But I have my doubt it is worth it for this case.

No stinkin' ifdefs please, that would break the whole concept.

> 
> Ideally we want a 3 way patch table to fix up at boot time but the if
> case at least gets us back to desirable situations. Also if I remember
> the prefetch exception thing rightly you can misalign the prefetch
> instruction as a workaround.

Nope, no misalignment. All it does is to just handle the exception
using __ex_table and jumps to the next instruction.

[the exceptions are very rare, they need very specific circumstances
in the CPU to trigger, so it's ok to make it slow]

Only trap is that you have to add the exception table sorting too...

-Andi

