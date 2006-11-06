Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932784AbWKFHhz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932784AbWKFHhz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 02:37:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030257AbWKFHhz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 02:37:55 -0500
Received: from amsfep19-int.chello.nl ([213.46.243.16]:16219 "EHLO
	amsfep17-int.chello.nl") by vger.kernel.org with ESMTP
	id S932784AbWKFHhy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 02:37:54 -0500
Subject: [PATCH] debug workqueue locking sanity -v2
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       arjan <arjan@infradead.org>
In-Reply-To: <20061106072323.GC29772@elte.hu>
References: <1162758984.14695.22.camel@lappy>
	 <20061106072323.GC29772@elte.hu>
Content-Type: text/plain
Date: Mon, 06 Nov 2006 08:36:34 +0100
Message-Id: <1162798594.26989.47.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-11-06 at 08:23 +0100, Ingo Molnar wrote:
> * Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
> 
> > +		if (unlikely(in_atomic()
> > +#ifdef CONFIG_LOCKDEP
> > +			|| current->lockdep_depth > 0
> > +#endif
> > +			)) {
> 
> i agree with this patch, but shouldnt this #ifdef be hidden via some 
> sort of lockdep_depth() inline in lockdep.h that just returns 0 if 
> !LOCKDEP?

Like so.

---

Workqueue functions should not leak locks, assert so, printing the
last function ran.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
---
 include/linux/lockdep.h |   11 +++++++++++
 kernel/workqueue.c      |   12 ++++++++++++
 2 files changed, 23 insertions(+)

Index: linux-2.6-twins/kernel/workqueue.c
===================================================================
--- linux-2.6-twins.orig/kernel/workqueue.c	2006-11-05 21:22:35.000000000 +0100
+++ linux-2.6-twins/kernel/workqueue.c	2006-11-06 08:31:21.000000000 +0100
@@ -29,6 +29,7 @@
 #include <linux/kthread.h>
 #include <linux/hardirq.h>
 #include <linux/mempolicy.h>
+#include <linux/kallsyms.h>
 
 /*
  * The per-CPU workqueue (if single thread, we always use the first
@@ -222,6 +223,17 @@ static void run_workqueue(struct cpu_wor
 		clear_bit(0, &work->pending);
 		f(data);
 
+		if (unlikely(in_atomic() || lockdep_depth(current) > 0)) {
+			printk(KERN_ERR "BUG: workqueue leaked lock or atomic: "
+					"%s/0x%08x/%d\n",
+					current->comm, preempt_count(),
+				       	current->pid);
+			printk(KERN_ERR "    last function: ");
+			print_symbol("%s\n", (unsigned long)f);
+			debug_show_held_locks(current);
+			dump_stack();
+		}
+
 		spin_lock_irqsave(&cwq->lock, flags);
 		cwq->remove_sequence++;
 		wake_up(&cwq->work_done);
Index: linux-2.6-twins/include/linux/lockdep.h
===================================================================
--- linux-2.6-twins.orig/include/linux/lockdep.h	2006-11-06 08:32:25.000000000 +0100
+++ linux-2.6-twins/include/linux/lockdep.h	2006-11-06 08:32:28.000000000 +0100
@@ -243,6 +243,11 @@ extern void lock_release(struct lockdep_
 
 # define INIT_LOCKDEP				.lockdep_recursion = 0,
 
+static inline int lockdep_depth(struct task *tsk)
+{
+	return tsk->lockdep_depth;
+}
+
 #else /* !LOCKDEP */
 
 static inline void lockdep_off(void)
@@ -277,6 +282,12 @@ static inline int lockdep_internal(void)
  * The class key takes no space if lockdep is disabled:
  */
 struct lock_class_key { };
+
+static inline int lockdep_depth(struct task *tsk)
+{
+	return 0;
+}
+
 #endif /* !LOCKDEP */
 
 #if defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_GENERIC_HARDIRQS)


