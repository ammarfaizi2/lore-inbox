Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751396AbWCBD2f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396AbWCBD2f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 22:28:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751958AbWCBD2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 22:28:35 -0500
Received: from zap.org.AU ([129.94.172.224]:52375 "EHLO mail.zap.org.au")
	by vger.kernel.org with ESMTP id S1751396AbWCBD2e convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 22:28:34 -0500
Date: Thu, 2 Mar 2006 14:28:17 +1100
From: John Zaitseff <J.Zaitseff@zap.org.au>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: Key codes for Microsoft Natural Ergonomic 4000 USB keyboard
Message-ID: <20060302032817.GA9381@zap.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Zaitseff <J.Zaitseff@zap.org.au>

The following patch to Linux kernel 2.6.16-rc5 enables the extra
keys found on the Microsoft Natural Ergonomic 4000 USB keyboard.  I
had to add a number of keycodes to include/linux/input.h; feel free
to reallocate IDs assigned to these new keys.

Main changes:

* Enabled the use of the extra "(" and ")" in the top right-hand
  part of the keyboard, above the keypad

* Map the zoom slider to KEY_ZOOMPLUS and KEY_ZOOMMINUS (they are
  actually keypresses)

* Map the F1-F12 keys to appropriate keys when the F Lock is off
  (this is quite easy as the keyboard already generates different
  USB key events)

* Map the five buttons above My Favorites to KEY_FN_F1 to KEY_FN_F5

I am not sure that I have done the last of these changes correctly:
the keyboard returns a usage->hid of (HID_UP_MSVENDOR | 0xff05)
whenever any of the five keys are pressed or let go (as well as at
certain other times, when the value is 0):

  value = 0x00  --->  none of the five keys are pressed
  value = 0x01  --->  key 1 is pressed
  value = 0x02  --->  key 2 is pressed
  value = 0x04  --->  key 3 is pressed
  value = 0x08  --->  key 4 is pressed
  value = 0x10  --->  key 5 is pressed

Note that although this looks like a bitfield, multiple keys CANNOT
in effect be pressed simultaneously: only one of these six values is
ever returned (as tested).

Please apply if at all possible!  Please CC me on any discussion, as
I am not subscribed to the mailing lists.

Signed-off-by: John Zaitseff <J.Zaitseff@zap.org.au>
---

 drivers/usb/input/hid-debug.h |    7 +++---
 drivers/usb/input/hid-input.c |   45 +++++++++++++++++++++++++++++++++++++++---
 drivers/usb/input/usbkbd.c    |    2 -
 include/linux/input.h         |    3 ++
 4 files changed, 50 insertions(+), 7 deletions(-)


