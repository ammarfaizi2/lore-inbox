Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264223AbUDHI7q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 04:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264215AbUDHI7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 04:59:45 -0400
Received: from [194.89.250.117] ([194.89.250.117]:51075 "EHLO
	kimputer.holviala.com") by vger.kernel.org with ESMTP
	id S264223AbUDHI7k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 04:59:40 -0400
From: Kim Holviala <kim@holviala.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Targus Scroller mouse wheel support for kernel 2.6.5
Date: Thu, 8 Apr 2004 11:59:37 +0300
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200404081159.37996.kim@holviala.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Targus mice boot in their own three-byte PS/2 protocol variant mode
and the support for that was missing. They can be switched to normal
ImPS/2, but a lot of laptops filter PS/2 traffic so external mice can't
be switched to other modes.

This patch adds support for such mice or more specifically, support
for the wheel. Since this protocol can't be detected, the parameter
psmouse.proto=targus must be specified in kernel parameters.

Flame away as this is my first post to LKML.


Kim




diff -ruN linux-2.6.5-orig/Documentation/kernel-parameters.txt linux-2.6.5-targus/Documentation/kernel-parameters.txt
--- linux-2.6.5-orig/Documentation/kernel-parameters.txt	2004-04-04 06:38:27.000000000 +0300
+++ linux-2.6.5-targus/Documentation/kernel-parameters.txt	2004-04-08 11:38:02.236991644 +0300
@@ -875,7 +875,7 @@
 			See Documentation/ramdisk.txt.
 
 	psmouse.proto=  [HW,MOUSE] Highest PS2 mouse protocol extension to
-			probe for (bare|imps|exps).
+			probe for (bare|imps|exps|targus).
 	psmouse.rate=	[HW,MOUSE] Set desired mouse report rate, in reports
 			per second.
 	psmouse.resetafter=
diff -ruN linux-2.6.5-orig/drivers/input/mouse/Kconfig linux-2.6.5-targus/drivers/input/mouse/Kconfig
--- linux-2.6.5-orig/drivers/input/mouse/Kconfig	2004-04-04 06:37:45.000000000 +0300
+++ linux-2.6.5-targus/drivers/input/mouse/Kconfig	2004-04-08 11:29:01.490187080 +0300
@@ -33,6 +33,9 @@
 	  If you do not want install specialized drivers but want tapping
 	  working please use option psmouse.proto=imps.
 
+	  If you have a Targus Scroller mouse and the scroll wheel moves the
+	  cursor instead of scrolling, use option psmouse.proto=targus.
+
 	  If unsure, say Y.
 
 	  To compile this driver as a module, choose M here: the
diff -ruN linux-2.6.5-orig/drivers/input/mouse/psmouse-base.c linux-2.6.5-targus/drivers/input/mouse/psmouse-base.c
--- linux-2.6.5-orig/drivers/input/mouse/psmouse-base.c	2004-04-04 06:36:27.000000000 +0300
+++ linux-2.6.5-targus/drivers/input/mouse/psmouse-base.c	2004-04-08 11:37:45.104063584 +0300
@@ -10,6 +10,13 @@
  * the Free Software Foundation.
  */
 
+/*
+ * 2004/04/08 -- Kim Holviala - Added support for the Targus Scroller mouse
+ * and it's own three-byte PS/2 protocol variant. Requires proto=targus
+ * since it's impossible to detect.
+ */
+
+
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
@@ -29,7 +36,7 @@
 static char *psmouse_proto;
 static unsigned int psmouse_max_proto = -1U;
 module_param_named(proto, psmouse_proto, charp, 0);
-MODULE_PARM_DESC(proto, "Highest protocol extension to probe (bare, imps, exps). Useful for KVM switches.");
+MODULE_PARM_DESC(proto, "Highest protocol extension to probe (bare, imps, exps, targus). Useful for KVM switches.");
 
 int psmouse_resolution = 200;
 module_param_named(resolution, psmouse_resolution, uint, 0);
@@ -53,7 +60,7 @@
 __obsolete_setup("psmouse_resetafter=");
 __obsolete_setup("psmouse_rate=");
 
-static char *psmouse_protocols[] = { "None", "PS/2", "PS2++", "PS2T++", "GenPS/2", "ImPS/2", "ImExPS/2", "SynPS/2"};
+static char *psmouse_protocols[] = { "None", "PS/2", "TgsPS/2", "PS2++", "PS2T++", "GenPS/2", "ImPS/2", "ImExPS/2", "SynPS/2"};
 
 /*
  * psmouse_process_packet() analyzes the PS/2 mouse packet contents and
@@ -101,6 +108,15 @@
 	}
 
 /*
+ * Scroll wheel on Targus Scroller
+ */
+
+	if (psmouse->type == PSMOUSE_TARGUS && ((packet[2] >> 2) & 0x20) != (packet[0] & 0x20)) {
+		input_report_rel(dev, REL_WHEEL, -(signed char) packet[2]);
+		packet[2] = 0;
+	}
+
+/*
  * Generic PS/2 Mouse
  */
 
@@ -428,6 +444,19 @@
 	}
 
 /*
+ * Targus Scroller mice have their own protocol for the scroll wheel
+ * which works even when ImPS/2 mode can't be set. Unfortunately this
+ * is impossible to detect, so we'll just trust the proto setting.
+ */
+	if (psmouse_max_proto == PSMOUSE_TARGUS) {
+		psmouse->vendor = "Targus";
+		psmouse->name = "Scroller Mouse";
+		set_bit(REL_WHEEL, psmouse->dev.relbit);
+
+		return PSMOUSE_TARGUS;
+	}
+
+/*
  * Okay, all failed, we have a standard mouse here. The number of the buttons
  * is still a question, though. We assume 3.
  */
@@ -722,6 +751,8 @@
 			psmouse_max_proto = PSMOUSE_IMPS;
 		else if (!strcmp(psmouse_proto, "exps"))
 			psmouse_max_proto = PSMOUSE_IMEX;
+		else if (!strcmp(psmouse_proto, "targus"))
+			psmouse_max_proto = PSMOUSE_TARGUS;
 		else
 			printk(KERN_ERR "psmouse: unknown protocol type '%s'\n", psmouse_proto);
 	}
diff -ruN linux-2.6.5-orig/drivers/input/mouse/psmouse.h linux-2.6.5-targus/drivers/input/mouse/psmouse.h
--- linux-2.6.5-orig/drivers/input/mouse/psmouse.h	2004-04-04 06:38:13.000000000 +0300
+++ linux-2.6.5-targus/drivers/input/mouse/psmouse.h	2004-04-08 11:29:01.492186839 +0300
@@ -57,12 +57,13 @@
 };
 
 #define PSMOUSE_PS2		1
-#define PSMOUSE_PS2PP		2
-#define PSMOUSE_PS2TPP		3
-#define PSMOUSE_GENPS		4
-#define PSMOUSE_IMPS		5
-#define PSMOUSE_IMEX		6
-#define PSMOUSE_SYNAPTICS 	7
+#define PSMOUSE_TARGUS		2
+#define PSMOUSE_PS2PP		3
+#define PSMOUSE_PS2TPP		4
+#define PSMOUSE_GENPS		5
+#define PSMOUSE_IMPS		6
+#define PSMOUSE_IMEX		7
+#define PSMOUSE_SYNAPTICS 	8
 
 int psmouse_command(struct psmouse *psmouse, unsigned char *param, int command);
 int psmouse_reset(struct psmouse *psmouse);
