Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261474AbVBVT2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbVBVT2R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 14:28:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261409AbVBVT1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 14:27:43 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:44969 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261410AbVBVT1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 14:27:17 -0500
Message-ID: <421B8793.7020704@acm.org>
Date: Tue, 22 Feb 2005 13:27:15 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix for the IPMI SMB driver
Content-Type: multipart/mixed;
 boundary="------------010907040808090005010306"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010907040808090005010306
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------010907040808090005010306
Content-Type: text/plain;
 name="ipmi-smb-run-timer-when-in-run-to-completion-mode.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ipmi-smb-run-timer-when-in-run-to-completion-mode.diff"

The IPMI SMB driver, when running in run-to-completion mode
(done during panic time), would sometimes get locked up if
a timeout occurred because the timer would not get run
properly.  This adds the timer handling to the run-to-completion
code.

Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.11-rc4/drivers/char/ipmi/ipmi_smb.c
===================================================================
--- linux-2.6.11-rc4.orig/drivers/char/ipmi/ipmi_smb.c
+++ linux-2.6.11-rc4/drivers/char/ipmi/ipmi_smb.c
@@ -140,6 +140,10 @@
 	   sure stuff goes out. */
 	int                 run_to_completion;
 
+	/* Used to perform timer operations when run-to-completion
+	   mode is on.  This is a countdown timer. */
+	int                 rtc_us_timer;
+
 	/* Used for sending/receiving data.  +1 for the length. */
 	unsigned char data[IPMI_MAX_MSG_LENGTH + 1];
 	unsigned int  data_len;
@@ -322,6 +326,8 @@
         struct smb_info     *smb_info = (void *) data;
         struct i2c_op_q_entry *i2ce;
 
+	smb_info->rtc_us_timer = 0;
+
         i2ce = &smb_info->i2c_q_entry;
         i2ce->xfer_type = I2C_OP_SMBUS;
         i2ce->handler = msg_done_handler;
@@ -380,6 +386,7 @@
 			t->data = (unsigned long) smb_info;
 			t->function = retry_timeout;
 			add_timer(t);
+			smb_info->rtc_us_timer = 10000;
 			return;
 		}
 		if  (smb_info->smb_debug & SMB_DEBUG_MSG)
@@ -790,6 +797,13 @@
 		i2c_poll(&smb_info->client, 0);
 		while (! SMB_IDLE(smb_info)) {
 			udelay(500);
+			if (smb_info->rtc_us_timer > 0) {
+				smb_info->rtc_us_timer -= 500;
+				if (smb_info->rtc_us_timer <= 0) {
+					retry_timeout((unsigned long) smb_info);
+					del_timer(&smb_info->retry_timer);
+				}
+			}
 			i2c_poll(&smb_info->client, 500);
 		}
 		return;
@@ -856,6 +870,13 @@
 		i2c_poll(&smb_info->client, 0);
 		while (! SMB_IDLE(smb_info)) {
 			udelay(500);
+			if (smb_info->rtc_us_timer > 0) {
+				smb_info->rtc_us_timer -= 500;
+				if (smb_info->rtc_us_timer <= 0) {
+					retry_timeout((unsigned long) smb_info);
+					del_timer(&smb_info->retry_timer);
+				}
+			}
 			i2c_poll(&smb_info->client, 500);
 		}
 	}

--------------010907040808090005010306--
