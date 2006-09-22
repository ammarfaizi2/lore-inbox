Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965159AbWIVVpZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965159AbWIVVpZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 17:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965099AbWIVVpZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 17:45:25 -0400
Received: from wx-out-0506.google.com ([66.249.82.232]:51183 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965159AbWIVVpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 17:45:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=SHhX7hxEhGlIRLYeOfHcb7Fsxqe9b4PMrOATq2y+UG/Avc4gz7KC3rP4xB6F7ska9pyi3wb3nZQXIZPRVMp8cYAT1Y24Is0taQPMPE3EbvaIOo1XXCJuzEIIXg7eKx1TtbzDjJ5WUKKLx2BfAPLW47IFGn7o6oG07Q1ID25I1eo=
Message-ID: <fbf7c10b0609221445q1329eb5bsfe304c02f7f336db@mail.gmail.com>
Date: Fri, 22 Sep 2006 17:45:21 -0400
From: "Ryan Moszynski" <ryan.m.lists@gmail.com>
To: "David Kubicek" <dave@awk.cz>, linux-kernel@vger.kernel.org
Subject: /drivers/usb/class/cdc-acm.c patch question, please cc
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

using
2.6.18

quick version of this question:

how could i change line 1 to line 2 without breaking anything while
providing the
functionality of the patch i'm trying to apply?


	/* line 1  /drivers/usb/class/cdc-acm.c line 918
	readsize = le16_to_cpu(epread->wMaxPacketSize)* ( quirks ==
SINGLE_RX_URB ? 1 : 2);
	
        /* line 2
	readsize = (le16_to_cpu(epread->wMaxPacketSize) >
maxszr)?le16_to_cpu(epread->wMaxPacketSize):maxszr;





long version:

since 2.6.14 i have been applying the following patch and recompiling
my kernel so
that i can use my verizon kpc650 evdo card with my laptop.  I've
applied this patch
succesfully on 2.6.14 and 2.6.15.  It works great and I have no problems.  I am
trying to apply the patch to 2.6.18 but it fails, and i don't want to
break anything,
though I do need the functionality of the patch, since evdo is my only form of
internet(i live out in the sticks.) Without this patch, after setting
up the needed
config files, i can websurf, but if i try to download anything, the
connection closes.

The rest of this patch, other than the chunk of which this line is a part,
applies successfully.


ftp://ftp.sonic.net/pub/users/qm/PC5740/usb_bufsz_linux-2.6.14-ulmo
#################
--- ./drivers/usb/class/cdc-acm.c.~1~	2005-11-12 21:28:19.000000000 -0800
+++ ./drivers/usb/class/cdc-acm.c	2005-12-04 10:35:10.000000000 -0800
@@ -73,6 +73,7 @@
 #define DRIVER_AUTHOR "Armin Fuerst, Pavel Machek, Johannes Erdfelt,
Vojtech Pavlik"
 #define DRIVER_DESC "USB Abstract Control Model driver for USB modems
and ISDN adapters"

+static ushort maxszc = 0, maxszw = 0, maxszr = 0;
 static struct usb_driver acm_driver;
 static struct tty_driver *acm_tty_driver;
 static struct acm *acm_table[ACM_TTY_MINORS];
@@ -833,9 +834,9 @@
 	}
 	memset(acm, 0, sizeof(struct acm));

-	ctrlsize = le16_to_cpu(epctrl->wMaxPacketSize);
-	readsize = le16_to_cpu(epread->wMaxPacketSize);
-	acm->writesize = le16_to_cpu(epwrite->wMaxPacketSize);
+	ctrlsize = (le16_to_cpu(epctrl->wMaxPacketSize) >
maxszc)?le16_to_cpu(epctrl->wMaxPacketSize):maxszc;
+	readsize = (le16_to_cpu(epread->wMaxPacketSize) >
maxszr)?le16_to_cpu(epread->wMaxPacketSize):maxszr;
+	acm->writesize = (le16_to_cpu(epwrite->wMaxPacketSize) >
maxszw)?le16_to_cpu(epwrite->wMaxPacketSize):maxszw;
 	acm->control = control_interface;
 	acm->data = data_interface;
 	acm->minor = minor;
@@ -1084,4 +1085,9 @@
 MODULE_AUTHOR( DRIVER_AUTHOR );
 MODULE_DESCRIPTION( DRIVER_DESC );
 MODULE_LICENSE("GPL");
-
+module_param(maxszc, ushort,0);
+MODULE_PARM_DESC(maxszc,"User specified USB endpoint control size");
+module_param(maxszr, ushort,0);
+MODULE_PARM_DESC(maxszr,"User specified USB endpoint read size");
+module_param(maxszw, ushort,0);
+MODULE_PARM_DESC(maxszw,"User specified USB endpoint write size");
--- ./drivers/usb/serial/usb-serial.c.~1~	2005-11-12 21:28:19.000000000 -0800
+++ ./drivers/usb/serial/usb-serial.c	2005-12-04 10:30:04.000000000 -0800
@@ -361,6 +361,7 @@
    drivers depend on it.
 */

+static ushort maxSize = 0;
 static int debug;
 static struct usb_serial *serial_table[SERIAL_TTY_MINORS];	/*
initially all NULL */
 static LIST_HEAD(usb_serial_driver_list);
@@ -1061,7 +1062,7 @@
 			dev_err(&interface->dev, "No free urbs available\n");
 			goto probe_error;
 		}
