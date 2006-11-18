Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755340AbWKRWz1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755340AbWKRWz1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 17:55:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755348AbWKRWz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 17:55:27 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:11952 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1755340AbWKRWzZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 17:55:25 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 1/4] swsusp: Untangle thaw_processes
Date: Sat, 18 Nov 2006 23:47:05 +0100
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, LKML <linux-kernel@vger.kernel.org>,
       Nigel Cunningham <ncunningham@linuxmail.org>
References: <200611182335.27453.rjw@sisk.pl>
In-Reply-To: <200611182335.27453.rjw@sisk.pl>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200611182347.05656.rjw@sisk.pl>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move the loop from thaw_processes() to a separate function and call it
independently for kernel threads and user space processes so that the order
of thawing tasks is clearly visible.

Drop thaw_kernel_threads() which is never used.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 include/linux/freezer.h |    6 -----
 kernel/power/process.c  |   55 +++++++++++++++++++++++++++---------------------
 2 files changed, 33 insertions(+), 28 deletions(-)

Index: linux-2.6.19-rc5-mm2/include/linux/freezer.h
===================================================================
--- linux-2.6.19-rc5-mm2.orig/include/linux/freezer.h
+++ linux-2.6.19-rc5-mm2/include/linux/freezer.h
@@ -1,8 +1,5 @@
 /* Freezer declarations */
 
-#define FREEZER_KERNEL_THREADS 0
-#define FREEZER_ALL_THREADS 1
-
 #ifdef CONFIG_PM
 /*
  * Check if a process has been frozen
@@ -60,8 +57,7 @@ static inline void frozen_process(struct
 
 extern void refrigerator(void);
 extern int freeze_processes(void);
-#define thaw_processes() do { thaw_some_processes(FREEZER_ALL_THREADS); } while(0)
-#define thaw_kernel_threads() do { thaw_some_processes(FREEZER_KERNEL_THREADS); } while(0)
+extern void thaw_processes(void);
 
 static inline int try_to_freeze(void)
 {
Index: linux-2.6.19-rc5-mm2/kernel/power/process.c
===================================================================
--- linux-2.6.19-rc5-mm2.orig/kernel/power/process.c
+++ linux-2.6.19-rc5-mm2/kernel/power/process.c
@@ -20,6 +20,8 @@
  */
 #define TIMEOUT	(20 * HZ)
 
+#define FREEZER_KERNEL_THREADS 0
+#define FREEZER_USER_SPACE 1
 
 static inline int freezeable(struct task_struct * p)
 {
@@ -79,6 +81,11 @@ static void cancel_freezing(struct task_
 	}
 }
 
+static inline int is_user_space(struct task_struct *p)
+{
+	return p->mm && !(p->flags & PF_BORROWED_MM);
+}
+
 /* 0 = success, else # of processes that we failed to stop */
 int freeze_processes(void)
 {
@@ -103,10 +110,9 @@ int freeze_processes(void)
 				cancel_freezing(p);
 				continue;
 			}
-			if (p->mm && !(p->flags & PF_BORROWED_MM)) {
-				/* The task is a user-space one.
-				 * Freeze it unless there's a vfork completion
-				 * pending
+			if (is_user_space(p)) {
+				/* Freeze the task unless there is a vfork
+				 * completion pending
 				 */
 				if (!p->vfork_done)
 					freeze_process(p);
@@ -155,31 +161,34 @@ int freeze_processes(void)
 	return 0;
 }
 
-void thaw_some_processes(int all)
+static void thaw_tasks(int thaw_user_space)
 {
 	struct task_struct *g, *p;
-	int pass = 0; /* Pass 0 = Kernel space, 1 = Userspace */
 
-	printk("Restarting tasks... ");
 	read_lock(&tasklist_lock);
-	do {
-		do_each_thread(g, p) {
-			/*
-			 * is_user = 0 if kernel thread or borrowed mm,
-			 * 1 otherwise.
-			 */
-			int is_user = !!(p->mm && !(p->flags & PF_BORROWED_MM));
-			if (!freezeable(p) || (is_user != pass))
-				continue;
-			if (!thaw_process(p))
-				printk(KERN_INFO
-					"Strange, %s not stopped\n", p->comm);
-		} while_each_thread(g, p);
-
-		pass++;
-	} while (pass < 2 && all);
+	do_each_thread(g, p) {
+		if (!freezeable(p))
+			continue;
 
+		if (is_user_space(p)) {
+			if (!thaw_user_space)
+				continue;
+		} else {
+			if (thaw_user_space)
+				continue;
+		}
+		if (!thaw_process(p))
+			printk(KERN_WARNING " Strange, %s not stopped\n",
+				p->comm );
+	} while_each_thread(g, p);
 	read_unlock(&tasklist_lock);
+}
+
+void thaw_processes(void)
+{
+	printk("Restarting tasks ... ");
+	thaw_tasks(FREEZER_KERNEL_THREADS);
+	thaw_tasks(FREEZER_USER_SPACE);
 	schedule();
 	printk("done.\n");
 }

