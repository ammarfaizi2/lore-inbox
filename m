Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262409AbVAPDA7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262409AbVAPDA7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 22:00:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262410AbVAPDA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 22:00:59 -0500
Received: from fw.osdl.org ([65.172.181.6]:2181 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262409AbVAPC76 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 21:59:58 -0500
Date: Sat, 15 Jan 2005 18:59:51 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Oeser <ioe-lkml@axxeo.de>
cc: linux@horizon.com, Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Make pipe data structure be a circular list of pages, rather
In-Reply-To: <Pine.LNX.4.58.0501141550000.2310@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0501151838010.8178@ppc970.osdl.org>
References: <20050108082535.24141.qmail@science.horizon.com>
 <200501142312.50861.ioe-lkml@axxeo.de> <Pine.LNX.4.58.0501141430320.2310@ppc970.osdl.org>
 <200501150034.31880.ioe-lkml@axxeo.de> <Pine.LNX.4.58.0501141550000.2310@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 14 Jan 2005, Linus Torvalds wrote:
> 
> So I don't think you'll get _exactly_ what you want for a while, since
> you'd have to go through in-memory buffers. But there's no huge conceptual
> problem (just enough implementation issues to make it inconvenient) with
> the concept of actually keeping the buffer on an external controller.

Here is, if you are interested, a slightly updated version of my 
"work-in-progress" example patch. It:

 - depends on a fairly recent -BK (since it uses the pipe buffer ops
   interfaces that I already checked in)
 - is very ugly: the VFS interfaces to splice things really are very wrong 
   indeed, and they _should_ be about passing "struct pipe_buffer" arrays
   around instead.
 - it only does one specific case (splicing from the page cache directly
   into a pipe)
 - only set up for ext3 right now (though the "generic_file_splice" thing 
   should work for any page-cache user)
 - and even that specific case it does wrong since it doesn't update the
   "f_pos" field right now
 - error handling is broken - if an IO error happens on the splice, the 
   "map()" operation will return NULL, and the current fs/pipe.c can't 
   handle that and will oops ;)

so it really is _purely_ a demonstration vehicle, but it at least shows
the kind of operation that I'm thinking of.

An example program to show its use is a simple:

	#include <fcntl.h>
	#include <unistd.h>
	#include <linux/unistd.h>
	
	#define __NR_sys_splice 289
	
	inline _syscall4(int, sys_splice, int, a, int, b, size_t, len, unsigned long, flags);
	
	int main(int argc, char **argv)
	{
		int fd = open(argv[1], O_RDONLY);
		if (fd < 0) {
			perror("open");
			exit(1);
		}
		write(1,"hello: ", 7);
		sys_splice(fd, 1, 1000, 0);
	}

which demonstrates three things: 

 - it works on a perfectly regular pipe, with no special setup, so to use 
   it you can just do

	./test-splice my-file | less

   and the normal pipe that the shell created for this will just work. No 
   new magic fd's required.

 - that you can combine different sources to the pipe (mixing a 
   traditional static write with a "splice from a file").

 - we start the IO when we do the splice, but the waiting for the result 
   happens separately, when (or if) the data is used by the other end.

it will print out "hello: " followed by the first 1000 bytes of the file.

It's obviously not very useful for anything but demonstration, since
splicing the other way (from a pipe to another fd) isn't implemented by
this example, but it gives a more concrete example of what I'm thinking
of.

And shows that the splicing itself is pretty simple ("move_to_pipe()"  
does all the moving of buffers to the pipe) - the rest is just regular
setup and finding of the pages in the page cache.

			Linus

