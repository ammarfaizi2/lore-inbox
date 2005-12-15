Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965207AbVLONX6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965207AbVLONX6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 08:23:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965208AbVLONX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 08:23:58 -0500
Received: from ns1.suse.de ([195.135.220.2]:6308 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965207AbVLONX6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 08:23:58 -0500
Message-ID: <43A16E64.3060601@suse.de>
Date: Thu, 15 Dec 2005 14:23:48 +0100
From: Gerd Knorr <kraxel@suse.de>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Gerd Knorr <kraxel@suse.de>
Cc: Jeff Dike <jdike@addtoit.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2/2] uml: Framebuffer driver for UML
References: <439EE38C.6020602@suse.de> <439EE5B0.2030709@suse.de> <20051213221548.GB9769@ccure.user-mode-linux.org> <43A13206.3080704@suse.de> <43A1500E.1080606@suse.de>
In-Reply-To: <43A1500E.1080606@suse.de>
Content-Type: multipart/mixed;
 boundary="------------020701050409030302010201"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020701050409030302010201
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

>> Should be trivially fixable with some Kconfig tweaks, I'll have a look.
> 
> Here we go, this patch disables vga console and the mouse/kbd hardware 
> drivers on UML.  Running a "allmodconfig" testbuild right now, but I 
> hope that everything else is catched by PCI + ISA dependencies ...

Unfortunaly not, there are a few more places which need fixing, updated 
patch attached, with that one applied on top of the uml framebuffer 
patch "ARCH=um allmodconfig" works again ...

cheers,

   Gerd

--------------020701050409030302010201
Content-Type: text/plain;
 name="uml-kconfig"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="uml-kconfig"

Index: linux-2.6.14/drivers/input/keyboard/Kconfig
===================================================================
--- linux-2.6.14.orig/drivers/input/keyboard/Kconfig	2005-12-12 18:24:51.000000000 +0100
+++ linux-2.6.14/drivers/input/keyboard/Kconfig	2005-12-15 12:07:26.000000000 +0100
@@ -10,7 +10,7 @@ menuconfig INPUT_KEYBOARD
 
 	  If unsure, say Y.
 
-if INPUT_KEYBOARD
+if INPUT_KEYBOARD && !UML
 
 config KEYBOARD_ATKBD
 	tristate "AT keyboard" if !X86_PC
Index: linux-2.6.14/drivers/input/mouse/Kconfig
===================================================================
--- linux-2.6.14.orig/drivers/input/mouse/Kconfig	2005-12-12 18:24:51.000000000 +0100
+++ linux-2.6.14/drivers/input/mouse/Kconfig	2005-12-15 12:06:59.000000000 +0100
@@ -10,7 +10,7 @@ menuconfig INPUT_MOUSE
 
 	  If unsure, say Y.
 
-if INPUT_MOUSE
+if INPUT_MOUSE && !UML
 
 config MOUSE_PS2
 	tristate "PS/2 mouse"
Index: linux-2.6.14/drivers/input/serio/Kconfig
===================================================================
--- linux-2.6.14.orig/drivers/input/serio/Kconfig	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.14/drivers/input/serio/Kconfig	2005-12-15 12:06:11.000000000 +0100
@@ -21,7 +21,7 @@ if SERIO
 config SERIO_I8042
 	tristate "i8042 PC Keyboard controller" if EMBEDDED || !X86
 	default y
-	depends on !PARISC && (!ARM || ARCH_SHARK || FOOTBRIDGE_HOST) && !M68K
+	depends on !PARISC && (!ARM || ARCH_SHARK || FOOTBRIDGE_HOST) && !M68K && !UML
 	---help---
 	  i8042 is the chip over which the standard AT keyboard and PS/2
 	  mouse are connected to the computer. If you use these devices,
Index: linux-2.6.14/drivers/video/console/Kconfig
===================================================================
--- linux-2.6.14.orig/drivers/video/console/Kconfig	2005-12-12 18:25:03.000000000 +0100
+++ linux-2.6.14/drivers/video/console/Kconfig	2005-12-15 12:01:31.000000000 +0100
@@ -6,7 +6,7 @@ menu "Console display driver support"
 
 config VGA_CONSOLE
 	bool "VGA text console" if EMBEDDED || !X86
-	depends on !ARCH_ACORN && !ARCH_EBSA110 && !4xx && !8xx && !SPARC32 && !SPARC64 && !M68K && !PARISC && !ARCH_VERSATILE
+	depends on !ARCH_ACORN && !ARCH_EBSA110 && !4xx && !8xx && !SPARC32 && !SPARC64 && !M68K && !PARISC && !ARCH_VERSATILE && !UML
 	default y
 	help
 	  Saying Y here will allow you to use Linux in text mode through a
