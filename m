Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750907AbWJVXsU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750907AbWJVXsU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 19:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750894AbWJVXsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 19:48:20 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:7359 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1750907AbWJVXsT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 19:48:19 -0400
Subject: [PATCH] Thaw userspace and kernel space separately.
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: Andrew Morton <akpm@osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 23 Oct 2006 09:48:16 +1000
Message-Id: <1161560896.7438.67.camel@nigel.suspend2.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Modify process thawing so that we can thaw kernel space without thawing
userspace, and thaw kernelspace first. This will be useful in later
patches, where I intend to get swsusp thawing kernel threads only before
seeking to free memory.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

diff --git a/include/linux/freezer.h b/include/linux/freezer.h
index 266373f..294ebea 100644
--- a/include/linux/freezer.h
+++ b/include/linux/freezer.h
@@ -1,5 +1,8 @@
 /* Freezer declarations */
 
+#define FREEZER_KERNEL_THREADS 0
+#define FREEZER_ALL_THREADS 1
+
 #ifdef CONFIG_PM
 /*
  * Check if a process has been frozen
@@ -57,7 +60,8 @@ static inline void frozen_process(struct
 
 extern void refrigerator(void);
 extern int freeze_processes(void);
-extern void thaw_processes(void);
+#define thaw_processes() do { thaw_some_processes(FREEZER_ALL_THREADS); } while(0)
+#define thaw_kernel_threads() do { thaw_some_processes(FREEZER_KERNEL_THREADS); } while(0)
 
 static inline int try_to_freeze(void)
 {
@@ -67,6 +71,9 @@ static inline int try_to_freeze(void)
 	} else
 		return 0;
 }
+
+extern void thaw_some_processes(int all);
+
 #else
 static inline int frozen(struct task_struct *p) { return 0; }
 static inline int freezing(struct task_struct *p) { return 0; }
diff --git a/kernel/power/process.c b/kernel/power/process.c
index fedabad..4a001fe 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -153,18 +153,29 @@ int freeze_processes(void)
 	return 0;
 }
 
-void thaw_processes(void)
+void thaw_some_processes(int all)
 {
 	struct task_struct *g, *p;
+	int pass = 0; /* Pass 0 = Kernel space, 1 = Userspace */
 
 	printk("Restarting tasks... ");
 	read_lock(&tasklist_lock);
-	do_each_thread(g, p) {
-		if (!freezeable(p))
-			continue;
-		if (!thaw_process(p))
-			printk(KERN_INFO "Strange, %s not stopped\n", p->comm);
-	} while_each_thread(g, p);
+	do {
+		do_each_thread(g, p) {
+			/* 
+			 * is_user = 0 if kernel thread or borrowed mm,
+			 * 1 otherwise.
+			 */
+			int is_user = !!(p->mm && !(p->flags & PF_BORROWED_MM));
+			if (!freezeable(p) || (is_user != pass))
+				continue;
+			if (!thaw_process(p))
+				printk(KERN_INFO
+					"Strange, %s not stopped\n", p->comm );
+		} while_each_thread(g, p);
+
+		pass++;
+	} while (pass < 2 && all);
 
 	read_unlock(&tasklist_lock);
 	schedule();


