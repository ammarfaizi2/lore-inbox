Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264196AbTHVUts (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 16:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264316AbTHVUts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 16:49:48 -0400
Received: from fed1mtao01.cox.net ([68.6.19.244]:54510 "EHLO
	fed1mtao01.cox.net") by vger.kernel.org with ESMTP id S264196AbTHVUtF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 16:49:05 -0400
Date: Fri, 22 Aug 2003 13:49:03 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Christoph Hellwig <hch@lst.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix the -test3 input config damages
Message-ID: <20030822204903.GA847@ip68-0-152-218.tc.ph.cox.net>
References: <20030822170523.GA7819@lst.de> <Pine.LNX.4.44.0308221027070.20736-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308221027070.20736-100000@home.osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 22, 2003 at 10:35:54AM -0700, Linus Torvalds wrote:

> 
> On Fri, 22 Aug 2003, Christoph Hellwig wrote:
> > 
> > What about two new options to replace the old CONFIG_EMBEDDED?
> 
> If it's just a naming issue for you, then yes, we could change the current 
> EXPERIMENTAL/BROKEN/EMBEDDED questions around a bit.
> 
> So we could split the EMBEDDED question into "STANDARD" (which implies VT,
> INPUT layer, PS/2 ATKBD) and "FEATURECOMPLETE" (FUTEX, EPOLL, NET).
> 
> Is it worth it? I see EMBEDDED as more of a "STANDARD" thing - for people
> who don't care or know, that's a slight safety-net saying "this selects
> the things you take for grated".

So lets give it a shot then.  This might clash with Christoph's patch,
if you've already applied it, but it otherwise applies to the current
bk.

===== arch/i386/defconfig 1.101 vs edited =====
--- 1.101/arch/i386/defconfig	Wed Aug 20 12:10:15 2003
+++ edited/arch/i386/defconfig	Fri Aug 22 13:41:24 2003
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
===== drivers/char/Kconfig 1.16 vs edited =====
--- 1.16/drivers/char/Kconfig	Fri Aug 22 09:52:20 2003
+++ edited/drivers/char/Kconfig	Fri Aug 22 13:43:59 2003
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
+++ edited/drivers/input/Kconfig	Fri Aug 22 13:45:40 2003
@@ -5,7 +5,10 @@
 menu "Input device support"
 
 config INPUT
-	tristate "Input devices (needed for keyboard, mouse, ...)" if EMBEDDED
+	tristate "Input devices (needed for keyboard, mouse, ...)"
+	select INPUT_MOUSEDEV if STANDARD
+	select INPUT_KEYBDEV if STANDARD && X86
+	select SERIO if STANDARD && X86
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
+++ edited/drivers/input/keyboard/Kconfig	Fri Aug 22 13:45:11 2003
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
+++ edited/drivers/input/serio/Kconfig	Fri Aug 22 13:39:13 2003
@@ -2,7 +2,8 @@
 # Input core configuration
 #
 config SERIO
 	tristate "Serial i/o support (needed for keyboard and mouse)"
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
+++ edited/drivers/video/console/Kconfig	Fri Aug 22 13:27:21 2003
@@ -5,7 +5,7 @@
 menu "Console display driver support"
 
 config VGA_CONSOLE
-	bool "VGA text console" if EMBEDDED || !X86
+	bool "VGA text console" if STANDARD && X86
 	depends on !ARCH_ACORN && !ARCH_EBSA110 || !4xx && !8xx
 	default y
 	help
===== init/Kconfig 1.22 vs edited =====
--- 1.22/init/Kconfig	Wed Aug 20 22:30:10 2003
+++ edited/init/Kconfig	Fri Aug 22 13:28:51 2003
@@ -145,8 +145,14 @@
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
@@ -155,7 +161,7 @@
 	  are doing.
 
 config KALLSYMS
-	 bool "Load all symbols for debugging/kksymoops" if EMBEDDED
+	 bool "Load all symbols for debugging/kksymoops" if NONSTD_ABI
 	 default y
 	 help
 	   Say Y here to let the kernel print out symbolic crash information and
@@ -163,7 +169,7 @@
 	   somewhat, as all symbols have to be loaded into the kernel image.
 
 config FUTEX
-	bool "Enable futex support" if EMBEDDED
+	bool "Enable futex support" if NONSTD_ABI
 	default y
 	help
 	  Disabling this option will cause the kernel to be built without
@@ -171,7 +177,7 @@
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
