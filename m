Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262130AbUCPPtK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 10:49:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262131AbUCPOhy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 09:37:54 -0500
Received: from styx.suse.cz ([82.208.2.94]:57985 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S261912AbUCPOTo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 09:19:44 -0500
Content-Transfer-Encoding: 7BIT
Message-Id: <10794467761075@twilight.ucw.cz>
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH 11/44] Convert HP/PARISC Lasi/Dino PS/2 driver to a serio driver
X-Mailer: gregkh_patchbomb_levon_offspring
To: torvalds@osdl.org, vojtech@ucw.cz, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Date: Tue, 16 Mar 2004 15:19:36 +0100
In-Reply-To: <10794467762870@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1474.188.11, 2004-01-26 13:59:12+01:00, deller@gmx.de
  input: Convert HP/PARISC Lasi/Dino PS/2 keyboard/mouse driver
         from an input driver to a serio driver.


 b/drivers/input/keyboard/Kconfig      |    1 
 b/drivers/input/keyboard/hpps2atkbd.h |  178 ++++----
 b/drivers/input/misc/Kconfig          |    9 
 b/drivers/input/misc/Makefile         |    1 
 b/drivers/input/mouse/Kconfig         |    1 
 b/drivers/input/serio/Kconfig         |   16 
 b/drivers/input/serio/Makefile        |    1 
 b/drivers/input/serio/gscps2.c        |  470 ++++++++++++++++++++++
 drivers/input/misc/gsc_ps2.c          |  712 ----------------------------------
 9 files changed, 582 insertions(+), 807 deletions(-)

===================================================================

diff -Nru a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
--- a/drivers/input/keyboard/Kconfig	Tue Mar 16 13:19:39 2004
+++ b/drivers/input/keyboard/Kconfig	Tue Mar 16 13:19:39 2004
@@ -17,6 +17,7 @@
 	depends on INPUT && INPUT_KEYBOARD
 	select SERIO
 	select SERIO_I8042 if PC
+	select SERIO_GSCPS2 if GSC
 	help
 	  Say Y here if you want to use a standard AT or PS/2 keyboard. Usually
 	  you'll need this, unless you have a different type keyboard (USB, ADB
diff -Nru a/drivers/input/keyboard/hpps2atkbd.h b/drivers/input/keyboard/hpps2atkbd.h
--- a/drivers/input/keyboard/hpps2atkbd.h	Tue Mar 16 13:19:39 2004
+++ b/drivers/input/keyboard/hpps2atkbd.h	Tue Mar 16 13:19:39 2004
@@ -4,14 +4,9 @@
  * Copyright (c) 2004 Helge Deller <deller@gmx.de>
  * Copyright (c) 2002 Laurent Canet <canetl@esiee.fr>
  * Copyright (c) 2002 Thibaut Varene <varenet@esiee.fr>
+ * Copyright (c) 2000 Xavier Debacker <debackex@esiee.fr>
  *
- * based on linux-2.4's hp_mouse.c & hp_keyb.c
- * 	Copyright (c) 1999 Alex deVries <adevries@thepuffingroup.com>
- *	Copyright (c) 1999-2000 Philipp Rumpf <prumpf@tux.org>
- *	Copyright (c) 2000 Xavier Debacker <debackex@esiee.fr>
- *	Copyright (c) 2000-2001 Thomas Marteau <marteaut@esiee.fr>
- *
- * HP PS/2 AT-compatible Keyboard, found in PA/RISC Workstations
+ * HP PS/2 AT-compatible Keyboard, found in PA/RISC Workstations & Laptops
  *
  * This file is subject to the terms and conditions of the GNU General Public
  * License.  See the file "COPYING" in the main directory of this archive
@@ -19,87 +14,100 @@
  */
 
 
-#define KBD_UNKNOWN 0
-
-/* Raw SET 2 scancode table */
+/* undefine if you have a RDI PRECISIONBOOK */
+#define STANDARD_KEYBOARD
 
-#if 0
-	/* conflicting keys between a RDI Precisionbook keyboard and a normal HP keyboard */
-        keytable[0x07] = KEY_F1;        /* KEY_F12      */
-        keytable[0x11] = KEY_LEFTCTRL;  /* KEY_LEFTALT  */
-        keytable[0x14] = KEY_CAPSLOCK;  /* KEY_LEFTCTRL */
-        keytable[0x61] = KEY_LEFT;      /* KEY_102ND    */
+#if defined(STANDARD_KEYBOARD)
+# define CONFLICT(x,y) x
+#else
+# define CONFLICT(x,y) y
 #endif
 
+/* sadly RDI (Tadpole) decided to ship a different keyboard layout
+   than HP for their PS/2 laptop keyboard which leads to conflicting
+   keycodes between a normal HP PS/2 keyboard and a RDI Precisionbook.
+                                HP:		RDI:            */
+#define C_07	CONFLICT(	KEY_F12,	KEY_F1		)
+#define C_11	CONFLICT(	KEY_LEFTALT,	KEY_LEFTCTRL	)
+#define C_14	CONFLICT(	KEY_LEFTCTRL,	KEY_CAPSLOCK	)
+#define C_58	CONFLICT(	KEY_CAPSLOCK,	KEY_RIGHTCTRL	)
+#define C_61	CONFLICT(	KEY_102ND,	KEY_LEFT	)
 
