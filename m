Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268665AbUIQKYe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268665AbUIQKYe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 06:24:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268667AbUIQKYe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 06:24:34 -0400
Received: from sd291.sivit.org ([194.146.225.122]:10457 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S268665AbUIQKXe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 06:23:34 -0400
Date: Fri, 17 Sep 2004 12:24:14 +0200
From: Stelian Pop <stelian@popies.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC, 2.6] a simple FIFO implementation
Message-ID: <20040917102413.GA3089@crusoe.alcove-fr>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040913135253.GA3118@crusoe.alcove-fr> <20040915153013.32e797c8.akpm@osdl.org> <20040916064320.GA9886@deep-space-9.dsnet> <20040916000438.46d91e94.akpm@osdl.org> <20040916104535.GA3146@crusoe.alcove-fr> <20040916100050.17a9b341.akpm@osdl.org> <20040916180908.GB9886@deep-space-9.dsnet> <20040916171817.78ab4430.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040916171817.78ab4430.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2004 at 05:18:17PM -0700, Andrew Morton wrote:

> Stelian Pop <stelian@popies.net> wrote:
> >
> > > I've always done it the other way: you put stuff onto the head and take
> > > stuff off the tail.  Now I have a horid feeling that I've always been
> > > arse-about.  hrm.  
> > 
> > Maybe I should use 'start' and 'end' as indices after all, they
> > are less subject to confusion.
> 
> `in' and `out' would be more meaningful, yes?  I'll edit the diff.

There is more than just this rename.

A third and I hope final version of the patch follows. It includes
several changes as suggested by Paul Jackson and Bill Davidsen
among others:
	- rename head/tail to in/out (data goes at 'in', gets out from 'out')
	- add some documentation to the struct kfifo fields
	- optimize __kfifo_put/__kfifo_get by removing the 
	  while() loop, the 'remaining' variable, and some 
	  unnecessary operations.
	- if the fifo becomes empty after a get() sets in = out = 0
	  so only a memcpy() will be needed not two in the next put/get.

Stelian.


Signed-off-by: Stelian Pop <stelian@popies.net>

--- /dev/null	2004-02-23 22:02:56.000000000 +0100
+++ linux-2.6/include/linux/kfifo.h	2004-09-17 10:23:48.000000000 +0200
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
+	unsigned char *buffer;	/* the buffer holding the data */
+	unsigned int size;	/* the size of the allocated buffer */
+	unsigned int in;	/* data is added at offset (in % size) */
+	unsigned int out;	/* data is extracted from off. (out % size) */
+	spinlock_t lock;	/* protects concurrent modifications */
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
+++ linux-2.6/kernel/kfifo.c	2004-09-17 10:51:26.000000000 +0200
@@ -0,0 +1,146 @@
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
+	fifo->in = fifo->out = 0;
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
+	fifo->in = fifo->out = 0;
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
+	unsigned int l;
+	
+	len = min(len, fifo->size - fifo->in + fifo->out);
+
+	/* first put the data starting from fifo->in to buffer end */
+	l = min(len, fifo->size - (fifo->in % fifo->size));
+	memcpy(fifo->buffer + (fifo->in % fifo->size), buffer, l);
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
+	unsigned int l;
+
+	len = min(len, fifo->in - fifo->out);
+
+	/* first get the data from fifo->out until the end of the buffer */
+	l = min(len, fifo->size - (fifo->out % fifo->size));
+	memcpy(buffer, fifo->buffer + (fifo->out % fifo->size), l);
+
+	/* then get the rest (if any) from the beginning of the buffer */
+	memcpy(buffer, fifo->buffer + l, len - l);
+
+	fifo->out += len;
+
+	/* if the FIFO is empty, set the indices to 0 so we don't wrap the next time */
+	if (fifo->in == fifo->out)
+		fifo->in = fifo->out = 0;
+
+	return len;
+}
+EXPORT_SYMBOL(__kfifo_get);
+
+/*
+ * kfifo_len - returns the number of bytes available in the FIFO, no locking version
+ * @fifo: the fifo to be used.
+ */
+unsigned int __kfifo_len(struct kfifo *fifo)
+{
+	return fifo->in - fifo->out;
+}
+EXPORT_SYMBOL(__kfifo_len);
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
