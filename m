Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262381AbSJQXuJ>; Thu, 17 Oct 2002 19:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262390AbSJQXuJ>; Thu, 17 Oct 2002 19:50:09 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:22883 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id <S262381AbSJQXuE>; Thu, 17 Oct 2002 19:50:04 -0400
Date: Fri, 18 Oct 2002 00:56:55 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: Christoph Rohland <cr@sap.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] tmpfs 6/9 shmem_file_write update
In-Reply-To: <Pine.LNX.4.44.0210180042480.7220-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0210180055150.7220-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Checked shmem_file_write against recent filemap source, and against
2.4 and 2.4-ac: folded in missing fixes, mostly related to far file
positions.  Plus the new kmap_atomic copying technique.  But for now,
as before, no mark_page_accessed or SetPageReferenced in shmem.c: add
those, or whatever, later on when akpm has reviewed usage elsewhere.

--- tmpfs5/mm/shmem.c	Thu Oct 17 22:01:29 2002
+++ tmpfs6/mm/shmem.c	Thu Oct 17 22:01:39 2002
@@ -1062,12 +1062,46 @@
 			send_sig(SIGXFSZ, current, 0);
 			goto out;
 		}
-		if (count > limit - pos) {
+		if (pos > 0xFFFFFFFFULL || count > limit - (u32)pos) {
+			/* send_sig(SIGXFSZ, current, 0); */
+			count = limit - (u32)pos;
+		}
+	}
+
+	/*
+	 *	LFS rule
+	 */
+	if (pos + count > MAX_NON_LFS && !(file->f_flags&O_LARGEFILE)) {
+		if (pos >= MAX_NON_LFS) {
 			send_sig(SIGXFSZ, current, 0);
-			count = limit - pos;
+			goto out;
+		}
+		if (count > MAX_NON_LFS - (u32)pos) {
+			/* send_sig(SIGXFSZ, current, 0); */
+			count = MAX_NON_LFS - (u32)pos;
 		}
 	}
 
+	/*
+	 *	Are we about to exceed the fs block limit ?
+	 *
+	 *	If we have written data it becomes a short write
+	 *	If we have exceeded without writing data we send
+	 *	a signal and give them an EFBIG.
+	 *
+	 *	Linus frestrict idea will clean these up nicely..
+	 */
+	if (pos >= SHMEM_MAX_BYTES) {
+		if (count || pos > SHMEM_MAX_BYTES) {
+			send_sig(SIGXFSZ, current, 0);
+			err = -EFBIG;
+			goto out;
+		}
+		/* zero-length writes at ->s_maxbytes are OK */
+	}
+	if (pos + count > SHMEM_MAX_BYTES)
+		count = SHMEM_MAX_BYTES - pos;
+
 	status	= 0;
 	if (count) {
 		remove_suid(file->f_dentry);
@@ -1077,51 +1111,62 @@
 	while (count) {
 		unsigned long bytes, index, offset;
 		char *kaddr;
+		int left;
 
-		/*
-		 * Try to find the page in the cache. If it isn't there,
-		 * allocate a free page.
-		 */
 		offset = (pos & (PAGE_CACHE_SIZE -1)); /* Within page */
 		index = pos >> PAGE_CACHE_SHIFT;
 		bytes = PAGE_CACHE_SIZE - offset;
-		if (bytes > count) {
+		if (bytes > count)
 			bytes = count;
-		}
 
 		/*
 		 * We don't hold page lock across copy from user -
 		 * what would it guard against? - so no deadlock here.
+		 * But it still may be a good idea to prefault below.
 		 */
 
 		status = shmem_getpage(inode, index, &page, SGP_WRITE);
 		if (status)
 			break;
 
-		kaddr = kmap(page);
-		status = __copy_from_user(kaddr+offset, buf, bytes);
-		kunmap(page);
-		if (status)
-			goto fail_write;
-
+		left = bytes;
+		if (PageHighMem(page)) {
+			volatile unsigned char dummy;
+			__get_user(dummy, buf);
+			__get_user(dummy, buf + bytes - 1);
+
+			kaddr = kmap_atomic(page, KM_USER0);
+			left = __copy_from_user(kaddr + offset, buf, bytes);
+			kunmap_atomic(kaddr, KM_USER0);
+		}
+		if (left) {
+			kaddr = kmap(page);
+			left = __copy_from_user(kaddr + offset, buf, bytes);
+			kunmap(page);
+		}
 		flush_dcache_page(page);
-		if (bytes > 0) {
-			set_page_dirty(page);
-			written += bytes;
-			count -= bytes;
-			pos += bytes;
-			buf += bytes;
-			if (pos > inode->i_size)
-				inode->i_size = pos;
+		if (left) {
+			page_cache_release(page);
+			status = -EFAULT;
+			break;
 		}
-release:
+
+		set_page_dirty(page);
 		page_cache_release(page);
 
-		if (status < 0)
-			break;
+		/*
+		 * Balance dirty pages??
+		 */
+
+		written += bytes;
+		count -= bytes;
+		pos += bytes;
+		buf += bytes;
+		if (pos > inode->i_size)
+			inode->i_size = pos;
 	}
-	*ppos = pos;
 
+	*ppos = pos;
 	err = written ? written : status;
 out:
 	/* Short writes give back address space */
@@ -1130,10 +1175,6 @@
 out_nc:
 	up(&inode->i_sem);
 	return err;
-fail_write:
-	status = -EFAULT;
-	ClearPageUptodate(page);
-	goto release;
 }
 
 static void do_shmem_file_read(struct file *filp, loff_t *ppos, read_descriptor_t *desc, read_actor_t actor)
@@ -1407,9 +1448,9 @@
 		spin_lock(&shmem_ilock);
 		list_add_tail(&info->list, &shmem_inodes);
 		spin_unlock(&shmem_ilock);
-		kaddr = kmap(page);
+		kaddr = kmap_atomic(page, KM_USER0);
 		memcpy(kaddr, symname, len);
-		kunmap(page);
+		kunmap_atomic(kaddr, KM_USER0);
 		set_page_dirty(page);
 		page_cache_release(page);
 	}

