Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280737AbRK2AND>; Wed, 28 Nov 2001 19:13:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282216AbRK2AMn>; Wed, 28 Nov 2001 19:12:43 -0500
Received: from www.transvirtual.com ([206.14.214.140]:38156 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S282212AbRK2AMe>; Wed, 28 Nov 2001 19:12:34 -0500
Date: Wed, 28 Nov 2001 16:12:23 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: [PATCH] vc_tty addition
Message-ID: <Pine.LNX.4.10.10111281608020.4098-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


These patches seem trival but they are very important for my new console
lock patch coming soon. Basically I have made the console lock more finer
grain. Each individual console is locked instead of all consoles when
printk is called. Their is no reason to block the serial console when say
the printk is currently writting to the VT console. This small patch is
the first step toward that. Also tusing vc_tty will be needed in
keyboard.c when it handles more than one keyboard.

diff -urN linux-2.5.0/drivers/char/console.c linux/drivers/char/console.c
--- linux-2.5.0/drivers/char/console.c	Tue Nov 27 11:56:43 2001
+++ linux/drivers/char/console.c	Wed Nov 28 16:24:54 2001
@@ -2377,6 +2377,7 @@
 
 	vt_cons[currcons]->vc_num = currcons;
 	tty->driver_data = vt_cons[currcons];
+	vc_cons[currcons].d->vc_tty = tty;
 
 	if (!tty->winsize.ws_row && !tty->winsize.ws_col) {
 		tty->winsize.ws_row = video_num_lines;
diff -urN linux-2.5.0/drivers/char/keyboard.c linux/drivers/char/keyboard.c
--- linux-2.5.0/drivers/char/keyboard.c	Tue Nov 27 11:56:43 2001
+++ linux/drivers/char/keyboard.c	Wed Nov 28 16:30:31 2001
@@ -36,6 +36,7 @@
 #include <asm/keyboard.h>
 #include <asm/bitops.h>
 
+#include <linux/console_struct.h>
 #include <linux/kbd_kern.h>
 #include <linux/kbd_diacr.h>
 #include <linux/vt_kern.h>
@@ -98,7 +99,6 @@
 static unsigned char diacr;
 static char rep;			/* flag telling character repeat */
 struct kbd_struct kbd_table[MAX_NR_CONSOLES];
-static struct tty_struct **ttytab;
 static struct kbd_struct * kbd = kbd_table;
 static struct tty_struct * tty;
 
@@ -207,7 +207,8 @@
 	pm_access(pm_kbd);
 	add_keyboard_randomness(scancode | up_flag);
 
-	tty = ttytab? ttytab[fg_console]: NULL;
+	tty = vc_cons[fg_console].d->vc_tty;
+
 	if (tty && (!tty->driver_data)) {
 		/*
 		 * We touch the tty structure via the ttytab array
@@ -919,7 +920,6 @@
 {
 	int i;
 	struct kbd_struct kbd0;
-	extern struct tty_driver console_driver;
 
 	kbd0.ledflagstate = kbd0.default_ledflagstate = KBD_DEFLEDS;
 	kbd0.ledmode = LED_SHOW_FLAGS;
@@ -930,8 +930,6 @@
  
 	for (i = 0 ; i < MAX_NR_CONSOLES ; i++)
 		kbd_table[i] = kbd0;
-
-	ttytab = console_driver.table;
 
 	kbd_init_hw();
 
diff -urN linux-2.5.0/include/linux/console_struct.h linux/include/linux/console_struct.h
--- linux-2.5.0/include/linux/console_struct.h	Tue Nov 27 11:56:33 2001
+++ linux/include/linux/console_struct.h	Wed Nov 28 16:21:51 2001
@@ -33,6 +33,7 @@
 	unsigned int	vc_top, vc_bottom;	/* Scrolling region */
 	unsigned int	vc_state;		/* Escape sequence parser state */
 	unsigned int	vc_npar,vc_par[NPAR];	/* Parameters of current escape sequence */
+	struct tty_struct *vc_tty;		/* TTY we are attached to */
 	unsigned long	vc_origin;		/* [!] Start of real screen */
 	unsigned long	vc_scr_end;		/* [!] End of real screen */
 	unsigned long	vc_visible_origin;	/* [!] Top of visible window */

