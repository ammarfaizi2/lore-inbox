Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266921AbUG1OQK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266921AbUG1OQK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 10:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267164AbUG1OQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 10:16:10 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:46491 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S266921AbUG1OQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 10:16:01 -0400
Message-ID: <4107B520.1060506@mvista.com>
Date: Wed, 28 Jul 2004 09:16:00 -0500
From: Corey Minyard <cminyard@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030428
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH]: convert ipmi_watchdog to also use module option nowayout
 as it's done in other watchdog drivers
References: <200407281141.13362.arekm@pld-linux.org>
In-Reply-To: <200407281141.13362.arekm@pld-linux.org>
Content-Type: multipart/mixed;
 boundary="------------000509040804030802020104"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000509040804030802020104
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

>
>
>Convert ipmi_watchdog to also use module option ,,nowayout'' as it's done in other watchdog drivers.
>  
>
The patch is good (same style as other watchdogs), but needs to have some documentation updated.  I've tacked that on.


Signed-off-by: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Signed-off-by: Corey Minyard <minyard@acm.org>


--------------000509040804030802020104
Content-Type: text/plain;
 name="ipmi-wdog-nowayout.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ipmi-wdog-nowayout.diff"

Index: linux-ipmi/Documentation/IPMI.txt
===================================================================
--- linux-ipmi.orig/Documentation/IPMI.txt	2004-05-21 11:48:29.000000000 -0500
+++ linux-ipmi/Documentation/IPMI.txt	2004-07-28 09:12:42.000000000 -0500
@@ -442,6 +442,7 @@
 
   modprobe ipmi_watchdog timeout=<t> pretimeout=<t> action=<action type>
       preaction=<preaction type> preop=<preop type> start_now=x
+      nowayout=x
 
 The timeout is the number of seconds to the action, and the pretimeout
 is the amount of seconds before the reset that the pre-timeout panic will
@@ -472,6 +473,10 @@
 If start_now is set to 1, the watchdog timer will start running as
 soon as the driver is loaded.
 
+If nowayout is set to 1, the watchdog timer will not stop when the
+watchdog device is closed.  The default value of nowayout is true
+if the CONFIG_WATCHDOG_NOWAYOUT option is enabled, or false if not.
+
 When compiled into the kernel, the kernel command line is available
 for configuring the watchdog:
 
@@ -480,6 +485,7 @@
 	ipmi_watchdog.preaction=<preaction type>
 	ipmi_watchdog.preop=<preop type>
 	ipmi_watchdog.start_now=x
+	ipmi_watchdog.nowayout=x
 
 The options are the same as the module parameter options.
 
Index: linux-ipmi/drivers/char/ipmi/ipmi_watchdog.c
===================================================================
--- linux-ipmi.orig/drivers/char/ipmi/ipmi_watchdog.c	2004-07-28 09:09:25.000000000 -0500
+++ linux-ipmi/drivers/char/ipmi/ipmi_watchdog.c	2004-07-28 09:10:40.000000000 -0500
@@ -129,6 +129,12 @@
 #define	WDIOC_GET_PRETIMEOUT     _IOW(WATCHDOG_IOCTL_BASE, 22, int)
 #endif
 
+#ifdef CONFIG_WATCHDOG_NOWAYOUT
+static int nowayout = 1;
+#else
+static int nowayout = 0;
+#endif
+
 static ipmi_user_t watchdog_user = NULL;
 
 /* Default the timeout to 10 seconds. */
@@ -175,6 +181,8 @@
 module_param(start_now, int, 0);
 MODULE_PARM_DESC(start_now, "Set to 1 to start the watchdog as"
 		 "soon as the driver is loaded.");
+module_param(nowayout, int, 0);
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
 
 /* Default state of the timer. */
 static unsigned char ipmi_watchdog_state = WDOG_TIMEOUT_NONE;
@@ -707,10 +715,10 @@
 {
 	if (iminor(ino)==WATCHDOG_MINOR)
 	{
-#ifndef CONFIG_WATCHDOG_NOWAYOUT	
-		ipmi_watchdog_state = WDOG_TIMEOUT_NONE;
-		ipmi_set_timeout(IPMI_SET_TIMEOUT_NO_HB);
-#endif		
+		if (!nowayout) {
+			ipmi_watchdog_state = WDOG_TIMEOUT_NONE;
+			ipmi_set_timeout(IPMI_SET_TIMEOUT_NO_HB);
+		}
 	        ipmi_wdog_open = 0;
 	}
 

--------------000509040804030802020104--

