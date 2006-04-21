Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932214AbWDUICS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbWDUICS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 04:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbWDUICR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 04:02:17 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:47945 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932214AbWDUICP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 04:02:15 -0400
Date: Fri, 21 Apr 2006 10:02:40 +0200
From: Jens Axboe <axboe@suse.de>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org, davem@davemloft.net
Subject: [PATCH] sys_vmsplice
Message-ID: <20060421080239.GC4717@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Here's the first implementation of sys_vmsplice(). I'm attaching a
little test app as well for playing with it, it's also committed to the
splice tools repo at:

        git://brick.kernel.dk/data/git/splice.git

Patch is against current Linus -git, it's also included in the splice
branch of the block git repo.

-----

sys_splice() moves data to/from pipes with a file input/output. sys_vmsplice()
moves data to a pipe, with the input being a user address range instead.

Signed-off-by: Jens Axboe <axboe@suse.de>

---

 arch/ia64/kernel/entry.S     |    1 
 arch/powerpc/kernel/systbl.S |    1 
 fs/fcntl.c                   |    8 ++
 fs/splice.c                  |  181 +++++++++++++++++++++++++++++++++++-------
 include/asm-generic/fcntl.h  |    5 +
 include/asm-i386/unistd.h    |    3 -
 include/asm-ia64/unistd.h    |    1 
 include/asm-powerpc/unistd.h |    3 -
 include/asm-x86_64/unistd.h  |    4 +
 include/linux/syscalls.h     |    3 +
 10 files changed, 176 insertions(+), 34 deletions(-)

888642ed2f315862a4cc815c1a9029a328adbd33
diff --git a/arch/ia64/kernel/entry.S b/arch/ia64/kernel/entry.S
index e307988..bcb80ca 100644
--- a/arch/ia64/kernel/entry.S
+++ b/arch/ia64/kernel/entry.S
@@ -1610,5 +1610,6 @@ sys_call_table:
 	data8 sys_get_robust_list
 	data8 sys_sync_file_range		// 1300
 	data8 sys_tee
+	data8 sys_vmsplice
 
 	.org sys_call_table + 8*NR_syscalls	// guard against failures to increase NR_syscalls
diff --git a/arch/powerpc/kernel/systbl.S b/arch/powerpc/kernel/systbl.S
index a14c964..9730315 100644
--- a/arch/powerpc/kernel/systbl.S
+++ b/arch/powerpc/kernel/systbl.S
@@ -324,3 +324,4 @@ COMPAT_SYS(ppoll)
 SYSCALL(unshare)
 SYSCALL(splice)
 SYSCALL(tee)
+SYSCALL(vmsplice)
diff --git a/fs/fcntl.c b/fs/fcntl.c
index d35cbc6..56ac96e 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -18,6 +18,7 @@ #include <linux/security.h>
 #include <linux/ptrace.h>
 #include <linux/signal.h>
 #include <linux/rcupdate.h>
+#include <linux/pipe_fs_i.h>
 
 #include <asm/poll.h>
 #include <asm/siginfo.h>
@@ -345,6 +346,13 @@ static long do_fcntl(int fd, unsigned in
 	case F_NOTIFY:
 		err = fcntl_dirnotify(fd, filp, arg);
 		break;
+	case F_SETPSZ:
+		err = -EINVAL;
+		break;
+	case F_GETPSZ:
+		/* this assumes user space can reliably tell PAGE_CACHE_SIZE */
+		err = PIPE_BUFFERS;
+		break;
 	default:
 		break;
 	}
