Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262592AbSJHNgd>; Tue, 8 Oct 2002 09:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262923AbSJHNgd>; Tue, 8 Oct 2002 09:36:33 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:36500 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S262592AbSJHNgH>;
	Tue, 8 Oct 2002 09:36:07 -0400
Date: Tue, 8 Oct 2002 15:41:32 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [patch] Input - Support for PS/2 Multiplexing spec [4/23]
Message-ID: <20021008154132.C18546@ucw.cz>
References: <20021008153813.A18515@ucw.cz> <20021008153926.A18546@ucw.cz> <20021008154029.B18546@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021008154029.B18546@ucw.cz>; from vojtech@suse.cz on Tue, Oct 08, 2002 at 03:40:29PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.
'bk pull bk://linux-input.bkbits.net/linux-input' should work as well.

===================================================================

ChangeSet@1.573.1.33, 2002-09-24 18:48:50+02:00, vojtech@suse.cz
  Add support for PS/2 Active Multiplexing Spec, updates for PS/2 mouse
  and keyboard handling - proper cleanup on reboot, allow USB-emulated
  AT keyboards, option to restrict PS/2 mouse to generic mode.


 drivers/input/keyboard/atkbd.c      |   86 ++++++---
 drivers/input/mouse/psmouse.c       |   42 ++++
 drivers/input/serio/i8042-io.h      |    9 -
 drivers/input/serio/i8042-ppcio.h   |   12 -
 drivers/input/serio/i8042-sparcio.h |   13 -
 drivers/input/serio/i8042.c         |  321 ++++++++++++++++++++++++------------
 drivers/input/serio/i8042.h         |   25 ++
 include/linux/serio.h               |   12 +
 8 files changed, 361 insertions(+), 159 deletions(-)

===================================================================

diff -Nru a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c	Tue Oct  8 15:27:18 2002
+++ b/drivers/input/keyboard/atkbd.c	Tue Oct  8 15:27:18 2002
@@ -22,9 +22,15 @@
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@suse.cz>");
 MODULE_DESCRIPTION("AT and PS/2 keyboard driver");
 MODULE_PARM(atkbd_set, "1i");
+MODULE_PARM(atkbd_reset, "1i");
 MODULE_LICENSE("GPL");
 
 static int atkbd_set = 2;
