Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422854AbWBIIYt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422854AbWBIIYt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 03:24:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422869AbWBIIYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 03:24:49 -0500
Received: from smtp.osdl.org ([65.172.181.4]:24466 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422854AbWBIIYs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 03:24:48 -0500
Date: Thu, 9 Feb 2006 00:18:50 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux@horizon.com
Cc: linux-kernel@vger.kernel.org, sct@redhat.com, linux@horizon.com
Subject: Re: msync() behaviour broken for MS_ASYNC, revert patch?
Message-Id: <20060209001850.18ca135f.akpm@osdl.org>
In-Reply-To: <20060209071832.10500.qmail@science.horizon.com>
References: <20060209071832.10500.qmail@science.horizon.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux@horizon.com wrote:
>
> Sorry to bring this up only after a 2-year hiatus, but I'm trying to
>  port an application from Solaris and Linux 2.4 to 2.6 and finding amazing
>  performance regression due to this.  (For referemce, as of 2.5.something,
>  msync(MS_ASYNC) just puts the pages on a dirty list but doesn't actually
>  start the I/O until some fairly coarse timer in the VM system fires.)
> 
>  It uses msync(MS_ASYNC) and msync(MS_SYNC) as a poor man's portable
>  async IO.  It's appending data to an on-disk log.  When a page is full
>  or a transaction complete, the page will not be modified any further and
>  it uses MS_ASYNC to start the I/O as early as possible.  (When compiled
>  with debugging, it also uses remaps the page read-only.)
> 
>  Then it accomplishes as much as it can without needing the transaction
>  committed (typically 25-100 ms), and when it's blocked until the
>  transaction is known to be durable, it calls msync(MS_SYNC).  Which
>  should, if everything went right, return immediately, because the page
>  is clean.

2.4:

	MS_ASYNC: dirty the pagecache pages, start I/O
	MS_SYNC: dirty the pagecache pages, start I/O, wait on I/O

2.6:

	MS_ASYNC: dirty the pagecache pages
	MS_SYNC: dirty the pagecache pages, start I/O, wait on I/O.

So you're saying that doing the I/O in that 25-100msec window allowed your
app to do more pipelining.

I think for most scenarios, what we have in 2.6 is better: it gives the app
more control over when the I/O should be started.  But not for you, because
you have this handy 25-100ms window in which to do other stuff, which
eliminates the need to create a new thread to do the I/O.

Something like this?   (Needs a triple-check).



Add two new linux-specific fadvise extensions():

LINUX_FADV_ASYNC_WRITE: start async writeout of any dirty pages between file
offsets `offset' and `offset+len'.

LINUX_FADV_SYNC_WRITE: start and wait upon writeout of any dirty pages between
file offsets `offset' and `offset+len'.

The patch also regularises the filemap_write_and_wait_range() API.  Make it
look like the __filemap_fdatawrite_range() one: the `end' argument points at
the first byte beyond the range being written.


Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 fs/direct-io.c          |    2 +-
 include/linux/fadvise.h |    6 ++++++
 include/linux/fs.h      |    3 +++
 mm/fadvise.c            |   13 +++++++++++--
 mm/filemap.c            |   18 +++++++++++-------
 5 files changed, 32 insertions(+), 10 deletions(-)

diff -puN mm/fadvise.c~fadvise-async-write-commands mm/fadvise.c
--- devel/mm/fadvise.c~fadvise-async-write-commands	2006-02-08 23:55:42.000000000 -0800
+++ devel-akpm/mm/fadvise.c	2006-02-09 00:16:58.000000000 -0800
@@ -15,6 +15,7 @@
 #include <linux/backing-dev.h>
 #include <linux/pagevec.h>
 #include <linux/fadvise.h>
+#include <linux/writeback.h>
 #include <linux/syscalls.h>
 
 #include <asm/unistd.h>
@@ -96,11 +97,19 @@ asmlinkage long sys_fadvise64_64(int fd,
 			filemap_flush(mapping);
 
 		/* First and last FULL page! */
-		start_index = (offset + (PAGE_CACHE_SIZE-1)) >> PAGE_CACHE_SHIFT;
+		start_index = (offset+(PAGE_CACHE_SIZE-1)) >> PAGE_CACHE_SHIFT;
 		end_index = (endbyte >> PAGE_CACHE_SHIFT);
 
 		if (end_index > start_index)
-			invalidate_mapping_pages(mapping, start_index, end_index-1);
+			invalidate_mapping_pages(mapping, start_index,
+						end_index - 1);
+		break;
+	case LINUX_FADV_ASYNC_WRITE:
+		ret = __filemap_fdatawrite_range(mapping, offset, endbyte,
+						WB_SYNC_NONE);
+		break;
+	case LINUX_FADV_SYNC_WRITE:
+		ret = filemap_write_and_wait_range(mapping, offset, endbyte);
 		break;
 	default:
 		ret = -EINVAL;
diff -puN include/linux/fadvise.h~fadvise-async-write-commands include/linux/fadvise.h
--- devel/include/linux/fadvise.h~fadvise-async-write-commands	2006-02-08 23:55:42.000000000 -0800
+++ devel-akpm/include/linux/fadvise.h	2006-02-08 23:56:55.000000000 -0800
@@ -18,4 +18,10 @@
 #define POSIX_FADV_NOREUSE	5 /* Data will be accessed once.  */
 #endif
 
+/*
+ * Linux-specific fadvise() extensions:
+ */
+#define LINUX_FADV_ASYNC_WRITE	32	/* Start writeout on range */
+#define LINUX_FADV_SYNC_WRITE	33	/* Write out and wait upon range */
+
 #endif	/* FADVISE_H_INCLUDED */
diff -puN mm/filemap.c~fadvise-async-write-commands mm/filemap.c
--- devel/mm/filemap.c~fadvise-async-write-commands	2006-02-08 23:59:01.000000000 -0800
+++ devel-akpm/mm/filemap.c	2006-02-09 00:10:40.000000000 -0800
@@ -174,7 +174,8 @@ static int sync_page(void *word)
  * dirty pages that lie within the byte offsets <start, end>
  * @mapping:	address space structure to write
  * @start:	offset in bytes where the range starts
- * @end:	offset in bytes where the range ends
+ * @end:	offset in bytes where the range ends (+1: we write end-start
+ *		bytes)
  * @sync_mode:	enable synchronous operation
  *
  * If sync_mode is WB_SYNC_ALL then this is a "data integrity" operation, as
@@ -182,8 +183,8 @@ static int sync_page(void *word)
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
@@ -212,8 +213,8 @@ int filemap_fdatawrite(struct address_sp
 }
 EXPORT_SYMBOL(filemap_fdatawrite);
 
-static int filemap_fdatawrite_range(struct address_space *mapping,
-	loff_t start, loff_t end)
+static int filemap_fdatawrite_range(struct address_space *mapping, loff_t start,
+				loff_t end)
 {
 	return __filemap_fdatawrite_range(mapping, start, end, WB_SYNC_ALL);
 }
@@ -367,19 +368,22 @@ int filemap_write_and_wait(struct addres
 }
 EXPORT_SYMBOL(filemap_write_and_wait);
 
+/*
+ * Write out and wait upon all the bytes between lstart and (lend-1)
+ */
 int filemap_write_and_wait_range(struct address_space *mapping,
 				 loff_t lstart, loff_t lend)
 {
 	int err = 0;
 
-	if (mapping->nrpages) {
+	if (mapping->nrpages && lend > lstart) {
 		err = __filemap_fdatawrite_range(mapping, lstart, lend,
 						 WB_SYNC_ALL);
 		/* See comment of filemap_write_and_wait() */
 		if (err != -EIO) {
 			int err2 = wait_on_page_writeback_range(mapping,
 						lstart >> PAGE_CACHE_SHIFT,
-						lend >> PAGE_CACHE_SHIFT);
+						(lend - 1) >> PAGE_CACHE_SHIFT);
 			if (!err)
 				err = err2;
 		}
diff -puN include/linux/fs.h~fadvise-async-write-commands include/linux/fs.h
--- devel/include/linux/fs.h~fadvise-async-write-commands	2006-02-08 23:59:24.000000000 -0800
+++ devel-akpm/include/linux/fs.h	2006-02-09 00:03:22.000000000 -0800
@@ -1476,6 +1476,9 @@ extern int filemap_fdatawait(struct addr
 extern int filemap_write_and_wait(struct address_space *mapping);
 extern int filemap_write_and_wait_range(struct address_space *mapping,
 				        loff_t lstart, loff_t lend);
+extern int __filemap_fdatawrite_range(struct address_space *mapping,
+				loff_t start, loff_t end, int sync_mode);
+
 extern void sync_supers(void);
 extern void sync_filesystems(int wait);
 extern void emergency_sync(void);
diff -puN fs/direct-io.c~fadvise-async-write-commands fs/direct-io.c
--- devel/fs/direct-io.c~fadvise-async-write-commands	2006-02-09 00:09:54.000000000 -0800
+++ devel-akpm/fs/direct-io.c	2006-02-09 00:10:06.000000000 -0800
@@ -1240,7 +1240,7 @@ __blockdev_direct_IO(int rw, struct kioc
 			}
 
 			retval = filemap_write_and_wait_range(mapping, offset,
-							      end - 1);
+							      end);
 			if (retval) {
 				kfree(dio);
 				goto out;
_

