Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266319AbUG0IAs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266319AbUG0IAs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 04:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266327AbUG0IAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 04:00:48 -0400
Received: from cantor.suse.de ([195.135.220.2]:24723 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266319AbUG0H7q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 03:59:46 -0400
Message-ID: <41060B62.1060806@suse.de>
Date: Tue, 27 Jul 2004 09:59:30 +0200
From: Hannes Reinecke <hare@suse.de>
Organization: SuSE Linux AG
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.6) Gecko/20040114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Limit number of concurrent hotplug processes
References: <40FD23A8.6090409@suse.de>	<20040725182006.6c6a36df.akpm@osdl.org>	<4104E421.8080700@suse.de>	<20040726131807.47816576.akpm@osdl.org>	<4105FE68.7040506@suse.de> <20040727002409.68d49d7c.akpm@osdl.org>
In-Reply-To: <20040727002409.68d49d7c.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------050100050603030302000002"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050100050603030302000002
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Andrew Morton wrote:
> Hannes Reinecke <hare@suse.de> wrote:
> 
>> Given enough processes in the waitqueue, the number of currently running 
>> processes effectively determines the number of processes to be started.
>> And as those processes are already running, I don't see an effective 
>> procedure how we could _reduce_ the number of processes to be started.
> 
> 
> By reducing the number of processes which can concurrently take the
> semaphore?  Confused.
> 
Well, case in point: let's say we have khelper_max = 10, ten processes 
currently running, 15 processes in the waitqueue.
How can I reduce the number of concurrently running processes?
(Obviously not for the currently running processes, but for those in the 
waitqueue).
If I were to use down() as per your suggestion, I would have to use 
another helper thread as down() will block. Otherwise I will block the 
calling function (e.g. sysctl).
This just leads to added complexity; can't say I like it.

But then, your call. If you say 'use semaphores' I will do it.

Patch (for the semaphore version) is attached.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke			hare@suse.de
SuSE Linux AG				S390 & zSeries
Maxfeldstraße 5				+49 911 74053 688
90409 Nürnberg				http://www.suse.de

--------------050100050603030302000002
Content-Type: text/x-patch;
 name="khelper_restrict_maxnum_semaphore.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="khelper_restrict_maxnum_semaphore.patch"

diff -u --recursive linux-2.6.8-rc1/include/linux/sysctl.h linux-2.6.8-rc1.hotplug/include/linux/sysctl.h
--- linux-2.6.8-rc1/include/linux/sysctl.h	2004-07-11 19:34:39.000000000 +0200
+++ linux-2.6.8-rc1.hotplug/include/linux/sysctl.h	2004-07-21 10:22:15.000000000 +0200
@@ -133,6 +133,7 @@
 	KERN_NGROUPS_MAX=63,	/* int: NGROUPS_MAX */
 	KERN_SPARC_SCONS_PWROFF=64, /* int: serial console power-off halt */
 	KERN_HZ_TIMER=65,	/* int: hz timer on or off */
+	KERN_KHELPER_MAX=66,    /* int: max # of concurrent khelper threads */
 };
 
 
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
+++ linux-2.6.8-rc1.hotplug/kernel/kmod.c	2004-07-27 10:42:49.000000000 +0200
@@ -17,6 +17,9 @@
 
 	call_usermodehelper wait flag, and remove exec_usermodehelper.
 	Rusty Russell <rusty@rustcorp.com.au>  Jan 2003
+
+	resource management for call_usermodehelper
+	Hannes Reinecke <hare@suse.de> Jul 2004
 */
 #define __KERNEL_SYSCALLS__
 
@@ -41,6 +44,10 @@
 extern int max_threads;
 
 static struct workqueue_struct *khelper_wq;
+int khelper_max = 50;
+static struct semaphore khelper_sem = __SEMAPHORE_INITIALIZER(khelper_sem, 50);
+
+#define DEBUG_KHELPER
 
 #ifdef CONFIG_KMOD
 
