Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290105AbSAQSJL>; Thu, 17 Jan 2002 13:09:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290103AbSAQSJC>; Thu, 17 Jan 2002 13:09:02 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:15682 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S290102AbSAQSIs>; Thu, 17 Jan 2002 13:08:48 -0500
Date: Thu, 17 Jan 2002 19:09:24 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: pte-highmem-5
Message-ID: <20020117190924.B4847@athlon.random>
In-Reply-To: <20020116185814.I22791@athlon.random> <Pine.LNX.4.21.0201171752520.2304-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.21.0201171752520.2304-100000@localhost.localdomain>; from hugh@veritas.com on Thu, Jan 17, 2002 at 05:57:15PM +0000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2002 at 05:57:15PM +0000, Hugh Dickins wrote:
> On Wed, 16 Jan 2002, Andrea Arcangeli wrote:
> > 
> > This patch in short will move pagetables into highmem, obviously it
> > breaks all the archs out there. This should fix the problem completly
> > allowing linux to effectively support all the 64G possibly available in
> > the ia32 boxes (currently, without this patch, you risk to be able to
> > use only a few gigabytes).
> 
> Several random points on the patch, I've not studied it as long as
> I'd like: so may well be making a fool of myself on some of these,
> and you may quickly say so!
> 
> 1.  Yes, this has to come sooner or later, but it is a significant step,
>     as I've said in other mail - may unmap some useful debugging info.
> 
> 2.  More complicated than I'd like: too many pte_offset variants!
>     I'd prefer it without the different SERIEs, I don't understand why
>     those.  I assume it's to prevent kmaps of data flushing away "more
>     valuable" kmaps of page tables, but wouldn't it be better to keep
>     just one "serie" of kmap for now, add cleverer decision on what
>     and when to throw away later on, localized within mm/highmem.c?

we need more than one serie, no way, or it can deadlock, the default
serie is for pages, the other series are for pagetables.

> 
> 3.  KM_SERIE_PAGETABLE2 kmap_pagetable2 pmd_page2 pte_offset2 all just
>     for copy_page_range src?  Why distinguished from KM_SERIE_PAGETABLE?
>     Often it will already be KM_SERIE_PAGETABLE.  I can imagine you might
>     want an atomic at that point (holding spinlock), but I don't see what
>     the PAGETABLE2 distinction gives you.

deadlock avoidance. It's the same reason as the mempool, you need tow
mempool if you need two objects from the same task or it can deadlock
(yes, it would be hard to deadlock it but possible).

in fork the pte_offset kmap could be an atomic one, but atomic are more
costly with the invlpg I believe, to do it in a raw the 2 variant with a
different serie should be faster for fork(2).

> 4.  You've lifted the PAE restriction to LAST_PKMAP 512 in i386/highmem.h,
>     and use pkmap_page_table as one long array in mm/highmem.c, but I
>     don't see where you enforce the contiguity of page table pages in
>     i386/mm/init.c.  (I do already have a patch for lifting the 1024,512
>     kmaps limit, simplifying i386/mm/init.c, we've been using for months:
>     I can update that from 2.4.9 if you'd like it.)

correct, currently it works because the bootmem tends to return
physically contigous pages but it is not enforced and it may trigger
with a weird e820 layout. If you've a patch very feel free to post it!!  :)
thanks for the review.

> 
> 5.  Shouldn't mm/vmscan.c be in the patch?

can you elaborate?

Andrea
