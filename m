Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262019AbUDSUkK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 16:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262044AbUDSUkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 16:40:10 -0400
Received: from stat1.steeleye.com ([65.114.3.130]:47758 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262019AbUDSUkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 16:40:00 -0400
Subject: [PATCH] fix dev_printk to work even in the absence of am attached
	driver
From: James Bottomley <James.Bottomley@steeleye.com>
To: greg@kroah.com
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 19 Apr 2004 15:39:57 -0500
Message-Id: <1082407198.1804.35.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dev_printk makes an incredibly convenient hook to hang a logging
infrastructure.  For that reason, it would be very useful to make all
device driver logging go through it.

Unfortunately in SCSI we can't do this yet because we need to log
messages even when the device doesn't have a bound driver (either
because the user has chosen not to load it or because we're starting up
or shutting down).

The attached makes dev_printk work even in the absence of a bound driver
so we should now be able to use it at all points in the lifecycle of a
SCSI device.

James
Index: include/linux/device.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/linux/device.h,v
retrieving revision 1.9
diff -u -r1.9 device.h
--- a/include/linux/device.h	15 Apr 2004 18:05:25 -0000	1.9
+++ b/include/linux/device.h	19 Apr 2004 20:36:57 -0000
@@ -400,7 +400,7 @@
 
 /* debugging and troubleshooting/diagnostic helpers. */
 #define dev_printk(level, dev, format, arg...)	\
-	printk(level "%s %s: " format , (dev)->driver->name , (dev)->bus_id , ## arg)
+	printk(level "%s %s: " format , (dev)->driver ? (dev)->driver->name : "(unbound)", (dev)->bus_id , ## arg)
 
 #ifdef DEBUG
 #define dev_dbg(dev, format, arg...)		\



