Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262105AbTIWR1y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 13:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262127AbTIWR1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 13:27:53 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:4235 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S262105AbTIWR1N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 13:27:13 -0400
Date: Tue, 23 Sep 2003 19:26:58 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: John Bradford <john@grabjohn.com>, ndiamond@wta.att.ne.jp, vojtech@suse.cz,
       linux-kernel@vger.kernel.org
Subject: Re: Translated set 3
Message-ID: <20030923172658.GA8713@ucw.cz>
References: <200309221242.h8MCgtMf000302@81-2-122-30.bradfords.org.uk> <20030922222527.B1064@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
In-Reply-To: <20030922222527.B1064@pclin040.win.tue.nl>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 22, 2003 at 10:25:27PM +0200, Andries Brouwer wrote:

> > Why not simplify the whole problem, and either have:
> > 
> > * translated set 2 with workarounds for all known strange keyboards
> > * untranslated set 3
> 
> Yes, you need untranslated set 3, everybody else on i386 needs
> translated set 2.
> 
> (Other architectures do not do any translation and probably need
> untranslated set 2.)
> 
> (Very rarely, one sees untranslated set 1 on i386.)
> 
> Let us wait and see what Vojtech creates.

How about this? Warning: COMPLETELY UNTESTED. But it should give you an
idea where I'm heading to.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR

--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=keyboard-x

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1376, 2003-09-23 19:24:41+02:00, vojtech@suse.cz
  input: Change AT keyboard to use hardware autorepeat and move
         untranslating to the AT keyboard driver as well. Lower
         PS/2 mouse default report rate. Fix repeat rate adjustment
         ioctls accordingly, and update other files to reflect the
         changes.


 drivers/char/keyboard.c            |   14 +--
 drivers/input/evdev.c              |   10 --
 drivers/input/input.c              |   32 +++++---
 drivers/input/keyboard/atkbd.c     |  143 ++++++++++++++++++++++++-------------
 drivers/input/mouse/psmouse-base.c |   25 ++++--
 drivers/input/serio/i8042.c        |   51 +------------
 include/linux/input.h              |    2 
 include/linux/serio.h              |    1 
 8 files changed, 146 insertions(+), 132 deletions(-)

===================================================================

diff -Nru a/drivers/char/keyboard.c b/drivers/char/keyboard.c
--- a/drivers/char/keyboard.c	Tue Sep 23 19:25:23 2003
+++ b/drivers/char/keyboard.c	Tue Sep 23 19:25:23 2003
@@ -264,12 +264,6 @@
 /*
  * Setting the keyboard rate.
  */
-static inline unsigned int ms_to_jiffies(unsigned int ms) {
-	unsigned int j;
-
-	j = (ms * HZ + 500) / 1000;
-	return (j > 0) ? j : 1;
-}
 
 int kbd_rate(struct kbd_repeat *rep)
 {
@@ -283,11 +277,11 @@
 
 		if (test_bit(EV_REP, dev->evbit)) {
 			if (rep->delay > 0)
-				dev->rep[REP_DELAY] = ms_to_jiffies(rep->delay);
+				input_event(dev, EV_REP, REP_DELAY, rep->delay);
 			if (rep->period > 0)
-				dev->rep[REP_PERIOD] = ms_to_jiffies(rep->period);
-			d = dev->rep[REP_DELAY]  * 1000 / HZ;
-			p = dev->rep[REP_PERIOD] * 1000 / HZ;
+				input_event(dev, EV_REP, REP_PERIOD, rep->period);
+			d = dev->rep[REP_DELAY];
+			p = dev->rep[REP_PERIOD];
 		}
 	}
 	rep->delay  = d;
diff -Nru a/drivers/input/evdev.c b/drivers/input/evdev.c
--- a/drivers/input/evdev.c	Tue Sep 23 19:25:23 2003
+++ b/drivers/input/evdev.c	Tue Sep 23 19:25:23 2003
@@ -220,16 +220,6 @@
 		case EVIOCGID:
 			return copy_to_user((void *) arg, &dev->id, sizeof(struct input_id)) ? -EFAULT : 0;
 		
