Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261878AbTELEJo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 00:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbTELEJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 00:09:44 -0400
Received: from dp.samba.org ([66.70.73.150]:38893 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261878AbTELEJm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 00:09:42 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16063.8548.834064.715458@argo.ozlabs.ibm.com>
Date: Mon, 12 May 2003 14:21:56 +1000
To: torvalds@transmeta.com, Franz.Sirl-kernel@lauterbach.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix adbhid driver
X-Mailer: VM 7.15 under Emacs 21.3.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

This patch fixes some compilation errors in the adbhid driver (the
driver that connects ADB keyboards to the input layer), and adds a fix
for one powerbook model.  Franz is the maintainer of this driver, and
I sent this patch to him some time ago for approval, but I didn't get
an answer.  It has been in our linuxppc-2.5 tree for some time without
problems, so please apply it.

Regards,
Paul.

diff -urN linux-2.5/drivers/macintosh/adbhid.c linuxppc-2.5/drivers/macintosh/adbhid.c
--- linux-2.5/drivers/macintosh/adbhid.c	2003-02-14 08:05:38.000000000 +1100
+++ linuxppc-2.5/drivers/macintosh/adbhid.c	2003-03-03 13:51:01.000000000 +1100
@@ -42,6 +42,10 @@
 #include <linux/adb.h>
 #include <linux/cuda.h>
 #include <linux/pmu.h>
+
+#include <asm/machdep.h>
+#include <asm/pmac_feature.h>
+
 #ifdef CONFIG_PMAC_BACKLIGHT
 #include <asm/backlight.h>
 #endif
@@ -65,7 +69,7 @@
 	  0, 83,  0, 55,  0, 78,  0, 69,  0,  0,  0, 98, 96,  0, 74,  0,
 	  0,117, 82, 79, 80, 81, 75, 76, 77, 71,  0, 72, 73,183,181,124,
 	 63, 64, 65, 61, 66, 67,191, 87,190, 99,  0, 70,  0, 68,101, 88,
-	  0,119,110,102,104,111, 62,107, 60,109, 59, 54,100, 97,116,116
+	  0,119,110,102,104,111, 62,107, 60,109, 59, 54,100, 97,126,116
 };
 
 struct adbhid {
@@ -84,7 +88,7 @@
 
 static void adbhid_probe(void);
 
-static void adbhid_input_keycode(int, int, int);
+static void adbhid_input_keycode(int, int, int, struct pt_regs *);
 static void leds_done(struct adb_request *);
 
 static void init_trackpad(int id);
@@ -140,7 +144,7 @@
 }
 
 static void
-adbhid_input_keycode(int id, int keycode, int repeat, pt_regs *regs)
+adbhid_input_keycode(int id, int keycode, int repeat, struct pt_regs *regs)
 {
 	int up_flag;
 
@@ -156,6 +160,15 @@
 		return;
 	case 0x3f: /* ignore Powerbook Fn key */
 		return;
+	case 0x7e: /* Power key on PBook 3400 needs remapping */
+		switch(pmac_call_feature(PMAC_FTR_GET_MB_INFO,
+			NULL, PMAC_MB_INFO_MODEL, 0)) {
+		case PMAC_TYPE_COMET:
+		case PMAC_TYPE_HOOPER:
+		case PMAC_TYPE_KANGA:
+			keycode = 0x7f;
+		}
+		break;
 	}
 
 	if (adbhid[id]->keycode[keycode]) {
@@ -343,13 +356,12 @@
 		case 0xa:	/* brightness decrease */
 #ifdef CONFIG_PMAC_BACKLIGHT
 			if (!disable_kernel_backlight) {
-				if (!down || backlight < 0)
-					break;
-				if (backlight > BACKLIGHT_OFF)
-					set_backlight_level(backlight-1);
-				else
-					set_backlight_level(BACKLIGHT_OFF);
-				break;
+				if (down && backlight >= 0) {
+					if (backlight > BACKLIGHT_OFF)
+						set_backlight_level(backlight-1);
+					else
+						set_backlight_level(BACKLIGHT_OFF);
+				}
 			}
 #endif /* CONFIG_PMAC_BACKLIGHT */
 			input_report_key(&adbhid[id]->input, KEY_BRIGHTNESSDOWN, down);
@@ -358,13 +370,12 @@
 		case 0x9:	/* brightness increase */
 #ifdef CONFIG_PMAC_BACKLIGHT
 			if (!disable_kernel_backlight) {
-				if (!down || backlight < 0)
-					break;
-				if (backlight < BACKLIGHT_MAX)
-					set_backlight_level(backlight+1);
-				else 
-					set_backlight_level(BACKLIGHT_MAX);
-				break;
+				if (down && backlight >= 0) {
+					if (backlight < BACKLIGHT_MAX)
+						set_backlight_level(backlight+1);
+					else 
+						set_backlight_level(BACKLIGHT_MAX);
+				}
 			}
 #endif /* CONFIG_PMAC_BACKLIGHT */
 			input_report_key(&adbhid[id]->input, KEY_BRIGHTNESSUP, down);
