Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261877AbUBWOYj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 09:24:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261878AbUBWOYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 09:24:38 -0500
Received: from verein.lst.de ([212.34.189.10]:17360 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S261877AbUBWOY2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 09:24:28 -0500
Date: Mon, 23 Feb 2004 15:24:23 +0100
From: Christoph Hellwig <hch@lst.de>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] build ipc/utils.c conditional on CONFIG_SYSVIPC
Message-ID: <20040223142423.GA9114@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

except for two tiny little stubs everything depends on CONFIG_SYSVIPC.
Thus move the stubs to the proper place (sem.h) and get rid of the
ifdefs in that file.

Also fix up fork.c to use sem.h insted of it's own externs.


--- 1.8/include/linux/sem.h	Sat Jul  5 08:52:29 2003
+++ edited/include/linux/sem.h	Mon Feb 23 13:39:22 2004
@@ -140,8 +140,18 @@
 asmlinkage long sys_semtimedop(int semid, struct sembuf __user *sops,
 			unsigned nsops, const struct timespec __user *timeout);
 
+#ifdef CONFIG_SYSVIPC
+int copy_semundo(unsigned long clone_flags, struct task_struct *p);
 void exit_sem(struct task_struct *p);
+#else
+static inline void exit_sem(struct task_struct *p)
+{
+}
+static inline int copy_semundo(unsigned long clone_flags, struct task_struct *p)
+{
+	return 0;
+}
 
+#endif /* CONFIG_SYSVIPC */
 #endif /* __KERNEL__ */
-
 #endif /* _LINUX_SEM_H */
--- 1.3/ipc/Makefile	Sat Dec 14 13:38:56 2002
+++ edited/ipc/Makefile	Mon Feb 23 13:40:45 2004
@@ -2,6 +2,4 @@
 # Makefile for the linux ipc.
 #
 
-obj-y   := util.o
-
-obj-$(CONFIG_SYSVIPC) += msg.o sem.o shm.o
+obj-$(CONFIG_SYSVIPC) += util.o msg.o sem.o shm.o 
--- 1.16/ipc/util.c	Mon Feb 23 06:24:11 2004
+++ edited/ipc/util.c	Mon Feb 23 13:40:30 2004
@@ -12,7 +12,6 @@
  *            Mingming Cao <cmm@us.ibm.com>
  */
 
-#include <linux/config.h>
 #include <linux/mm.h>
 #include <linux/shm.h>
 #include <linux/init.h>
@@ -25,8 +24,6 @@
 #include <linux/rcupdate.h>
 #include <linux/workqueue.h>
 
-#if defined(CONFIG_SYSVIPC)
-
 #include "util.h"
 
 /**
@@ -531,20 +528,3 @@
 }
 
 #endif /* __ia64__ */
-
-#else
-/*
- * Dummy functions when SYSV IPC isn't configured
- */
-
-int copy_semundo(unsigned long clone_flags, struct task_struct *tsk)
-{
-	return 0;
-}
-
-void exit_sem(struct task_struct *tsk)
-{
-	return;
-}
-
-#endif /* CONFIG_SYSVIPC */
--- 1.156/kernel/fork.c	Thu Feb 19 04:42:38 2004
+++ edited/kernel/fork.c	Mon Feb 23 13:39:31 2004
@@ -30,6 +30,7 @@
 #include <linux/futex.h>
 #include <linux/ptrace.h>
 #include <linux/mount.h>
+#include <linux/sem.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -37,9 +38,6 @@
 #include <asm/mmu_context.h>
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
-
-extern int copy_semundo(unsigned long clone_flags, struct task_struct *tsk);
-extern void exit_sem(struct task_struct *tsk);
 
 /* The idle threads do not count..
  * Protected by write_lock_irq(&tasklist_lock)
