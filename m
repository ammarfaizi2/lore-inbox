Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262450AbSLBKzK>; Mon, 2 Dec 2002 05:55:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262464AbSLBKzK>; Mon, 2 Dec 2002 05:55:10 -0500
Received: from d146.dhcp212-198-27.noos.fr ([212.198.27.146]:27591 "EHLO
	deep-space-9.dsnet") by vger.kernel.org with ESMTP
	id <S262450AbSLBKy4>; Mon, 2 Dec 2002 05:54:56 -0500
Date: Mon, 2 Dec 2002 12:02:13 +0100
From: Stelian Pop <stelian@popies.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH 2.4.20] sonypi driver update
Message-ID: <20021202120213.B17187@deep-space-9.dsnet>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a rather large cumulative patch updating the sonypi driver.
It superceeds the previous patch I send (during the 2.4.20-rc series),
so please don't apply that one if you have it in your queue.

The most important changes are:
        * add suspend/resume support to the sonypi driver (Florian Lohoff);
        * add "Zoom" and "Thumbphrase" buttons (Francois Gurin);
        * add camera and lid events for C1XE (Kunihiko IMAI);
        * add a mask parameter letting the user choose what kind
          of events he wants;
	* add Memory Stick events (Kunihiko IMAI);
        * several source cleanups.

Marcelo, please apply.

Stelian.

===== Documentation/sonypi.txt 1.8 vs edited =====
--- 1.8/Documentation/sonypi.txt	Wed Apr 17 15:59:51 2002
+++ edited/Documentation/sonypi.txt	Mon Dec  2 11:18:30 2002
@@ -1,6 +1,7 @@
 Sony Programmable I/O Control Device Driver Readme
 --------------------------------------------------
-	Copyright (C) 2001 Stelian Pop <stelian.pop@fr.alcove.com>, Alcôve
+	Copyright (C) 2001-2002 Stelian Pop <stelian@popies.net>
+	Copyright (C) 2001-2002 Alcôve <www.alcove.com>
 	Copyright (C) 2001 Michael Ashley <m.ashley@unsw.edu.au>
 	Copyright (C) 2001 Junichi Morita <jun1m@mars.dti.ne.jp>
 	Copyright (C) 2000 Takaya Kinjo <t-kinjo@tc4.so-net.ne.jp>
@@ -15,14 +16,14 @@
 	- capture button events (only on Vaio Picturebook series)
 	- Fn keys
 	- bluetooth button (only on C1VR model)
-	- back button (PCG-GR7/K model)
-	- lid open/close events (Z600NE model)
+	- programmable keys, back, help, zoom, thumbphrase buttons, etc.
+	  (when available)
 
 Those events (see linux/sonypi.h) can be polled using the character device node
 /dev/sonypi (major 10, minor auto allocated or specified as a option).
 
 A simple daemon which translates the jogdial movements into mouse wheel events
-can be downloaded at: <http://www.alcove-labs.org/en/software/sonypi/>
+can be downloaded at: <http://popies.net/sonypi/>
 
 This driver supports also some ioctl commands for setting the LCD screen
 brightness and querying the batteries charge information (some more 
@@ -43,7 +44,7 @@
 to /etc/modules.conf file, when the driver is compiled as a module or by
 adding the following to the kernel command line (in your bootloader):
 
-	sonypi=minor[,verbose[,fnkeyinit[,camera[,compat[,nojogdial]]]]]
+	sonypi=minor[,verbose[,fnkeyinit[,camera[,compat[,mask]]]]]
 
 where:
 
@@ -64,15 +65,37 @@
 			with it and it shouldn't be required anyway if 
 			ACPI is already enabled).
 
-	verbose:	print unknown events from the sonypi device
+	verbose:	set to 1 to print unknown events received from the 
+			sonypi device.
+			set to 2 to print all events received from the 
+			sonypi device.
 
 	compat:		uses some compatibility code for enabling the sonypi
 			events. If the driver worked for you in the past
 			(prior to version 1.5) and does not work anymore,
 			add this option and report to the author.
 
-	nojogdial:	gives more accurate PKEY events on those Vaio models
-			which don't have a jogdial (like the FX series).
+	mask:		event mask telling the driver what events will be
+			reported to the user. This parameter is required for some 
+			Vaio models where the hardware reuses values used in 
+			other Vaio models (like the FX series who does not
+			have a jogdial but reuses the jogdial events for
+			programmable keys events). The default event mask is
+			set to 0xffffffff, meaning that all possible events will be
+			tried. You can use the following bits to construct
+			your own event mask (from drivers/char/sonypi.h):
+				SONYPI_JOGGER_MASK 		0x0001
+				SONYPI_CAPTURE_MASK 		0x0002
+				SONYPI_FNKEY_MASK 		0x0004
+				SONYPI_BLUETOOTH_MASK 		0x0008
+				SONYPI_PKEY_MASK 		0x0010
+				SONYPI_BACK_MASK 		0x0020
+				SONYPI_HELP_MASK 		0x0040
+				SONYPI_LID_MASK 		0x0080
+				SONYPI_ZOOM_MASK 		0x0100
+				SONYPI_THUMBPHRASE_MASK 	0x0200
+				SONYPI_MEYE_MASK		0x0400
+				SONYPI_MEMORYSTICK_MASK		0x0800
 
 Module use:
 -----------