@@ -67,16 +74,12 @@
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
@@ -95,21 +98,11 @@
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
@@ -175,13 +168,166 @@
 	do_exit(0);
 }
 
+/* 
+ * Worker to adapt the number of khelper processes.
+ * down() might block, so we need a separate thread ...
+ */
+void khelper_modify_number(void *data)
+{
+	struct subprocess_info *sub_info = data;
+	int i, diff = sub_info->wait;
+	
+	if (khelper_max > 0) {
+		printk(KERN_INFO "khelper: max %d concurrent processes\n",
+		       khelper_max);
+	} else {
+		printk(KERN_INFO "khelper: delaying events\n");
+	}
+	/* Notify calling process */
+	sub_info->retval = 0;
+	complete(sub_info->complete);
+
+	/* Do the actual work and wait if neccessary */
+	if (diff < 0) {
+		for (i = 0; i > diff; i--)
+			down(&khelper_sem);
+	} else {
+		for (i = 0; i < diff; i++)
+			up(&khelper_sem);
+	}
+}
+
+/* simple wrapper to wake any sleeping processes */
+void khelper_notify(int diff)
+{
+	pid_t pid;
+	DECLARE_COMPLETION(done);
+	struct subprocess_info sub_info = {
+		.complete	= &done,
+		.path		= path,
+		.argv		= argv,
+		.envp		= envp,
+		.wait		= diff,
+		.retval		= 0,
+	};
+
+	pid = kernel_thread(khelper_modify_number, sub_info,
+			    CLONE_FS | CLONE_FILES | SIGCHLD);
+
+	if (pid >= 0)
+		wait_for_completion(&done);
+}
+
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
+	int flags = SIGCHLD, retval;
+	char *ev_descr;
 
+	/* Copy process info, we might need it later on */
+	khelper_copy_info(sub_info, &stored_info);
+	if (!stored_info.path) {
+		sub_info->retval = -ENOMEM;
+		complete(sub_info->complete);
+		return 0;
+	}
+
+	stored_info.wait = sub_info->wait;
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
+		/* Notify the caller */
+		stored_info.wait = -1;
+		sub_info->retval = -EAGAIN;
+		complete(sub_info->complete);
+		
+		/* Wait until the semaphore is available again */
+		down(&khelper_sem);
+	}
+	/* Do the real action */
+#ifdef DEBUG_KHELPER
+	printk(KERN_INFO "khelper: exec event %s (current %d, max %d)\n",
+	       ev_descr, atomic_read(&khelper_sem.count), khelper_max);
+#endif
 	/* Install a handler: if SIGCLD isn't handled sys_wait4 won't
 	 * populate the status, but will return -ECHILD. */
 	sa.sa.sa_handler = SIG_IGN;
@@ -190,23 +336,75 @@
 	do_sigaction(SIGCHLD, &sa, (struct k_sigaction *)0);
 	allow_signal(SIGCHLD);
 
-	pid = kernel_thread(____call_usermodehelper, sub_info, SIGCHLD);
+	if (stored_info.wait < 1) {
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
+		kfree(stored_info.path);
+		if (stored_info.wait >= 0) {
+			sub_info->retval = pid;
+			complete(sub_info->complete);
+		}
+		/* Bail out */
+		if (atomic_read(&khelper_sem.count) < khelper_max)
+			up(&khelper_sem);
+		return 0;
+	}
+	/* 
+	 * usermodehelper started successfully
+	 * We always block for the child to exit as we want to
+	 * keep track of the number of currently running processes.
+	 */
+
+	if (stored_info.wait == 0) {
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
+	if (stored_info.wait > 0) {
+		/* 
+		 * For synchronous events we can return the exit
+		 * status of the child.
+		 */
+		sub_info->retval = retval;
+		complete(sub_info->complete);
+	}
+	
+	kfree(stored_info.path);
+
+	/* 
+	 * Check whether the maximum number of threads have
+	 * been reache and wake any sleeping kmod invocations
+	 * if there are enough resources available.
+	 * We have to test here as khelper_max might have been
+	 * changed per sysctl() whilst we have been sleeping.
+	 */
+	if (atomic_read(&khelper_sem.count) < khelper_max)
+		up(&khelper_sem);
+
 	return 0;
 }
 
