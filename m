Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751265AbWHUWsw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbWHUWsw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 18:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbWHUWsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 18:48:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19631 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751265AbWHUWsw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 18:48:52 -0400
Date: Mon, 21 Aug 2006 15:48:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sys_ioprio_set: don't disable irqs
Message-Id: <20060821154841.e6ea500a.akpm@osdl.org>
In-Reply-To: <20060820205034.GA5755@oleg>
References: <20060820204345.GA5750@oleg>
	<20060820205034.GA5755@oleg>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Aug 2006 00:50:34 +0400
Oleg Nesterov <oleg@tv-sign.ru> wrote:

> Question: why do we need to disable irqs in exit_io_context() ?

iirc it was to prevent IRQ-context code from getting a hold on
current->io_context and then playing around with it while it's getting
freed.

In practice, a preempt_disable() there would probably suffice (ie: if this
CPU is running an ISR, it won't be running exit_io_context as well).  But
local_irq_disable() is clearer, albeit more expensive.

> Why do we need ->alloc_lock to clear io_context->task ?

To prevent races against elv_unregister(), I guess.

> In other words, could you explain why the patch below is not correct.
> 
> Thanks,
> 
> Oleg.
> 
> --- 2.6.18-rc4/block/ll_rw_blk.c~6_exit	2006-08-20 19:30:10.000000000 +0400
> +++ 2.6.18-rc4/block/ll_rw_blk.c	2006-08-20 22:34:46.000000000 +0400
> @@ -3580,25 +3580,22 @@ EXPORT_SYMBOL(put_io_context);
>  /* Called by the exitting task */
>  void exit_io_context(void)
>  {
> -	unsigned long flags;
>  	struct io_context *ioc;
>  	struct cfq_io_context *cic;
>  
> -	local_irq_save(flags);
>  	task_lock(current);
>  	ioc = current->io_context;
>  	current->io_context = NULL;
> -	ioc->task = NULL;
>  	task_unlock(current);
> -	local_irq_restore(flags);
>  
> +	ioc->task = NULL;
>  	if (ioc->aic && ioc->aic->exit)
>  		ioc->aic->exit(ioc->aic);
>  	if (ioc->cic_root.rb_node != NULL) {
>  		cic = rb_entry(rb_first(&ioc->cic_root), struct cfq_io_context, rb_node);
>  		cic->exit(ioc);
>  	}
> - 
> +
>  	put_io_context(ioc);
>  }
>  
