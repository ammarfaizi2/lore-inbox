Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261528AbTISK2b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 06:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbTISK1z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 06:27:55 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:20110 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S261488AbTISK0y convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 06:26:54 -0400
Subject: [PATCH 2/11] input: Forced release of keys on AT kbds
In-Reply-To: <10639672004187@twilight.ucw.cz>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Fri, 19 Sep 2003 12:26:41 +0200
Message-Id: <10639672011605@twilight.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1340, 2003-09-19 00:58:34-07:00, vojtech@suse.cz
  input.c:
    input: Don't set autorepeat times in core if already set by driver.
  atkbd.c:
    input: Automatic forced release of keys if keyrelease gets lost


 input.c          |    6 +
 keyboard/atkbd.c |  173 ++++++++++++++++++++++++++++++-------------------------
 2 files changed, 99 insertions(+), 80 deletions(-)

===================================================================

diff -Nru a/drivers/input/input.c b/drivers/input/input.c
--- a/drivers/input/input.c	Fri Sep 19 12:16:46 2003
+++ b/drivers/input/input.c	Fri Sep 19 12:16:46 2003
@@ -426,8 +426,10 @@
 	init_timer(&dev->timer);
 	dev->timer.data = (long) dev;
 	dev->timer.function = input_repeat_key;
-	dev->rep[REP_DELAY] = HZ/4;
-	dev->rep[REP_PERIOD] = HZ/33;
+	if (!dev->rep[REP_DELAY])
+		dev->rep[REP_DELAY] = HZ/4;
+	if (!dev->rep[REP_PERIOD])
+		dev->rep[REP_PERIOD] = HZ/33;
 
 	INIT_LIST_HEAD(&dev->h_list);
 	list_add_tail(&dev->node, &input_dev_list);
diff -Nru a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c	Fri Sep 19 12:16:46 2003
+++ b/drivers/input/keyboard/atkbd.c	Fri Sep 19 12:16:46 2003
@@ -18,6 +18,7 @@
 #include <linux/input.h>
 #include <linux/serio.h>
 #include <linux/workqueue.h>
+#include <linux/timer.h>
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@suse.cz>");
 MODULE_DESCRIPTION("AT and PS/2 keyboard driver");
@@ -40,8 +41,8 @@
 static unsigned char atkbd_set2_keycode[512] = {
 	  0, 67, 65, 63, 61, 59, 60, 88,  0, 68, 66, 64, 62, 15, 41, 85,
 	  0, 56, 42,182, 29, 16,  2, 89,  0,  0, 44, 31, 30, 17,  3, 90,
-	  0, 46, 45, 32, 18,  5,  4, 91,  0, 57, 47, 33, 20, 19,  6,  0,
-	  0, 49, 48, 35, 34, 21,  7,  0,  0,  0, 50, 36, 22,  8,  9,  0,
+	  0, 46, 45, 32, 18,  5,  4, 91, 90, 57, 47, 33, 20, 19,  6,  0,
+	 91, 49, 48, 35, 34, 21,  7,  0,  0,  0, 50, 36, 22,  8,  9,  0,
 	  0, 51, 37, 23, 24, 11, 10,  0,  0, 52, 53, 38, 39, 25, 12,  0,
 	122, 89, 40,120, 26, 13,  0,  0, 58, 54, 28, 27,  0, 43,  0,  0,
 	 85, 86, 90, 91, 92, 93, 14, 94, 95, 79,183, 75, 71,121,  0,123,
@@ -87,10 +88,10 @@
 #define ATKBD_CMD_GSCANSET	0x11f0
 #define ATKBD_CMD_SSCANSET	0x10f0
 #define ATKBD_CMD_GETID		0x02f2
+#define ATKBD_CMD_SETREP	0x10f3
 #define ATKBD_CMD_ENABLE	0x00f4
 #define ATKBD_CMD_RESET_DIS	0x00f5
 #define ATKBD_CMD_RESET_BAT	0x02ff
-#define ATKBD_CMD_SETALL_MB	0x00f8
 #define ATKBD_CMD_RESEND	0x00fe
 #define ATKBD_CMD_EX_ENABLE	0x10ea
 #define ATKBD_CMD_EX_SETLEDS	0x20eb
@@ -114,12 +115,14 @@
 	unsigned char keycode[512];
 	struct input_dev dev;
 	struct serio *serio;
+	struct timer_list timer;
 	char name[64];
 	char phys[32];
 	unsigned char cmdbuf[4];
 	unsigned char cmdcnt;
 	unsigned char set;
 	unsigned char release;
+	int lastkey;
 	volatile signed char ack;
 	unsigned char emul;
 	unsigned short id;
@@ -142,6 +145,7 @@
 	printk(KERN_DEBUG "atkbd.c: Received %02x flags %02x\n", data, flags);
 #endif
 
+#if !defined(__i386__) && !defined (__x86_64__)
 	if ((flags & (SERIO_FRAME | SERIO_PARITY)) && (~flags & SERIO_TIMEOUT) && !atkbd->resend && atkbd->write) {
 		printk("atkbd.c: frame/parity error: %02x\n", flags);
 		serio_write(serio, ATKBD_CMD_RESEND);
@@ -151,6 +155,7 @@
 	
 	if (!flags)
 		atkbd->resend = 0;
+#endif
 
 	switch (code) {
 		case ATKBD_RET_ACK:
@@ -195,6 +200,14 @@
 				atkbd->set, code, serio->phys, atkbd->release ? "released" : "pressed");
 			break;
 		default:
+
+			if (!atkbd->release) {
+				mod_timer(&atkbd->timer,
+					jiffies + (test_bit(atkbd->keycode[code],
+						&atkbd->dev.key) ? HZ/33 : HZ/4) + HZ/100);
+				atkbd->lastkey = atkbd->keycode[code];
+			}
+
 			input_regs(&atkbd->dev, regs);
 			input_report_key(&atkbd->dev, atkbd->keycode[code], !atkbd->release);
 			input_sync(&atkbd->dev);
@@ -205,6 +218,13 @@
 	return IRQ_HANDLED;
 }
 
+static void atkbd_force_key_up(unsigned long data)
+{
+	struct atkbd *atkbd = (void *) data;
+	input_report_key(&atkbd->dev, atkbd->lastkey, 0);
+	input_sync(&atkbd->dev);
+}
+
 /*
  * atkbd_sendbyte() sends a byte to the keyboard, and waits for
  * acknowledge. It doesn't handle resends according to the keyboard
@@ -214,7 +234,7 @@
 
 static int atkbd_sendbyte(struct atkbd *atkbd, unsigned char byte)
 {
-	int timeout = 10000; /* 100 msec */
+	int timeout = 20000; /* 200 msec */
 	atkbd->ack = 0;
 
 #ifdef ATKBD_DEBUG
@@ -322,13 +342,50 @@
 }
 
 /*
- * Enable keyboard.
+ * atkbd_probe() probes for an AT keyboard on a serio port.
  */
