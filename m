Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310457AbSCGT2w>; Thu, 7 Mar 2002 14:28:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310474AbSCGT2n>; Thu, 7 Mar 2002 14:28:43 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:11537 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S310457AbSCGT23>;
	Thu, 7 Mar 2002 14:28:29 -0500
Date: Thu, 7 Mar 2002 11:20:26 -0800
From: Greg KH <greg@kroah.com>
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] ir-usb.c fix for 2.5.6-pre3
Message-ID: <20020307192026.GA22121@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Thu, 07 Feb 2002 17:17:47 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As the irda header files seem to be messed up in 2.5.6-pre3 I've decided
to remove the dependency on them from the ir-usb.c driver.  So here's a
patch against 2.5.6-pre3 that enables the ir-usb.c code to build and
work properly.

thanks,

greg k-h


diff -Nru a/drivers/usb/serial/ir-usb.c b/drivers/usb/serial/ir-usb.c
--- a/drivers/usb/serial/ir-usb.c	Thu Mar  7 11:21:25 2002
+++ b/drivers/usb/serial/ir-usb.c	Thu Mar  7 11:21:25 2002
@@ -1,8 +1,8 @@
 /*
  * USB IR Dongle driver
  *
- *	Copyright (C) 2001 Greg Kroah-Hartman (greg@kroah.com)
- *	Copyright (C) 2002 Gary Brubaker (xavyer@ix.netcom.com)
+ *	Copyright (C) 2001-2002	Greg Kroah-Hartman (greg@kroah.com)
+ *	Copyright (C) 2002	Gary Brubaker (xavyer@ix.netcom.com)
  *
  *	This program is free software; you can redistribute it and/or modify
  *	it under the terms of the GNU General Public License as published by
@@ -21,6 +21,11 @@
  *
  * See Documentation/usb/usb-serial.txt for more information on using this driver
  *
+ * 2002_Mar_07	greg kh
+ *	moved some needed structures and #define values from the
+ *	net/irda/irda-usb.h file into our file, as we don't want to depend on
+ *	that codebase compiling correctly :)
+ *
  * 2002_Jan_14  gb
  *	Added module parameter to force specific number of XBOFs.
  *	Added ir_xbof_change().
@@ -56,7 +61,6 @@
 #include <linux/module.h>
 #include <linux/spinlock.h>
 #include <linux/usb.h>
-#include <net/irda/irda-usb.h>
 
 #ifdef CONFIG_USB_SERIAL_DEBUG
 	static int debug = 1;
@@ -73,6 +77,33 @@
 #define DRIVER_AUTHOR "Greg Kroah-Hartman <greg@kroah.com>"
 #define DRIVER_DESC "USB IR Dongle driver"
 
+/* USB IrDA class spec information */
+#define USB_CLASS_IRDA		0x02
+#define USB_DT_IRDA		0x21
+#define IU_REQ_GET_CLASS_DESC	0x06
+#define SPEED_2400		0x01
+#define SPEED_9600		0x02
+#define SPEED_19200		0x03
+#define SPEED_38400		0x04
+#define SPEED_57600		0x05
+#define SPEED_115200		0x06
+#define SPEED_576000		0x07
+#define SPEED_1152000		0x08
+#define SPEED_4000000		0x09
+
+struct irda_class_desc {
+	u8	bLength;
+	u8	bDescriptorType;
+	u16	bcdSpecRevision;
+	u8	bmDataSize;
+	u8	bmWindowSize;
+	u8	bmMinTurnaroundTime;
+	u16	wBaudRate;
+	u8	bmAdditionalBOFs;
+	u8	bIrdaRateSniff;
+	u8	bMaxUnicastList;
+} __attribute__ ((packed));
+
 /* if overridden by the user, then use their value for the size of the read and
  * write urbs */
 static int buffer_size = 0;
@@ -158,7 +189,7 @@
 	ret = usb_control_msg(dev, usb_rcvctrlpipe(dev,0),
 			IU_REQ_GET_CLASS_DESC,
 			USB_DIR_IN | USB_TYPE_CLASS | USB_RECIP_INTERFACE,
-			0, ifnum, desc, sizeof(*desc), MSECS_TO_JIFFIES(500));
+			0, ifnum, desc, sizeof(*desc), HZ);
 	
 	dbg("%s -  ret=%d", __FUNCTION__, ret);
 	if (ret < sizeof(*desc)) {
