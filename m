Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318207AbSHSIrN>; Mon, 19 Aug 2002 04:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318208AbSHSIrN>; Mon, 19 Aug 2002 04:47:13 -0400
Received: from adsl-161-92.barak.net.il ([62.90.161.92]:28683 "EHLO
	hirame.qlusters.com") by vger.kernel.org with ESMTP
	id <S318207AbSHSIrM>; Mon, 19 Aug 2002 04:47:12 -0400
Subject: Re: [PATCH] Add PAGE_CACHE_PAGES
From: Gilad Ben-Yossef <gilad@benyossef.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: torvalds@transmeta.com, Marcelo <marcelo@conectiva.com.br>,
       The Usual Suspects <linux-kernel@vger.kernel.org>,
       Patch Trivia <trivial@rustcorp.com.au>
In-Reply-To: <20020818232457.227812C195@lists.samba.org>
References: <20020818232457.227812C195@lists.samba.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 19 Aug 2002 11:48:59 +0300
Message-Id: <1029746940.31934.64.camel@sake>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-08-19 at 06:56, Rusty Russell wrote:
> > 
> > This patch introduces PAGE_CACHE_PAGES which is the number of pages in a
> > page cache.
> 
> AFAICT, you should simply do
> 
> /* Order of pages in page cache */
> #define PAGE_CACHE_PAGE_ORDER 0

Yes, it is simpler and better. I bow to your superiour code-fu :-)

Here is the patch done Rusty's way and against 2.5.31 as per Hugh
Dickins indication that this is not apropriate to fix in 2.4.x.

Recap: trying to solve the problem that shmem.c and filemap.c treat
vma->vm_pgoff as containing PAGE_CACHE_SIZE blocks despite the explicit
warning that it does not in include/linux/mm.h. Doesn't really hurt us
now but as is this may break horribly when PAGE_CACHE_SIZE !=
PAGE_SIZE).

Thanks,
Gilad

diff -Nur -X dontdiff linux-2.5.31/include/linux/pagemap.h linux-2.5.31-gby/include/linux/pagemap.h
--- linux-2.5.31/include/linux/pagemap.h	Sun Aug 11 04:41:17 2002
+++ linux-2.5.31-gby/include/linux/pagemap.h	Mon Aug 19 10:39:10 2002
@@ -17,10 +17,14 @@
  *
  * Or rather, it _will_ be done in larger chunks.
  */
-#define PAGE_CACHE_SHIFT	PAGE_SHIFT
-#define PAGE_CACHE_SIZE		PAGE_SIZE
-#define PAGE_CACHE_MASK		PAGE_MASK
-#define PAGE_CACHE_ALIGN(addr)	(((addr)+PAGE_CACHE_SIZE-1)&PAGE_CACHE_MASK)
+
+/* Order of pages in page cache */
+#define PAGE_CACHE_PAGE_ORDER 0
+
+#define PAGE_CACHE_SHIFT        (PAGE_SHIFT + PAGE_CACHE_PAGE_ORDER)
+#define PAGE_CACHE_SIZE         (1 << PAGE_CACHE_SHIFT)
+#define PAGE_CACHE_MASK         (~(PAGE_CACHE_SIZE-1))
+#define PAGE_CACHE_ALIGN(addr)  (((addr)+PAGE_CACHE_SIZE-1)&PAGE_CACHE_MASK)
 
 #define page_cache_get(x)	get_page(x)
 extern void FASTCALL(page_cache_release(struct page *));
diff -Nur -X dontdiff linux-2.5.31/mm/filemap.c linux-2.5.31-gby/mm/filemap.c
--- linux-2.5.31/mm/filemap.c	Sun Aug 11 04:41:26 2002
+++ linux-2.5.31-gby/mm/filemap.c	Mon Aug 19 10:59:07 2002
@@ -1186,8 +1186,8 @@
 	unsigned long size, pgoff, endoff;
 	int did_readahead;
 
-	pgoff = ((address - area->vm_start) >> PAGE_CACHE_SHIFT) + area->vm_pgoff;
-	endoff = ((area->vm_end - area->vm_start) >> PAGE_CACHE_SHIFT) + area->vm_pgoff;
+	pgoff = ((address - area->vm_start) >> PAGE_CACHE_SHIFT) + (area->vm_pgoff >> PAGE_CACHE_PAGE_ORDER);
+	endoff = ((area->vm_end - area->vm_start) >> PAGE_CACHE_SHIFT) + (area->vm_pgoff >> PAGE_CACHE_PAGE_ORDER);
 
 retry_all:
 	/*
diff -Nur -X dontdiff linux-2.5.31/mm/shmem.c linux-2.5.31-gby/mm/shmem.c
--- linux-2.5.31/mm/shmem.c	Sun Aug 11 04:41:27 2002
+++ linux-2.5.31-gby/mm/shmem.c	Mon Aug 19 10:59:54 2002
@@ -731,7 +731,7 @@
 	struct inode * inode = vma->vm_file->f_dentry->d_inode;
 
 	idx = (address - vma->vm_start) >> PAGE_CACHE_SHIFT;
-	idx += vma->vm_pgoff;
+	idx += (vma->vm_pgoff >> PAGE_CACHE_PAGE_ORDER);
 
 	if (shmem_getpage(inode, idx, &page))
 		return page;

-- 
Gilad Ben-Yossef <gilad@benyossef.com>
Code mangler, senior coffee drinker and VP SIGSEGV
Qlusters ltd.

"You got an EMP device in the server room? That is so cool."
      -- from a hackers-il thread on paranoia



