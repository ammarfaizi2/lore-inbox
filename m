Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751404AbWGJLQd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404AbWGJLQd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 07:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbWGJLPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 07:15:52 -0400
Received: from fitch2.uni2.net ([130.227.52.102]:47580 "EHLO fitch2.uni2.net")
	by vger.kernel.org with ESMTP id S1751353AbWGJLPf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 07:15:35 -0400
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 9/9] -Wshadow: fixes for drivers/char/keyboard.c
Date: Mon, 10 Jul 2006 13:13:42 +0200
User-Agent: KMail/1.8.2
Cc: jesper.juhl@gmail.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607101313.42962.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(please see the mail titled 
 "[RFC][PATCH 0/9] -Wshadow: Making the kernel build clean with -Wshadow"
 for an explanation of why I'm doing this)


Fix -Wshadow warnings in drivers/char/keyboard.c :

 drivers/char/keyboard.c:269: warning: declaration of 'rep' shadows a global declaration
 drivers/char/keyboard.c:130: warning: shadowed declaration is here
 drivers/char/keyboard.c:947: warning: declaration of 'kbd' shadows a global declaration
 drivers/char/keyboard.c:109: warning: shadowed declaration is here
 drivers/char/keyboard.c:959: warning: declaration of 'kbd' shadows a global declaration
 drivers/char/keyboard.c:109: warning: shadowed declaration is here
 drivers/char/keyboard.c:1129: warning: declaration of 'down' shadows a global declaration


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 drivers/char/keyboard.c |   58 +++++++++++++++++++-------------------
 1 files changed, 29 insertions(+), 29 deletions(-)

--- linux-2.6.18-rc1-orig/drivers/char/keyboard.c	2006-07-06 19:39:35.000000000 +0200
+++ linux-2.6.18-rc1/drivers/char/keyboard.c	2006-07-09 22:04:35.000000000 +0200
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
+static void kbd_keycode(unsigned int keycode, int _down,
 			int hw_raw, struct pt_regs *regs)
 {
 	struct vc_data *vc = vc_cons[fg_console].d;
@@ -1145,35 +1145,35 @@ static void kbd_keycode(unsigned int key
 	kbd = kbd_table + fg_console;
 
 	if (keycode == KEY_LEFTALT || keycode == KEY_RIGHTALT)
-		sysrq_alt = down ? keycode : 0;
+		sysrq_alt = _down ? keycode : 0;
 #ifdef CONFIG_SPARC
 	if (keycode == KEY_STOP)
-		sparc_l1_a_state = down;
+		sparc_l1_a_state = _down;
 #endif
 
-	rep = (down == 2);
+	rep = (_down == 2);
 
 #ifdef CONFIG_MAC_EMUMOUSEBTN
-	if (mac_hid_mouse_emulate_buttons(1, keycode, down))
+	if (mac_hid_mouse_emulate_buttons(1, keycode, _down))
 		return;
 #endif /* CONFIG_MAC_EMUMOUSEBTN */
 
 	if ((raw_mode = (kbd->kbdmode == VC_RAW)) && !hw_raw)
-		if (emulate_raw(vc, keycode, !down << 7))
+		if (emulate_raw(vc, keycode, !_down << 7))
 			if (keycode < BTN_MISC)
 				printk(KERN_WARNING "keyboard.c: can't emulate rawmode for keycode %d\n", keycode);
 
 #ifdef CONFIG_MAGIC_SYSRQ	       /* Handle the SysRq Hack */
-	if (keycode == KEY_SYSRQ && (sysrq_down || (down == 1 && sysrq_alt))) {
+	if (keycode == KEY_SYSRQ && (sysrq_down || (_down == 1 && sysrq_alt))) {
 		if (!sysrq_down) {
-			sysrq_down = down;
+			sysrq_down = _down;
 			sysrq_alt_use = sysrq_alt;
 		}
 		return;
 	}
-	if (sysrq_down && !down && keycode == sysrq_alt_use)
+	if (sysrq_down && !_down && keycode == sysrq_alt_use)
 		sysrq_down = 0;
-	if (sysrq_down && down && !rep) {
+	if (sysrq_down && _down && !rep) {
 		handle_sysrq(kbd_sysrq_xlate[keycode], regs, tty);
 		return;
 	}
@@ -1196,16 +1196,16 @@ static void kbd_keycode(unsigned int key
 		 * which should be enough.
 		 */
 		if (keycode < 128) {
-			put_queue(vc, keycode | (!down << 7));
+			put_queue(vc, keycode | (!_down << 7));
 		} else {
-			put_queue(vc, !down << 7);
+			put_queue(vc, !_down << 7);
 			put_queue(vc, (keycode >> 7) | 0x80);
 			put_queue(vc, keycode | 0x80);
 		}
 		raw_mode = 1;
 	}
 
-	if (down)
+	if (_down)
 		set_bit(keycode, key_down);
 	else
 		clear_bit(keycode, key_down);
@@ -1241,7 +1241,7 @@ static void kbd_keycode(unsigned int key
 	type = KTYP(keysym);
 
 	if (type < 0xf0) {
-		if (down && !raw_mode)
+		if (_down && !raw_mode)
 			to_utf8(vc, keysym);
 		return;
 	}
@@ -1260,7 +1260,7 @@ static void kbd_keycode(unsigned int key
 		}
 	}
 
-	(*k_handler[type])(vc, keysym & 0xff, !down, regs);
+	(*k_handler[type])(vc, keysym & 0xff, !_down, regs);
 
 	if (type != KT_SLOCK)
 		kbd->slockstate = 0;




