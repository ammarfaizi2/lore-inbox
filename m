Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261997AbUB2HJp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 02:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261999AbUB2HJK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 02:09:10 -0500
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:38047 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261997AbUB2HDw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 02:03:52 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 7/9] Move joysticks to the module_param way of handling options
Date: Sun, 29 Feb 2004 02:01:14 -0500
User-Agent: KMail/1.6
Cc: linux-kernel@vger.kernel.org
References: <200402290153.08798.dtor_core@ameritech.net> <200402290158.52036.dtor_core@ameritech.net> <200402290200.07447.dtor_core@ameritech.net>
In-Reply-To: <200402290200.07447.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200402290201.15611.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1691, 2004-02-28 00:48:18-05:00, dtor_core@ameritech.net
  Input: Convert joystick modules to the new way of handling parameters and
         document them in kernel-parameters.txt
  
         The new names are:
           amijoy.map=<a>,<b>
           analog.map=<type1>,<type2>,...<type16>
           db9.dev[2|3]=<parport#>,<type>
           gamecon.map[2|3]=<parport#>,<pad1>,<pad2>,...<pad5>
           turbografx.map[2|3]=<parport#>,<js1>,<js2>,...<js7>
  
         Also there is a tiny change to mousedev and tsdev descriptions in
         kernel-parameters, but no name changes.


 Documentation/input/joystick-parport.txt |   16 +++---
 Documentation/input/joystick.txt         |    6 +-
 Documentation/kernel-parameters.txt      |   46 ++++++++++-------
 drivers/input/joystick/amijoy.c          |   17 +-----
 drivers/input/joystick/analog.c          |   26 +--------
 drivers/input/joystick/db9.c             |   63 +++++++++--------------
 drivers/input/joystick/gamecon.c         |   82 +++++++++++++------------------
 drivers/input/joystick/turbografx.c      |   68 ++++++++++---------------
 8 files changed, 140 insertions(+), 184 deletions(-)


===================================================================



diff -Nru a/Documentation/input/joystick-parport.txt b/Documentation/input/joystick-parport.txt
--- a/Documentation/input/joystick-parport.txt	Sun Feb 29 01:19:19 2004
+++ b/Documentation/input/joystick-parport.txt	Sun Feb 29 01:19:19 2004
@@ -434,7 +434,7 @@
   Using gamecon.c you can connect up to five devices to one parallel port. It
 uses the following kernel/module command line:
 
-	gc=port,pad1,pad2,pad3,pad4,pad5
+	gamecon.map=port,pad1,pad2,pad3,pad4,pad5
 
   Where 'port' the number of the parport interface (eg. 0 for parport0).
 
@@ -457,15 +457,15 @@
 your controller plugged in before initializing.
 
   Should you want to use more than one of parallel ports at once, you can use
-gc_2 and gc_3 as additional command line parameters for two more parallel
-ports.
+gamecon.map2 and gamecon.map3 as additional command line parameters for two
+more parallel ports.
 
 3.2 db9.c
 ~~~~~~~~~
   Apart from making an interface, there is nothing difficult on using the
 db9.c driver. It uses the following kernel/module command line:
 
-	db9=port,type
+	db9.dev=port,type
 
   Where 'port' is the number of the parport interface (eg. 0 for parport0).
 
@@ -489,14 +489,14 @@
 	 10  | Amiga CD32 pad
 
   Should you want to use more than one of these joysticks/pads at once, you
-can use db9_2 and db9_3 as additional command line parameters for two
+can use db9.dev2 and db9.dev3 as additional command line parameters for two
 more joysticks/pads.
 
 3.3 turbografx.c
 ~~~~~~~~~~~~~~~~
   The turbografx.c driver uses a very simple kernel/module command line:
 
-	tgfx=port,js1,js2,js3,js4,js5,js6,js7
+	turbografx.map=port,js1,js2,js3,js4,js5,js6,js7
 
   Where 'port' is the number of the parport interface (eg. 0 for parport0).
 
@@ -504,8 +504,8 @@
 interface ports 1-7 have. For a standard multisystem joystick, this is 1.
 
   Should you want to use more than one of these interfaces at once, you can
