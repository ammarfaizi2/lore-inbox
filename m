Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030415AbWFJOcE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030415AbWFJOcE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 10:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030422AbWFJOcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 10:32:04 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:32186 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030415AbWFJOcC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 10:32:02 -0400
Date: Sat, 10 Jun 2006 09:31:00 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: bcollins@debian.org, linux1394-devel@lists.sourceforge.net,
       weihs@ict.tuwien.ac.at
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] kthread conversion: convert ieee1394 from kernel_thread
Message-ID: <20060610143100.GA15536@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert ieee1394 from using deprecated kernel_thread to
kthread api.

Compiles fine, but unfortunately I am unable to test.

Signed-off-by: Serge Hallyn <serue@us.ibm.com>

---

 drivers/ieee1394/ieee1394_core.c |   20 +++++++++++---------
 drivers/ieee1394/nodemgr.c       |   12 +++++++-----
 2 files changed, 18 insertions(+), 14 deletions(-)

d1e631b1c58bc2cfe4dbcdb5138abce5060fed5a
diff --git a/drivers/ieee1394/ieee1394_core.c b/drivers/ieee1394/ieee1394_core.c
index be6854e..075ee3e 100644
--- a/drivers/ieee1394/ieee1394_core.c
+++ b/drivers/ieee1394/ieee1394_core.c
@@ -33,6 +33,7 @@
 #include <linux/kdev_t.h>
 #include <linux/skbuff.h>
 #include <linux/suspend.h>
+#include <linux/kthread.h>
 
 #include <asm/byteorder.h>
 #include <asm/semaphore.h>
@@ -997,7 +998,8 @@ void abort_timedouts(unsigned long __opa
  * packets that have a "complete" function are sent here. This way, the
  * completion is run out of kernel context, and doesn't block the rest of
  * the stack. */
-static int khpsbpkt_pid = -1, khpsbpkt_kill;
+static int khpsbpkt_kill;
+struct task_struct *khpsbpkt_task;
 static DECLARE_COMPLETION(khpsbpkt_complete);
 static struct sk_buff_head hpsbpkt_queue;
 static DECLARE_MUTEX_LOCKED(khpsbpkt_sig);
@@ -1065,8 +1067,8 @@ static int __init ieee1394_init(void)
 		HPSB_ERR("Some features may not be available\n");
 	}
 
-	khpsbpkt_pid = kernel_thread(hpsbpkt_thread, NULL, CLONE_KERNEL);
-	if (khpsbpkt_pid < 0) {
+	khpsbpkt_task = kthread_create(hpsbpkt_thread, NULL, "hpsbpkt");
+	if (IS_ERR(khpsbpkt_task)) {
 		HPSB_ERR("Failed to start hpsbpkt thread!\n");
 		ret = -ENOMEM;
 		goto exit_cleanup_config_roms;
@@ -1133,6 +1135,8 @@ static int __init ieee1394_init(void)
 		goto cleanup_csr;
 	}
 
+	wake_up_process(khpsbpkt_task);
+
 	return 0;
 
 cleanup_csr:
@@ -1148,10 +1152,8 @@ release_all_bus:
 release_chrdev:
 	unregister_chrdev_region(IEEE1394_CORE_DEV, 256);
 exit_release_kernel_thread:
-	if (khpsbpkt_pid >= 0) {
-		kill_proc(khpsbpkt_pid, SIGTERM, 1);
-		wait_for_completion(&khpsbpkt_complete);
-	}
+	if (khpsbpkt_task && !IS_ERR(khpsbpkt_task))
+		kthread_stop(khpsbpkt_task);
 exit_cleanup_config_roms:
 	hpsb_cleanup_config_roms();
 	return ret;
@@ -1172,11 +1174,11 @@ static void __exit ieee1394_cleanup(void
 		bus_remove_file(&ieee1394_bus_type, fw_bus_attrs[i]);
 	bus_unregister(&ieee1394_bus_type);
 
-	if (khpsbpkt_pid >= 0) {
+	if (khpsbpkt_task) {
 		khpsbpkt_kill = 1;
 		mb();
 		up(&khpsbpkt_sig);
-		wait_for_completion(&khpsbpkt_complete);
+		kthread_stop(khpsbpkt_task);
 	}
 
 	hpsb_cleanup_config_roms();
diff --git a/drivers/ieee1394/nodemgr.c b/drivers/ieee1394/nodemgr.c
index 082c7fd..83392af 100644
--- a/drivers/ieee1394/nodemgr.c
+++ b/drivers/ieee1394/nodemgr.c
@@ -19,6 +19,7 @@
 #include <linux/delay.h>
 #include <linux/pci.h>
 #include <linux/moduleparam.h>
+#include <linux/kthread.h>
 #include <asm/atomic.h>
 
 #include "ieee1394_types.h"
@@ -115,7 +116,7 @@ struct host_info {
 	struct list_head list;
 	struct completion exited;
 	struct semaphore reset_sem;
-	int pid;
+	struct task_struct *task;
 	char daemon_name[15];
 	int kill_me;
 };
@@ -1719,15 +1720,16 @@ static void nodemgr_add_host(struct hpsb
 
 	sprintf(hi->daemon_name, "knodemgrd_%d", host->id);
 
-	hi->pid = kernel_thread(nodemgr_host_thread, hi, CLONE_KERNEL);
+	hi->task = kthread_create(nodemgr_host_thread, hi, hi->daemon_name);
 
-	if (hi->pid < 0) {
+	if (IS_ERR(hi->task)) {
 		HPSB_ERR ("NodeMgr: failed to start %s thread for %s",
 			  hi->daemon_name, host->driver->name);
 		hpsb_destroy_hostinfo(&nodemgr_highlevel, host);
 		return;
 	}
 
+	wake_up_process(hi->task);
 	return;
 }
 
@@ -1749,11 +1751,11 @@ static void nodemgr_remove_host(struct h
 	struct host_info *hi = hpsb_get_hostinfo(&nodemgr_highlevel, host);
 
 	if (hi) {
-		if (hi->pid >= 0) {
+		if (hi->task && !IS_ERR(hi->task)) {
 			hi->kill_me = 1;
 			mb();
 			up(&hi->reset_sem);
-			wait_for_completion(&hi->exited);
+			kthread_stop(hi->task);
 			nodemgr_remove_host_dev(&host->device);
 		}
 	} else
-- 
1.1.6
