Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289467AbSAOKEt>; Tue, 15 Jan 2002 05:04:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289481AbSAOKEk>; Tue, 15 Jan 2002 05:04:40 -0500
Received: from mgw-x1.nokia.com ([131.228.20.21]:59881 "EHLO mgw-x1.nokia.com")
	by vger.kernel.org with ESMTP id <S289467AbSAOKE2>;
	Tue, 15 Jan 2002 05:04:28 -0500
Message-ID: <3C43FD9D.8050706@nokia.com>
Date: Tue, 15 Jan 2002 11:59:57 +0200
From: Dmitri Kassatkine <dmitri.kassatkine@nokia.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011023
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org,
        Dmitri Kassatkine <dmitri.kassatkine@nokia.com>
Subject: usb.c patch -> successfuly read usb descriptors on some USB device
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sometimes USB subsystem cannot get USB descriptor.

Jan 15 10:44:21 selma kernel: hub.c: USB new device connect on bus1/1, 
assign
ed device number 25
Jan 15 10:44:21 selma kernel: usb.c: couldn't get all of config descriptors
Jan 15 10:44:21 selma kernel: usb.c: unable to get device 25 
configuration (e
rror=-110)


Here is patch how to fix it for 2.4.17. It works for 2.4.16 as well.
 It necassary to read descriptor at once, not first 8 byte first.

It works well now for NSM USB Bluetooth dongle.

br, Dmitri


----------------------------- CUT HERE ---------------------------------------------------------
--- usb.c.orig	Wed Nov 21 19:59:11 2001
+++ usb.c	Tue Jan 15 11:38:35 2002
@@ -2041,7 +2041,7 @@
 		return -ENOMEM;
 	}
 
-	buffer = kmalloc(8, GFP_KERNEL);
+	buffer = kmalloc(255, GFP_KERNEL);
 	if (!buffer) {
 		err("unable to allocate memory for configuration descriptors");
 		return -ENOMEM;
@@ -2049,9 +2049,9 @@
 	desc = (struct usb_config_descriptor *)buffer;
 
 	for (cfgno = 0; cfgno < dev->descriptor.bNumConfigurations; cfgno++) {
-		/* We grab the first 8 bytes so we know how long the whole */
+		/* We grab the first 255 bytes so we know how long the whole */
 		/*  configuration is */
-		result = usb_get_descriptor(dev, USB_DT_CONFIG, cfgno, buffer, 8);
+		result = usb_get_descriptor(dev, USB_DT_CONFIG, cfgno, buffer, 255);
 		if (result < 8) {
 			if (result < 0)
 				err("unable to get descriptor");
@@ -2072,19 +2072,24 @@
 			goto err;
 		}
 
-		/* Now that we know the length, get the whole thing */
-		result = usb_get_descriptor(dev, USB_DT_CONFIG, cfgno, bigbuffer, length);
-		if (result < 0) {
-			err("couldn't get all of config descriptors");
-			kfree(bigbuffer);
-			goto err;
-		}	
+		if (length > 255) {
+			/* Now that we know the length, get the whole thing */
+			result = usb_get_descriptor(dev, USB_DT_CONFIG, cfgno, bigbuffer, length);
+			if (result < 0) {
+				err("couldn't get all of config descriptors");
+				kfree(bigbuffer);
+				goto err;
+			}	
 	
-		if (result < length) {
-			err("config descriptor too short (expected %i, got %i)", length, result);
-			result = -EINVAL;
-			kfree(bigbuffer);
-			goto err;
+			if (result < length) {
+				err("config descriptor too short (expected %i, got %i)", length, result);
+				result = -EINVAL;
+				kfree(bigbuffer);
+				goto err;
+			}
+		}
+		else {
+			memcpy(bigbuffer, buffer, length);
 		}
 
 		dev->rawdescriptors[cfgno] = bigbuffer;
-------------- CUT HERE ----------------------------------------------------------------------------

-- 
 Dmitri Kassatkine
 Nokia Research Center / Helsinki
 Mobile: +358 50 4836365
 E-Mail: dmitri.kassatkine@nokia.com



