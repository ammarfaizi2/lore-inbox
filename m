Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272777AbTG3GO6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 02:14:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272779AbTG3GO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 02:14:58 -0400
Received: from codepoet.org ([166.70.99.138]:29852 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id S272777AbTG3GOx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 02:14:53 -0400
Date: Wed, 30 Jul 2003 00:14:55 -0600
From: Erik Andersen <andersen@codepoet.org>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Turning off automatic screen clanking
Message-ID: <20030730061454.GA19808@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	"Richard B. Johnson" <root@chaos.analogic.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here ya go...  This rips out the screen blanking code by the
roots since the kind and gentle approach didn't seem to be what
you were looking for.  :-)

--- linux/drivers/char/console.c.orig
+++ linux/drivers/char/console.c
@@ -144,7 +144,6 @@
 static int con_open(struct tty_struct *, struct file *);
 static void vc_init(unsigned int console, unsigned int rows,
 		    unsigned int cols, int do_clear);
-static void blank_screen(unsigned long dummy);
 static void gotoxy(int currcons, int new_x, int new_y);
 static void save_cur(int currcons);
 static void reset_terminal(int currcons, int do_clear);
@@ -152,7 +151,6 @@
 static void set_vesa_blanking(unsigned long arg);
 static void set_cursor(int currcons);
 static void hide_cursor(int currcons);
-static void unblank_screen_t(unsigned long dummy);
 static void console_callback(void *ignored);
 
 static int printable;		/* Is console ready for printing? */
@@ -205,8 +203,6 @@
  */
 int (*console_blank_hook)(int);
 
-static struct timer_list console_timer;
-
 /*
  *	Low-Level Functions
  */
@@ -2488,12 +2484,6 @@
 	if (tty_register_driver(&console_driver))
 		panic("Couldn't register console driver\n");
 
-	init_timer(&console_timer);
-	console_timer.function = blank_screen;
-	if (blankinterval) {
-		mod_timer(&console_timer, jiffies + blankinterval);
-	}
-
 	/*
 	 * kmalloc is not running yet - we use the bootmem allocator.
 	 */
@@ -2629,39 +2619,6 @@
 				    console_driver.minor_start + i);
 }
 
-/*
- * This is called by a timer handler
- */
-static void vesa_powerdown(void)
-{
-    struct vc_data *c = vc_cons[fg_console].d;
-    /*
-     *  Power down if currently suspended (1 or 2),
-     *  suspend if currently blanked (0),
-     *  else do nothing (i.e. already powered down (3)).
-     *  Called only if powerdown features are allowed.
-     */
-    switch (vesa_blank_mode) {
-	case VESA_NO_BLANKING:
-	    c->vc_sw->con_blank(c, VESA_VSYNC_SUSPEND+1);
-	    break;
-	case VESA_VSYNC_SUSPEND:
-	case VESA_HSYNC_SUSPEND:
-	    c->vc_sw->con_blank(c, VESA_POWERDOWN+1);
-	    break;
-    }
-}
-
-/*
- * This is a timer handler
- */
-static void vesa_powerdown_screen(unsigned long dummy)
-{
-	console_timer.function = unblank_screen_t;
-
-	vesa_powerdown();
-}
-
 static void timer_do_blank_screen(int entering_gfx, int from_timer_handler)
 {
 	int currcons = fg_console;
@@ -2687,17 +2644,6 @@
 	}
 
 	hide_cursor(currcons);
-	if (!from_timer_handler)
-		del_timer_sync(&console_timer);
-	if (vesa_off_interval) {
-		console_timer.function = vesa_powerdown_screen;
-		mod_timer(&console_timer, jiffies + vesa_off_interval);
-	} else {
-		if (!from_timer_handler)
-			del_timer_sync(&console_timer);
-		console_timer.function = unblank_screen_t;
-	}
-
 	save_screen(currcons);
 	/* In case we need to reset origin, blanking hook returns 1 */
 	i = sw->con_blank(vc_cons[currcons].d, 1);
@@ -2717,14 +2663,6 @@
 }
 
 /*
- * This is a timer handler
- */
-static void unblank_screen_t(unsigned long dummy)
-{
-	unblank_screen();
-}
-
-/*
  * Called by timer as well as from vt_console_driver
  */
 void unblank_screen(void)
@@ -2742,11 +2680,6 @@
 	if (vcmode != KD_TEXT)
 		return; /* but leave console_blanked != 0 */
 
-	console_timer.function = blank_screen;
-	if (blankinterval) {
-		mod_timer(&console_timer, jiffies + blankinterval);
-	}
-
 	console_blanked = 0;
 	if (console_blank_hook)
 		console_blank_hook(0);
@@ -2757,25 +2690,10 @@
 	set_cursor(fg_console);
 }
 
-/*
- * This is both a user-level callable and a timer handler
- */
-static void blank_screen(unsigned long dummy)
-{
-	timer_do_blank_screen(0, 1);
-}
-
 void poke_blanked_console(void)
 {
-	del_timer(&console_timer);
 	if (!vt_cons[fg_console] || vt_cons[fg_console]->vc_mode == KD_GRAPHICS)
 		return;
-	if (console_blanked) {
-		console_timer.function = unblank_screen_t;
-		mod_timer(&console_timer, jiffies);	/* Now */
-	} else if (blankinterval) {
-		mod_timer(&console_timer, jiffies + blankinterval);
-	}
 }
 
 /*
@@ -3001,7 +2919,7 @@
 		unblank_screen();
 		break;
 	case PM_SUSPEND:
-		do_blank_screen(0);
+		unblank_screen();
 		break;
 	}
 	return 0;

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