----
# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2005/01/15 18:36:19-08:00 torvalds@evo.osdl.org 
#   sys_splice: take 3
#   
#   Still horribly bad VFS interface, still doing the pipe
#   filling inside the per-fd callback instead of doing it
#   in "generic code" in fs/splice.c.
#   
#   Need to pass in (and out) arrays of "struct pipe_buffer"
#   on a VFS level instead.
# 
# fs/splice.c
#   2005/01/15 18:36:07-08:00 torvalds@evo.osdl.org +229 -0
# 
# include/linux/fs.h
#   2005/01/15 18:36:07-08:00 torvalds@evo.osdl.org +2 -0
#   sys_splice: take 3
#   
#   Still horribly bad VFS interface, still doing the pipe
#   filling inside the per-fd callback instead of doing it
#   in "generic code" in fs/splice.c.
#   
#   Need to pass in (and out) arrays of "struct pipe_buffer"
#   on a VFS level instead.
# 
# include/asm-i386/unistd.h
#   2005/01/15 18:36:07-08:00 torvalds@evo.osdl.org +2 -1
#   sys_splice: take 3
#   
#   Still horribly bad VFS interface, still doing the pipe
#   filling inside the per-fd callback instead of doing it
#   in "generic code" in fs/splice.c.
#   
#   Need to pass in (and out) arrays of "struct pipe_buffer"
#   on a VFS level instead.
# 
# fs/splice.c
#   2005/01/15 18:36:07-08:00 torvalds@evo.osdl.org +0 -0
#   BitKeeper file /home/torvalds/v2.6/linux/fs/splice.c
# 
# fs/ext3/file.c
#   2005/01/15 18:36:07-08:00 torvalds@evo.osdl.org +3 -0
#   sys_splice: take 3
#   
#   Still horribly bad VFS interface, still doing the pipe
#   filling inside the per-fd callback instead of doing it
#   in "generic code" in fs/splice.c.
#   
#   Need to pass in (and out) arrays of "struct pipe_buffer"
#   on a VFS level instead.
# 
# fs/Makefile
#   2005/01/15 18:36:07-08:00 torvalds@evo.osdl.org +1 -0
#   sys_splice: take 3
#   
#   Still horribly bad VFS interface, still doing the pipe
#   filling inside the per-fd callback instead of doing it
#   in "generic code" in fs/splice.c.
#   
#   Need to pass in (and out) arrays of "struct pipe_buffer"
#   on a VFS level instead.
# 
# arch/i386/kernel/entry.S
#   2005/01/15 18:36:07-08:00 torvalds@evo.osdl.org +1 -0
#   sys_splice: take 3
#   
#   Still horribly bad VFS interface, still doing the pipe
#   filling inside the per-fd callback instead of doing it
#   in "generic code" in fs/splice.c.
#   
#   Need to pass in (and out) arrays of "struct pipe_buffer"
#   on a VFS level instead.
# 
diff -Nru a/arch/i386/kernel/entry.S b/arch/i386/kernel/entry.S
--- a/arch/i386/kernel/entry.S	2005-01-15 18:36:40 -08:00
+++ b/arch/i386/kernel/entry.S	2005-01-15 18:36:40 -08:00
@@ -864,5 +864,6 @@
 	.long sys_add_key
 	.long sys_request_key
 	.long sys_keyctl
+	.long sys_splice
 
 syscall_table_size=(.-sys_call_table)
diff -Nru a/fs/Makefile b/fs/Makefile
--- a/fs/Makefile	2005-01-15 18:36:40 -08:00
+++ b/fs/Makefile	2005-01-15 18:36:40 -08:00
@@ -10,6 +10,7 @@
 		ioctl.o readdir.o select.o fifo.o locks.o dcache.o inode.o \
 		attr.o bad_inode.o file.o filesystems.o namespace.o aio.o \
 		seq_file.o xattr.o libfs.o fs-writeback.o mpage.o direct-io.o \
+		splice.o
 
 obj-$(CONFIG_EPOLL)		+= eventpoll.o
 obj-$(CONFIG_COMPAT)		+= compat.o
diff -Nru a/fs/ext3/file.c b/fs/ext3/file.c
--- a/fs/ext3/file.c	2005-01-15 18:36:40 -08:00
+++ b/fs/ext3/file.c	2005-01-15 18:36:40 -08:00
@@ -101,6 +101,8 @@
 	return ret;
 }
 
