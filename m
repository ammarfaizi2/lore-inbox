Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262885AbTDAWVB>; Tue, 1 Apr 2003 17:21:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262886AbTDAWVB>; Tue, 1 Apr 2003 17:21:01 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:13404 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id <S262885AbTDAWUy>; Tue, 1 Apr 2003 17:20:54 -0500
Date: Tue, 1 Apr 2003 23:34:15 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: Christoph Rohland <cr@sap.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] tmpfs 4/6 use mark_page_accessed
In-Reply-To: <Pine.LNX.4.44.0304012328390.1730-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0304012333220.1730-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tmpfs pages should be surfing the LRUs in the company of their filemap
friends: I was expecting the rules to change, but they've been stable
so long, let's sprinkle mark_page_accessed in the equivalent places
here; but (don't ask me why) SetPageReferenced in shmem_file_write.
Ooh, and shmem_populate was missing a flush_page_to_ram.

--- tmpfs3/mm/shmem.c	Tue Apr  1 21:35:10 2003
+++ tmpfs4/mm/shmem.c	Tue Apr  1 21:35:21 2003
@@ -951,6 +951,7 @@
 	if (error)
 		return (error == -ENOMEM)? NOPAGE_OOM: NOPAGE_SIGBUS;
 
+	mark_page_accessed(page);
 	flush_page_to_ram(page);
 	return page;
 }
@@ -978,6 +979,8 @@
 		if (err)
 			return err;
 		if (page) {
+			mark_page_accessed(page);
+			flush_page_to_ram(page);
 			err = install_page(mm, vma, addr, page, prot);
 			if (err) {
 				page_cache_release(page);
@@ -1192,6 +1195,8 @@
 			break;
 		}
 
+		if (!PageReferenced(page))
+			SetPageReferenced(page);
 		set_page_dirty(page);
 		page_cache_release(page);
 
@@ -1264,13 +1269,20 @@
 		}
 		nr -= offset;
 
-		/* If users can be writing to this page using arbitrary
-		 * virtual addresses, take care about potential aliasing
-		 * before reading the page on the kernel side.
-		 */
-		if (!list_empty(&mapping->i_mmap_shared) &&
-		    page != ZERO_PAGE(0))
-			flush_dcache_page(page);
+		if (page != ZERO_PAGE(0)) {
+			/*
+			 * If users can be writing to this page using arbitrary
+			 * virtual addresses, take care about potential aliasing
+			 * before reading the page on the kernel side.
+			 */
+			if (!list_empty(&mapping->i_mmap_shared))
+				flush_dcache_page(page);
+			/*
+			 * Mark the page accessed if we read the beginning.
+			 */
+			if (!offset)
+				mark_page_accessed(page);
+		}
 
 		/*
 		 * Ok, we have the page, and it's up-to-date, so
@@ -1523,6 +1535,7 @@
 		return res;
 	res = vfs_readlink(dentry, buffer, buflen, kmap(page));
 	kunmap(page);
+	mark_page_accessed(page);
 	page_cache_release(page);
 	return res;
 }
@@ -1535,6 +1548,7 @@
 		return res;
 	res = vfs_follow_link(nd, kmap(page));
 	kunmap(page);
+	mark_page_accessed(page);
 	page_cache_release(page);
 	return res;
 }

