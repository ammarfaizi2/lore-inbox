Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264414AbRFOOXN>; Fri, 15 Jun 2001 10:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264416AbRFOOXD>; Fri, 15 Jun 2001 10:23:03 -0400
Received: from devco.net ([196.15.188.2]:9856 "EHLO rinoa")
	by vger.kernel.org with ESMTP id <S264414AbRFOOWu>;
	Fri, 15 Jun 2001 10:22:50 -0400
Date: Fri, 15 Jun 2001 16:22:49 +0200
From: Leon Breedt <ljb@devco.net>
To: linux-kernel@vger.kernel.org
Subject: [patch] nonblinking VGA block cursor
Message-ID: <20010615162249.A1328@rinoa.rinoa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Attached is a patch to enforce a non-blinking, FreeBSD-syscons like
block cursor in console mode.

This is useful for laptop types, or people like me who really really
detest a blinking cursor.

NOTE: It disables the softcursor escape codes 
      (/usr/src/linux/Documentation/VGA-softcursor.txt), since I don't 
      ever want anything to change my cursor shape/style :)

It applies cleanly against 2.4.5, to use, select: 

'VGA block cursor (non-blinking) support' in the 'Console drivers'
section of menuconfig.

Have fun,

Leon.

-- 
lj breedt
coder

--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="noblink-2.4.5.diff"

diff -uNr linux-2.4.5/arch/i386/config.in linux-2.4.5.nonblink/arch/i386/config.in
--- linux-2.4.5/arch/i386/config.in	Fri May 25 00:14:08 2001
+++ linux-2.4.5.nonblink/arch/i386/config.in	Fri Jun 15 16:03:32 2001
@@ -356,6 +356,9 @@
    mainmenu_option next_comment
    comment 'Console drivers'
    bool 'VGA text console' CONFIG_VGA_CONSOLE
+   if [ "$CONFIG_VGA_CONSOLE" = "y" ]; then
+      bool 'VGA block cursor (non-blinking) support' CONFIG_NON_BLINK_CURSOR
+   fi
    bool 'Video mode selection support' CONFIG_VIDEO_SELECT
    if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
       tristate 'MDA text console (dual-headed) (EXPERIMENTAL)' CONFIG_MDA_CONSOLE
diff -uNr linux-2.4.5/drivers/char/console.c linux-2.4.5.nonblink/drivers/char/console.c
--- linux-2.4.5/drivers/char/console.c	Fri Feb  9 21:30:22 2001
+++ linux-2.4.5.nonblink/drivers/char/console.c	Fri Jun 15 15:47:58 2001
@@ -124,6 +124,11 @@
 #define DEFAULT_BELL_PITCH	750
 #define DEFAULT_BELL_DURATION	(HZ/8)
 
+/* 
+ * cursor_type value for non-blinking white block cursor
+ */
+#define CUR_NONBLINK 16748305
+
 extern void vcs_make_devfs (unsigned int index, int unregister);
 
 #ifndef MIN
@@ -1403,7 +1408,12 @@
 	kbd_table[currcons].ledflagstate = kbd_table[currcons].default_ledflagstate;
 	set_leds();
 
+#ifdef CONFIG_NON_BLINK_CURSOR
+	cursor_type = CUR_NONBLINK;
+#else
 	cursor_type = CUR_DEFAULT;
+#endif
+
 	complement_mask = s_complement_mask;
 
 	default_attr(currcons);
@@ -1595,6 +1605,7 @@
 			set_mode(currcons,0);
 			return;
 		case 'c':
+#ifndef CONFIG_NON_BLINK_CURSOR
 			if (ques) {
 				if (par[0])
 					cursor_type = par[0] | (par[1]<<8) | (par[2]<<16);
@@ -1602,6 +1613,7 @@
 					cursor_type = CUR_DEFAULT;
 				return;
 			}
+#endif
 			break;
 		case 'm':
 			if (ques) {
@@ -2445,6 +2457,9 @@
 	save_screen(currcons);
 	gotoxy(currcons,x,y);
 	csi_J(currcons, 0);
+#ifdef CONFIG_NON_BLINK_CURSOR
+	cursor_type = CUR_NONBLINK;
+#endif
 	update_screen(fg_console);
 	printk("Console: %s %s %dx%d",
 		can_do_color ? "colour" : "mono",

--8t9RHnE3ZwKMSgU+--