+#if defined(__i386__) || defined (__x86_64__)
+static int atkbd_reset;
+#else
+static int atkbd_reset = 1;
+#endif
 
 /*
  * Scancode to keycode tables. These are just the default setting, and
@@ -89,6 +95,7 @@
 #define ATKBD_CMD_RESEND	0x00fe
 #define ATKBD_CMD_EX_ENABLE	0x10ea
 #define ATKBD_CMD_EX_SETLEDS	0x20eb
+#define ATKBD_CMD_OK_GETID	0x02e8
 
 #define ATKBD_RET_ACK		0xfa
 #define ATKBD_RET_NAK		0xfe
@@ -113,6 +120,7 @@
 	unsigned char cmdbuf[4];
 	unsigned char cmdcnt;
 	unsigned char set;
+	unsigned char oldset;
 	unsigned char release;
 	signed char ack;
 	unsigned char emul;
@@ -134,7 +142,6 @@
 	printk(KERN_DEBUG "atkbd.c: Received %02x flags %02x\n", data, flags);
 #endif
 
-	/* Interface error.  Request that the keyboard resend. */
 	if ((flags & (SERIO_FRAME | SERIO_PARITY)) && (~flags & SERIO_TIMEOUT) && atkbd->write) {
 		printk("atkbd.c: frame/parity error: %02x\n", flags);
 		serio_write(serio, ATKBD_CMD_RESEND);
@@ -205,7 +212,9 @@
 #ifdef ATKBD_DEBUG
 	printk(KERN_DEBUG "atkbd.c: Sent: %02x\n", byte);
 #endif
-	serio_write(atkbd->serio, byte);
+	if (serio_write(atkbd->serio, byte))
+		return -1;
+
 	while (!atkbd->ack && timeout--) udelay(10);
 
 	return -(atkbd->ack <= 0);
@@ -289,34 +298,41 @@
 
 static int atkbd_set_3(struct atkbd *atkbd)
 {
-	unsigned char param;
+	unsigned char param[2];
+
+/*
+ * Remember original scancode set value, so that we can restore it on exit.
+ */
+
+	if (atkbd_command(atkbd, &atkbd->oldset, ATKBD_CMD_GSCANSET))
+		atkbd->oldset = 2;
 
 /*
  * For known special keyboards we can go ahead and set the correct set.
+ * We check for NCD PS/2 Sun, NorthGate OmniKey 101 and IBM RapidAccess
+ * keyboards.
  */
 
 	if (atkbd->id == 0xaca1) {
-		param = 3;
-		atkbd_command(atkbd, &param, ATKBD_CMD_SSCANSET);
+		param[0] = 3;
+		atkbd_command(atkbd, param, ATKBD_CMD_SSCANSET);
 		return 3;
 	}
 
-/*
- * We check for the extra keys on an some keyboards that need extra
- * command to get enabled. This shouldn't harm any keyboards not
- * knowing the command.
- */
+	if (!atkbd_command(atkbd, param, ATKBD_CMD_OK_GETID)) {
+		atkbd->id = param[0] << 8 | param[1];
+		return 2;
+	}
 
-	param = 0x71;
-	if (!atkbd_command(atkbd, &param, ATKBD_CMD_EX_ENABLE))
+	param[0] = 0x71;
+	if (!atkbd_command(atkbd, param, ATKBD_CMD_EX_ENABLE))
 		return 4;
 
 /*
  * Try to set the set we want.
  */
 
-	param = atkbd_set;
-	if (atkbd_command(atkbd, &param, ATKBD_CMD_SSCANSET))
+	if (atkbd_command(atkbd, &atkbd_set, ATKBD_CMD_SSCANSET))
 		return 2;
 
 /*
@@ -327,8 +343,8 @@
  * In that case we time out, and return 2.
  */
 
-	param = 0;
-	if (atkbd_command(atkbd, &param, ATKBD_CMD_GSCANSET))
+	param[0] = 0;
+	if (atkbd_command(atkbd, param, ATKBD_CMD_GSCANSET))
 		return 2;
 
 /*
@@ -336,7 +352,7 @@
  * itself.
  */
 
-	return (param == 3) ? 3 : 2;
+	return (param[0] == 3) ? 3 : 2;
 }
 
 /*
@@ -353,10 +369,9 @@
  * these systems the BIOS also usually doesn't do it for us.
  */
 
-#ifdef CONFIG_KEYBOARD_ATKBD_RESET
-	if (atkbd_command(atkbd, NULL, ATKBD_CMD_RESET_BAT))
-		printk(KERN_WARNING "atkbd.c: keyboard reset failed\n");
-#endif
+	if (atkbd_reset)
+		if (atkbd_command(atkbd, NULL, ATKBD_CMD_RESET_BAT))
+			printk(KERN_WARNING "atkbd.c: keyboard reset failed\n");
 
 /*
  * Next we check we can set LEDs on the keyboard. This should work on every
@@ -405,7 +420,18 @@
 }
 
 /*
- * atkbd_disconnect() cleans up behind us ...
+ * atkbd_cleanup() restores the keyboard state so that BIOS is happy after a
+ * reboot.
+ */
+
+static void atkbd_cleanup(struct serio *serio)
+{
+	struct atkbd *atkbd = serio->private;
+	atkbd_command(atkbd, &atkbd->oldset, ATKBD_CMD_SSCANSET);
+}
+
+/*
+ * atkbd_disconnect() closes and frees.
  */
 
 static void atkbd_disconnect(struct serio *serio)
@@ -508,18 +534,28 @@
 static struct serio_dev atkbd_dev = {
 	.interrupt =	atkbd_interrupt,
 	.connect =	atkbd_connect,
-	.disconnect =	atkbd_disconnect
+	.disconnect =	atkbd_disconnect,
+	.cleanup =	atkbd_cleanup,
 };
 
 #ifndef MODULE
-static int __init atkbd_setup(char *str)
+static int __init atkbd_setup_set(char *str)
 {
         int ints[4];
         str = get_options(str, ARRAY_SIZE(ints), ints);
         if (ints[0] > 0) atkbd_set = ints[1];
         return 1;
 }
-__setup("atkbd_set=", atkbd_setup);
+static int __init atkbd_setup_reset(char *str)
+{
+        int ints[4];
+        str = get_options(str, ARRAY_SIZE(ints), ints);
+        if (ints[0] > 0) atkbd_reset = ints[1];
+        return 1;
+}
+
+__setup("atkbd_set=", atkbd_setup_set);
+__setup("atkbd_reset", atkbd_setup_reset);
 #endif
 
 int __init atkbd_init(void)
diff -Nru a/drivers/input/mouse/psmouse.c b/drivers/input/mouse/psmouse.c
--- a/drivers/input/mouse/psmouse.c	Tue Oct  8 15:27:18 2002
+++ b/drivers/input/mouse/psmouse.c	Tue Oct  8 15:27:18 2002
@@ -21,8 +21,11 @@
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@suse.cz>");
 MODULE_DESCRIPTION("PS/2 mouse driver");
+MODULE_PARM(psmouse_noext, "1i");
 MODULE_LICENSE("GPL");
 
+static int psmouse_noext;
+
 #define PSMOUSE_CMD_SETSCALE11	0x00e6
 #define PSMOUSE_CMD_SETRES	0x10e8
 #define PSMOUSE_CMD_GETINFO	0x03e9
@@ -33,6 +36,7 @@
 #define PSMOUSE_CMD_SETRATE	0x10f3
 #define PSMOUSE_CMD_ENABLE	0x00f4
 #define PSMOUSE_CMD_RESET_DIS	0x00f6
+#define PSMOUSE_CMD_RESET_BAT	0x02ff
 
 #define PSMOUSE_RET_BAT		0xaa
 #define PSMOUSE_RET_ACK		0xfa
@@ -222,7 +226,11 @@
 	psmouse->ack = 0;
 	psmouse->acking = 1;
 
-	serio_write(psmouse->serio, byte);
+	if (serio_write(psmouse->serio, byte)) {
+		psmouse->acking = 0;
+		return -1;
+	}
+
 	while (!psmouse->ack && timeout--) udelay(10);
 
 	return -(psmouse->ack <= 0);
@@ -302,6 +310,9 @@
 	psmouse->name = "Mouse";
 	psmouse->model = 0;
 
+	if (psmouse_noext)
+		return PSMOUSE_PS2;
+
 /*
  * Try Genius NetMouse magic init.
  */
@@ -529,15 +540,24 @@
  * Last, we enable the mouse so that we get reports from it.
  */
 
-	if (psmouse_command(psmouse, NULL, PSMOUSE_CMD_ENABLE)) {
+	if (psmouse_command(psmouse, NULL, PSMOUSE_CMD_ENABLE))
 		printk(KERN_WARNING "psmouse.c: Failed to enable mouse on %s\n", psmouse->serio->phys);
-	}
 
 }
 
 /*
- * psmouse_disconnect() cleans up after we don't want talk
- * to the mouse anymore.
+ * psmouse_cleanup() resets the mouse into power-on state.
+ */
+
+static void psmouse_cleanup(struct serio *serio)
+{
+	struct psmouse *psmouse = serio->private;
+	unsigned char param[2];
+	psmouse_command(psmouse, param, PSMOUSE_CMD_RESET_BAT);
+}
+
+/*
+ * psmouse_disconnect() closes and frees.
  */
 
 static void psmouse_disconnect(struct serio *serio)
