Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129183AbQK1PVA>; Tue, 28 Nov 2000 10:21:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129257AbQK1PUu>; Tue, 28 Nov 2000 10:20:50 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:27360 "EHLO
        horus.its.uow.edu.au") by vger.kernel.org with ESMTP
        id <S129183AbQK1PUk>; Tue, 28 Nov 2000 10:20:40 -0500
Message-ID: <3A23C6EA.A76C65C6@uow.edu.au>
Date: Wed, 29 Nov 2000 01:53:30 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test11-ac4 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>, Mark Ellis <mark.uzumati@virgin.net>,
        Marc Heckmann <pfeif@step.polymtl.ca>
CC: linux-kernel@vger.kernel.org
Subject: Re: OOps in exec_usermodehelper
In-Reply-To: <E0CA73F3362@vcnet.vc.cvut.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Vandrovec wrote:
> 
> Hi,
>   I have one small problem with 2.4.0-test11 and exec_usermodehelper.
> When vmware modules shutdown (specifically vmnet-netifup), kernel tries
> to load some module through call_usermodehelper, but unfortunately
> from task which has current->files == NULL.

hmm..  Quite a few things fixed here.

Could you please test this patch?  It's against 2.4.0-test12-pre2,
should be OK against test11.

The basic problem is that we are launching kernel threads from
within half-exitted parents.

	do_exit->__exit_files->ppp_destroy_interface->...

I don't think it's a good idea to teach the kernel how to fork
from half-dead parents, so this patch moves /sbin/hotplug so
it's parented by [k]eventd, not by whoever called
[un]register_netdevice.

Changes:

- rename `eventd' to `keventd'

- start_context_thread() is now called explicitly prior to doing the
  initcalls.  This is to prevent the possibility of an initcall
  function getting permanently blocked because keventd hasn't
  started.

- Don't call net_notifier_init until we've mounted the root fs.
  This prevents the "no root fs" warnings.

- Make the call to net_notifier_init dependent on CONFIG_NET,
  so netless kernels don't fail at link time.

- call_usermodehelper() now asks keventd to parent the usermode
  app.  In fact keventd is the grandparent because we need an
  intermediate thread to wait on the usermode app.  We don't
  want keventd to block while /sbin/hotplug does its thing.

- Fix exec_helper so it returns the exit code of the child.
  Error values are now correctly propagated as described in the
  comments.

- In schedule_task(), drop a log if keventd isn't running yet.

- Fix call_usermodehelper() so it blocks SIGCHLD.  This was
  the reason for the waitpid() calls failing with ERESTARTSYS.

- Will now correctly find /sbin/hotplug if the caller of
  [un]register_netdevice is chrooted.

- keventd is now capable of reaping dead children.  I will be all ears
  if someone can tell me how to get a kernel thread to accept signals
  without having to install a handler with

    sa.sa_handler = (__sighandler_t)100;




--- linux-2.4.0-test12-pre2/include/linux/sched.h	Tue Nov 28 18:32:01 2000
+++ linux-akpm/include/linux/sched.h	Tue Nov 28 20:28:09 2000
@@ -150,6 +150,7 @@
 asmlinkage void schedule(void);
 
 extern void schedule_task(struct tq_struct *task);
