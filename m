Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932236AbWAZDuN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236AbWAZDuN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 22:50:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbWAZDtp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 22:49:45 -0500
Received: from [202.53.187.9] ([202.53.187.9]:19435 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S932235AbWAZDtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 22:49:19 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [ 09/23] [Suspend2] Quieten the freezer for normal operation.
Date: Thu, 26 Jan 2006 13:45:46 +1000
To: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
Message-Id: <20060126034545.3178.72508.stgit@localhost.localdomain>
In-Reply-To: <20060126034518.3178.55397.stgit@localhost.localdomain>
References: <20060126034518.3178.55397.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Quieten the freezer by replacing printks with a local #define
that can be enabled if and when debugging is needed.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/process.c |   19 +++++++++++++------
 1 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/kernel/power/process.c b/kernel/power/process.c
index 6da0445..09fc9ca 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -33,6 +33,13 @@
 #include <linux/suspend.h>
 #include <linux/module.h>
 
+#if 0
+//#ifdef CONFIG_PM_DEBUG
+#define freezer_message(msg, a...) do { printk(msg, ##a); } while(0)
+#else
+#define freezer_message(msg, a...) do { } while(0)
+#endif
+
 /* 
  * Timeout for stopping processes
  */
@@ -67,7 +74,7 @@ static int freeze_process(struct notifie
 	current->flags |= PF_FROZEN;
 	notifier_chain_unregister(&current->todo, nl);
 	kfree(nl);
-	printk("=");
+	freezer_message("=");
 
 	spin_lock_irq(&current->sighand->siglock);
 	recalc_sigpending(); /* We sent fake signal, clean it up */
@@ -84,11 +91,11 @@ static int freeze_process(struct notifie
 
 void thaw_processes(void)
 {
-	printk("Restarting tasks..");
+	freezer_message("Restarting tasks..");
 	complete_all(&thaw);
 	while (atomic_read(&nr_frozen) > 0)
 		schedule();
-	printk("done\n");
+	freezer_message("done\n");
 }
 
 static inline void freeze(struct task_struct *p)
@@ -127,7 +134,7 @@ int freeze_processes(void)
 	atomic_set(&nr_frozen, 0);
 	INIT_COMPLETION(thaw);
 
-	printk("Stopping tasks: ");
+	freezer_message("Stopping tasks: ");
 	start_time = jiffies;
 	do {
 		todo = 0;
@@ -142,7 +149,7 @@ int freeze_processes(void)
 		read_unlock(&tasklist_lock);
 		yield();			/* Yield is okay here */
 		if (todo && time_after(jiffies, start_time + TIMEOUT)) {
-			printk("\n");
+			freezer_message("\n");
 			printk(KERN_ERR " stopping tasks failed"
 					"(%d tasks remaining)\n",
 					todo - atomic_read(&nr_frozen));
@@ -151,7 +158,7 @@ int freeze_processes(void)
 		}
 	} while (atomic_read(&nr_frozen) < todo);
 
-	printk("|\n");
+	freezer_message("|\n");
 	BUG_ON(in_atomic());
 	return 0;
 }

--
Nigel Cunningham		nigel at suspend2 dot net
