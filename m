Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751625AbVJ1NXS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751625AbVJ1NXS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 09:23:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751627AbVJ1NXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 09:23:18 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:61598 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1751621AbVJ1NXR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 09:23:17 -0400
Date: Fri, 28 Oct 2005 08:23:16 -0500
From: Corey Minyard <minyard@acm.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [PATCH] ipmi: fix watchdog timeout panic handling
Message-ID: <20051028132316.GB10285@i2.minyard.local>
Reply-To: minyard@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If a panic came from the IPMI watchdog pretimeout and that was reported
via an NMI, it would also be reported via the standard IPMI flags,
which would get picked up when reporting panic events and cause another
panic.  This adds an atomic to avoid calling panic twice.

Signed-off-by: Corey Minyard <cminyard@mvista.com>

Index: linux-2.6.14-rc4/drivers/char/ipmi/ipmi_watchdog.c
===================================================================
--- linux-2.6.14-rc4.orig/drivers/char/ipmi/ipmi_watchdog.c
+++ linux-2.6.14-rc4/drivers/char/ipmi/ipmi_watchdog.c
@@ -49,6 +49,7 @@
 #include <linux/poll.h>
 #include <linux/string.h>
 #include <linux/ctype.h>
+#include <asm/atomic.h>
 #ifdef CONFIG_X86_LOCAL_APIC
 #include <asm/apic.h>
 #endif
@@ -288,6 +289,8 @@ static int ipmi_start_timer_on_heartbeat
 static unsigned char ipmi_version_major;
 static unsigned char ipmi_version_minor;
 
+/* If a pretimeout occurs, this is used to allow only one panic to happen. */
+static atomic_t preop_panic_excl = ATOMIC_INIT(-1);
 
 static int ipmi_heartbeat(void);
 static void panic_halt_ipmi_heartbeat(void);
@@ -833,9 +836,10 @@ static void ipmi_wdog_msg_handler(struct
 static void ipmi_wdog_pretimeout_handler(void *handler_data)
 {
 	if (preaction_val != WDOG_PRETIMEOUT_NONE) {
-		if (preop_val == WDOG_PREOP_PANIC)
-			panic("Watchdog pre-timeout");
-		else if (preop_val == WDOG_PREOP_GIVE_DATA) {
+		if (preop_val == WDOG_PREOP_PANIC) {
+			if (atomic_inc_and_test(&preop_panic_excl))
+				panic("Watchdog pre-timeout");
+		} else if (preop_val == WDOG_PREOP_GIVE_DATA) {
 			spin_lock(&ipmi_read_lock);
 			data_to_read = 1;
 			wake_up_interruptible(&read_q);
@@ -909,7 +913,8 @@ ipmi_nmi(void *dev_id, struct pt_regs *r
 		   an error and not work unless we re-enable
 		   the timer.   So do so. */
 		pretimeout_since_last_heartbeat = 1;
-		panic(PFX "pre-timeout");
+		if (atomic_inc_and_test(&preop_panic_excl))
+			panic(PFX "pre-timeout");
 	}
 
 	return NOTIFY_DONE;
