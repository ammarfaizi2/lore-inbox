Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266362AbUGPFRz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266362AbUGPFRz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 01:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266389AbUGPFQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 01:16:10 -0400
Received: from mail.tpgi.com.au ([203.12.160.103]:40406 "EHLO mail.tpgi.com.au")
	by vger.kernel.org with ESMTP id S266450AbUGPFEK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 01:04:10 -0400
Subject: PATCH: Fix ftdi_sio oops in 2.4 (applicable to 2.6 too?)
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: BRyder@users.sourceforge.net
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1089953837.3486.72.camel@nigel-laptop.wpcb.org.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 16 Jul 2004 14:57:18 +1000
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I used to get an oopses when disconnecting my serial console, which runs
via the ftdi_sio driver. The cause turned out to be that the
ASYNC_LOW_LATENCY flag being set causes the driver to schedule while in
an interrupt handler (because it tries to take a spinlock). This little
patch against 2.4.26 removes the setting of the LOW_LATENCY flag and
thus the oops. There may well be a better solution, but I send this for
your consideration (please excuse the source tree names).

Regards,

Nigel

diff -ruN software-suspend-core-2.0.0.99/drivers/usb/serial/ftdi_sio.c software-suspend-core-2.0.0.99A/drivers/usb/serial/ftdi_sio.c
--- software-suspend-core-2.0.0.99/drivers/usb/serial/ftdi_sio.c	2004-04-16 23:46:16.000000000 +1000
+++ software-suspend-core-2.0.0.99A/drivers/usb/serial/ftdi_sio.c	2004-07-11 15:25:12.000000000 +1000
@@ -1038,7 +1038,7 @@
         init_waitqueue_head(&priv->delta_msr_wait);
 	/* This will push the characters through immediately rather
 	   than queue a task to deliver them */
-	priv->flags = ASYNC_LOW_LATENCY;
+	//priv->flags = ASYNC_LOW_LATENCY;
 
 	/* Increase the size of read buffers */
 	if (port->bulk_in_buffer) {