@@ -607,8 +627,18 @@
 static struct serio_dev psmouse_dev = {
 	.interrupt =	psmouse_interrupt,
 	.connect =	psmouse_connect,
-	.disconnect =	psmouse_disconnect
+	.disconnect =	psmouse_disconnect,
+	.cleanup =	psmouse_cleanup,
 };
+
+#ifndef MODULE
+static int __init psmouse_setup(char *str)
+{
+	psmouse_noext = 1;
+	return 1;
+}
+__setup("psmouse_noext", psmouse_setup);
+#endif
 
 int __init psmouse_init(void)
 {
diff -Nru a/drivers/input/serio/i8042-io.h b/drivers/input/serio/i8042-io.h
--- a/drivers/input/serio/i8042-io.h	Tue Oct  8 15:27:18 2002
+++ b/drivers/input/serio/i8042-io.h	Tue Oct  8 15:27:18 2002
@@ -13,6 +13,7 @@
 
 #define I8042_KBD_PHYS_DESC "isa0060/serio0"
 #define I8042_AUX_PHYS_DESC "isa0060/serio1"
+#define I8042_MUX_PHYS_DESC "isa0060/serio%d"
 
 /*
  * IRQs.
@@ -64,9 +65,13 @@
  */
 #if !defined(__i386__) && !defined(__sh__) && !defined(__alpha__) && !defined(__x86_64__)
 	if (!request_region(I8042_DATA_REG, 16, "i8042"))
-		return 0;
+		return -1;
 #endif
-	return 1;
+
+#if !defined(__i386__) && !defined(__x86_64__)
+        i8042_reset = 1;
+#endif
+	return 0;
 }
 
 static inline void i8042_platform_exit(void)
diff -Nru a/drivers/input/serio/i8042-ppcio.h b/drivers/input/serio/i8042-ppcio.h
--- a/drivers/input/serio/i8042-ppcio.h	Tue Oct  8 15:27:18 2002
+++ b/drivers/input/serio/i8042-ppcio.h	Tue Oct  8 15:27:18 2002
@@ -14,6 +14,7 @@
 
 #define I8042_KBD_PHYS_DESC "walnutps2/serio0"
 #define I8042_AUX_PHYS_DESC "walnutps2/serio1"
+#define I8042_MUX_PHYS_DESC "walnutps2/serio%d"
 
 extern void *kb_cs;
 extern void *kb_data;
@@ -34,18 +35,17 @@
 static inline void i8042_write_data(int val)
 {
 	writeb(val, kb_data);
-	return;
 }
 
 static inline void i8042_write_command(int val)
 {
 	writeb(val, kb_cs);
-	return;
 }
 
 static inline int i8042_platform_init(void)
 {
-	return 1;
+	i8042_reset = 1;
+	return 0;
 }
 
 static inline void i8042_platform_exit(void)
@@ -59,6 +59,7 @@
 
 #define I8042_KBD_PHYS_DESC "spruceps2/serio0"
 #define I8042_AUX_PHYS_DESC "spruceps2/serio1"
+#define I8042_MUX_PHYS_DESC "spruceps2/serio%d"
 
 #define I8042_COMMAND_REG 0xff810000
 #define I8042_DATA_REG 0xff810001
@@ -109,18 +110,17 @@
 static inline void i8042_write_data(int val)
 {
 	*((unsigned char *)0xff810000) = (char)val;
-	return;
 }
 
 static inline void i8042_write_command(int val)
 {
 	*((unsigned char *)0xff810001) = (char)val;
-	return;
 }
 
 static inline int i8042_platform_init(void)
 {
-	return 1;
+	i8042_reset = 1;
+	return 0;
 }
 
 static inline void i8042_platform_exit(void)
