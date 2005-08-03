Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261616AbVHCW4y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261616AbVHCW4y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 18:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbVHCW4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 18:56:53 -0400
Received: from rwcrmhc13.comcast.net ([216.148.227.118]:28066 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261616AbVHCWzm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 18:55:42 -0400
Message-ID: <42F14B6B.5050902@acm.org>
Date: Wed, 03 Aug 2005 17:55:39 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] IPMI driver update part 3, watchdog/NMI interaction fixes
Content-Type: multipart/mixed;
 boundary="------------040405020208030507020708"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040405020208030507020708
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------040405020208030507020708
Content-Type: unknown/unknown;
 name="ipmi_wdog_nmi_fixes.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ipmi_wdog_nmi_fixes.patch"

There are some interactions between IPMI NMI timeouts and
the other operations of the IPMI driver.  This make sure those
interactions are handled properly.

Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.13-rc5/drivers/char/ipmi/ipmi_watchdog.c
===================================================================
--- linux-2.6.13-rc5.orig/drivers/char/ipmi/ipmi_watchdog.c
+++ linux-2.6.13-rc5/drivers/char/ipmi/ipmi_watchdog.c
@@ -259,7 +259,7 @@
 
 	data[1] = 0;
 	WDOG_SET_TIMEOUT_ACT(data[1], ipmi_watchdog_state);
-	if (pretimeout > 0) {
+	if ((pretimeout > 0) && (ipmi_watchdog_state != WDOG_TIMEOUT_NONE)) {
 	    WDOG_SET_PRETIMEOUT_ACT(data[1], preaction_val);
 	    data[2] = pretimeout;
 	} else {
@@ -817,15 +817,19 @@
 static int
 ipmi_nmi(void *dev_id, struct pt_regs *regs, int cpu, int handled)
 {
+        /* If we are not expecting a timeout, ignore it. */
+	if (ipmi_watchdog_state == WDOG_TIMEOUT_NONE)
+		return NOTIFY_DONE;
+
 	/* If no one else handled the NMI, we assume it was the IPMI
            watchdog. */
-	if ((!handled) && (preop_val == WDOG_PREOP_PANIC))
+	if ((!handled) && (preop_val == WDOG_PREOP_PANIC)) {
+		/* On some machines, the heartbeat will give
+		   an error and not work unless we re-enable
+		   the timer.   So do so. */
+		pretimeout_since_last_heartbeat = 1;
 		panic(PFX "pre-timeout");
-
-	/* On some machines, the heartbeat will give
-	   an error and not work unless we re-enable
-	   the timer.   So do so. */
-	pretimeout_since_last_heartbeat = 1;
+	}
 
 	return NOTIFY_DONE;
 }

--------------040405020208030507020708--