===== include/linux/sonypi.h 1.6 vs edited =====
--- 1.6/include/linux/sonypi.h	Tue Aug  6 19:24:33 2002
+++ edited/include/linux/sonypi.h	Mon Dec  2 11:19:31 2002
@@ -1,7 +1,9 @@
 /* 
  * Sony Programmable I/O Control Device driver for VAIO
  *
- * Copyright (C) 2001 Stelian Pop <stelian.pop@fr.alcove.com>, Alcôve
+ * Copyright (C) 2001-2002 Stelian Pop <stelian@popies.net>
+ *
+ * Copyright (C) 2001-2002 Alcôve <www.alcove.com>
  *
  * Copyright (C) 2001 Michael Ashley <m.ashley@unsw.edu.au>
  *
@@ -76,6 +78,21 @@
 #define SONYPI_EVENT_BLUETOOTH_ON		38
 #define SONYPI_EVENT_BLUETOOTH_OFF		39
 #define SONYPI_EVENT_HELP_PRESSED		40
+#define SONYPI_EVENT_FNKEY_ONLY			41
+#define SONYPI_EVENT_JOGDIAL_FAST_DOWN		42
+#define SONYPI_EVENT_JOGDIAL_FAST_UP		43
+#define SONYPI_EVENT_JOGDIAL_FAST_DOWN_PRESSED	44
+#define SONYPI_EVENT_JOGDIAL_FAST_UP_PRESSED	45
+#define SONYPI_EVENT_JOGDIAL_VFAST_DOWN		46
+#define SONYPI_EVENT_JOGDIAL_VFAST_UP		47
+#define SONYPI_EVENT_JOGDIAL_VFAST_DOWN_PRESSED	48
+#define SONYPI_EVENT_JOGDIAL_VFAST_UP_PRESSED	49
+#define SONYPI_EVENT_ZOOM_PRESSED		50
+#define SONYPI_EVENT_THUMBPHRASE_PRESSED	51
+#define SONYPI_EVENT_MEYE_FACE			52
+#define SONYPI_EVENT_MEYE_OPPOSITE		53
+#define SONYPI_EVENT_MEMORYSTICK_INSERT		54
+#define SONYPI_EVENT_MEMORYSTICK_EJECT		55
 
 /* get/set brightness */
 #define SONYPI_IOCGBRT		_IOR('v', 0, __u8)
===== drivers/char/sonypi.h 1.11 vs edited =====
--- 1.11/drivers/char/sonypi.h	Mon Aug 12 18:10:21 2002
+++ edited/drivers/char/sonypi.h	Mon Dec  2 11:16:22 2002
@@ -1,7 +1,9 @@
 /* 
  * Sony Programmable I/O Control Device driver for VAIO
  *
- * Copyright (C) 2001 Stelian Pop <stelian.pop@fr.alcove.com>, Alcôve
+ * Copyright (C) 2001-2002 Stelian Pop <stelian@popies.net>
+ *
+ * Copyright (C) 2001-2002 Alcôve <www.alcove.com>
  *
  * Copyright (C) 2001 Michael Ashley <m.ashley@unsw.edu.au>
  *
@@ -35,10 +37,16 @@
 #ifdef __KERNEL__
 
 #define SONYPI_DRIVER_MAJORVERSION	 1
-#define SONYPI_DRIVER_MINORVERSION	13
+#define SONYPI_DRIVER_MINORVERSION	16
 
+#define SONYPI_DEVICE_MODEL_TYPE1	1
+#define SONYPI_DEVICE_MODEL_TYPE2	2
+
+#include <linux/config.h>
 #include <linux/types.h>
 #include <linux/pci.h>
+#include <linux/pm.h>
+#include <linux/acpi.h>
 #include "linux/sonypi.h"
 
 /* type1 models use those */
@@ -54,6 +62,20 @@
 #define SONYPI_SHIB			0x9d
 #define SONYPI_TYPE2_REGION_SIZE	0x20
 
+/* battery / brightness addresses */
+#define SONYPI_BAT_FLAGS	0x81
+#define SONYPI_LCD_LIGHT	0x96
+#define SONYPI_BAT1_PCTRM	0xa0
+#define SONYPI_BAT1_LEFT	0xa2
+#define SONYPI_BAT1_MAXRT	0xa4
+#define SONYPI_BAT2_PCTRM	0xa8
+#define SONYPI_BAT2_LEFT	0xaa
+#define SONYPI_BAT2_MAXRT	0xac
+#define SONYPI_BAT1_MAXTK	0xb0
+#define SONYPI_BAT1_FULL	0xb2
+#define SONYPI_BAT2_MAXTK	0xb8
+#define SONYPI_BAT2_FULL	0xba
+
 /* ioports used for brightness and type2 events */
 #define SONYPI_DATA_IOPORT	0x62
 #define SONYPI_CST_IOPORT	0x66
@@ -131,34 +153,41 @@
 #define SONYPI_CAMERA_REVISION 			8
 #define SONYPI_CAMERA_ROMVERSION 		9
 
