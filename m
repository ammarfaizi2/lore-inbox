Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317170AbSHTNeT>; Tue, 20 Aug 2002 09:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317189AbSHTNeT>; Tue, 20 Aug 2002 09:34:19 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:36773 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S317170AbSHTNeO>;
	Tue, 20 Aug 2002 09:34:14 -0400
Date: Tue, 20 Aug 2002 15:38:13 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [patch] Amiga input driver compile fixes
Message-ID: <20020820153813.A13034@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Geert fixed the input drivers on Amiga to at least compile properly.

===================================================================

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.
'bk pull bk://linux-input.bkbits.net/linux-input' should work as well.

===================================================================

ChangeSet@1.490, 2002-08-19 11:20:09+02:00, geert@linux-m68k.org
  Compile fixes for Amiga input drivers


 joystick/Config.help |    4 ++--
 joystick/Config.in   |    2 +-
 joystick/amijoy.c    |   31 +++++++++++++++----------------
 keyboard/amikbd.c    |   25 +++++++++++++------------
 mouse/amimouse.c     |    9 +++++----
 5 files changed, 36 insertions(+), 35 deletions(-)

===================================================================

diff -Nru a/drivers/input/joystick/Config.help b/drivers/input/joystick/Config.help
--- a/drivers/input/joystick/Config.help	Tue Aug 20 15:35:25 2002
+++ b/drivers/input/joystick/Config.help	Tue Aug 20 15:35:25 2002
@@ -203,13 +203,13 @@
   The module will be called turbografx.o. If you want to compile it
   as a module, say M here and read <file:Documentation/modules.txt>.
 
-CONFIG_JOYSTICK_AMIJOY
+CONFIG_JOYSTICK_AMIGA
   Say Y here if you have an Amiga with a digital joystick connected
   to it.
 
   This driver is also available as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want).
-  The module will be called joy-amiga.o. If you want to compile it as
+  The module will be called amijoy.o. If you want to compile it as
   a module, say M here and read <file:Documentation/modules.txt>.
 
 CONFIG_INPUT_JOYDUMP
diff -Nru a/drivers/input/joystick/Config.in b/drivers/input/joystick/Config.in
--- a/drivers/input/joystick/Config.in	Tue Aug 20 15:35:25 2002
+++ b/drivers/input/joystick/Config.in	Tue Aug 20 15:35:25 2002
@@ -28,7 +28,7 @@
 dep_tristate '  Multisystem joysticks via TurboGraFX device' CONFIG_JOYSTICK_TURBOGRAFX $CONFIG_INPUT $CONFIG_INPUT_JOYSTICK $CONFIG_PARPORT
 
 if [ "$CONFIG_AMIGA" = "y" ]; then
-   dep_tristate '  Amiga joysticks' CONFIG_JOYSTICK_AMIJOY $CONFIG_INPUT $CONFIG_INPUT_JOYSTICK
+   dep_tristate '  Amiga joysticks' CONFIG_JOYSTICK_AMIGA $CONFIG_INPUT $CONFIG_INPUT_JOYSTICK
 fi
 
 dep_tristate '  Gameport data dumper' CONFIG_INPUT_JOYDUMP $CONFIG_INPUT $CONFIG_INPUT_JOYSTICK
diff -Nru a/drivers/input/joystick/amijoy.c b/drivers/input/joystick/amijoy.c
--- a/drivers/input/joystick/amijoy.c	Tue Aug 20 15:35:25 2002
+++ b/drivers/input/joystick/amijoy.c	Tue Aug 20 15:35:25 2002
@@ -37,6 +37,7 @@
 
 #include <asm/system.h>
 #include <asm/amigahw.h>
+#include <asm/amigaints.h>
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
 MODULE_DESCRIPTION("Driver for Amiga joysticks");
@@ -78,13 +79,13 @@
 
 	if ((*used)++)
 		return 0;
