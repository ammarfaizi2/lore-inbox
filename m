Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267777AbUHXN1R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267777AbUHXN1R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 09:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267795AbUHXN1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 09:27:17 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:42137 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S267777AbUHXNYz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 09:24:55 -0400
Date: Tue, 24 Aug 2004 15:25:21 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390: lcs network driver.
Message-ID: <20040824132521.GA5954@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] s390: lcs network driver.

From: Frank Pavlic <pavlic@de.ibm.com>

lcs network driver changes:
 - Allocate the reply structure instead of taking it from the stack.
 - Use del_timer_sync instead of del_timer.
 - Clean up helper threads creation/shutdown.
 - Split lcs_register_mc_addresses to make it readable again.
 - Free multicast list entries when device is going down.
 - Retransmit multicast list in device recovery.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 drivers/s390/net/lcs.c |  406 ++++++++++++++++++++++++++++++++++++++-----------
 drivers/s390/net/lcs.h |   17 +-
 2 files changed, 336 insertions(+), 87 deletions(-)

diff -urN linux-2.6/drivers/s390/net/lcs.c linux-2.6-s390/drivers/s390/net/lcs.c
--- linux-2.6/drivers/s390/net/lcs.c	Tue Aug 24 15:12:22 2004
+++ linux-2.6-s390/drivers/s390/net/lcs.c	Tue Aug 24 15:12:42 2004
@@ -11,7 +11,7 @@
  *			  Frank Pavlic (pavlic@de.ibm.com) and
  *		 	  Martin Schwidefsky <schwidefsky@de.ibm.com>
  *
- *    $Revision: 1.85 $	 $Date: 2004/08/04 11:05:43 $
+ *    $Revision: 1.89 $	 $Date: 2004/08/24 10:49:27 $
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -59,7 +59,7 @@
 /**
  * initialization string for output
  */
-#define VERSION_LCS_C  "$Revision: 1.85 $"
+#define VERSION_LCS_C  "$Revision: 1.89 $"
 
 static char version[] __initdata = "LCS driver ("VERSION_LCS_C "/" VERSION_LCS_H ")";
 static char debug_buffer[255];
@@ -70,6 +70,7 @@
 static void lcs_tasklet(unsigned long);
 static void lcs_start_kernel_thread(struct lcs_card *card);
 static void lcs_get_frames_cb(struct lcs_channel *, struct lcs_buffer *);