-static void atkbd_enable(struct atkbd *atkbd)
+
+static int atkbd_probe(struct atkbd *atkbd)
 {
-	if (atkbd_command(atkbd, NULL, ATKBD_CMD_ENABLE))
-		printk(KERN_ERR "atkbd.c: Failed to enable keyboard on %s\n",
-		       atkbd->serio->phys);
+	unsigned char param[2];
+
+/*
+ * Some systems, where the bit-twiddling when testing the io-lines of the
+ * controller may confuse the keyboard need a full reset of the keyboard. On
+ * these systems the BIOS also usually doesn't do it for us.
+ */
+
+	if (atkbd_reset)
+		if (atkbd_command(atkbd, NULL, ATKBD_CMD_RESET_BAT)) 
+			printk(KERN_WARNING "atkbd.c: keyboard reset failed on %s\n", atkbd->serio->phys);
+
+/*
+ * Then we check the keyboard ID. We should get 0xab83 under normal conditions.
+ * Some keyboards report different values, but the first byte is always 0xab or
+ * 0xac. Some old AT keyboards don't report anything. If a mouse is connected, this
+ * should make sure we don't try to set the LEDs on it.
+ */
+
+	if (atkbd_command(atkbd, param, ATKBD_CMD_GETID)) {
+
+/*
+ * If the get ID command failed, we check if we can at least set the LEDs on
+ * the keyboard. This should work on every keyboard out there. It also turns
+ * the LEDs off, which we want anyway.
+ */
+		param[0] = 0;
+		if (atkbd_command(atkbd, param, ATKBD_CMD_SETLEDS))
+			return -1;
+		atkbd->id = 0xabba;
+		return 0;
+	}
+
+	if (param[0] != 0xab && param[0] != 0xac)
+		return -1;
+	atkbd->id = (param[0] << 8) | param[1];
+
+
+	return 0;
 }
 
 /*
@@ -365,103 +422,57 @@
 			return 4;
 	}
 
-/*
- * Try to set the set we want.
- */
+	if (atkbd_set != 3) 
+		return 2;
 
-	param[0] = atkbd_set;
+	param[0] = 3;
 	if (atkbd_command(atkbd, param, ATKBD_CMD_SSCANSET))
 		return 2;
 
-/*
- * Read set number. Beware here. Some keyboards always send '2'
- * or some other number regardless into what mode they have been
- * attempted to be set. Other keyboards treat the '0' command as
- * 'set to set 0', and not 'report current set' as they should.
- * In that case we time out, and return 2.
- */
-
 	param[0] = 0;
 	if (atkbd_command(atkbd, param, ATKBD_CMD_GSCANSET))
 		return 2;
 
