Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264064AbTHZOPQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 10:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264030AbTHZONq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 10:13:46 -0400
Received: from m94.net81-67-11.noos.fr ([81.67.11.94]:42143 "EHLO
	deep-space-9.dsnet") by vger.kernel.org with ESMTP id S263898AbTHZOIZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 10:08:25 -0400
Date: Tue, 26 Aug 2003 16:08:20 +0200
From: Stelian Pop <stelian@popies.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH 2.4.22] sonypi driver update
Message-ID: <20030826140820.GA9046@deep-space-9.dsnet>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Now that we are starting a new -pre cycle, here are the latest
sonypi updates:
	* document the fact that FX501/FX702 laptops are not supported
	
	* add battery insert/remove events (thanks to Daniel K.)
	
	* improve the event detection using a different port offset
	  on 'type2' models (thanks to Daniel K.)
	  
	* now that ACPI is finally in the kernel, simplify the ACPI
	  tests.

Marcelo, please apply.

Stelian.

===== Documentation/sonypi.txt 1.12 vs edited =====
--- 1.12/Documentation/sonypi.txt	Sun Jun 29 17:10:46 2003
+++ edited/Documentation/sonypi.txt	Tue Aug 26 16:01:45 2003
@@ -8,7 +8,9 @@
 	Copyright (C) 2000 Andrew Tridgell <tridge@samba.org>
 
 This driver enables access to the Sony Programmable I/O Control Device which
-can be found in many (all ?) Sony Vaio laptops.
+can be found in many Sony Vaio laptops. Some newer Sony laptops (seems to be
+limited to new FX series laptops, at least the FX501 and the FX702) lack a
+sonypi device and are not supported at all by this driver.
 
 It will give access (through a user space utility) to some events those laptops
 generate, like:
@@ -96,6 +98,7 @@
 				SONYPI_THUMBPHRASE_MASK 	0x0200
 				SONYPI_MEYE_MASK		0x0400
 				SONYPI_MEMORYSTICK_MASK		0x0800
+				SONYPI_BATTERY_MASK		0x1000
 
 	useinput:	if set (which is the default) jogdial events are
 			forwarded to the input subsystem as mouse wheel
===== include/linux/sonypi.h 1.9 vs edited =====
--- 1.9/include/linux/sonypi.h	Fri Feb 21 11:22:44 2003
+++ edited/include/linux/sonypi.h	Tue Aug 26 11:52:33 2003
@@ -94,6 +94,8 @@
 #define SONYPI_EVENT_MEMORYSTICK_INSERT		54
 #define SONYPI_EVENT_MEMORYSTICK_EJECT		55
 #define SONYPI_EVENT_ANYBUTTON_RELEASED		56
+#define SONYPI_EVENT_BATTERY_INSERT		57
+#define SONYPI_EVENT_BATTERY_REMOVE		58
 
 /* get/set brightness */
 #define SONYPI_IOCGBRT		_IOR('v', 0, __u8)
===== drivers/char/sonypi.h 1.17 vs edited =====
--- 1.17/drivers/char/sonypi.h	Sun Jun 29 18:27:44 2003
+++ edited/drivers/char/sonypi.h	Tue Aug 26 11:52:33 2003
@@ -56,12 +56,14 @@
 #define SONYPI_BASE			0x50
 #define SONYPI_G10A			(SONYPI_BASE+0x14)
 #define SONYPI_TYPE1_REGION_SIZE	0x08
+#define SONYPI_TYPE1_EVTYPE_OFFSET	0x04
 
 /* type2 series specifics */
 #define SONYPI_SIRQ			0x9b
 #define SONYPI_SLOB			0x9c
 #define SONYPI_SHIB			0x9d
 #define SONYPI_TYPE2_REGION_SIZE	0x20
+#define SONYPI_TYPE2_EVTYPE_OFFSET	0x12
 
 /* battery / brightness addresses */
 #define SONYPI_BAT_FLAGS	0x81
