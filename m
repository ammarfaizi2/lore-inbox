Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262812AbTCRWLy>; Tue, 18 Mar 2003 17:11:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262815AbTCRWLx>; Tue, 18 Mar 2003 17:11:53 -0500
Received: from [195.39.17.254] ([195.39.17.254]:3076 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S262812AbTCRWLw>;
	Tue, 18 Mar 2003 17:11:52 -0500
Date: Tue, 18 Mar 2003 21:32:22 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>, vojtech@ucw.cz
Subject: Blank-screen-on-demand
Message-ID: <20030318203222.GA165@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This allows user to blank screen on demand. On some machines (philips
velo) backlight takes more energy than rest of system, and this
becomes pretty critical.

Vojtech, are you right person for this? If so please apply. [wow, that
patch is 6 years old ;-)]
								Pavel

Index: linux-quilt/drivers/char/keyboard.c
--- .pc/misc/drivers/char/keyboard.c	2003-03-18 18:34:12.000000000 +0100
+++ a/drivers/char/keyboard.c	2003-03-16 18:51:05.000000000 +0100
@@ -20,6 +20,7 @@
  * parts by Geert Uytterhoeven, May 1997
  *
  * 27-05-97: Added support for the Magic SysRq Key (Martin Mares)
+ * 29-07-97: Added blank console key (Pavel Machek)
  * 30-07-98: Dead keys redone, aeb@cwi.nl.
  * 21-08-02: Converted to input API, major cleanup. (Vojtech Pavlik)
  */
@@ -86,7 +87,8 @@
 	fn_show_state,	fn_send_intr, 	fn_lastcons, 	fn_caps_toggle,\
 	fn_num,		fn_hold, 	fn_scroll_forw,	fn_scroll_back,\
 	fn_boot_it, 	fn_caps_on, 	fn_compose,	fn_SAK,\
-	fn_dec_console, fn_inc_console, fn_spawn_con, 	fn_bare_num
+	fn_dec_console, fn_inc_console, fn_spawn_con, 	fn_bare_num, \
+	fn_blank_now
 
 typedef void (fn_handler_fn)(struct vc_data *vc, struct pt_regs *regs);
 static fn_handler_fn FN_HANDLERS;
@@ -320,6 +322,25 @@
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
+static void fn_blank_now(struct vc_data *vc, struct pt_regs *regs)
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
@@ -1215,6 +1258,9 @@
 {
 	int i;
 
+	init_timer(&blank_now_timer);
+	blank_now_timer.function = blank_now_do;
+
         kbd0.ledflagstate = kbd0.default_ledflagstate = KBD_DEFLEDS;
         kbd0.ledmode = LED_SHOW_FLAGS;
         kbd0.lockstate = KBD_DEFLOCK;

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