-static unsigned char atkbd_set2_keycode[512] = {
+/* Raw SET 2 scancode table */
 
-	/* 00 */  KBD_UNKNOWN,  KEY_F9,        KBD_UNKNOWN,   KEY_F5,        KEY_F3,        KEY_F1,       KEY_F2,        KEY_F1,
-	/* 08 */  KEY_ESC,      KEY_F10,       KEY_F8,        KEY_F6,        KEY_F4,        KEY_TAB,      KEY_GRAVE,     KEY_F2,
-	/* 10 */  KBD_UNKNOWN,  KEY_LEFTCTRL,  KEY_LEFTSHIFT, KBD_UNKNOWN,   KEY_CAPSLOCK,  KEY_Q,        KEY_1,         KEY_F3,
-	/* 18 */  KBD_UNKNOWN,  KEY_LEFTALT,   KEY_Z,         KEY_S,         KEY_A,         KEY_W,        KEY_2,         KEY_F4,
-	/* 20 */  KBD_UNKNOWN,  KEY_C,         KEY_X,         KEY_D,         KEY_E,         KEY_4,        KEY_3,         KEY_F5,
-	/* 28 */  KBD_UNKNOWN,  KEY_SPACE,     KEY_V,         KEY_F,         KEY_T,         KEY_R,        KEY_5,         KEY_F6,
-	/* 30 */  KBD_UNKNOWN,  KEY_N,         KEY_B,         KEY_H,         KEY_G,         KEY_Y,        KEY_6,         KEY_F7,
-	/* 38 */  KBD_UNKNOWN,  KEY_RIGHTALT,  KEY_M,         KEY_J,         KEY_U,         KEY_7,        KEY_8,         KEY_F8,
-	/* 40 */  KBD_UNKNOWN,  KEY_COMMA,     KEY_K,         KEY_I,         KEY_O,         KEY_0,        KEY_9,         KEY_F9,
-	/* 48 */  KBD_UNKNOWN,  KEY_DOT,       KEY_SLASH,     KEY_L,         KEY_SEMICOLON, KEY_P,        KEY_MINUS,     KEY_F10,
-	/* 50 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KEY_APOSTROPHE,KBD_UNKNOWN,   KEY_LEFTBRACE, KEY_EQUAL,    KEY_F11,       KEY_SYSRQ,
-	/* 58 */  KEY_CAPSLOCK, KEY_RIGHTSHIFT,KEY_ENTER,     KEY_RIGHTBRACE,KEY_BACKSLASH, KEY_BACKSLASH,KEY_F12,       KEY_SCROLLLOCK,
-	/* 60 */  KEY_DOWN,     KEY_LEFT,      KEY_PAUSE,     KEY_UP,        KEY_DELETE,    KEY_END,      KEY_BACKSPACE, KEY_INSERT,
-	/* 68 */  KBD_UNKNOWN,  KEY_KP1,       KEY_RIGHT,     KEY_KP4,       KEY_KP7,       KEY_PAGEDOWN, KEY_HOME,      KEY_PAGEUP,
-	/* 70 */  KEY_KP0,      KEY_KPDOT,     KEY_KP2,       KEY_KP5,       KEY_KP6,       KEY_KP8,      KEY_ESC,       KEY_NUMLOCK,
-	/* 78 */  KEY_F11,      KEY_KPPLUS,    KEY_KP3,       KEY_KPMINUS,   KEY_KPASTERISK,KEY_KP9,      KEY_SCROLLLOCK,KEY_103RD,
-	/* 80 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* 88 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* 90 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* 98 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* a0 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* a8 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* b0 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* b8 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* c0 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* c8 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* d0 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* d8 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* e0 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* e8 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* f0 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* f8 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-
-	/* These are offset for escaped keycodes: */
-
-	/* 00 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,   KEY_F7,        KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* 08 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,   KEY_LEFTMETA,  KEY_RIGHTMETA, KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* 10 */  KBD_UNKNOWN,  KEY_RIGHTALT,  KBD_UNKNOWN,   KBD_UNKNOWN,   KEY_RIGHTCTRL, KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* 18 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* 20 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* 28 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* 30 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* 38 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* 40 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* 48 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KEY_KPSLASH,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* 50 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* 58 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KEY_KPENTER,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* 60 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* 68 */  KBD_UNKNOWN,  KEY_END,       KBD_UNKNOWN,   KEY_LEFT,      KEY_HOME,      KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* 70 */  KEY_INSERT,   KEY_DELETE,    KEY_DOWN,      KBD_UNKNOWN,   KEY_RIGHT,     KEY_UP,       KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* 78 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KEY_PAGEDOWN,  KBD_UNKNOWN,   KEY_SYSRQ,     KEY_PAGEUP,   KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* 80 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* 88 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* 90 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* 98 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* a0 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* a8 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* b0 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* b8 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* c0 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* c8 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* d0 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* d8 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* e0 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* e8 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* f0 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* f8 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN
+/* 00 */  KEY_RESERVED, KEY_F9,        KEY_RESERVED,  KEY_F5,        KEY_F3,        KEY_F1,       KEY_F2,        C_07,
+/* 08 */  KEY_ESC,      KEY_F10,       KEY_F8,        KEY_F6,        KEY_F4,        KEY_TAB,      KEY_GRAVE,     KEY_F2,
+/* 10 */  KEY_RESERVED, C_11,          KEY_LEFTSHIFT, KEY_RESERVED,  C_14,          KEY_Q,        KEY_1,         KEY_F3,
+/* 18 */  KEY_RESERVED, KEY_LEFTALT,   KEY_Z,         KEY_S,         KEY_A,         KEY_W,        KEY_2,         KEY_F4,
+/* 20 */  KEY_RESERVED, KEY_C,         KEY_X,         KEY_D,         KEY_E,         KEY_4,        KEY_3,         KEY_F5,
+/* 28 */  KEY_RESERVED, KEY_SPACE,     KEY_V,         KEY_F,         KEY_T,         KEY_R,        KEY_5,         KEY_F6,
+/* 30 */  KEY_RESERVED, KEY_N,         KEY_B,         KEY_H,         KEY_G,         KEY_Y,        KEY_6,         KEY_F7,
+/* 38 */  KEY_RESERVED, KEY_RIGHTALT,  KEY_M,         KEY_J,         KEY_U,         KEY_7,        KEY_8,         KEY_F8,
+/* 40 */  KEY_RESERVED, KEY_COMMA,     KEY_K,         KEY_I,         KEY_O,         KEY_0,        KEY_9,         KEY_F9,
+/* 48 */  KEY_RESERVED, KEY_DOT,       KEY_SLASH,     KEY_L,         KEY_SEMICOLON, KEY_P,        KEY_MINUS,     KEY_F10,
+/* 50 */  KEY_RESERVED, KEY_RESERVED,  KEY_APOSTROPHE,KEY_RESERVED,  KEY_LEFTBRACE, KEY_EQUAL,    KEY_F11,       KEY_SYSRQ,
+/* 58 */  C_58,         KEY_RIGHTSHIFT,KEY_ENTER,     KEY_RIGHTBRACE,KEY_BACKSLASH, KEY_BACKSLASH,KEY_F12,       KEY_SCROLLLOCK,
+/* 60 */  KEY_DOWN,     C_61,          KEY_PAUSE,     KEY_UP,        KEY_DELETE,    KEY_END,      KEY_BACKSPACE, KEY_INSERT,
+/* 68 */  KEY_RESERVED, KEY_KP1,       KEY_RIGHT,     KEY_KP4,       KEY_KP7,       KEY_PAGEDOWN, KEY_HOME,      KEY_PAGEUP,
+/* 70 */  KEY_KP0,      KEY_KPDOT,     KEY_KP2,       KEY_KP5,       KEY_KP6,       KEY_KP8,      KEY_ESC,       KEY_NUMLOCK,
+/* 78 */  KEY_F11,      KEY_KPPLUS,    KEY_KP3,       KEY_KPMINUS,   KEY_KPASTERISK,KEY_KP9,      KEY_SCROLLLOCK,KEY_103RD,
+/* 80 */  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
+/* 88 */  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
+/* 90 */  KEY_RESERVED, KEY_RIGHTALT,  KEY_SYSRQ,     KEY_RESERVED,  KEY_RIGHTCTRL, KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
+/* 98 */  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_CAPSLOCK, KEY_RESERVED,  KEY_LEFTMETA,
+/* a0 */  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED, KEY_RESERVED,  KEY_RIGHTMETA,
+/* a8 */  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED, KEY_RESERVED,  KEY_COMPOSE,
+/* b0 */  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
+/* b8 */  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
+/* c0 */  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
+/* c8 */  KEY_RESERVED, KEY_RESERVED,  KEY_KPSLASH,   KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
+/* d0 */  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
+/* d8 */  KEY_RESERVED, KEY_RESERVED,  KEY_KPENTER,   KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
+/* e0 */  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
+/* e8 */  KEY_RESERVED, KEY_END,       KEY_RESERVED,  KEY_LEFT,      KEY_HOME,      KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
+/* f0 */  KEY_INSERT,   KEY_DELETE,    KEY_DOWN,      KEY_RESERVED,  KEY_RIGHT,     KEY_UP,       KEY_RESERVED,  KEY_PAUSE,
+/* f8 */  KEY_RESERVED, KEY_RESERVED,  KEY_PAGEDOWN,  KEY_RESERVED,  KEY_SYSRQ,     KEY_PAGEUP,   KEY_RESERVED,  KEY_RESERVED,
+
+/* These are offset for escaped keycodes: */
+
+/* 00 */  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,  KEY_F7,        KEY_RESERVED,  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
+/* 08 */  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,  KEY_LEFTMETA,  KEY_RIGHTMETA, KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
+/* 10 */  KEY_RESERVED, KEY_RIGHTALT,  KEY_RESERVED,  KEY_RESERVED,  KEY_RIGHTCTRL, KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
+/* 18 */  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
+/* 20 */  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
+/* 28 */  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
+/* 30 */  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
+/* 38 */  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
+/* 40 */  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
+/* 48 */  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
+/* 50 */  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
+/* 58 */  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
+/* 60 */  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
+/* 68 */  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
+/* 70 */  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
+/* 78 */  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
+/* 80 */  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
+/* 88 */  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
+/* 90 */  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
+/* 98 */  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
+/* a0 */  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
+/* a8 */  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
+/* b0 */  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
+/* b8 */  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
+/* c0 */  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
+/* c8 */  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
+/* d0 */  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
+/* d8 */  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
+/* e0 */  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
+/* e8 */  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
+/* f0 */  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,
+/* f8 */  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED,  KEY_RESERVED, KEY_RESERVED,  KEY_RESERVED
+
+#undef STANDARD_KEYBOARD
+#undef CONFLICT
+#undef C_07
+#undef C_11
+#undef C_14
+#undef C_58
+#undef C_61
 
-};
diff -Nru a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
--- a/drivers/input/misc/Kconfig	Tue Mar 16 13:19:39 2004
+++ b/drivers/input/misc/Kconfig	Tue Mar 16 13:19:39 2004
@@ -54,12 +54,3 @@
 	  To compile this driver as a module, choose M here: the
 	  module will be called uinput.
 