diff --git a/fs/splice.c b/fs/splice.c
index 0559e75..57d55f2 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -39,6 +39,18 @@ struct splice_desc {
 };
 
 /*
+ * Passed to move_to_pipe
+ */
+struct splice_pipe_desc {
+	struct page **pages;		/* page map */
+	int nr_pages;			/* number of pages in map */
+	unsigned long len;		/* maximum number of bytes to maps */
+	unsigned int offset;		/* offset into first page */
+	unsigned int flags;		/* splice flags */
+	struct pipe_buf_operations *ops;/* ops associated with output pipe */
+};
+
+/*
  * Attempt to steal a page from a pipe buffer. This should perhaps go into
  * a vm helper function, it's already simplified quite a bit by the
  * addition of remove_mapping(). If success is returned, the caller may
@@ -128,6 +140,19 @@ static void page_cache_pipe_buf_unmap(st
 	kunmap(buf->page);
 }
 
+static void *user_page_pipe_buf_map(struct file *file,
+				    struct pipe_inode_info *pipe,
+				    struct pipe_buffer *buf)
+{
+	return kmap(buf->page);
+}
+
+static void user_page_pipe_buf_unmap(struct pipe_inode_info *pipe,
+				     struct pipe_buffer *buf)
+{
+	kunmap(buf->page);
+}
+
 static void page_cache_pipe_buf_get(struct pipe_inode_info *info,
 				    struct pipe_buffer *buf)
 {
@@ -143,13 +168,27 @@ static struct pipe_buf_operations page_c
 	.get = page_cache_pipe_buf_get,
 };
 
+static int user_page_pipe_buf_steal(struct pipe_inode_info *pipe,
+				    struct pipe_buffer *buf)
+{
+	return 1;
+}
+
+static struct pipe_buf_operations user_page_pipe_buf_ops = {
+	.can_merge = 0,
+	.map = user_page_pipe_buf_map,
+	.unmap = user_page_pipe_buf_unmap,
+	.release = page_cache_pipe_buf_release,
+	.steal = user_page_pipe_buf_steal,
+	.get = page_cache_pipe_buf_get,
+};
+
 /*
  * Pipe output worker. This sets up our pipe format with the page cache
  * pipe buffer operations. Otherwise very similar to the regular pipe_writev().
  */