-use tgfx_2 and tgfx_3 as additional command line parameters for two more
-interfaces.
+use turbografx.map2 and turbografx.map3 as additional command line parameters
+for two more interfaces.
 
 3.4 PC parallel port pinout
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
diff -Nru a/Documentation/input/joystick.txt b/Documentation/input/joystick.txt
--- a/Documentation/input/joystick.txt	Sun Feb 29 01:19:19 2004
+++ b/Documentation/input/joystick.txt	Sun Feb 29 01:19:19 2004
@@ -111,7 +111,7 @@
 	alias tty-ldisc-2 serport
 	alias char-major-13 input
 	above input joydev ns558 analog
-	options analog js=gamepad
+	options analog map=gamepad,none,2btn
 
 2.5 Verifying that it works
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -185,7 +185,7 @@
 module command line, when inserting analog.o into the kernel. The
 parameters are:
 
-	js=type,type,type,....
+	analog.map=<type1>,<type2>,<type3>,....
 
   'type' is type of the joystick from the table below, defining joysticks
 present on gameports in the system, starting with gameport0, second 'type'
@@ -419,7 +419,7 @@
   Amiga joysticks, connected to an Amiga, are supported by the amijoy.c
 driver. Since they can't be autodetected, the driver has a command line.
 
-	amijoy=a,b
+	amijoy.map=<a>,<b>
 
   a and b define the joysticks connected to the JOY0DAT and JOY1DAT ports of
 the Amiga.
diff -Nru a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
--- a/Documentation/kernel-parameters.txt	Sun Feb 29 01:19:19 2004
+++ b/Documentation/kernel-parameters.txt	Sun Feb 29 01:19:19 2004
@@ -151,7 +151,15 @@
 			Format: <host-scsi-id>,<target-scsi-id>,<max-rate>,<max-offset>
 			See also header of drivers/scsi/AM53C974.c.
 
-	amijoy=		[HW,JOY] Amiga joystick support 
+	amijoy.map=	[HW,JOY] Amiga joystick support
+			Map of devices attached to JOY0DAT and JOY1DAT
+			Format: <a>,<b>
+			See also Documentation/kernel/input/joystick.txt
+
+	analog.map=	[HW,JOY] Analog joystick and gamepad support
+			Specifies type or capabilities of an analog joystick
+			connected to one of 16 gameports
+			Format: <type1>,<type2>,..<type16>
 
 	apc=		[HW,SPARC] Power management functions (SPARCstation-4/5 + deriv.)
 			Format: noidle
@@ -280,10 +288,11 @@
 	dasd=		[HW,NET]    
 			See header of drivers/s390/block/dasd_devmap.c.
 
-	db9=		[HW,JOY]
-	db9_2=
-	db9_3=
- 
+	db9.dev[2|3]=	[HW,JOY] Multisystem joystick support via parallel port
+			(one device per port)
+			Format: <port#>,<type>
+			See also Documentation/input/joystick-parport.txt
+
 	debug		[KNL] Enable kernel debugging (events log level).
 
 	decnet=		[HW,NET]
@@ -377,12 +386,14 @@
 	ftape=		[HW] Floppy Tape subsystem debugging options.
 			See Documentation/ftape.txt.
 
+	gamecon.map[2|3]=
+			[HW,JOY] Multisystem joystick and NES/SNES/PSX pad
+			support via parallel port (up to 5 devices per port)
+			Format: <port#>,<pad1>,<pad2>,<pad3>,<pad4>,<pad5>
+			See also Documentation/input/joystick-parport.txt
+
 	gamma=		[HW,DRM]
 
-	gc=		[HW,JOY]
-	gc_2=		See Documentation/input/joystick-parport.txt.
-	gc_3=		
- 
 	gdth=		[HW,SCSI]
 			See header of drivers/scsi/gdth.c.
 
@@ -609,9 +620,9 @@
 
 	mga=		[HW,DRM]
 
-	mousedev.xres	[MOUSE] Horizontal screen resolution, used for devices
+	mousedev.xres=	[MOUSE] Horizontal screen resolution, used for devices
 			reporting absolute coordinates, such as tablets
-	mousedev.yres	[MOUSE] Vertical screen resolution, used for devices
+	mousedev.yres=	[MOUSE] Vertical screen resolution, used for devices
 			reporting absolute coordinates, such as tablets
 
 	mpu401=		[HW,OSS]
