Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262809AbULRCGf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262809AbULRCGf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 21:06:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262813AbULRCGf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 21:06:35 -0500
Received: from wproxy.gmail.com ([64.233.184.201]:33659 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262809AbULRCG0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 21:06:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=jROVl52+CJl/5Nu6Xkl/38DcdMaZjqzxdZeRLDjnFT1QSvSsVHnVcAImpQYUTc7IkaWVq00+lJTtY4FRy62JF4Q/Bq5c1AMD0qeKsf/PPEc5ntdf5h9ptJVeNfIoG5YpQtel+pFx/qb+75VSzwZVWr59mSpbLaeLBap8NyPhGhY=
Message-ID: <41C3B068.4000605@gmail.com>
Date: Sat, 18 Dec 2004 04:22:00 +0000
From: Mikkel Krautz <krautz@gmail.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: vojtech@suse.cz, krautz@gmail.com
Subject: Re: [PATCH] hid-core: Configurable USB HID Mouse Interrupt Polling
 Interval
References: <1103335970.15567.15.camel@localhost> <20041218012725.GB25628@kroah.com>
In-Reply-To: <20041218012725.GB25628@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Dec 2004 19:43:23 -0500, Gene Heskett 
<gene.heskett@verizon.net> wrote:
 > Mikkel, could you please turn off the word wrap in your MTA's
 > composer and repost this? I'd like to try it.

Sorry about that.
Here's a repost. Now even with a diffstat:




Signed-off-by: Mikkel Krautz <krautz@gmail.com>
---

Kconfig | 32 ++++++++++++++++++++++++++++++++
hid-core.c | 8 +++++++-
2 files changed, 39 insertions(+), 1 deletion(-)


--- clean/drivers/usb/input/Kconfig
+++ dirty/drivers/usb/input/Kconfig
@@ -24,6 +24,38 @@
To compile this driver as a module, choose M here: the
module will be called usbhid.

+config USB_HID_MOUSE_POLLING_INTERVAL
+ int "USB HID Mouse Interrupt Polling Interval"
+ default 10
+ depends on USB_HID
+ help
+ The "USB HID Mouse Interrupt Polling Interval" is the interval, at
+ which your USB HID mouse is to be polled at. The interval is
+ specified in miliseconds.
+
+ Decreasing the interval will, of course, give you a much more
+ precise mouse.
+
+ Generally speaking, a polling interval of 2 ms should be more than
+ enough for most people, and is great for gaming and other things
+ that require high precision.
+
+ An interval lower than the default is not guaranteed work on your
+ specific piece of hardware. If you want to play it safe, don't
+ change this value.
+
+ Now, if you indeed want to feel the joy of a precise mouse, the
+ following mice are known to work without problems, when the interval
+ is set to at least 2 ms:
+
+ * Logitech's MX-family
+ * Logitech Mouse Man Dual Optical
+ * Logitech iFeel
+ * Microsoft Intellimouse Explorer
+ * Microsoft Intellimouse Optical 1.1
+
+ If unsure, keep it at 10 ms.
+
comment "Input core support is needed for USB HID input layer or HIDBP 
support"
depends on USB_HID && INPUT=n

--- clean/drivers/usb/input/hid-core.c
+++ dirty/drivers/usb/input/hid-core.c
@@ -37,7 +37,7 @@
* Version Information
*/

-#define DRIVER_VERSION "v2.0"
+#define DRIVER_VERSION "v2.01"
#define DRIVER_AUTHOR "Andreas Gal, Vojtech Pavlik"
#define DRIVER_DESC "USB HID core driver"
#define DRIVER_LICENSE "GPL"
@@ -1663,6 +1663,12 @@
if ((endpoint->bmAttributes & 3) != 3) /* Not an interrupt endpoint */
continue;

+ /* Set the interrupt polling interval of mice, to the one specified in 
the config. */
+ if (hid->collection->usage == HID_GD_MOUSE
+ && CONFIG_USB_HID_MOUSE_POLLING_INTERVAL > 0
+ && CONFIG_USB_HID_MOUSE_POLLING_INTERVAL < 255)
+ endpoint->bInterval = CONFIG_USB_HID_MOUSE_POLLING_INTERVAL;
+
/* handle potential highspeed HID correctly */
interval = endpoint->bInterval;
if (dev->speed == USB_SPEED_HIGH)


