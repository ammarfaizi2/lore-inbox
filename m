Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267701AbUIPKtP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267701AbUIPKtP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 06:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267904AbUIPKtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 06:49:14 -0400
Received: from sd291.sivit.org ([194.146.225.122]:13722 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S267701AbUIPKo7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 06:44:59 -0400
Date: Thu, 16 Sep 2004 12:45:36 +0200
From: Stelian Pop <stelian@popies.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC, 2.6] a simple FIFO implementation
Message-ID: <20040916104535.GA3146@crusoe.alcove-fr>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040913135253.GA3118@crusoe.alcove-fr> <20040915153013.32e797c8.akpm@osdl.org> <20040916064320.GA9886@deep-space-9.dsnet> <20040916000438.46d91e94.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040916000438.46d91e94.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2004 at 12:04:38AM -0700, Andrew Morton wrote:

> Stelian Pop <stelian@popies.net> wrote:
> >
> > > Implementation-wise, the head and tail indices should *not* be constrained
> >  > to be less than the size of the buffer.  They should be allowed to wrap all
> >  > the way back to zero.  This allows you to distinguish between the
> >  > completely-empty and completely-full states while using 100% of the storage.
[...]

Here is the updated patch.

Changes from the previous version include:
- removed excessive inlining, extern functions go now to kernel/kfifo.c
- added __kfifo_get, __kfifo_put etc which do no locking at all
- kfifo_get/kfifo_put are now inline wrappers of the __ versions, which
  takes the spinlock to protect the fifo contents.
- corrected whitespace damage :)

> add(char c)
> {
> 	p->buf[p->head++ % p->number_of_bytes_at_buf] = c;
> }

I wonder if replacing the kfifo_get/kfifo_put implementations with
something like:

	while (remaining--)
		add(*buffer++);

instead of the memcpy() would be a gain in performance... I leaved
the memcpy() implementation for now but since the FIFOS are generally
used to buffer small structures (most of the time bytes or ints), the
character based method may be more efficient.

Stelian.

