Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964917AbVKGRqU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964917AbVKGRqU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 12:46:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964919AbVKGRqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 12:46:20 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:57609 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S964917AbVKGRqS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 12:46:18 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 7/6] fat: Support a truncate() for expanding size
References: <87hdaotlci.fsf@devron.myhome.or.jp>
	<87d5lctl5y.fsf@devron.myhome.or.jp>
	<878xw0tl3r.fsf_-_@devron.myhome.or.jp>
	<874q6otl0q.fsf_-_@devron.myhome.or.jp>
	<87zmogs6cs.fsf_-_@devron.myhome.or.jp>
	<87vez4s6b7.fsf_-_@devron.myhome.or.jp>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 08 Nov 2005 02:46:11 +0900
In-Reply-To: <87vez4s6b7.fsf_-_@devron.myhome.or.jp> (OGAWA Hirofumi's message of "Tue, 08 Nov 2005 02:42:36 +0900")
Message-ID: <87r79ss658.fsf_-_@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/fat/file.c |   67 +++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 64 insertions(+), 3 deletions(-)

diff -puN fs/fat/file.c~fat_support-expand-truncate fs/fat/file.c
--- linux-2.6.14/fs/fat/file.c~fat_support-expand-truncate	2005-11-07 03:59:07.000000000 +0900
+++ linux-2.6.14-hirofumi/fs/fat/file.c	2005-11-07 03:59:07.000000000 +0900
@@ -11,6 +11,7 @@
 #include <linux/msdos_fs.h>
 #include <linux/smp_lock.h>
 #include <linux/buffer_head.h>
+#include <linux/writeback.h>
 
 int fat_generic_ioctl(struct inode *inode, struct file *filp,
 		      unsigned int cmd, unsigned long arg)
@@ -124,6 +125,60 @@ struct file_operations fat_file_operatio
 	.sendfile	= generic_file_sendfile,
 };
 
+static int fat_cont_expand(struct inode *inode, loff_t size)
+{
+	struct address_space *mapping = inode->i_mapping;
+	struct page *page;
+	unsigned long index, limit;
+	loff_t count, pos, start;
+	unsigned int from, to;
+	int err;
+
+	err = -EFBIG;
+	limit = current->signal->rlim[RLIMIT_FSIZE].rlim_cur;
+	if (limit != RLIM_INFINITY && size > (loff_t)limit) {
+		send_sig(SIGXFSZ, current, 0);
+		goto out;
+	}
+	if (size > inode->i_sb->s_maxbytes)
+		goto out;
+
+	start = inode->i_size;
+	count = size - inode->i_size;
+	/* calculate the stuff of last page */
+	pos = size - 1;
+	index = pos >> PAGE_CACHE_SHIFT;
+	from = to = (pos & (PAGE_CACHE_SIZE - 1)) + 1;
+
+	err = -ENOMEM;
+	page = grab_cache_page(mapping, index);
+	if (!page)
+		goto out;
+	err = mapping->a_ops->prepare_write(NULL, page, from, to);
+	if (unlikely(err)) {
+		/*
+		 * ->prepare_write() may have instantiated a few blocks
+		 * outside i_size.  Trim these off again.
+		 */
+		unlock_page(page);
+		page_cache_release(page);
+		vmtruncate(inode, inode->i_size);
+		goto out;
+	}
+
+	err = mapping->a_ops->commit_write(NULL, page, from, to);
+
+	unlock_page(page);
+	page_cache_release(page);
+
+	inode->i_ctime = inode->i_mtime = CURRENT_TIME_SEC;
+	mark_inode_dirty(inode);
+	if (!err && IS_SYNC(inode))
+		err = sync_page_range_nolock(inode, mapping, start, count);
+out:
+	return err;
+}
+
 int fat_notify_change(struct dentry *dentry, struct iattr *attr)
 {
 	struct msdos_sb_info *sbi = MSDOS_SB(dentry->d_sb);
@@ -132,11 +187,17 @@ int fat_notify_change(struct dentry *den
 
 	lock_kernel();
 
-	/* FAT cannot truncate to a longer file */
+	/*
+	 * Expand the file. Since inode_setattr() updates ->i_size
+	 * before calling the ->truncate(), but FAT needs to fill the
+	 * hole before it.
+	 */
 	if (attr->ia_valid & ATTR_SIZE) {
 		if (attr->ia_size > inode->i_size) {
-			error = -EPERM;
-			goto out;
+			error = fat_cont_expand(inode, attr->ia_size);
+			if (error || attr->ia_valid == ATTR_SIZE)
+				goto out;
+			attr->ia_valid &= ~ATTR_SIZE;
 		}
 	}
 
_
