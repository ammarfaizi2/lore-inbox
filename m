Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932127AbVJMRiy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbVJMRiy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 13:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932134AbVJMRiy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 13:38:54 -0400
Received: from mail.linicks.net ([217.204.244.146]:44555 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S932127AbVJMRiy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 13:38:54 -0400
From: Nick Warne <nick@linicks.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.4.31] Reintroduction i386 CONFIG_DUMMY_KEYB option
Date: Thu, 13 Oct 2005 18:38:44 +0100
User-Agent: KMail/1.8.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510131838.45082.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

A small patch here to reintroduce the dummy keyboard, which seems to have been 
lost sometime - refer to my LKML thread:

http://marc.theaimsgroup.com/?l=linux-kernel&m=112885471602308&w=2

I reason that a lot of people have headless boxes (I have 7), and the dummy 
keyboard option appears to be unknown, but a good addition...

I found out that CONFIG_DUMMY_KEYB is slightly broken in that although the 
header text in 'dummy_keyb.c' states that this should be used with CONFIG_VT, 
using this option breaks the kernel build 'as is'.  This patch fixes that, 
and also allows the use of dummy keyboard with or with out CONFIG_VT which 
stops all the timeout warnings etc at boot on a keyboardless box.  The option 
to use the dummy keyboard is only available if CONFIG_INPUT_KEYBDEV   is 'n'.

I apologise sending to list only, but I couldn't find a maintainer of this 
area...

Nick


Signed off by Nick Warne <nick@linicks.net>


 Documentation/Configure.help |   18 ++++++++++++++++++
 arch/i386/kernel/dmi_scan.c  |    2 ++
 drivers/char/dummy_keyb.c    |    1 +
 drivers/input/Config.in      |    5 +++++
 kernel/panic.c               |    2 +-
 5 files changed, 27 insertions(+), 1 deletion(-)





diff -Naur linux-2.4.31.orig/Documentation/Configure.help 
linux-2.4.31n/Documentation/Configure.help
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
diff -Naur linux-2.4.31.orig/arch/i386/kernel/dmi_scan.c 
linux-2.4.31n/arch/i386/kernel/dmi_scan.c
--- linux-2.4.31.orig/arch/i386/kernel/dmi_scan.c	Wed Nov 17 11:54:21 2004
+++ linux-2.4.31n/arch/i386/kernel/dmi_scan.c	Wed Oct 12 15:57:27 2005
@@ -412,11 +412,13 @@
 static __init int broken_ps2_resume(struct dmi_blacklist *d)
 {
 #ifdef CONFIG_VT
+#ifndef CONFIG_DUMMY_KEYB
 	if (pm_kbd_request_override == NULL)
 	{
 		pm_kbd_request_override = pckbd_pm_resume;
 		printk(KERN_INFO "%s machine detected. Mousepad Resume Bug workaround 
enabled.\n", d->ident);
 	}
+#endif
 #endif
 	return 0;
 }
diff -Naur linux-2.4.31.orig/drivers/char/dummy_keyb.c 
linux-2.4.31n/drivers/char/dummy_keyb.c
--- linux-2.4.31.orig/drivers/char/dummy_keyb.c	Mon Aug 25 12:44:41 2003
+++ linux-2.4.31n/drivers/char/dummy_keyb.c	Wed Oct 12 15:38:48 2005
@@ -29,6 +29,7 @@
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/input.h>
+#include <asm/keyboard.h>
 
 void kbd_leds(unsigned char leds)
 {
diff -Naur linux-2.4.31.orig/drivers/input/Config.in 
linux-2.4.31n/drivers/input/Config.in
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




-- 
http://sourceforge.net/projects/quake2plus

"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."