+extern int start_context_thread(void);
 
 /*
  * The default fd array needs to be at least BITS_PER_LONG,
--- linux-2.4.0-test12-pre2/kernel/kmod.c	Tue Nov 21 20:11:21 2000
+++ linux-akpm/kernel/kmod.c	Wed Nov 29 01:19:47 2000
@@ -165,7 +165,7 @@
  
 int request_module(const char * module_name)
 {
-	int pid;
+	pid_t pid;
 	int waitpid_result;
 	sigset_t tmpsig;
 	int i;
@@ -259,40 +259,121 @@
 
 static int exec_helper (void *arg)
 {
+	long ret;
+
 	void **params = (void **) arg;
 	char *path = (char *) params [0];
 	char **argv = (char **) params [1];
 	char **envp = (char **) params [2];
-	return exec_usermodehelper (path, argv, envp);
+	ret = exec_usermodehelper (path, argv, envp);
+	if (ret < 0)
+		ret = -ret;
+	do_exit(ret);
 }
 
+struct tq_with_sem {
+	struct semaphore *sem;
+	char *path;
+	char **argv;
+	char **envp;
+	int retval;
+};
 
-int call_usermodehelper (char *path, char **argv, char **envp)
+/*
+ * This is a standalone child of keventd.  It forks off another thread which
+ * is the desired usermode helper and then waits for the child to exit.
+ * We return the usermode process's exit code, or some -ve error code.
+ */
+static int ____call_usermodehelper(void *data)
 {
-	void *params [3] = { path, argv, envp };
-	int pid, pid2, retval;
+	struct tq_with_sem *tq_sem = data;
+	struct task_struct *curtask = current;
+	void *params [3] = { tq_sem->path, tq_sem->argv, tq_sem->envp };
+	pid_t pid, pid2;
 	mm_segment_t fs;
+	int retval = 0;
 
-	if ( ! current->fs->root ) {
-		printk(KERN_ERR "call_usermodehelper[%s]: no root fs\n",
-			path);
-		return -EPERM;
-	}
-	if ((pid = kernel_thread (exec_helper, (void *) params, 0)) < 0) {
-		printk(KERN_ERR "failed fork %s, errno = %d", argv [0], -pid);
-		return -1;
-	}
+	if (!curtask->fs->root) {
+		printk(KERN_ERR "call_usermodehelper[%s]: no root fs\n", tq_sem->path);
+		retval = -EPERM;
+		goto up_and_out;
+	}
+	if ((pid = kernel_thread(exec_helper, (void *) params, 0)) < 0) {
+		printk(KERN_ERR "failed fork2 %s, errno = %d", tq_sem->argv[0], -pid);
+		retval = pid;
+		goto up_and_out;
+	}
+
+	if (retval >= 0) {
+		/* Block everything but SIGKILL/SIGSTOP */
+		spin_lock_irq(&curtask->sigmask_lock);
+		siginitsetinv(&curtask->blocked, sigmask(SIGKILL) | sigmask(SIGSTOP));
+		recalc_sigpending(curtask);
+		spin_unlock_irq(&curtask->sigmask_lock);
+
+		/* Allow the system call to access kernel memory */
+		fs = get_fs();
+		set_fs(KERNEL_DS);
+		pid2 = waitpid(pid, &retval, __WCLONE);
+		if (pid2 == -1 && errno < 0)
+			pid2 = errno;
+		set_fs(fs);
+
+		if (pid2 != pid) {
+			printk(KERN_ERR "waitpid(%d) failed, %d\n", pid, pid2);
+			retval = (pid2 < 0) ? pid2 : -1;
+		}
+	}
+
+up_and_out:
+	tq_sem->retval = retval;
+	curtask->exit_signal = SIGCHLD;		/* Wake up parent */
+	up_and_exit(tq_sem->sem, retval);
+}
 
