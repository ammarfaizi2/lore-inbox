Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162771AbWLBEeh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162771AbWLBEeh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 23:34:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162773AbWLBEeh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 23:34:37 -0500
Received: from mta15.mail.adelphia.net ([68.168.78.77]:46465 "EHLO
	mta15.adelphia.net") by vger.kernel.org with ESMTP id S1162771AbWLBEeg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 23:34:36 -0500
Date: Fri, 1 Dec 2006 22:34:35 -0600
From: Corey Minyard <minyard@acm.org>
To: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Cc: OpenIPMI Developers <openipmi-developer@lists.sourceforge.net>
Subject: [PATCH 6/12] IPMI: fix request events
Message-ID: <20061202043434.GB30531@localdomain>
Reply-To: minyard@acm.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When the IPMI message handler requested that the interface look
for events, the ipmi_si driver would request flags, see if the
event buffer full flag was set, then request events.  It's better
to just send the request for events, as it cuts one message out
of the transaction if there happens to be events, and it will
fetch events even if the event buffer was not full.

Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.19-rc6/drivers/char/ipmi/ipmi_si_intf.c
===================================================================
--- linux-2.6.19-rc6.orig/drivers/char/ipmi/ipmi_si_intf.c
+++ linux-2.6.19-rc6/drivers/char/ipmi/ipmi_si_intf.c
@@ -684,22 +684,24 @@ static enum si_sm_result smi_event_handl
 	{
 		/* We are idle and the upper layer requested that I fetch
 		   events, so do so. */
-		unsigned char msg[2];
-
-		spin_lock(&smi_info->count_lock);
-		smi_info->flag_fetches++;
-		spin_unlock(&smi_info->count_lock);
-
 		atomic_set(&smi_info->req_events, 0);
-		msg[0] = (IPMI_NETFN_APP_REQUEST << 2);
-		msg[1] = IPMI_GET_MSG_FLAGS_CMD;
+
+		smi_info->curr_msg = ipmi_alloc_smi_msg();
+		if (!smi_info->curr_msg)
+			goto out;
+
+		smi_info->curr_msg->data[0] = (IPMI_NETFN_APP_REQUEST << 2);
+		smi_info->curr_msg->data[1] = IPMI_READ_EVENT_MSG_BUFFER_CMD;
+		smi_info->curr_msg->data_size = 2;
 
 		smi_info->handlers->start_transaction(
-			smi_info->si_sm, msg, 2);
-		smi_info->si_state = SI_GETTING_FLAGS;
+			smi_info->si_sm,
+			smi_info->curr_msg->data,
+			smi_info->curr_msg->data_size);
+		smi_info->si_state = SI_GETTING_EVENTS;
 		goto restart;
 	}
-
+ out:
 	return si_sm_result;
 }
 
