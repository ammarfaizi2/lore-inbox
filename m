Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965116AbVIIJT5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965116AbVIIJT5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 05:19:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965117AbVIIJT5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 05:19:57 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:28839 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S965116AbVIIJT4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 05:19:56 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Fri, 9 Sep 2005 10:19:52 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 2/25] NTFS: Allow highmem kmalloc() in ntfs_malloc_nofs()
 and add _nofail() version.
In-Reply-To: <Pine.LNX.4.60.0509090950100.11051@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0509091019290.26845@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0509090950100.11051@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NTFS: Allow highmem kmalloc() in ntfs_malloc_nofs() and add _nofail() version.

- Modify fs/ntfs/malloc.h::ntfs_malloc_nofs() to do the kmalloc() based
  allocations with __GFP_HIGHMEM, analogous to how the vmalloc() based
  allocations are done.
- Add fs/ntfs/malloc.h::ntfs_malloc_nofs_nofail() which is analogous to
  ntfs_malloc_nofs() but it performs allocations with __GFP_NOFAIL and
  hence cannot fail.

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

---

 fs/ntfs/ChangeLog |    6 ++++++
 fs/ntfs/malloc.h  |   48 ++++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 48 insertions(+), 6 deletions(-)

06d0e3cf3d527f927681773c6ffbe697ccc5db7f
diff --git a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog
+++ b/fs/ntfs/ChangeLog
@@ -34,6 +34,12 @@ ToDo/Notes:
 	  journals with two different restart pages.  We sanity check both and
 	  either use the only sane one or the more recent one of the two in the
 	  case that both are valid.
+	- Modify fs/ntfs/malloc.h::ntfs_malloc_nofs() to do the kmalloc() based
+	  allocations with __GFP_HIGHMEM, analogous to how the vmalloc() based
+	  allocations are done.
+	- Add fs/ntfs/malloc.h::ntfs_malloc_nofs_nofail() which is analogous to
+	  ntfs_malloc_nofs() but it performs allocations with __GFP_NOFAIL and
+	  hence cannot fail.
 
 2.1.23 - Implement extension of resident files and make writing safe as well as
 	 many bug fixes, cleanups, and enhancements...
diff --git a/fs/ntfs/malloc.h b/fs/ntfs/malloc.h
--- a/fs/ntfs/malloc.h
+++ b/fs/ntfs/malloc.h
@@ -27,27 +27,63 @@
 #include <linux/highmem.h>
 
 /**
- * ntfs_malloc_nofs - allocate memory in multiples of pages
- * @size	number of bytes to allocate
+ * __ntfs_malloc - allocate memory in multiples of pages
+ * @size:	number of bytes to allocate
+ * @gfp_mask:	extra flags for the allocator
+ *
+ * Internal function.  You probably want ntfs_malloc_nofs()...
  *
  * Allocates @size bytes of memory, rounded up to multiples of PAGE_SIZE and
  * returns a pointer to the allocated memory.
  *
  * If there was insufficient memory to complete the request, return NULL.
+ * Depending on @gfp_mask the allocation may be guaranteed to succeed.
  */
-static inline void *ntfs_malloc_nofs(unsigned long size)
+static inline void *__ntfs_malloc(unsigned long size,
+		unsigned int __nocast gfp_mask)
 {
 	if (likely(size <= PAGE_SIZE)) {
 		BUG_ON(!size);
 		/* kmalloc() has per-CPU caches so is faster for now. */
-		return kmalloc(PAGE_SIZE, GFP_NOFS);
-		/* return (void *)__get_free_page(GFP_NOFS | __GFP_HIGHMEM); */
+		return kmalloc(PAGE_SIZE, gfp_mask);
+		/* return (void *)__get_free_page(gfp_mask); */
 	}
 	if (likely(size >> PAGE_SHIFT < num_physpages))
-		return __vmalloc(size, GFP_NOFS | __GFP_HIGHMEM, PAGE_KERNEL);
+		return __vmalloc(size, gfp_mask, PAGE_KERNEL);
 	return NULL;
 }
 
+/**
+ * ntfs_malloc_nofs - allocate memory in multiples of pages
+ * @size:	number of bytes to allocate
+ *
+ * Allocates @size bytes of memory, rounded up to multiples of PAGE_SIZE and
+ * returns a pointer to the allocated memory.
+ *
+ * If there was insufficient memory to complete the request, return NULL.
+ */
+static inline void *ntfs_malloc_nofs(unsigned long size)
+{
+	return __ntfs_malloc(size, GFP_NOFS | __GFP_HIGHMEM);
+}
+
+/**
+ * ntfs_malloc_nofs_nofail - allocate memory in multiples of pages
+ * @size:	number of bytes to allocate
+ *
+ * Allocates @size bytes of memory, rounded up to multiples of PAGE_SIZE and
+ * returns a pointer to the allocated memory.
+ *
+ * This function guarantees that the allocation will succeed.  It will sleep
+ * for as long as it takes to complete the allocation.
+ *
+ * If there was insufficient memory to complete the request, return NULL.
+ */
+static inline void *ntfs_malloc_nofs_nofail(unsigned long size)
+{
+	return __ntfs_malloc(size, GFP_NOFS | __GFP_HIGHMEM | __GFP_NOFAIL);
+}
+
 static inline void ntfs_free(void *addr)
 {
 	if (likely(((unsigned long)addr < VMALLOC_START) ||