-config INPUT_GSC
-	tristate "PA-RISC GSC PS/2 keyboard/mouse support"
-	depends on GSC && INPUT && INPUT_MISC
-	help
-	  Say Y here if you have a PS/2 keyboard and/or mouse attached
-	  to your PA-RISC box.	HP run the keyboard in AT mode rather than
-	  XT mode like everyone else, so we need our own driver.
-	  Furthermore, the GSC PS/2 controller shares IRQ between mouse and
-	  keyboard.
diff -Nru a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
--- a/drivers/input/misc/Makefile	Tue Mar 16 13:19:39 2004
+++ b/drivers/input/misc/Makefile	Tue Mar 16 13:19:39 2004
@@ -9,4 +9,3 @@
 obj-$(CONFIG_INPUT_M68K_BEEP)		+= m68kspkr.o
 obj-$(CONFIG_INPUT_98SPKR)		+= 98spkr.o
 obj-$(CONFIG_INPUT_UINPUT)		+= uinput.o
-obj-$(CONFIG_INPUT_GSC)			+= gsc_ps2.o
diff -Nru a/drivers/input/misc/gsc_ps2.c b/drivers/input/misc/gsc_ps2.c
--- a/drivers/input/misc/gsc_ps2.c	Tue Mar 16 13:19:39 2004
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,712 +0,0 @@
-/*
- * drivers/input/misc/gsc_ps2.c
- *
- * Copyright (c) 2002 Laurent Canet <canetl@esiee.fr>
- * Copyright (c) 2002 Thibaut Varene <varenet@esiee.fr>
- *
- * Pieces of code based on linux-2.4's hp_mouse.c & hp_keyb.c
- * 	Copyright (c) 1999 Alex deVries <adevries@thepuffingroup.com>
- *	Copyright (c) 1999-2000 Philipp Rumpf <prumpf@tux.org>
- *	Copyright (c) 2000 Xavier Debacker <debackex@esiee.fr>
- *	Copyright (c) 2000-2001 Thomas Marteau <marteaut@esiee.fr>
- *
- * HP PS/2 Keyboard, found in PA/RISC Workstations
- * very similar to AT keyboards, but without i8042
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2, or (at your option)
- * any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- * 
- * STATUS:
- * 11/09: lc: Only basic keyboard is supported, mouse still needs to be done.
- * 11/12: tv: switching iomapping; cleaning code; improving module stuff.
- * 11/13: lc & tv: leds aren't working. auto_repeat/meta are. Generaly good behavior.
- * 11/15: tv: 2AM: leds ARE working !
- * 11/16: tv: 3AM: escaped keycodes emulation *handled*, some keycodes are
- *	  still deliberately ignored (18), what are they used for ?
- * 11/21: lc: mouse is now working
- * 11/29: tv: first try for error handling in init sequence
- *
- * TODO:
- * Error handling in init sequence
- * SysRq handling
- * Pause key handling
- * Intellimouse & other rodents handling (at least send an error when
- * such a mouse is plugged : it will totally fault)
- * Mouse: set scaling / Dino testing
- * Bug chasing...
- *
- */
-
-#include <linux/input.h>
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/ptrace.h>       /* interrupt.h wants struct pt_regs defined */
-#include <linux/interrupt.h>
-#include <linux/sched.h>        /* for request_irq/free_irq */        
-#include <linux/spinlock.h>
-#include <linux/delay.h>
-#include <linux/ioport.h>
-#include <linux/kd.h>
-#include <linux/pci_ids.h>
-
-#include <asm/irq.h>
-#include <asm/io.h>
-#include <asm/parisc-device.h>
-
-/* Debugging stuff */
-#undef KBD_DEBUG
-#ifdef KBD_DEBUG
-	#define DPRINTK(fmt,args...) printk(KERN_DEBUG __FILE__ ":" fmt, ##args)
-#else 
-	#define DPRINTK(x,...)
-#endif
-
-
-/* 
- * Driver constants
- */
-
-/* PS/2 keyboard and mouse constants */
-#define AUX_RECONNECT		0xAA	/* PS/2 Mouse end of test successful */
-#define AUX_REPLY_ACK		0xFA
-#define AUX_ENABLE_DEV		0xF4	/* Enables aux device */
-
-/* Order of the mouse bytes coming to the host */
-#define PACKET_X		1
-#define PACKET_Y		2
-#define PACKET_CTRL		0
-
-#define GSC_MOUSE_OFFSET	0x0100	/* offset from keyboard to mouse port */
-#define GSC_DINO_OFFSET		0x800	/* offset for DINO controller versus LASI one */
-
-#define GSC_ID			0x00	/* ID and reset port offsets */
-#define GSC_RESET		0x00
-#define GSC_RCVDATA		0x04	/* receive and transmit port offsets */
-#define GSC_XMTDATA		0x04
-#define GSC_CONTROL		0x08	/* see: control register bits */
-#define GSC_STATUS		0x0C	/* see: status register bits */
-
-/* Control register bits */
-#define GSC_CTRL_ENBL		0x01	/* enable interface */
-#define GSC_CTRL_LPBXR		0x02	/* loopback operation */
-#define GSC_CTRL_DIAG		0x20	/* directly control clock/data line */
-#define GSC_CTRL_DATDIR		0x40	/* data line direct control */
-#define GSC_CTRL_CLKDIR		0x80	/* clock line direct control */
-
-/* Status register bits */
-#define GSC_STAT_RBNE		0x01	/* Receive Buffer Not Empty */
-#define GSC_STAT_TBNE		0x02	/* Transmit Buffer Not Empty */
-#define GSC_STAT_TERR		0x04	/* Timeout Error */
-#define GSC_STAT_PERR		0x08	/* Parity Error */
-#define GSC_STAT_CMPINTR	0x10	/* Composite Interrupt */
-#define GSC_STAT_DATSHD		0x40	/* Data Line Shadow */
-#define GSC_STAT_CLKSHD		0x80	/* Clock Line Shadow */
-
-/* Keycode map */
-#define KBD_ESCAPE0		0xe0
-#define KBD_ESCAPE1		0xe1
-#define KBD_RELEASE		0xf0
-#define KBD_ACK			0xfa
-#define KBD_RESEND		0xfe
-#define KBD_UNKNOWN		0
-
-#define KBD_TBLSIZE		512
-
-/* Mouse */
-#define MOUSE_LEFTBTN		0x1
-#define MOUSE_MIDBTN		0x4
-#define MOUSE_RIGHTBTN		0x2
-#define MOUSE_ALWAYS1		0x8
-#define MOUSE_XSIGN		0x10
-#define MOUSE_YSIGN		0x20
-#define MOUSE_XOVFLOW		0x40
-#define MOUSE_YOVFLOW		0x80
-
-/* Remnant of pc_keyb.h */
-#define KBD_CMD_SET_LEDS	0xED	/* Sets keyboard leds */
-#define KBD_CMD_SET_RATE	0xF3	/* Sets typematic rate */
-#define KBD_CMD_ENABLE		0xF4	/* Enables scanning */
-#define KBD_CMD_DISABLE		0xF5
-#define KBD_CMD_RESET		0xFF
-
-static unsigned char hpkeyb_keycode[KBD_TBLSIZE] =
-{
-	/* 00 */  KBD_UNKNOWN,  KEY_F9,        KBD_UNKNOWN,   KEY_F5,        KEY_F3,        KEY_F1,       KEY_F2,        KEY_F12,
-	/* 08 */  KBD_UNKNOWN,  KEY_F10,       KEY_F8,        KEY_F6,        KEY_F4,        KEY_TAB,      KEY_GRAVE,     KBD_UNKNOWN,
-	/* 10 */  KBD_UNKNOWN,  KEY_LEFTALT,   KEY_LEFTSHIFT, KBD_UNKNOWN,   KEY_LEFTCTRL,  KEY_Q,        KEY_1,         KBD_UNKNOWN,
-	/* 18 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KEY_Z,         KEY_S,         KEY_A,         KEY_W,        KEY_2,         KBD_UNKNOWN,
-	/* 20 */  KBD_UNKNOWN,  KEY_C,         KEY_X,         KEY_D,         KEY_E,         KEY_4,        KEY_3,         KBD_UNKNOWN,
-	/* 28 */  KBD_UNKNOWN,  KEY_SPACE,     KEY_V,         KEY_F,         KEY_T,         KEY_R,        KEY_5,         KBD_UNKNOWN,
-	/* 30 */  KBD_UNKNOWN,  KEY_N,         KEY_B,         KEY_H,         KEY_G,         KEY_Y,        KEY_6,         KBD_UNKNOWN,
-	/* 38 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KEY_M,         KEY_J,         KEY_U,         KEY_7,        KEY_8,         KBD_UNKNOWN,
-	/* 40 */  KBD_UNKNOWN,  KEY_COMMA,     KEY_K,         KEY_I,         KEY_O,         KEY_0,        KEY_9,         KBD_UNKNOWN,
-	/* 48 */  KBD_UNKNOWN,  KEY_DOT,       KEY_SLASH,     KEY_L,         KEY_SEMICOLON, KEY_P,        KEY_MINUS,     KBD_UNKNOWN,
-	/* 50 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KEY_APOSTROPHE,KBD_UNKNOWN,   KEY_LEFTBRACE, KEY_EQUAL,    KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* 58 */  KEY_CAPSLOCK, KEY_RIGHTSHIFT,KEY_ENTER,     KEY_RIGHTBRACE,KBD_UNKNOWN,   KEY_BACKSLASH,KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* 60 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KEY_BACKSPACE, KBD_UNKNOWN,
-	/* 68 */  KBD_UNKNOWN,  KEY_KP1,       KBD_UNKNOWN,   KEY_KP4,       KEY_KP7,       KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* 70 */  KEY_KP0,      KEY_KPDOT,     KEY_KP2,       KEY_KP5,       KEY_KP6,       KEY_KP8,      KEY_ESC,       KEY_NUMLOCK,
-	/* 78 */  KEY_F11,      KEY_KPPLUS,    KEY_KP3,       KEY_KPMINUS,   KEY_KPASTERISK,KEY_KP9,      KEY_SCROLLLOCK,KEY_103RD,
-	/* 80 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,   KEY_F7,        KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* 88 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* 90 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* 98 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* a0 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* a8 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* b0 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* b8 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* c0 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* c8 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* d0 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* d8 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* e0 */  KBD_ESCAPE0,  KBD_ESCAPE1,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* e8 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* f0 */  KBD_RELEASE,  KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* f8 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_ACK,       KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_RESEND,    KBD_UNKNOWN,
-/* These are offset for escaped keycodes */
-	/* 00 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* 08 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* 10 */  KBD_UNKNOWN,  KEY_RIGHTALT,  KBD_UNKNOWN,   KBD_UNKNOWN,   KEY_RIGHTCTRL, KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* 18 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* 20 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* 28 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* 30 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* 38 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* 40 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* 48 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KEY_KPSLASH,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* 50 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* 58 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KEY_KPENTER,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* 60 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* 68 */  KBD_UNKNOWN,  KEY_END,       KBD_UNKNOWN,   KEY_LEFT,      KEY_HOME,      KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* 70 */  KEY_INSERT,   KEY_DELETE,    KEY_DOWN,      KBD_UNKNOWN,   KEY_RIGHT,     KEY_UP,       KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* 78 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KEY_PAGEDOWN,  KBD_UNKNOWN,   KEY_SYSRQ,     KEY_PAGEUP,   KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* 80 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* 88 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* 90 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* 98 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* a0 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* a8 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* b0 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* b8 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* c0 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* c8 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* d0 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* d8 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* e0 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* e8 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* f0 */  KBD_RELEASE,  KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,
-	/* f8 */  KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,   KBD_UNKNOWN,  KBD_UNKNOWN,   KBD_UNKNOWN
-};
-
-
-/* Keyboard struct */
-static struct {
-	struct input_dev dev;
-	char * addr;
-	unsigned int irq;
-	unsigned int scancode;
-	unsigned int escaped;
-	unsigned int released;
-	unsigned int initialized;
-}
-hpkeyb = {
-	.escaped = 0,
-	.released = 0,
-	.initialized = 0
-};
-
-/* Mouse struct */
-static struct {
-   	struct input_dev dev;
-	char * addr;
-	unsigned long irq;
-	unsigned long initialized;
-	int nbread;
-	unsigned char bytes[3];
-	unsigned long last;
-}
-hpmouse = {
-	.initialized = 0,
-	.nbread = 0
-};
-
-static spinlock_t gscps2_lock = SPIN_LOCK_UNLOCKED;
-
-
-/*
- * Various HW level routines
- */
-
-#define gscps2_readb_input(x)		readb(x+GSC_RCVDATA)
-#define gscps2_readb_control(x)		readb(x+GSC_CONTROL)
-#define gscps2_readb_status(x)		readb(x+GSC_STATUS)
-#define gscps2_writeb_control(x, y)	writeb(x, y+GSC_CONTROL)
-
-static inline void gscps2_writeb_output(u8 val, char * addr)
-{
-	int wait = 250;			/* Keyboard is expected to react within 250ms */
-
-	while (gscps2_readb_status(addr) & GSC_STAT_TBNE) {
-		if (!--wait)
-			return;		/* This should not happen */
-		mdelay(1);
-	}
-	writeb(val, addr+GSC_XMTDATA);
-}
-
-static inline unsigned char gscps2_wait_input(char * addr)
-{
-	int wait = 250;			/* Keyboard is expected to react within 250ms */
-
-	while (!(gscps2_readb_status(addr) & GSC_STAT_RBNE)) {
-		if (!--wait)
-			return 0;	/* This should not happen */
-		mdelay(1);
-	}
-	return gscps2_readb_input(addr);
-}
-
-static int gscps2_writeb_safe_output(u8 val)
-{
-	/* This function waits for keyboard's ACK */
-	u8 scanread = KBD_UNKNOWN;
-	int loop = 5;
-	
-	while (hpkeyb_keycode[scanread]!=KBD_ACK && --loop > 0) {	
-		gscps2_writeb_output(val, hpkeyb.addr);
-		mdelay(5);
-		scanread = gscps2_wait_input(hpkeyb.addr);
-	}
-	
-	if (loop <= 0)
-		return -1;
-	
-	return 0;
-}
-
-/* Reset the PS2 port */
-static void __init gscps2_reset(char * addr)
-{
-	/* reset the interface */
-	writeb(0xff, addr+GSC_RESET);
-	writeb(0x0 , addr+GSC_RESET);
-
-	/* enable it */
-	gscps2_writeb_control(gscps2_readb_control(addr) | GSC_CTRL_ENBL, addr);
-}
-
-
-/**
- * gscps2_kbd_docode() - PS2 Keyboard basic handler
- *
- * Receives a keyboard scancode, analyses it and sends it to the input layer.
- */
-
-static void gscps2_kbd_docode(struct pt_regs *regs)
-{
-	int scancode = gscps2_readb_input(hpkeyb.addr);
-	DPRINTK("rel=%d scancode=%d, esc=%d ", hpkeyb.released, scancode, hpkeyb.escaped);
-
-	/* Handle previously escaped scancodes */
-	if (hpkeyb.escaped == KBD_ESCAPE0)
-		scancode |= 0x100;	/* jump to the next 256 chars of the table */
-		
-	switch (hpkeyb_keycode[scancode]) {
-		case KBD_RELEASE:
-			DPRINTK("release\n");
-			hpkeyb.released = 1;
-			break;
-		case KBD_RESEND:
-			DPRINTK("resend request\n");
-			break;
-		case KBD_ACK:
-			DPRINTK("ACK\n");
-			break;
-		case KBD_ESCAPE0:
-		case KBD_ESCAPE1:
-			DPRINTK("escape code %d\n", hpkeyb_keycode[scancode]);
-			hpkeyb.escaped = hpkeyb_keycode[scancode];
-			break;
-		case KBD_UNKNOWN:
-			DPRINTK("received unknown scancode %d, escape %d.\n",
-				scancode, hpkeyb.escaped);	/* This is a DPRINTK atm since we do not handle escaped scancodes cleanly */
-			if (hpkeyb.escaped)
-			hpkeyb.escaped = 0;
-			if (hpkeyb.released)
-				hpkeyb.released = 0;
-			return;
-		default:
-			hpkeyb.scancode = scancode;
-			DPRINTK("sent=%d, rel=%d\n",hpkeyb.scancode, hpkeyb.released);
-			/*input_regs(regs);*/
-			input_report_key(&hpkeyb.dev, hpkeyb_keycode[hpkeyb.scancode], !hpkeyb.released);
-			input_sync(&hpkeyb.dev);
-			if (hpkeyb.escaped)
-				hpkeyb.escaped = 0;
-			if (hpkeyb.released) 
-				hpkeyb.released = 0;
-			break;	
-	}
-}
-
-
-/**
- * gscps2_mouse_docode() - PS2 Mouse basic handler
- *
- * Receives mouse codes, processes them by packets of three, and sends
- * correct events to the input layer.
- */
-
-static void gscps2_mouse_docode(struct pt_regs *regs)
-{
-	int xrel, yrel;
-
-	/* process BAT (end of basic tests) command */
-	if ((hpmouse.nbread == 1) && (hpmouse.bytes[0] == AUX_RECONNECT))
-		hpmouse.nbread--;
-
-	/* stolen from psmouse.c */
-	if (hpmouse.nbread && time_after(jiffies, hpmouse.last + HZ/2)) {
-		printk(KERN_DEBUG "%s:%d : Lost mouse synchronization, throwing %d bytes away.\n", __FILE__, __LINE__,
-				hpmouse.nbread);
-		hpmouse.nbread = 0;
-	}
-
-	hpmouse.last = jiffies;
-	hpmouse.bytes[hpmouse.nbread++] = gscps2_readb_input(hpmouse.addr);
-	
-	/* process packet */
-	if (hpmouse.nbread == 3) {
-		
-		if (!(hpmouse.bytes[PACKET_CTRL] & MOUSE_ALWAYS1))
-			DPRINTK("Mouse: error on packet always1 bit checking\n");
-			/* XXX should exit now, bad data on the line! */
-		
-		if ((hpmouse.bytes[PACKET_CTRL] & (MOUSE_XOVFLOW | MOUSE_YOVFLOW)))
-			DPRINTK("Mouse: position overflow\n");
-		
-		/*input_regs(regs);*/
-
-		input_report_key(&hpmouse.dev, BTN_LEFT, hpmouse.bytes[PACKET_CTRL] & MOUSE_LEFTBTN);
-		input_report_key(&hpmouse.dev, BTN_MIDDLE, hpmouse.bytes[PACKET_CTRL] & MOUSE_MIDBTN);
-		input_report_key(&hpmouse.dev, BTN_RIGHT, hpmouse.bytes[PACKET_CTRL] & MOUSE_RIGHTBTN);
-		
-		xrel = hpmouse.bytes[PACKET_X];
-		yrel = hpmouse.bytes[PACKET_Y];
-		
-		/* Data sent by mouse are 9-bit signed, the sign bit is in the control packet */
-		if (xrel && (hpmouse.bytes[PACKET_CTRL] & MOUSE_XSIGN))
-			xrel = xrel - 0x100;
-		if (yrel && (hpmouse.bytes[PACKET_CTRL] & MOUSE_YSIGN))
-			yrel = yrel - 0x100;
-		
-		input_report_rel(&hpmouse.dev, REL_X, xrel);
-		input_report_rel(&hpmouse.dev, REL_Y, -yrel);	/* Y axis is received upside-down */
-		
-		input_sync(&hpmouse.dev);
-		
-		hpmouse.nbread = 0;
-	}
-}
-
-
-/**
- * gscps2_interrupt() - Interruption service routine
- *
- * This processes the list of scancodes queued and sends appropriate
- * key value to the system.
- */
-
-static irqreturn_t gscps2_interrupt(int irq, void *dev, struct pt_regs *reg)
-{
-	/* process mouse actions */
-	while (gscps2_readb_status(hpmouse.addr) & GSC_STAT_RBNE)
-		gscps2_mouse_docode(reg);
-	
-	/* process keyboard scancode */
-	while (gscps2_readb_status(hpkeyb.addr) & GSC_STAT_RBNE)
-		gscps2_kbd_docode(reg);
-
-	return IRQ_HANDLED;
-}
-
-
-/**
- * gscps2_hpkeyb_event() - Event handler
- * @return: success/error report
- *
- * Currently only updates leds on keyboard
- */
-
-int gscps2_hpkeyb_event(struct input_dev *dev, unsigned int type, unsigned int code, int value)
-{
-	DPRINTK("Calling %s, type=%d, code=%d, value=%d\n",
-			__FUNCTION__, type, code, value);
-
-	if (!hpkeyb.initialized)
-		return -1;
-
-	if (type == EV_LED) {
-		u8 leds[2];
-
-		if (gscps2_writeb_safe_output(KBD_CMD_SET_LEDS)) {
-			printk(KERN_ERR "gsckbd_leds: timeout\n");
-			return -1;
-		}
-		DPRINTK("KBD_CMD_SET_LEDS\n");
-
-		*leds = (test_bit(LED_SCROLLL, dev->led) ? LED_SCR : 0)
-			| (test_bit(LED_NUML,    dev->led) ? LED_NUM : 0)
-			| (test_bit(LED_CAPSL,   dev->led) ? LED_CAP : 0);
-		DPRINTK("Sending leds=%x\n", *leds);
-		
-		if (gscps2_writeb_safe_output(*leds)) {
-			printk(KERN_ERR "gsckbd_leds: timeout\n");
-			return -1;
-		}
-		DPRINTK("leds sent\n");
-		
-		if (gscps2_writeb_safe_output(KBD_CMD_ENABLE)) {
-			printk(KERN_ERR "gsckbd_leds: timeout\n");
-			return -1;
-		}
-		DPRINTK("End\n");
-
-		return 0;
-
-	}
-	return -1;
-}
-
-
-/**
- * gscps2_kbd_probe() - Probes keyboard device and init input_dev structure
- * @return: number of device initialized (1, 0 on error)
- */
-
-static int __init gscps2_kbd_probe(void)
-{
-	int i, res = 0;
-	unsigned long flags;
-
-	if (hpkeyb.initialized) {
-		printk(KERN_ERR "GSC PS/2 keyboard driver already registered\n");
-		return 0;
-	}
-	
-	spin_lock_irqsave(&gscps2_lock, flags);
- 
-	if (!gscps2_writeb_safe_output(KBD_CMD_SET_LEDS)	&&
-	    !gscps2_writeb_safe_output(0)			&&
-	    !gscps2_writeb_safe_output(KBD_CMD_ENABLE))
-		res = 1;
- 
-	spin_unlock_irqrestore(&gscps2_lock, flags);
-
-	if (!res)
-		printk(KERN_ERR "Keyboard initialization sequence failled\n");
-	
-	init_input_dev(&hpkeyb.dev);
-	
-	for (i = 0; i < KBD_TBLSIZE; i++)
-		if (hpkeyb_keycode[i] != KBD_UNKNOWN)
-			set_bit(hpkeyb_keycode[i], hpkeyb.dev.keybit);
-		
-	hpkeyb.dev.evbit[0]	= BIT(EV_KEY) | BIT(EV_LED) | BIT(EV_REP);
-	hpkeyb.dev.ledbit[0]	= BIT(LED_NUML) | BIT(LED_CAPSL) | BIT(LED_SCROLLL);
-	hpkeyb.dev.keycode	= hpkeyb_keycode;
-	hpkeyb.dev.keycodesize	= sizeof(unsigned char);
-	hpkeyb.dev.keycodemax	= KBD_TBLSIZE;
-	hpkeyb.dev.name		= "GSC Keyboard";
-	hpkeyb.dev.phys		= "hpkbd/input0";
-
-	hpkeyb.dev.event	= gscps2_hpkeyb_event;
-	
-	/* TODO These need some adjustement, are they really useful ? */
-	hpkeyb.dev.id.bustype	= BUS_GSC;
-	hpkeyb.dev.id.vendor	= PCI_VENDOR_ID_HP;
-	hpkeyb.dev.id.product	= 0x0001;
-	hpkeyb.dev.id.version	= 0x0010;
-	hpkeyb.initialized	= 1;
-
-	return 1;
-}
-
-
-/**
- * gscps2_mouse_probe() - Probes mouse device and init input_dev structure
- * @return: number of device initialized (1, 0 on error)
- *
- * Currently no check on initialization is performed
- */
-
-static int __init gscps2_mouse_probe(void)
-{
-	if (hpmouse.initialized) {
-		printk(KERN_ERR "GSC PS/2 Mouse driver already registered\n");
-		return 0;
-	}
-	
-	init_input_dev(&hpmouse.dev);
-	
-	hpmouse.dev.name	= "GSC Mouse";
-	hpmouse.dev.phys	= "hpmouse/input0";
-   	hpmouse.dev.evbit[0] 	= BIT(EV_KEY) | BIT(EV_REL);
-	hpmouse.dev.keybit[LONG(BTN_MOUSE)] = BIT(BTN_LEFT) | BIT(BTN_MIDDLE) | BIT(BTN_RIGHT);
-	hpmouse.dev.relbit[0] 	= BIT(REL_X) | BIT(REL_Y);
-	hpmouse.last 		= 0;
-
-	gscps2_writeb_output(AUX_ENABLE_DEV, hpmouse.addr);
-	/* Try it a second time, this will give status if the device is available */
-	gscps2_writeb_output(AUX_ENABLE_DEV, hpmouse.addr);
-	
-	/* TODO These need some adjustement, are they really useful ? */
-	hpmouse.dev.id.bustype	= BUS_GSC;
-	hpmouse.dev.id.vendor	= 0x0001;
-	hpmouse.dev.id.product	= 0x0001;
-	hpmouse.dev.id.version	= 0x0010;
-	hpmouse.initialized = 1;
-	return 1;	/* XXX: we don't check if initialization failed */
-}
-
-
-/**
- * gscps2_probe() - Probes PS2 devices
- * @return: success/error report
- */
-
-static int __init gscps2_probe(struct parisc_device *dev)
-{
-	u8 id;
-	char *addr, *name;
-	int ret = 0, device_found = 0;
-	unsigned long hpa = dev->hpa;
-
-	if (!dev->irq)
-		goto fail_pitifully;
-	
-	/* Offset for DINO PS/2. Works with LASI even */
-	if (dev->id.sversion == 0x96)
-		hpa += GSC_DINO_OFFSET;
-
-	addr = ioremap(hpa, 256);
-	
-	if (!hpmouse.initialized || !hpkeyb.initialized)
-		gscps2_reset(addr);
-
-	ret = -EINVAL;
-	id = readb(addr+GSC_ID) & 0x0f;
-	switch (id) {
-		case 0:				/* keyboard */
-			hpkeyb.addr = addr;
-			name = "keyboard";
-			device_found = gscps2_kbd_probe();
-			break;
-		case 1:				/* mouse */
-			hpmouse.addr = addr;
-			name = "mouse";
-			device_found = gscps2_mouse_probe();
-			break;
-		default:
-			printk(KERN_WARNING "%s: Unsupported PS/2 port (id=%d) ignored\n",
-		    		__FUNCTION__, id);
-			goto fail_miserably;
-	}
-
-	/* No valid device found */
-	ret = -ENODEV;
-	if (!device_found)
-		goto fail_miserably;
-
-	/* Here we claim only if we have a device attached */
-	/* Allocate the irq and memory region for that device */
-	ret = -EBUSY;
-	if (request_irq(dev->irq, gscps2_interrupt, 0, name, NULL))
-		goto fail_miserably;
-
-	if (!request_mem_region(hpa, GSC_STATUS + 4, name))
-		goto fail_request_mem;
-	
-	/* Finalize input struct and register it */
-	switch (id) {
-		case 0:				/* keyboard */
-			hpkeyb.irq = dev->irq;
-			input_register_device(&hpkeyb.dev);	
-			break;
-		case 1:				/* mouse */
-			hpmouse.irq = dev->irq;
-			input_register_device(&hpmouse.dev);
-			break;
-		default:
-			break;
-	}
-
-	printk(KERN_INFO "input: PS/2 %s port at 0x%08lx (irq %d) found and attached\n",
-			name, hpa, dev->irq);
-
-	return 0;
-	
-fail_request_mem: free_irq(dev->irq, NULL);
-fail_miserably: iounmap(addr);
-fail_pitifully:	return ret;
-}
-
-
-
-static struct parisc_device_id gscps2_device_tbl[] = {
-	{ HPHW_FIO, HVERSION_REV_ANY_ID, HVERSION_ANY_ID, 0x00084 }, /* LASI PS/2 */
-/*	{ HPHW_FIO, HVERSION_REV_ANY_ID, HVERSION_ANY_ID, 0x00096 },  DINO PS/2 (XXX Not yet tested) */
-	{ 0, }	/* 0 terminated list */
-};
-
-static struct parisc_driver gscps2_driver = {
-	.name		= "GSC PS2",
-	.id_table	= gscps2_device_tbl,
-	.probe		= gscps2_probe,
-};
-
-static int __init gscps2_init(void)
-{
-	if (register_parisc_driver(&gscps2_driver))
-		return -EBUSY;
-	return 0;
-}
-
-static void __exit gscps2_exit(void)
-{
-	/* TODO this is probably not very good and needs to be checked */
-	if (hpkeyb.initialized) {
-		free_irq(hpkeyb.irq, gscps2_interrupt);
-		iounmap(hpkeyb.addr);
-		hpkeyb.initialized = 0;
-		input_unregister_device(&hpkeyb.dev);
-	}
-	if (hpmouse.initialized) {
-		free_irq(hpmouse.irq, gscps2_interrupt);
-		iounmap(hpmouse.addr);
-		hpmouse.initialized = 0;
-		input_unregister_device(&hpmouse.dev);
-	}
-	unregister_parisc_driver(&gscps2_driver);
-}
-
-
-MODULE_AUTHOR("Laurent Canet <canetl@esiee.fr>, Thibaut Varene <varenet@esiee.fr>");
-MODULE_DESCRIPTION("GSC PS/2 keyboard/mouse driver");
-MODULE_LICENSE("GPL");
-MODULE_DEVICE_TABLE(parisc, gscps2_device_tbl);
-
-
-module_init(gscps2_init);
-module_exit(gscps2_exit);
diff -Nru a/drivers/input/mouse/Kconfig b/drivers/input/mouse/Kconfig
--- a/drivers/input/mouse/Kconfig	Tue Mar 16 13:19:39 2004
+++ b/drivers/input/mouse/Kconfig	Tue Mar 16 13:19:39 2004
@@ -17,6 +17,7 @@
 	depends on INPUT && INPUT_MOUSE
 	select SERIO
 	select SERIO_I8042 if PC
