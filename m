Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261178AbULRPXy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbULRPXy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 10:23:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261180AbULRPXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 10:23:54 -0500
Received: from rproxy.gmail.com ([64.233.170.194]:1050 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261178AbULRPXu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 10:23:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Fi4ZGD8fCnXE93HKQrjPjxRAJ8BNFq15BLuxfnHOKbWBwMQRttSGV6KeOuoFuh09XjYPo6ezIRk+ilkeXIEMREUaQGM2baWGAd+8qM+WLu+UD4JvdOwg2cg1OhhtDIT8Z7THxA0aBh9/vjJyAnxGNd59XMflXSz0QuO7eUkMFpE=
Message-ID: <41C46B4D.5040506@gmail.com>
Date: Sat, 18 Dec 2004 17:39:25 +0000
From: Mikkel Krautz <krautz@gmail.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: greg@kroah.com, vojtech@suse.cz
Subject: Re: [PATCH] hid-core: Configurable USB HID Mouse Interrupt Polling
 Interval
References: <1103335970.15567.15.camel@localhost> <20041218012725.GB25628@kroah.com>
In-Reply-To: <20041218012725.GB25628@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Dec 2004 18:59:48 -0800, Greg KH <greg@kroah.com> wrote:
 > What about makeing it a module paramater then, that is exported to
 > sysfs?  That makes it easier to adjust on the fly (before the mouse is
 > inserted), and doesn't require the kernel to be rebuilt.

I really like the idea. I'm start to think that this is the ideal way to 
accomplish this.

Here's a new patch. Let's hope it doesn't wrap!




Signed-off-by: Mikkel Krautz <krautz@gmail.com>
---


 hid-core.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletion(-)



--- dirty/drivers/usb/input/hid-core.c
+++ clean/drivers/usb/input/hid-core.c
@@ -37,11 +37,12 @@
  * Version Information
  */
 
-#define DRIVER_VERSION "v2.0"
+#define DRIVER_VERSION "v2.01"
 #define DRIVER_AUTHOR "Andreas Gal, Vojtech Pavlik"
 #define DRIVER_DESC "USB HID core driver"
 #define DRIVER_LICENSE "GPL"
 
+static unsigned int hid_mouse_polling_interval;
 static char *hid_types[] = {"Device", "Pointer", "Mouse", "Device", 
"Joystick",
                 "Gamepad", "Keyboard", "Keypad", "Multi-Axis Controller"};
 
@@ -1663,6 +1664,11 @@
         if ((endpoint->bmAttributes & 3) != 3)        /* Not an 
interrupt endpoint */
             continue;
 
+        /* Change the polling interval of mice. */
+        if (hid->collection->usage == HID_GD_MOUSE
+                && hid_mouse_polling_interval > 0)
+            endpoint->bInterval = hid_mouse_polling_interval;
+       
         /* handle potential highspeed HID correctly */
         interval = endpoint->bInterval;
         if (dev->speed == USB_SPEED_HIGH)
@@ -1910,6 +1916,7 @@
 
 module_init(hid_init);
 module_exit(hid_exit);
+module_param(hid_mouse_polling_interval, int, 644);
 
 MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESC);

 



