Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932625AbVLSJOm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932625AbVLSJOm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 04:14:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932675AbVLSJOm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 04:14:42 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:12384 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932625AbVLSJOm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 04:14:42 -0500
Date: Mon, 19 Dec 2005 10:16:17 +0100
From: Jens Axboe <axboe@suse.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][RFC] splice support
Message-ID: <20051219091616.GA3734@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I decided to try and get the sys_splice that Linus posted close to a
year ago more complete, this is the result so far. It supports splicing
pages between pipes and files, in both directions. I'm attaching to
simple user space test tools to splice to and from a pipe:

o splice-in <file>  : splice pages from file to stdout
o splice-out <file> : splice pages from stdin to file

So if you wanted, you could copy a file to newfile by doing:

# splice-in file | splice-out newfile

which would move the pages to newfiles address space.

Now this isn't complete of course, I'm just posting this in the spirit
of posting early. Changes that I envision:

- The vfs interface is nasty, it's coupled to actual pipes now which
  isn't the intention. This needs to be split so the ->splice_read and
  ->splice_write merely fill the pipe buffers and the splice.c code
  handles the actual pipe (if there is one).

- sys_splice() should handle "any" file descriptor, so we can support
  file <-> splicing and file -> socket splicing. We require a real pipe
  now, because of the above vfs interface badness.

- Add ability to splice to a socket, using ->sendpage().

- The ->copy_page variable is ugly.

Probably more, but these are the most important ones. Patch is against
2.6.15-rc6, it also resides in the 'splice' branch of the block layer
git repo (yeah it's not really block io, but it's io at least :-)


Subject: [PATCH] Initial support for sys_splice()
From: Jens Axboe <axboe@suse.de>
Date: 1134983694 +0100

---

 arch/i386/kernel/syscall_table.S |    1 
 arch/ppc/kernel/misc.S           |    1 
 fs/Makefile                      |    2 
 fs/ext2/file.c                   |    2 
 fs/ext3/file.c                   |    2 
 fs/pipe.c                        |   16 +
 fs/splice.c                      |  526 ++++++++++++++++++++++++++++++++++++++
 include/asm-i386/unistd.h        |    3 
 include/asm-powerpc/unistd.h     |    3 
 include/asm-x86_64/apic.h        |    2 
 include/asm-x86_64/system.h      |    2 
 include/asm-x86_64/unistd.h      |    4 
 include/linux/fs.h               |    4 
 include/linux/pipe_fs_i.h        |    2 
 14 files changed, 561 insertions(+), 9 deletions(-)
 create mode 100644 fs/splice.c

05634a4999f9b79f42b98b1e1fb42fc0404bfe66
diff --git a/arch/i386/kernel/syscall_table.S b/arch/i386/kernel/syscall_table.S
index 9b21a31..8b9d2e1 100644
--- a/arch/i386/kernel/syscall_table.S
+++ b/arch/i386/kernel/syscall_table.S
@@ -294,3 +294,4 @@ ENTRY(sys_call_table)
 	.long sys_inotify_init
 	.long sys_inotify_add_watch
 	.long sys_inotify_rm_watch
+	.long sys_splice
diff --git a/arch/ppc/kernel/misc.S b/arch/ppc/kernel/misc.S
index 5e61124..1fb5eb7 100644
--- a/arch/ppc/kernel/misc.S
+++ b/arch/ppc/kernel/misc.S
@@ -1403,3 +1403,4 @@ _GLOBAL(sys_call_table)
 	.long sys_inotify_init		/* 275 */
 	.long sys_inotify_add_watch
 	.long sys_inotify_rm_watch
+	.long sys_splice
diff --git a/fs/Makefile b/fs/Makefile
index 4c26557..328f825 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -10,7 +10,7 @@ obj-y :=	open.o read_write.o file_table.
 		ioctl.o readdir.o select.o fifo.o locks.o dcache.o inode.o \
 		attr.o bad_inode.o file.o filesystems.o namespace.o aio.o \
 		seq_file.o xattr.o libfs.o fs-writeback.o mpage.o direct-io.o \