-		case EVIOCGREP:
-			if (put_user(dev->rep[0], ((int *) arg) + 0)) return -EFAULT;
-			if (put_user(dev->rep[1], ((int *) arg) + 1)) return -EFAULT;
-			return 0;
-
-		case EVIOCSREP:
-			if (get_user(dev->rep[0], ((int *) arg) + 0)) return -EFAULT;
-			if (get_user(dev->rep[1], ((int *) arg) + 1)) return -EFAULT;
-			return 0;
-
 		case EVIOCGKEYCODE:
 			if (get_user(t, ((int *) arg) + 0)) return -EFAULT;
 			if (t < 0 || t > dev->keycodemax || !dev->keycodesize) return -EINVAL;
diff -Nru a/drivers/input/input.c b/drivers/input/input.c
--- a/drivers/input/input.c	Tue Sep 23 19:25:23 2003
+++ b/drivers/input/input.c	Tue Sep 23 19:25:23 2003
@@ -55,6 +55,13 @@
 static int input_devices_state;
 #endif
 
+static inline unsigned int ms_to_jiffies(unsigned int ms)
+{
+        unsigned int j;
+        j = (ms * HZ + 500) / 1000;
+        return (j > 0) ? j : 1;
+}
+
 
 void input_event(struct input_dev *dev, unsigned int type, unsigned int code, int value)
 {
@@ -93,9 +100,9 @@
 
 			change_bit(code, dev->key);
 
-			if (test_bit(EV_REP, dev->evbit) && dev->rep[REP_PERIOD] && value) {
+			if (test_bit(EV_REP, dev->evbit) && dev->rep[REP_PERIOD] && dev->timer.data && value) {
 				dev->repeat_key = code;
-				mod_timer(&dev->timer, jiffies + dev->rep[REP_DELAY]);
+				mod_timer(&dev->timer, jiffies + ms_to_jiffies(dev->rep[REP_DELAY]));
 			}
 
 			break;
@@ -162,7 +169,7 @@
 
 		case EV_REP:
 
-			if (code > REP_MAX || dev->rep[code] == value) return;
+			if (code > REP_MAX || value < 0 || dev->rep[code] == value) return;
 
 			dev->rep[code] = value;
 			if (dev->event) dev->event(dev, type, code, value);
@@ -195,7 +202,7 @@
 	input_event(dev, EV_KEY, dev->repeat_key, 2);
 	input_sync(dev);
 
-	mod_timer(&dev->timer, jiffies + dev->rep[REP_PERIOD]);
+	mod_timer(&dev->timer, jiffies + ms_to_jiffies(dev->rep[REP_PERIOD]));
 }
 
 int input_accept_process(struct input_handle *handle, struct file *file)
@@ -423,13 +430,18 @@
 
 	set_bit(EV_SYN, dev->evbit);
 
+	/*
+	 * If delay and period are pre-set by the driver, then autorepeating
+	 * is handled by the driver itself and we don't do it in input.c.
+	 */
+
 	init_timer(&dev->timer);
-	dev->timer.data = (long) dev;
-	dev->timer.function = input_repeat_key;
-	if (!dev->rep[REP_DELAY])
-		dev->rep[REP_DELAY] = HZ/4;
-	if (!dev->rep[REP_PERIOD])
-		dev->rep[REP_PERIOD] = HZ/33;
+	if (!dev->rep[REP_DELAY] && !dev->rep[REP_PERIOD]) {
+		dev->timer.data = (long) dev;
+		dev->timer.function = input_repeat_key;
+		dev->rep[REP_DELAY] = 250;
+		dev->rep[REP_PERIOD] = 33;
+	}
 
 	INIT_LIST_HEAD(&dev->h_list);
 	list_add_tail(&dev->node, &input_dev_list);
diff -Nru a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c	Tue Sep 23 19:25:23 2003
+++ b/drivers/input/keyboard/atkbd.c	Tue Sep 23 19:25:23 2003
@@ -10,6 +10,13 @@
  * the Free Software Foundation.
  */
 
+/*
+ * This driver can handle standard AT keyboards and PS/2 keyboards in
+ * Translated and Raw Set 2 and Set 3, as well as AT keyboards on dumb
+ * input-only controllers and AT keyboards connected over a one way RS232
+ * converter.
+ */
+
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/slab.h>
@@ -47,14 +54,14 @@
 	122, 89, 40,120, 26, 13,  0,  0, 58, 54, 28, 27,  0, 43,  0,  0,
 	 85, 86, 90, 91, 92, 93, 14, 94, 95, 79,183, 75, 71,121,  0,123,
 	 82, 83, 80, 76, 77, 72,  1, 69, 87, 78, 81, 74, 55, 73, 70, 99,
-	252,  0,  0, 65, 99,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
+	  0,  0,  0, 65, 99,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
+	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
 	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
-	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,251,  0,  0,  0,  0,  0,
 	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
 	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
 	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
-	252,253,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
-	254,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,255,
+	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
+	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,255,
 	  0,  0, 92, 90, 85,  0,137,  0,  0,  0,  0, 91, 89,144,115,  0,
 	217,100,255,  0, 97,165,164,  0,156,  0,  0,140,115,  0,  0,125,
 	173,114,  0,113,152,163,151,126,128,166,  0,140,  0,147,  0,127,
@@ -76,12 +83,23 @@
 	 82, 83, 80, 76, 77, 72, 69, 98,  0, 96, 81,  0, 78, 73, 55, 85,
 	 89, 90, 91, 92, 74,185,184,182,  0,  0,  0,125,126,127,112,  0,
 	  0,139,150,163,165,115,152,150,166,140,160,154,113,114,167,168,
-	148,149,147,140,  0,  0,  0,  0,  0,  0,251,  0,  0,  0,  0,  0,
+	148,149,147,140,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
+	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
 	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
 	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
 	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
-	252,253,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
-	254,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,255
+	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,255
+};
+
+static unsigned char atkbd_unxlate_table[128] = {
+	  0,118, 22, 30, 38, 37, 46, 54, 61, 62, 70, 69, 78, 85,102, 13,
+	 21, 29, 36, 45, 44, 53, 60, 67, 68, 77, 84, 91, 90, 20, 28, 27,
+	 35, 43, 52, 51, 59, 66, 75, 76, 82, 14, 18, 93, 26, 34, 33, 42,
+	 50, 49, 58, 65, 73, 74, 89,124, 17, 41, 88,  5,  6,  4, 12,  3,
+	 11,  2, 10,  1,  9,119,126,108,117,125,123,107,115,116,121,105,
+	114,122,112,113,127, 96, 97,120,  7, 15, 23, 31, 39, 47, 55, 63,
+	 71, 79, 86, 94,  8, 16, 24, 32, 40, 48, 56, 64, 72, 80, 87,111,
+	 19, 25, 57, 81, 83, 92, 95, 98, 99,100,101,103,104,106,109,110
 };
 
 #define ATKBD_CMD_SETLEDS	0x10ed
