Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264600AbUEYEVM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264600AbUEYEVM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 00:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264595AbUEYEVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 00:21:12 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:9451
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264588AbUEYEU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 00:20:59 -0400
Date: Tue, 25 May 2004 06:20:54 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Ben LaHaise <bcrl@kvack.org>,
       linux-mm@kvack.org, Architectures Group <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] ppc64: Fix possible race with set_pte on a present PTE
Message-ID: <20040525042054.GU29378@dualathlon.random>
References: <1085369393.15315.28.camel@gaston> <Pine.LNX.4.58.0405232046210.25502@ppc970.osdl.org> <1085371988.15281.38.camel@gaston> <Pine.LNX.4.58.0405232134480.25502@ppc970.osdl.org> <1085373839.14969.42.camel@gaston> <Pine.LNX.4.58.0405232149380.25502@ppc970.osdl.org> <20040525034326.GT29378@dualathlon.random> <Pine.LNX.4.58.0405242051460.32189@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0405242051460.32189@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2004 at 09:00:02PM -0700, Linus Torvalds wrote:
> 
> 
> On Tue, 25 May 2004, Andrea Arcangeli wrote:
> > 
> > The below patch should fix it, the only problem is that it can screwup
> > some arch that might use page-faults to keep track of the accessed bit,
> 
> Indeed. At least alpha does this - that's where this code came from. SO 
> this will cause infinite page faults on alpha and any other "accessed bit 
> in software" architectures.

as you say the alpha has no accessed bit at all in hardware, so
it cannot generate page faults. 

"accessed bit in software" is fine with my fix.

the only architecture that has the accessed bit in _hardware_ via page
faults I know is ia64, but I don't know if it has a mode to set it
without page faults and how it is implementing the accessed bit in linux.

Everything else either has it in hardware trasparently set by the cpu
(like x86) in the pte, or in software (like alpha). Either ways it's
fine.

> I suspect we should just make a "ptep_set_bits()" inline function that 
> _atomically_ does "set the dirty/accessed bits". On x86, it would be a 
> simple
> 
> 		asm("lock ; orl %1,%0"
> 			:"m" (*ptep)
> 			:"r" (entry));
>
> and similarly on most other architectures it should be quite easy to do 
> the equivalent. You can always do it with a simple compare-and-exchange 
> loop, something any SMP-capable architecture should have.
> 
> Of course, arguably we can actually optimize this by "knowing" that it is
> safe to set the dirty bit, so then we don't even need an atomic operation,
> we just need one atomic write.  So we only actually need the atomic op for 
> the accessed bit case, and if we make the write-case be totally separate..

on x86 there's no point to use atomic ops in the write_access path and
there's no point to do anything in the read path.

The only issue are the archs that may generate page faults for young bit
clear and for those we should simply add a:

	ptep_atomic_set_young(pte)

right before the pte_unmap, the tlb flush is not needed of course (they
are generating active page faults so they will re-check).

But before adding the above operation, I'd wait to hear if any
architecture is really using _hardware_ page faults for the accessed bit
in linux.

Then it also depends if this is the only buggy place or if there are
others, but certainly this one doesn't need atomic ops on x86* and alpha
(that's the only two I'm 100% sure about ;).
