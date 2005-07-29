Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262764AbVG3CKs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262764AbVG3CKs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 22:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262802AbVG3CIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 22:08:42 -0400
Received: from mail.kroah.org ([69.55.234.183]:39855 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262764AbVG2TRu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 15:17:50 -0400
Date: Fri, 29 Jul 2005 12:17:20 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, mhund@ld-didactic.de
Subject: [patch 23/29] USB: ldusb fixes
Message-ID: <20050729191720.GY5095@kroah.com>
References: <20050729184950.014589000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="usb-ldusb-fixes.patch"
In-Reply-To: <20050729191255.GA5095@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Hund <mhund@ld-didactic.de>

below you will find the forgotten kmalloc check (sorry).

Signed-off-by: Michael Hund <mhund@ld-didactic.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/usb/misc/ldusb.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletion(-)

--- gregkh-2.6.orig/drivers/usb/misc/ldusb.c	2005-07-29 11:29:48.000000000 -0700
+++ gregkh-2.6/drivers/usb/misc/ldusb.c	2005-07-29 11:36:30.000000000 -0700
@@ -23,6 +23,7 @@
  *
  * V0.1  (mh) Initial version
  * V0.11 (mh) Added raw support for HID 1.0 devices (no interrupt out endpoint)
+ * V0.12 (mh) Added kmalloc check for string buffer
  */
 
 #include <linux/config.h>
@@ -84,7 +85,7 @@
 	{ }					/* Terminating entry */
 };
 MODULE_DEVICE_TABLE(usb, ld_usb_table);
-MODULE_VERSION("V0.11");
+MODULE_VERSION("V0.12");
 MODULE_AUTHOR("Michael Hund <mhund@ld-didactic.de>");
 MODULE_DESCRIPTION("LD USB Driver");
 MODULE_LICENSE("GPL");
@@ -635,6 +636,10 @@
 	     (le16_to_cpu(udev->descriptor.idProduct) == USB_DEVICE_ID_COM3LAB)) &&
 	    (le16_to_cpu(udev->descriptor.bcdDevice) <= 0x103)) {
 		buffer = kmalloc(256, GFP_KERNEL);
+		if (buffer == NULL) {
+			dev_err(&intf->dev, "Couldn't allocate string buffer\n");
+			goto error;
+		}
 		/* usb_string makes SETUP+STALL to leave always ControlReadLoop */
 		usb_string(udev, 255, buffer, 256);
 		kfree(buffer);

--
