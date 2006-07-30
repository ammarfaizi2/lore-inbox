Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932360AbWG3Qka@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932360AbWG3Qka (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 12:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932366AbWG3Qka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 12:40:30 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:4144 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932360AbWG3Qk2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 12:40:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=AFNh7swEIvM5w5nEhFwuXXh0P1ujMXtPqP+wZE/nH9RP5Tm9E2Pxk5S/qu/JUXxW1WnZOBx4hfZngwEsaw4rY+t0LWBMEyxvktAyxF9mzkCU2pNeDDl5DOzW/ENXNqQSgyZOkV58OuMrdCSMuVOtxxKDgVR5WT4vjjU49tInivk=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 08/12] making the kernel -Wshadow clean - fix keyboard.c
Date: Sun, 30 Jul 2006 18:41:32 +0200
User-Agent: KMail/1.9.3
References: <200607301830.01659.jesper.juhl@gmail.com>
In-Reply-To: <200607301830.01659.jesper.juhl@gmail.com>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607301841.32727.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix -Wshadow warnings in drivers/char/keyboard.c


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 drivers/char/keyboard.c |   58 +++++++++++++++++++-------------------
 1 files changed, 29 insertions(+), 29 deletions(-)

--- linux-2.6.18-rc2-orig/drivers/char/keyboard.c	2006-07-18 18:46:22.000000000 +0200
+++ linux-2.6.18-rc2/drivers/char/keyboard.c	2006-07-18 23:34:53.000000000 +0200
@@ -266,7 +266,7 @@ void kd_mksound(unsigned int hz, unsigne
  * Setting the keyboard rate.
  */
 
-int kbd_rate(struct kbd_repeat *rep)
+int kbd_rate(struct kbd_repeat *repeat)
 {
 	struct list_head *node;
 	unsigned int d = 0;
@@ -277,16 +277,16 @@ int kbd_rate(struct kbd_repeat *rep)
 		struct input_dev *dev = handle->dev;
 
 		if (test_bit(EV_REP, dev->evbit)) {
-			if (rep->delay > 0)
-				input_event(dev, EV_REP, REP_DELAY, rep->delay);
-			if (rep->period > 0)
-				input_event(dev, EV_REP, REP_PERIOD, rep->period);
+			if (repeat->delay > 0)
+				input_event(dev, EV_REP, REP_DELAY, repeat->delay);
+			if (repeat->period > 0)
+				input_event(dev, EV_REP, REP_PERIOD, repeat->period);
 			d = dev->rep[REP_DELAY];
 			p = dev->rep[REP_PERIOD];
 		}
 	}
-	rep->delay  = d;
-	rep->period = p;
+	repeat->delay  = d;
+	repeat->period = p;
 	return 0;
 }
 
@@ -944,28 +944,28 @@ unsigned char getledstate(void)
 	return ledstate;
 }
 
