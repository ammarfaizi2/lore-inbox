Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143362AbREKTA6>; Fri, 11 May 2001 15:00:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137214AbREKTAl>; Fri, 11 May 2001 15:00:41 -0400
Received: from colorfullife.com ([216.156.138.34]:4363 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S137215AbREKTA2>;
	Fri, 11 May 2001 15:00:28 -0400
Message-ID: <3AFC36BA.B71FC470@colorfullife.com>
Date: Fri, 11 May 2001 21:00:10 +0200
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] new version of singlecopy pipe
Content-Type: multipart/mixed;
 boundary="------------63F5781459667C73576839B4"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------63F5781459667C73576839B4
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

I've attached a new version of the patch.
The patch is now split into 2 parts:

* add copy_user_to_user() into kernel/ptrace.c. Most code is shared
between access_process_vm() and copy_user_to_user().

* use the new function for singlecopy pipe.

Please test it.
The kernel space part should be ok, but I know that the
patch can cause deadlocks with buggy user space apps.

--
	Manfred
--------------63F5781459667C73576839B4
Content-Type: text/plain; charset=us-ascii;
 name="patch-kiopipe"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-kiopipe"

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 4
//  SUBLEVEL = 4
//  EXTRAVERSION =
--- 2.4/fs/pipe.c	Mon May  7 20:43:38 2001
+++ build-2.4/fs/pipe.c	Fri May 11 19:17:45 2001
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
+#include <linux/iobuf.h>
+#include <linux/highmem.h>
 
 #include <asm/uaccess.h>
 #include <asm/ioctls.h>
@@ -36,214 +41,303 @@
 	down(PIPE_SEM(*inode));
 }
 
