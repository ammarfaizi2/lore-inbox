Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286273AbSAEW2X>; Sat, 5 Jan 2002 17:28:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286283AbSAEW2R>; Sat, 5 Jan 2002 17:28:17 -0500
Received: from colorfullife.com ([216.156.138.34]:39439 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S286273AbSAEW2B>;
	Sat, 5 Jan 2002 17:28:01 -0500
Message-ID: <002701c19638$400f15f0$010411ac@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: <linux-kernel@vger.kernel.org>
Cc: <lse-tech@lists.sourceforge.net>
Subject: zerocopy pipe, new version
Date: Sat, 5 Jan 2002 23:27:25 +0100
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0020_01C19640.886442F0"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0020_01C19640.886442F0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Attached is a new version of the zerocopy pipe code.

A few months ago, Hubertus Franke found a severe performance problem with my last
version. Now I figured out how I can solve it:
For good pipe performance, sys_read() must try to return as much data as possible with
one syscall, even if the writer writes small bits. The current code uses
PIPE_WAITING_WRITERS, but that doesn't work with nonblocking IO and is not that
efficient.

I added a sched_yield() into that path, and that fixed the performance degradation:
if pipe_read made progress and the user wants even more data, then call sched_yield() and
give the writers a chance to write additional data. After sched_yield() returns, try again until
there is either no more data, or the user request is completely fullfilled. Then return to userspace.

Now I got +50% on UP with pipeflex -c2 -r32 -w1 with 2.5.2-pre8+zerocopy, SMP kernel
over 2.4.2-UP.

Unfortunately the patch has virtually no effect on 4 kB write-4 kB read, and that's the most
common case. (number of context switches cut in half, but a slight performance loss on K6,
probably due to cache trashing)

The only solution I see for that problem are larger kernel buffers - more data must be queued
in kernel. Either on-demand (kmalloc() up to <sysctl-limit, around 512 kB> if a request for
<= 4096 bytes arrives and would block. If the allocation fails, then block), or at pipe creation
like in Hubertus' patch.

--
    Manfred

------=_NextPart_000_0020_01C19640.886442F0
Content-Type: application/octet-stream;
	name="patch-kp-2.5.2"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="patch-kp-2.5.2"

// $Header$=0A=
// Kernel Version:=0A=
//  VERSION =3D 2=0A=
//  PATCHLEVEL =3D 5=0A=
//  SUBLEVEL =3D 2=0A=
//  EXTRAVERSION =3D-pre8=0A=
--- 2.5/fs/pipe.c	Thu Oct 11 15:20:16 2001=0A=
+++ build-2.5/fs/pipe.c	Wed Jan  2 18:12:28 2002=0A=
@@ -2,6 +2,9 @@=0A=
  *  linux/fs/pipe.c=0A=
  *=0A=
  *  Copyright (C) 1991, 1992, 1999  Linus Torvalds=0A=
+ *=0A=
+ *  Major pipe_read() and pipe_write() cleanup:  Single copy,=0A=
+ *  fewer schedules.	Copyright (C) 2001 Manfred Spraul=0A=
  */=0A=
 =0A=
 #include <linux/mm.h>=0A=
@@ -10,6 +13,8 @@=0A=
 #include <linux/slab.h>=0A=
 #include <linux/module.h>=0A=
 #include <linux/init.h>=0A=
+#include <linux/highmem.h>=0A=
+#include <linux/compiler.h>=0A=
 =0A=
 #include <asm/uaccess.h>=0A=
 #include <asm/ioctls.h>=0A=
@@ -36,214 +41,360 @@=0A=
 	down(PIPE_SEM(*inode));=0A=
 }=0A=
 =0A=