-void setledstate(struct kbd_struct *kbd, unsigned int led)
+void setledstate(struct kbd_struct *kbrd, unsigned int led)
 {
 	if (!(led & ~7)) {
 		ledioctl = led;
-		kbd->ledmode = LED_SHOW_IOCTL;
+		kbrd->ledmode = LED_SHOW_IOCTL;
 	} else
-		kbd->ledmode = LED_SHOW_FLAGS;
+		kbrd->ledmode = LED_SHOW_FLAGS;
 	set_leds();
 }
 
 static inline unsigned char getleds(void)
 {
-	struct kbd_struct *kbd = kbd_table + fg_console;
+	struct kbd_struct *kbrd = kbd_table + fg_console;
 	unsigned char leds;
 	int i;
 
-	if (kbd->ledmode == LED_SHOW_IOCTL)
+	if (kbrd->ledmode == LED_SHOW_IOCTL)
 		return ledioctl;
 
-	leds = kbd->ledflagstate;
+	leds = kbrd->ledflagstate;
 
-	if (kbd->ledmode == LED_SHOW_MEM) {
+	if (kbrd->ledmode == LED_SHOW_MEM) {
 		for (i = 0; i < 3; i++)
 			if (ledptrs[i].valid) {
 				if (*ledptrs[i].addr & ledptrs[i].mask)
@@ -1126,7 +1126,7 @@ static void kbd_rawcode(unsigned char da
 		put_queue(vc, data);
 }
 
-static void kbd_keycode(unsigned int keycode, int down,
+static void kbd_keycode(unsigned int keycode, int down_key,
 			int hw_raw, struct pt_regs *regs)
 {
 	struct vc_data *vc = vc_cons[fg_console].d;
@@ -1145,35 +1145,35 @@ static void kbd_keycode(unsigned int key
 	kbd = kbd_table + fg_console;
 
 	if (keycode == KEY_LEFTALT || keycode == KEY_RIGHTALT)
-		sysrq_alt = down ? keycode : 0;
+		sysrq_alt = down_key ? keycode : 0;
 #ifdef CONFIG_SPARC
 	if (keycode == KEY_STOP)
-		sparc_l1_a_state = down;
+		sparc_l1_a_state = down_key;
 #endif
 
-	rep = (down == 2);
+	rep = (down_key == 2);
 
 #ifdef CONFIG_MAC_EMUMOUSEBTN
-	if (mac_hid_mouse_emulate_buttons(1, keycode, down))
+	if (mac_hid_mouse_emulate_buttons(1, keycode, down_key))
 		return;
 #endif /* CONFIG_MAC_EMUMOUSEBTN */
 
 	if ((raw_mode = (kbd->kbdmode == VC_RAW)) && !hw_raw)
-		if (emulate_raw(vc, keycode, !down << 7))
+		if (emulate_raw(vc, keycode, !down_key << 7))
 			if (keycode < BTN_MISC)
 				printk(KERN_WARNING "keyboard.c: can't emulate rawmode for keycode %d\n", keycode);
 
 #ifdef CONFIG_MAGIC_SYSRQ	       /* Handle the SysRq Hack */
-	if (keycode == KEY_SYSRQ && (sysrq_down || (down == 1 && sysrq_alt))) {
+	if (keycode == KEY_SYSRQ && (sysrq_down || (down_key == 1 && sysrq_alt))) {
 		if (!sysrq_down) {
-			sysrq_down = down;
+			sysrq_down = down_key;
 			sysrq_alt_use = sysrq_alt;
 		}
 		return;
 	}
-	if (sysrq_down && !down && keycode == sysrq_alt_use)
+	if (sysrq_down && !down_key && keycode == sysrq_alt_use)
 		sysrq_down = 0;
-	if (sysrq_down && down && !rep) {
+	if (sysrq_down && down_key && !rep) {
 		handle_sysrq(kbd_sysrq_xlate[keycode], regs, tty);
 		return;
 	}
@@ -1196,16 +1196,16 @@ static void kbd_keycode(unsigned int key
 		 * which should be enough.
 		 */
 		if (keycode < 128) {
-			put_queue(vc, keycode | (!down << 7));
+			put_queue(vc, keycode | (!down_key << 7));
 		} else {
-			put_queue(vc, !down << 7);
+			put_queue(vc, !down_key << 7);
 			put_queue(vc, (keycode >> 7) | 0x80);
 			put_queue(vc, keycode | 0x80);
 		}
 		raw_mode = 1;
 	}
 
-	if (down)
+	if (down_key)
 		set_bit(keycode, key_down);
 	else
 		clear_bit(keycode, key_down);
@@ -1241,7 +1241,7 @@ static void kbd_keycode(unsigned int key
 	type = KTYP(keysym);
 
 	if (type < 0xf0) {
-		if (down && !raw_mode)
+		if (down_key && !raw_mode)
 			to_utf8(vc, keysym);
 		return;
 	}
@@ -1260,7 +1260,7 @@ static void kbd_keycode(unsigned int key
 		}
 	}
 
-	(*k_handler[type])(vc, keysym & 0xff, !down, regs);
+	(*k_handler[type])(vc, keysym & 0xff, !down_key, regs);
 
 	if (type != KT_SLOCK)
 		kbd->slockstate = 0;



