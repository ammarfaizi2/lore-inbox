Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136503AbREDU47>; Fri, 4 May 2001 16:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136504AbREDU4v>; Fri, 4 May 2001 16:56:51 -0400
Received: from colorfullife.com ([216.156.138.34]:40718 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S136503AbREDU4e>;
	Fri, 4 May 2001 16:56:34 -0400
Message-ID: <3AF30EAA.9F0D233E@colorfullife.com>
Date: Fri, 04 May 2001 22:18:50 +0200
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-0.1.9smp i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: RFC: new zero copy pipe
Content-Type: multipart/mixed;
 boundary="------------920DA10E468528B11F3889B5"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------920DA10E468528B11F3889B5
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

I've rewritten the single copy pipe code again.
Main changes:

* doesn't use map_user_kiobuf anymore. That function locked the pages
into memory. DoS attacks were possible. Now pages stay pageable.
* simpler code, fewer loops.
* support added for set_fs(KERNEL_DS)+pipe_write
* all transfers that block now use single copy. This should reduce the
number of context switches.

The patch is not yet fully tested, but boots, compiles kernels and
survives man <long man page>.

Should I merge pio_copy_to_user() with access_process_vm()?
The main part of pio_copy_to_user() is access_process_vm(), but with
copy_to_user() instead of memmove().

--
	Manfred
--------------920DA10E468528B11F3889B5
Content-Type: text/plain; charset=us-ascii;
 name="patch-newpipe"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-newpipe"

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 4
//  SUBLEVEL = 4
//  EXTRAVERSION =
--- 2.4/fs/pipe.c	Thu Feb 22 22:29:46 2001
+++ build-2.4/fs/pipe.c	Fri May  4 21:35:37 2001
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
@@ -36,214 +41,380 @@
 	down(PIPE_SEM(*inode));
 }
 
+#define ASSERT(x)	do { if (!(x)) BUG(); } while(0)
+
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
+/*
+ * Do a quick page-table lookup for a single page. 
+ */
+static struct page * follow_page(struct mm_struct *mm, unsigned long address) 
+{
+	pgd_t *pgd;
+	pmd_t *pmd;
+	pte_t *ptep, pte;
+
+	pgd = pgd_offset(mm, address);
+	if (pgd_none(*pgd) || pgd_bad(*pgd))
+		goto out;
+
+	pmd = pmd_offset(pgd, address);
+	if (pmd_none(*pmd) || pmd_bad(*pmd))
+		goto out;
+
+	ptep = pte_offset(pmd, address);
+	if (!ptep)
+		goto out;
+
+	pte = *ptep;
+	if (pte_present(pte))
+		return pte_page(pte);
+out:
+	return 0;
+}
+
+static int
+pio_copy_to_user(struct inode* inode, char* ubuf, int chars)
+{
+	/* pio->tsk is within pipe_write(), we don't have to protect
+	 * against sudden death of that thread.
+	 */
+	struct pipe_pio* pio;
+	struct mm_struct* mm;
+	struct vm_area_struct * vma;
+	int read;
+
+	pio = list_entry(PIPE_PIO(*inode).next, struct pipe_pio, list);
+	ASSERT(pio->state>0);
+	mm = pio->tsk->mm;
+
+	if (chars > pio->len)
+		chars = pio->len;
+	if (pio->state == ADDR_KERNEL) {
+		/* kernel thread writes into a pipe. */
+		if(copy_to_user(ubuf, (void*)pio->addr, chars)) {
+			return -EFAULT;
+		}
+		pio->addr += chars;
+		pio->len -= chars;
+		read = chars;
+		goto done;
+	}
+	down_read(&mm->mmap_sem);
+	read = 0;
+	ASSERT(chars != 0);
+	goto start;
+	do {
+		struct page *page;
+		void *kaddr;
+		int pcount;
+		int r;
+		if (pio->addr >= vma->vm_end) {
+start:
+			vma = find_extend_vma(mm, pio->addr);
+			if (!vma) {
+				up_read(&mm->mmap_sem);
+				pio->state = -EFAULT;
+				goto unlink;
+			}
+		}
+
+repeat:
+		spin_lock(&mm->page_table_lock);
+		page = follow_page(mm, pio->addr);
+		if (!page) {
+			int ret;
+			spin_unlock(&mm->page_table_lock);
+			/* -1: out of memory. 0 - unmapped page */
+			ret = handle_mm_fault(mm, vma, pio->addr, 0);
+			if (ret > 0)
+				goto repeat;
+			up_read(&mm->mmap_sem);
+			if (ret < 0)
+				pio->state = -ENOMEM;
+			else
+				pio->state = -EFAULT;
+			goto unlink;
+		}
+		get_page(page);
+		spin_unlock(&mm->page_table_lock);
+
+		kaddr = kmap(page);
+		flush_cache_page(vma, pio->addr);
+
+		pcount = PAGE_SIZE-pio->addr%PAGE_SIZE;
+		if (pcount > chars)
+			pcount = chars;
+		r = copy_to_user(ubuf, kaddr+pio->addr%PAGE_SIZE, pcount);
+		flush_page_to_ram(page);
+		kunmap(page);
+		put_page(page);
+		if (r) {
+			up_read(&mm->mmap_sem);
+			return -EFAULT;
+		}
+
+		chars -= pcount;
+		ubuf += pcount;
+		pio->addr += pcount;
+		pio->len -= pcount;
+		read += pcount;
+	} while (chars);
+
+	up_read(&mm->mmap_sem);
+done:
+	if (!pio->len) {
+		pio->state = 0;
+unlink:
+		list_del(&pio->list);
+		wake_up_process(pio->tsk);
+		if (!read && list_empty(&PIPE_PIO(*inode))) {
+			/*
+			 * If someone wrote a block with a bad
+			 * pointer, then a full pipe becomes empty
+			 * although no data was transfered.
+			 * Wakeup everyone to recover.
+			 */
+			wake_up_interruptible(PIPE_WAIT(*inode));
+		}
+	}
+	return read;
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
+				read = -EFAULT;
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
+				read = chars;
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
+			goto out; /* common path: done */
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
+		if (read)
+			goto out;
+
+		/*  - don't sleep if no process has the pipe open
+		 *	 for writing
+		 */
+		if (!PIPE_WRITERS(*inode))
+			goto out;
+
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
 	}
