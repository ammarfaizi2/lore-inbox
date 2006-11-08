Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161359AbWKHWGD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161359AbWKHWGD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 17:06:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161483AbWKHWGB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 17:06:01 -0500
Received: from mta6.adelphia.net ([68.168.78.190]:12539 "EHLO
	mta6.adelphia.net") by vger.kernel.org with ESMTP id S1161359AbWKHWGA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 17:06:00 -0500
Date: Wed, 8 Nov 2006 15:31:43 -0600
From: Corey Minyard <minyard@acm.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Cc: Patrick Schoeller <Patrick.Schoeller@hp.com>
Subject: [PATCH] IPMI: Clean up the waiting message queue properly on unload
Message-ID: <20061108213143.GA17513@localdomain>
Reply-To: minyard@acm.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A wrong function was being used to free a list; this fixes
the problem.  Otherwise, an oops at unload time was possible.
But not likely, since you can't have any users when you unload
the modules and it is very hard to get messages into this
queue without users.

Signed-off-by: Corey Minyard <minyard@acm.org>
Cc: Patrick Schoeller <Patrick.Schoeller@hp.com>

Index: linux-2.6.18/drivers/char/ipmi/ipmi_msghandler.c
===================================================================
--- linux-2.6.18.orig/drivers/char/ipmi/ipmi_msghandler.c
+++ linux-2.6.18/drivers/char/ipmi/ipmi_msghandler.c
@@ -387,13 +387,23 @@ static void free_recv_msg_list(struct li
 	}
 }
 
+static void free_smi_msg_list(struct list_head *q)
+{
+	struct ipmi_smi_msg *msg, *msg2;
+
+	list_for_each_entry_safe(msg, msg2, q, link) {
+		list_del(&msg->link);
+		ipmi_free_smi_msg(msg);
+	}
+}
+
 static void clean_up_interface_data(ipmi_smi_t intf)
 {
 	int              i;
 	struct cmd_rcvr  *rcvr, *rcvr2;
 	struct list_head list;
 
-	free_recv_msg_list(&intf->waiting_msgs);
+	free_smi_msg_list(&intf->waiting_msgs);
 	free_recv_msg_list(&intf->waiting_events);
 
 	/* Wholesale remove all the entries from the list in the
