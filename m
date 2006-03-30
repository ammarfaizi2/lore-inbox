Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932147AbWC3KG1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbWC3KG1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 05:06:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbWC3KG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 05:06:26 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:53806 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932147AbWC3KG0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 05:06:26 -0500
Date: Thu, 30 Mar 2006 12:06:31 +0200
From: Jens Axboe <axboe@suse.de>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, torvalds@osdl.org
Subject: [PATCH] splice support #2
Message-ID: <20060330100630.GT13476@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch should resolve all issues mentioned so far. I'd still like to
implement the page moving, but that should just be a separate patch.
After this round of patching, I thought I'd toss a fresh version out
there for all to look at.

Signed-off-by: Jens Axboe <axboe@suse.de>

diff --git a/arch/i386/kernel/syscall_table.S b/arch/i386/kernel/syscall_table.S
index 326595f..ce3ef4f 100644
--- a/arch/i386/kernel/syscall_table.S
+++ b/arch/i386/kernel/syscall_table.S
@@ -312,3 +312,4 @@ ENTRY(sys_call_table)
 	.long sys_unshare		/* 310 */
 	.long sys_set_robust_list
 	.long sys_get_robust_list
+	.long sys_splice
diff --git a/arch/ia64/kernel/entry.S b/arch/ia64/kernel/entry.S
index 0e3eda9..14480d9 100644
--- a/arch/ia64/kernel/entry.S
+++ b/arch/ia64/kernel/entry.S
@@ -1605,5 +1605,6 @@ sys_call_table:
 	data8 sys_ni_syscall			// reserved for pselect
 	data8 sys_ni_syscall			// 1295 reserved for ppoll
 	data8 sys_unshare
+	date8 sys_splice
 
 	.org sys_call_table + 8*NR_syscalls	// guard against failures to increase NR_syscalls
diff --git a/fs/Makefile b/fs/Makefile
index 080b386..f3a4f70 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -10,7 +10,7 @@ obj-y :=	open.o read_write.o file_table.
 		ioctl.o readdir.o select.o fifo.o locks.o dcache.o inode.o \
 		attr.o bad_inode.o file.o filesystems.o namespace.o aio.o \
 		seq_file.o xattr.o libfs.o fs-writeback.o mpage.o direct-io.o \
-		ioprio.o pnode.o drop_caches.o
+		ioprio.o pnode.o drop_caches.o splice.o
 
 obj-$(CONFIG_INOTIFY)		+= inotify.o
 obj-$(CONFIG_EPOLL)		+= eventpoll.o
diff --git a/fs/ext2/file.c b/fs/ext2/file.c
index 509ccec..23e2c7c 100644
--- a/fs/ext2/file.c
+++ b/fs/ext2/file.c
@@ -53,6 +53,8 @@ const struct file_operations ext2_file_o
 	.readv		= generic_file_readv,
 	.writev		= generic_file_writev,
 	.sendfile	= generic_file_sendfile,
+	.splice_read	= generic_file_splice_read,
+	.splice_write	= generic_file_splice_write,
 };
 
 #ifdef CONFIG_EXT2_FS_XIP
diff --git a/fs/ext3/file.c b/fs/ext3/file.c
index 783a796..1efefb6 100644
--- a/fs/ext3/file.c
+++ b/fs/ext3/file.c
@@ -119,6 +119,8 @@ const struct file_operations ext3_file_o
 	.release	= ext3_release_file,
 	.fsync		= ext3_sync_file,
 	.sendfile	= generic_file_sendfile,
