Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262914AbUD2CB5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262914AbUD2CB5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 22:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262850AbUD2CB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 22:01:57 -0400
Received: from 82-168-177-147-bbxl.xdsl.tiscali.nl ([82.168.177.147]:41857
	"EHLO behemoth.pad.mess.org") by vger.kernel.org with ESMTP
	id S262920AbUD2B74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 21:59:56 -0400
Date: Thu, 29 Apr 2004 03:59:51 +0200
From: Sean Young <sean@mess.org>
To: Greg KH <greg@kroah.com>
Cc: Chester <fitchett@phidgets.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: add new USB PhidgetServo driver
Message-ID: <20040429015951.GA4135@behemoth.pad.mess.org>
References: <20040428181806.GA36322@atlantis.8hz.com> <20040428184138.GA17275@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040428184138.GA17275@kroah.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2004 at 11:41:38AM -0700, Greg KH wrote:
> On Wed, Apr 28, 2004 at 08:18:06PM +0200, Sean Young wrote:
> > Here is a driver for the usb servo controllers from Phidgets 
> > <http://www.phidgets.com/>, using sysfs. 
> > 
> > Note that the devices claim to be hid devices, so I've added them to the 
> > hid_blacklist (HID_QUIRK_IGNORE). A servo controller isn't really an hid
> > device (or is it?).
> > 
> > diff against 2.6.6-rc2.
> 
> Nice, I like tiny clean drivers like this :)
> 
> I've applied it to my trees, and it will make it into the next -mm tree,
> and show up in the 2.6.7 release whenever it happens.

Great! Thanks.

Somehow I managed to send the wrong version. Here is a patch which fixes
that. (Remove a dev_info() which wasn't supposed to be there, and make sure 
that everything is still consistent in the unlikely event that kmalloc()
fails). Just minor cleanups.


Sean

diff -Nur linux-2.6.0/drivers/usb/misc/phidgetservo.c /usr/src/linux-2.6.0/drivers/usb/misc/phidgetservo.c
--- linux-2.6.0/drivers/usb/misc/phidgetservo.c	2004-04-29 02:35:19.000000000 +0200
+++ /usr/src/linux-2.6.0/drivers/usb/misc/phidgetservo.c	2004-04-29 02:35:09.000000000 +0200
@@ -67,6 +67,13 @@
 	int retval;
 	unsigned char *buffer;
 
+	buffer = kmalloc(6, GFP_KERNEL);
+	if (!buffer) {
+		dev_err(&servo->udev->dev, "%s - out of memory\n",
+			__FUNCTION__);
+		return;
+	}
+
 	/*
 	 * pulse = 0 - 4095
 	 * angle = 0 - 180 degrees
@@ -77,13 +84,6 @@
 	servo->degrees[servo_no]= degrees;
 	servo->minutes[servo_no]= minutes;	
 
-	buffer = kmalloc(6, GFP_KERNEL);
-	if (!buffer) {
-		dev_err(&servo->udev->dev, "%s - out of memory\n",
-			__FUNCTION__);
-		return;
-	}
-
 	/* 
 	 * The PhidgetServo v3.0 is controlled by sending 6 bytes,
 	 * 4 * 12 bits for each servo.
@@ -136,6 +136,13 @@
 	int retval;
 	unsigned char *buffer;
 
+	buffer = kmalloc(2, GFP_KERNEL);
+	if (!buffer) {
+		dev_err(&servo->udev->dev, "%s - out of memory\n",
+			__FUNCTION__);
+		return;
+	}
+
 	/*
 	 * angle = 0 - 180 degrees
 	 * pulse = angle + 23
@@ -144,13 +151,6 @@
 	servo->degrees[servo_no]= degrees;
 	servo->minutes[servo_no]= 0;
 
-	buffer = kmalloc(2, GFP_KERNEL);
-	if (!buffer) {
-		dev_err(&servo->udev->dev, "%s - out of memory\n",
-			__FUNCTION__);
-		return;
-	}
-
 	/*
 	 * The PhidgetServo v2.0 is controlled by sending two bytes. The
 	 * first byte is the servo number xor'ed with 2:
@@ -291,9 +291,6 @@
 
 	dev_info(&interface->dev, "USB %d-Motor PhidgetServo v%d.0 detached\n",
 		 dev->quad_servo ? 4 : 1, dev->version);
-
-	dev_info(&interface->dev,
-		 "WARNING: version 2.0 not tested. Please report if this works.\n");
 }
 
 static struct usb_driver servo_driver = {
