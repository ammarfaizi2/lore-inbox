Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750780AbVKKOMZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbVKKOMZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 09:12:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbVKKOMZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 09:12:25 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:62655 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1750780AbVKKOMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 09:12:24 -0500
Date: Fri, 11 Nov 2005 08:12:21 -0600
From: Corey Minyard <minyard@acm.org>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, hishii@soft.fujitsu.com
Subject: [PATCH] ipmi: fix inconsistent spinlock usage
Message-ID: <20051111141221.GA6497@i2.minyard.local>
Reply-To: minyard@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

An obvious bug.  Thanks, Hironobu.

Part of a patch was accidentally reverted, this corrects an
inconsistent spinlock use in the IPMI message handler.

Signed-off-by: Hironobu Ishii <hishii@soft.fujitsu.com>
Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.14-rc4/drivers/char/ipmi/ipmi_msghandler.c
===================================================================
--- linux-2.6.14-rc4.orig/drivers/char/ipmi/ipmi_msghandler.c
+++ linux-2.6.14-rc4/drivers/char/ipmi/ipmi_msghandler.c
@@ -2664,7 +2664,7 @@ void ipmi_smi_msg_received(ipmi_smi_t   
 	spin_lock_irqsave(&intf->waiting_msgs_lock, flags);
 	if (!list_empty(&intf->waiting_msgs)) {
 		list_add_tail(&msg->link, &intf->waiting_msgs);
-		spin_unlock(&intf->waiting_msgs_lock);
+		spin_unlock_irqrestore(&intf->waiting_msgs_lock, flags);
 		goto out;
 	}
 	spin_unlock_irqrestore(&intf->waiting_msgs_lock, flags);
@@ -2673,9 +2673,9 @@ void ipmi_smi_msg_received(ipmi_smi_t   
 	if (rv > 0) {
 		/* Could not handle the message now, just add it to a
                    list to handle later. */
-		spin_lock(&intf->waiting_msgs_lock);
+		spin_lock_irqsave(&intf->waiting_msgs_lock, flags);
 		list_add_tail(&msg->link, &intf->waiting_msgs);
-		spin_unlock(&intf->waiting_msgs_lock);
+		spin_unlock_irqrestore(&intf->waiting_msgs_lock, flags);
 	} else if (rv == 0) {
 		ipmi_free_smi_msg(msg);
 	}
