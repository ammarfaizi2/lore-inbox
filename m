Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130067AbQKQRFL>; Fri, 17 Nov 2000 12:05:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130000AbQKQRFA>; Fri, 17 Nov 2000 12:05:00 -0500
Received: from styx.suse.cz ([195.70.145.226]:39407 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id <S129591AbQKQREp>;
	Fri, 17 Nov 2000 12:04:45 -0500
Date: Fri, 17 Nov 2000 16:32:54 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [patch] Input drivers critical fixes, try #2.
Message-ID: <20001117163254.A1747@suse.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

attached is a patch that fixes some critical and some less critical, but
still harmful bugs in the input drivers. It's against 2.4.0-test11-pre6.

Joysticks:

drivers/joystick/adi.c:
        Fix X/Y axes on Logitech gamepads.
drivers/joystick/ns558.c:
	Fix module impossible to load for ISA devices unless
	CONFIG_HOTPLUG - bug added in test11-pre6. [critical]
        Fix oops on unload if PCI gameports present. [critical]
	Fix oops on unload if PCI gameports not present,
	- bug added in test11-pre6. [critical]
        Fix memory leak on unload. [critical]
drivers/char/joystick/sidewinder.c
        Fix missing button on MS FF Wheel.

Input [USB+Joystick]:

drivers/input/input.c:
        Fix a possible race at open - fix by Oliver Neukum. [critical]
drivers/input/evdev.c:
        Fix possible overflows in connect and open. [critical]
drivers/input/joydev.c:
        Fix possible overflows in connect and open. [critical]
drivers/input/mousedev.c:
        Fix possible overflows in connect and open. [critical]
        Add missing randomness reporting. 

Please apply it.
Thanks.

-- 
Vojtech Pavlik
SuSE Labs

--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="input-crit2.diff"

diff -urN linux-2.4.0-test11-pre6/drivers/char/joystick/adi.c linux/drivers/char/joystick/adi.c
--- linux-2.4.0-test11-pre6/drivers/char/joystick/adi.c	Thu Jun 22 15:59:58 2000
+++ linux/drivers/char/joystick/adi.c	Fri Nov 17 16:20:09 2000
@@ -418,7 +418,7 @@
 	adi->dev.private = port;
 	adi->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
 
-	for (i = 0; i < adi->axes10 + adi->axes8 + adi->hats * 2; i++)
+	for (i = 0; i < adi->axes10 + adi->axes8 + (adi->hats + (adi->pad > 0)) * 2; i++)
 		set_bit(adi->abs[i], &adi->dev.absbit);
 
 	for (i = 0; i < adi->buttons; i++)
@@ -431,7 +431,7 @@
 
 	if (!adi->length) return;
 
-	for (i = 0; i < adi->axes10 + adi->axes8 + adi->hats * 2; i++) {
+	for (i = 0; i < adi->axes10 + adi->axes8 + (adi->hats + (adi->pad > 0)) * 2; i++) {
 
 		t = adi->abs[i];
 		x = adi->dev.abs[t];
diff -urN linux-2.4.0-test11-pre6/drivers/char/joystick/ns558.c linux/drivers/char/joystick/ns558.c
--- linux-2.4.0-test11-pre6/drivers/char/joystick/ns558.c	Fri Nov 17 16:13:41 2000
+++ linux/drivers/char/joystick/ns558.c	Fri Nov 17 16:20:51 2000
@@ -58,6 +58,7 @@
 };
 	
 static struct ns558 *ns558;
+static int ns558_pci;
 
 /*
  * ns558_isa_probe() tries to find an isa gameport at the
@@ -187,12 +188,10 @@
 	}
 	memset(port, 0, sizeof(struct ns558));
 
-	port->next = ns558;
 	port->type = NS558_PCI;
 	port->gameport.io = ioport;
 	port->gameport.size = iolen;
 	port->dev = pdev;
-	ns558 = port;
 
 	pdev->driver_data = port;
 
@@ -315,8 +314,7 @@
  * it is the least-invasive probe.
  */
 
-	i = pci_register_driver(&ns558_pci_driver);
-	if (i < 0) return i;
+	ns558_pci = !pci_module_init(&ns558_pci_driver);
 
 /*
  * Probe for ISA ports.
@@ -337,12 +335,12 @@
 	}
 #endif
 
-	return 0;
+	return (ns558 || ns558_pci) ? 0 : -ENODEV;
 }
 
 void __exit ns558_exit(void)
 {
-	struct ns558 *port = ns558;
+	struct ns558 *next, *port = ns558;
 
 	while (port) {
 		gameport_unregister_port(&port->gameport);
@@ -363,10 +361,13 @@
 				break;
 		}
 		
-		port = port->next;
+		next = port->next;
+		kfree(port);
+		port = next;
 	}
 
-	pci_unregister_driver(&ns558_pci_driver);
+	if (ns558_pci)
+		pci_unregister_driver(&ns558_pci_driver);
 }
 
 module_init(ns558_init);
diff -urN linux-2.4.0-test11-pre6/drivers/char/joystick/sidewinder.c linux/drivers/char/joystick/sidewinder.c
--- linux-2.4.0-test11-pre6/drivers/char/joystick/sidewinder.c	Mon Aug 14 22:55:01 2000
+++ linux/drivers/char/joystick/sidewinder.c	Fri Nov 17 16:20:09 2000
@@ -102,7 +102,7 @@
 	{ BTN_TRIGGER, BTN_THUMB, BTN_TOP, BTN_TOP2, BTN_BASE, BTN_BASE2, BTN_BASE3, BTN_BASE4, BTN_SELECT },
 	{ BTN_TRIGGER, BTN_THUMB, BTN_TOP, BTN_TOP2, BTN_BASE, BTN_BASE2, BTN_BASE3, BTN_BASE4, BTN_SELECT },
 	{ BTN_A, BTN_B, BTN_C, BTN_X, BTN_Y, BTN_Z, BTN_TL, BTN_TR, BTN_START, BTN_MODE, BTN_SELECT },
-	{ BTN_TRIGGER, BTN_TOP, BTN_THUMB, BTN_THUMB2, BTN_BASE, BTN_BASE2, BTN_BASE3 }};
+	{ BTN_TRIGGER, BTN_TOP, BTN_THUMB, BTN_THUMB2, BTN_BASE, BTN_BASE2, BTN_BASE3, BTN_BASE4 }};
 
 static struct {
 	int x;
diff -urN linux-2.4.0-test11-pre6/drivers/input/evdev.c linux/drivers/input/evdev.c
--- linux-2.4.0-test11-pre6/drivers/input/evdev.c	Fri Jul 28 03:36:54 2000
+++ linux/drivers/input/evdev.c	Fri Nov 17 16:20:12 2000
@@ -123,7 +123,7 @@
 	struct evdev_list *list;
 	int i = MINOR(inode->i_rdev) - EVDEV_MINOR_BASE;
 
-	if (i > EVDEV_MINORS || !evdev_table[i])
+	if (i >= EVDEV_MINORS || !evdev_table[i])
 		return -ENODEV;
 
 	if (!(list = kmalloc(sizeof(struct evdev_list), GFP_KERNEL)))
@@ -288,7 +288,7 @@
 	int minor;
 
 	for (minor = 0; minor < EVDEV_MINORS && evdev_table[minor]; minor++);
-	if (evdev_table[minor]) {
+	if (minor == EVDEV_MINORS) {
 		printk(KERN_ERR "evdev: no more free evdev devices\n");
 		return NULL;
 	}
diff -urN linux-2.4.0-test11-pre6/drivers/input/input.c linux/drivers/input/input.c
--- linux-2.4.0-test11-pre6/drivers/input/input.c	Wed Nov 15 11:03:35 2000
+++ linux/drivers/input/input.c	Fri Nov 17 16:20:12 2000
@@ -29,6 +29,8 @@
  */
 
 #include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/smp_lock.h>
 #include <linux/input.h>
 #include <linux/module.h>
 #include <linux/random.h>
@@ -378,7 +380,11 @@
 	}
 	old_fops = file->f_op;
 	file->f_op = new_fops;
+
+	lock_kernel();
 	err = new_fops->open(inode, file);
+	unlock_kernel();
+
 	if (err) {
 		fops_put(file->f_op);
 		file->f_op = fops_get(old_fops);
diff -urN linux-2.4.0-test11-pre6/drivers/input/joydev.c linux/drivers/input/joydev.c
--- linux-2.4.0-test11-pre6/drivers/input/joydev.c	Tue Aug 22 18:06:31 2000
+++ linux/drivers/input/joydev.c	Fri Nov 17 16:20:12 2000
@@ -193,7 +193,7 @@
 	struct joydev_list *list;
 	int i = MINOR(inode->i_rdev) - JOYDEV_MINOR_BASE;
 
-	if (i > JOYDEV_MINORS || !joydev_table[i])
+	if (i >= JOYDEV_MINORS || !joydev_table[i])
 		return -ENODEV;
 
 	if (!(list = kmalloc(sizeof(struct joydev_list), GFP_KERNEL)))
@@ -395,7 +395,7 @@
 		|| test_bit(BTN_1, dev->keybit)))) return NULL; 
 
 	for (minor = 0; minor < JOYDEV_MINORS && joydev_table[minor]; minor++);
