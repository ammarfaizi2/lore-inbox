Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129678AbQLIC0W>; Fri, 8 Dec 2000 21:26:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129765AbQLIC0M>; Fri, 8 Dec 2000 21:26:12 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:3804 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129678AbQLIC0E>; Fri, 8 Dec 2000 21:26:04 -0500
Message-ID: <3A3191FE.83C14585@uow.edu.au>
Date: Sat, 09 Dec 2000 12:59:26 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: mgalgoci@redhat.com
CC: linux-kernel@vger.kernel.org
Subject: Re: cardbus pirq conflict
In-Reply-To: <20001208130148.B19712@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Galgoci wrote:
> 
> Hi Folks,
> 
> I am running the 2.4.0test12pre7 kernel on my laptop computer, and
> I'm having some rather interesting problems.
> 
> For the longest time, usb never worked on this machine. As of the
> happy patch that enabled bus mastering for usb controllers, it
> magically started working. I am really happy that it does work
> now.
> 
> The usb controller and the pcmcia bridge both share the same
> irq, irq 10.
> 
> Now, my cardbus cards have stopped working. When I insert a cardbus
> nic, I get the following message: "IRQ routing conflict in pirq
> table! Try 'pci=autoirq'"
> 
> The card fails to initialize, and upon issuing the halt command, the
> system generates a kernel Oops. I tend to think that the Oops is a
> symptom of having a half initialized device. If anyone is interested,
> I'll catch the Oops, run it though ksymoops, and send it to them.

test12-pre7 has a number of hotplug problems.  I think what you're
seeing is a deadlock where keventd is waiting on itself in
call_usermodehelper() :(

And yes, when you shutdown the system in this state it oopses.  I'm
not sure why it was doing that - it shouldn't have. hmmm...

Could you please test this stuff?



--- linux-2.4.0-test12-pre7/include/linux/sched.h	Thu Dec  7 22:05:21 2000
+++ linux-akpm/include/linux/sched.h	Sat Dec  9 01:36:19 2000
@@ -152,6 +152,7 @@
 extern int schedule_task(struct tq_struct *task);
 extern void run_schedule_tasks(void);
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
+++ linux-akpm/drivers/pci/pci.c	Sat Dec  9 01:24:46 2000
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
+++ linux-akpm/kernel/kmod.c	Sat Dec  9 11:53:32 2000
@@ -256,21 +256,6 @@
 
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
@@ -279,73 +264,36 @@
 	int retval;
 };
 
-/*
- * This is a standalone child of keventd.  It forks off another thread which
- * is the desired usermode helper and then waits for the child to exit.
- * We return the usermode process's exit code, or some -ve error code.
- */
 static int ____call_usermodehelper(void *data)
 {
 	struct subprocess_info *sub_info = data;
-	struct task_struct *curtask = current;
-	void *params [3] = { sub_info->path, sub_info->argv, sub_info->envp };
-	pid_t pid, pid2;
-	mm_segment_t fs;
-	int retval = 0;
+	int retval;
 
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
+	retval = -EPERM;
+	if (current->fs->root)
+		retval = exec_usermodehelper(sub_info->path, sub_info->argv, sub_info->envp);
 
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
-
-up_and_out:
+	/* Exec failed? */
 	sub_info->retval = retval;
-	curtask->exit_signal = SIGCHLD;		/* Wake up parent */
-	up_and_exit(sub_info->sem, retval);
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
+	pid = kernel_thread (____call_usermodehelper, sub_info, CLONE_VFORK | SIGCHLD);
+	if (pid < 0)
 		sub_info->retval = pid;
-		up(sub_info->sem);
-	}
+	up(sub_info->sem);
 }
 
 /*
@@ -358,22 +306,50 @@
 {
 	DECLARE_MUTEX_LOCKED(sem);
 	struct subprocess_info sub_info = {
-		sem:	&sem,
-		path:	path,
-		argv:	argv,
-		envp:	envp,
-		retval:	0,
-	};
-	struct tq_struct tqs = {
-		next:		0,
-		sync:		0,
-		routine:	__call_usermodehelper,
-		data:		&sub_info,
+		sem:		&sem,
+		path:		path,
+		argv:		argv,
+		envp:		envp,
+		retval:		0,
 	};
+	int retval = 0;
+
+	if (path[0] == '\0')
+		goto out;
 
-	schedule_task(&tqs);
-	down(&sem);		/* Wait for an error or completion */
-	return sub_info.retval;
+	if (current_is_keventd()) {
+		/* We can't wait on keventd! */
+		__call_usermodehelper(&sub_info);
+	} else {
+		struct tq_struct tqs = {
+			next:		0,
+			sync:		0,
+			routine:	__call_usermodehelper,
+			data:		&sub_info,
+		};
+
+		schedule_task(&tqs);
+		down(&sem);		/* Wait for an error or completion */
+	}
+	retval = sub_info.retval;
+out:
+	return retval;
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
+++ linux-akpm/kernel/context.c	Fri Dec  8 22:38:30 2000
@@ -18,6 +18,17 @@
 static DECLARE_TASK_QUEUE(tq_context);
 static DECLARE_WAIT_QUEUE_HEAD(context_task_wq);
 static int keventd_running;
+static struct task_struct *keventd_task;
+
+int current_is_keventd(void)
+{
+	int ret = 0;
+	if (keventd_running == 0)
+		printk(KERN_ERR "current_is_keventd(): keventd has not started\n");
+	else
+		ret = (current == keventd_task);
+	return ret;
+}
 
 int schedule_task(struct tq_struct *task)
 {
@@ -38,6 +49,7 @@
 	daemonize();
 	strcpy(curtask->comm, "keventd");
 	keventd_running = 1;
+	keventd_task = curtask;
 
 	spin_lock_irq(&curtask->sigmask_lock);
 	siginitsetinv(&curtask->blocked, sigmask(SIGCHLD));
--- linux-2.4.0-test12-pre7/net/core/dev.c	Thu Dec  7 22:05:21 2000
+++ linux-akpm/net/core/dev.c	Sat Dec  9 02:11:10 2000
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
@@ -2748,27 +2748,11 @@
 	envp [i++] = "HOME=/";
 	envp [i++] = "PATH=/sbin:/bin:/usr/sbin:/usr/bin";
 	envp [i++] = ifname;
-	envp [i++] = action;
+	envp [i++] = action_str;
 	envp [i] = 0;
 	
 	call_usermodehelper (argv [0], argv, envp);
 
 	return NOTIFY_DONE;
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
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
