Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264192AbTFHGkp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 02:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264219AbTFHGkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 02:40:45 -0400
Received: from dixville.unh.edu ([132.177.137.38]:65433 "EHLO dixville.unh.edu")
	by vger.kernel.org with ESMTP id S264192AbTFHGkj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 02:40:39 -0400
Date: Sun, 8 Jun 2003 02:54:10 -0400
From: Samuel Thibault <Samuel.Thibault@ens-lyon.fr>
To: linux-kernel@vger.kernel.org
Cc: akpm@digeo.com, dave@mielke.cc
Subject: tioclinux() numbers in <linux/tiocl.h> ?
Message-ID: <20030608065410.GB1407@bouh.unh.edu>
Reply-To: Samuel Thibault <samuel.thibault@fnac.net>
Mail-Followup-To: Samuel Thibault <Samuel.Thibault@ens-lyon.fr>,
	linux-kernel@vger.kernel.org, akpm@digeo.com, dave@mielke.cc
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i-nntp
X-MailScanner-Information: http://pubpages.unh.edu/notes/mailfiltering.html
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-5.9, required 5,
	BAYES_20, PATCH_UNIFIED_DIFF, USER_AGENT_MUTT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Tioclinux() uses "magic numbers" that applications should know to use it.
Here is a patch against 2.5.70-bk12 which adds an include/linux/tiocl.h
which holds them and can be used by applications to properly call
iotcl(TIOCLINUX). It might stand for documentation as well, replacing
the not up-to-date man ioctl_list.

A structure for the selection argument is also defined.

I shortened TIOCLINUX_* into TIOCL_*, maybe is this too short ?

Regards,
Samuel Thibault

diff -urN linux-2.5.70-bk12/include/linux/tiocl.h linux-2.5.70-bk12-perso/include/linux/tiocl.h
--- linux-2.5.70-bk12/include/linux/tiocl.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.5.70-bk12-perso/include/linux/tiocl.h	2003-06-08 01:59:59.000000000 -0400
@@ -0,0 +1,38 @@
+#ifndef _LINUX_TIOCL_H
+#define _LINUX_TIOCL_H
+
+#define TIOCL_SETSEL	2	/* set a selection */
+#define 	TIOCL_SELCHAR	0	/* select characters */
+#define 	TIOCL_SELWORD	1	/* select whole words */
+#define 	TIOCL_SELLINE	2	/* select whole lines */
+#define 	TIOCL_SELPOINTER	3	/* show the pointer */
+#define 	TIOCL_SELCLEAR	4	/* clear visibility of selection */
+#define 	TIOCL_SELMOUSEREPORT	16	/* report beginning of selection */
+#define 	TIOCL_SELBUTTONMASK	15	/* button mask for report */
+/* selection extent */
+struct tiocl_selection {
+	unsigned short xs;	/* X start */
+	unsigned short ys;	/* Y start */
+	unsigned short xe;	/* X end */
+	unsigned short ye;	/* Y end */
+	unsigned short sel_mode;	/* selection mode */
+};
+
+#define TIOCL_PASTESEL	3	/* paste previous selection */
+#define TIOCL_UNBLANKSCREEN	4	/* unblank screen */
+
+#define TIOCL_SELLOADLUT	5
+	/* set characters to be considered alphabetic when selecting */
+	/* u32[8] bit array, 4 bytes-aligned with type */
+
+/* these two don't return a value: they write it back in the type */
+#define TIOCL_GETSHIFTSTATE	6	/* write shift state */
+#define TIOCL_GETMOUSEREPORTING	7	/* write whether mouse event are reported */
+#define TIOCL_SETVESABLANK	10	/* set vesa blanking mode */
+#define TIOCL_SETKMSGREDIRECT	11	/* restrict kernel messages to a vt */
+#define TIOCL_GETFGCONSOLE	12	/* get foreground vt */
+#define TIOCL_SCROLLCONSOLE	13	/* scroll console */
+#define TIOCL_BLANKSCREEN	14	/* keep screen blank even if a key is pressed */
+#define TIOCL_BLANKEDSCREEN	15	/* return which vt was blanked */
+
+#endif /* _LINUX_TIOCL_H */
diff -urN linux-2.5.70-bk12/drivers/char/selection.c linux-2.5.70-bk12-perso/drivers/char/selection.c
--- linux-2.5.70-bk12/drivers/char/selection.c	2003-06-08 00:03:46.000000000 -0400
+++ linux-2.5.70-bk12-perso/drivers/char/selection.c	2003-06-08 00:38:19.000000000 -0400
@@ -23,6 +23,7 @@
 #include <linux/vt_kern.h>
 #include <linux/consolemap.h>
 #include <linux/selection.h>
