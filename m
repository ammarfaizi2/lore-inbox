Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751620AbWJIJJS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751620AbWJIJJS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 05:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751662AbWJIJJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 05:09:18 -0400
Received: from yacht.ocn.ne.jp ([222.146.40.168]:58074 "EHLO
	smtp.yacht.ocn.ne.jp") by vger.kernel.org with ESMTP
	id S1751660AbWJIJJS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 05:09:18 -0400
Date: Mon, 9 Oct 2006 18:09:33 +0900
To: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH] usb devio: handle class_device_create() error
Message-ID: <20061009090933.GA6325@localhost>
Mail-Followup-To: akinobu.mita@gmail.com, linux-kernel@vger.kernel.org,
	linux-usb-devel@lists.sourceforge.net,
	Greg Kroah-Hartman <gregkh@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
From: akinobu.mita@gmail.com (Akinobu Mita)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds missing class_device_create() error check,
and makes notifier return NOTIFY_BAD.

Cc: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

 drivers/usb/core/devio.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

Index: work-fault-inject/drivers/usb/core/devio.c
===================================================================
--- work-fault-inject.orig/drivers/usb/core/devio.c	2006-10-09 15:06:27.000000000 +0900
+++ work-fault-inject/drivers/usb/core/devio.c	2006-10-09 15:09:23.000000000 +0900
@@ -1588,15 +1588,18 @@ const struct file_operations usbfs_devic
 	.release =	usbdev_release,
 };
 
-static void usbdev_add(struct usb_device *dev)
+static int usbdev_add(struct usb_device *dev)
 {
 	int minor = ((dev->bus->busnum-1) * 128) + (dev->devnum-1);
 
 	dev->class_dev = class_device_create(usb_device_class, NULL,
 				MKDEV(USB_DEVICE_MAJOR, minor), &dev->dev,
 				"usbdev%d.%d", dev->bus->busnum, dev->devnum);
+	if (IS_ERR(dev->class_dev))
+		return PTR_ERR(dev->class_dev);
 
 	dev->class_dev->class_data = dev;
+	return 0;
 }
 
 static void usbdev_remove(struct usb_device *dev)
@@ -1609,7 +1612,8 @@ static int usbdev_notify(struct notifier
 {
 	switch (action) {
 	case USB_DEVICE_ADD:
-		usbdev_add(dev);
+		if (usbdev_add(dev))
+			return NOTIFY_BAD;
 		break;
 	case USB_DEVICE_REMOVE:
 		usbdev_remove(dev);
