Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266553AbUHINJ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266553AbUHINJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 09:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266550AbUHINJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 09:09:29 -0400
Received: from cantor.suse.de ([195.135.220.2]:13755 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266553AbUHINJK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 09:09:10 -0400
Message-ID: <41177703.5070202@suse.de>
Date: Mon, 09 Aug 2004 15:07:15 +0200
From: Hannes Reinecke <hare@suse.de>
Organization: SuSE Linux AG
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.6) Gecko/20040114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] hotplug resource limitation
Content-Type: multipart/mixed;
 boundary="------------050207090201070706080302"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050207090201070706080302
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Hi all,
this is the second patch to implement hotplug resource limitation 
(relative to 2.6.7-rc2-mm2).

In some cases it is preferrable to adapt the number of concurrent 
hotplug processes on the fly in addition to set the number statically 
during boot. Additionally, it might be required to disable hotplug / 
kmod event delivery altogether for debugging purposes (e.g. if a module 
loaded automatically is crashing the machine).

This patch implements a new sysctl variable kernel.khelper_max (with 
proc interface /proc/sys/kernel/khelper_max) which holds the max # of 
concurrently running khelper threads. Setting this variable to '0' 
disables hotplug event delivery altogether. Events will not be lost but 
rather queued within the kernel (i.e. threads are cloned which wait on a 
semaphore to become free). This allows for a replay of missed events 
once the variable is increased again.

Further explanation on top of the patch.

Please apply.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke			hare@suse.de
SuSE Linux AG				S390 & zSeries
Maxfeldstraße 5				+49 911 74053 688
90409 Nürnberg				http://www.suse.de

--------------050207090201070706080302
Content-Type: text/x-patch;
 name="khelper-mm2-dynamic.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="khelper-mm2-dynamic.patch"

Restrict max number of concurrent hotplug processes (Part 2)

The max number of concurrent hotplug / kmod events might need to be
changed at runtime. This also allows for disabling the delivery of
hotplug / kmod events altogether for debugging reasons and later
enabling them again, with a complete replay of all queued events.

The runtime variable is implemented as a new sysctl variable, which
resets the global variable 'khelper_max' to the new value. Care has to
be taken if the variable is decreased and some processes are already
queued / blocked: As it's not possible to ensure that a call to down()
will not be blocked we take the other route of simply not calling up()
on exit from an already running process if the variable has been
changed during runtime of the process.

The patch alse needed to change request_module() to dynamically
allocate the process arguments, as now theses arguments might be
needed by a delayed execution of the kmod thread.

Signed-off-by: Hannes Reinecke <hare@suse.de>

diff -pur linux-2.6.8-rc2-mm2/include/linux/sysctl.h linux-2.6.8-rc2-mm2.hotplug/include/linux/sysctl.h
--- linux-2.6.8-rc2-mm2/include/linux/sysctl.h	2004-08-03 14:58:14.000000000 +0200
+++ linux-2.6.8-rc2-mm2.hotplug/include/linux/sysctl.h	2004-08-05 16:33:02.000000000 +0200
@@ -136,6 +136,7 @@ enum
 	KERN_UNKNOWN_NMI_PANIC=66, /* int: unknown nmi panic flag */
 	KERN_INTERACTIVE=67,	/* interactive tasks can have cpu bursts */
 	KERN_COMPUTE=68,	/* adjust timeslices for a compute server */
+	KERN_KHELPER_MAX=69,	/* max # of concurrent khelper processes */
 };
 
 
@@ -784,6 +785,8 @@ extern int proc_doulongvec_minmax(ctl_ta
 				  void __user *, size_t *);
 extern int proc_doulongvec_ms_jiffies_minmax(ctl_table *table, int,
 				      struct file *, void __user *, size_t *);
