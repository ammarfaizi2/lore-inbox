Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268992AbUIQU5F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268992AbUIQU5F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 16:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269034AbUIQUyz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 16:54:55 -0400
Received: from sd291.sivit.org ([194.146.225.122]:17544 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S268992AbUIQUta (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 16:49:30 -0400
Date: Fri, 17 Sep 2004 22:50:12 +0200
From: Stelian Pop <stelian@popies.net>
To: Hugh Dickins <hugh@veritas.com>
Cc: James R Bruce <bruce@andrew.cmu.edu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Andrea Arcangeli <andrea@novell.com>
Subject: Re: [RFC, 2.6] a simple FIFO implementation
Message-ID: <20040917205011.GA3049@crusoe.dsnet>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Hugh Dickins <hugh@veritas.com>,
	James R Bruce <bruce@andrew.cmu.edu>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, Andrea Arcangeli <andrea@novell.com>
References: <20040917154834.GA3180@crusoe.alcove-fr> <Pine.LNX.4.44.0409171708210.3162-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0409171708210.3162-100000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2004 at 05:14:06PM +0100, Hugh Dickins wrote:

> The moduli can now be replaced by faster masks "& (fifo->size - 1)".

With this and the latest Andrea suggestions the patch is now close
to final.

Andrew, I guess you can apply this one to your tree.

Thanks.

Stelian.

Signed-off-by: Stelian Pop <stelian@popies.net>

--- /dev/null	2004-02-23 22:02:56.000000000 +0100
+++ linux-2.6/include/linux/kfifo.h	2004-09-17 17:30:48.000000000 +0200
@@ -0,0 +1,157 @@
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
+	unsigned char *buffer;	/* the buffer holding the data */
+	unsigned int size;	/* the size of the allocated buffer */
+	unsigned int in;	/* data is added at offset (in % size) */
+	unsigned int out;	/* data is extracted from off. (out % size) */
+	spinlock_t *lock;	/* protects concurrent modifications */
+};
+
+extern struct kfifo *kfifo_init(unsigned char *buffer, unsigned int size,
+				int gfp_mask, spinlock_t *lock);
+extern struct kfifo *kfifo_alloc(unsigned int size, int gfp_mask,
+				 spinlock_t *lock);
+extern void kfifo_free(struct kfifo *fifo);
+extern unsigned int __kfifo_put(struct kfifo *fifo, 
+				unsigned char *buffer, unsigned int len);
+extern unsigned int __kfifo_get(struct kfifo *fifo, 
+				unsigned char *buffer, unsigned int len);
+
+/*
+ * __kfifo_reset - removes the entire FIFO contents, no locking version
+ * @fifo: the fifo to be emptied.
+ */
+static inline void __kfifo_reset(struct kfifo *fifo)
+{
+	fifo->in = fifo->out = 0;
+}
+
+/*
+ * kfifo_reset - removes the entire FIFO contents
+ * @fifo: the fifo to be emptied.
+ */
+static inline void kfifo_reset(struct kfifo *fifo)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(fifo->lock, flags);
+
+	__kfifo_reset(fifo);
+
+	spin_unlock_irqrestore(fifo->lock, flags);
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
+	spin_lock_irqsave(fifo->lock, flags);
+
+	ret = __kfifo_put(fifo, buffer, len);
+	
+	spin_unlock_irqrestore(fifo->lock, flags);
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
+	spin_lock_irqsave(fifo->lock, flags);
+
+	ret = __kfifo_get(fifo, buffer, len);
+
+	/* 
+	 * optimization: if the FIFO is empty, set the indices to 0 
+	 * so we don't wrap the next time
+	 */
+	if (fifo->in == fifo->out)
+		fifo->in = fifo->out = 0;
+
+	spin_unlock_irqrestore(fifo->lock, flags);
+
+	return ret;
+}
+
+/*
+ * __kfifo_len - returns the number of bytes available in the FIFO, no locking version
+ * @fifo: the fifo to be used.
+ */
+static inline unsigned int __kfifo_len(struct kfifo *fifo)
+{
+	return fifo->in - fifo->out;
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
+	spin_lock_irqsave(fifo->lock, flags);
+
+	ret = __kfifo_len(fifo);
+
+	spin_unlock_irqrestore(fifo->lock, flags);
+
+	return ret;
+}
+
+#else
+#warning "don't include kernel headers in userspace"
+#endif /* __KERNEL__ */
+#endif
--- /dev/null	2004-02-23 22:02:56.000000000 +0100
+++ linux-2.6/kernel/kfifo.c	2004-09-17 22:34:08.000000000 +0200
@@ -0,0 +1,170 @@
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
+#include <linux/err.h>
+#include <linux/kfifo.h>
+
+/*
+ * kfifo_init - allocates a new FIFO using a preallocated buffer
+ * @buffer: the preallocated buffer to be used.
+ * @size: the size of the internal buffer, this have to be a power of 2.
+ * @gfp_mask: get_free_pages mask, passed to kmalloc()
+ * @lock: the lock to be used to protect the fifo buffer
+ *
+ * Do NOT pass the kfifo to kfifo_free() after use ! Simply free the
+ * struct kfifo with kfree().
+ */
+struct kfifo *kfifo_init(unsigned char *buffer, unsigned int size, 
+			 int gfp_mask, spinlock_t *lock)
+{
+	struct kfifo *fifo;
+
+	/* size must be a power of 2 */
+	BUG_ON(size & (size - 1));
+
+	fifo = kmalloc(sizeof(struct kfifo), gfp_mask);
+	if (!fifo)
+		return ERR_PTR(-ENOMEM);
+
+	fifo->buffer = buffer;
+	fifo->size = size;
+	fifo->in = fifo->out = 0;
+	fifo->lock = lock;
+
+	return fifo;
+}
+EXPORT_SYMBOL(kfifo_init);
+
+/*
+ * kfifo_alloc - allocates a new FIFO and its internal buffer
+ * @size: the size of the internal buffer to be allocated.
+ * @gfp_mask: get_free_pages mask, passed to kmalloc()
+ * @lock: the lock to be used to protect the fifo buffer
+ *
+ * The size will be rounded-up to a power of 2.
+ */
+struct kfifo *kfifo_alloc(unsigned int size, int gfp_mask, spinlock_t *lock)
+{
+	unsigned int newsize;
+	unsigned char *buffer;
+	struct kfifo *ret;
+
+	/* 
+	 * round up to the next power of 2, since our 'let the indices
+	 * wrap' tachnique works only in this case.
+	 */
+	if (size > 0x80000000)
+		return ERR_PTR(-EINVAL);
+	newsize = 1;
+	while (newsize < size)
+		newsize <<= 1;
+
+	buffer = kmalloc(newsize, gfp_mask);
+	if (!buffer)
+		return ERR_PTR(-ENOMEM);
+
+	ret = kfifo_init(buffer, size, gfp_mask, lock);
+
+	if (IS_ERR(ret))
+		kfree(buffer);
+	
+	return ret;
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
+ * __kfifo_put - puts some data into the FIFO, no locking version
+ * @fifo: the fifo to be used.
+ * @buffer: the data to be added.
+ * @len: the length of the data to be added.
+ *
+ * This function copies at most 'len' bytes from the 'buffer' into
+ * the FIFO depending on the free space, and returns the number of
+ * bytes copied.
+ *
+ * Note that with only one concurrent reader and one concurrent 
+ * writer, you don't need extra locking to use these functions.
+ */
+unsigned int __kfifo_put(struct kfifo *fifo, 
+			 unsigned char *buffer, unsigned int len)
+{
+	unsigned int l;
+	
+	len = min(len, fifo->size - fifo->in + fifo->out);
+
+	/* first put the data starting from fifo->in to buffer end */
+	l = min(len, fifo->size - (fifo->in & (fifo->size - 1)));
+	memcpy(fifo->buffer + (fifo->in & (fifo->size - 1)), buffer, l);
+
+	/* then put the rest (if any) at the beginning of the buffer */	
+	memcpy(fifo->buffer, buffer + l, len - l);
+
+	fifo->in += len;
+
+	return len;
+}
+EXPORT_SYMBOL(__kfifo_put);
+
+/*
+ * __kfifo_get - gets some data from the FIFO, no locking version
+ * @fifo: the fifo to be used.
+ * @buffer: where the data must be copied.
+ * @len: the size of the destination buffer.
+ *
+ * This function copies at most 'len' bytes from the FIFO into the
+ * 'buffer' and returns the number of copied bytes.
+ *
+ * Note that with only one concurrent reader and one concurrent 
+ * writer, you don't need extra locking to use these functions.
+ */
+unsigned int __kfifo_get(struct kfifo *fifo, 
+			 unsigned char *buffer, unsigned int len)
+{
+	unsigned int l;
+
+	len = min(len, fifo->in - fifo->out);
+
+	/* first get the data from fifo->out until the end of the buffer */
+	l = min(len, fifo->size - (fifo->out & (fifo->size - 1)));
+	memcpy(buffer, fifo->buffer + (fifo->out & (fifo->size - 1)), l);
+
+	/* then get the rest (if any) from the beginning of the buffer */
+	memcpy(buffer, fifo->buffer + l, len - l);
+
+	fifo->out += len;
+
+	return len;
+}
+EXPORT_SYMBOL(__kfifo_get);
--- linux-2.6/kernel/Makefile.orig	2004-09-16 12:27:29.000000000 +0200
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
