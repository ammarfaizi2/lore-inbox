Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317862AbSHaSta>; Sat, 31 Aug 2002 14:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317864AbSHaSta>; Sat, 31 Aug 2002 14:49:30 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:35259 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S317862AbSHaStT>;
	Sat, 31 Aug 2002 14:49:19 -0400
Date: Sat, 31 Aug 2002 20:53:37 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: bert hubert <ahu@ds9a.nl>, Vojtech Pavlik <vojtech@suse.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: keyboard slowdown regression in 2.5.32 (right .config) Re: FIXED in 2.5.29 Re: keyboard ONLY functions in 2.5.27 with local APIC on for UP
Message-ID: <20020831205337.A65739@ucw.cz>
References: <20020720222905.GA15288@outpost.ds9a.nl> <20020728204051.A15238@ucw.cz> <20020728203211.GA20082@outpost.ds9a.nl> <20020831182645.GA8812@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020831182645.GA8812@outpost.ds9a.nl>; from ahu@ds9a.nl on Sat, Aug 31, 2002 at 08:26:45PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Aug 31, 2002 at 08:26:45PM +0200, bert hubert wrote:

> Vojtech, list, I think we may have a small regression in the keyboard
> support.
> 
> In 2.5.27 my keyboard only worked when I turned on Local APIC on UP, which
> was fixed in 2.5.29 (original message below).
> 
> In 2.5.32 I'm back to almost the exact same problem, but the APIC setting
> does not matter.
> 
> It boots fine without keyboard support, which I had initially after make
> oldconfig (except no keyboard). When I turn on the keyboard support, just
> after 'Freeing unused kernel memory', my harddisk light starts to blink
> roughly once every .75 seconds and the boot proceeds *very* slowly.
> Furthermore, I can feel that the CPU is hard at work, the fan exhaust of my
> laptop gets pretty hot.
> 
> Numlock does not react and keystrokes do not appear on the screen. I do see
> some keyboard related printk's early in the bootprocess but they are gone
> quickly and do not look like errors.
> 
> This is the exact same behaviour I had with 2.5.27 and APIC *off*.
> 
> 2.5.31 works fine. This is a nearly-completely-SiS laptop from a company
> called 'Gericom'.
> 
> ahu@snapcount:/mnt/linux-2.5.32$ egrep 'KEY|INPUT' .config
> CONFIG_INPUT_KEYBOARD=y
> CONFIG_KEYBOARD_ATKBD=y
> CONFIG_INPUT_MOUSE=y
> CONFIG_INPUT_MISC=y
> CONFIG_INPUT_PCSPKR=y

How about I8042 support? Also enabled? If not, then the keyboard driver
isn't even touching the hardware.

> Let me know if there are further things I can try. I think I know where my
> nullmodem cable is, so I could try that.

Can you check with the attached patch? Or (better) Linus's current BK
tree?

-- 
Vojtech Pavlik
SuSE Labs

--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=linusfix

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.
'bk pull bk://linux-input.bkbits.net/linux-input' should work as well.

===================================================================

ChangeSet@1.543, 2002-08-28 19:48:23+02:00, vojtech@suse.cz
  Remove uninformative coments in input.c.
  Silence hotplug printk()s in input.c
  More careful probe and init in atkbd.c and psmouse.c
  to avoid triggering bugs in certain keyboards.
  Accept old AT (non PS/2) keyboards with limited command set.
  Accept Logitech mice which can only do IMPS/2 and not PS2++.
  Use a buffer in i8042.c to avoid spinlock deadlocks when
  serio_write is called from within serio_interrupt.
  Only ask keyboard to resent if the keyboard is there (ie no timeout).
  Linus, this should fix both your keyboard and your mouse!


===================================================================

 input.c          |  112 ++++--------------------------------------
 keyboard/atkbd.c |  103 ++++++++++++++-------------------------
 mouse/psmouse.c  |  145 +++++++++++++++++++++++++------------------------------
 serio/i8042.c    |   34 +++++++++---
 4 files changed, 143 insertions(+), 251 deletions(-)

===================================================================

diff -Nru a/drivers/input/input.c b/drivers/input/input.c
--- a/drivers/input/input.c	Wed Aug 28 19:50:15 2002
+++ b/drivers/input/input.c	Wed Aug 28 19:50:15 2002
@@ -1,29 +1,13 @@
 /*
- * $Id: input.c,v 1.48 2001/12/26 21:08:33 jsimmons Exp $
+ * The input core
  *
- *  Copyright (c) 1999-2001 Vojtech Pavlik
- *
- *  The input core
+ * Copyright (c) 1999-2002 Vojtech Pavlik
  */
 
 /*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or 
- * (at your option) any later version.
- * 
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- * 
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- * 
- * Should you need to contact me, the author, you can do so either by
- * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
- * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
  */
 
 #include <linux/init.h>
@@ -39,7 +23,7 @@
 #include <linux/poll.h>
 #include <linux/device.h>
 
-MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
+MODULE_AUTHOR("Vojtech Pavlik <vojtech@suse.cz>");
 MODULE_DESCRIPTION("Input core");
 MODULE_LICENSE("GPL");
 
@@ -337,7 +321,7 @@
 	int i = 0, j, value;
 
 	if (!hotplug_path[0]) {
-		printk(KERN_ERR "input.c: calling hotplug a hotplug agent defined\n");
+		printk(KERN_ERR "input.c: calling hotplug without a hotplug agent defined\n");
 		return;
 	}
 	if (in_interrupt()) {
@@ -395,16 +379,20 @@
 
 	envp[i++] = 0;
 
+#ifdef INPUT_DEBUG
 	printk(KERN_DEBUG "input.c: calling %s %s [%s %s %s %s %s]\n",
 		argv[0], argv[1], envp[0], envp[1], envp[2], envp[3], envp[4]);
+#endif
 
 	value = call_usermodehelper(argv [0], argv, envp);
 
 	kfree(buf);
 	kfree(envp);
 
+#ifdef INPUT_DEBUG
 	if (value != 0)
-		printk(KERN_WARNING "input.c: hotplug returned %d\n", value);
+		printk(KERN_DEBUG "input.c: hotplug returned %d\n", value);
+#endif
 }
 
 #endif
@@ -415,31 +403,17 @@
 	struct input_handle *handle;
 	struct input_device_id *id;
 
-/*
- * Add the EV_SYN capability.
- */
-
 	set_bit(EV_SYN, dev->evbit);
 
-/*
- * Initialize repeat timer to default values.
- */
-
 	init_timer(&dev->timer);
 	dev->timer.data = (long) dev;
 	dev->timer.function = input_repeat_key;
 	dev->rep[REP_DELAY] = HZ/4;
 	dev->rep[REP_PERIOD] = HZ/33;
 
-/*
- * Add the device.
- */
 	INIT_LIST_HEAD(&dev->h_list);
 	list_add_tail(&dev->node,&input_dev_list);
 
-/*
- * Notify handlers.
- */
 	list_for_each(node,&input_handler_list) {
 		struct input_handler *handler = to_handler(node);
 		if ((id = input_match_device(handler->id_table, dev)))
@@ -447,18 +421,10 @@
 				input_link_handle(handle);
 	}
 
-/*
- * Notify the hotplug agent.
- */
-
 #ifdef CONFIG_HOTPLUG
 	input_call_hotplug("add", dev);
 #endif
 
-/*
- * Notify /proc.
- */
-
 #ifdef CONFIG_PROC_FS
 	input_devices_state++;
 	wake_up(&input_devices_poll_wait);
@@ -471,22 +437,11 @@
 
 	if (!dev) return;
 
-/*
- * Turn off power management for the device.
- */
 	if (dev->pm_dev)
 		pm_unregister(dev->pm_dev);
 
-/*
- * Kill any pending repeat timers.
- */
-
 	del_timer_sync(&dev->timer);
 
-/*
- * Notify handlers.
- */
-
 	list_for_each_safe(node,next,&dev->h_list) {
 		struct input_handle * handle = to_handle(node);
 		list_del_init(&handle->d_node);
@@ -494,23 +449,12 @@
 		handle->handler->disconnect(handle);
 	}
 
-/*
- * Notify the hotplug agent.
- */
-
 #ifdef CONFIG_HOTPLUG
 	input_call_hotplug("remove", dev);
 #endif
 
-/*
- * Remove the device.
- */
 	list_del_init(&dev->node);
 
-/*
- * Notify /proc.
- */
-
 #ifdef CONFIG_PROC_FS
 	input_devices_state++;
 	wake_up(&input_devices_poll_wait);
@@ -526,22 +470,12 @@
 	if (!handler) return;
 
 	INIT_LIST_HEAD(&handler->h_list);
-/*
- * Add minors if needed.
- */
 
 	if (handler->fops != NULL)
 		input_table[handler->minor >> 5] = handler;
 
-/*
- * Add the handler.
- */
 	list_add_tail(&handler->node,&input_handler_list);
 	
-/*
- * Notify it about all existing devices.
- */
-
 	list_for_each(node,&input_dev_list) {
 		struct input_dev *dev = to_dev(node);
 		if ((id = input_match_device(handler->id_table, dev)))
@@ -549,10 +483,6 @@
 				input_link_handle(handle);
 	}
 
-/*
- * Notify /proc.
- */
-
 #ifdef CONFIG_PROC_FS
 	input_devices_state++;
 	wake_up(&input_devices_poll_wait);
