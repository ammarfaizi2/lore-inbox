Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291800AbSBAPjD>; Fri, 1 Feb 2002 10:39:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291801AbSBAPip>; Fri, 1 Feb 2002 10:38:45 -0500
Received: from ns.caldera.de ([212.34.180.1]:45203 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S291798AbSBAPiZ>;
	Fri, 1 Feb 2002 10:38:25 -0500
Date: Fri, 1 Feb 2002 16:38:19 +0100
From: Christoph Hellwig <hch@caldera.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][RFC] kthread abstraction
Message-ID: <20020201163818.A32551@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the startup of custom kernel threads contains lots
of duplicated code (and bugs!).

I'd like to propose the following interface to get rid of these
code waste:

    int kthread_start(struct kthread *kth)

	Startup a new kernel thread as described by 'kth' (details
	below).  Wait until it has finished initialization.


    void kthread_stop(struct kthread *kth)

	Stop the kernel thread described by 'kth'.  Wait until is
	has finished.


    int kthread_running(struct kthread *kth)

	Return 1 if the kernel thread described by 'kth' is running.


The 'kthread' structure contains all information for this thread.
Two fields _must_ be initializes:

    const char *name;

	Name of the thread.

    void (*main)(struct kthread *);

	Mainloop of the thread.  This loop is repeated until the thread
	is stopped.  After finishing this method the common code calls
	schedule() so it's no allowed to have spinlocks held over more
	than one invocation.

Others may be filled out:

    int (*init)(struct kthread *);

	Initialize thread before the mainloop is called.

    void (*cleanup)(struct kthread *);

	Cleanup after the mainloop is done.

    void *data;

	Opaque data for the thread's use.

Patch for 2.5.3 and a small example module are below.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.


diff -uNr -Xdontdiff ../master/linux-2.5.3/include/linux/kthread.h linux/include/linux/kthread.h
--- ../master/linux-2.5.3/include/linux/kthread.h	Thu Jan  1 01:00:00 1970
+++ linux/include/linux/kthread.h	Fri Feb  1 16:28:07 2002
@@ -0,0 +1,23 @@
+#ifndef _LINUX_KTHREAD_H
+#define _LINUX_KTHREAD_H
+
+struct task_struct;
+
+struct kthread {
+	const char *name;
+	struct task_struct *task;
+	struct completion done;
+#define KTH_RUNNING	1
+#define KTH_SHUTDOWN	2
+	long state;
+	void *data;
+	int (*init)(struct kthread *);
+	void (*cleanup)(struct kthread *);
+	void (*main)(struct kthread *);
+};
+
+extern int kthread_start(struct kthread *);
+extern void kthread_stop(struct kthread *);
+extern int kthread_running(struct kthread *);
+
+#endif /* _LINUX_KTHREAD_H */
diff -uNr -Xdontdiff ../master/linux-2.5.3/kernel/Makefile linux/kernel/Makefile
--- ../master/linux-2.5.3/kernel/Makefile	Fri Feb  1 16:27:04 2002
+++ linux/kernel/Makefile	Fri Feb  1 16:29:19 2002
@@ -10,12 +10,12 @@
 O_TARGET := kernel.o
 
 export-objs = signal.o sys.o kmod.o context.o ksyms.o pm.o exec_domain.o \
-		printk.o 
+		printk.o kthread.o
 
 obj-y     = sched.o dma.o fork.o exec_domain.o panic.o printk.o \
 	    module.o exit.o itimer.o info.o time.o softirq.o resource.o \
 	    sysctl.o acct.o capability.o ptrace.o timer.o user.o \
-	    signal.o sys.o kmod.o context.o 
+	    signal.o sys.o kmod.o context.o kthread.o
 
 obj-$(CONFIG_UID16) += uid16.o
 obj-$(CONFIG_MODULES) += ksyms.o
