Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262942AbTFGKkH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 06:40:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262963AbTFGKkH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 06:40:07 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:19589 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S262942AbTFGKkB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 06:40:01 -0400
Date: Sat, 7 Jun 2003 12:53:07 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Console blanking: blank on demand
Message-ID: <20030607105306.GA572@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

[I seen you did some changes to screen blanking...]

For pretty long time this is in my tree. It is pretty important for
small machines where display takes as much power as rest of system...

What about applying?
								Pavel

%patch
Index: linux/drivers/char/keyboard.c
===================================================================
--- linux.orig/drivers/char/keyboard.c	2003-05-27 13:56:47.000000000 +0200
+++ linux/drivers/char/keyboard.c	2003-05-27 13:50:00.000000000 +0200
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

%diffstat
 keyboard.c |   48 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 47 insertions(+), 1 deletion(-)


-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