+static int lcs_send_delipm(struct lcs_card *, struct lcs_ipm_list *);
 
 /**
  * Debug Facility Stuff
@@ -100,9 +101,9 @@
 		return -ENOMEM;
 	}
 	debug_register_view(lcs_dbf_setup, &debug_hex_ascii_view);
-	debug_set_level(lcs_dbf_setup, 2);
+	debug_set_level(lcs_dbf_setup, 4);
 	debug_register_view(lcs_dbf_trace, &debug_hex_ascii_view);
-	debug_set_level(lcs_dbf_trace, 2);
+	debug_set_level(lcs_dbf_trace, 4);
 	return 0;
 }
 
@@ -316,7 +317,106 @@
 	init_waitqueue_head(&card->write.wait_q);
 }
 
+static void
+lcs_set_allowed_threads(struct lcs_card *card, unsigned long threads)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&card->mask_lock, flags);
+	card->thread_allowed_mask = threads;
+	spin_unlock_irqrestore(&card->mask_lock, flags);
+	wake_up(&card->wait_q);
+}
+static inline int
+lcs_threads_running(struct lcs_card *card, unsigned long threads)
+{
+        unsigned long flags;
+        int rc = 0;
+
+	spin_lock_irqsave(&card->mask_lock, flags);
+        rc = (card->thread_running_mask & threads);
+	spin_unlock_irqrestore(&card->mask_lock, flags);
+        return rc;
+}
+
+static int
+lcs_wait_for_threads(struct lcs_card *card, unsigned long threads)
+{
+        return wait_event_interruptible(card->wait_q,
+                        lcs_threads_running(card, threads) == 0);
+}
+
+static inline int
+lcs_set_thread_start_bit(struct lcs_card *card, unsigned long thread)
+{
+        unsigned long flags;
+
+	spin_lock_irqsave(&card->mask_lock, flags);
+        if ( !(card->thread_allowed_mask & thread) ||
+              (card->thread_start_mask & thread) ) {
+                spin_unlock_irqrestore(&card->mask_lock, flags);
+                return -EPERM;
+        }
+        card->thread_start_mask |= thread;
+	spin_unlock_irqrestore(&card->mask_lock, flags);
+        return 0;
+}
+
+static void
+lcs_clear_thread_running_bit(struct lcs_card *card, unsigned long thread)
+{
+        unsigned long flags;
+
+	spin_lock_irqsave(&card->mask_lock, flags);
+        card->thread_running_mask &= ~thread;
+	spin_unlock_irqrestore(&card->mask_lock, flags);
+        wake_up(&card->wait_q);
+}
+
+static inline int
+__lcs_do_run_thread(struct lcs_card *card, unsigned long thread)
+{
+        unsigned long flags;
+        int rc = 0;
+
+	spin_lock_irqsave(&card->mask_lock, flags);
+        if (card->thread_start_mask & thread){
+                if ((card->thread_allowed_mask & thread) &&
+                    !(card->thread_running_mask & thread)){
+                        rc = 1;
+                        card->thread_start_mask &= ~thread;
+                        card->thread_running_mask |= thread;
+                } else
+                        rc = -EPERM;
+        }
+	spin_unlock_irqrestore(&card->mask_lock, flags);
+        return rc;
+}
+
+static int
+lcs_do_run_thread(struct lcs_card *card, unsigned long thread)
+{
+        int rc = 0;
+        wait_event(card->wait_q,
+                   (rc = __lcs_do_run_thread(card, thread)) >= 0);
+        return rc;
+}
+
+static int
+lcs_do_start_thread(struct lcs_card *card, unsigned long thread)
+{
+        unsigned long flags;
+        int rc = 0;
 
+	spin_lock_irqsave(&card->mask_lock, flags);
+        LCS_DBF_TEXT_(4, trace, "  %02x%02x%02x",
+                        (u8) card->thread_start_mask,
+                        (u8) card->thread_allowed_mask,
+                        (u8) card->thread_running_mask);
+        rc = (card->thread_start_mask & thread);
+	spin_unlock_irqrestore(&card->mask_lock, flags);
+        return rc;
+}
 
 /**
  * Initialize channels,card and state machines.
@@ -337,34 +437,49 @@
 	/* Initialize kernel thread task used for LGW commands. */
 	INIT_WORK(&card->kernel_thread_starter,
 		  (void *)lcs_start_kernel_thread,card);
-	card->thread_mask = 0;
+	card->thread_start_mask = 0;
+	card->thread_allowed_mask = 0;
+	card->thread_running_mask = 0;
+	init_waitqueue_head(&card->wait_q);
 	spin_lock_init(&card->lock);
 	spin_lock_init(&card->ipm_lock);
+	spin_lock_init(&card->mask_lock);
 #ifdef CONFIG_IP_MULTICAST
 	INIT_LIST_HEAD(&card->ipm_list);
 #endif
 	INIT_LIST_HEAD(&card->lancmd_waiters);
 }
 
+static inline void
+lcs_clear_multicast_list(struct lcs_card *card)
+{
+#ifdef	CONFIG_IP_MULTICAST
+	struct list_head *l, *n;
+	struct lcs_ipm_list *ipm;
+	unsigned long flags;
+	/* Free multicast list. */
+	LCS_DBF_TEXT(3, setup, "clmclist");
+	spin_lock_irqsave(&card->ipm_lock, flags);
+	list_for_each_safe(l, n, &card->ipm_list) {
+		ipm = list_entry(l, struct lcs_ipm_list, list);
+		list_del(&ipm->list);
+		if (ipm->ipm_state != LCS_IPM_STATE_SET_REQUIRED)
+			lcs_send_delipm(card, ipm);
+		kfree(ipm);
+	}
+	spin_unlock_irqrestore(&card->ipm_lock, flags);
+#endif
+}
 /**
  * Cleanup channels,card and state machines.
  */
 static void
 lcs_cleanup_card(struct lcs_card *card)
 {
-	struct list_head *l, *n;
-	struct lcs_ipm_list *ipm_list;
 
 	LCS_DBF_TEXT(3, setup, "cleancrd");
 	LCS_DBF_HEX(2,setup,&card,sizeof(void*));
-#ifdef	CONFIG_IP_MULTICAST
-	/* Free multicast list. */
-	list_for_each_safe(l, n, &card->ipm_list) {
-		ipm_list = list_entry(l, struct lcs_ipm_list, list);
-		list_del(&ipm_list->list);
-		kfree(ipm_list);
-	}
-#endif
+
 	if (card->dev != NULL)
 		free_netdev(card->dev);
 	/* Cleanup channels. */
@@ -651,6 +766,44 @@
 	return buffer;
 }
 