@@ -1156,10 +1167,6 @@
 			See header of drivers/scsi/t128.c.
 
 	tdfx=		[HW,DRM]
- 
-	tgfx=		[HW,JOY] TurboGraFX parallel port interface
-	tgfx_2=		See Documentation/input/joystick-parport.txt.
-	tgfx_3=
 
 	thash_entries=	[KNL,NET]
 			Set number of hash buckets for TCP connection
@@ -1182,8 +1189,13 @@
 	trix=		[HW,OSS] MediaTrix AudioTrix Pro
 			Format: <io>,<irq>,<dma>,<dma2>,<sb_io>,<sb_irq>,<sb_dma>,<mpu_io>,<mpu_irq>
  
-	tsdev.xres	[TS] Horizontal screen resolution.
-	tsdev.yres	[TS] Vertical screen resolution.
+	tsdev.xres=	[TS] Horizontal screen resolution.
+	tsdev.yres=	[TS] Vertical screen resolution.
+
+	turbografx.map[2|3]=
+			[HW,JOY] TurboGraFX parallel port interface
+			Format: <port#>,<js1>,<js2>,<js3>,<js4>,<js5>,<js6>,<js7>
+			See also Documentation/input/joystick-parport.txt
 
 	u14-34f=	[HW,SCSI] UltraStor 14F/34F SCSI host adapter
 			See header of drivers/scsi/u14-34f.c.
diff -Nru a/drivers/input/joystick/amijoy.c b/drivers/input/joystick/amijoy.c
--- a/drivers/input/joystick/amijoy.c	Sun Feb 29 01:19:19 2004
+++ b/drivers/input/joystick/amijoy.c	Sun Feb 29 01:19:19 2004
@@ -32,6 +32,7 @@
 #include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/init.h>
 #include <linux/input.h>
 #include <linux/interrupt.h>
@@ -42,10 +43,13 @@
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
 MODULE_DESCRIPTION("Driver for Amiga joysticks");
-MODULE_PARM(amijoy, "1-2i");
 MODULE_LICENSE("GPL");
 
 static int amijoy[2] = { 0, 1 };
+static int amijoy_nargs;  
+module_param_array_named(map, amijoy, uint, amijoy_nargs, 0);
+MODULE_PARM_DESC(map, "Map of attached joysticks in form of <a>,<b> (default is 0,1)");
+
 static int amijoy_used[2] = { 0, 0 };
 static struct input_dev amijoy_dev[2];
 static char *amijoy_phys[2] = { "amijoy/input0", "amijoy/input1" };
@@ -100,17 +104,6 @@
 	if (!--(*used))
 		free_irq(IRQ_AMIGA_VERTB, amijoy_interrupt);
 }
