Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263290AbTICFuQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 01:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263372AbTICFuQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 01:50:16 -0400
Received: from smtp806.mail.sc5.yahoo.com ([66.163.168.185]:31510 "HELO
	smtp806.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263290AbTICFuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 01:50:10 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6: joydev is too eager claiming input devices
Date: Wed, 3 Sep 2003 00:50:04 -0500
User-Agent: KMail/1.5.3
Cc: Vojtech Pavlik <vojtech@suse.cz>, David Cougle <davidcougle@hotmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309030050.06800.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently joydev will claim any device reporting ABS_X events. This 
includes Synaptics touchpad in absolute mode, PC110 touchpad and both 
touchscreens. Nothing bad happens except for strange input/jsX device 
but it's still not right.

I think we need stricter rules for joydev matching, like in the patch
below. Unfortunately I do not own any joysticks, but I did go through
all code in input/joystick and I think I covered all possible cases.

Dmitry

--- 2.6.0-test4/drivers/input/joydev.c	2003-09-03 00:43:19.000000000 -0500
+++ linux-2.6.0-test4/drivers/input/joydev.c	2003-09-03 00:44:00.000000000 -0500
@@ -466,13 +466,43 @@
 
 static struct input_device_id joydev_ids[] = {
 	{
-		.flags = INPUT_DEVICE_ID_MATCH_EVBIT | INPUT_DEVICE_ID_MATCH_ABSBIT,
+		.flags = INPUT_DEVICE_ID_MATCH_EVBIT | INPUT_DEVICE_ID_MATCH_ABSBIT |
+			 INPUT_DEVICE_ID_MATCH_BUS,
+		.evbit = { BIT(EV_ABS) },
+		.absbit = { BIT(ABS_X) },
+		.id = { .bustype = BUS_GAMEPORT },
+	}, /* anything connected to a gameport is a fair game */
+	{
+		.flags = INPUT_DEVICE_ID_MATCH_EVBIT | INPUT_DEVICE_ID_MATCH_ABSBIT |
+			 INPUT_DEVICE_ID_MATCH_BUS,
+		.evbit = { BIT(EV_ABS) },
+		.absbit = { BIT(ABS_X) },
+		.id = { .bustype = BUS_AMIGA },
+	}, /* amiga joystick does not report any special buttons but luckily it is 
+	      the only device rporting absolute coordinates on Amiga bus */
+	{
+		.flags = INPUT_DEVICE_ID_MATCH_EVBIT | INPUT_DEVICE_ID_MATCH_ABSBIT | 
+			 INPUT_DEVICE_ID_MATCH_KEYBIT,
 		.evbit = { BIT(EV_ABS) },
 		.absbit = { BIT(ABS_X) },
+		.keybit = { BIT(BTN_TRIGGER) }, 
+	}, /* most joysticks have either BTN_TRIGGER or BTN_A or both */
+	{
+		.flags = INPUT_DEVICE_ID_MATCH_EVBIT | INPUT_DEVICE_ID_MATCH_ABSBIT | 
+			 INPUT_DEVICE_ID_MATCH_KEYBIT,
+		.evbit = { BIT(EV_ABS) },
+		.absbit = { BIT(ABS_X) },
+		.keybit = { BIT(BTN_A) },
 	},
 	{
 		.flags = INPUT_DEVICE_ID_MATCH_EVBIT | INPUT_DEVICE_ID_MATCH_ABSBIT,
 		.evbit = { BIT(EV_ABS) },
+		.absbit = { BIT(ABS_RX), BIT(ABS_RY) },
+	}, /* magellan and some others report only MISC buttons but we can identify 
+	      them by using special axis auch as RX/RY, ABS_WHEEL or ABS_THROTTLE */
+	{
+		.flags = INPUT_DEVICE_ID_MATCH_EVBIT | INPUT_DEVICE_ID_MATCH_ABSBIT,
+		.evbit = { BIT(EV_ABS) },
 		.absbit = { BIT(ABS_WHEEL) },
 	},
 	{