+#include <linux/tiocl.h>
 
 #ifndef MIN
 #define MIN(a,b)	((a) < (b) ? (a) : (b))
@@ -111,7 +112,7 @@
 }
 
 /* set the current selection. Invoked by ioctl() or by kernel code. */
-int set_selection(const unsigned long arg, struct tty_struct *tty, int user)
+int set_selection(const struct tiocl_selection *sel, struct tty_struct *tty, int user)
 {
 	int sel_mode, new_sel_start, new_sel_end, spc;
 	char *bp, *obp;
@@ -120,23 +121,22 @@
 
 	poke_blanked_console();
 
-	{ unsigned short *args, xs, ys, xe, ye;
+	{ unsigned short xs, ys, xe, ye;
 
-	  args = (unsigned short *)(arg + 1);
 	  if (user) {
-		  if (verify_area(VERIFY_READ, args, sizeof(short) * 5))
+		  if (verify_area(VERIFY_READ, sel, sizeof(*sel)))
 		  	return -EFAULT;
-		  __get_user(xs, args++);
-		  __get_user(ys, args++);
-		  __get_user(xe, args++);
-		  __get_user(ye, args++);
-		  __get_user(sel_mode, args);
+		  __get_user(xs, &sel->xs);
+		  __get_user(ys, &sel->ys);
+		  __get_user(xe, &sel->xe);
+		  __get_user(ye, &sel->ye);
+		  __get_user(sel_mode, &sel->sel_mode);
 	  } else {
-		  xs = *(args++); /* set selection from kernel */
-		  ys = *(args++);
-		  xe = *(args++);
-		  ye = *(args++);
-		  sel_mode = *args;
+		  xs = sel->xs; /* set selection from kernel */
+		  ys = sel->ys;
+		  xe = sel->xe;
+		  ye = sel->ye;
+		  sel_mode = sel->sel_mode;
 	  }
 	  xs--; ys--; xe--; ye--;
 	  xs = limit(xs, video_num_columns - 1);
@@ -146,14 +146,14 @@
 	  ps = ys * video_size_row + (xs << 1);
 	  pe = ye * video_size_row + (xe << 1);
 
-	  if (sel_mode == 4) {
+	  if (sel_mode == TIOCL_SELCLEAR) {
 	      /* useful for screendump without selection highlights */
 	      clear_selection();
 	      return 0;
 	  }
 
-	  if (mouse_reporting() && (sel_mode & 16)) {
-	      mouse_report(tty, sel_mode & 15, xs, ys);
+	  if (mouse_reporting() && (sel_mode & TIOCL_SELMOUSEREPORT)) {
+	      mouse_report(tty, sel_mode & TIOCL_SELBUTTONMASK, xs, ys);
 	      return 0;
 	  }
         }
@@ -172,11 +172,11 @@
 
 	switch (sel_mode)
 	{
-		case 0:	/* character-by-character selection */
+		case TIOCL_SELCHAR:	/* character-by-character selection */
 			new_sel_start = ps;
 			new_sel_end = pe;
 			break;
-		case 1:	/* word-by-word selection */
+		case TIOCL_SELWORD:	/* word-by-word selection */
 			spc = isspace(sel_pos(ps));
 			for (new_sel_start = ps; ; ps -= 2)
 			{
@@ -198,12 +198,12 @@
 					break;
 			}
 			break;
-		case 2:	/* line-by-line selection */
+		case TIOCL_SELLINE:	/* line-by-line selection */
 			new_sel_start = ps - ps % video_size_row;
 			new_sel_end = pe + video_size_row
 				    - pe % video_size_row - 2;
 			break;
-		case 3:
+		case TIOCL_SELPOINTER:
 			highlight_pointer(pe);
 			return 0;
 		default:
diff -urN linux-2.5.70-bk12/drivers/char/vt.c linux-2.5.70-bk12-perso/drivers/char/vt.c
--- linux-2.5.70-bk12/drivers/char/vt.c	2003-06-08 00:03:46.000000000 -0400
+++ linux-2.5.70-bk12-perso/drivers/char/vt.c	2003-06-08 02:00:56.000000000 -0400
@@ -90,6 +90,7 @@
 #include <linux/devfs_fs_kernel.h>
 #include <linux/vt_kern.h>
 #include <linux/selection.h>
+#include <linux/tiocl.h>
 #include <linux/kbd_kern.h>
 #include <linux/consolemap.h>
 #include <linux/timer.h>
@@ -2235,21 +2236,21 @@
 	ret = 0;
 	switch (type)
 	{
-		case 2:
+		case TIOCL_SETSEL:
 			acquire_console_sem();
-			ret = set_selection(arg, tty, 1);
+			ret = set_selection((struct tiocl_selection *)((char *)arg+1), tty, 1);
 			release_console_sem();
 			break;
-		case 3:
+		case TIOCL_PASTESEL:
 			ret = paste_selection(tty);
 			break;
-		case 4:
+		case TIOCL_UNBLANKSCREEN:
 			unblank_screen();
 			break;
-		case 5:
+		case TIOCL_SELLOADLUT:
 			ret = sel_loadlut(arg);
 			break;
-		case 6:
+		case TIOCL_GETSHIFTSTATE:
 			
 	/*
 	 * Make it possible to react to Shift+Mousebutton.
@@ -2260,14 +2261,14 @@
 	 		data = shift_state;
 			ret = __put_user(data, (char *) arg);
 			break;
-		case 7:
+		case TIOCL_GETMOUSEREPORTING:
 			data = mouse_reporting();
 			ret = __put_user(data, (char *) arg);
 			break;
-		case 10:
+		case TIOCL_SETVESABLANK:
 			set_vesa_blanking(arg);
 			break;;
-		case 11:	/* set kmsg redirect */
+		case TIOCL_SETKMSGREDIRECT:
 			if (!capable(CAP_SYS_ADMIN)) {
 				ret = -EPERM;
 			} else {
@@ -2277,10 +2278,10 @@
 					kmsg_redirect = data;
 			}
 			break;
-		case 12:	/* get fg_console */
+		case TIOCL_GETFGCONSOLE:
 			ret = fg_console;
 			break;
-		case 13:	/* scroll console */
+		case TIOCL_SCROLLCONSOLE:
 			if (get_user(lines, (char *)arg+1)) {
 				ret = -EFAULT;
 			} else {
@@ -2288,11 +2289,11 @@
 				ret = 0;
 			}
 			break;
-		case 14:	/* blank screen until explicitly unblanked, not only poked */
+		case TIOCL_BLANKSCREEN:	/* until explicitly unblanked, not only poked */
 			ignore_poke = 1;
 			do_blank_screen(0);
 			break;
-		case 15:	/* which console is blanked ? */
+		case TIOCL_BLANKEDSCREEN:
 			ret = console_blanked;
 			break;
 		default:
diff -urN linux-2.5.70-bk12/include/linux/selection.h linux-2.5.70-bk12-perso/include/linux/selection.h
--- linux-2.5.70-bk12/include/linux/selection.h	2003-05-26 21:00:41.000000000 -0400
+++ linux-2.5.70-bk12-perso/include/linux/selection.h	2003-06-08 00:32:30.000000000 -0400
@@ -7,12 +7,13 @@
 #ifndef _LINUX_SELECTION_H_
 #define _LINUX_SELECTION_H_
 
+#include <linux/tiocl.h>
 #include <linux/vt_buffer.h>
 
 extern int sel_cons;
 
 extern void clear_selection(void);
-extern int set_selection(const unsigned long arg, struct tty_struct *tty, int user);
+extern int set_selection(const struct tiocl_selection *sel, struct tty_struct *tty, int user);
 extern int paste_selection(struct tty_struct *tty);
 extern int sel_loadlut(const unsigned long arg);
 extern int mouse_reporting(void);