@@ -563,10 +493,6 @@
 {
 	struct list_head * node, * next;
 
-
-/*
- * Tell the handler to disconnect from all devices it keeps open.
- */
 	list_for_each_safe(node,next,&handler->h_list) {
 		struct input_handle * handle = to_handle_h(node);
 		list_del_init(&handle->h_node);
@@ -574,21 +500,11 @@
 		handler->disconnect(handle);
 	}
 
-/*
- * Remove it.
- */
 	list_del_init(&handler->node);
 
-/*
- * Remove minors.
- */
 	if (handler->fops != NULL)
 		input_table[handler->minor >> 5] = NULL;
 
-/*
- * Notify /proc.
- */
-
 #ifdef CONFIG_PROC_FS
 	input_devices_state++;
 	wake_up(&input_devices_poll_wait);
@@ -643,10 +559,6 @@
 {
 	devfs_unregister(handle);
 }
-
-/*
- * ProcFS interface for the input drivers.
- */
 
 #ifdef CONFIG_PROC_FS
 
diff -Nru a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c	Wed Aug 28 19:50:15 2002
+++ b/drivers/input/keyboard/atkbd.c	Wed Aug 28 19:50:15 2002
@@ -1,27 +1,13 @@
 /*
- * $Id: atkbd.c,v 1.33 2002/02/12 09:34:34 vojtech Exp $
+ * AT and PS/2 keyboard driver
  *
- *  Copyright (c) 1999-2001 Vojtech Pavlik
+ * Copyright (c) 1999-2002 Vojtech Pavlik
  */
 
 /*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or 
- * (at your option) any later version.
- * 
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- * 
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- * 
- * Should you need to contact me, the author, you can do so either by
- * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
- * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
  */
 
 #include <linux/delay.h>
@@ -33,7 +19,7 @@
 #include <linux/serio.h>
 #include <linux/tqueue.h>
 
-MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
+MODULE_AUTHOR("Vojtech Pavlik <vojtech@suse.cz>");
 MODULE_DESCRIPTION("AT and PS/2 keyboard driver");
 MODULE_PARM(atkbd_set, "1i");
 MODULE_LICENSE("GPL");
@@ -94,9 +80,11 @@
 #define ATKBD_CMD_SETLEDS	0x10ed
 #define ATKBD_CMD_GSCANSET	0x11f0
 #define ATKBD_CMD_SSCANSET	0x10f0
-#define ATKBD_CMD_GETID		0x02f2
+#define ATKBD_CMD_GETID		0x01f2
+#define ATKBD_CMD_GETID2	0x0100
 #define ATKBD_CMD_ENABLE	0x00f4
 #define ATKBD_CMD_RESET_DIS	0x00f5
+#define ATKBD_CMD_RESET_BAT	0x01ff
 #define ATKBD_CMD_SETALL_MB	0x00f8
 #define ATKBD_CMD_RESEND	0x00fe
 #define ATKBD_CMD_EX_ENABLE	0x10ea
@@ -147,7 +135,7 @@
 #endif
 
 	/* Interface error.  Request that the keyboard resend. */
-	if ((flags & (SERIO_FRAME | SERIO_PARITY)) && atkbd->write) {
+	if ((flags & (SERIO_FRAME | SERIO_PARITY)) && (~flags & SERIO_TIMEOUT) && atkbd->write) {
 		printk("atkbd.c: frame/parity error: %02x\n", flags);
 		serio_write(serio, ATKBD_CMD_RESEND);
 		return;
@@ -360,70 +348,60 @@
 	unsigned char param[2];
 
 /*
- * Full reset with selftest can on some keyboards be annoyingly slow,
- * so we just do a reset-and-disable on the keyboard, which
- * is considerably faster, but doesn't have to reset everything.
+ * Some systems, where the bit-twiddling when testing the io-lines of the
+ * controller may confuse the keyboard need a full reset of the keyboard. On
+ * these systems the BIOS also usually doesn't do it for us.
  */
 
-	if (atkbd_command(atkbd, NULL, ATKBD_CMD_RESET_DIS))
+#ifdef CONFIG_KEYBOARD_ATKBD_RESET
+	if (atkbd_command(atkbd, NULL, ATKBD_CMD_RESET_BAT))
 		printk(KERN_WARNING "atkbd.c: keyboard reset failed\n");
+#endif
 
 /*
- * Next, we check if it's a keyboard. It should send 0xab83
- * (0xab84 on IBM ThinkPad, and 0xaca1 on a NCD Sun layout keyboard,
- * 0xab02 on unxlated i8042 and 0xab03 on unxlated ThinkPad, 0xab7f
- * on Fujitsu Lifebook).
- * If it's a mouse, it'll only send 0x00 (0x03 if it's MS mouse),
- * and we'll time out here, and report an error.
+ * Next we check we can set LEDs on the keyboard. This should work on every
+ * keyboard out there. It also turns the LEDs off, which we want anyway.
  */
 
-	param[0] = param[1] = 0;
-
-	if (atkbd_command(atkbd, param, ATKBD_CMD_GETID))
+	param[0] = 0;
+	if (atkbd_command(atkbd, param, ATKBD_CMD_SETLEDS))
 		return -1;
 
-	atkbd->id = (param[0] << 8) | param[1];
-
-	if (atkbd->id != 0xab83 && atkbd->id != 0xab84 && atkbd->id != 0xaca1 &&
-	    atkbd->id != 0xab7f && atkbd->id != 0xab02 && atkbd->id != 0xab03)
-		printk(KERN_WARNING "atkbd.c: Unusual keyboard ID: %#x on %s\n",
-			atkbd->id, atkbd->serio->phys);
-
-	return 0;
-}
-
 /*
- * atkbd_initialize() sets the keyboard into a sane state.
+ * Then we check the keyboard ID. We should get 0xab83 under normal conditions.
+ * Some keyboards report different values, but the first byte is always 0xab or
+ * 0xac. Some old AT keyboards don't report anything.
  */
 
-static void atkbd_initialize(struct atkbd *atkbd)
-{
-	unsigned char param;	
+	if (atkbd_command(atkbd, param, ATKBD_CMD_GETID)) {
+		atkbd->id = 0xabba;
+		return 0;
+	}
+	if (param[0] != 0xab && param[0] != 0xac)
+		return -1;
+	atkbd->id = param[0] << 8;
+	if (atkbd_command(atkbd, param, ATKBD_CMD_GETID2))
+		return -1;
+	atkbd->id |= param[0];
 
 /*
  * Disable autorepeat. We don't need it, as we do it in software anyway,
- * because that way can get faster repeat, and have less system load
- * (less accesses to the slow ISA hardware). If this fails, we don't care,
- * and will just ignore the repeated keys.
+ * because that way can get faster repeat, and have less system load (less
+ * accesses to the slow ISA hardware). If this fails, we don't care, and will
+ * just ignore the repeated keys.
  */
 
 	atkbd_command(atkbd, NULL, ATKBD_CMD_SETALL_MB);
 
 /*
- * We also shut off all the leds. The console code will turn them back on,
- * if needed.
- */
-
-	param = 0;
-	atkbd_command(atkbd, &param, ATKBD_CMD_SETLEDS);
-
-/*
- * Last, we enable the keyboard so that we get keypresses from it.
+ * Last, we enable the keyboard to make sure  that we get keypresses from it.
  */
 
 	if (atkbd_command(atkbd, NULL, ATKBD_CMD_ENABLE))
 		printk(KERN_ERR "atkbd.c: Failed to enable keyboard on %s\n",
 			atkbd->serio->phys);
+
+	return 0;
 }
 
 /*
@@ -524,9 +502,6 @@
 	input_register_device(&atkbd->dev);
 
 	printk(KERN_INFO "input: %s on %s\n", atkbd->name, serio->phys);
-
-	if (atkbd->write)
-		atkbd_initialize(atkbd);
 }
 
 
diff -Nru a/drivers/input/mouse/psmouse.c b/drivers/input/mouse/psmouse.c
--- a/drivers/input/mouse/psmouse.c	Wed Aug 28 19:50:15 2002
+++ b/drivers/input/mouse/psmouse.c	Wed Aug 28 19:50:15 2002
@@ -1,27 +1,13 @@
 /*
- * $Id: psmouse.c,v 1.18 2002/03/13 10:03:43 vojtech Exp $
+ * PS/2 mouse driver
  *
- *  Copyright (c) 1999-2001 Vojtech Pavlik
+ * Copyright (c) 1999-2002 Vojtech Pavlik
  */
 
 /*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or 
- * (at your option) any later version.
- * 
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- * 
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- * 
- * Should you need to contact me, the author, you can do so either by
- * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
- * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
  */
 
 #include <linux/delay.h>
@@ -33,7 +19,7 @@
 #include <linux/init.h>
 #include <linux/tqueue.h>
 
-MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
+MODULE_AUTHOR("Vojtech Pavlik <vojtech@suse.cz>");
 MODULE_DESCRIPTION("PS/2 mouse driver");
 MODULE_LICENSE("GPL");
 
@@ -43,6 +29,7 @@
 #define PSMOUSE_CMD_SETSTREAM	0x00ea
 #define PSMOUSE_CMD_POLL	0x03eb	
 #define PSMOUSE_CMD_GETID	0x01f2
+#define PSMOUSE_CMD_GETID2	0x0100
 #define PSMOUSE_CMD_SETRATE	0x10f3
 #define PSMOUSE_CMD_ENABLE	0x00f4
 #define PSMOUSE_CMD_RESET_DIS	0x00f6
@@ -313,7 +300,7 @@
 	param[0] = 0;
 	psmouse->vendor = "Generic";
 	psmouse->name = "Mouse";
-	psmouse->model = 2;
+	psmouse->model = 0;
 
 /*
  * Try Genius NetMouse magic init.
@@ -327,13 +314,13 @@
 	psmouse_command(psmouse, param, PSMOUSE_CMD_GETINFO);
 
 	if (param[0] == 0x00 && param[1] == 0x33 && param[2] == 0x55) {
-		psmouse->vendor = "Genius";
-		psmouse->name = "Mouse";
 
 		set_bit(BTN_EXTRA, psmouse->dev.keybit);
 		set_bit(BTN_SIDE, psmouse->dev.keybit);
 		set_bit(REL_WHEEL, psmouse->dev.relbit);
 
+		psmouse->vendor = "Genius";
+		psmouse->name = "Wheel Mouse";
 		return PSMOUSE_GENPS;
 	}
 
@@ -356,7 +343,6 @@
 		static int logitech_ps2pp[] = { 12, 13, 40, 41, 42, 43, 50, 51, 52, 53, 73, 75,
 							76, 80, 81, 83, 88, 96, 97, -1 };
 		psmouse->vendor = "Logitech";
-		psmouse->name = "Mouse";
 		psmouse->model = ((param[0] >> 4) & 0x07) | ((param[0] << 3) & 0x78);
 
 		if (param[1] < 3)
@@ -367,46 +353,53 @@
 		psmouse->type = PSMOUSE_PS2;
 
 		for (i = 0; logitech_ps2pp[i] != -1; i++)
-			if (logitech_ps2pp[i] == psmouse->model) psmouse->type = PSMOUSE_PS2PP;
+			if (logitech_ps2pp[i] == psmouse->model)
+				psmouse->type = PSMOUSE_PS2PP;
 
-		if (psmouse->type != PSMOUSE_PS2PP) return PSMOUSE_PS2;
+		if (psmouse->type == PSMOUSE_PS2PP) {
 
-		for (i = 0; logitech_4btn[i] != -1; i++)
-			if (logitech_4btn[i] == psmouse->model) set_bit(BTN_SIDE, psmouse->dev.keybit);
-
-		for (i = 0; logitech_wheel[i] != -1; i++)
-			if (logitech_wheel[i] == psmouse->model) set_bit(REL_WHEEL, psmouse->dev.relbit);
+			for (i = 0; logitech_4btn[i] != -1; i++)
+				if (logitech_4btn[i] == psmouse->model)
+					set_bit(BTN_SIDE, psmouse->dev.keybit);
+
+			for (i = 0; logitech_wheel[i] != -1; i++)
+				if (logitech_wheel[i] == psmouse->model) {
+					set_bit(REL_WHEEL, psmouse->dev.relbit);
+					psmouse->name = "Wheel Mouse";
+				}
 
 /*
  * Do Logitech PS2++ / PS2T++ magic init.
  */
 
-		if (psmouse->model == 97) { /* TouchPad 3 */
+			if (psmouse->model == 97) { /* TouchPad 3 */
 
-			set_bit(REL_WHEEL, psmouse->dev.relbit);
-			set_bit(REL_HWHEEL, psmouse->dev.relbit);
+				set_bit(REL_WHEEL, psmouse->dev.relbit);
+				set_bit(REL_HWHEEL, psmouse->dev.relbit);
 
-			param[0] = 0x11; param[1] = 0x04; param[2] = 0x68; /* Unprotect RAM */
-			psmouse_command(psmouse, param, 0x30d1);
-			param[0] = 0x11; param[1] = 0x05; param[2] = 0x0b; /* Enable features */
-			psmouse_command(psmouse, param, 0x30d1);
-			param[0] = 0x11; param[1] = 0x09; param[2] = 0xc3; /* Enable PS2++ */
-			psmouse_command(psmouse, param, 0x30d1);
-
-			param[0] = 0;
-			if (!psmouse_command(psmouse, param, 0x13d1) &&
-				param[0] == 0x06 && param[1] == 0x00 && param[2] == 0x14)
-				return PSMOUSE_PS2TPP;
-
-		} else {
-			psmouse_ps2pp_cmd(psmouse, param, 0x39); /* Magic knock */
-			psmouse_ps2pp_cmd(psmouse, param, 0xDB);
-
-			if ((param[0] & 0x78) == 0x48 && (param[1] & 0xf3) == 0xc2 &&
-				(param[2] & 3) == ((param[1] >> 2) & 3))
-					return PSMOUSE_PS2PP;
+				param[0] = 0x11; param[1] = 0x04; param[2] = 0x68; /* Unprotect RAM */
+				psmouse_command(psmouse, param, 0x30d1);
+				param[0] = 0x11; param[1] = 0x05; param[2] = 0x0b; /* Enable features */
+				psmouse_command(psmouse, param, 0x30d1);
+				param[0] = 0x11; param[1] = 0x09; param[2] = 0xc3; /* Enable PS2++ */
+				psmouse_command(psmouse, param, 0x30d1);
+
+				param[0] = 0;
+				if (!psmouse_command(psmouse, param, 0x13d1) &&
+					param[0] == 0x06 && param[1] == 0x00 && param[2] == 0x14)
+					return PSMOUSE_PS2TPP;
+
+			} else {
+				param[0] = param[1] = param[2] = 0;
+
+				psmouse_ps2pp_cmd(psmouse, param, 0x39); /* Magic knock */
+				psmouse_ps2pp_cmd(psmouse, param, 0xDB);
+
+				if ((param[0] & 0x78) == 0x48 && (param[1] & 0xf3) == 0xc2 &&
+					(param[2] & 3) == ((param[1] >> 2) & 3))
+						return PSMOUSE_PS2PP;
+			}
 		}
-
 	}
 
 /*
@@ -426,7 +419,7 @@
 		set_bit(REL_WHEEL, psmouse->dev.relbit);
 
 /*
- * Try IntelliMouse Explorer magic init.
+ * Try IntelliMouse/Explorer magic init.
  */
 
 		param[0] = 200;
@@ -439,29 +432,22 @@
 
 		if (param[0] == 4) {
 
-			psmouse->vendor = "Microsoft";
-			psmouse->name = "IntelliMouse Explorer";
-
 			set_bit(BTN_SIDE, psmouse->dev.keybit);
 			set_bit(BTN_EXTRA, psmouse->dev.keybit);
 
+			psmouse->name = "Explorer Mouse";
 			return PSMOUSE_IMEX;
 		}
 
-		psmouse->vendor = "Microsoft";
-		psmouse->name = "IntelliMouse";
-
+		psmouse->name = "Wheel Mouse";
 		return PSMOUSE_IMPS;
 	}
 
 /*
- * Okay, all failed, we have a standard mouse here. The number of the buttons is
- * still a question, though.
+ * Okay, all failed, we have a standard mouse here. The number of the buttons
+ * is still a question, though. We assume 3.
  */
 
