Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319064AbSH1WO7>; Wed, 28 Aug 2002 18:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319033AbSH1WO7>; Wed, 28 Aug 2002 18:14:59 -0400
Received: from [195.39.17.254] ([195.39.17.254]:11136 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S319064AbSH1WO5>;
	Wed, 28 Aug 2002 18:14:57 -0400
Date: Thu, 29 Aug 2002 00:16:45 +0200
From: Pavel Machek <pavel@ucw.cz>
To: vojtech@ucw.cz, kernel list <linux-kernel@vger.kernel.org>
Subject: Blank now key
Message-ID: <20020828221644.GA30122@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Being able to "blank now" is very important for handheld devices
(where screen can eat more than 50% of total power), and it is just
nice everywhere else (also saves a little power). Please apply.

								Pavel

--- clean/drivers/char/keyboard.c	Wed Aug 28 22:38:44 2002
+++ linux/drivers/char/keyboard.c	Wed Aug 28 23:03:43 2002
@@ -20,6 +20,7 @@
  * parts by Geert Uytterhoeven, May 1997
  *
  * 27-05-97: Added support for the Magic SysRq Key (Martin Mares)
+ * 29-07-97: Added blank console key (Pavel Machek)
  * 30-07-98: Dead keys redone, aeb@cwi.nl.
  * 21-08-02: Converted to input API, major cleanup. (Vojtech Pavlik)
  */
@@ -88,7 +89,8 @@
 	fn_show_state,	fn_send_intr, 	fn_lastcons, 	fn_caps_toggle,\
 	fn_num,		fn_hold, 	fn_scroll_forw,	fn_scroll_back,\
 	fn_boot_it, 	fn_caps_on, 	fn_compose,	fn_SAK,\
-	fn_dec_console, fn_inc_console, fn_spawn_con, 	fn_bare_num
+	fn_dec_console, fn_inc_console, fn_spawn_con, 	fn_bare_num, \
+	fn_blank_now
 
 typedef void (fn_handler_fn)(struct vc_data *vc);
 static fn_handler_fn FN_HANDLERS;
@@ -310,6 +312,25 @@
 	con_schedule_flip(tty);
 }
 
+static void blank_now_do(unsigned long unused)
+{
+	do_poke_blanked_console = 0;
+	do_blank_screen(0);
+}
+
+static struct timer_list blank_now_timer;
+
+static void fn_blank_now(struct vc_data *vc)
+{
+	/* You ask why we have our own timer here? Well, it is because
+           we do not want user's release of keys to unblank
+           immediately. Even if we correctly guessed what is press and
+           what is release, thinkpad's broken bios will turn on
+           backlight for us... <pavel@ucw.cz> */
+	blank_now_timer.expires = jiffies + HZ;
+	add_timer(&blank_now_timer);
+}
+
 static void applkey(struct vc_data *vc, int key, char mode)
 {
 	static char buf[] = { 0x1b, 'O', 0x00, 0x00 };
@@ -1169,6 +1209,9 @@
 int __init kbd_init(void)
 {
 	int i;
+
+	init_timer(&blank_now_timer);
+	blank_now_timer.function = blank_now_do;
 
         kbd0.ledflagstate = kbd0.default_ledflagstate = KBD_DEFLEDS;
         kbd0.ledmode = LED_SHOW_FLAGS;

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
