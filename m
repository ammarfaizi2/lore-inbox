Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262896AbUEEGLh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262896AbUEEGLh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 02:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263093AbUEEGLh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 02:11:37 -0400
Received: from holomorphy.com ([207.189.100.168]:12943 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262896AbUEEGLZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 02:11:25 -0400
Date: Tue, 4 May 2004 23:11:21 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [2/3] filtered buffer_head wakeups
Message-ID: <20040505061121.GX1397@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20040505060612.GV1397@holomorphy.com> <20040505060849.GW1397@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040505060849.GW1397@holomorphy.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 04, 2004 at 11:08:49PM -0700, William Lee Irwin III wrote:
> Precisely the same filtered wakeups for pages as before. Drop in a
> fresh wakeup primitive that uses a key to discriminate between the
> waiters for different objects on a hashed waitqueue, and make the
> page waiting functions use it.

Now, make bh's use the new wakeup primitive also. This has the bugfix
vs. the prior version that autoremoved waitqueue wakeup functions are
made to match autoremove API usage in __wait_event_filtered().


-- wli

Index: wake-2.6.6-rc3-mm1/fs/buffer.c
===================================================================
--- wake-2.6.6-rc3-mm1.orig/fs/buffer.c	2004-04-30 15:06:46.000000000 -0700
+++ wake-2.6.6-rc3-mm1/fs/buffer.c	2004-05-04 13:16:16.000000000 -0700
@@ -74,7 +74,7 @@
 
 	smp_mb();
 	if (waitqueue_active(wq))
-		wake_up_all(wq);
+		wake_up_filtered(wq, bh);
 }
 EXPORT_SYMBOL(wake_up_buffer);
 
@@ -93,10 +93,10 @@
 void __wait_on_buffer(struct buffer_head * bh)
 {
 	wait_queue_head_t *wqh = bh_waitq_head(bh);
-	DEFINE_WAIT(wait);
+	DEFINE_FILTERED_WAIT(wait, bh);
 
 	do {
-		prepare_to_wait(wqh, &wait, TASK_UNINTERRUPTIBLE);
+		prepare_to_wait(wqh, &wait.wait, TASK_UNINTERRUPTIBLE);
 		if (buffer_locked(bh)) {
 			struct block_device *bd;
 			smp_mb();
@@ -106,7 +106,7 @@
 			io_schedule();
 		}
 	} while (buffer_locked(bh));
-	finish_wait(wqh, &wait);
+	finish_wait(wqh, &wait.wait);
 }
 
 static void
Index: wake-2.6.6-rc3-mm1/fs/jbd/transaction.c
===================================================================
--- wake-2.6.6-rc3-mm1.orig/fs/jbd/transaction.c	2004-04-30 15:06:46.000000000 -0700
+++ wake-2.6.6-rc3-mm1/fs/jbd/transaction.c	2004-05-04 13:16:16.000000000 -0700
@@ -638,7 +638,7 @@
 			jbd_unlock_bh_state(bh);
 			/* commit wakes up all shadow buffers after IO */
 			wqh = bh_waitq_head(jh2bh(jh));
-			wait_event(*wqh, (jh->b_jlist != BJ_Shadow));
+			wait_event_filtered(*wqh, jh2bh(jh), (jh->b_jlist != BJ_Shadow));
 			goto repeat;
 		}
 
Index: wake-2.6.6-rc3-mm1/include/linux/wait.h
===================================================================
--- wake-2.6.6-rc3-mm1.orig/include/linux/wait.h	2004-05-04 13:16:00.000000000 -0700
+++ wake-2.6.6-rc3-mm1/include/linux/wait.h	2004-05-04 13:16:27.000000000 -0700
@@ -146,7 +146,6 @@
 		break;							\
 	__wait_event(wq, condition);					\
 } while (0)
-
 #define __wait_event_interruptible(wq, condition, ret)			\
 do {									\
 	wait_queue_t __wait;						\
@@ -273,7 +272,28 @@
 			.task_list = LIST_HEAD_INIT(name.wait.task_list),\
 		},							\
 	}
-	
+
+#define __wait_event_filtered(wq, key, condition) 			\
+do {									\
+	DEFINE_FILTERED_WAIT(__wait, key);				\
+	wait_queue_head_t *__wqh = &(wq);				\
+	wait_queue_t *__wqe = &__wait.wait;				\
+	for (;;) {							\
+		prepare_to_wait(__wqh, __wqe, TASK_UNINTERRUPTIBLE);	\
+		if (condition)						\
+			break;						\
+		schedule();						\
+	}								\
+	finish_wait(__wqh, __wqe);					\
+} while (0)
+
+
+#define wait_event_filtered(wq, key, condition)				\
+do {									\
+	if (!(condition))						\
+		__wait_event_filtered(wq, key, condition);		\
+} while (0)
+
 #endif /* __KERNEL__ */
 
 #endif
