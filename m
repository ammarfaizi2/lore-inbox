Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751664AbWBEJQT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751664AbWBEJQT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 04:16:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751684AbWBEJQT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 04:16:19 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:11428 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751592AbWBEJQT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 04:16:19 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH -mm] swsusp: freeze user space processes first
Date: Sun, 5 Feb 2006 10:14:43 +0100
User-Agent: KMail/1.9.1
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>,
       Nigel Cunningham <nigel@suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602051014.43938.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch allows swsusp to freeze processes successfully under heavy load
by freezing userspace processes before kernel threads.

[Thanks to Nigel Cunningham <nigel@suspend2.net> for suggesting the
way to go.]

Please consider for applying.

Greetings,
Rafael


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Pavel Machek <pavel@suse.cz>

 kernel/power/disk.c    |    1 
 kernel/power/process.c |   61 ++++++++++++++++++++++++++++++++++++-------------
 kernel/power/user.c    |    1 
 3 files changed, 46 insertions(+), 17 deletions(-)

Index: linux-2.6.16-rc1-mm5/kernel/power/process.c
===================================================================
--- linux-2.6.16-rc1-mm5.orig/kernel/power/process.c
+++ linux-2.6.16-rc1-mm5/kernel/power/process.c
@@ -12,11 +12,12 @@
 #include <linux/interrupt.h>
 #include <linux/suspend.h>
 #include <linux/module.h>
+#include <linux/syscalls.h>
 
 /* 
  * Timeout for stopping processes
  */
-#define TIMEOUT	(6 * HZ)
+#define TIMEOUT	(20 * HZ)
 
 
 static inline int freezeable(struct task_struct * p)
@@ -54,38 +55,62 @@ void refrigerator(void)
 	current->state = save;
 }
 
+static inline void freeze_process(struct task_struct *p)
+{
+	unsigned long flags;
+
+	if (!freezing(p)) {
+		freeze(p);
+		spin_lock_irqsave(&p->sighand->siglock, flags);
+		signal_wake_up(p, 0);
+		spin_unlock_irqrestore(&p->sighand->siglock, flags);
+	}
+}
+
 /* 0 = success, else # of processes that we failed to stop */
 int freeze_processes(void)
 {
-	int todo;
+	int todo, nr_user, user_frozen;
 	unsigned long start_time;
 	struct task_struct *g, *p;
 	unsigned long flags;
 
 	printk( "Stopping tasks: " );
 	start_time = jiffies;
+	user_frozen = 0;
 	do {
-		todo = 0;
+		nr_user = todo = 0;
 		read_lock(&tasklist_lock);
 		do_each_thread(g, p) {
 			if (!freezeable(p))
 				continue;
 			if (frozen(p))
 				continue;
-
-			freeze(p);
-			spin_lock_irqsave(&p->sighand->siglock, flags);
-			signal_wake_up(p, 0);
-			spin_unlock_irqrestore(&p->sighand->siglock, flags);
-			todo++;
+			if (p->mm && !(p->flags & PF_BORROWED_MM)) {
+				/* The task is a user-space one.
+				 * Freeze it unless there's a vfork completion
+				 * pending
+				 */
+				if (!p->vfork_done)
+					freeze_process(p);
+				nr_user++;
+			} else {
+				/* Freeze only if the user space is frozen */
+				if (user_frozen)
+					freeze_process(p);
+				todo++;
+			}
 		} while_each_thread(g, p);
 		read_unlock(&tasklist_lock);
+		todo += nr_user;
+		if (!user_frozen && !nr_user) {
+			sys_sync();
+			start_time = jiffies;
+		}
+		user_frozen = !nr_user;
 		yield();			/* Yield is okay here */
-		if (todo && time_after(jiffies, start_time + TIMEOUT)) {
-			printk( "\n" );
-			printk(KERN_ERR " stopping tasks timed out (%d tasks remaining)\n", todo );
+		if (todo && time_after(jiffies, start_time + TIMEOUT))
 			break;
-		}
 	} while(todo);
 
 	/* This does not unfreeze processes that are already frozen
@@ -94,8 +119,14 @@ int freeze_processes(void)
 	 * but it cleans up leftover PF_FREEZE requests.
 	 */
 	if (todo) {
+		printk( "\n" );
+		printk(KERN_ERR " stopping tasks timed out "
+			"after %d seconds (%d tasks remaining):\n",
+			TIMEOUT / HZ, todo);
 		read_lock(&tasklist_lock);
-		do_each_thread(g, p)
+		do_each_thread(g, p) {
+			if (freezeable(p) && !frozen(p))
+				printk(KERN_ERR "  %s\n", p->comm);
 			if (freezing(p)) {
 				pr_debug("  clean up: %s\n", p->comm);
 				p->flags &= ~PF_FREEZE;
@@ -103,7 +134,7 @@ int freeze_processes(void)
 				recalc_sigpending_tsk(p);
 				spin_unlock_irqrestore(&p->sighand->siglock, flags);
 			}
-		while_each_thread(g, p);
+		} while_each_thread(g, p);
 		read_unlock(&tasklist_lock);
 		return todo;
 	}
Index: linux-2.6.16-rc1-mm5/kernel/power/disk.c
===================================================================
--- linux-2.6.16-rc1-mm5.orig/kernel/power/disk.c
+++ linux-2.6.16-rc1-mm5/kernel/power/disk.c
@@ -73,7 +73,6 @@ static int prepare_processes(void)
 	int error;
 
 	pm_prepare_console();
-	sys_sync();
 	disable_nonboot_cpus();
 
 	if (freeze_processes()) {
Index: linux-2.6.16-rc1-mm5/kernel/power/user.c
===================================================================
--- linux-2.6.16-rc1-mm5.orig/kernel/power/user.c
+++ linux-2.6.16-rc1-mm5/kernel/power/user.c
@@ -137,7 +137,6 @@ static int snapshot_ioctl(struct inode *
 	case SNAPSHOT_FREEZE:
 		if (data->frozen)
 			break;
-		sys_sync();
 		down(&pm_sem);
 		pm_prepare_console();
 		disable_nonboot_cpus();
