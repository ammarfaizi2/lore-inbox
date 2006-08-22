Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932221AbWHVNc6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbWHVNc6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 09:32:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932229AbWHVNc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 09:32:58 -0400
Received: from filfla-vlan276.msk.corbina.net ([213.234.233.49]:34192 "EHLO
	screens.ru") by vger.kernel.org with ESMTP id S932221AbWHVNc5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 09:32:57 -0400
Date: Tue, 22 Aug 2006 21:57:04 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sys_ioprio_set: don't disable irqs
Message-ID: <20060822175704.GC401@oleg>
References: <20060820204345.GA5750@oleg> <20060820205034.GA5755@oleg> <20060821154841.e6ea500a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060821154841.e6ea500a.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/21, Andrew Morton wrote:
>
> On Mon, 21 Aug 2006 00:50:34 +0400
> Oleg Nesterov <oleg@tv-sign.ru> wrote:
>
> > Question: why do we need to disable irqs in exit_io_context() ?
>
> iirc it was to prevent IRQ-context code from getting a hold on
> current->io_context and then playing around with it while it's getting
> freed.
>
> In practice, a preempt_disable() there would probably suffice (ie: if this
> CPU is running an ISR, it won't be running exit_io_context as well).  But
> local_irq_disable() is clearer, albeit more expensive.

Looks like my understanding of block I/O is even less than nothing :(

irq_disable() can't prevent from IRQ-context code playing with our io_context
on other CPUs. But this doesn't matter, we are only changing ioc->task.

What does matter, we are clearing the pointer to it: task_struct->io_context,
and IRQ should not look at it, no?

Or... Do you mean it is possible to submit I/O from IRQ on behalf of current ?????
In that case current_io_context() will re-instantiate ->io_context after irq_enable().
What is exit_io_context() for then? It is only called from do_exit() when we know
the task won't start IO.

(please don't beat a newbie)

> > Why do we need ->alloc_lock to clear io_context->task ?
>
> To prevent races against elv_unregister(), I guess.

elv_unregister() takes task_lock(), should see ->io_context == NULL.

Oleg.

