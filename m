Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129284AbRBTCkp>; Mon, 19 Feb 2001 21:40:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129309AbRBTCkg>; Mon, 19 Feb 2001 21:40:36 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:16901 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129284AbRBTCkT>; Mon, 19 Feb 2001 21:40:19 -0500
Date: Mon, 19 Feb 2001 22:51:36 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] exclusive wakeup for lock_buffer
In-Reply-To: <Pine.LNX.4.10.10102191757330.28351-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0102192245340.3338-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 19 Feb 2001, Linus Torvalds wrote:

> 
> 
> On Mon, 19 Feb 2001, Marcelo Tosatti wrote:
> > 
> > The following patch makes lock_buffer() use the exclusive wakeup scheme
> > added in 2.3.
> 
> Ugh, This is horrible.
> 
> You should NOT have one function that does two completely different things
> depending on a flag. That way lies madness and bad coding habits.
> 
> Just do two different functions - make one be "__wait_on_buffer()", and
> the other be "__lock_buffer()". See how the page functions work.
> 
> 		Linus

Ok. 

--- linux/include/linux/locks.h.orig	Mon Feb 19 23:16:50 2001
+++ linux/include/linux/locks.h	Mon Feb 19 23:21:48 2001
@@ -13,6 +13,7 @@
  * lock buffers.
  */
 extern void __wait_on_buffer(struct buffer_head *);
+extern void __lock_buffer(struct buffer_head *);
 
 extern inline void wait_on_buffer(struct buffer_head * bh)
 {
@@ -22,8 +23,8 @@
 
 extern inline void lock_buffer(struct buffer_head * bh)
 {
-	while (test_and_set_bit(BH_Lock, &bh->b_state))
-		__wait_on_buffer(bh);
+	if (test_and_set_bit(BH_Lock, &bh->b_state))
+		__lock_on_buffer(bh);
 }
 
 extern inline void unlock_buffer(struct buffer_head *bh)
--- linux/fs/buffer.c.orig	Mon Feb 19 23:09:31 2001
+++ linux/fs/buffer.c	Mon Feb 19 23:31:25 2001
@@ -161,6 +161,30 @@
 	atomic_dec(&bh->b_count);
 }
 
+void __lock_on_buffer(struct buffer_head * bh)
+{
+	struct task_struct *tsk = current;
+	DECLARE_WAITQUEUE(wait, tsk);
+
+	atomic_inc(&bh->b_count);
+	add_wait_queue_exclusive(&bh->b_wait, &wait);
+	for(;;) { 
+		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
+		if (test_bit(BH_Lock, &bh->b_state)) {
+			run_task_queue(&tq_disk);
+			schedule();
+			continue;
+		}
+
+		if (!test_and_set_bit(BH_Lock, &bh->b_state))
+			break;
+	} 
+	tsk->state = TASK_RUNNING;
+	remove_wait_queue(&bh->b_wait, &wait);
+	atomic_dec(&bh->b_count);
+}
+
+
 /* Call sync_buffers with wait!=0 to ensure that the call does not
  * return until all buffer writes have completed.  Sync() may return
  * before the writes have finished; fsync() may not.

