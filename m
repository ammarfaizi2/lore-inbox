Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264067AbUEHEQT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264067AbUEHEQT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 00:16:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264082AbUEHEQS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 00:16:18 -0400
Received: from gate.crashing.org ([63.228.1.57]:18631 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S264067AbUEHEQR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 00:16:17 -0400
Subject: [PATCH] Fix CTS handling in pmac-zilog.c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1083989323.19985.151.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 08 May 2004 14:08:44 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(From: Paul Mackerras <paulus@samba.org>)

This patch fixes a bug in the pmac-zilog driver where if you enable
CRTSCTS mode, it won't output data when CTS is asserted.  On
powermacs, the CTS input is inverted.  It also fixes a logic bug in
testing for CTS and DCD changes.

diff -urN linux-2.5/drivers/serial/pmac_zilog.c pmac-2.5/drivers/serial/pmac_zilog.c
--- linux-2.5/drivers/serial/pmac_zilog.c	2004-04-01 06:59:37.000000000 +1000
+++ pmac-2.5/drivers/serial/pmac_zilog.c	2004-05-07 21:06:49.000000000 +1000
@@ -352,13 +352,14 @@
 		/* The Zilog just gives us an interrupt when DCD/CTS/etc. change.
 		 * But it does not tell us which bit has changed, we have to keep
 		 * track of this ourselves.
+		 * The CTS input is inverted for some reason.  -- paulus
 		 */
-		if ((status & DCD) ^ uap->prev_status)
+		if ((status ^ uap->prev_status) & DCD)
 			uart_handle_dcd_change(&uap->port,
 					       (status & DCD));
-		if ((status & CTS) ^ uap->prev_status)
+		if ((status ^ uap->prev_status) & CTS)
 			uart_handle_cts_change(&uap->port,
-					       (status & CTS));
+					       !(status & CTS));
 
 		wake_up_interruptible(&uap->port.info->delta_msr_wait);
 	}
@@ -595,7 +596,7 @@
 		ret |= TIOCM_CAR;
 	if (status & SYNC_HUNT)
 		ret |= TIOCM_DSR;
-	if (status & CTS)
+	if (!(status & CTS))
 		ret |= TIOCM_CTS;
 
 	return ret;
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

