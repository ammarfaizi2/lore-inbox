Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261198AbVFMSrG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261198AbVFMSrG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 14:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261184AbVFMSrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 14:47:05 -0400
Received: from kanga.kvack.org ([66.96.29.28]:4555 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S261198AbVFMSqA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 14:46:00 -0400
Date: Mon, 13 Jun 2005 14:47:52 -0400
From: Benjamin LaHaise <bcrl@kvack.org>
To: torvalds@osdl.org
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] make wait_queue ->task ->private
Message-ID: <20050613184752.GB11285@kvack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the upcoming aio_down patch, it is useful to store a private data 
pointer in the kiocb's wait_queue.  Since we provide our own wake up 
function and do not require the task_struct pointer, it makes sense to 
convert the task pointer into a generic private pointer.

		-ben

Signed-off-by: Benjamin LaHaise <benjamin.c.lahaise@intel.com>
diff -purN 00_sync_rw/include/linux/wait.h 10_wait_private/include/linux/wait.h
--- 00_sync_rw/include/linux/wait.h	2005-06-13 02:08:02.000000000 -0400
+++ 10_wait_private/include/linux/wait.h	2005-06-13 14:26:58.171817512 -0400
@@ -33,7 +33,7 @@ int default_wake_function(wait_queue_t *
 struct __wait_queue {
 	unsigned int flags;
 #define WQ_FLAG_EXCLUSIVE	0x01
-	struct task_struct * task;
+	void *private;
 	wait_queue_func_t func;
 	struct list_head task_list;
 };
@@ -60,7 +60,7 @@ typedef struct __wait_queue_head wait_qu
  */
 
 #define __WAITQUEUE_INITIALIZER(name, tsk) {				\
-	.task		= tsk,						\
+	.private	= tsk,						\
 	.func		= default_wake_function,			\
 	.task_list	= { NULL, NULL } }
 
@@ -86,7 +86,7 @@ static inline void init_waitqueue_head(w
 static inline void init_waitqueue_entry(wait_queue_t *q, struct task_struct *p)
 {
 	q->flags = 0;
-	q->task = p;
+	q->private = p;
 	q->func = default_wake_function;
 }
 
@@ -94,7 +94,7 @@ static inline void init_waitqueue_func_e
 					wait_queue_func_t func)
 {
 	q->flags = 0;
-	q->task = NULL;
+	q->private = NULL;
 	q->func = func;
 }
 
@@ -110,7 +110,7 @@ static inline int waitqueue_active(wait_
  * aio specifies a wait queue entry with an async notification
  * callback routine, not associated with any task.
  */
-#define is_sync_wait(wait)	(!(wait) || ((wait)->task))
+#define is_sync_wait(wait)	(!(wait) || ((wait)->private))
 
 extern void FASTCALL(add_wait_queue(wait_queue_head_t *q, wait_queue_t * wait));
 extern void FASTCALL(add_wait_queue_exclusive(wait_queue_head_t *q, wait_queue_t * wait));
@@ -384,7 +384,7 @@ int wake_bit_function(wait_queue_t *wait
 
 #define DEFINE_WAIT(name)						\
 	wait_queue_t name = {						\
-		.task		= current,				\
+		.private	= current,				\
 		.func		= autoremove_wake_function,		\
 		.task_list	= LIST_HEAD_INIT((name).task_list),	\
 	}
@@ -393,7 +393,7 @@ int wake_bit_function(wait_queue_t *wait
 	struct wait_bit_queue name = {					\
 		.key = __WAIT_BIT_KEY_INITIALIZER(word, bit),		\
 		.wait	= {						\
-			.task		= current,			\
+			.private	= current,			\
 			.func		= wake_bit_function,		\
 			.task_list	=				\
 				LIST_HEAD_INIT((name).wait.task_list),	\
@@ -402,7 +402,7 @@ int wake_bit_function(wait_queue_t *wait
 
 #define init_wait(wait)							\
 	do {								\
-		(wait)->task = current;					\
+		(wait)->private = current;				\
 		(wait)->func = autoremove_wake_function;		\
 		INIT_LIST_HEAD(&(wait)->task_list);			\
 	} while (0)
diff -purN 00_sync_rw/kernel/sched.c 10_wait_private/kernel/sched.c
--- 00_sync_rw/kernel/sched.c	2005-06-13 02:08:03.000000000 -0400
+++ 10_wait_private/kernel/sched.c	2005-06-13 14:26:58.176816752 -0400
@@ -2869,7 +2869,7 @@ need_resched:
 
 int default_wake_function(wait_queue_t *curr, unsigned mode, int sync, void *key)
 {
-	task_t *p = curr->task;
+	task_t *p = curr->private;
 	return try_to_wake_up(p, mode, sync);
 }
 
