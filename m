Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261561AbRGIPKb>; Mon, 9 Jul 2001 11:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261289AbRGIPKV>; Mon, 9 Jul 2001 11:10:21 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:45848 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S261561AbRGIPKK>; Mon, 9 Jul 2001 11:10:10 -0400
Date: Mon, 9 Jul 2001 17:08:35 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: Abraham vd Merwe <abraham@2d3d.co.za>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: msync() bug
Message-ID: <20010709170835.J1594@athlon.random>
In-Reply-To: <20010709105044.A29658@crystal.2d3d.co.za> <3B49A44B.F5E3C6A7@uow.edu.au>, <3B49A44B.F5E3C6A7@uow.edu.au>; <20010709162131.F1594@athlon.random> <3B49C300.185DFCA4@uow.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B49C300.185DFCA4@uow.edu.au>; from andrewm@uow.edu.au on Tue, Jul 10, 2001 at 12:43:12AM +1000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2001 at 12:43:12AM +1000, Andrew Morton wrote:
> Andrea Arcangeli wrote:
> > 
> > Wrong fix, `page' is just garbage if some non memory was mapped in
> > userspace (like framebuffers or similar mmio regions were mapped etc..).
> 
> Now we're getting somewhere.  Thanks.  Tell me if this is right:
>  
> 
> > if (VALID_PAGE(page)
> 
> If the physical address of the page is somewhere inside our
> working RAM.

correct.

> 
> > !PageReserved(page)
> 
> And it's not a reserved page (discontigmem?)

yes, but it's not discontigmem issue, it is the other way around (page
structure is valid but it maps to non ram, like the 640k-1M region that
we have the page structure for, we don't use discontigmem for it because
the hole is too smalle, but it is non ram, or also normal ram mapped by
some device as dma region).

> > ptep_test_and_clear_dirty(ptep))
> 
> And if it was modified via this mapping

yes.

> 
> > +                       flush_tlb_page(vma, address);
> > +                       set_page_dirty(page);
> 
> Question:  What happens if a program mmap's a part of /dev/mem
> which passes all of these tests?   Couldn't it then pick some

that cannot happen, remap_pte_range only maps invalid pages or reserved
pages.

> arbitrary member of mem_map[] which may or may not have
> a non-zero ->mapping?


Andrea
