Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265526AbTIEV60 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 17:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265252AbTIEV4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 17:56:09 -0400
Received: from fed1mtao08.cox.net ([68.6.19.123]:33521 "EHLO
	fed1mtao08.cox.net") by vger.kernel.org with ESMTP id S262839AbTIEVwl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 17:52:41 -0400
Date: Fri, 5 Sep 2003 14:52:38 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] Rename and split CONFIG_EMBEDDED
Message-ID: <20030905215238.GE20060@ip68-0-152-218.tc.ph.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.  Inspired by Christoph Hellwig's fix to VT/INPUT, and the thread
that followed, this splits up CONFIG_EMBEDDED to reflect better what
it's actually used for now.  This creates a CONFIG_STANDARD, which is
for the features that users would be quite surprised to no longer have
(keyboard/mouse, VT, so on) and CONFIG_NONSTD_ABI, for things like
futexes, epoll, that might not be needed on your cellphone.  Comments?

===== arch/i386/defconfig 1.102 vs edited =====
--- 1.102/arch/i386/defconfig	Sun Aug 31 15:40:06 2003
+++ edited/arch/i386/defconfig	Fri Sep  5 14:45:36 2003
@@ -20,7 +20,8 @@
 # CONFIG_BSD_PROCESS_ACCT is not set
 CONFIG_SYSCTL=y
 CONFIG_LOG_BUF_SHIFT=15
-# CONFIG_EMBEDDED is not set
+CONFIG_STANDARD=y
+# CONFIG_NONSTD_ABI is not set
 CONFIG_KALLSYMS=y
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
===== drivers/char/Kconfig 1.18 vs edited =====
--- 1.18/drivers/char/Kconfig	Tue Sep  2 11:28:13 2003
+++ edited/drivers/char/Kconfig	Fri Sep  5 14:45:36 2003
@@ -5,8 +5,9 @@
 menu "Character devices"
 
 config VT
-	bool "Virtual terminal" if EMBEDDED
+	bool "Virtual terminal" if !STANDARD
 	select INPUT
+	select VT_CONSOLE if STANDARD
 	default y
 	---help---
 	  If you say Y here, you will get support for terminal devices with
@@ -36,7 +37,7 @@
 	  shiny Linux system :-)
 
 config VT_CONSOLE
-	bool "Support for console on virtual terminal" if EMBEDDED
+	bool "Support for console on virtual terminal"
 	depends on VT
 	default y
 	---help---
===== drivers/input/Kconfig 1.5 vs edited =====
--- 1.5/drivers/input/Kconfig	Wed Jul 16 10:39:32 2003
+++ edited/drivers/input/Kconfig	Fri Sep  5 14:45:36 2003
@@ -5,7 +5,9 @@
 menu "Input device support"
 
 config INPUT