-
-static int __init amijoy_setup(char *str)
-{
-	int i;
-	int ints[4];
-
-	str = get_options(str, ARRAY_SIZE(ints), ints);
-	for (i = 0; i <= ints[0] && i < 2; i++) amijoy[i] = ints[i+1];
-	return 1;
-}
-__setup("amijoy=", amijoy_setup);
 
 static int __init amijoy_init(void)
 {
diff -Nru a/drivers/input/joystick/analog.c b/drivers/input/joystick/analog.c
--- a/drivers/input/joystick/analog.c	Sun Feb 29 01:19:19 2004
+++ b/drivers/input/joystick/analog.c	Sun Feb 29 01:19:19 2004
@@ -32,6 +32,7 @@
 #include <linux/delay.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/slab.h>
 #include <linux/bitops.h>
 #include <linux/init.h>
@@ -50,9 +51,10 @@
 #define ANALOG_PORTS		16
 
 static char *js[ANALOG_PORTS];
+static int js_nargs;
 static int analog_options[ANALOG_PORTS];
-MODULE_PARM(js, "1-" __MODULE_STRING(ANALOG_PORTS) "s");
-MODULE_PARM_DESC(js, "Analog joystick options");
+module_param_array_named(map, js, charp, js_nargs, 0);
+MODULE_PARM_DESC(map, "Describes analog joysticks type/capabilities");
 
 /*
  * Times, feature definitions.
@@ -711,7 +713,7 @@
 	int i, j;
 	char *end;
 
-	for (i = 0; i < ANALOG_PORTS && js[i]; i++) {
+	for (i = 0; i < js_nargs; i++) {
 
 		for (j = 0; analog_types[j].name; j++)
 			if (!strcmp(analog_types[j].name, js[i])) {
@@ -741,24 +743,6 @@
 	.connect =	analog_connect,
 	.disconnect =	analog_disconnect,
 };
-
-#ifndef MODULE
-static int __init analog_setup(char *str)
-{
-	char *s = str;
-	int i = 0;
-
-	if (!str || !*str) return 0;
-
-	while ((str = s) && (i < ANALOG_PORTS)) {
-		if ((s = strchr(str,','))) *s++ = 0;
-		js[i++] = str;
-	}
-
-	return 1;
-}
-__setup("js=", analog_setup);
-#endif
 
 int __init analog_init(void)
 {
diff -Nru a/drivers/input/joystick/db9.c b/drivers/input/joystick/db9.c
--- a/drivers/input/joystick/db9.c	Sun Feb 29 01:19:19 2004
+++ b/drivers/input/joystick/db9.c	Sun Feb 29 01:19:19 2004
@@ -33,6 +33,7 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/parport.h>
@@ -42,9 +43,20 @@
 MODULE_DESCRIPTION("Atari, Amstrad, Commodore, Amiga, Sega, etc. joystick driver");
 MODULE_LICENSE("GPL");
 
-MODULE_PARM(db9, "2i");
-MODULE_PARM(db9_2, "2i");
-MODULE_PARM(db9_3, "2i");
+static int db9[] __initdata = { -1, 0 };
+static int db9_nargs __initdata = 0;
+module_param_array_named(dev, db9, int, db9_nargs, 0);
+MODULE_PARM_DESC(dev, "Describes first attached device (<parport#>,<type>)");
+
+static int db9_2[] __initdata = { -1, 0 };
+static int db9_nargs_2 __initdata = 0;
+module_param_array_named(dev2, db9_2, int, db9_nargs_2, 0);
+MODULE_PARM_DESC(dev2, "Describes second attached device (<parport#>,<type>)");
+
+static int db9_3[] __initdata = { -1, 0 };
+static int db9_nargs_3 __initdata = 0;
+module_param_array_named(dev3, db9_3, int, db9_nargs_3, 0);
+MODULE_PARM_DESC(dev3, "Describes third attached device (<parport#>,<type>)");
 
 #define DB9_MULTI_STICK		0x01
 #define DB9_MULTI2_STICK	0x02
@@ -76,10 +88,6 @@
 #define DB9_GENESIS6_DELAY	14
 #define DB9_REFRESH_TIME	HZ/100
 
-static int db9[] __initdata = { -1, 0 };
-static int db9_2[] __initdata = { -1, 0 };
-static int db9_3[] __initdata = { -1, 0 };
-
 struct db9 {
 	struct input_dev dev[DB9_MAX_DEVICES];
 	struct timer_list timer;
@@ -518,7 +526,7 @@
 	}
 }
 
-static struct db9 __init *db9_probe(int *config)
+static struct db9 __init *db9_probe(int *config, int nargs)
 {
 	struct db9 *db9;
 	struct parport *pp;
@@ -526,6 +534,12 @@
 
 	if (config[0] < 0)
 		return NULL;
+
+	if (nargs < 2) {
+		printk(KERN_ERR "db9.c: Device type must be specified.\n");
+		return NULL;
+	}
+
 	if (config[1] < 1 || config[1] >= DB9_MAX_PAD || !db9_buttons[config[1]]) {
 		printk(KERN_ERR "db9.c: bad config\n");
 		return NULL;
@@ -601,38 +615,11 @@
 	return db9;
 }
 
-#ifndef MODULE
-static int __init db9_setup(char *str)
-{
-	int i, ints[3];
-	get_options(str, ARRAY_SIZE(ints), ints);
-	for (i = 0; i <= ints[0] && i < 2; i++) db9[i] = ints[i + 1];
-	return 1;
-}
-static int __init db9_setup_2(char *str)
-{
-	int i, ints[3];
-	get_options(str, ARRAY_SIZE(ints), ints);
-	for (i = 0; i <= ints[0] && i < 2; i++) db9_2[i] = ints[i + 1];
-	return 1;
-}
-static int __init db9_setup_3(char *str)
-{
-	int i, ints[3];
-	get_options(str, ARRAY_SIZE(ints), ints);
-	for (i = 0; i <= ints[0] && i < 2; i++) db9_3[i] = ints[i + 1];
-	return 1;
-}
-__setup("db9=", db9_setup);
-__setup("db9_2=", db9_setup_2);
-__setup("db9_3=", db9_setup_3);
-#endif
-
 int __init db9_init(void)
 {
-	db9_base[0] = db9_probe(db9);
-	db9_base[1] = db9_probe(db9_2);
-	db9_base[2] = db9_probe(db9_3);
+	db9_base[0] = db9_probe(db9, db9_nargs);
+	db9_base[1] = db9_probe(db9_2, db9_nargs_2);
+	db9_base[2] = db9_probe(db9_3, db9_nargs_3);
 
 	if (db9_base[0] || db9_base[1] || db9_base[2])
 		return 0;
diff -Nru a/drivers/input/joystick/gamecon.c b/drivers/input/joystick/gamecon.c
--- a/drivers/input/joystick/gamecon.c	Sun Feb 29 01:19:19 2004
+++ b/drivers/input/joystick/gamecon.c	Sun Feb 29 01:19:19 2004
@@ -35,6 +35,7 @@
 #include <linux/kernel.h>
 #include <linux/delay.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/init.h>
 #include <linux/parport.h>
 #include <linux/input.h>
@@ -43,10 +44,26 @@
 MODULE_DESCRIPTION("NES, SNES, N64, MultiSystem, PSX gamepad driver");
 MODULE_LICENSE("GPL");
 
-MODULE_PARM(gc, "2-6i");
-MODULE_PARM(gc_2,"2-6i");
-MODULE_PARM(gc_3,"2-6i");
-MODULE_PARM(gc_psx_delay, "i");
+static int gc[] __initdata = { -1, 0, 0, 0, 0, 0 };
+static int gc_nargs __initdata = 0;
+module_param_array_named(map, gc, int, gc_nargs, 0);
+MODULE_PARM_DESC(map, "Describers first set of devices (<parport#>,<pad1>,<pad2>,..<pad5>)");
+
+static int gc_2[] __initdata = { -1, 0, 0, 0, 0, 0 };
+static int gc_nargs_2 __initdata = 0;
+module_param_array_named(map2, gc_2, int, gc_nargs_2, 0);
+MODULE_PARM_DESC(map2, "Describers second set of devices");
+
+static int gc_3[] __initdata = { -1, 0, 0, 0, 0, 0 };
+static int gc_nargs_3 __initdata = 0;
+module_param_array_named(map3, gc_3, int, gc_nargs_3, 0);
+MODULE_PARM_DESC(map3, "Describers third set of devices");
+
+__obsolete_setup("gc=");
+__obsolete_setup("gc_2=");
+__obsolete_setup("gc_3=");
+
+/* see also gs_psx_delay parameter in PSX support section */
 
 #define GC_SNES		1
 #define GC_NES		2
@@ -71,10 +88,6 @@
 
 static struct gc *gc_base[3];
 
-static int gc[] __initdata = { -1, 0, 0, 0, 0, 0 };
-static int gc_2[] __initdata = { -1, 0, 0, 0, 0, 0 };
-static int gc_3[] __initdata = { -1, 0, 0, 0, 0, 0 };
-
 static int gc_status_bit[] = { 0x40, 0x80, 0x20, 0x10, 0x08 };
 
 static char *gc_names[] = { NULL, "SNES pad", "NES pad", "NES FourPort", "Multisystem joystick",
@@ -232,6 +245,11 @@
 #define GC_PSX_LEN(x)	((x) & 0xf)	/* Low nibble is length in words */
 
 static int gc_psx_delay = GC_PSX_DELAY;
+module_param_named(psx_delay, gc_psx_delay, uint, 0);
+MODULE_PARM_DESC(psx_delay, "Delay when accessing Sony PSX controller (usecs)");
+
+__obsolete_setup("gc_psx_delay=");
+
 static short gc_psx_abs[] = { ABS_X, ABS_Y, ABS_RX, ABS_RY, ABS_HAT0X, ABS_HAT0Y };
 static short gc_psx_btn[] = { BTN_TL, BTN_TR, BTN_TL2, BTN_TR2, BTN_A, BTN_B, BTN_X, BTN_Y,
 				BTN_START, BTN_SELECT, BTN_THUMBL, BTN_THUMBR };
@@ -468,7 +486,7 @@
 	}
 }
 