-/* key press event data (ioport2) */
-#define SONYPI_TYPE1_JOGGER_EV		0x10
-#define SONYPI_TYPE2_JOGGER_EV		0x08
-#define SONYPI_TYPE1_CAPTURE_EV		0x60
-#define SONYPI_TYPE2_CAPTURE_EV		0x08
-#define SONYPI_TYPE1_FNKEY_EV		0x20
-#define SONYPI_TYPE2_FNKEY_EV		0x08
-#define SONYPI_TYPE1_BLUETOOTH_EV	0x30
-#define SONYPI_TYPE2_BLUETOOTH_EV	0x08
-#define SONYPI_TYPE1_PKEY_EV		0x40
-#define SONYPI_TYPE2_PKEY_EV		0x08
-#define SONYPI_BACK_EV			0x08
-#define SONYPI_LID_EV			0x38
+/* Event masks */
+#define SONYPI_JOGGER_MASK			0x00000001
+#define SONYPI_CAPTURE_MASK			0x00000002
+#define SONYPI_FNKEY_MASK			0x00000004
+#define SONYPI_BLUETOOTH_MASK			0x00000008
+#define SONYPI_PKEY_MASK			0x00000010
+#define SONYPI_BACK_MASK			0x00000020
+#define SONYPI_HELP_MASK			0x00000040
+#define SONYPI_LID_MASK				0x00000080
+#define SONYPI_ZOOM_MASK			0x00000100
+#define SONYPI_THUMBPHRASE_MASK			0x00000200
+#define SONYPI_MEYE_MASK			0x00000400
+#define SONYPI_MEMORYSTICK_MASK			0x00000800
 
 struct sonypi_event {
 	u8	data;
 	u8	event;
 };
-
 /* The set of possible jogger events  */
 static struct sonypi_event sonypi_joggerev[] = {
 	{ 0x1f, SONYPI_EVENT_JOGDIAL_UP },
 	{ 0x01, SONYPI_EVENT_JOGDIAL_DOWN },
 	{ 0x5f, SONYPI_EVENT_JOGDIAL_UP_PRESSED },
 	{ 0x41, SONYPI_EVENT_JOGDIAL_DOWN_PRESSED },
+	{ 0x1e, SONYPI_EVENT_JOGDIAL_FAST_UP },
+	{ 0x02, SONYPI_EVENT_JOGDIAL_FAST_DOWN },
+	{ 0x5e, SONYPI_EVENT_JOGDIAL_FAST_UP_PRESSED },
+	{ 0x42, SONYPI_EVENT_JOGDIAL_FAST_DOWN_PRESSED },
+	{ 0x1d, SONYPI_EVENT_JOGDIAL_VFAST_UP },
+	{ 0x03, SONYPI_EVENT_JOGDIAL_VFAST_DOWN },
+	{ 0x5d, SONYPI_EVENT_JOGDIAL_VFAST_UP_PRESSED },
+	{ 0x43, SONYPI_EVENT_JOGDIAL_VFAST_DOWN_PRESSED },
 	{ 0x40, SONYPI_EVENT_JOGDIAL_PRESSED },
 	{ 0x00, SONYPI_EVENT_JOGDIAL_RELEASED },
-	{ 0x00, 0x00 }
+	{ 0, 0 }
 };
 
 /* The set of possible capture button events */
@@ -167,7 +196,7 @@
 	{ 0x07, SONYPI_EVENT_CAPTURE_PRESSED },
 	{ 0x01, SONYPI_EVENT_CAPTURE_PARTIALRELEASED },
 	{ 0x00, SONYPI_EVENT_CAPTURE_RELEASED },
-	{ 0x00, 0x00 }
+	{ 0, 0 }
 };
 
 /* The set of possible fnkeys events */
@@ -192,7 +221,8 @@
 	{ 0x33, SONYPI_EVENT_FNKEY_F },
 	{ 0x34, SONYPI_EVENT_FNKEY_S },
 	{ 0x35, SONYPI_EVENT_FNKEY_B },
-	{ 0x00, 0x00 }
+	{ 0x36, SONYPI_EVENT_FNKEY_ONLY },
+	{ 0, 0 }
 };
 
 /* The set of possible program key events */
@@ -200,7 +230,7 @@
 	{ 0x01, SONYPI_EVENT_PKEY_P1 },
 	{ 0x02, SONYPI_EVENT_PKEY_P2 },
 	{ 0x04, SONYPI_EVENT_PKEY_P3 },
-	{ 0x00, 0x00 }
+	{ 0, 0 }
 };
 
 /* The set of possible bluetooth events */
@@ -208,21 +238,82 @@
 	{ 0x55, SONYPI_EVENT_BLUETOOTH_PRESSED },
 	{ 0x59, SONYPI_EVENT_BLUETOOTH_ON },
 	{ 0x5a, SONYPI_EVENT_BLUETOOTH_OFF },
-	{ 0x00, 0x00 }
+	{ 0, 0 }
 };
 
 /* The set of possible back button events */
 static struct sonypi_event sonypi_backev[] = {
 	{ 0x20, SONYPI_EVENT_BACK_PRESSED },
+	{ 0, 0 }
+};
+
+/* The set of possible help button events */
+static struct sonypi_event sonypi_helpev[] = {
 	{ 0x3b, SONYPI_EVENT_HELP_PRESSED },
-	{ 0x00, 0x00 }
+	{ 0, 0 }
 };
 
