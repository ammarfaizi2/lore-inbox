Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265063AbTABJ2N>; Thu, 2 Jan 2003 04:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265095AbTABJ2N>; Thu, 2 Jan 2003 04:28:13 -0500
Received: from dp.samba.org ([66.70.73.150]:54209 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265063AbTABJ2I>;
	Thu, 2 Jan 2003 04:28:08 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, akpm@zip.com.au,
       Thomas Sailer <sailer@ife.ee.ethz.ch>,
       Marcel Holtmann <marcel@holtmann.org>,
       Jose Orlando Pereira <jop@di.uminho.pt>,
       J.E.J.Bottomley@HansenPartnership.com
Subject: [PATCH] Deprecate exec_usermodehelper, fix request_module.
Date: Thu, 02 Jan 2003 20:36:05 +1100
Message-Id: <20030102093637.8C6892C2FB@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got a report from Urban Widmark that modprobe dropped its privs on
executing an install command: turns out request_module
(ie. exec_usermodehelper) doesn't set the real uid or gid (so bash
drops privs).

These efforts to "clean" the current process are *always* going to be
buggy: we should use the event thread all the time, rather than
forking a random thread and trying to clean it.  This fixes
request_module to do that (kevent threads can't block, so we
double-fork).

There are still three
(obscure) users of exec_usermodehelper in the tree:

	drivers/net/hamradio/baycom_epp.c
	drivers/bluetooth/bt3c_cs.c
	arch/i386/mach-voyager/voyager_thread.c

Any comments? (Patch size due to some required reshuffling).
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Make request_module use call_usermodehelper
Author: Rusty Russell
Status: Tested on 2.5.54

D: Urban Widmark points out that modprobe calls system() in many
D: configurations, which drops privs since request_module() doesn't
D: doesn't set ruid and rguid.
D:
D: Use a known-clean environment (as call_usermodehelper does).
D: Deprecate exec_usermodehelper, since it's probably buggy, maybe
D: exploitable.

diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.54/include/linux/kmod.h working-2.5.54-kmod/include/linux/kmod.h
--- linux-2.5.54/include/linux/kmod.h	Thu Jan  2 12:35:15 2003
+++ working-2.5.54-kmod/include/linux/kmod.h	Thu Jan  2 16:44:17 2003
@@ -21,6 +21,7 @@
 
 #include <linux/config.h>
 #include <linux/errno.h>
+#include <linux/compiler.h>
 
 #ifdef CONFIG_KMOD
 extern int request_module(const char * name);
