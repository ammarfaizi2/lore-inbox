Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265603AbTAFBqF>; Sun, 5 Jan 2003 20:46:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265643AbTAFBqF>; Sun, 5 Jan 2003 20:46:05 -0500
Received: from dp.samba.org ([66.70.73.150]:55982 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265603AbTAFBqA>;
	Sun, 5 Jan 2003 20:46:00 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, akpm@zip.com.au,
       Thomas Sailer <sailer@ife.ee.ethz.ch>,
       Marcel Holtmann <marcel@holtmann.org>,
       Jose Orlando Pereira <jop@di.uminho.pt>,
       J.E.J.Bottomley@HansenPartnership.com
Subject: [PATCH] Deprecated exec_usermodehelper, enhance call_usermodehelper
Date: Mon, 06 Jan 2003 12:47:43 +1100
Message-Id: <20030106015436.B5FC22C10E@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.

Adds a wait flag to call_usermodehelper, which makes it double-fork
off keventd (so it can wait), and return the child's exit status.

Once the three exec_usermodehelper pieces are converted, we can get
rid of the horrible (probably buggy) "try to clean up this process to
look like init" code, and the sun will come out, birds will start
singing, hackers will run joyfully through the streets, etc.

Thanks for the feedback!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: call_usermodehelper can wait for us: exec_usermodehelper sucks
Author: Rusty Russell
Status: Tested on 2.5.54

D: Urban Widmark points out that modprobe calls system() in many
D: configurations, which drops privs since request_module() doesn't
D: doesn't set ruid and rguid.
D:
D: Use a known-clean environment (as call_usermodehelper does).
D: Deprecate exec_usermodehelper, since it's probably buggy, maybe
D: exploitable.

diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5-bk/include/linux/kmod.h working-2.5-bk-kmod-noclean/include/linux/kmod.h
--- linux-2.5-bk/include/linux/kmod.h	Thu Jan  2 12:35:15 2003
+++ working-2.5-bk-kmod-noclean/include/linux/kmod.h	Fri Jan  3 14:50:30 2003
@@ -21,6 +21,7 @@
 
 #include <linux/config.h>
 #include <linux/errno.h>
+#include <linux/compiler.h>
 
 #ifdef CONFIG_KMOD
 extern int request_module(const char * name);
@@ -29,8 +30,8 @@ static inline int request_module(const c
 #endif
 
 #define try_then_request_module(x, mod) ((x) ?: request_module(mod), (x))
-extern int exec_usermodehelper(char *program_path, char *argv[], char *envp[]);
-extern int call_usermodehelper(char *path, char *argv[], char *envp[]);
+extern int exec_usermodehelper(char *program_path, char *argv[], char *envp[])  __deprecated;
+extern int call_usermodehelper(char *path, char *argv[], char *envp[], int wait);
 
 #ifdef CONFIG_HOTPLUG
 extern char hotplug_path [];
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5-bk/kernel/kmod.c working-2.5-bk-kmod-noclean/kernel/kmod.c
--- linux-2.5-bk/kernel/kmod.c	Thu Jan  2 12:37:03 2003
+++ working-2.5-bk-kmod-noclean/kernel/kmod.c	Fri Jan  3 16:02:55 2003
@@ -14,8 +14,10 @@
 
 	Unblock all signals when we exec a usermode process.
 	Shuu Yamaguchi <shuu@wondernetworkresources.com> December 2000
-*/
 
+	call_usermodehelper wait flag, and deprecate exec_usermodehelper.
+	Rusty Russell <rusty@rustcorp.com.au>  Jan 2003
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
@@ -153,29 +156,6 @@ int exec_usermodehelper(char *program_pa
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
@@ -189,24 +169,18 @@ static int exec_modprobe(void * module_n
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
@@ -216,56 +190,39 @@ int request_module(const char * module_n
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
@@ -294,7 +251,8 @@ struct subprocess_info {
 	char *path;
 	char **argv;
 	char **envp;
-	pid_t retval;
+	int wait;
+	int retval;
 };
 
 /*
@@ -310,10 +268,27 @@ static int ____call_usermodehelper(void 
 		retval = exec_usermodehelper(sub_info->path, sub_info->argv, sub_info->envp);
 
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
@@ -322,14 +297,21 @@ static void __call_usermodehelper(void *
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
@@ -337,15 +319,17 @@ static void __call_usermodehelper(void *
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
@@ -353,6 +337,7 @@ int call_usermodehelper(char *path, char
 		.path		= path,
 		.argv		= argv,
 		.envp		= envp,
+		.wait		= wait,
 		.retval		= 0,
 	};
 	DECLARE_WORK(work, __call_usermodehelper, &sub_info);
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5-bk/drivers/acpi/thermal.c working-2.5-bk-kmod-noclean/drivers/acpi/thermal.c
--- linux-2.5-bk/drivers/acpi/thermal.c	Thu Jan  2 12:47:01 2003
+++ working-2.5-bk-kmod-noclean/drivers/acpi/thermal.c	Fri Jan  3 14:50:30 2003
@@ -431,7 +431,7 @@ acpi_thermal_call_usermode (
 	envp[0] = "HOME=/";
 	envp[1] = "PATH=/sbin:/bin:/usr/sbin:/usr/bin";
 	
-	call_usermodehelper(argv[0], argv, envp);
+	call_usermodehelper(argv[0], argv, envp, 0);
 
 	return_VALUE(0);
 }
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5-bk/drivers/base/hotplug.c working-2.5-bk-kmod-noclean/drivers/base/hotplug.c
--- linux-2.5-bk/drivers/base/hotplug.c	Thu Jan  2 12:46:16 2003
+++ working-2.5-bk-kmod-noclean/drivers/base/hotplug.c	Fri Jan  3 14:50:30 2003
@@ -114,7 +114,7 @@ static int do_hotplug (struct device *de
 
 	pr_debug ("%s: %s %s %s %s %s %s\n", __FUNCTION__, argv [0], argv[1],
 		  envp[0], envp[1], envp[2], envp[3]);
-	retval = call_usermodehelper (argv [0], argv, envp);
+	retval = call_usermodehelper (argv [0], argv, envp, 0);
 	if (retval)
 		pr_debug ("%s - call_usermodehelper returned %d\n",
 			  __FUNCTION__, retval);
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5-bk/drivers/ieee1394/nodemgr.c working-2.5-bk-kmod-noclean/drivers/ieee1394/nodemgr.c
--- linux-2.5-bk/drivers/ieee1394/nodemgr.c	Thu Jan  2 12:46:17 2003
+++ working-2.5-bk-kmod-noclean/drivers/ieee1394/nodemgr.c	Fri Jan  3 14:50:30 2003
@@ -786,7 +786,7 @@ static void nodemgr_call_policy(char *ve
 #ifdef CONFIG_IEEE1394_VERBOSEDEBUG
 	HPSB_DEBUG("NodeMgr: %s %s %016Lx", argv[0], verb, (long long unsigned)ud->ne->guid);
 #endif
-	value = call_usermodehelper(argv[0], argv, envp);
+	value = call_usermodehelper(argv[0], argv, envp, 0);
 	kfree(buf);
 	kfree(envp);
 	if (value != 0)
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5-bk/drivers/input/input.c working-2.5-bk-kmod-noclean/drivers/input/input.c
--- linux-2.5-bk/drivers/input/input.c	Thu Jan  2 12:30:27 2003
+++ working-2.5-bk-kmod-noclean/drivers/input/input.c	Fri Jan  3 14:50:30 2003
@@ -383,7 +383,7 @@ static void input_call_hotplug(char *ver
 		argv[0], argv[1], envp[0], envp[1], envp[2], envp[3], envp[4]);
 #endif
 
-	value = call_usermodehelper(argv [0], argv, envp);
+	value = call_usermodehelper(argv [0], argv, envp, 0);
 
 	kfree(buf);
 	kfree(envp);
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5-bk/drivers/isdn/hardware/eicon/divasmain.c working-2.5-bk-kmod-noclean/drivers/isdn/hardware/eicon/divasmain.c
--- linux-2.5-bk/drivers/isdn/hardware/eicon/divasmain.c	Thu Jan  2 12:45:18 2003
+++ working-2.5-bk-kmod-noclean/drivers/isdn/hardware/eicon/divasmain.c	Fri Jan  3 14:50:30 2003
@@ -263,7 +263,7 @@ static void diva_adapter_trapped(void *c
 		pdpc->card_failed = 0;
 		argv[2] = &adapter[0];
 
-		ret = call_usermodehelper(argv[0], argv, envp);
+		ret = call_usermodehelper(argv[0], argv, envp, 0);
 
 		if (ret) {
 			printk(KERN_ERR
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5-bk/drivers/pnp/pnpbios/core.c working-2.5-bk-kmod-noclean/drivers/pnp/pnpbios/core.c
--- linux-2.5-bk/drivers/pnp/pnpbios/core.c	Thu Jan  2 14:47:59 2003
+++ working-2.5-bk-kmod-noclean/drivers/pnp/pnpbios/core.c	Fri Jan  3 14:50:30 2003
@@ -602,7 +602,7 @@ static int pnp_dock_event(int dock, stru
 		info->location_id, info->serial, info->capabilities);
 	envp[i] = 0;
 	
-	value = call_usermodehelper (argv [0], argv, envp);
+	value = call_usermodehelper (argv [0], argv, envp, 0);
 	kfree (buf);
 	kfree (envp);
 	return 0;
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5-bk/net/bluetooth/hci_core.c working-2.5-bk-kmod-noclean/net/bluetooth/hci_core.c
--- linux-2.5-bk/net/bluetooth/hci_core.c	Thu Jan  2 12:33:56 2003
+++ working-2.5-bk-kmod-noclean/net/bluetooth/hci_core.c	Fri Jan  3 14:50:30 2003
@@ -114,7 +114,7 @@ static int hci_run_hotplug(char *dev, ch
 	envp[3] = astr;
 	envp[4] = NULL;
 	
-	return call_usermodehelper(argv[0], argv, envp);
+	return call_usermodehelper(argv[0], argv, envp, 0);
 }
 #else
 #define hci_run_hotplug(A...)
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5-bk/net/core/dev.c working-2.5-bk-kmod-noclean/net/core/dev.c
--- linux-2.5-bk/net/core/dev.c	Thu Jan  2 14:48:01 2003
+++ working-2.5-bk-kmod-noclean/net/core/dev.c	Fri Jan  3 14:50:30 2003
@@ -2918,6 +2918,6 @@ static int net_run_sbin_hotplug(struct n
 	envp [i++] = action_str;
 	envp [i] = 0;
 
-	return call_usermodehelper(argv [0], argv, envp);
+	return call_usermodehelper(argv [0], argv, envp, 0);
 }
 #endif