+#define ADDR_USER	1
+#define ADDR_KERNEL	2
+struct pipe_pio {
+	struct list_head list;
+	int state;	/* >0: still pending. 0: success. < 0:error code */
+	struct task_struct *tsk;
+	unsigned long addr;
+	size_t len;
+};
+
+static ssize_t
+pio_copy_to_user(struct inode *inode, char *ubuf, ssize_t chars)
+{
+	struct pipe_pio *pio;
+	struct mm_struct *mm;
+	ssize_t ret;
+	pio = list_entry(PIPE_PIO(*inode).next, struct pipe_pio, list);
+	mm = pio->tsk->mm;
+
+	if (chars > pio->len)
+		chars = pio->len;
+	if (pio->state == ADDR_KERNEL) {
+		/* kernel thread writes into a pipe. */
+		if(copy_to_user(ubuf, (void*)pio->addr, chars))
+			return -EFAULT;
+	} else {
+		ret = 0;
+		/* pio->tsk is within pipe_write(), we don't have to protect
+		 * against sudden death of that thread.
+		 */
+		switch(copy_user_to_user(ubuf, mm, pio->addr, chars, 0))
+		{
+			case 0:
+				break;
+			case OTHER_EFAULT:
+				pio->state = -EFAULT;
+				goto unlink;
+			case OTHER_ENOMEM:
+				pio->state = -ENOMEM;
+				goto unlink;
+			case CUR_EFAULT:
+				return -EFAULT;
+		}
+	}
+	pio->addr += chars;
+	pio->len -= chars;
+	ret = chars;
+
+	if (!pio->len) {
+		pio->state = 0;
+unlink:
+		list_del(&pio->list);
+		wake_up_process(pio->tsk);
+		if (!ret && list_empty(&PIPE_PIO(*inode))) {
+			/*
+			 * Lock-up:
+			 * A block with a bad pointer was queued
+			 * by pipe_write() and got deleted.
+			 * The pipe was filled and is now empty
+			 * after reading 0 bytes ;-)
+			 * Wakeup to recover.
+			 */
+			wake_up_interruptible(PIPE_WAIT(*inode));
+		}
+	}
+	return ret;
+}
+
 static ssize_t
 pipe_read(struct file *filp, char *buf, size_t count, loff_t *ppos)
 {
 	struct inode *inode = filp->f_dentry->d_inode;
-	ssize_t size, read, ret;
+	ssize_t read;
 
-	/* Seeks are not allowed on pipes.  */
-	ret = -ESPIPE;
-	read = 0;
+	/* pread is not allowed on pipes.  */
 	if (ppos != &filp->f_pos)
-		goto out_nolock;
+		return -ESPIPE;
 
 	/* Always return 0 on null read.  */
-	ret = 0;
 	if (count == 0)
-		goto out_nolock;
+		return 0;
 
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
-
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
+	read = 0;
+	for (;;) {
+		/* read what data is available */
+		int chars = PIPE_LEN(*inode);
+		if (chars) {
+			char *pipebuf = PIPE_BASE(*inode);
+			int offset = PIPE_START(*inode);
+			if (chars > count)
+				chars = count;
+			if (chars > PIPE_SIZE-offset)
+				chars = PIPE_SIZE-offset;
+			if (copy_to_user(buf, pipebuf+offset, chars)) {
+				if (!read)
+					read = -EFAULT;
 				goto out;
-			ret = 0;
-			if (!PIPE_EMPTY(*inode))
-				break;
-			if (!PIPE_WRITERS(*inode))
+			}
+			PIPE_LEN(*inode) -= chars;
+			if (!PIPE_LEN(*inode)) {
+				/* Cache behaviour optimization */
+				PIPE_START(*inode) = 0;
+			} else {
+				PIPE_START(*inode) += chars;
+				PIPE_START(*inode) &= (PIPE_SIZE - 1);
+			}
+		} else if (!list_empty(&PIPE_PIO(*inode))) {
+			chars = pio_copy_to_user(inode, buf, count);
+			if(chars < 0) {
+				if (!read)
+					read = chars;
 				goto out;
+			}
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
-
-		if (copy_to_user(buf, pipebuf, chars))
-			goto out;
-
 		read += chars;
-		PIPE_START(*inode) += chars;
-		PIPE_START(*inode) &= (PIPE_SIZE - 1);
-		PIPE_LEN(*inode) -= chars;
 		count -= chars;
 		buf += chars;
-	}
 
-	/* Cache behaviour optimization */
-	if (!PIPE_LEN(*inode))
-		PIPE_START(*inode) = 0;
+		if (!count)
+			goto out; /* common case: done */
+	
+		/* special case:
+		 * additional data available.
+		 */
+		if (PIPE_LEN(*inode) || !list_empty(&PIPE_PIO(*inode)))
+			continue;
 
-	if (count && PIPE_WAITING_WRITERS(*inode) && !(filp->f_flags & O_NONBLOCK)) {
-		/*
-		 * We know that we are going to sleep: signal
-		 * writers synchronously that there is more
-		 * room.
+		/* tests before sleeping:
+		 *  - don't sleep if data was read.
 		 */
-		wake_up_interruptible_sync(PIPE_WAIT(*inode));
-		if (!PIPE_EMPTY(*inode))
-			BUG();
-		goto do_more_read;
-	}
-	/* Signal writers asynchronously that there is more room.  */
-	wake_up_interruptible(PIPE_WAIT(*inode));
+		if (read)
+			goto out;
+
+		/*  - don't sleep if no process has the pipe open
+		 *	 for writing
+		 */
+		if (!PIPE_WRITERS(*inode))
+			goto out;
 
-	ret = read;
+		/*   - don't sleep if O_NONBLOCK is set */
+		if (filp->f_flags & O_NONBLOCK) {
+			read = -EAGAIN;
+			goto out;
+		}
+
+		pipe_wait(inode);
+		if (signal_pending(current)) {
+			read = -ERESTARTSYS;
+			goto out;
+		}
+	}
 out:
 	up(PIPE_SEM(*inode));
-out_nolock:
-	if (read)
-		ret = read;
-	return ret;
+	/* Signal asynchronously that the pipe became empty. */
+	if (read > 0 && !PIPE_LEN(*inode) && list_empty(&PIPE_PIO(*inode)))
+		wake_up_interruptible(PIPE_WAIT(*inode));
+
+	return read;
 }
 
 static ssize_t
 pipe_write(struct file *filp, const char *buf, size_t count, loff_t *ppos)
 {
 	struct inode *inode = filp->f_dentry->d_inode;
-	ssize_t free, written, ret;
+	size_t min;
+	size_t free;
+	ssize_t ret;
 
-	/* Seeks are not allowed on pipes.  */
-	ret = -ESPIPE;
-	written = 0;
+	/* pwrite is not allowed on pipes.  */
 	if (ppos != &filp->f_pos)
-		goto out_nolock;
+		return -ESPIPE;
 
 	/* Null write succeeds.  */
-	ret = 0;
 	if (count == 0)
-		goto out_nolock;
+		return 0;
 
-	ret = -ERESTARTSYS;
-	if (down_interruptible(PIPE_SEM(*inode)))
-		goto out_nolock;
+	down(PIPE_SEM(*inode));
 
 	/* No readers yields SIGPIPE.  */
+	ret = -EPIPE;
 	if (!PIPE_READERS(*inode))
-		goto sigpipe;
-
-	/* If count <= PIPE_BUF, we have to make it atomic.  */
-	free = (count <= PIPE_BUF ? count : 1);
+		goto out;
 
-	/* Wait, or check for, available space.  */
-	if (filp->f_flags & O_NONBLOCK) {
-		ret = -EAGAIN;
-		if (PIPE_FREE(*inode) < free)
+	free = 0;
+	if (list_empty(&PIPE_PIO(*inode)))
+		free = PIPE_FREE(*inode);
+	min = count;
+	if (min > PIPE_BUF && (filp->f_flags & O_NONBLOCK))
+		min = 1; /* no atomicity guarantee for transfers > PIPE_BUF */
+
+	if (free >= min) {
+		/* Enough space for the minimal transfer.
+		 * Use the kernel buffer.
+		 */
+		int offset;
+		ret = 0;
+next_chunk:
+		if (free > count)
+			free = count;
+		offset = PIPE_END(*inode);
+		if (free > PIPE_SIZE-offset)
+			free = PIPE_SIZE-offset;
+
+		if (copy_from_user(PIPE_BASE(*inode)+offset, buf, free)) {
+			if (!ret)
+				ret = -EFAULT;
 			goto out;
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
-			if (chars > count)
-				chars = count;
-			if (chars > space)
-				chars = space;
-
-			if (copy_from_user(pipebuf, buf, chars))
-				goto out;
 
-			written += chars;
-			PIPE_LEN(*inode) += chars;
-			count -= chars;
-			buf += chars;
-			space = PIPE_FREE(*inode);
-			continue;
+		ret += free;
+		PIPE_LEN(*inode) += free;
+		buf += free;
+		count -= free;
+				
+		inode->i_ctime = inode->i_mtime = CURRENT_TIME;
+		mark_inode_dirty(inode);
+		wake_up_interruptible(PIPE_WAIT(*inode));
+		if (count) {
+			free = PIPE_FREE(*inode);
+			if (free)
+				goto next_chunk;
 		}
+	} else if (filp->f_flags & O_NONBLOCK) {
+		ret = -EAGAIN;
+	} else {
+		/* Blocking transfer.
+		 * Set up single copy and wait until a reader
+		 * has eaten the data.
+		 */
+		struct pipe_pio pio_desc;
 
-		ret = written;
-		if (filp->f_flags & O_NONBLOCK)
-			break;
-
-		do {
-			/*
-			 * Synchronous wake-up: it knows that this process
-			 * is going to give up this CPU, so it doesnt have
-			 * to do idle reschedules.
-			 */
-			wake_up_interruptible_sync(PIPE_WAIT(*inode));
-			PIPE_WAITING_WRITERS(*inode)++;
-			pipe_wait(inode);
-			PIPE_WAITING_WRITERS(*inode)--;
-			if (signal_pending(current))
-				goto out;
-			if (!PIPE_READERS(*inode))
-				goto sigpipe;
-		} while (!PIPE_FREE(*inode));
 		ret = -EFAULT;
-	}
-
-	/* Signal readers asynchronously that there is more data.  */
-	wake_up_interruptible(PIPE_WAIT(*inode));
+		if(!access_ok(VERIFY_READ, buf, count))
+			goto out;
 
-	inode->i_ctime = inode->i_mtime = CURRENT_TIME;
-	mark_inode_dirty(inode);
+		list_add_tail(&pio_desc.list, &PIPE_PIO(*inode));
+		if (segment_eq(get_fs(),KERNEL_DS))
+			pio_desc.state = ADDR_KERNEL;
+		else
+			pio_desc.state = ADDR_USER;
+		pio_desc.tsk = current;
+		pio_desc.addr = (unsigned long)buf;
+		pio_desc.len = count;
+		
+		inode->i_ctime = inode->i_mtime = CURRENT_TIME;
+		mark_inode_dirty(inode);
 
+		/*
+		 * Synchronous wake-up: this process is going to
+		 * give up this CPU, so it doesn't have to do
+		 * idle reschedules.
+		 */
+		wake_up_interruptible_sync(PIPE_WAIT(*inode));
+		for(;;) {
+			pipe_wait(inode);
+			if (!pio_desc.state) {
+				ret = count;
+				break;
+			}
+			if (pio_desc.state < 0) {
+				/* FIXME:
+				 * ENOMEM is not a valid return code
+				 * for pipe_write. Under OOM the return
+				 * code could return ENOMEM.
+				 * do_exit(SIGKILL)?
+				 */
+				ret = pio_desc.state;
+				break;
+			}
+			/* No readers yields SIGPIPE.  */
+			if (!PIPE_READERS(*inode)) {
+				ret = count - pio_desc.len;
+				if (!ret)
+					ret = -EPIPE;
+				goto unwire;
+			}
+
+			if (signal_pending(current)) {
+				ret = count - pio_desc.len;
+				if (!ret)
+					ret = -ERESTARTSYS;
+unwire:
+				/* unwire single copy transfer */
+				list_del(&pio_desc.list);
+				if (!PIPE_LEN(*inode) && list_empty(&PIPE_PIO(*inode)))
+					wake_up_interruptible(PIPE_WAIT(*inode));
+				break;
+			}
+		}
+	}
 out:
 	up(PIPE_SEM(*inode));
-out_nolock:
-	if (written)
-		ret = written;
+	if (ret == -EPIPE)
+		send_sig(SIGPIPE, current, 0);
 	return ret;
-
-sigpipe:
-	if (written)
-		goto out;
-	up(PIPE_SEM(*inode));
-	send_sig(SIGPIPE, current, 0);
-	return -EPIPE;
 }
 
 static loff_t
@@ -264,13 +358,31 @@
 	return -EBADF;
 }
 