+
 /* The set of possible lid events */
 static struct sonypi_event sonypi_lidev[] = {
 	{ 0x51, SONYPI_EVENT_LID_CLOSED },
 	{ 0x50, SONYPI_EVENT_LID_OPENED },
-	{ 0x00, 0x00 }
+	{ 0, 0 }
+};
+
+/* The set of possible zoom events */
+static struct sonypi_event sonypi_zoomev[] = {
+	{ 0x39, SONYPI_EVENT_ZOOM_PRESSED },
+	{ 0, 0 }
+};
+
+/* The set of possible thumbphrase events */
+static struct sonypi_event sonypi_thumbphraseev[] = {
+	{ 0x3a, SONYPI_EVENT_THUMBPHRASE_PRESSED },
+	{ 0, 0 }
+};
+
+/* The set of possible motioneye camera events */
+static struct sonypi_event sonypi_meyeev[] = {
+	{ 0x00, SONYPI_EVENT_MEYE_FACE },
+	{ 0x01, SONYPI_EVENT_MEYE_OPPOSITE },
+	{ 0, 0 }
+};
+
+/* The set of possible memorystick events */
+static struct sonypi_event sonypi_memorystickev[] = {
+	{ 0x53, SONYPI_EVENT_MEMORYSTICK_INSERT },
+	{ 0x54, SONYPI_EVENT_MEMORYSTICK_EJECT },
+	{ 0, 0 }
+};
+
+struct sonypi_eventtypes {
+	int			model;
+	u8			data;
+	unsigned long		mask;
+	struct sonypi_event *	events;
+} sonypi_eventtypes[] = {
+	{ SONYPI_DEVICE_MODEL_TYPE1, 0x70, SONYPI_MEYE_MASK, sonypi_meyeev },
+	{ SONYPI_DEVICE_MODEL_TYPE1, 0x30, SONYPI_LID_MASK, sonypi_lidev },
+	{ SONYPI_DEVICE_MODEL_TYPE1, 0x60, SONYPI_CAPTURE_MASK, sonypi_captureev },
+	{ SONYPI_DEVICE_MODEL_TYPE1, 0x10, SONYPI_JOGGER_MASK, sonypi_joggerev },
+	{ SONYPI_DEVICE_MODEL_TYPE1, 0x20, SONYPI_FNKEY_MASK, sonypi_fnkeyev },
+	{ SONYPI_DEVICE_MODEL_TYPE1, 0x30, SONYPI_BLUETOOTH_MASK, sonypi_blueev },
+	{ SONYPI_DEVICE_MODEL_TYPE1, 0x40, SONYPI_PKEY_MASK, sonypi_pkeyev },
+
+	{ SONYPI_DEVICE_MODEL_TYPE2, 0x38, SONYPI_LID_MASK, sonypi_lidev },
+	{ SONYPI_DEVICE_MODEL_TYPE2, 0x08, SONYPI_JOGGER_MASK, sonypi_joggerev },
+	{ SONYPI_DEVICE_MODEL_TYPE2, 0x08, SONYPI_CAPTURE_MASK, sonypi_captureev },
+	{ SONYPI_DEVICE_MODEL_TYPE2, 0x08, SONYPI_FNKEY_MASK, sonypi_fnkeyev },
+	{ SONYPI_DEVICE_MODEL_TYPE2, 0x08, SONYPI_BLUETOOTH_MASK, sonypi_blueev },
+	{ SONYPI_DEVICE_MODEL_TYPE2, 0x08, SONYPI_PKEY_MASK, sonypi_pkeyev },
+	{ SONYPI_DEVICE_MODEL_TYPE2, 0x08, SONYPI_BACK_MASK, sonypi_backev },
+	{ SONYPI_DEVICE_MODEL_TYPE2, 0x08, SONYPI_HELP_MASK, sonypi_helpev },
+	{ SONYPI_DEVICE_MODEL_TYPE2, 0x08, SONYPI_ZOOM_MASK, sonypi_zoomev },
+	{ SONYPI_DEVICE_MODEL_TYPE2, 0x08, SONYPI_THUMBPHRASE_MASK, sonypi_thumbphraseev },
+	{ SONYPI_DEVICE_MODEL_TYPE2, 0x08, SONYPI_MEMORYSTICK_MASK, sonypi_memorystickev },
+
+	{ 0, 0, 0, 0 }
 };
 
 #define SONYPI_BUF_SIZE	128
@@ -236,9 +327,6 @@
 	unsigned char buf[SONYPI_BUF_SIZE];
 };
 
-#define SONYPI_DEVICE_MODEL_TYPE1	1
-#define SONYPI_DEVICE_MODEL_TYPE2	2
-
 struct sonypi_device {
 	struct pci_dev *dev;
 	u16 irq;
@@ -252,14 +340,43 @@
 	struct sonypi_queue queue;
 	int open_count;
 	int model;
+#if CONFIG_PM
+	struct pm_dev *pm;
+#endif
 };
 
-#define wait_on_command(quiet, command) { \
-	unsigned int n = 10000; \
+#define ITERATIONS_LONG		10000
+#define ITERATIONS_SHORT	10
+
+#define wait_on_command(quiet, command, iterations) { \
+	unsigned int n = iterations; \
 	while (--n && (command)) \
 		udelay(1); \
 	if (!n && (verbose || !quiet)) \
-		printk(KERN_WARNING "sonypi command failed at " __FILE__ " : %s (line %d)\n", __FUNCTION__, __LINE__); \
+		printk(KERN_WARNING "sonypi command failed at %s : %s (line %d)\n", __FILE__, __FUNCTION__, __LINE__); \
+}
+
+extern int verbose;
+
+static inline int ec_write(u8 addr, u8 value) {
+	wait_on_command(1, inb_p(SONYPI_CST_IOPORT) & 3, ITERATIONS_LONG);
+	outb_p(0x81, SONYPI_CST_IOPORT);
+	wait_on_command(0, inb_p(SONYPI_CST_IOPORT) & 2, ITERATIONS_LONG);
+	outb_p(addr, SONYPI_DATA_IOPORT);
+	wait_on_command(0, inb_p(SONYPI_CST_IOPORT) & 2, ITERATIONS_LONG);
+	outb_p(value, SONYPI_DATA_IOPORT);
+	wait_on_command(0, inb_p(SONYPI_CST_IOPORT) & 2, ITERATIONS_LONG);
+	return 0;
+}
+
+static inline int ec_read(u8 addr, u8 *value) {
+	wait_on_command(1, inb_p(SONYPI_CST_IOPORT) & 3, ITERATIONS_LONG);
+	outb_p(0x80, SONYPI_CST_IOPORT);
+	wait_on_command(0, inb_p(SONYPI_CST_IOPORT) & 2, ITERATIONS_LONG);
+	outb_p(addr, SONYPI_DATA_IOPORT);
+	wait_on_command(0, inb_p(SONYPI_CST_IOPORT) & 2, ITERATIONS_LONG);
+	*value = inb_p(SONYPI_DATA_IOPORT);
+	return 0;
 }
 
 #endif /* __KERNEL__ */
