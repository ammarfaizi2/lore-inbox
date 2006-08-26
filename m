Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030200AbWHZQHb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030200AbWHZQHb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 12:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030218AbWHZQHb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 12:07:31 -0400
Received: from taganka54-host.corbina.net ([213.234.233.54]:60553 "EHLO
	screens.ru") by vger.kernel.org with ESMTP id S1030200AbWHZQHa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 12:07:30 -0400
Date: Sun, 27 Aug 2006 00:31:42 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Jens Axboe <axboe@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] exit_io_context: don't disable irqs
Message-ID: <20060826203142.GA333@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need to disable irqs to clear current->io_context, it is protected
by ->alloc_lock. Even IF it was possible to submit I/O from IRQ on behalf of
current this irq_disable() can't help: current_io_context() will re-instantiate
->io_context after irq_enable().

We don't need task_lock() or local_irq_disable() to clear ioc->task. This can't
prevent other CPUs from playing with our io_context anyway.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.18-rc4/block/ll_rw_blk.c~6_exit	2006-08-27 00:10:53.000000000 +0400
+++ 2.6.18-rc4/block/ll_rw_blk.c	2006-08-27 00:11:47.000000000 +0400
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
 

