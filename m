Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751214AbVJNJUD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbVJNJUD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 05:20:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbVJNJUD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 05:20:03 -0400
Received: from mail2.utc.com ([192.249.46.191]:21155 "EHLO mail2.utc.com")
	by vger.kernel.org with ESMTP id S1751214AbVJNJUA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 05:20:00 -0400
Date: Fri, 14 Oct 2005 10:19:44 +0100 (BST)
From: Nick Warne <nick@linicks.net>
Subject: Re: [PATCH 2.4.31] Reintroduction i386 CONFIG_DUMMY_KEYB option
X-X-Sender: nick@website2.europe.pwc.ca
To: linux-kernel@vger.kernel.org
Cc: Willy Tarreau <willy@w.ods.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Message-id: <Pine.LNX.4.44.0510141006280.3868-200000@website2.europe.pwc.ca>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_QAhkvNtnwcAcF3Pi5zXV0w)"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--Boundary_(ID_QAhkvNtnwcAcF3Pi5zXV0w)
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT


>>  #ifdef CONFIG_VT
>> +#ifndef CONFIG_DUMMY_KEYB

> Please could you change this to #if defined(CONFIG_VT) && 
> !defined(CONFIG_DUMMY_KEYB) ?

> Marcelo, I'd like this one to be merged, as it is useful to many of us, 
> and is already fixed in 2.6 (where you're not forced to have a 
> keyboard).  It's not intrusive and at most a build fix. Would you please 
> accept Nick's patch after the little clean-up above ?


OK, the adjusted patch attached.  I did look at the ifdefs in that file 
for a few minutes; but I see now I should have done it like this in the 
first place.

Nick

--Boundary_(ID_QAhkvNtnwcAcF3Pi5zXV0w)
Content-id: <Pine.LNX.4.44.0510141019440.3868@website2.europe.pwc.ca>
Content-type: TEXT/PLAIN; name=dummy_keyb.diff; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=dummy_keyb.diff

diff -Naur linux-2.4.31.orig/Documentation/Configure.help linux-2.4.31n/Documentation/Configure.help
--- linux-2.4.31.orig/Documentation/Configure.help	Mon Apr  4 02:42:19 2005
+++ linux-2.4.31n/Documentation/Configure.help	Thu Oct 13 09:38:07 2005
@@ -15242,6 +15242,24 @@
   The module will be called joydev.o. If you want to compile it as a
   module, say M here and read <file:Documentation/modules.txt>.
 
+Dummy keyboard driver
+CONFIG_DUMMY_KEYB
+  What is this for?
+
+  Not all systems have keyboards.  Some don't even have a keyboard
+  port.  However, some of those systems have video support and can
+  use the virtual terminal support for display.  However, the virtual
+  terminal code expects a keyboard of some kind.  This driver keeps
+  the virtual terminal code happy by providing it a "keyboard", albeit
+  a very quiet one.
+
+  If you want to use the virtual terminal support but your system
+  does not support a keyboard, define CONFIG_DUMMY_KEYB along with
+  CONFIG_VT.
+
+  This can also be selected lonesome without any VT support (i.e. no
+  monitor or keyboard attached) - just define CONFIG_DUMMY_KEYB.
+
 Event interface support
 CONFIG_INPUT_EVDEV
   Say Y here if you want your USB or ADB HID device events be
diff -Naur linux-2.4.31.orig/arch/i386/kernel/dmi_scan.c linux-2.4.31n/arch/i386/kernel/dmi_scan.c
--- linux-2.4.31.orig/arch/i386/kernel/dmi_scan.c	Wed Nov 17 11:54:21 2004
+++ linux-2.4.31n/arch/i386/kernel/dmi_scan.c	Fri Oct 14 08:39:04 2005
@@ -411,7 +411,7 @@
 
 static __init int broken_ps2_resume(struct dmi_blacklist *d)
 {
-#ifdef CONFIG_VT
+#if defined(CONFIG_VT) && !defined(CONFIG_DUMMY_KEYB)
 	if (pm_kbd_request_override == NULL)
 	{
 		pm_kbd_request_override = pckbd_pm_resume;
diff -Naur linux-2.4.31.orig/drivers/char/dummy_keyb.c linux-2.4.31n/drivers/char/dummy_keyb.c
--- linux-2.4.31.orig/drivers/char/dummy_keyb.c	Mon Aug 25 12:44:41 2003
+++ linux-2.4.31n/drivers/char/dummy_keyb.c	Wed Oct 12 15:38:48 2005
@@ -29,6 +29,7 @@
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/input.h>
+#include <asm/keyboard.h>
 
 void kbd_leds(unsigned char leds)
 {
diff -Naur linux-2.4.31.orig/drivers/input/Config.in linux-2.4.31n/drivers/input/Config.in
--- linux-2.4.31.orig/drivers/input/Config.in	Wed Feb 18 13:36:31 2004
+++ linux-2.4.31n/drivers/input/Config.in	Wed Oct 12 15:16:09 2005
@@ -7,6 +7,11 @@
 
 tristate 'Input core support' CONFIG_INPUT
 dep_tristate '  Keyboard support' CONFIG_INPUT_KEYBDEV $CONFIG_INPUT
+
+if [ "$CONFIG_INPUT_KEYBDEV" == "n" ]; then
+	bool '  Use dummy keyboard driver' CONFIG_DUMMY_KEYB $CONFIG_INPUT
+fi
+
 dep_tristate '  Mouse support' CONFIG_INPUT_MOUSEDEV $CONFIG_INPUT
 if [ "$CONFIG_INPUT_MOUSEDEV" != "n" ]; then
    int '   Horizontal screen resolution' CONFIG_INPUT_MOUSEDEV_SCREEN_X 1024
diff -Naur linux-2.4.31.orig/kernel/panic.c linux-2.4.31n/kernel/panic.c
--- linux-2.4.31.orig/kernel/panic.c	Wed Nov 17 11:54:22 2004
+++ linux-2.4.31n/kernel/panic.c	Wed Oct 12 16:07:56 2005
@@ -104,7 +104,7 @@
 #endif
 	sti();
 	for(;;) {
-#if defined(CONFIG_X86) && defined(CONFIG_VT) 
+#if defined(CONFIG_X86) && defined(CONFIG_VT) && !defined(CONFIG_DUMMY_KEYB) 
 		extern void panic_blink(void);
 		panic_blink(); 
 #endif

--Boundary_(ID_QAhkvNtnwcAcF3Pi5zXV0w)--
