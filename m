Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263633AbTFGUdP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 16:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263637AbTFGUdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 16:33:15 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:57269 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S263633AbTFGUdE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 16:33:04 -0400
Date: Sat, 7 Jun 2003 22:45:23 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Console blanking: blank on demand
Message-ID: <20030607204522.GE273@elf.ucw.cz>
References: <20030607105306.GA572@elf.ucw.cz> <20030607125924.54cd5695.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030607125924.54cd5695.akpm@digeo.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > [I seen you did some changes to screen blanking...]
> > 
> > For pretty long time this is in my tree. It is pretty important for
> > small machines where display takes as much power as rest of system...
> > 
> > What about applying?
> 
> - What key is it using?

Whatever you map it to, but to map it you need (one-line) loadkeys support.

> - Is there somewhere under Documentation/ where the key should be
> documented?

I guess right approach is add patch to loadkeys adding BlankNow key,
then adding it to some obscure place in default keymap.

> - whitespace looks suspect.

Well, whitespace is wrong in kbd_init() [it uses 8 spaces, not a
tab]. I reindented it in this version...

> - The timer is left running across rmmod.

I do not think keyboard.c can be unloaded. There's
input_register_handler but no input_unregister_handler.

							Pavel

%patch
Index: linux/drivers/char/keyboard.c
===================================================================
--- linux.orig/drivers/char/keyboard.c	2003-06-01 20:12:16.000000000 +0200
+++ linux/drivers/char/keyboard.c	2003-06-07 22:14:22.000000000 +0200
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
+	   we do not want user's release of keys to unblank
+	   immediately. Even if we correctly guessed what is press and
+	   what is release, thinkpad's broken bios will turn on
+	   backlight for us... <pavel@ucw.cz> */
+	blank_now_timer.expires = jiffies + HZ;
+	add_timer(&blank_now_timer);
+}
+
 static void applkey(struct vc_data *vc, int key, char mode)
 {
 	static char buf[] = { 0x1b, 'O', 0x00, 0x00 };
@@ -1215,15 +1258,18 @@
 {
 	int i;
 
-        kbd0.ledflagstate = kbd0.default_ledflagstate = KBD_DEFLEDS;
-        kbd0.ledmode = LED_SHOW_FLAGS;
-        kbd0.lockstate = KBD_DEFLOCK;
-        kbd0.slockstate = 0;
-        kbd0.modeflags = KBD_DEFMODE;
-        kbd0.kbdmode = VC_XLATE;
+	init_timer(&blank_now_timer);
+	blank_now_timer.function = blank_now_do;
+
+	kbd0.ledflagstate = kbd0.default_ledflagstate = KBD_DEFLEDS;
+	kbd0.ledmode = LED_SHOW_FLAGS;
+	kbd0.lockstate = KBD_DEFLOCK;
+	kbd0.slockstate = 0;
+	kbd0.modeflags = KBD_DEFMODE;
+	kbd0.kbdmode = VC_XLATE;
 
-        for (i = 0 ; i < MAX_NR_CONSOLES ; i++)
-                kbd_table[i] = kbd0;
+	for (i = 0 ; i < MAX_NR_CONSOLES ; i++)
+		kbd_table[i] = kbd0;
 
 	input_register_handler(&kbd_handler);
 

%diffstat
 keyboard.c |   64 ++++++++++++++++++++++++++++++++++++++++++++++++++++---------
 1 files changed, 55 insertions(+), 9 deletions(-)




-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
