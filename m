Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932579AbWFIX0r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932579AbWFIX0r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 19:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932581AbWFIX0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 19:26:47 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:37822 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932579AbWFIX0r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 19:26:47 -0400
Date: Fri, 9 Jun 2006 18:25:51 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18 -mm merge plans
Message-ID: <20060609232551.GA11240@sergelap.austin.ibm.com>
References: <20060604135011.decdc7c9.akpm@osdl.org> <20060605144328.GA12904@sergelap.austin.ibm.com> <m17j3r8lqd.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m17j3r8lqd.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Eric W. Biederman (ebiederm@xmission.com):
> If you want to help with the bare pid to struct pid conversion I
> don't have any outstanding patches, and getting that done kills
> some theoretical pid wrap around problems as well as laying the ground
> work for a simple pidspace implementation.
> 
> Eric

Is this the sort of thing you are looking for?  Is this worthwhile for
kernel_threads, or only for userspace threads - i.e. do we expect kernel
threads to live?

If we do want to do this for kernel threads, then I assume that
eventually we'll want to change kernel_thread() itself.  I actually
started to do that earlier, but of course that way every user would
have to be changed in the same patch :)

Subject: [PATCH] struct pid: convert ieee1394 to hold struct pid

ieee1394 driver caches pid_t's for kernel threads.  Switch to
holding a reference to a struct pid.  This prevents concern
about the cached pid pointing to the wrong process after the
kernel thread dies and pids wrap around.

Signed-off-by: Serge Hallyn <serue@us.ibm.com>

---

 drivers/ieee1394/ieee1394_core.c |   16 ++++++++++------
 drivers/ieee1394/nodemgr.c       |   12 ++++++++----
 2 files changed, 18 insertions(+), 10 deletions(-)

ca429eb5558988a34815c8cdfcecd26a06170f4f
diff --git a/drivers/ieee1394/ieee1394_core.c b/drivers/ieee1394/ieee1394_core.c
index be6854e..4db5c54 100644
--- a/drivers/ieee1394/ieee1394_core.c
+++ b/drivers/ieee1394/ieee1394_core.c
@@ -33,6 +33,7 @@
 #include <linux/kdev_t.h>
 #include <linux/skbuff.h>
 #include <linux/suspend.h>
+#include <linux/pid.h>
 
 #include <asm/byteorder.h>
 #include <asm/semaphore.h>
@@ -997,7 +998,8 @@ void abort_timedouts(unsigned long __opa
  * packets that have a "complete" function are sent here. This way, the
  * completion is run out of kernel context, and doesn't block the rest of
  * the stack. */
-static int khpsbpkt_pid = -1, khpsbpkt_kill;
+static int khpsbpkt_kill;
+static struct pid *khpsbpkt_pid;
 static DECLARE_COMPLETION(khpsbpkt_complete);
 static struct sk_buff_head hpsbpkt_queue;
 static DECLARE_MUTEX_LOCKED(khpsbpkt_sig);
@@ -1056,6 +1058,7 @@ static int hpsbpkt_thread(void *__hi)
 static int __init ieee1394_init(void)
 {
 	int i, ret;
+	pid_t nr;
 
 	skb_queue_head_init(&hpsbpkt_queue);
 
@@ -1065,12 +1068,13 @@ static int __init ieee1394_init(void)
 		HPSB_ERR("Some features may not be available\n");
 	}
 
-	khpsbpkt_pid = kernel_thread(hpsbpkt_thread, NULL, CLONE_KERNEL);
-	if (khpsbpkt_pid < 0) {
+	nr = kernel_thread(hpsbpkt_thread, NULL, CLONE_KERNEL);
+	if (nr < 0) {
 		HPSB_ERR("Failed to start hpsbpkt thread!\n");
 		ret = -ENOMEM;
 		goto exit_cleanup_config_roms;
 	}
+	khpsbpkt_pid = get_pid(nr);
 
 	if (register_chrdev_region(IEEE1394_CORE_DEV, 256, "ieee1394")) {
 		HPSB_ERR("unable to register character device major %d!\n", IEEE1394_MAJOR);
@@ -1148,8 +1152,8 @@ release_all_bus:
 release_chrdev:
 	unregister_chrdev_region(IEEE1394_CORE_DEV, 256);
 exit_release_kernel_thread:
-	if (khpsbpkt_pid >= 0) {
-		kill_proc(khpsbpkt_pid, SIGTERM, 1);
+	if (khpsbpkt_pid) {
+		kill_proc(khpsbpkt_pid->nr, SIGTERM, 1);
 		wait_for_completion(&khpsbpkt_complete);
 	}
 exit_cleanup_config_roms:
@@ -1172,7 +1176,7 @@ static void __exit ieee1394_cleanup(void
 		bus_remove_file(&ieee1394_bus_type, fw_bus_attrs[i]);
 	bus_unregister(&ieee1394_bus_type);
 
-	if (khpsbpkt_pid >= 0) {
+	if (khpsbpkt_pid) {
 		khpsbpkt_kill = 1;
 		mb();
 		up(&khpsbpkt_sig);
diff --git a/drivers/ieee1394/nodemgr.c b/drivers/ieee1394/nodemgr.c
index 082c7fd..d33f2fe 100644
--- a/drivers/ieee1394/nodemgr.c
+++ b/drivers/ieee1394/nodemgr.c
@@ -19,6 +19,7 @@
 #include <linux/delay.h>
 #include <linux/pci.h>
 #include <linux/moduleparam.h>
+#include <linux/pid.h>
 #include <asm/atomic.h>
 
 #include "ieee1394_types.h"
@@ -115,7 +116,7 @@ struct host_info {
 	struct list_head list;
 	struct completion exited;
 	struct semaphore reset_sem;
-	int pid;
+	struct pid *pid;
 	char daemon_name[15];
 	int kill_me;
 };
@@ -1705,6 +1706,7 @@ int hpsb_node_write(struct node_entry *n
 static void nodemgr_add_host(struct hpsb_host *host)
 {
 	struct host_info *hi;
+	pid_t nr;
 
 	hi = hpsb_create_hostinfo(&nodemgr_highlevel, host, sizeof(*hi));
 
@@ -1719,14 +1721,15 @@ static void nodemgr_add_host(struct hpsb
 
 	sprintf(hi->daemon_name, "knodemgrd_%d", host->id);
 
-	hi->pid = kernel_thread(nodemgr_host_thread, hi, CLONE_KERNEL);
+	nr = kernel_thread(nodemgr_host_thread, hi, CLONE_KERNEL);
 
-	if (hi->pid < 0) {
+	if (nr < 0) {
 		HPSB_ERR ("NodeMgr: failed to start %s thread for %s",
 			  hi->daemon_name, host->driver->name);
 		hpsb_destroy_hostinfo(&nodemgr_highlevel, host);
 		return;
 	}
+	hi->pid = find_get_pid(nr);
 
 	return;
 }
@@ -1749,11 +1752,12 @@ static void nodemgr_remove_host(struct h
 	struct host_info *hi = hpsb_get_hostinfo(&nodemgr_highlevel, host);
 
 	if (hi) {
-		if (hi->pid >= 0) {
+		if (hi->pid->nr >= 0) {
 			hi->kill_me = 1;
 			mb();
 			up(&hi->reset_sem);
 			wait_for_completion(&hi->exited);
+			put_pid(hi->pid);
 			nodemgr_remove_host_dev(&host->device);
 		}
 	} else
-- 
1.1.6
