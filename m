Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261332AbTISFyI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 01:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbTISFyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 01:54:08 -0400
Received: from fw.osdl.org ([65.172.181.6]:19657 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261332AbTISFxx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 01:53:53 -0400
Date: Thu, 18 Sep 2003 22:54:50 -0700
From: Andrew Morton <akpm@osdl.org>
To: Hugang <hugang@soulinfo.com>
Cc: linux-kernel@vger.kernel.org, Suparna Bhattacharya <suparna@in.ibm.com>,
       Badari Pulavarty <pbadari@us.ibm.com>
Subject: Re: use O_DIRECT open file, when read will hang.
Message-Id: <20030918225450.3d6bb72c.akpm@osdl.org>
In-Reply-To: <20030919124631.3b4e6301.hugang@soulinfo.com>
References: <20030919124631.3b4e6301.hugang@soulinfo.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugang <hugang@soulinfo.com> wrote:
>
> Hello all:
> 
> Steps to reproduce:
> 
> rm -f /tmp/1.log
> touch /tmp/1.log
> echo << EOF > /tmp/hang.c 
> #include <sys/types.h>
> #include <asm/fcntl.h>
> 
> main()
> {
>         int i;
>         char buf[1025];
> 
>         i = open("/tmp/1.log", O_RDONLY | 040000, 0);
>         if ( i != -1) {
>                 read(i, buf, 1);
>         }
>         printf("'%s'", buf);
> }
> EOF
> gcc -o /tmp/hang /tmp/hang.c
> /tmp/hang

This is due to O_DIRECT-race-fixes.patch forgetting to drop locks
on error paths all over the place.

I think this patch plugs them all for block-based direct-io, but it needs
checking.

There's also the little matter of (say) NFS direct-io which doesn't go
through fs/direct-io.c at all; it will deadlock in a jiffy.

Must say that I am getting very concerned about the general state of the IO
paths in the -mm kernel.


 fs/direct-io.c |   20 +++++++++++++-------
 mm/filemap.c   |   15 ++++++++++-----
 2 files changed, 23 insertions(+), 12 deletions(-)

diff -puN fs/direct-io.c~O_DIRECT-race-fixes-fixes-2 fs/direct-io.c
--- 25/fs/direct-io.c~O_DIRECT-race-fixes-fixes-2	2003-09-18 22:33:26.000000000 -0700
+++ 25-akpm/fs/direct-io.c	2003-09-18 22:47:13.000000000 -0700
@@ -858,18 +858,15 @@ out:
 static int
 direct_io_worker(int rw, struct kiocb *iocb, struct inode *inode, 
 	const struct iovec *iov, loff_t offset, unsigned long nr_segs, 
-	unsigned blkbits, get_blocks_t get_blocks, dio_iodone_t end_io)
+	unsigned blkbits, get_blocks_t get_blocks, dio_iodone_t end_io,
+	struct dio *dio)
 {
 	unsigned long user_addr; 
 	int seg;
 	int ret = 0;
 	int ret2;
-	struct dio *dio;
 	size_t bytes;
 
-	dio = kmalloc(sizeof(*dio), GFP_KERNEL);
-	if (!dio)
-		return -ENOMEM;
 	dio->is_async = !is_sync_kiocb(iocb);
 
 	dio->bio = NULL;
@@ -1016,6 +1013,7 @@ blockdev_direct_IO(int rw, struct kiocb 
 	unsigned bdev_blkbits = 0;
 	unsigned blocksize_mask = (1 << blkbits) - 1;
 	ssize_t retval = -EINVAL;
+	struct dio *dio;
 
 	if (bdev)
 		bdev_blkbits = blksize_bits(bdev_hardsect_size(bdev));
@@ -1041,8 +1039,16 @@ blockdev_direct_IO(int rw, struct kiocb 
 		}
 	}
 
-	retval = direct_io_worker(rw, iocb, inode, iov, offset, 
-				nr_segs, blkbits, get_blocks, end_io);
+	dio = kmalloc(sizeof(*dio), GFP_KERNEL);
+	retval = -ENOMEM;
+	if (!dio)
+		goto out;
+
+	return direct_io_worker(rw, iocb, inode, iov, offset,
+				nr_segs, blkbits, get_blocks, end_io, dio);
 out:
+	up(&inode->i_sem);
+	if (S_ISREG(inode->i_mode))
+		up_read(&inode->i_alloc_sem);
 	return retval;
 }
diff -puN mm/filemap.c~O_DIRECT-race-fixes-fixes-2 mm/filemap.c
--- 25/mm/filemap.c~O_DIRECT-race-fixes-fixes-2	2003-09-18 22:42:49.000000000 -0700
+++ 25-akpm/mm/filemap.c	2003-09-18 22:51:30.000000000 -0700
@@ -886,12 +886,12 @@ __generic_file_aio_read(struct kiocb *io
 		retval = 0;
 		if (!count)
 			goto out; /* skip atime */
-		if (S_ISREG(inode->i_mode)) {
-			down_read(&inode->i_alloc_sem);
-			down(&inode->i_sem);
-		}
 		size = i_size_read(inode);
 		if (pos < size) {
+			if (S_ISREG(inode->i_mode)) {
+				down_read(&inode->i_alloc_sem);
+				down(&inode->i_sem);
+			}
 			retval = generic_file_direct_IO(READ, iocb,
 						iov, pos, nr_segs);
 			if (retval >= 0 && !is_sync_kiocb(iocb))
@@ -2176,7 +2176,8 @@ generic_file_direct_IO(int rw, struct ki
 	loff_t offset, unsigned long nr_segs)
 {
 	struct file *file = iocb->ki_filp;
-	struct address_space *mapping = file->f_dentry->d_inode->i_mapping;
+	struct inode *inode = file->f_dentry->d_inode;
+	struct address_space *mapping = inode->i_mapping;
 	ssize_t retval;
 
 	if (mapping->nrpages) {
@@ -2190,6 +2191,10 @@ generic_file_direct_IO(int rw, struct ki
 	retval = mapping->a_ops->direct_IO(rw, iocb, iov, offset, nr_segs);
 	if (rw == WRITE && mapping->nrpages)
 		invalidate_inode_pages2(mapping);
+	return retval;
 out:
+	up(&inode->i_sem);
+	if (S_ISREG(inode->i_mode))
+		up_read(&inode->i_alloc_sem);
 	return retval;
 }

_

