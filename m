Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129874AbQLJM4Y>; Sun, 10 Dec 2000 07:56:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130095AbQLJM4O>; Sun, 10 Dec 2000 07:56:14 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:57780 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129874AbQLJM4D>; Sun, 10 Dec 2000 07:56:03 -0500
Message-ID: <3A337727.FDED61E3@uow.edu.au>
Date: Sun, 10 Dec 2000 23:29:27 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>, linux-usb-devel@lists.sourceforge.net
CC: Linus Torvalds <torvalds@transmeta.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: [patch] hotplug fixes
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a bunch of changes to the hotplug code, keventd, PCI,
netdevices and call_usermodehelper().

It should fix a number of the PCMCIA problems people have been
reporting.  There are still some questions and issues over this stuff -
I'll cover that in a separate email.


- We have been getting deadlocks at hotplug time because
  call_usermodehelper is synchronous: it returns control after the
  usermode application has exited.  But in some places (esp. 
  [un]register_netdevice) this happens with a lock held (rtnl_lock). 
  This cause `ifconfig' to get stuck.

  So call_usermodehelper has been made asynchronous.  Linus did some
  wizardry with CLONE_VFORK to make this happen safely.

- PCMCIA layer calls call_usermodehelper from within keventd.  But
  call_usermodehelper blocks until keventd has run the helper! Duh.

  This patch special-cases the situation where keventd is calling
  call_usermodehelper().

- Add a check for an empty executable path string in
  call_usermodehelper.  (This check can probably be removed from the
  USB code now?)

- Previously, the netdevice layer was calling call_usermodehelper
  from the netdevice notifier callchain.  This is a worry because:

  - The code which traverses notifier call chains is not safe wrt
    changes in the chain.  Calling out to userland applications
    increases the risk that the chain will be changed under our feet.

  - The sweet little loop at the end of unregister_netdevice can
    cause /sbin/hotplug to be called four times per second for thirty
    seconds while the kernel is waiting for orphaned IPV4 fragments to
    expire.

  So the patch takes the hotplug call off the notifier chain and open
  codes the calls.

- There is a ghastly race with all netdevices.  Hundreds of 'em.  The
  typical netdevice probe function is:

  xxx_probe()
  {
	dev = init_etherdev();	/* Calls register_netdevice */
	...
	futz around for tens of milliseconds
	...
	dev->open = xxx_open;
	/* Device is ready for open */
  }

  xxx_open()
  {
	does stuff with hardware
  }

  The netdevice becomes eligible for an open as soon as it is
  registered.  That open will fail because

  a) The hardware isn't ready yet and

  b) The netdevice.open field hasn't been initialised yet.

  Presumably this race hasn't been noticed before because:

  a) Opening the device usually occurs a "long" time after the
     probe.  Well, it used to.  But now we're running the `open' from
     within init_etherdev(), via /sbin/hotplug.

  b) Modular drivers are accidentally protected by the BKL.  The
     probing runs under sys_insert_module() which takes the BKL.  The
     netdevice open goes through sys_ioctl() which takes the BKL.

     But if the driver sleeps in its probe routine (eg: cs89x0
     does it explicitly) then we lose. On SMP or UP.

  The right fix is to take the register_netdevice call out of
  init_etherdev() and change the drivers so they don't register their
  netdevice until it's ready to be opened.

  Not being in the mood to edit 178 files, the approach I took in
  this patch is to introduce a new system-wide semaphore
  `dev_probe_lock()' which is taken around the PCI probe.  The
  netdevice ioctl layer also claims this lock so the race is fixed.

  Presumably other parts of the kernel which do device probing must
  also protect themselves by calling dev_probe_[un]lock().  This is
  important: running /sbin/hotplug from within the kernel is going to
  change timings quite a lot.

- There's an obscure bug in tty_io.c:release_dev().  I kindly put
  it there in pre7.

  release_dev() needs to ensure that all pending scheduled tasks have
  been executed before it starts deallocating resources.  To cater for
  this I created the function `run_schedule_tasks()'.  This simply runs
  the queue in the context of the caller.

  The problem is, release_dev() is sometimes called from within the
  do_exit()->__exit_files() path.  If there are pending tasks (and
  there usually aren't) ee end up trying to fork a child from a
  half-exitted parent and the child oopses accessing current->files.

  So I renamed run_schedule_tasks() to flush_scheduled_tasks() and it
  now correctly runs the scheduled tasks within keventd's context.

  Incidentally, all users of schedule_task() need to be reviewed for
  races on the close()/release() path.  I think they can end up
  shutting down their hardware and deallocating their resources while
  there are scheduled tasks outstanding.

  The fix is to call flush_scheduled_tasks() as soon as the subsystem
  is in a state where new scheduled_tasks() cannot occur (eg: the
  interrupts have been disabled).

  Note: flush_scheduled_tasks() has the same problem as
  del_timer_sync(): you mustn't call it when you're holding locks which
  would prevent the scheduled task to complete:

  xxx_intr()
  {
	schedule_task(xxx_bh);
  }

  xxx_bh()
  {
	down(&some_sem);	/* Or spin_lock() */
	...
  }

  xxx_close()
  {
	down(&some_sem);
	flush_scheduled_tasks();	/* Deadlock */
  }

- kerneldocified a few functions.



--- linux-2.4.0-test12-pre7/include/linux/sched.h	Thu Dec  7 22:05:21 2000
+++ linux-akpm/include/linux/sched.h	Sun Dec 10 14:57:09 2000
@@ -150,8 +150,9 @@
 asmlinkage void schedule(void);
 
 extern int schedule_task(struct tq_struct *task);
-extern void run_schedule_tasks(void);
+extern void flush_scheduled_tasks(void);
 extern int start_context_thread(void);
+extern int current_is_keventd(void);
 
 /*
  * The default fd array needs to be at least BITS_PER_LONG,
--- linux-2.4.0-test12-pre7/include/linux/kernel.h	Thu Dec  7 22:05:21 2000
+++ linux-akpm/include/linux/kernel.h	Sat Dec  9 01:22:18 2000
@@ -63,6 +63,8 @@
 extern int get_option(char **str, int *pint);
 extern char *get_options(char *str, int nints, int *ints);
 extern unsigned long memparse(char *ptr, char **retptr);
+extern void dev_probe_lock(void);
+extern void dev_probe_unlock(void);
 
 extern int session_of_pgrp(int pgrp);
 
--- linux-2.4.0-test12-pre7/drivers/pci/pci.c	Thu Dec  7 22:05:20 2000
+++ linux-akpm/drivers/pci/pci.c	Sun Dec 10 19:41:13 2000
@@ -300,18 +300,25 @@
 pci_announce_device(struct pci_driver *drv, struct pci_dev *dev)
 {
 	const struct pci_device_id *id;
+	int ret = 0;
 
 	if (drv->id_table) {
 		id = pci_match_device(drv->id_table, dev);
-		if (!id)
-			return 0;
+		if (!id) {
+			ret = 0;
+			goto out;
+		}
 	} else
 		id = NULL;
+
+	dev_probe_lock();
 	if (drv->probe(dev, id) >= 0) {
 		dev->driver = drv;
-		return 1;
+		ret = 1;
 	}
-	return 0;
+	dev_probe_unlock();
+out:
+	return ret;
 }
 
 int
@@ -360,9 +367,9 @@
 	if (!hotplug_path[0])
 		return;
 
-	sprintf(class_id, "PCI_CLASS=%X", pdev->class);
-	sprintf(id, "PCI_ID=%X/%X", pdev->vendor, pdev->device);
-	sprintf(sub_id, "PCI_SUBSYS_ID=%X/%X", pdev->subsystem_vendor, pdev->subsystem_device);
+	sprintf(class_id, "PCI_CLASS=%04X", pdev->class);
+	sprintf(id, "PCI_ID=%04X:%04X", pdev->vendor, pdev->device);
+	sprintf(sub_id, "PCI_SUBSYS_ID=%04X:%04X", pdev->subsystem_vendor, pdev->subsystem_device);
 	sprintf(bus_id, "PCI_SLOT_NAME=%s", pdev->slot_name);
 
 	i = 0;
--- linux-2.4.0-test12-pre7/kernel/exit.c	Thu Dec  7 22:05:21 2000
+++ linux-akpm/kernel/exit.c	Fri Dec  8 22:38:30 2000
@@ -302,9 +302,9 @@
 {
 	struct mm_struct * mm = tsk->mm;
 
+	mm_release();
 	if (mm) {
 		atomic_inc(&mm->mm_count);
-		mm_release();
 		if (mm != tsk->active_mm) BUG();
 		/* more a memory barrier than a real lock */
 		task_lock(tsk);
--- linux-2.4.0-test12-pre7/kernel/kmod.c	Thu Dec  7 22:05:21 2000
+++ linux-akpm/kernel/kmod.c	Sun Dec 10 21:08:27 2000
@@ -19,6 +19,7 @@
 #include <linux/module.h>
 #include <linux/sched.h>
 #include <linux/unistd.h>
+#include <linux/kmod.h>
 #include <linux/smp_lock.h>
 
 #include <asm/uaccess.h>
@@ -256,113 +257,71 @@
 
 #endif /* CONFIG_HOTPLUG */
 
-
-static int exec_helper (void *arg)
-{
-	long ret;
-	void **params = (void **) arg;
-	char *path = (char *) params [0];
-	char **argv = (char **) params [1];
-	char **envp = (char **) params [2];
-
-	ret = exec_usermodehelper (path, argv, envp);
-	if (ret < 0)
-		ret = -ret;
-	do_exit(ret);
-}
-
 struct subprocess_info {
 	struct semaphore *sem;
 	char *path;
 	char **argv;
 	char **envp;
-	int retval;
+	pid_t retval;
 };
 
 /*
- * This is a standalone child of keventd.  It forks off another thread which
- * is the desired usermode helper and then waits for the child to exit.
- * We return the usermode process's exit code, or some -ve error code.
+ * This is the task which runs the usermode application
  */
 static int ____call_usermodehelper(void *data)
 {
 	struct subprocess_info *sub_info = data;
-	struct task_struct *curtask = current;
-	void *params [3] = { sub_info->path, sub_info->argv, sub_info->envp };
-	pid_t pid, pid2;
-	mm_segment_t fs;
-	int retval = 0;
-
-	if (!curtask->fs->root) {
-		printk(KERN_ERR "call_usermodehelper[%s]: no root fs\n", sub_info->path);
-		retval = -EPERM;
-		goto up_and_out;
-	}
-	if ((pid = kernel_thread(exec_helper, (void *) params, 0)) < 0) {
-		printk(KERN_ERR "failed fork2 %s, errno = %d", sub_info->argv[0], -pid);
-		retval = pid;
-		goto up_and_out;
-	}
-
-	if (retval >= 0) {
-		/* Block everything but SIGKILL/SIGSTOP */
-		spin_lock_irq(&curtask->sigmask_lock);
-		siginitsetinv(&curtask->blocked, sigmask(SIGKILL) | sigmask(SIGSTOP));
-		recalc_sigpending(curtask);
-		spin_unlock_irq(&curtask->sigmask_lock);
-
-		/* Allow the system call to access kernel memory */
-		fs = get_fs();
-		set_fs(KERNEL_DS);
-		pid2 = waitpid(pid, &retval, __WCLONE);
-		if (pid2 == -1 && errno < 0)
-			pid2 = errno;
-		set_fs(fs);
-
-		if (pid2 != pid) {
-			printk(KERN_ERR "waitpid(%d) failed, %d\n", pid, pid2);
-			retval = (pid2 < 0) ? pid2 : -1;
-		}
-	}
+	int retval;
 
-up_and_out:
-	sub_info->retval = retval;
-	curtask->exit_signal = SIGCHLD;		/* Wake up parent */
-	up_and_exit(sub_info->sem, retval);
+	retval = -EPERM;
+	if (current->fs->root)
+		retval = exec_usermodehelper(sub_info->path, sub_info->argv, sub_info->envp);
+
+	/* Exec failed? */
+	sub_info->retval = (pid_t)retval;
+	do_exit(0);
 }
 
 /*
- * This is a schedule_task function, so we must not sleep for very long at all.
- * But the exec'ed process could do anything at all.  So we launch another
- * kernel thread.
+ * This is run by keventd.
  */
 static void __call_usermodehelper(void *data)
 {
 	struct subprocess_info *sub_info = data;
 	pid_t pid;
 
-	if ((pid = kernel_thread (____call_usermodehelper, (void *)sub_info, 0)) < 0) {
-		printk(KERN_ERR "failed fork1 %s, errno = %d", sub_info->argv[0], -pid);
+	/*
+	 * CLONE_VFORK: wait until the usermode helper has execve'd successfully
+	 * We need the data structures to stay around until that is done.
+	 */
+	pid = kernel_thread(____call_usermodehelper, sub_info, CLONE_VFORK | SIGCHLD);
+	if (pid < 0)
 		sub_info->retval = pid;
-		up(sub_info->sem);
-	}
+	up(sub_info->sem);
 }
 
-/*
- * This function can be called via do_exit->__exit_files, which means that
- * we're partway through exitting and things break if we fork children.
- * So we use keventd to parent the usermode helper.
- * We return the usermode application's exit code or some -ve error.
+/**
+ * call_usermodehelper - start a usermode application
+ * @path: pathname for the application
+ * @argv: null-terminated argument list
+ * @envp: null-terminated environment list
+ *
+ * Runs a user-space application.  The application is started asynchronously.  It
+ * runs as a child of keventd.  It runs with full root capabilities.  keventd silently
+ * reaps the child when it exits.
+ *
+ * Must be called from process context.  Returns zero on success, else a negative
+ * error code.
  */
-int call_usermodehelper (char *path, char **argv, char **envp)
+int call_usermodehelper(char *path, char **argv, char **envp)
 {
 	DECLARE_MUTEX_LOCKED(sem);
 	struct subprocess_info sub_info = {
-		sem:	&sem,
-		path:	path,
-		argv:	argv,
-		envp:	envp,
-		retval:	0,
+		sem:		&sem,
+		path:		path,
+		argv:		argv,
+		envp:		envp,
+		retval:		0,
 	};
 	struct tq_struct tqs = {
 		next:		0,
@@ -371,9 +330,34 @@
 		data:		&sub_info,
 	};
 
-	schedule_task(&tqs);
-	down(&sem);		/* Wait for an error or completion */
+	if (path[0] == '\0')
+		goto out;
+
+	if (current_is_keventd()) {
+		/* We can't wait on keventd! */
+		__call_usermodehelper(&sub_info);
+	} else {
+		schedule_task(&tqs);
+		down(&sem);		/* Wait until keventd has started the subprocess */
+	}
+out:
 	return sub_info.retval;
+}
+
+/*
+ * This is for the serialisation of device probe() functions
+ * against device open() functions
+ */
+static DECLARE_MUTEX(dev_probe_sem);
+
+void dev_probe_lock(void)
+{
+	down(&dev_probe_sem);
+}
+
+void dev_probe_unlock(void)
+{
+	up(&dev_probe_sem);
 }
 
 EXPORT_SYMBOL(exec_usermodehelper);
--- linux-2.4.0-test12-pre7/kernel/context.c	Thu Dec  7 22:05:21 2000
+++ linux-akpm/kernel/context.c	Sun Dec 10 23:11:03 2000
@@ -3,7 +3,12 @@
  *
  * Mechanism for running arbitrary tasks in process context
  *
- * dwmw2@redhat.com
+ * dwmw2@redhat.com:		Genesis
+ *
+ * andrewm@uow.edu.au:		2.4.0-test12
+ *	- Child reaping
+ *	- Support for tasks which re-add themselves
+ *	- flush_scheduled_tasks.
  */
 
 #define __KERNEL_SYSCALLS__
@@ -17,13 +22,42 @@
 
 static DECLARE_TASK_QUEUE(tq_context);
 static DECLARE_WAIT_QUEUE_HEAD(context_task_wq);
+static DECLARE_WAIT_QUEUE_HEAD(context_task_done);
 static int keventd_running;
+static struct task_struct *keventd_task;
 
+static int need_keventd(const char *who)
+{
+	if (keventd_running == 0)
+		printk(KERN_ERR "%s(): keventd has not started\n", who);
+	return keventd_running;
+}
+	
+int current_is_keventd(void)
+{
+	int ret = 0;
+	if (need_keventd(__FUNCTION__))
+		ret = (current == keventd_task);
+	return ret;
+}
+
+/**
+ * schedule_task - schedule a function for subsequent execution in process context.
+ * @task: pointer to a &tq_struct which defines the function to be scheduled.
+ *
+ * May be called from interrupt context.  The scheduled function is run at some
+ * time in the near future by the keventd kernel thread.  If it can sleep, it
+ * should be designed to do so for the minimum possible time, as it will be
+ * stalling all other scheduled tasks.
+ *
+ * schedule_task() returns non-zero if the task was successfully scheduled.
+ * If @task is already residing on a task queue then schedule_task() fails
+ * to schedule your task and returns zero.
+ */
 int schedule_task(struct tq_struct *task)
 {
 	int ret;
-	if (keventd_running == 0)
-		printk(KERN_ERR "schedule_task(): keventd has not started\n");
+	need_keventd(__FUNCTION__);
 	ret = queue_task(task, &tq_context);
 	wake_up(&context_task_wq);
 	return ret;
@@ -38,6 +72,7 @@
 	daemonize();
 	strcpy(curtask->comm, "keventd");
 	keventd_running = 1;
+	keventd_task = curtask;
 
 	spin_lock_irq(&curtask->sigmask_lock);
 	siginitsetinv(&curtask->blocked, sigmask(SIGCHLD));
@@ -50,18 +85,19 @@
 	siginitset(&sa.sa.sa_mask, sigmask(SIGCHLD));
 	do_sigaction(SIGCHLD, &sa, (struct k_sigaction *)0);
 
- 	/*
- 	 * If one of the functions on a task queue re-adds itself
- 	 * to the task queue we call schedule() in state TASK_RUNNING
- 	 */
- 	for (;;) {
+	/*
+	 * If one of the functions on a task queue re-adds itself
+	 * to the task queue we call schedule() in state TASK_RUNNING
+	 */
+	for (;;) {
 		set_task_state(curtask, TASK_INTERRUPTIBLE);
- 		add_wait_queue(&context_task_wq, &wait);
+		add_wait_queue(&context_task_wq, &wait);
 		if (tq_context)
 			set_task_state(curtask, TASK_RUNNING);
 		schedule();
- 		remove_wait_queue(&context_task_wq, &wait);
- 		run_task_queue(&tq_context);
+		remove_wait_queue(&context_task_wq, &wait);
+		run_task_queue(&tq_context);
+		wake_up(&context_task_done);
 		if (signal_pending(curtask)) {
 			while (waitpid(-1, (unsigned int *)0, __WALL|WNOHANG) > 0)
 				;
@@ -71,12 +107,43 @@
 	}
 }
 
-/*
- * Run the tq_context queue right now.  Must be called from process context
+/**
+ * flush_scheduled_tasks - ensure that any scheduled tasks have run to completion.
+ *
+ * Forces execution of the schedule_task() queue and blocks until its completion.
+ *
+ * If a kernel subsystem uses schedule_task() and wishes to flush any pending
+ * tasks, it should use this function.  This is typically used in driver shutdown
+ * handlers.
+ *
+ * The caller should hold no spinlocks and should hold no semaphores which could
+ * cause the scheduled tasks to block.
  */
-void run_schedule_tasks(void)
+static struct tq_struct dummy_task;
+
+void flush_scheduled_tasks(void)
 {
-	run_task_queue(&tq_context);
+	int count;
+	DECLARE_WAITQUEUE(wait, current);
+
+	/*
+	 * Do it twice. It's possible, albeit highly unlikely, that
+	 * the caller queued a task immediately before calling us,
+	 * and that the eventd thread was already past the run_task_queue()
+	 * but not yet into wake_up(), so it woke us up before completing
+	 * the caller's queued task or our new dummy task.
+	 */
+	add_wait_queue(&context_task_done, &wait);
+	for (count = 0; count < 2; count++) {
+		set_current_state(TASK_UNINTERRUPTIBLE);
+
+		/* Queue a dummy task to make sure we get kicked */
+		schedule_task(&dummy_task);
+
+		/* Wait for it to complete */
+		schedule();
+	}
+	remove_wait_queue(&context_task_done, &wait);
 }
 	
 int start_context_thread(void)
@@ -86,5 +153,5 @@
 }
 
 EXPORT_SYMBOL(schedule_task);
-EXPORT_SYMBOL(run_schedule_tasks);
+EXPORT_SYMBOL(flush_scheduled_tasks);
 
--- linux-2.4.0-test12-pre7/net/core/dev.c	Thu Dec  7 22:05:21 2000
+++ linux-akpm/net/core/dev.c	Sun Dec 10 19:40:13 2000
@@ -154,6 +154,12 @@
 static struct timer_list samp_timer = { function: sample_queue };
 #endif
 
+#ifdef CONFIG_HOTPLUG
+static int net_run_sbin_hotplug(struct net_device *dev, char *action);
+#else
+#define net_run_sbin_hotplug(dev, action) ({ 0; })
+#endif
+
 /*
  *	Our notifier list
  */
@@ -2196,9 +2202,11 @@
 			if (!capable(CAP_NET_ADMIN))
 				return -EPERM;
 			dev_load(ifr.ifr_name);
+			dev_probe_lock();
 			rtnl_lock();
 			ret = dev_ifsioc(&ifr, cmd);
 			rtnl_unlock();
+			dev_probe_unlock();
 			return ret;
 	
 		case SIOCGIFMEM:
@@ -2217,9 +2225,11 @@
 			if (cmd >= SIOCDEVPRIVATE &&
 			    cmd <= SIOCDEVPRIVATE + 15) {
 				dev_load(ifr.ifr_name);
+				dev_probe_lock();
 				rtnl_lock();
 				ret = dev_ifsioc(&ifr, cmd);
 				rtnl_unlock();
+				dev_probe_unlock();
 				if (!ret && copy_to_user(arg, &ifr, sizeof(struct ifreq)))
 					return -EFAULT;
 				return ret;
@@ -2388,10 +2398,12 @@
 	if (ret)
 		return ret;
 #endif /* CONFIG_NET_DIVERT */
-	
+
 	/* Notify protocols, that a new device appeared. */
 	notifier_call_chain(&netdev_chain, NETDEV_REGISTER, dev);
 
+	net_run_sbin_hotplug(dev, "register");
+
 	return 0;
 }
 
@@ -2475,6 +2487,8 @@
 		/* Shutdown queueing discipline. */
 		dev_shutdown(dev);
 
+		net_run_sbin_hotplug(dev, "unregister");
+
 		/* Notify protocols, that we are about to destroy
 		   this device. They should clean all the things.
 		 */
@@ -2714,29 +2728,15 @@
 /* Notify userspace when a netdevice event occurs,
  * by running '/sbin/hotplug net' with certain
  * environment variables set.
- *
- * Currently reported events are listed in netdev_event_names[].
  */
 
-/* /sbin/hotplug ONLY executes for events named here */
-static char *netdev_event_names[] = {
-	[NETDEV_REGISTER]	= "register",
-	[NETDEV_UNREGISTER]	= "unregister",
-};
-
-static int run_sbin_hotplug(struct notifier_block *this,
-			    unsigned long event, void *ptr)
+static int net_run_sbin_hotplug(struct net_device *dev, char *action)
 {
-	struct net_device *dev = (struct net_device *) ptr;
-	char *argv[3], *envp[5], ifname[12 + IFNAMSIZ], action[32];
+	char *argv[3], *envp[5], ifname[12 + IFNAMSIZ], action_str[32];
 	int i;
 
-	if ((event >= ARRAY_SIZE(netdev_event_names)) ||
-	    !netdev_event_names[event])
-		return NOTIFY_DONE;
-
 	sprintf(ifname, "INTERFACE=%s", dev->name);
-	sprintf(action, "ACTION=%s", netdev_event_names[event]);
+	sprintf(action_str, "ACTION=%s", action);
 
         i = 0;
         argv[i++] = hotplug_path;
@@ -2748,27 +2748,9 @@
 	envp [i++] = "HOME=/";
 	envp [i++] = "PATH=/sbin:/bin:/usr/sbin:/usr/bin";
 	envp [i++] = ifname;
-	envp [i++] = action;
+	envp [i++] = action_str;
 	envp [i] = 0;
 	
-	call_usermodehelper (argv [0], argv, envp);
-
-	return NOTIFY_DONE;
-}
-
-static struct notifier_block sbin_hotplug = {
-	notifier_call: run_sbin_hotplug,
-};
-
-/*
- * called from init/main.c, -after- all the initcalls are complete.
- * Registers a hook that calls /sbin/hotplug on every netdev
- * addition and removal.
- */
-void __init net_notifier_init (void)
-{
-	if (register_netdevice_notifier(&sbin_hotplug))
-		printk (KERN_WARNING "unable to register netdev notifier\n"
-			KERN_WARNING "/sbin/hotplug will not be run.\n");
+	return call_usermodehelper(argv [0], argv, envp);
 }
 #endif
--- linux-2.4.0-test12-pre7/net/ipv4/devinet.c	Thu Aug 24 21:07:25 2000
+++ linux-akpm/net/ipv4/devinet.c	Sat Dec  9 11:14:03 2000
@@ -519,6 +519,7 @@
 		return -EINVAL;
 	}
 
+	dev_probe_lock();
 	rtnl_lock();
 
 	if ((dev = __dev_get_by_name(ifr.ifr_name)) == NULL) {
@@ -649,10 +650,12 @@
 	}
 done:
 	rtnl_unlock();
+	dev_probe_unlock();
 	return ret;
 
 rarok:
 	rtnl_unlock();
+	dev_probe_unlock();
 	if (copy_to_user(arg, &ifr, sizeof(struct ifreq)))
 		return -EFAULT;
 	return 0;
--- linux-2.4.0-test12-pre7/init/main.c	Thu Dec  7 22:05:21 2000
+++ linux-akpm/init/main.c	Sat Dec  9 00:47:46 2000
@@ -716,14 +716,6 @@
 	/* Mount the root filesystem.. */
 	mount_root();
 
-#if defined(CONFIG_HOTPLUG) && defined(CONFIG_NET)
-	/* do this after other 'do this last' stuff, because we want
-	 * to minimize spurious executions of /sbin/hotplug
-	 * during boot-up
-	 */
-	net_notifier_init();
-#endif
-
 	mount_devfs_fs ();
 
 #ifdef CONFIG_BLK_DEV_INITRD
--- linux-2.4.0-test12-pre7/drivers/char/tty_io.c	Thu Dec  7 22:05:19 2000
+++ linux-akpm/drivers/char/tty_io.c	Sun Dec 10 14:57:31 2000
@@ -1262,7 +1262,7 @@
 	 * Make sure that the tty's task queue isn't activated. 
 	 */
 	run_task_queue(&tq_timer);
-	run_schedule_tasks();
+	flush_scheduled_tasks();
 
 	/* 
 	 * The release_mem function takes care of the details of clearing
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
