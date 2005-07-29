Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262844AbVG3Auh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262844AbVG3Auh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 20:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262757AbVG2TSx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 15:18:53 -0400
Received: from mail.kroah.org ([69.55.234.183]:28079 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262761AbVG2TRU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 15:17:20 -0400
Date: Fri, 29 Jul 2005 12:16:58 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, stern@rowland.harvard.edu
Subject: [patch 20/29] USB: usbfs: Don't leak uninitialized data
Message-ID: <20050729191658.GV5095@kroah.com>
References: <20050729184950.014589000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="usb-usbfs-dont-leak-data.patch"
In-Reply-To: <20050729191255.GA5095@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Stern <stern@rowland.harvard.edu>

This patch fixes an information leak in the usbfs snoop facility:
uninitialized data from __get_free_page can be returned to userspace and
written to the system log.  It also improves the snoop output by printing
the wLength value.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/usb/core/devio.c |   18 ++++++++++++------
 1 files changed, 12 insertions(+), 6 deletions(-)

--- gregkh-2.6.orig/drivers/usb/core/devio.c	2005-07-29 11:29:48.000000000 -0700
+++ gregkh-2.6/drivers/usb/core/devio.c	2005-07-29 11:36:28.000000000 -0700
@@ -569,8 +569,11 @@
 			free_page((unsigned long)tbuf);
 			return -EINVAL;
 		}
-		snoop(&dev->dev, "control read: bRequest=%02x bRrequestType=%02x wValue=%04x wIndex=%04x\n", 
-			ctrl.bRequest, ctrl.bRequestType, ctrl.wValue, ctrl.wIndex);
+		snoop(&dev->dev, "control read: bRequest=%02x "
+				"bRrequestType=%02x wValue=%04x "
+				"wIndex=%04x wLength=%04x\n",
+			ctrl.bRequest, ctrl.bRequestType, ctrl.wValue,
+				ctrl.wIndex, ctrl.wLength);
 
 		usb_unlock_device(dev);
 		i = usb_control_msg(dev, usb_rcvctrlpipe(dev, 0), ctrl.bRequest, ctrl.bRequestType,
@@ -579,11 +582,11 @@
 		if ((i > 0) && ctrl.wLength) {
 			if (usbfs_snoop) {
 				dev_info(&dev->dev, "control read: data ");
-				for (j = 0; j < ctrl.wLength; ++j)
+				for (j = 0; j < i; ++j)
 					printk ("%02x ", (unsigned char)(tbuf)[j]);
 				printk("\n");
 			}
-			if (copy_to_user(ctrl.data, tbuf, ctrl.wLength)) {
+			if (copy_to_user(ctrl.data, tbuf, i)) {
 				free_page((unsigned long)tbuf);
 				return -EFAULT;
 			}
@@ -595,8 +598,11 @@
 				return -EFAULT;
 			}
 		}
-		snoop(&dev->dev, "control write: bRequest=%02x bRrequestType=%02x wValue=%04x wIndex=%04x\n", 
-			ctrl.bRequest, ctrl.bRequestType, ctrl.wValue, ctrl.wIndex);
+		snoop(&dev->dev, "control write: bRequest=%02x "
+				"bRrequestType=%02x wValue=%04x "
+				"wIndex=%04x wLength=%04x\n",
+			ctrl.bRequest, ctrl.bRequestType, ctrl.wValue,
+				ctrl.wIndex, ctrl.wLength);
 		if (usbfs_snoop) {
 			dev_info(&dev->dev, "control write: data: ");
 			for (j = 0; j < ctrl.wLength; ++j)

--
