Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275050AbTHMOKQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 10:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275052AbTHMOKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 10:10:16 -0400
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:18936 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S275050AbTHMOKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 10:10:08 -0400
Subject: Re: 2.6.0-test3-mm1: scheduling while atomic (ext3?)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030813131457.GD32290@wotan.suse.de>
References: <20030813045638.GA9713@middle.of.nowhere.suse.lists.linux.kernel>
	 <20030813014746.412660ae.akpm@osdl.org.suse.lists.linux.kernel>
	 <20030813091958.GA30746@gates.of.nowhere.suse.lists.linux.kernel>
	 <20030813025542.32429718.akpm@osdl.org.suse.lists.linux.kernel>
	 <1060772769.8009.4.camel@localhost.localdomain.suse.lists.linux.kernel>
	 <20030813042544.5064b3f4.akpm@osdl.org.suse.lists.linux.kernel>
	 <1060774803.8008.24.camel@localhost.localdomain.suse.lists.linux.kernel>
	 <p7365l17o70.fsf@oldwotan.suse.de>
	 <1060778924.8008.39.camel@localhost.localdomain>
	 <20030813131457.GD32290@wotan.suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1060783794.8008.62.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 13 Aug 2003 15:09:55 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-08-13 at 14:14, Andi Kleen wrote:
> hw prefetch has nothing to do with how the linux kernel uses prefetch.
> It's only using it for data structures that cannot be handled by
> the auto prefetcher.
> 
> [except the broken 3dnow! copy that was never enabled]

Not broken in 2.4, although the 2.4-ac kernel uses movntq instead for
Athlon as it is faster than mmx_memcpy, which we use for Cyrix/VIA/IDT
processors where it is a win.
 
> > > Most Athlons in existence should have XMM already and the rest works.
> > 
> > Lots don't have XMM
> 
> All XPs have.

And what about all the pre MP/XP ones, lots of those.

> My AMD manual lists it as part of 3dnow. If an CPU advertises 3dnow!
> but doesn't have the instruction it's broken.

My AMD docs list it as part of the AMD extended 3dnow. The original
3dnow as done by AMD/Cyrix does not have it

> I would consider the MII broken then. setup should clear the 3dnow
> bit.

"Mummy it doesnt work like I personally have decreed it shall lets break
it and screw all the users". Thats the Dan Bernstein school of charm
theory of software development.

> there is 3dnowext, set on Athlons, but K6 has prefetchw too and
> it 

3dnowext is what we want here. It might end up doing a prefetchw on
K6 but at least K6 actually has the instruction...

> But if you only want Athlon you can check for X86_FEATURE_K7.
> The problem is that it doesn't include K8 and K8
> has prefetchw too (alternative currently only allows a single 
> bit, not a bitmask). Better is to either clear 3dnow on the MII
> or define a new pseudo bit that defines working and useful 
> prefetchw

We want a pseudobit - otherwise we'll break other code that checks
3dnow is present properly.

> > #if defined(CONFIG_MK7)
> >     alternative_input("prefetch" or "prefetchnta")
> > #else
> >     alternative_input(ASM_NOP4 or "prefetchnta");
> > #endif
> 
> No for weird combinations you define a new pseudo CPUID capability 
> bit, check for that in the CPU detection and use that in the alternative.

Ok

> If you really want 3 way alternative you can just define a macro
> for it. The basic data structure supports it - the macro
> just needs to have two .altinstructions records and two replacement codes. 
> But I have my doubt it is worth it for this case.

prefetching is a big win on older Athlon because the CPU is fast and the
chipset/ram sucks hugely relative to it

> No stinkin' ifdefs please, that would break the whole concept.

Ok

> > case at least gets us back to desirable situations. Also if I remember
> > the prefetch exception thing rightly you can misalign the prefetch
> > instruction as a workaround.
> 
> Nope, no misalignment. All it does is to just handle the exception
> using __ex_table and jumps to the next instruction.

If you misalign the instruction you don't seem to get the exception on
Athlon, dunno about the Opteron errata or if the opteron errata bites in
32bit. If it does I guess we should clear mmx, xmm for Opteron by your
arguments ;)