@@ -167,6 +169,7 @@
 #define SONYPI_THUMBPHRASE_MASK			0x00000200
 #define SONYPI_MEYE_MASK			0x00000400
 #define SONYPI_MEMORYSTICK_MASK			0x00000800
+#define SONYPI_BATTERY_MASK			0x00001000
 
 struct sonypi_event {
 	u8	data;
@@ -293,6 +296,13 @@
 	{ 0, 0 }
 };
 
+/* The set of possible battery events */
+static struct sonypi_event sonypi_batteryev[] = {
+	{ 0x20, SONYPI_EVENT_BATTERY_INSERT },
+	{ 0x30, SONYPI_EVENT_BATTERY_REMOVE },
+	{ 0, 0 }
+};
+
 struct sonypi_eventtypes {
 	int			model;
 	u8			data;
@@ -307,19 +317,22 @@
 	{ SONYPI_DEVICE_MODEL_TYPE1, 0x20, SONYPI_FNKEY_MASK, sonypi_fnkeyev },
 	{ SONYPI_DEVICE_MODEL_TYPE1, 0x30, SONYPI_BLUETOOTH_MASK, sonypi_blueev },
 	{ SONYPI_DEVICE_MODEL_TYPE1, 0x40, SONYPI_PKEY_MASK, sonypi_pkeyev },
+	{ SONYPI_DEVICE_MODEL_TYPE1, 0x30, SONYPI_MEMORYSTICK_MASK, sonypi_memorystickev },
+	{ SONYPI_DEVICE_MODEL_TYPE1, 0x40, SONYPI_BATTERY_MASK, sonypi_batteryev },
 
 	{ SONYPI_DEVICE_MODEL_TYPE2, 0, 0xffffffff, sonypi_releaseev },
 	{ SONYPI_DEVICE_MODEL_TYPE2, 0x38, SONYPI_LID_MASK, sonypi_lidev },
-	{ SONYPI_DEVICE_MODEL_TYPE2, 0x08, SONYPI_JOGGER_MASK, sonypi_joggerev },
+	{ SONYPI_DEVICE_MODEL_TYPE2, 0x11, SONYPI_JOGGER_MASK, sonypi_joggerev },
 	{ SONYPI_DEVICE_MODEL_TYPE2, 0x08, SONYPI_CAPTURE_MASK, sonypi_captureev },
-	{ SONYPI_DEVICE_MODEL_TYPE2, 0x08, SONYPI_FNKEY_MASK, sonypi_fnkeyev },
-	{ SONYPI_DEVICE_MODEL_TYPE2, 0x08, SONYPI_BLUETOOTH_MASK, sonypi_blueev },
+	{ SONYPI_DEVICE_MODEL_TYPE2, 0x21, SONYPI_FNKEY_MASK, sonypi_fnkeyev },
+	{ SONYPI_DEVICE_MODEL_TYPE2, 0x31, SONYPI_BLUETOOTH_MASK, sonypi_blueev },
 	{ SONYPI_DEVICE_MODEL_TYPE2, 0x08, SONYPI_PKEY_MASK, sonypi_pkeyev },
-	{ SONYPI_DEVICE_MODEL_TYPE2, 0x08, SONYPI_BACK_MASK, sonypi_backev },
+	{ SONYPI_DEVICE_MODEL_TYPE2, 0x11, SONYPI_BACK_MASK, sonypi_backev },
 	{ SONYPI_DEVICE_MODEL_TYPE2, 0x08, SONYPI_HELP_MASK, sonypi_helpev },
 	{ SONYPI_DEVICE_MODEL_TYPE2, 0x08, SONYPI_ZOOM_MASK, sonypi_zoomev },
 	{ SONYPI_DEVICE_MODEL_TYPE2, 0x08, SONYPI_THUMBPHRASE_MASK, sonypi_thumbphraseev },
-	{ SONYPI_DEVICE_MODEL_TYPE2, 0x08, SONYPI_MEMORYSTICK_MASK, sonypi_memorystickev },
+	{ SONYPI_DEVICE_MODEL_TYPE2, 0x31, SONYPI_MEMORYSTICK_MASK, sonypi_memorystickev },
+	{ SONYPI_DEVICE_MODEL_TYPE2, 0x41, SONYPI_BATTERY_MASK, sonypi_batteryev },
 
 	{ 0, 0, 0, 0 }
 };
