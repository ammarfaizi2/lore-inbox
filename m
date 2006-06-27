Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030217AbWF0SPQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030217AbWF0SPQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 14:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030247AbWF0SPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 14:15:15 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.154]:30662 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S1030217AbWF0SPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 14:15:13 -0400
Date: Tue, 27 Jun 2006 13:15:46 -0500
From: minyard@acm.org
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>,
       OpenIPMI Developers <openipmi-developer@lists.sourceforge.net>
Subject: [PATCH] IPMI: watchdog handle panic properly
Message-ID: <20060627181546.GC10805@localdomain>
Reply-To: minyard@acm.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Modify the watchdog timeout in IPMI to only do things at panic/reboot
time if the watchdog timer was already running.  Some BIOSes do not
disable the watchdog timer at startup, and this led to a reboot a
while later if the new OS running didn't start monitoring the watchdog,
even if the watchdog was not running before.

Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.16/drivers/char/ipmi/ipmi_watchdog.c
===================================================================
--- linux-2.6.16.orig/drivers/char/ipmi/ipmi_watchdog.c
+++ linux-2.6.16/drivers/char/ipmi/ipmi_watchdog.c
@@ -966,9 +966,10 @@ static int wdog_reboot_handler(struct no
 			/* Disable the WDT if we are shutting down. */
 			ipmi_watchdog_state = WDOG_TIMEOUT_NONE;
 			panic_halt_ipmi_set_timeout();
-		} else {
+		} else if (ipmi_watchdog_state != WDOG_TIMEOUT_NONE) {
 			/* Set a long timer to let the reboot happens, but
-			   reboot if it hangs. */
+			   reboot if it hangs, but only if the watchdog
+			   timer was already running. */
 			timeout = 120;
 			pretimeout = 0;
 			ipmi_watchdog_state = WDOG_TIMEOUT_RESET;
@@ -990,16 +991,17 @@ static int wdog_panic_handler(struct not
 {
 	static int panic_event_handled = 0;
 
-	/* On a panic, if we have a panic timeout, make sure that the thing
-	   reboots, even if it hangs during that panic. */
-	if (watchdog_user && !panic_event_handled) {
-		/* Make sure the panic doesn't hang, and make sure we
-		   do this only once. */
+	/* On a panic, if we have a panic timeout, make sure to extend
+	   the watchdog timer to a reasonable value to complete the
+	   panic, if the watchdog timer is running.  Plus the
+	   pretimeout is meaningless at panic time. */
+	if (watchdog_user && !panic_event_handled &&
+	    ipmi_watchdog_state != WDOG_TIMEOUT_NONE) {
+		/* Make sure we do this only once. */
 		panic_event_handled = 1;
 	    
 		timeout = 255;
 		pretimeout = 0;
-		ipmi_watchdog_state = WDOG_TIMEOUT_RESET;
 		panic_halt_ipmi_set_timeout();
 	}
 
