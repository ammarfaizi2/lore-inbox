Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267057AbTBLK5J>; Wed, 12 Feb 2003 05:57:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267085AbTBLKz4>; Wed, 12 Feb 2003 05:55:56 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:27017 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S267057AbTBLKyt>;
	Wed, 12 Feb 2003 05:54:49 -0500
Date: Wed, 12 Feb 2003 12:04:27 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [patch] input: joydev/mousedev update [8/14]
Message-ID: <20030212120427.G1563@ucw.cz>
References: <20030212115954.A1268@ucw.cz> <20030212120038.A1563@ucw.cz> <20030212120119.B1563@ucw.cz> <20030212120154.C1563@ucw.cz> <20030212120242.D1563@ucw.cz> <20030212120321.E1563@ucw.cz> <20030212120359.F1563@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030212120359.F1563@ucw.cz>; from vojtech@suse.cz on Wed, Feb 12, 2003 at 12:03:59PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1011, 2003-02-12 11:02:12+01:00, vojtech@suse.cz
  input.c: joydev/mousedev update
  	- relax requirements on devices, joydev now allows joysticks
  	  without buttons to work with throttles and pedals, mousedev
  	  allows a separate mouse wheel
  	- remove a stray semicolon in joydev


 joydev.c   |   17 +++++++++--------
 mousedev.c |    6 +++++-
 2 files changed, 14 insertions(+), 9 deletions(-)

===================================================================

diff -Nru a/drivers/input/joydev.c b/drivers/input/joydev.c
--- a/drivers/input/joydev.c	Wed Feb 12 11:56:52 2003
+++ b/drivers/input/joydev.c	Wed Feb 12 11:56:52 2003
@@ -340,7 +340,7 @@
 		case JSIOCSBTNMAP:
 			if (copy_from_user(joydev->keypam, (__u16 *) arg, sizeof(__u16) * (KEY_MAX - BTN_MISC)))
 				return -EFAULT;
-			for (i = 0; i < joydev->nkey; i++); {
+			for (i = 0; i < joydev->nkey; i++) {
 				if (joydev->keypam[i] > KEY_MAX || joydev->keypam[i] < BTN_MISC) return -EINVAL;
 				joydev->keymap[joydev->keypam[i] - BTN_MISC] = i;
 			}
@@ -377,7 +377,8 @@
 	struct joydev *joydev;
 	int i, j, t, minor;
 
-        if (test_bit(BTN_TOUCH, dev->keybit))
+	/* Avoid tablets */
+        if (test_bit(EV_KEY, dev->evbit) && test_bit(BTN_TOUCH, dev->keybit))
 		return NULL;
 
 	for (minor = 0; minor < JOYDEV_MINORS && joydev_table[minor]; minor++);
@@ -463,18 +464,18 @@
 
 static struct input_device_id joydev_ids[] = {
 	{
-		.flags = INPUT_DEVICE_ID_MATCH_EVBIT,
-		.evbit = { BIT(EV_KEY) | BIT(EV_ABS) },
+		.flags = INPUT_DEVICE_ID_MATCH_EVBIT | INPUT_DEVICE_ID_MATCH_ABSBIT,
+		.evbit = { BIT(EV_ABS) },
 		.absbit = { BIT(ABS_X) },
 	},
 	{
-		.flags = INPUT_DEVICE_ID_MATCH_EVBIT,
-		.evbit = { BIT(EV_KEY) | BIT(EV_ABS) },
+		.flags = INPUT_DEVICE_ID_MATCH_EVBIT | INPUT_DEVICE_ID_MATCH_ABSBIT,
+		.evbit = { BIT(EV_ABS) },
 		.absbit = { BIT(ABS_WHEEL) },
 	},
 	{
-		.flags = INPUT_DEVICE_ID_MATCH_EVBIT,
-		.evbit = { BIT(EV_KEY) | BIT(EV_ABS) },
+		.flags = INPUT_DEVICE_ID_MATCH_EVBIT | INPUT_DEVICE_ID_MATCH_ABSBIT,
+		.evbit = { BIT(EV_ABS) },
 		.absbit = { BIT(ABS_THROTTLE) },
 	},
 	{ }, 	/* Terminating entry */
diff -Nru a/drivers/input/mousedev.c b/drivers/input/mousedev.c
--- a/drivers/input/mousedev.c	Wed Feb 12 11:56:52 2003
+++ b/drivers/input/mousedev.c	Wed Feb 12 11:56:52 2003
@@ -454,7 +454,11 @@
 		.keybit = { [LONG(BTN_LEFT)] = BIT(BTN_LEFT) },
 		.relbit = { BIT(REL_X) | BIT(REL_Y) },
 	},	/* A mouse like device, at least one button, two relative axes */
-
+	{
+		.flags = INPUT_DEVICE_ID_MATCH_EVBIT | INPUT_DEVICE_ID_MATCH_RELBIT,
+		.evbit = { BIT(EV_KEY) | BIT(EV_REL) },
+		.relbit = { BIT(REL_WHEEL) },
+	},	/* A separate scrollwheel */
 	{
 		.flags = INPUT_DEVICE_ID_MATCH_EVBIT | INPUT_DEVICE_ID_MATCH_KEYBIT | INPUT_DEVICE_ID_MATCH_ABSBIT,
 		.evbit = { BIT(EV_KEY) | BIT(EV_ABS) },
