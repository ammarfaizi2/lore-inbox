Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265900AbUG2Sm1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265900AbUG2Sm1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 14:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267490AbUG2Op7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 10:45:59 -0400
Received: from styx.suse.cz ([82.119.242.94]:21142 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S264881AbUG2OIK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 10:08:10 -0400
To: torvalds@osdl.org, vojtech@suse.cz, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH 16/47] Make hardware rawmode optional for AT-keyboards
Content-Transfer-Encoding: 7BIT
Date: Thu, 29 Jul 2004 16:09:55 +0200
X-Mailer: gregkh_patchbomb_levon_offspring
In-Reply-To: <10911101951045@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Message-Id: <1091110195893@twilight.ucw.cz>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1722.117.2, 2004-06-06 11:08:20+02:00, vojtech@suse.cz
  input: Make hardware rawmode optional for AT-keyboards, and check
         for rawmode bits in keyboard.c
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>


 drivers/char/keyboard.c        |    3 ++-
 drivers/input/keyboard/atkbd.c |   16 ++++++++++++++--
 include/linux/input.h          |    1 +
 3 files changed, 17 insertions(+), 3 deletions(-)

===================================================================

diff -Nru a/drivers/char/keyboard.c b/drivers/char/keyboard.c
--- a/drivers/char/keyboard.c	Thu Jul 29 14:41:12 2004
+++ b/drivers/char/keyboard.c	Thu Jul 29 14:41:12 2004
@@ -942,7 +942,8 @@
 
 #if defined(CONFIG_X86) || defined(CONFIG_IA64) || defined(CONFIG_ALPHA) || defined(CONFIG_MIPS) || defined(CONFIG_PPC) || defined(CONFIG_SPARC32) || defined(CONFIG_SPARC64) || defined(CONFIG_PARISC) || defined(CONFIG_SH_MPC1211)
 
-#define HW_RAW(dev) (((dev)->id.bustype == BUS_I8042) && ((dev)->id.vendor == 0x0001) && ((dev)->id.product == 0x0001))
+#define HW_RAW(dev) (test_bit(EV_MSC, dev->evbit) && test_bit(MSC_RAW, dev->mscbit) &&\
+			((dev)->id.bustype == BUS_I8042) && ((dev)->id.vendor == 0x0001) && ((dev)->id.product == 0x0001))
 
 static unsigned short x86_keycodes[256] =
 	{ 0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, 15,
diff -Nru a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c	Thu Jul 29 14:41:12 2004
+++ b/drivers/input/keyboard/atkbd.c	Thu Jul 29 14:41:12 2004
@@ -47,6 +47,10 @@
 module_param_named(softrepeat, atkbd_softrepeat, bool, 0);
 MODULE_PARM_DESC(softrepeat, "Use software keyboard repeat");
 
+static int atkbd_softraw = 1;
+module_param_named(softraw, atkbd_softraw, bool, 0);
+MODULE_PARM_DESC(softraw, "Use software generated rawmode");
+
 static int atkbd_scroll;
 module_param_named(scroll, atkbd_scroll, bool, 0);
 MODULE_PARM_DESC(scroll, "Enable scroll-wheel on MS Office and similar keyboards");
@@ -336,6 +340,9 @@
 		code |= (atkbd->set != 3) ? 0x80 : 0x100;
 	}
 
+	if (atkbd->keycode[code] != ATKBD_KEY_NULL)
+		input_event(&atkbd->dev, EV_MSC, MSC_SCAN, code);
+
 	switch (atkbd->keycode[code]) {
 		case ATKBD_KEY_NULL:
 			break;
@@ -750,16 +757,21 @@
 			return;
 	}
 
+	if (!atkbd->write)
+		atkbd_softrepeat = 1;
+	if (atkbd_softrepeat)
+		atkbd_softraw = 1;
+
 	if (atkbd->write) {
 		atkbd->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_LED) | BIT(EV_REP) | BIT(EV_MSC);
 		atkbd->dev.ledbit[0] = BIT(LED_NUML) | BIT(LED_CAPSL) | BIT(LED_SCROLLL);
 	} else  atkbd->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_REP) | BIT(EV_MSC);
-	atkbd->dev.mscbit[0] = BIT(MSC_RAW);
+	atkbd->dev.mscbit[0] = atkbd_softraw ? BIT(MSC_SCAN) : BIT(MSC_RAW) | BIT(MSC_SCAN);
 
 	if (!atkbd_softrepeat) {
 		atkbd->dev.rep[REP_DELAY] = 250;
 		atkbd->dev.rep[REP_PERIOD] = 33;
-	}
+	} else atkbd_softraw = 1;
 
 	atkbd->serio = serio;
 
diff -Nru a/include/linux/input.h b/include/linux/input.h
--- a/include/linux/input.h	Thu Jul 29 14:41:12 2004
+++ b/include/linux/input.h	Thu Jul 29 14:41:12 2004
@@ -528,6 +528,7 @@
 #define MSC_PULSELED		0x01
 #define MSC_GESTURE		0x02
 #define MSC_RAW			0x03
+#define MSC_SCAN		0x04
 #define MSC_MAX			0x07
 
 /*

