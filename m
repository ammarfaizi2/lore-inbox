Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262884AbTDAWRn>; Tue, 1 Apr 2003 17:17:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262885AbTDAWRn>; Tue, 1 Apr 2003 17:17:43 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:25140 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id <S262884AbTDAWRj>; Tue, 1 Apr 2003 17:17:39 -0500
Date: Tue, 1 Apr 2003 23:31:00 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: Christoph Rohland <cr@sap.com>, Oleg Drokin <green@namesys.com>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH] tmpfs 1/6 use generic_write_checks
Message-ID: <Pine.LNX.4.44.0304012328390.1730-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First of a suite of six patches to 2.5.66-mm2 tmpfs (mm/shmem.c):
 Documentation/filesystems/tmpfs.txt |   25 ++---
 mm/shmem.c                          |  162 ++++++++++++------------------------
 2 files changed, 66 insertions(+), 121 deletions(-)

tmpfs 1/6 use generic_write_checks
Blessings be upon the creator of generic_write_checks in filemap.c:
shmem_file_write call it instead of duplicating those tedious checks.

--- 2.5.66-mm2/mm/shmem.c	Tue Apr  1 11:25:50 2003
+++ tmpfs1/mm/shmem.c	Tue Apr  1 21:34:48 2003
@@ -1126,10 +1126,8 @@
 shmem_file_write(struct file *file, const char *buf, size_t count, loff_t *ppos)
 {
 	struct inode	*inode = file->f_dentry->d_inode;
-	unsigned long	limit = current->rlim[RLIMIT_FSIZE].rlim_cur;
 	loff_t		pos;
 	unsigned long	written;
-	long		status;
 	int		err;
 	loff_t		maxpos;
 
@@ -1142,88 +1140,25 @@
 	down(&inode->i_sem);
 
 	pos = *ppos;
-	err = -EINVAL;
-	if (pos < 0)
-		goto out_nc;
-
-	err = file->f_error;
-	if (err) {
-		file->f_error = 0;
-		goto out_nc;
-	}
-
 	written = 0;
 
-	if (file->f_flags & O_APPEND)
-		pos = inode->i_size;
+	err = generic_write_checks(inode, file, &pos, &count, 0);
+	if (err || !count)
+		goto out;
 
 	maxpos = inode->i_size;
-	if (pos + count > inode->i_size) {
+	if (maxpos < pos + count) {
 		maxpos = pos + count;
-		if (maxpos > SHMEM_MAX_BYTES)
-			maxpos = SHMEM_MAX_BYTES;
 		if (!vm_enough_memory(VM_ACCT(maxpos) - VM_ACCT(inode->i_size))) {
 			err = -ENOMEM;
-			goto out_nc;
-		}
-	}
-
-	/*
-	 * Check whether we've reached the file size limit.
-	 */
-	err = -EFBIG;
-	if (limit != RLIM_INFINITY) {
-		if (pos >= limit) {
-			send_sig(SIGXFSZ, current, 0);
-			goto out;
-		}
-		if (pos > 0xFFFFFFFFULL || count > limit - (u32)pos) {
-			/* send_sig(SIGXFSZ, current, 0); */
-			count = limit - (u32)pos;
-		}
-	}
-
-	/*
-	 *	LFS rule
-	 */
-	if (pos + count > MAX_NON_LFS && !(file->f_flags&O_LARGEFILE)) {
-		if (pos >= MAX_NON_LFS) {
-			send_sig(SIGXFSZ, current, 0);
 			goto out;
 		}
-		if (count > MAX_NON_LFS - (u32)pos) {
-			/* send_sig(SIGXFSZ, current, 0); */
-			count = MAX_NON_LFS - (u32)pos;
-		}
-	}
-
-	/*
-	 *	Are we about to exceed the fs block limit ?
-	 *
-	 *	If we have written data it becomes a short write
-	 *	If we have exceeded without writing data we send
-	 *	a signal and give them an EFBIG.
-	 *
-	 *	Linus frestrict idea will clean these up nicely..
-	 */
-	if (pos >= SHMEM_MAX_BYTES) {
-		if (count || pos > SHMEM_MAX_BYTES) {
-			send_sig(SIGXFSZ, current, 0);
-			err = -EFBIG;
-			goto out;
-		}
-		/* zero-length writes at ->s_maxbytes are OK */
 	}
-	if (pos + count > SHMEM_MAX_BYTES)
-		count = SHMEM_MAX_BYTES - pos;
 
-	status	= 0;
-	if (count) {
-		remove_suid(file->f_dentry);
-		inode->i_ctime = inode->i_mtime = CURRENT_TIME;
-	}
+	remove_suid(file->f_dentry);
+	inode->i_ctime = inode->i_mtime = CURRENT_TIME;
 
-	while (count) {
+	do {
 		struct page *page = NULL;
 		unsigned long bytes, index, offset;
 		char *kaddr;
@@ -1241,8 +1176,8 @@
 		 * But it still may be a good idea to prefault below.
 		 */
 
-		status = shmem_getpage(inode, index, &page, SGP_WRITE);
-		if (status)
+		err = shmem_getpage(inode, index, &page, SGP_WRITE);
+		if (err)
 			break;
 
 		left = bytes;
@@ -1263,7 +1198,7 @@
 		flush_dcache_page(page);
 		if (left) {
 			page_cache_release(page);
-			status = -EFAULT;
+			err = -EFAULT;
 			break;
 		}
 
@@ -1271,7 +1206,8 @@
 		page_cache_release(page);
 
 		/*
-		 * Balance dirty pages??
+		 * Our dirty pages are not counted in nr_dirty,
+		 * and we do not attempt to balance dirty pages.
 		 */
 
 		written += bytes;
@@ -1280,15 +1216,16 @@
 		buf += bytes;
 		if (pos > inode->i_size)
 			inode->i_size = pos;
-	}
+	} while (count);
 
 	*ppos = pos;
-	err = written ? written : status;
-out:
+	if (written)
+		err = written;
+
 	/* Short writes give back address space */
 	if (inode->i_size != maxpos)
 		vm_unacct_memory(VM_ACCT(maxpos) - VM_ACCT(inode->i_size));
-out_nc:
+out:
 	up(&inode->i_sem);
 	return err;
 }

