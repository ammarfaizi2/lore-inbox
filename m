Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264553AbTLQUww (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 15:52:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264557AbTLQUwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 15:52:43 -0500
Received: from imr1.ericy.com ([198.24.6.9]:28843 "EHLO imr1.ericy.com")
	by vger.kernel.org with ESMTP id S264553AbTLQUwd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 15:52:33 -0500
From: Frederic Rossi <frederic.rossi@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16352.49508.688996.531904@localhost.localdomain>
Date: Wed, 17 Dec 2003 15:49:40 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH] AEM v0.5.2, kernel 2.6.0-test9
X-Mailer: VM 7.07 under Emacs 21.1.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


AEM (Asynchronous Event Mechanism) is an extension providing a native 
support for asynchronous events in the Linux kernel. 

Pathes and updates for the v0.5.x are mostly to cleanup, correct and fix
bugs for forked event handlers. Below is a diff for v0.5.1.

Package: mod_aem-2.6
Version: v0.5.2

Modules+patches at: 
http://sourceforge.net/projects/aem

Major changes:
 * Fix alignment during process frame copy
 * Fix the wait for zombies in the capsule manager
 * Fix for concurrent event activations occuring 
   while holding event locks

Frederic









Index: aem/module/2.6.0-test9//aem-core/src/arch/events.c
===================================================================
RCS file: /cvsroot/aem/aem/module/2.6.0-test9/aem-core/src/arch/events.c,v
retrieving revision 1.1
retrieving revision 1.3
diff -B -b -w -u -r1.1 -r1.3
--- aem/module/2.6.0-test9//aem-core/src/arch/events.c	18 Nov 2003 16:10:01 -0000	1.1
+++ aem/module/2.6.0-test9//aem-core/src/arch/events.c	10 Dec 2003 14:06:57 -0000	1.3
@@ -39,6 +39,12 @@
  *  ----------------
  *
  * $Log$
+ * Revision 1.3  2003/12/10 14:06:57  fjrossi
+ * Fix frame copy for forked handlers
+ *
+ * Revision 1.2  2003/11/27 16:12:44  fjrossi
+ * Fix in copy_vmt()
+ *
  * Revision 1.1  2003/11/18 16:10:01  fjrossi
  * Added
  *
@@ -458,8 +464,8 @@
 			capframe = (unsigned long )page_address (stackpage) + (capesp & ~PAGE_MASK);
 			framesz = (int )((ulong)frame - newesp);
 			capframe -= framesz;
-			memcpy ((void *)capframe, (void *)(newesp), framesz*sizeof (unsigned long));
- 			capregs->esp -= framesz & -8ul; 
+			memcpy ((void *)capframe, (void *)(newesp), framesz);
+ 			capregs->esp -= framesz;
 			
 			start_capsule (cap);
 			err = 0;
Index: aem/module/2.6.0-test9//aem-core/src/kernel/capsule.c
===================================================================
RCS file: /cvsroot/aem/aem/module/2.6.0-test9/aem-core/src/kernel/capsule.c,v
retrieving revision 1.1
retrieving revision 1.3
diff -B -b -w -u -r1.1 -r1.3
--- aem/module/2.6.0-test9//aem-core/src/kernel/capsule.c	18 Nov 2003 16:10:35 -0000	1.1
+++ aem/module/2.6.0-test9//aem-core/src/kernel/capsule.c	10 Dec 2003 13:00:58 -0000	1.3
@@ -161,6 +161,8 @@
 #define switch_list(n)  (((n) + 1) % 2)
 #define end_of_list(n)  ((caps[(n)].free==CAPSULE_NB) && !(caps[(n)].free=0))
 
