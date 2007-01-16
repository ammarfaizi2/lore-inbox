Return-Path: <linux-kernel-owner+w=401wt.eu-S932433AbXAPG2V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932433AbXAPG2V (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 01:28:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932423AbXAPG1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 01:27:53 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:44252 "EHLO
	ecfrec.frec.bull.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932418AbXAPG1s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 01:27:48 -0500
Message-Id: <20070116063028.901814000@bull.net>
References: <20070116061516.899460000@bull.net>
User-Agent: quilt/0.45-1
Date: Tue, 16 Jan 2007 07:15:18 +0100
From: Nadia.Derbey@bull.net
To: linux-kernel@vger.kernel.org
Cc: Nadia Derbey <Nadia.Derbey@bull.net>
Subject: [RFC][PATCH 2/6] auto_tuning activation
Content-Disposition: inline; filename=auto_tuning_activation.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 02/06]

Introduces the auto-tuning activation routine

The auto-tuning routine is called by the fork kernel component


Signed-off-by: Nadia Derbey <Nadia.Derbey@bull.net>


---
 include/linux/akt.h |   50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/exit.c       |   11 +++++++++++
 kernel/fork.c       |    2 ++
 3 files changed, 63 insertions(+)

Index: linux-2.6.20-rc4/include/linux/akt.h
===================================================================
--- linux-2.6.20-rc4.orig/include/linux/akt.h	2007-01-15 14:26:24.000000000 +0100
+++ linux-2.6.20-rc4/include/linux/akt.h	2007-01-15 15:00:31.000000000 +0100
@@ -118,12 +118,22 @@ struct auto_tune {
 /*
  * Flags for a registered tunable
  */
+#define AUTO_TUNE_ENABLE  0x01
 #define TUNABLE_REGISTERED  0x02
 
 
 /*
  * When calling this routine the tunable lock should be held
  */
+static inline int is_auto_tune_enabled(struct auto_tune *tunable)
+{
+	return (tunable->flags & AUTO_TUNE_ENABLE) == AUTO_TUNE_ENABLE;
+}
+
+
+/*
+ * When calling this routine the tunable lock should be held
+ */
 static inline int is_tunable_registered(struct auto_tune *tunable)
 {
 	return (tunable->flags & TUNABLE_REGISTERED) == TUNABLE_REGISTERED;
@@ -163,6 +173,44 @@ static inline int is_tunable_registered(
 	} while (0)
 
 
+static inline void set_autotuning_routine(struct auto_tune *tunable,
+					auto_tune_fn fn)
+{
+	if (fn != NULL)
+		tunable->auto_tune = fn;
+}
+
+
+/*
+ * direction may be one of:
+ *    AKT_UP: adjust up (i.e. increase tunable value when needed)
+ *    AKT_DOWN: adjust down (i.e. decrease tunable value when needed)
+ */
+static inline int activate_auto_tuning(int direction,
+					struct auto_tune *tunable)
+{
+	int ret = 0;
+
+	BUG_ON(direction != AKT_UP && direction != AKT_DOWN);
+
+	if (tunable == NULL)
+		return 0;
+
+	spin_lock(&tunable->tunable_lck);
+
+	if (!is_auto_tune_enabled(tunable) ||
+					!is_tunable_registered(tunable)) {
+		spin_unlock(&tunable->tunable_lck);
+		return 0;
+	}
+
+	ret = tunable->auto_tune(direction, tunable);
+
+	spin_unlock(&tunable->tunable_lck);
+	return ret;
+}
+
+
 
 extern int register_tunable(struct auto_tune *);
 extern int unregister_tunable(struct auto_tune *);
@@ -173,7 +221,9 @@ extern int unregister_tunable(struct aut
 
 #define DEFINE_TUNABLE(s, thresh, min, max, tun, chk, type)
 #define set_tunable_min_max(s, min, max, type)   do { } while (0)
+#define set_autotuning_routine(s, fn)            do { } while (0)
 
+#define activate_auto_tuning(direction, tunable) ( { 0; } )
 
 #define register_tunable(a)                 0
 #define unregister_tunable(a)               0
Index: linux-2.6.20-rc4/kernel/fork.c
===================================================================
--- linux-2.6.20-rc4.orig/kernel/fork.c	2007-01-15 14:36:48.000000000 +0100
+++ linux-2.6.20-rc4/kernel/fork.c	2007-01-15 14:57:28.000000000 +0100
@@ -995,6 +995,8 @@ static struct task_struct *copy_process(
 	if ((clone_flags & CLONE_SIGHAND) && !(clone_flags & CLONE_VM))
 		return ERR_PTR(-EINVAL);
 
+	activate_auto_tuning(AKT_UP, &max_threads_akt);
+
 	retval = security_task_create(clone_flags);
 	if (retval)
 		goto fork_out;
Index: linux-2.6.20-rc4/kernel/exit.c
===================================================================
--- linux-2.6.20-rc4.orig/kernel/exit.c	2007-01-15 13:08:15.000000000 +0100
+++ linux-2.6.20-rc4/kernel/exit.c	2007-01-15 14:58:23.000000000 +0100
@@ -42,12 +42,15 @@
 #include <linux/audit.h> /* for audit_free() */
 #include <linux/resource.h>
 #include <linux/blkdev.h>
+#include <linux/akt.h>
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
 #include <asm/pgtable.h>
 #include <asm/mmu_context.h>
 
+extern struct auto_tune max_threads_akt;
+
 extern void sem_exit (void);
 
 static void exit_mm(struct task_struct * tsk);
@@ -172,6 +175,14 @@ repeat:
 
 	sched_exit(p);
 	write_unlock_irq(&tasklist_lock);
+
+	/*
+	 * nr_threads has been decremented in __unhash_process: adjust
+	 * max_threads down if needed
+	 * We do it here to avoid calling activate_auto_tuning under lock
+	 */
+	activate_auto_tuning(AKT_DOWN, &max_threads_akt);
+
 	proc_flush_task(p);
 	release_thread(p);
 	call_rcu(&p->rcu, delayed_put_task_struct);

--
