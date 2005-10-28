Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965226AbVJ1NTq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965226AbVJ1NTq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 09:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965227AbVJ1NTq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 09:19:46 -0400
Received: from rwcrmhc12.comcast.net ([204.127.198.43]:6059 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S965226AbVJ1NTp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 09:19:45 -0400
Date: Fri, 28 Oct 2005 08:19:44 -0500
From: Corey Minyard <minyard@acm.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, paulmck@us.ibm.com
Subject: [PATCH] ipmi: use rcu lock for using command receivers
Message-ID: <20051028131944.GA10285@i2.minyard.local>
Reply-To: minyard@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I finally got some time to think this through and test it.
This patch is in addition to the ipmi-use-refcount-in-message-handler
patch.
Thanks again, Paul, for seeing this.

Use rcu_read_lock for the cmd_rcvrs list, since that was what
what intended, anyway.  This means that all the users of the
cmd_rcvrs_lock are tasks, so the irq disables are no longer
required for that lock and it can become a semaphore.

Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.14-rc4/drivers/char/ipmi/ipmi_msghandler.c
===================================================================
--- linux-2.6.14-rc4.orig/drivers/char/ipmi/ipmi_msghandler.c
+++ linux-2.6.14-rc4/drivers/char/ipmi/ipmi_msghandler.c
@@ -209,7 +209,7 @@ struct ipmi_smi
 
 	/* The list of command receivers that are registered for commands
 	   on this interface. */
-	spinlock_t       cmd_rcvrs_lock;
+	struct semaphore cmd_rcvrs_lock;
 	struct list_head cmd_rcvrs;
 
 	/* Events that were queues because no one was there to receive
@@ -345,7 +345,6 @@ static void clean_up_interface_data(ipmi
 {
 	int              i;
 	struct cmd_rcvr  *rcvr, *rcvr2;
-	unsigned long    flags;
 	struct list_head list;
 
 	free_recv_msg_list(&intf->waiting_msgs);
@@ -353,10 +352,10 @@ static void clean_up_interface_data(ipmi
 
 	/* Wholesale remove all the entries from the list in the
 	 * interface and wait for RCU to know that none are in use. */
-	spin_lock_irqsave(&intf->cmd_rcvrs_lock, flags);
+	down(&intf->cmd_rcvrs_lock);
 	list_add_rcu(&list, &intf->cmd_rcvrs);
 	list_del_rcu(&intf->cmd_rcvrs);
-	spin_unlock_irqrestore(&intf->cmd_rcvrs_lock, flags);
+	up(&intf->cmd_rcvrs_lock);
 	synchronize_rcu();
 
 	list_for_each_entry_safe(rcvr, rcvr2, &list, link)
@@ -812,7 +811,7 @@ int ipmi_destroy_user(ipmi_user_t user)
 	 * since other things may be using it till we do
 	 * synchronize_rcu()) then free everything in that list.
 	 */
-	spin_lock_irqsave(&intf->cmd_rcvrs_lock, flags);
+	down(&intf->cmd_rcvrs_lock);
 	list_for_each_safe_rcu(entry1, entry2, &intf->cmd_rcvrs) {
 		rcvr = list_entry(entry1, struct cmd_rcvr, link);
 		if (rcvr->user == user) {
@@ -821,7 +820,7 @@ int ipmi_destroy_user(ipmi_user_t user)
 			rcvrs = rcvr;
 		}
 	}
-	spin_unlock_irqrestore(&intf->cmd_rcvrs_lock, flags);
+	up(&intf->cmd_rcvrs_lock);
 	synchronize_rcu();
 	while (rcvrs) {
 		rcvr = rcvrs;
@@ -950,7 +949,7 @@ int ipmi_register_for_cmd(ipmi_user_t   
 	rcvr->netfn = netfn;
 	rcvr->user = user;
 
-	spin_lock_irq(&intf->cmd_rcvrs_lock);
+	down(&intf->cmd_rcvrs_lock);
 	/* Make sure the command/netfn is not already registered. */
 	entry = find_cmd_rcvr(intf, netfn, cmd);
 	if (entry) {
@@ -961,7 +960,7 @@ int ipmi_register_for_cmd(ipmi_user_t   
 	list_add_rcu(&rcvr->link, &intf->cmd_rcvrs);
 
  out_unlock:
-	spin_unlock_irq(&intf->cmd_rcvrs_lock);
+	up(&intf->cmd_rcvrs_lock);
 	if (rv)
 		kfree(rcvr);
 
@@ -975,17 +974,17 @@ int ipmi_unregister_for_cmd(ipmi_user_t 
 	ipmi_smi_t      intf = user->intf;
 	struct cmd_rcvr *rcvr;
 
-	spin_lock_irq(&intf->cmd_rcvrs_lock);
+	down(&intf->cmd_rcvrs_lock);
 	/* Make sure the command/netfn is not already registered. */
 	rcvr = find_cmd_rcvr(intf, netfn, cmd);
 	if ((rcvr) && (rcvr->user == user)) {
 		list_del_rcu(&rcvr->link);
-		spin_unlock_irq(&intf->cmd_rcvrs_lock);
+		up(&intf->cmd_rcvrs_lock);
 		synchronize_rcu();
 		kfree(rcvr);
 		return 0;
 	} else {
-		spin_unlock_irq(&intf->cmd_rcvrs_lock);
+		up(&intf->cmd_rcvrs_lock);
 		return -ENOENT;
 	}
 }
@@ -1858,7 +1857,7 @@ int ipmi_register_smi(struct ipmi_smi_ha
 	spin_lock_init(&intf->events_lock);
 	INIT_LIST_HEAD(&intf->waiting_events);
 	intf->waiting_events_count = 0;
-	spin_lock_init(&intf->cmd_rcvrs_lock);
+	init_MUTEX(&intf->cmd_rcvrs_lock);
 	INIT_LIST_HEAD(&intf->cmd_rcvrs);
 	init_waitqueue_head(&intf->waitq);
 
@@ -2058,14 +2057,14 @@ static int handle_ipmb_get_msg_cmd(ipmi_
 	netfn = msg->rsp[4] >> 2;
 	cmd = msg->rsp[8];
 
-	spin_lock_irqsave(&intf->cmd_rcvrs_lock, flags);
+	rcu_read_lock();
 	rcvr = find_cmd_rcvr(intf, netfn, cmd);
 	if (rcvr) {
 		user = rcvr->user;
 		kref_get(&user->refcount);
 	} else
 		user = NULL;
-	spin_unlock_irqrestore(&intf->cmd_rcvrs_lock, flags);
+	rcu_read_unlock();
 
 	if (user == NULL) {
 		/* We didn't find a user, deliver an error response. */
@@ -2238,14 +2237,14 @@ static int handle_lan_get_msg_cmd(ipmi_s
 	netfn = msg->rsp[6] >> 2;
 	cmd = msg->rsp[10];
 
-	spin_lock_irqsave(&intf->cmd_rcvrs_lock, flags);
+	rcu_read_lock();
 	rcvr = find_cmd_rcvr(intf, netfn, cmd);
 	if (rcvr) {
 		user = rcvr->user;
 		kref_get(&user->refcount);
 	} else
 		user = NULL;
-	spin_unlock_irqrestore(&intf->cmd_rcvrs_lock, flags);
+	rcu_read_unlock();
 
 	if (user == NULL) {
 		/* We didn't find a user, just give up. */
