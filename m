Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265038AbUG0M1z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265038AbUG0M1z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 08:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265199AbUG0M1z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 08:27:55 -0400
Received: from cantor.suse.de ([195.135.220.2]:40329 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265038AbUG0M1h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 08:27:37 -0400
Message-ID: <410648E9.809@suse.de>
Date: Tue, 27 Jul 2004 14:22:01 +0200
From: Hannes Reinecke <hare@suse.de>
Organization: SuSE Linux AG
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.6) Gecko/20040114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Limit number of concurrent hotplug processes
References: <40FD23A8.6090409@suse.de>	<20040725182006.6c6a36df.akpm@osdl.org>	<4104E421.8080700@suse.de>	<20040726131807.47816576.akpm@osdl.org>	<4105FE68.7040506@suse.de>	<20040727002409.68d49d7c.akpm@osdl.org>	<41060B62.1060806@suse.de>	<20040727013427.52d3e5f5.akpm@osdl.org>	<41061AC0.8000607@suse.de> <20040727022826.2c95d8ff.akpm@osdl.org>
In-Reply-To: <20040727022826.2c95d8ff.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------060802050407020600010003"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060802050407020600010003
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Andrew Morton wrote:
> Hannes Reinecke <hare@suse.de> wrote:
> 
>> Problem with your patch is that call_usermodehelper might block on 
>> down() regardless whether it is called async or sync.
>> So any write to sysfs which triggers a hotplug event might block until 
>> enough resources are available.
> 
> 
> This is exactly the behaviour we want.  If we don't block the caller then
> the only option is to fail the call_usermodehelper() attempt, which would
> be very bad indeed.
> 
But only if call_usermodehelper is called with wait=1. For the async 
path we should not block.

> The main reason for calling call_usermodehelper(wait=0) is that the caller
> holds locks which will prevent the helper application from terminating.  I
> guess my proto-patch risks the same deadlock, because all the
> currently-running helpers may be waiting on that lock.
> 
And so it does. If an event is to be queued we need to copy the 
arguments and call 'complete' prior to calling down() to prevent locking 
of the calling process.

> Maybe this is why you were allocating a copy of the call_usermodehelper()
> arguments?  I didn't try to reverse-engineer your patch to that extent -
> I'd prefer to hear the design in your own words.  Am still waiting for
> this, btw.
> 
Ok. As already mentioned we have to copy the args if asynchronous events
are to be queued and wait for the semaphore to become available. Hence 
we will block and thus would need a similar mechanism as in 
wait_for_helper as otherwise either keventd itself or the calling thread 
would be blocked.
The only difference to the current wait_for_helper is that complete() 
should be called prior to calling down() to avoid blocking of the 
calling thread.
So part of my patch is just streamlining the calling sequence for 
usermodehelper to always call wait_for_helper and do all the main action 
in there.
In wait_for_helper I first check whether enough resources are available; 
if not the event is queued, wait=-1 and complete() is called to notify 
the calling function that this event is finished.
Here I mis-used the 'wait' entry so that -1 means 'event delayed'.
As we might have to queue the events I always copy the arguments to a 
local structure; thus we can have the same calling sequence for the 
entire function.

> Allocating a whole bunch of buffers to hold copies of the
> call_usermodehelper() args also uses resources, of course.  But it should
> be acceptable.  We'd allocate the same amount of memory if we were sending
> messages up a socket/pipe to userspace, which is what we should always have
> done, instead of the direct-exec - it's caused tons of trouble.
> 
Agreed. Would you be willing to accept patches for something like that?

> You didn't answer half the questions in my previous email, btw.
> 
Sorry. Hope this explains it a bit further.

> Right now, I cannot think of any solution apart from:
> 
> - In the sync path, take the semaphore
> 
> - In the async path, take a copy of the args, then pass them over to some
>   kernel thread which takes the args off a list one-at-a-time, takes the
>   semaphore for each one, execs the helper and drops the semaphore on the
>   exit path.
> 
Please have a look at the attached patch; it should be doing exactly this.

The patch to init/main.c is just for enabling all events with initramfs.
Without it events will be skipped as the workqueue for usermodehelper 
will be enabled only after any driver events have been generated.

Again, thanks very much for you help :-).

Cheers,

Hannes
-- 
Dr. Hannes Reinecke			hare@suse.de
SuSE Linux AG				S390 & zSeries
Maxfeldstraße 5				+49 911 74053 688
90409 Nürnberg				http://www.suse.de

--------------060802050407020600010003
Content-Type: text/x-patch;
 name="khelper_restrict_maxnum_sem_take2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="khelper_restrict_maxnum_sem_take2.patch"

