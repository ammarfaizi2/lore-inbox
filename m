Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946989AbWKARyk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946989AbWKARyk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 12:54:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946991AbWKARyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 12:54:40 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:10163 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1946989AbWKARyj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 12:54:39 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: [PATCH -mm] swsusp: Freeze filesystems during suspend (rev. 2)
Date: Wed, 1 Nov 2006 18:53:07 +0100
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Nigel Cunningham <ncunningham@linuxmail.org>,
       Christoph Hellwig <hch@infradead.org>
References: <200611011200.18438.rjw@sisk.pl> <20061101114707.GA22079@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20061101114707.GA22079@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611011853.09633.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Freeze all filesystems during the suspend by calling freeze_bdev() for each of
them and thaw them during the resume using thaw_bdev().

This is needed by swsusp, because some filesystems (eg. XFS) use work queues
and worker_threads run with PF_NOFREEZE set, so if these filesystems are not
frozen, they can cause some writes to be performed after the suspend image has
been created which may corrupt lead to a filesystem corruption.

The additional benefit of it is that if the resume fails, the filesystems will
be in a consistent state and there won't be any journal replays needed.

The freezing of filesystems is carried out when processes are being frozen, so
on the majority of architectures it also will happen during a suspend to RAM.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 fs/buffer.c                 |   44 +++++++++++++++++++++++++++++++++++
 include/linux/buffer_head.h |    2 +
 include/linux/freezer.h     |    7 +----
 include/linux/fs.h          |    1 
 kernel/power/process.c      |   54 +++++++++++++++++++++++++++++---------------
 5 files changed, 85 insertions(+), 23 deletions(-)

Index: linux-2.6.19-rc4-mm1/kernel/power/process.c
===================================================================
--- linux-2.6.19-rc4-mm1.orig/kernel/power/process.c	2006-10-31 22:40:40.000000000 +0100
+++ linux-2.6.19-rc4-mm1/kernel/power/process.c	2006-11-01 17:53:18.000000000 +0100
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/syscalls.h>
 #include <linux/freezer.h>
+#include <linux/buffer_head.h>
 
 /* 
  * Timeout for stopping processes
@@ -120,6 +121,7 @@ int freeze_processes(void)
 		todo += nr_user;
 		if (!user_frozen && !nr_user) {
 			sys_sync();
+			freeze_filesystems();
 			start_time = jiffies;
 		}
 		user_frozen = !nr_user;
@@ -153,31 +155,47 @@ int freeze_processes(void)
 	return 0;
 }
 
-void thaw_some_processes(int all)
+#define FREEZER_KERNEL_THREADS 0
+#define FREEZER_USER_SPACE 1
+
+static void __thaw_tasks(int user_space)
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
+	do_each_thread(g, p) {
+		if (!freezeable(p))
+			continue;
+
+		if (p->mm && !(p->flags & PF_BORROWED_MM)) {
+			/* It's a user space process */
+			if (!user_space)
 				continue;
-			if (!thaw_process(p))
-				printk(KERN_INFO
-					"Strange, %s not stopped\n", p->comm);
-		} while_each_thread(g, p);
+		} else {
+			/* It's a kernel thread */
+			if (user_space)
+				continue;
+		}
+		if (!thaw_process(p))
+			printk(KERN_INFO " Strange, %s not stopped\n", p->comm );
+	} while_each_thread(g, p);
+	read_unlock(&tasklist_lock);
+}
 
-		pass++;
-	} while (pass < 2 && all);
+void thaw_processes(void)
+{
+	printk("Restarting tasks ... ");
+	__thaw_tasks(FREEZER_KERNEL_THREADS);
+	thaw_filesystems();
+	__thaw_tasks(FREEZER_USER_SPACE);
+	schedule();
+	printk("done.\n");
+}
 
-	read_unlock(&tasklist_lock);
+void thaw_kernel_threads(void)
+{
+	printk("Restarting kernel threads ... ");
+	__thaw_tasks(FREEZER_KERNEL_THREADS);
 	schedule();
 	printk("done.\n");
 }