diff -ruNp linux-2.6.16-rc5/drivers/usb/input/hid-debug.h linux-2.6.16-rc5.patched/drivers/usb/input/hid-debug.h
--- linux-2.6.16-rc5/drivers/usb/input/hid-debug.h	2006-02-27 16:09:35.000000000 +1100
+++ linux-2.6.16-rc5.patched/drivers/usb/input/hid-debug.h	2006-03-02 10:48:49.000000000 +1100
@@ -675,9 +675,10 @@ static char *keys[KEY_MAX + 1] = {
 	[KEY_SLOW] = "Slow",			[KEY_SHUFFLE] = "Shuffle",
 	[KEY_BREAK] = "Break",			[KEY_PREVIOUS] = "Previous",
 	[KEY_DIGITS] = "Digits",		[KEY_TEEN] = "TEEN",
-	[KEY_TWEN] = "TWEN",			[KEY_DEL_EOL] = "DeleteEOL",
-	[KEY_DEL_EOS] = "DeleteEOS",		[KEY_INS_LINE] = "InsertLine",
-	[KEY_DEL_LINE] = "DeleteLine",
+	[KEY_TWEN] = "TWEN",			[KEY_ZOOMPLUS] = "ZoomPlus",
+	[KEY_ZOOMMINUS] = "ZoomMinus",		[KEY_SPELL] = "Spell",
+	[KEY_DEL_EOL] = "DeleteEOL",		[KEY_DEL_EOS] = "DeleteEOS",
+	[KEY_INS_LINE] = "InsertLine",		[KEY_DEL_LINE] = "DeleteLine",
 	[KEY_SEND] = "Send",			[KEY_REPLY] = "Reply",
 	[KEY_FORWARDMAIL] = "ForwardMail",	[KEY_SAVE] = "Save",
 	[KEY_DOCUMENTS] = "Documents",
diff -ruNp linux-2.6.16-rc5/drivers/usb/input/hid-input.c linux-2.6.16-rc5.patched/drivers/usb/input/hid-input.c
--- linux-2.6.16-rc5/drivers/usb/input/hid-input.c	2006-02-27 16:09:35.000000000 +1100
+++ linux-2.6.16-rc5.patched/drivers/usb/input/hid-input.c	2006-03-02 13:47:00.000000000 +1100
@@ -51,7 +51,7 @@ static const unsigned char hid_keyboard[
 	115,114,unk,unk,unk,121,unk, 89, 93,124, 92, 94, 95,unk,unk,unk,
 	122,123, 90, 91, 85,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,
 	unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,
-	unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,
+	unk,unk,unk,unk,unk,unk,179,180,unk,unk,unk,unk,unk,unk,unk,unk,
 	unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,
 	unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,
 	 29, 42, 56,125, 97, 54,100,126,164,166,165,163,161,115,114,113,
@@ -426,12 +426,16 @@ static void hidinput_configure_usage(str
 				case 0x0e5: map_key_clear(KEY_BASSBOOST);	break;
 				case 0x0e9: map_key_clear(KEY_VOLUMEUP);	break;
 				case 0x0ea: map_key_clear(KEY_VOLUMEDOWN);	break;
+				case 0x182: map_key_clear(KEY_FAVORITES);	break;
 				case 0x183: map_key_clear(KEY_CONFIG);		break;
 				case 0x18a: map_key_clear(KEY_MAIL);		break;
 				case 0x192: map_key_clear(KEY_CALC);		break;
 				case 0x194: map_key_clear(KEY_FILE);		break;
 				case 0x1a7: map_key_clear(KEY_DOCUMENTS);	break;
+				case 0x1ab: map_key_clear(KEY_SPELL);		break;
 				case 0x201: map_key_clear(KEY_NEW);		break;
+				case 0x202: map_key_clear(KEY_OPEN);		break;
+				case 0x203: map_key_clear(KEY_CLOSE);		break;
 				case 0x207: map_key_clear(KEY_SAVE);		break;
 				case 0x208: map_key_clear(KEY_PRINT);		break;
 				case 0x209: map_key_clear(KEY_PROPS);		break;
@@ -446,6 +450,8 @@ static void hidinput_configure_usage(str
 				case 0x226: map_key_clear(KEY_STOP);		break;
 				case 0x227: map_key_clear(KEY_REFRESH);		break;
 				case 0x22a: map_key_clear(KEY_BOOKMARKS);	break;
+				case 0x22d: map_key_clear(KEY_ZOOMPLUS);	break;
+				case 0x22e: map_key_clear(KEY_ZOOMMINUS);	break;
 				case 0x233: map_key_clear(KEY_SCROLLUP);	break;
 				case 0x234: map_key_clear(KEY_SCROLLDOWN);	break;
 				case 0x238: map_rel(REL_HWHEEL);		break;
@@ -483,8 +489,23 @@ static void hidinput_configure_usage(str
 			}
 			break;
 
-		case HID_UP_MSVENDOR:
-			goto ignore;
+		case HID_UP_MSVENDOR: /* Reported on MS Natural Ergonomic 4000 USB keyboard */
+
+			set_bit(EV_REP, input->evbit);
+			switch(usage->hid & HID_USAGE) {
+				case 0xff05:
+					/* The Favourites 1-5 keys */
+					map_key_clear(KEY_FN);
+					clear_bit(KEY_FN_F1, input->keybit);
+					clear_bit(KEY_FN_F2, input->keybit);
+					clear_bit(KEY_FN_F3, input->keybit);
+					clear_bit(KEY_FN_F4, input->keybit);
+					clear_bit(KEY_FN_F5, input->keybit);
+					break;
+
+				default:    goto ignore;
+			}
+			break;
 
 		case HID_UP_CUSTOM: /* Reported on Logitech and Powerbook USB keyboards */
 
@@ -655,6 +676,24 @@ void hidinput_hid_event(struct hid_devic
 	if ((hid->quirks & HID_QUIRK_POWERBOOK_HAS_FN) && hidinput_pb_event(hid, input, usage, value))
 		return;
 
+	if (usage->hid == (HID_UP_MSVENDOR | 0xff05)) {
+		unsigned int code = 0;
+
+		switch (value) {
+			case 0x01: code = KEY_FN_F1;	break;
+			case 0x02: code = KEY_FN_F2;	break;
+			case 0x04: code = KEY_FN_F3;	break;
+			case 0x08: code = KEY_FN_F4;	break;
+			case 0x10: code = KEY_FN_F5;	break;
+			default:			break;
+		}
+		if (code) {
+			input_event(input, usage->type, code, 1);
+			input_event(input, usage->type, code, 0);
+			return;
+		}
+	}
+
 	if (usage->hat_min < usage->hat_max || usage->hat_dir) {
 		int hat_dir = usage->hat_dir;
 		if (!hat_dir)
diff -ruNp linux-2.6.16-rc5/drivers/usb/input/usbkbd.c linux-2.6.16-rc5.patched/drivers/usb/input/usbkbd.c
--- linux-2.6.16-rc5/drivers/usb/input/usbkbd.c	2006-02-27 16:09:35.000000000 +1100
+++ linux-2.6.16-rc5.patched/drivers/usb/input/usbkbd.c	2006-03-02 10:44:28.000000000 +1100
@@ -58,7 +58,7 @@ static unsigned char usb_kbd_keycode[256
 	115,114,  0,  0,  0,121,  0, 89, 93,124, 92, 94, 95,  0,  0,  0,
 	122,123, 90, 91, 85,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
 	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
-	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
+	  0,  0,  0,  0,  0,  0,179,180,  0,  0,  0,  0,  0,  0,  0,  0,
 	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
 	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
 	 29, 42, 56,125, 97, 54,100,126,164,166,165,163,161,115,114,113,
diff -ruNp linux-2.6.16-rc5/include/linux/input.h linux-2.6.16-rc5.patched/include/linux/input.h
--- linux-2.6.16-rc5/include/linux/input.h	2006-02-27 16:09:35.000000000 +1100
+++ linux-2.6.16-rc5.patched/include/linux/input.h	2006-03-02 10:15:35.000000000 +1100
@@ -484,6 +484,9 @@ struct input_absinfo {
 #define KEY_DIGITS		0x19d
 #define KEY_TEEN		0x19e
 #define KEY_TWEN		0x19f
+#define KEY_ZOOMPLUS		0x1a0
+#define KEY_ZOOMMINUS		0x1a1
+#define KEY_SPELL		0x1a2
 
 #define KEY_DEL_EOL		0x1c0
 #define KEY_DEL_EOS		0x1c1


-- 
John Zaitseff                    ,--_|\    The ZAP Group
Phone:  +61 2 9643 7737         /      \   Sydney, Australia
E-mail: J.Zaitseff@zap.org.au   \_,--._*   http://www.zap.org.au/
Finger: john@zap.org.au               v
GnuPG   fingerprint:  8FD2 8962 7768 2546 FE07  DE7C 61A8 4486 C9A6 69B0
