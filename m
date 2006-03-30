Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932116AbWC3Id1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbWC3Id1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 03:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932117AbWC3Id1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 03:33:27 -0500
Received: from smtp.osdl.org ([65.172.181.4]:40103 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932116AbWC3Id0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 03:33:26 -0500
Date: Thu, 30 Mar 2006 00:32:46 -0800
From: Andrew Morton <akpm@osdl.org>
To: Neil Brown <neilb@suse.de>
Cc: linux-kernel@vger.kernel.org, drepper@redhat.com, mtk-manpages@gmx.net,
       nickpiggin@yahoo.com.au
Subject: Re: [patch 1/1] sys_sync_file_range()
Message-Id: <20060330003246.31216ff2.akpm@osdl.org>
In-Reply-To: <17451.36790.450410.79788@cse.unsw.edu.au>
References: <200603300741.k2U7fQLe002202@shell0.pdx.osdl.net>
	<17451.36790.450410.79788@cse.unsw.edu.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown <neilb@suse.de> wrote:
>
> Hmmm... any chance this could be split into a sys_sync_file_range and
>  a vfs_sync_file_range which takes a 'struct file*' and does less (or
>  no) sanity checking, so I can call it from nfsd?

Problem is, we don't appear to have a way of syncing the file's metadata
without also syncing all of its pagecache.

For example, ext3_sync_file() will run a commit, which will sync all data
and metadata.

ext2_sync_file() will also sync all pagecache as well as metadata.  Even
though do_fsync() already synced the file data (!).


Is the below still useful?


diff -puN mm/fadvise.c~sys_sync_file_range mm/fadvise.c
--- devel/mm/fadvise.c~sys_sync_file_range	2006-03-29 23:48:28.000000000 -0800
+++ devel-akpm/mm/fadvise.c	2006-03-29 23:48:28.000000000 -0800
@@ -35,17 +35,6 @@
  *
  * LINUX_FADV_ASYNC_WRITE: push some or all of the dirty pages at the disk.
  *
- * LINUX_FADV_WRITE_WAIT, LINUX_FADV_ASYNC_WRITE: push all of the currently
- * dirty pages at the disk.
- *
- * LINUX_FADV_WRITE_WAIT, LINUX_FADV_ASYNC_WRITE, LINUX_FADV_WRITE_WAIT: push
- * all of the currently dirty pages at the disk, wait until they have been
- * written.
- *
- * It should be noted that none of these operations write out the file's
- * metadata.  So unless the application is strictly performing overwrites of
- * already-instantiated disk blocks, there are no guarantees here that the data
- * will be available after a crash.
  */
 asmlinkage long sys_fadvise64_64(int fd, loff_t offset, loff_t len, int advice)
 {
@@ -129,15 +118,6 @@ asmlinkage long sys_fadvise64_64(int fd,
 			invalidate_mapping_pages(mapping, start_index,
 						end_index);
 		break;
-	case LINUX_FADV_ASYNC_WRITE:
-		ret = __filemap_fdatawrite_range(mapping, offset, endbyte,
-						WB_SYNC_NONE);
-		break;
-	case LINUX_FADV_WRITE_WAIT:
-		ret = wait_on_page_writeback_range(mapping,
-					offset >> PAGE_CACHE_SHIFT,
-					endbyte >> PAGE_CACHE_SHIFT);
-		break;
 	default:
 		ret = -EINVAL;
 	}
diff -puN include/linux/fadvise.h~sys_sync_file_range include/linux/fadvise.h
--- devel/include/linux/fadvise.h~sys_sync_file_range	2006-03-29 23:48:28.000000000 -0800
+++ devel-akpm/include/linux/fadvise.h	2006-03-29 23:48:28.000000000 -0800
@@ -18,10 +18,4 @@
 #define POSIX_FADV_NOREUSE	5 /* Data will be accessed once.  */
 #endif
 
-/*
- * Linux-specific fadvise() extensions:
- */
-#define LINUX_FADV_ASYNC_WRITE	32	/* Start writeout on range */
-#define LINUX_FADV_WRITE_WAIT	33	/* Wait upon writeout to range */
-
 #endif	/* FADVISE_H_INCLUDED */
diff -puN /dev/null fs/sync.c
--- /dev/null	2003-09-15 06:40:47.000000000 -0700
+++ devel-akpm/fs/sync.c	2006-03-30 00:16:37.000000000 -0800
@@ -0,0 +1,163 @@
+/*
+ * High-level sync()-related operations
+ */
+
+#include <linux/kernel.h>
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/module.h>
+#include <linux/writeback.h>
+#include <linux/syscalls.h>
+#include <linux/linkage.h>
+#include <linux/pagemap.h>
+
+#define VALID_FLAGS (SYNC_FILE_RANGE_WAIT_BEFORE|SYNC_FILE_RANGE_WRITE| \
+			SYNC_FILE_RANGE_WAIT_AFTER)
+
+/*
+ * sys_sync_file_range() permits finely controlled syncing over a segment of
+ * a file in the range offset .. (offset+nbytes-1) inclusive.  If nbytes is
+ * zero then sys_sync_file_range() will operate from offset out to EOF.
+ *
+ * The flag bits are:
+ *
+ * SYNC_FILE_RANGE_WAIT_BEFORE: wait upon writeout of all pages in the range
+ * before performing the write.
+ *
+ * SYNC_FILE_RANGE_WRITE: initiate writeout of all those dirty pages in the
+ * range which are not presently under writeback.
+ *
+ * SYNC_FILE_RANGE_WAIT_AFTER: wait upon writeout of all pages in the range
+ * after performing the write.
+ *
+ * Useful combinations of the flag bits are:
+ *
+ * SYNC_FILE_RANGE_WAIT_BEFORE|SYNC_FILE_RANGE_WRITE: ensures that all pages
+ * in the range which were dirty on entry to sys_sync_file_range() are placed
+ * under writeout.  This is a start-write-for-data-integrity operation.
+ *
+ * SYNC_FILE_RANGE_WRITE: start writeout of all dirty pages in the range which
+ * are not presently under writeout.  This is an asynchronous flush-to-disk
+ * operation.  Not suitable for data integrity operations.
+ *
+ * SYNC_FILE_RANGE_WAIT_BEFORE (or SYNC_FILE_RANGE_WAIT_AFTER): wait for
+ * completion of writeout of all pages in the range.  This will be used after an
+ * earlier SYNC_FILE_RANGE_WAIT_BEFORE|SYNC_FILE_RANGE_WRITE operation to wait
+ * for that operation to complete and to return the result.
+ *
+ * SYNC_FILE_RANGE_WAIT_BEFORE|SYNC_FILE_RANGE_WRITE|SYNC_FILE_RANGE_WAIT_AFTER:
+ * a traditional sync() operation.  This is a write-for-data-integrity operation
+ * which will ensure that all pages in the range which were dirty on entry to
+ * sys_sync_file_range() are committed to disk.
+ *
+ *
+ * SYNC_FILE_RANGE_WAIT_BEFORE and SYNC_FILE_RANGE_WAIT_AFTER will detect any
+ * I/O errors or ENOSPC conditions and will return those to the caller, after
+ * clearing the EIO and ENOSPC flags in the address_space.
+ *
+ * It should be noted that none of these operations write out the file's
+ * metadata.  So unless the application is strictly performing overwrites of
+ * already-instantiated disk blocks, there are no guarantees here that the data
+ * will be available after a crash.
+ */
+asmlinkage long sys_sync_file_range(int fd, loff_t offset, loff_t nbytes,
+					int flags)
+{
+	int ret;
+	struct file *file;
+	loff_t endbyte;			/* inclusive */
+	int fput_needed;
+
+	ret = -EINVAL;
+	if (flags & ~VALID_FLAGS)
+		goto out;
+
+	endbyte = offset + nbytes;
+
+	if ((s64)offset < 0)
+		goto out;
+	if ((s64)endbyte < 0)
+		goto out;
+	if (endbyte < offset)
+		goto out;
+
+	if (sizeof(pgoff_t) == 4) {
+		if (offset >= (0x100000000ULL << PAGE_CACHE_SHIFT)) {
+			/*
+			 * The range starts outside a 32 bit machine's
+			 * pagecache addressing capabilities.  Let it "succeed"
+			 */
+			ret = 0;
+			goto out;
+		}
+		if (endbyte >= (0x100000000ULL << PAGE_CACHE_SHIFT)) {
+			/*
+			 * Out to EOF
+			 */
+			nbytes = 0;
+		}
+	}
+
+	if (nbytes == 0)
+		endbyte = -1;
+	else
+		endbyte--;		/* inclusive */
+
+	file = fget_light(fd, &fput_needed);
+	if (!file) {
+		ret = -EBADF;
+		goto out;
+	}
+
+	if (S_ISFIFO(file->f_dentry->d_inode->i_mode)) {
+		ret = -ESPIPE;
+		goto out_put;
+	}
+
+	ret = do_sync_file_range(file, offset, endbyte, flags);
+out_put:
+	fput_light(file, fput_needed);
+out:
+	return ret;
+}
+
+/*
+ * `endbyte' is inclusive
+ */
+int do_sync_file_range(struct file *file, loff_t offset, loff_t endbyte,
+			int flags)
+{
+	int ret;
+	struct address_space *mapping;
+
+	mapping = file->f_mapping;
+	if (!mapping) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = 0;
+	if (flags & SYNC_FILE_RANGE_WAIT_BEFORE) {
+		ret = wait_on_page_writeback_range(mapping,
+					offset >> PAGE_CACHE_SHIFT,
+					endbyte >> PAGE_CACHE_SHIFT);
+		if (ret < 0)
+			goto out;
+	}
+
+	if (flags & SYNC_FILE_RANGE_WRITE) {
+		ret = __filemap_fdatawrite_range(mapping, offset, endbyte,
+						WB_SYNC_NONE);
+		if (ret < 0)
+			goto out;
+	}
+
+	if (flags & SYNC_FILE_RANGE_WAIT_AFTER) {
+		ret = wait_on_page_writeback_range(mapping,
+					offset >> PAGE_CACHE_SHIFT,
+					endbyte >> PAGE_CACHE_SHIFT);
+	}
+out:
+	return ret;
+}
+EXPORT_SYMBOL_GPL(do_sync_file_range);
diff -puN include/linux/syscalls.h~sys_sync_file_range include/linux/syscalls.h
--- devel/include/linux/syscalls.h~sys_sync_file_range	2006-03-29 23:48:28.000000000 -0800
+++ devel-akpm/include/linux/syscalls.h	2006-03-30 00:11:50.000000000 -0800
@@ -569,5 +569,7 @@ asmlinkage long compat_sys_newfstatat(un
 asmlinkage long compat_sys_openat(unsigned int dfd, const char __user *filename,
 				   int flags, int mode);
 asmlinkage long sys_unshare(unsigned long unshare_flags);
+asmlinkage long sys_sync_file_range(int fd, loff_t offset, loff_t nbytes,
+					int flags);
 
 #endif
diff -puN include/linux/fs.h~sys_sync_file_range include/linux/fs.h
--- devel/include/linux/fs.h~sys_sync_file_range	2006-03-29 23:48:28.000000000 -0800
+++ devel-akpm/include/linux/fs.h	2006-03-30 00:15:44.000000000 -0800
@@ -757,6 +757,13 @@ extern void send_sigio(struct fown_struc
 extern int fcntl_setlease(unsigned int fd, struct file *filp, long arg);
 extern int fcntl_getlease(struct file *filp);
 
+/* fs/sync.c */
+#define SYNC_FILE_RANGE_WAIT_BEFORE	1
+#define SYNC_FILE_RANGE_WRITE		2
+#define SYNC_FILE_RANGE_WAIT_AFTER	4
+extern int do_sync_file_range(struct file *file, loff_t offset, loff_t endbyte,
+			int flags);
+
 /* fs/locks.c */
 extern void locks_init_lock(struct file_lock *);
 extern void locks_copy_lock(struct file_lock *, struct file_lock *);
diff -puN fs/Makefile~sys_sync_file_range fs/Makefile
--- devel/fs/Makefile~sys_sync_file_range	2006-03-29 23:48:28.000000000 -0800
+++ devel-akpm/fs/Makefile	2006-03-30 00:11:47.000000000 -0800
@@ -10,7 +10,7 @@ obj-y :=	open.o read_write.o file_table.
 		ioctl.o readdir.o select.o fifo.o locks.o dcache.o inode.o \
 		attr.o bad_inode.o file.o filesystems.o namespace.o aio.o \
 		seq_file.o xattr.o libfs.o fs-writeback.o mpage.o direct-io.o \
-		ioprio.o pnode.o drop_caches.o
+		ioprio.o pnode.o drop_caches.o sync.o
 
 obj-$(CONFIG_INOTIFY)		+= inotify.o
 obj-$(CONFIG_EPOLL)		+= eventpoll.o
diff -puN include/asm-i386/unistd.h~sys_sync_file_range include/asm-i386/unistd.h
--- devel/include/asm-i386/unistd.h~sys_sync_file_range	2006-03-29 23:48:28.000000000 -0800
+++ devel-akpm/include/asm-i386/unistd.h	2006-03-29 23:48:28.000000000 -0800
@@ -318,8 +318,9 @@
 #define __NR_unshare		310
 #define __NR_set_robust_list	311
 #define __NR_get_robust_list	312
+#define __NR_sys_sync_file_range 313
 
-#define NR_syscalls 313
+#define NR_syscalls 314
 
 /*
  * user-visible error numbers are in the range -1 - -128: see
diff -puN arch/i386/kernel/syscall_table.S~sys_sync_file_range arch/i386/kernel/syscall_table.S
--- devel/arch/i386/kernel/syscall_table.S~sys_sync_file_range	2006-03-29 23:48:28.000000000 -0800
+++ devel-akpm/arch/i386/kernel/syscall_table.S	2006-03-29 23:48:28.000000000 -0800
@@ -312,3 +312,4 @@ ENTRY(sys_call_table)
 	.long sys_unshare		/* 310 */
 	.long sys_set_robust_list
 	.long sys_get_robust_list
+	.long sys_sync_file_range
_

