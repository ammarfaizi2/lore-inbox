Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263875AbTGGLI7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 07:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264904AbTGGLI7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 07:08:59 -0400
Received: from dp.samba.org ([66.70.73.150]:51915 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263875AbTGGLI5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 07:08:57 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16137.22067.260130.880044@nanango.paulus.ozlabs.org>
Date: Mon, 7 Jul 2003 21:14:59 +1000 (EST)
From: Paul Mackerras <paulus@samba.org>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Compile fix and cleanup for macserial driver
X-Mailer: VM 6.75 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

This patch adds a declaration that the macserial driver needs in order
to compile correctly, and removes some old SERIAL_DO_RESTART junk
which isn't used (SERIAL_DO_RESTART is never defined in this driver)
and which I think is incorrect anyway, since it looks to me like it
would potentially return an ERESTARTSYS error without a signal
pending.

Please apply.  This patch is OK with Ben Herrenschmidt.

Thanks,
Paul.

diff -urN linux-2.5/drivers/macintosh/macserial.c pmac-2.5/drivers/macintosh/macserial.c
--- linux-2.5/drivers/macintosh/macserial.c	2003-06-12 20:27:47.000000000 +1000
+++ pmac-2.5/drivers/macintosh/macserial.c	2003-06-17 21:57:19.000000000 +1000
@@ -76,6 +76,8 @@
    in the order we want. */
 #define RECOVERY_DELAY	eieio()
 
+static struct tty_driver *serial_driver;
+
 struct mac_zschannel zs_channels[NUM_CHANNELS];
 
 struct mac_serial zs_soft[NUM_CHANNELS];
@@ -2093,12 +2095,7 @@
 	 */
 	if (info->flags & ZILOG_CLOSING) {
 		interruptible_sleep_on(&info->close_wait);
-#ifdef SERIAL_DO_RESTART
-		return ((info->flags & ZILOG_HUP_NOTIFY) ?
-			-EAGAIN : -ERESTARTSYS);
-#else
 		return -EAGAIN;
-#endif
 	}
 
 	/*
@@ -2139,14 +2136,7 @@
 		set_current_state(TASK_INTERRUPTIBLE);
 		if (tty_hung_up_p(filp) ||
 		    !(info->flags & ZILOG_INITIALIZED)) {
-#ifdef SERIAL_DO_RESTART
-			if (info->flags & ZILOG_HUP_NOTIFY)
-				retval = -EAGAIN;
-			else
-				retval = -ERESTARTSYS;
-#else
 			retval = -EAGAIN;
-#endif
 			break;
 		}
 		if (!(info->flags & ZILOG_CLOSING) &&
@@ -2222,12 +2212,7 @@
 	    (info->flags & ZILOG_CLOSING)) {
 		if (info->flags & ZILOG_CLOSING)
 			interruptible_sleep_on(&info->close_wait);
-#ifdef SERIAL_DO_RESTART
-		return ((info->flags & ZILOG_HUP_NOTIFY) ?
-			-EAGAIN : -ERESTARTSYS);
-#else
 		return -EAGAIN;
-#endif
 	}
 
 	/*
