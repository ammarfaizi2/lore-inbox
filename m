Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317188AbSEXQN4>; Fri, 24 May 2002 12:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314505AbSEXQNz>; Fri, 24 May 2002 12:13:55 -0400
Received: from mailsorter.ma.tmpw.net ([63.112.169.25]:18978 "EHLO
	mailsorter.ma.tmpw.net") by vger.kernel.org with ESMTP
	id <S317188AbSEXQNv>; Fri, 24 May 2002 12:13:51 -0400
Message-ID: <61DB42B180EAB34E9D28346C11535A783A775D@nocmail101.ma.tmpw.net>
From: "Holzrichter, Bruce" <bruce.holzrichter@monster.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: FW: sparc64 pgalloc.h pgd_quicklist question
Date: Fri, 24 May 2002 11:13:42 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave,

Right now, if you configure Sparc64 for UP, free_pgd_fast and get_pgd_fast
are configured to use the old linked list in struct page. There may be other
reasons to not configure a machine for UP, but I was looking at the pgalloc,
and as you seem to be working on some of the pgt stuff, what better time to
ask! 

Anyway, After looking at the SMP and UP configuration in pgalloc.h, could
you simply remove the UP/SMP differentiation in the routines, as in my
attachment?  It looks to me, that the struct for pgt_quicklist is built
correctly for UP or SMP above this?  I could be wrong on this....

Thanks,
Bruce H.

--- sparctest/include/asm-sparc64/pgalloc.h	Thu May 23 09:30:46 2002
+++ sparchack/include/asm-sparc64/pgalloc.h	Fri May 24 11:48:37 2002
@@ -28,66 +28,6 @@
 #define pgtable_cache_size	(pgt_quicklists.pgcache_size)
 #define pgd_cache_size		(pgt_quicklists.pgdcache_size)
 
-#ifndef CONFIG_SMP
-
-static __inline__ void free_pgd_fast(pgd_t *pgd)
-{
-	struct page *page = virt_to_page(pgd);
-
-	preempt_disable();
-	if (!page->pprev_hash) {
-		(unsigned long *)page->next_hash = pgd_quicklist;
-		pgd_quicklist = (unsigned long *)page;
-	}
-	(unsigned long)page->pprev_hash |=
-		(((unsigned long)pgd & (PAGE_SIZE / 2)) ? 2 : 1);
-	pgd_cache_size++;
-	preempt_enable();
-}
-
-static __inline__ pgd_t *get_pgd_fast(void)
-{
-        struct page *ret;
-
-	preempt_disable();
-        if ((ret = (struct page *)pgd_quicklist) != NULL) {
-                unsigned long mask = (unsigned long)ret->pprev_hash;
-		unsigned long off = 0;
-
-		if (mask & 1)
-			mask &= ~1;
-		else {
-			off = PAGE_SIZE / 2;
-			mask &= ~2;
-		}
-		(unsigned long)ret->pprev_hash = mask;
-		if (!mask)
-			pgd_quicklist = (unsigned long *)ret->next_hash;
-                ret = (struct page *)(__page_address(ret) + off);
-                pgd_cache_size--;
-		preempt_enable();
-        } else {
-		struct page *page;
-
-		preempt_enable();
-		page = alloc_page(GFP_KERNEL);
-		if (page) {
-			ret = (struct page *)page_address(page);
-			clear_page(ret);
-			(unsigned long)page->pprev_hash = 2;
-
-			preempt_disable();
-			(unsigned long *)page->next_hash = pgd_quicklist;
-			pgd_quicklist = (unsigned long *)page;
-			pgd_cache_size++;
-			preempt_enable();
-		}
-        }
-        return (pgd_t *)ret;
-}
-
-#else /* CONFIG_SMP */
-
 static __inline__ void free_pgd_fast(pgd_t *pgd)
 {
 	preempt_disable();
@@ -115,6 +55,8 @@
 	}
 	return (pgd_t *)ret;
 }
+
+#ifdef CONFIG_SMP  /* CONFIG_SMP */
 
 static __inline__ void free_pgd_slow(pgd_t *pgd)
 {