-static ssize_t move_to_pipe(struct pipe_inode_info *pipe, struct page **pages,
-			    int nr_pages, unsigned long len,
-			    unsigned int offset, unsigned int flags)
+static ssize_t move_to_pipe(struct pipe_inode_info *pipe,
+			    struct splice_pipe_desc *spd)
 {
 	int ret, do_wakeup, i;
 
@@ -171,27 +210,27 @@ static ssize_t move_to_pipe(struct pipe_
 		if (pipe->nrbufs < PIPE_BUFFERS) {
 			int newbuf = (pipe->curbuf + pipe->nrbufs) & (PIPE_BUFFERS - 1);
 			struct pipe_buffer *buf = pipe->bufs + newbuf;
-			struct page *page = pages[i++];
+			struct page *page = spd->pages[i++];
 			unsigned long this_len;
 
-			this_len = PAGE_CACHE_SIZE - offset;
-			if (this_len > len)
-				this_len = len;
+			this_len = PAGE_CACHE_SIZE - spd->offset;
+			if (this_len > spd->len)
+				this_len = spd->len;
 
 			buf->page = page;
-			buf->offset = offset;
+			buf->offset = spd->offset;
 			buf->len = this_len;
-			buf->ops = &page_cache_pipe_buf_ops;
+			buf->ops = spd->ops;
 			pipe->nrbufs++;
 			if (pipe->inode)
 				do_wakeup = 1;
 
 			ret += this_len;
-			len -= this_len;
-			offset = 0;
-			if (!--nr_pages)
+			spd->len -= this_len;
+			spd->offset = 0;
+			if (!--spd->nr_pages)
 				break;
-			if (!len)
+			if (!spd->len)
 				break;
 			if (pipe->nrbufs < PIPE_BUFFERS)
 				continue;
@@ -199,7 +238,7 @@ static ssize_t move_to_pipe(struct pipe_
 			break;
 		}
 
-		if (flags & SPLICE_F_NONBLOCK) {
+		if (spd->flags & SPLICE_F_NONBLOCK) {
 			if (!ret)
 				ret = -EAGAIN;
 			break;
@@ -234,8 +273,8 @@ static ssize_t move_to_pipe(struct pipe_
 		kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
 	}
 
-	while (i < nr_pages)
-		page_cache_release(pages[i++]);
+	while (i < spd->nr_pages)
+		page_cache_release(spd->pages[i++]);
 
 	return ret;
 }
@@ -246,17 +285,21 @@ __generic_file_splice_read(struct file *
 			   unsigned int flags)
 {
 	struct address_space *mapping = in->f_mapping;
-	unsigned int loff, offset, nr_pages;
+	unsigned int loff, nr_pages;
 	struct page *pages[PIPE_BUFFERS];
 	struct page *page;
 	pgoff_t index, end_index;
 	loff_t isize;
-	size_t bytes;
-	int i, error;
+	int error;
+	struct splice_pipe_desc spd = {
+		.pages = pages,
+		.flags = flags,
+		.ops = &page_cache_pipe_buf_ops,
+	};
 
 	index = *ppos >> PAGE_CACHE_SHIFT;
-	loff = offset = *ppos & ~PAGE_CACHE_MASK;
-	nr_pages = (len + offset + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
+	loff = spd.offset = *ppos & ~PAGE_CACHE_MASK;
+	nr_pages = (len + loff + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
 
 	if (nr_pages > PIPE_BUFFERS)
 		nr_pages = PIPE_BUFFERS;
@@ -266,15 +309,14 @@ __generic_file_splice_read(struct file *
 	 * read-ahead if this is a non-zero offset (we are likely doing small
 	 * chunk splice and the page is already there) for a single page.
 	 */
-	if (!offset || nr_pages > 1)
-		do_page_cache_readahead(mapping, in, index, nr_pages);
+	if (!spd.offset || spd.nr_pages > 1)
+		do_page_cache_readahead(mapping, in, index, spd.nr_pages);
 
 	/*
 	 * Now fill in the holes:
 	 */
 	error = 0;
-	bytes = 0;
-	for (i = 0; i < nr_pages; i++, index++) {
+	for (spd.nr_pages = 0; spd.nr_pages < nr_pages; spd.nr_pages++, index++) {
 		unsigned int this_len;
 
 		if (!len)
@@ -367,26 +409,26 @@ readpage:
 			 */
 			if (end_index == index) {
 				loff = PAGE_CACHE_SIZE - (isize & ~PAGE_CACHE_MASK);
-				if (bytes + loff > isize) {
+				if (spd.len + loff > isize) {
 					page_cache_release(page);
 					break;
 				}
 				/*
 				 * force quit after adding this page
 				 */
-				nr_pages = i;
+				nr_pages = spd.nr_pages;
 				this_len = min(this_len, loff);
 			}
 		}
 fill_it:
-		pages[i] = page;
-		bytes += this_len;
+		pages[spd.nr_pages] = page;
+		spd.len += this_len;
 		len -= this_len;
 		loff = 0;
 	}
 
-	if (i)
-		return move_to_pipe(pipe, pages, i, bytes, offset, flags);
+	if (spd.nr_pages)
+		return move_to_pipe(pipe, &spd);
 
 	return error;
 }
@@ -1010,6 +1052,83 @@ static long do_splice(struct file *in, l
 	return -EINVAL;
 }
 
+/*
+ * vmsplice splices a user address range into a pipe. It can be thought of
+ * as splice-from-memory, where the regular splice is splice-from-file (or
+ * to file). In both cases the output is a pipe, naturally.
+ *
+ * Note that vmsplice only supports splicing _from_ user memory to a pipe,
+ * not the other way around. Splicing from user memory is a simple operation
+ * that can be supported without any funky alignment restrictions or nasty
+ * vm tricks. We simply map in the user memory and fill them into a pipe.
+ * The reverse isn't quite as easy, though. There are two possible solutions
+ * for that:
+ *
+ *	- memcpy() the data internally, at which point we might as well just
+ *	  do a regular read() on the buffer anyway.
+ *	- Lots of nasty vm tricks, that are neither fast nor flexible (it
+ *	  has restriction limitations on both ends of the pipe).
+ *
+ * Alas, it isn't here.
+ *
+ */
+static long do_vmsplice(struct file *file, void __user *buffer, size_t len,
+			unsigned int flags)
+{
+	unsigned long uaddr = (unsigned long) buffer;
+	struct pipe_inode_info *pipe;
+	struct page *pages[PIPE_BUFFERS];
+	unsigned int nr_pages;
+	struct splice_pipe_desc spd = {
+		.pages = pages,
+		.len = len,
+		.flags = flags,
+		.ops = &user_page_pipe_buf_ops,
+	};
+
+	pipe = file->f_dentry->d_inode->i_pipe;
+	if (unlikely(!pipe))
+		return -EBADF;
+
+	spd.offset = uaddr & ~PAGE_CACHE_MASK;
+	nr_pages = (len + spd.offset + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
+
+	if (nr_pages > PIPE_BUFFERS)
+		nr_pages = PIPE_BUFFERS;
+
+	down_read(&current->mm->mmap_sem);
+	spd.nr_pages = get_user_pages(current, current->mm, uaddr, nr_pages, 0,
+				      0, pages, NULL);
+	up_read(&current->mm->mmap_sem);
+
+	if (spd.nr_pages > 0)
+		return move_to_pipe(pipe, &spd);
+
+	return spd.nr_pages;
+}
+
+asmlinkage long sys_vmsplice(int fd, void __user *buffer, size_t len,
+			     unsigned int flags)
+{
+	long error;
+	struct file *file;
+	int fput;
+
+	if (unlikely(!len))
+		return 0;
+
+	error = -EBADF;
+	file = fget_light(fd, &fput);
+	if (file) {
+		if (file->f_mode & FMODE_WRITE)
+			error = do_vmsplice(file, buffer, len, flags);
+
+		fput_light(file, fput);
+	}
+
+	return error;
+}
+
 asmlinkage long sys_splice(int fd_in, loff_t __user *off_in,
 			   int fd_out, loff_t __user *off_out,
 			   size_t len, unsigned int flags)
diff --git a/include/asm-generic/fcntl.h b/include/asm-generic/fcntl.h
index b663520..1da0fba 100644
--- a/include/asm-generic/fcntl.h
+++ b/include/asm-generic/fcntl.h
@@ -146,4 +146,9 @@ struct flock64 {
 #endif
 #endif /* !CONFIG_64BIT */
 
+#ifndef F_SETPSZ
+#define F_SETPSZ	15	/* for pipes. */
+#define F_GETPSZ	16	/* for pipes. */
+#endif
+
 #endif /* _ASM_GENERIC_FCNTL_H */
diff --git a/include/asm-i386/unistd.h b/include/asm-i386/unistd.h
index d81d6cf..eb4b152 100644
--- a/include/asm-i386/unistd.h
+++ b/include/asm-i386/unistd.h
@@ -321,8 +321,9 @@ #define __NR_get_robust_list	312
 #define __NR_splice		313
 #define __NR_sync_file_range	314
 #define __NR_tee		315
+#define __NR_vmsplice		316
 
-#define NR_syscalls 316
+#define NR_syscalls 317
 
 /*
  * user-visible error numbers are in the range -1 - -128: see
diff --git a/include/asm-ia64/unistd.h b/include/asm-ia64/unistd.h
index a40ebec..9aa3487 100644
--- a/include/asm-ia64/unistd.h
+++ b/include/asm-ia64/unistd.h
@@ -290,6 +290,7 @@ #define __NR_set_robust_list		1298
 #define __NR_get_robust_list		1299
 #define __NR_sync_file_range		1300
 #define __NR_tee			1301
+#define __NR_vmsplice			1302
 
 #ifdef __KERNEL__
 
diff --git a/include/asm-powerpc/unistd.h b/include/asm-powerpc/unistd.h
index c612f1a..34325e2 100644
--- a/include/asm-powerpc/unistd.h
+++ b/include/asm-powerpc/unistd.h
@@ -303,8 +303,9 @@ #define __NR_ppoll		281
 #define __NR_unshare		282
 #define __NR_splice		283
 #define __NR_tee		284
+#define __NR_vmsplice		285
 
-#define __NR_syscalls		285
+#define __NR_syscalls		286
 
 #ifdef __KERNEL__
 #define __NR__exit __NR_exit
diff --git a/include/asm-x86_64/unistd.h b/include/asm-x86_64/unistd.h
index 98c36ea..feb77cb 100644
--- a/include/asm-x86_64/unistd.h
+++ b/include/asm-x86_64/unistd.h
@@ -615,8 +615,10 @@ #define __NR_tee		276
 __SYSCALL(__NR_tee, sys_tee)
 #define __NR_sync_file_range	277
 __SYSCALL(__NR_sync_file_range, sys_sync_file_range)
+#define __NR_vmsplice		278
+__SYSCALL(__NR_vmsplice, sys_vmsplice)
 
-#define __NR_syscall_max __NR_sync_file_range
+#define __NR_syscall_max __NR_vmsplice
 
 #ifndef __NO_STUBS
 
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index d3ebc0e..fc9392c 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -574,6 +574,9 @@ asmlinkage long sys_splice(int fd_in, lo
 			   int fd_out, loff_t __user *off_out,
 			   size_t len, unsigned int flags);
 
+asmlinkage long sys_vmsplice(int fd, void __user *buffer, size_t len,
+			     unsigned int flags);
+
 asmlinkage long sys_tee(int fdin, int fdout, size_t len, unsigned int flags);
 
 asmlinkage long sys_sync_file_range(int fd, loff_t offset, loff_t nbytes,
-- 
1.3.0.g2473


-- 
Jens Axboe


--SUOF0GtieIMvvwua
Content-Type: text/x-c++src; charset=us-ascii
Content-Disposition: attachment; filename="vmsplice.c"

/*
 * Use vmsplice to fill some user memory into a pipe. vmsplice writes
 * to stdout, so that must be a pipe.
 */
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <limits.h>
#include <sys/poll.h>
#include <sys/stat.h>
#include <sys/types.h>

#include "splice.h"

#define ALIGN_BUF

#ifdef ALIGN_BUF
#define ALIGN_MASK	(65535)	/* 64k-1, should just be PAGE_SIZE - 1 */
#define ALIGN(buf)	(void *) (((unsigned long) (buf) + ALIGN_MASK) & ~ALIGN_MASK)
#else
#define ALIGN_MASK	(0)
#define ALIGN(buf)	(buf)
#endif

int do_vmsplice(int fd, void *buffer, int len)
{
	struct pollfd pfd = { .fd = fd, .events = POLLOUT, };
	int written;

	while (len) {
		/*
		 * in a real app you'd be more clever with poll of course,
		 * here we are basically just blocking on output room and
		 * not using the free time for anything interesting.
		 */
		if (poll(&pfd, 1, -1) < 0)
			return error("poll");

		written = vmsplice(fd, buffer, min(SPLICE_SIZE, len), 0);

		if (written <= 0)
			return error("vmsplice");

		len -= written;
	}

	return 0;
}

int main(int argc, char *argv[])
{
	unsigned char *buffer;
	struct stat sb;
	long page_size;
	int i, ret;

	if (fstat(STDOUT_FILENO, &sb) < 0)
		return error("stat");
	if (!S_ISFIFO(sb.st_mode)) {
		fprintf(stderr, "stdout must be a pipe\n");
		return 1;
	}

	ret = fcntl(STDOUT_FILENO, F_GETPSZ);
	if (ret < 0)
		return error("F_GETPSZ");

	page_size = sysconf(_SC_PAGESIZE);
	if (page_size < 0)
		return error("_SC_PAGESIZE");

	fprintf(stderr, "Pipe size: %d pages / %ld bytes\n", ret, ret * page_size);

	buffer = ALIGN(malloc(2 * SPLICE_SIZE + ALIGN_MASK));
	for (i = 0; i < 2 * SPLICE_SIZE; i++)
		buffer[i] = (i & 0xff);

	do {
		/*
		 * vmsplice the first half of the buffer into the pipe
		 */
		if (do_vmsplice(STDOUT_FILENO, buffer, SPLICE_SIZE))
			break;

		/*
		 * first half is now in pipe, but we don't quite know when
		 * we can reuse it.
		 */

		/*
		 * vmsplice second half
		 */
		if (do_vmsplice(STDOUT_FILENO, buffer + SPLICE_SIZE, SPLICE_SIZE))
			break;

		/*
		 * We still don't know when we can reuse the second half of
		 * the buffer, but we do now know that all parts of the first
		 * half have been consumed from the pipe - so we can reuse that.
		 */
	} while (0);

	return 0;
}

--SUOF0GtieIMvvwua--