diff -uNr -Xdontdiff ../master/linux-2.5.3/kernel/kthread.c linux/kernel/kthread.c
--- ../master/linux-2.5.3/kernel/kthread.c	Thu Jan  1 01:00:00 1970
+++ linux/kernel/kthread.c	Fri Feb  1 16:29:07 2002
@@ -0,0 +1,137 @@
+/*
+ * Copyright (c) 2002 Christoph Hellwig.
+ * All rights resered.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/completion.h>
+#include <linux/kernel.h>
+#include <linux/kthread.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/sched.h>
+#include <linux/signal.h>
+#include <linux/smp_lock.h>
+#include <linux/spinlock.h>
+#include <asm/bitops.h>
+
+#define KTHREAD_FLAGS \
+	(CLONE_FS|CLONE_FILES|CLONE_SIGHAND)
+
+
+static int kthread_stopped(struct kthread *kth)
+{
+	struct task_struct *task = kth->task;
+	unsigned long signr;
+	siginfo_t info;
+
+	spin_lock_irq(&task->sigmask_lock);
+	signr = dequeue_signal(&task->blocked, &info);
+	spin_unlock_irq(&task->sigmask_lock);
+
+	if (signr == SIGKILL && test_bit(KTH_SHUTDOWN, &kth->state))
+		return 1;
+	return 0;
+}
+
+static int kthread_main(void *arg)
+{
+	struct kthread *kth = arg;
+
+	lock_kernel();
+	daemonize();
+	reparent_to_init();
+	strcpy(current->comm, kth->name);
+	unlock_kernel();
+
+	kth->task = current;
+
+	spin_lock_irq(&current->sigmask_lock);
+	siginitsetinv(&current->blocked,
+			sigmask(SIGHUP) | sigmask(SIGKILL) |
+			sigmask(SIGSTOP) | sigmask(SIGCONT));
+	spin_unlock_irq(&current->sigmask_lock);
+
+	if (kth->init)
+		kth->init(kth);
+	complete(&kth->done);
+
+	do {
+		kth->main(kth);
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule();
+	} while (!kthread_stopped(kth));
+
+	if (kth->cleanup)
+		kth->cleanup(kth);
+	clear_bit(KTH_RUNNING, &kth->state);
+	complete(&kth->done);
+	return 0;
+}
+
+/**
+ *	kthread_start    -    start a new kernel thread
+ *	@kth:		kernel thread description
+ *
+ *	For off a new kernel thread as described by @kth.
+ */
+int kthread_start(struct kthread *kth)
+{
+	pid_t pid;
+
+	if (!kth->name || !kth->main)
+		return -EINVAL;
+
+	init_completion(&kth->done);
+	if ((pid = kernel_thread(kthread_main, kth, KTHREAD_FLAGS)) < 0)
+		return pid;
+	set_bit(KTH_RUNNING, &kth->state);
+	wait_for_completion(&kth->done);
+	return 0;
+}
+
+/**
+ *	kthread_stop    -    stop a kernel thread
+ *	@kth:		kernel thread description
+ *
+ *	Stop the kernel thread described by @kth.
+ */
+void kthread_stop(struct kthread *kth)
+{
+	if (kth->task) {
+		init_completion(&kth->done);
+		set_bit(KTH_SHUTDOWN, &kth->state);
+		send_sig(SIGKILL, kth->task, 1);
+		wait_for_completion(&kth->done);
+		kth->task = NULL;
+		clear_bit(KTH_SHUTDOWN, &kth->state);
+	}
+}
+
+/**
+ *	kthread_running    -    check whether a kernel thread is running
+ *	@kth:		kernel thread description
+ *
+ *	Checks whether the kernel thread described by @kth is running.
+ */
+int kthread_running(struct kthread *kth)
+{
+	return test_bit(KTH_RUNNING, &kth->state);
+}
+
+EXPORT_SYMBOL(kthread_start);
+EXPORT_SYMBOL(kthread_stop);
+EXPORT_SYMBOL(kthread_running);



#include <linux/completion.h>
#include <linux/kernel.h>
#include <linux/kthread.h>
#include <linux/module.h>
#include <linux/types.h>
#include <linux/sched.h>


static int ktestd_init(struct kthread *kth)
{
	printk("ktestd: init\n");
	return 0;
}

static void ktestd_cleanup(struct kthread *kth)
{
	printk("ktestd: cleanup\n");
}

static void ktestd_main(struct kthread *kth)
{
	static int i = 0;
	while (i++ < 10)
		printk("ktestd: main\n");
}

struct kthread test_thread = {
	name:		"ktestd",
	init:		ktestd_init,
	cleanup:	ktestd_cleanup,
	main:		ktestd_main,
};

int init_module(void)
{
	kthread_start(&test_thread);
	return 0;
}

void cleanup_module(void)
{
	printk("ktestd is %s running\n",
		kthread_running(&test_thread) ? "" : "not");
	kthread_stop(&test_thread);
}
