Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422720AbWBNRv6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422720AbWBNRv6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 12:51:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422722AbWBNRv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 12:51:58 -0500
Received: from verein.lst.de ([213.95.11.210]:62156 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1422720AbWBNRv5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 12:51:57 -0500
Date: Tue, 14 Feb 2006 18:51:52 +0100
From: Christoph Hellwig <hch@lst.de>
To: duncan.sands@free.fr, dwmw2@infradead.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] usbatm: use kthread_ API
Message-ID: <20060214175152.GB19080@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use the kthread_ API instead of opencoding lots of hairy code for kernel
thread creation and teardown.

Note: due to the short thread runtime we don't need a
kthread_should_stop()

Note2: all this is a bit odd and I don't have hardware, Duncan or David,
could you give it a try?


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/drivers/usb/atm/usbatm.c
===================================================================
--- linux-2.6.orig/drivers/usb/atm/usbatm.c	2006-02-04 13:35:01.000000000 +0100
+++ linux-2.6/drivers/usb/atm/usbatm.c	2006-02-14 18:08:04.000000000 +0100
@@ -75,6 +75,7 @@
 #include <linux/netdevice.h>
 #include <linux/proc_fs.h>
 #include <linux/sched.h>
+#include <linux/kthread.h>
 #include <linux/signal.h>
 #include <linux/slab.h>
 #include <linux/smp_lock.h>
@@ -999,38 +1000,24 @@
 	struct usbatm_data *instance = arg;
 	int ret;
 
-	daemonize(instance->driver->driver_name);
-	allow_signal(SIGTERM);
-
-	complete(&instance->thread_started);
-
 	ret = instance->driver->heavy_init(instance, instance->usb_intf);
-
 	if (!ret)
 		ret = usbatm_atm_init(instance);
-
-	mutex_lock(&instance->serialize);
-	instance->thread_pid = -1;
-	mutex_unlock(&instance->serialize);
-
-	complete_and_exit(&instance->thread_exited, ret);
+	return 0;
 }
 
 static int usbatm_heavy_init(struct usbatm_data *instance)
 {
-	int ret = kernel_thread(usbatm_do_heavy_init, instance, CLONE_KERNEL);
+	int ret;
 
-	if (ret < 0) {
-		usb_err(instance, "%s: failed to create kernel_thread (%d)!\n", __func__, ret);
+	instance->thread = kthread_run(usbatm_do_heavy_init, instance, "%s",
+			instance->driver->driver_name);
+	if (IS_ERR(instance->thread)) {
+		ret = PTR_ERR(instance->thread);
+		usb_err(instance, "%s: failed to create kernel thread (%d)!\n", __func__, ret);
 		return ret;
 	}
 
-	mutex_lock(&instance->serialize);
-	instance->thread_pid = ret;
-	mutex_unlock(&instance->serialize);
-
-	wait_for_completion(&instance->thread_started);
-
 	return 0;
 }
 
@@ -1112,10 +1099,6 @@
 	kref_init(&instance->refcount);		/* dropped in usbatm_usb_disconnect */
 	mutex_init(&instance->serialize);
 
-	instance->thread_pid = -1;
-	init_completion(&instance->thread_started);
-	init_completion(&instance->thread_exited);
-
 	INIT_LIST_HEAD(&instance->vcc_list);
 	skb_queue_head_init(&instance->sndqueue);
 
@@ -1227,7 +1210,6 @@
 	if (!(instance->flags & UDSL_SKIP_HEAVY_INIT) && driver->heavy_init) {
 		error = usbatm_heavy_init(instance);
 	} else {
-		complete(&instance->thread_exited);	/* pretend that heavy_init was run */
 		error = usbatm_atm_init(instance);
 	}
 
@@ -1275,12 +1257,10 @@
 
 	mutex_lock(&instance->serialize);
 	instance->disconnected = 1;
-	if (instance->thread_pid >= 0)
-		kill_proc(instance->thread_pid, SIGTERM, 1);
+	if (instance->thread);
+		kthread_stop(instance->thread);
 	mutex_unlock(&instance->serialize);
 
-	wait_for_completion(&instance->thread_exited);
-
 	mutex_lock(&instance->serialize);
 	list_for_each_entry(vcc_data, &instance->vcc_list, list)
 		vcc_release_async(vcc_data->vcc, -EPIPE);
Index: linux-2.6/drivers/usb/atm/usbatm.h
===================================================================
--- linux-2.6.orig/drivers/usb/atm/usbatm.h	2006-02-04 13:35:01.000000000 +0100
+++ linux-2.6/drivers/usb/atm/usbatm.h	2006-02-14 18:07:11.000000000 +0100
@@ -176,9 +176,7 @@
 	int disconnected;
 
 	/* heavy init */
-	int thread_pid;
-	struct completion thread_started;
-	struct completion thread_exited;
+	struct task_struct *thread;
 
 	/* ATM device */
 	struct list_head vcc_list;