-	/* Signal writers asynchronously that there is more room.  */
-	wake_up_interruptible(PIPE_WAIT(*inode));
 
-	ret = read;
 out:
 	up(PIPE_SEM(*inode));
-out_nolock:
-	if (read)
-		ret = read;
-	return ret;
+	/* Signal asynchronously that the pipe is empty. */
+	if ((read > 0) && !PIPE_LEN(*inode) && list_empty(&PIPE_PIO(*inode)))
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
+	unsigned int free;
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
+		goto out;
 
-	/* If count <= PIPE_BUF, we have to make it atomic.  */
-	free = (count <= PIPE_BUF ? count : 1);
+	free = 0;
+	if (list_empty(&PIPE_PIO(*inode)))
+		free = PIPE_FREE(*inode);
+	min = count;
+	if (min > PIPE_BUF && (filp->f_flags & O_NONBLOCK))
+		min = 1; /* no atomicity guarantee for transfers > PIPE_BUF */
+
+	if (free >= min) {
+		/* enough space for the minimal transfer.
+		 * Use the kernel space buffer
+		 */
+		int offset;
+		ret = 0;
+next_chunk:
+		offset = PIPE_END(*inode);
 
-	/* Wait, or check for, available space.  */
-	if (filp->f_flags & O_NONBLOCK) {
-		ret = -EAGAIN;
-		if (PIPE_FREE(*inode) < free)
+		if (free > count)
+			free = count;
+		if (free > PIPE_SIZE-offset)
+			free = PIPE_SIZE-offset;
+
+		if (copy_from_user(PIPE_BASE(*inode)+offset, buf, free)) {
+			ret = -EFAULT;
 			goto out;
-	} else {
-		while (PIPE_FREE(*inode) < free) {
-			PIPE_WAITING_WRITERS(*inode)++;
-			pipe_wait(inode);
-			PIPE_WAITING_WRITERS(*inode)--;
-			ret = -ERESTARTSYS;
-			if (signal_pending(current))
-				goto out;
+		}
 
-			if (!PIPE_READERS(*inode))
-				goto sigpipe;
+		ret += free;
+		PIPE_LEN(*inode) += free;
+		buf += free;
+		count -= free;
+				
+		if (count) {
+			free = PIPE_FREE(*inode);
+			if (free)
+				goto next_chunk;
 		}
-	}
+		inode->i_ctime = inode->i_mtime = CURRENT_TIME;
+		mark_inode_dirty(inode);
+		wake_up_interruptible(PIPE_WAIT(*inode));
+	} else if (filp->f_flags & O_NONBLOCK) {
+		ret = -EAGAIN;
+	} else {
+		/* use single copy transfer, and wait until a reader
+		 * has eaten that data.
+		 */
+		struct pipe_pio pio_desc;
 
-	/* Copy into available space.  */
-	ret = -EFAULT;
-	while (count > 0) {
-		int space;
-		char *pipebuf = PIPE_BASE(*inode) + PIPE_END(*inode);
-		ssize_t chars = PIPE_MAX_WCHUNK(*inode);
+		ret = -EFAULT;
+		if(!access_ok(VERIFY_READ, buf, count))
+			goto out;
 
-		if ((space = PIPE_FREE(*inode)) != 0) {
-			if (chars > count)
-				chars = count;
-			if (chars > space)
-				chars = space;
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
 
-			if (copy_from_user(pipebuf, buf, chars))
+		/*
+		 * Synchronous wake-up: this process is going to
+		 * give up this CPU, so it doesnt have to do
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
+				/* unwire single copy transfer */
+				list_del(&pio_desc.list);
+				ret = count - pio_desc.len;
+				if (!ret)
+					ret = -EPIPE;
 				goto out;
+			}
 
-			written += chars;
-			PIPE_LEN(*inode) += chars;
-			count -= chars;
-			buf += chars;
-			space = PIPE_FREE(*inode);
-			continue;
+			if (signal_pending(current)) {
+				/* unwire single copy transfer */
+				list_del(&pio_desc.list);
+				ret = count - pio_desc.len;
+				if (!ret)
+					ret = -ERESTARTSYS;
+				break;
+			}
 		}
-
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
-		ret = -EFAULT;
 	}
-
-	/* Signal readers asynchronously that there is more data.  */
-	wake_up_interruptible(PIPE_WAIT(*inode));
-
-	inode->i_ctime = inode->i_mtime = CURRENT_TIME;
-	mark_inode_dirty(inode);
-
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
@@ -264,13 +435,31 @@
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
+		struct pipe_pio * pio;
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
@@ -285,10 +474,11 @@
 
 	poll_wait(filp, PIPE_WAIT(*inode), wait);
 
-	/* Reading only -- no need for acquiring the semaphore.  */
 	mask = POLLIN | POLLRDNORM;
-	if (PIPE_EMPTY(*inode))
+	/* Reading only -- no need for acquiring the semaphore.  */
+	if (!PIPE_LEN(*inode) && list_empty(&PIPE_PIO(*inode)))
 		mask = POLLOUT | POLLWRNORM;
+
 	if (!PIPE_WRITERS(*inode) && filp->f_version != PIPE_WCOUNTER(*inode))
 		mask |= POLLHUP;
 	if (!PIPE_READERS(*inode))
@@ -454,9 +644,9 @@
 
 	init_waitqueue_head(PIPE_WAIT(*inode));
 	PIPE_BASE(*inode) = (char*) page;
+	INIT_LIST_HEAD(&PIPE_PIO(*inode));
 	PIPE_START(*inode) = PIPE_LEN(*inode) = 0;
 	PIPE_READERS(*inode) = PIPE_WRITERS(*inode) = 0;
-	PIPE_WAITING_READERS(*inode) = PIPE_WAITING_WRITERS(*inode) = 0;
 	PIPE_RCOUNTER(*inode) = PIPE_WCOUNTER(*inode) = 1;
 
 	return inode;
--- 2.4/include/linux/pipe_fs_i.h	Mon Apr 30 23:14:13 2001
+++ build-2.4/include/linux/pipe_fs_i.h	Fri May  4 15:50:58 2001
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
--- 2.4/fs/fifo.c	Thu Feb 22 22:29:43 2001
+++ build-2.4/fs/fifo.c	Fri May  4 20:42:22 2001
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
 

--------------920DA10E468528B11F3889B5--