diff -Nru a/drivers/input/serio/i8042-sparcio.h b/drivers/input/serio/i8042-sparcio.h
--- a/drivers/input/serio/i8042-sparcio.h	Tue Oct  8 15:27:18 2002
+++ b/drivers/input/serio/i8042-sparcio.h	Tue Oct  8 15:27:18 2002
@@ -11,6 +11,7 @@
 
 #define I8042_KBD_PHYS_DESC "sparcps2/serio0"
 #define I8042_AUX_PHYS_DESC "sparcps2/serio1"
+#define I8042_MUX_PHYS_DESC "sparcps2/serio%d"
 
 static unsigned long kbd_iobase;
 
@@ -50,14 +51,14 @@
 	len = prom_getproperty(prom_root_node, "name", prop, sizeof(prop));
 	if (len < 0) {
 		printk("i8042: Cannot get name property of root OBP node.\n");
-		return 0;
+		return -1;
 	}
 	if (strncmp(prop, "SUNW,JavaStation-1", len) == 0) {
 		/* Hardcoded values for MrCoffee.  */
 		i8042_kbd_irq = i8042_aux_irq = 13 | 0x20;
 		kbd_iobase = (unsigned long) ioremap(0x71300060, 8);
 		if (!kbd_iobase)
-			return 0;
+			return -1;
 	} else {
 		struct linux_ebus *ebus;
 		struct linux_ebus_device *edev;
@@ -69,7 +70,7 @@
 					goto edev_found;
 			}
 		}
-		return 0;
+		return -1;
 
 	edev_found:
 		for_each_edevchild(edev, child) {
@@ -87,11 +88,13 @@
 		    i8042_aux_irq == -1) {
 			printk("i8042: Error, 8042 device lacks both kbd and "
 			       "mouse nodes.\n");
-			return 0;
+			return -1;
 		}
 	}
 
-	return 1;
+	i8042_reset = 1;
+
+	return 0;
 }
 
 static inline void i8042_platform_exit(void)
diff -Nru a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
--- a/drivers/input/serio/i8042.c	Tue Oct  8 15:27:18 2002
+++ b/drivers/input/serio/i8042.c	Tue Oct  8 15:27:18 2002
@@ -19,7 +19,9 @@
 #include <linux/reboot.h>
 #include <linux/init.h>
 #include <linux/serio.h>
-#include <linux/sched.h>	/* request/free_irq */
+#include <linux/sched.h>
+
+#undef DEBUG
 
 #include "i8042.h"
 
@@ -31,13 +33,13 @@
 MODULE_PARM(i8042_unlock, "1i");
 MODULE_PARM(i8042_reset, "1i");
 MODULE_PARM(i8042_direct, "1i");
-MODULE_PARM(i8042_restore_ctr, "1i");
+MODULE_PARM(i8042_dumbkbd, "1i");
 
 static int i8042_noaux;
 static int i8042_unlock;
 static int i8042_reset;
 static int i8042_direct;
-static int i8042_restore_ctr;
+static int i8042_dumbkbd;
 
 spinlock_t i8042_lock = SPIN_LOCK_UNLOCKED;
 
@@ -46,6 +48,7 @@
 	unsigned char disable;
 	unsigned char irqen;
 	unsigned char exists;
+	signed char mux;
 	unsigned char *name;
 	unsigned char *phys;
 };
@@ -55,12 +58,9 @@
 static unsigned char i8042_initial_ctr;
 static unsigned char i8042_ctr;
 static unsigned char i8042_last_e0;
+static unsigned char i8042_mux_open;
 struct timer_list i8042_timer;
 
-#ifdef I8042_DEBUG_IO
-static unsigned long i8042_start;
-#endif
-
 extern struct pt_regs *kbd_pt_regs;
 
 static unsigned long i8042_unxlate_seen[128 / BITS_PER_LONG];
@@ -110,18 +110,16 @@
 static int i8042_flush(void)
 {
 	unsigned long flags;
+	unsigned char data;
 	int i = 0;
 
 	spin_lock_irqsave(&i8042_lock, flags);
 
-	while ((i8042_read_status() & I8042_STR_OBF) && (i++ < I8042_BUFFER_SIZE))
-#ifdef I8042_DEBUG_IO
-		printk(KERN_DEBUG "i8042.c: %02x <- i8042 (flush, %s) [%d]\n",
-			i8042_read_data(), i8042_read_status() & I8042_STR_AUXDATA ? "aux" : "kbd",
-			(int) (jiffies - i8042_start));
-#else
-		i8042_read_data();
-#endif
+	while ((i8042_read_status() & I8042_STR_OBF) && (i++ < I8042_BUFFER_SIZE)) {
+		data = i8042_read_data();
+		dbg("%02x <- i8042 (flush, %s)", data,
+			i8042_read_status() & I8042_STR_AUXDATA ? "aux" : "kbd");
+	}
 
 	spin_unlock_irqrestore(&i8042_lock, flags);
 
@@ -145,20 +143,14 @@
 
 	retval = i8042_wait_write();
 	if (!retval) {
-#ifdef I8042_DEBUG_IO
-		printk(KERN_DEBUG "i8042.c: %02x -> i8042 (command) [%d]\n",
-			command & 0xff, (int) (jiffies - i8042_start));
-#endif
+		dbg("%02x -> i8042 (command)", command & 0xff);
 		i8042_write_command(command & 0xff);
 	}
 	
 	if (!retval)
 		for (i = 0; i < ((command >> 12) & 0xf); i++) {
 			if ((retval = i8042_wait_write())) break;
-#ifdef I8042_DEBUG_IO
-			printk(KERN_DEBUG "i8042.c: %02x -> i8042 (parameter) [%d]\n",
-				param[i], (int) (jiffies - i8042_start));
-#endif
+			dbg("%02x -> i8042 (parameter)", param[i]);
 			i8042_write_data(param[i]);
 		}
 
@@ -169,19 +161,13 @@
 				param[i] = ~i8042_read_data();
 			else
 				param[i] = i8042_read_data();
-#ifdef I8042_DEBUG_IO
-			printk(KERN_DEBUG "i8042.c: %02x <- i8042 (return) [%d]\n",
-				param[i], (int) (jiffies - i8042_start));
-#endif
+			dbg("%02x <- i8042 (return)\n", param[i]);
 		}
 
 	spin_unlock_irqrestore(&i8042_lock, flags);
 
