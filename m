Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261259AbULSBwQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261259AbULSBwQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 20:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261260AbULSBwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 20:52:16 -0500
Received: from wproxy.gmail.com ([64.233.184.207]:4117 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261259AbULSBwI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 20:52:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=LLL3OJgMQDwyxnlsdzXUNnMBsJUtzej0iZeLnXDPSBrQ3r6UFxjG/X3fZS1pV/hUWuQtunkTOhm0VhK/bkTiVJq2kcBOgjikAeQYnlzLJG/m6yleymaMtLARCJKoxIQisA8xN3WoPlDnabqFVTOdhrdT+SyWjveBGyMpRGye2WA=
Message-ID: <d4b385204121817521b0df40f@mail.gmail.com>
Date: Sun, 19 Dec 2004 01:52:06 +0000
From: Mikkel Krautz <krautz@gmail.com>
Reply-To: Mikkel Krautz <krautz@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hid-core: Configurable USB HID Mouse Interrupt Polling Interval
Cc: greg@kroah.com, vojtech@suse.cz
In-Reply-To: <20041218165331.GA7737@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1103335970.15567.15.camel@localhost>
	 <20041218012725.GB25628@kroah.com> <41C46B4D.5040506@gmail.com>
	 <20041218165331.GA7737@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Dec 2004 08:53:31 -0800, Greg KH <greg@kroah.com> wrote:
> On Sat, Dec 18, 2004 at 05:39:25PM +0000, Mikkel Krautz wrote:
> > On Fri, 17 Dec 2004 18:59:48 -0800, Greg KH <greg@kroah.com> wrote:
> > > What about makeing it a module paramater then, that is exported to
> > > sysfs?  That makes it easier to adjust on the fly (before the mouse is
> > > inserted), and doesn't require the kernel to be rebuilt.
> >
> > I really like the idea. I'm start to think that this is the ideal way to
> > accomplish this.
> >
> > Here's a new patch. Let's hope it doesn't wrap!
> 
> It was eaten :(
> 
> > module_init(hid_init);
> > module_exit(hid_exit);
> > +module_param(hid_mouse_polling_interval, int, 644);
> 
> 0644, or use the proper #defines instead.
> 
> thanks,
> 
> greg k-h
> 

Here's an updated version, with your and Marcel's suggestions:





Signed-off-by: Mikkel Krautz <krautz@gmail.com>
---


 hid-core.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletion(-)


--- clean/drivers/usb/input/hid-core.c
+++ dirty/drviers/usb/input/hid-core.c
@@ -37,11 +37,12 @@
  * Version Information
  */
 
-#define DRIVER_VERSION "v2.0"
+#define DRIVER_VERSION "v2.01"
 #define DRIVER_AUTHOR "Andreas Gal, Vojtech Pavlik"
 #define DRIVER_DESC "USB HID core driver"
 #define DRIVER_LICENSE "GPL"
 
+static unsigned int hid_mousepoll_interval;
 static char *hid_types[] = {"Device", "Pointer", "Mouse", "Device", "Joystick",
 				"Gamepad", "Keyboard", "Keypad", "Multi-Axis Controller"};
 
@@ -1663,6 +1664,11 @@
 		if ((endpoint->bmAttributes & 3) != 3)		/* Not an interrupt endpoint */
 			continue;
 
+		/* Change the polling interval of mice. */
+		if (hid->collection->usage == HID_GD_MOUSE
+				&& hid_mousepoll_interval > 0)
+			endpoint->bInterval = hid_mousepoll_interval;
+		
 		/* handle potential highspeed HID correctly */
 		interval = endpoint->bInterval;
 		if (dev->speed == USB_SPEED_HIGH)
@@ -1910,6 +1916,7 @@
 
 module_init(hid_init);
 module_exit(hid_exit);
+module_param_named(mousepoll, hid_mousepoll_interval, uint, 0644);
 
 MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESC);
