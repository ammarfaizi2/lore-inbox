Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266991AbRGIOWR>; Mon, 9 Jul 2001 10:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266417AbRGIOWI>; Mon, 9 Jul 2001 10:22:08 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:18192 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S265003AbRGIOVv>; Mon, 9 Jul 2001 10:21:51 -0400
Date: Mon, 9 Jul 2001 16:21:31 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: Abraham vd Merwe <abraham@2d3d.co.za>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: msync() bug
Message-ID: <20010709162131.F1594@athlon.random>
In-Reply-To: <20010709105044.A29658@crystal.2d3d.co.za> <3B49A44B.F5E3C6A7@uow.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B49A44B.F5E3C6A7@uow.edu.au>; from andrewm@uow.edu.au on Mon, Jul 09, 2001 at 10:32:11PM +1000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2001 at 10:32:11PM +1000, Andrew Morton wrote:
> Abraham vd Merwe wrote:
> > 
> > Hi!
> > 
> > I was preparing some lecture last night and stumbled onto this bug. Maybe
> > some of you can shed some light on it.
> > 
> > Basically, I just memory map /dev/mem at 0xb8000 (text mode - yes I know you
> > shouldn't do this, but it was to illustrate something), reads 4k, changes it
> > writes it back.
> > 
> 
> The actual call trace is:
> 
> __set_page_dirty
> filemap_sync_pte
> filemap_sync_pte_range 
> filemap_sync_pmd_range 
> filemap_sync
> msync_interval
> sys_msync
> 
> We're crashing because __set_page_dirty dereferences page->mapping,
> but pages from a mmap() of /dev/mem seem to have a NULL ->mapping.
> 
> One of the very frustrating things about Linux kernel development
> is that the main source of tuition is merely the source code. You
> can stare at that for months (as I have) and still not have a firm
> grasp on the big-picture semantic *meaning* behind something as
> simple as a page having a null ->mapping.  Sigh.
> 
> So one is reduced to mimicry:
> 
> --- linux-2.4.7-pre3/mm/filemap.c	Wed Jul  4 18:21:32 2001
> +++ linux-akpm/mm/filemap.c	Mon Jul  9 22:22:46 2001
> @@ -1652,7 +1652,8 @@ static inline int filemap_sync_pte(pte_t
>  	if (pte_present(pte) && ptep_test_and_clear_dirty(ptep)) {
>  		struct page *page = pte_page(pte);
>  		flush_tlb_page(vma, address);
> -		set_page_dirty(page);
> +		if (page->mapping)
> +			set_page_dirty(page);
>  	}
>  	return 0;
>  }

Wrong fix, `page' is just garbage if some non memory was mapped in
userspace (like framebuffers or similar mmio regions were mapped etc..).

I fixed it right ages ago (also sumbitted to Linus but got not
integrated and I forgotten to resend):

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.7pre3aa1/00_msync-fb0-1

Please Linus include this time:

--- 2.4.5pre1aa3/mm/filemap.c.~1~	Fri May 11 02:08:28 2001
+++ 2.4.5pre1aa3/mm/filemap.c	Mon May 14 18:48:59 2001
@@ -1808,10 +1808,12 @@
 {
 	pte_t pte = *ptep;
 
-	if (pte_present(pte) && ptep_test_and_clear_dirty(ptep)) {
+	if (pte_present(pte)) {
 		struct page *page = pte_page(pte);
-		flush_tlb_page(vma, address);
-		set_page_dirty(page);
+		if (VALID_PAGE(page) && !PageReserved(page) && ptep_test_and_clear_dirty(ptep)) {
+			flush_tlb_page(vma, address);
+			set_page_dirty(page);
+		}
 	}
 	return 0;
 }

Andrea
