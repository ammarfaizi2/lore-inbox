Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277882AbRJRSH4>; Thu, 18 Oct 2001 14:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277873AbRJRSHw>; Thu, 18 Oct 2001 14:07:52 -0400
Received: from colorfullife.com ([216.156.138.34]:6412 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S277882AbRJRSHd>;
	Thu, 18 Oct 2001 14:07:33 -0400
Message-ID: <3BCF1A74.AE96F241@colorfullife.com>
Date: Thu, 18 Oct 2001 20:07:48 +0200
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.12 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Hubertus Franke <frankeh@watson.ibm.com>, linux-kernel@vger.kernel.org
Subject: Patch and Performance of larger pipes
Content-Type: multipart/mixed;
 boundary="------------8E25B17FC3D734D28835B07F"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------8E25B17FC3D734D28835B07F
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Could you test the attached singlecopy patches?

with bw_pipe,
* on UP, up to +100%.
* on SMP with busy cpus, up to +100%
* on SMP with idle cpus a performance drop due to increased cache
trashing. Probably the scheduler should keep both bw_pipe processes on
the same cpu.

I've sent patch-pgw to Linus for inclusion, since it's needed to fix the
elf coredump deadlock.

patch-kiopipe must wait until 2.5, because it changes the behaviour of
pipe_write with partial reads.

--
	Manfred
--------------8E25B17FC3D734D28835B07F
Content-Type: text/plain; charset=us-ascii;
 name="patch-kiopipe"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-kiopipe"

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 4
//  SUBLEVEL = 10
//  EXTRAVERSION =
--- 2.4/fs/pipe.c	Sun Sep 23 21:20:49 2001
+++ build-2.4/fs/pipe.c	Sun Sep 30 12:08:59 2001
@@ -2,6 +2,9 @@
  *  linux/fs/pipe.c
  *
  *  Copyright (C) 1991, 1992, 1999  Linus Torvalds
+ *
+ *  Major pipe_read() and pipe_write() cleanup:  Single copy,
+ *  fewer schedules.	Copyright (C) 2001 Manfred Spraul
  */
 
 #include <linux/mm.h>
@@ -10,6 +13,8 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/highmem.h>
+#include <linux/compiler.h>
 
 #include <asm/uaccess.h>
 #include <asm/ioctls.h>
@@ -36,214 +41,347 @@
 	down(PIPE_SEM(*inode));
 }
 
