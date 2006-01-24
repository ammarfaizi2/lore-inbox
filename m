Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964994AbWAXQAU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964994AbWAXQAU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 11:00:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964995AbWAXQAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 11:00:20 -0500
Received: from mail.suse.de ([195.135.220.2]:64489 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964994AbWAXQAT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 11:00:19 -0500
Message-ID: <43D64F05.90302@suse.de>
Date: Tue, 24 Jan 2006 17:00:05 +0100
From: Gerd Hoffmann <kraxel@suse.de>
User-Agent: Thunderbird 1.5 (X11/20060111)
MIME-Version: 1.0
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Jeff Dike <jdike@addtoit.com>
Subject: [patch 1/2] uml: enable drivers (input, fb, vt)
Content-Type: multipart/mixed;
 boundary="------------030005080404090607050600"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030005080404090607050600
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

  Hi,

This patch enables a number of drivers for the uml build, in preparation
for the uml framebuffer driver patch coming next ;)

Changes:

  * Include drivers/{input,char,video} in the uml kernel configuration,
    thus enabling the vt subsystem, input subsystem and the framebuffer
    console.
  * Add the console_use_vt variable to make the vt subsystem
    runtime-switchable.  That is needed because uml has it's own,
    special "uml console" driver for major #5, which can only be
    used if the vt subsystem doesn't grab #5.  The plan is to enable
    the vt subsystem only if we are going to use it for the framebuffer
    console, so the current behaviour remains unchanged if the
    framebuffer is not used.
  * A bunch of Kconfig tweaks to make the allmodconfig build fine by
    disabling drivers which either don't make sense or don't even build
    on uml.  Fortunaly CONFIG_PCI & friends catched most of them
    already ;)

pleae apply,

  Gerd

-- 
Gerd 'just married' Hoffmann <kraxel@suse.de>
I'm the hacker formerly known as Gerd Knorr.
http://www.suse.de/~kraxel/just-married.jpeg

--------------030005080404090607050600
Content-Type: text/plain;
 name="uml-kconfig"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="uml-kconfig"

Index: linux-2.6.16-pre/drivers/input/keyboard/Kconfig
===================================================================
--- linux-2.6.16-pre.orig/drivers/input/keyboard/Kconfig	2006-01-23 12:43:55.000000000 +0100
+++ linux-2.6.16-pre/drivers/input/keyboard/Kconfig	2006-01-23 12:44:58.000000000 +0100
@@ -10,7 +10,7 @@ menuconfig INPUT_KEYBOARD
 
 	  If unsure, say Y.
 
-if INPUT_KEYBOARD
+if INPUT_KEYBOARD && !UML
 
 config KEYBOARD_ATKBD
 	tristate "AT keyboard" if !X86_PC
Index: linux-2.6.16-pre/drivers/input/mouse/Kconfig
===================================================================
--- linux-2.6.16-pre.orig/drivers/input/mouse/Kconfig	2006-01-23 12:43:55.000000000 +0100
+++ linux-2.6.16-pre/drivers/input/mouse/Kconfig	2006-01-23 12:44:58.000000000 +0100
@@ -10,7 +10,7 @@ menuconfig INPUT_MOUSE
 
 	  If unsure, say Y.
 
-if INPUT_MOUSE
+if INPUT_MOUSE && !UML
 
 config MOUSE_PS2
 	tristate "PS/2 mouse"
Index: linux-2.6.16-pre/drivers/input/serio/Kconfig
===================================================================
--- linux-2.6.16-pre.orig/drivers/input/serio/Kconfig	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.16-pre/drivers/input/serio/Kconfig	2006-01-23 12:44:58.000000000 +0100
@@ -21,7 +21,7 @@ if SERIO
 config SERIO_I8042
 	tristate "i8042 PC Keyboard controller" if EMBEDDED || !X86
 	default y
-	depends on !PARISC && (!ARM || ARCH_SHARK || FOOTBRIDGE_HOST) && !M68K
+	depends on !PARISC && (!ARM || ARCH_SHARK || FOOTBRIDGE_HOST) && !M68K && !UML
 	---help---
 	  i8042 is the chip over which the standard AT keyboard and PS/2
 	  mouse are connected to the computer. If you use these devices,
Index: linux-2.6.16-pre/drivers/char/Kconfig
===================================================================
--- linux-2.6.16-pre.orig/drivers/char/Kconfig	2006-01-23 12:43:54.000000000 +0100
+++ linux-2.6.16-pre/drivers/char/Kconfig	2006-01-23 12:44:58.000000000 +0100
@@ -59,11 +59,12 @@ config VT_CONSOLE
 
 config HW_CONSOLE
 	bool
-	depends on VT && !S390 && !UML
+	depends on VT && !S390
 	default y
 
 config SERIAL_NONSTANDARD
 	bool "Non-standard serial port support"
+	depends on !UML
 	---help---
 	  Say Y here if you have any non-standard serial boards -- boards
 	  which aren't supported using the standard "dumb" serial driver.
