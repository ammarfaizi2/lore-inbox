Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750791AbWFZQjZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbWFZQjZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 12:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750789AbWFZQi6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 12:38:58 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:44524 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1750791AbWFZQiy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 12:38:54 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 2/2] [Suspend2] Freezer upgrade.
Date: Tue, 27 Jun 2006 02:38:57 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626163856.10345.14073.stgit@nigel.suspend2.net>
In-Reply-To: <20060626163850.10345.13807.stgit@nigel.suspend2.net>
References: <20060626163850.10345.13807.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch represents the Suspend2 upgrades to the freezer implementation.
Due to recent changes in the vanilla version, I should be able to greatly
reduce the size of this patch. TODO.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 include/linux/freezer.h |   29 +++++++++++
 include/linux/sched.h   |    4 +
 include/linux/suspend.h |    5 ++
 kernel/kmod.c           |    4 +
 kernel/power/disk.c     |    5 +-
 kernel/power/main.c     |    5 +-
 kernel/power/process.c  |  127 ++++++++++++++++++++++++++++++++++++++++-------
 kernel/power/swsusp.c   |    5 ++
 kernel/power/user.c     |    7 +--
 9 files changed, 164 insertions(+), 27 deletions(-)

diff --git a/include/linux/freezer.h b/include/linux/freezer.h
new file mode 100644
index 0000000..43ef3b2
--- /dev/null
+++ b/include/linux/freezer.h
@@ -0,0 +1,29 @@
+/* Freezer declarations */
+
+#define FREEZER_ON 0
+#define ABORT_FREEZING 1
+#define FREEZING_COMPLETE 2
+
+#define FREEZER_KERNEL_THREADS 0
+#define FREEZER_ALL_THREADS 1
+
+#ifdef CONFIG_PM
+extern unsigned long freezer_state;
+
+#define test_freezer_state(bit) test_bit(bit, &freezer_state)
+#define set_freezer_state(bit) set_bit(bit, &freezer_state)
+#define clear_freezer_state(bit) clear_bit(bit, &freezer_state)
+
+#define freezer_is_on() (test_freezer_state(FREEZER_ON))
+
+extern void do_freeze_process(struct notifier_block *nl);
+
+#else
+
+#define test_freezer_state(bit) (0)
+#define set_freezer_state(bit) do { } while(0)
+#define clear_freezer_state(bit) do { } while(0)
+
+#define freezer_is_on() (0)
+
+#endif
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 267f152..b6d96ab 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1452,7 +1452,7 @@ static inline void frozen_process(struct
 
 extern void refrigerator(void);
 extern int freeze_processes(void);
-extern void thaw_processes(void);
+extern void thaw_processes(int which_threads);
 
 static inline int try_to_freeze(void)
 {
@@ -1471,7 +1471,7 @@ static inline void frozen_process(struct
 
 static inline void refrigerator(void) {}
 static inline int freeze_processes(void) { BUG(); return 0; }
-static inline void thaw_processes(void) {}
+static inline void thaw_processes(int which_threads) {}
 
 static inline int try_to_freeze(void) { return 0; }
 
diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 96e31aa..b128fd2 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -8,6 +8,7 @@
 #include <linux/notifier.h>
 #include <linux/init.h>
 #include <linux/pm.h>
+#include <linux/suspend2.h>
 
 /* page backup entry */
 typedef struct pbe {
@@ -45,6 +46,8 @@ extern int software_suspend(void);
 #if defined(CONFIG_VT) && defined(CONFIG_VT_CONSOLE)
 extern int pm_prepare_console(void);
 extern void pm_restore_console(void);
+extern int freeze_processes(void);
+extern void thaw_processes(int which_threads);
 #else
 static inline int pm_prepare_console(void) { return 0; }
 static inline void pm_restore_console(void) {}
@@ -55,6 +58,8 @@ static inline int software_suspend(void)
 	printk("Warning: fake suspend called\n");
 	return -EPERM;
 }
+static inline int freeze_processes(void) { return 0; }
+static inline void thaw_processes(int which_threads) { }
 #endif /* CONFIG_PM */
 
 #ifdef CONFIG_SUSPEND_SMP
diff --git a/kernel/kmod.c b/kernel/kmod.c
index 20a997c..b792b32 100644
--- a/kernel/kmod.c
+++ b/kernel/kmod.c
@@ -36,6 +36,7 @@
 #include <linux/mount.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/freezer.h>
 #include <asm/uaccess.h>
 
 extern int max_threads;
@@ -249,6 +250,9 @@ int call_usermodehelper_keys(char *path,
 	if (!khelper_wq)
 		return -EBUSY;
 
+	if (freezer_is_on())
+		return 0;
+
 	if (path[0] == '\0')
 		return 0;
 
diff --git a/kernel/power/disk.c b/kernel/power/disk.c
index 81d4d98..a2463e3 100644
--- a/kernel/power/disk.c
+++ b/kernel/power/disk.c
@@ -10,6 +10,7 @@
  */
 
 #include <linux/suspend.h>
+#include <linux/freezer.h>
 #include <linux/syscalls.h>
 #include <linux/reboot.h>
 #include <linux/string.h>
@@ -83,7 +84,7 @@ static int prepare_processes(void)
 	if (!(error = swsusp_shrink_memory()))
 		return 0;
 thaw:
-	thaw_processes();
+	thaw_processes(FREEZER_ALL_THREADS);
 	enable_nonboot_cpus();
 	pm_restore_console();
 	return error;
@@ -92,7 +93,7 @@ thaw:
 static void unprepare_processes(void)
 {
 	platform_finish();
-	thaw_processes();
+	thaw_processes(FREEZER_ALL_THREADS);
 	enable_nonboot_cpus();
 	pm_restore_console();
 }
diff --git a/kernel/power/main.c b/kernel/power/main.c
index 0a907f0..8413db2 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/suspend.h>
+#include <linux/freezer.h>
 #include <linux/kobject.h>
 #include <linux/string.h>
 #include <linux/delay.h>
@@ -96,7 +97,7 @@ static int suspend_prepare(suspend_state
 	if (pm_ops->finish)
 		pm_ops->finish(state);
  Thaw:
-	thaw_processes();
+	thaw_processes(FREEZER_ALL_THREADS);
  Enable_cpu:
 	enable_nonboot_cpus();
 	pm_restore_console();
@@ -135,7 +136,7 @@ static void suspend_finish(suspend_state
 {
 	device_resume();
 	resume_console();
-	thaw_processes();
+	thaw_processes(FREEZER_ALL_THREADS);
 	enable_nonboot_cpus();
 	if (pm_ops && pm_ops->finish)
 		pm_ops->finish(state);
diff --git a/kernel/power/process.c b/kernel/power/process.c
index b2a5f67..020895d 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -5,7 +5,6 @@
  * Originally from swsusp.
  */
 
-
 #undef DEBUG
 
 #include <linux/smp_lock.h>
@@ -13,12 +12,72 @@
 #include <linux/suspend.h>
 #include <linux/module.h>
 #include <linux/syscalls.h>
+#include <linux/buffer_head.h>
+#include <linux/freezer.h>
+
+unsigned long freezer_state = 0;
+
+#ifdef CONFIG_PM_DEBUG
+#define freezer_message(msg, a...) do { printk(msg, ##a); } while(0)
+#else
+#define freezer_message(msg, a...) do { } while(0)
+#endif
 
 /* 
  * Timeout for stopping processes
  */
 #define TIMEOUT	(20 * HZ)
 
+struct frozen_fs
+{
+	struct list_head fsb_list;
+	struct super_block *sb;
+};
+
+LIST_HEAD(frozen_fs_list);
+
+void freezer_make_fses_rw(void)
+{
+	struct frozen_fs *fs, *next_fs;
+
+	list_for_each_entry_safe(fs, next_fs, &frozen_fs_list, fsb_list) {
+		thaw_bdev(fs->sb->s_bdev, fs->sb);
+
+		list_del(&fs->fsb_list);
+		kfree(fs);
+	}
+}
+
+/* 
+ * Done after userspace is frozen, so there should be no danger of
+ * fses being unmounted while we're in here.
+ */
+int freezer_make_fses_ro(void)
+{
+	struct frozen_fs *fs;
+	struct super_block *sb;
+
+	/* Generate the list */
+	list_for_each_entry(sb, &super_blocks, s_list) {
+		if (!sb->s_root || !sb->s_bdev ||
+		    (sb->s_frozen == SB_FREEZE_TRANS) ||
+		    (sb->s_flags & MS_RDONLY))
+			continue;
+
+		fs = kmalloc(sizeof(struct frozen_fs), GFP_ATOMIC);
+		fs->sb = sb;
+		list_add_tail(&fs->fsb_list, &frozen_fs_list);
+	};
+
+	/* Do the freezing in reverse order so filesystems dependant
+	 * upon others are frozen in the right order. (Eg loopback
+	 * on ext3). */
+	list_for_each_entry_reverse(fs, &frozen_fs_list, fsb_list)
+		freeze_bdev(fs->sb->s_bdev);
+
+	return 0;
+}
+
 
 static inline int freezeable(struct task_struct * p)
 {
@@ -39,7 +98,7 @@ void refrigerator(void)
 	long save;
 	save = current->state;
 	pr_debug("%s entered refrigerator\n", current->comm);
-	printk("=");
+	freezer_message("=");
 
 	frozen_process(current);
 	spin_lock_irq(&current->sighand->siglock);
@@ -74,9 +133,13 @@ int freeze_processes(void)
 	struct task_struct *g, *p;
 	unsigned long flags;
 
-	printk( "Stopping tasks: " );
+	user_frozen = test_freezer_state(FREEZER_ON);
+	
+	if (!user_frozen)
+		set_freezer_state(FREEZER_ON);
+
+	freezer_message( "Stopping tasks: " );
 	start_time = jiffies;
-	user_frozen = 0;
 	do {
 		nr_user = todo = 0;
 		read_lock(&tasklist_lock);
@@ -103,8 +166,10 @@ int freeze_processes(void)
 		read_unlock(&tasklist_lock);
 		todo += nr_user;
 		if (!user_frozen && !nr_user) {
-			sys_sync();
+			freezer_message("Freezing bdevs... ");
+			freezer_make_fses_ro();
 			start_time = jiffies;
+			freezer_message("Freezing kernel threads... ");
 		}
 		user_frozen = !nr_user;
 		yield();			/* Yield is okay here */
@@ -118,14 +183,14 @@ int freeze_processes(void)
 	 * but it cleans up leftover PF_FREEZE requests.
 	 */
 	if (todo) {
-		printk( "\n" );
-		printk(KERN_ERR " stopping tasks timed out "
+		freezer_message( "\n" );
+		freezer_message(KERN_ERR " stopping tasks timed out "
 			"after %d seconds (%d tasks remaining):\n",
 			TIMEOUT / HZ, todo);
 		read_lock(&tasklist_lock);
 		do_each_thread(g, p) {
 			if (freezeable(p) && !frozen(p))
-				printk(KERN_ERR "  %s\n", p->comm);
+				freezer_message(KERN_ERR "  %s\n", p->comm);
 			if (freezing(p)) {
 				pr_debug("  clean up: %s\n", p->comm);
 				p->flags &= ~PF_FREEZE;
@@ -138,27 +203,53 @@ int freeze_processes(void)
 		return todo;
 	}
 
-	printk( "|\n" );
+	freezer_message( "|\n" );
 	BUG_ON(in_atomic());
+	
+	set_freezer_state(FREEZING_COMPLETE);
+
 	return 0;
 }
 
-void thaw_processes(void)
+void thaw_processes(int all)
 {
 	struct task_struct *g, *p;
+	int pass = 0; /* Start on kernel space */
+
+	if (!test_freezer_state(FREEZER_ON))
+		return;
+
+	if (!test_freezer_state(FREEZING_COMPLETE))
+		pass++;
+
+	clear_freezer_state(FREEZING_COMPLETE);
 
-	printk( "Restarting tasks..." );
+	freezer_message( "Restarting tasks..." );
 	read_lock(&tasklist_lock);
-	do_each_thread(g, p) {
-		if (!freezeable(p))
-			continue;
-		if (!thaw_process(p))
-			printk(KERN_INFO " Strange, %s not stopped\n", p->comm );
-	} while_each_thread(g, p);
+	do {
+		if (pass) {
+			read_unlock(&tasklist_lock);
+			freezer_make_fses_rw();
+			read_lock(&tasklist_lock);
+		}
+
+		do_each_thread(g, p) {
+			int is_user = !!(p->mm && !(p->flags & PF_BORROWED_MM));
+			if (!freezeable(p) || (is_user != pass))
+				continue;
+			if (!thaw_process(p))
+				freezer_message(KERN_INFO " Strange, %s not stopped\n", p->comm );
+		} while_each_thread(g, p);
+
+		pass++;
+	} while(pass < 2 && all);
 
 	read_unlock(&tasklist_lock);
 	schedule();
-	printk( " done\n" );
+	freezer_message( " done\n" );
+
+	if (all)
+		clear_freezer_state(FREEZER_ON);
 }
 
 EXPORT_SYMBOL(refrigerator);
diff --git a/kernel/power/swsusp.c b/kernel/power/swsusp.c
index c4016cb..64acda1 100644
--- a/kernel/power/swsusp.c
+++ b/kernel/power/swsusp.c
@@ -49,6 +49,7 @@
 #include <linux/bootmem.h>
 #include <linux/syscalls.h>
 #include <linux/highmem.h>
+#include <linux/freezer.h>
 
 #include "power.h"
 
@@ -184,6 +185,8 @@ int swsusp_shrink_memory(void)
 	unsigned int i = 0;
 	char *p = "-\\|/";
 
+	thaw_processes(FREEZER_KERNEL_THREADS);
+
 	printk("Shrinking memory...  ");
 	do {
 		size = 2 * count_highmem_pages();
@@ -207,6 +210,8 @@ int swsusp_shrink_memory(void)
 	} while (tmp > 0);
 	printk("\bdone (%lu pages freed)\n", pages);
 
+	freeze_processes();
+
 	return 0;
 }
 
diff --git a/kernel/power/user.c b/kernel/power/user.c
index 3f1539f..10d5c9b 100644
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -19,6 +19,7 @@
 #include <linux/swapops.h>
 #include <linux/pm.h>
 #include <linux/fs.h>
+#include <linux/freezer.h>
 
 #include <asm/uaccess.h>
 
@@ -75,7 +76,7 @@ static int snapshot_release(struct inode
 	free_bitmap(data->bitmap);
 	if (data->frozen) {
 		down(&pm_sem);
-		thaw_processes();
+		thaw_processes(FREEZER_ALL_THREADS);
 		enable_nonboot_cpus();
 		up(&pm_sem);
 	}
@@ -141,7 +142,7 @@ static int snapshot_ioctl(struct inode *
 		down(&pm_sem);
 		disable_nonboot_cpus();
 		if (freeze_processes()) {
-			thaw_processes();
+			thaw_processes(FREEZER_ALL_THREADS);
 			enable_nonboot_cpus();
 			error = -EBUSY;
 		}
@@ -154,7 +155,7 @@ static int snapshot_ioctl(struct inode *
 		if (!data->frozen)
 			break;
 		down(&pm_sem);
-		thaw_processes();
+		thaw_processes(FREEZER_ALL_THREADS);
 		enable_nonboot_cpus();
 		up(&pm_sem);
 		data->frozen = 0;

--
Nigel Cunningham		nigel at suspend2 dot net
