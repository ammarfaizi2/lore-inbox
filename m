Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264622AbSJOW3r>; Tue, 15 Oct 2002 18:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265080AbSJOW31>; Tue, 15 Oct 2002 18:29:27 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:27146 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S264622AbSJOW0v>; Tue, 15 Oct 2002 18:26:51 -0400
Date: Tue, 15 Oct 2002 23:32:45 +0100
From: John Levon <levon@movementarian.org>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] [1/7] oprofile - hooks
Message-ID: <20021015223245.GA41906@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The following seven patches, against the latest bk2patch, implement the
oprofile functionality in 2.5. Each patch produces a compilable kernel,
but most of the patches are dependent upon the previous ones.  The
design and implementation is similar to that we discussed previously.

The patch has been in -mm series for a while now, and has been tested by
numerous people on UP and SMP. The patch has been looked at by Andi
Kleen, Christophe Hellwig, Ingo Molnar, and Alan Cox, amongst others.

Please consider applying (especially as oprofile can no longer build
externally)

thanks
john

[1/7]

This patch implements the simple hooks we need to catch unmappings, and
to make sure no stale task_struct*'s are ever used by the main oprofile
core mechanism. If disabled, it compiles to nothing.


diff -Naur -X dontdiff linux-linus/arch/i386/Config.help linux-linus2/arch/i386/Config.help
--- linux-linus/arch/i386/Config.help	Sun Oct 13 19:51:03 2002
+++ linux-linus2/arch/i386/Config.help	Tue Oct 15 22:08:06 2002
@@ -1048,6 +1048,11 @@
   Say Y here if you want to reduce the chances of the tree compiling,
   and are prepared to dig into driver internals to fix compile errors.
 
+Profiling support
+CONFIG_PROFILING
+  Say Y here to enable the extended profiling support mechanisms used
+  by profilers such as OProfile.
+ 
 Software Suspend
 CONFIG_SOFTWARE_SUSPEND
   Enable the possibilty of suspendig machine. It doesn't need APM.
diff -Naur -X dontdiff linux-linus/arch/i386/config.in linux-linus2/arch/i386/config.in
--- linux-linus/arch/i386/config.in	Sun Oct 13 19:51:03 2002
+++ linux-linus2/arch/i386/config.in	Tue Oct 15 22:08:25 2002
@@ -442,6 +442,13 @@
 
 source net/bluetooth/Config.in
 
+if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
+   mainmenu_option next_comment
+   comment 'Profiling support'
+   bool 'Profiling support (EXPERIMENTAL)' CONFIG_PROFILING
+   endmenu
+fi
+ 
 mainmenu_option next_comment
 comment 'Kernel hacking'
 if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
diff -Naur -X dontdiff linux-linus/include/linux/profile.h linux-linus2/include/linux/profile.h
--- linux-linus/include/linux/profile.h	Thu Jan  1 01:00:00 1970
+++ linux-linus2/include/linux/profile.h	Tue Oct 15 22:13:16 2002
@@ -0,0 +1,56 @@
+#ifndef _LINUX_PROFILE_H
+#define _LINUX_PROFILE_H
+
+#ifdef __KERNEL__
+ 
+#include <linux/kernel.h>
+#include <linux/config.h>
+#include <linux/init.h>
+#include <asm/errno.h>
+ 
+enum profile_type {
+	EXIT_TASK,
+	EXIT_MMAP,
+	EXEC_UNMAP
+};
+
+#ifdef CONFIG_PROFILING
+ 
+struct notifier_block;
+struct task_struct;
+struct mm_struct;
+ 
+/* task is in do_exit() */
+void profile_exit_task(struct task_struct * task);
+ 
+/* change of vma mappings */
+void profile_exec_unmap(struct mm_struct * mm);
+
+/* exit of all vmas for a task */
+void profile_exit_mmap(struct mm_struct * mm);
+
+int profile_event_register(enum profile_type, struct notifier_block * n);
+
+int profile_event_unregister(enum profile_type, struct notifier_block * n);
+ 
+#else
+
+static inline int profile_event_register(enum profile_type t, struct notifier_block * n)
+{
+	return -ENOSYS;
+}
+ 
+static inline int profile_event_unregister(enum profile_type t, struct notifier_block * n)
+{
+	return -ENOSYS;
+}
+ 
+#define profile_exit_task(a) do { } while (0)
+#define profile_exec_unmap(a) do { } while (0)
+#define profile_exit_mmap(a) do { } while (0)
+ 
+#endif /* CONFIG_PROFILING */
+ 
+#endif /* __KERNEL__ */
+ 
+#endif /* _LINUX_PROFILE_H */
diff -Naur -X dontdiff linux-linus/kernel/Makefile linux-linus2/kernel/Makefile
--- linux-linus/kernel/Makefile	Sun Oct 13 19:51:03 2002
+++ linux-linus2/kernel/Makefile	Tue Oct 15 22:08:06 2002
@@ -3,9 +3,10 @@
 #
 
 export-objs = signal.o sys.o kmod.o workqueue.o ksyms.o pm.o exec_domain.o \
-	      printk.o platform.o suspend.o dma.o module.o cpufreq.o
+		printk.o platform.o suspend.o dma.o module.o cpufreq.o \
+		profile.o
 
-obj-y     = sched.o fork.o exec_domain.o panic.o printk.o \
+obj-y     = sched.o fork.o exec_domain.o panic.o printk.o profile.o \
 	    module.o exit.o itimer.o time.o softirq.o resource.o \
 	    sysctl.o capability.o ptrace.o timer.o user.o \
 	    signal.o sys.o kmod.o workqueue.o futex.o platform.o pid.o
