Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267053AbRGIMbq>; Mon, 9 Jul 2001 08:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267052AbRGIMbg>; Mon, 9 Jul 2001 08:31:36 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:25086 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S267050AbRGIMb1>; Mon, 9 Jul 2001 08:31:27 -0400
Message-ID: <3B49A44B.F5E3C6A7@uow.edu.au>
Date: Mon, 09 Jul 2001 22:32:11 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Abraham vd Merwe <abraham@2d3d.co.za>
CC: Linux Kernel Development <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: msync() bug
In-Reply-To: <20010709105044.A29658@crystal.2d3d.co.za>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Abraham vd Merwe wrote:
> 
> Hi!
> 
> I was preparing some lecture last night and stumbled onto this bug. Maybe
> some of you can shed some light on it.
> 
> Basically, I just memory map /dev/mem at 0xb8000 (text mode - yes I know you
> shouldn't do this, but it was to illustrate something), reads 4k, changes it
> writes it back.
> 

The actual call trace is:

__set_page_dirty
filemap_sync_pte
filemap_sync_pte_range 
filemap_sync_pmd_range 
filemap_sync
msync_interval
sys_msync

We're crashing because __set_page_dirty dereferences page->mapping,
but pages from a mmap() of /dev/mem seem to have a NULL ->mapping.

One of the very frustrating things about Linux kernel development
is that the main source of tuition is merely the source code. You
can stare at that for months (as I have) and still not have a firm
grasp on the big-picture semantic *meaning* behind something as
simple as a page having a null ->mapping.  Sigh.

So one is reduced to mimicry:

--- linux-2.4.7-pre3/mm/filemap.c	Wed Jul  4 18:21:32 2001
+++ linux-akpm/mm/filemap.c	Mon Jul  9 22:22:46 2001
@@ -1652,7 +1652,8 @@ static inline int filemap_sync_pte(pte_t
 	if (pte_present(pte) && ptep_test_and_clear_dirty(ptep)) {
 		struct page *page = pte_page(pte);
 		flush_tlb_page(vma, address);
-		set_page_dirty(page);
+		if (page->mapping)
+			set_page_dirty(page);
 	}
 	return 0;
 }

-
