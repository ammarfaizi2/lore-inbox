Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268157AbUIPPWC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268157AbUIPPWC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 11:22:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268283AbUIPPVX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 11:21:23 -0400
Received: from rproxy.gmail.com ([64.233.170.192]:11301 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268236AbUIPPJy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 11:09:54 -0400
Message-ID: <5d6b657504091608093b171e30@mail.gmail.com>
Date: Thu, 16 Sep 2004 17:09:51 +0200
From: Buddy Lucas <buddy.lucas@gmail.com>
Reply-To: Buddy Lucas <buddy.lucas@gmail.com>
To: Stelian Pop <stelian@popies.net>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC, 2.6] a simple FIFO implementation
In-Reply-To: <20040916104535.GA3146@crusoe.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20040913135253.GA3118@crusoe.alcove-fr>
	 <20040915153013.32e797c8.akpm@osdl.org>
	 <20040916064320.GA9886@deep-space-9.dsnet>
	 <20040916000438.46d91e94.akpm@osdl.org>
	 <20040916104535.GA3146@crusoe.alcove-fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Sep 2004 12:45:36 +0200, Stelian Pop <stelian@popies.net> wrote:
> On Thu, Sep 16, 2004 at 12:04:38AM -0700, Andrew Morton wrote:
> 
> > Stelian Pop <stelian@popies.net> wrote:
> > >
> > > > Implementation-wise, the head and tail indices should *not* be constrained
> > >  > to be less than the size of the buffer.  They should be allowed to wrap all
> > >  > the way back to zero.  This allows you to distinguish between the
> > >  > completely-empty and completely-full states while using 100% of the storage.
> [...]
> 
> Here is the updated patch.
>
[ .. ] 
>
> +unsigned int __kfifo_put(struct kfifo *fifo,
> +                        unsigned char *buffer, unsigned int len)
> +{
> +       unsigned int total, remaining, l;
> +
> +       total = remaining = min(len, fifo->size - fifo->tail + fifo->head);

I could be mistaken (long day at the office ;-) but doesn't this fail after 
wrapping?

> +       while (remaining > 0) {
> +               l = min(remaining, fifo->size - (fifo->tail % fifo->size));
> +               memcpy(fifo->buffer + (fifo->tail % fifo->size), buffer, l);
> +               fifo->tail += l;
> +               buffer += l;
> +               remaining -= l;
> +       }
> +
> +       return total;
> +}
> +EXPORT_SYMBOL(__kfifo_put);
> +
> +/*
> + * kfifo_get - gets some data from the FIFO, no locking version
> + * @fifo: the fifo to be used.
> + * @buffer: where the data must be copied.
> + * @len: the size of the destination buffer.
> + *
> + * This function copies at most 'len' bytes from the FIFO into the
> + * 'buffer' and returns the number of copied bytes.
> + */
> +unsigned int __kfifo_get(struct kfifo *fifo,
> +                        unsigned char *buffer, unsigned int len)
> +{
> +       unsigned int total, remaining, l;
> +
> +       total = remaining = min(len, fifo->tail - fifo->head);

Same here?

> +       while (remaining > 0) {
> +               l = min(remaining, fifo->size - (fifo->head % fifo->size));
> +               memcpy(buffer, fifo->buffer + (fifo->head % fifo->size), l);
> +               fifo->head += l;
> +               buffer += l;
> +               remaining -= l;
> +       }
> +
> +       return total;
> +}
> +EXPORT_SYMBOL(__kfifo_get);
> +
> +/*
> + * kfifo_len - returns the number of bytes available in the FIFO, no locking version
> + * @fifo: the fifo to be used.
> + */
> +unsigned int __kfifo_len(struct kfifo *fifo)
> +{
> +       return fifo->tail - fifo->head;
> +}
> +EXPORT_SYMBOL(__kfifo_len);
> --- linux-2.6/kernel/Makefile.orig      2004-09-16 12:27:29.012343608 +0200
> +++ linux-2.6/kernel/Makefile   2004-09-16 11:58:26.000000000 +0200
> @@ -7,7 +7,7 @@
>            sysctl.o capability.o ptrace.o timer.o user.o \
>            signal.o sys.o kmod.o workqueue.o pid.o \
>            rcupdate.o intermodule.o extable.o params.o posix-timers.o \
> -           kthread.o
> +           kthread.o kfifo.o
> 
> obj-$(CONFIG_FUTEX) += futex.o
> obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
> 
> --
> 
> 
> Stelian Pop <stelian@popies.net>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
