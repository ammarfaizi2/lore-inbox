Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263176AbTKYVwK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 16:52:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263189AbTKYVwK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 16:52:10 -0500
Received: from imr2.ericy.com ([198.24.6.3]:19130 "EHLO imr2.ericy.com")
	by vger.kernel.org with ESMTP id S263176AbTKYVwC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 16:52:02 -0500
From: Frederic Rossi <frederic.rossi@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16323.52821.540686.388083@localhost.localdomain>
Date: Tue, 25 Nov 2003 16:49:09 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH] AEM v0.5.1, linux-2.6.0-test9
X-Mailer: VM 7.07 under Emacs 21.1.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



AEM is an extension providing a native support for asynchronous events 
in the Linux kernel. Below a patch for the previous v0.5 fixes 
some issues when event handlers are forked.

Package: mod_aem-2.6
Version: v0.5.1

Modules+patches at: 
http://sourceforge.net/projects/aem

Changelog:
 * Fix the forked events termination procedure


Frederic





Index: aem/module/2.6.0-test9/aem-core/src/kernel/events.c
diff -u aem/module/2.6.0-test9/aem-core/src/kernel/events.c:1.1 aem/module/2.6.0-test9/aem-core/src/kernel/events.c:1.4
--- aem/module/2.6.0-test9/aem-core/src/kernel/events.c:1.1	Tue Nov 18 08:10:40 2003
+++ aem/module/2.6.0-test9/aem-core/src/kernel/events.c	Mon Nov 24 07:54:03 2003
@@ -366,13 +377,12 @@
 	REMOVE_LINKS (task);
 	task->parent = task->real_parent = adopter;
 	SET_LINKS (task);
-
+	
+	/* Post SIGCHLD */
 	spin_lock (&adopter->sighand->siglock);
 	sigaddset (&adopter->pending.signal, SIGCHLD);
 	recalc_sigpending_tsk (adopter);
 	spin_unlock (&adopter->sighand->siglock);
-
-	wake_up_process (adopter);
 }
 
 void forget_child (struct task_struct *task)
@@ -420,46 +430,61 @@
 		 * it is destroyed here.
 		 */
 		unsigned long jflags;
-		struct event_struct *evc = task->cloner;
+		struct event_struct *evc;
 		struct task_struct *root;
 
-		root = evc->root;
+		if (task->parent->pid == 1)
+			/* The parent has exited */
+			goto cleanup_events;
+		
+		/* This is the event cloner... */
+		evc = task->cloner;
+
+		/* If the process is present, the event is still present too */
+		root = task->parent;
+		if (evc->root != root)
+			/* Sanity check */
+			goto cleanup_events;
 
 		if (get_task (root)) {
-			local_bh_disable ();
-		spin_lock (&evc->lock);
+			unsigned long flags;
 
-		jflags = (evc->jargs)? evc->jargs->flags: 0;
+			local_irq_save (flags);
+			spin_lock (&evc->lock);
 
-		if (jflags && ((jflags & EVF_FORK) || (jflags & EVF_CAPSULE))) {
+			jflags = (evc->jargs)? evc->jargs->flags: 0;
+
+			if (jflags && ((jflags & EVF_FORK) || (jflags & EVF_CAPSULE))) {
 				struct job_struct *job = job_lookup (evc->jid);
 			
-				local_bh_enable ();
-			__event_dtor (evc);
-				local_bh_disable ();
+				/* Called with irq disabled -- will be changed */
+				__event_dtor (evc);
 			
-			if (jflags & EVF_NOCLDWAIT)
-				__forget_child (task);
+				if (jflags & EVF_NOCLDWAIT) {
+					__forget_child (task);
+					wake_up_process (capm);
+				}
 			
-			if (jflags & EVF_ONESHOT || (job && job->shutdown == JOB_SHUTDOWN)) {
-				__events_remove (evc, job);
-				kfree (evc);
-				goto cont;
+				if (jflags & EVF_ONESHOT || (job && job->shutdown == JOB_SHUTDOWN)) {
+					__events_remove (evc, job);
+					kfree (evc);
+					goto cont;
+				}
+			}
+			else {
+				/* The event has probably been removed by the user */
+				__forget_child (task);
+				wake_up_process (capm);
 			}
-		}
-		else {
-                        /* The event has probably been removed by the user */
-			__forget_child (task);
-		}
 
-		spin_unlock (&evc->lock);
-        cont:
-		put_task (root);
-			local_bh_enable ();
+			spin_unlock (&evc->lock);
+		cont:
+			local_irq_restore (flags);
+			put_task (root);
 		}
 	}
 
-again:
+cleanup_events:
 	spin_lock_irq (&task->evlock);
 	list_for_each (curr, &task->events) {
 		
@@ -481,7 +506,7 @@
 		job = job_hash_find (ev->jid);
 		__events_remove (ev, job);
 		kfree (ev);
-		goto again;
+		goto cleanup_events;
 	}
 
 	list_del_init (&task->events);
