Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265121AbUEYVze@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265121AbUEYVze (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 17:55:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265115AbUEYVze
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 17:55:34 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:44236
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S265103AbUEYVzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 17:55:07 -0400
Date: Tue, 25 May 2004 23:55:00 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Matthew Wilcox <willy@debian.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Ben LaHaise <bcrl@kvack.org>,
       linux-mm@kvack.org, Architectures Group <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] ppc64: Fix possible race with set_pte on a present PTE
Message-ID: <20040525215500.GI29378@dualathlon.random>
References: <1085371988.15281.38.camel@gaston> <Pine.LNX.4.58.0405232134480.25502@ppc970.osdl.org> <1085373839.14969.42.camel@gaston> <Pine.LNX.4.58.0405232149380.25502@ppc970.osdl.org> <20040525034326.GT29378@dualathlon.random> <Pine.LNX.4.58.0405242051460.32189@ppc970.osdl.org> <20040525114437.GC29154@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0405250726000.9951@ppc970.osdl.org> <20040525212720.GG29378@dualathlon.random> <Pine.LNX.4.58.0405251440120.9951@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0405251440120.9951@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2004 at 02:43:46PM -0700, Linus Torvalds wrote:
> 
> 
> On Tue, 25 May 2004, Andrea Arcangeli wrote:
> > 
> > 			entry = ptep_get_and_clear(pte);
> > 			set_pte(pte, pte_modify(entry, newprot));
> > 
> > Again no atomic instructions.
> 
> Well, actually, that "ptep_get_and_clear()" is actually an atomic 
> instruction. Or at least it had _better_ be.

sure, I really meant no "new" atomic instruction.

> > I believe using ptep_establish in handle_mm_fault makes little sense,
> > to make the most obvious example there's no need of flushing the tlb in
> > handle_mm_fault to resolve young or dirty page faults. Not a big deal
> > for x86 and x86-64 that reaches that path only if a race happens, but on
> > alpha we shouldn't flush the tlb. If some weird architecture really need
> > to flush the tlb they still can inside
> > ptep_handle_[young|dirty]_page_fault.
> 
> Actually, especially on alpha we _do_ need to flush the TLB.
> 
> Think about it: the TLB clearly contains the right virt->physical mapping, 
> but the TLB contains the wrong "control bits". 
> 
> If we don't flush the TLB, the TLB will _continue_ to contain the wrong 
> control bits.

I expected the pal code to re-read the pte if the control bits asked for
page fault, like it must happen if the control bits are set to
non-present. This latter this must be true or linux wouldn't run at all
on alpha.  We certainly don't flush the tlb after marking the page from
non-present to present, example in do_anonymous_page. Anyways if the pal
code behaves like that specifically with the KWE/UWE/KRE/URE and not
with the PAGE_VALID bit, I obviously agree have to flush the tlb. I just
didn't expect it, though I admit I couldn't easily find specs about it.

> And as you saw earlier, if those bits are wrong, you get some really nasty 
> behaviour, like infinite page faults. If the TLB still says that the page 
> is non-readable, even though _memory_ says it is readable, it doesn't much 
> matter that we updated the page tables correctly in memory. The CPU will 
> use the TLB.
> 
> So that TLB flush actually _is_ fundamental. 
> 
> Arguably we could remove it from x86. On the other hand, arguably it 
> doesn't actually matter on x86, so..

it doesn't matter in handle_mm_fault but it does matter in do_wp_page.
since we've to mess with ptep_establish to fix this race, it would be
nice to remove such flush_tlb_page from do_wp_page. Or is the x86 tlb
also not refilling the pte automatically if the control bits asks for
page-fault? In mprotect obviously we've to flush since we can upgrade
and downgrade the control bits, but in do_wp_page we only ugprade, so
there should be no need of tlb flush. I'll try to find some
documentation about this to be sure, at least for x86 it should be easy
to find.