@@ -354,6 +367,7 @@
 	u16 ioport1;
 	u16 ioport2;
 	u16 region_size;
+	u16 evtype_offset;
 	int camera_power;
 	int bluetooth_power;
 	struct semaphore lock;
@@ -380,30 +394,17 @@
 }
 
 #ifdef CONFIG_ACPI
-#include <linux/acpi.h>
-#if (ACPI_CA_VERSION > 0x20021121)
-#ifdef CONFIG_ACPI_EC
-#define SONYPI_USE_ACPI
-#endif
-#endif
-#endif /* CONFIG_ACPI */
-
-#ifdef CONFIG_ACPI
-#ifdef SONYPI_USE_ACPI
 extern int acpi_disabled;
 #define SONYPI_ACPI_ACTIVE (!acpi_disabled)
 #else
-#define SONYPI_ACPI_ACTIVE 1
-#endif
-#else /* CONFIG_ACPI */
 #define SONYPI_ACPI_ACTIVE 0
 #endif /* CONFIG_ACPI */
 
 extern int verbose;
 
 static inline int sonypi_ec_write(u8 addr, u8 value) {
-#ifdef SONYPI_USE_ACPI
-	if (!acpi_disabled)
+#ifdef CONFIG_ACPI_EC
+	if (SONYPI_ACPI_ACTIVE)
 		return ec_write(addr, value);
 #endif
 	wait_on_command(1, inb_p(SONYPI_CST_IOPORT) & 3, ITERATIONS_LONG);
@@ -417,8 +418,8 @@
 }
 
 static inline int sonypi_ec_read(u8 addr, u8 *value) {
-#ifdef SONYPI_USE_ACPI
-	if (!acpi_disabled)
+#ifdef CONFIG_ACPI_EC
+	if (SONYPI_ACPI_ACTIVE)
 		return ec_read(addr, value);
 #endif
 	wait_on_command(1, inb_p(SONYPI_CST_IOPORT) & 3, ITERATIONS_LONG);
===== drivers/char/sonypi.c 1.16 vs edited =====
--- 1.16/drivers/char/sonypi.c	Sun Jun 29 17:10:02 2003
+++ edited/drivers/char/sonypi.c	Fri Aug  1 12:35:17 2003
@@ -308,7 +308,7 @@
 	int i, j;
 
 	v1 = inb_p(sonypi_device.ioport1);
-	v2 = inb_p(sonypi_device.ioport2);
+	v2 = inb_p(sonypi_device.ioport1 + sonypi_device.evtype_offset);
 
 	for (i = 0; sonypi_eventtypes[i].model; i++) {
 		if (sonypi_device.model != sonypi_eventtypes[i].model)
@@ -665,11 +665,13 @@
 	if (sonypi_device.model == SONYPI_DEVICE_MODEL_TYPE2) {
 		ioport_list = sonypi_type2_ioport_list;
 		sonypi_device.region_size = SONYPI_TYPE2_REGION_SIZE;
+		sonypi_device.evtype_offset = SONYPI_TYPE2_EVTYPE_OFFSET;
 		irq_list = sonypi_type2_irq_list;
 	}
 	else {
 		ioport_list = sonypi_type1_ioport_list;
 		sonypi_device.region_size = SONYPI_TYPE1_REGION_SIZE;
+		sonypi_device.evtype_offset = SONYPI_TYPE1_EVTYPE_OFFSET;
 		irq_list = sonypi_type1_irq_list;
 	}
 
-- 
Stelian Pop <stelian@popies.net>