-	psmouse->vendor = "Generic";
-	psmouse->name = "Mouse";
-
 	return PSMOUSE_PS2;
 }
 
@@ -474,14 +460,7 @@
 	unsigned char param[2];
 
 /*
- * First we reset and disable the mouse.
- */
-
-	if (psmouse_command(psmouse, NULL, PSMOUSE_CMD_RESET_DIS))
-		return -1;
-
-/*
- * Next, we check if it's a mouse. It should send 0x00 or 0x03
+ * First, we check if it's a mouse. It should send 0x00 or 0x03
  * in case of an IntelliMouse in 4-byte mode or 0x04 for IM Explorer.
  */
 
@@ -490,10 +469,22 @@
 	if (psmouse_command(psmouse, param, PSMOUSE_CMD_GETID))
 		return -1;
 
+	if (param[0] == 0xab || param[0] == 0xac) {
+		psmouse_command(psmouse, param, PSMOUSE_CMD_GETID2);
+		return -1;
+	}
+
 	if (param[0] != 0x00 && param[0] != 0x03 && param[0] != 0x04)
 		return -1;
 
 /*
+ * Then we reset and disable the mouse so that it doesn't generate events.
+ */
+
+	if (psmouse_command(psmouse, NULL, PSMOUSE_CMD_RESET_DIS))
+		return -1;
+
+/*
  * And here we try to determine if it has any extensions over the
  * basic PS/2 3-button mouse.
  */
