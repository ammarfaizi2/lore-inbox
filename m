Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265345AbTLNFCg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Dec 2003 00:02:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265346AbTLNFCg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Dec 2003 00:02:36 -0500
Received: from fw.osdl.org ([65.172.181.6]:31914 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265345AbTLNFCd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Dec 2003 00:02:33 -0500
Date: Sat, 13 Dec 2003 21:02:30 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Anton Blanchard <anton@samba.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: prepare_to_wait/waitqueue_active issues in 2.6
In-Reply-To: <20031214035356.GM17683@krispykreme>
Message-ID: <Pine.LNX.4.58.0312132024270.14336@home.osdl.org>
References: <20031214034059.GL17683@krispykreme> <20031214035356.GM17683@krispykreme>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 14 Dec 2003, Anton Blanchard wrote:
>
> > End result is waitqueue_active returns 0 and buffer_locked returns 1.
> > We miss a wakeup. Game over. Ive attached a patch that forces the check
> > to happen after we are put on the waitqueue. Thanks to Brian Twichell
> > for the analysis and suggested fix for this.
>
> This time for sure.

Pardon my French, but this patch sure looks like crap.

Wouldn't it be better to just make sure "prepare_to_wait()" has the proper
barriers in it?  If you have problems with fs/buffer.c, then you should
have problems with the page_unlock() path in mm/filemap.c too, which has
_exactly_ the same logic.

In fact, pretty much any use of "prepare_to_wait()" has the potential of
moving a subsequent test upwards to before the wait-queue addition, so
we'd have this bug for _any_ use of "waitqueue_active()". The spinlocks
protect from criticial data moving outside the critical region, but not
against movement in_to_ the critical region.

In short - as-is, your patch looks to be right, but it only solves a small
part of what appears to be the larger problem.

So my preference would be to add the barrier into prepare_to_wait(), along
with a comment on why it is sometimes needed.  Something like the
appended.. (which just uses "set_current_state()", since that's what it
exists for).

Does this work for you? I'd much prefer to see a fix that fixes _all_ the
cases, and is just two lines (plus the comment, which is much more ;)

		Linus

----
--- 1.147/kernel/fork.c	Fri Dec 12 14:20:03 2003
+++ edited/kernel/fork.c	Sat Dec 13 20:59:29 2003
@@ -125,15 +125,28 @@

 EXPORT_SYMBOL(remove_wait_queue);

+
+/*
+ * Note: we use "set_current_state()" _after_ the wait-queue add,
+ * because we need a memory barrier there on SMP, so that any
+ * wake-function that tests for the wait-queue being active
+ * will be guaranteed to see waitqueue addition _or_ subsequent
+ * tests in this thread will see the wakeup having taken place.
+ *
+ * The spin_unlock() itself is semi-permeable and only protects
+ * one way (it only protects stuff inside the critical region and
+ * stops them from bleeding out - it would still allow subsequent
+ * loads to move into the the critical region).
+ */
 void prepare_to_wait(wait_queue_head_t *q, wait_queue_t *wait, int state)
 {
 	unsigned long flags;

-	__set_current_state(state);
 	wait->flags &= ~WQ_FLAG_EXCLUSIVE;
 	spin_lock_irqsave(&q->lock, flags);
 	if (list_empty(&wait->task_list))
 		__add_wait_queue(q, wait);
+	set_current_state(state);
 	spin_unlock_irqrestore(&q->lock, flags);
 }

@@ -144,11 +157,11 @@
 {
 	unsigned long flags;

-	__set_current_state(state);
 	wait->flags |= WQ_FLAG_EXCLUSIVE;
 	spin_lock_irqsave(&q->lock, flags);
 	if (list_empty(&wait->task_list))
 		__add_wait_queue_tail(q, wait);
+	set_current_state(state);
 	spin_unlock_irqrestore(&q->lock, flags);
 }

