Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266218AbUFPImq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266218AbUFPImq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 04:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266221AbUFPImq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 04:42:46 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:949 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S266218AbUFPImm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 04:42:42 -0400
Date: Wed, 16 Jun 2004 10:42:36 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] s390: lost dirty bits.
Message-ID: <20040616084236.GA2738@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This patch still has a little race - it'd be better to override _all_ of
> SetPageUptodate() in page-flags.h and do:

This is even better because it really makes a race impossible. I think it
is correct with the simple if as well because a page which isn't up to date
isn't mapped anywhere and while a page is read from the backing store it
is locked. The end io function first does SetPageUptodate and then unlocks
the page.
Combining the test_and_set_bit idea with Christophs valid objection I
created a new patch.

blue skies,
   Martin

---

[PATCH] s390: lost dirty bits.

The SetPageUptodate function is called for pages that are already
up to date. The arch_set_page_uptodate function of s390 may not
clear the dirty bit in that case otherwise a dirty bit which is set
between the start of an i/o for a writeback and a following call
to SetPageUptodate is lost.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 include/asm-s390/pgtable.h |    6 ++++--
 include/linux/page-flags.h |   12 +++---------
 2 files changed, 7 insertions(+), 11 deletions(-)

diff -urN linux-2.6/include/asm-s390/pgtable.h linux-2.6-s390/include/asm-s390/pgtable.h
--- linux-2.6/include/asm-s390/pgtable.h	Wed Jun 16 10:39:37 2004
+++ linux-2.6-s390/include/asm-s390/pgtable.h	Wed Jun 16 10:39:49 2004
@@ -654,9 +654,11 @@
 	__pte;                                                            \
 })
 
-#define arch_set_page_uptodate(__page)					  \
+#define SetPageUptodate(_page) \
 	do {								  \
-		asm volatile ("sske %0,%1" : : "d" (0),			  \
+		struct page *__page = (_page);				  \
+		if (!test_and_set_bit(PG_uptodate, &__page->flags))	  \
+			asm volatile ("sske %0,%1" : : "d" (0),		  \
 			      "a" (__pa((__page-mem_map) << PAGE_SHIFT)));\
 	} while (0)
 
diff -urN linux-2.6/include/linux/page-flags.h linux-2.6-s390/include/linux/page-flags.h
--- linux-2.6/include/linux/page-flags.h	Wed Jun 16 10:39:37 2004
+++ linux-2.6-s390/include/linux/page-flags.h	Wed Jun 16 10:39:49 2004
@@ -194,16 +194,10 @@
 #define ClearPageReferenced(page)	clear_bit(PG_referenced, &(page)->flags)
 #define TestClearPageReferenced(page) test_and_clear_bit(PG_referenced, &(page)->flags)
 
-#ifndef arch_set_page_uptodate
-#define arch_set_page_uptodate(page) do { } while (0)
-#endif
-
 #define PageUptodate(page)	test_bit(PG_uptodate, &(page)->flags)
-#define SetPageUptodate(page) \
-	do {								\
-		arch_set_page_uptodate(page);				\
-		set_bit(PG_uptodate, &(page)->flags);			\
-	} while (0)
+#ifndef SetPageUptodate
+#define SetPageUptodate(page)	set_bit(PG_uptodate, &(page)->flags)
+#endif
 #define ClearPageUptodate(page)	clear_bit(PG_uptodate, &(page)->flags)
 
 #define PageDirty(page)		test_bit(PG_dirty, &(page)->flags)
