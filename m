Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263325AbTHVQiS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 12:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263611AbTHVQiS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 12:38:18 -0400
Received: from verein.lst.de ([212.34.189.10]:14056 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S263325AbTHVQiH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 12:38:07 -0400
Date: Fri, 22 Aug 2003 18:38:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix the -test3 input config damages
Message-ID: <20030822163800.GA7568@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -3 () PATCH_UNIFIED_DIFF,USER_AGENT_MUTT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's really no point in forcing in support for all kinds of
optional input devices unless CONFIG_EMBEDDED.  Also some of the
selections really broke configs that worked fine before as indicated
by the reports on lkml.  Instead select CONFIG_INPUT if CONFIG_VT
is selected so people upgrading from 2.4 using make oldconfig have
a chance to see it if they didn't need CONFIG_INPUT before.

Btw, could we please get a consensus on what CONFIG_EMBEDDED is
supposed to mean?  It was introduced to allow compiling code out
for special cases that normal userspace should be able to rely
on like epoll and futexes but people seem to use it as an Aunt Tillie
guard these days..


--- 1.15/drivers/char/Kconfig	Wed Jul 16 13:39:32 2003
+++ edited/drivers/char/Kconfig	Sun Aug 10 11:17:02 2003
@@ -5,8 +5,8 @@
 menu "Character devices"
 
 config VT
-	bool "Virtual terminal" if EMBEDDED
-	requires INPUT=y
+	bool "Virtual terminal"
+	select INPUT
 	default y
 	---help---
 	  If you say Y here, you will get support for terminal devices with
@@ -36,7 +36,7 @@
 	  shiny Linux system :-)
 
 config VT_CONSOLE
-	bool "Support for console on virtual terminal" if EMBEDDED
+	bool "Support for console on virtual terminal"
 	depends on VT
 	default y
 	---help---
--- 1.5/drivers/input/Kconfig	Wed Jul 16 13:39:32 2003
+++ edited/drivers/input/Kconfig	Sun Aug 10 11:15:19 2003
@@ -5,7 +5,7 @@
 menu "Input device support"
 
 config INPUT
-	tristate "Input devices (needed for keyboard, mouse, ...)" if EMBEDDED
+	tristate "Input devices (needed for keyboard, mouse, ...)"
 	default y
 	---help---
 	  Say Y here if you have any input device (mouse, keyboard, tablet,
@@ -27,8 +27,8 @@
 comment "Userland interfaces"
 
 config INPUT_MOUSEDEV
-	tristate "Mouse interface" if EMBEDDED
+	tristate "Mouse interface"
 	default y
 	depends on INPUT
 	---help---
 	  Say Y here if you want your mouse to be accessible as char devices
@@ -45,8 +45,8 @@
 	  a module, say M here and read <file:Documentation/modules.txt>.
 
 config INPUT_MOUSEDEV_PSAUX
-	bool "Provide legacy /dev/psaux device" if EMBEDDED
+	bool "Provide legacy /dev/psaux device"
 	default y
 	depends on INPUT_MOUSEDEV
 
 config INPUT_MOUSEDEV_SCREEN_X
===== drivers/input/keyboard/Kconfig 1.6 vs edited =====
--- 1.6/drivers/input/keyboard/Kconfig	Wed Jul 16 13:39:32 2003
+++ edited/drivers/input/keyboard/Kconfig	Sun Aug 10 11:15:49 2003
@@ -2,7 +2,7 @@
 # Input core configuration
 #
 config INPUT_KEYBOARD
-	bool "Keyboards" if EMBEDDED || !X86
+	bool "Keyboards"
 	default y
 	depends on INPUT
 	help
@@ -12,8 +12,8 @@
 	  If unsure, say Y.
 
 config KEYBOARD_ATKBD
-	tristate "AT keyboard support" if EMBEDDED || !X86 
+	tristate "AT keyboard support"
 	default y
 	depends on INPUT && INPUT_KEYBOARD && SERIO
 	help
 	  Say Y here if you want to use a standard AT or PS/2 keyboard. Usually
===== drivers/input/serio/Kconfig 1.9 vs edited =====
--- 1.9/drivers/input/serio/Kconfig	Wed Jul 16 13:39:32 2003
+++ edited/drivers/input/serio/Kconfig	Sun Aug 10 11:16:08 2003
@@ -19,8 +19,8 @@
 	  as a module, say M here and read <file:Documentation/modules.txt>.
 
 config SERIO_I8042
-	tristate "i8042 PC Keyboard controller" if EMBEDDED || !X86
+	tristate "i8042 PC Keyboard controller"
 	default y
 	depends on SERIO
 	---help---
 	  i8042 is the chip over which the standard AT keyboard and PS/2