+
+static void
+lcs_get_reply(struct lcs_reply *reply)
+{
+	WARN_ON(atomic_read(&reply->refcnt) <= 0);
+	atomic_inc(&reply->refcnt);
+}
+
+static void
+lcs_put_reply(struct lcs_reply *reply)
+{
+        WARN_ON(atomic_read(&reply->refcnt) <= 0);
+        if (atomic_dec_and_test(&reply->refcnt)) {
+		kfree(reply);
+	}
+
+}
+
+static struct lcs_reply *
+lcs_alloc_reply(struct lcs_cmd *cmd)
+{
+	struct lcs_reply *reply;
+
+	LCS_DBF_TEXT(4, trace, "getreply");
+
+	reply = kmalloc(sizeof(struct lcs_reply), GFP_ATOMIC);
+	if (!reply)
+		return NULL;
+	memset(reply,0,sizeof(struct lcs_reply));
+	atomic_set(&reply->refcnt,1);
+	reply->sequence_no = cmd->sequence_no;
+	reply->received = 0;
+	reply->rc = 0;
+	init_waitqueue_head(&reply->wait_q);
+
+	return reply;
+}
+
 /**
  * Notifier function for lancmd replies. Called from read irq.
  */
@@ -665,12 +818,14 @@
 	list_for_each_safe(l, n, &card->lancmd_waiters) {
 		reply = list_entry(l, struct lcs_reply, list);
 		if (reply->sequence_no == cmd->sequence_no) {
-			list_del(&reply->list);
+			lcs_get_reply(reply);
+			list_del_init(&reply->list);
 			if (reply->callback != NULL)
 				reply->callback(card, cmd);
 			reply->received = 1;
 			reply->rc = cmd->return_code;
 			wake_up(&reply->wait_q);
+			lcs_put_reply(reply);
 			break;
 		}
 	}