+atomic_t caps_init = ATOMIC_INIT(0);
+
 int capsule_run (void)
 {
 	spin_lock (&lock_qe);
@@ -190,15 +192,11 @@
 
 	while (1) {
 
-		set_task_state (capm, TASK_INTERRUPTIBLE);
-		add_wait_queue (&capsule_wq, &wq);
-		
-		schedule ();
-		
-		remove_wait_queue (&capsule_wq, &wq);
-		
 		if (signal_pending (capm)) {
 
+			if (sigismember (&(capm->pending.signal), SIGCHLD))
+				while (waitpid (-1, NULL, __WALL|WNOHANG) != -1);
+			
 			if (sigismember (&(capm->pending.signal), SIGKILL) ||
 			    sigismember (&(capm->pending.signal), SIGQUIT) ||
 			    sigismember (&(capm->pending.signal), SIGTERM) ||
@@ -203,18 +201,17 @@
 			    sigismember (&(capm->pending.signal), SIGQUIT) ||
 			    sigismember (&(capm->pending.signal), SIGTERM) ||
 			    sigismember (&(capm->pending.signal), SIGINT))
-
 				break;
 
-			while (waitpid (-1, NULL, __WALL|WNOHANG) > 0)
-					;
-			
 			flush_signals (capm);
-			spin_lock_irq (&capm->sighand->siglock);
-			recalc_sigpending_tsk (capm);
-			spin_unlock_irq (&capm->sighand->siglock);
 		}
 
+		set_task_state (capm, TASK_INTERRUPTIBLE);
+		add_wait_queue (&capsule_wq, &wq);
+		schedule ();
+		remove_wait_queue (&capsule_wq, &wq);
+
+		if (atomic_read (&caps_init))
 		schedule_work (&capsule_qe);
 	}
 
@@ -275,8 +272,14 @@
 {
 	unsigned int backlist;
 
+	spin_lock_irq (&capslock);
+	
 	backlist = switch_list (capscurr);
 	capsule_list_init (&caps[backlist]);
+	
+	atomic_dec (&caps_init);
+	
+	spin_unlock_irq (&capslock);
 }
 
 static capsule_t *find_free_capsule (void)
@@ -289,7 +292,12 @@
 
 	if (end_of_list (capscurr)) {
 		capscurr = switch_list (capscurr);
+		
+		atomic_inc (&caps_init);
+		if (atomic_read (&caps_init)==1)
 		capsule_run ();
+		else
+			atomic_dec (&caps_init);
 	}
 	
 	this = &caps[capscurr];
Index: aem/module/2.6.0-test9//aem-core/src/kernel/events.c
===================================================================
RCS file: /cvsroot/aem/aem/module/2.6.0-test9/aem-core/src/kernel/events.c,v
retrieving revision 1.4
retrieving revision 1.6
diff -B -b -w -u -r1.4 -r1.6
--- aem/module/2.6.0-test9//aem-core/src/kernel/events.c	24 Nov 2003 15:54:03 -0000	1.4
+++ aem/module/2.6.0-test9//aem-core/src/kernel/events.c	10 Dec 2003 18:33:38 -0000	1.6
@@ -38,6 +38,15 @@
  *  ----------------
  *
  * $Log$
+ * Revision 1.6  2003/12/10 18:33:38  fjrossi
+ * ev->reactivate must be initialized outside of the locks
+ * to prevent jobs to access the task event list.
+ *
+ * Revision 1.5  2003/12/10 14:18:50  fjrossi
+ * Check of concurrent activations occuring
+ * while holding event locks. Fix reactivation
+ * of events.
+ *
  * Revision 1.4  2003/11/24 15:54:03  fjrossi
  * Fixed forked events termination
  *
@@ -312,15 +321,18 @@
 
 		task->keep_alive = 0;
 
+		spin_unlock (&ev->lock);
+
                 /* 
 		 * Check if concurrent activations occured 
 		 * while holding the lock 
 		 */
+		spin_lock_irqsave (&task->evlock, flags);
+		spin_lock (&ev->lock);
 		if (atomic_read (&ev->reactivate) > 1 && list_empty (&ev->active))
 			list_add_tail (&ev->active, &task->active);
-		
 		spin_unlock (&ev->lock);
-
+		spin_unlock_irqrestore (&task->evlock, flags);
 		atomic_set (&ev->reactivate, 0);
 
 		goto out;
Index: aem/module/2.6.0-test9//aem-core/src/kernel/job.c
===================================================================
RCS file: /cvsroot/aem/aem/module/2.6.0-test9/aem-core/src/kernel/job.c,v
retrieving revision 1.1
retrieving revision 1.2
diff -B -b -w -u -r1.1 -r1.2
--- aem/module/2.6.0-test9//aem-core/src/kernel/job.c	18 Nov 2003 16:10:45 -0000	1.1
+++ aem/module/2.6.0-test9//aem-core/src/kernel/job.c	27 Nov 2003 16:05:44 -0000	1.2
@@ -38,6 +38,9 @@
  *  ----------------
  *
  *  $Log$
+ *  Revision 1.2  2003/11/27 16:05:44  fjrossi
+ *  Fix lock in the job scheduler
+ *
  *  Revision 1.1  2003/11/18 16:10:45  fjrossi
  *  Added
  *
@@ -177,7 +180,7 @@
 		if (!jb)
 			continue;
 
-		simple_rlock_job (jb);
+		simple_wlock_job (jb);
 
 		if (jb->limit == JOB_SCHED_NO_SCHED)
 			goto cont;
@@ -220,7 +223,7 @@
 		spin_unlock (&Jqueue_lock);
 		
 	cont:
-		simple_runlock_job (jb);
+		simple_wunlock_job (jb);
 	}
 
 	spin_unlock_irq (&Dqueue_lock);
