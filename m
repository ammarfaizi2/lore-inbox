Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315419AbSFAIj6>; Sat, 1 Jun 2002 04:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315420AbSFAIjD>; Sat, 1 Jun 2002 04:39:03 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44810 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315416AbSFAIiZ>;
	Sat, 1 Jun 2002 04:38:25 -0400
Message-ID: <3CF888CB.FF93908E@zip.com.au>
Date: Sat, 01 Jun 2002 01:41:47 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 5/16] speed up writes
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Speeds up generic_file_write() by not calling mark_inode_dirty() when
the mtime and ctime didn't change.

There may be concerns over the fact that this restricts mtime and ctime
updates to one-second resolution.  But the interface doesn't support
that anyway - all the filesystem knows is that its dirty_inode()
superop was called.  It doesn't know why.

So filesystems which support high-resolution timestamps already need to
make their own arrangements.  We need an update_mtime i_op to support
those properly.

time to write a one megabyte file one-byte-at-a-time:

Before:
	ext3:		24.8 seconds
	ext2:		 4.9 seconds
	reiserfs:	17.0 seconds
After:
	ext3:		22.5 seconds
	ext2:		4.8  seconds
	reiserfs:	11.6 seconds

Not much improvement because we're also calling expensive
mark_inode_dirty() functions when i_size is expanded.  So compare the
overwrite case:

time dd if=/dev/zero of=foo bs=1 count=1M conv=notrunc

ext3 before:	20.0 seconds
ext3 after:	9.7  seconds


=====================================

--- 2.5.19/mm/filemap.c~mtime-speedup	Sat Jun  1 01:18:08 2002
+++ 2.5.19-akpm/mm/filemap.c	Sat Jun  1 01:18:08 2002
@@ -2098,6 +2098,7 @@ generic_file_write(struct file *file, co
 	ssize_t		written;
 	int		err;
 	unsigned	bytes;
+	time_t		time_now;
 
 	if (unlikely((ssize_t) count < 0))
 		return -EINVAL;
@@ -2195,9 +2196,12 @@ generic_file_write(struct file *file, co
 		goto out;
 
 	remove_suid(file->f_dentry);
-	inode->i_ctime = CURRENT_TIME;
-	inode->i_mtime = CURRENT_TIME;
-	mark_inode_dirty_sync(inode);
+	time_now = CURRENT_TIME;
+	if (inode->i_ctime != time_now || inode->i_mtime != time_now) {
+		inode->i_ctime = time_now;
+		inode->i_mtime = time_now;
+		mark_inode_dirty_sync(inode);
+	}
 
 	if (unlikely(file->f_flags & O_DIRECT)) {
 		written = generic_file_direct_IO(WRITE, file,

-
