Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267799AbUH1UKt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267799AbUH1UKt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 16:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267798AbUH1UJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 16:09:35 -0400
Received: from holomorphy.com ([207.189.100.168]:63912 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267756AbUH1UHE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 16:07:04 -0400
Date: Sat, 28 Aug 2004 13:06:59 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [1/5] move waitqueue functions to kernel/wait.c
Message-ID: <20040828200659.GS5492@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, akpm@osdl.org
References: <20040828200549.GR5492@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040828200549.GR5492@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28, 2004 at 01:05:49PM -0700, William Lee Irwin III wrote:
> These patches have the further benefit and intention of enabling aio
> to use filtered wakeups by standardizing the data structure passed to
> wake functions so that embedded waitqueue elements in aio structures
> may be succesfully passed to the filtered wakeup wake functions, though
> this patch series doesn't implement that particular functionality.
> Successfully stress-tested on x86-64, and ia64 in recent prior versions.

Move waitqueue -related functions not needing static functions in
sched.c to kernel/wait.c

Index: wait-2.6.9-rc1-mm1/kernel/Makefile
===================================================================
--- wait-2.6.9-rc1-mm1.orig/kernel/Makefile	2004-08-28 09:43:20.428470784 -0700
+++ wait-2.6.9-rc1-mm1/kernel/Makefile	2004-08-28 09:45:17.915610024 -0700
@@ -7,7 +7,7 @@
 	    sysctl.o capability.o ptrace.o timer.o user.o \
 	    signal.o sys.o kmod.o workqueue.o pid.o \
 	    rcupdate.o intermodule.o extable.o params.o posix-timers.o \
-	    kthread.o
+	    kthread.o wait.o
 
 obj-$(CONFIG_FUTEX) += futex.o
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
Index: wait-2.6.9-rc1-mm1/kernel/wait.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ wait-2.6.9-rc1-mm1/kernel/wait.c	2004-08-28 09:46:45.808248312 -0700
@@ -0,0 +1,129 @@
+/*
+ * Generic waiting primitives.
+ *
+ * (C) 2004 William Irwin, Oracle
+ */
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/wait.h>
+
+void fastcall add_wait_queue(wait_queue_head_t *q, wait_queue_t *wait)
+{
+	unsigned long flags;
+
+	wait->flags &= ~WQ_FLAG_EXCLUSIVE;
+	spin_lock_irqsave(&q->lock, flags);
+	__add_wait_queue(q, wait);
+	spin_unlock_irqrestore(&q->lock, flags);
+}
+EXPORT_SYMBOL(add_wait_queue);
+
+void fastcall add_wait_queue_exclusive(wait_queue_head_t *q, wait_queue_t *wait)
+{
+	unsigned long flags;
+
+	wait->flags |= WQ_FLAG_EXCLUSIVE;
+	spin_lock_irqsave(&q->lock, flags);
+	__add_wait_queue_tail(q, wait);
+	spin_unlock_irqrestore(&q->lock, flags);
+}
+EXPORT_SYMBOL(add_wait_queue_exclusive);
+
+void fastcall remove_wait_queue(wait_queue_head_t *q, wait_queue_t *wait)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&q->lock, flags);
+	__remove_wait_queue(q, wait);
+	spin_unlock_irqrestore(&q->lock, flags);
+}
+EXPORT_SYMBOL(remove_wait_queue);
+
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
+void fastcall
+prepare_to_wait(wait_queue_head_t *q, wait_queue_t *wait, int state)
+{
+	unsigned long flags;
+
+	wait->flags &= ~WQ_FLAG_EXCLUSIVE;
+	spin_lock_irqsave(&q->lock, flags);
+	if (list_empty(&wait->task_list))
+		__add_wait_queue(q, wait);
+	/*
+	 * don't alter the task state if this is just going to
+	 * queue an async wait queue callback
+	 */
+	if (is_sync_wait(wait))
+		set_current_state(state);
+	spin_unlock_irqrestore(&q->lock, flags);
+}
+EXPORT_SYMBOL(prepare_to_wait);
+
+void fastcall
+prepare_to_wait_exclusive(wait_queue_head_t *q, wait_queue_t *wait, int state)
+{
+	unsigned long flags;
+
+	wait->flags |= WQ_FLAG_EXCLUSIVE;
+	spin_lock_irqsave(&q->lock, flags);
+	if (list_empty(&wait->task_list))
+		__add_wait_queue_tail(q, wait);
+	/*
+	 * don't alter the task state if this is just going to
+ 	 * queue an async wait queue callback
+	 */
+	if (is_sync_wait(wait))
+		set_current_state(state);
+	spin_unlock_irqrestore(&q->lock, flags);
+}
+EXPORT_SYMBOL(prepare_to_wait_exclusive);
+
+void fastcall finish_wait(wait_queue_head_t *q, wait_queue_t *wait)
+{
+	unsigned long flags;
+
+	__set_current_state(TASK_RUNNING);
+	/*
+	 * We can check for list emptiness outside the lock
+	 * IFF:
+	 *  - we use the "careful" check that verifies both
+	 *    the next and prev pointers, so that there cannot
+	 *    be any half-pending updates in progress on other
+	 *    CPU's that we haven't seen yet (and that might
+	 *    still change the stack area.
+	 * and
+	 *  - all other users take the lock (ie we can only
+	 *    have _one_ other CPU that looks at or modifies
+	 *    the list).
+	 */
+	if (!list_empty_careful(&wait->task_list)) {
+		spin_lock_irqsave(&q->lock, flags);
+		list_del_init(&wait->task_list);
+		spin_unlock_irqrestore(&q->lock, flags);
+	}
+}
+EXPORT_SYMBOL(finish_wait);
+
+int autoremove_wake_function(wait_queue_t *wait, unsigned mode, int sync, void *key)
+{
+	int ret = default_wake_function(wait, mode, sync, key);
+
+	if (ret)
+		list_del_init(&wait->task_list);
+	return ret;
+}
+EXPORT_SYMBOL(autoremove_wake_function);
Index: wait-2.6.9-rc1-mm1/kernel/fork.c
===================================================================
--- wait-2.6.9-rc1-mm1.orig/kernel/fork.c	2004-08-28 09:43:34.177380632 -0700
+++ wait-2.6.9-rc1-mm1/kernel/fork.c	2004-08-28 09:45:17.925608504 -0700
@@ -102,131 +102,6 @@
 		free_task(tsk);
 }
 
