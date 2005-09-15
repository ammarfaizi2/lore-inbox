Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030335AbVIOMnb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030335AbVIOMnb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 08:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030341AbVIOMnb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 08:43:31 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:11019 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S1030335AbVIOMna
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 08:43:30 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: "Machida, Hiroyuki" <machida@sm.sony.co.jp>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2][FAT] miss-sync issues on sync mount (miss-sync on write)
References: <43288964.7020307@sm.sony.co.jp>
	<20050914194820.5bbddcb3.akpm@osdl.org>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Thu, 15 Sep 2005 21:43:12 +0900
In-Reply-To: <20050914194820.5bbddcb3.akpm@osdl.org> (Andrew Morton's message of "Wed, 14 Sep 2005 19:48:20 -0700")
Message-ID: <874q8my00v.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> "Machida, Hiroyuki" <machida@sm.sony.co.jp> wrote:
>>
>> This patch fixes miss-sync issue on write() system call.
>>  This updates inode attrs flags, mtime and ctime on every
>>  comit_write call, due to locking.
>
> This all seems wrong.
>
> Why does fatfs have file_operations.write pointing at do_sync_write()
> rather than generic_file_write()?
>
> Why does fatfs have a custom .aio_write() rather than using
> generic_file_aio_write()?
>
> If fatfs can use all the standard library functions, all this inode
> dirtying and O_SYNC/-o sync handling shoud just work.

In fat_file_aio_write:

	retval = generic_file_aio_write(iocb, buf, count, pos);
	if (retval > 0) {
		inode->i_mtime = inode->i_ctime = CURRENT_TIME_SEC;
		MSDOS_I(inode)->i_attrs |= ATTR_ARCH;
		mark_inode_dirty(inode);

He says about the above FAT specific flag and timestamp.  FAT needs to
add the ATTR_ARCH if data was modified, but current FAT is adding it
after generic_file_aio_write()/generic_file_writev(). (IIRC, some
other filesystems is also doing this.)

His patch seems good, although the some additional works was needed.
I applied the attached patch. Thanks, Hiroyuki-san.

Andrew, now fat_file_operations is the following. Is this OK?

struct file_operations fat_file_operations = {
	.llseek		= generic_file_llseek,
	.read		= do_sync_read,
	.write		= do_sync_write,
	.readv		= generic_file_readv,
	.writev		= generic_file_writev,
	.aio_read	= generic_file_aio_read,
	.aio_write	= generic_file_aio_write,
	.mmap		= generic_file_mmap,
	.ioctl		= fat_generic_ioctl,
	.fsync		= file_fsync,
	.sendfile	= generic_file_sendfile,
};
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>



[PATCH] FAT: miss-sync issues on sync mount (miss-sync on write)

This patch fixes miss-sync issue on write() system call.
This updates inode attrs flags, mtime and ctime on every
comit_write call, due to locking.

Signed-off-by: Hiroyuki Machida <machida@sm.sony.co.jp>
Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/fat/file.c  |   37 ++-----------------------------------
 fs/fat/inode.c |   15 ++++++++++++++-
 2 files changed, 16 insertions(+), 36 deletions(-)

diff -puN fs/fat/file.c~fat_arch-flags-fix fs/fat/file.c
--- linux-2.6.14-rc1/fs/fat/file.c~fat_arch-flags-fix	2005-09-15 20:52:21.000000000 +0900
+++ linux-2.6.14-rc1-hirofumi/fs/fat/file.c	2005-09-15 20:55:12.000000000 +0900
@@ -12,39 +12,6 @@
 #include <linux/smp_lock.h>
 #include <linux/buffer_head.h>
 
-static ssize_t fat_file_aio_write(struct kiocb *iocb, const char __user *buf,
-				  size_t count, loff_t pos)
-{
-	struct inode *inode = iocb->ki_filp->f_dentry->d_inode;
-	int retval;
-
-	retval = generic_file_aio_write(iocb, buf, count, pos);
-	if (retval > 0) {
-		inode->i_mtime = inode->i_ctime = CURRENT_TIME_SEC;
-		MSDOS_I(inode)->i_attrs |= ATTR_ARCH;
-		mark_inode_dirty(inode);
-//		check the locking rules
-//		if (IS_SYNC(inode))
-//			fat_sync_inode(inode);
-	}
-	return retval;
-}
-
-static ssize_t fat_file_writev(struct file *filp, const struct iovec *iov,
-			       unsigned long nr_segs, loff_t *ppos)
-{
-	struct inode *inode = filp->f_dentry->d_inode;
-	int retval;
-
-	retval = generic_file_writev(filp, iov, nr_segs, ppos);
-	if (retval > 0) {
-		inode->i_mtime = inode->i_ctime = CURRENT_TIME_SEC;
-		MSDOS_I(inode)->i_attrs |= ATTR_ARCH;
-		mark_inode_dirty(inode);
-	}
-	return retval;
-}
-
 int fat_generic_ioctl(struct inode *inode, struct file *filp,
 		      unsigned int cmd, unsigned long arg)
 {
@@ -148,9 +115,9 @@ struct file_operations fat_file_operatio
 	.read		= do_sync_read,
 	.write		= do_sync_write,
 	.readv		= generic_file_readv,
-	.writev		= fat_file_writev,
+	.writev		= generic_file_writev,
 	.aio_read	= generic_file_aio_read,
-	.aio_write	= fat_file_aio_write,
+	.aio_write	= generic_file_aio_write,
 	.mmap		= generic_file_mmap,
 	.ioctl		= fat_generic_ioctl,
 	.fsync		= file_fsync,
diff -puN fs/fat/inode.c~fat_arch-flags-fix fs/fat/inode.c
--- linux-2.6.14-rc1/fs/fat/inode.c~fat_arch-flags-fix	2005-09-15 20:52:21.000000000 +0900
+++ linux-2.6.14-rc1-hirofumi/fs/fat/inode.c	2005-09-15 21:32:51.000000000 +0900
@@ -102,6 +102,19 @@ static int fat_prepare_write(struct file
 				  &MSDOS_I(page->mapping->host)->mmu_private);
 }
 
+static int fat_commit_write(struct file *file, struct page *page,
+			    unsigned from, unsigned to)
+{
+	struct inode *inode = page->mapping->host;
+	int err = generic_commit_write(file, page, from, to);
+	if (!err && !(MSDOS_I(inode)->i_attrs & ATTR_ARCH)) {
+		inode->i_mtime = inode->i_ctime = CURRENT_TIME_SEC;
+		MSDOS_I(inode)->i_attrs |= ATTR_ARCH;
+		mark_inode_dirty(inode);
+	}
+	return err;
+}
+
 static sector_t _fat_bmap(struct address_space *mapping, sector_t block)
 {
 	return generic_block_bmap(mapping, block, fat_get_block);
@@ -112,7 +125,7 @@ static struct address_space_operations f
 	.writepage	= fat_writepage,
 	.sync_page	= block_sync_page,
 	.prepare_write	= fat_prepare_write,
-	.commit_write	= generic_commit_write,
+	.commit_write	= fat_commit_write,
 	.bmap		= _fat_bmap
 };
 
_
