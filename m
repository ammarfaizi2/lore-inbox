Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750713AbWGBXZm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbWGBXZm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 19:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750716AbWGBXZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 19:25:42 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:47319 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1750713AbWGBXZl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 19:25:41 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Mon, 3 Jul 2006 01:25:25 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 16/19] ieee1394: nodemgr: switch to kthread api, replace reset
 semaphore
To: Ben Collins <bcollins@ubuntu.com>
cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <tkrat.8d67352567e525c1@s5r6.in-berlin.de>
Message-ID: <tkrat.909a0e48b0755ebb@s5r6.in-berlin.de>
References: <tkrat.8d67352567e525c1@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (0.905) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert nodemgr's host thread from kernel_thread to kthread and its
sleep/restart mechanism from a counting semaphore to a schedule()/
wake_up_process() scheme.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
Replaces the patches
  "ieee1394: nodemgr: switch to kthread API"
  "ieee1394: nodemgr: replace reset semaphore"

 drivers/ieee1394/nodemgr.c |  120 ++++++++++++-------------------------
 1 files changed, 41 insertions(+), 79 deletions(-)

Index: linux/drivers/ieee1394/nodemgr.c
===================================================================
--- linux.orig/drivers/ieee1394/nodemgr.c	2006-07-02 12:22:51.000000000 +0200
+++ linux/drivers/ieee1394/nodemgr.c	2006-07-02 12:23:05.000000000 +0200
@@ -12,8 +12,8 @@
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/slab.h>
-#include <linux/completion.h>
 #include <linux/delay.h>
+#include <linux/kthread.h>
 #include <linux/moduleparam.h>
 #include <asm/atomic.h>
 
@@ -163,11 +163,7 @@ static DECLARE_MUTEX(nodemgr_serialize);
 struct host_info {
 	struct hpsb_host *host;
 	struct list_head list;
-	struct completion exited;
-	struct semaphore reset_sem;
-	int pid;
-	char daemon_name[15];
-	int kill_me;
+	struct task_struct *thread;
 };
 
 static int nodemgr_bus_match(struct device * dev, struct device_driver * drv);