-void fastcall add_wait_queue(wait_queue_head_t *q, wait_queue_t * wait)
-{
-	unsigned long flags;
-
-	wait->flags &= ~WQ_FLAG_EXCLUSIVE;
-	spin_lock_irqsave(&q->lock, flags);
-	__add_wait_queue(q, wait);
-	spin_unlock_irqrestore(&q->lock, flags);
-}
-
-EXPORT_SYMBOL(add_wait_queue);
-
-void fastcall add_wait_queue_exclusive(wait_queue_head_t *q, wait_queue_t * wait)
-{
-	unsigned long flags;
-
-	wait->flags |= WQ_FLAG_EXCLUSIVE;
-	spin_lock_irqsave(&q->lock, flags);
-	__add_wait_queue_tail(q, wait);
-	spin_unlock_irqrestore(&q->lock, flags);
-}
-
-EXPORT_SYMBOL(add_wait_queue_exclusive);
-
-void fastcall remove_wait_queue(wait_queue_head_t *q, wait_queue_t * wait)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&q->lock, flags);
-	__remove_wait_queue(q, wait);
-	spin_unlock_irqrestore(&q->lock, flags);
-}
-
-EXPORT_SYMBOL(remove_wait_queue);
-
-
-/*
- * Note: we use "set_current_state()" _after_ the wait-queue add,
- * because we need a memory barrier there on SMP, so that any
- * wake-function that tests for the wait-queue being active
- * will be guaranteed to see waitqueue addition _or_ subsequent
- * tests in this thread will see the wakeup having taken place.
- *
- * The spin_unlock() itself is semi-permeable and only protects
- * one way (it only protects stuff inside the critical region and
- * stops them from bleeding out - it would still allow subsequent
- * loads to move into the the critical region).
- */
-void fastcall prepare_to_wait(wait_queue_head_t *q, wait_queue_t *wait, int state)
-{
-	unsigned long flags;
-
-	wait->flags &= ~WQ_FLAG_EXCLUSIVE;
-	spin_lock_irqsave(&q->lock, flags);
-	if (list_empty(&wait->task_list))
-		__add_wait_queue(q, wait);
-	/*
-	 * don't alter the task state if this is just going to
-	 * queue an async wait queue callback
-	 */
-	if (is_sync_wait(wait))
-		set_current_state(state);
-	spin_unlock_irqrestore(&q->lock, flags);
-}
-
-EXPORT_SYMBOL(prepare_to_wait);
-
-void fastcall
-prepare_to_wait_exclusive(wait_queue_head_t *q, wait_queue_t *wait, int state)
-{
-	unsigned long flags;
-
-	wait->flags |= WQ_FLAG_EXCLUSIVE;
-	spin_lock_irqsave(&q->lock, flags);
-	if (list_empty(&wait->task_list))
-		__add_wait_queue_tail(q, wait);
-	/*
-	 * don't alter the task state if this is just going to
- 	 * queue an async wait queue callback
-	 */
-	if (is_sync_wait(wait))
-		set_current_state(state);
-	spin_unlock_irqrestore(&q->lock, flags);
-}
-
-EXPORT_SYMBOL(prepare_to_wait_exclusive);
-
-void fastcall finish_wait(wait_queue_head_t *q, wait_queue_t *wait)
-{
-	unsigned long flags;
-
-	__set_current_state(TASK_RUNNING);
-	/*
-	 * We can check for list emptiness outside the lock
-	 * IFF:
-	 *  - we use the "careful" check that verifies both
-	 *    the next and prev pointers, so that there cannot
-	 *    be any half-pending updates in progress on other
-	 *    CPU's that we haven't seen yet (and that might
-	 *    still change the stack area.
-	 * and
-	 *  - all other users take the lock (ie we can only
-	 *    have _one_ other CPU that looks at or modifies
-	 *    the list).
-	 */
-	if (!list_empty_careful(&wait->task_list)) {
-		spin_lock_irqsave(&q->lock, flags);
-		list_del_init(&wait->task_list);
-		spin_unlock_irqrestore(&q->lock, flags);
-	}
-}
-
-EXPORT_SYMBOL(finish_wait);
-
-int autoremove_wake_function(wait_queue_t *wait, unsigned mode, int sync, void *key)
-{
-	int ret = default_wake_function(wait, mode, sync, key);
-
-	if (ret)
-		list_del_init(&wait->task_list);
-	return ret;
-}
-
-EXPORT_SYMBOL(autoremove_wake_function);
-
 void __init fork_init(unsigned long mempages)
 {
 #ifndef __HAVE_ARCH_TASK_STRUCT_ALLOCATOR
