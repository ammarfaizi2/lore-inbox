Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131823AbRAGBBF>; Sat, 6 Jan 2001 20:01:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135453AbRAGBAz>; Sat, 6 Jan 2001 20:00:55 -0500
Received: from pizda.ninka.net ([216.101.162.242]:22930 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S131823AbRAGBAp>;
	Sat, 6 Jan 2001 20:00:45 -0500
Date: Sat, 6 Jan 2001 16:43:21 -0800
Message-Id: <200101070043.QAA13874@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: manfred@colorfullife.com
CC: linux-kernel@vger.kernel.org
In-Reply-To: <3A57BA06.DE2EA489@colorfullife.com> (message from Manfred on
	Sun, 07 Jan 2001 01:36:22 +0100)
Subject: Re: [patch] single copy pipe rewrite
In-Reply-To: <3A57A95C.A1411221@colorfullife.com> <200101062322.PAA13439@pizda.ninka.net> <3A57BA06.DE2EA489@colorfullife.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Sun, 07 Jan 2001 01:36:22 +0100
   From: Manfred <manfred@colorfullife.com>

   Do you still have that patch?

I think so, see below.

   Was it posted to linux-kernel?

Yes, it was.

I just found a copy, enjoy:

diff -ur ../vger3-001101/linux/fs/pipe.c linux/fs/pipe.c
--- ../vger3-001101/linux/fs/pipe.c	Sat Oct 14 18:38:24 2000
+++ linux/fs/pipe.c	Wed Nov  1 21:39:53 2000
@@ -8,6 +8,8 @@
 #include <linux/file.h>
 #include <linux/poll.h>
 #include <linux/malloc.h>
+#include <linux/iobuf.h>
+#include <linux/highmem.h>
 #include <linux/module.h>
 #include <linux/init.h>
 
@@ -22,6 +24,18 @@
  * -- Julian Bradfield 1999-06-07.
  */
 
+#define PIPE_UMAP(inode)	((inode).i_pipe->umap)
+#define PIPE_UMAPOFF(inode)	((inode).i_pipe->umap_offset)
+#define PIPE_UMAPLEN(inode)	((inode).i_pipe->umap_length)
+
+#define PIPE_UMAP_EMPTY(inode)	\
+	((PIPE_UMAP(inode) == NULL) || \
+	 (PIPE_UMAPOFF(inode) >= PIPE_UMAPLEN(inode)))
+
+#define PIPE_EMPTY(inode)	\
+	((PIPE_LEN(inode) == 0) && PIPE_UMAP_EMPTY(inode))
+
+
 /* Drop the inode semaphore and wait for a pipe event, atomically */
 void pipe_wait(struct inode * inode)
 {
@@ -36,6 +50,65 @@
 }
 
 static ssize_t
+pipe_copy_from_kiobuf(char *buf, size_t count, struct kiobuf *kio, int kio_offset)
+{
+	struct page **cur_page;
+	unsigned long cur_offset, remains_this_page;
+	char *cur_buf;
+	int kio_remains;
+
+	kio_remains = kio->length;
+	cur_page = kio->maplist;
+	cur_offset = kio->offset;
+	while (kio_offset > 0 && kio_remains > 0) {
+		remains_this_page = PAGE_SIZE - cur_offset;
+		if (kio_offset < remains_this_page) {
+			cur_offset += kio_offset;
+			kio_remains -= kio_offset;
+			break;
+		}
+		kio_offset -= remains_this_page;
+		kio_remains -= remains_this_page;
+		cur_offset = 0;
+		cur_page++;
+	}
+
+	cur_buf = buf;
+	while (kio_remains > 0) {
+		unsigned long kvaddr;
+		int err;
+
+		remains_this_page = PAGE_SIZE - cur_offset;
+		if (remains_this_page > count)
+			remains_this_page = count;
+		if (remains_this_page > kio_remains)
+			remains_this_page = kio_remains;
+
+		kvaddr = kmap(*cur_page);
+		err = copy_to_user(cur_buf, (void *)(kvaddr + cur_offset),
+				   remains_this_page);
+		kunmap(*cur_page);
+
+		if (err)
+			return -EFAULT;
+
+		cur_buf += remains_this_page;
+		count -= remains_this_page;
+		if (count <= 0)
+			break;
+
+		kio_remains -= remains_this_page;
+		if (kio_remains <= 0)
+			break;
+
+		cur_offset = 0;
+		cur_page++;
+	}
+
+	return cur_buf - buf;
+}
+
+static ssize_t
 pipe_read(struct file *filp, char *buf, size_t count, loff_t *ppos)
 {
 	struct inode *inode = filp->f_dentry->d_inode;
@@ -84,29 +157,44 @@
 
 	/* Read what data is available.  */
 	ret = -EFAULT;
-	while (count > 0 && (size = PIPE_LEN(*inode))) {
-		char *pipebuf = PIPE_BASE(*inode) + PIPE_START(*inode);
-		ssize_t chars = PIPE_MAX_RCHUNK(*inode);
-
-		if (chars > count)
-			chars = count;
-		if (chars > size)
-			chars = size;
+	if (PIPE_UMAP(*inode)) {
+		ssize_t chars;
 
-		if (copy_to_user(buf, pipebuf, chars))
+		chars = pipe_copy_from_kiobuf(buf, count,
+					      PIPE_UMAP(*inode),
+					      PIPE_UMAPOFF(*inode));
+		if (chars < 0)
 			goto out;
 
 		read += chars;
-		PIPE_START(*inode) += chars;
-		PIPE_START(*inode) &= (PIPE_SIZE - 1);
-		PIPE_LEN(*inode) -= chars;
 		count -= chars;
 		buf += chars;
-	}
+		PIPE_UMAPOFF(*inode) += chars;
+	} else {
+		while (count > 0 && (size = PIPE_LEN(*inode))) {
+			char *pipebuf = PIPE_BASE(*inode) + PIPE_START(*inode);
+			ssize_t chars = PIPE_MAX_RCHUNK(*inode);
 
-	/* Cache behaviour optimization */
-	if (!PIPE_LEN(*inode))
-		PIPE_START(*inode) = 0;
+			if (chars > count)
+				chars = count;
+			if (chars > size)
+				chars = size;
+
+			if (copy_to_user(buf, pipebuf, chars))
+				goto out;
+
+			read += chars;
+			PIPE_START(*inode) += chars;
+			PIPE_START(*inode) &= (PIPE_SIZE - 1);
+			PIPE_LEN(*inode) -= chars;
+			count -= chars;
+			buf += chars;
+		}
+
+		/* Cache behaviour optimization */
+		if (!PIPE_LEN(*inode))
+			PIPE_START(*inode) = 0;
+	}
 
 	if (count && PIPE_WAITING_WRITERS(*inode) && !(filp->f_flags & O_NONBLOCK)) {
 		/*
@@ -156,16 +244,20 @@
 	if (!PIPE_READERS(*inode))
 		goto sigpipe;
 
-	/* If count <= PIPE_BUF, we have to make it atomic.  */
-	free = (count <= PIPE_BUF ? count : 1);
+	/* If count <= PIPE_BUF, we have to make it atomic.
+	 * PIPE_BUF is not used more, pipe is atomic for blocking
+	 * IO up to KIO_MAX_ATOMIC_BYTES and for non-blocking
+	 * up to PAGE_SIZE.
+	 */
+	free = (count <= PIPE_SIZE ? count : PIPE_SIZE);
 
 	/* Wait, or check for, available space.  */
 	if (filp->f_flags & O_NONBLOCK) {
 		ret = -EAGAIN;
-		if (PIPE_FREE(*inode) < free)
+		if (PIPE_FREE(*inode) < free || PIPE_UMAP(*inode))
 			goto out;
 	} else {
-		while (PIPE_FREE(*inode) < free) {
+		while (PIPE_FREE(*inode) < free || PIPE_UMAP(*inode)) {
 			PIPE_WAITING_WRITERS(*inode)++;
 			pipe_wait(inode);
 			PIPE_WAITING_WRITERS(*inode)--;
@@ -180,11 +272,69 @@
 
 	/* Copy into available space.  */
 	ret = -EFAULT;
-	while (count > 0) {
+	if (count >= PAGE_SIZE &&
+	    !(filp->f_flags & O_NONBLOCK)) {
+		struct kiobuf *kio;
+		int err, do_sigpipe;;
+
+		/* Bulk, non-blocking, sole writer, use kio. */
+		err = alloc_kiovec(1, &kio);
+		if (err)
+			goto kio_abort;
+
+		do_sigpipe = 0;
+		PIPE_UMAP(*inode) = kio;
+		while (count > 0) {
+			unsigned long iosize = count;
+
+			if (iosize > KIO_MAX_ATOMIC_BYTES)
+				iosize = KIO_MAX_ATOMIC_BYTES;
+
+			/* Since we only use atomic sized transfers, the
+			 * only possible error here is EFAULT.
+			 */
+			err = map_user_kiobuf(WRITE, kio, (unsigned long)buf, iosize);
+			if (err)
+				break;
+
+			PIPE_UMAPOFF(*inode) = 0;
+			PIPE_UMAPLEN(*inode) = iosize;
+
+			do {
+				wake_up_interruptible_sync(PIPE_WAIT(*inode));
+				PIPE_WAITING_WRITERS(*inode)++;
+				pipe_wait(inode);
+				PIPE_WAITING_WRITERS(*inode)--;
+				if (signal_pending(current)) {
+					unmap_kiobuf(kio);
+					goto kio_break;
+				}
+				if (!PIPE_READERS(*inode)) {
+					unmap_kiobuf(kio);
+					do_sigpipe = 1;
+					goto kio_break;
+				}
+			} while (!PIPE_UMAP_EMPTY(*inode));
+
+			unmap_kiobuf(kio);
+			count -= iosize;
+			written += iosize;
+			buf += iosize;
+		}
+	kio_break:
+		free_kiovec(1, &kio);
+		PIPE_UMAP(*inode) = NULL;
+		
+		if (do_sigpipe)
+			goto sigpipe;
+	} else while (count > 0) {
 		int space;
-		char *pipebuf = PIPE_BASE(*inode) + PIPE_END(*inode);
-		ssize_t chars = PIPE_MAX_WCHUNK(*inode);
+		char *pipebuf;
+		ssize_t chars;
 
+kio_abort:
+		pipebuf = PIPE_BASE(*inode) + PIPE_END(*inode);
+		chars = PIPE_MAX_WCHUNK(*inode);
 		if ((space = PIPE_FREE(*inode)) != 0) {
 			if (chars > count)
 				chars = count;
@@ -285,8 +435,11 @@
 	poll_wait(filp, PIPE_WAIT(*inode), wait);
 
 	/* Reading only -- no need for acquiring the semaphore.  */
-	mask = POLLIN | POLLRDNORM;
-	if (PIPE_EMPTY(*inode))
+ 	/* Is this not racy occasionally? */
+ 	mask = 0;
+ 	if (!PIPE_EMPTY(*inode))
+ 		mask = POLLIN | POLLRDNORM;
+ 	else if (!PIPE_UMAP(*inode))
 		mask = POLLOUT | POLLWRNORM;
 	if (!PIPE_WRITERS(*inode) && filp->f_version != PIPE_WCOUNTER(*inode))
 		mask |= POLLHUP;
@@ -309,6 +462,8 @@
 		struct pipe_inode_info *info = inode->i_pipe;
 		inode->i_pipe = NULL;
 		free_page((unsigned long) info->base);
+		if (info->umap != NULL)
+			BUG();
 		kfree(info);
 	} else {
 		wake_up_interruptible(PIPE_WAIT(*inode));
@@ -457,6 +612,7 @@
 	PIPE_READERS(*inode) = PIPE_WRITERS(*inode) = 0;
 	PIPE_WAITING_READERS(*inode) = PIPE_WAITING_WRITERS(*inode) = 0;
 	PIPE_RCOUNTER(*inode) = PIPE_WCOUNTER(*inode) = 1;
+	PIPE_UMAP(*inode) = NULL;
 
 	return inode;
 fail_page:
diff -ur ../vger3-001101/linux/include/linux/pipe_fs_i.h linux/include/linux/pipe_fs_i.h
--- ../vger3-001101/linux/include/linux/pipe_fs_i.h	Fri May 26 21:31:37 2000
+++ linux/include/linux/pipe_fs_i.h	Wed Nov  1 21:39:54 2000
@@ -4,6 +4,9 @@
 #define PIPEFS_MAGIC 0x50495045
 struct pipe_inode_info {
 	wait_queue_head_t wait;
+	void *umap;
+	int umap_length;
+	int umap_offset;
 	char *base;
 	unsigned int start;
 	unsigned int readers;
@@ -30,7 +33,6 @@
 #define PIPE_RCOUNTER(inode)	((inode).i_pipe->r_counter)
 #define PIPE_WCOUNTER(inode)	((inode).i_pipe->w_counter)
 
-#define PIPE_EMPTY(inode)	(PIPE_LEN(inode) == 0)
 #define PIPE_FULL(inode)	(PIPE_LEN(inode) == PIPE_SIZE)
 #define PIPE_FREE(inode)	(PIPE_SIZE - PIPE_LEN(inode))
 #define PIPE_END(inode)	((PIPE_START(inode) + PIPE_LEN(inode)) & (PIPE_SIZE-1))
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
