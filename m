Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261820AbTFGGVK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 02:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261936AbTFGGVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 02:21:10 -0400
Received: from zero.aec.at ([193.170.194.10]:49673 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S261820AbTFGGVF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 02:21:05 -0400
Date: Sat, 7 Jun 2003 08:34:24 +0200
From: Andi Kleen <ak@muc.de>
To: linux-kernel@vger.kernel.org
Cc: akpm@digeo.com, vojtech@suse.cz
Subject: [PATCH] Making keyboard/mouse drivers dependent on CONFIG_EMBEDDED
Message-ID: <20030607063424.GA12616@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I finally got sick of seeing bug reports from people who did not enable
CONFIG_VT or forgot to enable the obscure options for the keyboard
driver. This is especially a big problem for people who do make oldconfig
with a 2.4 configuration, but seems to happen in general often.
I also included the PS/2 mouse driver. It is small enough and a useful
fallback on any PC.

This patch wraps all this for i386/amd64 in CONFIG_EMBEDDED. If 
CONFIG_EMBEDDED is not defined they are not visible and always enabled.

I only tried to give good defaults for PC type of hardware. So far 
the assumption is that people running other architectures know how 
to configure a kernel.

I also included VGA_CONSOLE with this. Arguably a lot of people use
fbcon now, but having vga console compiled in too as a fallback doesn't hurt.

Hopefully this will fix one of the major FAQs on linux-kernel.

-Andi

diff -u linux-2.5.70/drivers/char/Kconfig-KCONFIG linux-2.5.70/drivers/char/Kconfig
--- linux-2.5.70/drivers/char/Kconfig-KCONFIG	2003-05-08 04:52:43.000000000 +0200
+++ linux-2.5.70/drivers/char/Kconfig	2003-06-06 23:46:52.000000000 +0200
@@ -5,8 +5,9 @@
 menu "Character devices"
 
 config VT
-	bool "Virtual terminal"
+	bool "Virtual terminal" if EMBEDDED
 	requires INPUT=y
+	default y
 	---help---
 	  If you say Y here, you will get support for terminal devices with
 	  display and keyboard devices. These are called "virtual" because you
@@ -35,8 +36,9 @@
 	  shiny Linux system :-)
 
 config VT_CONSOLE
-	bool "Support for console on virtual terminal"
+	bool "Support for console on virtual terminal" if EMBEDDED
 	depends on VT
+	default y
 	---help---
 	  The system console is the device which receives all kernel messages
 	  and warnings and which allows logins in single user mode. If you
diff -u linux-2.5.70/drivers/input/keyboard/Kconfig-KCONFIG linux-2.5.70/drivers/input/keyboard/Kconfig
--- linux-2.5.70/drivers/input/keyboard/Kconfig-KCONFIG	2003-03-28 18:32:22.000000000 +0100
+++ linux-2.5.70/drivers/input/keyboard/Kconfig	2003-06-06 23:46:51.000000000 +0200
@@ -2,7 +2,7 @@
 # Input core configuration
 #
 config INPUT_KEYBOARD
-	bool "Keyboards"
+	bool "Keyboards" if (X86 && EMBEDDED) || (!X86)
 	default y
 	depends on INPUT
 	help
@@ -12,7 +12,7 @@
 	  If unsure, say Y.
 
 config KEYBOARD_ATKBD
-	tristate "AT keyboard support"
+	tristate "AT keyboard support" if (X86 && EMBEDDED) || (!X86) 
 	default y
 	depends on INPUT && INPUT_KEYBOARD && SERIO
 	help
diff -u linux-2.5.70/drivers/input/serio/Kconfig-KCONFIG linux-2.5.70/drivers/input/serio/Kconfig
--- linux-2.5.70/drivers/input/serio/Kconfig-KCONFIG	2003-03-28 18:32:22.000000000 +0100
+++ linux-2.5.70/drivers/input/serio/Kconfig	2003-06-06 23:56:20.000000000 +0200
@@ -19,7 +19,7 @@
 	  as a module, say M here and read <file:Documentation/modules.txt>.
 
 config SERIO_I8042
-	tristate "i8042 PC Keyboard controller"
+	tristate "i8042 PC Keyboard controller" if (X86 && EMBEDDED) || (!X86)
 	default y
 	depends on SERIO
 	---help---
diff -u linux-2.5.70/drivers/input/Kconfig-KCONFIG linux-2.5.70/drivers/input/Kconfig
--- linux-2.5.70/drivers/input/Kconfig-KCONFIG	2003-02-10 19:37:58.000000000 +0100
+++ linux-2.5.70/drivers/input/Kconfig	2003-06-06 23:44:32.000000000 +0200
@@ -5,7 +5,7 @@
 menu "Input device support"
 
 config INPUT
-	tristate "Input devices (needed for keyboard, mouse, ...)"
+	tristate "Input devices (needed for keyboard, mouse, ...)" if EMBEDDED
 	default y
 	---help---
 	  Say Y here if you have any input device (mouse, keyboard, tablet,
@@ -27,7 +27,7 @@
 comment "Userland interfaces"
 
 config INPUT_MOUSEDEV
-	tristate "Mouse interface"
+	tristate "Mouse interface" if EMBEDDED
 	default y
 	depends on INPUT
 	---help---
@@ -45,7 +45,7 @@
 	  a module, say M here and read <file:Documentation/modules.txt>.
 
 config INPUT_MOUSEDEV_PSAUX
-	bool "Provide legacy /dev/psaux device"
+	bool "Provide legacy /dev/psaux device" if EMBEDDED
 	default y
 	depends on INPUT_MOUSEDEV
 
diff -u linux-2.5.70/drivers/video/console/Kconfig-KCONFIG linux-2.5.70/drivers/video/console/Kconfig
--- linux-2.5.70/drivers/video/console/Kconfig-KCONFIG	2003-03-28 18:32:25.000000000 +0100
+++ linux-2.5.70/drivers/video/console/Kconfig	2003-06-07 08:23:50.000000000 +0200
@@ -5,8 +5,9 @@
 menu "Console display driver support"
 
 config VGA_CONSOLE
-	bool "VGA text console"
+	bool "VGA text console" if (EMBEDDED && X86) || (!X86)
 	depends on !ARCH_ACORN && !ARCH_EBSA110 || !4xx && !8xx
+	default y
 	help
 	  Saying Y here will allow you to use Linux in text mode through a
 	  display that complies with the generic VGA standard. Virtually