===== drivers/char/sonypi.c 1.10 vs edited =====
--- 1.10/drivers/char/sonypi.c	Mon Apr 29 12:39:37 2002
+++ edited/drivers/char/sonypi.c	Fri Nov 22 13:49:08 2002
@@ -1,7 +1,9 @@
-/* 
+/*
  * Sony Programmable I/O Control Device driver for VAIO
  *
- * Copyright (C) 2001 Stelian Pop <stelian.pop@fr.alcove.com>, Alcôve
+ * Copyright (C) 2001-2002 Stelian Pop <stelian@popies.net>
+ *
+ * Copyright (C) 2001-2002 Alcôve <www.alcove.com>
  *
  * Copyright (C) 2001 Michael Ashley <m.ashley@unsw.edu.au>
  *
@@ -34,9 +36,13 @@
 #include <linux/pci.h>
 #include <linux/sched.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/miscdevice.h>
 #include <linux/poll.h>
 #include <linux/delay.h>
+#include <linux/wait.h>
+#include <linux/acpi.h>
+
 #include <asm/uaccess.h>
 #include <asm/io.h>
 #include <asm/system.h>
@@ -50,7 +56,7 @@
 static int fnkeyinit; /* = 0 */
 static int camera; /* = 0 */
 static int compat; /* = 0 */
-static int nojogdial; /* = 0 */
+static unsigned long mask = 0xffffffff;
 
 /* Inits the queue */
 static inline void sonypi_initq(void) {
@@ -110,29 +116,14 @@
         return result;
 }
 
-static void sonypi_ecrset(u8 addr, u8 value) {
-
-	wait_on_command(1, inb_p(SONYPI_CST_IOPORT) & 3);
-	outb_p(0x81, SONYPI_CST_IOPORT);
-	wait_on_command(0, inb_p(SONYPI_CST_IOPORT) & 2);
-	outb_p(addr, SONYPI_DATA_IOPORT);
-	wait_on_command(0, inb_p(SONYPI_CST_IOPORT) & 2);
-	outb_p(value, SONYPI_DATA_IOPORT);
-	wait_on_command(0, inb_p(SONYPI_CST_IOPORT) & 2);
-}
-
-static u8 sonypi_ecrget(u8 addr) {
-
-	wait_on_command(1, inb_p(SONYPI_CST_IOPORT) & 3);
-	outb_p(0x80, SONYPI_CST_IOPORT);
-	wait_on_command(0, inb_p(SONYPI_CST_IOPORT) & 2);
-	outb_p(addr, SONYPI_DATA_IOPORT);
-	wait_on_command(0, inb_p(SONYPI_CST_IOPORT) & 2);
-	return inb_p(SONYPI_DATA_IOPORT);
-}
-
-static u16 sonypi_ecrget16(u8 addr) {
-	return sonypi_ecrget(addr) | (sonypi_ecrget(addr + 1) << 8);
+static int ec_read16(u8 addr, u16 *value) {
+	u8 val_lb, val_hb;
+	if (ec_read(addr, &val_lb))
+		return -1;
+	if (ec_read(addr + 1, &val_hb))
+		return -1;
+	*value = val_lb | (val_hb << 8);
+	return 0;
 }
 
 /* Initializes the device - this comes from the AML code in the ACPI bios */
@@ -159,9 +150,12 @@
 }
 
 static void __devinit sonypi_type2_srs(void) {
-	sonypi_ecrset(SONYPI_SHIB, (sonypi_device.ioport1 & 0xFF00) >> 8);
-	sonypi_ecrset(SONYPI_SLOB,  sonypi_device.ioport1 & 0x00FF);
-	sonypi_ecrset(SONYPI_SIRQ,  sonypi_device.bits);
+	if (ec_write(SONYPI_SHIB, (sonypi_device.ioport1 & 0xFF00) >> 8))
+		printk(KERN_WARNING "ec_write failed\n");
+	if (ec_write(SONYPI_SLOB,  sonypi_device.ioport1 & 0x00FF))
+		printk(KERN_WARNING "ec_write failed\n");
+	if (ec_write(SONYPI_SIRQ,  sonypi_device.bits))
+		printk(KERN_WARNING "ec_write failed\n");
 	udelay(10);
 }
 
