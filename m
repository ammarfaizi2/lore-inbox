Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262514AbSJAVs2>; Tue, 1 Oct 2002 17:48:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262521AbSJAVs2>; Tue, 1 Oct 2002 17:48:28 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:39740 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id <S262514AbSJAVsW>; Tue, 1 Oct 2002 17:48:22 -0400
Date: Tue, 1 Oct 2002 22:54:37 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: Christoph Rohland <cr@sap.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] tmpfs 8/9 misc trivia
In-Reply-To: <Pine.LNX.4.44.0210012240470.2602-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0210012253210.2602-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If PAGE_CACHE_SIZE were to differ from PAGE_SIZE, the VM_ACCT macro,
and shmem_nopage's vm_pgoff manipulation, were still not quite right.

Slip a cond_resched_lock into shmem_truncate's long loop; but not into
shmem_unuse_inode's, since other locks held, and swapoff awful anyway.

Move SetPageUptodate to where it's not already set.  Replace
copy_from_user by __copy_from_user since access already verified.

Replace BUG()s by BUG_ON()s.  Remove an uninteresting PAGE_BUG().

--- tmpfs7/mm/shmem.c	Tue Oct  1 19:49:24 2002
+++ tmpfs8/mm/shmem.c	Tue Oct  1 19:49:29 2002
@@ -43,7 +43,7 @@
 #define SHMEM_MAX_INDEX  (SHMEM_NR_DIRECT + (ENTRIES_PER_PAGEPAGE/2) * (ENTRIES_PER_PAGE+1))
 #define SHMEM_MAX_BYTES  ((unsigned long long)SHMEM_MAX_INDEX << PAGE_CACHE_SHIFT)
 
-#define VM_ACCT(size)    (((size) + PAGE_CACHE_SIZE - 1) >> PAGE_SHIFT)
+#define VM_ACCT(size)    (PAGE_CACHE_ALIGN(size) >> PAGE_SHIFT)
 
 /* Pretend that each entry is of this size in directory's i_size */
 #define BOGO_DIRENT_SIZE 20
@@ -428,6 +428,7 @@
 				info->alloced++;
 			}
 			empty = subdir;
+			cond_resched_lock(&info->lock);
 			dir = shmem_dir_map(subdir);
 		}
 		subdir = *dir;
@@ -657,10 +658,8 @@
 	unsigned long index;
 	struct inode *inode;
 
-	if (!PageLocked(page))
-		BUG();
-	if (page_mapped(page))
-		BUG();
+	BUG_ON(!PageLocked(page));
+	BUG_ON(page_mapped(page));
 
 	mapping = page->mapping;
 	index = page->index;
@@ -675,10 +674,8 @@
 	spin_lock(&info->lock);
 	shmem_recalc_inode(inode);
 	entry = shmem_swp_entry(info, index, NULL);
-	if (!entry)
-		BUG();
-	if (entry->val)
-		BUG();
+	BUG_ON(!entry);
+	BUG_ON(entry->val);
 
 	if (move_to_swap_cache(page, swap) == 0) {
 		shmem_swp_set(info, entry, swap.val);
@@ -852,10 +849,10 @@
 		info->alloced++;
 		spin_unlock(&info->lock);
 		clear_highpage(page);
+		SetPageUptodate(page);
 	}
 
 	/* We have the page */
-	SetPageUptodate(page);
 	*pagep = page;
 	return 0;
 }
@@ -896,8 +893,9 @@
 	unsigned long idx;
 	int error;
 
-	idx = (address - vma->vm_start) >> PAGE_CACHE_SHIFT;
+	idx = (address - vma->vm_start) >> PAGE_SHIFT;
 	idx += vma->vm_pgoff;
+	idx >>= PAGE_CACHE_SHIFT - PAGE_SHIFT;
 
 	if (((loff_t) idx << PAGE_CACHE_SHIFT) >= inode->i_size)
 		return NOPAGE_SIGBUS;
@@ -1118,13 +1116,8 @@
 		if (status)
 			break;
 
-		/* We have exclusive IO access to the page.. */
-		if (!PageLocked(page)) {
-			PAGE_BUG(page);
-		}
-
 		kaddr = kmap(page);
-		status = copy_from_user(kaddr+offset, buf, bytes);
+		status = __copy_from_user(kaddr+offset, buf, bytes);
 		kunmap(page);
 		if (status)
 			goto fail_write;

