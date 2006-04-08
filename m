Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964995AbWDHCvs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964995AbWDHCvs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 22:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965000AbWDHCvs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 22:51:48 -0400
Received: from rwcrmhc11.comcast.net ([216.148.227.151]:27608 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S964995AbWDHCvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 22:51:47 -0400
Date: Fri, 7 Apr 2006 21:51:46 -0500
From: Corey Minyard <minyard@acm.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [PATCH] ipmi: fix event queue limit
Message-ID: <20060408025146.GA22525@i2.minyard.local>
Reply-To: minyard@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The event handler mechanism in the IPMI driver had a limit on the
number of received events, but the counts were not being updated.
Update the counts to impose a limit.  This is not a critical fix,
as this function (the sending of the events) has to be turned on
by the user, anyway.  This avoids problems if they forget to
turn it back off.

Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.16/drivers/char/ipmi/ipmi_msghandler.c
===================================================================
--- linux-2.6.16.orig/drivers/char/ipmi/ipmi_msghandler.c
+++ linux-2.6.16/drivers/char/ipmi/ipmi_msghandler.c
@@ -941,6 +941,7 @@ int ipmi_set_gets_events(ipmi_user_t use
 			list_del(&msg->link);
 			list_add_tail(&msg->link, &msgs);
 		}
+		intf->waiting_events_count = 0;
 	}
 
 	/* Hold the events lock while doing this to preserve order. */
@@ -2917,6 +2918,7 @@ static int handle_read_event_rsp(ipmi_sm
 
 		copy_event_into_recv_msg(recv_msg, msg);
 		list_add_tail(&(recv_msg->link), &(intf->waiting_events));
+		intf->waiting_events_count++;
 	} else {
 		/* There's too many things in the queue, discard this
 		   message. */
