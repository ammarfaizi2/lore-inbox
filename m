Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265109AbUEYVn5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265109AbUEYVn5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 17:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265107AbUEYVn5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 17:43:57 -0400
Received: from fw.osdl.org ([65.172.181.6]:13803 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265099AbUEYVny (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 17:43:54 -0400
Date: Tue, 25 May 2004 14:43:46 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
cc: Matthew Wilcox <willy@debian.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Ben LaHaise <bcrl@kvack.org>,
       linux-mm@kvack.org, Architectures Group <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] ppc64: Fix possible race with set_pte on a present PTE
In-Reply-To: <20040525212720.GG29378@dualathlon.random>
Message-ID: <Pine.LNX.4.58.0405251440120.9951@ppc970.osdl.org>
References: <1085369393.15315.28.camel@gaston> <Pine.LNX.4.58.0405232046210.25502@ppc970.osdl.org>
 <1085371988.15281.38.camel@gaston> <Pine.LNX.4.58.0405232134480.25502@ppc970.osdl.org>
 <1085373839.14969.42.camel@gaston> <Pine.LNX.4.58.0405232149380.25502@ppc970.osdl.org>
 <20040525034326.GT29378@dualathlon.random> <Pine.LNX.4.58.0405242051460.32189@ppc970.osdl.org>
 <20040525114437.GC29154@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.58.0405250726000.9951@ppc970.osdl.org> <20040525212720.GG29378@dualathlon.random>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 25 May 2004, Andrea Arcangeli wrote:
> 
> 			entry = ptep_get_and_clear(pte);
> 			set_pte(pte, pte_modify(entry, newprot));
> 
> Again no atomic instructions.

Well, actually, that "ptep_get_and_clear()" is actually an atomic 
instruction. Or at least it had _better_ be.

> I believe using ptep_establish in handle_mm_fault makes little sense,
> to make the most obvious example there's no need of flushing the tlb in
> handle_mm_fault to resolve young or dirty page faults. Not a big deal
> for x86 and x86-64 that reaches that path only if a race happens, but on
> alpha we shouldn't flush the tlb. If some weird architecture really need
> to flush the tlb they still can inside
> ptep_handle_[young|dirty]_page_fault.

Actually, especially on alpha we _do_ need to flush the TLB.

Think about it: the TLB clearly contains the right virt->physical mapping, 
but the TLB contains the wrong "control bits". 

If we don't flush the TLB, the TLB will _continue_ to contain the wrong 
control bits.

And as you saw earlier, if those bits are wrong, you get some really nasty 
behaviour, like infinite page faults. If the TLB still says that the page 
is non-readable, even though _memory_ says it is readable, it doesn't much 
matter that we updated the page tables correctly in memory. The CPU will 
use the TLB.

So that TLB flush actually _is_ fundamental. 

Arguably we could remove it from x86. On the other hand, arguably it 
doesn't actually matter on x86, so..

		Linus
