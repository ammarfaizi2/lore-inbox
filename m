Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261333AbVC2TuL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261333AbVC2TuL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 14:50:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261341AbVC2TuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 14:50:10 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:34787 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261333AbVC2TuB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 14:50:01 -0500
Date: Tue, 29 Mar 2005 13:49:56 -0600 (CST)
From: Patrick Gefre <pfg@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: Patrick Gefre <pfg@sgi.com>
Message-Id: <20050329194956.30693.94506.sendpatchset@attica.americas.sgi.com>
Subject: [PATCH 2.6.12 1/2] Altix ioc4 serial - set hfc from ioctl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Allow hardware flow control to be set from an ioctl.

Signed-off-by: Patrick Gefre <pfg@sgi.com>



Index: linux-2.5-ioc4/drivers/serial/ioc4_serial.c
===================================================================
--- linux-2.5-ioc4.orig/drivers/serial/ioc4_serial.c	2005-03-24 13:54:30.657706924 -0600
+++ linux-2.5-ioc4/drivers/serial/ioc4_serial.c	2005-03-24 13:56:48.230417236 -0600
@@ -1765,8 +1765,11 @@
 		the_port->ignore_status_mask &= ~N_DATA_READY;
 	}
 
-	if (cflag & CRTSCTS)
+	if (cflag & CRTSCTS) {
 		info->flags |= ASYNC_CTS_FLOW;
+		port->ip_sscr |= IOC4_SSCR_HFC_EN;
+		writel(port->ip_sscr, &port->ip_serial_regs->sscr);
+	}
 	else
 		info->flags &= ~ASYNC_CTS_FLOW;
 
@@ -1825,12 +1828,6 @@
 	/* set the speed of the serial port */
 	ioc4_change_speed(the_port, info->tty->termios, (struct termios *)0);
 
-	/* enable hardware flow control - after ioc4_change_speed because
-	 * ASYNC_CTS_FLOW is set there */
-	if (info->flags & ASYNC_CTS_FLOW) {
-		port->ip_sscr |= IOC4_SSCR_HFC_EN;
-		writel(port->ip_sscr, &port->ip_serial_regs->sscr);
-	}
 	info->flags |= UIF_INITIALIZED;
 	return 0;
 }

-- 

