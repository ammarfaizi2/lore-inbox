Return-Path: <linux-kernel-owner+w=401wt.eu-S1750975AbXAOQ2q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbXAOQ2q (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 11:28:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750979AbXAOQ2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 11:28:46 -0500
Received: from smtprelay03.ispgateway.de ([80.67.18.15]:49548 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750975AbXAOQ2p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 11:28:45 -0500
Date: Mon, 15 Jan 2007 17:28:47 +0100
From: Simon Budig <simon@budig.de>
To: vojtech@suse.cz
Cc: linux-kernel@vger.kernel.org, Jiri Kosina <jikos@jikos.cz>
Subject: [PATCH 2.6.20-rc5] USB HID: proper LED-mapping (support for SpaceNavigator)
Message-ID: <20070115162847.GB3751@budig.de>
References: <20070114231135.GA29966@budig.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070114231135.GA29966@budig.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Simon Budig <simon@budig.de>

This change introduces a mapping for LED indicators between the USB HID
specification and the Linux input subsystem. The previous code properly
mapped the LEDs relevant for Keyboards, but garbeled the remaining ones.
With this change all LED enums from the input system get mapped to more
or less equivalent LED numbers from the HID specification.

This patch also ensures that the unused bits in a HID report to the
device are zeroed out. This makes the 3Dconnexion SpaceNavigator fully
usable with the linux input system.

Signed-off-by: Simon Budig <simon@budig.de>


diff -uprN -X linux/Documentation/dontdiff linux-2.6.19/drivers/hid/hid-core.c linux/drivers/hid/hid-core.c
--- linux-2.6.19/drivers/hid/hid-core.c	2007-01-15 17:06:37.000000000 +0100
+++ linux/drivers/hid/hid-core.c	2007-01-15 16:59:16.000000000 +0100
@@ -880,6 +880,10 @@ static void hid_output_field(struct hid_
 	unsigned size = field->report_size;
 	unsigned n;
 
+	/* make sure the unused bits in the last byte are zeros */
+	if (count > 0 && size > 0)
+		data[(count*size-1)/8] = 0;
+
 	for (n = 0; n < count; n++) {
 		if (field->logical_minimum < 0)	/* signed values */
 			implement(data, offset + n * size, size, s32ton(field->value[n], size));
diff -uprN -X linux/Documentation/dontdiff linux-2.6.19/drivers/hid/hid-input.c linux/drivers/hid/hid-input.c
--- linux-2.6.19/drivers/hid/hid-input.c	2007-01-15 17:06:37.000000000 +0100
+++ linux/drivers/hid/hid-input.c	2007-01-15 17:03:20.000000000 +0100
@@ -364,9 +364,22 @@ static void hidinput_configure_usage(str
 			break;
 
 		case HID_UP_LED:
-			if (((usage->hid - 1) & 0xffff) >= LED_MAX)
-				goto ignore;
-			map_led((usage->hid - 1) & 0xffff);
+
+			switch (usage->hid & 0xffff) {                        /* HID-Value:                   */
+				case 0x01:  map_led (LED_NUML);     break;    /*   "Num Lock"                 */
+				case 0x02:  map_led (LED_CAPSL);    break;    /*   "Caps Lock"                */
+				case 0x03:  map_led (LED_SCROLLL);  break;    /*   "Scroll Lock"              */
+				case 0x04:  map_led (LED_COMPOSE);  break;    /*   "Compose"                  */
+				case 0x05:  map_led (LED_KANA);     break;    /*   "Kana"                     */
+				case 0x27:  map_led (LED_SLEEP);    break;    /*   "Stand-By"                 */
+				case 0x4c:  map_led (LED_SUSPEND);  break;    /*   "System Suspend"           */
+				case 0x09:  map_led (LED_MUTE);     break;    /*   "Mute"                     */
+				case 0x4b:  map_led (LED_MISC);     break;    /*   "Generic Indicator"        */
+				case 0x19:  map_led (LED_MAIL);     break;    /*   "Message Waiting"          */
+				case 0x4d:  map_led (LED_CHARGING); break;    /*   "External Power Connected" */
+
+				default: goto ignore;
+			}
 			break;
 
 		case HID_UP_DIGITIZER:
