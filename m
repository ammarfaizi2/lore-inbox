Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266546AbUHIMoh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266546AbUHIMoh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 08:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266549AbUHIMoh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 08:44:37 -0400
Received: from cantor.suse.de ([195.135.220.2]:45202 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266546AbUHIMl2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 08:41:28 -0400
Message-ID: <411770DD.5080207@suse.de>
Date: Mon, 09 Aug 2004 14:41:01 +0200
From: Hannes Reinecke <hare@suse.de>
Organization: SuSE Linux AG
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.6) Gecko/20040114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] hotplug resource limitation 
Content-Type: multipart/mixed;
 boundary="------------050903030906080606080909"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050903030906080606080909
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Hi all,

this is the first patch to implement hotplug resource limitation 
(relative to 2.6.7-rc2-mm2).

Some sort of limitation is needed as call_usermodehelper just execve()s 
a program without any checks if enough resources (memory, cpu) are 
available. So loading a module which creates a lot of hotplug events may 
stall or even crash the machine.

It implements a semaphore holding the max # of concurrent hotplug / kmod 
processes, which blocks if the number has been reached. Any further 
attempt to call a helper program with call_usermodehelper will either be 
blocked (if the call is synchronous) or queued (if the call is 
asynchronous) until the semaphore is freed upon exit() from a previous 
call. The total number is adjustable with a kernel commandline option
'khelper_max', but restricted to something sane, as setting this too low 
would result in a deadlock from request_module (as this might be called 
recursively from several modules).

This patch also eliminates the need for the 'track number of kmod 
processes' hach in request_module, as it implements the same 
functionality on a broader scale.

Please apply.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke			hare@suse.de
SuSE Linux AG				S390 & zSeries
Maxfeldstra�e 5				+49 911 74053 688
90409 N�rnberg				http://www.suse.de

--------------050903030906080606080909
Content-Type: text/x-patch;
 name="khelper-mm2-static.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="khelper-mm2-static.patch"

Restrict max number of concurrent hotplug processes (Part 1)

The max number of concurrent hotplug (and kmod) processes needs to be
restricted. Otherwise the machine might hang on low memory conditions 
as the thread itself could have been started, but the subsequent execve 
might hang if not enough memory to load the programm image / shared 
library is available.

This patch implements a new commandline parameter 'khelper_max', which
specifies the maximum number of concurrently running hotplug processes.
This number is used to prime a semaphore, which will be down()ed on
the start of each process and up()ed on exit.
On reaching this number, the process will be blocked (for synchronous
events) or queued (for asynchronous events) until the semaphore becomes
available again.

To implement proper queueing we have to make sure to have all process
arguments available at the time of process invocation. Hence the calling
convention for asynchronous events (wait=0 at call_usermodehelper) had to
be changed so that both argv and envp are kmalloc()ed areas, which must
be freed by the caller only if call_usermodehelper returns non-zero.

Signed-off-by: Hannes Reinecke <hare@suse.de>

diff -pur linux-2.6.8-rc2-mm2/kernel/kmod.c linux-2.6.8-rc2-mm2.hotplug/kernel/kmod.c
--- linux-2.6.8-rc2-mm2/kernel/kmod.c	2004-08-03 14:58:15.000000000 +0200
+++ linux-2.6.8-rc2-mm2.hotplug/kernel/kmod.c	2004-08-05 14:56:35.000000000 +0200
@@ -17,6 +17,9 @@
 
 	call_usermodehelper wait flag, and remove exec_usermodehelper.
 	Rusty Russell <rusty@rustcorp.com.au>  Jan 2003
+
+	resource management for call_usermodehelper
+	Hannes Reinecke <hare@suse.de> Jul 2004
 */
 #define __KERNEL_SYSCALLS__
 
@@ -38,9 +41,13 @@
 #include <linux/init.h>
 #include <asm/uaccess.h>
 
+#define DEBUG_KHELPER
+
 extern int max_threads;
 
 static struct workqueue_struct *khelper_wq;
+int khelper_max = 50;
+static struct semaphore khelper_sem;
 
 #ifdef CONFIG_KMOD
 