@@ -99,12 +117,13 @@
 
 #define ATKBD_RET_ACK		0xfa
 #define ATKBD_RET_NAK		0xfe
+#define ATKBD_RET_BAT		0xaa
+#define ATKBD_RET_EMUL0		0xe0
+#define ATKBD_RET_EMULX		0x80
+#define ATKBD_RET_EMUL1		0xe1
+#define ATKBD_RET_RELEASE	0xf0
 
 #define ATKBD_KEY_UNKNOWN	  0
-#define ATKBD_KEY_BAT		251
-#define ATKBD_KEY_EMUL0		252
-#define ATKBD_KEY_EMUL1		253
-#define ATKBD_KEY_RELEASE	254
 #define ATKBD_KEY_NULL		255
 
 /*
@@ -127,6 +146,7 @@
 	unsigned char emul;
 	unsigned short id;
 	unsigned char write;
+	unsigned char translated;
 	unsigned char resend;
 };
 
@@ -166,22 +186,40 @@
 			goto out;
 	}
 
+	if (atkbd->translated)
+		switch (code) {
+			case ATKBD_RET_BAT:
+			case ATKBD_RET_EMUL0:
+			case ATKBD_RET_EMUL1:
+				break;
+			default:
+				if (code < 0x80) {
+					code = atkbd_unxlate_table[code];
+					break;
+				}
+				if (atkbd->cmdcnt)
+					break;
+				code = atkbd_unxlate_table[code & 0x7f];
+				atkbd->release = 1;
+				break;
+		}
+
 	if (atkbd->cmdcnt) {
 		atkbd->cmdbuf[--atkbd->cmdcnt] = code;
 		goto out;
 	}
 
-	switch (atkbd->keycode[code]) {
-		case ATKBD_KEY_BAT:
+	switch (code) {
+		case ATKBD_RET_BAT:
 			serio_rescan(atkbd->serio);
 			goto out;
-		case ATKBD_KEY_EMUL0:
+		case ATKBD_RET_EMUL0:
 			atkbd->emul = 1;
 			goto out;
-		case ATKBD_KEY_EMUL1:
+		case ATKBD_RET_EMUL1:
 			atkbd->emul = 2;
 			goto out;
-		case ATKBD_KEY_RELEASE:
+		case ATKBD_RET_RELEASE:
 			atkbd->release = 1;
 			goto out;
 	}
@@ -196,21 +234,15 @@
 		case ATKBD_KEY_NULL:
 			break;
 		case ATKBD_KEY_UNKNOWN:
-			printk(KERN_WARNING "atkbd.c: Unknown key (set %d, scancode %#x, on %s) %s.\n",
-				atkbd->set, code, serio->phys, atkbd->release ? "released" : "pressed");
+			printk(KERN_WARNING "atkbd.c: Unknown key %s (%s set %d, code %#x, data %#x, on %s).\n",
+				atkbd->release ? "released" : "pressed",
+				atkbd->translated ? "translated" : "raw", 
+				atkbd->set, code, data, serio->phys);
 			break;
 		default:
-#if 0
-			if (!atkbd->release) {
-				mod_timer(&atkbd->timer,
-					jiffies + (test_bit(atkbd->keycode[code],
-						atkbd->dev.key) ? HZ/33 : HZ/4) + HZ/100);
-				atkbd->lastkey = atkbd->keycode[code];
-			}
-#endif
-
 			input_regs(&atkbd->dev, regs);
-			input_report_key(&atkbd->dev, atkbd->keycode[code], !atkbd->release);
+			input_event(&atkbd->dev, EV_KEY, atkbd->keycode[code], 
+				atkbd->release ? 0 : (!!test_bit(code, atkbd->dev.keybit) + 1));
 			input_sync(&atkbd->dev);
 	}
 
@@ -219,13 +251,6 @@
 	return IRQ_HANDLED;
 }
 
-static void atkbd_force_key_up(unsigned long data)
-{
-	struct atkbd *atkbd = (void *) data;
-	input_report_key(&atkbd->dev, atkbd->lastkey, 0);
-	input_sync(&atkbd->dev);
-}
-
 /*
  * atkbd_sendbyte() sends a byte to the keyboard, and waits for
  * acknowledge. It doesn't handle resends according to the keyboard
@@ -312,7 +337,12 @@
 static int atkbd_event(struct input_dev *dev, unsigned int type, unsigned int code, int value)
 {
 	struct atkbd *atkbd = dev->private;
+	struct { int p; u8 v; } period[] =	
+		{ {30, 0x00}, {25, 0x02}, {20, 0x04}, {15, 0x08}, {10, 0x0c}, {7, 0x10}, {5, 0x14}, {0, 0x14} };
+	struct { int d; u8 v; } delay[] =
+        	{ {1000, 0x60}, {750, 0x40}, {500, 0x20}, {250, 0x00}, {0, 0x00} };
 	char param[2];
+	int i, j;
 
 	if (!atkbd->write)
 		return -1;
@@ -337,6 +367,19 @@
 			}
 
 			return 0;
+
+
+		case EV_REP:
+
+			i = j = 0;
+			while (period[i].p > dev->rep[REP_PERIOD]) i++;
+			while (delay[j].d > dev->rep[REP_DELAY]) j++;
+			dev->rep[REP_PERIOD] = period[i].p;
+			dev->rep[REP_DELAY] = delay[j].d;
+			param[0] = period[i].v | delay[j].v;
+			atkbd_command(atkbd, param, ATKBD_CMD_SETREP);
+
+			return 0;
 	}
 
 	return -1;
@@ -508,25 +551,33 @@
 	struct atkbd *atkbd;
 	int i;
 
-	if ((serio->type & SERIO_TYPE) != SERIO_8042 &&
-		(((serio->type & SERIO_TYPE) != SERIO_RS232) || (serio->type & SERIO_PROTO) != SERIO_PS2SER))
-		        return;
-
 	if (!(atkbd = kmalloc(sizeof(struct atkbd), GFP_KERNEL)))
 		return;
-
 	memset(atkbd, 0, sizeof(struct atkbd));
 
-	if ((serio->type & SERIO_TYPE) == SERIO_8042 && serio->write)
-		atkbd->write = 1;
+	switch (serio->type & SERIO_TYPE) {
 
+		case SERIO_8042_XL: 
+			atkbd->translated = 1;
+		case SERIO_8042:
+			if (serio->write)
+				atkbd->write = 1;
+			break;
+		case SERIO_RS232:
+			if ((serio->type & SERIO_PROTO) == SERIO_PS2SER)
+				break;
+		default:
+			kfree(atkbd);
+			return;
+	}
+			
 	if (atkbd->write) {
 		atkbd->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_LED) | BIT(EV_REP);
 		atkbd->dev.ledbit[0] = BIT(LED_NUML) | BIT(LED_CAPSL) | BIT(LED_SCROLLL);
 	} else  atkbd->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_REP);
 
-	atkbd->dev.rep[REP_DELAY] = HZ/4 + HZ/50;
-	atkbd->dev.rep[REP_PERIOD] = HZ/33;
+	atkbd->dev.rep[REP_DELAY] = 250;
+	atkbd->dev.rep[REP_PERIOD] = 33;
 
 	atkbd->serio = serio;
 
@@ -539,10 +590,6 @@
 	atkbd->dev.private = atkbd;
 
 	serio->private = atkbd;
-
-	init_timer(&atkbd->timer);
-	atkbd->timer.data = (long) atkbd;
-	atkbd->timer.function = atkbd_force_key_up;
 
 	if (serio_open(serio, dev)) {
 		kfree(atkbd);
diff -Nru a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
--- a/drivers/input/mouse/psmouse-base.c	Tue Sep 23 19:25:22 2003
+++ b/drivers/input/mouse/psmouse-base.c	Tue Sep 23 19:25:22 2003
@@ -28,6 +28,8 @@
 MODULE_PARM_DESC(psmouse_noext, "Disable any protocol extensions. Useful for KVM switches.");
 MODULE_PARM(psmouse_resolution, "i");
 MODULE_PARM_DESC(psmouse_resolution, "Resolution, in dpi.");
+MODULE_PARM(psmouse_rate, "i");
+MODULE_PARM_DESC(psmouse_rate, "Report rate, in reports per second.");
 MODULE_PARM(psmouse_smartscroll, "i");
 MODULE_PARM_DESC(psmouse_smartscroll, "Logitech Smartscroll autorepeat, 1 = enabled (default), 0 = disabled.");
 MODULE_PARM(psmouse_resetafter, "i");
@@ -38,6 +40,7 @@
 
 static int psmouse_noext;
 int psmouse_resolution;
+unsigned int psmouse_rate = 60;
 int psmouse_smartscroll = PSMOUSE_LOGITECH_SMARTSCROLL;
 unsigned int psmouse_resetafter;
 
@@ -443,22 +446,32 @@
 }
 
 /*
+ * Here we set the mouse report rate.
+ */
+
+static void psmouse_set_rate(struct psmouse *psmouse)
+{
+	unsigned char rates[] = { 200, 100, 80, 60, 40, 20, 10, 0 };
+	int i = 0;
+
+	while (rates[i] > psmouse_rate) i++;
+	psmouse_command(psmouse, rates + i, PSMOUSE_CMD_SETRATE);
+}
+
+/*
  * psmouse_initialize() initializes the mouse to a sane state.
  */
 
 static void psmouse_initialize(struct psmouse *psmouse)
 {
 	unsigned char param[2];
+	
 
 /*
- * We set the mouse report rate to a highest possible value.
- * We try 100 first in case mouse fails to set 200.
+ * We set the mouse report rate.
  */
-	param[0] = 100;
-	psmouse_command(psmouse, param, PSMOUSE_CMD_SETRATE);
 
-	param[0] = 200;
-	psmouse_command(psmouse, param, PSMOUSE_CMD_SETRATE);
+	psmouse_set_rate(psmouse);
 
 /*
  * We also set the resolution and scaling.
diff -Nru a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
--- a/drivers/input/serio/i8042.c	Tue Sep 23 19:25:22 2003
+++ b/drivers/input/serio/i8042.c	Tue Sep 23 19:25:22 2003
@@ -58,8 +58,6 @@
 static struct serio i8042_aux_port;
 static unsigned char i8042_initial_ctr;
 static unsigned char i8042_ctr;
-static unsigned char i8042_last_e0;
-static unsigned char i8042_last_release;
 static unsigned char i8042_mux_open;
 struct timer_list i8042_timer;
 
@@ -69,18 +67,6 @@
  */
 #define i8042_request_irq_cookie (&i8042_timer)
 
-static unsigned long i8042_unxlate_seen[256 / BITS_PER_LONG];
-static unsigned char i8042_unxlate_table[128] = {
-	  0,118, 22, 30, 38, 37, 46, 54, 61, 62, 70, 69, 78, 85,102, 13,
-	 21, 29, 36, 45, 44, 53, 60, 67, 68, 77, 84, 91, 90, 20, 28, 27,
-	 35, 43, 52, 51, 59, 66, 75, 76, 82, 14, 18, 93, 26, 34, 33, 42,
-	 50, 49, 58, 65, 73, 74, 89,124, 17, 41, 88,  5,  6,  4, 12,  3,
-	 11,  2, 10,  1,  9,119,126,108,117,125,123,107,115,116,121,105,
-	114,122,112,113,127, 96, 97,120,  7, 15, 23, 31, 39, 47, 55, 63,
-	 71, 79, 86, 94,  8, 16, 24, 32, 40, 48, 56, 64, 72, 80, 87,111,
-	 19, 25, 57, 81, 83, 92, 95, 98, 99,100,101,103,104,106,109,110
-};
-
 static irqreturn_t i8042_interrupt(int irq, void *dev_id, struct pt_regs *regs);
 
 /*
@@ -301,7 +287,7 @@
 
 static struct serio i8042_kbd_port =
 {
-	.type =		SERIO_8042,
+	.type =		SERIO_8042_XL,
 	.write =	i8042_kbd_write,
 	.open =		i8042_open,
 	.close =	i8042_close,
@@ -400,39 +386,10 @@
 		if (!i8042_kbd_values.exists)
 			continue;
 
-		if (i8042_direct) {
-			serio_interrupt(&i8042_kbd_port, data, dfl, regs);
-			continue;
-		}
-
-		if (data > 0x7f) {
-			unsigned char index = (data & 0x7f) | (i8042_last_e0 << 7);
-			/* work around hardware that doubles key releases */
-			if (index == i8042_last_release) {
-				dbg("i8042 skipped double release (%d)\n", index);
-				i8042_last_e0 = 0;
-				continue;
-			}
-			if (index == 0xaa || index == 0xb6)
-				set_bit(index, i8042_unxlate_seen);
-			if (test_and_clear_bit(index, i8042_unxlate_seen)) {
-				serio_interrupt(&i8042_kbd_port, 0xf0, dfl, regs);
-				data = i8042_unxlate_table[data & 0x7f];
-				i8042_last_release = index;
-			}
-		} else {
-			set_bit(data | (i8042_last_e0 << 7), i8042_unxlate_seen);
-			data = i8042_unxlate_table[data];
-			i8042_last_release = 0;
-		}
-
-		i8042_last_e0 = (data == 0xe0);
-
 		serio_interrupt(&i8042_kbd_port, data, dfl, regs);
 	}
 
