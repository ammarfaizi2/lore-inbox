Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752129AbWCCBtK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752129AbWCCBtK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 20:49:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752128AbWCCBsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 20:48:46 -0500
Received: from smtp-1.llnl.gov ([128.115.3.81]:6865 "EHLO smtp-1.llnl.gov")
	by vger.kernel.org with ESMTP id S1752129AbWCCBsO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 20:48:14 -0500
From: Dave Peterson <dsp@llnl.gov>
To: alan@lxorguk.ukuu.org.uk, akpm@osdl.org
Subject: [PATCH 1/15] EDAC: switch to kthread_ API
Date: Thu, 2 Mar 2006 17:47:47 -0800
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org, bluesmoke-devel@lists.sourceforge.net,
       hch@lst.de
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603021747.47515.dsp@llnl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch was originally posted by Christoph Hellwig (see
http://lkml.org/lkml/2006/2/14/331):

"Christoph Hellwig" <hch@lst.de> wrote:
> Use the kthread_ API instead of opencoding lots of hairy code for kernel
> thread creation and teardown, including tasklist_lock abuse.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Signed-Off-By: David S. Peterson <dsp@llnl.gov> <dave_peterson@pobox.com>
---

Index: linux-2.6.16-rc5-edac/drivers/edac/edac_mc.c
===================================================================
--- linux-2.6.16-rc5-edac.orig/drivers/edac/edac_mc.c	2006-02-27 15:13:54.000000000 -0800
+++ linux-2.6.16-rc5-edac/drivers/edac/edac_mc.c	2006-02-27 16:58:40.000000000 -0800
@@ -29,6 +29,7 @@
 #include <linux/list.h>
 #include <linux/sysdev.h>
 #include <linux/ctype.h>
+#include <linux/kthread.h>
 
 #include <asm/uaccess.h>
 #include <asm/page.h>
@@ -58,6 +59,8 @@ static atomic_t pci_parity_count = ATOMI
 static DECLARE_MUTEX(mem_ctls_mutex);
 static struct list_head mc_devices = LIST_HEAD_INIT(mc_devices);
 
+static struct task_struct *edac_thread;
+
 /* Structure of the whitelist and blacklist arrays */
 struct edac_pci_device_list {
 	unsigned int  vendor;		/* Vendor ID */
@@ -2027,7 +2030,6 @@ static inline void check_mc_devices (voi
  */
 static void do_edac_check(void)
 {
-
 	debugf3("MC: " __FILE__ ": %s()\n", __func__);
 
 	check_mc_devices();
@@ -2035,50 +2037,10 @@ static void do_edac_check(void)
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
@@ -2086,11 +2048,9 @@ static int edac_kernel_thread(void *arg)
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
 
@@ -2100,9 +2060,6 @@ static int edac_kernel_thread(void *arg)
  */
 static int __init edac_mc_init(void)
 {
-	int ret;
-	struct completion event;
-
 	printk(KERN_INFO "MC: " __FILE__ " version " EDAC_MC_VERSION "\n");
 
 	/*
@@ -2130,24 +2087,15 @@ static int __init edac_mc_init(void)
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
 
@@ -2158,21 +2106,9 @@ static int __init edac_mc_init(void)
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
