Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262189AbUK0EAn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262189AbUK0EAn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 23:00:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262187AbUK0EAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 23:00:18 -0500
Received: from beseeingyou.bytemark.co.uk ([212.13.210.26]:41965 "HELO
	beseeingyou.bytemark.co.uk") by vger.kernel.org with SMTP
	id S262299AbUKZTaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:30:09 -0500
From: Fred Emmott <mail@fredemmott.co.uk>
To: linux-kernel@vger.kernel.org
Subject: [patch] root_plug improvement
Date: Thu, 25 Nov 2004 18:19:04 +0000
User-Agent: KMail/1.7.50
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411251819.04700.mail@fredemmott.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the root_plug LSM module also check the serial number of the 
USB device. Without this, it's possible to use another USB device of the same 
brand + model as a root_plug device.

I am not familiar with the module interface, and have not added a paramater 
for specifying the serial_number, so it must be specified at compile time.

Sorry if this is the wrong place to send this.

--- root_plug.c.orig 2004-11-25 18:05:30.000000000 +0000
+++ root_plug.c 2004-11-25 18:06:45.000000000 +0000
@@ -35,6 +36,7 @@
 /* default is a generic type of usb to serial converter */
 static int vendor_id = 0x0557;
 static int product_id = 0x2008;
+char *serial_number = "ENTER_ID_HERE";
 
 module_param(vendor_id, uint, 0400);
 MODULE_PARM_DESC(vendor_id, "USB Vendor ID of device to look for");
@@ -65,7 +67,9 @@
 static int rootplug_bprm_check_security (struct linux_binprm *bprm)
 {
  struct usb_device *dev;
-
+ char* buf;
+ buf = kmalloc(128, GFP_KERNEL);
+ 
  root_dbg("file %s, e_uid = %d, e_gid = %d\n",
    bprm->filename, bprm->e_uid, bprm->e_gid);
 
@@ -76,6 +80,15 @@
      "task not allowed to run...\n");
    return -EPERM;
   }
+  else {
+   usb_string(dev, dev->descriptor.iSerialNumber, buf, 128);
+   if (strcmp(buf, serial_number) != 0)
+   {
+    root_dbg("e_gid = 0, and device found, "
+     "but bad serial number...\n");
+    return -EPERM;
+   }
+  }
   usb_put_dev(dev);
  }

-- 
Fred Emmott
(http://www.fredemmott.co.uk)
