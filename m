Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261661AbUDCIms (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 03:42:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261648AbUDCIms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 03:42:48 -0500
Received: from outmx001.isp.belgacom.be ([195.238.3.51]:40879 "EHLO
	outmx001.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S261654AbUDCIlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 03:41:31 -0500
Subject: [PATCH 2.6.5rc2-mm2] Root_plug device check
From: Fabian Frederick <Fabian.Frederick@skynet.be>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-6bsWaiCrOBdij2Wgw946"
Message-Id: <1080981753.4309.26.camel@linux.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Sat, 03 Apr 2004 10:42:33 +0200
X-RAVMilter-Version: 8.4.3(snapshot 20030212) (outmx001.isp.belgacom.be)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-6bsWaiCrOBdij2Wgw946
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

      Here's a patch to check device in root_plug to avoid box freeze
when user gives bad ids.

Regards,
Fabian

--=-6bsWaiCrOBdij2Wgw946
Content-Disposition: attachment; filename=root_plug1.diff
Content-Type: text/x-patch; name=root_plug1.diff; charset=
Content-Transfer-Encoding: 7bit

diff -Naur orig/security/root_plug.c edited/security/root_plug.c
--- orig/security/root_plug.c	2004-03-25 23:54:19.000000000 +0100
+++ edited/security/root_plug.c	2004-03-26 23:39:26.000000000 +0100
@@ -20,6 +20,9 @@
  *	modify it under the terms of the GNU General Public License as
  *	published by the Free Software Foundation, version 2 of the
  *	License.
+ *
+ * 03/2004 : (Fabian Frederick) 
+ *		-Make sure we have device if defined through module call
  */
 
 #include <linux/config.h>
@@ -33,8 +36,11 @@
 static int secondary;
 
 /* default is a generic type of usb to serial converter */
-static int vendor_id = 0x0557;
-static int product_id = 0x2008;
+#define DEFAULT_VENDOR 0x0557
+#define DEFAULT_PRODUCT 0x2008
+
+static int vendor_id = DEFAULT_VENDOR;
+static int product_id = DEFAULT_PRODUCT;
 
 MODULE_PARM(vendor_id, "h");
 MODULE_PARM_DESC(vendor_id, "USB Vendor ID of device to look for");
@@ -101,6 +107,17 @@
 
 static int __init rootplug_init (void)
 {
+	struct usb_device *dev;
+
+	/* check we have device featuring in usb list to avoid any trouble*/
+	if((vendor_id!=DEFAULT_VENDOR) || (product_id!=DEFAULT_PRODUCT)){
+		dev = usb_find_device(vendor_id, product_id);
+		if (!dev) {
+			printk (KERN_INFO "Unable to find USB device "
+				" We won't start to avoid box freeze.\n");
+			return -EINVAL;
+		}
+	}
 	/* register ourselves with the security framework */
 	if (register_security (&rootplug_security_ops)) {
 		printk (KERN_INFO 

--=-6bsWaiCrOBdij2Wgw946--

