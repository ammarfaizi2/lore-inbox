Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266064AbTAFFXT>; Mon, 6 Jan 2003 00:23:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266069AbTAFFXS>; Mon, 6 Jan 2003 00:23:18 -0500
Received: from dp.samba.org ([66.70.73.150]:50842 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S266064AbTAFFXI>;
	Mon, 6 Jan 2003 00:23:08 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, akpm@zip.com.au,
       Thomas Sailer <sailer@ife.ee.ethz.ch>,
       Marcel Holtmann <marcel@holtmann.org>,
       Jose Orlando Pereira <jop@di.uminho.pt>,
       J.E.J.Bottomley@HansenPartnership.com
Subject: Re: [PATCH] Deprecated exec_usermodehelper, enhance call_usermodehelper 
In-reply-to: Your message of "Mon, 06 Jan 2003 15:35:45 +1100."
Date: Mon, 06 Jan 2003 16:31:14 +1100
Message-Id: <20030106053144.083C72C276@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In message <Pine.LNX.4.44.0301051952450.3087-100000@home.transmeta.com> you w
ri
> te:
> > 
> > On Mon, 6 Jan 2003, Rusty Russell wrote:
> > >
> > > Linus, please apply.
> > 
> > Nope, I really don't want to deprecate any more interfaces while my build 
> > is still so noisy about the _existing_ deprecated stuff.
> 
> OK.  I'll work with the various authors to actually remove all 3 users
> in the tree, then submit a patch to rip it out.

OK.  This patch does that.  Thomas, Marcel, James?  This touches code
I don't use, so although the transformation is fairly trivial...

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: exec_usermodehelper sucks
Author: Rusty Russell
Status: Tested on 2.5.54

D: Urban Widmark points out that modprobe calls system() in many
D: configurations, which drops privs since request_module() doesn't
D: doesn't set ruid and rguid.
D:
D: This gets rid of exec_usermodehelper and makes everyone use
D: call_usermodehelper, which has a new "wait" flag.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5-bk/include/linux/kmod.h working-2.5-bk-kmod-noclean/include/linux/kmod.h
--- linux-2.5-bk/include/linux/kmod.h	2003-01-02 12:35:15.000000000 +1100
+++ working-2.5-bk-kmod-noclean/include/linux/kmod.h	2003-01-06 16:25:28.000000000 +1100
@@ -21,6 +21,7 @@
 
 #include <linux/config.h>
 #include <linux/errno.h>
+#include <linux/compiler.h>
 
 #ifdef CONFIG_KMOD
 extern int request_module(const char * name);
@@ -29,8 +30,7 @@ static inline int request_module(const c
 #endif
 
 #define try_then_request_module(x, mod) ((x) ?: request_module(mod), (x))
-extern int exec_usermodehelper(char *program_path, char *argv[], char *envp[]);
-extern int call_usermodehelper(char *path, char *argv[], char *envp[]);
+extern int call_usermodehelper(char *path, char *argv[], char *envp[], int wait);
 
 #ifdef CONFIG_HOTPLUG
 extern char hotplug_path [];
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5-bk/kernel/kmod.c working-2.5-bk-kmod-noclean/kernel/kmod.c
--- linux-2.5-bk/kernel/kmod.c	2003-01-02 12:37:03.000000000 +1100
+++ working-2.5-bk-kmod-noclean/kernel/kmod.c	2003-01-06 16:25:43.000000000 +1100
@@ -14,8 +14,10 @@
 
 	Unblock all signals when we exec a usermode process.
 	Shuu Yamaguchi <shuu@wondernetworkresources.com> December 2000
-*/
 
+	call_usermodehelper wait flag, and remove exec_usermodehelper.
+	Rusty Russell <rusty@rustcorp.com.au>  Jan 2003
+*/
 #define __KERNEL_SYSCALLS__
 
 #include <linux/config.h>
@@ -31,121 +33,11 @@
 #include <linux/workqueue.h>
 #include <linux/security.h>
 #include <linux/mount.h>
+#include <linux/kernel.h>
 #include <asm/uaccess.h>
 
 extern int max_threads, system_running;
 
-static inline void
-use_init_fs_context(void)
-{
-	struct fs_struct *our_fs, *init_fs;
-	struct dentry *root, *pwd;
-	struct vfsmount *rootmnt, *pwdmnt;
-	struct namespace *our_ns, *init_ns;
-
-	/*
-	 * Make modprobe's fs context be a copy of init's.
-	 *
-	 * We cannot use the user's fs context, because it
-	 * may have a different root than init.
-	 * Since init was created with CLONE_FS, we can grab
-	 * its fs context from "init_task".
-	 *
-	 * The fs context has to be a copy. If it is shared
-	 * with init, then any chdir() call in modprobe will
-	 * also affect init and the other threads sharing
-	 * init_task's fs context.
-	 *
-	 * We created the exec_modprobe thread without CLONE_FS,
-	 * so we can update the fields in our fs context freely.
-	 */
-
-	init_fs = init_task.fs;
-	init_ns = init_task.namespace;
-	get_namespace(init_ns);
-	our_ns = current->namespace;
-	current->namespace = init_ns;
-	put_namespace(our_ns);
-	read_lock(&init_fs->lock);
-	rootmnt = mntget(init_fs->rootmnt);
-	root = dget(init_fs->root);
-	pwdmnt = mntget(init_fs->pwdmnt);
-	pwd = dget(init_fs->pwd);
-	read_unlock(&init_fs->lock);
-
-	/* FIXME - unsafe ->fs access */
-	our_fs = current->fs;
-	our_fs->umask = init_fs->umask;
-	set_fs_root(our_fs, rootmnt, root);
-	set_fs_pwd(our_fs, pwdmnt, pwd);
-	write_lock(&our_fs->lock);
-	if (our_fs->altroot) {
-		struct vfsmount *mnt = our_fs->altrootmnt;
-		struct dentry *dentry = our_fs->altroot;
-		our_fs->altrootmnt = NULL;
-		our_fs->altroot = NULL;
-		write_unlock(&our_fs->lock);
-		dput(dentry);
-		mntput(mnt);
-	} else 
-		write_unlock(&our_fs->lock);
-	dput(root);
-	mntput(rootmnt);
-	dput(pwd);
-	mntput(pwdmnt);
-}
-
-int exec_usermodehelper(char *program_path, char *argv[], char *envp[])
-{
-	int i;
-	struct task_struct *curtask = current;
-
-	curtask->session = 1;
-	curtask->pgrp = 1;
-
-	use_init_fs_context();
-
-	/* Prevent parent user process from sending signals to child.
-	   Otherwise, if the modprobe program does not exist, it might
-	   be possible to get a user defined signal handler to execute
-	   as the super user right after the execve fails if you time
-	   the signal just right.
-	*/
-	spin_lock_irq(&curtask->sig->siglock);
-	sigemptyset(&curtask->blocked);
-	flush_signals(curtask);
-	flush_signal_handlers(curtask);
-	recalc_sigpending();
-	spin_unlock_irq(&curtask->sig->siglock);
-
-	for (i = 0; i < curtask->files->max_fds; i++ ) {
-		if (curtask->files->fd[i]) close(i);
-	}
-
-	/* Drop the "current user" thing */
-	{
-		struct user_struct *user = curtask->user;
-		curtask->user = INIT_USER;
-		atomic_inc(&INIT_USER->__count);
-		atomic_inc(&INIT_USER->processes);
-		atomic_dec(&user->processes);
-		free_uid(user);
-	}
-
-	/* Give kmod all effective privileges.. */
-	curtask->euid = curtask->fsuid = 0;
-	curtask->egid = curtask->fsgid = 0;
-	security_task_kmod_set_label();
-
-	/* Allow execve args to be in kernel space. */
-	set_fs(KERNEL_DS);
-
-	/* Go, go, go... */
-	if (execve(program_path, argv, envp) < 0)
-		return -errno;
-	return 0;
-}
-
 #ifdef CONFIG_KMOD
 
 /*
@@ -153,29 +45,6 @@ int exec_usermodehelper(char *program_pa
 */
 char modprobe_path[256] = "/sbin/modprobe";
 
-static int exec_modprobe(void * module_name)
-{
-	static char * envp[] = { "HOME=/", "TERM=linux", "PATH=/sbin:/usr/sbin:/bin:/usr/bin", NULL };
-	char *argv[] = { modprobe_path, "--", (char*)module_name, NULL };
-	int ret;
-
-	if (!system_running)
-		return -EBUSY;
-
-	ret = exec_usermodehelper(modprobe_path, argv, envp);
-	if (ret) {
-		static unsigned long last;
-		unsigned long now = jiffies;
-		if (now - last > HZ) {
-			last = now;
-			printk(KERN_DEBUG
-			       "kmod: failed to exec %s -s -k %s, errno = %d\n",
-			       modprobe_path, (char*) module_name, errno);
-		}
-	}
-	return ret;
-}
-
 /**
  * request_module - try to load a kernel module
  * @module_name: Name of module
@@ -189,24 +58,18 @@ static int exec_modprobe(void * module_n
  * If module auto-loading support is disabled then this function
  * becomes a no-operation.
  */
-int request_module(const char * module_name)
+int request_module(const char *module_name)
 {
-	pid_t pid;
-	int waitpid_result;
-	sigset_t tmpsig;
-	int i, ret;
+	unsigned int max_modprobes;
+	int ret;
+	char *argv[] = { modprobe_path, "--", (char*)module_name, NULL };
+	static char *envp[] = { "HOME=/",
+				"TERM=linux",
+				"PATH=/sbin:/usr/sbin:/bin:/usr/bin",
+				NULL };
 	static atomic_t kmod_concurrent = ATOMIC_INIT(0);
 #define MAX_KMOD_CONCURRENT 50	/* Completely arbitrary value - KAO */
 	static int kmod_loop_msg;
-	unsigned long saved_policy = current->policy;
-
-	current->policy = SCHED_NORMAL;
-	/* Don't allow request_module() when the system isn't set up */
-	if ( ! system_running ) {
-		printk(KERN_ERR "request_module[%s]: not ready\n", module_name);
-		ret = -EPERM;
-		goto out;
-	}
 
 	/* If modprobe needs a service that is in a module, we get a recursive
 	 * loop.  Limit the number of running kmod threads to max_threads/2 or
@@ -216,61 +79,44 @@ int request_module(const char * module_n
 	 * process tables to get the command line, proc_pid_cmdline is static
 	 * and it is not worth changing the proc code just to handle this case. 
 	 * KAO.
+	 *
+
+	 * "trace the ppid" is simple, but will fail if someone's
+	 * parent exits.  I think this is as good as it gets. --RR
 	 */
-	i = max_threads/2;
-	if (i > MAX_KMOD_CONCURRENT)
-		i = MAX_KMOD_CONCURRENT;
+	max_modprobes = min(max_threads/2, MAX_KMOD_CONCURRENT);
 	atomic_inc(&kmod_concurrent);
-	if (atomic_read(&kmod_concurrent) > i) {
+	if (atomic_read(&kmod_concurrent) > max_modprobes) {
+		/* We may be blaming an innocent here, but unlikely */
 		if (kmod_loop_msg++ < 5)
 			printk(KERN_ERR
-			       "kmod: runaway modprobe loop assumed and stopped\n");
+			       "request_module: runaway loop modprobe %s\n",
+			       module_name);
 		atomic_dec(&kmod_concurrent);
-		ret = -ENOMEM;
-		goto out;
+		return -ENOMEM;
 	}
 
-	pid = kernel_thread(exec_modprobe, (void*) module_name, 0);
-	if (pid < 0) {
-		printk(KERN_ERR "request_module[%s]: fork failed, errno %d\n", module_name, -pid);
-		atomic_dec(&kmod_concurrent);
-		ret = pid;
-		goto out;
+	ret = call_usermodehelper(modprobe_path, argv, envp, 1);
+	if (ret < 0) { /* Exec failed, or fork failed or something bad */
+		static unsigned long last;
+		unsigned long now = jiffies;
+		if (now - last > HZ) {
+			last = now;
+			printk(KERN_DEBUG
+			       "request_module: failed %s -- %s. error = %d\n",
+			       modprobe_path, module_name, -ret);
+		}
 	}
-
-	/* Block everything but SIGKILL/SIGSTOP */
-	spin_lock_irq(&current->sig->siglock);
-	tmpsig = current->blocked;
-	siginitsetinv(&current->blocked, sigmask(SIGKILL) | sigmask(SIGSTOP));
-	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
-
-	waitpid_result = waitpid(pid, NULL, __WCLONE);
 	atomic_dec(&kmod_concurrent);
-
-	/* Allow signals again.. */
-	spin_lock_irq(&current->sig->siglock);
-	current->blocked = tmpsig;
-	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
-
-	if (waitpid_result != pid) {
-		printk(KERN_ERR "request_module[%s]: waitpid(%d,...) failed, errno %d\n",
-		       module_name, pid, -waitpid_result);
-	}
-	ret = 0;
-out:
-	current->policy = saved_policy;
-	return ret;
+	return ret < 0 ? ret : 0;
 }
 #endif /* CONFIG_KMOD */
 
-
 #ifdef CONFIG_HOTPLUG
 /*
 	hotplug path is set via /proc/sys
 	invoked by hotplug-aware bus drivers,
-	with exec_usermodehelper and some thread-spawner
+	with call_usermodehelper
 
 	argv [0] = hotplug_path;
 	argv [1] = "usb", "scsi", "pci", "network", etc;
@@ -294,7 +140,8 @@ struct subprocess_info {
 	char *path;
 	char **argv;
 	char **envp;
-	pid_t retval;
+	int wait;
+	int retval;
 };
 
 /*
@@ -307,13 +154,30 @@ static int ____call_usermodehelper(void 
 
 	retval = -EPERM;
 	if (current->fs->root)
-		retval = exec_usermodehelper(sub_info->path, sub_info->argv, sub_info->envp);
+		retval = execve(program_path, argv, envp);
 
 	/* Exec failed? */
-	sub_info->retval = (pid_t)retval;
+	sub_info->retval = retval;
 	do_exit(0);
 }
 
+/* Keventd can't block, but this (a child) can. */
+static int wait_for_helper(void *data)
+{
+	struct subprocess_info *sub_info = data;
+	pid_t pid;
+
+	pid = kernel_thread(____call_usermodehelper, sub_info,
+			    CLONE_VFORK | SIGCHLD);
+	if (pid < 0)
+		sub_info->retval = pid;
+	else
+		sys_wait4(pid, (unsigned int *)&sub_info->retval, 0, NULL);
+
+	complete(sub_info->complete);
+	return 0;
+}
+
 /*
  * This is run by keventd.
  */
@@ -322,14 +186,21 @@ static void __call_usermodehelper(void *
 	struct subprocess_info *sub_info = data;
 	pid_t pid;
 
-	/*
-	 * CLONE_VFORK: wait until the usermode helper has execve'd successfully
-	 * We need the data structures to stay around until that is done.
-	 */
-	pid = kernel_thread(____call_usermodehelper, sub_info, CLONE_VFORK | SIGCHLD);
-	if (pid < 0)
+	/* CLONE_VFORK: wait until the usermode helper has execve'd
+	 * successfully We need the data structures to stay around
+	 * until that is done.  */
+	if (sub_info->wait)
+		pid = kernel_thread(wait_for_helper, sub_info,
+				    CLONE_KERNEL | SIGCHLD);
+	else
+		pid = kernel_thread(____call_usermodehelper, sub_info,
+				    CLONE_VFORK | SIGCHLD);
+
+	if (pid < 0) {
 		sub_info->retval = pid;
-	complete(sub_info->complete);
+		complete(sub_info->complete);
+	} else if (!sub_info->wait)
+		complete(sub_info->complete);
 }
 
 /**
@@ -337,15 +208,17 @@ static void __call_usermodehelper(void *
  * @path: pathname for the application
  * @argv: null-terminated argument list
  * @envp: null-terminated environment list
+ * @wait: wait for the application to finish and return status.
  *
- * Runs a user-space application.  The application is started asynchronously.  It
- * runs as a child of keventd.  It runs with full root capabilities.  keventd silently
- * reaps the child when it exits.
+ * Runs a user-space application.  The application is started
+ * asynchronously if wait is not set, and runs as a child of keventd.
+ * (ie. it runs with full root capabilities).
  *
- * Must be called from process context.  Returns zero on success, else a negative
- * error code.
+ * Must be called from process context.  Returns a negative error code
+ * if program was not execed successfully, or (exitcode << 8 + signal)
+ * of the application (0 if wait is not set).
  */
-int call_usermodehelper(char *path, char **argv, char **envp)
+int call_usermodehelper(char *path, char **argv, char **envp, int wait)
 {
 	DECLARE_COMPLETION(done);
 	struct subprocess_info sub_info = {
@@ -353,6 +226,7 @@ int call_usermodehelper(char *path, char
 		.path		= path,
 		.argv		= argv,
 		.envp		= envp,
+		.wait		= wait,
 		.retval		= 0,
 	};
 	DECLARE_WORK(work, __call_usermodehelper, &sub_info);
@@ -390,7 +264,6 @@ void dev_probe_unlock(void)
 	up(&dev_probe_sem);
 }
 
-EXPORT_SYMBOL(exec_usermodehelper);
 EXPORT_SYMBOL(call_usermodehelper);
 
 #ifdef CONFIG_KMOD
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5-bk/arch/i386/mach-voyager/voyager_thread.c working-2.5-bk-kmod-noclean/arch/i386/mach-voyager/voyager_thread.c
--- linux-2.5-bk/arch/i386/mach-voyager/voyager_thread.c	2003-01-02 12:32:34.000000000 +1100
+++ working-2.5-bk-kmod-noclean/arch/i386/mach-voyager/voyager_thread.c	2003-01-06 16:24:54.000000000 +1100
@@ -57,7 +57,7 @@ voyager_thread_start(void)
 }
 
 static int
-execute_helper(void *string)
+execute(const char *string)
 {
 	int ret;
 
@@ -74,23 +74,14 @@ execute_helper(void *string)
 		NULL,
 	};
 
-	if((ret = exec_usermodehelper(argv[0], argv, envp)) < 0) {
-		printk(KERN_ERR "Voyager failed to execute \"%s\"\n",
-		       (char *)string);
+	if ((ret = call_usermodehelper(argv[0], argv, envp, 1)) != 0) {
+		printk(KERN_ERR "Voyager failed to run \"%s\": %i\n",
+		       string, ret);
 	}
 	return ret;
 }
 
 static void
-execute(char *string)
-{
-	if(kernel_thread(execute_helper, (void *)string, CLONE_VFORK | SIGCHLD) < 0) {
-		printk(KERN_ERR "Voyager failed to fork before exec of \"%s\"\n",
-		       string);
-	}
-}
-
-static void
 check_from_kernel(void)
 {
 	if(voyager_status.switch_off) {
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5-bk/drivers/acpi/thermal.c working-2.5-bk-kmod-noclean/drivers/acpi/thermal.c
--- linux-2.5-bk/drivers/acpi/thermal.c	2003-01-02 12:47:01.000000000 +1100
+++ working-2.5-bk-kmod-noclean/drivers/acpi/thermal.c	2003-01-06 15:43:53.000000000 +1100
@@ -431,7 +431,7 @@ acpi_thermal_call_usermode (
 	envp[0] = "HOME=/";
 	envp[1] = "PATH=/sbin:/bin:/usr/sbin:/usr/bin";
 	
-	call_usermodehelper(argv[0], argv, envp);
+	call_usermodehelper(argv[0], argv, envp, 0);
 
 	return_VALUE(0);
 }
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5-bk/drivers/base/hotplug.c working-2.5-bk-kmod-noclean/drivers/base/hotplug.c
--- linux-2.5-bk/drivers/base/hotplug.c	2003-01-02 12:46:16.000000000 +1100
+++ working-2.5-bk-kmod-noclean/drivers/base/hotplug.c	2003-01-06 15:43:53.000000000 +1100
@@ -114,7 +114,7 @@ static int do_hotplug (struct device *de
 
 	pr_debug ("%s: %s %s %s %s %s %s\n", __FUNCTION__, argv [0], argv[1],
 		  envp[0], envp[1], envp[2], envp[3]);
-	retval = call_usermodehelper (argv [0], argv, envp);
+	retval = call_usermodehelper (argv [0], argv, envp, 0);
 	if (retval)
 		pr_debug ("%s - call_usermodehelper returned %d\n",
 			  __FUNCTION__, retval);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5-bk/drivers/bluetooth/bt3c_cs.c working-2.5-bk-kmod-noclean/drivers/bluetooth/bt3c_cs.c
--- linux-2.5-bk/drivers/bluetooth/bt3c_cs.c	2003-01-02 12:35:09.000000000 +1100
+++ working-2.5-bk-kmod-noclean/drivers/bluetooth/bt3c_cs.c	2003-01-06 16:23:09.000000000 +1100
@@ -489,65 +489,22 @@ static int bt3c_hci_ioctl(struct hci_dev
 
 
 #define FW_LOADER  "/sbin/bluefw"
-static int errno;
-
-
-static int bt3c_fw_loader_exec(void *dev)
-{
-	char *argv[] = { FW_LOADER, "pccard", dev, NULL };
-	char *envp[] = { "HOME=/", "TERM=linux", "PATH=/sbin:/usr/sbin:/bin:/usr/bin", NULL };
-	int err;
-
-	err = exec_usermodehelper(FW_LOADER, argv, envp);
-	if (err)
-		printk(KERN_WARNING "bt3c_cs: Failed to exec \"%s pccard %s\".\n", FW_LOADER, (char *)dev);
-
-	return err;
-}
-
 
 static int bt3c_firmware_load(bt3c_info_t *info)
 {
-	sigset_t tmpsig;
 	char dev[16];
-	pid_t pid;
 	int result;
-
-	/* Check if root fs is mounted */
-	if (!current->fs->root) {
-		printk(KERN_WARNING "bt3c_cs: Root filesystem is not mounted.\n");
-		return -EPERM;
-	}
+	char *argv[] = { FW_LOADER, "pccard", dev, NULL };
+	char *envp[] = { "HOME=/", "TERM=linux", "PATH=/sbin:/usr/sbin:/bin:/usr/bin", NULL };
 
 	sprintf(dev, "%04x", info->link.io.BasePort1);
 
-	pid = kernel_thread(bt3c_fw_loader_exec, (void *)dev, 0);
-	if (pid < 0) {
-		printk(KERN_WARNING "bt3c_cs: Forking of kernel thread failed (errno=%d).\n", -pid);
-		return pid;
-	}
-
-	/* Block signals, everything but SIGKILL/SIGSTOP */
-	spin_lock_irq(&current->sig->siglock);
-	tmpsig = current->blocked;
-	siginitsetinv(&current->blocked, sigmask(SIGKILL) | sigmask(SIGSTOP));
-	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
-
-	result = waitpid(pid, NULL, __WCLONE);
-
-	/* Allow signals again */
-	spin_lock_irq(&current->sig->siglock);
-	current->blocked = tmpsig;
-	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
-
-	if (result != pid) {
-		printk(KERN_WARNING "bt3c_cs: Waiting for pid %d failed (errno=%d).\n", pid, -result);
-		return -result;
-	}
-
-	return 0;
+	result = call_usermodehelper(FW_LOADER, argv, envp, 1);
+	if (result)
+		printk(KERN_WARNING
+		       "bt3c_cs: Failed to run \"%s pccard %s\": %i.\n",
+		       FW_LOADER, dev, result);
+	return result;
 }
 
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5-bk/drivers/ieee1394/nodemgr.c working-2.5-bk-kmod-noclean/drivers/ieee1394/nodemgr.c
--- linux-2.5-bk/drivers/ieee1394/nodemgr.c	2003-01-02 12:46:17.000000000 +1100
+++ working-2.5-bk-kmod-noclean/drivers/ieee1394/nodemgr.c	2003-01-06 15:43:53.000000000 +1100
@@ -786,7 +786,7 @@ static void nodemgr_call_policy(char *ve
 #ifdef CONFIG_IEEE1394_VERBOSEDEBUG
 	HPSB_DEBUG("NodeMgr: %s %s %016Lx", argv[0], verb, (long long unsigned)ud->ne->guid);
 #endif
-	value = call_usermodehelper(argv[0], argv, envp);
+	value = call_usermodehelper(argv[0], argv, envp, 0);
 	kfree(buf);
 	kfree(envp);
 	if (value != 0)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5-bk/drivers/input/input.c working-2.5-bk-kmod-noclean/drivers/input/input.c
--- linux-2.5-bk/drivers/input/input.c	2003-01-02 12:30:27.000000000 +1100
+++ working-2.5-bk-kmod-noclean/drivers/input/input.c	2003-01-06 15:43:54.000000000 +1100
@@ -383,7 +383,7 @@ static void input_call_hotplug(char *ver
 		argv[0], argv[1], envp[0], envp[1], envp[2], envp[3], envp[4]);
 #endif
 
-	value = call_usermodehelper(argv [0], argv, envp);
+	value = call_usermodehelper(argv [0], argv, envp, 0);
 
 	kfree(buf);
 	kfree(envp);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5-bk/drivers/isdn/hardware/eicon/divasmain.c working-2.5-bk-kmod-noclean/drivers/isdn/hardware/eicon/divasmain.c
--- linux-2.5-bk/drivers/isdn/hardware/eicon/divasmain.c	2003-01-02 12:45:18.000000000 +1100
+++ working-2.5-bk-kmod-noclean/drivers/isdn/hardware/eicon/divasmain.c	2003-01-06 15:43:54.000000000 +1100
@@ -263,7 +263,7 @@ static void diva_adapter_trapped(void *c
 		pdpc->card_failed = 0;
 		argv[2] = &adapter[0];
 
-		ret = call_usermodehelper(argv[0], argv, envp);
+		ret = call_usermodehelper(argv[0], argv, envp, 0);
 
 		if (ret) {
 			printk(KERN_ERR
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5-bk/drivers/net/hamradio/baycom_epp.c working-2.5-bk-kmod-noclean/drivers/net/hamradio/baycom_epp.c
--- linux-2.5-bk/drivers/net/hamradio/baycom_epp.c	2003-01-02 14:47:58.000000000 +1100
+++ working-2.5-bk-kmod-noclean/drivers/net/hamradio/baycom_epp.c	2003-01-06 16:19:12.000000000 +1100
@@ -369,15 +369,14 @@ static char eppconfig_path[256] = "/usr/
 
 static char *envp[] = { "HOME=/", "TERM=linux", "PATH=/usr/bin:/bin", NULL };
 
-static int errno;
-
-static int exec_eppfpga(void *b)
+/* eppconfig: called during ifconfig up to configure the modem */
+static int eppconfig(struct baycom_state *bc)
 {
-	struct baycom_state *bc = (struct baycom_state *)b;
 	char modearg[256];
 	char portarg[16];
-        char *argv[] = { eppconfig_path, "-s", "-p", portarg, "-m", modearg, NULL};
-        int i;
+        char *argv[] = { eppconfig_path, "-s", "-p", portarg, "-m", modearg,
+			 NULL };
+        int ret;
 
 	/* set up arguments */
 	sprintf(modearg, "%sclk,%smodem,fclk=%d,bps=%d,divider=%d%s,extstat",
@@ -388,39 +387,7 @@ static int exec_eppfpga(void *b)
 	sprintf(portarg, "%ld", bc->pdev->port->base);
 	printk(KERN_DEBUG "%s: %s -s -p %s -m %s\n", bc_drvname, eppconfig_path, portarg, modearg);
 
-	i = exec_usermodehelper(eppconfig_path, argv, envp);
-	if (i < 0) {
-                printk(KERN_ERR "%s: failed to exec %s -s -p %s -m %s, errno = %d\n",
-                       bc_drvname, eppconfig_path, portarg, modearg, i);
-                return i;
-        }
-        return 0;
-}
-
-
-/* eppconfig: called during ifconfig up to configure the modem */
-
-static int eppconfig(struct baycom_state *bc)
-{
-        int i, pid, r;
-	mm_segment_t fs;
-
-        pid = kernel_thread(exec_eppfpga, bc, CLONE_FS);
-        if (pid < 0) {
-                printk(KERN_ERR "%s: fork failed, errno %d\n", bc_drvname, -pid);
-                return pid;
-        }
-	fs = get_fs();
-        set_fs(KERNEL_DS);      /* Allow i to be in kernel space. */
-	r = waitpid(pid, &i, __WCLONE);
-	set_fs(fs);
-        if (r != pid) {
-                printk(KERN_ERR "%s: waitpid(%d) failed, returning %d\n",
-		       bc_drvname, pid, r);
-		return -1;
-        }
-	printk(KERN_DEBUG "%s: eppfpga returned %d\n", bc_drvname, i);
-	return i;
+	return call_usermodehelper(eppconfig_path, argv, envp, 1);
 }
 
 /* ---------------------------------------------------------------------- */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5-bk/drivers/pnp/pnpbios/core.c working-2.5-bk-kmod-noclean/drivers/pnp/pnpbios/core.c
--- linux-2.5-bk/drivers/pnp/pnpbios/core.c	2003-01-02 14:47:59.000000000 +1100
+++ working-2.5-bk-kmod-noclean/drivers/pnp/pnpbios/core.c	2003-01-06 15:43:54.000000000 +1100
@@ -602,7 +602,7 @@ static int pnp_dock_event(int dock, stru
 		info->location_id, info->serial, info->capabilities);
 	envp[i] = 0;
 	
-	value = call_usermodehelper (argv [0], argv, envp);
+	value = call_usermodehelper (argv [0], argv, envp, 0);
 	kfree (buf);
 	kfree (envp);
 	return 0;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5-bk/net/bluetooth/hci_core.c working-2.5-bk-kmod-noclean/net/bluetooth/hci_core.c
--- linux-2.5-bk/net/bluetooth/hci_core.c	2003-01-02 12:33:56.000000000 +1100
+++ working-2.5-bk-kmod-noclean/net/bluetooth/hci_core.c	2003-01-06 15:43:54.000000000 +1100
@@ -114,7 +114,7 @@ static int hci_run_hotplug(char *dev, ch
 	envp[3] = astr;
 	envp[4] = NULL;
 	
-	return call_usermodehelper(argv[0], argv, envp);
+	return call_usermodehelper(argv[0], argv, envp, 0);
 }
 #else
 #define hci_run_hotplug(A...)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5-bk/net/core/dev.c working-2.5-bk-kmod-noclean/net/core/dev.c
--- linux-2.5-bk/net/core/dev.c	2003-01-02 14:48:01.000000000 +1100
+++ working-2.5-bk-kmod-noclean/net/core/dev.c	2003-01-06 15:43:54.000000000 +1100
@@ -2918,6 +2918,6 @@ static int net_run_sbin_hotplug(struct n
 	envp [i++] = action_str;
 	envp [i] = 0;
 
-	return call_usermodehelper(argv [0], argv, envp);
+	return call_usermodehelper(argv [0], argv, envp, 0);
 }
 #endif
