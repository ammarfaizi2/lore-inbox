Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263551AbUECCc7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263551AbUECCc7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 22:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263555AbUECCc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 22:32:59 -0400
Received: from holomorphy.com ([207.189.100.168]:19076 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263551AbUECCcy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 22:32:54 -0400
Date: Sun, 2 May 2004 19:32:52 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [2/2] filtered buffer_head wakeups
Message-ID: <20040503023252.GI1397@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20040503021709.GF1397@holomorphy.com> <20040503022346.GG1397@holomorphy.com> <20040503022936.GH1397@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040503022936.GH1397@holomorphy.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 02, 2004 at 07:29:36PM -0700, William Lee Irwin III wrote:
> This patch creates a new scheduling entrypoint, wake_up_filtered(), and
> uses it in page waitqueue hashing to discriminate between the waiters
> on various pages. One of the sources of the thundering herds was
> identified as the page waitqueue hashing by a priori methods and
> empirically confirmed using the scheduler caller profiling patch.

It turned out there were still thundering herds after the page
waitqueue hashtable. The scheduler caller profiling patch identified
this as the buffer_head waitqueue hashtable. This patch teaches the
buffer_head waitqueue hashing to use filtered wakeups.


-- wli

Index: wli-2.6.6-rc3-mm1/fs/buffer.c
===================================================================
--- wli-2.6.6-rc3-mm1.orig/fs/buffer.c	2004-04-30 15:06:46.000000000 -0700
+++ wli-2.6.6-rc3-mm1/fs/buffer.c	2004-04-30 19:51:25.000000000 -0700
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
Index: wli-2.6.6-rc3-mm1/fs/jbd/transaction.c
===================================================================
--- wli-2.6.6-rc3-mm1.orig/fs/jbd/transaction.c	2004-04-30 15:06:46.000000000 -0700
+++ wli-2.6.6-rc3-mm1/fs/jbd/transaction.c	2004-04-30 19:51:25.000000000 -0700
@@ -638,7 +638,7 @@
 			jbd_unlock_bh_state(bh);
 			/* commit wakes up all shadow buffers after IO */
 			wqh = bh_waitq_head(jh2bh(jh));
-			wait_event(*wqh, (jh->b_jlist != BJ_Shadow));
+			wait_event_filtered(*wqh, jh2bh(jh), (jh->b_jlist != BJ_Shadow));
 			goto repeat;
 		}
 
Index: wli-2.6.6-rc3-mm1/include/linux/wait.h
===================================================================
--- wli-2.6.6-rc3-mm1.orig/include/linux/wait.h	2004-04-30 19:50:33.000000000 -0700
+++ wli-2.6.6-rc3-mm1/include/linux/wait.h	2004-04-30 19:51:25.000000000 -0700
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
+	add_wait_queue(&(wq), &__wait.wait);				\
+	for (;;) {							\
+		set_current_state(TASK_UNINTERRUPTIBLE);		\
+		if (condition)						\
+			break;						\
+		schedule();						\
+	}								\
+	current->state = TASK_RUNNING;					\
+	remove_wait_queue(&(wq), &__wait.wait);				\
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