-		ioprio.o pnode.o
+		ioprio.o pnode.o splice.o
 
 obj-$(CONFIG_INOTIFY)		+= inotify.o
 obj-$(CONFIG_EPOLL)		+= eventpoll.o
diff --git a/fs/ext2/file.c b/fs/ext2/file.c
index a484412..3a4b0c0 100644
--- a/fs/ext2/file.c
+++ b/fs/ext2/file.c
@@ -53,6 +53,8 @@ struct file_operations ext2_file_operati
 	.readv		= generic_file_readv,
 	.writev		= generic_file_writev,
 	.sendfile	= generic_file_sendfile,
+	.splice_read	= generic_file_splice_read,
+	.splice_write	= generic_file_splice_write,
 };
 
 #ifdef CONFIG_EXT2_FS_XIP
diff --git a/fs/ext3/file.c b/fs/ext3/file.c
index 98e7834..a0ea89b 100644
--- a/fs/ext3/file.c
+++ b/fs/ext3/file.c
@@ -119,6 +119,8 @@ struct file_operations ext3_file_operati
 	.release	= ext3_release_file,
 	.fsync		= ext3_sync_file,
 	.sendfile	= generic_file_sendfile,
+	.splice_read	= generic_file_splice_read,
+	.splice_write	= generic_file_splice_write,
 };
 
 struct inode_operations ext3_file_inode_operations = {
diff --git a/fs/pipe.c b/fs/pipe.c
index 66aa0b9..36c0c18 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -15,6 +15,7 @@
 #include <linux/pipe_fs_i.h>
 #include <linux/uio.h>
 #include <linux/highmem.h>
+#include <linux/pagemap.h>
 
 #include <asm/uaccess.h>
 #include <asm/ioctls.h>
@@ -94,11 +95,20 @@ static void anon_pipe_buf_release(struct
 {
 	struct page *page = buf->page;
 
-	if (info->tmp_page) {
-		__free_page(page);
+	/*
+	 * If nobody else uses this page, and we don't already have a
+	 * temporary page, let's keep track of it as a one-deep
+	 * allocation cache
+	 */
+	if (page_count(page) == 1 && !info->tmp_page) {
+		info->tmp_page = page;
 		return;
 	}
-	info->tmp_page = page;
+
+	/*
+	 * Otherwise just release our reference to it
+	 */
+	page_cache_release(page);
 }
 
 static void *anon_pipe_buf_map(struct file *file, struct pipe_inode_info *info, struct pipe_buffer *buf)
diff --git a/fs/splice.c b/fs/splice.c
new file mode 100644
index 0000000..550a934
--- /dev/null
+++ b/fs/splice.c
@@ -0,0 +1,526 @@
+/*
+ * "splice": joining two ropes together by interweaving their strands.
+ *
+ * This is the "extended pipe" functionality, where a pipe is used as
+ * an arbitrary in-memory buffer. Think of a pipe as a small kernel
+ * buffer that you can use to transfer data from one end to the other.
+ *
+ * The traditional unix read/write is extended with a "splice()" operation
+ * that transfers data buffers to or from a pipe buffer.
+ *
+ * Named by Larry McVoy, original implementation from Linus, extended by
+ * Jens to support splicing to files and fixing the initial implementation
+ * bugs.
+ *
+ * Copyright (C) 2005 Jens Axboe <axboe@suse.de>
+ * Copyright (C) 2005 Linus Torvalds <torvalds@osdl.org>
+ *
+ */
+#include <linux/fs.h>
+#include <linux/file.h>
+#include <linux/pagemap.h>
+#include <linux/pipe_fs_i.h>
+#include <linux/mm_inline.h>
+
+static void page_cache_pipe_buf_release(struct pipe_inode_info *info,
+					struct pipe_buffer *buf)
+{
+	page_cache_release(buf->page);
+	buf->page = NULL;
+	buf->copy_page = 0;
+}
+
+static void *page_cache_pipe_buf_map(struct file *file,
+				     struct pipe_inode_info *info,
+				     struct pipe_buffer *buf)
+{
+	struct page *page = buf->page;
+
+	lock_page(page);
+
+	if (!PageUptodate(page))
+		return NULL;
+
+	/*
+	 * now prune the page from the page cache, if we can. if not,
+	 * we need to copy the page instead of just mapping it to the new
+	 * address space. a count of two means we are the only ones holding
+	 * a reference to this page outside of the pagecache
+	 */
+	if (page_count(page) == 2) {
+		struct zone *zone = page_zone(page);
+
+		spin_lock_irq(&zone->lru_lock);
+		if (TestClearPageLRU(page))
+			del_page_from_lru(zone, page);
+		spin_unlock_irq(&zone->lru_lock);
+
+		remove_from_page_cache(page);
+		page_cache_release(page);
+	} else
+		buf->copy_page = 1;
+
+	return kmap(buf->page);
+}
+
+static void page_cache_pipe_buf_unmap(struct pipe_inode_info *info,
+				      struct pipe_buffer *buf)
+{
+	if (buf->copy_page)
+		unlock_page(buf->page);
+
+	kunmap(buf->page);
+}
+
+static struct pipe_buf_operations page_cache_pipe_buf_ops = {
+	.can_merge = 0,
+	.map = page_cache_pipe_buf_map,
+	.unmap = page_cache_pipe_buf_unmap,
+	.release = page_cache_pipe_buf_release,
+};
+
+static ssize_t move_to_pipe(struct inode *inode, struct page **array, int pages,
+			    unsigned long offset, unsigned long len)
+{
+	struct pipe_inode_info *info;
+	int ret, do_wakeup, i;
+
+	ret = 0;
+	do_wakeup = 0;
+	i = 0;
+
+	down(PIPE_SEM(*inode));
+
+	info = inode->i_pipe;
+	for (;;) {
+		int bufs;
+
+		if (!PIPE_READERS(*inode)) {
+			send_sig(SIGPIPE, current, 0);
+			if (!ret)
+				ret = -EPIPE;
+			break;
+		}
+
+		bufs = info->nrbufs;
+		if (bufs < PIPE_BUFFERS) {
+			int newbuf = (info->curbuf + bufs) & (PIPE_BUFFERS - 1);
+			struct pipe_buffer *buf = info->bufs + newbuf;
+			struct page *page = array[i++];
+			unsigned long this_len;
+
+			this_len = PAGE_SIZE - offset;
+			if (this_len > len)
+				this_len = len;
+
+			buf->page = page;
+			buf->offset = offset;
+			buf->len = this_len;
+			buf->ops = &page_cache_pipe_buf_ops;
+			info->nrbufs = ++bufs;
+			do_wakeup = 1;
+
+			ret += this_len;
+			len -= this_len;
+			offset = 0;
+			if (!--pages)
+				break;
+			if (!len)
+				break;
+			if (bufs < PIPE_BUFFERS)
+				continue;
+
+			break;
+		}
+
+		if (signal_pending(current)) {
+			if (!ret)
+				ret = -ERESTARTSYS;
+			break;
+		}
+
+		if (do_wakeup) {
+			wake_up_interruptible_sync(PIPE_WAIT(*inode));
+			kill_fasync(PIPE_FASYNC_READERS(*inode), SIGIO,
+				    POLL_IN);
+			do_wakeup = 0;
+		}
+
+		PIPE_WAITING_WRITERS(*inode)++;
+		pipe_wait(inode);
+		PIPE_WAITING_WRITERS(*inode)--;
+	}
+
+	up(PIPE_SEM(*inode));
+
+	if (do_wakeup) {
+		wake_up_interruptible(PIPE_WAIT(*inode));
+		kill_fasync(PIPE_FASYNC_READERS(*inode), SIGIO, POLL_IN);
+	}
+
+	while (i < pages)
+		page_cache_release(array[i++]);
+
+	return ret;
+}
+
+static int __generic_file_splice_read(struct file *in, struct inode *pipe,
+				      size_t len)
+{
+	struct address_space *mapping = in->f_mapping;
+	unsigned long index, offset, pages;
+	struct page *array[PIPE_BUFFERS];
+	int i;
+
+	index = in->f_pos >> PAGE_CACHE_SHIFT;
+	offset = in->f_pos & ~PAGE_CACHE_MASK;
+	pages = (len + offset + PAGE_SIZE - 1) >> PAGE_CACHE_SHIFT;
+
+	if (pages > PIPE_BUFFERS)
+		pages = PIPE_BUFFERS;
+
+	/*
+	 * Get as many pages from the page cache as possible..
+	 * Start IO on the page cache entries we create (we
+	 * can assume that any pre-existing ones we find have
+	 * already had IO started on them).
+	 */
+	i = find_get_pages(mapping, index, pages, array);
+
+	/*
+	 * If not all pages were in the page-cache, we'll
+	 * just assume that the rest haven't been read in,
+	 * so we'll get the rest locked and start IO on
+	 * them if we can..
+	 */
+	while (i < pages) {
+		struct page *page;
+		int error;
+
+		page = find_or_create_page(mapping, index + i, GFP_USER);
+		if (!page)
+			break;
+
+		if (PageUptodate(page))
+			unlock_page(page);
+		else {
+			error = mapping->a_ops->readpage(in, page);
+			if (unlikely(error)) {
+				page_cache_release(page);
+				break;
+			}
+		}
+
+		array[i++] = page;
+	}
+
+	if (!i)
+		return 0;
+
+	/*
+	 * Now we splice them into the pipe..
+	 */
+	return move_to_pipe(pipe, array, i, offset, len);
+}
+
+ssize_t generic_file_splice_read(struct file *in, struct inode *pipe,
+				 size_t len, unsigned long flags)
+{
+	ssize_t spliced;
+	int ret;
+
+	ret = 0;
+	spliced = 0;
+	while (len) {
+		ret = __generic_file_splice_read(in, pipe, len);
+
+		if (ret <= 0)
+			break;
+
+		in->f_pos += ret;
+		len -= ret;
+		spliced += ret;
+	}
+
+	if (spliced)
+		return spliced;
+
+	return ret;
+}
+
+/*
+ * This is a little more tricky than the file -> pipe splicing. There are
+ * basically three cases:
+ *
+ *	- Destination page already exists in the address space and there
+ *	  are users of it. For that case we have no other option that
+ *	  copying the data. Tough luck.
+ *	- Destination page already exists in the address space, but there
+ *	  are no users of it. Make sure it's uptodate, then drop it. Fall
+ *	  through to last case.
+ *	- Destination page does not exist, we can add the pipe page to
+ *	  the page cache and avoid the copy.
+ *
+ * For now we just ignore the case where the page exists but has no users.
+ * Additionally, we have to do the copy if we cannot unmap the source page.
+ */
+static int move_from_pipe(struct pipe_inode_info *info, struct pipe_buffer *buf,
+			  struct file *file, unsigned int len,
+			  unsigned long long pos)
+{
+	struct address_space *mapping = file->f_mapping;
+	struct page *file_page, *buf_page;
+	unsigned long long index;
+	unsigned int offset;
+	char *src, *dst;
+	int ret;
+
+	/*
+	 * after this, page will be locked and unmapped
+	 */
+	src = buf->ops->map(file, info, buf);
+	if (!src)
+		return -EIO;
+
+	index = pos >> PAGE_CACHE_SHIFT;
+	offset = pos & ~PAGE_CACHE_MASK;
+	buf_page = buf->page;
+	file_page = NULL;
+
+	/*
+	 * fast and, by far, normal case - we don't have to copy, just map
+	 * the page to the file address space and initiate the write out
+	 */
+	if (!buf->copy_page &&
+	    !add_to_page_cache_lru(buf_page, mapping, index, GFP_USER)) {
+		ret = mapping->a_ops->prepare_write(file, buf_page, 0, len);
+		if (unlikely(ret)) {
+			unlock_page(buf_page);
+			goto out;
+		}
+
+		ret = mapping->a_ops->commit_write(file, buf_page, 0, len);
+		if (unlikely(ret)) {
+			unlock_page(buf_page);
+			goto out;
+		}
+
+		/*
+		 * writeout will unlock the page later
+		 */
+		set_page_dirty(buf_page);
+		ret = write_one_page(buf_page, 0);
+	} else {
+		/*
+		 * slow path, create the destination page, copy data over,
+		 * and mark dirty for later write out
+		 */
+
+		/*
+		 * if we got here because adding to page cache failed,
+		 * it's also a copy operation
+		 */
+		buf->copy_page = 1;
+
+		ret = -ENOMEM;
+		file_page = find_or_create_page(mapping, index, GFP_USER);
+		if (!file_page)
+			goto out;
+
+		/*
+		 * If the page is uptodate, it is also locked. If it isn't
+		 * uptodate, we can mark it uptodate if we are filling the
+		 * full page. Otherwise we need to read it in first...
+		 */
+		if (!PageUptodate(file_page)) {
+			if (len < PAGE_CACHE_SIZE) {
+				ret = mapping->a_ops->readpage(file, file_page);
+				if (unlikely(ret))
+					goto out;
+
+				lock_page(file_page);
+			} else {
+				WARN_ON(!PageLocked(file_page));
+				SetPageUptodate(file_page);
+			}
+		}
+
+		dst = kmap_atomic(file_page, KM_USER0);
+		memcpy(dst + offset, src + buf->offset, len);
+		flush_dcache_page(file_page);
+		kunmap_atomic(dst, KM_USER0);
+		set_page_dirty(file_page);
+
+		ret = 0;
+	}
+
+out:
+	if (file_page) {
+		unlock_page(file_page);
+		page_cache_release(file_page);
+	}
+
+	buf->ops->unmap(info, buf);
+	return ret;
+}
+
+ssize_t generic_file_splice_write(struct inode *inode, struct file *out,
+				  size_t len, unsigned long flags)
+{
+	struct pipe_inode_info *info;
+	unsigned long long pos;
+	int ret, do_wakeup, err;
+
+	pos = out->f_pos;
+	ret = 0;
+	do_wakeup = 0;
+
+	down(PIPE_SEM(*inode));
+
+	info = inode->i_pipe;
+	for (;;) {
+		int bufs = info->nrbufs;
+
+		if (bufs) {
+			int curbuf = info->curbuf;
+			struct pipe_buffer *buf = info->bufs + curbuf;
+			struct pipe_buf_operations *ops = buf->ops;
+			unsigned int this_len;
+
+			this_len = buf->len;
+			if (this_len > len)
+				this_len = len;
+
+			err = move_from_pipe(info, buf, out, this_len, pos);
+			if (err) {
+				if (!ret)
+					ret = err;
+
+				break;
+			}
+
+			ret += this_len;
+			buf->offset += this_len;
+			buf->len -= this_len;
+			if (!buf->len) {
+				buf->ops = NULL;
+				ops->release(info, buf);
+				curbuf = (curbuf + 1) & (PIPE_BUFFERS - 1);
+				info->curbuf = curbuf;
+				info->nrbufs = --bufs;
+				do_wakeup = 1;
+			}
+
+			pos += this_len;
+			len -= this_len;
+			if (!len)
+				break;
+		}
+
+		if (bufs)
+			continue;
+		if (!PIPE_WRITERS(*inode))
+			break;
+		if (!PIPE_WAITING_WRITERS(*inode)) {
+			if (ret)
+				break;
+		}
+
+		if (signal_pending(current)) {
+			if (!ret)
+				ret = -ERESTARTSYS;
+			break;
+		}
+
+		if (do_wakeup) {
+			wake_up_interruptible_sync(PIPE_WAIT(*inode));
+			kill_fasync(PIPE_FASYNC_WRITERS(*inode),SIGIO,POLL_OUT);
+			do_wakeup = 0;
+		}
+
+		pipe_wait(inode);
+	}
+
+	up(PIPE_SEM(*inode));
+
+	if (do_wakeup) {
+		wake_up_interruptible(PIPE_WAIT(*inode));
+		kill_fasync(PIPE_FASYNC_WRITERS(*inode), SIGIO, POLL_OUT);
+	}
+
+	out->f_pos = pos;
+	return ret;
+}
+
+
+static long do_splice_from(struct inode *pipe, struct file *out, size_t len,
+			   unsigned long flags)
+{
+	if (out->f_op && out->f_op->splice_write)
+		return out->f_op->splice_write(pipe, out, len, flags);
+
+	return -EINVAL;
+}
+
+static long do_splice_to(struct file *in, struct inode *pipe, size_t len,
+			 unsigned long flags)
+{
+	if (in->f_op && in->f_op->splice_read) {
+		loff_t isize = i_size_read(in->f_mapping->host);
+		size_t left;
+
+		if (unlikely(in->f_pos >= isize))
+			return 0;
+	
+		left = isize - in->f_pos;
+		if (left < len)
+			len = left;
+
+		return in->f_op->splice_read(in, pipe, len, flags);
+	}
+
+	return -EINVAL;
+}
+
+static long do_splice(struct file *in, struct file *out, size_t len,
+		      unsigned long flags)
+{
+	struct inode *pipe;
+
+	pipe = in->f_dentry->d_inode;
+	if (pipe->i_pipe)
+		return do_splice_from(pipe, out, len, flags);
+
+	pipe = out->f_dentry->d_inode;
+	if (pipe->i_pipe)
+		return do_splice_to(in, pipe, len, flags);
+
+	return -EINVAL;
+}
+
+asmlinkage long sys_splice(int fdin, int fdout, size_t len, unsigned long flags)
+{
+	long error;
+	struct file *in, *out;
+	int fput_in, fput_out;
+
+	if (unlikely(!len))
+		return 0;
+
+	error = -EBADF;
+	in = fget_light(fdin, &fput_in);
+	if (in) {
+		if (in->f_mode & FMODE_READ) {
+			out = fget_light(fdout, &fput_out);
+			if (out) {
+				if (out->f_mode & FMODE_WRITE)
+					error = do_splice(in, out, len, flags);
+				fput_light(out, fput_out);
+			}
+		}
+
+		fput_light(in, fput_in);
+	}
+
+	return error;
+}
diff --git a/include/asm-i386/unistd.h b/include/asm-i386/unistd.h
index 0f92e78..623ed31 100644
--- a/include/asm-i386/unistd.h
+++ b/include/asm-i386/unistd.h
@@ -299,8 +299,9 @@
 #define __NR_inotify_init	291
 #define __NR_inotify_add_watch	292
 #define __NR_inotify_rm_watch	293
+#define __NR_splice		294
 
-#define NR_syscalls 294
+#define NR_syscalls 295
 
 /*
  * user-visible error numbers are in the range -1 - -128: see
diff --git a/include/asm-powerpc/unistd.h b/include/asm-powerpc/unistd.h
index 0991dfc..1ef5271 100644
--- a/include/asm-powerpc/unistd.h
+++ b/include/asm-powerpc/unistd.h
@@ -296,8 +296,9 @@
 #define __NR_inotify_init	275
 #define __NR_inotify_add_watch	276
 #define __NR_inotify_rm_watch	277
+#define __NR_splice		278
 
-#define __NR_syscalls		278
+#define __NR_syscalls		279
 
 #ifdef __KERNEL__
 #define __NR__exit __NR_exit
diff --git a/include/asm-x86_64/unistd.h b/include/asm-x86_64/unistd.h
index 2c42150..142b938 100644
--- a/include/asm-x86_64/unistd.h
+++ b/include/asm-x86_64/unistd.h
@@ -571,8 +571,10 @@ __SYSCALL(__NR_inotify_init, sys_inotify
 __SYSCALL(__NR_inotify_add_watch, sys_inotify_add_watch)
 #define __NR_inotify_rm_watch	255
 __SYSCALL(__NR_inotify_rm_watch, sys_inotify_rm_watch)
+#define __NR_splice		256
+__SYSCALL(__NR_splice, sys_splice)
 
-#define __NR_syscall_max __NR_inotify_rm_watch
+#define __NR_syscall_max __NR_splice
 #ifndef __NO_STUBS
 
 /* user-visible error numbers are in the range -1 - -4095 */
diff --git a/include/linux/fs.h b/include/linux/fs.h
index cc35b6a..9725b00 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -995,6 +995,8 @@ struct file_operations {
 	int (*check_flags)(int);
 	int (*dir_notify)(struct file *filp, unsigned long arg);
 	int (*flock) (struct file *, int, struct file_lock *);
+	ssize_t (*splice_write)(struct inode *, struct file *, size_t, unsigned long);
+	ssize_t (*splice_read)(struct file *, struct inode *, size_t, unsigned long);
 };
 
 struct inode_operations {
@@ -1538,6 +1540,8 @@ extern ssize_t generic_file_sendfile(str
 extern void do_generic_mapping_read(struct address_space *mapping,
 				    struct file_ra_state *, struct file *,
 				    loff_t *, read_descriptor_t *, read_actor_t);
+extern ssize_t generic_file_splice_read(struct file *, struct inode *, size_t, unsigned long);
+extern ssize_t generic_file_splice_write(struct inode *, struct file *, size_t, unsigned long);
 extern void
 file_ra_state_init(struct file_ra_state *ra, struct address_space *mapping);
 extern ssize_t generic_file_readv(struct file *filp, const struct iovec *iov, 
diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
index 1767073..966d535 100644
--- a/include/linux/pipe_fs_i.h
+++ b/include/linux/pipe_fs_i.h
@@ -8,6 +8,7 @@
 struct pipe_buffer {
 	struct page *page;
 	unsigned int offset, len;
+	unsigned int copy_page;
 	struct pipe_buf_operations *ops;
 };
 
@@ -16,6 +17,7 @@ struct pipe_buf_operations {
 	void * (*map)(struct file *, struct pipe_inode_info *, struct pipe_buffer *);
 	void (*unmap)(struct pipe_inode_info *, struct pipe_buffer *);
 	void (*release)(struct pipe_inode_info *, struct pipe_buffer *);
+	int (*claim)(struct pipe_inode_info *, struct pipe_buffer *);
 };
 
 struct pipe_inode_info {
-- 
0.99.9.GIT

-- 
Jens Axboe


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="splice-in.c"

/*
 * Splice argument file to stdout
 */
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>

#if defined(__i386__)
#define __NR_splice	294
#elif defined(__x86_64__)
#define __NR_splice	256
#elif defined(__powerpc__) || defined(__powerpc64__)
#define __NR_splice	278
#else
#error unsupported arch
#endif

static inline int splice(int fdin, int fdout, size_t len, unsigned long flags)
{
	return syscall(__NR_splice, fdin, fdout, len, flags);
}

int main(int argc, char *argv[])
{
	struct stat sb;
	int fd;

	if (argc < 2) {
		printf("%s: infile\n", argv[0]);
		return 1;
	}

	fd = open(argv[1], O_RDONLY);
	if (fd < 0) {
		perror("open");
		return 1;
	}

	if (fstat(fd, &sb) < 0) {
		perror("stat");
		return 1;
	}

	do {
		int ret = splice(fd, STDOUT_FILENO, sb.st_size, 0);

		if (ret < 0) {
			perror("splice");
			break;
		} else if (!ret)
			break;

		sb.st_size -= ret;
	} while (1);

	close(fd);
	return 0;
}

--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="splice-out.c"

/*
 * Splice argument file to stdout
 */
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>

#define SPLICE_SIZE	(64*1024)

#if defined(__i386__)
#define __NR_splice	294
#elif defined(__x86_64__)
#define __NR_splice	256
#elif defined(__powerpc__) || defined(__powerpc64__)
#define __NR_splice	278
#else
#error unsupported arch
#endif

static inline int splice(int fdin, int fdout, size_t len, unsigned long flags)
{
	return syscall(__NR_splice, fdin, fdout, len, flags);
}

int main(int argc, char *argv[])
{
	int fd;

	if (argc < 2) {
		printf("%s: outfile\n", argv[0]);
		return 1;
	}

	fd = open(argv[1], O_WRONLY | O_CREAT | O_TRUNC, 0644);
	if (fd < 0) {
		perror("open");
		return 1;
	}

	do {
		int ret = splice(STDIN_FILENO, fd, SPLICE_SIZE, 0);

		if (ret < 0) {
			perror("splice");
			break;
		} else if (!ret)
			break;
	} while (1);

	close(fd);
	return 0;
}

--/04w6evG8XlLl3ft--
