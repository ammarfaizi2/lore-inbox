Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750831AbWHTQ0f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbWHTQ0f (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 12:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbWHTQ0f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 12:26:35 -0400
Received: from filfla-vlan276.msk.corbina.net ([213.234.233.49]:22152 "EHLO
	screens.ru") by vger.kernel.org with ESMTP id S1750831AbWHTQ0f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 12:26:35 -0400
Date: Mon, 21 Aug 2006 00:50:34 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Jens Axboe <axboe@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sys_ioprio_set: don't disable irqs
Message-ID: <20060820205034.GA5755@oleg>
References: <20060820204345.GA5750@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060820204345.GA5750@oleg>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Question: why do we need to disable irqs in exit_io_context() ?
Why do we need ->alloc_lock to clear io_context->task ?

In other words, could you explain why the patch below is not correct.

Thanks,

Oleg.

--- 2.6.18-rc4/block/ll_rw_blk.c~6_exit	2006-08-20 19:30:10.000000000 +0400
+++ 2.6.18-rc4/block/ll_rw_blk.c	2006-08-20 22:34:46.000000000 +0400
@@ -3580,25 +3580,22 @@ EXPORT_SYMBOL(put_io_context);
 /* Called by the exitting task */
 void exit_io_context(void)
 {
-	unsigned long flags;
 	struct io_context *ioc;
 	struct cfq_io_context *cic;
 
-	local_irq_save(flags);
 	task_lock(current);
 	ioc = current->io_context;
 	current->io_context = NULL;
-	ioc->task = NULL;
 	task_unlock(current);
-	local_irq_restore(flags);
 
+	ioc->task = NULL;
 	if (ioc->aic && ioc->aic->exit)
 		ioc->aic->exit(ioc->aic);
 	if (ioc->cic_root.rb_node != NULL) {
 		cic = rb_entry(rb_first(&ioc->cic_root), struct cfq_io_context, rb_node);
 		cic->exit(ioc);
 	}
- 
+
 	put_io_context(ioc);
 }
 