+static inline int pipe_getlen(struct inode *inode)
+{
+	unsigned long long len;
+	struct list_head *walk;
+
+	down(PIPE_SEM(*inode));
+	len = PIPE_LEN(*inode);
+	list_for_each(walk, &PIPE_PIO(*inode)) {
+		struct pipe_pio *pio;
+		pio = list_entry(PIPE_PIO(*inode).next, struct pipe_pio, list);
+		len += pio->len;
+	}
+	up(PIPE_SEM(*inode));
+	if (len > INT_MAX)
+		return INT_MAX;
+	return len;
+}
+
 static int
 pipe_ioctl(struct inode *pino, struct file *filp,
 	   unsigned int cmd, unsigned long arg)
 {
 	switch (cmd) {
 		case FIONREAD:
-			return put_user(PIPE_LEN(*pino), (int *)arg);
+			return put_user(pipe_getlen(pino), (int *)arg);
 		default:
 			return -EINVAL;
 	}
@@ -287,7 +399,7 @@
 
 	/* Reading only -- no need for acquiring the semaphore.  */
 	mask = POLLIN | POLLRDNORM;
-	if (PIPE_EMPTY(*inode))
+	if (!PIPE_LEN(*inode) && list_empty(&PIPE_PIO(*inode)))
 		mask = POLLOUT | POLLWRNORM;
 	if (!PIPE_WRITERS(*inode) && filp->f_version != PIPE_WCOUNTER(*inode))
 		mask |= POLLHUP;
@@ -454,9 +566,9 @@
 
 	init_waitqueue_head(PIPE_WAIT(*inode));
 	PIPE_BASE(*inode) = (char*) page;
+	INIT_LIST_HEAD(&PIPE_PIO(*inode));
 	PIPE_START(*inode) = PIPE_LEN(*inode) = 0;
 	PIPE_READERS(*inode) = PIPE_WRITERS(*inode) = 0;
-	PIPE_WAITING_READERS(*inode) = PIPE_WAITING_WRITERS(*inode) = 0;
 	PIPE_RCOUNTER(*inode) = PIPE_WCOUNTER(*inode) = 1;
 
 	return inode;
--- 2.4/include/linux/pipe_fs_i.h	Mon May  7 20:43:38 2001
+++ build-2.4/include/linux/pipe_fs_i.h	Mon May  7 19:38:12 2001
@@ -5,12 +5,11 @@
 struct pipe_inode_info {
 	wait_queue_head_t wait;
 	char *base;
-	unsigned int len;
+	unsigned int len;	/* not including pio buffers */
 	unsigned int start;
+	struct list_head pio;
 	unsigned int readers;
 	unsigned int writers;
-	unsigned int waiting_readers;
-	unsigned int waiting_writers;
 	unsigned int r_counter;
 	unsigned int w_counter;
 };
@@ -24,19 +23,14 @@
 #define PIPE_BASE(inode)	((inode).i_pipe->base)
 #define PIPE_START(inode)	((inode).i_pipe->start)
 #define PIPE_LEN(inode)		((inode).i_pipe->len)
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
--- 2.4/fs/fifo.c	Mon May  7 20:43:38 2001
+++ build-2.4/fs/fifo.c	Mon May  7 19:38:12 2001
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
 



--------------63F5781459667C73576839B4
Content-Type: text/plain; charset=us-ascii;
 name="patch-copy_user_user"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-copy_user_user"

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 4
//  SUBLEVEL = 4
//  EXTRAVERSION =
--- 2.4/kernel/ptrace.c	Sat Mar 31 21:49:29 2001
+++ build-2.4/kernel/ptrace.c	Fri May 11 18:38:02 2001
@@ -19,13 +19,14 @@
 /*
  * Access another process' address space, one page at a time.
  */
-static int access_one_page(struct mm_struct * mm, struct vm_area_struct * vma, unsigned long addr, void *buf, int len, int write)
+static int access_one_page(struct mm_struct * mm, struct vm_area_struct * vma, unsigned long addr, void *buf, size_t len, int write)
 {
 	pgd_t * pgdir;
 	pmd_t * pgmiddle;
 	pte_t * pgtable;
 	char *maddr; 
 	struct page *page;
+	int i;
 
 repeat:
 	spin_lock(&mm->page_table_lock);
@@ -50,7 +51,7 @@
 	if (page != ZERO_PAGE(addr) || write) {
 		if ((!VALID_PAGE(page)) || PageReserved(page)) {
 			spin_unlock(&mm->page_table_lock);
-			return 0;
+			return OTHER_EFAULT;
 		}
 	}
 	get_page(page);
@@ -59,38 +60,40 @@
 
 	if (write) {
 		maddr = kmap(page);
-		memcpy(maddr + (addr & ~PAGE_MASK), buf, len);
+		i = copy_from_user(maddr + (addr & ~PAGE_MASK), buf, len);
 		flush_page_to_ram(page);
 		flush_icache_page(vma, page);
 		kunmap(page);
 	} else {
 		maddr = kmap(page);
-		memcpy(buf, maddr + (addr & ~PAGE_MASK), len);
+		i = copy_to_user(buf, maddr + (addr & ~PAGE_MASK), len);
 		flush_page_to_ram(page);
 		kunmap(page);
 	}
 	put_page(page);
-	return len;
+	return i ? CUR_EFAULT : 0;
 
 fault_in_page:
 	spin_unlock(&mm->page_table_lock);
 	/* -1: out of memory. 0 - unmapped page */
-	if (handle_mm_fault(mm, vma, addr, write) > 0)
+	i = handle_mm_fault(mm, vma, addr, write);
+	if (i > 0)
 		goto repeat;
-	return 0;
-
+	if (i < 0)
+		return OTHER_ENOMEM;
+	return OTHER_EFAULT;
 bad_pgd:
 	spin_unlock(&mm->page_table_lock);
 	pgd_ERROR(*pgdir);
-	return 0;
+	return OTHER_EFAULT;
 
 bad_pmd:
 	spin_unlock(&mm->page_table_lock);
 	pmd_ERROR(*pgmiddle);
-	return 0;
+	return OTHER_EFAULT;
 }
 
-static int access_mm(struct mm_struct *mm, struct vm_area_struct * vma, unsigned long addr, void *buf, int len, int write)
+static int access_mm(struct mm_struct *mm, struct vm_area_struct * vma, unsigned long addr, void *buf, size_t len, int write, int *pcopied)
 {
 	int copied = 0;
 
@@ -102,11 +105,14 @@
 		if (this_len > len)
 			this_len = len;
 		retval = access_one_page(mm, vma, addr, buf, this_len, write);
-		copied += retval;
-		if (retval != this_len)
-			break;
+		if (retval) {
+			if (pcopied)
+				*pcopied = copied;
+			return retval;
+		}
+		copied += this_len;
 
-		len -= retval;
+		len -= this_len;
 		if (!len)
 			break;
 
@@ -115,17 +121,20 @@
 
 		if (addr < vma->vm_end)
 			continue;	
-		if (!vma->vm_next)
-			break;
-		if (vma->vm_next->vm_start != vma->vm_end)
-			break;
+		if (!vma->vm_next || vma->vm_next->vm_start != vma->vm_end) {
+			if (pcopied)
+				*pcopied = copied;
+			return OTHER_EFAULT;
+		}
 	
 		vma = vma->vm_next;
 	}
-	return copied;
+	if (pcopied)
+		*pcopied = copied;
+	return 0;
 }
 