+extern int proc_dointvec_khelper(ctl_table *, int, struct file *,
+				 void __user *, size_t *);
 
 extern int do_sysctl (int __user *name, int nlen,
 		      void __user *oldval, size_t __user *oldlenp,
diff -pur linux-2.6.8-rc2-mm2/kernel/kmod.c linux-2.6.8-rc2-mm2.hotplug/kernel/kmod.c
--- linux-2.6.8-rc2-mm2/kernel/kmod.c	2004-08-05 17:27:53.000000000 +0200
+++ linux-2.6.8-rc2-mm2.hotplug/kernel/kmod.c	2004-08-05 17:14:26.000000000 +0200
@@ -47,6 +47,7 @@ extern int max_threads;
 
 static struct workqueue_struct *khelper_wq;
 int khelper_max = 50;
+static int khelper_diff;
 static struct semaphore khelper_sem;
 
 #ifdef CONFIG_KMOD
@@ -75,11 +76,11 @@ int request_module(const char *fmt, ...)
 	va_list args;
 	char module_name[MODULE_NAME_LEN];
 	int ret;
-	char *argv[] = { modprobe_path, "-q", "--", module_name, NULL };
-	static char *envp[] = { "HOME=/",
-				"TERM=linux",
-				"PATH=/sbin:/usr/sbin:/bin:/usr/bin",
-				NULL };
+	char *argv_buffer = NULL;
+	char *envp_buffer = NULL;
+	char *scratch = NULL;
+	char **argv = NULL;
+	char **envp = NULL;
 
 	va_start(args, fmt);
 	ret = vsnprintf(module_name, MODULE_NAME_LEN, fmt, args);
@@ -87,6 +88,51 @@ int request_module(const char *fmt, ...)
 	if (ret >= MODULE_NAME_LEN)
 		return -ENAMETOOLONG;
 
+	/*
+	 * Use kmalloc for argv and envp as they might be delayed.
+	 */
+	argv_buffer = kmalloc(512,GFP_KERNEL);
+	if (!argv_buffer)
+		return -ENOMEM;
+	memset(argv_buffer,0x0,512);
+
+	envp_buffer = kmalloc(128,GFP_KERNEL);
+	if (!envp_buffer) {
+		kfree(argv_buffer);
+		return -ENOMEM;
+	}
+	memset(envp_buffer,0x0, 128);
+
+	scratch = argv_buffer;
+	argv = (char **)scratch;
+	scratch += sizeof(char *) * 5;
+	argv[0] = scratch;
+	strcpy(scratch, modprobe_path);
+	scratch += strlen(scratch) + 1;
+	argv[1] = scratch;
+	strcpy(scratch, "-q");
+	scratch += 3;
+	argv[2] = scratch;
+	strcpy(scratch, "--");
+	scratch += 3;
+	argv[3] = scratch;
+	strcpy(scratch, module_name);
+	argv[4] = NULL;
+
+	scratch = envp_buffer;
+	envp = (char **)scratch;
+	scratch += sizeof(char *) * 4;
+	envp[0] = scratch;
+	strcpy(scratch, "HOME=/");
+	scratch += strlen("HOME=/") + 1;
+	envp[1] = scratch;
+	strcpy(scratch, "TERM=linux");
+	scratch += strlen("TERM=linux") + 1;
+	envp[2] = scratch;
+	strcpy(scratch,"PATH=/sbin:/usr/sbin:/bin:/usr/bin");
+	
+	envp[3] = NULL;
+
 	/* If modprobe needs a service that is in a module, we get a recursive
 	 * loop.  Limit the number of running kmod threads to max_threads/2 or
 	 * MAX_KMOD_CONCURRENT, whichever is the smaller.  A cleaner method
@@ -102,7 +148,7 @@ int request_module(const char *fmt, ...)
 	 * Resource checking is now implemented in 
 	 * call_usermodehelper --hare
 	 */
-	ret = call_usermodehelper(modprobe_path, argv, envp, 1);
+	ret = call_usermodehelper(argv[0], argv, envp, 1);
 	return ret;
 }
 EXPORT_SYMBOL(request_module);
@@ -203,7 +249,7 @@ static int wait_for_helper(void *data)
 		printk(KERN_INFO "khelper: delay event %s (current %d, max %d)\n",
 		       ev_descr, atomic_read(&khelper_sem.count), khelper_max);
 #endif
