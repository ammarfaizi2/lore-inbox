Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162249AbWKPCqt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162249AbWKPCqt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 21:46:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162248AbWKPCqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 21:46:35 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:4752 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1162243AbWKPCqQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 21:46:16 -0500
Message-Id: <20061116024710.248311000@sous-sol.org>
References: <20061116024332.124753000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Wed, 15 Nov 2006 18:43:49 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org, greg@kroah.com
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, benh@kernel.crashing.org, dtor@mail.ru,
       olh@suse.de
Subject: [patch 17/30] correct keymapping on Powerbook built-in USB ISO keyboards
Content-Disposition: inline; filename=correct-keymapping-on-powerbook-built-in-usb-iso-keyboards.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Olaf Hering <olh@suse.de>

similar to the version in adbhid_input_register(): The '<>' key and the
'^°' key on a german keyboard is swapped.  Provide correct keys to
userland, external USB keyboards will not work correctly when the
'badmap'/'goodmap' workarounds from xkeyboard-config are used.

It is expected that distributions drop the badmap/goodmap part from
keycodes/macintosh in the xkeyboard-config package.

This is probably 2.6.18.x material, if major distros settle on 2.6.18.

Signed-off-by: Olaf Hering <olh@suse.de>
Cc: Greg KH <greg@kroah.com>
Cc: Dmitry Torokhov <dtor@mail.ru>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: <stable@kernel.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
Note: still not upstream, candidate to drop.  Please advise.

 drivers/usb/input/hid-core.c  |    4 ++--
 drivers/usb/input/hid-input.c |   17 +++++++++++++++++
 drivers/usb/input/hid.h       |    1 +
 3 files changed, 20 insertions(+), 2 deletions(-)

--- linux-2.6.18.2.orig/drivers/usb/input/hid-core.c
+++ linux-2.6.18.2/drivers/usb/input/hid-core.c
@@ -1734,10 +1734,10 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_APPLE, 0x020E, HID_QUIRK_POWERBOOK_HAS_FN },
 	{ USB_VENDOR_ID_APPLE, 0x020F, HID_QUIRK_POWERBOOK_HAS_FN },
 	{ USB_VENDOR_ID_APPLE, 0x0214, HID_QUIRK_POWERBOOK_HAS_FN },
-	{ USB_VENDOR_ID_APPLE, 0x0215, HID_QUIRK_POWERBOOK_HAS_FN },
+	{ USB_VENDOR_ID_APPLE, 0x0215, HID_QUIRK_POWERBOOK_HAS_FN | HID_QUIRK_POWERBOOK_ISO_KEYBOARD},
 	{ USB_VENDOR_ID_APPLE, 0x0216, HID_QUIRK_POWERBOOK_HAS_FN },
 	{ USB_VENDOR_ID_APPLE, 0x0217, HID_QUIRK_POWERBOOK_HAS_FN },
-	{ USB_VENDOR_ID_APPLE, 0x0218, HID_QUIRK_POWERBOOK_HAS_FN },
+	{ USB_VENDOR_ID_APPLE, 0x0218, HID_QUIRK_POWERBOOK_HAS_FN | HID_QUIRK_POWERBOOK_ISO_KEYBOARD},
 	{ USB_VENDOR_ID_APPLE, 0x0219, HID_QUIRK_POWERBOOK_HAS_FN },
 	{ USB_VENDOR_ID_APPLE, 0x030A, HID_QUIRK_POWERBOOK_HAS_FN },
 	{ USB_VENDOR_ID_APPLE, 0x030B, HID_QUIRK_POWERBOOK_HAS_FN },
--- linux-2.6.18.2.orig/drivers/usb/input/hid-input.c
+++ linux-2.6.18.2/drivers/usb/input/hid-input.c
@@ -123,6 +123,12 @@ static struct hidinput_key_translation p
 	{ }
 };
 
+static struct hidinput_key_translation powerbook_iso_keyboard[] = {
+	{ KEY_GRAVE,    KEY_102ND },
+	{ KEY_102ND,    KEY_GRAVE },
+	{ }
+};
+
 static int usbhid_pb_fnmode = 1;
 module_param_named(pb_fnmode, usbhid_pb_fnmode, int, 0644);
 MODULE_PARM_DESC(pb_fnmode,
@@ -197,6 +203,14 @@ static int hidinput_pb_event(struct hid_
 		}
 	}
 
+	if (hid->quirks & HID_QUIRK_POWERBOOK_ISO_KEYBOARD) {
+		trans = find_translation(powerbook_iso_keyboard, usage->code);
+		if (trans) {
+			input_event(input, usage->type, trans->to, value);
+			return 1;
+		}
+	}
+
 	return 0;
 }
 
@@ -212,6 +226,9 @@ static void hidinput_pb_setup(struct inp
 
 	for (trans = powerbook_numlock_keys; trans->from; trans++)
 		set_bit(trans->to, input->keybit);
+
+	for (trans = powerbook_iso_keyboard; trans->from; trans++)
+		set_bit(trans->to, input->keybit);
 }
 #else
 static inline int hidinput_pb_event(struct hid_device *hid, struct input_dev *input,
--- linux-2.6.18.2.orig/drivers/usb/input/hid.h
+++ linux-2.6.18.2/drivers/usb/input/hid.h
@@ -260,6 +260,7 @@ struct hid_item {
 #define HID_QUIRK_POWERBOOK_HAS_FN		0x00001000
 #define HID_QUIRK_POWERBOOK_FN_ON		0x00002000
 #define HID_QUIRK_INVERT_HWHEEL			0x00004000
+#define HID_QUIRK_POWERBOOK_ISO_KEYBOARD	0x00010000
 
 /*
  * This is the global environment of the parser. This information is

--
