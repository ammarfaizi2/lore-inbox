Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315438AbSEUSyR>; Tue, 21 May 2002 14:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315437AbSEUSyQ>; Tue, 21 May 2002 14:54:16 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:50184 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315438AbSEUSyK>; Tue, 21 May 2002 14:54:10 -0400
Date: Tue, 21 May 2002 11:53:47 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Roman Zippel <zippel@linux-m68k.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.17
In-Reply-To: <3CEA93B5.B2E62FC7@linux-m68k.org>
Message-ID: <Pine.LNX.4.33.0205211144180.3073-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 21 May 2002, Roman Zippel wrote:
> 
> Basically I could agree with it, but something looks wrong. Why exactly
> is pte_free_tlb() needed in first place? Why does it call
> tlb_remove_page()?

That is a x86-specific thing, not aarchitected.

The _architected_ thing is

 - pte_free() does the physical free of a pte pointer that was allocated 
   but never inserted into the page tables due to optimistic locking (see 
   pte_alloc_map() in mm/memory.c).

 - pte_free_tlb() does the same BUT it is also an architecture-specific 
   hook to allow the architecture to also some way shoot down whatever TLB 
   contents that might depend on the pmd_page in question.

   On x86, we do that by just adding it as another page to teh tlb flush 
   stuff, but other architectures might just make it be the same as 
   pte_free() if there are no TLB issues involved.

If you care, the reason we need to do this on x86 is that the TLB walker
is speculative and almost totally asynchronous wrt the rest of the CPU
core, so we may have a CPU "TLB lookup thread" goin on in parallel with 
the TLB cleaning - and that TLB lookup may have looked up the pmd contents 
already but not resolved the entry yet. Which is why we have to 
synchronize the PMD freeing with the TLB flush - the same way we already 
have to do it for the regular data pages.

Other architectures may not have this issue (or you can fix it with
alternative approaches, like using the pmd quicklists etc to avoid freeing
the pmd before the TLB flush, which is likely to be the fix in the 2.4.x
tree).

		Linus

