Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317031AbSEWWEp>; Thu, 23 May 2002 18:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317034AbSEWWEo>; Thu, 23 May 2002 18:04:44 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:24583 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317031AbSEWWEm>; Thu, 23 May 2002 18:04:42 -0400
Date: Thu, 23 May 2002 15:04:36 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Q: backport of the free_pgtables tlb fixes to 2.4
In-Reply-To: <20020523204101.GY21164@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0205231459230.29160-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 23 May 2002, Andrea Arcangeli wrote:
>
> If the userspace tlb lookup is started during munmap the tlb can contain
> garabge before invalidate_tlb.

No.

If we wait until after the TLB fill to actually free the page tables
pages, there is _no_ way the TLB can contain garbage, because the page
directories will never have had garbage in it while any TLB lookup could
be active.

Which is the whole _point_ of the patches.

> What I don't understand is how the BTB can invoke random userspace tlb
> fills when we are running do_munmap, there's no point at all in doing
> that. If the cpu see a read of an user address after invalidate_tlb,
> the tlb must not be started because it's before an invalidate_tlb.

Take a course in CPU design if you want to understand why a CPU front-end
might speculatively start accessing something before the back-end has
actually told it what the "something" actually is.

But don't argue with the patch.

> And if it's true not even irq are barriers for the tlb fills invoked by
> this p4-BTB thing

It has nothing to do with the BTB - the BTB is just a source of
speculative addresses to start looking at.

But yes, Intel tells me that the only thing that is guaranteed to
serialize a TLB lookup is a TLB invalidate. NOTHING else.

>	so if leave_mm is really necessary, then 2.5 is as
> well wrong in UP, because the pagetable can be scribbled by irqs in a UP
> machine, and so the fastmode must go away even in 1 cpu systems.

Yes. Except I will make the 2.5.x code use the pmd quicklists instead
(both fast and slow mode), since that actually ends up being "nicer" from
a cross-architecture standpoint (right now the i386 careful mode depends
on the fact that page directories are regular pages - which is not true on
other CPU's).

		Linus