-#ifdef I8042_DEBUG_IO
 	if (retval)
-		printk(KERN_DEBUG "i8042.c:      -- i8042 (timeout) [%d]\n",
-			(int) (jiffies - i8042_start));
-#endif
+		dbg("     -- i8042 (timeout)");
 
 	return retval;
 }
@@ -198,10 +184,7 @@
 	spin_lock_irqsave(&i8042_lock, flags);
 
 	if(!(retval = i8042_wait_write())) {
-#ifdef I8042_DEBUG_IO
-		printk(KERN_DEBUG "i8042.c: %02x -> i8042 (kbd-data) [%d]\n",
-			c, (int) (jiffies - i8042_start));
-#endif
+		dbg("%02x -> i8042 (kbd-data)", c);
 		i8042_write_data(c);
 	}
 
@@ -216,21 +199,17 @@
 
 static int i8042_aux_write(struct serio *port, unsigned char c)
 {
+	struct i8042_values *values = port->driver;
 	int retval;
 
 /*
  * Send the byte out.
  */
 
-	retval  = i8042_command(&c, I8042_CMD_AUX_SEND);
-
-/*
- * Here we restore the CTR value if requested. I don't know why, but i8042's in
- * half-AT mode tend to trash their CTR when doing the AUX_SEND command. 
- */
-
-	if (i8042_restore_ctr)
-		retval |= i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR);
+	if (values->mux == -1)
+		retval = i8042_command(&c, I8042_CMD_AUX_SEND);
+	else
+		retval = i8042_command(&c, I8042_CMD_MUX_SEND + values->mux);
 
 /*
  * Make sure the interrupt happens and the character is received even
@@ -242,6 +221,7 @@
 	return retval;
 }
 
+
 /*
  * i8042_open() is called when a port is open by the higher layer.
  * It allocates the interrupt and enables in in the chip.
@@ -253,6 +233,10 @@
 
 	i8042_flush();
 
+	if (values->mux != -1)
+		if (i8042_mux_open++)
+			return 0;
+
 	if (request_irq(values->irq, i8042_interrupt, 0, "i8042", NULL)) {
 		printk(KERN_ERR "i8042.c: Can't get irq %d for %s, unregistering the port.\n", values->irq, values->name);
 		values->exists = 0;
@@ -282,6 +266,10 @@
 {
 	struct i8042_values *values = port->driver;
 
+	if (values->mux != -1)
+		if (--i8042_mux_open)
+			return;
+
 	i8042_ctr &= ~values->irqen;
 
 	if (i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR)) {
@@ -299,11 +287,11 @@
  */
 
 static struct i8042_values i8042_kbd_values = {
-	.irq =		0,
+	.irq =		I8042_KBD_IRQ,
 	.irqen =	I8042_CTR_KBDINT,
 	.disable =	I8042_CTR_KBDDIS,
 	.name =		"KBD",
-	.exists =	0,
+	.mux =		-1,
 };
 
 static struct serio i8042_kbd_port =
@@ -318,11 +306,11 @@
 };
 
 static struct i8042_values i8042_aux_values = {
-	.irq =		0,
+	.irq =		I8042_AUX_IRQ,
 	.irqen =	I8042_CTR_AUXINT,
 	.disable =	I8042_CTR_AUXDIS,
 	.name =		"AUX",
-	.exists =	0,
+	.mux =		-1,
 };
 
 static struct serio i8042_aux_port =
@@ -336,6 +324,12 @@
 	.phys =		I8042_AUX_PHYS_DESC,
 };
 
