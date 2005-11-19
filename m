Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161228AbVKSCVQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161228AbVKSCVQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 21:21:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161216AbVKSCVP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 21:21:15 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:40072 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161226AbVKSCUq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 21:20:46 -0500
Subject: [RFC][PATCH 5/7]: Do not unregister from callout
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: linux-kernel@vger.kernel.org
Cc: lse-tech@lists.sourceforge.net, stern@rowland.harvard.edu,
       achim_leubner@adaptec.com, dmp@davidmpye.dyndns.org
Content-Type: text/plain
Organization: IBM
Date: Fri, 18 Nov 2005 18:20:44 -0800
Message-Id: <1132366844.9617.18.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There were two places where notifier_chain_unregister was called from
within a callout routine, which is not the correct usage of this
interface. This patch fixes the problem by using a new flag.

Signed-off-by:  Chandra Seetharaman <sekharan@us.ibm.com>
Signed-off-by:  Alan Stern <stern@rowland.harvard.edu>
-----
 drivers/parisc/led.c |   14 ++++++++++++--
 drivers/scsi/gdth.c  |   17 ++++++++---------
 2 files changed, 20 insertions(+), 11 deletions(-)

Index: l2615-rc1-notifiers/drivers/parisc/led.c
===================================================================
--- l2615-rc1-notifiers.orig/drivers/parisc/led.c
+++ l2615-rc1-notifiers/drivers/parisc/led.c
@@ -498,11 +498,16 @@ static int led_halt(struct notifier_bloc
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
@@ -526,7 +531,6 @@ static int led_halt(struct notifier_bloc
 		if (led_func_ptr)
 			led_func_ptr(0xff); /* turn all LEDs ON */
 	
-	unregister_reboot_notifier(&led_notifier);
 	return NOTIFY_OK;
 }
 
@@ -757,6 +761,12 @@ not_found:
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
Index: l2615-rc1-notifiers/drivers/scsi/gdth.c
===================================================================
--- l2615-rc1-notifiers.orig/drivers/scsi/gdth.c
+++ l2615-rc1-notifiers/drivers/scsi/gdth.c
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
 

-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


