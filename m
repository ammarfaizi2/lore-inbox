Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267683AbUIOWaO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267683AbUIOWaO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 18:30:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267650AbUIOW27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 18:28:59 -0400
Received: from fw.osdl.org ([65.172.181.6]:51168 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267660AbUIOW0b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 18:26:31 -0400
Date: Wed, 15 Sep 2004 15:30:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: Stelian Pop <stelian@popies.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC, 2.6] a simple FIFO implementation
Message-Id: <20040915153013.32e797c8.akpm@osdl.org>
In-Reply-To: <20040913135253.GA3118@crusoe.alcove-fr>
References: <20040913135253.GA3118@crusoe.alcove-fr>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stelian Pop <stelian@popies.net> wrote:
>
> Hi all,
> 
> Is there a reason there is no API implementing a simple in-kernel
> FIFO ? A linked list is a bit overkill...
> 
> +struct kfifo {
> +	unsigned int head;
> +	unsigned int tail;
> +	unsigned int size;
> +	unsigned int len;
> +	spinlock_t lock;
> +	unsigned char *buffer;
> +};

A circular buffer implementation needs only head and tail indices.  `size'
above appears to be redundant.

Implementation-wise, the head and tail indices should *not* be constrained
to be less than the size of the buffer.  They should be allowed to wrap all
the way back to zero.  This allows you to distinguish between the
completely-empty and completely-full states while using 100% of the storage.

> +static inline struct kfifo *kfifo_alloc(unsigned int size) {

This should not be inlined, and the caller should pass in the gfp_flags.

> +static inline void kfifo_reset(struct kfifo *fifo) {

uninline this.

> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&fifo->lock, flags);
> +	
> +	fifo->head = fifo->tail = 0;
> +	fifo->len = 0;
> +
> +	spin_unlock_irqrestore(&fifo->lock, flags);
> +}

The caller should provide the locking.  The spinlock should be removed.

Or maybe provide a separate higher-level API which does the locking for
you.

> +static inline unsigned int kfifo_put(struct kfifo *fifo, 
> +				     unsigned char *buffer, unsigned int len) {
> +	unsigned long flags;
> +	unsigned int total, remaining;
> +	
> +	spin_lock_irqsave(&fifo->lock, flags);
> +
> +	total = remaining = min(len, fifo->size - fifo->len);
> +	while (remaining > 0) {
> +		unsigned int l = min(remaining, fifo->size - fifo->tail);
> +		memcpy(fifo->buffer + fifo->tail, buffer, l);
> +		fifo->tail += l;
> +		fifo->tail %= fifo->size;
> +		fifo->len += l;
> +		buffer += l;
> +		remaining -= l;
> +	}
> +
> +	spin_unlock_irqrestore(&fifo->lock, flags);
> +
> +	return total;
> +}

This is too big to inline.

> +static inline unsigned int kfifo_get(struct kfifo *fifo, 
> +				     unsigned char *buffer, unsigned int len) {
> +	unsigned long flags;
> +	unsigned int total, remaining;
> +
> +	spin_lock_irqsave(&fifo->lock, flags);
> +
> +	total = remaining = min(len, fifo->len);
> +	while (remaining > 0) {
> +		unsigned int l = min(remaining, fifo->size - fifo->head);
> +		memcpy(buffer, fifo->buffer + fifo->head, l);
> +		fifo->head += l;
> +		fifo->head %= fifo->size;
> +		fifo->len -= l;
> +		buffer += l;
> +		remaining -= l;
> +	}
> +
> +	spin_unlock_irqrestore(&fifo->lock, flags);
> +
> +        return total;

whitespace damage

> +}

Too big to inline.

> +/*
> + * kfifo_len - returns the number of bytes available in the FIFO
> + * @fifo: the fifo to be used.
> + */
> +static inline unsigned int kfifo_len(struct kfifo *fifo) {
> +	unsigned long flags;
> +	unsigned int result;
> +	
> +	spin_lock_irqsave(&fifo->lock, flags);
> +	
> +	result = fifo->len;
> +
> +	spin_unlock_irqrestore(&fifo->lock, flags);
> +
> +	return result;
> +}

And this.