@@ -683,50 +838,66 @@
 void
 lcs_lancmd_timeout(unsigned long data)
 {
-	struct lcs_reply *reply;
+	struct lcs_reply *reply, *list_reply, *r;
+	unsigned long flags;
 
 	LCS_DBF_TEXT(4, trace, "timeout");
 	reply = (struct lcs_reply *) data;
-	list_del(&reply->list);
-	reply->received = 1;
-	reply->rc = -ETIME;
-	wake_up(&reply->wait_q);
+	spin_lock_irqsave(&reply->card->lock, flags);
+	list_for_each_entry_safe(list_reply, r,
+				 &reply->card->lancmd_waiters,list) {
+		if (reply == list_reply) {
+			lcs_get_reply(reply);
+			list_del_init(&reply->list);
+			spin_unlock_irqrestore(&reply->card->lock, flags);
+			reply->received = 1;
+			reply->rc = -ETIME;
+			wake_up(&reply->wait_q);
+			lcs_put_reply(reply);
+			return;
+		}
+	}
+	spin_unlock_irqrestore(&reply->card->lock, flags);
 }
 
 static int
 lcs_send_lancmd(struct lcs_card *card, struct lcs_buffer *buffer,
 		void (*reply_callback)(struct lcs_card *, struct lcs_cmd *))
 {
-	struct lcs_reply reply;
+	struct lcs_reply *reply;
 	struct lcs_cmd *cmd;
 	struct timer_list timer;
+	unsigned long flags;
 	int rc;
 
 	LCS_DBF_TEXT(4, trace, "sendcmd");
 	cmd = (struct lcs_cmd *) buffer->data;
-	cmd->sequence_no = ++card->sequence_no;
 	cmd->return_code = 0;
-	reply.sequence_no = cmd->sequence_no;
-	reply.callback = reply_callback;
-	reply.received = 0;
-	reply.rc = 0;
-	init_waitqueue_head(&reply.wait_q);
-	spin_lock(&card->lock);
-	list_add_tail(&reply.list, &card->lancmd_waiters);
-	spin_unlock(&card->lock);
+	cmd->sequence_no = card->sequence_no++;
+	reply = lcs_alloc_reply(cmd);
+	if (!reply)
+		return -ENOMEM;
+	reply->callback = reply_callback;
+	reply->card = card;
+	spin_lock_irqsave(&card->lock, flags);
+	list_add_tail(&reply->list, &card->lancmd_waiters);
+	spin_unlock_irqrestore(&card->lock, flags);
+
 	buffer->callback = lcs_release_buffer;
 	rc = lcs_ready_buffer(&card->write, buffer);
 	if (rc)
 		return rc;
 	init_timer(&timer);
 	timer.function = lcs_lancmd_timeout;
-	timer.data = (unsigned long) &reply;
+	timer.data = (unsigned long) reply;
 	timer.expires = jiffies + HZ*card->lancmd_timeout;
 	add_timer(&timer);
-	wait_event(reply.wait_q, reply.received);
-	del_timer(&timer);
-	LCS_DBF_TEXT_(4, trace, "rc:%d",reply.rc);
-	return reply.rc ? -EIO : 0;
+	wait_event(reply->wait_q, reply->received);
+	del_timer_sync(&timer);
+	LCS_DBF_TEXT_(4, trace, "rc:%d",reply->rc);
+	rc = reply->rc;
+	lcs_put_reply(reply);
+	return rc ? -EIO : 0;
 }
 
 /**
@@ -942,9 +1113,10 @@
 {
 	struct list_head *l, *n;
 	struct lcs_ipm_list *ipm;
+	unsigned long flags;
 
 	LCS_DBF_TEXT(4,trace, "fixipm");
-	spin_lock(&card->ipm_lock);
+	spin_lock_irqsave(&card->ipm_lock, flags);
 	list_for_each_safe(l, n, &card->ipm_list) {
 		ipm = list_entry(l, struct lcs_ipm_list, list);
 		switch (ipm->ipm_state) {
@@ -964,9 +1136,9 @@
 			break;
 		}
 	}
+	spin_unlock_irqrestore(&card->ipm_lock, flags);
 	if (card->state == DEV_STATE_UP)
 		netif_wake_queue(card->dev);
-	spin_unlock(&card->ipm_lock);
 }
 
 /**
@@ -985,51 +1157,67 @@
 /**
  * function called by net device to handle multicast address relevant things
  */
