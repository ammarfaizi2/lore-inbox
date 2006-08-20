Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750750AbWHTLov@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbWHTLov (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 07:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbWHTLov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 07:44:51 -0400
Received: from filfla-vlan276.msk.corbina.net ([213.234.233.49]:59362 "EHLO
	screens.ru") by vger.kernel.org with ESMTP id S1750750AbWHTLou
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 07:44:50 -0400
Date: Sun, 20 Aug 2006 20:08:52 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Jens Axboe <axboe@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, "Paul E. McKenney" <paulmck@us.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] fix? current_io_context() vs set_task_ioprio() race
Message-ID: <20060820160852.GA2186@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I know nothing about io scheduler, but I suspect set_task_ioprio() is not safe.

current_io_context() initializes "struct io_context", then sets ->io_context.
set_task_ioprio() running on another cpu may see the changes out of order, so
->set_ioprio(ioc) may use io_context which was not initialized properly.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.18-rc4/block/ll_rw_blk.c~3_race	2006-07-16 01:53:08.000000000 +0400
+++ 2.6.18-rc4/block/ll_rw_blk.c	2006-08-20 19:30:10.000000000 +0400
@@ -3628,6 +3628,8 @@ struct io_context *current_io_context(gf
 		ret->nr_batch_requests = 0; /* because this is 0 */
 		ret->aic = NULL;
 		ret->cic_root.rb_node = NULL;
+		/* make sure set_task_ioprio() sees the settings above */
+		smp_wmb();
 		tsk->io_context = ret;
 	}
 
--- 2.6.18-rc4/fs/ioprio.c~3_race	2006-08-20 19:09:08.000000000 +0400
+++ 2.6.18-rc4/fs/ioprio.c	2006-08-20 19:57:14.000000000 +0400
@@ -44,6 +44,9 @@ static int set_task_ioprio(struct task_s
 	task->ioprio = ioprio;
 
 	ioc = task->io_context;
+	/* see wmb() in current_io_context() */
+	smp_read_barrier_depends();
+
 	if (ioc && ioc->set_ioprio)
 		ioc->set_ioprio(ioc, ioprio);
 