+#define PIO_PGCOUNT	((131072+PAGE_SIZE-1)/PAGE_SIZE)=0A=
+struct pipe_pio {=0A=
+	struct list_head list;=0A=
+	struct page *pages[PIO_PGCOUNT];=0A=
+	int offset;=0A=
+	size_t len;=0A=
+	size_t orig_len;=0A=
+	struct task_struct *tsk;=0A=
+};=0A=
+=0A=
+static ssize_t=0A=
+copy_from_piolist(struct list_head *piolist, void *buf, ssize_t len)=0A=
+{=0A=
+	struct list_head *walk =3D piolist->next;=0A=
+	int ret =3D 0;=0A=
+	while(walk !=3D piolist && len) {=0A=
+		struct pipe_pio* pio =3D list_entry(walk, struct pipe_pio, list);=0A=
+		if (pio->len) {=0A=
+			struct page *page;=0A=
+			void *maddr;=0A=
+			int this_len, off, i;=0A=
+			int ret2;=0A=
+=0A=
+			i =3D pio->offset/PAGE_SIZE;=0A=
+			off =3D pio->offset%PAGE_SIZE;=0A=
+			this_len =3D len;=0A=
+			if (this_len > PAGE_SIZE-off)=0A=
+				this_len =3D PAGE_SIZE-off;=0A=
+			if (this_len > pio->len)=0A=
+				this_len =3D pio->len;=0A=
+=0A=
+			page =3D pio->pages[i];=0A=
+			maddr =3D kmap(page);=0A=
+			ret2 =3D copy_to_user(buf, maddr+off, this_len);=0A=
+			flush_page_to_ram(page);=0A=
+			kunmap(page);=0A=
+			if (unlikely(ret2)) {=0A=
+				if (ret)=0A=
+					return ret;=0A=
+				return -EFAULT;=0A=
+			}=0A=
+=0A=
+			buf +=3D this_len;=0A=
+			len -=3D this_len;=0A=
+			pio->len -=3D this_len;=0A=
+			pio->offset +=3D this_len;=0A=
+			ret +=3D this_len;=0A=
+			if (pio->len =3D=3D 0)=0A=
+				wake_up_process(pio->tsk);=0A=
+		} else {=0A=
+			walk =3D walk->next;=0A=
+		}=0A=
+	}=0A=
+	return ret;=0A=
+}=0A=
+=0A=
+static void=0A=
+build_pio(struct pipe_pio *pio, struct inode *inode, const void *buf, =
size_t count)=0A=
+{=0A=
+	int len;=0A=
+	struct vm_area_struct *vmas[PIO_PGCOUNT];=0A=
+=0A=
+	pio->tsk =3D current;=0A=
+	pio->len =3D count;=0A=
+	pio->offset =3D (unsigned long)buf&(PAGE_SIZE-1);=0A=
+=0A=
+	pio->len =3D PIO_PGCOUNT*PAGE_SIZE - pio->offset;=0A=
+	if (pio->len > count)=0A=
+		pio->len =3D count;=0A=
+	len =3D (pio->offset+pio->len+PAGE_SIZE-1)/PAGE_SIZE;=0A=
+	down_read(&current->mm->mmap_sem);=0A=
+	len =3D get_user_pages(current, current->mm, (unsigned long)buf, len,=0A=
+			0, 0, pio->pages, vmas);=0A=
+	if (len > 0) {=0A=
+		int i;=0A=
+		for(i=3D0;i<len;i++) {=0A=
+			flush_cache_page(vmas[i], addr+i*PAGE_SIZE);=0A=
+		}=0A=
+		len =3D len*PAGE_SIZE-pio->offset;=0A=
+		if (len < pio->len)=0A=
+			pio->len =3D len;=0A=
+		list_add_tail(&pio->list, &PIPE_PIO(*inode));=0A=
+		PIPE_PIOLEN(*inode) +=3D pio->len;=0A=
+		pio->orig_len =3D pio->len;=0A=
+	} else {=0A=
+		pio->list.next =3D NULL;=0A=
+	}=0A=
+	up_read(&current->mm->mmap_sem);=0A=
+}=0A=
+=0A=
+static size_t=0A=
+teardown_pio(struct pipe_pio *pio, struct inode *inode, const void *buf)=0A=
+{=0A=
+	int i;=0A=
+	if (!pio->list.next)=0A=
+		return 0;=0A=
+	for (i=3D0;i<(pio->len+pio->offset+PAGE_SIZE-1)/PAGE_SIZE;i++) {=0A=
+		if (pio->pages[i]) {=0A=
+			put_page(pio->pages[i]);=0A=
+		}=0A=
+	}=0A=
+	i =3D pio->orig_len - pio->len;=0A=
+	PIPE_PIOLEN(*inode) -=3D pio->len;=0A=
+	list_del(&pio->list);=0A=
+	if (i && pio->len) {=0A=
+		/*=0A=
+		 * We would violate the atomicity requirements:=0A=
+		 * 1 byte in the internal buffer.=0A=
+		 * write(fd, buf, PIPE_BUF);=0A=
+		 * --> doesn't fit into internal buffer, pio build.=0A=
+		 * read(fd, buf, 200);(i.e. 199 bytes from pio)=0A=
+		 * signal sent to writer.=0A=
+		 * The writer must not return with 199 bytes written!=0A=
+		 * Fortunately the internal buffer will be empty in this=0A=
+		 * case. Write into the internal buffer before=0A=
+		 * checking for signals/error conditions.=0A=
+		 */=0A=
+		size_t j =3D min((size_t)PIPE_SIZE, pio->len);=0A=
+		if (PIPE_LEN(*inode)) BUG();=0A=
+		if (PIPE_START(*inode)) BUG();=0A=
+		if (!copy_from_user(PIPE_BASE(*inode), buf + i, j)) {=0A=
+			i +=3D j;=0A=
+			PIPE_LEN(*inode) =3D  j;=0A=
+		}=0A=
+	}=0A=
+	return i;=0A=
+}=0A=
+/*=0A=
+ * reader:=0A=
+	flush_cache_page(vma, addr);=0A=
+ *=0A=
+		flush_icache_page(vma, page);=0A=
+ */=0A=
 static ssize_t=0A=
 pipe_read(struct file *filp, char *buf, size_t count, loff_t *ppos)=0A=
 {=0A=
 	struct inode *inode =3D filp->f_dentry->d_inode;=0A=
-	ssize_t size, read, ret;=0A=
+	ssize_t read;=0A=
+	ssize_t lastread;=0A=
 =0A=
-	/* Seeks are not allowed on pipes.  */=0A=
-	ret =3D -ESPIPE;=0A=
-	read =3D 0;=0A=
-	if (ppos !=3D &filp->f_pos)=0A=
-		goto out_nolock;=0A=
+	/* pread is not allowed on pipes.  */=0A=
+	if (unlikely(ppos !=3D &filp->f_pos))=0A=
+		return -ESPIPE;=0A=
 =0A=
 	/* Always return 0 on null read.  */=0A=
-	ret =3D 0;=0A=
-	if (count =3D=3D 0)=0A=
-		goto out_nolock;=0A=
-=0A=
-	/* Get the pipe semaphore */=0A=
-	ret =3D -ERESTARTSYS;=0A=
-	if (down_interruptible(PIPE_SEM(*inode)))=0A=
-		goto out_nolock;=0A=
-=0A=
-	if (PIPE_EMPTY(*inode)) {=0A=
-do_more_read:=0A=
-		ret =3D 0;=0A=
-		if (!PIPE_WRITERS(*inode))=0A=
-			goto out;=0A=
+	if (unlikely(count =3D=3D 0))=0A=
+		return 0;=0A=
 =0A=
-		ret =3D -EAGAIN;=0A=
-		if (filp->f_flags & O_NONBLOCK)=0A=
-			goto out;=0A=
+	down(PIPE_SEM(*inode));=0A=
 =0A=
-		for (;;) {=0A=
-			PIPE_WAITING_READERS(*inode)++;=0A=
-			pipe_wait(inode);=0A=
-			PIPE_WAITING_READERS(*inode)--;=0A=
-			ret =3D -ERESTARTSYS;=0A=
-			if (signal_pending(current))=0A=
-				goto out;=0A=
-			ret =3D 0;=0A=
-			if (!PIPE_EMPTY(*inode))=0A=
-				break;=0A=
-			if (!PIPE_WRITERS(*inode))=0A=
+	read =3D 0;=0A=
+	lastread =3D 0;=0A=
+	for (;;) {=0A=
+		/* read what data is available */=0A=
+		int chars;=0A=
+		while( (chars =3D PIPE_LEN(*inode)) ) {=0A=
+			char *pipebuf =3D PIPE_BASE(*inode);=0A=
+			int offset =3D PIPE_START(*inode)%PIPE_BUF;=0A=
+			if (chars > count)=0A=
+				chars =3D count;=0A=
+			if (chars > PIPE_SIZE-offset)=0A=
+				chars =3D PIPE_SIZE-offset;=0A=
+			if (unlikely(copy_to_user(buf, pipebuf+offset, chars))) {=0A=
+				if (!read)=0A=
+					read =3D -EFAULT;=0A=
 				goto out;=0A=
+			}=0A=
+			PIPE_LEN(*inode) -=3D chars;=0A=
+			if (!PIPE_LEN(*inode)) {=0A=
+				/* Cache behaviour optimization */=0A=
+				PIPE_START(*inode) =3D 0;=0A=
+			} else {=0A=
+				/* there is no need to limit PIPE_START=0A=
+				 * to PIPE_BUF - the user does=0A=
+				 * %PIPE_BUF anyway.=0A=
+				 */=0A=
+				PIPE_START(*inode) +=3D chars;=0A=
+			}=0A=
+			read +=3D chars;=0A=
+			count -=3D chars;=0A=
+			if (!count)=0A=
+				goto out; /* common case: done */=0A=
+			buf +=3D chars;=0A=
+			/* Check again that the internal buffer is empty.=0A=
+			 * If it was cyclic more data could be in the buffer.=0A=
+			 */=0A=
 		}=0A=
-	}=0A=
-=0A=
-	/* Read what data is available.  */=0A=
-	ret =3D -EFAULT;=0A=
-	while (count > 0 && (size =3D PIPE_LEN(*inode))) {=0A=
-		char *pipebuf =3D PIPE_BASE(*inode) + PIPE_START(*inode);=0A=
-		ssize_t chars =3D PIPE_MAX_RCHUNK(*inode);=0A=
-=0A=
-		if (chars > count)=0A=
-			chars =3D count;=0A=
-		if (chars > size)=0A=
-			chars =3D size;=0A=
+		if (PIPE_PIOLEN(*inode)) {=0A=
+			chars =3D copy_from_piolist(&PIPE_PIO(*inode), buf, count);=0A=
+			if (unlikely(chars < 0)) {=0A=
+				if (!read)=0A=
+					read =3D chars;=0A=
+				goto out;=0A=
+			}=0A=
+			PIPE_PIOLEN(*inode) -=3D chars;=0A=
+			read +=3D chars;=0A=
+			count -=3D chars;=0A=
+			if (!count)=0A=
+				goto out; /* common case: done */=0A=
+			buf +=3D chars;=0A=
 =0A=
-		if (copy_to_user(buf, pipebuf, chars))=0A=
+		}=0A=
+		if (PIPE_PIOLEN(*inode) || PIPE_LEN(*inode)) BUG();=0A=
+		if (lastread !=3D read) {=0A=
+			up(PIPE_SEM(*inode));=0A=
+			wake_up_interruptible(PIPE_WAIT(*inode));=0A=
+			sys_sched_yield();=0A=
+			schedule();=0A=
+			down(PIPE_SEM(*inode));=0A=
+			lastread =3D read;=0A=
+			continue;=0A=
+		}=0A=
+		/* tests before sleeping:=0A=
+		 *  - don't sleep if data was read.=0A=
+		 */=0A=
+		if (read)=0A=
 			goto out;=0A=
 =0A=
-		read +=3D chars;=0A=
-		PIPE_START(*inode) +=3D chars;=0A=
-		PIPE_START(*inode) &=3D (PIPE_SIZE - 1);=0A=
-		PIPE_LEN(*inode) -=3D chars;=0A=
-		count -=3D chars;=0A=
-		buf +=3D chars;=0A=
-	}=0A=
-=0A=
-	/* Cache behaviour optimization */=0A=
-	if (!PIPE_LEN(*inode))=0A=
-		PIPE_START(*inode) =3D 0;=0A=
+		/*  - don't sleep if no process has the pipe open=0A=
+		 *	 for writing=0A=
+		 */=0A=
+		if (unlikely(!PIPE_WRITERS(*inode)))=0A=
+			goto out;=0A=
 =0A=
-	if (count && PIPE_WAITING_WRITERS(*inode) && !(filp->f_flags & =
O_NONBLOCK)) {=0A=
-		/*=0A=
-		 * We know that we are going to sleep: signal=0A=
-		 * writers synchronously that there is more=0A=
-		 * room.=0A=
+		/*   - don't sleep if O_NONBLOCK is set */=0A=
+		if (filp->f_flags & O_NONBLOCK) {=0A=
+			read =3D -EAGAIN;=0A=
+			goto out;=0A=
+		}=0A=
+		/*   - don't sleep if a signal is pending */=0A=
+		if (unlikely(signal_pending(current))) {=0A=
+			read =3D -ERESTARTSYS;=0A=
+			goto out;=0A=
+		}=0A=
+		/* readers never need to wake up if they go to sleep:=0A=
+		 * They only sleep if they didn't read anything=0A=
 		 */=0A=
-		wake_up_interruptible_sync(PIPE_WAIT(*inode));=0A=
-		if (!PIPE_EMPTY(*inode))=0A=
-			BUG();=0A=
-		goto do_more_read;=0A=
+		pipe_wait(inode);=0A=
 	}=0A=
-	/* Signal writers asynchronously that there is more room.  */=0A=
-	wake_up_interruptible(PIPE_WAIT(*inode));=0A=
-=0A=
-	ret =3D read;=0A=
 out:=0A=
 	up(PIPE_SEM(*inode));=0A=
-out_nolock:=0A=
-	if (read)=0A=
-		ret =3D read;=0A=
-	return ret;=0A=
+	/* If we drained the pipe, then wakeup everyone=0A=
+	 * waiting for that - either poll(2) or write(2).=0A=
+	 * We are only reading, therefore we can access without locking.=0A=
+	 */=0A=
+	if (read > 0 && !PIPE_PIOLEN(*inode) && !PIPE_LEN(*inode))=0A=
+		wake_up_interruptible(PIPE_WAIT(*inode));=0A=
+=0A=
+	return read;=0A=
 }=0A=
 =0A=
 static ssize_t=0A=
 pipe_write(struct file *filp, const char *buf, size_t count, loff_t =
*ppos)=0A=
 {=0A=
 	struct inode *inode =3D filp->f_dentry->d_inode;=0A=
-	ssize_t free, written, ret;=0A=
-=0A=
-	/* Seeks are not allowed on pipes.  */=0A=
-	ret =3D -ESPIPE;=0A=
-	written =3D 0;=0A=
-	if (ppos !=3D &filp->f_pos)=0A=
-		goto out_nolock;=0A=
+	size_t min;=0A=
+	ssize_t written;=0A=
+	int do_wakeup;=0A=
+=0A=
+	/* pwrite is not allowed on pipes.  */=0A=
+	if (unlikely(ppos !=3D &filp->f_pos))=0A=
+		return -ESPIPE;=0A=
 =0A=
 	/* Null write succeeds.  */=0A=
-	ret =3D 0;=0A=
-	if (count =3D=3D 0)=0A=
-		goto out_nolock;=0A=
-=0A=
-	ret =3D -ERESTARTSYS;=0A=
-	if (down_interruptible(PIPE_SEM(*inode)))=0A=
-		goto out_nolock;=0A=
+	if (unlikely(count =3D=3D 0))=0A=
+		return 0;=0A=
+	min =3D count;=0A=
+	if (min > PIPE_BUF && (filp->f_flags & O_NONBLOCK))=0A=
+		min =3D 1; /* no atomicity guarantee for transfers > PIPE_BUF */=0A=
 =0A=
-	/* No readers yields SIGPIPE.  */=0A=
-	if (!PIPE_READERS(*inode))=0A=
-		goto sigpipe;=0A=
-=0A=
-	/* If count <=3D PIPE_BUF, we have to make it atomic.  */=0A=
-	free =3D (count <=3D PIPE_BUF ? count : 1);=0A=
-=0A=
-	/* Wait, or check for, available space.  */=0A=
-	if (filp->f_flags & O_NONBLOCK) {=0A=
-		ret =3D -EAGAIN;=0A=
-		if (PIPE_FREE(*inode) < free)=0A=
-			goto out;=0A=
-	} else {=0A=
-		while (PIPE_FREE(*inode) < free) {=0A=
-			PIPE_WAITING_WRITERS(*inode)++;=0A=
-			pipe_wait(inode);=0A=
-			PIPE_WAITING_WRITERS(*inode)--;=0A=
-			ret =3D -ERESTARTSYS;=0A=
-			if (signal_pending(current))=0A=
-				goto out;=0A=
-=0A=
-			if (!PIPE_READERS(*inode))=0A=
-				goto sigpipe;=0A=
+	down(PIPE_SEM(*inode));=0A=
+	written =3D 0;=0A=
+	do_wakeup =3D 0;=0A=
+	for(;;) {=0A=
+		int start;=0A=
+		size_t chars;=0A=
+		/* No readers yields SIGPIPE.  */=0A=
+		if (unlikely(!PIPE_READERS(*inode))) {=0A=
+			if (!written)=0A=
+				written =3D -EPIPE;=0A=
+			break;=0A=
 		}=0A=
-	}=0A=
-=0A=
-	/* Copy into available space.  */=0A=
-	ret =3D -EFAULT;=0A=
-	while (count > 0) {=0A=
-		int space;=0A=
-		char *pipebuf =3D PIPE_BASE(*inode) + PIPE_END(*inode);=0A=
-		ssize_t chars =3D PIPE_MAX_WCHUNK(*inode);=0A=
-=0A=
-		if ((space =3D PIPE_FREE(*inode)) !=3D 0) {=0A=
+		if (PIPE_PIOLEN(*inode))=0A=
+			goto skip_int_buf;=0A=
+		/* write to internal buffer - could be cyclic */=0A=
+		while(start =3D PIPE_LEN(*inode),chars =3D PIPE_SIZE - start, chars =
>=3D min) {=0A=
+			start +=3D PIPE_START(*inode);=0A=
+			start %=3D PIPE_SIZE;=0A=
+			if (chars > PIPE_BUF - start)=0A=
+				chars =3D PIPE_BUF - start;=0A=
 			if (chars > count)=0A=
 				chars =3D count;=0A=
-			if (chars > space)=0A=
-				chars =3D space;=0A=
-=0A=
-			if (copy_from_user(pipebuf, buf, chars))=0A=
+			if (unlikely(copy_from_user(PIPE_BASE(*inode)+start,=0A=
+						buf, chars))) {=0A=
+				if (!written)=0A=
+					written =3D -EFAULT;=0A=
 				goto out;=0A=
-=0A=
-			written +=3D chars;=0A=
+			}=0A=
+			do_wakeup =3D 1;=0A=
 			PIPE_LEN(*inode) +=3D chars;=0A=
 			count -=3D chars;=0A=
+			written +=3D chars;=0A=
+			if (!count)=0A=
+				goto out;=0A=
 			buf +=3D chars;=0A=
-			space =3D PIPE_FREE(*inode);=0A=
-			continue;=0A=
+			min =3D 1;=0A=
 		}=0A=
-=0A=
-		ret =3D written;=0A=
-		if (filp->f_flags & O_NONBLOCK)=0A=
+skip_int_buf:=0A=
+		if (!filp->f_flags & O_NONBLOCK) {=0A=
+			if (!written)=0A=
+				written =3D -EAGAIN;=0A=
 			break;=0A=
+		}=0A=
 =0A=
-		do {=0A=
-			/*=0A=
-			 * Synchronous wake-up: it knows that this process=0A=
-			 * is going to give up this CPU, so it doesnt have=0A=
-			 * to do idle reschedules.=0A=
+		if (unlikely(signal_pending(current))) {=0A=
+			if (!written)=0A=
+				written =3D -ERESTARTSYS;=0A=
+			break;=0A=
+		}=0A=
+		{=0A=
+			struct pipe_pio my_pio;=0A=
+			/* build_pio=0A=
+			 * wakeup readers:=0A=
+			 * If the pipe was empty and now contains data, then do=0A=
+			 * a wakeup. We will sleep --> sync wakeup.=0A=
 			 */=0A=
-			wake_up_interruptible_sync(PIPE_WAIT(*inode));=0A=
-			PIPE_WAITING_WRITERS(*inode)++;=0A=
+			build_pio(&my_pio, inode, buf, count);=0A=
+			if (do_wakeup || PIPE_PIO(*inode).next =3D=3D &my_pio.list)=0A=
+				wake_up_sync(PIPE_WAIT(*inode));=0A=
+			do_wakeup =3D 0;=0A=
 			pipe_wait(inode);=0A=
-			PIPE_WAITING_WRITERS(*inode)--;=0A=
-			if (signal_pending(current))=0A=
-				goto out;=0A=
-			if (!PIPE_READERS(*inode))=0A=
-				goto sigpipe;=0A=
-		} while (!PIPE_FREE(*inode));=0A=
-		ret =3D -EFAULT;=0A=
+			chars =3D teardown_pio(&my_pio, inode, buf);=0A=
+			count -=3D chars;=0A=
+			written +=3D chars;=0A=
+			if (!count)=0A=
+				break;=0A=
+			buf +=3D chars;=0A=
+		}=0A=
 	}=0A=
-=0A=
-	/* Signal readers asynchronously that there is more data.  */=0A=
-	wake_up_interruptible(PIPE_WAIT(*inode));=0A=
-=0A=
-	inode->i_ctime =3D inode->i_mtime =3D CURRENT_TIME;=0A=
-	mark_inode_dirty(inode);=0A=
-=0A=
 out:=0A=
+	if (written > 0) {=0A=
+		/* SuS V2: st_ctime and st_mtime are updated=0A=
+		 * uppon successful completion of write(2).=0A=
+		 */=0A=
+		inode->i_ctime =3D inode->i_mtime =3D CURRENT_TIME;=0A=
+		mark_inode_dirty(inode);=0A=
+	}=0A=
 	up(PIPE_SEM(*inode));=0A=
-out_nolock:=0A=
-	if (written)=0A=
-		ret =3D written;=0A=
-	return ret;=0A=
 =0A=
-sigpipe:=0A=
-	if (written)=0A=
-		goto out;=0A=
-	up(PIPE_SEM(*inode));=0A=
-	send_sig(SIGPIPE, current, 0);=0A=
-	return -EPIPE;=0A=
+	if (do_wakeup)=0A=
+		wake_up(PIPE_WAIT(*inode));=0A=
+	if (written =3D=3D -EPIPE)=0A=
+		send_sig(SIGPIPE, current, 0);=0A=
+	return written;=0A=
 }=0A=
 =0A=
 static loff_t=0A=
@@ -270,7 +421,8 @@=0A=
 {=0A=
 	switch (cmd) {=0A=
 		case FIONREAD:=0A=
-			return put_user(PIPE_LEN(*pino), (int *)arg);=0A=
+			return put_user(PIPE_LEN(*filp->f_dentry->d_inode) +=0A=
+					PIPE_PIOLEN(*filp->f_dentry->d_inode), (int *)arg);=0A=
 		default:=0A=
 			return -EINVAL;=0A=
 	}=0A=
@@ -286,11 +438,20 @@=0A=
 	poll_wait(filp, PIPE_WAIT(*inode), wait);=0A=
 =0A=
 	/* Reading only -- no need for acquiring the semaphore.  */=0A=
+=0A=
+	/* =0A=
+	 * POLLIN means that data is available for read.=0A=
+	 * POLLOUT means that a nonblocking write will succeed.=0A=
+	 * We can only guarantee that if the internal buffers are empty=0A=
+	 * Therefore both are mutually exclusive.=0A=
+	 */=0A=
 	mask =3D POLLIN | POLLRDNORM;=0A=
-	if (PIPE_EMPTY(*inode))=0A=
+	if (!PIPE_LEN(*inode) && !PIPE_PIOLEN(*inode))=0A=
 		mask =3D POLLOUT | POLLWRNORM;=0A=
+	/* POLLHUP: no writer, and there was at least once a writer */=0A=
 	if (!PIPE_WRITERS(*inode) && filp->f_version !=3D =
PIPE_WCOUNTER(*inode))=0A=
 		mask |=3D POLLHUP;=0A=
+	/* POLLERR: no reader */=0A=
 	if (!PIPE_READERS(*inode))=0A=
 		mask |=3D POLLERR;=0A=
 =0A=
@@ -454,9 +615,9 @@=0A=
 =0A=
 	init_waitqueue_head(PIPE_WAIT(*inode));=0A=
 	PIPE_BASE(*inode) =3D (char*) page;=0A=
-	PIPE_START(*inode) =3D PIPE_LEN(*inode) =3D 0;=0A=
+	INIT_LIST_HEAD(&PIPE_PIO(*inode));=0A=
+	PIPE_START(*inode) =3D PIPE_LEN(*inode) =3D PIPE_PIOLEN(*inode) =3D 0;=0A=
 	PIPE_READERS(*inode) =3D PIPE_WRITERS(*inode) =3D 0;=0A=
-	PIPE_WAITING_READERS(*inode) =3D PIPE_WAITING_WRITERS(*inode) =3D 0;=0A=
 	PIPE_RCOUNTER(*inode) =3D PIPE_WCOUNTER(*inode) =3D 1;=0A=
 =0A=
 	return inode;=0A=
--- 2.5/include/linux/pipe_fs_i.h	Sat Apr 28 10:37:27 2001=0A=
+++ build-2.5/include/linux/pipe_fs_i.h	Wed Jan  2 00:56:14 2002=0A=
@@ -5,12 +5,12 @@=0A=
 struct pipe_inode_info {=0A=
 	wait_queue_head_t wait;=0A=
 	char *base;=0A=
-	unsigned int len;=0A=
+	size_t len;	/* not including pio buffers */=0A=
+	size_t piolen;=0A=
 	unsigned int start;=0A=
+	struct list_head pio;=0A=
 	unsigned int readers;=0A=
 	unsigned int writers;=0A=
-	unsigned int waiting_readers;=0A=
-	unsigned int waiting_writers;=0A=
 	unsigned int r_counter;=0A=
 	unsigned int w_counter;=0A=
 };=0A=
@@ -24,19 +24,15 @@=0A=
 #define PIPE_BASE(inode)	((inode).i_pipe->base)=0A=
 #define PIPE_START(inode)	((inode).i_pipe->start)=0A=
 #define PIPE_LEN(inode)		((inode).i_pipe->len)=0A=
+#define PIPE_PIOLEN(inode)	((inode).i_pipe->piolen)=0A=
+#define PIPE_PIO(inode)		((inode).i_pipe->pio)=0A=
 #define PIPE_READERS(inode)	((inode).i_pipe->readers)=0A=
 #define PIPE_WRITERS(inode)	((inode).i_pipe->writers)=0A=
-#define PIPE_WAITING_READERS(inode)	((inode).i_pipe->waiting_readers)=0A=
-#define PIPE_WAITING_WRITERS(inode)	((inode).i_pipe->waiting_writers)=0A=
 #define PIPE_RCOUNTER(inode)	((inode).i_pipe->r_counter)=0A=
 #define PIPE_WCOUNTER(inode)	((inode).i_pipe->w_counter)=0A=
 =0A=
-#define PIPE_EMPTY(inode)	(PIPE_LEN(inode) =3D=3D 0)=0A=
-#define PIPE_FULL(inode)	(PIPE_LEN(inode) =3D=3D PIPE_SIZE)=0A=
 #define PIPE_FREE(inode)	(PIPE_SIZE - PIPE_LEN(inode))=0A=
 #define PIPE_END(inode)	((PIPE_START(inode) + PIPE_LEN(inode)) & =
(PIPE_SIZE-1))=0A=
-#define PIPE_MAX_RCHUNK(inode)	(PIPE_SIZE - PIPE_START(inode))=0A=
-#define PIPE_MAX_WCHUNK(inode)	(PIPE_SIZE - PIPE_END(inode))=0A=
 =0A=
 /* Drop the inode semaphore and wait for a pipe event, atomically */=0A=
 void pipe_wait(struct inode * inode);=0A=
--- 2.5/fs/fifo.c	Fri Feb 23 15:25:22 2001=0A=
+++ build-2.5/fs/fifo.c	Wed Jan  2 00:56:14 2002=0A=
@@ -32,10 +32,8 @@=0A=
 {=0A=
 	int ret;=0A=
 =0A=
-	ret =3D -ERESTARTSYS;=0A=
-	lock_kernel();=0A=
 	if (down_interruptible(PIPE_SEM(*inode)))=0A=
-		goto err_nolock_nocleanup;=0A=
+		return -ERESTARTSYS;=0A=
 =0A=
 	if (!inode->i_pipe) {=0A=
 		ret =3D -ENOMEM;=0A=
@@ -116,7 +114,6 @@=0A=
 =0A=
 	/* Ok! */=0A=
 	up(PIPE_SEM(*inode));=0A=
-	unlock_kernel();=0A=
 	return 0;=0A=
 =0A=
 err_rd:=0A=
@@ -141,9 +138,6 @@=0A=
 =0A=
 err_nocleanup:=0A=
 	up(PIPE_SEM(*inode));=0A=
-=0A=
-err_nolock_nocleanup:=0A=
-	unlock_kernel();=0A=
 	return ret;=0A=
 }=0A=
 =0A=

------=_NextPart_000_0020_01C19640.886442F0--