diff -u --recursive linux-2.6.8-rc1/init/main.c linux-2.6.8-rc1.hotplug/init/main.c
--- linux-2.6.8-rc1/init/main.c	2004-07-11 19:33:56.000000000 +0200
+++ linux-2.6.8-rc1.hotplug/init/main.c	2004-07-23 09:43:35.000000000 +0200
@@ -93,6 +93,7 @@
 extern void populate_rootfs(void);
 extern void driver_init(void);
 extern void prepare_namespace(void);
+extern void usermodehelper_init(void);
 
 #ifdef CONFIG_TC
 extern void tc_init(void);
@@ -598,7 +599,9 @@
  */
 static void __init do_basic_setup(void)
 {
-	driver_init();
+	/* drivers will send hotplug events */
+	init_workqueues();
+	usermodehelper_init();
 
 #ifdef CONFIG_SYSCTL
 	sysctl_init();
@@ -607,7 +610,8 @@
 	/* Networking initialization needs a process context */ 
 	sock_init();
 
-	init_workqueues();
+	driver_init();
+
 	do_initcalls();
 }
 
diff -u --recursive linux-2.6.8-rc1/kernel/kmod.c linux-2.6.8-rc1.hotplug/kernel/kmod.c
--- linux-2.6.8-rc1/kernel/kmod.c	2004-07-11 19:34:19.000000000 +0200
+++ linux-2.6.8-rc1.hotplug/kernel/kmod.c	2004-07-27 14:55:26.000000000 +0200
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
 
@@ -67,16 +72,12 @@
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
@@ -95,21 +96,11 @@
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
@@ -167,6 +158,7 @@
 	set_cpus_allowed(current, CPU_MASK_ALL);
 
 	retval = -EPERM;
+
 	if (current->fs->root)
 		retval = execve(sub_info->path, sub_info->argv,sub_info->envp);
 
@@ -175,12 +167,99 @@
 	do_exit(0);
 }
 
+/* 
+ * The process args are only valid until call_usermodehelper
+ * returns, so we have to copy them to somewhere safe.
+ */
+void khelper_copy_info(struct subprocess_info *orig, 
+		       struct subprocess_info *new)
+{
+	int i, l;
+	char *p;
+
+	new->path = kmalloc(4096, GFP_KERNEL);
+	if (!new->path)
+	    return;
+	memset(new->path, 0, 4096);
+	p = new->path;
+	strcpy(p, orig->path);
+	p += strlen(p);
+	p++;
+	new->argv = (char **)p;
+	i = 0;
+	l = 0;
+	while (orig->envp[i]) {
+		l += strlen(orig->envp[i]) + 1;
+		i++;
+	}
+	if ( i > 7 )
+		i = 7;
+	p += sizeof(char *) * (i + 1);
+
+	i = 0;
+	while (orig->argv[i] && i < 7) {
+		strcpy(p, orig->argv[i]);
+		new->argv[i] = p;
+		p += strlen(p);
+		*p++ = '\0';
+		i++;
+	}
+	new->argv[i] = NULL;
+
+	i = 0;
+	l = 0;
+	while (orig->envp[i]) {
+		l += strlen(orig->envp[i]) + 1;
+		i++;
+	}
+	if ( i > 31 )
+		i = 31;
+	new->envp = (char **)p;
+	p += sizeof(char *) * (i + 1);
+
+	i = 0;
+	while (orig->envp[i] && i < 31) {
+		strcpy(p, orig->envp[i]);
+		new->envp[i] = p;
+		p += strlen(p);
+		*p++ = '\0';
+		i++;
+	}
+	new->envp[i] = NULL;
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
+	/* Copy process info, we might need it later on */
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
+		/* Wait until the semaphore is available again */
+		down(&khelper_sem);
+	}
+	/* Do the real action */
 
 	/* Install a handler: if SIGCLD isn't handled sys_wait4 won't
 	 * populate the status, but will return -ECHILD. */
@@ -190,23 +269,62 @@
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
+	}
+
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
 	}
+	
+	kfree(stored_info.path);
+	up(&khelper_sem);
 
-	complete(sub_info->complete);
 	return 0;
 }
 
@@ -216,21 +334,13 @@
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
@@ -272,10 +382,35 @@
 }
 EXPORT_SYMBOL(call_usermodehelper);
 
-static __init int usermodehelper_init(void)
+void __init usermodehelper_init(void)
 {
 	khelper_wq = create_singlethread_workqueue("khelper");
 	BUG_ON(!khelper_wq);
-	return 0;
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
+ * We want to restrict the maximum number of concurrent processes
+ * to max_threads / 2; however, at this time max_threads is not 
+ * yet initialised. So we will do the real check in usermodehelper_init().
+ */
+static int __init khelper_setup(char *s)
+{
+	get_option(&s, &khelper_max);
+
+	return 1;
 }
-core_initcall(usermodehelper_init);
+__setup("khelper_max=", khelper_setup);
+

--------------060802050407020600010003--
