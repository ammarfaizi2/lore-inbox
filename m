Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266858AbUG1Jle@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266858AbUG1Jle (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 05:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266851AbUG1Jle
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 05:41:34 -0400
Received: from smtp.sys.beep.pl ([195.245.198.13]:27152 "EHLO smtp.sys.beep.pl")
	by vger.kernel.org with ESMTP id S266860AbUG1Jl2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 05:41:28 -0400
From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Organization: SelfOrganizing
To: linux-kernel <linux-kernel@vger.kernel.org>,
       Corey Minyard <minyard@mvista.com>
Subject: [PATCH]: convert ipmi_watchdog to also use module option nowayout as it's done in other watchdog drivers
Date: Wed, 28 Jul 2004 11:41:13 +0200
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Message-Id: <200407281141.13362.arekm@pld-linux.org>
X-Spam-Score: 0.0 (/)
X-Spam-Report: Points assigned by spam scoring system to this email. Note that message
	is treated as spam ONLY if X-Spam-Flag header is set to YES.
	If you have any report questions, see report postmaster@beep.pl for details.
	Content analysis details:   (0.0 points, 25.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
X-Authenticated-Id: arekm 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Convert ipmi_watchdog to also use module option ,,nowayout'' as it's done in other watchdog drivers.

Signed-off-by: Arkadiusz Miskiewicz <arekm@pld-linux.org>

--- linux.org/drivers/char/ipmi/ipmi_watchdog.c.org 2004-07-28 11:29:47.300755696 +0200
+++ linux/drivers/char/ipmi/ipmi_watchdog.c     2004-07-28 11:33:25.537578656 +0200
@@ -129,6 +129,12 @@
 #define        WDIOC_GET_PRETIMEOUT     _IOW(WATCHDOG_IOCTL_BASE, 22, int)
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
@@ -704,10 +712,10 @@
 {
        if (iminor(ino)==WATCHDOG_MINOR)
        {
-#ifndef CONFIG_WATCHDOG_NOWAYOUT
-               ipmi_watchdog_state = WDOG_TIMEOUT_NONE;
-               ipmi_set_timeout(IPMI_SET_TIMEOUT_NO_HB);
-#endif
+               if (!nowayout) {
+                       ipmi_watchdog_state = WDOG_TIMEOUT_NONE;
+                       ipmi_set_timeout(IPMI_SET_TIMEOUT_NO_HB);
+               }
                ipmi_wdog_open = 0;
        }


-- 
Arkadiusz Mi¶kiewicz     CS at FoE, Wroclaw University of Technology
arekm.pld-linux.org, 1024/3DB19BBD, JID: arekm.jabber.org, PLD/Linux