-	
-	if (request_irq(IRQ_AMIGA_VERTB, amijoy_interrupt, 0, "amijoy", NULL)) {
+
+	if (request_irq(IRQ_AMIGA_VERTB, amijoy_interrupt, 0, "amijoy", amijoy_interrupt)) {
 		(*used)--;
-		printk(KERN_ERR "amijoy.c: Can't allocate irq %d\n", amijoy_irq);
+		printk(KERN_ERR "amijoy.c: Can't allocate irq %d\n", IRQ_AMIGA_VERTB);
 		return -EBUSY;
 	}
-		
+
 	return 0;
 }
 
@@ -99,8 +100,9 @@
 static int __init amijoy_setup(char *str)
 {
 	int i;
-	int ints[4]
-        str = get_options(str, ARRAY_SIZE(ints), ints);
+	int ints[4];
+
+	str = get_options(str, ARRAY_SIZE(ints), ints);
 	for (i = 0; i <= ints[0] && i < 2; i++) amijoy[i] = ints[i+1];
 	return 1;
 }
@@ -110,9 +112,6 @@
 {
 	int i, j;
 
-	init_timer(amijoy_timer);
-	port->timer.function = amijoy_timer;
-
 	for (i = 0; i < 2; i++)
 		if (amijoy[i]) {
 			if (!request_mem_region(CUSTOM_PHYSADDR+10+i*2, 2,
@@ -134,12 +133,12 @@
 				amijoy_dev[i].absmax[ABS_X + j] = 1;
 			}
 
-			amijoy->dev[i].name = amijoy_name;
-			amijoy->dev[i].phys = amijoy_phys[i];
-			amijoy->dev[i].id.bustype = BUS_AMIGA;
-			amijoy->dev[i].id.vendor = 0x0001;
-			amijoy->dev[i].id.product = 0x0003;
-			amijoy->dev[i].id.version = 0x0100;
+			amijoy_dev[i].name = amijoy_name;
+			amijoy_dev[i].phys = amijoy_phys[i];
+			amijoy_dev[i].id.bustype = BUS_AMIGA;
+			amijoy_dev[i].id.vendor = 0x0001;
+			amijoy_dev[i].id.product = 0x0003;
+			amijoy_dev[i].id.version = 0x0100;
 
 			amijoy_dev[i].private = amijoy_used + i;
 
@@ -149,7 +148,7 @@
 	return 0;
 }
 
-static void _exit amijoy_exit(void)
+static void __exit amijoy_exit(void)
 {
 	int i;
 
diff -Nru a/drivers/input/keyboard/amikbd.c b/drivers/input/keyboard/amikbd.c
--- a/drivers/input/keyboard/amikbd.c	Tue Aug 20 15:35:25 2002
+++ b/drivers/input/keyboard/amikbd.c	Tue Aug 20 15:35:25 2002
@@ -34,6 +34,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/input.h>
+#include <linux/delay.h>
 
 #include <asm/amigaints.h>
 #include <asm/amigahw.h>
@@ -51,9 +52,9 @@
 	 57, 14, 15, 96, 28,  1,111,  0,  0,  0, 74,  0,103,108,106,105,
 	 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 98, 55, 78, 87,
 	 42, 54, 58, 29, 56,100
-}
+};
 
-static char *amikbd_messages[] = {
+static const char *amikbd_messages[8] = {
 	KERN_ALERT "amikbd: Ctrl-Amiga-Amiga reset warning!!\n",
 	KERN_WARNING "amikbd: keyboard lost sync\n",
 	KERN_WARNING "amikbd: keyboard buffer overflow\n",
@@ -79,19 +80,19 @@
 	ciaa.cra &= ~0x40;		/* switch CIA serial port to input mode */
 
 	down = scancode & 1;		/* lowest bit is release bit */
-	scancode = scancode >> 1;
+	scancode >>= 1;
 
 	if (scancode < 0x78) {		/* scancodes < 0x78 are keys */
 
 		scancode = amikbd_keycode[scancode];
-	
-		if (scancode == KEY_CAPS) {	/* CapsLock is a toggle switch key on Amiga */
+
+		if (scancode == KEY_CAPSLOCK) {	/* CapsLock is a toggle switch key on Amiga */
 			input_report_key(&amikbd_dev, scancode, 1);
 			input_report_key(&amikbd_dev, scancode, 0);
 			input_sync(&amikbd_dev);
 			return;
 		}
-		
+
 		input_report_key(&amikbd_dev, scancode, down);
 		input_sync(&amikbd_dev);
 
@@ -106,20 +107,20 @@
 	int i;
 
 	if (!AMIGAHW_PRESENT(AMI_KEYBOARD))
-	 	return -EIO;
+		return -EIO;
 
-	if (!request_mem_region(CIAA_PHYSADDR-1+0xb00, 0x100, "amikeyb"))   
+	if (!request_mem_region(CIAA_PHYSADDR-1+0xb00, 0x100, "amikeyb"))
 		return -EBUSY;
 
-	amikbd_dev.evbit[0] = BIT(EV_KEY) | BIT(EV_REP);	
+	amikbd_dev.evbit[0] = BIT(EV_KEY) | BIT(EV_REP);
 	amikbd_dev.keycode = amikbd_keycode;
-	
- 	for (i = 0; i < 0x78; i++)
+
+	for (i = 0; i < 0x78; i++)
 		if (amikbd_keycode[i])
 			set_bit(amikbd_keycode[i], amikbd_dev.keybit);
 
 	ciaa.cra &= ~0x41;	 /* serial data in, turn off TA */
-	request_irq(IRQ_AMIGA_CIAA_SP, amikbd_interrupt, 0, "amikbd", NULL);
+	request_irq(IRQ_AMIGA_CIAA_SP, amikbd_interrupt, 0, "amikbd", amikbd_interrupt);
 
 	amikbd_dev.name = amikbd_name;
 	amikbd_dev.phys = amikbd_phys;
diff -Nru a/drivers/input/mouse/amimouse.c b/drivers/input/mouse/amimouse.c
--- a/drivers/input/mouse/amimouse.c	Tue Aug 20 15:35:25 2002
+++ b/drivers/input/mouse/amimouse.c	Tue Aug 20 15:35:25 2002
@@ -64,7 +64,7 @@
 
 	input_report_rel(&amimouse_dev, REL_X, dx);
 	input_report_rel(&amimouse_dev, REL_Y, dy);
-	
+
 	input_report_key(&amimouse_dev, BTN_LEFT,   ciaa.pra & 0x40);
 	input_report_key(&amimouse_dev, BTN_MIDDLE, potgor & 0x0100);
 	input_report_key(&amimouse_dev, BTN_RIGHT,  potgor & 0x0400);
@@ -84,9 +84,9 @@
 	amimouse_lastx = joy0dat & 0xff;
 	amimouse_lasty = joy0dat >> 8;
 
-	if (request_irq(IRQ_AMIGA_VERTB, amimouse_interrupt, 0, "amimouse", NULL)) {
+	if (request_irq(IRQ_AMIGA_VERTB, amimouse_interrupt, 0, "amimouse", amimouse_interrupt)) {
                 amimouse_used--;
-                printk(KERN_ERR "amimouse.c: Can't allocate irq %d\n", amimouse_irq);
+                printk(KERN_ERR "amimouse.c: Can't allocate irq %d\n", IRQ_AMIGA_VERTB);
                 return -EBUSY;
         }
 
@@ -116,10 +116,11 @@
 	amimouse_dev.id.vendor = 0x0001;
 	amimouse_dev.id.product = 0x0002;
 	amimouse_dev.id.version = 0x0100;
-        
+
 	input_register_device(&amimouse_dev);
 
         printk(KERN_INFO "input: %s at joy0dat\n", amimouse_name);
+	return 0;
 }
 
 static void __exit amimouse_exit(void)

===================================================================

This BitKeeper patch contains the following changesets:
+
## Wrapped with gzip_uu ##


begin 664 bkpatch13023
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
*_P--*'V8H1@`````
`
end


-- 
Vojtech Pavlik
SuSE Labs
