Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030312AbVIATLx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030312AbVIATLx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 15:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030314AbVIATLx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 15:11:53 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:8671 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1030312AbVIATLw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 15:11:52 -0400
Subject: [PATCH] part 2 - remove unused fields from the IPMI driver
From: Corey Minyard <minyard@acm.org>
To: Andrew Morton <akpm@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-iamncaLbeDp0aZN14v/N"
Date: Thu, 01 Sep 2005 14:11:39 -0500
Message-Id: <1125601899.4403.4.camel@i2.minyard.local>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3-5mdk 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-iamncaLbeDp0aZN14v/N
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



--=-iamncaLbeDp0aZN14v/N
Content-Disposition: attachment; filename=ipmi-remove-all-cmd-rcvr.patch
Content-Type: text/x-patch; name=ipmi-remove-all-cmd-rcvr.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit

This removes the unused "all_cmd_rcvr" variable from the
IPMI driver.

Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.13/drivers/char/ipmi/ipmi_msghandler.c
===================================================================
--- linux-2.6.13.orig/drivers/char/ipmi/ipmi_msghandler.c
+++ linux-2.6.13/drivers/char/ipmi/ipmi_msghandler.c
@@ -202,12 +202,6 @@ struct ipmi_smi
 	struct list_head waiting_events;
 	unsigned int     waiting_events_count; /* How many events in queue? */
 
-	/* This will be non-null if someone registers to receive all
-	   IPMI commands (this is for interface emulation).  There
-	   may not be any things in the cmd_rcvrs list above when
-	   this is registered. */
-	ipmi_user_t all_cmd_rcvr;
-
 	/* The event receiver for my BMC, only really used at panic
 	   shutdown as a place to store this. */
 	unsigned char event_receiver;
@@ -867,11 +861,6 @@ int ipmi_register_for_cmd(ipmi_user_t   
 
 	read_lock(&(user->intf->users_lock));
 	write_lock_irqsave(&(user->intf->cmd_rcvr_lock), flags);
-	if (user->intf->all_cmd_rcvr != NULL) {
-		rv = -EBUSY;
-		goto out_unlock;
-	}
-
 	/* Make sure the command/netfn is not already registered. */
 	list_for_each_entry(cmp, &(user->intf->cmd_rcvrs), link) {
 		if ((cmp->netfn == netfn) && (cmp->cmd == cmd)) {
@@ -886,7 +875,7 @@ int ipmi_register_for_cmd(ipmi_user_t   
 		rcvr->user = user;
 		list_add_tail(&(rcvr->link), &(user->intf->cmd_rcvrs));
 	}
- out_unlock:
+
 	write_unlock_irqrestore(&(user->intf->cmd_rcvr_lock), flags);
 	read_unlock(&(user->intf->users_lock));
 
@@ -1799,7 +1788,6 @@ int ipmi_register_smi(struct ipmi_smi_ha
 			rwlock_init(&(new_intf->cmd_rcvr_lock));
 			init_waitqueue_head(&new_intf->waitq);
 			INIT_LIST_HEAD(&(new_intf->cmd_rcvrs));
-			new_intf->all_cmd_rcvr = NULL;
 
 			spin_lock_init(&(new_intf->counter_lock));
 
@@ -2037,15 +2025,11 @@ static int handle_ipmb_get_msg_cmd(ipmi_
 
 	read_lock(&(intf->cmd_rcvr_lock));
 	
-	if (intf->all_cmd_rcvr) {
-		user = intf->all_cmd_rcvr;
-	} else {
-		/* Find the command/netfn. */
-		list_for_each_entry(rcvr, &(intf->cmd_rcvrs), link) {
-			if ((rcvr->netfn == netfn) && (rcvr->cmd == cmd)) {
-				user = rcvr->user;
-				break;
-			}
+	/* Find the command/netfn. */
+	list_for_each_entry(rcvr, &(intf->cmd_rcvrs), link) {
+		if ((rcvr->netfn == netfn) && (rcvr->cmd == cmd)) {
+			user = rcvr->user;
+			break;
 		}
 	}
 	read_unlock(&(intf->cmd_rcvr_lock));
@@ -2222,15 +2206,11 @@ static int handle_lan_get_msg_cmd(ipmi_s
 
 	read_lock(&(intf->cmd_rcvr_lock));
 
-	if (intf->all_cmd_rcvr) {
-		user = intf->all_cmd_rcvr;
-	} else {
-		/* Find the command/netfn. */
-		list_for_each_entry(rcvr, &(intf->cmd_rcvrs), link) {
-			if ((rcvr->netfn == netfn) && (rcvr->cmd == cmd)) {
-				user = rcvr->user;
-				break;
-			}
+	/* Find the command/netfn. */
+	list_for_each_entry(rcvr, &(intf->cmd_rcvrs), link) {
+		if ((rcvr->netfn == netfn) && (rcvr->cmd == cmd)) {
+			user = rcvr->user;
+			break;
 		}
 	}
 	read_unlock(&(intf->cmd_rcvr_lock));

--=-iamncaLbeDp0aZN14v/N--