+extern ssize_t generic_file_splice_read(struct file *in, struct inode *pipe, size_t len, unsigned long flags);
+
 struct file_operations ext3_file_operations = {
 	.llseek		= generic_file_llseek,
 	.read		= do_sync_read,
@@ -115,6 +117,7 @@
 	.release	= ext3_release_file,
 	.fsync		= ext3_sync_file,
 	.sendfile	= generic_file_sendfile,
+	.splice_read	= generic_file_splice_read,
 };
 
 struct inode_operations ext3_file_inode_operations = {
diff -Nru a/fs/splice.c b/fs/splice.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/fs/splice.c	2005-01-15 18:36:40 -08:00
@@ -0,0 +1,229 @@
+/*
+ * linux/fs/splice.c
+ *
+ * "splice": joining two ropes together by interweaving their strands.
+ *
+ * This is the "extended pipe" functionality, where a pipe is used as
+ * an arbitrary in-memory buffer. Think of a pipe as a small kernel
+ * buffer that you can use to transfer data from one end to the other.
+ *
+ * The traditional unix read/write is extended with a "splice()" operation
+ * that transfers data buffers to or from a pipe buffer.
+ *
+ * Named by Larry McVoy.
+ */
+#include <linux/fs.h>
+#include <linux/file.h>
+#include <linux/pagemap.h>
+#include <linux/pipe_fs_i.h>
+
+static void page_cache_pipe_buf_release(struct pipe_inode_info *info, struct pipe_buffer *buf)
+{
+	page_cache_release(buf->page);
+}
+
+static void *page_cache_pipe_buf_map(struct file *file, struct pipe_inode_info *info, struct pipe_buffer *buf)
+{
+	struct page *page = buf->page;
+
+	if (!PageUptodate(page)) {
+		wait_on_page_locked(page);
+		if (!PageUptodate(page))
+			return NULL;
+	}
+	return kmap(page);
+}
+
+static void page_cache_pipe_buf_unmap(struct pipe_inode_info *info, struct pipe_buffer *buf)
+{
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
+static ssize_t move_to_pipe(struct inode *inode, struct page **array, int pages, unsigned long offset, unsigned long len)
+{
+	struct pipe_inode_info *info;
+	int ret, do_wakeup;
+
+	down(PIPE_SEM(*inode));
+	info = inode->i_pipe;
+	ret = 0;
+	do_wakeup = 0;
+	for (;;) {
+		int bufs;
+
+		if (!PIPE_READERS(*inode)) {
+			send_sig(SIGPIPE, current, 0);
+			if (!ret) ret = -EPIPE;
+			break;
+		}
+		bufs = info->nrbufs;
+		if (bufs < PIPE_BUFFERS) {
+			int newbuf = (info->curbuf + bufs) & (PIPE_BUFFERS-1);
+			struct pipe_buffer *buf = info->bufs + newbuf;
+			struct page *page = *array++;
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
+			break;
+		}
+		if (signal_pending(current)) {
+			if (!ret) ret = -ERESTARTSYS;
+			break;
+		}
+		if (do_wakeup) {
+			wake_up_interruptible_sync(PIPE_WAIT(*inode));
+			kill_fasync(PIPE_FASYNC_READERS(*inode), SIGIO, POLL_IN);
+			do_wakeup = 0;
+		}
+		PIPE_WAITING_WRITERS(*inode)++;
+		pipe_wait(inode);
+		PIPE_WAITING_WRITERS(*inode)--;
+	}
+	up(PIPE_SEM(*inode));
+	if (do_wakeup) {
+		wake_up_interruptible(PIPE_WAIT(*inode));
+		kill_fasync(PIPE_FASYNC_READERS(*inode), SIGIO, POLL_IN);
+	}
+	while (--pages >= 0)
+		page_cache_release(*++array);
+	return ret;
+}
+
+ssize_t generic_file_splice_read(struct file *in, struct inode *pipe, size_t len, unsigned long flags)
+{
+	struct address_space *mapping = in->f_mapping;
+	unsigned long long pos, size, left;
+	unsigned long index, offset, pages;
+	struct page *array[PIPE_BUFFERS];
+	int i;
+
+	pos = in->f_pos;
+	size = i_size_read(mapping->host);
+	if (pos >= size)
+		return 0;
+	left = size - pos;
+	if (left < len)
+		len = left;
+	index = pos >> PAGE_CACHE_SHIFT;   
+	offset = pos & ~PAGE_CACHE_MASK;
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
+		struct page *page = find_or_create_page(mapping, index + i, GFP_USER);
+		int error;
+		if (!page)
+			break;
+		if (PageUptodate(page)) {
+			unlock_page(page);
+		} else {
+			error = mapping->a_ops->readpage(in, page);
+			if (unlikely(error)) {
+				page_cache_release(page);
+				break;
+			}
+		}
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
+static long do_splice_from(struct inode *pipe, struct file *out, size_t len, unsigned long flags)
+{
+	if (out->f_op && out->f_op->splice_write)
+		return out->f_op->splice_write(pipe, out, len, flags);
+	return -EINVAL;
+}
+
+static long do_splice_to(struct file *in, struct inode *pipe, size_t len, unsigned long flags)
+{
+	if (in->f_op && in->f_op->splice_read)
+		return in->f_op->splice_read(in, pipe, len, flags);
+	return -EINVAL;
+}
+
+static long do_splice(struct file *in, struct file *out, size_t len, unsigned long flags)
+{
+	struct inode *pipe;
+
+	if (!len)
+		return 0;
+	pipe = in->f_dentry->d_inode;
+	if (pipe->i_pipe)
+		return do_splice_from(pipe, out, len, flags);
+	pipe = out->f_dentry->d_inode;
+	if (pipe->i_pipe)
+		return do_splice_to(in, pipe, len, flags);
+	return -EINVAL;
+}
+
+asmlinkage long sys_splice(int fdin, int fdout, size_t len, unsigned long flags)
+{
+	long error;
+	struct file *in, *out;
+	int fput_in, fput_out;
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
+		fput_light(in, fput_in);
+	}
+	return error;
+}
diff -Nru a/include/asm-i386/unistd.h b/include/asm-i386/unistd.h
--- a/include/asm-i386/unistd.h	2005-01-15 18:36:40 -08:00
+++ b/include/asm-i386/unistd.h	2005-01-15 18:36:40 -08:00
@@ -294,8 +294,9 @@
 #define __NR_add_key		286
 #define __NR_request_key	287
 #define __NR_keyctl		288
+#define __NR_splice		289
 
-#define NR_syscalls 289
+#define NR_syscalls 290
 
 /*
  * user-visible error numbers are in the range -1 - -128: see
diff -Nru a/include/linux/fs.h b/include/linux/fs.h
--- a/include/linux/fs.h	2005-01-15 18:36:40 -08:00
+++ b/include/linux/fs.h	2005-01-15 18:36:40 -08:00
@@ -944,6 +944,8 @@
 	int (*check_flags)(int);
 	int (*dir_notify)(struct file *filp, unsigned long arg);
 	int (*flock) (struct file *, int, struct file_lock *);
+	ssize_t (*splice_write)(struct inode *, struct file *, size_t, unsigned long);
+	ssize_t (*splice_read)(struct file *, struct inode *, size_t, unsigned long);
 };
 
 struct inode_operations {
