Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265847AbUGTNwu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265847AbUGTNwu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 09:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265872AbUGTNwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 09:52:50 -0400
Received: from cantor.suse.de ([195.135.220.2]:37507 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265847AbUGTNwl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 09:52:41 -0400
Message-ID: <40FD23A8.6090409@suse.de>
Date: Tue, 20 Jul 2004 15:52:40 +0200
From: Hannes Reinecke <hare@suse.de>
Organization: SuSE Linux AG
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.6) Gecko/20040114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: hotplug <linux-hotplug-devel@lists.sourceforge.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Limit number of concurrent hotplug processes
Content-Type: multipart/mixed;
 boundary="------------070806040909070002060109"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070806040909070002060109
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Hi all,

the attached patch limits the number of concurrent hotplug processes.
Main idea behind it is that currently each call to call_usermodehelper 
will result in an execve() of "/sbin/hotplug", without any check whether 
enough resources are available for successful execution. This leads to 
hotplug being stuck and in worst cases to machines being unable to boot.

This check cannot be implemented in userspace as the resources are 
already taken by the time any resource check can be done; for the same 
reason any 'slim' programs as /sbin/hotplug will only delay the problem.

Any comments/suggestions welcome; otherwise please apply.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke			hare@suse.de
SuSE Linux AG				S390 & zSeries
Maxfeldstraße 5				+49 911 74053 688
90409 Nürnberg				http://www.suse.de

--------------070806040909070002060109
Content-Type: text/x-patch;
 name="kmod_limit_processes.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kmod_limit_processes.patch"

--- linux-2.6.8-rc1/kernel/kmod.c.orig	2004-07-14 15:55:41.000000000 +0200
+++ linux-2.6.8-rc1/kernel/kmod.c	2004-07-20 16:40:25.424425628 +0200
@@ -41,6 +41,9 @@
 extern int max_threads;
 
 static struct workqueue_struct *khelper_wq;
+static wait_queue_head_t kmod_waitq;
+static atomic_t kmod_concurrent = ATOMIC_INIT(50);
+static int kmod_max_concurrent = 50;
 
 #ifdef CONFIG_KMOD
 
@@ -67,16 +70,12 @@ int request_module(const char *fmt, ...)
 {
 	va_list args;
 	char module_name[MODULE_NAME_LEN];
-	unsigned int max_modprobes;
 	int ret;
 	char *argv[] = { modprobe_path, "-q", "--", module_name, NULL };
 	static char *envp[] = { "HOME=/",
 				"TERM=linux",
 				"PATH=/sbin:/usr/sbin:/bin:/usr/bin",
 				NULL };
-	static atomic_t kmod_concurrent = ATOMIC_INIT(0);
-#define MAX_KMOD_CONCURRENT 50	/* Completely arbitrary value - KAO */
-	static int kmod_loop_msg;
 
 	va_start(args, fmt);
 	ret = vsnprintf(module_name, MODULE_NAME_LEN, fmt, args);
@@ -95,21 +94,11 @@ int request_module(const char *fmt, ...)
 	 *
 	 * "trace the ppid" is simple, but will fail if someone's
 	 * parent exits.  I think this is as good as it gets. --RR
+	 *
+	 * Resource checking is now implemented in 
+	 * call_usermodehelper --hare
 	 */
-	max_modprobes = min(max_threads/2, MAX_KMOD_CONCURRENT);
-	atomic_inc(&kmod_concurrent);
-	if (atomic_read(&kmod_concurrent) > max_modprobes) {
-		/* We may be blaming an innocent here, but unlikely */
-		if (kmod_loop_msg++ < 5)
-			printk(KERN_ERR
-			       "request_module: runaway loop modprobe %s\n",
-			       module_name);
-		atomic_dec(&kmod_concurrent);
-		return -ENOMEM;
-	}
-
 	ret = call_usermodehelper(modprobe_path, argv, envp, 1);
-	atomic_dec(&kmod_concurrent);
 	return ret;
 }
 EXPORT_SYMBOL(request_module);
@@ -181,6 +170,21 @@ static int wait_for_helper(void *data)
 	struct subprocess_info *sub_info = data;
 	pid_t pid;
 	struct k_sigaction sa;
+	int flags = SIGCHLD, retval, wait = sub_info->wait;
+
+	if (atomic_dec_and_test(&kmod_concurrent)) {
+		/* 
+		 * We have exceeded the maximum number of
+		 * concurrent kmod invocations. Delay this process
+		 * until enough resources are available again.
+		 */
+		printk(KERN_INFO "Delaying kmod event (current %d, max %d)\n",
+		       atomic_read(&kmod_concurrent), kmod_max_concurrent);
+		wait_event(kmod_waitq,
+			   atomic_read(&kmod_concurrent) > 0);
+	}
+	printk(KERN_INFO "Exec kmod event (current %d, max %d)\n",
+	       atomic_read(&kmod_concurrent), kmod_max_concurrent);
 
 	/* Install a handler: if SIGCLD isn't handled sys_wait4 won't
 	 * populate the status, but will return -ECHILD. */