-static int
-lcs_register_mc_addresses(void *data)
+static inline void
+lcs_remove_mc_addresses(struct lcs_card *card, struct in_device *in4_dev)
 {
-	struct lcs_card *card;
-	char buf[MAX_ADDR_LEN];
-	struct list_head *l;
 	struct ip_mc_list *im4;
-	struct in_device *in4_dev;
-	struct lcs_ipm_list *ipm, *tmp;
-
-	daemonize("regipm");
-	LCS_DBF_TEXT(4, trace, "regmulti");
+	struct list_head *l;
+	struct lcs_ipm_list *ipm;
+	unsigned long flags;
+	char buf[MAX_ADDR_LEN];
 
-	card = (struct lcs_card *) data;
-	in4_dev = in_dev_get(card->dev);
-	if (in4_dev == NULL)
-		return 0;
-	read_lock(&in4_dev->mc_list_lock);
-	spin_lock(&card->ipm_lock);
-	/* Check for multicast addresses to be removed. */
+	LCS_DBF_TEXT(4, trace, "remmclst");
+	spin_lock_irqsave(&card->ipm_lock, flags);
 	list_for_each(l, &card->ipm_list) {
 		ipm = list_entry(l, struct lcs_ipm_list, list);
 		for (im4 = in4_dev->mc_list; im4 != NULL; im4 = im4->next) {
 			lcs_get_mac_for_ipm(im4->multiaddr, buf, card->dev);
-			if (memcmp(buf, &ipm->ipm.mac_addr,
-				   LCS_MAC_LENGTH) == 0 &&
-			    ipm->ipm.ip_addr == im4->multiaddr)
+			if ( (ipm->ipm.ip_addr == im4->multiaddr) &&
+			     (memcmp(buf, &ipm->ipm.mac_addr,
+				     LCS_MAC_LENGTH) == 0) )
 				break;
 		}
 		if (im4 == NULL)
 			ipm->ipm_state = LCS_IPM_STATE_DEL_REQUIRED;
 	}
-	/* Check for multicast addresses to be added. */
+	spin_unlock_irqrestore(&card->ipm_lock, flags);
+}
+
+static inline struct lcs_ipm_list *
+lcs_check_addr_entry(struct lcs_card *card, struct ip_mc_list *im4, char *buf)
+{
+	struct lcs_ipm_list *tmp, *ipm = NULL;
+	struct list_head *l;
+	unsigned long flags;
+
+	LCS_DBF_TEXT(4, trace, "chkmcent");
+	spin_lock_irqsave(&card->ipm_lock, flags);
+	list_for_each(l, &card->ipm_list) {
+		tmp = list_entry(l, struct lcs_ipm_list, list);
+		if ( (tmp->ipm.ip_addr == im4->multiaddr) &&
+		     (memcmp(buf, &tmp->ipm.mac_addr,
+			     LCS_MAC_LENGTH) == 0) ) {
+			ipm = tmp;
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&card->ipm_lock, flags);
+	return ipm;
+}
+
+static inline void
+lcs_set_mc_addresses(struct lcs_card *card, struct in_device *in4_dev)
+{
+
+	struct ip_mc_list *im4;
+	struct lcs_ipm_list *ipm;
+	char buf[MAX_ADDR_LEN];
+	unsigned long flags;
+
+	LCS_DBF_TEXT(4, trace, "setmclst");
 	for (im4 = in4_dev->mc_list; im4; im4 = im4->next) {
 		lcs_get_mac_for_ipm(im4->multiaddr, buf, card->dev);
-		ipm = NULL;
-		list_for_each(l, &card->ipm_list) {
-			tmp = list_entry(l, struct lcs_ipm_list, list);
-			if (memcmp(buf, &tmp->ipm.mac_addr,
-				   LCS_MAC_LENGTH) == 0 &&
-			    tmp->ipm.ip_addr == im4->multiaddr) {
-				ipm = tmp;
-				break;
-			}
-		}
+		ipm = lcs_check_addr_entry(card, im4, buf);
 		if (ipm != NULL)
 			continue;	/* Address already in list. */
 		ipm = (struct lcs_ipm_list *)
@@ -1043,12 +1231,37 @@
 		memcpy(&ipm->ipm.mac_addr, buf, LCS_MAC_LENGTH);
 		ipm->ipm.ip_addr = im4->multiaddr;
 		ipm->ipm_state = LCS_IPM_STATE_SET_REQUIRED;
+		spin_lock_irqsave(&card->ipm_lock, flags);
 		list_add(&ipm->list, &card->ipm_list);
+		spin_unlock_irqrestore(&card->ipm_lock, flags);
 	}
-	spin_unlock(&card->ipm_lock);
+}
+
+static int
+lcs_register_mc_addresses(void *data)
+{
+	struct lcs_card *card;
+	struct in_device *in4_dev;
+
+	card = (struct lcs_card *) data;
+	daemonize("regipm");
+
+	if (!lcs_do_run_thread(card, LCS_SET_MC_THREAD))
+		return 0;
+	LCS_DBF_TEXT(4, trace, "regmulti");
+
+	in4_dev = in_dev_get(card->dev);
+	if (in4_dev == NULL)
+		goto out;
+	read_lock(&in4_dev->mc_list_lock);
+	lcs_remove_mc_addresses(card,in4_dev);
+	lcs_set_mc_addresses(card, in4_dev);
 	read_unlock(&in4_dev->mc_list_lock);
 	in_dev_put(in4_dev);
+
 	lcs_fix_multicast_list(card);
+out:
+	lcs_clear_thread_running_bit(card, LCS_SET_MC_THREAD);
 	return 0;
 }
 /**
@@ -1062,8 +1275,10 @@
 
         LCS_DBF_TEXT(4, trace, "setmulti");
         card = (struct lcs_card *) dev->priv;
-        set_bit(3, &card->thread_mask);
-        schedule_work(&card->kernel_thread_starter);
+
+        if (!lcs_set_thread_start_bit(card, LCS_SET_MC_THREAD)) {
+		schedule_work(&card->kernel_thread_starter);
+	}
 }
 
 #endif /* CONFIG_IP_MULTICAST */
@@ -1427,6 +1642,7 @@
 	return -EIO;
 }
 
