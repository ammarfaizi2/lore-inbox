Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266409AbUHCNhM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266409AbUHCNhM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 09:37:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266425AbUHCNhM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 09:37:12 -0400
Received: from cantor.suse.de ([195.135.220.2]:46279 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266409AbUHCNgj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 09:36:39 -0400
Message-ID: <410F94C6.6000200@suse.de>
Date: Tue, 03 Aug 2004 15:36:06 +0200
From: Hannes Reinecke <hare@suse.de>
Organization: SuSE Linux AG
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.6) Gecko/20040114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: hotplug <linux-hotplug-devel@lists.sourceforge.net>
Subject: [PATCH] restrict number of hotplug processes (Take 2)
Content-Type: multipart/mixed;
 boundary="------------000809050102090207010408"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000809050102090207010408
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Hi all,

the attached patch (relative to 2.6.8-rc2-mm2) restricts the number of 
concurrently running hotplug  / kmod processes. It's an update to the 
patch posted earlier, adapted to suggestions by Andrew Morton (THX for 
that, Andrew).

The current design of call_usermodehelper has the disadvantage that 
always a kernel thread is started without checking whether enough 
resources are available. This makes it possible to run any machine out 
of memory by just generating enough hotplug processes.

The patch introduces a semaphore khelper_sem, which is initialised with 
the maximum number of concurrently running hotplug processes. When the 
semaphore count hits zero, the process is either blocked (if its an 
synchronous process) or delayed by returning control to the calling 
function prior to call down(). In either case we have to wait for the 
helper thread to finish, as we have to up() the semaphore and free up 
the process information.

Note that we have to copy the process information in case the hotplug 
event gets delayed, as originally the process information is allocated 
locally to the calling function, which is lost after control is returned.

Please apply.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke			hare@suse.de
SuSE Linux AG				S390 & zSeries
Maxfeldstraße 5				+49 911 74053 688
90409 Nürnberg				http://www.suse.de

--------------000809050102090207010408
Content-Type: text/x-patch;
 name="khelper_restrict_maxnum.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="khelper_restrict_maxnum.patch"

diff -purN linux-2.6.8-rc2-mm2/kernel/kmod.c linux-2.6.8-rc2-mm2.hotplug/kernel/kmod.c
--- linux-2.6.8-rc2-mm2/kernel/kmod.c	2004-08-03 14:58:15.000000000 +0200
+++ linux-2.6.8-rc2-mm2.hotplug/kernel/kmod.c	2004-08-03 15:21:35.000000000 +0200
@@ -17,6 +17,9 @@
 
 	call_usermodehelper wait flag, and remove exec_usermodehelper.
 	Rusty Russell <rusty@rustcorp.com.au>  Jan 2003
+
+	resource management for call_usermodehelper
+	Hannes Reinecke <hare@suse.de> Jul 2004
 */
 #define __KERNEL_SYSCALLS__
 
@@ -41,6 +44,8 @@
 extern int max_threads;
 
 static struct workqueue_struct *khelper_wq;
+int khelper_max = 50;
+static struct semaphore khelper_sem;
 
 #ifdef CONFIG_KMOD
 
@@ -67,16 +72,12 @@ int request_module(const char *fmt, ...)
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
@@ -95,21 +96,11 @@ int request_module(const char *fmt, ...)
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
@@ -175,12 +166,98 @@ static int ____call_usermodehelper(void 
 	do_exit(0);
 }
 
