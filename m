Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272165AbTHRQCX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 12:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272169AbTHRQCX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 12:02:23 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:3792 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S272165AbTHRQBv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 12:01:51 -0400
Date: Mon, 18 Aug 2003 18:01:38 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Andries Brouwer <aebr@win.tue.nl>,
       linux-kernel@vger.kernel.org
Subject: Re: Input issues - key down with no key up
Message-ID: <20030818160138.GA31760@ucw.cz>
References: <16188.27810.50931.158166@gargle.gargle.HOWL> <20030815094604.B2784@pclin040.win.tue.nl> <20030815105802.GA14836@ucw.cz> <16188.54799.675256.608570@gargle.gargle.HOWL> <20030815135248.GA7315@win.tue.nl> <20030815141328.GA16176@ucw.cz> <16189.58357.516036.664166@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
In-Reply-To: <16189.58357.516036.664166@gargle.gargle.HOWL>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Aug 16, 2003 at 05:57:41PM +1000, Neil Brown wrote:
> On Friday August 15, vojtech@suse.cz wrote:
> > On Fri, Aug 15, 2003 at 03:52:48PM +0200, Andries Brouwer wrote:
> > > On Fri, Aug 15, 2003 at 10:46:07PM +1000, Neil Brown wrote:
> > > 
> > > > It seems to work (though some of the keys actually generate 'down'
> > > > events for both the down and up transitions, so it seems that the key
> > > > is pressed twice.
> > > 
> > > Maybe it really is as you say. But your description sounds fishy.
> > > It would be nice to know what really happens.
> > > (And it would be nice to know which scancodes are involved.)
> > 
> > Indeed. Neil, please enable DEBUG in i8042.c ... both with and without the
> > i8042_direct=1 and atkbd_set=3 options from my previous e-mail.
> > 
> > And for Andries, if you can, do the showkey -s test on 2.4, too ...
> 
> Well...
> 
> For my purposes, I need to use an "ioctl" to set a keycode for each
> scancode, so adding an ioctl to set the no-keyup status is no hassle
> for me.  However the suggest approach of auto-detecting keys which
> have no up event would probably a good idea.

How about this patch? It tries to be a bit clever, but hopefully not too
much ...

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR

--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="norelease.diff"

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1386, 2003-08-18 18:00:19+02:00, vojtech@suse.cz
  input: atkbd.c - First take on keys which systematically or randomly
  don't generate release.


 atkbd.c |  156 ++++++++++++++++++++++++++++++++++++----------------------------
 1 files changed, 90 insertions(+), 66 deletions(-)

===================================================================

diff -Nru a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c	Mon Aug 18 18:00:46 2003
+++ b/drivers/input/keyboard/atkbd.c	Mon Aug 18 18:00:46 2003
@@ -18,6 +18,7 @@
 #include <linux/input.h>
 #include <linux/serio.h>
 #include <linux/workqueue.h>
+#include <linux/timer.h>
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@suse.cz>");
 MODULE_DESCRIPTION("AT and PS/2 keyboard driver");
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
+					(test_bit(atkbd->keycode[code], &atkbd->dev.key)
+						? HZ/30 : HZ/4) + HZ/100);
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
@@ -322,6 +342,53 @@
 }
 
 /*
+ * atkbd_probe() probes for an AT keyboard on a serio port.
+ */
+
+static int atkbd_probe(struct atkbd *atkbd)
+{
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
+}
+
+/*
  * atkbd_set_3 checks if a keyboard has a working Set 3 support, and
  * sets it into that. Unfortunately there are keyboards that can be switched
  * to Set 3, but don't work well in that (BTC Multimedia ...)
@@ -355,75 +422,26 @@
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
-
-/*
- * Some systems, where the bit-twiddling when testing the io-lines of the
- * controller may confuse the keyboard need a full reset of the keyboard. On
- * these systems the BIOS also usually doesn't do it for us.
- */
-
-	if (atkbd_reset)
-		if (atkbd_command(atkbd, NULL, ATKBD_CMD_RESET_BAT)) 
-			printk(KERN_WARNING "atkbd.c: keyboard reset failed on %s\n", atkbd->serio->phys);
-
-/*
- * Then we check the keyboard ID. We should get 0xab83 under normal conditions.
- * Some keyboards report different values, but the first byte is always 0xab or
- * 0xac. Some old AT keyboards don't report anything.
- */
-
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
-		return -1;
-	atkbd->id = (param[0] << 8) | param[1];
+	unsigned char param[1];
 
 /*
  * Set the LEDs to a defined state.
@@ -434,21 +452,22 @@
 		return -1;
 
 /*
- * Disable autorepeat. We don't need it, as we do it in software anyway,
- * because that way can get faster repeat, and have less system load (less
- * accesses to the slow ISA hardware). If this fails, we don't care, and will
- * just ignore the repeated keys.
+ * Set autorepeat to fastest possible.
  */
 
-	atkbd_command(atkbd, NULL, ATKBD_CMD_SETALL_MB);
+	param[0] = 0;
+	if (atkbd_command(atkbd, param, ATKBD_CMD_SETREP))
+		return -1;
 
 /*
- * Last, we enable the keyboard to make sure  that we get keypresses from it.
+ * Enable the keyboard to receive keystrokes.
  */
 
-	if (atkbd_command(atkbd, NULL, ATKBD_CMD_ENABLE))
+	if (atkbd_command(atkbd, NULL, ATKBD_CMD_ENABLE)) {
 		printk(KERN_ERR "atkbd.c: Failed to enable keyboard on %s\n",
 			atkbd->serio->phys);
+		return -1;
+	}
 
 	return 0;
 }
@@ -517,6 +536,10 @@
 
 	serio->private = atkbd;
 
+	init_timer(&atkbd->timer);
+	atkbd->timer.data = (long) atkbd;
+	atkbd->timer.function = atkbd_force_key_up;
+
 	if (serio_open(serio, dev)) {
 		kfree(atkbd);
 		return;
@@ -531,6 +554,7 @@
 		}
 		
 		atkbd->set = atkbd_set_3(atkbd);
+		atkbd_enable(atkbd);
 
 	} else {
 		atkbd->set = 2;

--ReaqsoxgOBHFXBhH--
