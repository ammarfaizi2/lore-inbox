Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317404AbSHOU3N>; Thu, 15 Aug 2002 16:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317415AbSHOU3M>; Thu, 15 Aug 2002 16:29:12 -0400
Received: from mail.actcom.co.il ([192.114.47.13]:3501 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S317404AbSHOU3L>; Thu, 15 Aug 2002 16:29:11 -0400
Subject: [PATCH] Add PAGE_CACHE_PAGES
From: Gilad Ben-Yossef <gilad@benyossef.com>
To: Marcelo <marcelo@conectiva.com.br>
Cc: The Usual Suspects <linux-kernel@vger.kernel.org>,
       Patch Trivia <trivial@rustcorp.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 15 Aug 2002 23:33:00 +0300
Message-Id: <1029443580.2508.18.camel@gby.benyossef.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch introduces PAGE_CACHE_PAGES which is the number of pages in a
page cache.

Why?

Thus spake mm/shmem.c:

  idx = (address - vma->vm_start) >> PAGE_CACHE_SHIFT;
  idx += vma->vm_pgoff;

But include/linux/mm.h says:

unsigned long vm_pgoff;         /* Offset (within vm_file) in PAGE_SIZE
                                   units, *not* PAGE_CACHE_SIZE */
and include/linux/pagemap.h adds:

 * The page cache can done in larger chunks than
 * one page, because it allows for more efficient
 * throughput (it can then be mapped into user
 * space in smaller chunks for same flexibility).
 *
 * Or rather, it _will_ be done in larger chunks.

I also found two other places in mm/filemap.c that treat vma->vm_pgoff
as counting in PAGE_CACHE_SIZE units.

This patch only makes sense if PAGE_CACHE_SIZE is a multiple of
PAGE_SIZE but it seems logical to me that they will continue to be so
even when they wont be equel as they are now.

Comments are welcome.

Gilad.



diff -Nur -X /home/gby/dontdiff linux-2.4.19/include/linux/pagemap.h linux/include/linux/pagemap.h
--- linux-2.4.19/include/linux/pagemap.h	Fri Jun 21 01:38:38 2002
+++ linux/include/linux/pagemap.h	Thu Aug 15 21:53:15 2002
@@ -27,6 +27,7 @@
 #define PAGE_CACHE_SIZE		PAGE_SIZE
 #define PAGE_CACHE_MASK		PAGE_MASK
 #define PAGE_CACHE_ALIGN(addr)	(((addr)+PAGE_CACHE_SIZE-1)&PAGE_CACHE_MASK)
+#define PAGE_CACHE_PAGES         (PAGE_CACHE_SIZE / PAGE_SIZE)
 
 #define page_cache_get(x)	get_page(x)
 #define page_cache_release(x)	__free_page(x)
diff -Nur -X /home/gby/dontdiff linux-2.4.19/mm/filemap.c linux/mm/filemap.c
--- linux-2.4.19/mm/filemap.c	Thu Aug 15 21:31:38 2002
+++ linux/mm/filemap.c	Thu Aug 15 21:45:48 2002
@@ -1918,8 +1918,8 @@
 	struct page *page, **hash;
 	unsigned long size, pgoff, endoff;
 
-	pgoff = ((address - area->vm_start) >> PAGE_CACHE_SHIFT) + area->vm_pgoff;
-	endoff = ((area->vm_end - area->vm_start) >> PAGE_CACHE_SHIFT) + area->vm_pgoff;
+	pgoff = ((address - area->vm_start) >> PAGE_CACHE_SHIFT) + (area->vm_pgoff / PAGE_CACHE_PAGES);
+	endoff = ((area->vm_end - area->vm_start) >> PAGE_CACHE_SHIFT) + (area->vm_pgoff / PAGE_CACHE_PAGES);
 
 retry_all:
 	/*
diff -Nur -X /home/gby/dontdiff linux-2.4.19/mm/shmem.c linux/mm/shmem.c
--- linux-2.4.19/mm/shmem.c	Thu Aug 15 21:31:38 2002
+++ linux/mm/shmem.c	Thu Aug 15 21:41:21 2002
@@ -663,7 +663,7 @@
 	struct inode * inode = vma->vm_file->f_dentry->d_inode;
 
 	idx = (address - vma->vm_start) >> PAGE_CACHE_SHIFT;
-	idx += vma->vm_pgoff;
+	idx += (vma->vm_pgoff / PAGE_CACHE_PAGES);
 
 	if (shmem_getpage(inode, idx, &page))
 		return page;


-- 
Gilad Ben-Yossef <gilad@benyossef.com>
http://benyossef.com

"Money talks, bullshit walks and GNU awks."
  -- Shachar "Sun" Shemesh, debt collector for the GNU/Yakuza

