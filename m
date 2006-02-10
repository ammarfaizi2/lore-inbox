Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751271AbWBJQFx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbWBJQFx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 11:05:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbWBJQFx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 11:05:53 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:50096 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751271AbWBJQFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 11:05:51 -0500
Date: Fri, 10 Feb 2006 11:05:51 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Andrew Morton <akpm@osdl.org>
cc: Kernel development list <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/8] Notifier chain update: Don't unregister yourself
Message-ID: <Pine.LNX.4.44L0.0602101105220.5227-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Notifier chain re-implementation (as636b): Two notifier chain callout
routines try to unregister themselves.  The new blocking-notifier API
does not support this, so this patch fixes the problem by adding a new
flag.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Chandra Seetharaman <sekharan@us.ibm.com>

Index: l2616/drivers/parisc/led.c
===================================================================
--- l2616.orig/drivers/parisc/led.c
+++ l2616/drivers/parisc/led.c
@@ -499,11 +499,16 @@ static int led_halt(struct notifier_bloc
 static struct notifier_block led_notifier = {
 	.notifier_call = led_halt,
 };
+static int notifier_disabled = 0;
 
 static int led_halt(struct notifier_block *nb, unsigned long event, void *buf) 
 {
 	char *txt;
-	
+
+	if (notifier_disabled)
+		return NOTIFY_OK;
+
+	notifier_disabled = 1;
 	switch (event) {
 	case SYS_RESTART:	txt = "SYSTEM RESTART";
 				break;
@@ -527,7 +532,6 @@ static int led_halt(struct notifier_bloc
 		if (led_func_ptr)
 			led_func_ptr(0xff); /* turn all LEDs ON */
 	
-	unregister_reboot_notifier(&led_notifier);
 	return NOTIFY_OK;
 }
 
@@ -758,6 +762,12 @@ not_found:
 	return 1;
 }
 
+static void __exit led_exit(void)
+{
+	unregister_reboot_notifier(&led_notifier);
+	return;
+}
+
 #ifdef CONFIG_PROC_FS
 module_init(led_create_procfs)
 #endif
Index: l2616/drivers/scsi/gdth.c
===================================================================
--- l2616.orig/drivers/scsi/gdth.c
+++ l2616/drivers/scsi/gdth.c
@@ -671,7 +671,7 @@ static struct file_operations gdth_fops 
 static struct notifier_block gdth_notifier = {
     gdth_halt, NULL, 0
 };
-
+static int notifier_disabled = 0;
 
 static void gdth_delay(int milliseconds)
 {
@@ -4595,13 +4595,13 @@ static int __init gdth_detect(struct scs
         add_timer(&gdth_timer);
 #endif
         major = register_chrdev(0,"gdth",&gdth_fops);
+        notifier_disabled = 0;
         register_reboot_notifier(&gdth_notifier);
     }
     gdth_polling = FALSE;
     return gdth_ctr_vcount;
 }
 
-
 static int gdth_release(struct Scsi_Host *shp)
 {
     int hanum;
@@ -5632,10 +5632,14 @@ static int gdth_halt(struct notifier_blo
     char            cmnd[MAX_COMMAND_SIZE];   
 #endif
 
+    if (notifier_disabled)
+    	return NOTIFY_OK;
+
     TRACE2(("gdth_halt() event %d\n",(int)event));
     if (event != SYS_RESTART && event != SYS_HALT && event != SYS_POWER_OFF)
         return NOTIFY_DONE;
 
+    notifier_disabled = 1;
     printk("GDT-HA: Flushing all host drives .. ");
     for (hanum = 0; hanum < gdth_ctr_count; ++hanum) {
         gdth_flush(hanum);
@@ -5650,10 +5654,8 @@ static int gdth_halt(struct notifier_blo
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
         sdev = scsi_get_host_dev(gdth_ctr_tab[hanum]);
         srp  = scsi_allocate_request(sdev, GFP_KERNEL);
-        if (!srp) {
-            unregister_reboot_notifier(&gdth_notifier);
+        if (!srp)
             return NOTIFY_OK;
-        }
         srp->sr_cmd_len = 12;
         srp->sr_use_sg = 0;
         gdth_do_req(srp, &gdtcmd, cmnd, 10);
@@ -5662,10 +5664,8 @@ static int gdth_halt(struct notifier_blo
 #else
         sdev = scsi_get_host_dev(gdth_ctr_tab[hanum]);
         scp  = scsi_allocate_device(sdev, 1, FALSE);
-        if (!scp) {
-            unregister_reboot_notifier(&gdth_notifier);
+        if (!scp)
             return NOTIFY_OK;
-        }
         scp->cmd_len = 12;
         scp->use_sg = 0;
         gdth_do_cmd(scp, &gdtcmd, cmnd, 10);
@@ -5679,7 +5679,6 @@ static int gdth_halt(struct notifier_blo
 #ifdef GDTH_STATISTICS
     del_timer(&gdth_timer);
 #endif
-    unregister_reboot_notifier(&gdth_notifier);
     return NOTIFY_OK;
 }
 