@@ -29,7 +30,7 @@ static inline int request_module(const c
 #endif
 
 #define try_then_request_module(x, mod) ((x) ?: request_module(mod), (x))
-extern int exec_usermodehelper(char *program_path, char *argv[], char *envp[]);
+extern int exec_usermodehelper(char *program_path, char *argv[], char *envp[])  __deprecated;
 extern int call_usermodehelper(char *path, char *argv[], char *envp[]);
 
 #ifdef CONFIG_HOTPLUG
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.54/kernel/kmod.c working-2.5.54-kmod/kernel/kmod.c
--- linux-2.5.54/kernel/kmod.c	Thu Jan  2 12:37:03 2003
+++ working-2.5.54-kmod/kernel/kmod.c	Thu Jan  2 20:15:52 2003
@@ -14,8 +14,10 @@
 
 	Unblock all signals when we exec a usermode process.
 	Shuu Yamaguchi <shuu@wondernetworkresources.com> December 2000
-*/
 
+	Fixed request_module to use call_usermodehelper path.  Jan 2003.
+	Rusty Russell <rusty@rustcorp.com.au>
+*/
 #define __KERNEL_SYSCALLS__
 
 #include <linux/config.h>
@@ -31,6 +33,7 @@
 #include <linux/workqueue.h>
 #include <linux/security.h>
 #include <linux/mount.h>
+#include <linux/kernel.h>
 #include <asm/uaccess.h>
 
 extern int max_threads, system_running;
@@ -141,41 +144,87 @@ int exec_usermodehelper(char *program_pa
 	set_fs(KERNEL_DS);
 
 	/* Go, go, go... */
+	printk("Execing %s\n", program_path);
 	if (execve(program_path, argv, envp) < 0)
 		return -errno;
 	return 0;
 }
 
-#ifdef CONFIG_KMOD
+struct subprocess_info {
+	struct completion *complete;
+	char *path;
+	char **argv;
+	char **envp;
+	int wait;
+	pid_t retval;
+};
 
 /*
-	modprobe_path is set via /proc/sys.
-*/
-char modprobe_path[256] = "/sbin/modprobe";
+ * This is the task which runs the usermode application
+ */
+static int ____call_usermodehelper(void *data)
+{
+	struct subprocess_info *sub_info = data;
+	int retval;
 
-static int exec_modprobe(void * module_name)
+	retval = -EPERM;
+	if (current->fs->root)
+		retval = exec_usermodehelper(sub_info->path, sub_info->argv, sub_info->envp);
+
+	/* Exec failed? */
+	sub_info->retval = (pid_t)retval;
+	do_exit(0);
+}
+
+/* Keventd can't block, but this (a child) can. */
+static int wait_for_helper(void *data)
 {
-	static char * envp[] = { "HOME=/", "TERM=linux", "PATH=/sbin:/usr/sbin:/bin:/usr/bin", NULL };
-	char *argv[] = { modprobe_path, "--", (char*)module_name, NULL };
-	int ret;
+	struct subprocess_info *sub_info = data;
+	pid_t pid;
 
-	if (!system_running)
-		return -EBUSY;
+	pid = kernel_thread(____call_usermodehelper, sub_info,
+			    CLONE_VFORK | SIGCHLD);
+	if (pid < 0)
+		sub_info->retval = pid;
+	else
+		sys_wait4(pid, NULL, 0, NULL);
 
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
+	complete(sub_info->complete);
+	return 0;
+}
+
+/*
+ * This is run by keventd.
+ */
+static void __call_usermodehelper(void *data)
+{
+	struct subprocess_info *sub_info = data;
+	pid_t pid;
+
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
+		sub_info->retval = pid;
+		complete(sub_info->complete);
+	} else if (!sub_info->wait)
+		complete(sub_info->complete);
 }
 
+#ifdef CONFIG_KMOD
+
+/*
+	modprobe_path is set via /proc/sys.
+*/
+char modprobe_path[256] = "/sbin/modprobe";
+
 /**
  * request_module - try to load a kernel module
  * @module_name: Name of module
@@ -189,24 +238,33 @@ static int exec_modprobe(void * module_n
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
+	DECLARE_COMPLETION(done);
+	char *argv[] = { modprobe_path, "--", (char*)module_name, NULL };
+	static char *envp[] = { "HOME=/",
+				"TERM=linux",
+				"PATH=/sbin:/usr/sbin:/bin:/usr/bin",
+				NULL };
+	struct subprocess_info sub_info = {
+		.complete	= &done,
+		.path		= modprobe_path,
+		.argv		= argv,
+		.envp		= envp,
+		.wait		= 1, /* We need to wait. */
+		.retval		= 0,
+	};
+	DECLARE_WORK(work, __call_usermodehelper, &sub_info);
 	static atomic_t kmod_concurrent = ATOMIC_INIT(0);
 #define MAX_KMOD_CONCURRENT 50	/* Completely arbitrary value - KAO */
 	static int kmod_loop_msg;
-	unsigned long saved_policy = current->policy;
 
