Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422711AbWBNRrn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422711AbWBNRrn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 12:47:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422713AbWBNRrn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 12:47:43 -0500
Received: from verein.lst.de ([213.95.11.210]:42956 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1422711AbWBNRrm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 12:47:42 -0500
Date: Tue, 14 Feb 2006 18:47:30 +0100
From: Christoph Hellwig <hch@lst.de>
To: norsk5@xmission.com, dsp@llnl.gov
Cc: bluesmoke-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] edac: switch to kthread_ API
Message-ID: <20060214174730.GC18919@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use the kthread_ API instead of opencoding lots of hairy code for kernel
thread creation and teardown, including tasklist_lock abuse.


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/drivers/edac/edac_mc.c
===================================================================
--- linux-2.6.orig/drivers/edac/edac_mc.c	2006-02-04 13:35:00.000000000 +0100
+++ linux-2.6/drivers/edac/edac_mc.c	2006-02-14 17:47:34.000000000 +0100
@@ -29,6 +29,7 @@
 #include <linux/list.h>
 #include <linux/sysdev.h>
 #include <linux/ctype.h>
+#include <linux/kthread.h>
 
 #include <asm/uaccess.h>
 #include <asm/page.h>
@@ -58,6 +59,8 @@
 static DECLARE_MUTEX(mem_ctls_mutex);
 static struct list_head mc_devices = LIST_HEAD_INIT(mc_devices);
 
+static struct task_struct *edac_thread;
+
 /* Structure of the whitelist and blacklist arrays */
 struct edac_pci_device_list {
 	unsigned int  vendor;		/* Vendor ID */
@@ -2027,7 +2030,6 @@
  */
 static void do_edac_check(void)
 {
-
 	debugf3("MC: " __FILE__ ": %s()\n", __func__);
 
 	check_mc_devices();
@@ -2035,50 +2037,10 @@
 	do_pci_parity_check();
 }
 
-
-/*
- * EDAC thread state information
- */
-struct bs_thread_info
-{
-	struct task_struct *task;
-	struct completion *event;
-	char *name;
-	void (*run)(void);
-};
-
-static struct bs_thread_info bs_thread;
-
-/*
- *  edac_kernel_thread
- *      This the kernel thread that processes edac operations
- *      in a normal thread environment
- */
 static int edac_kernel_thread(void *arg)
 {
-	struct bs_thread_info *thread = (struct bs_thread_info *) arg;
-
-	/* detach thread */
-	daemonize(thread->name);
-
-	current->exit_signal = SIGCHLD;
-	allow_signal(SIGKILL);
-	thread->task = current;
-
-	/* indicate to starting task we have started */
-	complete(thread->event);
-
-	/* loop forever, until we are told to stop */
-	while(thread->run != NULL) {
-		void (*run)(void);
-
-		/* call the function to check the memory controllers */
-		run = thread->run;
-		if (run)
-			run();
-
-		if (signal_pending(current))
-			flush_signals(current);
+	while (!kthread_should_stop()) {
+		do_edac_check();
 
 		/* ensure we are interruptable */
 		set_current_state(TASK_INTERRUPTIBLE);
@@ -2086,11 +2048,9 @@
 		/* goto sleep for the interval */
 		schedule_timeout((HZ * poll_msec) / 1000);
 		try_to_freeze();
+		__set_current_state(TASK_RUNNING);
 	}
 
-	/* notify waiter that we are exiting */
-	complete(thread->event);
-
 	return 0;
 }
 
@@ -2100,9 +2060,6 @@
  */
 static int __init edac_mc_init(void)
 {
-	int ret;
-	struct completion event;
-
 	printk(KERN_INFO "MC: " __FILE__ " version " EDAC_MC_VERSION "\n");
 
 	/*
@@ -2130,24 +2087,15 @@
 		return -ENODEV;
 	}
 
-	/* Create our kernel thread */
-	init_completion(&event);
-	bs_thread.event = &event;
-	bs_thread.name = "kedac";
-	bs_thread.run = do_edac_check;
-
 	/* create our kernel thread */
-	ret = kernel_thread(edac_kernel_thread, &bs_thread, CLONE_KERNEL);
-	if (ret < 0) {
+	edac_thread = kthread_run(edac_kernel_thread, NULL, "kedac");
+	if (IS_ERR(edac_thread)) {
 		/* remove the sysfs entries */
 		edac_sysfs_memctrl_teardown();
 		edac_sysfs_pci_teardown();
-		return -ENOMEM;
+		return PTR_ERR(edac_thread);
 	}
 
-	/* wait for our kernel theard ack that it is up and running */
-	wait_for_completion(&event);
-
 	return 0;
 }
 
@@ -2158,21 +2106,9 @@
  */
 static void __exit edac_mc_exit(void)
 {
-	struct completion event;
-
 	debugf0("MC: " __FILE__ ": %s()\n", __func__);
 
-	init_completion(&event);
-	bs_thread.event = &event;
-
-	/* As soon as ->run is set to NULL, the task could disappear,
-	 * so we need to hold tasklist_lock until we have sent the signal
-	 */
-	read_lock(&tasklist_lock);
-	bs_thread.run = NULL;
-	send_sig(SIGKILL, bs_thread.task, 1);
-	read_unlock(&tasklist_lock);
-	wait_for_completion(&event);
+	kthread_stop(edac_thread);
 
         /* tear down the sysfs device */
 	edac_sysfs_memctrl_teardown();
