Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318936AbSG1HYt>; Sun, 28 Jul 2002 03:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318935AbSG1HYE>; Sun, 28 Jul 2002 03:24:04 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59141 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318926AbSG1HVh>;
	Sun, 28 Jul 2002 03:21:37 -0400
Message-ID: <3D439E43.5F2DEE3D@zip.com.au>
Date: Sun, 28 Jul 2002 00:33:23 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 11/13] don't hold i_sem during O_DIRECT writes to blockdevs
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



We're moving in the direction of deprecating the raw driver and
recommending that applications use O_DIRECT reads and writes against
blockdevs.

I don't know how acceptable this will be - there may be
operational/admin reasons for preferring the raw driver, and there are
certainly application porting issues.  So we should continue to support
the raw driver well in 2.6.

One weakness which writes to blockdevs have wrt the raw driver is that
they are serialised under i_sem.  There is no need for this.

This patch changes O_DIRECT writes to blockdevs so that they no longer
run under i_sem.



 filemap.c |   71 ++++++++++++++++++++++++++++++++++++++------------------------
 1 files changed, 44 insertions(+), 27 deletions(-)

--- 2.5.29/mm/filemap.c~o_direct-i_sem	Sat Jul 27 23:39:13 2002
+++ 2.5.29-akpm/mm/filemap.c	Sat Jul 27 23:48:58 2002
@@ -1934,6 +1934,7 @@ generic_file_write(struct file *file, co
 	struct address_space_operations *a_ops = mapping->a_ops;
 	struct inode 	*inode = mapping->host;
 	unsigned long	limit = current->rlim[RLIMIT_FSIZE].rlim_cur;
+	int		isblk = S_ISBLK(inode->i_mode);
 	long		status = 0;
 	loff_t		pos;
 	struct page	*page;
@@ -1953,19 +1954,19 @@ generic_file_write(struct file *file, co
 	pos = *ppos;
 	if (unlikely(pos < 0)) {
 		err = -EINVAL;
-		goto out;
+		goto out_sem;
 	}
 
 	if (unlikely(file->f_error)) {
 		err = file->f_error;
 		file->f_error = 0;
-		goto out;
+		goto out_sem;
 	}
 
 	written = 0;
 
 	/* FIXME: this is for backwards compatibility with 2.4 */
-	if (!S_ISBLK(inode->i_mode) && file->f_flags & O_APPEND)
+	if (!isblk && file->f_flags & O_APPEND)
 		pos = inode->i_size;
 
 	/*
@@ -1975,7 +1976,7 @@ generic_file_write(struct file *file, co
 		if (pos >= limit) {
 			send_sig(SIGXFSZ, current, 0);
 			err = -EFBIG;
-			goto out;
+			goto out_sem;
 		}
 		if (pos > 0xFFFFFFFFULL || count > limit - (u32)pos) {
 			/* send_sig(SIGXFSZ, current, 0); */
@@ -1991,7 +1992,7 @@ generic_file_write(struct file *file, co
 		if (pos >= MAX_NON_LFS) {
 			send_sig(SIGXFSZ, current, 0);
 			err = -EFBIG;
-			goto out;
+			goto out_sem;
 		}
 		if (count > MAX_NON_LFS - (u32)pos) {
 			/* send_sig(SIGXFSZ, current, 0); */
@@ -2006,12 +2007,12 @@ generic_file_write(struct file *file, co
 	 * exceeded without writing data we send a signal and return EFBIG.
 	 * Linus frestrict idea will clean these up nicely..
 	 */
-	if (likely(!S_ISBLK(inode->i_mode))) {
+	if (likely(!isblk)) {
 		if (unlikely(pos >= inode->i_sb->s_maxbytes)) {
 			if (count || pos > inode->i_sb->s_maxbytes) {
 				send_sig(SIGXFSZ, current, 0);
 				err = -EFBIG;
-				goto out;
+				goto out_sem;
 			}
 			/* zero-length writes at ->s_maxbytes are OK */
 		}
@@ -2021,12 +2022,12 @@ generic_file_write(struct file *file, co
 	} else {
 		if (bdev_read_only(inode->i_bdev)) {
 			err = -EPERM;
-			goto out;
+			goto out_sem;
 		}
 		if (pos >= inode->i_size) {
 			if (count || pos > inode->i_size) {
 				err = -ENOSPC;
-				goto out;
+				goto out_sem;
 			}
 		}
 
@@ -2036,7 +2037,7 @@ generic_file_write(struct file *file, co
 
 	err = 0;
 	if (count == 0)
-		goto out;
+		goto out_sem;
 
 	remove_suid(file->f_dentry);
 	time_now = CURRENT_TIME;
@@ -2047,25 +2048,40 @@ generic_file_write(struct file *file, co
 	}
 
 	if (unlikely(file->f_flags & O_DIRECT)) {
-		written = generic_file_direct_IO(WRITE, inode,
+		if (isblk) {
+			up(&inode->i_sem);
+			written = generic_file_direct_IO(WRITE, inode,
 						(char *)buf, pos, count);
-		if (written > 0) {
-			loff_t end = pos + written;
-			if (end > inode->i_size && !S_ISBLK(inode->i_mode)) {
-				inode->i_size = end;
-				mark_inode_dirty(inode);
+			if (written > 0) {
+				if (mapping->nrpages)
+					invalidate_inode_pages2(mapping);
+				*ppos = pos + written;
 			}
-			*ppos = end;
-			if (mapping->nrpages)
-				invalidate_inode_pages2(mapping);
+			err = written;
+			goto out;
+		} else {
+			written = generic_file_direct_IO(WRITE, inode,
+						(char *)buf, pos, count);
+			if (written > 0) {
+				loff_t end = pos + written;
+				if (end > inode->i_size) {
+					inode->i_size = end;
+					mark_inode_dirty(inode);
+				}
+				*ppos = end;
+				/*
+				 * Sync the fs metadata but not the minor inode
+				 * changes and of course not the data as we did
+				 * direct DMA for the IO.
+				 */
+				if (file->f_flags & O_SYNC)
+					status = generic_osync_inode(inode,
+								OSYNC_METADATA);
+				if (mapping->nrpages)
+					invalidate_inode_pages2(mapping);
+			}
+			goto out_status;
 		}
-		/*
-		 * Sync the fs metadata but not the minor inode changes and
-		 * of course not the data as we did direct DMA for the IO.
-		 */
-		if (written >= 0 && file->f_flags & O_SYNC)
-			status = generic_osync_inode(inode, OSYNC_METADATA);
-		goto out_status;
 	}
 
 	do {
@@ -2152,7 +2168,8 @@ generic_file_write(struct file *file, co
 	
 out_status:	
 	err = written ? written : status;
-out:
+out_sem:
 	up(&inode->i_sem);
+out:
 	return err;
 }

.