--- /dev/null	2004-02-23 22:02:56.000000000 +0100
+++ linux-2.6/include/linux/kfifo.h	2004-09-16 12:36:36.024185168 +0200
@@ -0,0 +1,131 @@
+/*
+ * A simple kernel FIFO implementation.
+ *
+ * Copyright (C) 2004 Stelian Pop <stelian@popies.net>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ * 
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ * 
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+#ifndef _LINUX_KFIFO_H
+#define _LINUX_KFIFO_H
+
+#ifdef __KERNEL__
+
+#include <linux/kernel.h>
+#include <linux/spinlock.h>
+
+struct kfifo {
+	unsigned int head;
+	unsigned int tail;
+	unsigned int size;
+	spinlock_t lock;
+	unsigned char *buffer;
+};
+
+extern struct kfifo *kfifo_alloc(unsigned int size, int gfp_mask);
+extern void kfifo_free(struct kfifo *fifo);
+extern void __kfifo_reset(struct kfifo *fifo);
+extern unsigned int __kfifo_put(struct kfifo *fifo, 
+				unsigned char *buffer, unsigned int len);
+extern unsigned int __kfifo_get(struct kfifo *fifo, 
+				unsigned char *buffer, unsigned int len);
+extern unsigned int __kfifo_len(struct kfifo *fifo);
+
+/*
+ * kfifo_reset - removes the entire FIFO contents
+ * @fifo: the fifo to be emptied.
+ */
+static inline void kfifo_reset(struct kfifo *fifo)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&fifo->lock, flags);
+
+	__kfifo_reset(fifo);
+
+	spin_unlock_irqrestore(&fifo->lock, flags);
+}
+
+/*
+ * kfifo_put - puts some data into the FIFO
+ * @fifo: the fifo to be used.
+ * @buffer: the data to be added.
+ * @len: the length of the data to be added.
+ *
+ * This function copies at most 'len' bytes from the 'buffer' into
+ * the FIFO depending on the free space, and returns the number of
+ * bytes copied. 
+ */
+static inline unsigned int kfifo_put(struct kfifo *fifo, 
+				     unsigned char *buffer, unsigned int len)
+{
+	unsigned long flags;
+	unsigned int ret;
+
+	spin_lock_irqsave(&fifo->lock, flags);
+
+	ret = __kfifo_put(fifo, buffer, len);
+	
+	spin_unlock_irqrestore(&fifo->lock, flags);
+
+	return ret;
+}
+
+/*
+ * kfifo_get - gets some data from the FIFO
+ * @fifo: the fifo to be used.
+ * @buffer: where the data must be copied.
+ * @len: the size of the destination buffer.
+ *
+ * This function copies at most 'len' bytes from the FIFO into the
+ * 'buffer' and returns the number of copied bytes.
+ */
+static inline unsigned int kfifo_get(struct kfifo *fifo, 
+				     unsigned char *buffer, unsigned int len)
+{
+	unsigned long flags;
+	unsigned int ret;
+
+	spin_lock_irqsave(&fifo->lock, flags);
+
+	ret = __kfifo_get(fifo, buffer, len);
+
+	spin_unlock_irqrestore(&fifo->lock, flags);
+
+	return ret;
+}
+
+/*
+ * kfifo_len - returns the number of bytes available in the FIFO
+ * @fifo: the fifo to be used.
+ */
+static inline unsigned int kfifo_len(struct kfifo *fifo)
+{
+	unsigned long flags;
+	unsigned int ret;
+
+	spin_lock_irqsave(&fifo->lock, flags);
+
+	ret = __kfifo_len(fifo);
+
+	spin_unlock_irqrestore(&fifo->lock, flags);
+
+	return ret;
+}
+
+#else
+#warning "don't include kernel headers in userspace"
+#endif /* __KERNEL__ */
+#endif
--- /dev/null	2004-02-23 22:02:56.000000000 +0100
+++ linux-2.6/kernel/kfifo.c	2004-09-16 12:37:45.233663728 +0200
@@ -0,0 +1,138 @@
+/*
+ * A simple kernel FIFO implementation.
+ *
+ * Copyright (C) 2004 Stelian Pop <stelian@popies.net>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ * 
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ * 
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/kfifo.h>
+
+/*
+ * kfifo_alloc - allocates a new FIFO
+ * @size: the size of the internal buffer.
+ * @gfp_mask: get_free_pages mask, passed to kmalloc()
+ */
+struct kfifo *kfifo_alloc(unsigned int size, int gfp_mask)
+{
+	struct kfifo *fifo;
+
+	fifo = kmalloc(sizeof(struct kfifo), gfp_mask);
+	if (!fifo)
+		return NULL;
+	
+	fifo->buffer = kmalloc(size, gfp_mask);
+	if (!fifo->buffer) {
+		kfree(fifo);
+		return NULL;
+	}
+
+	fifo->head = fifo->tail = 0;
+	fifo->size = size;
+	fifo->lock = SPIN_LOCK_UNLOCKED;
+
+	return fifo;
+}
+EXPORT_SYMBOL(kfifo_alloc);
+
+/*
+ * kfifo_free - frees the FIFO
+ * @fifo: the fifo to be freed.
+ */
+void kfifo_free(struct kfifo *fifo)
+{
+	kfree(fifo->buffer);
+	kfree(fifo);
+}
+EXPORT_SYMBOL(kfifo_free);
+
+/*
+ * __kfifo_reset - removes the entire FIFO contents, no locking version
+ * @fifo: the fifo to be emptied.
+ */
+void __kfifo_reset(struct kfifo *fifo)
+{
+	fifo->head = fifo->tail = 0;
+}
+EXPORT_SYMBOL(__kfifo_reset);
+
+/*
+ * __kfifo_put - puts some data into the FIFO, no locking version
+ * @fifo: the fifo to be used.
+ * @buffer: the data to be added.
+ * @len: the length of the data to be added.
+ *
+ * This function copies at most 'len' bytes from the 'buffer' into
+ * the FIFO depending on the free space, and returns the number of
+ * bytes copied. 
+ */
+unsigned int __kfifo_put(struct kfifo *fifo, 
+			 unsigned char *buffer, unsigned int len)
+{
+	unsigned int total, remaining, l;
+	
+	total = remaining = min(len, fifo->size - fifo->tail + fifo->head);
+	while (remaining > 0) {
+		l = min(remaining, fifo->size - (fifo->tail % fifo->size));
+		memcpy(fifo->buffer + (fifo->tail % fifo->size), buffer, l);
+		fifo->tail += l;
+		buffer += l;
+		remaining -= l;
+	}
+
+	return total;
+}
+EXPORT_SYMBOL(__kfifo_put);
+
+/*
+ * kfifo_get - gets some data from the FIFO, no locking version
+ * @fifo: the fifo to be used.
+ * @buffer: where the data must be copied.
+ * @len: the size of the destination buffer.
+ *
+ * This function copies at most 'len' bytes from the FIFO into the
+ * 'buffer' and returns the number of copied bytes.
+ */
+unsigned int __kfifo_get(struct kfifo *fifo, 
+			 unsigned char *buffer, unsigned int len)
+{
+	unsigned int total, remaining, l;
+
+	total = remaining = min(len, fifo->tail - fifo->head);
+	while (remaining > 0) {
+		l = min(remaining, fifo->size - (fifo->head % fifo->size));
+		memcpy(buffer, fifo->buffer + (fifo->head % fifo->size), l);
+		fifo->head += l;
+		buffer += l;
+		remaining -= l;
+	}
+
+	return total;
+}
+EXPORT_SYMBOL(__kfifo_get);
+
+/*
+ * kfifo_len - returns the number of bytes available in the FIFO, no locking version
+ * @fifo: the fifo to be used.
+ */
+unsigned int __kfifo_len(struct kfifo *fifo)
+{
+	return fifo->tail - fifo->head;
+}
+EXPORT_SYMBOL(__kfifo_len);
--- linux-2.6/kernel/Makefile.orig	2004-09-16 12:27:29.012343608 +0200
+++ linux-2.6/kernel/Makefile	2004-09-16 11:58:26.000000000 +0200
@@ -7,7 +7,7 @@
 	    sysctl.o capability.o ptrace.o timer.o user.o \
 	    signal.o sys.o kmod.o workqueue.o pid.o \
 	    rcupdate.o intermodule.o extable.o params.o posix-timers.o \
-	    kthread.o
+	    kthread.o kfifo.o
 
 obj-$(CONFIG_FUTEX) += futex.o
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o

-- 
Stelian Pop <stelian@popies.net>    
