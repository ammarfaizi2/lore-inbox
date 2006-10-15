Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751017AbWJOPrP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751017AbWJOPrP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 11:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751050AbWJOPrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 11:47:15 -0400
Received: from [213.46.243.16] ([213.46.243.16]:50515 "EHLO
	amsfep17-int.chello.nl") by vger.kernel.org with ESMTP
	id S1751005AbWJOPrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 11:47:14 -0400
Subject: Re: SPAM: Re: [patch 6/6] mm: fix pagecache write deadlocks
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Nick Piggin <npiggin@suse.de>
Cc: Linux Memory Management <linux-mm@kvack.org>, Neil Brown <neilb@suse.de>,
       Anton Altaparmakov <aia21@cam.ac.uk>,
       Chris Mason <chris.mason@oracle.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, ralf@linux-mips.org,
       David Howells <dhowells@redhat.com>
In-Reply-To: <20061015141953.GC25243@wotan.suse.de>
References: <20061013143516.15438.8802.sendpatchset@linux.site>
	 <20061013143616.15438.77140.sendpatchset@linux.site>
	 <1160912230.5230.23.camel@lappy> <20061015115656.GA25243@wotan.suse.de>
	 <1160920269.5230.29.camel@lappy>  <20061015141953.GC25243@wotan.suse.de>
Content-Type: text/plain
Date: Sun, 15 Oct 2006 17:47:03 +0200
Message-Id: <1160927224.5230.36.camel@lappy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-10-15 at 16:19 +0200, Nick Piggin wrote:
> On Sun, Oct 15, 2006 at 03:51:09PM +0200, Peter Zijlstra wrote:
> > 
> > > > 
> > > > Why use raw {inc,dec}_preempt_count() and not
> > > > preempt_{disable,enable}()? Is the compiler barrier not needed here? And
> > > > do we really want to avoid the preempt_check_resched()?
> > > 
> > > Counter to intuition, we actually don't mind being preempted here,
> > > but we do mind entering the (core) pagefault handler. Incrementing
> > > the preempt count causes the arch specific handler to bail out early
> > > before it takes any locks.
> > > 
> > > Clear as mud? Wrapping it in a better name might be an improvement?
> > > Or wrapping it into the copy*user_atomic functions themselves (which
> > > is AFAIK the only place we use it).
> > 
> > Right, but since you do inc the preempt_count you do disable preemption,
> > might as well check TIF_NEED_RESCHED when enabling preemption again.
> 
> Yeah, you are right about that. Unfortunately there isn't a good
> way to do this at the moment... well we could disable preempt
> around the section, but that would be silly for a PREEMPT kernel.
> 
> And we should really decouple it from preempt entirely, in case we
> ever want to check for it some other way in the pagefault handler.

How about we make sure all kmap_atomic implementations behave properly 
and make in_atomic true.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
---
 include/asm-frv/highmem.h  |    5 +++--
 include/asm-mips/highmem.h |   10 ++++++++--
 include/linux/highmem.h    |    9 ++++++---
 mm/filemap.c               |    4 +---
 4 files changed, 18 insertions(+), 10 deletions(-)

Index: linux-2.6/include/asm-frv/highmem.h
===================================================================
--- linux-2.6.orig/include/asm-frv/highmem.h	2006-07-17 22:30:51.000000000 +0200
+++ linux-2.6/include/asm-frv/highmem.h	2006-10-15 17:32:02.000000000 +0200
@@ -115,7 +115,7 @@ static inline void *kmap_atomic(struct p
 {
 	unsigned long paddr;
 
-	preempt_disable();
+	inc_preempt_count();
 	paddr = page_to_phys(page);
 
 	switch (type) {
@@ -170,7 +170,8 @@ static inline void kunmap_atomic(void *k
 	default:
 		BUG();
 	}
-	preempt_enable();
+	dec_preempt_count();
+	preempt_check_resched();
 }
 
 #endif /* !__ASSEMBLY__ */
Index: linux-2.6/include/asm-mips/highmem.h
===================================================================
--- linux-2.6.orig/include/asm-mips/highmem.h	2006-07-17 22:30:56.000000000 +0200
+++ linux-2.6/include/asm-mips/highmem.h	2006-10-15 17:36:49.000000000 +0200
@@ -70,11 +70,17 @@ static inline void *kmap(struct page *pa
 
 static inline void *kmap_atomic(struct page *page, enum km_type type)
 {
+	inc_preempt_count();
 	return page_address(page);
 }
 
-static inline void kunmap_atomic(void *kvaddr, enum km_type type) { }
-#define kmap_atomic_pfn(pfn, idx)	page_address(pfn_to_page(pfn))
+static inline void kunmap_atomic(void *kvaddr, enum km_type type)
+{
+	dec_preempt_count();
+	preempt_check_resched();
+}
+
+#define kmap_atomic_pfn(pfn, idx)	kmap_atomic(pfn_to_page(pfn), (idx))
 
 #define kmap_atomic_to_page(ptr) virt_to_page(ptr)
 
Index: linux-2.6/include/linux/highmem.h
===================================================================
--- linux-2.6.orig/include/linux/highmem.h	2006-10-07 18:47:32.000000000 +0200
+++ linux-2.6/include/linux/highmem.h	2006-10-15 17:32:44.000000000 +0200
@@ -3,6 +3,7 @@
 
 #include <linux/fs.h>
 #include <linux/mm.h>
+#include <linux/preempt.h>
 
 #include <asm/cacheflush.h>
 
@@ -41,9 +42,11 @@ static inline void *kmap(struct page *pa
 
 #define kunmap(page) do { (void) (page); } while (0)
 
-#define kmap_atomic(page, idx)		page_address(page)
-#define kunmap_atomic(addr, idx)	do { } while (0)
-#define kmap_atomic_pfn(pfn, idx)	page_address(pfn_to_page(pfn))
+#define kmap_atomic(page, idx) \
+	({ inc_preempt_count(); page_address(page); })
+#define kunmap_atomic(addr, idx) \
+	do { dec_preempt_count(); preempt_check_resched(); } while (0)
+#define kmap_atomic_pfn(pfn, idx)	kmap_atomic(pfn_to_page(pfn), (idx))
 #define kmap_atomic_to_page(ptr)	virt_to_page(ptr)
 #endif
 
Index: linux-2.6/mm/filemap.c
===================================================================
--- linux-2.6.orig/mm/filemap.c	2006-10-15 17:24:41.000000000 +0200
+++ linux-2.6/mm/filemap.c	2006-10-15 17:40:19.000000000 +0200
@@ -2140,9 +2140,8 @@ retry_noprogress:
 		 * the page lock, so we might recursively deadlock on the same
 		 * lock, or get an ABBA deadlock against a different lock, or
 		 * against the mmap_sem (which nests outside the page lock).
-		 * So increment preempt count, and use _atomic usercopies.
+		 * So use _atomic usercopies.
 		 */
-		inc_preempt_count();
 		if (likely(nr_segs == 1))
 			copied = filemap_copy_from_user_atomic(page, offset,
 							buf, bytes);
@@ -2150,7 +2149,6 @@ retry_noprogress:
 			copied = filemap_copy_from_user_iovec_atomic(page,
 						offset, cur_iov, iov_offset,
 						bytes);
-		dec_preempt_count();
 
 		if (!PageUptodate(page)) {
 			/*