-		if (wait == 0) {
+		if (khelper_max < 5 || wait == 0) {
 			/* Queueing is for async events only */
 			wait = -1;
 			sub_info->retval = 0;
@@ -285,7 +331,14 @@ static int wait_for_helper(void *data)
 		kfree(stored_info.envp);
 	}
 
-	up(&khelper_sem);
+	if (khelper_diff > 0) {
+#ifdef DEBUG_KHELPER
+		printk(KERN_INFO "khelper: decrease semaphore\n");
+#endif
+		khelper_diff--;
+	} else {
+		up(&khelper_sem);
+	}
 
 	return 0;
 }
@@ -363,6 +416,48 @@ void __init usermodehelper_init(void)
 	sema_init(&khelper_sem, khelper_max);
 }
 
+/* 
+ * Worker to adapt the number of khelper processes.
+ * down() might block, so we need a separate thread ...
+ */
+int khelper_modify_number(int diff)
+{
+	if (khelper_max > 0) {
+		printk(KERN_INFO "khelper: max %d concurrent processes\n",
+		       khelper_max);
+	} else {
+		printk(KERN_INFO "khelper: delaying events\n");
+	}
+
+	if (diff > 0) {
+		while (diff > 0) {
+			up(&khelper_sem);
+			diff--;
+		}
+	} else {
+		/* 
+		 * Note that we cannot call down() directly
+		 * as this would block.
+		 * So we first test whether we would block
+		 * and instruct the running processes to not
+		 * call up() instead.
+		 */
+		while (diff < 0) {
+			if (down_trylock(&khelper_sem)) {
+				khelper_diff++;
+			} else {
+#ifdef DEBUG_KHELPER
+				printk(KERN_INFO "khelper: decrease semaphore\n");
+#endif
+			}
+			diff++;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(khelper_modify_number);
+
 /*
  * Sanity check for khelper_max is done in usermodehelper_init,
  * as at this point of time the system is not fully initialised.
diff -pur linux-2.6.8-rc2-mm2/kernel/sysctl.c linux-2.6.8-rc2-mm2.hotplug/kernel/sysctl.c
--- linux-2.6.8-rc2-mm2/kernel/sysctl.c	2004-08-03 14:58:15.000000000 +0200
+++ linux-2.6.8-rc2-mm2.hotplug/kernel/sysctl.c	2004-08-05 16:51:43.000000000 +0200
@@ -64,6 +64,7 @@ extern int sysctl_lower_zone_protection;
 extern int min_free_kbytes;
 extern int printk_ratelimit_jiffies;
 extern int printk_ratelimit_burst;
+extern int khelper_max;
 
 #if defined(CONFIG_X86_LOCAL_APIC) && defined(__i386__)
 int unknown_nmi_panic;
@@ -414,6 +415,14 @@ static ctl_table kern_table[] = {
 		.proc_handler	= &proc_dostring,
 		.strategy	= &sysctl_string,
 	},
+	{
+		.ctl_name	= KERN_KHELPER_MAX,
+		.procname	= "khelper_max",
+		.data		= &khelper_max,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec_khelper,
+	},
 #endif
 #ifdef CONFIG_CHR_DEV_SG
 	{
@@ -1952,6 +1961,27 @@ int proc_dointvec_userhz_jiffies(ctl_tab
 		    	    do_proc_dointvec_userhz_jiffies_conv,NULL);
 }
 
+extern int khelper_modify_number(int diff);
+
+int proc_dointvec_khelper(ctl_table *table, int write, struct file *filp,
+			  void __user *buffer, size_t *lenp)
+{
+	int maxval = max_threads / 2;
+	struct do_proc_dointvec_minmax_conv_param param = {
+		.min = (int *) &zero,
+		.max = (int *) &maxval,
+	};
+	int oldval = khelper_max, retval;
+
+	retval = do_proc_dointvec(table, write, filp, buffer, lenp,
+				  do_proc_dointvec_minmax_conv, &param);
+	
+	if (khelper_max != oldval)
+	    khelper_modify_number(khelper_max - oldval);
+	return retval;
+}
+
+
 #else /* CONFIG_PROC_FS */
 
 int proc_dostring(ctl_table *table, int write, struct file *filp,

--------------050207090201070706080302--
