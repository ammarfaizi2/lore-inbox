Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267001AbTBTVnP>; Thu, 20 Feb 2003 16:43:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267007AbTBTVnP>; Thu, 20 Feb 2003 16:43:15 -0500
Received: from probity.mcc.ac.uk ([130.88.200.94]:63239 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S267001AbTBTVnM>; Thu, 20 Feb 2003 16:43:12 -0500
Date: Thu, 20 Feb 2003 21:53:17 +0000
From: John Levon <levon@movementarian.org>
To: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: [PATCH] Add module load profile hook
Message-ID: <20030220215317.GA80769@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18lyd3-0009v7-00*obzcYaOS852*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Any problems with this Rusty ? It's at load time rather than
unload as it helps userspace a little wrt reading /proc/modules

regards
john


diff -Naur -X dontdiff linux/drivers/oprofile/buffer_sync.c up/drivers/oprofile/buffer_sync.c
--- linux/drivers/oprofile/buffer_sync.c	2003-02-20 19:59:50.000000000 +0000
+++ up/drivers/oprofile/buffer_sync.c	2003-02-20 21:22:50.000000000 +0000
@@ -67,6 +67,17 @@
 }
 
  
+static int module_load_notify(struct notifier_block * self, unsigned long val, void * data)
+{
+	sync_cpu_buffers();
+	down(&buffer_sem);
+	add_event_entry(ESCAPE_CODE);
+	add_event_entry(DROP_MODULES_CODE);
+	up(&buffer_sem);
+	return 0;
+}
+
+
 static struct notifier_block exit_task_nb = {
 	.notifier_call	= exit_task_notify,
 };
@@ -79,6 +90,10 @@
 	.notifier_call	= mm_notify,
 };
  
+static struct notifier_block module_load_nb = {
+	.notifier_call = module_load_notify,
+};
+
  
 int sync_start(void)
 {
@@ -91,6 +106,9 @@
 	err = profile_event_register(EXEC_UNMAP, &exec_unmap_nb);
 	if (err)
 		goto out3;
+	err = profile_event_register(MODULE_LOADED, &module_load_nb);
+	if (err)
+		goto out4;
 
 	init_timer(&sync_timer);
 	sync_timer.function = timer_ping;
@@ -98,6 +116,8 @@
 	add_timer(&sync_timer);
 out:
 	return err;
+out4:
+	profile_event_unregister(EXEC_UNMAP, &exec_unmap_nb);
 out3:
 	profile_event_unregister(EXIT_MMAP, &exit_mmap_nb);
 out2:
@@ -111,6 +131,7 @@
 	profile_event_unregister(EXIT_TASK, &exit_task_nb);
 	profile_event_unregister(EXIT_MMAP, &exit_mmap_nb);
 	profile_event_unregister(EXEC_UNMAP, &exec_unmap_nb);
+	profile_event_unregister(MODULE_LOADED, &module_load_nb);
 	del_timer_sync(&sync_timer);
 }
 
diff -Naur -X dontdiff linux/drivers/oprofile/event_buffer.h up/drivers/oprofile/event_buffer.h
--- linux/drivers/oprofile/event_buffer.h	2003-02-15 18:26:58.000000000 +0000
+++ up/drivers/oprofile/event_buffer.h	2003-02-20 12:54:47.000000000 +0000
@@ -24,12 +24,13 @@
  * then one of the following codes, then the
  * relevant data.
  */
-#define ESCAPE_CODE		~0UL
+#define ESCAPE_CODE			~0UL
 #define CTX_SWITCH_CODE 		1
 #define CPU_SWITCH_CODE 		2
 #define COOKIE_SWITCH_CODE 		3
 #define KERNEL_ENTER_SWITCH_CODE	4
 #define KERNEL_EXIT_SWITCH_CODE		5
+#define DROP_MODULES_CODE		6
  
 /* add data to the event buffer */
 void add_event_entry(unsigned long data);
