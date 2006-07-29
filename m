Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752033AbWG2AKf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752033AbWG2AKf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 20:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752063AbWG2AKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 20:10:35 -0400
Received: from tetsuo.zabbo.net ([207.173.201.20]:46222 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S1752033AbWG2AKe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 20:10:34 -0400
Date: Fri, 28 Jul 2006 17:10:32 -0700
From: Zach Brown <zach.brown@oracle.com>
To: linux-kernel@vger.kernel.org, linux-aio@kvack.org
Cc: Benjamin LaHaise <bcrl@kvack.org>, Arjan van de Ven <arjan@infradead.org>
Subject: [RFC][PATCH] Fix lock inversion aio_kick_handler()
Message-ID: <20060729001032.GA7885@tetsuo.zabbo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix lock inversion aio_kick_handler()

lockdep found a AB BC CA lock inversion in retry-based AIO:

1) The task struct's alloc_lock (A) is acquired in process context with
interrupts enabled.  An interrupt might arrive and call wake_up() which grabs
the wait queue's q->lock (B).

2) When performing retry-based AIO the AIO core registers aio_wake_function()
as the wake funtion for iocb->ki_wait.  It is called with the wait queue's
q->lock (B) held and then tries to add the iocb to the run list after acquiring
the ctx_lock (C).

3) aio_kick_handler() holds the ctx_lock (C) while acquiring the alloc_lock (A)
via lock_task() and unuse_mm().  Lockdep emits a warning saying that we're
trying to connect the irq-safe q->lock to the irq-unsafe alloc_lock via
ctx_lock.

This fixes the inversion by calling unuse_mm() in the AIO kick handing path
after we've released the ctx_lock.

Signed-off-by: Zach Brown <zach.brown@oracle.com>
---

Ben, can you remember why we put unuse_mm() inside the ctx_lock?  Is that
intentional and still needed?

Index: 2.6.18-rc2-mm1-cmdepoll/fs/aio.c
===================================================================
--- 2.6.18-rc2-mm1-cmdepoll.orig/fs/aio.c
+++ 2.6.18-rc2-mm1-cmdepoll/fs/aio.c
@@ -598,9 +598,6 @@ static void use_mm(struct mm_struct *mm)
  *	by the calling kernel thread
  *	(Note: this routine is intended to be called only
  *	from a kernel thread context)
- *
- * Comments: Called with ctx->ctx_lock held. This nests
- * task_lock instead ctx_lock.
  */
 static void unuse_mm(struct mm_struct *mm)
 {
@@ -866,8 +863,8 @@ static void aio_kick_handler(void *data)
 	use_mm(ctx->mm);
 	spin_lock_irq(&ctx->ctx_lock);
 	requeue =__aio_run_iocbs(ctx);
- 	unuse_mm(ctx->mm);
 	spin_unlock_irq(&ctx->ctx_lock);
+ 	unuse_mm(ctx->mm);
 	set_fs(oldfs);
 	/*
 	 * we're in a worker thread already, don't use queue_delayed_work,
