Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267595AbUI1Go7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267595AbUI1Go7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 02:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267598AbUI1Go6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 02:44:58 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:10125 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S267595AbUI1God (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 02:44:33 -0400
Date: Mon, 27 Sep 2004 23:43:33 -0700
From: Paul Jackson <pj@sgi.com>
To: Roland Dreier <roland@topspin.com>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][1/2] [RESEND] kobject: add HOTPLUG_ENV_VAR
Message-Id: <20040927234333.7cceff47.pj@sgi.com>
In-Reply-To: <52fz53e526.fsf@topspin.com>
References: <1096302710971@topspin.com>
	<10963027102899@topspin.com>
	<20040927131014.695b8212.pj@sgi.com>
	<52fz53e526.fsf@topspin.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland wrote:
> The problem is that the straightforward way to implement this helper
> modifies three of its parameters (the current buffer location, the
> amount of space left, and the current index). 

You could reduce the number of modified parameters from three to two?

I find snprintf usage schemes that move the buffer location to be
confusing -- tend to lead to subtly wrong code ;).  Better to keep
the invariants for each variable you use as simple as you can, and
the number of variables as few as you can.  Keeping a variable constant
is one nice way to simplify its invariants ;).

For example, leave buffer unmoved, and only change one variable on each
snprintf - the count of how many chars would have been written, given
infinite space.

I've had good luck of late with the following way of calling snprintf
(example taken from kernel/cpuset.c):

	cnt += snprintf(buf + cnt, max(sz - cnt, 0), "%d\n", a[i]);

If you have a series of multiple snprintf's, you can even leave off
checking that cnt goes past buf+sz on each snprintf call, and just once,
after the last snprintf, look for the -ENOMEM error case if cnt > sz.

Just don't call snprintf with a negative length - rather than doing what
I would prefer, which is writing nothing successfully, instead it
WARN_ON()'s one time of an out-of-range value: "Badness in func at
file:line"  This is the reason for the max(), in the above example.

You could even do the same sort of logic with the "envp[i++] = buffer"
lines, changing them to:

	if (i < num_envp)
		envp[i++] = buffer;

Then all just once, at the end:

	if (i == num_envp || length >= buffer_size)
		return -ENOMEM;

This removes several return's in the middle of the procedure.

In other words, perhaps instead of encapsulating the ugliness in a macro
so as to avoid repeating it, try reducing it?

Something like the following, never before seen by a compiler, patch to
2.6.9-rc2-mm4:

diff -Naurp 2.6.9-rc2-mm4.orig/drivers/usb/core/usb.c 2.6.9-rc2-mm4/drivers/usb/core/usb.c
--- 2.6.9-rc2-mm4.orig/drivers/usb/core/usb.c	2004-09-27 22:59:01.382907032 -0700
+++ 2.6.9-rc2-mm4/drivers/usb/core/usb.c	2004-09-27 23:40:03.968537112 -0700
@@ -582,7 +582,6 @@ static int usb_hotplug (struct device *d
 {
 	struct usb_interface *intf;
 	struct usb_device *usb_dev;
-	char *scratch;
 	int i = 0;
 	int length = 0;
 
@@ -609,8 +608,6 @@ static int usb_hotplug (struct device *d
 		return -ENODEV;
 	}
 
-	scratch = buffer;
-
 #ifdef	CONFIG_USB_DEVICEFS
 	/* If this is available, userspace programs can directly read
 	 * all the device descriptors we don't tell them about.  Or
@@ -618,37 +615,30 @@ static int usb_hotplug (struct device *d
 	 *
 	 * FIXME reduce hardwired intelligence here
 	 */
-	envp [i++] = scratch;
-	length += snprintf (scratch, buffer_size - length,
+	if (i < num_envp)
+		envp [i++] = buffer + length;
+	length += snprintf (buffer + length, max(buffer_size - length, 0),
 			    "DEVICE=/proc/bus/usb/%03d/%03d",
 			    usb_dev->bus->busnum, usb_dev->devnum);
-	if ((buffer_size - length <= 0) || (i >= num_envp))
-		return -ENOMEM;
-	++length;
-	scratch += length;
 #endif
 
 	/* per-device configurations are common */
-	envp [i++] = scratch;
-	length += snprintf (scratch, buffer_size - length, "PRODUCT=%x/%x/%x",
+	if (i < num_envp)
+		envp [i++] = buffer + length;
+	length += snprintf (buffer + length, max(buffer_size - length, 0),
+			    "PRODUCT=%x/%x/%x",
 			    usb_dev->descriptor.idVendor,
 			    usb_dev->descriptor.idProduct,
 			    usb_dev->descriptor.bcdDevice);
-	if ((buffer_size - length <= 0) || (i >= num_envp))
-		return -ENOMEM;
-	++length;
-	scratch += length;
 
 	/* class-based driver binding models */
-	envp [i++] = scratch;
-	length += snprintf (scratch, buffer_size - length, "TYPE=%d/%d/%d",
+	if (i < num_envp)
+		envp [i++] = buffer + length;
+	length += snprintf (buffer + length, max(buffer_size - length, 0),
+			    "TYPE=%d/%d/%d",
 			    usb_dev->descriptor.bDeviceClass,
 			    usb_dev->descriptor.bDeviceSubClass,
 			    usb_dev->descriptor.bDeviceProtocol);
-	if ((buffer_size - length <= 0) || (i >= num_envp))
-		return -ENOMEM;
-	++length;
-	scratch += length;
 
 	if (usb_dev->descriptor.bDeviceClass == 0) {
 		struct usb_host_interface *alt = intf->cur_altsetting;
@@ -657,19 +647,19 @@ static int usb_hotplug (struct device *d
 		 * agents are called for all interfaces, and can use
 		 * $DEVPATH/bInterfaceNumber if necessary.
 		 */
-		envp [i++] = scratch;
-		length += snprintf (scratch, buffer_size - length,
+	 	if (i < num_envp)
+			envp [i++] = buffer + length;
+		length += snprintf (buffer + length,
+			    max(buffer_size - length, 0),
 			    "INTERFACE=%d/%d/%d",
 			    alt->desc.bInterfaceClass,
 			    alt->desc.bInterfaceSubClass,
 			    alt->desc.bInterfaceProtocol);
-		if ((buffer_size - length <= 0) || (i >= num_envp))
-			return -ENOMEM;
-		++length;
-		scratch += length;
-
 	}
-	envp[i++] = NULL;
+	if (i < num_envp)
+		envp[i++] = NULL;
+	if (i == num_envp || length >= buffer_size)
+		return -ENOMEM;
 
 	return 0;
 }


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
