Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751310AbWHBUif@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbWHBUif (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 16:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbWHBUif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 16:38:35 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:23812 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751310AbWHBUie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 16:38:34 -0400
Date: Wed, 2 Aug 2006 16:38:28 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Andrew Morton <akpm@osdl.org>, "Paul E. McKenney" <paulmck@us.ibm.com>
cc: Jesse Brandeburg <jesse.brandeburg@gmail.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] SRCU: report out-of-memory errors
In-Reply-To: <4807377b0608021257p27882866i69a5a0a4a1f05dda@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.0608021621210.8004-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the init_srcu_struct() routine has no way to report 
out-of-memory errors.  This patch (as761) makes it return -ENOMEM when the 
per-cpu data allocation fails.

The patch also makes srcu_init_notifier_head() report a BUG if a notifier
head can't be initialized.  Perhaps it should return -ENOMEM instead, but
in the most likely cases where this might occur I don't think any recovery
is possible.  Notifier chains generally are not created dynamically.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

Paul, I trust you will agree with the changes this makes to the SRCU code.

The second part of this patch series will convert the cpufreq transition 
notifier chain to use SRCU, with the initialization occuring in a 
core_initcall routine.  Although I haven't actually tried it, it seems 
very likely that an attempt to use the notifier chain before it has been 
initialized will cause a memory-address fault.

Alan Stern


Index: 2.6.18-rc2-mm1/kernel/sys.c
===================================================================
--- 2.6.18-rc2-mm1.orig/kernel/sys.c
+++ 2.6.18-rc2-mm1/kernel/sys.c
@@ -516,7 +516,7 @@ EXPORT_SYMBOL_GPL(srcu_notifier_call_cha
 void srcu_init_notifier_head(struct srcu_notifier_head *nh)
 {
 	mutex_init(&nh->mutex);
-	init_srcu_struct(&nh->srcu);
+	BUG_ON(init_srcu_struct(&nh->srcu) < 0);
 	nh->head = NULL;
 }
 
Index: 2.6.18-rc2-mm1/kernel/srcu.c
===================================================================
--- 2.6.18-rc2-mm1.orig/kernel/srcu.c
+++ 2.6.18-rc2-mm1/kernel/srcu.c
@@ -42,11 +42,12 @@
  * to any other function.  Each srcu_struct represents a separate domain
  * of SRCU protection.
  */
-void init_srcu_struct(struct srcu_struct *sp)
+int init_srcu_struct(struct srcu_struct *sp)
 {
 	sp->completed = 0;
-	sp->per_cpu_ref = alloc_percpu(struct srcu_struct_array);
 	mutex_init(&sp->mutex);
+	sp->per_cpu_ref = alloc_percpu(struct srcu_struct_array);
+	return (sp->per_cpu_ref ? 0 : -ENOMEM);
 }
 
 /*
Index: 2.6.18-rc2-mm1/include/linux/srcu.h
===================================================================
--- 2.6.18-rc2-mm1.orig/include/linux/srcu.h
+++ 2.6.18-rc2-mm1/include/linux/srcu.h
@@ -43,7 +43,7 @@ struct srcu_struct {
 #define srcu_barrier()
 #endif /* #else #ifndef CONFIG_PREEMPT */
 
-void init_srcu_struct(struct srcu_struct *sp);
+int init_srcu_struct(struct srcu_struct *sp);
 void cleanup_srcu_struct(struct srcu_struct *sp);
 int srcu_read_lock(struct srcu_struct *sp);
 void srcu_read_unlock(struct srcu_struct *sp, int idx);