+
 /**
  * LCS Stop card
  */
@@ -1440,6 +1656,7 @@
 	if (card->read.state != CH_STATE_STOPPED &&
 	    card->write.state != CH_STATE_STOPPED &&
 	    card->state == DEV_STATE_UP) {
+		lcs_clear_multicast_list(card);
 		rc = lcs_send_stoplan(card,LCS_INITIATOR_TCPIP);
 		rc = lcs_send_shutdown(card);
 	}
@@ -1459,6 +1676,9 @@
 
 	card = (struct lcs_card *) data;
 	daemonize("lgwstpln");
+
+	if (!lcs_do_run_thread(card, LCS_STARTLAN_THREAD))
+		return 0;
 	LCS_DBF_TEXT(4, trace, "lgwstpln");
 	if (card->dev)
 		netif_stop_queue(card->dev);
@@ -1471,6 +1691,7 @@
 	} else
 		PRINT_ERR("LCS Startlan for device %s failed!\n",
 			  card->dev->name);
+	lcs_clear_thread_running_bit(card, LCS_STARTLAN_THREAD);
 	return 0;
 }
 
@@ -1485,8 +1706,11 @@
 	struct lcs_card *card;
 
 	card = (struct lcs_card *) data;
-	daemonize("lgwstpln");
-	LCS_DBF_TEXT(4, trace, "lgwstpln");
+	daemonize("lgwstaln");
+
+	if (!lcs_do_run_thread(card, LCS_STARTUP_THREAD))
+		return 0;
+	LCS_DBF_TEXT(4, trace, "lgwstaln");
 	if (card->dev)
 		netif_stop_queue(card->dev);
 	rc = lcs_send_startup(card, LCS_INITIATOR_LGW);
@@ -1511,6 +1735,7 @@
 	else
 		PRINT_ERR("LCS Startup for device %s failed!\n",
 			  card->dev->name);
+	lcs_clear_thread_running_bit(card, LCS_STARTUP_THREAD);
 	return 0;
 }
 
@@ -1526,6 +1751,9 @@
 
 	card = (struct lcs_card *) data;
 	daemonize("lgwstop");
+
+	if (!lcs_do_run_thread(card, LCS_STOPLAN_THREAD))
+		return 0;
 	LCS_DBF_TEXT(4, trace, "lgwstop");
 	if (card->dev)
 		netif_stop_queue(card->dev);
@@ -1539,6 +1767,7 @@
         rc = lcs_resetcard(card);
         if (rc != 0)
                 rc = lcs_stopcard(card);
+	lcs_clear_thread_running_bit(card, LCS_STOPLAN_THREAD);
         return rc;
 }
 
@@ -1549,14 +1778,14 @@
 lcs_start_kernel_thread(struct lcs_card *card)
 {
 	LCS_DBF_TEXT(5, trace, "krnthrd");
-	if (test_and_clear_bit(0, &card->thread_mask))
+	if (lcs_do_start_thread(card, LCS_STARTUP_THREAD))
 		kernel_thread(lcs_lgw_startup_thread, (void *) card, SIGCHLD);
-	if (test_and_clear_bit(1, &card->thread_mask))
+	if (lcs_do_start_thread(card, LCS_STARTLAN_THREAD))
 		kernel_thread(lcs_lgw_startlan_thread, (void *) card, SIGCHLD);
-	if (test_and_clear_bit(2, &card->thread_mask))
+	if (lcs_do_start_thread(card, LCS_STOPLAN_THREAD))
 		kernel_thread(lcs_lgw_stoplan_thread, (void *) card, SIGCHLD);
 #ifdef CONFIG_IP_MULTICAST
-	if (test_and_clear_bit(3, &card->thread_mask))
+	if (lcs_do_start_thread(card, LCS_SET_MC_THREAD))
 		kernel_thread(lcs_register_mc_addresses, (void *) card, SIGCHLD);
 #endif
 }