@@ -695,7 +696,7 @@ config NVRAM
 
 config RTC
 	tristate "Enhanced Real Time Clock Support"
-	depends on !PPC32 && !PARISC && !IA64 && !M68K && (!SPARC || PCI) && !FRV
+	depends on !PPC32 && !PARISC && !IA64 && !M68K && (!SPARC || PCI) && !FRV && !UML
 	---help---
 	  If you say Y here and create a character special file /dev/rtc with
 	  major number 10 and minor number 135 using mknod ("man mknod"), you
@@ -743,7 +744,7 @@ config SGI_IP27_RTC
 
 config GEN_RTC
 	tristate "Generic /dev/rtc emulation"
-	depends on RTC!=y && !IA64 && !ARM && !M32R && !SPARC && !FRV
+	depends on RTC!=y && !IA64 && !ARM && !M32R && !SPARC && !FRV && !UML
 	---help---
 	  If you say Y here and create a character special file /dev/rtc with
 	  major number 10 and minor number 135 using mknod ("man mknod"), you
@@ -800,6 +801,7 @@ config COBALT_LCD
 
 config DTLK
 	tristate "Double Talk PC internal speech card support"
+	depends on ISA
 	help
 	  This driver is for the DoubleTalk PC, a speech synthesizer
 	  manufactured by RC Systems (<http://www.rcsys.com/>).  It is also
Index: linux-2.6.16-pre/drivers/char/ipmi/Kconfig
===================================================================
--- linux-2.6.16-pre.orig/drivers/char/ipmi/Kconfig	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.16-pre/drivers/char/ipmi/Kconfig	2006-01-23 12:44:59.000000000 +0100
@@ -5,6 +5,7 @@
 menu "IPMI"
 config IPMI_HANDLER
        tristate 'IPMI top-level message handler'
+       depends on !UML
        help
          This enables the central IPMI message handler, required for IPMI
 	 to work.
Index: linux-2.6.16-pre/drivers/char/tpm/Kconfig
===================================================================
--- linux-2.6.16-pre.orig/drivers/char/tpm/Kconfig	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.16-pre/drivers/char/tpm/Kconfig	2006-01-23 12:44:59.000000000 +0100
@@ -6,7 +6,7 @@ menu "TPM devices"
 
 config TCG_TPM
 	tristate "TPM Hardware Support"
-	depends on EXPERIMENTAL
+	depends on EXPERIMENTAL && !UML
 	---help---
 	  If you have a TPM security chip in your system, which
 	  implements the Trusted Computing Group's specification,
Index: linux-2.6.16-pre/drivers/input/touchscreen/Kconfig
===================================================================
--- linux-2.6.16-pre.orig/drivers/input/touchscreen/Kconfig	2006-01-23 12:43:55.000000000 +0100
+++ linux-2.6.16-pre/drivers/input/touchscreen/Kconfig	2006-01-23 12:44:59.000000000 +0100
@@ -9,7 +9,7 @@ menuconfig INPUT_TOUCHSCREEN
 
 	  If unsure, say Y.
 
-if INPUT_TOUCHSCREEN
+if INPUT_TOUCHSCREEN && !UML
 
 config TOUCHSCREEN_ADS7846
 	tristate "ADS 7846 based touchscreens"
Index: linux-2.6.16-pre/drivers/serial/Kconfig
===================================================================
--- linux-2.6.16-pre.orig/drivers/serial/Kconfig	2006-01-23 12:44:53.000000000 +0100
+++ linux-2.6.16-pre/drivers/serial/Kconfig	2006-01-23 12:44:59.000000000 +0100
@@ -11,6 +11,7 @@ menu "Serial drivers"
 config SERIAL_8250
 	tristate "8250/16550 and compatible serial support"
 	depends on (BROKEN || !SPARC)
+	depends on !UML
 	select SERIAL_CORE
 	---help---
 	  This selects whether you want to include the driver for the standard
Index: linux-2.6.16-pre/drivers/video/Kconfig
===================================================================
--- linux-2.6.16-pre.orig/drivers/video/Kconfig	2006-01-23 12:44:06.000000000 +0100
+++ linux-2.6.16-pre/drivers/video/Kconfig	2006-01-23 12:44:59.000000000 +0100
@@ -602,7 +602,7 @@ config FB_EPSON1355
 
 config FB_S1D13XXX
 	tristate "Epson S1D13XXX framebuffer support"
-	depends on FB
+	depends on FB && !UML
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
Index: linux-2.6.16-pre/arch/um/Kconfig
===================================================================
--- linux-2.6.16-pre.orig/arch/um/Kconfig	2006-01-23 12:44:52.000000000 +0100
+++ linux-2.6.16-pre/arch/um/Kconfig	2006-01-23 12:44:59.000000000 +0100
@@ -288,6 +288,12 @@ source "drivers/net/Kconfig"
 
 source "drivers/connector/Kconfig"
 
+source "drivers/input/Kconfig"
+
+source "drivers/char/Kconfig"
+
+source "drivers/video/Kconfig"
+
 source "fs/Kconfig"
 
 source "security/Kconfig"
Index: linux-2.6.16-pre/arch/um/kernel/um_arch.c
===================================================================
--- linux-2.6.16-pre.orig/arch/um/kernel/um_arch.c	2006-01-23 12:43:53.000000000 +0100
+++ linux-2.6.16-pre/arch/um/kernel/um_arch.c	2006-01-23 12:44:59.000000000 +0100
@@ -18,6 +18,7 @@
 #include "linux/seq_file.h"
 #include "linux/delay.h"
 #include "linux/module.h"
+#include "linux/console.h"
 #include "asm/page.h"
 #include "asm/pgtable.h"
 #include "asm/ptrace.h"
@@ -464,6 +465,9 @@ void __init setup_arch(char **cmdline_p)
         strlcpy(saved_command_line, command_line, COMMAND_LINE_SIZE);
  	*cmdline_p = command_line;
 	setup_hostinfo();
+#if defined(CONFIG_DUMMY_CONSOLE)
+	console_use_vt = 0;
+#endif
 }
 
 void __init check_bugs(void)
