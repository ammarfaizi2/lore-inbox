Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262671AbVA0RSm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262671AbVA0RSm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 12:18:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262670AbVA0RRe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 12:17:34 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:64479 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S262673AbVA0ROW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 12:14:22 -0500
Subject: [PATCH 1/6] Add support for H-Wheel on Microsoft Explorer and Logitech MX mice
In-Reply-To: <20050127165958.GA15690@ucw.cz>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Thu, 27 Jan 2005 18:13:58 +0100
Message-Id: <1106846038373@twilight.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@osdl.org, vojtech@ucw.cz, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/for-linus

===================================================================

ChangeSet@1.1970, 2005-01-11 17:45:14+01:00, vojtech@silver.ucw.cz
  input: Add support for H-Wheel on Microsoft Explorer and Logitech MX
         USB HID mice.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>


 hid-debug.h |   24 ++++++++++++++----------
 hid-input.c |   12 +++++++++---
 hid.h       |    1 +
 3 files changed, 24 insertions(+), 13 deletions(-)

===================================================================

diff -Nru a/drivers/usb/input/hid-debug.h b/drivers/usb/input/hid-debug.h
--- a/drivers/usb/input/hid-debug.h	2005-01-27 17:48:14 +01:00
+++ b/drivers/usb/input/hid-debug.h	2005-01-27 17:48:14 +01:00
@@ -81,15 +81,21 @@
       {0, 0x8b, "SystemMenuLeft"},
       {0, 0x8c, "SystemMenuUp"},
       {0, 0x8d, "SystemMenuDown"},
-    {0, 0x90, "D-padUp"},
-    {0, 0x91, "D-padDown"},
-    {0, 0x92, "D-padRight"},
-    {0, 0x93, "D-padLeft"},
+      {0, 0x90, "D-PadUp"},
+      {0, 0x91, "D-PadDown"},
+      {0, 0x92, "D-PadRight"},
+      {0, 0x93, "D-PadLeft"},
   {  7, 0, "Keyboard" },
+      {0, 0x01, "NumLock"},
+      {0, 0x02, "CapsLock"},
+      {0, 0x03, "ScrollLock"},
+      {0, 0x04, "Compose"},
+      {0, 0x05, "Kana"},
   {  8, 0, "LED" },
   {  9, 0, "Button" },
   { 10, 0, "Ordinal" },
-  { 12, 0, "Hotkey" },
+  { 12, 0, "Consumer" },
+      {0, 0x238, "HorizontalWheel"},
   { 13, 0, "Digitizers" },
     {0, 0x01, "Digitizer"},
     {0, 0x02, "Pen"},
@@ -653,12 +659,10 @@
 	[KEY_SLOW] = "Slow",			[KEY_SHUFFLE] = "Shuffle",
 	[KEY_BREAK] = "Break",			[KEY_PREVIOUS] = "Previous",
 	[KEY_DIGITS] = "Digits",		[KEY_TEEN] = "TEEN",
-	[KEY_TWEN] = "TWEN",			[KEY_DEL_EOL] = "Delete EOL",
-	[KEY_DEL_EOS] = "Delete EOS",		[KEY_INS_LINE] = "Insert line",
-	[KEY_DEL_LINE] = "Delete line",
+	[KEY_TWEN] = "TWEN",			[KEY_DEL_EOL] = "DeleteEOL",
+	[KEY_DEL_EOS] = "DeleteEOS",		[KEY_INS_LINE] = "InsertLine",
+	[KEY_DEL_LINE] = "DeleteLine",
 };
-
-static char *absval[5] = { "Value", "Min  ", "Max  ", "Fuzz ", "Flat " };
 
 static char *relatives[REL_MAX + 1] = {
 	[0 ... REL_MAX] = NULL,
diff -Nru a/drivers/usb/input/hid-input.c b/drivers/usb/input/hid-input.c
--- a/drivers/usb/input/hid-input.c	2005-01-27 17:48:14 +01:00
+++ b/drivers/usb/input/hid-input.c	2005-01-27 17:48:14 +01:00
@@ -185,7 +185,9 @@
 			break;
 
 		case HID_UP_LED:
-			map_led((usage->hid - 1) & 0xf);
+			if (usage->hid - 1 >= LED_MAX)
+				goto ignore;
+			map_led(usage->hid - 1);
 			break;
 
 		case HID_UP_DIGITIZER:
@@ -231,7 +233,6 @@
 
 		case HID_UP_CONSUMER:	/* USB HUT v1.1, pages 56-62 */
 
-			set_bit(EV_REP, input->evbit);
 			switch (usage->hid & HID_USAGE) {
 				case 0x000: goto ignore;
 				case 0x034: map_key_clear(KEY_SLEEP);		break;
@@ -268,6 +269,7 @@
 				case 0x226: map_key_clear(KEY_STOP);		break;
 				case 0x227: map_key_clear(KEY_REFRESH);		break;
 				case 0x22a: map_key_clear(KEY_BOOKMARKS);	break;
+				case 0x238: map_rel(REL_HWHEEL);		break;
 				default:    goto unknown;
 			}
 			break;
@@ -288,9 +290,13 @@
 				case 0x084: map_key_clear(KEY_FINANCE);		break;
 				case 0x085: map_key_clear(KEY_SPORT);		break;
 				case 0x086: map_key_clear(KEY_SHOP);	        break;
-				default:    goto unknown;
+				default:    goto ignore;
 			}
 			break;
+
+		case HID_UP_MSVENDOR:
+
+			goto ignore;
 			
 		case HID_UP_PID:
 
diff -Nru a/drivers/usb/input/hid.h b/drivers/usb/input/hid.h
--- a/drivers/usb/input/hid.h	2005-01-27 17:48:14 +01:00
+++ b/drivers/usb/input/hid.h	2005-01-27 17:48:14 +01:00
@@ -181,6 +181,7 @@
 #define HID_UP_DIGITIZER 	0x000d0000
 #define HID_UP_PID 		0x000f0000
 #define HID_UP_HPVENDOR         0xff7f0000
+#define HID_UP_MSVENDOR		0xff000000
 
 #define HID_USAGE		0x0000ffff
 