@@ -67,16 +74,12 @@ int request_module(const char *fmt, ...)
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
@@ -95,21 +98,11 @@ int request_module(const char *fmt, ...)
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
@@ -178,9 +171,51 @@ static int ____call_usermodehelper(void 
 /* Keventd can't block, but this (a child) can. */
 static int wait_for_helper(void *data)
 {
-	struct subprocess_info *sub_info = data;
+	struct subprocess_info *sub_info = data, stored_info;
 	pid_t pid;
 	struct k_sigaction sa;
+	int flags = SIGCHLD, retval, wait = sub_info->wait;
+#ifdef DEBUG_KHELPER
+	char *ev_descr;
+#endif
+
+	/* Copy process info, it's not vaild after complete() */
+	stored_info.path = sub_info->path;
+	stored_info.argv = sub_info->argv;
+	stored_info.envp = sub_info->envp;
+	stored_info.wait = sub_info->wait;
+
+#ifdef DEBUG_KHELPER
+	/* Debug info */
+	if (stored_info.wait) {
+		ev_descr = stored_info.argv[3];
+	} else {
+		ev_descr = stored_info.envp[3] + 7;
+	}
+#endif
+	if (down_trylock(&khelper_sem)) {
+		/* 
+		 * We have exceeded the maximum number of
+		 * concurrent kmod invocations. Delay this process
+		 * until enough resources are available again.
+		 */
+#ifdef DEBUG_KHELPER
+		printk(KERN_INFO "khelper: delay event %s (current %d, max %d)\n",
+		       ev_descr, atomic_read(&khelper_sem.count), khelper_max);
+#endif
+		if (wait == 0) {
+			/* Queueing is for async events only */
+			wait = -1;
+			sub_info->retval = 0;
+			complete(sub_info->complete);
+		}
+		down(&khelper_sem);
+	}
+	/* Do the real action */
+#ifdef DEBUG_KHELPER
+	printk(KERN_INFO "khelper: exec event %s (current %d, max %d)\n",
+	       ev_descr, atomic_read(&khelper_sem.count), khelper_max);
+#endif
 
 	/* Install a handler: if SIGCLD isn't handled sys_wait4 won't
 	 * populate the status, but will return -ECHILD. */
@@ -190,23 +225,68 @@ static int wait_for_helper(void *data)
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
+#ifdef DEBUG_KHELPER
+		printk(KERN_INFO "khelper: exec event %s failed (%d)\n",
+		       ev_descr, pid);
+#endif
+		if (wait >= 0) {
+			sub_info->retval = pid;
+			complete(sub_info->complete);
+		}
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
+	} else {
+		/* Has been allocated in lib/kobject.c:kset_hotplug() */
+		kfree(stored_info.argv);
+		kfree(stored_info.envp);
+	}
+
+	up(&khelper_sem);
+
 	return 0;
 }
 
@@ -216,21 +296,13 @@ static void __call_usermodehelper(void *
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
@@ -276,4 +348,30 @@ void __init usermodehelper_init(void)
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
 }
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
+}
+__setup("khelper_max=", khelper_setup);
+
diff -pur linux-2.6.8-rc2-mm2/lib/kobject.c linux-2.6.8-rc2-mm2.hotplug/lib/kobject.c
--- linux-2.6.8-rc2-mm2/lib/kobject.c	2004-07-18 06:59:07.000000000 +0200
+++ linux-2.6.8-rc2-mm2.hotplug/lib/kobject.c	2004-08-05 15:12:18.000000000 +0200
@@ -98,7 +98,8 @@ static void fill_kobj_path(struct kset *
 	pr_debug("%s: path = '%s'\n",__FUNCTION__,path);
 }
 
-#define BUFFER_SIZE	1024	/* should be enough memory for the env */
+#define ARGV_SIZE	512	/* should be enough memory for the argv */
+#define ENVP_SIZE	2048	/* should be enough memory for the env */
 #define NUM_ENVP	32	/* number of env pointers */
 static unsigned long sequence_num;
 static spinlock_t sequence_lock = SPIN_LOCK_UNLOCKED;
