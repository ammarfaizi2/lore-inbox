Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1160997AbWJOQOG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160997AbWJOQOG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 12:14:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161004AbWJOQOG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 12:14:06 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:44821 "EHLO
	amsfep18-int.chello.nl") by vger.kernel.org with ESMTP
	id S1160997AbWJOQOD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 12:14:03 -0400
Subject: Re: RRe: [patch 6/6] mm: fix pagecache write deadlocks
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Nick Piggin <npiggin@suse.de>
Cc: Linux Memory Management <linux-mm@kvack.org>, Neil Brown <neilb@suse.de>,
       Anton Altaparmakov <aia21@cam.ac.uk>,
       Chris Mason <chris.mason@oracle.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, ralf@linux-mips.org,
       David Howells <dhowells@redhat.com>
In-Reply-To: <20061015155727.GA539@wotan.suse.de>
References: <20061013143516.15438.8802.sendpatchset@linux.site>
	 <20061013143616.15438.77140.sendpatchset@linux.site>
	 <1160912230.5230.23.camel@lappy> <20061015115656.GA25243@wotan.suse.de>
	 <1160920269.5230.29.camel@lappy> <20061015141953.GC25243@wotan.suse.de>
	 <1160927224.5230.36.camel@lappy>  <20061015155727.GA539@wotan.suse.de>
Content-Type: text/plain
Date: Sun, 15 Oct 2006 18:13:55 +0200
Message-Id: <1160928835.5230.41.camel@lappy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-10-15 at 17:57 +0200, Nick Piggin wrote:
> On Sun, Oct 15, 2006 at 05:47:03PM +0200, Peter Zijlstra wrote:
> > > 
> > > And we should really decouple it from preempt entirely, in case we
> > > ever want to check for it some other way in the pagefault handler.
> > 
> > How about we make sure all kmap_atomic implementations behave properly 
> > and make in_atomic true.
> 
> Hmm, but you may not be doing a copy*user within the kmap. And you may
> want an atomic copy*user not within a kmap (maybe).
> 
> I think it really would be more logical to do it in a wrapper function
> pagefault_disable() pagefault_enable()? ;)

I did that one first, but then noticed that most non trivial kmap_atomic
implementations already did the inc_preempt_count()/dec_preempt_count()
thing (except frv which did preempt_disable()/preempt_enable() ?)

Anyway, here goes:

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
---
 mm/filemap.c |    4 +---
 mm/filemap.h |   20 ++++++++++++++++++++
 2 files changed, 21 insertions(+), 3 deletions(-)

Index: linux-2.6/mm/filemap.c
===================================================================
--- linux-2.6.orig/mm/filemap.c	2006-10-14 20:20:20.000000000 +0200
+++ linux-2.6/mm/filemap.c	2006-10-15 17:16:59.000000000 +0200
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
Index: linux-2.6/mm/filemap.h
===================================================================
--- linux-2.6.orig/mm/filemap.h	2006-10-14 20:20:20.000000000 +0200
+++ linux-2.6/mm/filemap.h	2006-10-15 17:17:45.000000000 +0200
@@ -21,6 +21,22 @@ __filemap_copy_from_user_iovec_inatomic(
 					size_t bytes);
 
 /*
+ * By increasing the preempt_count we make sure the arch preempt
+ * handler bails out early, before taking any locks, so that the copy
+ * operation gets terminated early.
+ */
+pagefault_static inline void disable(void)
+{
+	inc_preempt_count();
+}
+
+pagefault_static inline void enable(void)
+{
+	dec_preempt_count();
+	preempt_check_resched();
+}
+
+/*
  * Copy as much as we can into the page and return the number of bytes which
  * were sucessfully copied.  If a fault is encountered then return the number of
  * bytes which were copied.
@@ -40,9 +56,11 @@ filemap_copy_from_user_atomic(struct pag
 	char *kaddr;
 	int left;
 
+	pagefault_disable();
 	kaddr = kmap_atomic(page, KM_USER0);
 	left = __copy_from_user_inatomic_nocache(kaddr + offset, buf, bytes);
 	kunmap_atomic(kaddr, KM_USER0);
+	pagefault_enable();
 
 	return bytes - left;
 }
@@ -75,10 +93,12 @@ filemap_copy_from_user_iovec_atomic(stru
 	char *kaddr;
 	size_t copied;
 
+	pagefault_disable();
 	kaddr = kmap_atomic(page, KM_USER0);
 	copied = __filemap_copy_from_user_iovec_inatomic(kaddr + offset, iov,
 							 base, bytes);
 	kunmap_atomic(kaddr, KM_USER0);
+	pagefault_enable();
 	return copied;
 }
 


