Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264647AbSKIF0n>; Sat, 9 Nov 2002 00:26:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264649AbSKIF0n>; Sat, 9 Nov 2002 00:26:43 -0500
Received: from dp.samba.org ([66.70.73.150]:46571 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S264647AbSKIF0m>;
	Sat, 9 Nov 2002 00:26:42 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15820.40456.734049.126906@argo.ozlabs.ibm.com>
Date: Sat, 9 Nov 2002 16:32:56 +1100
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, Franz.Sirl-kernel@lauterbach.com
Subject: [PATCH] Update adbhid.c driver
X-Mailer: VM 7.07 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

This patch updates drivers/macintosh/adbhid.c driver (which interfaces
between the ADB bus and the input layer).  The patch gets rid of
global cli/sti uses and corrects some typos (for example
input.idversion -> input.id.version).  These changes have been
approved by Franz Sirl, the maintainer of this driver.

Please apply.

Thanks,
Paul.

diff -urN linux-2.5/drivers/macintosh/adbhid.c pmac-2.5/drivers/macintosh/adbhid.c
--- linux-2.5/drivers/macintosh/adbhid.c	2002-10-09 08:18:31.000000000 +1000
+++ pmac-2.5/drivers/macintosh/adbhid.c	2002-11-07 14:50:41.000000000 +1100
@@ -3,8 +3,9 @@
  *
  * ADB HID driver for Power Macintosh computers.
  *
- * Adapted from drivers/macintosh/mac_keyb.c by Franz Sirl
- * (see that file for its authors and contributors).
+ * Adapted from drivers/macintosh/mac_keyb.c by Franz Sirl.
+ * drivers/macintosh/mac_keyb.c was Copyright (C) 1996 Paul Mackerras
+ * with considerable contributions from Ben Herrenschmidt and others.
  *
  * Copyright (C) 2000 Franz Sirl.
  *
@@ -433,22 +434,17 @@
 static int
 adb_message_handler(struct notifier_block *this, unsigned long code, void *x)
 {
-	unsigned long flags;
-
 	switch (code) {
 	case ADB_MSG_PRE_RESET:
 	case ADB_MSG_POWERDOWN:
 	    	/* Stop the repeat timer. Autopoll is already off at this point */
-		save_flags(flags);
-		cli();
 		{
 			int i;
 			for (i = 1; i < 16; i++) {
 				if (adbhid[i])
-					del_timer(&adbhid[i]->input.timer);
+					del_timer_sync(&adbhid[i]->input.timer);
 			}
 		}
-		restore_flags(flags);
 
 		/* Stop pending led requests */
 		while(!led_request.complete)
@@ -479,7 +475,7 @@
 	memset(adbhid[id], 0, sizeof(struct adbhid));
 	sprintf(adbhid[id]->phys, "adb%d:%d.%02x/input", id, default_id, original_handler_id);
 
-	init_input_dev(&adbhid[id]);
+	init_input_dev(&adbhid[id]->input);
 
 	adbhid[id]->id = default_id;
 	adbhid[id]->original_handler_id = original_handler_id;
@@ -508,21 +504,21 @@
 		switch (original_handler_id) {
 		default:
 			printk("<unknown>.\n");
-			adbhid[id]->input.idversion = ADB_KEYBOARD_UNKNOWN;
+			adbhid[id]->input.id.version = ADB_KEYBOARD_UNKNOWN;
 			break;
 
 		case 0x01: case 0x02: case 0x03: case 0x06: case 0x08:
 		case 0x0C: case 0x10: case 0x18: case 0x1B: case 0x1C:
 		case 0xC0: case 0xC3: case 0xC6:
 			printk("ANSI.\n");
-			adbhid[id]->input.idversion = ADB_KEYBOARD_ANSI;
+			adbhid[id]->input.id.version = ADB_KEYBOARD_ANSI;
 			break;
 
 		case 0x04: case 0x05: case 0x07: case 0x09: case 0x0D:
 		case 0x11: case 0x14: case 0x19: case 0x1D: case 0xC1:
 		case 0xC4: case 0xC7:
 			printk("ISO, swapping keys.\n");
-			adbhid[id]->input.idversion = ADB_KEYBOARD_ISO;
+			adbhid[id]->input.id.version = ADB_KEYBOARD_ISO;
 			i = adbhid[id]->keycode[10];
 			adbhid[id]->keycode[10] = adbhid[id]->keycode[50];
 			adbhid[id]->keycode[50] = i;
@@ -531,7 +527,7 @@
 		case 0x12: case 0x15: case 0x16: case 0x17: case 0x1A:
 		case 0x1E: case 0xC2: case 0xC5: case 0xC8: case 0xC9:
 			printk("JIS.\n");
-			adbhid[id]->input.idversion = ADB_KEYBOARD_JIS;
+			adbhid[id]->input.id.version = ADB_KEYBOARD_JIS;
 			break;
 		}
 