@@ -1571,16 +1800,19 @@
 	if (cmd->initiator == LCS_INITIATOR_LGW) {
 		switch(cmd->cmd_code) {
 		case LCS_CMD_STARTUP:
-			set_bit(0, &card->thread_mask);
-			schedule_work(&card->kernel_thread_starter);
+			if (!lcs_set_thread_start_bit(card,
+						      LCS_STARTUP_THREAD))
+				schedule_work(&card->kernel_thread_starter);
 			break;
 		case LCS_CMD_STARTLAN:
-			set_bit(1, &card->thread_mask);
-			schedule_work(&card->kernel_thread_starter);
+			if (!lcs_set_thread_start_bit(card,
+						      LCS_STARTLAN_THREAD))
+				schedule_work(&card->kernel_thread_starter);
 			break;
 		case LCS_CMD_STOPLAN:
-			set_bit(2, &card->thread_mask);
-			schedule_work(&card->kernel_thread_starter);
+			if (!lcs_set_thread_start_bit(card,
+						      LCS_STOPLAN_THREAD))
+				schedule_work(&card->kernel_thread_starter);
 			break;
 		default:
 			PRINT_INFO("UNRECOGNIZED LGW COMMAND\n");
@@ -1953,7 +2185,9 @@
 		card->dev->set_multicast_list = lcs_set_multicast_list;
 #endif
 	netif_stop_queue(card->dev);
+	lcs_set_allowed_threads(card,0xffffffff);
 	if (recover_state == DEV_STATE_RECOVER) {
+		lcs_set_multicast_list(card->dev);
 		card->dev->flags |= IFF_UP;
 		netif_wake_queue(card->dev);
 		card->state = DEV_STATE_UP;
@@ -1982,7 +2216,9 @@
 	card = (struct lcs_card *)ccwgdev->dev.driver_data;
 	if (!card)
 		return -ENODEV;
-
+	lcs_set_allowed_threads(card, 0);
+	if (lcs_wait_for_threads(card, LCS_SET_MC_THREAD))
+		return -ERESTARTSYS;
 	LCS_DBF_HEX(3, setup, &card, sizeof(void*));
 	recover_state = card->state;
 
diff -urN linux-2.6/drivers/s390/net/lcs.h linux-2.6-s390/drivers/s390/net/lcs.h
--- linux-2.6/drivers/s390/net/lcs.h	Sat Aug 14 12:55:48 2004
+++ linux-2.6-s390/drivers/s390/net/lcs.h	Tue Aug 24 15:12:42 2004
@@ -6,7 +6,7 @@
 #include <linux/workqueue.h>
 #include <asm/ccwdev.h>
 
-#define VERSION_LCS_H "$Revision: 1.17 $"
+#define VERSION_LCS_H "$Revision: 1.18 $"
 
 #define LCS_DBF_TEXT(level, name, text) \
 	do { \
@@ -152,6 +152,12 @@
 	DEV_STATE_RECOVER,
 };
 
+enum lcs_threads {
+	LCS_SET_MC_THREAD 	= 1,
+	LCS_STARTLAN_THREAD	= 2,
+	LCS_STOPLAN_THREAD	= 4,
+	LCS_STARTUP_THREAD	= 8,
+};
 /**
  * LCS struct declarations
  */
@@ -247,9 +253,11 @@
 struct lcs_reply {
 	struct list_head list;
 	__u16 sequence_no;
+	atomic_t refcnt;
 	/* Callback for completion notification. */
 	void (*callback)(struct lcs_card *, struct lcs_cmd *);
 	wait_queue_head_t wait_q;
+	struct lcs_card *card;
 	int received;
 	int rc;
 };
@@ -268,6 +276,7 @@
 	int buf_idx;
 };
 
+
 /**
  * definition of the lcs card
  */
@@ -287,7 +296,11 @@
 	int lancmd_timeout;
 
 	struct work_struct kernel_thread_starter;
-	unsigned long thread_mask;
+	spinlock_t mask_lock;
+	unsigned long thread_start_mask;
+	unsigned long thread_running_mask;
+	unsigned long thread_allowed_mask;
+	wait_queue_head_t wait_q;
 
 #ifdef CONFIG_IP_MULTICAST
 	struct list_head ipm_list;