@@ -190,10 +194,29 @@ static int wait_for_helper(void *data)
 	do_sigaction(SIGCHLD, &sa, (struct k_sigaction *)0);
 	allow_signal(SIGCHLD);
 
-	pid = kernel_thread(____call_usermodehelper, sub_info, SIGCHLD);
+	if (!wait) {
+		/* CLONE_VFORK: wait until the usermode helper has execve'd
+		 * successfully We need the data structures to stay around
+		 * until that is done.  */
+		flags |= CLONE_VFORK;
+	}
+
+	pid = kernel_thread(____call_usermodehelper, sub_info, flags);
 	if (pid < 0) {
 		sub_info->retval = pid;
-	} else {
+		complete(sub_info->complete);
+		return 0;
+	}
+	/* 
+	 * usermodehelper started successfully
+	 * We always block for the child to exit as we want to
+	 * keep track of the number of currently running processes.
+	 * The only difference between asynchonous and synchronous
+	 * is that we notify the caller immediately for the former case
+	 * and delay the notification until the child exited for the 
+	 * latter.
+	 */
+	if (wait) {
 		/*
 		 * Normally it is bogus to call wait4() from in-kernel because
 		 * wait4() wants to write the exit code to a userspace address.
@@ -205,8 +228,23 @@ static int wait_for_helper(void *data)
 		 */
 		sys_wait4(pid, (int __user *) &sub_info->retval, 0, NULL);
 	}
-
+	/* Return the correct return value (if any) and notify caller */
 	complete(sub_info->complete);
+	
+	/* sub_info is not valid anymore, we need to use local variables */
+	if (!wait) {
+		/*
+		 * Wait for the child; we should only decrement the
+		 * counter after the child has indeed exited
+		 */
+		sys_wait4(pid, (int __user *) &retval, 0, NULL);
+	}
+	/* Increment the counter, we're done here */
+	atomic_inc(&kmod_concurrent);
+
+	/* Wake any sleeping kmod invocations */
+	wake_up(&kmod_waitq);
+
 	return 0;
 }
 
@@ -216,21 +254,13 @@ static void __call_usermodehelper(void *
 	struct subprocess_info *sub_info = data;
 	pid_t pid;
 
-	/* CLONE_VFORK: wait until the usermode helper has execve'd
-	 * successfully We need the data structures to stay around
-	 * until that is done.  */
-	if (sub_info->wait)
-		pid = kernel_thread(wait_for_helper, sub_info,
-				    CLONE_FS | CLONE_FILES | SIGCHLD);
-	else
-		pid = kernel_thread(____call_usermodehelper, sub_info,
-				    CLONE_VFORK | SIGCHLD);
+	pid = kernel_thread(wait_for_helper, sub_info,
+			    CLONE_FS | CLONE_FILES | SIGCHLD);
 
 	if (pid < 0) {
 		sub_info->retval = pid;
 		complete(sub_info->complete);
-	} else if (!sub_info->wait)
-		complete(sub_info->complete);
+	}
 }
 
 /**
@@ -276,4 +306,32 @@ void __init usermodehelper_init(void)
 {
 	khelper_wq = create_singlethread_workqueue("khelper");
 	BUG_ON(!khelper_wq);
+	init_waitqueue_head(&kmod_waitq);
+
+	/*
+	 * Limit the max number of concurrent processes
+	 * to something sane; 10 - max_threads/2 seems ok.
+	 */
+	if (kmod_max_concurrent > max_threads/2)
+		kmod_max_concurrent = max_threads/2;
+	if (kmod_max_concurrent < 10)
+		kmod_max_concurrent = 10;
+
+	printk(KERN_INFO "kmod: max %d concurrent processes\n",
+	       kmod_max_concurrent);
+	atomic_set(&kmod_concurrent,kmod_max_concurrent);
 }
+
+/*
+ * We want to restrict the maximum number of concurrent processes
+ * to max_threads / 2; however, at this time max_threads is not 
+ * yet initialised. So we will do the real check in usermodehelper_init().
+ */
+static int __init kmod_setup(char *s)
+{
+	get_option(&s, &kmod_max_concurrent);
+
+	return 1;
+}
+__setup("kmod_max=", kmod_setup);
+

--------------070806040909070002060109--
