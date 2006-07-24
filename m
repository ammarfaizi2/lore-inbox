Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932284AbWGXSNU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932284AbWGXSNU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 14:13:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbWGXSNU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 14:13:20 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:24493 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932284AbWGXSNS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 14:13:18 -0400
Date: Mon, 24 Jul 2006 11:13:09 -0700
From: Sukadev Bhattiprolu <sukadev@us.ibm.com>
To: akpm@osdl.org
Cc: achirica@gmail.com, hch@infradead.org, linville@tuxdriver.com,
       "David C. Hansen" <haveblue@us.ibm.com>, serue@us.ibm.com,
       clr@fr.ibm.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kthread: airo.c
Message-ID: <20060724181309.GA23938@us.ibm.com>
References: <20060713205319.GA23594@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060713205319.GA23594@us.ibm.com>
User-Agent: Mutt/1.4.1i
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sukadev Bhattiprolu [sukadev@us.ibm.com] wrote:

| Andrew,
| 
| Javier Achirica, one of the major contributors to drivers/net/wireless/airo.c
| took a look at this patch, and doesn't have any problems with it. It doesn't
| fix any bugs and is just a cleanup, so it certainly isn't a candidate
| for this mainline cycle

Here is the same patch, merged up to 2.6.18-rc2. Christoph's patch (see
http://lkml.org/lkml/2006/7/13/332) still applies cleanly on top of this.

-----
The airo driver is currently caching a pid for later use, but with the
implementation of containers, pids themselves do not uniquely identify
a task. The driver is also using kernel_thread() which is deprecated in
drivers.

This patch essentially replaces the kernel_thread() with kthread_create().
It also stores the task_struct of the airo_thread rather than its pid.
Since this introduces a second task_struct in struct airo_info, the patch
renames airo_info.task to airo_info.list_bss_task.

As an extension of these changes, the patch further:

         - replaces kill_proc() with kthread_stop()
         - replaces signal_pending() with kthread_should_stop()
	 - removes thread completion synchronisation which is handled by
	   kthread_stop().

Signed-off-by: Sukadev Bhattiprolu <sukadev@us.ibm.com>
Cc: Javier Achirica <achirica@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: John Linville <linville@tuxdriver.com>

 drivers/net/wireless/airo.c |   38 +++++++++++++++-----------------------
 1 files changed, 15 insertions(+), 23 deletions(-)

Index: linux-2.6.18-rc1-mm2/drivers/net/wireless/airo.c
===================================================================
--- linux-2.6.18-rc1-mm2.orig/drivers/net/wireless/airo.c	2006-07-14 14:04:01.000000000 -0700
+++ linux-2.6.18-rc1-mm2/drivers/net/wireless/airo.c	2006-07-20 19:44:50.000000000 -0700
@@ -47,6 +47,7 @@
 #include <linux/pci.h>
 #include <asm/uaccess.h>
 #include <net/ieee80211.h>
+#include <linux/kthread.h>
 
 #include "airo.h"
 
@@ -1187,11 +1188,10 @@ struct airo_info {
 			int whichbap);
 	unsigned short *flash;
 	tdsRssiEntry *rssi;
-	struct task_struct *task;
+	struct task_struct *list_bss_task;
+	struct task_struct *airo_thread_task;
 	struct semaphore sem;
-	pid_t thr_pid;
 	wait_queue_head_t thr_wait;
-	struct completion thr_exited;
 	unsigned long expires;
 	struct {
 		struct sk_buff *skb;
@@ -1736,9 +1736,9 @@ static int readBSSListRid(struct airo_in
 		issuecommand(ai, &cmd, &rsp);
 		up(&ai->sem);
 		/* Let the command take effect */
-		ai->task = current;
+		ai->list_bss_task = current;
 		ssleep(3);
-		ai->task = NULL;
+		ai->list_bss_task = NULL;
 	}
 	rc = PC4500_readrid(ai, first ? ai->bssListFirst : ai->bssListNext,
 			    list, ai->bssListRidLen, 1);
@@ -2400,8 +2400,7 @@ void stop_airo_card( struct net_device *
 		clear_bit(FLAG_REGISTERED, &ai->flags);
 	}
 	set_bit(JOB_DIE, &ai->jobs);
-	kill_proc(ai->thr_pid, SIGTERM, 1);
-	wait_for_completion(&ai->thr_exited);
+	kthread_stop(ai->airo_thread_task);
 
 	/*
 	 * Clean out tx queue
@@ -2811,9 +2810,8 @@ static struct net_device *_init_airo_car
 	ai->config.len = 0;
 	ai->pci = pci;
 	init_waitqueue_head (&ai->thr_wait);
-	init_completion (&ai->thr_exited);
-	ai->thr_pid = kernel_thread(airo_thread, dev, CLONE_FS | CLONE_FILES);
-	if (ai->thr_pid < 0)
+	ai->airo_thread_task = kthread_run(airo_thread, dev, dev->name);
+	if (IS_ERR(ai->airo_thread_task))
 		goto err_out_free;
 	ai->tfm = NULL;
 	rc = add_airo_dev( dev );
@@ -2930,8 +2928,7 @@ err_out_unlink:
 	del_airo_dev(dev);
 err_out_thr:
 	set_bit(JOB_DIE, &ai->jobs);
-	kill_proc(ai->thr_pid, SIGTERM, 1);
-	wait_for_completion(&ai->thr_exited);
+	kthread_stop(ai->airo_thread_task);
 err_out_free:
 	free_netdev(dev);
 	return NULL;
@@ -3063,13 +3060,7 @@ static int airo_thread(void *data) {
 	struct airo_info *ai = dev->priv;
 	int locked;
 	
-	daemonize("%s", dev->name);
-	allow_signal(SIGTERM);
-
 	while(1) {
-		if (signal_pending(current))
-			flush_signals(current);
-
 		/* make swsusp happy with our thread */
 		try_to_freeze();
 
@@ -3097,7 +3088,7 @@ static int airo_thread(void *data) {
 						set_bit(JOB_AUTOWEP, &ai->jobs);
 						break;
 					}
-					if (!signal_pending(current)) {
+					if (!kthread_should_stop()) {
 						unsigned long wake_at;
 						if (!ai->expires || !ai->scan_timeout) {
 							wake_at = max(ai->expires,
@@ -3109,7 +3100,7 @@ static int airo_thread(void *data) {
 						schedule_timeout(wake_at - jiffies);
 						continue;
 					}
-				} else if (!signal_pending(current)) {
+				} else if (!kthread_should_stop()) {
 					schedule();
 					continue;
 				}
@@ -3154,7 +3145,8 @@ static int airo_thread(void *data) {
 		else  /* Shouldn't get here, but we make sure to unlock */
 			up(&ai->sem);
 	}
-	complete_and_exit (&ai->thr_exited, 0);
+
+	return 0;
 }
 
 static irqreturn_t airo_interrupt ( int irq, void* dev_id, struct pt_regs *regs) {
@@ -3235,8 +3227,8 @@ static irqreturn_t airo_interrupt ( int 
 			if(newStatus == ASSOCIATED || newStatus == REASSOCIATED) {
 				if (auto_wep)
 					apriv->expires = 0;
-				if (apriv->task)
-					wake_up_process (apriv->task);
+				if (apriv->list_bss_task)
+					wake_up_process(apriv->list_bss_task);
 				set_bit(FLAG_UPDATE_UNI, &apriv->flags);
 				set_bit(FLAG_UPDATE_MULTI, &apriv->flags);
 