@@ -216,21 +414,13 @@
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
@@ -272,10 +462,39 @@
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
+	if (khelper_max < 0)
+		khelper_max = 0;
+
+	if (khelper_max > 0) {
+		printk(KERN_INFO "khelper: max %d concurrent processes\n",
+		       khelper_max);
+	} else {
+		printk(KERN_INFO "khelper: delaying events\n");
+	}
+	atomic_set(&khelper_sem.count, khelper_max);
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
diff -u --recursive linux-2.6.8-rc1/kernel/sysctl.c linux-2.6.8-rc1.hotplug/kernel/sysctl.c
--- linux-2.6.8-rc1/kernel/sysctl.c	2004-07-11 19:33:55.000000000 +0200
+++ linux-2.6.8-rc1.hotplug/kernel/sysctl.c	2004-07-27 10:12:59.000000000 +0200
@@ -77,6 +77,7 @@
 #ifdef CONFIG_HOTPLUG
 extern char hotplug_path[];
 #endif
+extern int khelper_max;
 #ifdef CONFIG_CHR_DEV_SG
 extern int sg_big_buff;
 #endif
@@ -124,6 +125,8 @@
 		       ctl_table *, void **);
 static int proc_doutsstring(ctl_table *table, int write, struct file *filp,
 		  void __user *buffer, size_t *lenp);
+static int proc_dointvec_khelper(ctl_table *table, int write, struct file *filp,
+				 void __user *buffer, size_t *lenp);
 
 static ctl_table root_table[];
 static struct ctl_table_header root_table_header =
@@ -387,6 +390,14 @@
 		.mode		= 0644,
 		.proc_handler	= &proc_dointvec,
 	},
+	{
+		.ctl_name	= KERN_KHELPER_MAX,
+		.procname	= "khelper_max",
+		.data		= &khelper_max,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec_khelper,
+	},
 #ifdef CONFIG_KMOD
 	{
 		.ctl_name	= KERN_MODPROBE,
@@ -1670,6 +1681,51 @@
 				do_proc_dointvec_minmax_conv, &param);
 }
 
+extern void khelper_notify(int);
+
+static int do_proc_dointvec_khelper_conv(int *negp, unsigned long *lvalp, 
+					 int *valp, 
+					 int write, void *data)
+{
+	struct do_proc_dointvec_minmax_conv_param *param = data;
+	if (write) {
+		int val = *negp ? -*lvalp : *lvalp;
+		int old = *valp;
+
+		if ((param->min && *param->min > val) ||
+		    (param->max && *param->max < val))
+		    return -EINVAL;
+		*valp = val;
+
+		/* Notify any sleeping processes */
+		khelper_notify(val - old);
+	} else {
+		int val = *valp;
+		if (val < 0) {
+			*negp = -1;
+			*lvalp = (unsigned long)-val;
+		} else {
+			*negp = 0;
+			*lvalp = (unsigned long)val;
+		}
+	}
+	return 0;
+}
+
+static int proc_dointvec_khelper(ctl_table *table, int write, struct file *filp,
+				 void __user *buffer, size_t *lenp)
+{
+	int khelper_max = max_threads / 2;
+
+	struct do_proc_dointvec_minmax_conv_param param = {
+		.min = (int *)&zero,
+		.max = (int *)&khelper_max,
+	};
+    
+	return do_proc_dointvec(table,write,filp,buffer,lenp,
+				do_proc_dointvec_khelper_conv, &param);
+}
+
 static int do_proc_doulongvec_minmax(ctl_table *table, int write,
 				     struct file *filp,
 				     void __user *buffer, size_t *lenp,

--------------050100050603030302000002--
