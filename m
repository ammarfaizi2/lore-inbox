Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271645AbRIMMwH>; Thu, 13 Sep 2001 08:52:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271582AbRIMMwA>; Thu, 13 Sep 2001 08:52:00 -0400
Received: from [195.89.159.99] ([195.89.159.99]:22266 "EHLO
	kushida.degree2.com") by vger.kernel.org with ESMTP
	id <S271572AbRIMMvu>; Thu, 13 Sep 2001 08:51:50 -0400
Date: Thu, 13 Sep 2001 13:51:40 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Pavel Machek <pavel@suse.cz>
Cc: Simon Hay <simon@haywired.org>, linux-kernel@vger.kernel.org
Subject: Re: Multiple monitors
Message-ID: <20010913135140.A1397@kushida.degree2.com>
In-Reply-To: <20010903214829.B17488@unthought.net> <Pine.LNX.4.33.0109032107280.2297-100000@localhost.localdomain> <20010907015556.A7329@kushida.degree2.com> <20010911005848.A1005@bug.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010911005848.A1005@bug.ucw.cz>; from pavel@suse.cz on Tue, Sep 11, 2001 at 12:58:48AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> > On one 686 class machine, I saw text mode take nearly two seconds to
> > scroll the screen, when all but one line of the screen was being
> > scrolled (so it had to copy everything).  This was in pure text mode,
> > not even a framebuffer!  In X it was invisibly fast.
> 
> 2 seconds on vga console is way too much. It could happen with
> framebuffer + usb hogging PCI...

No, this was in 1996 on a Pentium Pro machine, with no USB or x86
framebuffer drivers even written then :-)  It was plain 80x50 text mode,
really.

I still have the patch I wrote in March 1997 (attached for reference),
and this patch made a _huge_ difference to text mode Emacs on those
machines.  An equivalent fix seems to have been incorporated in
console.c by now.

enjoy,
-- Jamie

--- linux/drivers/char/console.c.dist	Tue Jan 14 22:01:17 1997
+++ linux/drivers/char/console.c	Tue Feb 25 03:40:26 1997
@@ -592,15 +592,22 @@
 	__set_origin(__real_origin);
 }
 
