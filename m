Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751563AbWA0WaT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751563AbWA0WaT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 17:30:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751565AbWA0WaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 17:30:19 -0500
Received: from smtp.osdl.org ([65.172.181.4]:62438 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751563AbWA0WaS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 17:30:18 -0500
Date: Fri, 27 Jan 2006 14:32:15 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [patch] drivers/block/floppy.c: dont free_irq() from irq
 context
Message-Id: <20060127143215.5e349aeb.akpm@osdl.org>
In-Reply-To: <20060126162922.GA5135@elte.hu>
References: <20060126162922.GA5135@elte.hu>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> free_irq() should not be executed from softirq context.
> 
> ...
> 
> the fix is to push fd_free_irq() into keventd. The code validates fine 
> with this patch applied.
> 
> --- linux.orig/drivers/block/floppy.c
> +++ linux/drivers/block/floppy.c

You know this makes you the floppy maintainer?

> @@ -251,6 +251,18 @@ static int irqdma_allocated;
>  #include <linux/cdrom.h>	/* for the compatibility eject ioctl */
>  #include <linux/completion.h>
>  
> +/*
> + * Interrupt freeing also means /proc VFS work - dont do it
> + * from interrupt context. We push this work into keventd:
> + */
> +static void fd_free_irq_fn(void *data)
> +{
> +	fd_free_irq();
> +}
> +
> +static DECLARE_WORK(fd_free_irq_work, fd_free_irq_fn, NULL);
> +
> +
>  static struct request *current_req;
>  static struct request_queue *floppy_queue;
>  static void do_fd_request(request_queue_t * q);
> @@ -4434,6 +4446,13 @@ static int floppy_grab_irq_and_dma(void)
>  		return 0;
>  	}
>  	spin_unlock_irqrestore(&floppy_usage_lock, flags);
> +
> +	/*
> +	 * We might have scheduled a free_irq(), wait it to
> +	 * drain first:
> +	 */
> +	flush_scheduled_work();
> +

yup.

>  	if (fd_request_irq()) {
>  		DPRINT("Unable to grab IRQ%d for the floppy driver\n",
>  		       FLOPPY_IRQ);
> @@ -4523,7 +4542,7 @@ static void floppy_release_irq_and_dma(v
>  	if (irqdma_allocated) {
>  		fd_disable_dma();
>  		fd_free_dma();
> -		fd_free_irq();
> +		schedule_work(&fd_free_irq_work);
>  		irqdma_allocated = 0;
>  	}
>  	set_dor(0, ~0, 8);

I think we need a flush_scheduled_work() in cleanup_module() too.  Because
floppy_release_irq_and_dma() might have taken usage_count to zero, but the
workqueue is still pending.

This patch doesn't do anything to improve the floppy driver :(
