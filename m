Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932257AbWFRRDE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257AbWFRRDE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 13:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932258AbWFRRDE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 13:03:04 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:54206 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S932257AbWFRRDB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 13:03:01 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Sun, 18 Jun 2006 19:02:27 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 2.6.17-rc6-mm2 4/6] ieee1394: nodemgr: switch to kthread API
To: linux1394-devel@lists.sourceforge.net
cc: Ben Collins <bcollins@ubuntu.com>, "Serge E. Hallyn" <serue@us.ibm.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
In-Reply-To: <tkrat.68482958a026ceaa@s5r6.in-berlin.de>
Message-ID: <tkrat.2acbea371dfb6404@s5r6.in-berlin.de>
References: <20060610143100.GA15536@sergelap.austin.ibm.com>
 <20060610144205.GA13850@infradead.org> <448AE12E.5060002@s5r6.in-berlin.de>
 <20060610154213.GA19077@infradead.org> <1149957286.4448.542.camel@grayson>
 <20060610163859.GA24081@infradead.org> <1149962931.4448.557.camel@grayson>
 <20060610183703.GA1497@infradead.org> <44944D8A.6090808@s5r6.in-berlin.de>
 <tkrat.7edcc575e6bfd4ed@s5r6.in-berlin.de>
 <tkrat.285947e88a3d529f@s5r6.in-berlin.de>
 <tkrat.7fb54747c3c78ac1@s5r6.in-berlin.de>
 <tkrat.68482958a026ceaa@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (0.878) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
Index: linux/drivers/ieee1394/nodemgr.c
===================================================================
--- linux.orig/drivers/ieee1394/nodemgr.c	2006-06-18 09:15:51.000000000 +0200
+++ linux/drivers/ieee1394/nodemgr.c	2006-06-18 11:25:17.000000000 +0200
@@ -12,8 +12,8 @@
 #include <linux/config.h>
 #include <linux/list.h>
 #include <linux/slab.h>
-#include <linux/completion.h>
 #include <linux/delay.h>
+#include <linux/kthread.h>
 #include <linux/moduleparam.h>
 #include <asm/atomic.h>
 
@@ -162,11 +162,8 @@ static DECLARE_MUTEX(nodemgr_serialize);
 struct host_info {
 	struct hpsb_host *host;
 	struct list_head list;
-	struct completion exited;
 	struct semaphore reset_sem;
-	int pid;
-	char daemon_name[15];
-	int kill_me;
+	struct task_struct *thread;
 };
 
 static int nodemgr_bus_match(struct device * dev, struct device_driver * drv);
@@ -1601,10 +1598,8 @@ static int nodemgr_host_thread(void *__h
 {
 	struct host_info *hi = (struct host_info *)__hi;
 	struct hpsb_host *host = hi->host;
-	int reset_cycles = 0;
-
-	/* No userlevel access needed */
-	daemonize(hi->daemon_name);
+	unsigned int generation = 0;
+	int i, reset_cycles = 0;
 
 	/* Setup our device-model entries */
 	nodemgr_create_host_dev_files(host);
@@ -1612,30 +1607,22 @@ static int nodemgr_host_thread(void *__h
 	/* Sit and wait for a signal to probe the nodes on the bus. This
 	 * happens when we get a bus reset. */
 	while (1) {
-		unsigned int generation = 0;
-		int i;
-
 		if (down_interruptible(&hi->reset_sem) ||
 		    down_interruptible(&nodemgr_serialize)) {
 			if (try_to_freeze())
 				continue;
 			printk("NodeMgr: received unexpected signal?!\n" );
-			break;
+			goto exit;
 		}
 
-		if (hi->kill_me) {
-			up(&nodemgr_serialize);
-			break;
-		}
+		if (kthread_should_stop())
+			goto unlock_exit;
 
 		/* Pause for 1/4 second in 1/16 second intervals,
 		 * to make sure things settle down. */
 		for (i = 0; i < 4 ; i++) {
-			set_current_state(TASK_INTERRUPTIBLE);
-			if (msleep_interruptible(63)) {
-				up(&nodemgr_serialize);
-				goto caught_signal;
-			}
+			if (msleep_interruptible(63))
+				goto unlock_exit;
 
 			/* Now get the generation in which the node ID's we collect
 			 * are valid.  During the bus scan we will use this generation
@@ -1648,12 +1635,8 @@ static int nodemgr_host_thread(void *__h
 			 * start the the waiting over again */
 			while (!down_trylock(&hi->reset_sem))
 				i = 0;
-
-			/* Check the kill_me again */
-			if (hi->kill_me) {
-				up(&nodemgr_serialize);
-				goto caught_signal;
-			}
+			if (kthread_should_stop())
+				goto unlock_exit;
 		}
 
 		if (!nodemgr_check_irm_capability(host, reset_cycles) ||
@@ -1679,11 +1662,11 @@ static int nodemgr_host_thread(void *__h
 
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
@@ -1743,41 +1726,28 @@ static void nodemgr_add_host(struct hpsb
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
+	sema_init(&hi->reset_sem, 0);
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
+	if (hi) {
+		HPSB_VERBOSE("NodeMgr: Processing reset for host %d", host->id);
 		up(&hi->reset_sem);
-	} else
-		HPSB_ERR ("NodeMgr: could not process reset of unused host");
-
-	return;
+	}
 }
 
 static void nodemgr_remove_host(struct hpsb_host *host)
@@ -1785,18 +1755,9 @@ static void nodemgr_remove_host(struct h
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
+		kthread_stop_sem(hi->thread, &hi->reset_sem);
+		nodemgr_remove_host_dev(&host->device);
+	}
 }
 
 static struct hpsb_highlevel nodemgr_highlevel = {