Index: linux-2.6.16-pre/drivers/char/tty_io.c
===================================================================
--- linux-2.6.16-pre.orig/drivers/char/tty_io.c	2006-01-23 12:43:55.000000000 +0100
+++ linux-2.6.16-pre/drivers/char/tty_io.c	2006-01-23 12:44:59.000000000 +0100
@@ -132,6 +132,8 @@ LIST_HEAD(tty_drivers);			/* linked list
    vt.c for deeply disgusting hack reasons */
 DECLARE_MUTEX(tty_sem);
 
+int console_use_vt = 1;
+
 #ifdef CONFIG_UNIX98_PTYS
 extern struct tty_driver *ptm_driver;	/* Unix98 pty masters; for /dev/ptmx */
 extern int pty_limit;		/* Config limit on Unix98 ptys */
@@ -2033,7 +2035,7 @@ retry_open:
 		goto got_driver;
 	}
 #ifdef CONFIG_VT
-	if (device == MKDEV(TTY_MAJOR,0)) {
+	if (console_use_vt && device == MKDEV(TTY_MAJOR,0)) {
 		extern struct tty_driver *console_driver;
 		driver = console_driver;
 		index = fg_console;
@@ -3201,6 +3203,8 @@ static int __init tty_init(void)
 #endif
 
 #ifdef CONFIG_VT
+	if (!console_use_vt)
+		goto out_vt;
 	cdev_init(&vc0_cdev, &console_fops);
 	if (cdev_add(&vc0_cdev, MKDEV(TTY_MAJOR, 0), 1) ||
 	    register_chrdev_region(MKDEV(TTY_MAJOR, 0), 1, "/dev/vc/0") < 0)
@@ -3209,6 +3213,7 @@ static int __init tty_init(void)
 	class_device_create(tty_class, NULL, MKDEV(TTY_MAJOR, 0), NULL, "tty0");
 
 	vty_init();
+ out_vt:
 #endif
 	return 0;
 }
Index: linux-2.6.16-pre/include/linux/console.h
===================================================================
--- linux-2.6.16-pre.orig/include/linux/console.h	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.16-pre/include/linux/console.h	2006-01-23 12:44:59.000000000 +0100
@@ -62,6 +62,7 @@ extern const struct consw dummy_con;	/* 
 extern const struct consw vga_con;	/* VGA text console */
 extern const struct consw newport_con;	/* SGI Newport console  */
 extern const struct consw prom_con;	/* SPARC PROM console */
+extern int console_use_vt;
 
 int take_over_console(const struct consw *sw, int first, int last, int deflt);
 void give_up_console(const struct consw *sw);
Index: linux-2.6.16-pre/drivers/video/console/Kconfig
===================================================================
--- linux-2.6.16-pre.orig/drivers/video/console/Kconfig	2006-01-23 12:44:06.000000000 +0100
+++ linux-2.6.16-pre/drivers/video/console/Kconfig	2006-01-23 12:44:59.000000000 +0100
@@ -6,7 +6,7 @@ menu "Console display driver support"
 
 config VGA_CONSOLE
 	bool "VGA text console" if EMBEDDED || !X86
-	depends on !ARCH_ACORN && !ARCH_EBSA110 && !4xx && !8xx && !SPARC && !M68K && !PARISC && !FRV && !ARCH_VERSATILE
+	depends on !ARCH_ACORN && !ARCH_EBSA110 && !4xx && !8xx && !SPARC && !M68K && !PARISC && !FRV && !ARCH_VERSATILE && !UML
 	default y
 	help
 	  Saying Y here will allow you to use Linux in text mode through a

--------------030005080404090607050600--
