Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130218AbQLDOJ1>; Mon, 4 Dec 2000 09:09:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130462AbQLDOJR>; Mon, 4 Dec 2000 09:09:17 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:62094 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S130218AbQLDOJO>; Mon, 4 Dec 2000 09:09:14 -0500
Message-ID: <3A2B9F2D.2A7A09E1@uow.edu.au>
Date: Tue, 05 Dec 2000 00:42:05 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test12-pre3 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Oleg Drokin <green@ixcelerator.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Race/problem with hotplug & network interfaces
In-Reply-To: <20001204155751.B11731@iXcelerator.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Drokin wrote:
> 
> Hello!
> 
>    It seems I have found some kind of race, if hotplug is enabled,
>    and one have changing number of network interfaces (observed on ppp).
>    I use 2.4.0-test11. Problem is 100% repeatable.
> 
>    My test case is this: I start ppp over ssh session, then do ifconfig
>    and then kill pppd (by kill -9 pid).
>    Immediatelly I getting: 1. waitpid(<somepid>) failed, -512 2. oops.
>    Inspecting oops, I have found that
>    current->files == NULL in kmod.c::exec_usermodehelper.
>    After some investigations, it appears, that when pppd exits,
>    ppp interface gets destroyed, and /sbin/hotplug net is called,
>    using now dead pppd as parent.
>    Simple (and probably not that good) solution is attached as patch, below.
>    It get gid of oops, but waitpid failed thing is still there.

Yup.  This is due to the kernel trying to fork/exec from within
a half-dead process.

Could you please test this patch?  It was sent to Linus for
test12-pre4, but....


--- linux-2.4.0-test12-pre4/include/linux/sched.h	Mon Dec  4 21:07:13 2000
+++ linux-akpm/include/linux/sched.h	Tue Dec  5 00:36:08 2000
@@ -150,6 +150,7 @@
 asmlinkage void schedule(void);
 
 extern void schedule_task(struct tq_struct *task);
+extern int start_context_thread(void);
 
 /*
  * The default fd array needs to be at least BITS_PER_LONG,
--- linux-2.4.0-test12-pre4/kernel/kmod.c	Tue Nov 21 20:11:21 2000
+++ linux-akpm/kernel/kmod.c	Tue Dec  5 00:36:08 2000
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
 	void **params = (void **) arg;
 	char *path = (char *) params [0];
 	char **argv = (char **) params [1];
 	char **envp = (char **) params [2];
-	return exec_usermodehelper (path, argv, envp);
+
+	ret = exec_usermodehelper (path, argv, envp);
+	if (ret < 0)
+		ret = -ret;
+	do_exit(ret);
 }
 
+struct subprocess_info {
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
+	struct subprocess_info *sub_info = data;
+	struct task_struct *curtask = current;
+	void *params [3] = { sub_info->path, sub_info->argv, sub_info->envp };
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
+		printk(KERN_ERR "call_usermodehelper[%s]: no root fs\n", sub_info->path);
+		retval = -EPERM;
+		goto up_and_out;
+	}
+	if ((pid = kernel_thread(exec_helper, (void *) params, 0)) < 0) {
+		printk(KERN_ERR "failed fork2 %s, errno = %d", sub_info->argv[0], -pid);
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
+	sub_info->retval = retval;
+	curtask->exit_signal = SIGCHLD;		/* Wake up parent */
+	up_and_exit(sub_info->sem, retval);
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
+	struct subprocess_info *sub_info = data;
+	pid_t pid;
 
-	if (pid2 != pid) {
-		printk(KERN_ERR "waitpid(%d) failed, %d\n", pid, pid2);
-			return -1;
+	if ((pid = kernel_thread (____call_usermodehelper, (void *)sub_info, 0)) < 0) {
+		printk(KERN_ERR "failed fork1 %s, errno = %d", sub_info->argv[0], -pid);
+		sub_info->retval = pid;
+		up(sub_info->sem);
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
+	struct subprocess_info sub_info = {
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
+		data:		&sub_info,
+	};
+
+	schedule_task(&tqs);
+	down(&sem);		/* Wait for an error or completion */
+	return sub_info.retval;
 }
 
 EXPORT_SYMBOL(exec_usermodehelper);
--- linux-2.4.0-test12-pre4/kernel/context.c	Tue Nov 21 20:11:21 2000
+++ linux-akpm/kernel/context.c	Tue Dec  5 00:36:08 2000
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
@@ -24,18 +31,27 @@
 
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
+
+	/* Install a handler so SIGCLD is delivered */
+	sa.sa.sa_handler = SIG_IGN;
+	sa.sa.sa_flags = 0;
+	siginitset(&sa.sa.sa_mask, sigmask(SIGCHLD));
+	do_sigaction(SIGCHLD, &sa, (struct k_sigaction *)0);
 
 	for (;;) {
-		current->state = TASK_INTERRUPTIBLE;
+		__set_task_state(curtask, TASK_INTERRUPTIBLE);
 		add_wait_queue(&context_task_wq, &wait);
 
 		/*
@@ -46,15 +62,19 @@
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
--- linux-2.4.0-test12-pre4/init/main.c	Mon Dec  4 21:07:13 2000
+++ linux-akpm/init/main.c	Tue Dec  5 00:36:08 2000
@@ -700,6 +700,7 @@
 	else mount_initrd =0;
 #endif
 
+	start_context_thread();
 	do_initcalls();
 
 	/* .. filesystems .. */
@@ -712,16 +713,16 @@
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
