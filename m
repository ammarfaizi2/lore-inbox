Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261909AbUCPOmt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 09:42:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262139AbUCPOmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 09:42:04 -0500
Received: from styx.suse.cz ([82.208.2.94]:57217 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S261909AbUCPOTg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 09:19:36 -0500
Content-Transfer-Encoding: 7BIT
Message-Id: <10794467761141@twilight.ucw.cz>
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH 9/44] Support for scroll wheel on Office keyboards
X-Mailer: gregkh_patchbomb_levon_offspring
To: torvalds@osdl.org, vojtech@ucw.cz, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Date: Tue, 16 Mar 2004 15:19:36 +0100
In-Reply-To: <1079446776784@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1474.188.9, 2004-01-26 13:56:47+01:00, vojtech@suse.cz
  input: Add support for scroll wheel on MS Office and similar keyboards.


 atkbd.c |   65 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 58 insertions(+), 7 deletions(-)

===================================================================

diff -Nru a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c	Tue Mar 16 13:19:47 2004
+++ b/drivers/input/keyboard/atkbd.c	Tue Mar 16 13:19:47 2004
@@ -33,18 +33,18 @@
 MODULE_PARM(atkbd_set, "1i");
 MODULE_PARM(atkbd_reset, "1i");
 MODULE_PARM(atkbd_softrepeat, "1i");
+MODULE_PARM(atkbd_scroll, "1i");
 MODULE_LICENSE("GPL");
 
 static int atkbd_set = 2;
 module_param_named(set, atkbd_set, int, 0);
 MODULE_PARM_DESC(set, "Select keyboard code set (2 = default, 3, 4)");
+
 #if defined(__i386__) || defined(__x86_64__) || defined(__hppa__)
 static int atkbd_reset;
 #else
 static int atkbd_reset = 1;
 #endif
-static int atkbd_softrepeat;
-
 module_param_named(reset, atkbd_reset, bool, 0);
 MODULE_PARM_DESC(reset, "Reset keyboard during initialization");
 
@@ -52,6 +52,10 @@
 module_param_named(softrepeat, atkbd_softrepeat, bool, 0);
 MODULE_PARM_DESC(softrepeat, "Use software keyboard repeat");
 
+static int atkbd_scroll;
+module_parm_named(scroll, atkbd_scroll, bool, 0);
+MODULE_PARM_DESC_(scroll, "Enable scroll-wheel on office keyboards");
+
 /*
  * Scancode to keycode tables. These are just the default setting, and
  * are loadable via an userland utility.
@@ -127,11 +131,11 @@
 #define ATKBD_CMD_EX_SETLEDS	0x20eb
 #define ATKBD_CMD_OK_GETID	0x02e8
 
+
 #define ATKBD_RET_ACK		0xfa
 #define ATKBD_RET_NAK		0xfe
 #define ATKBD_RET_BAT		0xaa
 #define ATKBD_RET_EMUL0		0xe0
-#define ATKBD_RET_EMULX		0x80
 #define ATKBD_RET_EMUL1		0xe1
 #define ATKBD_RET_RELEASE	0xf0
 #define ATKBD_RET_HANGUEL	0xf1
@@ -141,6 +145,22 @@
 #define ATKBD_KEY_UNKNOWN	  0
 #define ATKBD_KEY_NULL		255
 
+#define ATKBD_SCR_1		254
+#define ATKBD_SCR_2		253
+#define ATKBD_SCR_4		252
+#define ATKBD_SCR_8		251
+#define ATKBD_SCR_CLICK		250
+
+#define ATKBD_SPECIAL		250
+
+static unsigned char atkbd_scroll_keys[5][2] = {
+	{ ATKBD_SCR_1,     0x45 },
+	{ ATKBD_SCR_2,     0x29 },
+	{ ATKBD_SCR_4,     0x36 },
+	{ ATKBD_SCR_8,     0x27 },
+	{ ATKBD_SCR_CLICK, 0x60 },
+};
+
 /*
  * The atkbd control structure
  */
@@ -189,6 +209,7 @@
 {
 	struct atkbd *atkbd = serio->private;
 	unsigned int code = data;
+	int scroll = 0, click = -1;
 	int value;
 
 #ifdef ATKBD_DEBUG
@@ -284,6 +305,21 @@
 			else
 				printk(KERN_WARNING "atkbd.c: Use 'setkeycodes %s%02x <keycode>' to make it known.\n",						code & 0x80 ? "e0" : "", code & 0x7f);
 			break;
+		case ATKBD_SCR_1:
+			scroll = 1 - atkbd->release * 2;
+			break;
+		case ATKBD_SCR_2:
+			scroll = 2 - atkbd->release * 4;
+			break;
+		case ATKBD_SCR_4:
+			scroll = 4 - atkbd->release * 8;
+			break;
+		case ATKBD_SCR_8:
+			scroll = 8 - atkbd->release * 16;
+			break;
+		case ATKBD_SCR_CLICK:
+			click = !atkbd->release;
+			break;
 		default:
 			value = atkbd->release ? 0 :
 				(1 + (!atkbd_softrepeat && test_bit(atkbd->keycode[code], atkbd->dev.key)));
@@ -305,6 +341,13 @@
 			atkbd_report_key(&atkbd->dev, regs, atkbd->keycode[code], value);
 	}
 
+	if (scroll || click != -1) {
+		input_regs(&atkbd->dev, regs);
+		input_report_key(&atkbd->dev, BTN_MIDDLE, click);
+		input_report_rel(&atkbd->dev, REL_WHEEL, scroll);
+		input_sync(&atkbd->dev);
+	}
+
 	atkbd->release = 0;
 out:
 	return IRQ_HANDLED;
@@ -705,15 +748,23 @@
 
 	sprintf(atkbd->phys, "%s/input0", serio->phys);
 
+	if (atkbd_scroll) {
+		for (i = 0; i < 5; i++)
+			atkbd_set2_keycode[atkbd_scroll_keys[i][1]] = atkbd_scroll_keys[i][0];
+		atkbd->dev.evbit[0] |= BIT(EV_REL);
+		atkbd->dev.relbit[0] = BIT(REL_WHEEL);
+		set_bit(BTN_MIDDLE, atkbd->dev.keybit);
+	}
+
 	if (atkbd->translated) {
 		for (i = 0; i < 128; i++) {
 			atkbd->keycode[i] = atkbd_set2_keycode[atkbd_unxlate_table[i]];
 			atkbd->keycode[i | 0x80] = atkbd_set2_keycode[atkbd_unxlate_table[i] | 0x80];
 		}
-	} else if (atkbd->set == 2) {
-		memcpy(atkbd->keycode, atkbd_set2_keycode, sizeof(atkbd->keycode));
-	} else {
+	} else if (atkbd->set == 3) {
 		memcpy(atkbd->keycode, atkbd_set3_keycode, sizeof(atkbd->keycode));
+	} else {
+		memcpy(atkbd->keycode, atkbd_set2_keycode, sizeof(atkbd->keycode));
 	}
 
 	atkbd->dev.name = atkbd->name;
@@ -724,7 +775,7 @@
 	atkbd->dev.id.version = atkbd->id;
 
 	for (i = 0; i < 512; i++)
-		if (atkbd->keycode[i] && atkbd->keycode[i] < 255)
+		if (atkbd->keycode[i] && atkbd->keycode[i] < ATKBD_SPECIAL)
 			set_bit(atkbd->keycode[i], atkbd->dev.keybit);
 
 	input_register_device(&atkbd->dev);

