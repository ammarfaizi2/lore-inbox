Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261859AbVC3Kq4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261859AbVC3Kq4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 05:46:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261860AbVC3Kqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 05:46:55 -0500
Received: from mx1.redhat.com ([66.187.233.31]:47071 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261859AbVC3Kqv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 05:46:51 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Pine.LNX.4.61.0503292223090.18131@goblin.wat.veritas.com> 
References: <Pine.LNX.4.61.0503292223090.18131@goblin.wat.veritas.com>  <Pine.LNX.4.61.0503231705560.15274@goblin.wat.veritas.com> <Pine.LNX.4.61.0503231710310.15274@goblin.wat.veritas.com> <4243A257.8070805@yahoo.com.au> <20050325092312.4ae2bd32.davem@davemloft.net> <20050325162926.6d28448b.davem@davemloft.net> 
To: Hugh Dickins <hugh@veritas.com>
Cc: "David S. Miller" <davem@davemloft.net>, Ian Molton <spyro@f2s.com>,
       nickpiggin@yahoo.com.au, akpm@osdl.org, tony.luck@intel.com,
       benh@kernel.crashing.org, ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] freepgt: free_pgtables use vma list 
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Wed, 30 Mar 2005 11:46:17 +0100
Message-ID: <22627.1112179577@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hugh Dickins <hugh@veritas.com> wrote:

> On Fri, 25 Mar 2005, David S. Miller wrote:
> 
> [ of flush_tlb_pgtables ]
> 
> > Since sparc64 is the only user of this thing...
> 
> Not quite.  sparc64 is the only user which makes any use of the
> addresses passed to it, but frv does a little assembler with it,
> and arm26 does a printk - eh? I'd take that to mean that it never
> gets called there, but I don't see what prevents it, before or now.
> Ian, does current -mm give you "flush_tlb_pgtables" printks?

That bit of assembly invalidates some data cached by the TLB-miss handler in
registers SCR0 and SCR1 to improve performance in the next TLB-miss event.

What happens is that the TLB-miss handler sets a static mapping for a page
table and stores the base virtual address for the region covered by that page
table in SCR0 (ITLB) or SCR1 (DTLB). Then when dealing with the next TLB-miss
event we can do:

	((SCRx ^ virtaddr) >> 26) == 0

to very quickly work out whether we can re-use the static mapping left from
the previous TLB-miss event.

However, if the mapping from virtual address to page table changes, then the
cached static mappings may no longer be valid. We can invalidate them simply
by zapping SCR0 and SCR1.

It occurs to me that:

	#define flush_tlb_pgtables(mm,start,end) \
		asm volatile("movgs gr0,scr0 ! movgs gr0,scr1");

is actually wrong. It doesn't actually invalidate anything; it just changes
the virtual range for that page table to be 0x00000000-0x04000000, no matter
whether that page table should be backing that region or not. It should
instead be:

	#define flush_tlb_pgtables(mm,start,end) \
		asm volatile("movgs %0,scr0 ! movgs %0,scr1" :: "r"(-1));

Because the addresses in the range 0xFC000000-0xFFFFFFFF are all statically
mapped to the Boot ROM chip select.

This doesn't matter for most programs as they never use more than the bottom
page table anyway (which covers 64MB).

> > Let's make it so that the flush can be queued up
> > at pmd_clear() time, as that's what we really want.
> > 
> > Something like:
> > 
> > 	pmd_clear(mm, vaddr, pmdp);
> > 
> > I'll try to play with something like this later.
> 
> Depends really on what DavidH wants there, not clear to me.
> I suspect Ian can live without his printk!

I could do the zapping in pmd_clear() instead, I suppose. It's just that it
only needs to be done once when tearing down the page tables; not for every
PMD.

David
