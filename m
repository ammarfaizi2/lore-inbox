Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161471AbWJUMWs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161471AbWJUMWs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 08:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161470AbWJUMWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 08:22:47 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:41696 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1161471AbWJUMWq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 08:22:46 -0400
Subject: [PATCH] Quieten freezer if !CONFIG_PM_DEBUG.
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: Linux PM <linux-pm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       suspend2-devel <suspend2-devel@lists.suspend2.net>
Content-Type: text/plain
Date: Sat, 21 Oct 2006 22:22:43 +1000
Message-Id: <1161433364.7644.9.camel@nigel.suspend2.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The freezing of processes is currently very noisy. This patch makes the
noise dependant upon CONFIG_PM_DEBUG.

Prepared against current git.
    
Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

diff --git a/kernel/power/process.c b/kernel/power/process.c
index 29be608..6829612 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -15,6 +15,12 @@ #include <linux/module.h>
 #include <linux/syscalls.h>
 #include <linux/freezer.h>
 
+#ifdef CONFIG_PM_DEBUG
+#define freezer_message(msg, a...) do { printk(msg, ##a); } while(0)
+#else
+#define freezer_message(msg, a...) do { } while(0)
+#endif
+
 /* 
  * Timeout for stopping processes
  */
@@ -40,7 +46,7 @@ void refrigerator(void)
 	long save;
 	save = current->state;
 	pr_debug("%s entered refrigerator\n", current->comm);
-	printk("=");
+	freezer_message("=");
 
 	frozen_process(current);
 	spin_lock_irq(&current->sighand->siglock);
@@ -87,7 +93,7 @@ int freeze_processes(void)
 	unsigned long start_time;
 	struct task_struct *g, *p;
 
-	printk( "Stopping tasks: " );
+	freezer_message( "Stopping tasks: " );
 	start_time = jiffies;
 	user_frozen = 0;
 	do {
@@ -135,7 +141,7 @@ int freeze_processes(void)
 	 * but it cleans up leftover PF_FREEZE requests.
 	 */
 	if (todo) {
-		printk( "\n" );
+		freezer_message( "\n" );
 		printk(KERN_ERR " stopping tasks timed out "
 			"after %d seconds (%d tasks remaining):\n",
 			TIMEOUT / HZ, todo);
@@ -149,7 +155,7 @@ int freeze_processes(void)
 		return todo;
 	}
 
-	printk( "|\n" );
+	freezer_message( "|\n" );
 	BUG_ON(in_atomic());
 	return 0;
 }
@@ -158,18 +164,18 @@ void thaw_processes(void)
 {
 	struct task_struct *g, *p;
 
-	printk( "Restarting tasks..." );
+	freezer_message( "Restarting tasks..." );
 	read_lock(&tasklist_lock);
 	do_each_thread(g, p) {
 		if (!freezeable(p))
 			continue;
 		if (!thaw_process(p))
-			printk(KERN_INFO " Strange, %s not stopped\n", p->comm );
+			freezer_message(KERN_INFO " Strange, %s not stopped\n", p->comm );
 	} while_each_thread(g, p);
 
 	read_unlock(&tasklist_lock);
 	schedule();
-	printk( " done\n" );
+	freezer_message( " done\n" );
 }
 
 EXPORT_SYMBOL(refrigerator);