-static struct gc __init *gc_probe(int *config)
+static struct gc __init *gc_probe(int *config, int nargs)
 {
 	struct gc *gc;
 	struct parport *pp;
@@ -478,6 +496,11 @@
 	if (config[0] < 0)
 		return NULL;
 
+	if (nargs < 2) {
+		printk(KERN_ERR "gamecon.c: at least one device must be specified\n");
+		return NULL;
+	}
+
 	pp = parport_find_number(config[0]);
 
 	if (!pp) {
@@ -507,7 +530,7 @@
 	gc->timer.data = (long) gc;
 	gc->timer.function = gc_timer;
 
-	for (i = 0; i < 5; i++) {
+	for (i = 0; i < nargs - 1; i++) {
 
 		if (!config[i + 1])
 			continue;
@@ -632,44 +655,11 @@
 	return gc;
 }
 
-#ifndef MODULE
-static int __init gc_setup(char *str)
-{
-	int i, ints[7];
-	get_options(str, ARRAY_SIZE(ints), ints);
-	for (i = 0; i <= ints[0] && i < 6; i++) gc[i] = ints[i + 1];
-	return 1;
-}
-static int __init gc_setup_2(char *str)
-{
-	int i, ints[7];
-	get_options(str, ARRAY_SIZE(ints), ints);
-	for (i = 0; i <= ints[0] && i < 6; i++) gc_2[i] = ints[i + 1];
-	return 1;
-}
-static int __init gc_setup_3(char *str)
-{
-	int i, ints[7];
-	get_options(str, ARRAY_SIZE(ints), ints);
-	for (i = 0; i <= ints[0] && i < 6; i++) gc_3[i] = ints[i + 1];
-	return 1;
-}
-static int __init gc_psx_setup(char *str)
-{
-        get_option(&str, &gc_psx_delay);
-        return 1;
-}
-__setup("gc=", gc_setup);
-__setup("gc_2=", gc_setup_2);
-__setup("gc_3=", gc_setup_3);
-__setup("gc_psx_delay=", gc_psx_setup);
-#endif
-
 int __init gc_init(void)
 {
-	gc_base[0] = gc_probe(gc);
-	gc_base[1] = gc_probe(gc_2);
-	gc_base[2] = gc_probe(gc_3);
+	gc_base[0] = gc_probe(gc, gc_nargs);
+	gc_base[1] = gc_probe(gc_2, gc_nargs_2);
+	gc_base[2] = gc_probe(gc_3, gc_nargs_3);
 
 	if (gc_base[0] || gc_base[1] || gc_base[2])
 		return 0;
diff -Nru a/drivers/input/joystick/turbografx.c b/drivers/input/joystick/turbografx.c
--- a/drivers/input/joystick/turbografx.c	Sun Feb 29 01:19:19 2004
+++ b/drivers/input/joystick/turbografx.c	Sun Feb 29 01:19:19 2004
@@ -35,15 +35,31 @@
 #include <linux/parport.h>
 #include <linux/input.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/init.h>
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
 MODULE_DESCRIPTION("TurboGraFX parallel port interface driver");
 MODULE_LICENSE("GPL");
 
-MODULE_PARM(tgfx, "2-8i");
-MODULE_PARM(tgfx_2, "2-8i");
-MODULE_PARM(tgfx_3, "2-8i");
+static int tgfx[] __initdata = { -1, 0, 0, 0, 0, 0, 0, 0 };
+static int tgfx_nargs __initdata = 0;
+module_param_array_named(map, tgfx, int, tgfx_nargs, 0);
+MODULE_PARM_DESC(map, "Describes first set of devices (<parport#>,<js1>,<js2>,..<js7>");
+
+static int tgfx_2[] __initdata = { -1, 0, 0, 0, 0, 0, 0, 0 };
+static int tgfx_nargs_2 __initdata = 0;
+module_param_array_named(map2, tgfx_2, int, tgfx_nargs_2, 0);
+MODULE_PARM_DESC(map2, "Describes second set of devices");
+
+static int tgfx_3[] __initdata = { -1, 0, 0, 0, 0, 0, 0, 0 };
+static int tgfx_nargs_3 __initdata = 0;
+module_param_array_named(map3, tgfx_3, int, tgfx_nargs_3, 0);
+MODULE_PARM_DESC(map3, "Describes third set of devices");
+
+__obsolete_setup("tgfx=");
+__obsolete_setup("tgfx_2=");
+__obsolete_setup("tgfx_3=");
 
 #define TGFX_REFRESH_TIME	HZ/100	/* 10 ms */
 
@@ -58,10 +74,6 @@
 #define TGFX_TOP		0x01
 #define TGFX_TOP2		0x08
 
-static int tgfx[] __initdata = { -1, 0, 0, 0, 0, 0, 0, 0 };
-static int tgfx_2[] __initdata = { -1, 0, 0, 0, 0, 0, 0, 0 };
-static int tgfx_3[] __initdata = { -1, 0, 0, 0, 0, 0, 0, 0 };
-
 static int tgfx_buttons[] = { BTN_TRIGGER, BTN_THUMB, BTN_THUMB2, BTN_TOP, BTN_TOP2 };
 static char *tgfx_name = "TurboGraFX Multisystem joystick";
 
@@ -133,7 +145,7 @@
  * tgfx_probe() probes for tg gamepads.
  */
 
-static struct tgfx __init *tgfx_probe(int *config)
+static struct tgfx __init *tgfx_probe(int *config, int nargs)
 {
 	struct tgfx *tgfx;
 	struct parport *pp;
@@ -142,6 +154,11 @@
 	if (config[0] < 0)
 		return NULL;
 
+	if (nargs < 2) {
+		printk(KERN_ERR "turbografx.c: at least one joystick must be specified\n");
+		return NULL;
+	}
+
 	pp = parport_find_number(config[0]);
 
 	if (!pp) {
@@ -171,7 +188,7 @@
 
 	tgfx->sticks = 0;
 
-	for (i = 0; i < 7; i++)
+	for (i = 0; i < nargs - 1; i++)
 		if (config[i+1] > 0 && config[i+1] < 6) {
 
 			tgfx->sticks |= (1 << i);
@@ -212,38 +229,11 @@
 	return tgfx;
 }
 
-#ifndef MODULE
-static int __init tgfx_setup(char *str)
-{
-	int i, ints[9];
-	get_options(str, ARRAY_SIZE(ints), ints);
-	for (i = 0; i <= ints[0] && i < 8; i++) tgfx[i] = ints[i + 1];
-	return 1;
-}
-static int __init tgfx_setup_2(char *str)
-{
-	int i, ints[9];
-	get_options(str, ARRAY_SIZE(ints), ints);
-	for (i = 0; i <= ints[0] && i < 8; i++) tgfx_2[i] = ints[i + 1];
-	return 1;
-}
-static int __init tgfx_setup_3(char *str)
-{
-	int i, ints[9];
-	get_options(str, ARRAY_SIZE(ints), ints);
-	for (i = 0; i <= ints[0] && i < 8; i++) tgfx_3[i] = ints[i + 1];
-	return 1;
-}
-__setup("tgfx=", tgfx_setup);
-__setup("tgfx_2=", tgfx_setup_2);
-__setup("tgfx_3=", tgfx_setup_3);
-#endif
-
 int __init tgfx_init(void)
 {
-	tgfx_base[0] = tgfx_probe(tgfx);
-	tgfx_base[1] = tgfx_probe(tgfx_2);
-	tgfx_base[2] = tgfx_probe(tgfx_3);
+	tgfx_base[0] = tgfx_probe(tgfx, tgfx_nargs);
+	tgfx_base[1] = tgfx_probe(tgfx_2, tgfx_nargs_2);
+	tgfx_base[2] = tgfx_probe(tgfx_3, tgfx_nargs_3);
 
 	if (tgfx_base[0] || tgfx_base[1] || tgfx_base[2])
 		return 0;