diff -Naur -X dontdiff linux-linus/kernel/exit.c linux-linus2/kernel/exit.c
--- linux-linus/kernel/exit.c	Sun Oct 13 19:51:03 2002
+++ linux-linus2/kernel/exit.c	Tue Oct 15 22:08:06 2002
@@ -19,6 +19,7 @@
 #include <linux/file.h>
 #include <linux/binfmts.h>
 #include <linux/ptrace.h>
+#include <linux/profile.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -59,11 +60,12 @@
 {
 	struct dentry *proc_dentry;
 	task_t *leader;
-
-	if (p->state < TASK_ZOMBIE)
-		BUG();
+ 
+	BUG_ON(p->state < TASK_ZOMBIE);
+ 
 	if (p != current)
 		wait_task_inactive(p);
+
 	atomic_dec(&p->user->processes);
 	security_ops->task_free_security(p);
 	free_uid(p->user);
@@ -635,6 +637,8 @@
 				current->comm, current->pid,
 				preempt_count());
 
+	profile_exit_task(tsk);
+ 
 fake_volatile:
 	acct_process(code);
 	__exit_mm(tsk);
diff -Naur -X dontdiff linux-linus/kernel/profile.c linux-linus2/kernel/profile.c
--- linux-linus/kernel/profile.c	Thu Jan  1 01:00:00 1970
+++ linux-linus2/kernel/profile.c	Tue Oct 15 22:13:07 2002
@@ -0,0 +1,91 @@
+/*
+ *  linux/kernel/profile.c
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/profile.h>
+#include <linux/bootmem.h>
+#include <linux/notifier.h>
+#include <linux/mm.h>
+
+/* Profile event notifications */
+ 
+#ifdef CONFIG_PROFILING
+ 
+static DECLARE_RWSEM(profile_rwsem);
+static struct notifier_block * exit_task_notifier;
+static struct notifier_block * exit_mmap_notifier;
+static struct notifier_block * exec_unmap_notifier;
+ 
+void profile_exit_task(struct task_struct * task)
+{
+	down_read(&profile_rwsem);
+	notifier_call_chain(&exit_task_notifier, 0, task);
+	up_read(&profile_rwsem);
+}
+ 
+void profile_exit_mmap(struct mm_struct * mm)
+{
+	down_read(&profile_rwsem);
+	notifier_call_chain(&exit_mmap_notifier, 0, mm);
+	up_read(&profile_rwsem);
+}
+
+void profile_exec_unmap(struct mm_struct * mm)
+{
+	down_read(&profile_rwsem);
+	notifier_call_chain(&exec_unmap_notifier, 0, mm);
+	up_read(&profile_rwsem);
+}
+
+int profile_event_register(enum profile_type type, struct notifier_block * n)
+{
+	int err = -EINVAL;
+ 
+	down_write(&profile_rwsem);
+ 
+	switch (type) {
+		case EXIT_TASK:
+			err = notifier_chain_register(&exit_task_notifier, n);
+			break;
+		case EXIT_MMAP:
+			err = notifier_chain_register(&exit_mmap_notifier, n);
+			break;
+		case EXEC_UNMAP:
+			err = notifier_chain_register(&exec_unmap_notifier, n);
+			break;
+	}
+ 
+	up_write(&profile_rwsem);
+ 
+	return err;
+}
+
+ 
+int profile_event_unregister(enum profile_type type, struct notifier_block * n)
+{
+	int err = -EINVAL;
+ 
+	down_write(&profile_rwsem);
+ 
+	switch (type) {
+		case EXIT_TASK:
+			err = notifier_chain_unregister(&exit_task_notifier, n);
+			break;
+		case EXIT_MMAP:
+			err = notifier_chain_unregister(&exit_mmap_notifier, n);
+			break;
+		case EXEC_UNMAP:
+			err = notifier_chain_unregister(&exec_unmap_notifier, n);
+			break;
+	}
+
+	up_write(&profile_rwsem);
+	return err;
+}
+
+#endif /* CONFIG_PROFILING */
+
+EXPORT_SYMBOL_GPL(profile_event_register);
+EXPORT_SYMBOL_GPL(profile_event_unregister);
diff -Naur -X dontdiff linux-linus/mm/mmap.c linux-linus2/mm/mmap.c
--- linux-linus/mm/mmap.c	Sun Oct 13 19:51:03 2002
+++ linux-linus2/mm/mmap.c	Tue Oct 15 22:08:06 2002
@@ -16,6 +16,7 @@
 #include <linux/fs.h>
 #include <linux/personality.h>
 #include <linux/security.h>
+#include <linux/profile.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
@@ -1104,6 +1105,10 @@
 	if (mpnt->vm_start >= end)
 		return 0;
 
+	/* Something will probably happen, so notify. */
+	if (mpnt->vm_file && (mpnt->vm_flags & VM_EXEC))
+		profile_exec_unmap(mm);
+ 
 	/*
 	 * If we need to split any vma, do it now to save pain later.
 	 */
@@ -1253,7 +1258,10 @@
 	mmu_gather_t *tlb;
 	struct vm_area_struct * mpnt;
 
+	profile_exit_mmap(mm);
+ 
 	release_segments(mm);
+ 
 	spin_lock(&mm->page_table_lock);
 
 	tlb = tlb_gather_mmu(mm, 1);