+	select SERIO_GSCPS2 if GSC
 	---help---
 	  Say Y here if you have a PS/2 mouse connected to your system. This
 	  includes the standard 2 or 3-button PS/2 mouse, as well as PS/2
diff -Nru a/drivers/input/serio/Kconfig b/drivers/input/serio/Kconfig
--- a/drivers/input/serio/Kconfig	Tue Mar 16 13:19:39 2004
+++ b/drivers/input/serio/Kconfig	Tue Mar 16 13:19:39 2004
@@ -20,6 +20,7 @@
 	tristate "i8042 PC Keyboard controller" if EMBEDDED || !X86
 	default y
 	select SERIO
+	depends on !PARISC
 	---help---
 	  i8042 is the chip over which the standard AT keyboard and PS/2
 	  mouse are connected to the computer. If you use these devices,
@@ -48,6 +49,7 @@
 config SERIO_CT82C710
 	tristate "ct82c710 Aux port controller"
 	depends on SERIO
+	depends on !PARISC
 	---help---
 	  Say Y here if you have a Texas Instruments TravelMate notebook
 	  equipped with the ct82c710 chip and want to use a mouse connected
@@ -104,6 +106,20 @@
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called 98kbd-io.
+
+config SERIO_GSCPS2
+	tristate "HP GSC PS/2 keyboard and PS/2 mouse controller"
+	depends on GSC && SERIO
+	default y
+	help
+	  This driver provides support for the PS/2 ports on PA-RISC machines
+	  over which HP PS/2 keyboards and PS/2 mice may be connected.
+	  If you use these devices, you'll need to say Y here.
+
+	  It's safe to enable this driver, so if unsure, say Y.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called gscps2.
 
 config SERIO_PCIPS2
 	tristate "PCI PS/2 keyboard and PS/2 mouse controller"