@@ -602,9 +593,9 @@
 	psmouse->dev.name = psmouse->devname;
 	psmouse->dev.phys = psmouse->phys;
 	psmouse->dev.id.bustype = BUS_I8042;
-	psmouse->dev.id.vendor = psmouse->type;
-	psmouse->dev.id.product = psmouse->model;
-	psmouse->dev.id.version = 0x0100;
+	psmouse->dev.id.vendor = 0x0002;
+	psmouse->dev.id.product = psmouse->type;
+	psmouse->dev.id.version = psmouse->model;
 
 	input_register_device(&psmouse->dev);
 	
diff -Nru a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
--- a/drivers/input/serio/i8042.c	Wed Aug 28 19:50:15 2002
+++ b/drivers/input/serio/i8042.c	Wed Aug 28 19:50:15 2002
@@ -23,7 +23,7 @@
 
 #include "i8042.h"
 
-MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
+MODULE_AUTHOR("Vojtech Pavlik <vojtech@suse.cz>");
 MODULE_DESCRIPTION("i8042 keyboard and mouse controller driver");
 MODULE_LICENSE("GPL");
 
@@ -347,6 +347,11 @@
 	unsigned long flags;
 	unsigned char str, data;
 	unsigned int dfl;
+	struct {
+		int data;
+		int str;
+	} buffer[I8042_BUFFER_SIZE];
+	int i, j = 0;
 
 #ifdef CONFIG_VT
 	kbd_pt_regs = regs;
