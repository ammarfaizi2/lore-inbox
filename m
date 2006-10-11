Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161003AbWJKGTM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161003AbWJKGTM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 02:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161000AbWJKGSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 02:18:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64967 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030660AbWJKGSS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 02:18:18 -0400
Date: Tue, 10 Oct 2006 23:18:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>, Nick Piggin <npiggin@suse.de>,
       Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [patch 6/6] fix pagecache write deadlocks
Message-Id: <20061010231808.2d90bc5f.akpm@osdl.org>
In-Reply-To: <20061010231514.c1da7355.akpm@osdl.org>
References: <20061010121314.19693.75503.sendpatchset@linux.site>
	<20061010121332.19693.37204.sendpatchset@linux.site>
	<20061010221304.6bef249f.akpm@osdl.org>
	<452C8613.7080708@yahoo.com.au>
	<20061010231150.fb9e30f5.akpm@osdl.org>
	<20061010231243.bc8b834c.akpm@osdl.org>
	<20061010231339.a79c1fae.akpm@osdl.org>
	<20061010231424.db88931f.akpm@osdl.org>
	<20061010231514.c1da7355.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>

This is half-written and won't work.

The idea is to modify the core write() code so that it won't take a pagefault
while holding a lock on the pagecache page.

- Instead of copy_from_user(), use inc_preempt_count() and
  copy_from_user_inatomic().

- If the copy_from_user_inatomic() hits a pagefault, it'll return a short
  copy.

  - So zero out the remainder of the pagecache page (the uncopied bit).

    - but only if the page is not uptodate.

  - commit_write()

  - unlock_page()

  - adjust various pointers and counters

  - go back and try to fault the page in again, redo the lock_page,
    prepare_write, copy_from_user_inatomic(), etc.

  - After a certain number of retries, someone is being silly: give up.


Now, the design objective here isn't just to fix the deadlock.  It's to be
able to copy multiple iovec segments into the pagecache page within a single
prepare-write/commit_write pair.  But to do that, we'll need to prefault them.

That could get complex.  Walk across the segments, touching each user page
until we reach the point where we see that this iovec segment doesn't fall
into the target page.

Alternatively, only prefault the *present* iovec segment.  The code as
designed will handle pagefaults against the user's pages quite happily.  But
is it efficient?  Needs thought.

(I think we will end up with quite a bit of dead code as a result of this
exercise - some of the fancy user-copying inlines.  Needs checking when the
dust has settled).


Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 mm/filemap.c |    7 ++--
 mm/filemap.h |   69 ++++++++++++++++++++++++++++++++++---------------
 2 files changed, 53 insertions(+), 23 deletions(-)

diff -puN mm/filemap.c~fix-pagecache-write-deadlocks mm/filemap.c
--- a/mm/filemap.c~fix-pagecache-write-deadlocks
+++ a/mm/filemap.c
@@ -2133,11 +2133,12 @@ generic_file_buffered_write(struct kiocb
 			break;
 		}
 		if (likely(nr_segs == 1))
