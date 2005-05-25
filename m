Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261491AbVEYS3v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261491AbVEYS3v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 14:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262386AbVEYS22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 14:28:28 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:3721 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262379AbVEYSKq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 14:10:46 -0400
Subject: Re: [RFC/PATCH 2/4] fs/mm: execute in place (3rd version)
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Carsten Otte <cotte@freenet.de>
Cc: suparna@in.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>, schwidefsky@de.ibm.com,
       Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>
In-Reply-To: <42933B7A.3060206@freenet.de>
References: <1116866094.12153.12.camel@cotte.boeblingen.de.ibm.com>
	 <1116869420.12153.32.camel@cotte.boeblingen.de.ibm.com>
	 <20050524093029.GA4390@in.ibm.com> <42930B64.2060105@freenet.de>
	 <20050524133211.GA4896@in.ibm.com>  <42933B7A.3060206@freenet.de>
Content-Type: multipart/mixed; boundary="=-I2dxChpRif6aO81CVtr5"
Organization: 
Message-Id: <1117043475.26913.1540.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 25 May 2005 10:51:17 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-I2dxChpRif6aO81CVtr5
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2005-05-24 at 07:34, Carsten Otte wrote:

> Maintenance effort is a good point. Changes would need to be applied
> to both versions, which don't differ too much today.
> Embedded folks will likely figure they also need the reverse path to
> return references (like put_xip_page()), and indication of required access
> (read/write) to make this work with flash chips.
> Therefore I guess those two versions to differ more in the future,
> making it hard to think about a soloution unifying the code paths
> in a sane way so that it will work out for flash in the end.
> As for me, I did not find a better one than in version one/two. If you
> figure a good one, I will be happy to work on its implementation.
> 

Hi,

This is my crude version of the cleanup patch to reduce the 
duplication of code.

Basically, I added __generic_file_aio_read_internal() and 
__generic_file_aio_write_nolock_internal() to take a read/write
handlers instead of defaulting to do_generic_file_read() or
generic_file_buffered_write().

This way I was able to reduce 129 lines of your code. 
This patch is on top of your current set and I haven't even
tried compiling it. Needs cleanup.

BTW, function & variable names are too long and/or ugly & doesn't 
make sense - need fixing.

Christoph/Suparna/Andrew, Comments ?

Thanks,
Badari








--=-I2dxChpRif6aO81CVtr5
Content-Disposition: attachment; filename=xip-filemap.patch
Content-Type: text/plain; name=xip-filemap.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

# diffstat /tmp/xip-filemap.patch
 filemap.c     |   27 +++++++++---
 filemap.h     |    6 ++
 filemap_xip.c |  129 +++-------------------------------------------------------
 3 files changed, 35 insertions(+), 127 deletions(-)

Signed-off-by: Badari Pulavarty <pbadari@us.ibm.com>
diff -X dontdiff -Narup linux-2.6.12-rc4/mm/filemap.c linux-2.6.12-rc4.xip/mm/filemap.c
--- linux-2.6.12-rc4/mm/filemap.c	2005-05-25 03:05:55.367260168 -0700
+++ linux-2.6.12-rc4.xip/mm/filemap.c	2005-05-25 03:07:15.805031768 -0700
@@ -988,8 +988,8 @@ success:
  * that can use the page cache directly.
  */
 ssize_t
