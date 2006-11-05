Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161714AbWKEUhN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161714AbWKEUhN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 15:37:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161719AbWKEUgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 15:36:49 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.15]:36823 "EHLO
	amsfep19-int.chello.nl") by vger.kernel.org with ESMTP
	id S1161717AbWKEUgf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 15:36:35 -0500
Subject: [PATCH] debug workqueue locking sanity
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, arjan <arjan@infradead.org>
Content-Type: text/plain
Date: Sun, 05 Nov 2006 21:36:23 +0100
Message-Id: <1162758984.14695.22.camel@lappy>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Workqueue functions should not leak locks, assert so, printing the
last function ran.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
---
 kernel/workqueue.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

Index: linux-2.6-twins/kernel/workqueue.c
===================================================================
--- linux-2.6-twins.orig/kernel/workqueue.c	2006-11-05 21:04:13.000000000 +0100
+++ linux-2.6-twins/kernel/workqueue.c	2006-11-05 21:16:05.000000000 +0100
@@ -29,6 +29,7 @@
 #include <linux/kthread.h>
 #include <linux/hardirq.h>
 #include <linux/mempolicy.h>
+#include <linux/kallsyms.h>
 
 /*
  * The per-CPU workqueue (if single thread, we always use the first
@@ -222,6 +223,21 @@ static void run_workqueue(struct cpu_wor
 		clear_bit(0, &work->pending);
 		f(data);
 
+		if (unlikely(in_atomic()
+#ifdef CONFIG_LOCKDEP
+			|| current->lockdep_depth > 0
+#endif
+			)) {
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


