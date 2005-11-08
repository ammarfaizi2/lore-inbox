Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964971AbVKHUkp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964971AbVKHUkp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 15:40:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965094AbVKHUkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 15:40:45 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:64527 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S964971AbVKHUko
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 15:40:44 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/6] fat: Support a truncate() for expanding size
References: <87hdaotlci.fsf@devron.myhome.or.jp>
	<87d5lctl5y.fsf@devron.myhome.or.jp>
	<878xw0tl3r.fsf_-_@devron.myhome.or.jp>
	<874q6otl0q.fsf_-_@devron.myhome.or.jp>
	<87zmogs6cs.fsf_-_@devron.myhome.or.jp>
	<87vez4s6b7.fsf_-_@devron.myhome.or.jp>
	<87r79ss658.fsf_-_@devron.myhome.or.jp>
	<20051107170626.4d08e8d6.akpm@osdl.org>
	<87ek5rx1ur.fsf@devron.myhome.or.jp>
	<20051107201934.4c01a472.akpm@osdl.org>
	<874q6nww63.fsf@devron.myhome.or.jp>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 09 Nov 2005 05:40:32 +0900
In-Reply-To: <874q6nww63.fsf@devron.myhome.or.jp> (OGAWA Hirofumi's message of "Tue, 08 Nov 2005 14:22:44 +0900")
Message-ID: <87oe4una9r.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> writes:

>> -int generic_cont_expand(struct inode *inode, loff_t size)
>> +static int __generic_cont_expand(struct inode *inode, loff_t size, int dont_do_that)
>>  {
>>  	struct address_space *mapping = inode->i_mapping;
>>  	struct page *page;
>> @@ -2182,9 +2182,8 @@ int generic_cont_expand(struct inode *in
>>  	** skip the prepare.  make sure we never send an offset for the start
>>  	** of a block
>>  	*/
>> -	if ((offset & (inode->i_sb->s_blocksize - 1)) == 0) {
>> +	if (!dont_do_that &&  (offset & (inode->i_sb->s_blocksize - 1)) == 0)
>>  		offset++;
>
> Yes. But, if size is the page boundary, index is different.
>
> Probably something like the below. And I'd like to do vmtruncate()
> if ->prepare_write() returns a error. The sync_page_range_nolock()
> can do by caller, so not necessary.
>
> Hmm, I'll rethink this at tonight (10 hours later), the result may be
> same after all though.

How about this patch? If ok, please replace

fat-support-a-truncate-for-expanding-size.patch

with this.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>



[PATCH] fat: Support a truncate() for expanding size (generic_cont_expand)

This patch changes generic_cont_expand(), in order to share the code
with fatfs.

  - Use vmtruncate() if ->prepare_write() returns a error.

Even if ->prepare_write() returns an error, it may already have added some
blocks. So, this truncates blocks outside of ->i_size by vmtruncate().

  - Add generic_cont_expand_simple().

The generic_cont_expand_simple() assumes that ->prepare_write() can handle
the block boundary. With this, we don't need to care the extra byte.


And for expanding a file size by truncate(), fatfs uses the
added generic_cont_expand_simple().

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/buffer.c                 |   60 +++++++++++++++++++++++++++++++++-----------
 fs/fat/file.c               |   31 ++++++++++++++++++++--
 include/linux/buffer_head.h |    3 +-
 3 files changed, 76 insertions(+), 18 deletions(-)

diff -puN fs/fat/file.c~fat_support-expand-truncate fs/fat/file.c
--- linux-2.6.14/fs/fat/file.c~fat_support-expand-truncate	2005-11-07 23:03:02.000000000 +0900
+++ linux-2.6.14-hirofumi/fs/fat/file.c	2005-11-09 04:00:53.000000000 +0900
@@ -11,6 +11,7 @@
 #include <linux/msdos_fs.h>
 #include <linux/smp_lock.h>
 #include <linux/buffer_head.h>
+#include <linux/writeback.h>
 
 int fat_generic_ioctl(struct inode *inode, struct file *filp,
 		      unsigned int cmd, unsigned long arg)
@@ -124,6 +125,24 @@ struct file_operations fat_file_operatio
 	.sendfile	= generic_file_sendfile,
 };
 
+static int fat_cont_expand(struct inode *inode, loff_t size)
+{
+	struct address_space *mapping = inode->i_mapping;
+	loff_t start = inode->i_size, count = size - inode->i_size;
+	int err;
+
+	err = generic_cont_expand_simple(inode, size);
+	if (err)
+		goto out;
+
+	inode->i_ctime = inode->i_mtime = CURRENT_TIME_SEC;
+	mark_inode_dirty(inode);
+	if (IS_SYNC(inode))
+		err = sync_page_range_nolock(inode, mapping, start, count);
+out:
+	return err;
+}
+
 int fat_notify_change(struct dentry *dentry, struct iattr *attr)
 {
 	struct msdos_sb_info *sbi = MSDOS_SB(dentry->d_sb);
@@ -132,11 +151,17 @@ int fat_notify_change(struct dentry *den
 
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
 
diff -puN fs/buffer.c~fat_support-expand-truncate fs/buffer.c
--- linux-2.6.14/fs/buffer.c~fat_support-expand-truncate	2005-11-09 03:35:10.000000000 +0900
+++ linux-2.6.14-hirofumi/fs/buffer.c	2005-11-09 04:33:29.000000000 +0900
@@ -2160,11 +2160,12 @@ int block_read_full_page(struct page *pa
  * truncates.  Uses prepare/commit_write to allow the filesystem to
  * deal with the hole.  
  */
-int generic_cont_expand(struct inode *inode, loff_t size)
+static int __generic_cont_expand(struct inode *inode, loff_t size,
+				 pgoff_t index, unsigned int offset)
 {
 	struct address_space *mapping = inode->i_mapping;
 	struct page *page;
-	unsigned long index, offset, limit;
+	unsigned long limit;
 	int err;
 
 	err = -EFBIG;
@@ -2176,24 +2177,24 @@ int generic_cont_expand(struct inode *in
 	if (size > inode->i_sb->s_maxbytes)
 		goto out;
 
-	offset = (size & (PAGE_CACHE_SIZE-1)); /* Within page */
-
-	/* ugh.  in prepare/commit_write, if from==to==start of block, we 
-	** skip the prepare.  make sure we never send an offset for the start
-	** of a block
-	*/
-	if ((offset & (inode->i_sb->s_blocksize - 1)) == 0) {
-		offset++;
-	}
-	index = size >> PAGE_CACHE_SHIFT;
 	err = -ENOMEM;
 	page = grab_cache_page(mapping, index);
 	if (!page)
 		goto out;
 	err = mapping->a_ops->prepare_write(NULL, page, offset, offset);
-	if (!err) {
-		err = mapping->a_ops->commit_write(NULL, page, offset, offset);
+	if (err) {
+		/*
+		 * ->prepare_write() may have instantiated a few blocks
+		 * outside i_size.  Trim these off again.
+		 */
+		unlock_page(page);
+		page_cache_release(page);
+		vmtruncate(inode, inode->i_size);
+		goto out;
 	}
+
+	err = mapping->a_ops->commit_write(NULL, page, offset, offset);
+
 	unlock_page(page);
 	page_cache_release(page);
 	if (err > 0)
@@ -2202,6 +2203,36 @@ out:
 	return err;
 }
 
+int generic_cont_expand(struct inode *inode, loff_t size)
+{
+	pgoff_t index;
+	unsigned int offset;
+
+	offset = (size & (PAGE_CACHE_SIZE - 1)); /* Within page */
+
+	/* ugh.  in prepare/commit_write, if from==to==start of block, we
+	** skip the prepare.  make sure we never send an offset for the start
+	** of a block
+	*/
+	if ((offset & (inode->i_sb->s_blocksize - 1)) == 0) {
+		/* caller must handle this extra byte. */
+		offset++;
+	}
+	index = size >> PAGE_CACHE_SHIFT;
+
+	return __generic_cont_expand(inode, size, index, offset);
+}
+
+int generic_cont_expand_simple(struct inode *inode, loff_t size)
+{
+	loff_t pos = size - 1;
+	pgoff_t index = pos >> PAGE_CACHE_SHIFT;
+	unsigned int offset = (pos & (PAGE_CACHE_SIZE - 1)) + 1;
+
+	/* prepare/commit_write can handle even if from==to==start of block. */
+	return __generic_cont_expand(inode, size, index, offset);
+}
+
 /*
  * For moronic filesystems that do not allow holes in file.
  * We may have to extend the file.
@@ -3145,6 +3176,7 @@ EXPORT_SYMBOL(fsync_bdev);
 EXPORT_SYMBOL(generic_block_bmap);
 EXPORT_SYMBOL(generic_commit_write);
 EXPORT_SYMBOL(generic_cont_expand);
+EXPORT_SYMBOL(generic_cont_expand_simple);
 EXPORT_SYMBOL(init_buffer);
 EXPORT_SYMBOL(invalidate_bdev);
 EXPORT_SYMBOL(ll_rw_block);
diff -puN include/linux/buffer_head.h~fat_support-expand-truncate include/linux/buffer_head.h
--- linux-2.6.14/include/linux/buffer_head.h~fat_support-expand-truncate	2005-11-09 03:37:26.000000000 +0900
+++ linux-2.6.14-hirofumi/include/linux/buffer_head.h	2005-11-09 03:37:36.000000000 +0900
@@ -197,7 +197,8 @@ int block_read_full_page(struct page*, g
 int block_prepare_write(struct page*, unsigned, unsigned, get_block_t*);
 int cont_prepare_write(struct page*, unsigned, unsigned, get_block_t*,
 				loff_t *);
-int generic_cont_expand(struct inode *inode, loff_t size) ;
+int generic_cont_expand(struct inode *inode, loff_t size);
+int generic_cont_expand_simple(struct inode *inode, loff_t size);
 int block_commit_write(struct page *page, unsigned from, unsigned to);
 int block_sync_page(struct page *);
 sector_t generic_block_bmap(struct address_space *, sector_t, get_block_t *);
_
