Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262704AbSI1EbR>; Sat, 28 Sep 2002 00:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262705AbSI1EaC>; Sat, 28 Sep 2002 00:30:02 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:2244 "HELO atlrel6.hp.com")
	by vger.kernel.org with SMTP id <S262706AbSI1E3f>;
	Sat, 28 Sep 2002 00:29:35 -0400
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] pc_keyb.c: hook for keybd controller detection
Message-Id: <E17v9Je-0001nG-00@eeyore>
From: Bjorn Helgaas <helgaas@fc.hp.com>
Date: Fri, 27 Sep 2002 22:34:54 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the ability for architecture-specific code to
determine whether a keyboard controller is present (IA64 uses
ACPI to figure this out).

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.666   -> 1.667  
#	drivers/char/pc_keyb.c	1.12    -> 1.13   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/16	bjorn_helgaas@hp.com	1.667
# Add hook so arch-specific code can determine whether
# keyboard controller is present.
# --------------------------------------------
#
diff -Nru a/drivers/char/pc_keyb.c b/drivers/char/pc_keyb.c
--- a/drivers/char/pc_keyb.c	Mon Sep 16 16:39:24 2002
+++ b/drivers/char/pc_keyb.c	Mon Sep 16 16:39:24 2002
@@ -69,6 +69,9 @@
 static int aux_reconnect = 0;
 #endif
 
+#ifndef kbd_controller_present
+#define kbd_controller_present()	1
+#endif
 static spinlock_t kbd_controller_lock = SPIN_LOCK_UNLOCKED;
 static unsigned char handle_kbd_event(void);
 
@@ -895,6 +898,11 @@
 
 void __init pckbd_init_hw(void)
 {
+	if (!kbd_controller_present()) {
+		kbd_exists = 0;
+		return;
+	}
+
 	kbd_request_region();
 
 	/* Flush any pending input. */
