Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263030AbUCPP0K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 10:26:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262138AbUCPOlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 09:41:09 -0500
Received: from styx.suse.cz ([82.208.2.94]:57729 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S261913AbUCPOTg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 09:19:36 -0500
Content-Transfer-Encoding: 7BIT
Message-Id: <10794467762870@twilight.ucw.cz>
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH 10/44] Make enabling IBM RapidAccess special features its own option
X-Mailer: gregkh_patchbomb_levon_offspring
To: torvalds@osdl.org, vojtech@ucw.cz, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Date: Tue, 16 Mar 2004 15:19:36 +0100
In-Reply-To: <10794467761141@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1474.188.10, 2004-01-26 13:57:19+01:00, vojtech@suse.cz
  input: Create an extra option for enabling IBM RapidAccess keyboard
         special features (atkbd.extra), instead of abusing the
         atkbd.set option for this.


 Documentation/kernel-parameters.txt |   13 ++++++++++---
 drivers/input/keyboard/atkbd.c      |   35 ++++++++++++++++++++---------------
 2 files changed, 30 insertions(+), 18 deletions(-)

===================================================================

diff -Nru a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
--- a/Documentation/kernel-parameters.txt	Tue Mar 16 13:19:43 2004
+++ b/Documentation/kernel-parameters.txt	Tue Mar 16 13:19:43 2004
@@ -157,11 +157,18 @@
 
 	atascsi=	[HW,SCSI] Atari SCSI
 
-	atkbd.set=	[HW] Select keyboard code set
-			Format: <int>
+	atkbd.extra=	[HW] Enable extra LEDs and keys on IBM RapidAccess, EzKey
+			and similar keyboards
+
+	atkbd.reset=	[HW] Reset keyboard during initialization
+
+	atkbd.set=	[HW] Select keyboard code set 
+			Format: <int> (2 = AT (default) 3 = PS/2)
+
+	atkbd.scroll=	[HW] Enable scroll wheel on MS Office and similar keyboards
+	
 	atkbd.softrepeat=
 			[HW] Use software keyboard repeat
-	atkbd.reset=	[HW] Reset keyboard during initialization
 
 	autotest	[IA64]
 
diff -Nru a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c	Tue Mar 16 13:19:43 2004
+++ b/drivers/input/keyboard/atkbd.c	Tue Mar 16 13:19:43 2004
@@ -33,12 +33,11 @@
 MODULE_PARM(atkbd_set, "1i");
 MODULE_PARM(atkbd_reset, "1i");
 MODULE_PARM(atkbd_softrepeat, "1i");
-MODULE_PARM(atkbd_scroll, "1i");
 MODULE_LICENSE("GPL");
 
 static int atkbd_set = 2;
 module_param_named(set, atkbd_set, int, 0);
-MODULE_PARM_DESC(set, "Select keyboard code set (2 = default, 3, 4)");
+MODULE_PARM_DESC(set, "Select keyboard code set (2 = default, 3 = PS/2 native)");
 
 #if defined(__i386__) || defined(__x86_64__) || defined(__hppa__)
 static int atkbd_reset;
@@ -53,8 +52,12 @@
 MODULE_PARM_DESC(softrepeat, "Use software keyboard repeat");
 
 static int atkbd_scroll;
-module_parm_named(scroll, atkbd_scroll, bool, 0);
-MODULE_PARM_DESC_(scroll, "Enable scroll-wheel on office keyboards");
+module_param_named(scroll, atkbd_scroll, bool, 0);
+MODULE_PARM_DESC(scroll, "Enable scroll-wheel on MS Office and similar keyboards");
+
+static int atkbd_extra;
+module_param_named(extra, atkbd_extra, bool, 0);
+MODULE_PARM_DESC(extra, "Enable extra LEDs and keys on IBM RapidAcces, EzKey and similar keyboards");
 
 /*
  * Scancode to keycode tables. These are just the default setting, and
@@ -175,6 +178,7 @@
 	unsigned char cmdbuf[4];
 	unsigned char cmdcnt;
 	unsigned char set;
+	unsigned char extra;
 	unsigned char release;
 	int lastkey;
 	volatile signed char ack;
@@ -463,7 +467,7 @@
 			         | (test_bit(LED_CAPSL,   dev->led) ? 4 : 0);
 		        atkbd_command(atkbd, param, ATKBD_CMD_SETLEDS);
 
-			if (atkbd->set == 4) {
+			if (atkbd->extra) {
 				param[0] = 0;
 				param[1] = (test_bit(LED_COMPOSE, dev->led) ? 0x01 : 0)
 					 | (test_bit(LED_SLEEP,   dev->led) ? 0x02 : 0)
@@ -572,21 +576,22 @@
 		return 3;
 	}
 
-	if (atkbd_set != 2) 
-		if (!atkbd_command(atkbd, param, ATKBD_CMD_OK_GETID)) {
-			atkbd->id = param[0] << 8 | param[1];
+	if (atkbd_extra) {
+		param[0] = 0x71;
+		if (!atkbd_command(atkbd, param, ATKBD_CMD_EX_ENABLE)) {
+			atkbd->extra = 1;
 			return 2;
 		}
-
-	if (atkbd_set == 4) {
-		param[0] = 0x71;
-		if (!atkbd_command(atkbd, param, ATKBD_CMD_EX_ENABLE))
-			return 4;
 	}
 
 	if (atkbd_set != 3) 
 		return 2;
 
+	if (!atkbd_command(atkbd, param, ATKBD_CMD_OK_GETID)) {
+		atkbd->id = param[0] << 8 | param[1];
+		return 2;
+	}
+
 	param[0] = 3;
 	if (atkbd_command(atkbd, param, ATKBD_CMD_SSCANSET))
 		return 2;
@@ -739,9 +744,9 @@
 		atkbd->id = 0xab00;
 	}
 
-	if (atkbd->set == 4) {
+	if (atkbd->extra) {
 		atkbd->dev.ledbit[0] |= BIT(LED_COMPOSE) | BIT(LED_SUSPEND) | BIT(LED_SLEEP) | BIT(LED_MUTE) | BIT(LED_MISC);
-		sprintf(atkbd->name, "AT Set 2 Extended keyboard");
+		sprintf(atkbd->name, "AT Set 2 Extra keyboard");
 	} else
 		sprintf(atkbd->name, "AT %s Set %d keyboard",
 			atkbd->translated ? "Translated" : "Raw", atkbd->set);

