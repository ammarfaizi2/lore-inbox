Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266768AbUIMNwo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266768AbUIMNwo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 09:52:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266775AbUIMNwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 09:52:44 -0400
Received: from sd291.sivit.org ([194.146.225.122]:22741 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S266768AbUIMNwU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 09:52:20 -0400
Date: Mon, 13 Sep 2004 15:52:53 +0200
From: Stelian Pop <stelian@popies.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC, 2.6] a simple FIFO implementation
Message-ID: <20040913135253.GA3118@crusoe.alcove-fr>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Is there a reason there is no API implementing a simple in-kernel
FIFO ? A linked list is a bit overkill...

Besides my sonypi and meye drivers which could use this, there are
quite a few other drivers which re-implement the circular buffer
over and over again...

An initial implementation follows below. Comments ?

Thanks,

Stelian.

--- /dev/null	2004-02-23 22:02:56.000000000 +0100
+++ linux-2.6/include/linux/kfifo.h	2004-09-13 14:58:37.000000000 +0200
@@ -0,0 +1,179 @@
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
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+
+/*
+ * This is a simple FIFO implementation using a circular buffer.
+ */
+struct kfifo {
+	unsigned int head;
+	unsigned int tail;
+	unsigned int size;
+	unsigned int len;
+	spinlock_t lock;
+	unsigned char *buffer;
+};
+
+/*
+ * kfifo_alloc - allocates a new FIFO
+ * @size: the size of the internal buffer.
+ *
+ * Note that the allocation uses kmalloc(GFP_KERNEL).
+ */
+static inline struct kfifo *kfifo_alloc(unsigned int size) {
+	struct kfifo *fifo;
+
+	fifo = kmalloc(sizeof(struct kfifo), GFP_KERNEL);
+	if (!fifo)
+		return NULL;
+	
+	fifo->buffer = kmalloc(size, GFP_KERNEL);
+	if (!fifo->buffer) {
+		kfree(fifo);
+		return NULL;
+	}
+
+	fifo->head = fifo->tail = 0;
+	fifo->size = size;
+	fifo->len = 0;
+	fifo->lock = SPIN_LOCK_UNLOCKED;
+
+	return fifo;
+}
+
+/*
+ * kfifo_free - frees the FIFO
+ * @fifo: the fifo to be freed.
+ */
+static inline void kfifo_free(struct kfifo *fifo) {
+	kfree(fifo->buffer);
+	kfree(fifo);
+}
+
+/*
+ * kfifo_reset - removes the entire FIFO contents
+ * @fifo: the fifo to be emptied.
+ */
+static inline void kfifo_reset(struct kfifo *fifo) {
+	unsigned long flags;
+
+	spin_lock_irqsave(&fifo->lock, flags);
+	
+	fifo->head = fifo->tail = 0;
+	fifo->len = 0;
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
+				     unsigned char *buffer, unsigned int len) {
+	unsigned long flags;
+	unsigned int total, remaining;
+	
+	spin_lock_irqsave(&fifo->lock, flags);
+
+	total = remaining = min(len, fifo->size - fifo->len);
+	while (remaining > 0) {
+		unsigned int l = min(remaining, fifo->size - fifo->tail);
+		memcpy(fifo->buffer + fifo->tail, buffer, l);
+		fifo->tail += l;
+		fifo->tail %= fifo->size;
+		fifo->len += l;
+		buffer += l;
+		remaining -= l;
+	}
+
+	spin_unlock_irqrestore(&fifo->lock, flags);
+
+	return total;
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
+				     unsigned char *buffer, unsigned int len) {
+	unsigned long flags;
+	unsigned int total, remaining;
+
+	spin_lock_irqsave(&fifo->lock, flags);
+
+	total = remaining = min(len, fifo->len);
+	while (remaining > 0) {
+		unsigned int l = min(remaining, fifo->size - fifo->head);
+		memcpy(buffer, fifo->buffer + fifo->head, l);
+		fifo->head += l;
+		fifo->head %= fifo->size;
+		fifo->len -= l;
+		buffer += l;
+		remaining -= l;
+	}
+
+	spin_unlock_irqrestore(&fifo->lock, flags);
+
+        return total;
+}
+
+/*
+ * kfifo_len - returns the number of bytes available in the FIFO
+ * @fifo: the fifo to be used.
+ */
+static inline unsigned int kfifo_len(struct kfifo *fifo) {
+	unsigned long flags;
+	unsigned int result;
+	
+	spin_lock_irqsave(&fifo->lock, flags);
+	
+	result = fifo->len;
+
+	spin_unlock_irqrestore(&fifo->lock, flags);
+
+	return result;
+}
+
+
+#else
+#warning "don't include kernel headers in userspace"
+#endif /* __KERNEL__ */
+#endif
-- 
Stelian Pop <stelian@popies.net>    