+/* 
+ * Copy process args
+ */
+void khelper_copy_info(struct subprocess_info *orig, 
+		       struct subprocess_info *new)
+{
+	int ie, ia, l;
+	char *p;
+
+	l = 0;
+	if (orig->path)
+	    l += strlen(orig->path) + 1;
+	
+	ia = 0;
+	while (orig->argv[ia] && ia < 7) {
+		l += strlen(orig->argv[ia]) + 1;
+		ia++;
+	}
+	l += sizeof(char *) * (ia + 1);
+	ie = 0;
+	while (orig->envp[ie] && ie < 31) {
+		l += strlen(orig->envp[ie]) + 1;
+		ie++;
+	}
+	l += sizeof(char *) * (ie + 1);
+
+	new->path = kmalloc(l, GFP_KERNEL);
+	if (!new->path)
+	    return;
+	memset(new->path, 0, l);
+	p = new->path;
+	strcpy(p, orig->path);
+	p += strlen(p);
+	p++;
+	new->argv = (char **)p;
+	p += sizeof(char *) * (ia + 1);
+
+	ia = 0;
+	while (orig->argv[ia] && ia < 7) {
+		strcpy(p, orig->argv[ia]);
+		new->argv[ia] = p;
+		p += strlen(p);
+		*p++ = '\0';
+		ia++;
+	}
+	new->argv[ia] = NULL;
+
+	new->envp = (char **)p;
+	p += sizeof(char *) * (ie + 1);
+
+	ie = 0;
+	while (orig->envp[ie] && ie < 31) {
+		strcpy(p, orig->envp[ie]);
+		new->envp[ie] = p;
+		p += strlen(p);
+		*p++ = '\0';
+		ie++;
+	}
+	new->envp[ie] = NULL;
+}
+
 /* Keventd can't block, but this (a child) can. */
 static int wait_for_helper(void *data)
 {
-	struct subprocess_info *sub_info = data;
+	struct subprocess_info *sub_info = data, stored_info;
 	pid_t pid;
 	struct k_sigaction sa;
+	int flags = SIGCHLD, retval, wait = sub_info->wait;
+
+	/* Copy process info, it's not vaild after complete() */
+	khelper_copy_info(sub_info, &stored_info);
+	if (!stored_info.path) {
+		sub_info->retval = -ENOMEM;
+		complete(sub_info->complete);
+		return 0;
+	}
+
+	if (down_trylock(&khelper_sem)) {
+		/* 
+		 * We have exceeded the maximum number of
+		 * concurrent kmod invocations. Delay this process
+		 * until enough resources are available again.
+		 */
+		if (wait == 0) {
+			/* Queueing is for async events only */
+			wait = -1;
+			sub_info->retval = -EAGAIN;
+			complete(sub_info->complete);
+		}
+		down(&khelper_sem);
+	}
+	/* Do the real action */
 
 	/* Install a handler: if SIGCLD isn't handled sys_wait4 won't
 	 * populate the status, but will return -ECHILD. */
@@ -190,23 +267,62 @@ static int wait_for_helper(void *data)
 	do_sigaction(SIGCHLD, &sa, (struct k_sigaction *)0);
 	allow_signal(SIGCHLD);
 
-	pid = kernel_thread(____call_usermodehelper, sub_info, SIGCHLD);
+	if (wait < 1) {
+		/* CLONE_VFORK: wait until the usermode helper has execve'd
+		 * successfully We need the data structures to stay around
+		 * until that is done.  */
+		flags |= CLONE_VFORK;
+	}
+
+	pid = kernel_thread(____call_usermodehelper, &stored_info, flags);
 	if (pid < 0) {
-		sub_info->retval = pid;
-	} else {
+		if (wait >= 0) {
+			sub_info->retval = pid;
+			complete(sub_info->complete);
+		}
+		kfree(stored_info.path);
+		/* Bail out */
+		up(&khelper_sem);
+
+		return 0;
+	}
+	/* 
+	 * usermodehelper started successfully
+	 * We always block for the child to exit as we want to
+	 * keep track of the number of currently running processes.
+	 */
+
+	if (wait == 0) {
 		/*
-		 * Normally it is bogus to call wait4() from in-kernel because
-		 * wait4() wants to write the exit code to a userspace address.
-		 * But wait_for_helper() always runs as keventd, and put_user()
-		 * to a kernel address works OK for kernel threads, due to their
-		 * having an mm_segment_t which spans the entire address space.
-		 *
-		 * Thus the __user pointer cast is valid here.
+		 * For asynchronous events notify the caller
+		 * immediately, but wait for the event to finish.
 		 */
-		sys_wait4(pid, (int __user *) &sub_info->retval, 0, NULL);
+		complete(sub_info->complete);
 	}
 
-	complete(sub_info->complete);
+	/*
+	 * Normally it is bogus to call wait4() from in-kernel because
+	 * wait4() wants to write the exit code to a userspace address.
+	 * But wait_for_helper() always runs as keventd, and put_user()
+	 * to a kernel address works OK for kernel threads, due to their
+	 * having an mm_segment_t which spans the entire address space.
+	 *
+	 * Thus the __user pointer cast is valid here.
+	 */
+	sys_wait4(pid, (int __user *) &retval, 0, NULL);
+	
+	if (wait > 0) {
+		/* 
+		 * For synchronous events we can return the exit
+		 * status of the child.
+		 */
+		sub_info->retval = retval;
+		complete(sub_info->complete);
+	}
+	
+	kfree(stored_info.path);
+	up(&khelper_sem);
+
 	return 0;
 }
 
@@ -216,21 +332,13 @@ static void __call_usermodehelper(void *
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
@@ -276,4 +384,30 @@ void __init usermodehelper_init(void)
 {
 	khelper_wq = create_singlethread_workqueue("khelper");
 	BUG_ON(!khelper_wq);
+
+	/*
+	 * Limit the max number of concurrent processes
+	 * to something sane; 10 - max_threads/2 seems ok.
+	 */
+	if (khelper_max > max_threads/2)
+		khelper_max = max_threads/2;
+	if (khelper_max < 10)
+		khelper_max = 10;
+
+	printk(KERN_INFO "khelper: max %d concurrent processes\n",
+	       khelper_max);
+	sema_init(&khelper_sem, khelper_max);
+}
+
+/*
+ * Sanity check for khelper_max is done in usermodehelper_init,
+ * as at this point of time the system is not fully initialised.
+ */
+static int __init khelper_setup(char *s)
+{
+	get_option(&s, &khelper_max);
+
+	return 1;
 }
+__setup("khelper_max=", khelper_setup);
+

--------------000809050102090207010408--