-	fs = get_fs ();
-	set_fs (KERNEL_DS);
-	pid2 = waitpid (pid, &retval, __WCLONE);
-	set_fs (fs);
+/*
+ * This is a schedule_task function, so we must not sleep for very long at all.
+ * But the exec'ed process could do anything at all.  So we launch another
+ * kernel thread.
+ */
+static void __call_usermodehelper(void *data)
+{
+	struct tq_with_sem *tq_sem = data;
+	pid_t pid;
 
-	if (pid2 != pid) {
-		printk(KERN_ERR "waitpid(%d) failed, %d\n", pid, pid2);
-			return -1;
+	if ((pid = kernel_thread (____call_usermodehelper, (void *)tq_sem, 0)) < 0) {
+		printk(KERN_ERR "failed fork1 %s, errno = %d", tq_sem->argv[0], -pid);
+		tq_sem->retval = pid;
+		up(tq_sem->sem);
 	}
-	return retval;
+}
+
+/*
+ * This function can be called via do_exit->__exit_files, which means that
+ * we're partway through exitting and things break if we fork children.
+ * So we use keventd to parent the usermode helper.
+ * We return the usermode application's exit code or some -ve error.
+ */
+int call_usermodehelper (char *path, char **argv, char **envp)
+{
+	DECLARE_MUTEX_LOCKED(sem);
+	struct tq_with_sem tq_sem = {
+		sem:	&sem,
+		path:	path,
+		argv:	argv,
+		envp:	envp,
+		retval:	0,
+	};
+	struct tq_struct tqs = {
+		next:		0,
+		sync:		0,
+		routine:	__call_usermodehelper,
+		data:		&tq_sem,
+	};
+
+	schedule_task(&tqs);
+	down(&sem);		/* Wait for an error or completion */
+	return tq_sem.retval;
 }
 
 EXPORT_SYMBOL(exec_usermodehelper);
--- linux-2.4.0-test12-pre2/kernel/context.c	Tue Nov 21 20:11:21 2000
+++ linux-akpm/kernel/context.c	Wed Nov 29 01:48:42 2000
@@ -6,16 +6,23 @@
  * dwmw2@redhat.com
  */
 
+#define __KERNEL_SYSCALLS__
+
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/init.h>
+#include <linux/unistd.h>
+#include <linux/signal.h>
 
 static DECLARE_TASK_QUEUE(tq_context);
 static DECLARE_WAIT_QUEUE_HEAD(context_task_wq);
+static int keventd_running;
 
 void schedule_task(struct tq_struct *task)
 {
+	if (keventd_running == 0)
+		printk(KERN_ERR "schedule_task(): keventd has not started\n");
 	queue_task(task, &tq_context);
 	wake_up(&context_task_wq);
 }
@@ -24,18 +31,24 @@
 
 static int context_thread(void *dummy)
 {
-	DECLARE_WAITQUEUE(wait, current);
+	struct task_struct *curtask = current;
+	DECLARE_WAITQUEUE(wait, curtask);
+	struct k_sigaction sa;
 
 	daemonize();
-	strcpy(current->comm, "eventd");
+	strcpy(curtask->comm, "keventd");
+	keventd_running = 1;
 
-        spin_lock_irq(&current->sigmask_lock);
-        sigfillset(&current->blocked);
-        recalc_sigpending(current);
-        spin_unlock_irq(&current->sigmask_lock);
+	spin_lock_irq(&curtask->sigmask_lock);
+	siginitsetinv(&curtask->blocked, sigmask(SIGCHLD));
+	recalc_sigpending(curtask);
+	spin_unlock_irq(&curtask->sigmask_lock);
+	sa.sa.sa_handler = (__sighandler_t)100;		/* Surely there's a better way? */
+	sa.sa.sa_flags = 0;
+	do_sigaction(SIGCHLD, &sa, (struct k_sigaction *)0);
 
 	for (;;) {
-		current->state = TASK_INTERRUPTIBLE;
+		__set_task_state(curtask, TASK_INTERRUPTIBLE);
 		add_wait_queue(&context_task_wq, &wait);
 
 		/*
@@ -46,15 +59,19 @@
 			schedule();
 
 		remove_wait_queue(&context_task_wq, &wait);
-		current->state = TASK_RUNNING;
+		__set_task_state(curtask, TASK_RUNNING);
 		run_task_queue(&tq_context);
+		if (signal_pending(curtask)) {
+			while (waitpid(-1, (unsigned int *)0, __WALL|WNOHANG) > 0)
+				;
+			flush_signals(curtask);
+			recalc_sigpending(curtask);
+		}
 	}
 }
 
-static int __init start_context_thread(void)
+int start_context_thread(void)
 {
 	kernel_thread(context_thread, NULL, CLONE_FS | CLONE_FILES | CLONE_SIGHAND);
 	return 0;
 }
-
-module_init(start_context_thread);
--- linux-2.4.0-test12-pre2/init/main.c	Tue Nov 28 18:32:01 2000
+++ linux-akpm/init/main.c	Tue Nov 28 20:29:34 2000
@@ -702,6 +702,7 @@
 	else mount_initrd =0;
 #endif
 
+	start_context_thread();
 	do_initcalls();
 
 	/* .. filesystems .. */
@@ -714,16 +715,16 @@
 	init_pcmcia_ds();		/* Do this last */
 #endif
 
-#ifdef CONFIG_HOTPLUG
+	/* Mount the root filesystem.. */
+	mount_root();
+
+#if defined(CONFIG_HOTPLUG) && defined(CONFIG_NET)
 	/* do this after other 'do this last' stuff, because we want
 	 * to minimize spurious executions of /sbin/hotplug
 	 * during boot-up
 	 */
 	net_notifier_init();
 #endif
-
-	/* Mount the root filesystem.. */
-	mount_root();
 
 	mount_devfs_fs ();
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