Index: linux-2.6.14/drivers/char/Kconfig
===================================================================
--- linux-2.6.14.orig/drivers/char/Kconfig	2005-12-12 18:25:17.000000000 +0100
+++ linux-2.6.14/drivers/char/Kconfig	2005-12-15 12:52:55.000000000 +0100
@@ -64,6 +64,7 @@ config HW_CONSOLE
 
 config SERIAL_NONSTANDARD
 	bool "Non-standard serial port support"
+	depends on !UML
 	---help---
 	  Say Y here if you have any non-standard serial boards -- boards
 	  which aren't supported using the standard "dumb" serial driver.
@@ -687,7 +688,7 @@ config NVRAM
 
 config RTC
 	tristate "Enhanced Real Time Clock Support"
-	depends on !PPC32 && !PARISC && !IA64 && !M68K
+	depends on !PPC32 && !PARISC && !IA64 && !M68K && !UML
 	---help---
 	  If you say Y here and create a character special file /dev/rtc with
 	  major number 10 and minor number 135 using mknod ("man mknod"), you
@@ -735,7 +736,7 @@ config SGI_IP27_RTC
 
 config GEN_RTC
 	tristate "Generic /dev/rtc emulation"
-	depends on RTC!=y && !IA64 && !ARM && !M32R && !SPARC32 && !SPARC64
+	depends on RTC!=y && !IA64 && !ARM && !M32R && !SPARC32 && !SPARC64 && !UML
 	---help---
 	  If you say Y here and create a character special file /dev/rtc with
 	  major number 10 and minor number 135 using mknod ("man mknod"), you
@@ -792,6 +793,7 @@ config COBALT_LCD
 
 config DTLK
 	tristate "Double Talk PC internal speech card support"
+	depends on ISA
 	help
 	  This driver is for the DoubleTalk PC, a speech synthesizer
 	  manufactured by RC Systems (<http://www.rcsys.com/>).  It is also
Index: linux-2.6.14/drivers/char/ipmi/Kconfig
===================================================================
--- linux-2.6.14.orig/drivers/char/ipmi/Kconfig	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.14/drivers/char/ipmi/Kconfig	2005-12-15 12:54:05.000000000 +0100
@@ -5,6 +5,7 @@
 menu "IPMI"
 config IPMI_HANDLER
        tristate 'IPMI top-level message handler'
+       depends on !UML
        help
          This enables the central IPMI message handler, required for IPMI
 	 to work.
Index: linux-2.6.14/drivers/char/tpm/Kconfig
===================================================================
--- linux-2.6.14.orig/drivers/char/tpm/Kconfig	2005-12-12 18:24:50.000000000 +0100
+++ linux-2.6.14/drivers/char/tpm/Kconfig	2005-12-15 12:54:46.000000000 +0100
@@ -6,7 +6,7 @@ menu "TPM devices"
 
 config TCG_TPM
 	tristate "TPM Hardware Support"
-	depends on EXPERIMENTAL
+	depends on EXPERIMENTAL && !UML
 	---help---
 	  If you have a TPM security chip in your system, which
 	  implements the Trusted Computing Group's specification,
Index: linux-2.6.14/drivers/input/touchscreen/Kconfig
===================================================================
--- linux-2.6.14.orig/drivers/input/touchscreen/Kconfig	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.14/drivers/input/touchscreen/Kconfig	2005-12-15 13:21:13.000000000 +0100
@@ -9,7 +9,7 @@ menuconfig INPUT_TOUCHSCREEN
 
 	  If unsure, say Y.
 
-if INPUT_TOUCHSCREEN
+if INPUT_TOUCHSCREEN && !UML
 
 config TOUCHSCREEN_BITSY
 	tristate "Compaq iPAQ H3600 (Bitsy) touchscreen"
Index: linux-2.6.14/drivers/serial/Kconfig
===================================================================
--- linux-2.6.14.orig/drivers/serial/Kconfig	2005-12-15 11:59:47.000000000 +0100
+++ linux-2.6.14/drivers/serial/Kconfig	2005-12-15 14:03:09.000000000 +0100
@@ -11,6 +11,7 @@ menu "Serial drivers"
 config SERIAL_8250
 	tristate "8250/16550 and compatible serial support"
 	depends on (BROKEN || !(SPARC64 || SPARC32))
+	depends on !UML
 	select SERIAL_CORE
 	---help---
 	  This selects whether you want to include the driver for the standard
Index: linux-2.6.14/drivers/video/Kconfig
===================================================================
--- linux-2.6.14.orig/drivers/video/Kconfig	2005-12-12 18:25:16.000000000 +0100
+++ linux-2.6.14/drivers/video/Kconfig	2005-12-15 14:06:13.000000000 +0100
@@ -602,7 +602,7 @@ config FB_EPSON1355
 
 config FB_S1D13XXX
 	tristate "Epson S1D13XXX framebuffer support"
-	depends on FB
+	depends on FB && !UML
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT

--------------020701050409030302010201--