@@ -1477,9 +1473,8 @@ static void nodemgr_node_probe(struct ho
 	/* If we had a bus reset while we were scanning the bus, it is
 	 * possible that we did not probe all nodes.  In that case, we
 	 * skip the clean up for now, since we could remove nodes that
-	 * were still on the bus.  The bus reset increased hi->reset_sem,
-	 * so there's a bus scan pending which will do the clean up
-	 * eventually.
+	 * were still on the bus.  Another bus scan is pending which will
+	 * do the clean up eventually.
 	 *
 	 * Now let's tell the bus to rescan our devices. This may seem
 	 * like overhead, but the driver-model core will only scan a
@@ -1607,41 +1602,37 @@ static int nodemgr_host_thread(void *__h
 {
 	struct host_info *hi = (struct host_info *)__hi;
 	struct hpsb_host *host = hi->host;
-	int reset_cycles = 0;
-
-	/* No userlevel access needed */
-	daemonize(hi->daemon_name);
+	unsigned int g, generation = get_hpsb_generation(host) - 1;
+	int i, reset_cycles = 0;
 
 	/* Setup our device-model entries */
 	nodemgr_create_host_dev_files(host);
 
-	/* Sit and wait for a signal to probe the nodes on the bus. This
-	 * happens when we get a bus reset. */
-	while (1) {
-		unsigned int generation = 0;
-		int i;
+	for (;;) {
+		/* Sleep until next bus reset */
+		set_current_state(TASK_INTERRUPTIBLE);
+		if (get_hpsb_generation(host) == generation)
+			schedule();
+		__set_current_state(TASK_RUNNING);
+
+		/* Thread may have been woken up to freeze or to exit */
+		if (try_to_freeze())
+			continue;
+		if (kthread_should_stop())
+			goto exit;
 
-		if (down_interruptible(&hi->reset_sem) ||
-		    down_interruptible(&nodemgr_serialize)) {
+		if (down_interruptible(&nodemgr_serialize)) {
 			if (try_to_freeze())
 				continue;
-			printk("NodeMgr: received unexpected signal?!\n" );
-			break;
-		}
-
-		if (hi->kill_me) {
-			up(&nodemgr_serialize);
-			break;
+			goto exit;
 		}
 
 		/* Pause for 1/4 second in 1/16 second intervals,
 		 * to make sure things settle down. */
+		g = get_hpsb_generation(host);
 		for (i = 0; i < 4 ; i++) {
-			set_current_state(TASK_INTERRUPTIBLE);
-			if (msleep_interruptible(63)) {
-				up(&nodemgr_serialize);
-				goto caught_signal;
-			}
+			if (msleep_interruptible(63) || kthread_should_stop())
+				goto unlock_exit;
 
 			/* Now get the generation in which the node ID's we collect
 			 * are valid.  During the bus scan we will use this generation
@@ -1652,14 +1643,8 @@ static int nodemgr_host_thread(void *__h
 
 			/* If we get a reset before we are done waiting, then
 			 * start the the waiting over again */
-			while (!down_trylock(&hi->reset_sem))
-				i = 0;
-
-			/* Check the kill_me again */
-			if (hi->kill_me) {
-				up(&nodemgr_serialize);
-				goto caught_signal;
-			}
+			if (generation != g)
+				g = generation, i = 0;
 		}
 
 		if (!nodemgr_check_irm_capability(host, reset_cycles) ||
@@ -1685,11 +1670,11 @@ static int nodemgr_host_thread(void *__h
 
 		up(&nodemgr_serialize);
 	}
-
-caught_signal:
+unlock_exit:
+	up(&nodemgr_serialize);
+exit:
 	HPSB_VERBOSE("NodeMgr: Exiting thread");
-
-	complete_and_exit(&hi->exited, 0);
+	return 0;
 }
 
 int nodemgr_for_each_host(void *__data, int (*cb)(struct hpsb_host *, void *))
@@ -1749,41 +1734,27 @@ static void nodemgr_add_host(struct hpsb
 	struct host_info *hi;
 
 	hi = hpsb_create_hostinfo(&nodemgr_highlevel, host, sizeof(*hi));
-
 	if (!hi) {
-		HPSB_ERR ("NodeMgr: out of memory in add host");
+		HPSB_ERR("NodeMgr: out of memory in add host");
 		return;
 	}
-
 	hi->host = host;
-	init_completion(&hi->exited);
-        sema_init(&hi->reset_sem, 0);
-
-	sprintf(hi->daemon_name, "knodemgrd_%d", host->id);
-
-	hi->pid = kernel_thread(nodemgr_host_thread, hi, CLONE_KERNEL);
-
-	if (hi->pid < 0) {
-		HPSB_ERR ("NodeMgr: failed to start %s thread for %s",
-			  hi->daemon_name, host->driver->name);
+	hi->thread = kthread_run(nodemgr_host_thread, hi, "knodemgrd_%d",
+				 host->id);
+	if (IS_ERR(hi->thread)) {
+		HPSB_ERR("NodeMgr: cannot start thread for host %d", host->id);
 		hpsb_destroy_hostinfo(&nodemgr_highlevel, host);
-		return;
 	}
-
-	return;
 }
 
 static void nodemgr_host_reset(struct hpsb_host *host)
 {
 	struct host_info *hi = hpsb_get_hostinfo(&nodemgr_highlevel, host);
 
-	if (hi != NULL) {
-		HPSB_VERBOSE("NodeMgr: Processing host reset for %s", hi->daemon_name);
-		up(&hi->reset_sem);
-	} else
-		HPSB_ERR ("NodeMgr: could not process reset of unused host");
-
-	return;
+	if (hi) {
+		HPSB_VERBOSE("NodeMgr: Processing reset for host %d", host->id);
+		wake_up_process(hi->thread);
+	}
 }
 
 static void nodemgr_remove_host(struct hpsb_host *host)
@@ -1791,18 +1762,9 @@ static void nodemgr_remove_host(struct h
 	struct host_info *hi = hpsb_get_hostinfo(&nodemgr_highlevel, host);
 
 	if (hi) {
-		if (hi->pid >= 0) {
-			hi->kill_me = 1;
-			mb();
-			up(&hi->reset_sem);
-			wait_for_completion(&hi->exited);
-			nodemgr_remove_host_dev(&host->device);
-		}
-	} else
-		HPSB_ERR("NodeMgr: host %s does not exist, cannot remove",
-			 host->driver->name);
-
-	return;
+		kthread_stop(hi->thread);
+		nodemgr_remove_host_dev(&host->device);
+	}
 }
 
 static struct hpsb_highlevel nodemgr_highlevel = {