+	.splice_read	= generic_file_splice_read,
+	.splice_write	= generic_file_splice_write,
 };
 
 struct inode_operations ext3_file_inode_operations = {
diff --git a/fs/pipe.c b/fs/pipe.c
index e2f4f1d..aef9ad7 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -15,6 +15,7 @@ #include <linux/mount.h>
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
diff --git a/fs/reiserfs/file.c b/fs/reiserfs/file.c
index 010094d..cf6e1cf 100644
--- a/fs/reiserfs/file.c
+++ b/fs/reiserfs/file.c
@@ -1576,6 +1576,8 @@ const struct file_operations reiserfs_fi
 	.sendfile = generic_file_sendfile,
 	.aio_read = generic_file_aio_read,
 	.aio_write = reiserfs_aio_write,
+	.splice_read = generic_file_splice_read,
+	.splice_write = generic_file_splice_write,
 };
 
 struct inode_operations reiserfs_file_inode_operations = {
diff --git a/fs/splice.c b/fs/splice.c
new file mode 100644
index 0000000..b63db3f
--- /dev/null
+++ b/fs/splice.c
@@ -0,0 +1,602 @@
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
+/*
+ * Passed to the actors
+ */
+struct splice_desc {
+	unsigned int len, total_len;	/* current and remaining length */
+	unsigned int flags;		/* splice flags */
+	struct file *file;		/* file to read/write */
+	loff_t pos;			/* file position */
+};
+
+static void page_cache_pipe_buf_release(struct pipe_inode_info *info,
+					struct pipe_buffer *buf)
+{
+	page_cache_release(buf->page);
+	buf->page = NULL;
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
+	if (!PageUptodate(page)) {
+		unlock_page(page);
+		return NULL;
+	}
+
+	return kmap(buf->page);
+}
+
+static void page_cache_pipe_buf_unmap(struct pipe_inode_info *info,
+				      struct pipe_buffer *buf)
+{
+	unlock_page(buf->page);
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
+static ssize_t move_to_pipe(struct inode *inode, struct page **pages,
+			    int nr_pages, unsigned long offset,
+			    unsigned long len)
+{
+	struct pipe_inode_info *info;
+	int ret, do_wakeup, i;
+
+	ret = 0;
+	do_wakeup = 0;
+	i = 0;
+
+	mutex_lock(PIPE_MUTEX(*inode));
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
+			struct page *page = pages[i++];
+			unsigned long this_len;
+
+			this_len = PAGE_CACHE_SIZE - offset;
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
+			if (!--nr_pages)
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
+	mutex_unlock(PIPE_MUTEX(*inode));
+
+	if (do_wakeup) {
+		wake_up_interruptible(PIPE_WAIT(*inode));
+		kill_fasync(PIPE_FASYNC_READERS(*inode), SIGIO, POLL_IN);
+	}
+
+	while (i < nr_pages)
+		page_cache_release(pages[i++]);
+
+	return ret;
+}
+
+static int __generic_file_splice_read(struct file *in, struct inode *pipe,
+				      size_t len)
+{
+	struct address_space *mapping = in->f_mapping;
+	unsigned int offset, nr_pages;
+	struct page *pages[PIPE_BUFFERS];
+	struct page *page;
+	pgoff_t index, pidx;
+	int i;
+
+	index = in->f_pos >> PAGE_CACHE_SHIFT;
+	offset = in->f_pos & ~PAGE_CACHE_MASK;
+	nr_pages = (len + offset + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
+
+	if (nr_pages > PIPE_BUFFERS)
+		nr_pages = PIPE_BUFFERS;
+
+	/*
+	 * initiate read-ahead on this page range
+	 */
+	do_page_cache_readahead(mapping, in, index, nr_pages);
+
+	/*
+	 * Get as many pages from the page cache as possible..
+	 * Start IO on the page cache entries we create (we
+	 * can assume that any pre-existing ones we find have
+	 * already had IO started on them).
+	 */
+	i = find_get_pages(mapping, index, nr_pages, pages);
+
+	/*
+	 * common case - we found all pages and they are contiguous,
+	 * kick them off
+	 */
+	if (i && (pages[i - 1]->index == index + i - 1))
+		goto splice_them;
+
+	memset(&pages[i], 0, (nr_pages - i) * sizeof(struct page *));
+
+	/*
+	 * find_get_pages() may not return consecutive pages, so loop
+	 * over the array moving pages and filling the rest, if need be.
+	 */
+	for (i = 0, pidx = index; i < nr_pages; pidx++, i++) {
+		if (!pages[i]) {
+			int error;
+fill_page:
+			/*
+			 * no page there, look one up / create it
+			 */
+			page = find_or_create_page(mapping, pidx,
+						   mapping_gfp_mask(mapping));
+			if (!page)
+				break;
+
+			if (PageUptodate(page))
+				unlock_page(page);
+			else {
+				error = mapping->a_ops->readpage(in, page);
+
+				if (unlikely(error)) {
+					page_cache_release(page);
+					break;
+				}
+			}
+			pages[i] = page;
+		} else if (pages[i]->index != pidx) {
+			page = pages[i];
+			/*
+			 * page isn't in the right spot, move it and jump
+			 * back to filling this one. we know that ->index
+			 * is larger than pidx
+			 */
+			pages[i + page->index - pidx] = page;
+			pages[i] = NULL;
+			goto fill_page;
+		}
+	}
+
+	if (!i)
+		return 0;
+
+	/*
+	 * Now we splice them into the pipe..
+	 */
+splice_them:
+	return move_to_pipe(pipe, pages, i, offset, len);
+}
+
+ssize_t generic_file_splice_read(struct file *in, struct inode *pipe,
+				 size_t len, unsigned int flags)
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
+ * Send 'len' bytes to socket from 'file' at position 'pos' using sendpage().
+ */
+static int pipe_to_sendpage(struct pipe_inode_info *info,
+			    struct pipe_buffer *buf, struct splice_desc *sd)
+{
+	struct file *file = sd->file;
+	loff_t pos = sd->pos;
+	unsigned int offset;
+	ssize_t ret;
+
+	/*
+	 * sub-optimal, but we are limited by the pipe ->map. we don't
+	 * need a kmap'ed buffer here, we just want to make sure we
+	 * have the page pinned if the pipe page originates from the
+	 * page cache
+	 */
+	if (!buf->ops->map(file, info, buf))
+		return -EIO;
+
+	offset = pos & ~PAGE_CACHE_MASK;
+
+	ret = file->f_op->sendpage(file, buf->page, offset, sd->len, &pos,
+					sd->len < sd->total_len);
+
+	buf->ops->unmap(info, buf);
+	if (ret == sd->len)
+		return 0;
+
+	return -EIO;
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
+ * For now we just do the slower thing and always copy pages over, it's
+ * easier than migrating pages from the pipe to the target file. For the
+ * case of doing file | file splicing, the migrate approach had some LRU
+ * nastiness...
+ */
+static int pipe_to_file(struct pipe_inode_info *info, struct pipe_buffer *buf,
+			struct splice_desc *sd)
+{
+	struct file *file = sd->file;
+	struct address_space *mapping = file->f_mapping;
+	unsigned int offset;
+	struct page *page;
+	char *src, *dst;
+	pgoff_t index;
+	int ret;
+
+	/*
+	 * after this, page will be locked and unmapped
+	 */
+	src = buf->ops->map(file, info, buf);
+	if (!src)
+		return -EIO;
+
+	index = sd->pos >> PAGE_CACHE_SHIFT;
+	offset = sd->pos & ~PAGE_CACHE_MASK;
+
+find_page:
+	ret = -ENOMEM;
+	page = find_or_create_page(mapping, index, mapping_gfp_mask(mapping));
+	if (!page)
+		goto out;
+
+	/*
+	 * If the page is uptodate, it is also locked. If it isn't
+	 * uptodate, we can mark it uptodate if we are filling the
+	 * full page. Otherwise we need to read it in first...
+	 */
+	if (!PageUptodate(page)) {
+		if (sd->len < PAGE_CACHE_SIZE) {
+			ret = mapping->a_ops->readpage(file, page);
+			if (unlikely(ret))
+				goto out;
+
+			lock_page(page);
+
+			if (!PageUptodate(page)) {
+				/*
+				 * page got invalidated, repeat
+				 */
+				if (page->mapping == NULL) {
+					unlock_page(page);
+					page_cache_release(page);
+					goto find_page;
+				}
+				ret = -EIO;
+				goto out;
+			}
+		} else {
+			WARN_ON(!PageLocked(page));
+			SetPageUptodate(page);
+		}
+	}
+
+	ret = mapping->a_ops->prepare_write(file, page, 0, sd->len);
+	if (ret)
+		goto out;
+
+	dst = kmap_atomic(page, KM_USER0);
+	memcpy(dst + offset, src + buf->offset, sd->len);
+	flush_dcache_page(page);
+	kunmap_atomic(dst, KM_USER0);
+
+	ret = mapping->a_ops->commit_write(file, page, 0, sd->len);
+	if (ret < 0)
+		goto out;
+
+	set_page_dirty(page);
+	ret = write_one_page(page, 0);
+out:
+	if (ret < 0)
+		unlock_page(page);
+	page_cache_release(page);
+	buf->ops->unmap(info, buf);
+	return ret;
+}
+
+typedef int (splice_actor)(struct pipe_inode_info *, struct pipe_buffer *,
+			   struct splice_desc *);
+
+static ssize_t move_from_pipe(struct inode *inode, struct file *out,
+			      size_t len, unsigned int flags,
+			      splice_actor *actor)
+{
+	struct pipe_inode_info *info;
+	int ret, do_wakeup, err;
+	struct splice_desc sd;
+
+	ret = 0;
+	do_wakeup = 0;
+
+	sd.total_len = len;
+	sd.flags = flags;
+	sd.file = out;
+	sd.pos = out->f_pos;
+
+	mutex_lock(PIPE_MUTEX(*inode));
+
+	info = inode->i_pipe;
+	for (;;) {
+		int bufs = info->nrbufs;
+
+		if (bufs) {
+			int curbuf = info->curbuf;
+			struct pipe_buffer *buf = info->bufs + curbuf;
+			struct pipe_buf_operations *ops = buf->ops;
+
+			sd.len = buf->len;
+			if (sd.len > sd.total_len)
+				sd.len = sd.total_len;
+
+			err = actor(info, buf, &sd);
+			if (err) {
+				if (!ret)
+					ret = err;
+
+				break;
+			}
+
+			ret += sd.len;
+			buf->offset += sd.len;
+			buf->len -= sd.len;
+			if (!buf->len) {
+				buf->ops = NULL;
+				ops->release(info, buf);
+				curbuf = (curbuf + 1) & (PIPE_BUFFERS - 1);
+				info->curbuf = curbuf;
+				info->nrbufs = --bufs;
+				do_wakeup = 1;
+			}
+
+			sd.pos += sd.len;
+			sd.total_len -= sd.len;
+			if (!sd.total_len)
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
+	mutex_unlock(PIPE_MUTEX(*inode));
+
+	if (do_wakeup) {
+		wake_up_interruptible(PIPE_WAIT(*inode));
+		kill_fasync(PIPE_FASYNC_WRITERS(*inode), SIGIO, POLL_OUT);
+	}
+
+	mutex_lock(&out->f_mapping->host->i_mutex);
+	out->f_pos = sd.pos;
+	mutex_unlock(&out->f_mapping->host->i_mutex);
+	return ret;
+
+}
+
+ssize_t generic_file_splice_write(struct inode *inode, struct file *out,
+				  size_t len, unsigned int flags)
+{
+	return move_from_pipe(inode, out, len, flags, pipe_to_file);
+}
+
+ssize_t generic_splice_sendpage(struct inode *inode, struct file *out,
+				size_t len, unsigned int flags)
+{
+	return move_from_pipe(inode, out, len, flags, pipe_to_sendpage);
+}
+
+static long do_splice_from(struct inode *pipe, struct file *out, size_t len,
+			   unsigned int flags)
+{
+	loff_t pos;
+	int ret;
+
+	if (!out->f_op || !out->f_op->splice_write)
+		return -EINVAL;
+
+	if (!(out->f_mode & FMODE_WRITE))
+		return -EBADF;
+
+	pos = out->f_pos;
+	ret = rw_verify_area(WRITE, out, &pos, len);
+	if (unlikely(ret < 0))
+		return ret;
+
+	return out->f_op->splice_write(pipe, out, len, flags);
+}
+
+static long do_splice_to(struct file *in, struct inode *pipe, size_t len,
+			 unsigned int flags)
+{
+	loff_t pos, isize, left;
+	int ret;
+
+	if (!in->f_op || !in->f_op->splice_read)
+		return -EINVAL;
+
+	if (!(in->f_mode & FMODE_READ))
+		return -EBADF;
+
+	pos = in->f_pos;
+	ret = rw_verify_area(READ, in, &pos, len);
+	if (unlikely(ret < 0))
+		return ret;
+
+	isize = i_size_read(in->f_mapping->host);
+	if (unlikely(in->f_pos >= isize))
+		return 0;
+	
+	left = isize - in->f_pos;
+	if (left < len)
+		len = left;
+
+	return in->f_op->splice_read(in, pipe, len, flags);
+}
+
+static long do_splice(struct file *in, struct file *out, size_t len,
+		      unsigned int flags)
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
+asmlinkage long sys_splice(int fdin, int fdout, size_t len, unsigned int flags)
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
index 014e356..789e9bd 100644
--- a/include/asm-i386/unistd.h
+++ b/include/asm-i386/unistd.h
@@ -318,8 +318,9 @@ #define __NR_ppoll		309
 #define __NR_unshare		310
 #define __NR_set_robust_list	311
 #define __NR_get_robust_list	312
+#define __NR_sys_splice		313
 
-#define NR_syscalls 313
+#define NR_syscalls 314
 
 /*
  * user-visible error numbers are in the range -1 - -128: see
diff --git a/include/asm-ia64/unistd.h b/include/asm-ia64/unistd.h
index 019956c..36070c1 100644
--- a/include/asm-ia64/unistd.h
+++ b/include/asm-ia64/unistd.h
@@ -285,12 +285,13 @@ #define __NR_fchmodat			1292
 #define __NR_faccessat			1293
 /* 1294, 1295 reserved for pselect/ppoll */
 #define __NR_unshare			1296
+#define __NR_splice			1297
 
 #ifdef __KERNEL__
 
 #include <linux/config.h>
 
-#define NR_syscalls			273 /* length of syscall table */
+#define NR_syscalls			274 /* length of syscall table */
 
 #define __ARCH_WANT_SYS_RT_SIGACTION
 
diff --git a/include/asm-powerpc/unistd.h b/include/asm-powerpc/unistd.h
index 1e99074..536ba08 100644
--- a/include/asm-powerpc/unistd.h
+++ b/include/asm-powerpc/unistd.h
@@ -301,8 +301,9 @@ #define __NR_spu_create		279
 #define __NR_pselect6		280
 #define __NR_ppoll		281
 #define __NR_unshare		282
+#define __NR_splice		283
 
-#define __NR_syscalls		283
+#define __NR_syscalls		284
 
 #ifdef __KERNEL__
 #define __NR__exit __NR_exit
diff --git a/include/asm-x86_64/unistd.h b/include/asm-x86_64/unistd.h
index fcc5163..f21ff2c 100644
--- a/include/asm-x86_64/unistd.h
+++ b/include/asm-x86_64/unistd.h
@@ -609,8 +609,10 @@ #define __NR_set_robust_list	273
 __SYSCALL(__NR_set_robust_list, sys_set_robust_list)
 #define __NR_get_robust_list	274
 __SYSCALL(__NR_get_robust_list, sys_get_robust_list)
+#define __NR_splice		275
+__SYSCALL(__NR_splice, sys_splice)
 
-#define __NR_syscall_max __NR_get_robust_list
+#define __NR_syscall_max __NR_splice
 
 #ifndef __NO_STUBS
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 408fe89..20fa5f6 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1032,6 +1032,8 @@ struct file_operations {
 	int (*check_flags)(int);
 	int (*dir_notify)(struct file *filp, unsigned long arg);
 	int (*flock) (struct file *, int, struct file_lock *);
+	ssize_t (*splice_write)(struct inode *, struct file *, size_t, unsigned int);
+	ssize_t (*splice_read)(struct file *, struct inode *, size_t, unsigned int);
 };
 
 struct inode_operations {
@@ -1609,6 +1611,8 @@ extern ssize_t generic_file_sendfile(str
 extern void do_generic_mapping_read(struct address_space *mapping,
 				    struct file_ra_state *, struct file *,
 				    loff_t *, read_descriptor_t *, read_actor_t);
+extern ssize_t generic_file_splice_read(struct file *, struct inode *, size_t, unsigned int);
+extern ssize_t generic_file_splice_write(struct inode *, struct file *, size_t, unsigned int);
 extern void
 file_ra_state_init(struct file_ra_state *ra, struct address_space *mapping);
 extern ssize_t generic_file_readv(struct file *filp, const struct iovec *iov, 
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index e487e3b..e78ffc7 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -569,5 +569,7 @@ asmlinkage long compat_sys_newfstatat(un
 asmlinkage long compat_sys_openat(unsigned int dfd, const char __user *filename,
 				   int flags, int mode);
 asmlinkage long sys_unshare(unsigned long unshare_flags);
+asmlinkage long sys_splice(int fdin, int fdout, size_t len,
+				unsigned int flags);
 
 #endif
diff --git a/net/socket.c b/net/socket.c
index fcd77ea..b13042f 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -119,7 +119,10 @@ static ssize_t sock_writev(struct file *
 static ssize_t sock_sendpage(struct file *file, struct page *page,
 			     int offset, size_t size, loff_t *ppos, int more);
 
+extern ssize_t generic_splice_sendpage(struct inode *inode, struct file *out,
+				size_t len, unsigned int flags);
 
+
 /*
  *	Socket files have a set of 'special' operations as well as the generic file ones. These don't appear
  *	in the operation structures but are done directly via the socketcall() multiplexor.
@@ -141,7 +144,8 @@ #endif
 	.fasync =	sock_fasync,
 	.readv =	sock_readv,
 	.writev =	sock_writev,
-	.sendpage =	sock_sendpage
+	.sendpage =	sock_sendpage,
+	.splice_write = generic_splice_sendpage,
 };
 
 /*

-- 
Jens Axboe