-	if (joydev_table[minor]) {
+	if (minor == JOYDEV_MINORS) {
 		printk(KERN_ERR "joydev: no more free joydev devices\n");
 		return NULL;
 	}
diff -urN linux-2.4.0-test11-pre6/drivers/input/mousedev.c linux/drivers/input/mousedev.c
--- linux-2.4.0-test11-pre6/drivers/input/mousedev.c	Tue Aug 22 18:06:31 2000
+++ linux/drivers/input/mousedev.c	Fri Nov 17 16:20:12 2000
@@ -39,6 +39,7 @@
 #include <linux/input.h>
 #include <linux/config.h>
 #include <linux/smp_lock.h>
+#include <linux/random.h>
 
 #ifndef CONFIG_INPUT_MOUSEDEV_SCREEN_X
 #define CONFIG_INPUT_MOUSEDEV_SCREEN_X	1024
@@ -86,6 +87,8 @@
 	struct mousedev_list *list;
 	int index, size;
 
+	add_mouse_randomness((type << 4) ^ code ^ (code >> 4) ^ value);
+
 	while (*mousedev) {
 		list = (*mousedev)->list;
 		while (list) {
@@ -213,7 +216,7 @@
 	struct mousedev_list *list;
 	int i = MINOR(inode->i_rdev) - MOUSEDEV_MINOR_BASE;
 
-	if (i > MOUSEDEV_MINORS || !mousedev_table[i])
+	if (i >= MOUSEDEV_MINORS || !mousedev_table[i])
 		return -ENODEV;
 
 	if (!(list = kmalloc(sizeof(struct mousedev_list), GFP_KERNEL)))
@@ -407,7 +410,7 @@
 		return NULL;
 
 	for (minor = 0; minor < MOUSEDEV_MINORS && mousedev_table[minor]; minor++);
-	if (mousedev_table[minor]) {
+	if (minor == MOUSEDEV_MINORS) {
 		printk(KERN_ERR "mousedev: no more free mousedev devices\n");
 		return NULL;
 	}

--qDbXVdCdHGoSgWSk--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
