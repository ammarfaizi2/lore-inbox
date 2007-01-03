Return-Path: <linux-kernel-owner+w=401wt.eu-S1750867AbXACPbc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867AbXACPbc (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 10:31:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750872AbXACPbc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 10:31:32 -0500
Received: from mta16.mail.adelphia.net ([68.168.78.211]:46374 "EHLO
	mta16.adelphia.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750868AbXACPbb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 10:31:31 -0500
Date: Wed, 3 Jan 2007 09:31:30 -0600
From: Corey Minyard <minyard@acm.org>
To: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
       Carol Hebert <cah@us.ibm.com>,
       OpenIPMI Developers <openipmi-developer@lists.sourceforge.net>,
       Christoph Hellwig <hch@infradead.org>
Subject: [PATCH] IPMI: Fix some RCU problems
Message-ID: <20070103153130.GB16063@localdomain>
Reply-To: minyard@acm.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fix some RCU problem pointed out by Paul McKenney of IBM.  These are:

The wholesale move of the command receivers list into a new list was
not safe because the list will point to the new tail during a
traversal, so the traversal will never end on a reader if this happens
during a read.

Memory barriers were needed to handle proper ordering of the setting
of the IPMI interface as valid.  Readers might not see proper ordering
of data otherwise.

In ipmi_smi_watcher_register(), the use of the _rcu suffix on the list
is unnecessary.

This require the list_splice_init_rcu() patch previously posted.

Signed-off-by: Corey Minyard <minyard@acm.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

Index: linux-2.6.19/drivers/char/ipmi/ipmi_msghandler.c
===================================================================
--- linux-2.6.19.orig/drivers/char/ipmi/ipmi_msghandler.c	2006-12-30 12:41:15.000000000 -0600
+++ linux-2.6.19/drivers/char/ipmi/ipmi_msghandler.c	2006-12-30 12:43:50.000000000 -0600
@@ -406,13 +406,14 @@
 	free_smi_msg_list(&intf->waiting_msgs);
 	free_recv_msg_list(&intf->waiting_events);
 
-	/* Wholesale remove all the entries from the list in the
-	 * interface and wait for RCU to know that none are in use. */
+	/*
+	 * Wholesale remove all the entries from the list in the
+	 * interface and wait for RCU to know that none are in use.
+	 */
 	mutex_lock(&intf->cmd_rcvrs_mutex);
-	list_add_rcu(&list, &intf->cmd_rcvrs);
-	list_del_rcu(&intf->cmd_rcvrs);
+	INIT_LIST_HEAD(&list);
+	list_splice_init_rcu(&intf->cmd_rcvrs, &list, synchronize_rcu);
 	mutex_unlock(&intf->cmd_rcvrs_mutex);
-	synchronize_rcu();
 
 	list_for_each_entry_safe(rcvr, rcvr2, &list, link)
 		kfree(rcvr);
@@ -451,7 +452,7 @@
 	mutex_lock(&ipmi_interfaces_mutex);
 
 	/* Build a list of things to deliver. */
-	list_for_each_entry_rcu(intf, &ipmi_interfaces, link) {
+	list_for_each_entry(intf, &ipmi_interfaces, link) {
 		if (intf->intf_num == -1)
 			continue;
 		e = kmalloc(sizeof(*e), GFP_KERNEL);
@@ -838,6 +839,7 @@
 	goto out_kfree;
 
  found:
+	smp_rmb();
 	/* Note that each existing user holds a refcount to the interface. */
 	kref_get(&intf->refcount);
 
@@ -2761,6 +2763,7 @@
 		kref_put(&intf->refcount, intf_free);
 	} else {
 		/* After this point the interface is legal to use. */
+		smp_wmb(); /* Keep memory order straight for RCU readers. */
 		intf->intf_num = i;
 		mutex_unlock(&ipmi_interfaces_mutex);
 		call_smi_watchers(i, intf->si_dev);
@@ -3924,6 +3927,8 @@
 			/* Interface was not ready yet. */
 			continue;
 
+		smp_rmb();
+
 		/* First job here is to figure out where to send the
 		   OEM events.  There's no way in IPMI to send OEM
 		   events using an event send command, so we have to