+static struct i8042_values i8042_mux_values[4];
+static struct serio i8042_mux_port[4];
+static char i8042_mux_names[4][16];
+static char i8042_mux_short[4][8];
+static char i8042_mux_phys[4][32];
+
 /*
  * i8042_interrupt() is the most important function in this driver -
  * it handles the interrupts from the i8042, and sends incoming bytes
@@ -373,34 +367,60 @@
 		dfl = ((str & I8042_STR_PARITY) ? SERIO_PARITY : 0) |
 		      ((str & I8042_STR_TIMEOUT) ? SERIO_TIMEOUT : 0);
 
-#ifdef I8042_DEBUG_IO
-		printk(KERN_DEBUG "i8042.c: %02x <- i8042 (interrupt, %s, %d%s%s) [%d]\n",
+		if (i8042_mux_values[0].exists && (buffer[i].str & I8042_STR_AUXDATA)) {
+
+			if (buffer[i].str & I8042_STR_MUXERR) {
+				switch (buffer[i].data) {
+					case 0xfd:
+					case 0xfe: dfl = SERIO_TIMEOUT; break;
+					case 0xff: dfl = SERIO_PARITY; break;
+				}
+				buffer[i].data = 0xfe;
+			} else dfl = 0;
+
+			dbg("%02x <- i8042 (interrupt, aux%d, %d%s%s)",
+				data, (str >> 6), irq, 
+				dfl & SERIO_PARITY ? ", bad parity" : "",
+				dfl & SERIO_TIMEOUT ? ", timeout" : "");
+
+			if (i8042_mux_values[(str >> 6)].exists)
+				serio_interrupt(i8042_mux_port + (str >> 6), buffer[i].data, dfl);
+			continue;
+		}
+
+		dbg("%02x <- i8042 (interrupt, %s, %d%s%s)",
 			data, (str & I8042_STR_AUXDATA) ? "aux" : "kbd", irq, 
 			dfl & SERIO_PARITY ? ", bad parity" : "",
-			dfl & SERIO_TIMEOUT ? ", timeout" : "",
-			(int) (jiffies - i8042_start));
-#endif
+			dfl & SERIO_TIMEOUT ? ", timeout" : "");
 
 		if (i8042_aux_values.exists && (buffer[i].str & I8042_STR_AUXDATA)) {
 			serio_interrupt(&i8042_aux_port, buffer[i].data, dfl);
-		} else 
-			if (i8042_kbd_values.exists) {
-				if (!i8042_direct) {
-					if (data > 0x7f) {
-						if (test_and_clear_bit(data & 0x7f, i8042_unxlate_seen)) {
-							serio_interrupt(&i8042_kbd_port, 0xf0, dfl);
-							if (i8042_last_e0 && (data == 0xaa || data == 0xb6))
-								set_bit(data & 0x7f, i8042_unxlate_seen);
-							data = i8042_unxlate_table[data & 0x7f];
-						}
-					} else {
-						set_bit(data, i8042_unxlate_seen);
-						data = i8042_unxlate_table[data];
-					}
-					i8042_last_e0 = (data == 0xe0);
-				}
-				serio_interrupt(&i8042_kbd_port, data, dfl);
+			continue;
+		}
+
+		if (!i8042_kbd_values.exists)
+			continue;
+
+		if (i8042_direct) {
+			serio_interrupt(&i8042_kbd_port, data, dfl);
+			continue;
+		}
+
+		if (data > 0x7f) {
+			if (test_and_clear_bit(data & 0x7f, i8042_unxlate_seen)) {
+				serio_interrupt(&i8042_kbd_port, 0xf0, dfl);
+				if (i8042_last_e0 && (data == 0xaa || data == 0xb6))
+					set_bit(data & 0x7f, i8042_unxlate_seen);
+				data = i8042_unxlate_table[data & 0x7f];
 			}
+		} else {
+			set_bit(data, i8042_unxlate_seen);
+			data = i8042_unxlate_table[data];
+		}
+
+		i8042_last_e0 = (data == 0xe0);
+
+		serio_interrupt(&i8042_kbd_port, data, dfl);
 	}
 
 }
@@ -460,17 +480,15 @@
  */
 
 	if (~i8042_read_status() & I8042_STR_KEYLOCK) {
-
-		if (i8042_unlock) {
+		if (i8042_unlock)
 			i8042_ctr |= I8042_CTR_IGNKEYLOCK;
-		} else {
+		 else
 			printk(KERN_WARNING "i8042.c: Warning: Keylock active.\n");
-		}
 	}
 
 /*
  * If the chip is configured into nontranslated mode by the BIOS, don't
- * bother enabling translating and just use that happily.
+ * bother enabling translating and be happy.
  */
 
 	if (~i8042_ctr & I8042_CTR_XLATE)
@@ -478,10 +496,9 @@
 
 /*
  * Set nontranslated mode for the kbd interface if requested by an option.
- * This is vital for a working scancode set 3 support. After this the kbd
- * interface becomes a simple serial in/out, like the aux interface is. If
- * the user doesn't wish this, the driver tries to untranslate the values
- * after the i8042 translates them.
+ * After this the kbd interface becomes a simple serial in/out, like the aux
+ * interface is. We don't do this by default, since it can confuse notebook
+ * BIOSes.
  */
 
 	if (i8042_direct)
@@ -506,10 +523,25 @@
 
 void i8042_controller_cleanup(void)
 {
+	int i;
 
 	i8042_flush();
 
 /*
+ * Reset anything that is connected to the ports.
+ */
+
+	if (i8042_kbd_values.exists)
+		serio_cleanup(&i8042_kbd_port);
+
+	if (i8042_aux_values.exists)
+		serio_cleanup(&i8042_aux_port);
+
+	for (i = 0; i < 4; i++)
+		if (i8042_mux_values[i].exists)
+			serio_cleanup(i8042_mux_port + i);
+
+/*
  * Reset the controller.
  */
 
@@ -529,16 +561,72 @@
 	if (i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR))
 		printk(KERN_WARNING "i8042.c: Can't restore CTR.\n");
 
