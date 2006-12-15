Return-Path: <linux-kernel-owner+w=401wt.eu-S1030320AbWLOWyM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030320AbWLOWyM (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 17:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030323AbWLOWyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 17:54:11 -0500
Received: from smtp.osdl.org ([65.172.181.25]:51799 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030320AbWLOWyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 17:54:09 -0500
Date: Fri, 15 Dec 2006 14:45:25 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       "David S. Miller" <davem@davemloft.net>, matthew@wil.cx,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/2] WorkStruct: Add assign_bits() to give an atomic-bitops
 safe assignment
In-Reply-To: <457F606B.70805@yahoo.com.au>
Message-ID: <Pine.LNX.4.64.0612151437130.3849@woody.osdl.org>
References: <20061212201112.29817.22041.stgit@warthog.cambridge.redhat.com>
 <20061212225443.GA25902@flint.arm.linux.org.uk> <Pine.LNX.4.64.0612121726150.3535@woody.osdl.org>
 <457F606B.70805@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 13 Dec 2006, Nick Piggin wrote:
> Linus Torvalds wrote:
> > 
> > On Tue, 12 Dec 2006, Russell King wrote:
> > > 
> > > Why can't we just use atomic_t for this?
> > 
> > 
> > Well, others have answered that ("wrong sizes"), but I'm wavering on using
> > atomic_long_t. I have to admit that I'd rather not add a new accessor
> > function, when it _should_ be easier to use the current ones.
> 
> I agree.

Ok, nobody ever did anything about this, so here's my try.

This uses "atomic_long_t" for the workstruct "data" field, which shares 
the per-cpu pointer and the workstruct flag bits in one field.

This ONLY works if "atomic_set()" is actually atomic wrt the atomic bit 
operations too, which is generally true on any architecture that does 
atomics natively (or on UP when done by disabling interrupts), but may not 
be true on architectures where atomic operations are faked with spinlocks, 
and the two different kinds of atomic ops use different spinlocks.

Right now sparc32 is one such architecture, possibly the only one. It 
would need to be fixed. Davem?

NOTE! This patch also depends on an unrealted fix that I already pushed 
out, which fixes "delayed_work_pending()" which was totally broken before 
(macro expansion would replace "work" whether it was used as a variable 
_or_ as a struct member name). If that hasn't mirrored out yet, you should 
just fix the "delayed_work_pending()" macro to look like

	#define delayed_work_pending(w) \
		work_pending(&(w)->work)

(ie use the "work_pending()" macro to do the heavy lifting, and do NOT use 
the name "work" for the macro argument).

This is untested, other than to see that it compiles. It all looks very 
obvious, but then, all my code always does, yet somehow bugs still creep 
in occasionally. I personally suspect it's some really subtle SMTP bug 
that corrupts my patches, but I've never caught it outright. 

Anyway. It's bug-free-by-definition, since it's written by yours truly, 
but people should probably test it and comment on it, in the unlikely 
event that the evil gnomes lurking in the intarnet tubes corrupt it.

Comments?

			Linus
---
diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 5b13dcf..2a7b38d 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -8,16 +8,21 @@
 #include <linux/timer.h>
 #include <linux/linkage.h>
 #include <linux/bitops.h>
+#include <asm/atomic.h>
 
 struct workqueue_struct;
 
 struct work_struct;
 typedef void (*work_func_t)(struct work_struct *work);
 
+/*
+ * The first word is the work queue pointer and the flags rolled into
+ * one
+ */
+#define work_data_bits(work) ((unsigned long *)(&(work)->data))
+
 struct work_struct {
-	/* the first word is the work queue pointer and the flags rolled into
-	 * one */
-	unsigned long management;
+	atomic_long_t data;
 #define WORK_STRUCT_PENDING 0		/* T if work item pending execution */
 #define WORK_STRUCT_NOAUTOREL 1		/* F if work item automatically released on exec */
 #define WORK_STRUCT_FLAG_MASK (3UL)
@@ -26,6 +31,9 @@ struct work_struct {
 	work_func_t func;
 };
 
+#define WORK_DATA_INIT(autorelease) \
+	ATOMIC_LONG_INIT((autorelease) << WORK_STRUCT_NOAUTOREL)
+
 struct delayed_work {
 	struct work_struct work;
 	struct timer_list timer;
@@ -36,13 +44,13 @@ struct execute_work {
 };
 
 #define __WORK_INITIALIZER(n, f) {				\
-	.management = 0,					\
+	.data = WORK_DATA_INIT(0),				\
         .entry	= { &(n).entry, &(n).entry },			\
 	.func = (f),						\
 	}
 
 #define __WORK_INITIALIZER_NAR(n, f) {				\
-	.management = (1 << WORK_STRUCT_NOAUTOREL),		\
+	.data = WORK_DATA_INIT(1),				\
         .entry	= { &(n).entry, &(n).entry },			\
 	.func = (f),						\
 	}
@@ -82,17 +90,21 @@ struct execute_work {
 
 /*
  * initialize all of a work item in one go
+ *
+ * NOTE! No point in using "atomic_long_set()": useing a direct
+ * assignment of the work data initializer allows the compiler
+ * to generate better code.
  */
 #define INIT_WORK(_work, _func)					\
 	do {							\
-		(_work)->management = 0;			\
+		(_work)->data = (atomic_long_t) WORK_DATA_INIT(0);	\
 		INIT_LIST_HEAD(&(_work)->entry);		\
 		PREPARE_WORK((_work), (_func));			\
 	} while (0)
 
 #define INIT_WORK_NAR(_work, _func)					\
 	do {								\
-		(_work)->management = (1 << WORK_STRUCT_NOAUTOREL);	\
+		(_work)->data = (atomic_long_t) WORK_DATA_INIT(1);	\
 		INIT_LIST_HEAD(&(_work)->entry);			\
 		PREPARE_WORK((_work), (_func));				\
 	} while (0)
@@ -114,7 +126,7 @@ struct execute_work {
  * @work: The work item in question
  */
 #define work_pending(work) \
-	test_bit(WORK_STRUCT_PENDING, &(work)->management)
+	test_bit(WORK_STRUCT_PENDING, work_data_bits(work))
 
 /**
  * delayed_work_pending - Find out whether a delayable work item is currently
@@ -143,7 +155,7 @@ struct execute_work {
  * This should also be used to release a delayed work item.
  */
 #define work_release(work) \
-	clear_bit(WORK_STRUCT_PENDING, &(work)->management)
+	clear_bit(WORK_STRUCT_PENDING, work_data_bits(work))
 
 
 extern struct workqueue_struct *__create_workqueue(const char *name,
@@ -188,7 +200,7 @@ static inline int cancel_delayed_work(struct delayed_work *work)
 
 	ret = del_timer_sync(&work->timer);
 	if (ret)
-		clear_bit(WORK_STRUCT_PENDING, &work->work.management);
+		work_release(&work->work);
 	return ret;
 }
 
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index db49886..742cbbe 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -96,13 +96,13 @@ static inline void set_wq_data(struct work_struct *work, void *wq)
 	BUG_ON(!work_pending(work));
 
 	new = (unsigned long) wq | (1UL << WORK_STRUCT_PENDING);
-	new |= work->management & WORK_STRUCT_FLAG_MASK;
-	work->management = new;
+	new |= WORK_STRUCT_FLAG_MASK & *work_data_bits(work);
+	atomic_long_set(&work->data, new);
 }
 
 static inline void *get_wq_data(struct work_struct *work)
 {
-	return (void *) (work->management & WORK_STRUCT_WQ_DATA_MASK);
+	return (void *) (atomic_long_read(&work->data) & WORK_STRUCT_WQ_DATA_MASK);
 }
 
 static int __run_work(struct cpu_workqueue_struct *cwq, struct work_struct *work)
@@ -133,7 +133,7 @@ static int __run_work(struct cpu_workqueue_struct *cwq, struct work_struct *work
 		list_del_init(&work->entry);
 		spin_unlock_irqrestore(&cwq->lock, flags);
 
-		if (!test_bit(WORK_STRUCT_NOAUTOREL, &work->management))
+		if (!test_bit(WORK_STRUCT_NOAUTOREL, work_data_bits(work)))
 			work_release(work);
 		f(work);
 
@@ -206,7 +206,7 @@ int fastcall queue_work(struct workqueue_struct *wq, struct work_struct *work)
 {
 	int ret = 0, cpu = get_cpu();
 
-	if (!test_and_set_bit(WORK_STRUCT_PENDING, &work->management)) {
+	if (!test_and_set_bit(WORK_STRUCT_PENDING, work_data_bits(work))) {
 		if (unlikely(is_single_threaded(wq)))
 			cpu = singlethread_cpu;
 		BUG_ON(!list_empty(&work->entry));
@@ -248,7 +248,7 @@ int fastcall queue_delayed_work(struct workqueue_struct *wq,
 	if (delay == 0)
 		return queue_work(wq, work);
 
-	if (!test_and_set_bit(WORK_STRUCT_PENDING, &work->management)) {
+	if (!test_and_set_bit(WORK_STRUCT_PENDING, work_data_bits(work))) {
 		BUG_ON(timer_pending(timer));
 		BUG_ON(!list_empty(&work->entry));
 
@@ -280,7 +280,7 @@ int queue_delayed_work_on(int cpu, struct workqueue_struct *wq,
 	struct timer_list *timer = &dwork->timer;
 	struct work_struct *work = &dwork->work;
 
-	if (!test_and_set_bit(WORK_STRUCT_PENDING, &work->management)) {
+	if (!test_and_set_bit(WORK_STRUCT_PENDING, work_data_bits(work))) {
 		BUG_ON(timer_pending(timer));
 		BUG_ON(!list_empty(&work->entry));
 
@@ -321,7 +321,7 @@ static void run_workqueue(struct cpu_workqueue_struct *cwq)
 		spin_unlock_irqrestore(&cwq->lock, flags);
 
 		BUG_ON(get_wq_data(work) != cwq);
-		if (!test_bit(WORK_STRUCT_NOAUTOREL, &work->management))
+		if (!test_bit(WORK_STRUCT_NOAUTOREL, work_data_bits(work)))
 			work_release(work);
 		f(work);
 
