Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267421AbUIPGmm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267421AbUIPGmm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 02:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267703AbUIPGml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 02:42:41 -0400
Received: from sd291.sivit.org ([194.146.225.122]:62863 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S267421AbUIPGmi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 02:42:38 -0400
Date: Thu, 16 Sep 2004 08:43:21 +0200
From: Stelian Pop <stelian@popies.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC, 2.6] a simple FIFO implementation
Message-ID: <20040916064320.GA9886@deep-space-9.dsnet>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040913135253.GA3118@crusoe.alcove-fr> <20040915153013.32e797c8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040915153013.32e797c8.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2004 at 03:30:13PM -0700, Andrew Morton wrote:

> > +struct kfifo {
> > +	unsigned int head;
> > +	unsigned int tail;
> > +	unsigned int size;
> > +	unsigned int len;
> > +	spinlock_t lock;
> > +	unsigned char *buffer;
> > +};
> 
> A circular buffer implementation needs only head and tail indices.  `size'
> above appears to be redundant.
> 
> Implementation-wise, the head and tail indices should *not* be constrained
> to be less than the size of the buffer.  They should be allowed to wrap all
> the way back to zero.  This allows you to distinguish between the
> completely-empty and completely-full states while using 100% of the storage.

Do you mean 'size' (the size of alloc'ed buffer) is redundant or 'len' 
(the amount of data in the FIFO) is redundant ? I see how 'len' could
be removed (and didn't do it in the first place because I choosed
code simplification over a 4 bytes gain in storage), but I hardly
see how 'size' could be removed...

> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&fifo->lock, flags);
> > +	
> > +	fifo->head = fifo->tail = 0;
> > +	fifo->len = 0;
> > +
> > +	spin_unlock_irqrestore(&fifo->lock, flags);
> > +}
> 
> The caller should provide the locking.  The spinlock should be removed.
> 
> Or maybe provide a separate higher-level API which does the locking for
> you.

Like in __kfifo_get which doesn't lock and kfifo_get which does ?

I don't want to remove it completly since the whole point of this 
spinlock is to protect the fifo contents...

> This is too big to inline.
[...]
> whitespace damage
[...]

Oops. I will post an updated patch later today.

Thanks for the feedback.

Stelian.
-- 
Stelian Pop <stelian@popies.net>