diff -Naur -X dontdiff linux/include/linux/profile.h up/include/linux/profile.h
--- linux/include/linux/profile.h	2002-12-16 03:54:18.000000000 +0000
+++ up/include/linux/profile.h	2003-02-20 12:57:15.000000000 +0000
@@ -23,7 +23,8 @@
 enum profile_type {
 	EXIT_TASK,
 	EXIT_MMAP,
-	EXEC_UNMAP
+	EXEC_UNMAP,
+	MODULE_LOADED,
 };
 
 #ifdef CONFIG_PROFILING
@@ -41,6 +42,9 @@
 /* exit of all vmas for a task */
 void profile_exit_mmap(struct mm_struct * mm);
 
+/* a module was loaded */
+void profile_module_loaded(void);
+
 int profile_event_register(enum profile_type, struct notifier_block * n);
 
 int profile_event_unregister(enum profile_type, struct notifier_block * n);
@@ -60,6 +64,7 @@
 #define profile_exit_task(a) do { } while (0)
 #define profile_exec_unmap(a) do { } while (0)
 #define profile_exit_mmap(a) do { } while (0)
+#define profile_module_loaded do { } while (0)
  
 #endif /* CONFIG_PROFILING */
  
diff -Naur -X dontdiff linux/kernel/module.c up/kernel/module.c
--- linux/kernel/module.c	2003-02-18 00:39:13.000000000 +0000
+++ up/kernel/module.c	2003-02-20 12:49:45.000000000 +0000
@@ -31,6 +31,7 @@
 #include <linux/errno.h>
 #include <linux/err.h>
 #include <linux/vermagic.h>
+#include <linux/profile.h>
 #include <asm/uaccess.h>
 #include <asm/semaphore.h>
 #include <asm/pgalloc.h>
@@ -1437,6 +1438,8 @@
 	/* Drop lock so they can recurse */
 	up(&module_mutex);
 
+	profile_module_loaded();
+
 	/* Start the module */
 	ret = mod->init();
 	if (ret < 0) {
diff -Naur -X dontdiff linux/kernel/profile.c up/kernel/profile.c
--- linux/kernel/profile.c	2002-12-16 04:01:12.000000000 +0000
+++ up/kernel/profile.c	2003-02-20 12:57:05.000000000 +0000
@@ -51,6 +51,7 @@
 static struct notifier_block * exit_task_notifier;
 static struct notifier_block * exit_mmap_notifier;
 static struct notifier_block * exec_unmap_notifier;
+static struct notifier_block * module_load_notifier;
  
 void profile_exit_task(struct task_struct * task)
 {
@@ -58,6 +59,7 @@
 	notifier_call_chain(&exit_task_notifier, 0, task);
 	up_read(&profile_rwsem);
 }
+
  
 void profile_exit_mmap(struct mm_struct * mm)
 {
@@ -66,6 +68,7 @@
 	up_read(&profile_rwsem);
 }
 
+
 void profile_exec_unmap(struct mm_struct * mm)
 {
 	down_read(&profile_rwsem);
@@ -73,6 +76,15 @@
 	up_read(&profile_rwsem);
 }
 
+
+void profile_module_loaded()
+{
+	down_read(&profile_rwsem);
+	notifier_call_chain(&module_load_notifier, 0, 0);
+	up_read(&profile_rwsem);
+}
+
+
 int profile_event_register(enum profile_type type, struct notifier_block * n)
 {
 	int err = -EINVAL;
@@ -89,6 +101,9 @@
 		case EXEC_UNMAP:
 			err = notifier_chain_register(&exec_unmap_notifier, n);
 			break;
+		case MODULE_LOADED:
+			err = notifier_chain_register(&module_load_notifier, n);
+			break;
 	}
  
 	up_write(&profile_rwsem);
@@ -113,6 +128,9 @@
 		case EXEC_UNMAP:
 			err = notifier_chain_unregister(&exec_unmap_notifier, n);
 			break;
+		case MODULE_LOADED:
+			err = notifier_chain_unregister(&module_load_notifier, n);
+			break;
 	}
 
 	up_write(&profile_rwsem);
