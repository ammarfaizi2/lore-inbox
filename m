Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267994AbUIUSQ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267994AbUIUSQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 14:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267992AbUIUSQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 14:16:28 -0400
Received: from c-24-19-11-70.client.comcast.net ([24.19.11.70]:31976 "EHLO
	ultimation.org") by vger.kernel.org with ESMTP id S267994AbUIUSQU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 14:16:20 -0400
Message-ID: <4192.69.25.132.5.1095790579.squirrel@69.25.132.5>
Date: Tue, 21 Sep 2004 11:16:19 -0700 (PDT)
Subject: [PATCH] Support for Snapstream Firefly remote added to ati_remote.c
From: dylan@ultimation.org
To: greg@kroah.net
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.3-RC1
X-Mailer: SquirrelMail/1.4.3-RC1
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've added support for the Snapstream Firefly X10 remote
(http://www.snapstream.com/Products/firefly/). This involved adding a new
product ID, and adding some additional logic to the event_lookup function.
The Firefly alternately encodes the keypress data differently than the
driver currently expects, so that every other keypress is invalid with the
current driver version. The transformation is pretty simple; I'm assuming
it's there simply to allow the driver to distinguish between what two
distinct key events looks like and what it looks like to drop signal in
the middle of holding a remote button.

As well, I also added a module_param called disable_keyboard which allows
the user to toggle off whether the driver actually sends key events, or
simply generates raw evdev events. I found this useful, since I'm working
on an app that reads the evdev events natively and then sends it's own
keyboard/mouse/window events in X. The keyboard events being sent by the
driver were interfering with the events I wanted to generate myself.

This patch applies to version 2.6.9-rc1-mm4.

Signed-off-by: Dylan Paris <kernelcontrib@ultimation.org>

--- ati_remote.c.orig   2004-09-21 11:03:26.214097225 -0700
+++ ati_remote.c        2004-09-13 22:55:28.000000000 -0700
@@ -22,6 +22,9 @@
  *                Vincent Vanackere <vanackere@lif.univ-mrs.fr>
  *            Added support for the "Lola" remote contributed by:
  *                Seth Cohn <sethcohn@yahoo.com>
+ *  August 2004: Dylan Paris <kernelcontrib@ultimation.org>
+ *               Version 2.2.2
+ *              Added support for the Snapstream Firefly remote
  *
  * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
  *
@@ -102,6 +105,7 @@
 #define ATI_REMOTE_VENDOR_ID   0x0bc7
 #define ATI_REMOTE_PRODUCT_ID  0x004
 #define LOLA_REMOTE_PRODUCT_ID         0x002
+#define FIREFLY_REMOTE_PRODUCT_ID  0x0008

 #define DRIVER_VERSION                 "2.2.1"
 #define DRIVER_AUTHOR           "Torrey Hoffman <thoffman@arnor.net>"
@@ -116,9 +120,13 @@ module_param(channel_mask, ulong, 0444);
 MODULE_PARM_DESC(channel_mask, "Bitmask of remote control channels to
ignore");

 static int debug = 0;
-module_param(debug, int, 0444);
+module_param(debug, int, 0666);
 MODULE_PARM_DESC(debug, "Enable extra debug messages and information");

+static int disable_keyboard = 0;
+module_param(disable_keyboard, int, 0666);
+MODULE_PARM_DESC(disable_keyboard, "Disable sending keyboard events");
+
 #define dbginfo(dev, format, arg...) do { if (debug) dev_info(dev ,
format , ## arg); } while (0)
 #undef err
 #define err(format, arg...) printk(KERN_ERR format , ## arg)
@@ -126,6 +134,7 @@ MODULE_PARM_DESC(debug, "Enable extra de
 static struct usb_device_id ati_remote_table[] = {
        { USB_DEVICE(ATI_REMOTE_VENDOR_ID, ATI_REMOTE_PRODUCT_ID) },
        { USB_DEVICE(ATI_REMOTE_VENDOR_ID, LOLA_REMOTE_PRODUCT_ID) },
+       { USB_DEVICE(ATI_REMOTE_VENDOR_ID, FIREFLY_REMOTE_PRODUCT_ID) },
        {}      /* Terminating entry */
 };

@@ -280,6 +289,9 @@ static struct
        {KIND_FILTERED, 0xf4, 0x2F, EV_KEY, KEY_END, 1},        /* END */
        {KIND_FILTERED, 0xf5, 0x30, EV_KEY, KEY_SELECT, 1},     /* SELECT */

+       /* Firefly Remote Buttons */
+       {KIND_FILTERED, 0xf1, 0x2c, EV_KEY, KEY_KATAKANA, 1},     /*
MAXIMIZE */
+
        {KIND_END, 0x00, 0x00, EV_MAX + 1, 0, 0}
 };

@@ -444,8 +456,15 @@ static int ati_remote_event_lookup(int r
                    ((((ati_remote_tbl[i].data1 >> 4) -
                       (d1 >> 4) + rem) & 0x0f) == 0x0f) &&
                    (ati_remote_tbl[i].data2 == d2))
-                       return i;
-
+                 return i;
+
+
+               if ((((ati_remote_tbl[i].data1 & 0x0f) == (d1 & 0x0f))) &&
+                   ((d1 >> 4) == (((ati_remote_tbl[i].data1 >> 4) + 1 ) &
0x0f )) &&
+                   (((ati_remote_tbl[i].data2 & 0x0f) == (d2 & 0x0f))) &&
+                   ((d2 >> 4) == ((ati_remote_tbl[i].data2 >> 4) ^ 0x8)))
+                 return i;
+
        }
        return -1;
 }
@@ -460,6 +479,7 @@ static void ati_remote_input_report(stru
        struct input_dev *dev = &ati_remote->idev;
        int index, acc;
        int remote_num;
+       int ev_type;

        /* Deal with strange looking inputs */
        if ( (urb->actual_length != 4) || (data[0] != 0x14) ||
@@ -492,7 +512,9 @@ static void ati_remote_input_report(stru

        if (ati_remote_tbl[index].kind == KIND_LITERAL) {
                input_regs(dev, regs);
-               input_event(dev, ati_remote_tbl[index].type,
+
+               ev_type = ((disable_keyboard) ? 0 :
ati_remote_tbl[index].type);
+               input_event(dev, ev_type,
                        ati_remote_tbl[index].code,
                        ati_remote_tbl[index].value);
                input_sync(dev);
@@ -520,11 +542,12 @@ static void ati_remote_input_report(stru
                    && (ati_remote->repeat_count < 5))
                        return;

+               ev_type = ((disable_keyboard) ? 0 :
ati_remote_tbl[index].type);

                input_regs(dev, regs);
-               input_event(dev, ati_remote_tbl[index].type,
+               input_event(dev, ev_type,
                        ati_remote_tbl[index].code, 1);
-               input_event(dev, ati_remote_tbl[index].type,
+               input_event(dev, ev_type,
                        ati_remote_tbl[index].code, 0);
                input_sync(dev);

@@ -729,7 +752,8 @@ static int ati_remote_probe(struct usb_i
        /* See if the offered device matches what we can accept */
        if ((udev->descriptor.idVendor != ATI_REMOTE_VENDOR_ID) ||
                ( (udev->descriptor.idProduct != ATI_REMOTE_PRODUCT_ID) &&
-                 (udev->descriptor.idProduct != LOLA_REMOTE_PRODUCT_ID) ))
+                 (udev->descriptor.idProduct != LOLA_REMOTE_PRODUCT_ID) &&
+                 (udev->descriptor.idProduct !=
FIREFLY_REMOTE_PRODUCT_ID) ))
                return -ENODEV;

        /* Allocate and clear an ati_remote struct */

