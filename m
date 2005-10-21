Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964972AbVJUO4A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964972AbVJUO4A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 10:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964968AbVJUO4A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 10:56:00 -0400
Received: from rwcrmhc14.comcast.net ([204.127.198.54]:24025 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S964970AbVJUOz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 10:55:59 -0400
Date: Fri, 21 Oct 2005 09:55:58 -0500
From: Corey Minyard <minyard@acm.org>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Cc: Matt_Domsch@dell.com, rocky.craig@hp.com
Subject: [PATCH 7/9] ipmi: bt restart reset fixes
Message-ID: <20051021145558.GG19532@i2.minyard.local>
Reply-To: minyard@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The current BT retry/reset mechanism fails to succeed on a PowerEdge
1650, when the controller is wedged with B2H_ATN asserted at
XACTION_START.  If this occurs, no further commands will ever succeed
unless the state of the controller is first cleared out.

Furthermore, the soft reset would only occur if the first command
after insmod was the one that timed out, not if a later command timed out.

This patch changes the retry/reset mechanism to be as follows:

Before retrying a command, clear the state of the BT controller such
that the flags represent ready for a new transaction.  This increases
the chance of success of the restarted transaction.

After 2 retries, issue a soft reset and retry one more time before
giving up and reporting back a failure.

Signed-off-by: Matt Domsch <Matt_Domsch@dell.com>
Acked-by: Rocky Craig <rocky.craig@hp.com>
Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.ipmi/drivers/char/ipmi/ipmi_bt_sm.c
===================================================================
--- linux-2.6.ipmi.orig/drivers/char/ipmi/ipmi_bt_sm.c	2005-10-10 12:02:10.%N -0500
+++ linux-2.6.ipmi/drivers/char/ipmi/ipmi_bt_sm.c	2005-10-13 14:35:14.%N -0500
@@ -333,8 +333,7 @@
 		bt->state = BT_STATE_HOSED;
 		if (!bt->nonzero_status)
 			printk(KERN_ERR "IPMI: BT stuck, try power cycle\n");
-		else if (bt->seq == FIRST_SEQ + BT_RETRY_LIMIT) {
-			/* most likely during insmod */
+		else if (bt->error_retries <= BT_RETRY_LIMIT + 1) {
 			printk(KERN_DEBUG "IPMI: BT reset (takes 5 secs)\n");
         		bt->state = BT_STATE_RESET1;
 		}
@@ -475,6 +474,7 @@
 		break;
 
 	case BT_STATE_RESTART:		/* don't reset retries! */
+		reset_flags(bt);
 		bt->write_data[2] = ++bt->seq;
 		bt->read_count = 0;
 		bt->nonzero_status = 0;