+#define PIO_PGCOUNT	((131072+PAGE_SIZE-1)/PAGE_SIZE)
+struct pipe_pio {
+	struct list_head list;
+	struct page *pages[PIO_PGCOUNT];
+	int offset;
+	size_t len;
+	size_t orig_len;
+	struct task_struct *tsk;
+};
+
+static ssize_t
+copy_from_piolist(struct list_head *piolist, void *buf, ssize_t len)
+{
+	struct list_head *walk = piolist->next;
+	int ret = 0;
+	while(walk != piolist && len) {
+		struct pipe_pio* pio = list_entry(walk, struct pipe_pio, list);
+		if (pio->len) {
+			struct page *page;
+			void *maddr;
+			int this_len, off, i;
+			int ret2;
+
+			i = pio->offset/PAGE_SIZE;
+			off = pio->offset%PAGE_SIZE;
+			this_len = len;
+			if (this_len > PAGE_SIZE-off)
+				this_len = PAGE_SIZE-off;
+			if (this_len > pio->len)
+				this_len = pio->len;
+
+			page = pio->pages[i];
+			maddr = kmap(page);
+			ret2 = copy_to_user(buf, maddr+off, this_len);
+			flush_page_to_ram(page);
+			kunmap(page);
+			if (unlikely(ret2)) {
+				if (ret)
+					return ret;
+				return -EFAULT;
+			}
+
+			buf += this_len;
+			len -= this_len;
+			pio->len -= this_len;
+			pio->offset += this_len;
+			ret += this_len;
+			if (pio->len == 0)
+				wake_up_process(pio->tsk);
+		} else {
+			walk = walk->next;
+		}
+	}
+	return ret;
+}
+
+static void
+build_pio(struct pipe_pio *pio, struct inode *inode, const void *buf, size_t count)
+{
+	int len;
+	struct vm_area_struct *vmas[PIO_PGCOUNT];
+
+	pio->tsk = current;
+	pio->len = count;
+	pio->offset = (unsigned long)buf&(PAGE_SIZE-1);
+
+	pio->len = PIO_PGCOUNT*PAGE_SIZE - pio->offset;
+	if (pio->len > count)
+		pio->len = count;
+	len = (pio->offset+pio->len+PAGE_SIZE-1)/PAGE_SIZE;
+	down_read(&current->mm->mmap_sem);
+	len = get_user_pages(current, current->mm, (unsigned long)buf, len,
+			0, pio->pages, vmas);
+	if (len > 0) {
+		int i;
+		for(i=0;i<len;i++) {
+			flush_cache_page(vmas[i], addr+i*PAGE_SIZE);
+		}
+		len = len*PAGE_SIZE-pio->offset;
+		if (len < pio->len)
+			pio->len = len;
+		list_add_tail(&pio->list, &PIPE_PIO(*inode));
+		PIPE_PIOLEN(*inode) += pio->len;
+		pio->orig_len = pio->len;
+	} else {
+		pio->list.next = NULL;
+	}
+	up_read(&current->mm->mmap_sem);
+}
+
+static size_t
+teardown_pio(struct pipe_pio *pio, struct inode *inode, const void *buf)
+{
+	int i;
+	if (!pio->list.next)
+		return 0;
+	for (i=0;i<(pio->len+pio->offset+PAGE_SIZE-1)/PAGE_SIZE;i++) {
+		if (pio->pages[i]) {
+			put_page(pio->pages[i]);
+		}
+	}
+	i = pio->orig_len - pio->len;
+	PIPE_PIOLEN(*inode) -= pio->len;
+	list_del(&pio->list);
+	if (i && pio->len) {
+		/*
+		 * We would violate the atomicity requirements:
+		 * 1 byte in the internal buffer.
+		 * write(fd, buf, PIPE_BUF);
+		 * --> doesn't fit into internal buffer, pio build.
+		 * read(fd, buf, 200);(i.e. 199 bytes from pio)
+		 * signal sent to writer.
+		 * The writer must not return with 199 bytes written!
+		 * Fortunately the internal buffer will be empty in this
+		 * case. Write into the internal buffer before
+		 * checking for signals/error conditions.
+		 */
+		size_t j = min((size_t)PIPE_SIZE, pio->len);
+		if (PIPE_LEN(*inode)) BUG();
+		if (PIPE_START(*inode)) BUG();
+		if (!copy_from_user(PIPE_BASE(*inode), buf + i, j)) {
+			i += j;
+			PIPE_LEN(*inode) =  j;
+		}
+	}
+	return i;
+}
+/*
+ * reader:
+	flush_cache_page(vma, addr);
+ *
+		flush_icache_page(vma, page);
+ */
 static ssize_t
 pipe_read(struct file *filp, char *buf, size_t count, loff_t *ppos)
 {
 	struct inode *inode = filp->f_dentry->d_inode;
-	ssize_t size, read, ret;
+	ssize_t read;
 
-	/* Seeks are not allowed on pipes.  */
-	ret = -ESPIPE;
-	read = 0;
-	if (ppos != &filp->f_pos)
-		goto out_nolock;
+	/* pread is not allowed on pipes.  */
+	if (unlikely(ppos != &filp->f_pos))
+		return -ESPIPE;
 
 	/* Always return 0 on null read.  */
-	ret = 0;
-	if (count == 0)
-		goto out_nolock;
-
-	/* Get the pipe semaphore */
-	ret = -ERESTARTSYS;
-	if (down_interruptible(PIPE_SEM(*inode)))
-		goto out_nolock;
-
-	if (PIPE_EMPTY(*inode)) {
-do_more_read:
-		ret = 0;
-		if (!PIPE_WRITERS(*inode))
-			goto out;
+	if (unlikely(count == 0))
+		return 0;
 
-		ret = -EAGAIN;
-		if (filp->f_flags & O_NONBLOCK)
-			goto out;
+	down(PIPE_SEM(*inode));
 
-		for (;;) {
-			PIPE_WAITING_READERS(*inode)++;
-			pipe_wait(inode);
-			PIPE_WAITING_READERS(*inode)--;
-			ret = -ERESTARTSYS;
-			if (signal_pending(current))
-				goto out;
-			ret = 0;
-			if (!PIPE_EMPTY(*inode))
-				break;
-			if (!PIPE_WRITERS(*inode))
+	for (;;) {
+		/* read what data is available */
+		int chars;
+		read = 0;
+		while( (chars = PIPE_LEN(*inode)) ) {
+			char *pipebuf = PIPE_BASE(*inode);
+			int offset = PIPE_START(*inode)%PIPE_BUF;
+			if (chars > count)
+				chars = count;
+			if (chars > PIPE_SIZE-offset)
+				chars = PIPE_SIZE-offset;
+			if (unlikely(copy_to_user(buf, pipebuf+offset, chars))) {
+				if (!read)
+					read = -EFAULT;
 				goto out;
+			}
+			PIPE_LEN(*inode) -= chars;
+			if (!PIPE_LEN(*inode)) {
+				/* Cache behaviour optimization */
+				PIPE_START(*inode) = 0;
+			} else {
+				/* there is no need to limit PIPE_START
+				 * to PIPE_BUF - the user does
+				 * %PIPE_BUF anyway.
+				 */
+				PIPE_START(*inode) += chars;
+			}
+			read += chars;
+			count -= chars;
+			if (!count)
+				goto out; /* common case: done */
+			buf += chars;
+			/* Check again that the internal buffer is empty.
+			 * If it was cyclic more data could be in the buffer.
+			 */
 		}
-	}
-
-	/* Read what data is available.  */
-	ret = -EFAULT;
-	while (count > 0 && (size = PIPE_LEN(*inode))) {
-		char *pipebuf = PIPE_BASE(*inode) + PIPE_START(*inode);
-		ssize_t chars = PIPE_MAX_RCHUNK(*inode);
-
-		if (chars > count)
-			chars = count;
-		if (chars > size)
-			chars = size;
+		if (PIPE_PIOLEN(*inode)) {
+			chars = copy_from_piolist(&PIPE_PIO(*inode), buf, count);
+			if (unlikely(chars < 0)) {
+				if (!read)
+					read = chars;
+				goto out;
+			}
+			PIPE_PIOLEN(*inode) -= chars;
+			read += chars;
+			count -= chars;
+			if (!count)
+				goto out; /* common case: done */
+			buf += chars;
 
-		if (copy_to_user(buf, pipebuf, chars))
+		}
+		if (PIPE_PIOLEN(*inode) || PIPE_LEN(*inode)) BUG();
+		/* tests before sleeping:
+		 *  - don't sleep if data was read.
+		 */
+		if (read)
 			goto out;
 
-		read += chars;
-		PIPE_START(*inode) += chars;
-		PIPE_START(*inode) &= (PIPE_SIZE - 1);
-		PIPE_LEN(*inode) -= chars;
-		count -= chars;
-		buf += chars;
-	}
-
-	/* Cache behaviour optimization */
-	if (!PIPE_LEN(*inode))
-		PIPE_START(*inode) = 0;
+		/*  - don't sleep if no process has the pipe open
+		 *	 for writing
+		 */
+		if (unlikely(!PIPE_WRITERS(*inode)))
+			goto out;
 
-	if (count && PIPE_WAITING_WRITERS(*inode) && !(filp->f_flags & O_NONBLOCK)) {
-		/*
-		 * We know that we are going to sleep: signal
-		 * writers synchronously that there is more
-		 * room.
+		/*   - don't sleep if O_NONBLOCK is set */
+		read = -EAGAIN;
+		if (filp->f_flags & O_NONBLOCK)
+			goto out;
+		/*   - don't sleep if a signal is pending */
+		read = -ERESTARTSYS;
+		if (unlikely(signal_pending(current)))
+			goto out;
+		/* readers never need to wake up if they go to sleep:
+		 * They only sleep if they didn't read anything
 		 */
-		wake_up_interruptible_sync(PIPE_WAIT(*inode));
-		if (!PIPE_EMPTY(*inode))
-			BUG();
-		goto do_more_read;
+		pipe_wait(inode);
 	}
-	/* Signal writers asynchronously that there is more room.  */
-	wake_up_interruptible(PIPE_WAIT(*inode));
-
-	ret = read;
 out:
 	up(PIPE_SEM(*inode));
-out_nolock:
-	if (read)
-		ret = read;
-	return ret;
+	/* If we drained the pipe, then wakeup everyone
+	 * waiting for that - either poll(2) or write(2).
+	 * We are only reading, therefore we can access without locking.
+	 */
+	if (read > 0 && !PIPE_PIOLEN(*inode) && !PIPE_LEN(*inode))
+		wake_up_interruptible(PIPE_WAIT(*inode));
+
+	return read;
 }
 
 static ssize_t
 pipe_write(struct file *filp, const char *buf, size_t count, loff_t *ppos)
 {
 	struct inode *inode = filp->f_dentry->d_inode;
-	ssize_t free, written, ret;
-
-	/* Seeks are not allowed on pipes.  */
-	ret = -ESPIPE;
-	written = 0;
-	if (ppos != &filp->f_pos)
-		goto out_nolock;
+	size_t min;
+	ssize_t written;
+	int do_wakeup;
+
+	/* pwrite is not allowed on pipes.  */
+	if (unlikely(ppos != &filp->f_pos))
+		return -ESPIPE;
 
 	/* Null write succeeds.  */
-	ret = 0;
-	if (count == 0)
-		goto out_nolock;
-
-	ret = -ERESTARTSYS;
-	if (down_interruptible(PIPE_SEM(*inode)))
-		goto out_nolock;
-
-	/* No readers yields SIGPIPE.  */
-	if (!PIPE_READERS(*inode))
-		goto sigpipe;
+	if (unlikely(count == 0))
+		return 0;
+	min = count;
+	if (min > PIPE_BUF && (filp->f_flags & O_NONBLOCK))
+		min = 1; /* no atomicity guarantee for transfers > PIPE_BUF */
 
-	/* If count <= PIPE_BUF, we have to make it atomic.  */
-	free = (count <= PIPE_BUF ? count : 1);
-
-	/* Wait, or check for, available space.  */
-	if (filp->f_flags & O_NONBLOCK) {
-		ret = -EAGAIN;
-		if (PIPE_FREE(*inode) < free)
-			goto out;
-	} else {
-		while (PIPE_FREE(*inode) < free) {
-			PIPE_WAITING_WRITERS(*inode)++;
-			pipe_wait(inode);
-			PIPE_WAITING_WRITERS(*inode)--;
-			ret = -ERESTARTSYS;
-			if (signal_pending(current))
-				goto out;
-
-			if (!PIPE_READERS(*inode))
-				goto sigpipe;
+	down(PIPE_SEM(*inode));
+	written = 0;
+	do_wakeup = 0;
+	for(;;) {
+		int start;
+		size_t chars;
+		/* No readers yields SIGPIPE.  */
+		if (unlikely(!PIPE_READERS(*inode))) {
+			if (!written)
+				written = -EPIPE;
+			break;
 		}
-	}
-
-	/* Copy into available space.  */
-	ret = -EFAULT;
-	while (count > 0) {
-		int space;
-		char *pipebuf = PIPE_BASE(*inode) + PIPE_END(*inode);
-		ssize_t chars = PIPE_MAX_WCHUNK(*inode);
-
-		if ((space = PIPE_FREE(*inode)) != 0) {
+		if (PIPE_PIOLEN(*inode))
+			goto skip_int_buf;
+		/* write to internal buffer - could be cyclic */
+		while(start = PIPE_LEN(*inode),chars = PIPE_SIZE - start, chars >= min) {
+			start += PIPE_START(*inode);
+			start %= PIPE_SIZE;
+			if (chars > PIPE_BUF - start)
+				chars = PIPE_BUF - start;
 			if (chars > count)
 				chars = count;
-			if (chars > space)
-				chars = space;
-
-			if (copy_from_user(pipebuf, buf, chars))
+			if (unlikely(copy_from_user(PIPE_BASE(*inode)+start,
+						buf, chars))) {
+				if (!written)
+					written = -EFAULT;
 				goto out;
-
-			written += chars;
+			}
+			do_wakeup = 1;
 			PIPE_LEN(*inode) += chars;
 			count -= chars;
+			written += chars;
+			if (!count)
+				goto out;
 			buf += chars;
-			space = PIPE_FREE(*inode);
-			continue;
+			min = 1;
 		}
-
-		ret = written;
-		if (filp->f_flags & O_NONBLOCK)
+skip_int_buf:
+		if (!filp->f_flags & O_NONBLOCK) {
+			if (!written)
+				written = -EAGAIN;
 			break;
+		}
 
-		do {
-			/*
-			 * Synchronous wake-up: it knows that this process
-			 * is going to give up this CPU, so it doesnt have
-			 * to do idle reschedules.
+		if (unlikely(signal_pending(current))) {
+			if (!written)
+				written = -ERESTARTSYS;
+			break;
+		}
+		{
+			struct pipe_pio my_pio;
+			/* build_pio
+			 * wakeup readers:
+			 * If the pipe was empty and now contains data, then do
+			 * a wakeup. We will sleep --> sync wakeup.
 			 */
-			wake_up_interruptible_sync(PIPE_WAIT(*inode));
-			PIPE_WAITING_WRITERS(*inode)++;
+			build_pio(&my_pio, inode, buf, count);
+			if (do_wakeup || PIPE_PIO(*inode).next == &my_pio.list)
+				wake_up_sync(PIPE_WAIT(*inode));
+			do_wakeup = 0;
 			pipe_wait(inode);
-			PIPE_WAITING_WRITERS(*inode)--;
-			if (signal_pending(current))
-				goto out;
-			if (!PIPE_READERS(*inode))
-				goto sigpipe;
-		} while (!PIPE_FREE(*inode));
-		ret = -EFAULT;
+			chars = teardown_pio(&my_pio, inode, buf);
+			count -= chars;
+			written += chars;
+			if (!count)
+				break;
+			buf += chars;
+		}
 	}
-
-	/* Signal readers asynchronously that there is more data.  */
-	wake_up_interruptible(PIPE_WAIT(*inode));
-
-	inode->i_ctime = inode->i_mtime = CURRENT_TIME;
-	mark_inode_dirty(inode);
-
 out:
+	if (written > 0) {
+		/* SuS V2: st_ctime and st_mtime are updated
+		 * uppon successful completion of write(2).
+		 */
+		inode->i_ctime = inode->i_mtime = CURRENT_TIME;
+		mark_inode_dirty(inode);
+	}
 	up(PIPE_SEM(*inode));
-out_nolock:
-	if (written)
-		ret = written;
-	return ret;
 
-sigpipe:
-	if (written)
-		goto out;
-	up(PIPE_SEM(*inode));
-	send_sig(SIGPIPE, current, 0);
-	return -EPIPE;
+	if (do_wakeup)
+		wake_up(PIPE_WAIT(*inode));
+	if (written == -EPIPE)
+		send_sig(SIGPIPE, current, 0);
+	return written;
 }
 
 static loff_t
@@ -270,7 +408,8 @@
 {
 	switch (cmd) {
 		case FIONREAD:
-			return put_user(PIPE_LEN(*pino), (int *)arg);
+			return put_user(PIPE_LEN(*filp->f_dentry->d_inode) +
+					PIPE_PIOLEN(*filp->f_dentry->d_inode), (int *)arg);
 		default:
 			return -EINVAL;
 	}
@@ -286,11 +425,20 @@
 	poll_wait(filp, PIPE_WAIT(*inode), wait);
 
 	/* Reading only -- no need for acquiring the semaphore.  */
+
+	/* 
+	 * POLLIN means that data is available for read.
+	 * POLLOUT means that a nonblocking write will succeed.
+	 * We can only guarantee that if the internal buffers are empty
+	 * Therefore both are mutually exclusive.
+	 */
 	mask = POLLIN | POLLRDNORM;
-	if (PIPE_EMPTY(*inode))
+	if (!PIPE_LEN(*inode) && !PIPE_PIOLEN(*inode))
 		mask = POLLOUT | POLLWRNORM;
+	/* POLLHUP: no writer, and there was at least once a writer */
 	if (!PIPE_WRITERS(*inode) && filp->f_version != PIPE_WCOUNTER(*inode))
 		mask |= POLLHUP;
+	/* POLLERR: no reader */
 	if (!PIPE_READERS(*inode))
 		mask |= POLLERR;
 
@@ -454,9 +602,9 @@
 
 	init_waitqueue_head(PIPE_WAIT(*inode));
 	PIPE_BASE(*inode) = (char*) page;
-	PIPE_START(*inode) = PIPE_LEN(*inode) = 0;
+	INIT_LIST_HEAD(&PIPE_PIO(*inode));
+	PIPE_START(*inode) = PIPE_LEN(*inode) = PIPE_PIOLEN(*inode) = 0;
 	PIPE_READERS(*inode) = PIPE_WRITERS(*inode) = 0;
-	PIPE_WAITING_READERS(*inode) = PIPE_WAITING_WRITERS(*inode) = 0;
 	PIPE_RCOUNTER(*inode) = PIPE_WCOUNTER(*inode) = 1;
 
 	return inode;
--- 2.4/include/linux/pipe_fs_i.h	Sat Apr 28 10:37:27 2001
+++ build-2.4/include/linux/pipe_fs_i.h	Sat Sep 29 22:18:31 2001
@@ -5,12 +5,12 @@
 struct pipe_inode_info {
 	wait_queue_head_t wait;
 	char *base;
-	unsigned int len;
+	size_t len;	/* not including pio buffers */
+	size_t piolen;
 	unsigned int start;
+	struct list_head pio;
 	unsigned int readers;
 	unsigned int writers;
-	unsigned int waiting_readers;
-	unsigned int waiting_writers;
 	unsigned int r_counter;
 	unsigned int w_counter;
 };
@@ -24,19 +24,15 @@
 #define PIPE_BASE(inode)	((inode).i_pipe->base)
 #define PIPE_START(inode)	((inode).i_pipe->start)
 #define PIPE_LEN(inode)		((inode).i_pipe->len)
+#define PIPE_PIOLEN(inode)	((inode).i_pipe->piolen)
+#define PIPE_PIO(inode)		((inode).i_pipe->pio)
 #define PIPE_READERS(inode)	((inode).i_pipe->readers)
 #define PIPE_WRITERS(inode)	((inode).i_pipe->writers)
-#define PIPE_WAITING_READERS(inode)	((inode).i_pipe->waiting_readers)
-#define PIPE_WAITING_WRITERS(inode)	((inode).i_pipe->waiting_writers)
 #define PIPE_RCOUNTER(inode)	((inode).i_pipe->r_counter)
 #define PIPE_WCOUNTER(inode)	((inode).i_pipe->w_counter)
 
-#define PIPE_EMPTY(inode)	(PIPE_LEN(inode) == 0)
-#define PIPE_FULL(inode)	(PIPE_LEN(inode) == PIPE_SIZE)
 #define PIPE_FREE(inode)	(PIPE_SIZE - PIPE_LEN(inode))
 #define PIPE_END(inode)	((PIPE_START(inode) + PIPE_LEN(inode)) & (PIPE_SIZE-1))
-#define PIPE_MAX_RCHUNK(inode)	(PIPE_SIZE - PIPE_START(inode))
-#define PIPE_MAX_WCHUNK(inode)	(PIPE_SIZE - PIPE_END(inode))
 
 /* Drop the inode semaphore and wait for a pipe event, atomically */
 void pipe_wait(struct inode * inode);
--- 2.4/fs/fifo.c	Fri Feb 23 15:25:22 2001
+++ build-2.4/fs/fifo.c	Sat Sep 29 22:18:31 2001
@@ -32,10 +32,8 @@
 {
 	int ret;
 
-	ret = -ERESTARTSYS;
-	lock_kernel();
 	if (down_interruptible(PIPE_SEM(*inode)))
-		goto err_nolock_nocleanup;
+		return -ERESTARTSYS;
 
 	if (!inode->i_pipe) {
 		ret = -ENOMEM;
@@ -116,7 +114,6 @@
 
 	/* Ok! */
 	up(PIPE_SEM(*inode));
-	unlock_kernel();
 	return 0;
 
 err_rd:
@@ -141,9 +138,6 @@
 
 err_nocleanup:
 	up(PIPE_SEM(*inode));
-
-err_nolock_nocleanup:
-	unlock_kernel();
 	return ret;
 }
 

--------------8E25B17FC3D734D28835B07F
Content-Type: text/plain; charset=us-ascii;
 name="patch-pgw"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-pgw"

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 4
//  SUBLEVEL = 13
//  EXTRAVERSION =-pre3
--- 2.4/include/linux/mm.h	Thu Oct 11 16:51:38 2001
+++ build-2.4/include/linux/mm.h	Tue Oct 16 21:32:05 2001
@@ -431,6 +431,9 @@
 extern int ptrace_detach(struct task_struct *, unsigned int);
 extern void ptrace_disable(struct task_struct *);
 
+int get_user_pages(struct task_struct *tsk, struct mm_struct *mm, unsigned long start,
+		int len, int write, int force, struct page **pages, struct vm_area_struct **vmas);
+
 /*
  * On a two-level page table, this ends up being trivial. Thus the
  * inlining and the symmetry break with pte_alloc() that does all
--- 2.4/mm/memory.c	Tue Oct 16 21:28:44 2001
+++ build-2.4/mm/memory.c	Tue Oct 16 21:30:02 2001
@@ -404,17 +404,16 @@
 	spin_unlock(&mm->page_table_lock);
 }
 
-
 /*
  * Do a quick page-table lookup for a single page. 
  */
-static struct page * follow_page(unsigned long address, int write) 
+static struct page * follow_page(struct mm_struct *mm, unsigned long address, int write) 
 {
 	pgd_t *pgd;
 	pmd_t *pmd;
 	pte_t *ptep, pte;
 
-	pgd = pgd_offset(current->mm, address);
+	pgd = pgd_offset(mm, address);
 	if (pgd_none(*pgd) || pgd_bad(*pgd))
 		goto out;
 
@@ -450,21 +449,70 @@
 	return page;
 }
 
+int get_user_pages(struct task_struct *tsk, struct mm_struct *mm, unsigned long start,
+		int len, int write, int force, struct page **pages, struct vm_area_struct **vmas)
+{
+	int i = 0;
+
+	do {
+		struct vm_area_struct *	vma;
+
+		vma = find_extend_vma(mm, start);
+
+		if ( !vma ||
+		    (!force &&
+		     	((write && (!(vma->vm_flags & VM_WRITE))) ||
+		    	 (!write && (!(vma->vm_flags & VM_READ))) ) )) {
+			if (i) return i;
+			return -EFAULT;
+		}
+
+		spin_lock(&mm->page_table_lock);
+		do {
+			struct page *map;
+			while (!(map = follow_page(mm, start, write))) {
+				spin_unlock(&mm->page_table_lock);
+				switch (handle_mm_fault(mm, vma, start, write)) {
+				case 1:
+					tsk->min_flt++;
+					break;
+				case 2:
+					tsk->maj_flt++;
+					break;
+				case 0:
+					if (i) return i;
+					return -EFAULT;
+				default:
+					if (i) return i;
+					return -ENOMEM;
+				}
+				spin_lock(&mm->page_table_lock);
+			}
+			if (pages) {
+				pages[i] = get_page_map(map);
+				if (pages[i]) get_page(pages[i]);
+			}
+			if (vmas)
+				vmas[i] = vma;
+			i++;
+			start += PAGE_SIZE;
+			len--;
+		} while(len && start < vma->vm_end);
+		spin_unlock(&mm->page_table_lock);
+	} while(len);
+	return i;
+}
+
 /*
  * Force in an entire range of pages from the current process's user VA,
  * and pin them in physical memory.  
  */
-
 #define dprintk(x...)
+
 int map_user_kiobuf(int rw, struct kiobuf *iobuf, unsigned long va, size_t len)
 {
-	unsigned long		ptr, end;
-	int			err;
+	int pgcount, err;
 	struct mm_struct *	mm;
-	struct vm_area_struct *	vma = 0;
-	struct page *		map;
-	int			i;
-	int			datain = (rw == READ);
 	
 	/* Make sure the iobuf is not already mapped somewhere. */
 	if (iobuf->nr_pages)
@@ -473,79 +521,37 @@
 	mm = current->mm;
 	dprintk ("map_user_kiobuf: begin\n");
 	
-	ptr = va & PAGE_MASK;
-	end = (va + len + PAGE_SIZE - 1) & PAGE_MASK;
-	err = expand_kiobuf(iobuf, (end - ptr) >> PAGE_SHIFT);
+	pgcount = (va + len + PAGE_SIZE - 1)/PAGE_SIZE - va/PAGE_SIZE;
+	/* mapping 0 bytes is not permitted */
+	if (!pgcount) BUG();
+	err = expand_kiobuf(iobuf, pgcount);
 	if (err)
 		return err;
 
-	down_read(&mm->mmap_sem);
-
-	err = -EFAULT;
 	iobuf->locked = 0;
-	iobuf->offset = va & ~PAGE_MASK;
+	iobuf->offset = va & (PAGE_SIZE-1);
 	iobuf->length = len;
 	
-	i = 0;
-	
-	/* 
-	 * First of all, try to fault in all of the necessary pages
-	 */
-	while (ptr < end) {
-		if (!vma || ptr >= vma->vm_end) {
-			vma = find_vma(current->mm, ptr);
-			if (!vma) 
-				goto out_unlock;
-			if (vma->vm_start > ptr) {
-				if (!(vma->vm_flags & VM_GROWSDOWN))
-					goto out_unlock;
-				if (expand_stack(vma, ptr))
-					goto out_unlock;
-			}
-			if (((datain) && (!(vma->vm_flags & VM_WRITE))) ||
-					(!(vma->vm_flags & VM_READ))) {
-				err = -EACCES;
-				goto out_unlock;
-			}
-		}
-		spin_lock(&mm->page_table_lock);
-		while (!(map = follow_page(ptr, datain))) {
-			int ret;
-
-			spin_unlock(&mm->page_table_lock);
-			ret = handle_mm_fault(current->mm, vma, ptr, datain);
-			if (ret <= 0) {
-				if (!ret)
-					goto out_unlock;
-				else {
-					err = -ENOMEM;
-					goto out_unlock;
-				}
-			}
-			spin_lock(&mm->page_table_lock);
-		}			
-		map = get_page_map(map);
-		if (map) {
-			flush_dcache_page(map);
-			atomic_inc(&map->count);
-		} else
-			printk (KERN_INFO "Mapped page missing [%d]\n", i);
-		spin_unlock(&mm->page_table_lock);
-		iobuf->maplist[i] = map;
-		iobuf->nr_pages = ++i;
-		
-		ptr += PAGE_SIZE;
-	}
-
+	/* Try to fault in all of the necessary pages */
+	down_read(&mm->mmap_sem);
+	/* rw==READ means read from disk, write into memory area */
+	err = get_user_pages(current, mm, va, pgcount,
+			(rw==READ), 0, iobuf->maplist, NULL);
 	up_read(&mm->mmap_sem);
+	if (err < 0) {
+		unmap_kiobuf(iobuf);
+		dprintk ("map_user_kiobuf: end %d\n", err);
+		return err;
+	}
+	iobuf->nr_pages = err;
+	while (pgcount--) {
+		/* FIXME: flush superflous for rw==READ,
+		 * probably wrong function for rw==WRITE
+		 */
+		flush_dcache_page(iobuf->maplist[pgcount]);
+	}
 	dprintk ("map_user_kiobuf: end OK\n");
 	return 0;
-
- out_unlock:
-	up_read(&mm->mmap_sem);
-	unmap_kiobuf(iobuf);
-	dprintk ("map_user_kiobuf: end %d\n", err);
-	return err;
 }
 
 /*
@@ -595,6 +601,7 @@
 		if (map) {
 			if (iobuf->locked)
 				UnlockPage(map);
+			/* FIXME: cache flush missing for rw==READ*/
 			__free_page(map);
 		}
 	}
@@ -1439,23 +1446,19 @@
 	return pte_offset(pmd, address);
 }
 
-/*
- * Simplistic page force-in..
- */
 int make_pages_present(unsigned long addr, unsigned long end)
 {
-	int write;
-	struct mm_struct *mm = current->mm;
+	int ret, len, write;
 	struct vm_area_struct * vma;
 
-	vma = find_vma(mm, addr);
+	vma = find_vma(current->mm, addr);
 	write = (vma->vm_flags & VM_WRITE) != 0;
 	if (addr >= end)
 		BUG();
-	do {
-		if (handle_mm_fault(mm, vma, addr, write) < 0)
-			return -1;
-		addr += PAGE_SIZE;
-	} while (addr < end);
-	return 0;
+	if (end > vma->vm_end)
+		BUG();
+	len = (end+PAGE_SIZE-1)/PAGE_SIZE-addr/PAGE_SIZE;
+	ret = get_user_pages(current, current->mm, addr,
+			len, write, 0, NULL, NULL);
+	return ret == len ? 0 : -1;
 }
--- 2.4/kernel/ptrace.c	Thu Oct 11 16:51:38 2001
+++ build-2.4/kernel/ptrace.c	Tue Oct 16 21:30:02 2001
@@ -85,119 +85,17 @@
 }
 
 /*
- * Access another process' address space, one page at a time.
+ * Access another process' address space.
+ * Source/target buffer must be kernel space, 
+ * Do not walk the page table directly, use get_user_pages
  */
-static int access_one_page(struct mm_struct * mm, struct vm_area_struct * vma, unsigned long addr, void *buf, int len, int write)
-{
-	pgd_t * pgdir;
-	pmd_t * pgmiddle;
-	pte_t * pgtable;
-	char *maddr; 
-	struct page *page;
-
-repeat:
-	spin_lock(&mm->page_table_lock);
-	pgdir = pgd_offset(vma->vm_mm, addr);
-	if (pgd_none(*pgdir))
-		goto fault_in_page;
-	if (pgd_bad(*pgdir))
-		goto bad_pgd;
-	pgmiddle = pmd_offset(pgdir, addr);
-	if (pmd_none(*pgmiddle))
-		goto fault_in_page;
-	if (pmd_bad(*pgmiddle))
-		goto bad_pmd;
-	pgtable = pte_offset(pgmiddle, addr);
-	if (!pte_present(*pgtable))
-		goto fault_in_page;
-	if (write && (!pte_write(*pgtable) || !pte_dirty(*pgtable)))
-		goto fault_in_page;
-	page = pte_page(*pgtable);
-
-	/* ZERO_PAGE is special: reads from it are ok even though it's marked reserved */
-	if (page != ZERO_PAGE(addr) || write) {
-		if ((!VALID_PAGE(page)) || PageReserved(page)) {
-			spin_unlock(&mm->page_table_lock);
-			return 0;
-		}
-	}
-	get_page(page);
-	spin_unlock(&mm->page_table_lock);
-	flush_cache_page(vma, addr);
-
-	if (write) {
-		maddr = kmap(page);
-		memcpy(maddr + (addr & ~PAGE_MASK), buf, len);
-		flush_page_to_ram(page);
-		flush_icache_page(vma, page);
-		kunmap(page);
-	} else {
-		maddr = kmap(page);
-		memcpy(buf, maddr + (addr & ~PAGE_MASK), len);
-		flush_page_to_ram(page);
-		kunmap(page);
-	}
-	put_page(page);
-	return len;
-
-fault_in_page:
-	spin_unlock(&mm->page_table_lock);
-	/* -1: out of memory. 0 - unmapped page */
-	if (handle_mm_fault(mm, vma, addr, write) > 0)
-		goto repeat;
-	return 0;
-
-bad_pgd:
-	spin_unlock(&mm->page_table_lock);
-	pgd_ERROR(*pgdir);
-	return 0;
-
-bad_pmd:
-	spin_unlock(&mm->page_table_lock);
-	pmd_ERROR(*pgmiddle);
-	return 0;
-}
-
-static int access_mm(struct mm_struct *mm, struct vm_area_struct * vma, unsigned long addr, void *buf, int len, int write)
-{
-	int copied = 0;
-
-	for (;;) {
-		unsigned long offset = addr & ~PAGE_MASK;
-		int this_len = PAGE_SIZE - offset;
-		int retval;
-
-		if (this_len > len)
-			this_len = len;
-		retval = access_one_page(mm, vma, addr, buf, this_len, write);
-		copied += retval;
-		if (retval != this_len)
-			break;
-
-		len -= retval;
-		if (!len)
-			break;
-
-		addr += retval;
-		buf += retval;
-
-		if (addr < vma->vm_end)
-			continue;	
-		if (!vma->vm_next)
-			break;
-		if (vma->vm_next->vm_start != vma->vm_end)
-			break;
-	
-		vma = vma->vm_next;
-	}
-	return copied;
-}
 
 int access_process_vm(struct task_struct *tsk, unsigned long addr, void *buf, int len, int write)
 {
-	int copied;
 	struct mm_struct *mm;
-	struct vm_area_struct * vma;
+	struct vm_area_struct *vma;
+	struct page *page;
+	void *old_buf = buf;
 
 	/* Worry about races with exit() */
 	task_lock(tsk);
@@ -209,14 +107,41 @@
 		return 0;
 
 	down_read(&mm->mmap_sem);
-	vma = find_extend_vma(mm, addr);
-	copied = 0;
-	if (vma)
-		copied = access_mm(mm, vma, addr, buf, len, write);
+	/* ignore errors, just check how much was sucessfully transfered */
+	while (len) {
+		int bytes, ret, offset;
+		void *maddr;
+
+		ret = get_user_pages(current, mm, addr, 1,
+				write, 1, &page, &vma);
+		if (ret <= 0)
+			break;
+
+		bytes = len;
+		offset = addr & (PAGE_SIZE-1);
+		if (bytes > PAGE_SIZE-offset)
+			bytes = PAGE_SIZE-offset;
 
+		flush_cache_page(vma, addr);
+
+		maddr = kmap(page);
+		if (write) {
+			memcpy(maddr + offset, buf, bytes);
+			flush_page_to_ram(page);
+			flush_icache_page(vma, page);
+		} else {
+			memcpy(buf, maddr + offset, bytes);
+			flush_page_to_ram(page);
+		}
+		kunmap(page);
+		put_page(page);
+		len -= bytes;
+		buf += bytes;
+	}
 	up_read(&mm->mmap_sem);
 	mmput(mm);
-	return copied;
+	
+	return buf - old_buf;
 }
 
 int ptrace_readdata(struct task_struct *tsk, unsigned long src, char *dst, int len)

--------------8E25B17FC3D734D28835B07F--