+}
+
 /*
- * Reset anything that is connected to the ports if the ports
- * are enabled in the original config.
+ * i8042_check_mux() checks whether the controller supports the PS/2 Active
+ * Multiplexing specification by Synaptics, Phoenix, Insyde and
+ * LCS/Telegraphics.
  */
 
-	if (i8042_kbd_values.exists)
-		i8042_kbd_write(&i8042_kbd_port, 0xff);
+static int __init i8042_check_mux(struct i8042_values *values)
+{
+	unsigned char param;
+	int i;
 
-	if (i8042_aux_values.exists)
-		i8042_aux_write(&i8042_aux_port, 0xff);
+/*
+ * Check if AUX irq is available.
+ */
+
+	if (request_irq(values->irq, i8042_interrupt, 0, "i8042", NULL))
+                return -1;
+	free_irq(values->irq, NULL);
+
+/*
+ * Get rid of bytes in the queue.
+ */
+
+	i8042_flush();
+
+/*
+ * Internal loopback test - send three bytes, they should come back from the
+ * mouse interface, the last should be version. Note that we negate mouseport
+ * command responses for the i8042_check_aux() routine.
+ */
+
+	param = 0xf0;
+	if (i8042_command(&param, I8042_CMD_AUX_LOOP) || param != 0x0f)
+		return -1;
+	param = 0x56;
+	if (i8042_command(&param, I8042_CMD_AUX_LOOP) || param != 0xa9)
+		return -1;
+	param = 0xa4;
+	if (i8042_command(&param, I8042_CMD_AUX_LOOP) || param == 0x5b)
+		return -1;
+
+	printk(KERN_INFO "i8042.c: Detected active multiplexing controller, rev%d.%d.\n",
+		~param >> 4, ~param & 0xf);
+
+/*
+ * Disable all muxed ports by disabling AUX.
+ */
+
+	i8042_ctr &= I8042_CTR_AUXDIS;
+	i8042_ctr &= ~I8042_CTR_AUXINT;
+
+	if (i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR))
+		return -1;
+
+/*
+ * Enable all muxed ports.
+ */
+
+	for (i = 0; i < 4; i++) {
+		i8042_command(&param, I8042_CMD_MUX_PFX + i);
+		i8042_command(&param, I8042_CMD_AUX_ENABLE);
+	}
+
+	return 0;
 }
 
 /*
@@ -546,7 +634,7 @@
  * the presence of an AUX interface.
  */
 
-static int __init i8042_check_aux(struct i8042_values *values, struct serio *port)
+static int __init i8042_check_aux(struct i8042_values *values)
 {
 	unsigned char param;
 
@@ -570,7 +658,6 @@
  */
 
 	param = 0x5a;
-
 	if (i8042_command(&param, I8042_CMD_AUX_LOOP) || param != 0xa5)
 		return -1;
 
@@ -665,9 +752,9 @@
 	i8042_direct = 1;
 	return 1;
 }
-static int __init i8042_setup_restore_ctr(char *str)
+static int __init i8042_setup_dumbkbd(char *str)
 {
-	i8042_restore_ctr = 1;
+	i8042_dumbkbd = 1;
 	return 1;
 }
 
@@ -675,7 +762,7 @@
 __setup("i8042_noaux", i8042_setup_noaux);
 __setup("i8042_unlock", i8042_setup_unlock);
 __setup("i8042_direct", i8042_setup_direct);
