Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290088AbSAQR5S>; Thu, 17 Jan 2002 12:57:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290094AbSAQR5J>; Thu, 17 Jan 2002 12:57:09 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:9557 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S290088AbSAQR4v>; Thu, 17 Jan 2002 12:56:51 -0500
Date: Thu, 17 Jan 2002 17:57:15 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: pte-highmem-5
In-Reply-To: <20020116185814.I22791@athlon.random>
Message-ID: <Pine.LNX.4.21.0201171752520.2304-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jan 2002, Andrea Arcangeli wrote:
> 
> This patch in short will move pagetables into highmem, obviously it
> breaks all the archs out there. This should fix the problem completly
> allowing linux to effectively support all the 64G possibly available in
> the ia32 boxes (currently, without this patch, you risk to be able to
> use only a few gigabytes).

Several random points on the patch, I've not studied it as long as
I'd like: so may well be making a fool of myself on some of these,
and you may quickly say so!

1.  Yes, this has to come sooner or later, but it is a significant step,
    as I've said in other mail - may unmap some useful debugging info.

2.  More complicated than I'd like: too many pte_offset variants!
    I'd prefer it without the different SERIEs, I don't understand why
    those.  I assume it's to prevent kmaps of data flushing away "more
    valuable" kmaps of page tables, but wouldn't it be better to keep
    just one "serie" of kmap for now, add cleverer decision on what
    and when to throw away later on, localized within mm/highmem.c?

3.  KM_SERIE_PAGETABLE2 kmap_pagetable2 pmd_page2 pte_offset2 all just
    for copy_page_range src?  Why distinguished from KM_SERIE_PAGETABLE?
    Often it will already be KM_SERIE_PAGETABLE.  I can imagine you might
    want an atomic at that point (holding spinlock), but I don't see what
    the PAGETABLE2 distinction gives you.

4.  You've lifted the PAE restriction to LAST_PKMAP 512 in i386/highmem.h,
    and use pkmap_page_table as one long array in mm/highmem.c, but I
    don't see where you enforce the contiguity of page table pages in
    i386/mm/init.c.  (I do already have a patch for lifting the 1024,512
    kmaps limit, simplifying i386/mm/init.c, we've been using for months:
    I can update that from 2.4.9 if you'd like it.)

5.  Shouldn't mm/vmscan.c be in the patch?

Hugh

