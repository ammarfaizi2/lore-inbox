Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751172AbWBJHPX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbWBJHPX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 02:15:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbWBJHPW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 02:15:22 -0500
Received: from smtp.osdl.org ([65.172.181.4]:22960 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751172AbWBJHPV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 02:15:21 -0500
Date: Thu, 9 Feb 2006 23:14:32 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux@horizon.com, linux-kernel@vger.kernel.org, sct@redhat.com,
       torvalds@osdl.org
Subject: Re: msync() behaviour broken for MS_ASYNC, revert patch?
Message-Id: <20060209231432.03a09dee.akpm@osdl.org>
In-Reply-To: <43EC3961.3030904@yahoo.com.au>
References: <20060209071832.10500.qmail@science.horizon.com>
	<20060209001850.18ca135f.akpm@osdl.org>
	<43EAFEB9.2060000@yahoo.com.au>
	<20060209004208.0ada27ef.akpm@osdl.org>
	<43EB3801.70903@yahoo.com.au>
	<20060209094815.75041932.akpm@osdl.org>
	<43EC0A44.1020302@yahoo.com.au>
	<20060209195035.5403ce95.akpm@osdl.org>
	<43EC0F3F.1000805@yahoo.com.au>
	<20060209201333.62db0e24.akpm@osdl.org>
	<43EC16D8.8030300@yahoo.com.au>
	<20060209204314.2dae2814.akpm@osdl.org>
	<43EC1BFF.1080808@yahoo.com.au>
	<20060209211356.6c3a641a.akpm@osdl.org>
	<43EC24B1.9010104@yahoo.com.au>
	<20060209215040.0dcb36b1.akpm@osdl.org>
	<43EC2C9A.7000507@yahoo.com.au>
	<20060209221324.53089938.akpm@osdl.org>
	<43EC3326.4080706@yahoo.com.au>
	<20060209224656.7533ce2b.akpm@osdl.org>
	<43EC3961.3030904@yahoo.com.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
> Instead of
>  LINUX_FADV_ASYNC_WRITE
>  LINUX_FADV_WRITE_WAIT
> 
>  can we have something more consistent? Perhaps
>  FADV_WRITE_ASYNC
>  FADV_WRITE_SYNC

Nope, I had a bit of a think about this and decided that the two operations
which we need are:




From: Andrew Morton <akpm@osdl.org>

Add two new linux-specific fadvise extensions():

LINUX_FADV_ASYNC_WRITE: start async writeout of any dirty pages between file
offsets `offset' and `offset+len'.  Any pages which are currently under
writeout are skipped, whether or not they are dirty.

LINUX_FADV_WRITE_WAIT: wait upon writeout of any dirty pages between file
offsets `offset' and `offset+len'.

By combining these two operations the application may do several things:

LINUX_FADV_ASYNC_WRITE: push some or all of the dirty pages at the disk.

LINUX_FADV_WRITE_WAIT, LINUX_FADV_ASYNC_WRITE: push all of the currently dirty
pages at the disk.

LINUX_FADV_WRITE_WAIT, LINUX_FADV_ASYNC_WRITE, LINUX_FADV_WRITE_WAIT: push all
of the currently dirty pages at the disk, wait until they have been written.

It should be noted that none of these operations write out the file's
metadata.  So unless the application is strictly performing overwrites of
already-instantiated disk blocks, there are no guarantees here that the data
will be available after a crash.

To complete this suite of operations I guess we should have a "sync file
metadata only" operation.  This gives applications access to all the building
blocks needed for all sorts of sync operations.  But sync-metadata doesn't fit
well with the fadvise() interface.  Probably it should be a new syscall:
sys_fmetadatasync().



The patch also diddles with the meaning of `endbyte' in sys_fadvise64_64(). 
It is made to represent that last affected byte in the file (ie: it is
inclusive).  Generally, all these byterange and pagerange functions are
inclusive so we can easily represent EOF with -1.

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 include/linux/fadvise.h |    6 ++++
 include/linux/fs.h      |    5 ++++
 mm/fadvise.c            |   46 +++++++++++++++++++++++++++++++++-----
 mm/filemap.c            |   10 ++++----
 4 files changed, 57 insertions(+), 10 deletions(-)

diff -puN include/linux/fadvise.h~fadvise-async-write-commands include/linux/fadvise.h
--- devel/include/linux/fadvise.h~fadvise-async-write-commands	2006-02-09 22:29:36.000000000 -0800
+++ devel-akpm/include/linux/fadvise.h	2006-02-09 22:29:36.000000000 -0800
@@ -18,4 +18,10 @@
 #define POSIX_FADV_NOREUSE	5 /* Data will be accessed once.  */
 #endif
 
+/*
+ * Linux-specific fadvise() extensions:
+ */
+#define LINUX_FADV_ASYNC_WRITE	32	/* Start writeout on range */
+#define LINUX_FADV_WRITE_WAIT	33	/* Wait upon writeout to range */
+
 #endif	/* FADVISE_H_INCLUDED */
diff -puN include/linux/fs.h~fadvise-async-write-commands include/linux/fs.h
--- devel/include/linux/fs.h~fadvise-async-write-commands	2006-02-09 22:29:36.000000000 -0800
+++ devel-akpm/include/linux/fs.h	2006-02-09 23:06:03.000000000 -0800
@@ -1473,6 +1473,11 @@ extern int filemap_fdatawait(struct addr
 extern int filemap_write_and_wait(struct address_space *mapping);
 extern int filemap_write_and_wait_range(struct address_space *mapping,
 				        loff_t lstart, loff_t lend);
+extern int wait_on_page_writeback_range(struct address_space *mapping,
+				pgoff_t start, pgoff_t end);
+extern int __filemap_fdatawrite_range(struct address_space *mapping,
+				loff_t start, loff_t end, int sync_mode);
+
 extern void sync_supers(void);
 extern void sync_filesystems(int wait);
 extern void emergency_sync(void);
diff -puN mm/fadvise.c~fadvise-async-write-commands mm/fadvise.c
--- devel/mm/fadvise.c~fadvise-async-write-commands	2006-02-09 22:29:36.000000000 -0800
+++ devel-akpm/mm/fadvise.c	2006-02-09 23:12:22.000000000 -0800
@@ -15,6 +15,7 @@
 #include <linux/backing-dev.h>
 #include <linux/pagevec.h>
 #include <linux/fadvise.h>
+#include <linux/writeback.h>
 #include <linux/syscalls.h>
 
 #include <asm/unistd.h>
@@ -22,13 +23,36 @@
 /*
  * POSIX_FADV_WILLNEED could set PG_Referenced, and POSIX_FADV_NOREUSE could
  * deactivate the pages and clear PG_Referenced.
+ *
+ * LINUX_FADV_ASYNC_WRITE: start async writeout of any dirty pages between file
+ * offsets `offset' and `offset+len' inclusive.  Any pages which are currently
+ * under writeout are skipped, whether or not they are dirty.
+ *
+ * LINUX_FADV_WRITE_WAIT: wait upon writeout of any dirty pages between file
+ * offsets `offset' and `offset+len'.
+ *
+ * By combining these two operations the application may do several things:
+ *
+ * LINUX_FADV_ASYNC_WRITE: push some or all of the dirty pages at the disk.
+ *
+ * LINUX_FADV_WRITE_WAIT, LINUX_FADV_ASYNC_WRITE: push all of the currently
+ * dirty pages at the disk.
+ *
+ * LINUX_FADV_WRITE_WAIT, LINUX_FADV_ASYNC_WRITE, LINUX_FADV_WRITE_WAIT: push
+ * all of the currently dirty pages at the disk, wait until they have been
+ * written.
+ *
+ * It should be noted that none of these operations write out the file's
+ * metadata.  So unless the application is strictly performing overwrites of
+ * already-instantiated disk blocks, there are no guarantees here that the data
+ * will be available after a crash.
  */
 asmlinkage long sys_fadvise64_64(int fd, loff_t offset, loff_t len, int advice)
 {
 	struct file *file = fget(fd);
 	struct address_space *mapping;
 	struct backing_dev_info *bdi;
-	loff_t endbyte;
+	loff_t endbyte;			/* inclusive */
 	pgoff_t start_index;
 	pgoff_t end_index;
 	unsigned long nrpages;
@@ -56,6 +80,8 @@ asmlinkage long sys_fadvise64_64(int fd,
 	endbyte = offset + len;
 	if (!len || endbyte < len)
 		endbyte = -1;
+	else
+		endbyte--;		/* inclusive */
 
 	bdi = mapping->backing_dev_info;
 
@@ -78,7 +104,7 @@ asmlinkage long sys_fadvise64_64(int fd,
 
 		/* First and last PARTIAL page! */
 		start_index = offset >> PAGE_CACHE_SHIFT;
-		end_index = (endbyte-1) >> PAGE_CACHE_SHIFT;
+		end_index = endbyte >> PAGE_CACHE_SHIFT;
 
 		/* Careful about overflow on the "+1" */
 		nrpages = end_index - start_index + 1;
@@ -96,11 +122,21 @@ asmlinkage long sys_fadvise64_64(int fd,
 			filemap_flush(mapping);
 
 		/* First and last FULL page! */
-		start_index = (offset + (PAGE_CACHE_SIZE-1)) >> PAGE_CACHE_SHIFT;
+		start_index = (offset+(PAGE_CACHE_SIZE-1)) >> PAGE_CACHE_SHIFT;
 		end_index = (endbyte >> PAGE_CACHE_SHIFT);
 
-		if (end_index > start_index)
-			invalidate_mapping_pages(mapping, start_index, end_index-1);
+		if (end_index >= start_index)
+			invalidate_mapping_pages(mapping, start_index,
+						end_index);
+		break;
+	case LINUX_FADV_ASYNC_WRITE:
+		ret = __filemap_fdatawrite_range(mapping, offset, endbyte,
+						WB_SYNC_NONE);
+		break;
+	case LINUX_FADV_WRITE_WAIT:
+		ret = wait_on_page_writeback_range(mapping,
+					offset >> PAGE_CACHE_SHIFT,
+					endbyte >> PAGE_CACHE_SHIFT);
 		break;
 	default:
 		ret = -EINVAL;
diff -puN mm/filemap.c~fadvise-async-write-commands mm/filemap.c
--- devel/mm/filemap.c~fadvise-async-write-commands	2006-02-09 22:29:36.000000000 -0800
+++ devel-akpm/mm/filemap.c	2006-02-09 23:05:56.000000000 -0800
@@ -181,8 +181,8 @@ static int sync_page(void *word)
  * these two operations is that if a dirty page/buffer is encountered, it must
  * be waited upon, and not just skipped over.
  */
-static int __filemap_fdatawrite_range(struct address_space *mapping,
-	loff_t start, loff_t end, int sync_mode)
+int __filemap_fdatawrite_range(struct address_space *mapping, loff_t start,
+				loff_t end, int sync_mode)
 {
 	int ret;
 	struct writeback_control wbc = {
@@ -211,8 +211,8 @@ int filemap_fdatawrite(struct address_sp
 }
 EXPORT_SYMBOL(filemap_fdatawrite);
 
-static int filemap_fdatawrite_range(struct address_space *mapping,
-	loff_t start, loff_t end)
+static int filemap_fdatawrite_range(struct address_space *mapping, loff_t start,
+				loff_t end)
 {
 	return __filemap_fdatawrite_range(mapping, start, end, WB_SYNC_ALL);
 }
@@ -231,7 +231,7 @@ EXPORT_SYMBOL(filemap_flush);
  * Wait for writeback to complete against pages indexed by start->end
  * inclusive
  */
-static int wait_on_page_writeback_range(struct address_space *mapping,
+int wait_on_page_writeback_range(struct address_space *mapping,
 				pgoff_t start, pgoff_t end)
 {
 	struct pagevec pvec;
_