-	/* FIXME - was it really ours? */
-	return IRQ_HANDLED;
+	return IRQ_RETVAL(j);
 }
 
 /*
@@ -511,8 +468,10 @@
  * BIOSes.
  */
 
-	if (i8042_direct)
+	if (i8042_direct) {
 		i8042_ctr &= ~I8042_CTR_XLATE;
+		i8042_kbd_port.type = SERIO_8042;
+	}
 
 /*
  * Write CTR back.
diff -Nru a/include/linux/input.h b/include/linux/input.h
--- a/include/linux/input.h	Tue Sep 23 19:25:23 2003
+++ b/include/linux/input.h	Tue Sep 23 19:25:23 2003
@@ -56,8 +56,6 @@
 
 #define EVIOCGVERSION		_IOR('E', 0x01, int)			/* get driver version */
 #define EVIOCGID		_IOR('E', 0x02, struct input_id)	/* get device ID */
-#define EVIOCGREP		_IOR('E', 0x03, int[2])			/* get repeat settings */
-#define EVIOCSREP		_IOW('E', 0x03, int[2])			/* get repeat settings */
 #define EVIOCGKEYCODE		_IOR('E', 0x04, int[2])			/* get keycode */
 #define EVIOCSKEYCODE		_IOW('E', 0x04, int[2])			/* set keycode */
 
diff -Nru a/include/linux/serio.h b/include/linux/serio.h
--- a/include/linux/serio.h	Tue Sep 23 19:25:23 2003
+++ b/include/linux/serio.h	Tue Sep 23 19:25:23 2003
@@ -107,6 +107,7 @@
 #define SERIO_HIL_MLC	0x03000000UL
 #define SERIO_PC9800	0x04000000UL
 #define SERIO_PS_PSTHRU	0x05000000UL
+#define SERIO_8042_XL	0x06000000UL
 
 #define SERIO_PROTO	0xFFUL
 #define SERIO_MSC	0x01

--UugvWAfsgieZRqgk--