-__generic_file_aio_read(struct kiocb *iocb, const struct iovec *iov,
-		unsigned long nr_segs, loff_t *ppos)
+__generic_file_aio_read_internal(struct kiocb *iocb, const struct iovec *iov,
+		unsigned long nr_segs, loff_t *ppos, file_read_t file_read)
 {
 	struct file *filp = iocb->ki_filp;
 	ssize_t retval;
@@ -1051,7 +1051,7 @@ __generic_file_aio_read(struct kiocb *io
 			if (desc.count == 0)
 				continue;
 			desc.error = 0;
-			do_generic_file_read(filp,ppos,&desc,file_read_actor);
+			file_read(filp,ppos,&desc,file_read_actor);
 			retval += desc.written;
 			if (!retval) {
 				retval = desc.error;
@@ -1063,6 +1063,13 @@ out:
 	return retval;
 }
 
+ssize_t
+__generic_file_aio_read(struct kiocb *iocb, const struct iovec *iov,
+		unsigned long nr_segs, loff_t *ppos)
+{
+	return __generic_file_aio_read_internal(iocb, iov, nr_segs, 
+				ppos, do_generic_file_read);
+}
 EXPORT_SYMBOL(__generic_file_aio_read);
 
 ssize_t
@@ -2024,8 +2031,9 @@ generic_file_buffered_write(struct kiocb
 EXPORT_SYMBOL(generic_file_buffered_write);
 
 ssize_t
-__generic_file_aio_write_nolock(struct kiocb *iocb, const struct iovec *iov,
-				unsigned long nr_segs, loff_t *ppos)
+__generic_file_aio_write_nolock_internal(struct kiocb *iocb, 
+	const struct iovec *iov, unsigned long nr_segs, loff_t *ppos,
+	file_write_t file_write)
 {
 	struct file *file = iocb->ki_filp;
 	struct address_space * mapping = file->f_mapping;
@@ -2093,12 +2101,19 @@ __generic_file_aio_write_nolock(struct k
 		count -= written;
 	}
 
-	written = generic_file_buffered_write(iocb, iov, nr_segs,
+	written = file_write(iocb, iov, nr_segs,
 			pos, ppos, count, written);
 out:
 	current->backing_dev_info = NULL;
 	return written ? written : err;
 }
+ssize_t
+__generic_file_aio_write_nolock(struct kiocb *iocb, const struct iovec *iov,
+				unsigned long nr_segs, loff_t *ppos)
+{
+	return __generic_file_aio_write_nolock_internal(iocb, *iov,
+			nr_segs, *ppos, generic_file_buffered_write);
+}
 EXPORT_SYMBOL(generic_file_aio_write_nolock);
 
 ssize_t
diff -X dontdiff -Narup linux-2.6.12-rc4/mm/filemap.h linux-2.6.12-rc4.xip/mm/filemap.h
--- linux-2.6.12-rc4/mm/filemap.h	2005-05-25 03:06:03.857969384 -0700
+++ linux-2.6.12-rc4.xip/mm/filemap.h	2005-05-25 03:08:09.388885784 -0700
@@ -15,6 +15,12 @@
 #include <linux/config.h>
 #include <asm/uaccess.h>
 
+typedef int (file_read_t)(struct file * filp, loff_t *ppos,
+		read_descriptor_t * desc, read_actor_t actor):
+typedef int (file_write_t)(struct kiocb *iocb, const struct iovec *iov,
+		unsigned long nr_segs, loff_t pos, loff_t *ppos,
+		size_t count, ssize_t written);
+
 extern size_t
 __filemap_copy_from_user_iovec(char *vaddr, 
 			       const struct iovec *iov,
diff -X dontdiff -Narup linux-2.6.12-rc4/mm/filemap_xip.c linux-2.6.12-rc4.xip/mm/filemap_xip.c
--- linux-2.6.12-rc4/mm/filemap_xip.c	2005-05-25 03:05:55.369259864 -0700
+++ linux-2.6.12-rc4.xip/mm/filemap_xip.c	2005-05-25 02:58:27.200391888 -0700
@@ -114,62 +114,6 @@ out:
 		file_accessed(filp);
 }
 
-/*
- * This is the "read()" routine for all filesystems
- * that uses the get_xip_page address space operation.
- */
-static ssize_t
-__xip_file_aio_read(struct kiocb *iocb, const struct iovec *iov,
-		unsigned long nr_segs, loff_t *ppos)
-{
-	struct file *filp = iocb->ki_filp;
-	ssize_t retval;
-	unsigned long seg;
-	size_t count;
-
-	count = 0;
-	for (seg = 0; seg < nr_segs; seg++) {
-		const struct iovec *iv = &iov[seg];
-
-		/*
-		 * If any segment has a negative length, or the cumulative
-		 * length ever wraps negative then return -EINVAL.
-		 */
-		count += iv->iov_len;
-		if (unlikely((ssize_t)(count|iv->iov_len) < 0))
-			return -EINVAL;
-		if (access_ok(VERIFY_WRITE, iv->iov_base, iv->iov_len))
-			continue;
-		if (seg == 0)
-			return -EFAULT;
-		nr_segs = seg;
-		count -= iv->iov_len;	/* This segment is no good */
-		break;
-	}
-
-	retval = 0;
-	if (count) {
-		for (seg = 0; seg < nr_segs; seg++) {
-			read_descriptor_t desc;
-
-			desc.written = 0;
-			desc.arg.buf = iov[seg].iov_base;
-			desc.count = iov[seg].iov_len;
-			if (desc.count == 0)
-				continue;
-			desc.error = 0;
-			do_xip_mapping_read(filp->f_mapping, &filp->f_ra, filp,
-					    ppos, &desc, file_read_actor);
-			retval += desc.written;
-			if (!retval) {
-				retval = desc.error;
-				break;
-			}
-		}
-	}
-	return retval;
-}
-
 ssize_t
 xip_file_aio_read(struct kiocb *iocb, char __user *buf, size_t count,
 		  loff_t pos)
@@ -177,7 +121,8 @@ xip_file_aio_read(struct kiocb *iocb, ch
 	struct iovec local_iov = { .iov_base = buf, .iov_len = count };
 
 	BUG_ON(iocb->ki_pos != pos);
-	return __xip_file_aio_read(iocb, &local_iov, 1, &iocb->ki_pos);
+	return __generic_file_aio_read_internal(iocb, &local_iov, 1, 
+			&iocb->ki_pos, do_xip_mapping_read);
 }
 EXPORT_SYMBOL_GPL(xip_file_aio_read);
 
@@ -188,7 +133,8 @@ xip_file_readv(struct file *filp, const 
 	struct kiocb kiocb;
 
 	init_sync_kiocb(&kiocb, filp);
-	return __xip_file_aio_read(&kiocb, iov, nr_segs, ppos);
+	return __generic_file_aio_read_internal(&kiocb, iov, nr_segs, 
+			ppos, do_xip_mapping_read);
 }
 EXPORT_SYMBOL_GPL(xip_file_readv);
 
@@ -423,74 +369,14 @@ do_xip_file_write(struct kiocb *iocb, co
 }
 
 static ssize_t
-xip_file_aio_write_nolock(struct kiocb *iocb, const struct iovec *iov,
-				unsigned long nr_segs, loff_t *ppos)
-{
-	struct file *file = iocb->ki_filp;
-	struct address_space * mapping = file->f_mapping;
-	size_t ocount;		/* original count */
-	size_t count;		/* after file limit checks */
-	struct inode 	*inode = mapping->host;
-	unsigned long	seg;
-	loff_t		pos;
-	ssize_t		written;
-	ssize_t		err;
-
-	ocount = 0;
-	for (seg = 0; seg < nr_segs; seg++) {
-		const struct iovec *iv = &iov[seg];
-
-		/*
-		 * If any segment has a negative length, or the cumulative
-		 * length ever wraps negative then return -EINVAL.
-		 */
-		ocount += iv->iov_len;
-		if (unlikely((ssize_t)(ocount|iv->iov_len) < 0))
-			return -EINVAL;
-		if (access_ok(VERIFY_READ, iv->iov_base, iv->iov_len))
-			continue;
-		if (seg == 0)
-			return -EFAULT;
-		nr_segs = seg;
-		ocount -= iv->iov_len;	/* This segment is no good */
-		break;
-	}
-
-	count = ocount;
-	pos = *ppos;
-
-	vfs_check_frozen(inode->i_sb, SB_FREEZE_WRITE);
-
-	written = 0;
-
-	err = generic_write_checks(file, &pos, &count, S_ISBLK(inode->i_mode));
-	if (err)
-		goto out;
-
-	if (count == 0)
-		goto out;
-
-	err = remove_suid(file->f_dentry);
-	if (err)
-		goto out;
-
-	inode_update_time(inode, 1);
-
-	/* use execute in place to copy directly to disk */
-	written = do_xip_file_write (iocb, iov,
-				  nr_segs, pos, ppos, count);
- out:
-	return written ? written : err;
-}
-
-static ssize_t
 __xip_file_write_nolock(struct file *file, const struct iovec *iov,
 			unsigned long nr_segs, loff_t *ppos)
 {
 	struct kiocb kiocb;
 
 	init_sync_kiocb(&kiocb, file);
-	return xip_file_aio_write_nolock(&kiocb, iov, nr_segs, ppos);
+	return __generic_file_aio_write_nolock_internal(&kiocb, iov, 
+			nr_segs, ppos, do_xip_file_write);
 }
 
 ssize_t
@@ -507,7 +393,8 @@ xip_file_aio_write(struct kiocb *iocb, c
 	BUG_ON(iocb->ki_pos != pos);
 
 	down(&inode->i_sem);
-	ret = xip_file_aio_write_nolock(iocb, &local_iov, 1, &iocb->ki_pos);
+	ret = __generic_file_aio_write_nolock_internal(iocb, &local_iov, 
+			1, &iocb->ki_pos, do_xip_file_write);
 	up(&inode->i_sem);
 	return ret;
 }

--=-I2dxChpRif6aO81CVtr5--

