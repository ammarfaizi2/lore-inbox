Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129131AbRBTBwa>; Mon, 19 Feb 2001 20:52:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129242AbRBTBwU>; Mon, 19 Feb 2001 20:52:20 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:15109 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129131AbRBTBvl>; Mon, 19 Feb 2001 20:51:41 -0500
Date: Mon, 19 Feb 2001 22:03:33 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] exclusive wakeup for lock_buffer
Message-ID: <Pine.LNX.4.21.0102192156330.3008-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, 

The following patch makes lock_buffer() use the exclusive wakeup scheme
added in 2.3.

Against 2.4.2pre4.


--- linux/fs/buffer.c.orig	Mon Feb 19 23:13:08 2001
+++ linux/fs/buffer.c	Mon Feb 19 23:16:26 2001
@@ -142,13 +142,18 @@
  * if 'b_wait' is set before calling this, so that the queues aren't set
  * up unnecessarily.
  */
-void __wait_on_buffer(struct buffer_head * bh)
+void __wait_on_buffer(struct buffer_head * bh, int exclusive)
 {
 	struct task_struct *tsk = current;
 	DECLARE_WAITQUEUE(wait, tsk);
 
 	atomic_inc(&bh->b_count);
-	add_wait_queue(&bh->b_wait, &wait);
+
+	if (exclusive)
+		add_wait_queue_exclusive(&bh->b_wait, &wait);
+	else
+		add_wait_queue(&bh->b_wait, &wait);
+
 	do {
 		run_task_queue(&tq_disk);
 		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
@@ -2332,7 +2337,7 @@
 		tmp = tmp->b_this_page;
 		if (buffer_locked(p)) {
 			if (wait > 1)
-				__wait_on_buffer(p);
+				__wait_on_buffer(p, 0);
 		} else if (buffer_dirty(p))
 			ll_rw_block(WRITE, 1, &p);
 	} while (tmp != bh);
--- linux/include/linux/locks.h.orig	Mon Feb 19 23:21:10 2001
+++ linux/include/linux/locks.h	Mon Feb 19 23:17:42 2001
@@ -12,18 +12,18 @@
  * Buffer cache locking - note that interrupts may only unlock, not
  * lock buffers.
  */
-extern void __wait_on_buffer(struct buffer_head *);
+extern void __wait_on_buffer(struct buffer_head *, int);
 
 extern inline void wait_on_buffer(struct buffer_head * bh)
 {
 	if (test_bit(BH_Lock, &bh->b_state))
-		__wait_on_buffer(bh);
+		__wait_on_buffer(bh, 0);
 }
 
 extern inline void lock_buffer(struct buffer_head * bh)
 {
 	while (test_and_set_bit(BH_Lock, &bh->b_state))
-		__wait_on_buffer(bh);
+		__wait_on_buffer(bh, 1);
 }
 
 extern inline void unlock_buffer(struct buffer_head *bh)