-	current->policy = SCHED_NORMAL;
-	/* Don't allow request_module() when the system isn't set up */
-	if ( ! system_running ) {
-		printk(KERN_ERR "request_module[%s]: not ready\n", module_name);
-		ret = -EPERM;
-		goto out;
-	}
+	if (!system_running)
+		return -EBUSY;
+
+	if (modprobe_path[0] == '\0')
+		return 0;
 
 	/* If modprobe needs a service that is in a module, we get a recursive
 	 * loop.  Limit the number of running kmod threads to max_threads/2 or
@@ -216,52 +274,39 @@ int request_module(const char * module_n
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
-		atomic_dec(&kmod_concurrent);
-		ret = -ENOMEM;
-		goto out;
-	}
-
-	pid = kernel_thread(exec_modprobe, (void*) module_name, 0);
-	if (pid < 0) {
-		printk(KERN_ERR "request_module[%s]: fork failed, errno %d\n", module_name, -pid);
+			       "request_module: runaway loop modprobe %s\n",
+			       module_name);
 		atomic_dec(&kmod_concurrent);
-		ret = pid;
-		goto out;
+		return -ENOMEM;
 	}
 
-	/* Block everything but SIGKILL/SIGSTOP */
-	spin_lock_irq(&current->sig->siglock);
-	tmpsig = current->blocked;
-	siginitsetinv(&current->blocked, sigmask(SIGKILL) | sigmask(SIGSTOP));
-	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
-
-	waitpid_result = waitpid(pid, NULL, __WCLONE);
-	atomic_dec(&kmod_concurrent);
-
-	/* Allow signals again.. */
-	spin_lock_irq(&current->sig->siglock);
-	current->blocked = tmpsig;
-	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
+	schedule_work(&work);
+	wait_for_completion(&done);
 
-	if (waitpid_result != pid) {
-		printk(KERN_ERR "request_module[%s]: waitpid(%d,...) failed, errno %d\n",
-		       module_name, pid, -waitpid_result);
+	/* This is exec failing, not modprobe failing. */
+	if (sub_info.retval < 0) {
+		static unsigned long last;
+		unsigned long now = jiffies;
+		if (now - last > HZ) {
+			last = now;
+			printk(KERN_DEBUG
+			       "request_module: failed %s -- %s. error = %d\n",
+			       modprobe_path, module_name, sub_info.retval);
+		}
 	}
-	ret = 0;
-out:
-	current->policy = saved_policy;
-	return ret;
+	atomic_dec(&kmod_concurrent);
+	return sub_info.retval;
 }
 #endif /* CONFIG_KMOD */
 
@@ -289,49 +334,6 @@ EXPORT_SYMBOL(hotplug_path);
 
 #endif /* CONFIG_HOTPLUG */
 
-struct subprocess_info {
-	struct completion *complete;
-	char *path;
-	char **argv;
-	char **envp;
-	pid_t retval;
-};
-
-/*
- * This is the task which runs the usermode application
- */
-static int ____call_usermodehelper(void *data)
-{
-	struct subprocess_info *sub_info = data;
-	int retval;
-
-	retval = -EPERM;
-	if (current->fs->root)
-		retval = exec_usermodehelper(sub_info->path, sub_info->argv, sub_info->envp);
-
-	/* Exec failed? */
-	sub_info->retval = (pid_t)retval;
-	do_exit(0);
-}
-
-/*
- * This is run by keventd.
- */
-static void __call_usermodehelper(void *data)
-{
-	struct subprocess_info *sub_info = data;
-	pid_t pid;
-
-	/*
-	 * CLONE_VFORK: wait until the usermode helper has execve'd successfully
-	 * We need the data structures to stay around until that is done.
-	 */
-	pid = kernel_thread(____call_usermodehelper, sub_info, CLONE_VFORK | SIGCHLD);
-	if (pid < 0)
-		sub_info->retval = pid;
-	complete(sub_info->complete);
-}
-
 /**
  * call_usermodehelper - start a usermode application
  * @path: pathname for the application
@@ -353,6 +355,7 @@ int call_usermodehelper(char *path, char
 		.path		= path,
 		.argv		= argv,
 		.envp		= envp,
+		.wait		= 0,
 		.retval		= 0,
 	};
 	DECLARE_WORK(work, __call_usermodehelper, &sub_info);