-	tristate "Input devices (needed for keyboard, mouse, ...)" if EMBEDDED
+	tristate "Input devices (needed for keyboard, mouse, ...)"
+	select INPUT_MOUSEDEV if STANDARD
+	select INPUT_KEYBOARD if STANDARD && X86
 	default y
 	---help---
 	  Say Y here if you have any input device (mouse, keyboard, tablet,
@@ -27,8 +29,9 @@
 comment "Userland interfaces"
 
 config INPUT_MOUSEDEV
-	tristate "Mouse interface" if EMBEDDED
+	tristate "Mouse interface"
 	default y
+	select INPUT_MOUSEDEV_PSAUX if STANDARD
 	depends on INPUT
 	---help---
 	  Say Y here if you want your mouse to be accessible as char devices
@@ -45,7 +48,7 @@
 	  a module, say M here and read <file:Documentation/modules.txt>.
 
 config INPUT_MOUSEDEV_PSAUX
-	bool "Provide legacy /dev/psaux device" if EMBEDDED
+	bool "Provide legacy /dev/psaux device"
 	default y
 	depends on INPUT_MOUSEDEV
 
===== drivers/input/keyboard/Kconfig 1.6 vs edited =====
--- 1.6/drivers/input/keyboard/Kconfig	Wed Jul 16 10:39:32 2003
+++ edited/drivers/input/keyboard/Kconfig	Fri Sep  5 14:45:36 2003
@@ -2,8 +2,9 @@
 # Input core configuration
 #
 config INPUT_KEYBOARD
-	bool "Keyboards" if EMBEDDED || !X86
+	bool "Keyboards"
 	default y
+	select KEYBOARD_ATKBD if STANDARD && X86
 	depends on INPUT
 	help
 	  Say Y here, and a list of supported keyboards will be displayed.
@@ -12,7 +13,7 @@
 	  If unsure, say Y.
 
 config KEYBOARD_ATKBD
-	tristate "AT keyboard support" if EMBEDDED || !X86 
+	tristate "AT keyboard support"
 	default y
 	depends on INPUT && INPUT_KEYBOARD && SERIO
 	help
===== drivers/input/serio/Kconfig 1.9 vs edited =====
--- 1.9/drivers/input/serio/Kconfig	Wed Jul 16 10:39:32 2003
+++ edited/drivers/input/serio/Kconfig	Fri Sep  5 14:45:36 2003
@@ -2,7 +2,8 @@
 # Input core configuration
 #
 config SERIO
-	tristate "Serial i/o support (needed for keyboard and mouse)"
+	tristate "Serial i/o support (needed for keyboard and mouse)" if !(STANDARD && X86)
+	select SERIO_I8042 if STANDARD && X86
 	default y
 	---help---
 	  Say Yes here if you have any input device that uses serial I/O to
@@ -19,7 +20,7 @@
 	  as a module, say M here and read <file:Documentation/modules.txt>.
 
 config SERIO_I8042
-	tristate "i8042 PC Keyboard controller" if EMBEDDED || !X86
+	tristate "i8042 PC Keyboard controller"
 	default y
 	depends on SERIO
 	---help---
===== drivers/video/console/Kconfig 1.18 vs edited =====
--- 1.18/drivers/video/console/Kconfig	Wed Jul 16 10:39:32 2003
+++ edited/drivers/video/console/Kconfig	Fri Sep  5 14:45:36 2003
@@ -5,7 +5,7 @@
 menu "Console display driver support"
 
 config VGA_CONSOLE
-	bool "VGA text console" if EMBEDDED || !X86
+	bool "VGA text console" if !(STANDARD && X86)
 	depends on !ARCH_ACORN && !ARCH_EBSA110 || !4xx && !8xx
 	default y
 	help
===== init/Kconfig 1.25 vs edited =====
--- 1.25/init/Kconfig	Wed Sep  3 10:51:31 2003
+++ edited/init/Kconfig	Fri Sep  5 14:45:36 2003
@@ -153,8 +153,14 @@
 	  This option enables access to kernel configuration file and build
 	  information through /proc/ikconfig.
 
+config STANDARD
+	bool "Enable standard kernel features"
+	default y
+	help
+	  This option will automatically select some standard kernel
+	  features that you almost certainly want.
 
-menuconfig EMBEDDED
+menuconfig NONSTD_ABI
 	bool "Remove kernel features (for embedded systems)"
 	help
 	  This option allows certain base kernel features to be removed from
@@ -163,7 +169,7 @@
 	  are doing.
 
 config KALLSYMS
-	 bool "Load all symbols for debugging/kksymoops" if EMBEDDED
+	 bool "Load all symbols for debugging/kksymoops" if NONSTD_ABI
 	 default y
 	 help
 	   Say Y here to let the kernel print out symbolic crash information and
@@ -171,7 +177,7 @@
 	   somewhat, as all symbols have to be loaded into the kernel image.
 
 config FUTEX
-	bool "Enable futex support" if EMBEDDED
+	bool "Enable futex support" if NONSTD_ABI
 	default y
 	help
 	  Disabling this option will cause the kernel to be built without
@@ -179,7 +185,7 @@
 	  run glibc-based applications correctly.
 
 config EPOLL
-	bool "Enable eventpoll support" if EMBEDDED
+	bool "Enable eventpoll support" if NONSTD_ABI
 	default y
 	help
 	  Disabling this option will cause the kernel to be built without

-- 
Tom Rini
http://gate.crashing.org/~trini/