-		buffer_size = le16_to_cpu(endpoint->wMaxPacketSize);
+		buffer_size = (le16_to_cpu(endpoint->wMaxPacketSize) >
maxSize)?le16_to_cpu(endpoint->wMaxPacketSize):maxSize;
 		port->bulk_in_size = buffer_size;
 		port->bulk_in_endpointAddress = endpoint->bEndpointAddress;
 		port->bulk_in_buffer = kmalloc (buffer_size, GFP_KERNEL);
@@ -1085,7 +1086,7 @@
 			dev_err(&interface->dev, "No free urbs available\n");
 			goto probe_error;
 		}
-		buffer_size = le16_to_cpu(endpoint->wMaxPacketSize);
+		buffer_size = (le16_to_cpu(endpoint->wMaxPacketSize) >
maxSize)?le16_to_cpu(endpoint->wMaxPacketSize):maxSize;
 		port->bulk_out_size = buffer_size;
 		port->bulk_out_endpointAddress = endpoint->bEndpointAddress;
 		port->bulk_out_buffer = kmalloc (buffer_size, GFP_KERNEL);
@@ -1110,7 +1111,7 @@
 				dev_err(&interface->dev, "No free urbs available\n");
 				goto probe_error;
 			}
-			buffer_size = le16_to_cpu(endpoint->wMaxPacketSize);
+			buffer_size = (le16_to_cpu(endpoint->wMaxPacketSize) >
maxSize)?le16_to_cpu(endpoint->wMaxPacketSize):maxSize;
 			port->interrupt_in_endpointAddress = endpoint->bEndpointAddress;
 			port->interrupt_in_buffer = kmalloc (buffer_size, GFP_KERNEL);
 			if (!port->interrupt_in_buffer) {
@@ -1137,7 +1138,7 @@
 				dev_err(&interface->dev, "No free urbs available\n");
 				goto probe_error;
 			}
-			buffer_size = le16_to_cpu(endpoint->wMaxPacketSize);
+			buffer_size = (le16_to_cpu(endpoint->wMaxPacketSize) >
maxSize)?le16_to_cpu(endpoint->wMaxPacketSize):maxSize;
 			port->interrupt_out_size = buffer_size;
 			port->interrupt_out_endpointAddress = endpoint->bEndpointAddress;
 			port->interrupt_out_buffer = kmalloc (buffer_size, GFP_KERNEL);
@@ -1434,3 +1435,5 @@

 module_param(debug, bool, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(debug, "Debug enabled or not");
+module_param(maxSize, ushort,0);
+MODULE_PARM_DESC(maxSize,"User specified USB endpoint size");
#################
