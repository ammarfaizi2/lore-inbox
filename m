Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261310AbVESXne@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261310AbVESXne (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 19:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261303AbVESXmq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 19:42:46 -0400
Received: from sccrmhc14.comcast.net ([204.127.202.59]:35994 "EHLO
	sccrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S261310AbVESXbL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 19:31:11 -0400
Message-ID: <428D21B9.5040607@acm.org>
Date: Thu, 19 May 2005 18:31:05 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] IPMI timer shutdown cleanup
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------080905070803000609020607"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080905070803000609020607
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------080905070803000609020607
Content-Type: text/x-patch;
 name="ipmi-fix-timer-stop.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ipmi-fix-timer-stop.diff"

Clean up the timer shutdown handling in the IPMI driver.

Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.12-rc2/drivers/char/ipmi/ipmi_msghandler.c
===================================================================
--- linux-2.6.12-rc2.orig/drivers/char/ipmi/ipmi_msghandler.c
+++ linux-2.6.12-rc2/drivers/char/ipmi/ipmi_msghandler.c
@@ -2806,16 +2806,13 @@
    the queue and this silliness can go away. */
 #define IPMI_REQUEST_EV_TIME	(1000 / (IPMI_TIMEOUT_TIME))
 
-static volatile int stop_operation = 0;
-static volatile int timer_stopped = 0;
+static atomic_t stop_operation;
 static unsigned int ticks_to_req_ev = IPMI_REQUEST_EV_TIME;
 
 static void ipmi_timeout(unsigned long data)
 {
-	if (stop_operation) {
-		timer_stopped = 1;
+	if (atomic_read(&stop_operation))
 		return;
-	}
 
 	ticks_to_req_ev--;
 	if (ticks_to_req_ev == 0) {
@@ -2825,8 +2822,7 @@
 
 	ipmi_timeout_handler(IPMI_TIMEOUT_TIME);
 
-	ipmi_timer.expires += IPMI_TIMEOUT_JIFFIES;
-	add_timer(&ipmi_timer);
+	mod_timer(&ipmi_timer, jiffies + IPMI_TIMEOUT_JIFFIES);
 }
 
 
@@ -3189,11 +3185,8 @@
 
 	/* Tell the timer to stop, then wait for it to stop.  This avoids
 	   problems with race conditions removing the timer here. */
-	stop_operation = 1;
-	while (!timer_stopped) {
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout(1);
-	}
+	atomic_inc(&stop_operation);
+	del_timer_sync(&ipmi_timer);
 
 	remove_proc_entry(proc_ipmi_root->name, &proc_root);
 

--------------080905070803000609020607--