-void scrup(int currcons, unsigned int t, unsigned int b)
+static void scrup(int currcons, unsigned int t, unsigned int b, unsigned int nr)
 {
 	int hardscroll = hardscroll_enabled;
 
-	if (b > video_num_lines || t >= b)
+	if (b > video_num_lines || t >= b || nr == 0)
 		return;
+	if (nr > b - t)
+		nr = b - t;
 	if (t || b != video_num_lines)
 		hardscroll = 0;
 	if (hardscroll) {
+		if (nr != 1) {
+			while (nr--)
+				scrup (currcons, t, b, 1);
+			return;
+		}
 		origin += video_size_row;
 		pos += video_size_row;
 		scr_end += video_size_row;
@@ -639,14 +646,14 @@
 		set_origin(currcons);
 	} else {
 		unsigned short * d = (unsigned short *) (origin+video_size_row*t);
-		unsigned short * s = (unsigned short *) (origin+video_size_row*(t+1));
-		unsigned int count = (b-t-1) * video_num_columns;
+		unsigned short * s = (unsigned short *) (origin+video_size_row*(t+nr));
+		unsigned int count = (b-t-nr) * video_num_columns;
 
 		while (count) {
 			count--;
 			scr_writew(scr_readw(s++), d++);
 		}
-		count = video_num_columns;
+		count = nr*video_num_columns;
 		while (count) {
 			count--;
 			scr_writew(video_erase_char, d++);
@@ -654,27 +661,28 @@
 	}
 }
 
-void
-scrdown(int currcons, unsigned int t, unsigned int b)
+static void
+scrdown(int currcons, unsigned int t, unsigned int b, unsigned int nr)
 {
 	unsigned short *d, *s;
 	unsigned int count;
 
-	if (b > video_num_lines || t >= b)
+	if (b > video_num_lines || t >= b || nr == 0)
 		return;
+	if (nr > b - t)
+		nr = b - t;
 	d = (unsigned short *) (origin+video_size_row*b);
-	s = (unsigned short *) (origin+video_size_row*(b-1));
-	count = (b-t-1)*video_num_columns;
+	s = (unsigned short *) (origin+video_size_row*(b-nr));
+	count = (b-t-nr)*video_num_columns;
 	while (count) {
 		count--;
 		scr_writew(scr_readw(--s), --d);
 	}
-	count = video_num_columns;
+	count = nr*video_num_columns;
 	while (count) {
 		count--;
 		scr_writew(video_erase_char, --d);
 	}
-	has_scrolled = 1;
 }
 
 static void lf(int currcons)
@@ -683,7 +691,7 @@
 	 * if below scrolling region
 	 */
     	if (y+1 == bottom)
-		scrup(currcons,top,bottom);
+		scrup(currcons,top,bottom,1);
 	else if (y < video_num_lines-1) {
 	    	y++;
 		pos += video_size_row;
@@ -697,7 +705,7 @@
 	 * if above scrolling region
 	 */
 	if (y == top)
-		scrdown(currcons,top,bottom);
+		scrdown(currcons,top,bottom,1);
 	else if (y > 0) {
 		y--;
 		pos -= video_size_row;
@@ -1171,84 +1179,61 @@
 	}
 }
 
-static void insert_char(int currcons)
+static void insert_chars(int currcons, unsigned int nr)
 {
-	unsigned int i = x;
-	unsigned short tmp, old = video_erase_char;
+	unsigned int count;
 	unsigned short * p = (unsigned short *) pos;
 
-	while (i++ < video_num_columns) {
-		tmp = scr_readw(p);
-		scr_writew(old, p);
-		old = tmp;
-		p++;
+	if (nr >= video_num_columns - x)
+		nr = video_num_columns - x;
+	if (nr == 0)
+		return;
+
+	p += video_num_columns - x;
+	count = video_num_columns - x - nr;
+	while (count--) {
+		p--;
+		scr_writew(scr_readw(p-nr), p);
 	}
+	count = nr;
+	while (count--)
+		scr_writew(video_erase_char, --p);
+
 	need_wrap = 0;
 }
 
-static void insert_line(int currcons)
+static inline void insert_lines(int currcons, unsigned int nr)
 {
-	scrdown(currcons,y,bottom);
+	scrdown(currcons,y,bottom,nr);
 	need_wrap = 0;
 }
 
-static void delete_char(int currcons)
+static void delete_chars(int currcons, unsigned int nr)
 {
-	unsigned int i = x;
+	unsigned int count;
 	unsigned short * p = (unsigned short *) pos;
 
-	while (++i < video_num_columns) {
-		scr_writew(scr_readw(p+1), p);
+	if (nr >= video_num_columns - x)
+		nr = video_num_columns - x;
+	if (nr == 0)
+		return;
+
+	count = video_num_columns - x - nr;
+	while (count--) {
+		scr_writew(scr_readw(p+nr), p);
 		p++;
 	}
-	scr_writew(video_erase_char, p);
-	need_wrap = 0;
-}
+	count = nr;
+	while (count--)
+		scr_writew(video_erase_char, p++);
 
-static void delete_line(int currcons)
-{
-	scrup(currcons,y,bottom);
 	need_wrap = 0;
 }
 
-static void csi_at(int currcons, unsigned int nr)
-{
-	if (nr > video_num_columns)
-		nr = video_num_columns;
-	else if (!nr)
-		nr = 1;
-	while (nr--)
-		insert_char(currcons);
-}
-
-static void csi_L(int currcons, unsigned int nr)
-{
-	if (nr > video_num_lines)
-		nr = video_num_lines;
-	else if (!nr)
-		nr = 1;
-	while (nr--)
-		insert_line(currcons);
-}
-
-static void csi_P(int currcons, unsigned int nr)
-{
-	if (nr > video_num_columns)
-		nr = video_num_columns;
-	else if (!nr)
-		nr = 1;
-	while (nr--)
-		delete_char(currcons);
-}
-
-static void csi_M(int currcons, unsigned int nr)
+static inline void delete_lines(int currcons, unsigned int nr)
 {
-	if (nr > video_num_lines)
-		nr = video_num_lines;
-	else if (!nr)
-		nr=1;
-	while (nr--)
-		delete_line(currcons);
+	scrup(currcons,y,bottom,nr);
+	need_wrap = 0;
 }
 
 static void save_cur(int currcons)
@@ -1468,7 +1453,7 @@
 				lf(currcons);
 			}
 			if (decim)
-				insert_char(currcons);
+				insert_chars(currcons, 1);
 			scr_writew( video_mode_512ch ?
 			   ((attr & 0xf7) << 8) + ((tc & 0x100) << 3) +
 			   (tc & 0x0ff) : (attr << 8) + tc,
@@ -1707,13 +1692,13 @@
 						csi_K(currcons,par[0]);
 						continue;
 					case 'L':
-						csi_L(currcons,par[0]);
+						insert_lines(currcons,(par[0] ? par[0] : 1));
 						continue;
 					case 'M':
-						csi_M(currcons,par[0]);
+						delete_lines(currcons,(par[0] ? par[0] : 1));
 						continue;
 					case 'P':
-						csi_P(currcons,par[0]);
+						delete_chars(currcons,(par[0] ? par[0] : 1));
 						continue;
 					case 'c':
 						if (!par[0])
@@ -1762,7 +1747,7 @@
 						csi_X(currcons, par[0]);
 						continue;
 					case '@':
-						csi_at(currcons,par[0]);
+						insert_chars(currcons,(par[0] ? par[0] : 1));
 						continue;
 					case ']': /* setterm functions */
 						setterm_command(currcons);
--- linux/drivers/char/vt.c.dist	Wed Feb  5 20:04:38 1997
+++ linux/drivers/char/vt.c	Tue Feb 25 03:42:23 1997
@@ -28,6 +28,7 @@
 #include "vt_kern.h"
 #include "diacr.h"
 #include "selection.h"
+#include "console_struct.h"	/* for `vc_has_scrolled' */
 
 extern char vt_dont_switch;
 extern struct tty_driver console_driver;
@@ -299,9 +300,10 @@
 		/*
 		 * explicitly blank/unblank the screen if switching modes
 		 */
-		if (arg == KD_TEXT)
+		if (arg == KD_TEXT) {
+			vc_cons[console].d->vc_has_scrolled = 1;
 			do_unblank_screen();
-		else
+		} else
 			do_blank_screen(1);
 		return 0;
 