-			copied = filemap_copy_from_user(page, offset,
+			copied = filemap_copy_from_user_atomic(page, offset,
 							buf, bytes);
 		else
-			copied = filemap_copy_from_user_iovec(page, offset,
-						cur_iov, iov_offset, bytes);
+			copied = filemap_copy_from_user_iovec_atomic(page,
+						offset, cur_iov, iov_offset,
+						bytes);
 		flush_dcache_page(page);
 		status = a_ops->commit_write(file, page, offset, offset+bytes);
 		if (status == AOP_TRUNCATED_PAGE) {
diff -puN mm/filemap.h~fix-pagecache-write-deadlocks mm/filemap.h
--- a/mm/filemap.h~fix-pagecache-write-deadlocks
+++ a/mm/filemap.h
@@ -22,19 +22,19 @@ __filemap_copy_from_user_iovec_inatomic(
 
 /*
  * Copy as much as we can into the page and return the number of bytes which
- * were sucessfully copied.  If a fault is encountered then clear the page
- * out to (offset+bytes) and return the number of bytes which were copied.
+ * were sucessfully copied.  If a fault is encountered then return the number of
+ * bytes which were copied.
  *
- * NOTE: For this to work reliably we really want copy_from_user_inatomic_nocache
- * to *NOT* zero any tail of the buffer that it failed to copy.  If it does,
- * and if the following non-atomic copy succeeds, then there is a small window
- * where the target page contains neither the data before the write, nor the
- * data after the write (it contains zero).  A read at this time will see
- * data that is inconsistent with any ordering of the read and the write.
- * (This has been detected in practice).
+ * NOTE: For this to work reliably we really want
+ * copy_from_user_inatomic_nocache to *NOT* zero any tail of the buffer that it
+ * failed to copy.  If it does, and if the following non-atomic copy succeeds,
+ * then there is a small window where the target page contains neither the data
+ * before the write, nor the data after the write (it contains zero).  A read at
+ * this time will see data that is inconsistent with any ordering of the read
+ * and the write.  (This has been detected in practice).
  */
 static inline size_t
-filemap_copy_from_user(struct page *page, unsigned long offset,
+filemap_copy_from_user_atomic(struct page *page, unsigned long offset,
 			const char __user *buf, unsigned bytes)
 {
 	char *kaddr;
@@ -53,14 +53,28 @@ filemap_copy_from_user(struct page *page
 	return bytes - left;
 }
 
+static inline size_t
+filemap_copy_from_user_nonatomic(struct page *page, unsigned long offset,
+			const char __user *buf, unsigned bytes)
+{
+	int left;
+	char *kaddr;
+
+	kaddr = kmap(page);
+	left = __copy_from_user_nocache(kaddr + offset, buf, bytes);
+	kunmap(page);
+	return bytes - left;
+}
+
 /*
- * This has the same sideeffects and return value as filemap_copy_from_user().
+ * This has the same sideeffects and return value as
+ * filemap_copy_from_user_atomic().
  * The difference is that on a fault we need to memset the remainder of the
  * page (out to offset+bytes), to emulate filemap_copy_from_user()'s
  * single-segment behaviour.
  */
 static inline size_t
-filemap_copy_from_user_iovec(struct page *page, unsigned long offset,
+filemap_copy_from_user_iovec_atomic(struct page *page, unsigned long offset,
 			const struct iovec *iov, size_t base, size_t bytes)
 {
 	char *kaddr;
@@ -70,14 +84,29 @@ filemap_copy_from_user_iovec(struct page
 	copied = __filemap_copy_from_user_iovec_inatomic(kaddr + offset, iov,
 							 base, bytes);
 	kunmap_atomic(kaddr, KM_USER0);
-	if (copied != bytes) {
-		kaddr = kmap(page);
-		copied = __filemap_copy_from_user_iovec_inatomic(kaddr + offset, iov,
-								 base, bytes);
-		if (bytes - copied)
-			memset(kaddr + offset + copied, 0, bytes - copied);
-		kunmap(page);
-	}
+	return copied;
+}
+
+/*
+ * This has the same sideeffects and return value as
+ * filemap_copy_from_user_nonatomic().
+ * The difference is that on a fault we need to memset the remainder of the
+ * page (out to offset+bytes), to emulate filemap_copy_from_user_nonatomic()'s
+ * single-segment behaviour.
+ */
+static inline size_t
+filemap_copy_from_user_iovec_nonatomic(struct page *page, unsigned long offset,
+			const struct iovec *iov, size_t base, size_t bytes)
+{
+	char *kaddr;
+	size_t copied;
+
+	kaddr = kmap(page);
+	copied = __filemap_copy_from_user_iovec_inatomic(kaddr + offset, iov,
+							 base, bytes);
+	if (bytes - copied)
+		memset(kaddr + offset + copied, 0, bytes - copied);
+	kunmap(page);
 	return copied;
 }
 
_