@@ -106,9 +107,10 @@ static spinlock_t sequence_lock = SPIN_L
 static void kset_hotplug(const char *action, struct kset *kset,
 			 struct kobject *kobj)
 {
-	char *argv [3];
+	char **argv = NULL;
 	char **envp = NULL;
-	char *buffer = NULL;
+	char *argv_buffer = NULL;
+	char *envp_buffer = NULL;
 	char *scratch;
 	int i = 0;
 	int retval;
@@ -129,29 +131,46 @@ static void kset_hotplug(const char *act
 	if (!hotplug_path[0])
 		return;
 
-	envp = kmalloc(NUM_ENVP * sizeof (char *), GFP_KERNEL);
-	if (!envp)
+	argv_buffer = kmalloc(ARGV_SIZE, GFP_KERNEL);
+	if (!argv_buffer)
 		return;
-	memset (envp, 0x00, NUM_ENVP * sizeof (char *));
+	memset (argv_buffer, 0x00, ARGV_SIZE);
+	scratch = argv_buffer;
 
-	buffer = kmalloc(BUFFER_SIZE, GFP_KERNEL);
-	if (!buffer)
-		goto exit;
+	argv = (char **)scratch;
+	scratch += sizeof (char *) * 3;
 
 	if (kset->hotplug_ops->name)
 		name = kset->hotplug_ops->name(kset, kobj);
 	if (name == NULL)
 		name = kset->kobj.name;
-
-	argv [0] = hotplug_path;
-	argv [1] = name;
+	argv [0] = scratch;
+	strcpy(scratch, hotplug_path);
+	scratch += strlen(hotplug_path) + 1;
+	argv [1] = scratch;
+	strcpy(scratch, name);
+	scratch += strlen(name) + 1;
 	argv [2] = NULL;
+	scratch++;
 
 	/* minimal command environment */
-	envp [i++] = "HOME=/";
-	envp [i++] = "PATH=/sbin:/bin:/usr/sbin:/usr/bin";
+	envp_buffer = kmalloc(ENVP_SIZE, GFP_KERNEL);
+	if (!envp_buffer) {
+		kfree(argv_buffer);
+		return;
+	}
+	memset (envp_buffer, 0x00, ENVP_SIZE);
+	scratch = envp_buffer;
 
-	scratch = buffer;
+	envp = (char **)scratch;
+	scratch += sizeof(char **) * NUM_ENVP;
+
+	envp [i++] = scratch;
+	strcpy(scratch,"HOME=/");
+	scratch += strlen("HOME=/") + 1;
+	envp [i++] = scratch;
+	strcpy(scratch,"PATH=/sbin:/bin:/usr/sbin:/usr/bin");
+	scratch += strlen("PATH=/sbin:/bin:/usr/sbin:/usr/bin") + 1;
 
 	envp [i++] = scratch;
 	scratch += sprintf(scratch, "ACTION=%s", action) + 1;
@@ -173,11 +192,13 @@ static void kset_hotplug(const char *act
 	envp [i++] = scratch;
 	scratch += sprintf (scratch, "DEVPATH=%s", kobj_path) + 1;
 
+	kfree(kobj_path);
+
 	if (kset->hotplug_ops->hotplug) {
 		/* have the kset specific function add its stuff */
 		retval = kset->hotplug_ops->hotplug (kset, kobj,
 				  &envp[i], NUM_ENVP - i, scratch,
-				  BUFFER_SIZE - (scratch - buffer));
+				  ENVP_SIZE - (scratch - envp_buffer));
 		if (retval) {
 			pr_debug ("%s - hotplug() returned %d\n",
 				  __FUNCTION__, retval);
@@ -188,14 +209,16 @@ static void kset_hotplug(const char *act
 	pr_debug ("%s: %s %s %s %s %s %s %s\n", __FUNCTION__, argv[0], argv[1],
 		  envp[0], envp[1], envp[2], envp[3], envp[4]);
 	retval = call_usermodehelper (argv[0], argv, envp, 0);
-	if (retval)
-		pr_debug ("%s - call_usermodehelper returned %d\n",
-			  __FUNCTION__, retval);
+	if (!retval)
+		return;
+
+	pr_debug ("%s - call_usermodehelper returned %d\n",
+		  __FUNCTION__, retval);
 
 exit:
-	kfree(kobj_path);
-	kfree(buffer);
-	kfree(envp);
+	kfree(argv_buffer);
+	kfree(envp_buffer);
+
 	return;
 }
 

--------------050903030906080606080909--
