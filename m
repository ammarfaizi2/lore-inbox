Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292282AbSCFS74>; Wed, 6 Mar 2002 13:59:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293049AbSCFS7r>; Wed, 6 Mar 2002 13:59:47 -0500
Received: from ns.caldera.de ([212.34.180.1]:22423 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S292282AbSCFS7h>;
	Wed, 6 Mar 2002 13:59:37 -0500
Date: Wed, 6 Mar 2002 19:59:24 +0100
From: Christoph Hellwig <hch@caldera.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] kthread abstraction for 2.5.6-pre2
Message-ID: <20020306195924.A5092@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

the appended patch adds a small and lightweigt 'kthread' layer that
simplifies creating kernel daemons for drivers/filesystems/etc.
Currently there is lots of duplicated code doing the setup of this
threads which is hard to maintain and error-prone.

For an description of the API please take a look at:

	http://lwn.net/2002/0214/a/kthread.php3

Please apply,

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.

diff -uNr -Xdontdiff ../master/linux-2.5.4-pre5/include/linux/kthread.h linux/include/linux/kthread.h
--- ../master/linux-2.5.4-pre5/include/linux/kthread.h	Thu Jan  1 01:00:00 1970
+++ linux/include/linux/kthread.h	Sat Feb  9 17:43:12 2002
@@ -0,0 +1,22 @@
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
+	int (*init)(struct kthread *, void *);
+	void (*cleanup)(struct kthread *, void *);
+	int (*main)(struct kthread *, void *);
+};
+
+extern int kthread_start(struct kthread *, void *);
+extern void kthread_stop(struct kthread *);
+extern int kthread_running(struct kthread *);
+
+#endif /* _LINUX_KTHREAD_H */
diff -uNr -Xdontdiff ../master/linux-2.5.4-pre5/kernel/Makefile linux/kernel/Makefile
--- ../master/linux-2.5.4-pre5/kernel/Makefile	Fri Feb  1 16:27:04 2002
+++ linux/kernel/Makefile	Sat Feb  9 17:42:58 2002
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
diff -uNr -Xdontdiff ../master/linux-2.5.4-pre5/kernel/kthread.c linux/kernel/kthread.c
--- ../master/linux-2.5.4-pre5/kernel/kthread.c	Thu Jan  1 01:00:00 1970
+++ linux/kernel/kthread.c	Sat Feb  9 17:43:47 2002
@@ -0,0 +1,148 @@
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
+struct kthread_args {
+	struct kthread *kth;
+	void *data;
+};
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
+static int kthread_main(void *p)
+{
+	struct kthread_args *args = p;
+	struct kthread *kth = args->kth;
+	void *data = args->data;
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
+		kth->init(kth, data);
+	complete(&kth->done);
+
+	do {
+		if (kth->main(kth, data) < 0)
+			break;
+	} while (!kthread_stopped(kth));
+
+	if (kth->cleanup)
+		kth->cleanup(kth, data);
+	clear_bit(KTH_RUNNING, &kth->state);
+	complete(&kth->done);
+	return 0;
+}
+
+/**
+ *	kthread_start    -    start a new kernel thread
+ *	@kth:		kernel thread description
+ *	@data:		opaque data for use with the methods
+ *
+ *	For off a new kernel thread as described by @kth.
+ */
+int kthread_start(struct kthread *kth, void *data)
+{
+	struct kthread_args args;
+	pid_t pid;
+
+	if (!kth->name || !kth->main)
+		return -EINVAL;
+
+	args.kth = kth;
+	args.data = data;
+	
+	init_completion(&kth->done);
+	if ((pid = kernel_thread(kthread_main, &args, KTHREAD_FLAGS)) < 0)
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
