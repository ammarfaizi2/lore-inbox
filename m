Return-Path: <linux-kernel-owner+w=401wt.eu-S1751720AbXANXST@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751720AbXANXST (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 18:18:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751721AbXANXST
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 18:18:19 -0500
Received: from smtprelay05.ispgateway.de ([80.67.18.43]:33852 "EHLO
	smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751715AbXANXSS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 18:18:18 -0500
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Sun, 14 Jan 2007 18:18:17 EST
Date: Mon, 15 Jan 2007 00:11:35 +0100
To: vojtech@suse.cz
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.19] USB HID: proper LED-mapping (support for SpaceNavigator)
Message-ID: <20070114231135.GA29966@budig.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Simon Budig <simon@budig.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Simon Budig <simon@budig.de>

This change introduces a mapping for LED indicators between the USB HID
specification and the Linux input subsystem. The previous code properly
mapped the LEDs relevant for Keyboards, but garbeled the remaining ones.
With this change all LED enums from the input system get mapped to more
or less equivalent LED numbers from the HID specification.

This patch also extends the debug output and ensures that the unused
bits in a HID report to the device are zeroed out. This makes the
3Dconnexion SpaceNavigator fully usable with the linux input system.

Signed-off-by: Simon Budig <simon@budig.de>

diff -uprN -X linux/Documentation/dontdiff linux/drivers/usb/input.orig/hid-core.c linux/drivers/usb/input/hid-core.c
--- linux/drivers/usb/input.orig/hid-core.c	2006-11-29 22:57:37.000000000 +0100
+++ linux/drivers/usb/input/hid-core.c	2007-01-15 00:01:25.000000000 +0100
@@ -1089,6 +1089,10 @@ static void hid_output_field(struct hid_
 	unsigned size = field->report_size;
 	unsigned n;
 
+	/* make sure the unused bits in the last byte are zeros */
+	if (count > 0 && size > 0)
+		data[(count*size-1)/8] = 0;
+
 	for (n = 0; n < count; n++) {
 		if (field->logical_minimum < 0)	/* signed values */
 			implement(data, offset + n * size, size, s32ton(field->value[n], size));
diff -uprN -X linux/Documentation/dontdiff linux/drivers/usb/input.orig/hid-debug.h linux/drivers/usb/input/hid-debug.h
--- linux/drivers/usb/input.orig/hid-debug.h	2006-11-29 22:57:37.000000000 +0100
+++ linux/drivers/usb/input/hid-debug.h	2007-01-08 15:36:51.000000000 +0100
@@ -700,9 +700,10 @@ static char *keys[KEY_MAX + 1] = {
 
 static char *relatives[REL_MAX + 1] = {
 	[REL_X] = "X",			[REL_Y] = "Y",
-	[REL_Z] = "Z",			[REL_HWHEEL] = "HWheel",
-	[REL_DIAL] = "Dial",		[REL_WHEEL] = "Wheel",
-	[REL_MISC] = "Misc",
+	[REL_Z] = "Z",			[REL_RX] = "Rx",
+	[REL_RY] = "Ry",		[REL_RZ] = "Rz",
+	[REL_HWHEEL] = "HWheel",	[REL_DIAL] = "Dial",
+	[REL_WHEEL] = "Wheel",		[REL_MISC] = "Misc",
 };
 
 static char *absolutes[ABS_MAX + 1] = {
diff -uprN -X linux/Documentation/dontdiff linux/drivers/usb/input.orig/hid-input.c linux/drivers/usb/input/hid-input.c
--- linux/drivers/usb/input.orig/hid-input.c	2006-11-29 22:57:37.000000000 +0100
+++ linux/drivers/usb/input/hid-input.c	2007-01-08 17:20:16.000000000 +0100
@@ -366,9 +366,22 @@ static void hidinput_configure_usage(str
 			break;
 
 		case HID_UP_LED:
-			if (((usage->hid - 1) & 0xffff) >= LED_MAX)
-				goto ignore;
-			map_led((usage->hid - 1) & 0xffff);
+
+			switch (usage->hid & 0xffff) {                        /* HID-Value: */
+				case 0x01:  map_led (LED_NUML);     break;    /* Num Lock */
+				case 0x02:  map_led (LED_CAPSL);    break;    /* Caps Lock */
+				case 0x03:  map_led (LED_SCROLLL);  break;    /* Scroll Lock */
+				case 0x04:  map_led (LED_COMPOSE);  break;    /* Compose */
+				case 0x05:  map_led (LED_KANA);     break;    /* Kana */
+				case 0x27:  map_led (LED_SLEEP);    break;    /* Stand-By */
+				case 0x4c:  map_led (LED_SUSPEND);  break;    /* System Suspend */
+				case 0x09:  map_led (LED_MUTE);     break;    /* Mute */
+				case 0x4b:  map_led (LED_MISC);     break;    /* Generic Indicator */
+				case 0x19:  map_led (LED_MAIL);     break;    /* Message Waiting */
+				case 0x4d:  map_led (LED_CHARGING); break;    /* External Power Connected */
+
+				default: goto ignore;
+			}
 			break;
 
 		case HID_UP_DIGITIZER:
