Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964854AbWETOMw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964854AbWETOMw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 10:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964856AbWETOMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 10:12:52 -0400
Received: from hansmi.home.forkbomb.ch ([213.144.146.165]:58140 "EHLO
	hansmi.home.forkbomb.ch") by vger.kernel.org with ESMTP
	id S964854AbWETOMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 10:12:51 -0400
Date: Sat, 20 May 2006 16:12:48 +0200
From: Michael Hanselmann <linux-kernel@hansmi.ch>
To: linux-kernel@vger.kernel.org
Cc: linux-input@atrey.karlin.mff.cuni.cz, linuxppc-dev@ozlabs.org
Subject: input/powermac: Cleanup of mac_hid and support for ctrl+click and command+click
Message-ID: <20060520141248.GA26587@hansmi.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch cleans up mac_hid and adds support for Ctrl+Click (right
click) and Command+Click (middle click) emulation. The latter is similar
to Mac OS X.

Signed-off-by: Michael Hanselmann <linux-kernel@hansmi.ch>

---
diff -Nrup --exclude-from linux-exclude-from linux-2.6.17-rc4.orig/drivers/char/keyboard.c linux-2.6.17-rc4/drivers/char/keyboard.c
--- linux-2.6.17-rc4.orig/drivers/char/keyboard.c	2006-05-13 12:33:45.000000000 +0200
+++ linux-2.6.17-rc4/drivers/char/keyboard.c	2006-05-19 23:33:17.000000000 +0200
@@ -40,6 +40,10 @@
 #include <linux/sysrq.h>
 #include <linux/input.h>
 
+#ifdef CONFIG_MAC_EMUMOUSEBTN
+#include <asm/mac_hid.h>
+#endif
+
 static void kbd_disconnect(struct input_handle *handle);
 extern void ctrl_alt_del(void);
 
@@ -1052,10 +1056,6 @@ static unsigned short x86_keycodes[256] 
 	308,310,313,314,315,317,318,319,320,357,322,323,324,325,276,330,
 	332,340,365,342,343,344,345,346,356,270,341,368,369,370,371,372 };
 
-#ifdef CONFIG_MAC_EMUMOUSEBTN
-extern int mac_hid_mouse_emulate_buttons(int, int, int);
-#endif /* CONFIG_MAC_EMUMOUSEBTN */
-
 #ifdef CONFIG_SPARC
 static int sparc_l1_a_state = 0;
 extern void sun_do_break(void);
@@ -1151,7 +1151,7 @@ static void kbd_keycode(unsigned int key
 	rep = (down == 2);
 
 #ifdef CONFIG_MAC_EMUMOUSEBTN
-	if (mac_hid_mouse_emulate_buttons(1, keycode, down))
+	if (mac_hid_mouse_emulate_buttons(keycode, down))
 		return;
 #endif /* CONFIG_MAC_EMUMOUSEBTN */
 
diff -Nrup --exclude-from linux-exclude-from linux-2.6.17-rc4.orig/drivers/input/input.c linux-2.6.17-rc4/drivers/input/input.c
--- linux-2.6.17-rc4.orig/drivers/input/input.c	2006-05-13 12:33:45.000000000 +0200
+++ linux-2.6.17-rc4/drivers/input/input.c	2006-05-20 13:43:41.000000000 +0200
@@ -24,6 +24,10 @@
 #include <linux/device.h>
 #include <linux/mutex.h>
 
+#ifdef CONFIG_MAC_EMUMOUSEBTN
+#include <asm/mac_hid.h>
+#endif
+
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@suse.cz>");
 MODULE_DESCRIPTION("Input core");
 MODULE_LICENSE("GPL");
@@ -194,8 +198,16 @@ static void input_repeat_key(unsigned lo
 	if (!test_bit(dev->repeat_key, dev->key))
 		return;
 
-	input_event(dev, EV_KEY, dev->repeat_key, 2);
-	input_sync(dev);
+#ifdef CONFIG_MAC_EMUMOUSEBTN
+	if (!mac_hid_repeat_key(dev->repeat_key)) {
+#endif
+
+		input_event(dev, EV_KEY, dev->repeat_key, 2);
+		input_sync(dev);
+
+#ifdef CONFIG_MAC_EMUMOUSEBTN
+	}
+#endif
 
 	if (dev->rep[REP_PERIOD])
 		mod_timer(&dev->timer, jiffies + msecs_to_jiffies(dev->rep[REP_PERIOD]));
diff -Nrup --exclude-from linux-exclude-from linux-2.6.17-rc4.orig/drivers/input/mousedev.c linux-2.6.17-rc4/drivers/input/mousedev.c
--- linux-2.6.17-rc4.orig/drivers/input/mousedev.c	2006-05-13 12:33:46.000000000 +0200
+++ linux-2.6.17-rc4/drivers/input/mousedev.c	2006-05-20 00:48:58.000000000 +0200
@@ -27,6 +27,9 @@
 #ifdef CONFIG_INPUT_MOUSEDEV_PSAUX
 #include <linux/miscdevice.h>
 #endif
+#ifdef CONFIG_MAC_EMUMOUSEBTN
+#include <asm/mac_hid.h>
+#endif
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
 MODULE_DESCRIPTION("Mouse (ExplorerPS/2) device interfaces");
@@ -316,8 +319,12 @@ static void mousedev_event(struct input_
 			if (value != 2) {
 				if (code == BTN_TOUCH && test_bit(BTN_TOOL_FINGER, handle->dev->keybit))
 					mousedev_touchpad_touch(mousedev, value);
-				else
+				else {
+#ifdef CONFIG_MAC_EMUMOUSEBTN
+					code = mac_hid_mouse_click(code, value);
+#endif
 					mousedev_key_event(mousedev, code, value);
+				}
 			}
 			break;
 
diff -Nrup --exclude-from linux-exclude-from linux-2.6.17-rc4.orig/drivers/macintosh/Kconfig linux-2.6.17-rc4/drivers/macintosh/Kconfig
--- linux-2.6.17-rc4.orig/drivers/macintosh/Kconfig	2006-05-13 12:33:46.000000000 +0200
+++ linux-2.6.17-rc4/drivers/macintosh/Kconfig	2006-05-20 13:29:07.000000000 +0200
@@ -144,6 +144,10 @@ config MAC_EMUMOUSEBTN
 	  /proc/sys/dev/mac_hid/mouse_button_emulation
 	  /proc/sys/dev/mac_hid/mouse_button2_keycode
 	  /proc/sys/dev/mac_hid/mouse_button3_keycode
+	  /proc/sys/dev/mac_hid/key_click
+
+	  When key_click is enabled by writing a value other than 0 into it,
+	  Ctrl+Click is for right click and Command+Click for middle click.
 
 	  If you have an Apple machine with a 1-button mouse, say Y here.
 
diff -Nrup --exclude-from linux-exclude-from linux-2.6.17-rc4.orig/drivers/macintosh/mac_hid.c linux-2.6.17-rc4/drivers/macintosh/mac_hid.c
--- linux-2.6.17-rc4.orig/drivers/macintosh/mac_hid.c	2006-05-13 12:33:46.000000000 +0200
+++ linux-2.6.17-rc4/drivers/macintosh/mac_hid.c	2006-05-20 14:03:20.000000000 +0200
@@ -4,8 +4,7 @@
  * HID support stuff for Macintosh computers.
  *
  * Copyright (C) 2000 Franz Sirl.
- *
- * This file will soon be removed in favor of an uinput userspace tool.
+ * Copyright (C) 2006 Michael Hanselmann <linux-kernel@hansmi.ch>
  */
 
 #include <linux/config.h>
@@ -14,16 +13,19 @@
 #include <linux/sysctl.h>
 #include <linux/input.h>
 #include <linux/module.h>
-
+#include <asm/mac_hid.h>
 
 static struct input_dev *emumousebtn;
-static int emumousebtn_input_register(void);
-static int mouse_emulate_buttons = 0;
+static int mouse_emulate_buttons;
 static int mouse_button2_keycode = KEY_RIGHTCTRL;	/* right control key */
 static int mouse_button3_keycode = KEY_RIGHTALT;	/* right option key */
-static int mouse_last_keycode = 0;
+static int key_click;
+static int key_click_active;
+static int key_click_button;
+static int key_pressed;
+static int inside_mouse_click;
 
-#if defined(CONFIG_SYSCTL)
+#ifdef CONFIG_SYSCTL
 /* file(s) in /proc/sys/dev/mac_hid */
 ctl_table mac_hid_files[] = {
 	{
@@ -50,6 +52,14 @@ ctl_table mac_hid_files[] = {
 		.mode		= 0644,
 		.proc_handler	= &proc_dointvec,
 	},
+	{
+		.ctl_name	= DEV_MAC_HID_KEY_CLICK,
+		.procname	= "key_click",
+		.data		= &key_click,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
 	{ .ctl_name = 0 }
 };
 
@@ -79,33 +89,91 @@ ctl_table mac_hid_root_dir[] = {
 
 static struct ctl_table_header *mac_hid_sysctl_header;
 
-#endif /* endif CONFIG_SYSCTL */
+#endif /* CONFIG_SYSCTL */
 
-int mac_hid_mouse_emulate_buttons(int caller, unsigned int keycode, int down)
+/* Emulate mouse buttons with keys */
+int mac_hid_mouse_emulate_buttons(unsigned int keycode, int down)
 {
-	switch (caller) {
-	case 1:
-		/* Called from keyboard.c */
-		if (mouse_emulate_buttons
-		    && (keycode == mouse_button2_keycode
-			|| keycode == mouse_button3_keycode)) {
-			if (mouse_emulate_buttons == 1) {
-				input_report_key(emumousebtn,
-						 keycode == mouse_button2_keycode ? BTN_MIDDLE : BTN_RIGHT,
-						 down);
+	if (inside_mouse_click)
+		return 0;
+
+	if (key_click &&
+	    (keycode == KEY_LEFTCTRL || keycode == KEY_RIGHTCTRL ||
+	     keycode == KEY_LEFTMETA || keycode == KEY_RIGHTMETA)) {
+		if (down && !key_pressed && !key_click_active)
+			key_pressed = keycode;
+		else if (!down && keycode == key_pressed) {
+			key_pressed = 0;
+
+			if (key_click_active > 0) {
+				input_report_key(emumousebtn, key_click_active, 0);
 				input_sync(emumousebtn);
-				return 1;
+
+				key_click_active = -1;
 			}
-			mouse_last_keycode = down ? keycode : 0;
 		}
-		break;
 	}
+
+	if (mouse_emulate_buttons) {
+		if (keycode == mouse_button2_keycode)
+			input_report_key(emumousebtn, BTN_RIGHT, down);
+		else if (keycode == mouse_button3_keycode)
+			input_report_key(emumousebtn, BTN_MIDDLE, down);
+
+		input_sync(emumousebtn);
+
+		return 1;
+	}
+
 	return 0;
 }
 
-EXPORT_SYMBOL(mac_hid_mouse_emulate_buttons);
+/* Modify mouse button value if the Control key is pressed */
+int mac_hid_mouse_click(unsigned int code, int value)
+{
+	if (!key_click || code != BTN_LEFT || inside_mouse_click)
+		return code;
+
+	inside_mouse_click = 1;
+
+	if (value && key_pressed && !key_click_active) {
+		key_click_active = key_pressed;
+
+		input_report_key(emumousebtn, key_click_active, 0);
+		input_sync(emumousebtn);
+
+		if (key_click_active == KEY_LEFTMETA ||
+		    key_click_active == KEY_RIGHTMETA)
+			code = BTN_MIDDLE;
+		else
+			code = BTN_RIGHT;
+
+		key_click_button = code;
+	} else if (!value && key_click_active) {
+		if (key_click_active > 0) {
+			input_report_key(emumousebtn, key_click_active, 1);
+			input_sync(emumousebtn);
+		}
 
-static int emumousebtn_input_register(void)
+		key_click_active = 0;
+
+		code = key_click_button;
+	}
+
+	inside_mouse_click = 0;
+
+	return code;
+}
+
+/* This function returns true if the given keycode should not
+ * be repeated.
+ */
+int mac_hid_repeat_key(unsigned int keycode)
+{
+	return (key_click && key_click_active == keycode);
+}
+
+int __init mac_hid_init(void)
 {
 	emumousebtn = input_allocate_device();
 	if (!emumousebtn)
@@ -121,24 +189,22 @@ static int emumousebtn_input_register(vo
 	emumousebtn->keybit[LONG(BTN_MOUSE)] = BIT(BTN_LEFT) | BIT(BTN_MIDDLE) | BIT(BTN_RIGHT);
 	emumousebtn->relbit[0] = BIT(REL_X) | BIT(REL_Y);
 
-	input_register_device(emumousebtn);
-
-	return 0;
-}
+	set_bit(KEY_LEFTCTRL, emumousebtn->keybit);
+	set_bit(KEY_RIGHTCTRL, emumousebtn->keybit);
+	set_bit(KEY_LEFTMETA, emumousebtn->keybit);
+	set_bit(KEY_RIGHTMETA, emumousebtn->keybit);
 
-int __init mac_hid_init(void)
-{
-	int err;
-
-	err = emumousebtn_input_register();
-	if (err)
-		return err;
+	input_register_device(emumousebtn);
 
-#if defined(CONFIG_SYSCTL)
+#ifdef CONFIG_SYSCTL
 	mac_hid_sysctl_header = register_sysctl_table(mac_hid_root_dir, 1);
-#endif /* CONFIG_SYSCTL */
+#endif
 
 	return 0;
 }
 
 device_initcall(mac_hid_init);
+
+EXPORT_SYMBOL(mac_hid_mouse_emulate_buttons);
+EXPORT_SYMBOL_GPL(mac_hid_mouse_click);
+EXPORT_SYMBOL_GPL(mac_hid_repeat_key);
diff -Nrup --exclude-from linux-exclude-from linux-2.6.17-rc4.orig/include/asm-powerpc/mac_hid.h linux-2.6.17-rc4/include/asm-powerpc/mac_hid.h
--- linux-2.6.17-rc4.orig/include/asm-powerpc/mac_hid.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.17-rc4/include/asm-powerpc/mac_hid.h	2006-05-20 00:49:22.000000000 +0200
@@ -0,0 +1,13 @@
+/*
+ * HID support stuff for Macintosh computers.
+ */
+#ifndef __ASM_POWERPC_MAC_HID_H
+#define __ASM_POWERPC_MAC_HID_H
+#ifdef __KERNEL__
+
+extern int mac_hid_mouse_emulate_buttons(unsigned int keycode, int down);
+extern int mac_hid_mouse_click(unsigned int code, int value);
+extern int mac_hid_repeat_key(unsigned int keycode);
+
+#endif
+#endif
diff -Nrup --exclude-from linux-exclude-from linux-2.6.17-rc4.orig/include/linux/sysctl.h linux-2.6.17-rc4/include/linux/sysctl.h
--- linux-2.6.17-rc4.orig/include/linux/sysctl.h	2006-05-13 12:34:00.000000000 +0200
+++ linux-2.6.17-rc4/include/linux/sysctl.h	2006-05-20 12:31:23.000000000 +0200
@@ -870,7 +870,8 @@ enum {
 	DEV_MAC_HID_MOUSE_BUTTON_EMULATION=3,
 	DEV_MAC_HID_MOUSE_BUTTON2_KEYCODE=4,
 	DEV_MAC_HID_MOUSE_BUTTON3_KEYCODE=5,
-	DEV_MAC_HID_ADB_MOUSE_SENDS_KEYCODES=6
+	DEV_MAC_HID_ADB_MOUSE_SENDS_KEYCODES=6,
+	DEV_MAC_HID_KEY_CLICK=7,
 };
 
 /* /proc/sys/dev/scsi */