diff -Nru a/drivers/input/serio/Makefile b/drivers/input/serio/Makefile
--- a/drivers/input/serio/Makefile	Tue Mar 16 13:19:39 2004
+++ b/drivers/input/serio/Makefile	Tue Mar 16 13:19:39 2004
@@ -14,4 +14,5 @@
 obj-$(CONFIG_SERIO_AMBAKMI)	+= ambakmi.o
 obj-$(CONFIG_SERIO_Q40KBD)	+= q40kbd.o
 obj-$(CONFIG_SERIO_98KBD)	+= 98kbd-io.o
+obj-$(CONFIG_SERIO_GSCPS2)	+= gscps2.o
 obj-$(CONFIG_SERIO_PCIPS2)	+= pcips2.o
diff -Nru a/drivers/input/serio/gscps2.c b/drivers/input/serio/gscps2.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/input/serio/gscps2.c	Tue Mar 16 13:19:39 2004
@@ -0,0 +1,470 @@
+/*
+ * drivers/input/serio/gscps2.c
+ *
+ * Copyright (c) 2004 Helge Deller <deller@gmx.de>
+ * Copyright (c) 2002 Laurent Canet <canetl@esiee.fr>
+ * Copyright (c) 2002 Thibaut Varene <varenet@esiee.fr>
+ *
+ * Pieces of code based on linux-2.4's hp_mouse.c & hp_keyb.c
+ * 	Copyright (c) 1999 Alex deVries <adevries@thepuffingroup.com>
+ *	Copyright (c) 1999-2000 Philipp Rumpf <prumpf@tux.org>
+ *	Copyright (c) 2000 Xavier Debacker <debackex@esiee.fr>
+ *	Copyright (c) 2000-2001 Thomas Marteau <marteaut@esiee.fr>
+ *
+ * HP GSC PS/2 port driver, found in PA/RISC Workstations
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ * 
+ * TODO:
+ * - Dino testing (did HP ever shipped a machine on which this port
+ *                 was usable/enabled ?)
+ */
+
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/serio.h>
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/spinlock.h>
+#include <linux/delay.h>
+#include <linux/ioport.h>
+#include <linux/pci_ids.h>
+
+#include <asm/irq.h>
+#include <asm/io.h>
+#include <asm/parisc-device.h>
+
+MODULE_AUTHOR("Laurent Canet <canetl@esiee.fr>, Thibaut Varene <varenet@esiee.fr>, Helge Deller <deller@gmx.de>");
+MODULE_DESCRIPTION("HP GSC PS/2 port driver");
+MODULE_LICENSE("GPL");
+MODULE_DEVICE_TABLE(parisc, gscps2_device_tbl);
+
+#define PFX "gscps2.c: "
+
+/* 
+ * Driver constants
+ */
+
+/* various constants */
+#define ENABLE			1
+#define DISABLE			0
+
+#define GSC_DINO_OFFSET		0x0800	/* offset for DINO controller versus LASI one */
+
+/* PS/2 IO port offsets */
+#define GSC_ID			0x00	/* device ID offset (see: GSC_ID_XXX) */
+#define GSC_RESET		0x00	/* reset port offset */
+#define GSC_RCVDATA		0x04	/* receive port offset */
+#define GSC_XMTDATA		0x04	/* transmit port offset */
+#define GSC_CONTROL		0x08	/* see: Control register bits */
+#define GSC_STATUS		0x0C	/* see: Status register bits */
+
+/* Control register bits */
+#define GSC_CTRL_ENBL		0x01	/* enable interface */
+#define GSC_CTRL_LPBXR		0x02	/* loopback operation */
+#define GSC_CTRL_DIAG		0x20	/* directly control clock/data line */
+#define GSC_CTRL_DATDIR		0x40	/* data line direct control */
+#define GSC_CTRL_CLKDIR		0x80	/* clock line direct control */
+
+/* Status register bits */
+#define GSC_STAT_RBNE		0x01	/* Receive Buffer Not Empty */
+#define GSC_STAT_TBNE		0x02	/* Transmit Buffer Not Empty */
+#define GSC_STAT_TERR		0x04	/* Timeout Error */
+#define GSC_STAT_PERR		0x08	/* Parity Error */
+#define GSC_STAT_CMPINTR	0x10	/* Composite Interrupt = irq on any port */
+#define GSC_STAT_DATSHD		0x40	/* Data Line Shadow */
+#define GSC_STAT_CLKSHD		0x80	/* Clock Line Shadow */
+
+/* IDs returned by GSC_ID port register */
+#define GSC_ID_KEYBOARD		0	/* device ID values */
+#define GSC_ID_MOUSE		1
+
+
+static irqreturn_t gscps2_interrupt(int irq, void *dev, struct pt_regs *regs);
+
+#define BUFFER_SIZE 0x0f
+
+/* GSC PS/2 port device struct */
+struct gscps2port {
+	struct list_head node;
+	struct parisc_device *padev;
+	struct serio port;
+	spinlock_t lock;
+	char *addr;
+	u8 act, append; /* position in buffer[] */
+	struct {
+		u8 data;
+		u8 str;
+	} buffer[BUFFER_SIZE+1];
+	int id;
+	char name[32];
+};
+
+/*
+ * Various HW level routines
+ */
+
+#define gscps2_readb_input(x)		readb((x)+GSC_RCVDATA)
+#define gscps2_readb_control(x)		readb((x)+GSC_CONTROL)
+#define gscps2_readb_status(x)		readb((x)+GSC_STATUS)
+#define gscps2_writeb_control(x, y)	writeb((x), (y)+GSC_CONTROL)
+
+
+/*
+ * wait_TBE() - wait for Transmit Buffer Empty
+ */
+
+static int wait_TBE(char *addr)
+{
+	int timeout = 25000; /* device is expected to react within 250 msec */
+	while (gscps2_readb_status(addr) & GSC_STAT_TBNE) {
+		if (!--timeout)
+			return 0;	/* This should not happen */
+		udelay(10);
+	}
+	return 1;
+}
+
+
+/*
+ * gscps2_flush() - flush the receive buffer
+ */
+
+static void gscps2_flush(struct gscps2port *ps2port)
+{
+	while (gscps2_readb_status(ps2port->addr) & GSC_STAT_RBNE)
+		gscps2_readb_input(ps2port->addr);
+	ps2port->act = ps2port->append = 0;
+}
+
+/*
+ * gscps2_writeb_output() - write a byte to the port
+ *
+ * returns 1 on sucess, 0 on error
+ */
+
+static inline int gscps2_writeb_output(struct gscps2port *ps2port, u8 data)
+{
+	unsigned long flags;
+	char *addr = ps2port->addr;
+
+	if (!wait_TBE(addr)) {
+		printk(KERN_DEBUG PFX "timeout - could not write byte %#x\n", data);
+		return 0;
+	}
+
+	while (gscps2_readb_status(ps2port->addr) & GSC_STAT_RBNE)
+		/* wait */;
+
+	spin_lock_irqsave(&ps2port->lock, flags);
+	writeb(data, addr+GSC_XMTDATA);
+	spin_unlock_irqrestore(&ps2port->lock, flags);
+
+	/* this is ugly, but due to timing of the port it seems to be necessary. */
+	mdelay(6);
+
+	/* make sure any received data is returned as fast as possible */
+	/* this is important e.g. when we set the LEDs on the keyboard */
+	gscps2_interrupt(0, NULL, NULL);
+
+	return 1;
+}
+
+
+/*
+ * gscps2_enable() - enables or disables the port
+ */
+
+static void gscps2_enable(struct gscps2port *ps2port, int enable)
+{
+	unsigned long flags;
+	u8 data;
+
+	/* now enable/disable the port */
+	spin_lock_irqsave(&ps2port->lock, flags);
+	gscps2_flush(ps2port);
+	data = gscps2_readb_control(ps2port->addr);
+	if (enable)
+		data |= GSC_CTRL_ENBL;
+	else
+		data &= ~GSC_CTRL_ENBL;
+	gscps2_writeb_control(data, ps2port->addr);
+	spin_unlock_irqrestore(&ps2port->lock, flags);
+	wait_TBE(ps2port->addr);
+	gscps2_flush(ps2port);
+}
+
+/*
+ * gscps2_reset() - resets the PS/2 port
+ */
+
+static void gscps2_reset(struct gscps2port *ps2port)
+{
+	char *addr = ps2port->addr;
+	unsigned long flags;
+
+	/* reset the interface */
+	spin_lock_irqsave(&ps2port->lock, flags);
+	gscps2_flush(ps2port);
+	writeb(0xff, addr+GSC_RESET);
+	gscps2_flush(ps2port);
+	spin_unlock_irqrestore(&ps2port->lock, flags);
+
+	/* enable it */
+	gscps2_enable(ps2port, ENABLE);
+}
+
+static LIST_HEAD(ps2port_list);
+
+/**
+ * gscps2_interrupt() - Interruption service routine
+ *
+ * This function reads received PS/2 bytes and processes them on 
+ * all interfaces.
+ * The problematic part here is, that the keyboard and mouse PS/2 port
+ * share the same interrupt and it's not possible to send data if any
+ * one of them holds input data. To solve this problem we try to receive
+ * the data as fast as possible and handle the reporting to the upper layer
+ * later.
+ */
+
+static irqreturn_t gscps2_interrupt(int irq, void *dev, struct pt_regs *regs)
+{
+	struct gscps2port *ps2port;
+
+	list_for_each_entry(ps2port, &ps2port_list, node) {
+
+	  unsigned long flags;
+	  spin_lock_irqsave(&ps2port->lock, flags);
+
+	  while ( (ps2port->buffer[ps2port->append].str = 
+		   gscps2_readb_status(ps2port->addr)) & GSC_STAT_RBNE ) {
+		ps2port->buffer[ps2port->append].data = 
+				gscps2_readb_input(ps2port->addr);
+		ps2port->append = ((ps2port->append+1) & BUFFER_SIZE);
+	  }
+
+	  spin_unlock_irqrestore(&ps2port->lock, flags);
+
+	} /* list_for_each_entry */
+
+	/* all data was read from the ports - now report the data to upper layer */
+
+	list_for_each_entry(ps2port, &ps2port_list, node) {
+
+	  while (ps2port->act != ps2port->append) {
+
+	    unsigned int rxflags;
+	    u8 data, status;
+
+	    /* Did new data arrived while we read existing data ?
+	       If yes, exit now and let the new irq handler start over again */
+	    if (gscps2_readb_status(ps2port->addr) & GSC_STAT_CMPINTR)
+		return IRQ_HANDLED;
+
+	    status = ps2port->buffer[ps2port->act].str;
+	    data   = ps2port->buffer[ps2port->act].data;
+
+	    ps2port->act = ((ps2port->act+1) & BUFFER_SIZE);
+	    rxflags =	((status & GSC_STAT_TERR) ? SERIO_TIMEOUT : 0 ) |
+			((status & GSC_STAT_PERR) ? SERIO_PARITY  : 0 );
+
+	    serio_interrupt(&ps2port->port, data, rxflags, regs);
+
+	  } /* while() */
+
+	} /* list_for_each_entry */
+
+	return IRQ_HANDLED;
+}
+
+
+/*
+ * gscps2_write() - send a byte out through the aux interface.
+ */
+
+static int gscps2_write(struct serio *port, unsigned char data)
+{
+	struct gscps2port *ps2port = port->driver;
+
+	if (!gscps2_writeb_output(ps2port, data)) {
+		printk(KERN_DEBUG PFX "sending byte %#x failed.\n", data);
+		return -1;
+	}
+	return 0;
+}
+
+/*
+ * gscps2_open() is called when a port is opened by the higher layer.
+ * It resets and enables the port.
+ */
+
+static int gscps2_open(struct serio *port)
+{
+	struct gscps2port *ps2port = port->driver;
+
+	gscps2_reset(ps2port);
+
+	gscps2_interrupt(0, NULL, NULL);
+
+	return 0;
+}
+
+/*
+ * gscps2_close() disables the port
+ */
+
+static void gscps2_close(struct serio *port)
+{
+	struct gscps2port *ps2port = port->driver;
+	gscps2_enable(ps2port, DISABLE);
+}
+
+static struct serio gscps2_serio_port =
+{
+	.name =		"GSC PS/2",
+	.idbus =	BUS_GSC,
+	.idvendor =	PCI_VENDOR_ID_HP,
+	.idproduct =	0x0001,
+	.idversion =	0x0010,
+	.type =		SERIO_8042,
+	.write =	gscps2_write,
+	.open =		gscps2_open,
+	.close =	gscps2_close,
+};
+
+/**
+ * gscps2_probe() - Probes PS2 devices
+ * @return: success/error report
+ */
+
+static int __init gscps2_probe(struct parisc_device *dev)
+{
+        struct gscps2port *ps2port;
+	unsigned long hpa = dev->hpa;
+	int ret;
+
+	if (!dev->irq)
+		return -ENODEV;
+	
+	/* Offset for DINO PS/2. Works with LASI even */
+	if (dev->id.sversion == 0x96)
+		hpa += GSC_DINO_OFFSET;
+
+	ps2port = kmalloc(sizeof(struct gscps2port), GFP_KERNEL);
+	if (!ps2port)
+		return -ENOMEM;
+
+	dev_set_drvdata(&dev->dev, ps2port);
+
+	memset(ps2port, 0, sizeof(struct gscps2port));
+	ps2port->padev = dev;
+	ps2port->addr = ioremap(hpa, GSC_STATUS + 4);
+	spin_lock_init(&ps2port->lock);
+
+	gscps2_reset(ps2port);
+	ps2port->id = readb(ps2port->addr+GSC_ID) & 0x0f;
+	snprintf(ps2port->name, sizeof(ps2port->name)-1, "%s %s",
+		gscps2_serio_port.name, 
+		(ps2port->id == GSC_ID_KEYBOARD) ? "keyboard" : "mouse" );
+
+	memcpy(&ps2port->port, &gscps2_serio_port, sizeof(gscps2_serio_port));
+	ps2port->port.driver = ps2port;
+	ps2port->port.name = ps2port->name;
+	ps2port->port.phys = dev->dev.bus_id;
+
+	list_add_tail(&ps2port->node, &ps2port_list);
+
+	ret = -EBUSY;
+	if (request_irq(dev->irq, gscps2_interrupt, SA_SHIRQ, ps2port->name, ps2port))
+		goto fail_miserably;
+
+	if ( (ps2port->id != GSC_ID_KEYBOARD) && (ps2port->id != GSC_ID_MOUSE) ) {
+		printk(KERN_WARNING PFX "Unsupported PS/2 port at 0x%08lx (id=%d) ignored\n",
+				hpa, ps2port->id);
+		ret = -ENODEV;
+		goto fail;
+	}
+
+#if 0
+	if (!request_mem_region(hpa, GSC_STATUS + 4, ps2port->port.name))
+		goto fail;
+#endif
+
+	printk(KERN_INFO "serio: %s port at 0x%p irq %d @ %s\n",
+		ps2port->name,
+		ps2port->addr,
+		ps2port->padev->irq,
+		ps2port->port.phys);
+
+	serio_register_port(&ps2port->port);
+	
+	return 0;
+	
+fail:
+	free_irq(dev->irq, ps2port);
+
+fail_miserably:
+	list_del(&ps2port->node);
+	iounmap(ps2port->addr);
+	release_mem_region(dev->hpa, GSC_STATUS + 4);
+	kfree(ps2port);
+	return ret;
+}
+
+/**
+ * gscps2_remove() - Removes PS2 devices
+ * @return: success/error report
+ */
+
+static int __devexit gscps2_remove(struct parisc_device *dev)
+{
+	struct gscps2port *ps2port = dev_get_drvdata(&dev->dev);
+
+	serio_unregister_port(&ps2port->port);
+	free_irq(dev->irq, ps2port);
+	gscps2_flush(ps2port);
+	list_del(&ps2port->node);
+	iounmap(ps2port->addr);
+#if 0
+	release_mem_region(dev->hpa, GSC_STATUS + 4); 
+#endif
+	dev_set_drvdata(&dev->dev, NULL);
+	kfree(ps2port);
+	return 0;
+}
+
+
+static struct parisc_device_id gscps2_device_tbl[] = {
+	{ HPHW_FIO, HVERSION_REV_ANY_ID, HVERSION_ANY_ID, 0x00084 }, /* LASI PS/2 */
+#ifdef DINO_TESTED
+	{ HPHW_FIO, HVERSION_REV_ANY_ID, HVERSION_ANY_ID, 0x00096 }, /* DINO PS/2 */ 
+#endif
+	{ 0, }	/* 0 terminated list */
+};
+
+static struct parisc_driver parisc_ps2_driver = {
+	.name		= "GSC PS/2",
+	.id_table	= gscps2_device_tbl,
+	.probe		= gscps2_probe,
+	.remove		= gscps2_remove,
+};
+
+static int __init gscps2_init(void)
+{
+	register_parisc_driver(&parisc_ps2_driver);
+	return 0;
+}
+
+static void __exit gscps2_exit(void)
+{
+	unregister_parisc_driver(&parisc_ps2_driver);
+}
+
+
+module_init(gscps2_init);
+module_exit(gscps2_exit);
+