@@ -179,15 +173,18 @@
 }
 
 static void __devexit sonypi_type2_dis(void) {
-	sonypi_ecrset(SONYPI_SHIB, 0);
-	sonypi_ecrset(SONYPI_SLOB, 0);
-	sonypi_ecrset(SONYPI_SIRQ, 0);
+	if (ec_write(SONYPI_SHIB, 0))
+		printk(KERN_WARNING "ec_write failed\n");
+	if (ec_write(SONYPI_SLOB, 0))
+		printk(KERN_WARNING "ec_write failed\n");
+	if (ec_write(SONYPI_SIRQ, 0))
+		printk(KERN_WARNING "ec_write failed\n");
 }
 
 static u8 sonypi_call1(u8 dev) {
 	u8 v1, v2;
 
-	wait_on_command(0, inb_p(sonypi_device.ioport2) & 2);
+	wait_on_command(0, inb_p(sonypi_device.ioport2) & 2, ITERATIONS_LONG);
 	outb(dev, sonypi_device.ioport2);
 	v1 = inb_p(sonypi_device.ioport2);
 	v2 = inb_p(sonypi_device.ioport1);
@@ -197,9 +194,9 @@
 static u8 sonypi_call2(u8 dev, u8 fn) {
 	u8 v1;
 
-	wait_on_command(0, inb_p(sonypi_device.ioport2) & 2);
+	wait_on_command(0, inb_p(sonypi_device.ioport2) & 2, ITERATIONS_LONG);
 	outb(dev, sonypi_device.ioport2);
-	wait_on_command(0, inb_p(sonypi_device.ioport2) & 2);
+	wait_on_command(0, inb_p(sonypi_device.ioport2) & 2, ITERATIONS_LONG);
 	outb(fn, sonypi_device.ioport1);
 	v1 = inb_p(sonypi_device.ioport1);
 	return v1;
@@ -208,11 +205,11 @@
 static u8 sonypi_call3(u8 dev, u8 fn, u8 v) {
 	u8 v1;
 
-	wait_on_command(0, inb_p(sonypi_device.ioport2) & 2);
+	wait_on_command(0, inb_p(sonypi_device.ioport2) & 2, ITERATIONS_LONG);
 	outb(dev, sonypi_device.ioport2);
-	wait_on_command(0, inb_p(sonypi_device.ioport2) & 2);
+	wait_on_command(0, inb_p(sonypi_device.ioport2) & 2, ITERATIONS_LONG);
 	outb(fn, sonypi_device.ioport1);
-	wait_on_command(0, inb_p(sonypi_device.ioport2) & 2);
+	wait_on_command(0, inb_p(sonypi_device.ioport2) & 2, ITERATIONS_LONG);
 	outb(v, sonypi_device.ioport1);
 	v1 = inb_p(sonypi_device.ioport1);
 	return v1;
@@ -234,7 +231,7 @@
 /* Set brightness, hue etc */
 static void sonypi_set(u8 fn, u8 v) {
 	
-	wait_on_command(0, sonypi_call3(0x90, fn, v));
+	wait_on_command(0, sonypi_call3(0x90, fn, v), ITERATIONS_SHORT);
 }
 
 /* Tests if the camera is ready */
@@ -308,79 +305,30 @@
 /* Interrupt handler: some event is available */
 void sonypi_irq(int irq, void *dev_id, struct pt_regs *regs) {
 	u8 v1, v2, event = 0;
-	int i;
-	u8 sonypi_jogger_ev, sonypi_fnkey_ev;
-	u8 sonypi_capture_ev, sonypi_bluetooth_ev;
-	u8 sonypi_pkey_ev;
-
-	if (sonypi_device.model == SONYPI_DEVICE_MODEL_TYPE2) {
-		sonypi_jogger_ev = SONYPI_TYPE2_JOGGER_EV;
-		sonypi_fnkey_ev = SONYPI_TYPE2_FNKEY_EV;
-		sonypi_capture_ev = SONYPI_TYPE2_CAPTURE_EV;
-		sonypi_bluetooth_ev = SONYPI_TYPE2_BLUETOOTH_EV;
-		sonypi_pkey_ev = nojogdial ? SONYPI_TYPE2_PKEY_EV 
-					   : SONYPI_TYPE1_PKEY_EV;
-	}
-	else {
-		sonypi_jogger_ev = SONYPI_TYPE1_JOGGER_EV;
-		sonypi_fnkey_ev = SONYPI_TYPE1_FNKEY_EV;
-		sonypi_capture_ev = SONYPI_TYPE1_CAPTURE_EV;
-		sonypi_bluetooth_ev = SONYPI_TYPE1_BLUETOOTH_EV;
-		sonypi_pkey_ev = SONYPI_TYPE1_PKEY_EV;
-	}
+	int i, j;
 
 	v1 = inb_p(sonypi_device.ioport1);
 	v2 = inb_p(sonypi_device.ioport2);
 
-	if ((v2 & sonypi_pkey_ev) == sonypi_pkey_ev) {
-		for (i = 0; sonypi_pkeyev[i].event; i++)
-			if (sonypi_pkeyev[i].data == v1) {
-				event = sonypi_pkeyev[i].event;
-				goto found;
-			}
-	}
-	if ((v2 & sonypi_jogger_ev) == sonypi_jogger_ev) {
-		for (i = 0; sonypi_joggerev[i].event; i++)
-			if (sonypi_joggerev[i].data == v1) {
-				event = sonypi_joggerev[i].event;
-				goto found;
-			}
-	}
-	if ((v2 & sonypi_capture_ev) == sonypi_capture_ev) {
-		for (i = 0; sonypi_captureev[i].event; i++)
-			if (sonypi_captureev[i].data == v1) {
-				event = sonypi_captureev[i].event;
-				goto found;
-			}
-	}
-	if ((v2 & sonypi_fnkey_ev) == sonypi_fnkey_ev) {
-		for (i = 0; sonypi_fnkeyev[i].event; i++)
-			if (sonypi_fnkeyev[i].data == v1) {
-				event = sonypi_fnkeyev[i].event;
-				goto found;
-			}
-	}
-	if ((v2 & sonypi_bluetooth_ev) == sonypi_bluetooth_ev) {
-		for (i = 0; sonypi_blueev[i].event; i++)
-			if (sonypi_blueev[i].data == v1) {
-				event = sonypi_blueev[i].event;
-				goto found;
-			}
-	}
-	if ((v2 & SONYPI_BACK_EV) == SONYPI_BACK_EV) {
-		for (i = 0; sonypi_backev[i].event; i++)
-			if (sonypi_backev[i].data == v1) {
-				event = sonypi_backev[i].event;
-				goto found;
-			}
-	}
-	if ((v2 & SONYPI_LID_EV) == SONYPI_LID_EV) {
-		for (i = 0; sonypi_lidev[i].event; i++)
-			if (sonypi_lidev[i].data == v1) {
-				event = sonypi_lidev[i].event;
+	if (verbose > 1)
+		printk(KERN_INFO 
+		       "sonypi: event port1=0x%02x,port2=0x%02x\n", v1, v2);
+
+	for (i = 0; sonypi_eventtypes[i].model; i++) {
+		if (sonypi_device.model != sonypi_eventtypes[i].model)
+			continue;
+		if ((v2 & sonypi_eventtypes[i].data) != sonypi_eventtypes[i].data)
+			continue;
+		if (! (mask & sonypi_eventtypes[i].mask))
+			continue;
+		for (j = 0; sonypi_eventtypes[i].events[j].event; j++) {
+			if (v1 == sonypi_eventtypes[i].events[j].data) {
+				event = sonypi_eventtypes[i].events[j].event;
 				goto found;
 			}
+		}
 	}
+
 	if (verbose)
 		printk(KERN_WARNING 
 		       "sonypi: unknown event port1=0x%02x,port2=0x%02x\n",v1,v2);
@@ -542,90 +490,140 @@
 	down(&sonypi_device.lock);
 	switch (cmd) {
 	case SONYPI_IOCGBRT:
-		val8 = sonypi_ecrget(0x96);
-		if (copy_to_user((u8 *)arg, &val8, sizeof(val8))) {
-			ret = -EFAULT;
-			goto out;
+		if (ec_read(SONYPI_LCD_LIGHT, &val8)) {
+			ret = -EIO;
+			break;
 		}
+		if (copy_to_user((u8 *)arg, &val8, sizeof(val8)))
+			ret = -EFAULT;
 		break;
 	case SONYPI_IOCSBRT:
 		if (copy_from_user(&val8, (u8 *)arg, sizeof(val8))) {
 			ret = -EFAULT;
-			goto out;
+			break;
 		}
-		sonypi_ecrset(0x96, val8);
+		if (ec_write(SONYPI_LCD_LIGHT, val8))
+			ret = -EIO;
 		break;
 	case SONYPI_IOCGBAT1CAP:
-		val16 = sonypi_ecrget16(0xb2);
-		if (copy_to_user((u16 *)arg, &val16, sizeof(val16))) {
-			ret = -EFAULT;
-			goto out;
+		if (ec_read16(SONYPI_BAT1_FULL, &val16)) {
+			ret = -EIO;
+			break;
 		}
+		if (copy_to_user((u16 *)arg, &val16, sizeof(val16)))
+			ret = -EFAULT;
 		break;
 	case SONYPI_IOCGBAT1REM:
-		val16 = sonypi_ecrget16(0xa2);
-		if (copy_to_user((u16 *)arg, &val16, sizeof(val16))) {
-			ret = -EFAULT;
-			goto out;
+		if (ec_read16(SONYPI_BAT1_FULL, &val16)) {
+			ret = -EIO;
+			break;
 		}
+		if (copy_to_user((u16 *)arg, &val16, sizeof(val16)))
+			ret = -EFAULT;
 		break;
 	case SONYPI_IOCGBAT2CAP:
-		val16 = sonypi_ecrget16(0xba);
-		if (copy_to_user((u16 *)arg, &val16, sizeof(val16))) {
-			ret = -EFAULT;
-			goto out;
+		if (ec_read16(SONYPI_BAT1_FULL, &val16)) {
+			ret = -EIO;
+			break;
 		}
+		if (copy_to_user((u16 *)arg, &val16, sizeof(val16)))
+			ret = -EFAULT;
 		break;
 	case SONYPI_IOCGBAT2REM:
-		val16 = sonypi_ecrget16(0xaa);
-		if (copy_to_user((u16 *)arg, &val16, sizeof(val16))) {
-			ret = -EFAULT;
-			goto out;
+		if (ec_read16(SONYPI_BAT1_FULL, &val16)) {
+			ret = -EIO;
+			break;
 		}
+		if (copy_to_user((u16 *)arg, &val16, sizeof(val16)))
+			ret = -EFAULT;
 		break;
 	case SONYPI_IOCGBATFLAGS:
-		val8 = sonypi_ecrget(0x81) & 0x07;
-		if (copy_to_user((u8 *)arg, &val8, sizeof(val8))) {
-			ret = -EFAULT;
-			goto out;
+		if (ec_read(SONYPI_BAT_FLAGS, &val8)) {
+			ret = -EIO;
+			break;
 		}
+		val8 &= 0x07;
+		if (copy_to_user((u8 *)arg, &val8, sizeof(val8)))
+			ret = -EFAULT;
 		break;
 	case SONYPI_IOCGBLUE:
 		val8 = sonypi_device.bluetooth_power;
-		if (copy_to_user((u8 *)arg, &val8, sizeof(val8))) {
+		if (copy_to_user((u8 *)arg, &val8, sizeof(val8)))
 			ret = -EFAULT;
-			goto out;
-		}
 		break;
 	case SONYPI_IOCSBLUE:
 		if (copy_from_user(&val8, (u8 *)arg, sizeof(val8))) {
 			ret = -EFAULT;
-			goto out;
+			break;
 		}
 		sonypi_setbluetoothpower(val8);
 		break;
 	default:
 		ret = -EINVAL;
 	}
-out:
 	up(&sonypi_device.lock);
 	return ret;
 }
 
 static struct file_operations sonypi_misc_fops = {
-	owner:		THIS_MODULE,
-	read:		sonypi_misc_read,
-	poll:		sonypi_misc_poll,
-	open:		sonypi_misc_open,
-	release:	sonypi_misc_release,
-	fasync: 	sonypi_misc_fasync,
-	ioctl:		sonypi_misc_ioctl,
+	.owner		= THIS_MODULE,
+	.read		= sonypi_misc_read,
+	.poll		= sonypi_misc_poll,
+	.open		= sonypi_misc_open,
+	.release	= sonypi_misc_release,
+	.fasync		= sonypi_misc_fasync,
+	.ioctl		= sonypi_misc_ioctl,
 };
 
 struct miscdevice sonypi_misc_device = {
 	-1, "sonypi", &sonypi_misc_fops
 };
 
+#if CONFIG_PM
+static int sonypi_pm_callback(struct pm_dev *dev, pm_request_t rqst, void *data) {
+	static int old_camera_power;
+
+	switch (rqst) {
+	case PM_SUSPEND:
+		sonypi_call2(0x81, 0); /* make sure we don't get any more events */
+		if (camera) {
+			old_camera_power = sonypi_device.camera_power;
+			sonypi_camera_off();
+		}
+		if (sonypi_device.model == SONYPI_DEVICE_MODEL_TYPE2)
+			sonypi_type2_dis();
+		else
+			sonypi_type1_dis();
+#if !defined(CONFIG_ACPI)
+		/* disable ACPI mode */
+		if (fnkeyinit)
+			outb(0xf1, 0xb2);
+#endif
+		break;
+	case PM_RESUME:
+#if !defined(CONFIG_ACPI)
+		/* Enable ACPI mode to get Fn key events */
+		if (fnkeyinit)
+			outb(0xf0, 0xb2);
+#endif
+		if (sonypi_device.model == SONYPI_DEVICE_MODEL_TYPE2)
+			sonypi_type2_srs();
+		else
+			sonypi_type1_srs();
+		sonypi_call1(0x82);
+		sonypi_call2(0x81, 0xff);
+		if (compat)
+			sonypi_call1(0x92); 
+		else
+			sonypi_call1(0x82);
+		if (camera && old_camera_power)
+			sonypi_camera_on();
+		break;
+	}
+	return 0;
+}
+#endif
+
 static int __devinit sonypi_probe(struct pci_dev *pcidev) {
 	int i, ret;
 	struct sonypi_ioport_list *ioport_list;
@@ -717,14 +715,14 @@
 	       SONYPI_DRIVER_MINORVERSION);
 	printk(KERN_INFO "sonypi: detected %s model, "
 	       "verbose = %s, fnkeyinit = %s, camera = %s, "
-	       "compat = %s, nojogdial = %s\n",
+	       "compat = %s, mask = 0x%08lx\n",
 	       (sonypi_device.model == SONYPI_DEVICE_MODEL_TYPE1) ?
 			"type1" : "type2",
 	       verbose ? "on" : "off",
 	       fnkeyinit ? "on" : "off",
 	       camera ? "on" : "off",
 	       compat ? "on" : "off",
-	       nojogdial ? "on" : "off");
+	       mask);
 	printk(KERN_INFO "sonypi: enabled at irq=%d, port1=0x%x, port2=0x%x\n",
 	       sonypi_device.irq, 
 	       sonypi_device.ioport1, sonypi_device.ioport2);
@@ -732,6 +730,10 @@
 		printk(KERN_INFO "sonypi: device allocated minor is %d\n",
 		       sonypi_misc_device.minor);
 
+#if CONFIG_PM
+	sonypi_device.pm = pm_register(PM_PCI_DEV, 0, sonypi_pm_callback);
+#endif
+
 	return 0;
 
 out3:
@@ -743,6 +745,11 @@
 }
 
 static void __devexit sonypi_remove(void) {
+
+#if CONFIG_PM
+	pm_unregister(sonypi_device.pm);
+#endif
+
 	sonypi_call2(0x81, 0); /* make sure we don't get any more events */
 	if (camera)
 		sonypi_camera_off();
@@ -800,7 +807,7 @@
 	compat = ints[5];
 	if (ints[0] == 5)
 		goto out;
-	nojogdial = ints[6];
+	mask = ints[6];
 out:
 	return 1;
 }
@@ -812,7 +819,7 @@
 module_init(sonypi_init_module);
 module_exit(sonypi_cleanup_module);
 
-MODULE_AUTHOR("Stelian Pop <stelian.pop@fr.alcove.com>");
+MODULE_AUTHOR("Stelian Pop <stelian@popies.net>");
 MODULE_DESCRIPTION("Sony Programmable I/O Control Device driver");
 MODULE_LICENSE("GPL");
 
@@ -827,7 +834,7 @@
 MODULE_PARM_DESC(camera, "set this if you have a MotionEye camera (PictureBook series)");
 MODULE_PARM(compat,"i");
 MODULE_PARM_DESC(compat, "set this if you want to enable backward compatibility mode");
-MODULE_PARM(nojogdial, "i");
-MODULE_PARM_DESC(nojogdial, "set this if you have a Vaio without a jogdial (like the fx series)");
+MODULE_PARM(mask, "i");
+MODULE_PARM_DESC(mask, "set this to the mask of event you want to enable (see doc)");
 
 EXPORT_SYMBOL(sonypi_camera_command);
-- 
Stelian Pop <stelian@popies.net>