-int access_process_vm(struct task_struct *tsk, unsigned long addr, void *buf, int len, int write)
+int access_process_vm(struct task_struct *tsk, unsigned long addr, void *buf, size_t len, int write)
 {
 	int copied;
 	struct mm_struct *mm;
@@ -143,12 +152,44 @@
 	down_read(&mm->mmap_sem);
 	vma = find_extend_vma(mm, addr);
 	copied = 0;
-	if (vma)
-		copied = access_mm(mm, vma, addr, buf, len, write);
+	if (vma) {
+		mm_segment_t old;
+		old = get_fs();
+		set_fs(KERNEL_DS);
+		/* silently ignore failues, perhaps the caller
+		 * is interested in partial transfers
+		 */
+		access_mm(mm, vma, addr, buf, len, write, &copied);
+		set_fs(old);
+	}
 
 	up_read(&mm->mmap_sem);
 	mmput(mm);
 	return copied;
+}
+
+/* 
+ * transfers 'len' bytes from/to from 'mm:oaddr' to/from
+ * 'current->mm:cbuf'.
+ * The caller must guarantee that mm won't go away.
+ * if do_write is true, then the data is written into 'mm:oaddr' 
+ * Return 0 on success.
+ */
+
+
+int copy_user_to_user(char *cbuf, struct mm_struct *mm, unsigned long oaddr, size_t len, int do_write)
+{
+	struct vm_area_struct * vma;
+	int retval;
+	down_read(&mm->mmap_sem);
+	vma = find_extend_vma(mm, oaddr);
+	if (vma)
+		retval = access_mm(mm, vma, oaddr, cbuf, len, do_write, NULL);
+	else
+		retval = OTHER_EFAULT;
+
+	up_read(&mm->mmap_sem);
+	return retval;
 }
 
 int ptrace_readdata(struct task_struct *tsk, unsigned long src, char *dst, int len)