-/*
- * Here we return the set number the keyboard reports about
- * itself.
- */
+	if (param[0] != 3)
+		return 2;
 
-	return (param[0] == 3) ? 3 : 2;
+	return 3;
 }
 
-/*
- * atkbd_probe() probes for an AT keyboard on a serio port.
- */
-
-static int atkbd_probe(struct atkbd *atkbd)
+static int atkbd_enable(struct atkbd *atkbd)
 {
-	unsigned char param[2];
+	unsigned char param[1];
 
 /*
- * Some systems, where the bit-twiddling when testing the io-lines of the
- * controller may confuse the keyboard need a full reset of the keyboard. On
- * these systems the BIOS also usually doesn't do it for us.
+ * Set the LEDs to a defined state.
  */
 
-	if (atkbd_reset)
-		if (atkbd_command(atkbd, NULL, ATKBD_CMD_RESET_BAT)) 
-			printk(KERN_WARNING
-			       "atkbd.c: keyboard reset failed on %s\n",
-			       atkbd->serio->phys);
+	param[0] = 0;
+	if (atkbd_command(atkbd, param, ATKBD_CMD_SETLEDS))
+		return -1;
 
 /*
- * Then we check the keyboard ID. We should get 0xab83 under normal conditions.
- * Some keyboards report different values, but the first byte is always 0xab or
- * 0xac. Some old AT keyboards don't report anything.
+ * Set autorepeat to fastest possible.
  */
 
-	if (atkbd_command(atkbd, param, ATKBD_CMD_GETID)) {
-
-/*
- * If the get ID command failed, we check if we can at least set the LEDs on
- * the keyboard. This should work on every keyboard out there. It also turns
- * the LEDs off, which we want anyway.
- */
-		param[0] = 0;
-		if (atkbd_command(atkbd, param, ATKBD_CMD_SETLEDS))
-			return -1;
-		atkbd->id = 0xabba;
-		return 0;
-	}
-
-	if (param[0] != 0xab && param[0] != 0xac)
+	param[0] = 0;
+	if (atkbd_command(atkbd, param, ATKBD_CMD_SETREP))
 		return -1;
-	atkbd->id = (param[0] << 8) | param[1];
 
 /*
- * Set the LEDs to a defined state.
+ * Enable the keyboard to receive keystrokes.
  */
 
-	param[0] = 0;
-	if (atkbd_command(atkbd, param, ATKBD_CMD_SETLEDS))
+	if (atkbd_command(atkbd, NULL, ATKBD_CMD_ENABLE)) {
+		printk(KERN_ERR "atkbd.c: Failed to enable keyboard on %s\n",
+			atkbd->serio->phys);
 		return -1;
+	}
 
 	return 0;
 }
 
 /*
- * Disable autorepeat. We don't need it, as we do it in software anyway,
- * because that way can get faster repeat, and have less system load (less
- * accesses to the slow ISA hardware). If this fails, we don't care, and will
- * just ignore the repeated keys.
- *
- * This command is for scancode set 3 only.
- */
-static void atkbd_disable_autorepeat(struct atkbd *atkbd)
-{
-	atkbd_command(atkbd, NULL, ATKBD_CMD_SETALL_MB);
-}
-
-/*
  * atkbd_cleanup() restores the keyboard state so that BIOS is happy after a
  * reboot.
  */
@@ -485,7 +496,7 @@
 }
 
 /*
- * atkbd_connect() is called when the serio module finds an interface
+ * atkbd_connect() is called when the serio module finds and interface
  * that isn't handled yet by an appropriate device driver. We check if
  * there is an AT keyboard out there and if yes, we register ourselves
  * to the input module.
@@ -513,6 +524,9 @@
 		atkbd->dev.ledbit[0] = BIT(LED_NUML) | BIT(LED_CAPSL) | BIT(LED_SCROLLL);
 	} else  atkbd->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_REP);
 
+	atkbd->dev.rep[REP_DELAY] = HZ/4 + HZ/50;
+	atkbd->dev.rep[REP_PERIOD] = HZ/33;
+
 	atkbd->serio = serio;
 
 	init_input_dev(&atkbd->dev);
@@ -525,6 +539,10 @@
 
 	serio->private = atkbd;
 
+	init_timer(&atkbd->timer);
+	atkbd->timer.data = (long) atkbd;
+	atkbd->timer.function = atkbd_force_key_up;
+
 	if (serio_open(serio, dev)) {
 		kfree(atkbd);
 		return;
@@ -539,9 +557,8 @@
 		}
 		
 		atkbd->set = atkbd_set_3(atkbd);
-		if (atkbd->set == 3)
-			atkbd_disable_autorepeat(atkbd);
 		atkbd_enable(atkbd);
+
 	} else {
 		atkbd->set = 2;
 		atkbd->id = 0xab00;