@@ -354,20 +359,31 @@
 
 	spin_lock_irqsave(&i8042_lock, flags);
 
-	while ((str = i8042_read_status()) & I8042_STR_OBF) {
+	while (j < I8042_BUFFER_SIZE && 
+	    (buffer[j].str = i8042_read_status()) & I8042_STR_OBF)
+		buffer[j++].data = i8042_read_data();
+
+	spin_unlock_irqrestore(&i8042_lock, flags);
+
+	for (i = 0; i < j; i++) {
+
+		str = buffer[i].str;
+		data = buffer[i].data;
 
-		data = i8042_read_data();
 		dfl = ((str & I8042_STR_PARITY) ? SERIO_PARITY : 0) |
 		      ((str & I8042_STR_TIMEOUT) ? SERIO_TIMEOUT : 0);
 
 #ifdef I8042_DEBUG_IO
-		printk(KERN_DEBUG "i8042.c: %02x <- i8042 (interrupt, %s, %d) [%d]\n",
-			data, (str & I8042_STR_AUXDATA) ? "aux" : "kbd", irq, (int) (jiffies - i8042_start));
+		printk(KERN_DEBUG "i8042.c: %02x <- i8042 (interrupt, %s, %d%s%s) [%d]\n",
+			data, (str & I8042_STR_AUXDATA) ? "aux" : "kbd", irq, 
+			dfl & SERIO_PARITY ? ", bad parity" : "",
+			dfl & SERIO_TIMEOUT ? ", timeout" : "",
+			(int) (jiffies - i8042_start));
 #endif
 
-		if (i8042_aux_values.exists && (str & I8042_STR_AUXDATA)) {
-			serio_interrupt(&i8042_aux_port, data, dfl);
-		} else {
+		if (i8042_aux_values.exists && (buffer[i].str & I8042_STR_AUXDATA)) {
+			serio_interrupt(&i8042_aux_port, buffer[i].data, dfl);
+		} else 
 			if (i8042_kbd_values.exists) {
 				if (!i8042_direct) {
 					if (data > 0x7f) {
@@ -385,10 +401,8 @@
 				}
 				serio_interrupt(&i8042_kbd_port, data, dfl);
 			}
-		}
 	}
 
-	spin_unlock_irqrestore(&i8042_lock, flags);
 }
 
 /*

===================================================================

This BitKeeper patch contains the following changesets:
+
## Wrapped with gzip_uu ##


begin 664 bkpatch19689
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
DC+@1P[>%PQRZP<I_+R=2*S+QWE!QFT//4LO_!H&S[+&<)P``
`
end

--oyUTqETQ0mS9luUI--