Index: linux-2.6.19-rc4-mm1/include/linux/buffer_head.h
===================================================================
--- linux-2.6.19-rc4-mm1.orig/include/linux/buffer_head.h	2006-10-31 22:40:36.000000000 +0100
+++ linux-2.6.19-rc4-mm1/include/linux/buffer_head.h	2006-10-31 22:41:03.000000000 +0100
@@ -170,6 +170,8 @@ wait_queue_head_t *bh_waitq_head(struct 
 int fsync_bdev(struct block_device *);
 struct super_block *freeze_bdev(struct block_device *);
 void thaw_bdev(struct block_device *, struct super_block *);
+void freeze_filesystems(void);
+void thaw_filesystems(void);
 int fsync_super(struct super_block *);
 int fsync_no_super(struct block_device *);
 struct buffer_head *__find_get_block(struct block_device *, sector_t, int);
Index: linux-2.6.19-rc4-mm1/include/linux/fs.h
===================================================================
--- linux-2.6.19-rc4-mm1.orig/include/linux/fs.h	2006-10-31 22:40:36.000000000 +0100
+++ linux-2.6.19-rc4-mm1/include/linux/fs.h	2006-10-31 22:41:03.000000000 +0100
@@ -120,6 +120,7 @@ extern int dir_notify_enable;
 #define MS_PRIVATE	(1<<18)	/* change to private */
 #define MS_SLAVE	(1<<19)	/* change to slave */
 #define MS_SHARED	(1<<20)	/* change to shared */
+#define MS_FROZEN	(1<<21)	/* Frozen by freeze_filesystems() */
 #define MS_ACTIVE	(1<<30)
 #define MS_NOUSER	(1<<31)
 
Index: linux-2.6.19-rc4-mm1/fs/buffer.c
===================================================================
--- linux-2.6.19-rc4-mm1.orig/fs/buffer.c	2006-10-31 22:40:35.000000000 +0100
+++ linux-2.6.19-rc4-mm1/fs/buffer.c	2006-10-31 23:20:09.000000000 +0100
@@ -244,6 +244,50 @@ void thaw_bdev(struct block_device *bdev
 }
 EXPORT_SYMBOL(thaw_bdev);
 
+/**
+ * freeze_filesystems - lock all filesystems and force them into a consistent
+ * state
+ */
+void freeze_filesystems(void)
+{
+	struct super_block *sb;
+
+	lockdep_off();
+	/*
+	 * Freeze in reverse order so filesystems dependant upon others are
+	 * frozen in the right order (eg. loopback on ext3).
+	 */
+	list_for_each_entry_reverse(sb, &super_blocks, s_list) {
+		if (!sb->s_root || !sb->s_bdev ||
+		    (sb->s_frozen == SB_FREEZE_TRANS) ||
+		    (sb->s_flags & MS_RDONLY) ||
+		    (sb->s_flags & MS_FROZEN))
+			continue;
+
+		freeze_bdev(sb->s_bdev);
+		sb->s_flags |= MS_FROZEN;
+	}
+	lockdep_on();
+}
+
+/**
+ * thaw_filesystems - unlock all filesystems
+ */
+void thaw_filesystems(void)
+{
+	struct super_block *sb;
+
+	lockdep_off();
+
+	list_for_each_entry(sb, &super_blocks, s_list)
+		if (sb->s_flags & MS_FROZEN) {
+			sb->s_flags &= ~MS_FROZEN;
+			thaw_bdev(sb->s_bdev, sb);
+		}
+
+	lockdep_on();
+}
+
 /*
  * Various filesystems appear to want __find_get_block to be non-blocking.
  * But it's the page lock which protects the buffers.  To get around this,
Index: linux-2.6.19-rc4-mm1/include/linux/freezer.h
===================================================================
--- linux-2.6.19-rc4-mm1.orig/include/linux/freezer.h	2006-11-01 17:47:50.000000000 +0100
+++ linux-2.6.19-rc4-mm1/include/linux/freezer.h	2006-11-01 17:55:00.000000000 +0100
@@ -1,8 +1,5 @@
 /* Freezer declarations */
 
-#define FREEZER_KERNEL_THREADS 0
-#define FREEZER_ALL_THREADS 1
-
 #ifdef CONFIG_PM
 /*
  * Check if a process has been frozen
@@ -60,8 +57,8 @@ static inline void frozen_process(struct
 
 extern void refrigerator(void);
 extern int freeze_processes(void);
-#define thaw_processes() do { thaw_some_processes(FREEZER_ALL_THREADS); } while(0)
-#define thaw_kernel_threads() do { thaw_some_processes(FREEZER_KERNEL_THREADS); } while(0)
+extern void thaw_processes(void);
+extern void thaw_kernel_threads(void);
 
 static inline int try_to_freeze(void)
 {
