Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130038AbRCLQnL>; Mon, 12 Mar 2001 11:43:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130480AbRCLQnG>; Mon, 12 Mar 2001 11:43:06 -0500
Received: from colorfullife.com ([216.156.138.34]:14099 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S130038AbRCLQmz>;
	Mon, 12 Mar 2001 11:42:55 -0500
Message-ID: <3AACFC6A.67E570AA@colorfullife.com>
Date: Mon, 12 Mar 2001 17:42:18 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-ac17 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
CC: linux-kernel@vger.kernel.org, mikeg@wen-online.de
Subject: Re: Feedback for fastselect and one-copy-pipe
In-Reply-To: <20010312151548.B878@nightmaster.csn.tu-chemnitz.de>
Content-Type: multipart/mixed;
 boundary="------------7FB31BA4F02EDD676EE2F1A0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------7FB31BA4F02EDD676EE2F1A0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Ingo Oeser wrote:
> 
> Hi Manfred,
> 
> I'm running your patches [1] with sucess for a while now.
> 
> Did you get any feedback about problems regarding these patches?
>
No feedback yet.

> They seem to work for me, but there seems to be a memleak in
> 2.4.x (x: 0-2), which I'm chasing down.
>
You are right, there's a stupid bug in my poll patch:

p = kmalloc(PAGE_SIZE);
free_page((unsigned long)p);

This causes a memory leak for the slab control structures.

> 
> [1] put on http://www.tu-chemnitz.de/~ioe/fastpipe.patch
>
That's davem's original 
I rewrote it because I didn't like the nested loops. pipe_read() and
_write() were never easy to follow, and adding yet another set of goto &
for(;;) loops is IMHO a bad idea.

The main difference between my patch and davem's patch is that davem
uses zerocopy for exactly PAGE_SIZE sized transfers, I only use it for
transfers larger than PIPE_BUF.

<<<<< davem's patch
+       if (count >= PAGE_SIZE &&
+           !(filp->f_flags & O_NONBLOCK)) {
<<<<<<< my patch
+  if (count > PIPE_BUF && chars == PIPE_SIZE &&
+      (!(filp->f_flags & O_NONBLOCK))) {
<<<<<<<

On i386 PIPE_BUF is 4096, and thus

* davem's patch is faster, since glibc by default writes in 4096 byte
blocks
* davem's patch breaks apps that assume that write(,PIPE_BUF) after
poll(POLLOUT) never blocks, even for blocking pipes.

I've attached the newest versions of both patches.


--
	Manfred
--------------7FB31BA4F02EDD676EE2F1A0
Content-Type: text/plain; charset=us-ascii;
 name="patch-kiopipe"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-kiopipe"

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 4
//  SUBLEVEL = 2
//  EXTRAVERSION = -ac17
--- 2.4/fs/pipe.c	Thu Feb 22 22:29:46 2001
+++ build-2.4/fs/pipe.c	Mon Mar 12 16:02:48 2001
@@ -2,6 +2,9 @@
  *  linux/fs/pipe.c
  *
  *  Copyright (C) 1991, 1992, 1999  Linus Torvalds
+ *
+ *  Major pipe_read() and pipe_write() cleanup, kiobuf based
+ *  single copy		Copyright (C) 2001 Manfred Spraul
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
@@ -36,97 +41,149 @@
 	down(PIPE_SEM(*inode));
 }
 
+struct pipe_pio {
+	int *pdone;
+	struct kiobuf iobuf;
+};
+
+static int
+pio_copy_to_user(struct kiobuf* iobuf, int offset, char* ubuf, int chars)
+{
+	int page_nr;
+	offset += iobuf->offset;
+	page_nr = offset/PAGE_SIZE;
+	offset %= PAGE_SIZE;
+	while(chars) {
+		int pcount = PAGE_SIZE-offset;
+		void *kaddr;
+		if (pcount > chars)
+			pcount = chars;
+		kaddr = kmap(iobuf->maplist[page_nr]);
+		if (copy_to_user(ubuf, kaddr+offset, pcount))
+			return 1;
+		kunmap(iobuf->maplist[page_nr]);
+		chars -= pcount;
+		ubuf += pcount;
+		offset = 0;
+		page_nr++;
+	}
+	return 0;
+}
+
 static ssize_t
 pipe_read(struct file *filp, char *buf, size_t count, loff_t *ppos)
 {
 	struct inode *inode = filp->f_dentry->d_inode;
-	ssize_t size, read, ret;
+	ssize_t read, ret;
 
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
+	down(PIPE_SEM(*inode));
 
-	if (PIPE_EMPTY(*inode)) {
-do_more_read:
+	read = 0;
+	for (;;) {
+		/* read what data is available */
+		int chars = PIPE_LEN(*inode);
+		if (chars) {
+			char *pipebuf = PIPE_BASE(*inode);
+			int offset = PIPE_START(*inode);
+
+			if (chars > count)
+				chars = count;
+			ret = -EFAULT;
+			if(PIPE_IS_PIO(*inode)) {
+				struct pipe_pio* pio = ((struct pipe_pio*)pipebuf);
+				if(pio_copy_to_user(&pio->iobuf, offset, buf, chars))
+					goto out;
+
+				PIPE_LEN(*inode) -= chars;
+				if(!PIPE_LEN(*inode)) {
+					unmap_kiobuf(&pio->iobuf);
+					*pio->pdone = 1;
+					PIPE_IS_PIO(*inode) = 0;
+					PIPE_START(*inode) = 0;
+				} else {
+					PIPE_START(*inode) += chars;
+				}
+			} else {
+				if (chars > PIPE_SIZE-offset)
+					chars = PIPE_SIZE-offset;
+				if (copy_to_user(buf, pipebuf+offset, chars))
+					goto out;
+				PIPE_LEN(*inode) -= chars;
+				if (!PIPE_LEN(*inode)) {
+					/* Cache behaviour optimization */
+					PIPE_START(*inode) = 0;
+				} else {
+					PIPE_START(*inode) += chars;
+					PIPE_START(*inode) &= (PIPE_SIZE - 1);
+				}
+			}
+			read += chars;
+			count -= chars;
+			buf += chars;
+		}
 		ret = 0;
+		if (!count)
+			goto out;
+	
+		/* Rare special case:
+		 * The pipe buffer was really circular,
+		 * the wrapped bytes must be read before sleeping.
+		 */
+		if (PIPE_LEN(*inode))
+			continue;
+
+		/* Never sleep if no process has the pipe open
+		 * for writing */
 		if (!PIPE_WRITERS(*inode))
 			goto out;
 
+		/* Never sleep if O_NONBLOCK is set */
 		ret = -EAGAIN;
 		if (filp->f_flags & O_NONBLOCK)
 			goto out;
 
-		for (;;) {
-			PIPE_WAITING_READERS(*inode)++;
-			pipe_wait(inode);
-			PIPE_WAITING_READERS(*inode)--;
-			ret = -ERESTARTSYS;
-			if (signal_pending(current))
-				goto out;
+		/* optimization:
+		 * pipe_read() should return even if only a single byte
+		 * was read.  (Posix Std. 6.4.1.2)
+		 * But if another process is sleeping in pipe_write()
+		 * then we wait for that data - it's invisible for user
+		 * space programs.
+		 */
+		if (PIPE_MORE_DATA_WAITING(*inode)) {
+			/*
+			 * We know that we are going to sleep: signal
+			 * writers synchronously that there is more
+			 * room.
+			 */
+			wake_up_interruptible_sync(PIPE_WAIT(*inode));
+		} else if (read) {
+			/* We know that there are no writers, no need
+			 * for wake up.
+			 */
 			ret = 0;
-			if (!PIPE_EMPTY(*inode))
-				break;
-			if (!PIPE_WRITERS(*inode))
-				goto out;
+			goto out;
 		}
-	}
 
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
+		pipe_wait(inode);
+		ret = -ERESTARTSYS;
+		if (signal_pending(current))
 			goto out;
-
-		read += chars;
-		PIPE_START(*inode) += chars;
-		PIPE_START(*inode) &= (PIPE_SIZE - 1);
-		PIPE_LEN(*inode) -= chars;
-		count -= chars;
-		buf += chars;
 	}
 
-	/* Cache behaviour optimization */
-	if (!PIPE_LEN(*inode))
-		PIPE_START(*inode) = 0;
-
-	if (count && PIPE_WAITING_WRITERS(*inode) && !(filp->f_flags & O_NONBLOCK)) {
-		/*
-		 * We know that we are going to sleep: signal
-		 * writers synchronously that there is more
-		 * room.
-		 */
-		wake_up_interruptible_sync(PIPE_WAIT(*inode));
-		if (!PIPE_EMPTY(*inode))
-			BUG();
-		goto do_more_read;
-	}
+out:
 	/* Signal writers asynchronously that there is more room.  */
-	wake_up_interruptible(PIPE_WAIT(*inode));
+	if (read && !PIPE_IS_PIO(*inode))
+		wake_up_interruptible(PIPE_WAIT(*inode));
 
-	ret = read;
-out:
 	up(PIPE_SEM(*inode));
-out_nolock:
 	if (read)
 		ret = read;
 	return ret;
@@ -137,113 +194,143 @@
 {
 	struct inode *inode = filp->f_dentry->d_inode;
 	ssize_t free, written, ret;
+	int pio_done, do_wakeup;
 
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
-
-	ret = -ERESTARTSYS;
-	if (down_interruptible(PIPE_SEM(*inode)))
-		goto out_nolock;
+		return 0;
 
-	/* No readers yields SIGPIPE.  */
-	if (!PIPE_READERS(*inode))
-		goto sigpipe;
+	down(PIPE_SEM(*inode));
 
 	/* If count <= PIPE_BUF, we have to make it atomic.  */
 	free = (count <= PIPE_BUF ? count : 1);
 
-	/* Wait, or check for, available space.  */
-	if (filp->f_flags & O_NONBLOCK) {
-		ret = -EAGAIN;
-		if (PIPE_FREE(*inode) < free)
+	written = 0;
+	pio_done = 1;
+	do_wakeup = 0;
+	for(;;) {
+		/* No readers yields SIGPIPE.  */
+		ret = -EPIPE;
+		if (!PIPE_READERS(*inode))
 			goto out;
-	} else {
-		while (PIPE_FREE(*inode) < free) {
-			PIPE_WAITING_WRITERS(*inode)++;
-			pipe_wait(inode);
-			PIPE_WAITING_WRITERS(*inode)--;
-			ret = -ERESTARTSYS;
-			if (signal_pending(current))
-				goto out;
 
-			if (!PIPE_READERS(*inode))
-				goto sigpipe;
-		}
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
-
-			written += chars;
-			PIPE_LEN(*inode) += chars;
-			count -= chars;
-			buf += chars;
-			space = PIPE_FREE(*inode);
-			continue;
+		if(!PIPE_IS_PIO(*inode)) {
+			int chars;
+			/* Copy into available space.  */
+			chars = PIPE_FREE(*inode);
+		
+			/*
+			 * Try zero-copy:
+			 * - only possible if the normal pipe buffer
+			 *   is empty
+			 * - only possible if we can block:
+			 *   a) O_NONBLOCK not set
+			 *	and
+			 *   b) request for more than PIPE_BUF bytes.
+			 *	No Unix version blocks in pipe write for
+			 *	<= PIPE_BUF bytes after poll() returned POLLOUT.
+			 */
+			ret = -EFAULT;
+			if (count > PIPE_BUF && chars == PIPE_SIZE &&
+				    (!(filp->f_flags & O_NONBLOCK))) {
+				struct pipe_pio* pio = (struct pipe_pio*)PIPE_BASE(*inode);
+				chars = KIO_MAX_ATOMIC_BYTES;
+				if (chars > count)
+					chars = count;
+				kiobuf_init(&pio->iobuf);
+				if(map_user_kiobuf(READ, &pio->iobuf, (unsigned long)buf, chars))
+					goto out;
+				PIPE_IS_PIO(*inode) = 1;
+				pio_done = 0;
+				pio->pdone = &pio_done;
+
+				written += chars;
+				PIPE_LEN(*inode) += chars;
+				count -= chars;
+				buf += chars;
+				do_wakeup = 1;
+			} else if (chars >= free) {
+				int offset;
+next_chunk:
+				offset = PIPE_END(*inode);
+
+				if (chars > count)
+					chars = count;
+				if (chars > PIPE_SIZE-offset)
+					chars = PIPE_SIZE-offset;
+				if (copy_from_user(PIPE_BASE(*inode)+offset, buf, chars))
+					goto out;
+
+				written += chars;
+				PIPE_LEN(*inode) += chars;
+				count -= chars;
+				buf += chars;
+				do_wakeup = 1;
+				
+				if(!count)
+					break; /* DONE! */
+
+				/* special case: pipe buffer wrapped */
+				if(PIPE_LEN(*inode) != PIPE_SIZE) {
+					chars = PIPE_FREE(*inode);
+					goto next_chunk;
+				}
+			}
 		}
 
-		ret = written;
+		ret = -EAGAIN;
 		if (filp->f_flags & O_NONBLOCK)
 			break;
 
-		do {
+		/* Do not wakeup unless data was written, otherwise
+		 * multiple writers can cause a wakeup storm
+		 */
+		if(do_wakeup) {
 			/*
 			 * Synchronous wake-up: it knows that this process
 			 * is going to give up this CPU, so it doesnt have
 			 * to do idle reschedules.
 			 */
 			wake_up_interruptible_sync(PIPE_WAIT(*inode));
-			PIPE_WAITING_WRITERS(*inode)++;
-			pipe_wait(inode);
-			PIPE_WAITING_WRITERS(*inode)--;
-			if (signal_pending(current))
-				goto out;
-			if (!PIPE_READERS(*inode))
-				goto sigpipe;
-		} while (!PIPE_FREE(*inode));
-		ret = -EFAULT;
+			do_wakeup = 0;
+		}
+		if (count)
+			PIPE_MORE_DATA_WAITING(*inode)++;
+		pipe_wait(inode);
+		if (count)
+			PIPE_MORE_DATA_WAITING(*inode)--;
+		if (!count && pio_done)
+			break; /* DONE */
+		ret = -ERESTARTSYS;
+		if (signal_pending(current))
+			goto out;
 	}
-
-	/* Signal readers asynchronously that there is more data.  */
-	wake_up_interruptible(PIPE_WAIT(*inode));
-
-	inode->i_ctime = inode->i_mtime = CURRENT_TIME;
-	mark_inode_dirty(inode);
-
 out:
-	up(PIPE_SEM(*inode));
-out_nolock:
-	if (written)
-		ret = written;
-	return ret;
+	if(!pio_done) {
+		struct pipe_pio* pio = (struct pipe_pio*)PIPE_BASE(*inode);
+		PIPE_IS_PIO(*inode) = 0;
+		written -= PIPE_LEN(*inode);
+		PIPE_LEN(*inode) = 0;
+		unmap_kiobuf(&pio->iobuf);
+		wake_up_interruptible(PIPE_WAIT(*inode));
+	}
+	if (written) {
+		inode->i_ctime = inode->i_mtime = CURRENT_TIME;
+		mark_inode_dirty(inode);
 
-sigpipe:
-	if (written)
-		goto out;
+		ret = written;
+	}
 	up(PIPE_SEM(*inode));
-	send_sig(SIGPIPE, current, 0);
-	return -EPIPE;
+	/* Signal readers asynchronously that there is more data.  */
+	if(do_wakeup)
+		wake_up_interruptible(PIPE_WAIT(*inode));
+	if (ret == -EPIPE)
+		send_sig(SIGPIPE, current, 0);
+	return ret;
 }
 
 static loff_t
@@ -454,9 +541,10 @@
 
 	init_waitqueue_head(PIPE_WAIT(*inode));
 	PIPE_BASE(*inode) = (char*) page;
+	PIPE_IS_PIO(*inode) = 0;
 	PIPE_START(*inode) = PIPE_LEN(*inode) = 0;
 	PIPE_READERS(*inode) = PIPE_WRITERS(*inode) = 0;
-	PIPE_WAITING_READERS(*inode) = PIPE_WAITING_WRITERS(*inode) = 0;
+	PIPE_MORE_DATA_WAITING(*inode) = 0;
 	PIPE_RCOUNTER(*inode) = PIPE_WCOUNTER(*inode) = 1;
 
 	return inode;
--- 2.4/include/linux/pipe_fs_i.h	Wed Feb  7 20:02:07 2001
+++ build-2.4/include/linux/pipe_fs_i.h	Mon Mar 12 16:02:48 2001
@@ -5,11 +5,11 @@
 struct pipe_inode_info {
 	wait_queue_head_t wait;
 	char *base;
+	unsigned int is_pio;
 	unsigned int start;
 	unsigned int readers;
 	unsigned int writers;
-	unsigned int waiting_readers;
-	unsigned int waiting_writers;
+	unsigned int more_data;
 	unsigned int r_counter;
 	unsigned int w_counter;
 };
@@ -21,12 +21,12 @@
 #define PIPE_SEM(inode)		(&(inode).i_sem)
 #define PIPE_WAIT(inode)	(&(inode).i_pipe->wait)
 #define PIPE_BASE(inode)	((inode).i_pipe->base)
+#define PIPE_IS_PIO(inode)	((inode).i_pipe->is_pio)
 #define PIPE_START(inode)	((inode).i_pipe->start)
 #define PIPE_LEN(inode)		((inode).i_size)
 #define PIPE_READERS(inode)	((inode).i_pipe->readers)
 #define PIPE_WRITERS(inode)	((inode).i_pipe->writers)
-#define PIPE_WAITING_READERS(inode)	((inode).i_pipe->waiting_readers)
-#define PIPE_WAITING_WRITERS(inode)	((inode).i_pipe->waiting_writers)
+#define PIPE_MORE_DATA_WAITING(inode)	((inode).i_pipe->more_data)
 #define PIPE_RCOUNTER(inode)	((inode).i_pipe->r_counter)
 #define PIPE_WCOUNTER(inode)	((inode).i_pipe->w_counter)
 
@@ -34,8 +34,6 @@
 #define PIPE_FULL(inode)	(PIPE_LEN(inode) == PIPE_SIZE)
 #define PIPE_FREE(inode)	(PIPE_SIZE - PIPE_LEN(inode))
 #define PIPE_END(inode)	((PIPE_START(inode) + PIPE_LEN(inode)) & (PIPE_SIZE-1))
-#define PIPE_MAX_RCHUNK(inode)	(PIPE_SIZE - PIPE_START(inode))
-#define PIPE_MAX_WCHUNK(inode)	(PIPE_SIZE - PIPE_END(inode))
 
 /* Drop the inode semaphore and wait for a pipe event, atomically */
 void pipe_wait(struct inode * inode);

--------------7FB31BA4F02EDD676EE2F1A0
Content-Type: text/plain; charset=us-ascii;
 name="patch-poll"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-poll"

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 4
//  SUBLEVEL = 2
//  EXTRAVERSION = -ac17
--- 2.4/fs/select.c	Thu Feb 22 22:29:47 2001
+++ build-2.4/fs/select.c	Mon Mar 12 17:01:45 2001
@@ -24,12 +24,6 @@
 #define ROUND_UP(x,y) (((x)+(y)-1)/(y))
 #define DEFAULT_POLLMASK (POLLIN | POLLOUT | POLLRDNORM | POLLWRNORM)
 
-struct poll_table_entry {
-	struct file * filp;
-	wait_queue_t wait;
-	wait_queue_head_t * wait_address;
-};
-
 struct poll_table_page {
 	struct poll_table_page * next;
 	struct poll_table_entry * entry;
@@ -52,11 +46,36 @@
  * poll table.
  */
 
+/*
+ * Memory free and alloc took a significant part of the total
+ * sys_poll()/sys_select() execution time, thus I moved several
+ * structures on the stack:
+ * - sys_select has a 192 byte (enough for 256 fds) buffer on the stack.
+ *   Please avoid selecting more than 5000 descriptors
+ *   (kmalloc > 4096 bytes), and you can't select
+ *   more than 170.000 fds (kmalloc > 128 kB)
+ * - sys_poll stores the first 24 file descriptors on the
+ *   stack. If more than 24 descriptors are polled, then
+ *   additional memory is allocated, but the first 24 descriptors
+ *   always lie on the stack.
+ * - the poll table contains 8 wait queue entries. This means that no dynamic
+ *   memory allocation is necessary for the wait queues if one of the first
+ *   8 file descriptors has new data.
+ * <manfred@colorfullife.com>
+ */
+
 void poll_freewait(poll_table* pt)
 {
 	struct poll_table_page * p = pt->table;
+	struct poll_table_entry * entry;
+	entry = pt->internal + pt->nr;
+	while(pt->nr > 0) {
+		pt->nr--;
+		entry--;
+		remove_wait_queue(entry->wait_address,&entry->wait);
+		fput(entry->filp);
+	}
 	while (p) {
-		struct poll_table_entry * entry;
 		struct poll_table_page *old;
 
 		entry = p->entry;
@@ -67,39 +86,42 @@
 		} while (entry > p->entries);
 		old = p;
 		p = p->next;
-		free_page((unsigned long) old);
+		kfree(old);
 	}
 }
 
 void __pollwait(struct file * filp, wait_queue_head_t * wait_address, poll_table *p)
 {
-	struct poll_table_page *table = p->table;
-
-	if (!table || POLL_TABLE_FULL(table)) {
-		struct poll_table_page *new_table;
+	struct poll_table_entry * entry;
 
-		new_table = (struct poll_table_page *) __get_free_page(GFP_KERNEL);
-		if (!new_table) {
-			p->error = -ENOMEM;
-			__set_current_state(TASK_RUNNING);
-			return;
+	if(p->nr < POLL_TABLE_INTERNAL) {
+		entry = p->internal+p->nr++;
+	} else {
+		struct poll_table_page *table = p->table;
+
+		if (!table || POLL_TABLE_FULL(table)) {
+			struct poll_table_page *new_table;
+
+			new_table = kmalloc(PAGE_SIZE, GFP_KERNEL);
+			if (!new_table) {
+				p->error = -ENOMEM;
+				__set_current_state(TASK_RUNNING);
+				return;
+			}
+			new_table->entry = new_table->entries;
+			new_table->next = table;
+			p->table = new_table;
+			table = new_table;
 		}
-		new_table->entry = new_table->entries;
-		new_table->next = table;
-		p->table = new_table;
-		table = new_table;
-	}
-
-	/* Add a new entry */
-	{
-		struct poll_table_entry * entry = table->entry;
+		entry = table->entry;
 		table->entry = entry+1;
-	 	get_file(filp);
-	 	entry->filp = filp;
-		entry->wait_address = wait_address;
-		init_waitqueue_entry(&entry->wait, current);
-		add_wait_queue(wait_address,&entry->wait);
 	}
+	/* Add a new entry */
+	get_file(filp);
+	entry->filp = filp;
+	entry->wait_address = wait_address;
+	init_waitqueue_entry(&entry->wait, current);
+	add_wait_queue(wait_address,&entry->wait);
 }
 
 #define __IN(fds, n)		(fds->in + n)
@@ -233,14 +255,18 @@
 	return retval;
 }
 
-static void *select_bits_alloc(int size)
+#define SELECT_INLINE_BYTES	32
+static inline void *select_bits_alloc(int size, void* internal)
 {
+	if(size <= SELECT_INLINE_BYTES)
+		return internal;
 	return kmalloc(6 * size, GFP_KERNEL);
 }
 
-static void select_bits_free(void *bits, int size)
+static inline void select_bits_free(void *bits, void* internal)
 {
-	kfree(bits);
+	if(bits != internal)
+		kfree(bits);
 }
 
 /*
@@ -254,10 +280,12 @@
 #define MAX_SELECT_SECONDS \
 	((unsigned long) (MAX_SCHEDULE_TIMEOUT / HZ)-1)
 
+
 asmlinkage long
 sys_select(int n, fd_set *inp, fd_set *outp, fd_set *exp, struct timeval *tvp)
 {
 	fd_set_bits fds;
+	char ibuf[6*SELECT_INLINE_BYTES];
 	char *bits;
 	long timeout;
 	int ret, size;
@@ -295,7 +323,7 @@
 	 */
 	ret = -ENOMEM;
 	size = FDS_BYTES(n);
-	bits = select_bits_alloc(size);
+	bits = select_bits_alloc(size, ibuf);
 	if (!bits)
 		goto out_nofds;
 	fds.in      = (unsigned long *)  bits;
@@ -340,12 +368,18 @@
 	set_fd_set(n, exp, fds.res_ex);
 
 out:
-	select_bits_free(bits, size);
+	select_bits_free(bits, ibuf);
 out_nofds:
 	return ret;
 }
 
-#define POLLFD_PER_PAGE  ((PAGE_SIZE) / sizeof(struct pollfd))
+struct poll_list {
+	struct poll_list *next;
+	int len;
+	struct pollfd entries[0];
+};
+
+#define POLLFD_PER_PAGE  ((PAGE_SIZE-sizeof(struct poll_list)) / sizeof(struct pollfd))
 
 static void do_pollfd(unsigned int num, struct pollfd * fdpage,
 	poll_table ** pwait, int *count)
@@ -379,39 +413,44 @@
 	}
 }
 
-static int do_poll(unsigned int nfds, unsigned int nchunks, unsigned int nleft, 
-	struct pollfd *fds[], poll_table *wait, long timeout)
+static int do_poll(int nfds, struct poll_list *list,
+			poll_table *wait, long timeout)
 {
-	int count;
+	int count = 0;
 	poll_table* pt = wait;
-
+ 
 	for (;;) {
-		unsigned int i;
-
+		struct poll_list* walk;
 		set_current_state(TASK_INTERRUPTIBLE);
-		count = 0;
-		for (i=0; i < nchunks; i++)
-			do_pollfd(POLLFD_PER_PAGE, fds[i], &pt, &count);
-		if (nleft)
-			do_pollfd(nleft, fds[nchunks], &pt, &count);
+		walk = list;
+		while(walk != NULL) {
+			do_pollfd( walk->len, walk->entries, &pt, &count);
+			walk = walk->next;
+		}
 		pt = NULL;
 		if (count || !timeout || signal_pending(current))
 			break;
 		count = wait->error;
 		if (count)
 			break;
+
 		timeout = schedule_timeout(timeout);
 	}
 	current->state = TASK_RUNNING;
 	return count;
 }
 
+#define INLINE_POLL_COUNT	24
 asmlinkage long sys_poll(struct pollfd * ufds, unsigned int nfds, long timeout)
 {
-	int i, j, fdcount, err;
-	struct pollfd **fds;
+	int fdcount, err;
+	unsigned int i;
+	struct poll_list *pollwalk;
+	struct {
+		struct poll_list head;
+		struct pollfd entries[INLINE_POLL_COUNT];
+	} polldata;
 	poll_table table, *wait;
-	int nchunks, nleft;
 
 	/* Do a sanity check on nfds ... */
 	if (nfds > current->files->max_fds)
@@ -431,63 +470,65 @@
 		wait = NULL;
 
 	err = -ENOMEM;
-	fds = NULL;
-	if (nfds != 0) {
-		fds = (struct pollfd **)kmalloc(
-			(1 + (nfds - 1) / POLLFD_PER_PAGE) * sizeof(struct pollfd *),
-			GFP_KERNEL);
-		if (fds == NULL)
-			goto out;
-	}
+	polldata.head.next = NULL;
+	polldata.head.len = INLINE_POLL_COUNT;
+	if(nfds <= INLINE_POLL_COUNT)
+		polldata.head.len = nfds;
 
-	nchunks = 0;
-	nleft = nfds;
-	while (nleft > POLLFD_PER_PAGE) { /* allocate complete PAGE_SIZE chunks */
-		fds[nchunks] = (struct pollfd *)__get_free_page(GFP_KERNEL);
-		if (fds[nchunks] == NULL)
+	pollwalk = &polldata.head;
+	i = nfds;
+	err = -ENOMEM;
+	goto start;
+	while(i!=0) {
+		struct poll_list *pp;
+		pp = kmalloc(sizeof(struct poll_list)+
+				sizeof(struct pollfd)*
+				(i>POLLFD_PER_PAGE?POLLFD_PER_PAGE:i),
+					GFP_KERNEL);
+		if(pp==NULL)
 			goto out_fds;
-		nchunks++;
-		nleft -= POLLFD_PER_PAGE;
-	}
-	if (nleft) { /* allocate last PAGE_SIZE chunk, only nleft elements used */
-		fds[nchunks] = (struct pollfd *)__get_free_page(GFP_KERNEL);
-		if (fds[nchunks] == NULL)
+		pp->next=NULL;
+		pp->len = (i>POLLFD_PER_PAGE?POLLFD_PER_PAGE:i);
+		pollwalk->next = pp;
+		pollwalk = pp;
+start:
+		if (copy_from_user(pollwalk+1, ufds + nfds-i, 
+				sizeof(struct pollfd)*pollwalk->len)) {
+			err = -EFAULT;
 			goto out_fds;
+		}
+		i -= pollwalk->len;
 	}
+		
+	fdcount = do_poll(nfds, &polldata.head,
+			wait, timeout);
 
+	/* OK, now copy the revents fields back to user space. */
+	i = nfds;
+	pollwalk = &polldata.head;
 	err = -EFAULT;
-	for (i=0; i < nchunks; i++)
-		if (copy_from_user(fds[i], ufds + i*POLLFD_PER_PAGE, PAGE_SIZE))
-			goto out_fds1;
-	if (nleft) {
-		if (copy_from_user(fds[nchunks], ufds + nchunks*POLLFD_PER_PAGE, 
-				nleft * sizeof(struct pollfd)))
-			goto out_fds1;
+	while(pollwalk != NULL) {
+		struct pollfd * fds = pollwalk->entries;
+		int j;
+
+		for (j=0; j < pollwalk->len; j++, ufds++) {
+			if(__put_user(fds[j].revents, &ufds->revents))
+				goto out_fds;
+		}
+		i -= pollwalk->len;
+		pollwalk = pollwalk->next;
 	}
-
-	fdcount = do_poll(nfds, nchunks, nleft, fds, wait, timeout);
-
-	/* OK, now copy the revents fields back to user space. */
-	for(i=0; i < nchunks; i++)
-		for (j=0; j < POLLFD_PER_PAGE; j++, ufds++)
-			__put_user((fds[i] + j)->revents, &ufds->revents);
-	if (nleft)
-		for (j=0; j < nleft; j++, ufds++)
-			__put_user((fds[nchunks] + j)->revents, &ufds->revents);
-
 	err = fdcount;
 	if (!fdcount && signal_pending(current))
 		err = -EINTR;
 
-out_fds1:
-	if (nleft)
-		free_page((unsigned long)(fds[nchunks]));
 out_fds:
-	for (i=0; i < nchunks; i++)
-		free_page((unsigned long)(fds[i]));
-	if (nfds != 0)
-		kfree(fds);
-out:
+	pollwalk = polldata.head.next;
+	while(pollwalk!=NULL) {
+		struct poll_list *pp = pollwalk->next;
+		kfree(pollwalk);
+		pollwalk = pp;
+	}
 	poll_freewait(&table);
 	return err;
 }
--- 2.4/include/linux/poll.h	Thu Jan  4 23:51:10 2001
+++ build-2.4/include/linux/poll.h	Mon Mar 12 16:03:07 2001
@@ -12,9 +12,18 @@
 
 struct poll_table_page;
 
+struct poll_table_entry {
+	struct file * filp;
+	wait_queue_t wait;
+	wait_queue_head_t * wait_address;
+};
+
+#define POLL_TABLE_INTERNAL	8
 typedef struct poll_table_struct {
 	int error;
+	int nr;
 	struct poll_table_page * table;
+	struct poll_table_entry internal[POLL_TABLE_INTERNAL];
 } poll_table;
 
 extern void __pollwait(struct file * filp, wait_queue_head_t * wait_address, poll_table *p);
@@ -28,6 +37,7 @@
 static inline void poll_initwait(poll_table* pt)
 {
 	pt->error = 0;
+	pt->nr = 0;
 	pt->table = NULL;
 }
 extern void poll_freewait(poll_table* pt);

--------------7FB31BA4F02EDD676EE2F1A0--