--- 2.4/include/linux/mm.h	Wed May  9 21:03:43 2001
+++ build-2.4/include/linux/mm.h	Fri May 11 17:17:54 2001
@@ -399,9 +399,15 @@
 extern pte_t *FASTCALL(pte_alloc(struct mm_struct *mm, pmd_t *pmd, unsigned long address));
 extern int handle_mm_fault(struct mm_struct *mm,struct vm_area_struct *vma, unsigned long address, int write_access);
 extern int make_pages_present(unsigned long addr, unsigned long end);
-extern int access_process_vm(struct task_struct *tsk, unsigned long addr, void *buf, int len, int write);
+extern int access_process_vm(struct task_struct *tsk, unsigned long addr, void *buf, size_t len, int write);
 extern int ptrace_readdata(struct task_struct *tsk, unsigned long src, char *dst, int len);
 extern int ptrace_writedata(struct task_struct *tsk, char * src, unsigned long dst, int len);
+
+#define OTHER_EFAULT	1
+#define OTHER_ENOMEM	2
+#define CUR_EFAULT	3
+extern int copy_user_to_user(char *cbuf, struct mm_struct *mm, unsigned long oaddr, size_t len, int do_write);
+
 
 /*
  * On a two-level page table, this ends up being trivial. Thus the


--------------63F5781459667C73576839B4--


