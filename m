Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267899AbTBVNeX>; Sat, 22 Feb 2003 08:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267901AbTBVNeX>; Sat, 22 Feb 2003 08:34:23 -0500
Received: from mailout07.sul.t-online.com ([194.25.134.83]:20387 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267899AbTBVNeS>; Sat, 22 Feb 2003 08:34:18 -0500
Date: Sat, 22 Feb 2003 14:42:56 +0100
From: malware@t-online.de (Malware)
Message-Id: <200302221342.h1MDguW0029229@debian.malware.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] PC keyboard: Disable interrupts during initialization
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.757.40.2 -> 1.757.40.3
#	drivers/char/pc_keyb.c	1.13    -> 1.14   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/02/22	malware@debian.malware.de	1.757.40.3
# pc_keyb.c:
#   Fix: Disable interrupts during keyboard initialization.
#      The initialization does cause keyboard interrupts. On most platforms this
#      should not be a problem. But if there is no interrupt controller the
#      interrupt might retriggered for ever. This happended on the m68k/TekXpress
#      port. 
# --------------------------------------------
#
diff -Nru a/drivers/char/pc_keyb.c b/drivers/char/pc_keyb.c
--- a/drivers/char/pc_keyb.c	Sat Feb 22 13:29:21 2003
+++ b/drivers/char/pc_keyb.c	Sat Feb 22 13:29:21 2003
@@ -898,6 +898,8 @@
 
 void __init pckbd_init_hw(void)
 {
+	unsigned long flags;
+
 	if (!kbd_controller_present()) {
 		kbd_exists = 0;
 		return;
@@ -905,6 +907,9 @@
 
 	kbd_request_region();
 
+	save_flags(flags);
+	cli();
+
 	/* Flush any pending input. */
 	kbd_clear_input();
 
@@ -922,6 +927,8 @@
 
 	/* Ok, finally allocate the IRQ, and off we go.. */
 	kbd_request_irq(keyboard_interrupt);
+
+	restore_flags(flags);
 }
 
 #if defined CONFIG_PSMOUSE
