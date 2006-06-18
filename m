Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932258AbWFRREO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258AbWFRREO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 13:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932259AbWFRREO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 13:04:14 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:62910 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S932258AbWFRREN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 13:04:13 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Sun, 18 Jun 2006 19:03:49 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 2.6.17-rc6-mm2 5/6] ieee1394: nodemgr: replace reset semaphore
To: linux1394-devel@lists.sourceforge.net
cc: Ben Collins <bcollins@ubuntu.com>, "Serge E. Hallyn" <serue@us.ibm.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
In-Reply-To: <tkrat.2acbea371dfb6404@s5r6.in-berlin.de>
Message-ID: <tkrat.d002fde02fba70c0@s5r6.in-berlin.de>
References: <20060610143100.GA15536@sergelap.austin.ibm.com>
 <20060610144205.GA13850@infradead.org> <448AE12E.5060002@s5r6.in-berlin.de>
 <20060610154213.GA19077@infradead.org> <1149957286.4448.542.camel@grayson>
 <20060610163859.GA24081@infradead.org> <1149962931.4448.557.camel@grayson>
 <20060610183703.GA1497@infradead.org> <44944D8A.6090808@s5r6.in-berlin.de>
 <tkrat.7edcc575e6bfd4ed@s5r6.in-berlin.de>
 <tkrat.285947e88a3d529f@s5r6.in-berlin.de>
 <tkrat.7fb54747c3c78ac1@s5r6.in-berlin.de>
 <tkrat.68482958a026ceaa@s5r6.in-berlin.de>
 <tkrat.2acbea371dfb6404@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (0.879) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert knodemgrd's sleep/restart mechanism from a counting semaphore to
a schedule()/wake_up_process() scheme.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
Index: linux/drivers/ieee1394/nodemgr.c
===================================================================
--- linux.orig/drivers/ieee1394/nodemgr.c	2006-06-18 12:06:30.000000000 +0200
+++ linux/drivers/ieee1394/nodemgr.c	2006-06-18 16:34:45.000000000 +0200
@@ -162,7 +162,6 @@ static DECLARE_MUTEX(nodemgr_serialize);
 struct host_info {
 	struct hpsb_host *host;
 	struct list_head list;
-	struct semaphore reset_sem;
 	struct task_struct *thread;
 };
 
@@ -1468,9 +1467,8 @@ static void nodemgr_node_probe(struct ho
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
@@ -1598,30 +1596,36 @@ static int nodemgr_host_thread(void *__h
 {
 	struct host_info *hi = (struct host_info *)__hi;
 	struct hpsb_host *host = hi->host;
-	unsigned int generation = 0;
+	unsigned int g, generation = get_hpsb_generation(host) - 1;
 	int i, reset_cycles = 0;
 
 	/* Setup our device-model entries */
 	nodemgr_create_host_dev_files(host);
 
-	/* Sit and wait for a signal to probe the nodes on the bus. This
-	 * happens when we get a bus reset. */
-	while (1) {
-		if (down_interruptible(&hi->reset_sem) ||
-		    down_interruptible(&nodemgr_serialize)) {
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
+
+		if (down_interruptible(&nodemgr_serialize)) {
 			if (try_to_freeze())
 				continue;
-			printk("NodeMgr: received unexpected signal?!\n" );
 			goto exit;
 		}
 
-		if (kthread_should_stop())
-			goto unlock_exit;
-
 		/* Pause for 1/4 second in 1/16 second intervals,
 		 * to make sure things settle down. */
+		g = get_hpsb_generation(host);
 		for (i = 0; i < 4 ; i++) {
-			if (msleep_interruptible(63))
+			if (msleep_interruptible(63) || kthread_should_stop())
 				goto unlock_exit;
 
 			/* Now get the generation in which the node ID's we collect
@@ -1633,10 +1637,8 @@ static int nodemgr_host_thread(void *__h
 
 			/* If we get a reset before we are done waiting, then
 			 * start the the waiting over again */
-			while (!down_trylock(&hi->reset_sem))
-				i = 0;
-			if (kthread_should_stop())
-				goto unlock_exit;
+			if (generation != g)
+				g = generation, i = 0;
 		}
 
 		if (!nodemgr_check_irm_capability(host, reset_cycles) ||
@@ -1731,7 +1733,6 @@ static void nodemgr_add_host(struct hpsb
 		return;
 	}
 	hi->host = host;
-	sema_init(&hi->reset_sem, 0);
 	hi->thread = kthread_run(nodemgr_host_thread, hi, "knodemgrd_%d",
 				 host->id);
 	if (IS_ERR(hi->thread)) {
@@ -1746,7 +1747,7 @@ static void nodemgr_host_reset(struct hp
 
 	if (hi) {
 		HPSB_VERBOSE("NodeMgr: Processing reset for host %d", host->id);
-		up(&hi->reset_sem);
+		wake_up_process(hi->thread);
 	}
 }
 
@@ -1755,7 +1756,7 @@ static void nodemgr_remove_host(struct h
 	struct host_info *hi = hpsb_get_hostinfo(&nodemgr_highlevel, host);
 
 	if (hi) {
-		kthread_stop_sem(hi->thread, &hi->reset_sem);
+		kthread_stop(hi->thread);
 		nodemgr_remove_host_dev(&host->device);
 	}
 }