-__setup("i8042_restore_ctr", i8042_setup_restore_ctr);
+__setup("i8042_dumbkbd", i8042_setup_dumbkbd);
 #endif
 
 /*
@@ -698,27 +785,43 @@
         0
 };
 
+static void __init i8042_init_mux_values(struct i8042_values *values, struct serio *port, int index)
+{
+	memcpy(port, &i8042_aux_port, sizeof(struct serio));
+	memcpy(values, &i8042_aux_values, sizeof(struct i8042_values));
+	sprintf(i8042_mux_names[index], "i8042 Aux-%d Port", index);
+	sprintf(i8042_mux_phys[index], I8042_MUX_PHYS_DESC, index + 1);
+	sprintf(i8042_mux_short[index], "AUX%d", index);
+	port->name = i8042_mux_names[index];
+	port->phys = i8042_mux_phys[index];
+	values->name = i8042_mux_short[index];
+	values->mux = index;
+}
+
 int __init i8042_init(void)
 {
-#ifdef I8042_DEBUG_IO
-	i8042_start = jiffies;
-#endif
+	int i;
 
-#if !defined(__i386__) && !defined(__x86_64__)
-	i8042_reset = 1;
-#endif
+	dbg_init();
 
-	if (!i8042_platform_init())
+	if (i8042_platform_init())
 		return -EBUSY;
 
-	i8042_kbd_values.irq = I8042_KBD_IRQ;
-	i8042_aux_values.irq = I8042_AUX_IRQ;
-
 	if (i8042_controller_init())
 		return -ENODEV;
-		
-	if (!i8042_noaux && !i8042_check_aux(&i8042_aux_values, &i8042_aux_port))
-		i8042_port_register(&i8042_aux_values, &i8042_aux_port);
+
+	if (i8042_dumbkbd)
+		i8042_kbd_port.write = NULL;
+
+	for (i = 0; i < 4; i++)
+		i8042_init_mux_values(i8042_mux_values + i, i8042_mux_port + i, i);
+
+	if (!i8042_noaux && !i8042_check_mux(&i8042_aux_values))
+		for (i = 0; i < 4; i++)
+			i8042_port_register(i8042_mux_values + i, i8042_mux_port + i);
+	else 
+		if (!i8042_noaux && !i8042_check_aux(&i8042_aux_values))
+			i8042_port_register(&i8042_aux_values, &i8042_aux_port);
 
 	i8042_port_register(&i8042_kbd_values, &i8042_kbd_port);
 
@@ -732,22 +835,26 @@
 
 void __exit i8042_exit(void)
 {
+	int i;
+
 	unregister_reboot_notifier(&i8042_notifier);
 
 	del_timer(&i8042_timer);
+
+	i8042_controller_cleanup();
 	
 	if (i8042_kbd_values.exists)
 		serio_unregister_port(&i8042_kbd_port);
 
 	if (i8042_aux_values.exists)
 		serio_unregister_port(&i8042_aux_port);
-
-	i8042_controller_cleanup();
+	
+	for (i = 0; i < 4; i++)
+		if (i8042_mux_values[i].exists)
+			serio_unregister_port(i8042_mux_port + i);
 
 	i8042_platform_exit();
 }
 
 module_init(i8042_init);
 module_exit(i8042_exit);
-
-
diff -Nru a/drivers/input/serio/i8042.h b/drivers/input/serio/i8042.h
--- a/drivers/input/serio/i8042.h	Tue Oct  8 15:27:18 2002
+++ b/drivers/input/serio/i8042.h	Tue Oct  8 15:27:18 2002
@@ -22,13 +22,6 @@
 #endif
 
 /*
- * If you want to trace all the i/o the i8042 module does for
- * debugging purposes, define this.
- */
-
-#undef I8042_DEBUG_IO
-
-/*
  * This is in 50us units, the time we wait for the i8042 to react. This
  * has to be long enough for the i8042 itself to timeout on sending a byte
  * to a non-existent mouse.
@@ -54,6 +47,7 @@
 #define I8042_STR_AUXDATA	0x20
 #define I8042_STR_KEYLOCK	0x10
 #define I8042_STR_CMDDAT	0x08
+#define I8042_STR_MUXERR	0x04
 #define I8042_STR_IBF		0x02
 #define	I8042_STR_OBF		0x01
 
@@ -87,6 +81,9 @@
 #define I8042_CMD_AUX_SEND	0x10d4
 #define I8042_CMD_AUX_LOOP	0x11d3
 
+#define I8042_CMD_MUX_PFX	0x0090
+#define I8042_CMD_MUX_SEND	0x1090
+
 /*
  * Return codes.
  */
@@ -99,5 +96,19 @@
  */
 
 #define I8042_BUFFER_SIZE	32
+
+/*
+ * Debug.
+ */
+
+#ifdef DEBUG
+static unsigned long i8042_start;
+#define dbg_init() do { i8042_start = jiffies; } while (0);
+#define dbg(format, arg...) printk(KERN_DEBUG __FILE__ ": " format "[%d]\n" ,\
+	 ## arg, (int) (jiffies - i8042_start))
+#else
+#define dbg_init() do { } while (0);
+#define dbg(format, arg...) do {} while (0)
+#endif
 
 #endif /* _I8042_H */
diff -Nru a/include/linux/serio.h b/include/linux/serio.h
--- a/include/linux/serio.h	Tue Oct  8 15:27:18 2002
+++ b/include/linux/serio.h	Tue Oct  8 15:27:18 2002
@@ -69,6 +69,7 @@
 	void (*interrupt)(struct serio *, unsigned char, unsigned int);
 	void (*connect)(struct serio *, struct serio_dev *dev);
 	void (*disconnect)(struct serio *);
+	void (*cleanup)(struct serio *);
 
 	struct serio_dev *next;
 };
@@ -85,13 +86,22 @@
 
 static __inline__ int serio_write(struct serio *serio, unsigned char data)
 {
-	return serio->write(serio, data);
+	if (serio->write)
+		return serio->write(serio, data);
+	else
+		return -1;
 }
 
 static __inline__ void serio_dev_write_wakeup(struct serio *serio)
 {
 	if (serio->dev && serio->dev->write_wakeup)
 		serio->dev->write_wakeup(serio);
+}
+
+static __inline__ void serio_cleanup(struct serio *serio)
+{
+	if (serio->dev && serio->dev->cleanup)
+		serio->dev->cleanup(serio);
 }
 
 /*

===================================================================

This BitKeeper patch contains the following changesets:
1.573.1.33
## Wrapped with gzip_uu ##


begin 664 bkpatch18386
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
IB?AQQ&.2/UM$I"X09^\<I?^O!B+9GM_L*UV7&_)(JO\?O))1_D)!````
`
end
