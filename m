Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273255AbRIYTmc>; Tue, 25 Sep 2001 15:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273302AbRIYTmV>; Tue, 25 Sep 2001 15:42:21 -0400
Received: from [194.213.32.137] ([194.213.32.137]:4356 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S273143AbRIYTkf>;
	Tue, 25 Sep 2001 15:40:35 -0400
Message-ID: <20010924172910.A178@bug.ucw.cz>
Date: Mon, 24 Sep 2001 17:29:10 +0200
From: Pavel Machek <pavel@suse.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
        ACPI mailing list <acpi@phobos.fachschaften.tu-muenchen.de>
Subject: Workaround for ACPI sleep problems
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Some machines have bad problems with acpi... Toshiba will kill
interrupts and mvp3 gives totally incorrect table, meaning that sleeps
just will not work.

I figured part of table, but I *know* there's working S1 somewhere out
there, so if someone has the correct value to use, please let me
know. [If you replace number near /* HERE */ with correct value in
0-15 range, you'll get working S1. It's only 15 tries ;-).]

This fixes acpi on toshiba, and provides at least working poweroff on
MVP3.
								Pavel

--- clean/include/asm-i386/system.h	Sun Sep 23 23:07:00 2001
+++ linux/include/asm-i386/system.h	Mon Sep 24 16:39:54 2001
@@ -340,4 +340,8 @@
 void disable_hlt(void);
 void enable_hlt(void);
 
+extern unsigned long dmi_broken;
+#define BROKEN_ACPI_Sx		0x0001
+#define BROKEN_INIT_AFTER_S1	0x0002
+
 #endif
--- clean/arch/i386/kernel/dmi_scan.c	Sun Sep 23 23:04:49 2001
+++ linux/arch/i386/kernel/dmi_scan.c	Mon Sep 24 17:01:00 2001
@@ -10,6 +10,8 @@
 #include <linux/keyboard.h>
 #include <asm/keyboard.h>
 
+unsigned long dmi_broken;
+
 struct dmi_header
 {
 	u8	type;
@@ -365,6 +367,38 @@
 }
 
 /*
+ * ASUS K7V-RM has broken ACPI table defining sleep modes
+ */
+
+static __init int broken_acpi_Sx(struct dmi_blacklist *d)
+{
+	printk(KERN_WARNING "Detected ASUS mainboard with broken ACPI sleep table\n");
+	dmi_broken |= BROKEN_ACPI_Sx;
+	return 0;
+}
+
+/*
+ * Toshiba keyboard likes to repeat keys when they are not repeated.
+ */
+
+static __init int broken_toshiba_keyboard(struct dmi_blacklist *d)
+{
+	printk(KERN_WARNING "Toshiba with broken keyboard detected. If your keyboard sometimes generates 3 keypresses instead of one, contact pavel@ucw.cz\n");
+	return 0;
+}
+
+/*
+ * Toshiba fails to preserve interrupts over S1
+ */
+
+static __init int init_ints_after_s1(struct dmi_blacklist *d)
+{
+	printk(KERN_WARNING "Toshiba with broken S1 detected.\n");
+	dmi_broken |= BROKEN_INIT_AFTER_S1;
+	return 0;
+}
+
+/*
  * Some Bioses enable the PS/2 mouse (touchpad) at resume, even if it
  * was disabled before the suspend. Linux gets terribly confused by that.
  */
@@ -543,7 +577,19 @@
 			MATCH(DMI_PRODUCT_NAME, "Dell PowerEdge 8450"),
 			NO_MATCH, NO_MATCH, NO_MATCH
 			} },
-
+	{ broken_acpi_Sx, "ASUS K7V-RM", {		/* Bad ACPI Sx table */
+			MATCH(DMI_BIOS_VERSION,"ASUS K7V-RM ACPI BIOS Revision 1003A"),
+			MATCH(DMI_BOARD_NAME, "<K7V-RM>"),
+			NO_MATCH, NO_MATCH
+			} },
+	{ broken_toshiba_keyboard, "Toshiba Satellite 4030cdt", { /* Keyboard generates spurious repeats */
+			MATCH(DMI_PRODUCT_NAME, "S4030CDT/4.3"),
+			NO_MATCH, NO_MATCH, NO_MATCH
+			} },
+	{ init_ints_after_s1, "Toshiba Satellite 4030cdt", { /* Reinitialization of 8259 is needed after S1 resume */
+			MATCH(DMI_PRODUCT_NAME, "S4030CDT/4.3"),
+			NO_MATCH, NO_MATCH, NO_MATCH
+			} },
 	{ NULL, }
 };
 	
--- clean/drivers/acpi/hardware/hwregs.c	Sun Sep 23 23:05:16 2001
+++ linux/drivers/acpi/hardware/hwregs.c	Mon Sep 24 17:15:58 2001
@@ -29,6 +29,7 @@
 #include "acpi.h"
 #include "achware.h"
 #include "acnamesp.h"
+#include <asm/system.h>
 
 #define _COMPONENT          ACPI_HARDWARE
 	 MODULE_NAME         ("hwregs")
@@ -162,6 +163,22 @@
 	if ((sleep_state > ACPI_S_STATES_MAX) ||
 		!slp_typ_a || !slp_typ_b) {
 		return_ACPI_STATUS (AE_BAD_PARAMETER);
+	}
+
+	if (dmi_broken & BROKEN_ACPI_Sx) {
+		printk("Attempted to enter %d\n", sleep_state);
+		switch (sleep_state) {
+			/* 0,3,4,6,7,11 is nop */
+			/* 5 is nop, too? No. 5 is some valid state, just not S1 nor S3 (strange). */
+			/* 13 is lockup when used in S1 or S3 context */
+			/* 14 is "keep monitor on and than all goes off when power is pressed in S1 context */
+		case 1:	*slp_typ_a = *slp_typ_b =12 /* HERE */; return_ACPI_STATUS (status);
+		case 3:	*slp_typ_a = *slp_typ_b =14; return_ACPI_STATUS (status);
+		case 4:	*slp_typ_a = *slp_typ_b = 1; return_ACPI_STATUS (status);	/* Seems ok, but it times somehow long to wakeup. Is it possible this is S3? */
+		case 5:	*slp_typ_a = *slp_typ_b =10; return_ACPI_STATUS (status);	/* Seems ok */
+		default: return_ACPI_STATUS (AE_BAD_PARAMETER)
+		}
+		
 	}
 
 	/*
--- clean/drivers/acpi/ospm/system/sm_osl.c	Sun Sep 23 23:05:21 2001
+++ linux/drivers/acpi/ospm/system/sm_osl.c	Mon Sep 24 16:41:14 2001
@@ -719,6 +780,11 @@
 	/* TODO: resume devices and restore their state */
 
 	enable();
+
+	if (dmi_broken & BROKEN_INIT_AFTER_S1) {
+		printk("Broken toshiba laptop -> kicking interrupts\n");
+		init_8259A(0);
+	}
 	return status;
 }
 
  
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
