Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262062AbULaOhg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbULaOhg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 09:37:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262096AbULaOhc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 09:37:32 -0500
Received: from verein.lst.de ([213.95.11.210]:8652 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S262062AbULaOfK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 09:35:10 -0500
Date: Fri, 31 Dec 2004 15:34:57 +0100
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] cleanup virtual console <-> selection.c interface
Message-ID: <20041231143457.GA9165@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pass around pointers instead of indices into a global array between
various files of the virtual console implementation and stop using
obsfucting macros that expect certain variables to be in scope.

This is a first step to get rid of the various global arrays in the VC
code.


--- 1.12/drivers/char/selection.c	2004-10-28 09:39:58 +02:00
+++ edited/drivers/char/selection.c	2004-12-31 14:30:35 +01:00
@@ -33,7 +33,7 @@ extern void poke_blanked_console(void);
 
 /* Variables for selection control. */
 /* Use a dynamic buffer, instead of static (Dec 1994) */
-       int sel_cons;		/* must not be disallocated */
+struct vc_data *sel_cons;		/* must not be disallocated */
 static volatile int sel_start = -1; 	/* cleared by clear_selection */
 static int sel_end;
 static int sel_buffer_lth;
@@ -44,20 +44,22 @@ static char *sel_buffer;
 
 /* set reverse video on characters s-e of console with selection. */
 inline static void
-highlight(const int s, const int e) {
+highlight(const int s, const int e)
+{
 	invert_screen(sel_cons, s, e-s+2, 1);
 }
 
 /* use complementary color to show the pointer */
 inline static void
-highlight_pointer(const int where) {
+highlight_pointer(const int where)
+{
 	complement_pos(sel_cons, where);
 }
 
 static unsigned char
 sel_pos(int n)
 {
-	return inverse_translate(vc_cons[sel_cons].d, screen_glyph(sel_cons, n));
+	return inverse_translate(sel_cons, screen_glyph(sel_cons, n));
 }
 
 /* remove the current selection highlight, if any,
@@ -111,10 +113,10 @@ static inline unsigned short limit(const
 /* set the current selection. Invoked by ioctl() or by kernel code. */
 int set_selection(const struct tiocl_selection __user *sel, struct tty_struct *tty)
 {
+	struct vc_data *vc = vc_cons[fg_console].d;
 	int sel_mode, new_sel_start, new_sel_end, spc;
 	char *bp, *obp;
 	int i, ps, pe;
-	unsigned int currcons = fg_console;
 
 	poke_blanked_console();
 
@@ -128,12 +130,12 @@ int set_selection(const struct tiocl_sel
 	  __get_user(ye, &sel->ye);
 	  __get_user(sel_mode, &sel->sel_mode);
 	  xs--; ys--; xe--; ye--;
-	  xs = limit(xs, video_num_columns - 1);
-	  ys = limit(ys, video_num_lines - 1);
-	  xe = limit(xe, video_num_columns - 1);
-	  ye = limit(ye, video_num_lines - 1);
-	  ps = ys * video_size_row + (xs << 1);
-	  pe = ye * video_size_row + (xe << 1);
+	  xs = limit(xs, vc->vc_cols - 1);
+	  ys = limit(ys, vc->vc_rows - 1);
+	  xe = limit(xe, vc->vc_cols - 1);
+	  ye = limit(ye, vc->vc_rows - 1);
+	  ps = ys * vc->vc_size_row + (xs << 1);
+	  pe = ye * vc->vc_size_row + (xe << 1);
 
 	  if (sel_mode == TIOCL_SELCLEAR) {
 	      /* useful for screendump without selection highlights */
@@ -154,9 +156,9 @@ int set_selection(const struct tiocl_sel
 		pe = tmp;
 	}
 
-	if (sel_cons != fg_console) {
+	if (sel_cons != vc_cons[fg_console].d) {
 		clear_selection();
-		sel_cons = fg_console;
+		sel_cons = vc_cons[fg_console].d;
 	}
 
 	switch (sel_mode)
@@ -173,7 +175,7 @@ int set_selection(const struct tiocl_sel
 				    (!spc && !inword(sel_pos(ps))))
 					break;
 				new_sel_start = ps;
-				if (!(ps % video_size_row))
+				if (!(ps % vc->vc_size_row))
 					break;
 			}
 			spc = isspace(sel_pos(pe));
@@ -183,14 +185,14 @@ int set_selection(const struct tiocl_sel
 				    (!spc && !inword(sel_pos(pe))))
 					break;
 				new_sel_end = pe;
-				if (!((pe + 2) % video_size_row))
+				if (!((pe + 2) % vc->vc_size_row))
 					break;
 			}
 			break;
 		case TIOCL_SELLINE:	/* line-by-line selection */
-			new_sel_start = ps - ps % video_size_row;
-			new_sel_end = pe + video_size_row
-				    - pe % video_size_row - 2;
+			new_sel_start = ps - ps % vc->vc_size_row;
+			new_sel_end = pe + vc->vc_size_row
+				    - pe % vc->vc_size_row - 2;
 			break;
 		case TIOCL_SELPOINTER:
 			highlight_pointer(pe);
@@ -204,11 +206,11 @@ int set_selection(const struct tiocl_sel
 
 	/* select to end of line if on trailing space */
 	if (new_sel_end > new_sel_start &&
-		!atedge(new_sel_end, video_size_row) &&
+		!atedge(new_sel_end, vc->vc_size_row) &&
 		isspace(sel_pos(new_sel_end))) {
 		for (pe = new_sel_end + 2; ; pe += 2)
 			if (!isspace(sel_pos(pe)) ||
-			    atedge(pe, video_size_row))
+			    atedge(pe, vc->vc_size_row))
 				break;
 		if (isspace(sel_pos(pe)))
 			new_sel_end = pe;
@@ -255,7 +257,7 @@ int set_selection(const struct tiocl_sel
 		*bp = sel_pos(i);
 		if (!isspace(*bp++))
 			obp = bp;
-		if (! ((i + 2) % video_size_row)) {
+		if (! ((i + 2) % vc->vc_size_row)) {
 			/* strip trailing blanks from line and add newline,
 			   unless non-space at end of line. */
 			if (obp != bp) {
===== drivers/char/vc_screen.c 1.14 vs edited =====
--- 1.14/drivers/char/vc_screen.c	2004-06-28 02:28:39 +02:00
+++ edited/drivers/char/vc_screen.c	2004-12-31 14:30:35 +01:00
@@ -59,7 +59,7 @@ vcs_size(struct inode *inode)
 	if (!vc_cons_allocated(currcons))
 		return -ENXIO;
 
-	size = video_num_lines * video_num_columns;
+	size = vc_cons[currcons].d->vc_rows * vc_cons[currcons].d->vc_cols;
 
 	if (minor & 128)
 		size = 2*size + HEADER_SIZE;
@@ -99,6 +99,7 @@ vcs_read(struct file *file, char __user 
 {
 	struct inode *inode = file->f_dentry->d_inode;
 	unsigned int currcons = iminor(inode);
+	struct vc_data *vc;
 	long pos;
 	long viewed, attr, read;
 	int col, maxcol;
@@ -126,6 +127,7 @@ vcs_read(struct file *file, char __user 
 	ret = -ENXIO;
 	if (!vc_cons_allocated(currcons))
 		goto unlock_out;
+	vc = vc_cons[currcons].d;
 
 	ret = -EINVAL;
 	if (pos < 0)
@@ -159,15 +161,15 @@ vcs_read(struct file *file, char __user 
 
 		con_buf_start = con_buf0 = con_buf;
 		orig_count = this_round;
-		maxcol = video_num_columns;
+		maxcol = vc->vc_cols;
 		if (!attr) {
-			org = screen_pos(currcons, p, viewed);
+			org = screen_pos(vc, p, viewed);
 			col = p % maxcol;
 			p += maxcol - col;
 			while (this_round-- > 0) {
-				*con_buf0++ = (vcs_scr_readw(currcons, org++) & 0xff);
+				*con_buf0++ = (vcs_scr_readw(vc, org++) & 0xff);
 				if (++col == maxcol) {
-					org = screen_pos(currcons, p, viewed);
+					org = screen_pos(vc, p, viewed);
 					col = 0;
 					p += maxcol;
 				}
@@ -176,9 +178,9 @@ vcs_read(struct file *file, char __user 
 			if (p < HEADER_SIZE) {
 				size_t tmp_count;
 
-				con_buf0[0] = (char) video_num_lines;
-				con_buf0[1] = (char) video_num_columns;
-				getconsxy(currcons, con_buf0 + 2);
+				con_buf0[0] = (char)vc->vc_rows;
+				con_buf0[1] = (char)vc->vc_cols;
+				getconsxy(vc, con_buf0 + 2);
 
 				con_buf_start += p;
 				this_round += p;
@@ -214,7 +216,7 @@ vcs_read(struct file *file, char __user 
 				p /= 2;
 				col = p % maxcol;
 
-				org = screen_pos(currcons, p, viewed);
+				org = screen_pos(vc, p, viewed);
 				p += maxcol - col;
 
 				/* Buffer has even length, so we can always copy
@@ -224,10 +226,10 @@ vcs_read(struct file *file, char __user 
 				this_round = (this_round + 1) >> 1;
 
 				while (this_round) {
-					*tmp_buf++ = vcs_scr_readw(currcons, org++);
+					*tmp_buf++ = vcs_scr_readw(vc, org++);
 					this_round --;
 					if (++col == maxcol) {
-						org = screen_pos(currcons, p, viewed);
+						org = screen_pos(vc, p, viewed);
 						col = 0;
 						p += maxcol;
 					}
@@ -270,6 +272,7 @@ vcs_write(struct file *file, const char 
 {
 	struct inode *inode = file->f_dentry->d_inode;
 	unsigned int currcons = iminor(inode);
+	struct vc_data *vc;
 	long pos;
 	long viewed, attr, size, written;
 	char *con_buf0;
@@ -299,6 +302,7 @@ vcs_write(struct file *file, const char 
 	ret = -ENXIO;
 	if (!vc_cons_allocated(currcons))
 		goto unlock_out;
+	vc = vc_cons[currcons].d;
 
 	size = vcs_size(inode);
 	ret = -EINVAL;
@@ -351,10 +355,10 @@ vcs_write(struct file *file, const char 
 
 		con_buf0 = con_buf;
 		orig_count = this_round;
-		maxcol = video_num_columns;
+		maxcol = vc->vc_cols;
 		p = pos;
 		if (!attr) {
-			org0 = org = screen_pos(currcons, p, viewed);
+			org0 = org = screen_pos(vc, p, viewed);
 			col = p % maxcol;
 			p += maxcol - col;
 
@@ -362,11 +366,11 @@ vcs_write(struct file *file, const char 
 				unsigned char c = *con_buf0++;
 
 				this_round--;
-				vcs_scr_writew(currcons,
-					       (vcs_scr_readw(currcons, org) & 0xff00) | c, org);
+				vcs_scr_writew(vc,
+					       (vcs_scr_readw(vc, org) & 0xff00) | c, org);
 				org++;
 				if (++col == maxcol) {
-					org = screen_pos(currcons, p, viewed);
+					org = screen_pos(vc, p, viewed);
 					col = 0;
 					p += maxcol;
 				}
@@ -375,34 +379,34 @@ vcs_write(struct file *file, const char 
 			if (p < HEADER_SIZE) {
 				char header[HEADER_SIZE];
 
-				getconsxy(currcons, header + 2);
+				getconsxy(vc, header + 2);
 				while (p < HEADER_SIZE && this_round > 0) {
 					this_round--;
 					header[p++] = *con_buf0++;
 				}
 				if (!viewed)
-					putconsxy(currcons, header + 2);
+					putconsxy(vc, header + 2);
 			}
 			p -= HEADER_SIZE;
 			col = (p/2) % maxcol;
 			if (this_round > 0) {
-				org0 = org = screen_pos(currcons, p/2, viewed);
+				org0 = org = screen_pos(vc, p/2, viewed);
 				if ((p & 1) && this_round > 0) {
 					char c;
 
 					this_round--;
 					c = *con_buf0++;
 #ifdef __BIG_ENDIAN
-					vcs_scr_writew(currcons, c |
-					     (vcs_scr_readw(currcons, org) & 0xff00), org);
+					vcs_scr_writew(vc, c |
+					     (vcs_scr_readw(vc, org) & 0xff00), org);
 #else
-					vcs_scr_writew(currcons, (c << 8) |
-					     (vcs_scr_readw(currcons, org) & 0xff), org);
+					vcs_scr_writew(vc, (c << 8) |
+					     (vcs_scr_readw(vc, org) & 0xff), org);
 #endif
 					org++;
 					p++;
 					if (++col == maxcol) {
-						org = screen_pos(currcons, p/2, viewed);
+						org = screen_pos(vc, p/2, viewed);
 						col = 0;
 					}
 				}
@@ -413,11 +417,11 @@ vcs_write(struct file *file, const char 
 				unsigned short w;
 
 				w = get_unaligned(((const unsigned short *)con_buf0));
-				vcs_scr_writew(currcons, w, org++);
+				vcs_scr_writew(vc, w, org++);
 				con_buf0 += 2;
 				this_round -= 2;
 				if (++col == maxcol) {
-					org = screen_pos(currcons, p, viewed);
+					org = screen_pos(vc, p, viewed);
 					col = 0;
 					p += maxcol;
 				}
@@ -427,9 +431,9 @@ vcs_write(struct file *file, const char 
 
 				c = *con_buf0++;
 #ifdef __BIG_ENDIAN
-				vcs_scr_writew(currcons, (vcs_scr_readw(currcons, org) & 0xff) | (c << 8), org);
+				vcs_scr_writew(vc, (vcs_scr_readw(vc, org) & 0xff) | (c << 8), org);
 #else
-				vcs_scr_writew(currcons, (vcs_scr_readw(currcons, org) & 0xff00) | c, org);
+				vcs_scr_writew(vc, (vcs_scr_readw(vc, org) & 0xff00) | c, org);
 #endif
 			}
 		}
===== drivers/char/vt.c 1.85 vs edited =====
--- 1.85/drivers/char/vt.c	2004-12-10 18:52:35 +01:00
+++ edited/drivers/char/vt.c	2004-12-31 14:30:35 +01:00
@@ -40,15 +40,6 @@
  *     - Arno Griffioen <arno@usn.nl>
  *     - David Carter <carter@cs.bris.ac.uk>
  * 
- *   Note that the abstract console driver allows all consoles to be of
- *   potentially different sizes, so the following variables depend on the
- *   current console (currcons):
- *
- *     - video_num_columns
- *     - video_num_lines
- *     - video_size_row
- *     - can_do_color
- *
  *   The abstract console driver provides a generic interface for a text
  *   console. It supports VGA text mode, frame buffer based graphical consoles
  *   and special graphics processors that are only accessible through some
@@ -146,13 +137,13 @@ static const struct consw *con_driver_ma
 static int con_open(struct tty_struct *, struct file *);
 static void vc_init(unsigned int console, unsigned int rows,
 		    unsigned int cols, int do_clear);
-static void gotoxy(int currcons, int new_x, int new_y);
+static void gotoxy(struct vc_data *vc, int new_x, int new_y);
 static void save_cur(int currcons);
 static void reset_terminal(int currcons, int do_clear);
 static void con_flush_chars(struct tty_struct *tty);
 static void set_vesa_blanking(char __user *p);
-static void set_cursor(int currcons);
-static void hide_cursor(int currcons);
+static void set_cursor(struct vc_data *vc);
+static void hide_cursor(struct vc_data *vc);
 static void console_callback(void *ignored);
 static void blank_screen_t(unsigned long dummy);
 
@@ -223,28 +214,32 @@ enum {
  *	Low-Level Functions
  */
 
-#define IS_FG (currcons == fg_console)
+#define IS_FG			(currcons == fg_console)
+#define IS_FG_VC(vc)		(vc == vc_cons[fg_console].d)
+
 #define IS_VISIBLE CON_IS_VISIBLE(vc_cons[currcons].d)
 
 #ifdef VT_BUF_VRAM_ONLY
-#define DO_UPDATE 0
+#define DO_UPDATE		0
+#define DO_UPDATE_VC(vc)	0
 #else
-#define DO_UPDATE IS_VISIBLE
+#define DO_UPDATE 		IS_VISIBLE
+#define DO_UPDATE_VC(vc)	CON_IS_VISIBLE(vc)
 #endif
 
 static int pm_con_request(struct pm_dev *dev, pm_request_t rqst, void *data);
 static struct pm_dev *pm_con;
 
-static inline unsigned short *screenpos(int currcons, int offset, int viewed)
+static inline unsigned short *screenpos(struct vc_data *vc, int offset, int viewed)
 {
 	unsigned short *p;
 	
 	if (!viewed)
-		p = (unsigned short *)(origin + offset);
-	else if (!sw->con_screen_pos)
-		p = (unsigned short *)(visible_origin + offset);
+		p = (unsigned short *)(vc->vc_origin + offset);
+	else if (!vc->vc_sw->con_screen_pos)
+		p = (unsigned short *)(vc->vc_visible_origin + offset);
 	else
-		p = sw->con_screen_pos(vc_cons[currcons].d, offset);
+		p = vc->vc_sw->con_screen_pos(vc, offset);
 	return p;
 }
 
@@ -265,14 +260,15 @@ static void scrup(int currcons, unsigned
 
 	if (t+nr >= b)
 		nr = b - t - 1;
-	if (b > video_num_lines || t >= b || nr < 1)
+	if (b > vc_cons[currcons].d->vc_rows || t >= b || nr < 1)
 		return;
 	if (IS_VISIBLE && sw->con_scroll(vc_cons[currcons].d, t, b, SM_UP, nr))
 		return;
-	d = (unsigned short *) (origin+video_size_row*t);
-	s = (unsigned short *) (origin+video_size_row*(t+nr));
-	scr_memmovew(d, s, (b-t-nr) * video_size_row);
-	scr_memsetw(d + (b-t-nr) * video_num_columns, video_erase_char, video_size_row*nr);
+	d = (unsigned short *) (origin+vc_cons[currcons].d->vc_size_row*t);
+	s = (unsigned short *) (origin+vc_cons[currcons].d->vc_size_row*(t+nr));
+	scr_memmovew(d, s, (b-t-nr) * vc_cons[currcons].d->vc_size_row);
+	scr_memsetw(d + (b-t-nr) * vc_cons[currcons].d->vc_cols, video_erase_char,
+			vc_cons[currcons].d->vc_size_row * nr);
 }
 
 static void
@@ -283,40 +279,40 @@ scrdown(int currcons, unsigned int t, un
 
 	if (t+nr >= b)
 		nr = b - t - 1;
-	if (b > video_num_lines || t >= b || nr < 1)
+	if (b > vc_cons[currcons].d->vc_rows || t >= b || nr < 1)
 		return;
 	if (IS_VISIBLE && sw->con_scroll(vc_cons[currcons].d, t, b, SM_DOWN, nr))
 		return;
-	s = (unsigned short *) (origin+video_size_row*t);
-	step = video_num_columns * nr;
-	scr_memmovew(s + step, s, (b-t-nr)*video_size_row);
+	s = (unsigned short *) (origin+vc_cons[currcons].d->vc_size_row*t);
+	step = vc_cons[currcons].d->vc_cols * nr;
+	scr_memmovew(s + step, s, (b-t-nr)*vc_cons[currcons].d->vc_size_row);
 	scr_memsetw(s, video_erase_char, 2*step);
 }
 
-static void do_update_region(int currcons, unsigned long start, int count)
+static void do_update_region(struct vc_data *vc, unsigned long start, int count)
 {
 #ifndef VT_BUF_VRAM_ONLY
 	unsigned int xx, yy, offset;
 	u16 *p;
 
 	p = (u16 *) start;
-	if (!sw->con_getxy) {
-		offset = (start - origin) / 2;
-		xx = offset % video_num_columns;
-		yy = offset / video_num_columns;
+	if (!vc->vc_sw->con_getxy) {
+		offset = (start - vc->vc_origin) / 2;
+		xx = offset % vc->vc_cols;
+		yy = offset / vc->vc_cols;
 	} else {
 		int nxx, nyy;
-		start = sw->con_getxy(vc_cons[currcons].d, start, &nxx, &nyy);
+		start = vc->vc_sw->con_getxy(vc, start, &nxx, &nyy);
 		xx = nxx; yy = nyy;
 	}
 	for(;;) {
 		u16 attrib = scr_readw(p) & 0xff00;
 		int startx = xx;
 		u16 *q = p;
-		while (xx < video_num_columns && count) {
+		while (xx < vc->vc_cols && count) {
 			if (attrib != (scr_readw(p) & 0xff00)) {
 				if (p > q)
-					sw->con_putcs(vc_cons[currcons].d, q, p-q, yy, startx);
+					vc->vc_sw->con_putcs(vc, q, p-q, yy, startx);
 				startx = xx;
 				q = p;
 				attrib = scr_readw(p) & 0xff00;
@@ -326,14 +322,14 @@ static void do_update_region(int currcon
 			count--;
 		}
 		if (p > q)
-			sw->con_putcs(vc_cons[currcons].d, q, p-q, yy, startx);
+			vc->vc_sw->con_putcs(vc, q, p-q, yy, startx);
 		if (!count)
 			break;
 		xx = 0;
 		yy++;
-		if (sw->con_getxy) {
+		if (vc->vc_sw->con_getxy) {
 			p = (u16 *)start;
-			start = sw->con_getxy(vc_cons[currcons].d, start, NULL, NULL);
+			start = vc->vc_sw->con_getxy(vc, start, NULL, NULL);
 		}
 	}
 #endif
@@ -344,9 +340,9 @@ void update_region(int currcons, unsigne
 	WARN_CONSOLE_UNLOCKED();
 
 	if (DO_UPDATE) {
-		hide_cursor(currcons);
-		do_update_region(currcons, start, count);
-		set_cursor(currcons);
+		hide_cursor(vc_cons[currcons].d);
+		do_update_region(vc_cons[currcons].d, start, count);
+		set_cursor(vc_cons[currcons].d);
 	}
 }
 
@@ -370,7 +366,7 @@ static u8 build_attr(int currcons, u8 _c
  */
 	{
 	u8 a = color;
-	if (!can_do_color)
+	if (!vc_cons[currcons].d->vc_can_do_color)
 		return _intensity |
 		       (_underline ? 4 : 0) |
 		       (_reverse ? 8 : 0) |
@@ -401,31 +397,30 @@ static void update_attr(int currcons)
 }
 
 /* Note: inverting the screen twice should revert to the original state */
-
-void invert_screen(int currcons, int offset, int count, int viewed)
+void invert_screen(struct vc_data *vc, int offset, int count, int viewed)
 {
 	unsigned short *p;
 
 	WARN_CONSOLE_UNLOCKED();
 
 	count /= 2;
-	p = screenpos(currcons, offset, viewed);
-	if (sw->con_invert_region)
-		sw->con_invert_region(vc_cons[currcons].d, p, count);
+	p = screenpos(vc, offset, viewed);
+	if (vc->vc_sw->con_invert_region)
+		vc->vc_sw->con_invert_region(vc, p, count);
 #ifndef VT_BUF_VRAM_ONLY
 	else {
 		u16 *q = p;
 		int cnt = count;
 		u16 a;
 
-		if (!can_do_color) {
+		if (!vc->vc_can_do_color) {
 			while (cnt--) {
 			    a = scr_readw(q);
 			    a ^= 0x0800;
 			    scr_writew(a, q);
 			    q++;
 			}
-		} else if (hi_font_mask == 0x100) {
+		} else if (vc->vc_hi_font_mask == 0x100) {
 			while (cnt--) {
 				a = scr_readw(q);
 				a = ((a) & 0x11ff) | (((a) & 0xe000) >> 4) | (((a) & 0x0e00) << 4);
@@ -442,12 +437,12 @@ void invert_screen(int currcons, int off
 		}
 	}
 #endif
-	if (DO_UPDATE)
-		do_update_region(currcons, (unsigned long) p, count);
+	if (DO_UPDATE_VC(vc))
+		do_update_region(vc, (unsigned long) p, count);
 }
 
 /* used by selection: complement pointer position */
-void complement_pos(int currcons, int offset)
+void complement_pos(struct vc_data *vc, int offset)
 {
 	static unsigned short *p;
 	static unsigned short old;
@@ -457,21 +452,21 @@ void complement_pos(int currcons, int of
 
 	if (p) {
 		scr_writew(old, p);
-		if (DO_UPDATE)
-			sw->con_putc(vc_cons[currcons].d, old, oldy, oldx);
+		if (DO_UPDATE_VC(vc))
+			vc->vc_sw->con_putc(vc, old, oldy, oldx);
 	}
 	if (offset == -1)
 		p = NULL;
 	else {
 		unsigned short new;
-		p = screenpos(currcons, offset, 1);
+		p = screenpos(vc, offset, 1);
 		old = scr_readw(p);
-		new = old ^ complement_mask;
+		new = old ^ vc->vc_complement_mask;
 		scr_writew(new, p);
-		if (DO_UPDATE) {
-			oldx = (offset >> 1) % video_num_columns;
-			oldy = (offset >> 1) / video_num_columns;
-			sw->con_putc(vc_cons[currcons].d, new, oldy, oldx);
+		if (DO_UPDATE_VC(vc)) {
+			oldx = (offset >> 1) % vc->vc_cols;
+			oldy = (offset >> 1) / vc->vc_cols;
+			vc->vc_sw->con_putc(vc, new, oldy, oldx);
 		}
 	}
 }
@@ -480,7 +475,7 @@ static void insert_char(int currcons, un
 {
 	unsigned short *p, *q = (unsigned short *) pos;
 
-	p = q + video_num_columns - nr - x;
+	p = q + vc_cons[currcons].d->vc_cols - nr - x;
 	while (--p >= q)
 		scr_writew(scr_readw(p), p + nr);
 	scr_memsetw(q, video_erase_char, nr*2);
@@ -488,7 +483,7 @@ static void insert_char(int currcons, un
 	if (DO_UPDATE) {
 		unsigned short oldattr = attr;
 		sw->con_bmove(vc_cons[currcons].d,y,x,y,x+nr,1,
-			      video_num_columns-x-nr);
+			      vc_cons[currcons].d->vc_cols-x-nr);
 		attr = video_erase_char >> 8;
 		while (nr--)
 			sw->con_putc(vc_cons[currcons].d,
@@ -502,7 +497,7 @@ static void delete_char(int currcons, un
 	unsigned int i = x;
 	unsigned short *p = (unsigned short *) pos;
 
-	while (++i <= video_num_columns - nr) {
+	while (++i <= vc_cons[currcons].d->vc_cols - nr) {
 		scr_writew(scr_readw(p+nr), p);
 		p++;
 	}
@@ -511,22 +506,22 @@ static void delete_char(int currcons, un
 	if (DO_UPDATE) {
 		unsigned short oldattr = attr;
 		sw->con_bmove(vc_cons[currcons].d, y, x+nr, y, x, 1,
-			      video_num_columns-x-nr);
+			      vc_cons[currcons].d->vc_cols-x-nr);
 		attr = video_erase_char >> 8;
 		while (nr--)
 			sw->con_putc(vc_cons[currcons].d,
 				     video_erase_char, y,
-				     video_num_columns-1-nr);
+				     vc_cons[currcons].d->vc_cols-1-nr);
 		attr = oldattr;
 	}
 }
 
 static int softcursor_original;
 
-static void add_softcursor(int currcons)
+static void add_softcursor(struct vc_data *vc)
 {
-	int i = scr_readw((u16 *) pos);
-	u32 type = cursor_type;
+	int i = scr_readw((u16 *) vc->vc_pos);
+	u32 type = vc->vc_cursor_type;
 
 	if (! (type & 0x10)) return;
 	if (softcursor_original != -1) return;
@@ -535,41 +530,43 @@ static void add_softcursor(int currcons)
 	i ^= ((type) & 0xff00 );
 	if ((type & 0x20) && ((softcursor_original & 0x7000) == (i & 0x7000))) i ^= 0x7000;
 	if ((type & 0x40) && ((i & 0x700) == ((i & 0x7000) >> 4))) i ^= 0x0700;
-	scr_writew(i, (u16 *) pos);
-	if (DO_UPDATE)
-		sw->con_putc(vc_cons[currcons].d, i, y, x);
+	scr_writew(i, (u16 *) vc->vc_pos);
+	if (DO_UPDATE_VC(vc))
+		vc->vc_sw->con_putc(vc, i, vc->vc_y, vc->vc_x);
 }
 
-static void hide_softcursor(int currcons)
+static void hide_softcursor(struct vc_data *vc)
 {
 	if (softcursor_original != -1) {
-		scr_writew(softcursor_original,(u16 *) pos);
-		if (DO_UPDATE)
-			sw->con_putc(vc_cons[currcons].d, softcursor_original, y, x);
+		scr_writew(softcursor_original, (u16 *)vc->vc_pos);
+		if (DO_UPDATE_VC(vc))
+			vc->vc_sw->con_putc(vc, softcursor_original,
+					vc->vc_y, vc->vc_x);
 		softcursor_original = -1;
 	}
 }
 
-static void hide_cursor(int currcons)
+static void hide_cursor(struct vc_data *vc)
 {
-	if (currcons == sel_cons)
+	if (vc == sel_cons)
 		clear_selection();
-	sw->con_cursor(vc_cons[currcons].d,CM_ERASE);
-	hide_softcursor(currcons);
+	vc->vc_sw->con_cursor(vc, CM_ERASE);
+	hide_softcursor(vc);
 }
 
-static void set_cursor(int currcons)
+static void set_cursor(struct vc_data *vc)
 {
-    if (!IS_FG || console_blanked || vcmode == KD_GRAPHICS)
-	return;
-    if (deccm) {
-	if (currcons == sel_cons)
-		clear_selection();
-	add_softcursor(currcons);
-	if ((cursor_type & 0x0f) != 1)
-	    sw->con_cursor(vc_cons[currcons].d,CM_DRAW);
-    } else
-	hide_cursor(currcons);
+	if (!IS_FG_VC(vc) || console_blanked ||
+	    vc->vc_vt->vc_mode == KD_GRAPHICS)
+		return;
+	if (vc->vc_deccm) {
+		if (vc == sel_cons)
+			clear_selection();
+		add_softcursor(vc);
+		if ((vc->vc_cursor_type & 0x0f) != 1)
+			vc->vc_sw->con_cursor(vc, CM_DRAW);
+	} else
+		hide_cursor(vc);
 }
 
 static void set_origin(int currcons)
@@ -582,7 +579,7 @@ static void set_origin(int currcons)
 		origin = (unsigned long) screenbuf;
 	visible_origin = origin;
 	scr_end = origin + screenbuf_size;
-	pos = origin + video_size_row*y + 2*x;
+	pos = origin + vc_cons[currcons].d->vc_size_row*y + 2*x;
 }
 
 static inline void save_screen(int currcons)
@@ -623,7 +620,7 @@ void redraw_screen(int new_console, int 
 
 	if (is_switch) {
 		currcons = fg_console;
-		hide_cursor(currcons);
+		hide_cursor(vc_cons[currcons].d);
 		if (fg_console != new_console) {
 			struct vc_data **display = vc_cons[new_console].d->vc_display_fg;
 			old_console = (*display) ? (*display)->vc_num : fg_console;
@@ -640,7 +637,7 @@ void redraw_screen(int new_console, int 
 		}
 	} else {
 		currcons = new_console;
-		hide_cursor(currcons);
+		hide_cursor(vc_cons[currcons].d);
 	}
 
 	if (redraw) {
@@ -661,9 +658,9 @@ void redraw_screen(int new_console, int 
 			clear_buffer_attributes(currcons);
 		}
 		if (update && vcmode != KD_GRAPHICS)
-			do_update_region(currcons, origin, screenbuf_size/2);
+			do_update_region(vc_cons[currcons].d, origin, screenbuf_size/2);
 	}
-	set_cursor(currcons);
+	set_cursor(vc_cons[currcons].d);
 	if (is_switch) {
 		set_leds();
 		compute_shiftstate();
@@ -696,13 +693,14 @@ static void visual_init(int currcons, in
     vc_cons[currcons].d->vc_uni_pagedir = 0;
     hi_font_mask = 0;
     complement_mask = 0;
-    can_do_color = 0;
+    vc_cons[currcons].d->vc_can_do_color = 0;
     sw->con_init(vc_cons[currcons].d, init);
     if (!complement_mask)
-        complement_mask = can_do_color ? 0x7700 : 0x0800;
+        complement_mask =
+		vc_cons[currcons].d->vc_can_do_color ? 0x7700 : 0x0800;
     s_complement_mask = complement_mask;
-    video_size_row = video_num_columns<<1;
-    screenbuf_size = video_num_lines*video_size_row;
+    vc_cons[currcons].d->vc_size_row = vc_cons[currcons].d->vc_cols<<1;
+    screenbuf_size = vc_cons[currcons].d->vc_rows * vc_cons[currcons].d->vc_size_row;
 }
 
 int vc_allocate(unsigned int currcons)	/* return 0 on success */
@@ -730,6 +728,7 @@ int vc_allocate(unsigned int currcons)	/
 	    memset((void *)p, 0, structsize);
 	    vc_cons[currcons].d = (struct vc_data *)p;
 	    vt_cons[currcons] = (struct vt_struct *)(p+sizeof(struct vc_data));
+	    vc_cons[currcons].d->vc_vt = vt_cons[currcons];
 	    visual_init(currcons, 1);
 	    if (!*vc_cons[currcons].d->vc_uni_pagedir_loc)
 		con_set_default_unimap(currcons);
@@ -742,7 +741,7 @@ int vc_allocate(unsigned int currcons)	/
 	    }
 	    screenbuf = (unsigned short *) q;
 	    kmalloced = 1;
-	    vc_init(currcons, video_num_lines, video_num_columns, 1);
+	    vc_init(currcons, vc_cons[currcons].d->vc_rows, vc_cons[currcons].d->vc_cols, 1);
 
 	    if (!pm_con) {
 		    pm_con = pm_register(PM_SYS_DEV,
@@ -785,21 +784,21 @@ int vc_resize(int currcons, unsigned int
 	if (cols > VC_RESIZE_MAXCOL || lines > VC_RESIZE_MAXROW)
 		return -EINVAL;
 
-	new_cols = (cols ? cols : video_num_columns);
-	new_rows = (lines ? lines : video_num_lines);
+	new_cols = (cols ? cols : vc_cons[currcons].d->vc_cols);
+	new_rows = (lines ? lines : vc_cons[currcons].d->vc_rows);
 	new_row_size = new_cols << 1;
 	new_screen_size = new_row_size * new_rows;
 
-	if (new_cols == video_num_columns && new_rows == video_num_lines)
+	if (new_cols == vc_cons[currcons].d->vc_cols && new_rows == vc_cons[currcons].d->vc_rows)
 		return 0;
 
 	newscreen = (unsigned short *) kmalloc(new_screen_size, GFP_USER);
 	if (!newscreen)
 		return -ENOMEM;
 
-	old_rows = video_num_lines;
-	old_cols = video_num_columns;
-	old_row_size = video_size_row;
+	old_rows = vc_cons[currcons].d->vc_rows;
+	old_cols = vc_cons[currcons].d->vc_cols;
+	old_row_size = vc_cons[currcons].d->vc_size_row;
 	old_screen_size = screenbuf_size;
 
 	err = resize_screen(currcons, new_cols, new_rows);
@@ -808,9 +807,9 @@ int vc_resize(int currcons, unsigned int
 		return err;
 	}
 
-	video_num_lines = new_rows;
-	video_num_columns = new_cols;
-	video_size_row = new_row_size;
+	vc_cons[currcons].d->vc_rows = new_rows;
+	vc_cons[currcons].d->vc_cols = new_cols;
+	vc_cons[currcons].d->vc_size_row = new_row_size;
 	screenbuf_size = new_screen_size;
 
 	rlth = min(old_row_size, new_row_size);
@@ -841,16 +840,16 @@ int vc_resize(int currcons, unsigned int
 
 	/* do part of a reset_terminal() */
 	top = 0;
-	bottom = video_num_lines;
-	gotoxy(currcons, x, y);
+	bottom = vc_cons[currcons].d->vc_rows;
+	gotoxy(vc_cons[currcons].d, x, y);
 	save_cur(currcons);
 
 	if (vc_cons[currcons].d->vc_tty) {
 		struct winsize ws, *cws = &vc_cons[currcons].d->vc_tty->winsize;
 
 		memset(&ws, 0, sizeof(ws));
-		ws.ws_row = video_num_lines;
-		ws.ws_col = video_num_columns;
+		ws.ws_row = vc_cons[currcons].d->vc_rows;
+		ws.ws_col = vc_cons[currcons].d->vc_cols;
 		ws.ws_ypixel = video_scan_lines;
 		if ((ws.ws_row != cws->ws_row || ws.ws_col != cws->ws_col) &&
 		    vc_cons[currcons].d->vc_tty->pgrp > 0)
@@ -913,38 +912,40 @@ int default_blu[] = {0x00,0x00,0x00,0x00
  * might also be negative. If the given position is out of
  * bounds, the cursor is placed at the nearest margin.
  */
-static void gotoxy(int currcons, int new_x, int new_y)
+static void gotoxy(struct vc_data *vc, int new_x, int new_y)
 {
 	int min_y, max_y;
 
 	if (new_x < 0)
-		x = 0;
-	else
-		if (new_x >= video_num_columns)
-			x = video_num_columns - 1;
+		vc->vc_x = 0;
+	else {
+		if (new_x >= vc->vc_cols)
+			vc->vc_x = vc->vc_cols - 1;
 		else
-			x = new_x;
- 	if (decom) {
-		min_y = top;
-		max_y = bottom;
+			vc->vc_x = new_x;
+	}
+
+ 	if (vc->vc_decom) {
+		min_y = vc->vc_top;
+		max_y = vc->vc_bottom;
 	} else {
 		min_y = 0;
-		max_y = video_num_lines;
+		max_y = vc->vc_rows;
 	}
 	if (new_y < min_y)
-		y = min_y;
+		vc->vc_y = min_y;
 	else if (new_y >= max_y)
-		y = max_y - 1;
+		vc->vc_y = max_y - 1;
 	else
-		y = new_y;
-	pos = origin + y*video_size_row + (x<<1);
-	need_wrap = 0;
+		vc->vc_y = new_y;
+	vc->vc_pos = vc->vc_origin + vc->vc_y * vc->vc_size_row + (vc->vc_x<<1);
+	vc->vc_need_wrap = 0;
 }
 
 /* for absolute user moves, when decom is set */
 static void gotoxay(int currcons, int new_x, int new_y)
 {
-	gotoxy(currcons, new_x, decom ? (top+new_y) : new_y);
+	gotoxy(vc_cons[currcons].d, new_x, decom ? (top+new_y) : new_y);
 }
 
 void scrollback(int lines)
@@ -952,7 +953,7 @@ void scrollback(int lines)
 	int currcons = fg_console;
 
 	if (!lines)
-		lines = video_num_lines/2;
+		lines = vc_cons[currcons].d->vc_rows/2;
 	scrolldelta(-lines);
 }
 
@@ -961,7 +962,7 @@ void scrollfront(int lines)
 	int currcons = fg_console;
 
 	if (!lines)
-		lines = video_num_lines/2;
+		lines = vc_cons[currcons].d->vc_rows/2;
 	scrolldelta(lines);
 }
 
@@ -972,9 +973,9 @@ static void lf(int currcons)
 	 */
     	if (y+1 == bottom)
 		scrup(currcons,top,bottom,1);
-	else if (y < video_num_lines-1) {
+	else if (y < vc_cons[currcons].d->vc_rows-1) {
 	    	y++;
-		pos += video_size_row;
+		pos += vc_cons[currcons].d->vc_size_row;
 	}
 	need_wrap = 0;
 }
@@ -988,7 +989,7 @@ static void ri(int currcons)
 		scrdown(currcons,top,bottom,1);
 	else if (y > 0) {
 		y--;
-		pos -= video_size_row;
+		pos -= vc_cons[currcons].d->vc_size_row;
 	}
 	need_wrap = 0;
 }
@@ -1025,10 +1026,10 @@ static void csi_J(int currcons, int vpar
 			if (DO_UPDATE) {
 				/* do in two stages */
 				sw->con_clear(vc_cons[currcons].d, y, x, 1,
-					      video_num_columns-x);
+					      vc_cons[currcons].d->vc_cols-x);
 				sw->con_clear(vc_cons[currcons].d, y+1, 0,
-					      video_num_lines-y-1,
-					      video_num_columns);
+					      vc_cons[currcons].d->vc_rows-y-1,
+					      vc_cons[currcons].d->vc_cols);
 			}
 			break;
 		case 1:	/* erase from start to cursor */
@@ -1037,18 +1038,18 @@ static void csi_J(int currcons, int vpar
 			if (DO_UPDATE) {
 				/* do in two stages */
 				sw->con_clear(vc_cons[currcons].d, 0, 0, y,
-					      video_num_columns);
+					      vc_cons[currcons].d->vc_cols);
 				sw->con_clear(vc_cons[currcons].d, y, 0, 1,
 					      x + 1);
 			}
 			break;
 		case 2: /* erase whole display */
-			count = video_num_columns * video_num_lines;
+			count = vc_cons[currcons].d->vc_cols * vc_cons[currcons].d->vc_rows;
 			start = (unsigned short *) origin;
 			if (DO_UPDATE)
 				sw->con_clear(vc_cons[currcons].d, 0, 0,
-					      video_num_lines,
-					      video_num_columns);
+					      vc_cons[currcons].d->vc_rows,
+					      vc_cons[currcons].d->vc_cols);
 			break;
 		default:
 			return;
@@ -1064,11 +1065,11 @@ static void csi_K(int currcons, int vpar
 
 	switch (vpar) {
 		case 0:	/* erase from cursor to end of line */
-			count = video_num_columns-x;
+			count = vc_cons[currcons].d->vc_cols-x;
 			start = (unsigned short *) pos;
 			if (DO_UPDATE)
 				sw->con_clear(vc_cons[currcons].d, y, x, 1,
-					      video_num_columns-x);
+					      vc_cons[currcons].d->vc_cols-x);
 			break;
 		case 1:	/* erase from start of line to cursor */
 			start = (unsigned short *) (pos - (x<<1));
@@ -1079,10 +1080,10 @@ static void csi_K(int currcons, int vpar
 			break;
 		case 2: /* erase whole line */
 			start = (unsigned short *) (pos - (x<<1));
-			count = video_num_columns;
+			count = vc_cons[currcons].d->vc_cols;
 			if (DO_UPDATE)
 				sw->con_clear(vc_cons[currcons].d, y, 0, 1,
-					      video_num_columns);
+					      vc_cons[currcons].d->vc_cols);
 			break;
 		default:
 			return;
@@ -1097,7 +1098,7 @@ static void csi_X(int currcons, int vpar
 
 	if (!vpar)
 		vpar++;
-	count = (vpar > video_num_columns-x) ? (video_num_columns-x) : vpar;
+	count = (vpar > vc_cons[currcons].d->vc_cols-x) ? (vc_cons[currcons].d->vc_cols-x) : vpar;
 
 	scr_memsetw((unsigned short *) pos, video_erase_char, 2 * count);
 	if (DO_UPDATE)
@@ -1270,7 +1271,7 @@ static void set_mode(int currcons, int o
 			case 3:	/* 80/132 mode switch unimplemented */
 				deccolm = on_off;
 #if 0
-				(void) vc_resize(deccolm ? 132 : 80, video_num_lines);
+				(void) vc_resize(deccolm ? 132 : 80, vc_cons[currcons].d->vc_rows);
 				/* this alone does not suffice; some user mode
 				   utility has to change the hardware regs */
 #endif
@@ -1278,7 +1279,7 @@ static void set_mode(int currcons, int o
 			case 5:			/* Inverted screen on/off */
 				if (decscnm != on_off) {
 					decscnm = on_off;
-					invert_screen(currcons, 0, screenbuf_size, 0);
+					invert_screen(vc_cons[currcons].d, 0, screenbuf_size, 0);
 					update_attr(currcons);
 				}
 				break;
@@ -1325,14 +1326,16 @@ static void setterm_command(int currcons
 {
 	switch(par[0]) {
 		case 1:	/* set color for underline mode */
-			if (can_do_color && par[1] < 16) {
+			if (vc_cons[currcons].d->vc_can_do_color &&
+					par[1] < 16) {
 				ulcolor = color_table[par[1]];
 				if (underline)
 					update_attr(currcons);
 			}
 			break;
 		case 2:	/* set color for half intensity mode */
-			if (can_do_color && par[1] < 16) {
+			if (vc_cons[currcons].d->vc_can_do_color &&
+					par[1] < 16) {
 				halfcolor = color_table[par[1]];
 				if (intensity == 0)
 					update_attr(currcons);
@@ -1381,8 +1384,8 @@ static void setterm_command(int currcons
 /* console_sem is held */
 static void csi_at(int currcons, unsigned int nr)
 {
-	if (nr > video_num_columns - x)
-		nr = video_num_columns - x;
+	if (nr > vc_cons[currcons].d->vc_cols - x)
+		nr = vc_cons[currcons].d->vc_cols - x;
 	else if (!nr)
 		nr = 1;
 	insert_char(currcons, nr);
@@ -1391,8 +1394,8 @@ static void csi_at(int currcons, unsigne
 /* console_sem is held */
 static void csi_L(int currcons, unsigned int nr)
 {
-	if (nr > video_num_lines - y)
-		nr = video_num_lines - y;
+	if (nr > vc_cons[currcons].d->vc_rows - y)
+		nr = vc_cons[currcons].d->vc_rows - y;
 	else if (!nr)
 		nr = 1;
 	scrdown(currcons,y,bottom,nr);
@@ -1402,8 +1405,8 @@ static void csi_L(int currcons, unsigned
 /* console_sem is held */
 static void csi_P(int currcons, unsigned int nr)
 {
-	if (nr > video_num_columns - x)
-		nr = video_num_columns - x;
+	if (nr > vc_cons[currcons].d->vc_cols - x)
+		nr = vc_cons[currcons].d->vc_cols - x;
 	else if (!nr)
 		nr = 1;
 	delete_char(currcons, nr);
@@ -1412,8 +1415,8 @@ static void csi_P(int currcons, unsigned
 /* console_sem is held */
 static void csi_M(int currcons, unsigned int nr)
 {
-	if (nr > video_num_lines - y)
-		nr = video_num_lines - y;
+	if (nr > vc_cons[currcons].d->vc_rows - y)
+		nr = vc_cons[currcons].d->vc_rows - y;
 	else if (!nr)
 		nr=1;
 	scrup(currcons,y,bottom,nr);
@@ -1438,7 +1441,7 @@ static void save_cur(int currcons)
 /* console_sem is held */
 static void restore_cur(int currcons)
 {
-	gotoxy(currcons,saved_x,saved_y);
+	gotoxy(vc_cons[currcons].d,saved_x,saved_y);
 	intensity	= s_intensity;
 	underline	= s_underline;
 	blink		= s_blink;
@@ -1460,7 +1463,7 @@ enum { ESnormal, ESesc, ESsquare, ESgetp
 static void reset_terminal(int currcons, int do_clear)
 {
 	top		= 0;
-	bottom		= video_num_lines;
+	bottom		= vc_cons[currcons].d->vc_rows;
 	vc_state	= ESnormal;
 	ques		= 0;
 	translate	= set_translate(LAT1_MAP,currcons);
@@ -1507,7 +1510,7 @@ static void reset_terminal(int currcons,
 	bell_pitch = DEFAULT_BELL_PITCH;
 	bell_duration = DEFAULT_BELL_DURATION;
 
-	gotoxy(currcons,0,0);
+	gotoxy(vc_cons[currcons].d, 0, 0);
 	save_cur(currcons);
 	if (do_clear)
 	    csi_J(currcons,2);
@@ -1532,7 +1535,7 @@ static void do_con_trol(struct tty_struc
 		return;
 	case 9:
 		pos -= (x << 1);
-		while (x < video_num_columns - 1) {
+		while (x < vc_cons[currcons].d->vc_cols - 1) {
 			x++;
 			if (tab_stop[x >> 5] & (1 << (x & 31)))
 				break;
@@ -1719,31 +1722,31 @@ static void do_con_trol(struct tty_struc
 		switch(c) {
 		case 'G': case '`':
 			if (par[0]) par[0]--;
-			gotoxy(currcons,par[0],y);
+			gotoxy(vc_cons[currcons].d, par[0], y);
 			return;
 		case 'A':
 			if (!par[0]) par[0]++;
-			gotoxy(currcons,x,y-par[0]);
+			gotoxy(vc_cons[currcons].d, x, y-par[0]);
 			return;
 		case 'B': case 'e':
 			if (!par[0]) par[0]++;
-			gotoxy(currcons,x,y+par[0]);
+			gotoxy(vc_cons[currcons].d, x, y+par[0]);
 			return;
 		case 'C': case 'a':
 			if (!par[0]) par[0]++;
-			gotoxy(currcons,x+par[0],y);
+			gotoxy(vc_cons[currcons].d, x+par[0], y);
 			return;
 		case 'D':
 			if (!par[0]) par[0]++;
-			gotoxy(currcons,x-par[0],y);
+			gotoxy(vc_cons[currcons].d, x-par[0], y);
 			return;
 		case 'E':
 			if (!par[0]) par[0]++;
-			gotoxy(currcons,0,y+par[0]);
+			gotoxy(vc_cons[currcons].d, 0, y+par[0]);
 			return;
 		case 'F':
 			if (!par[0]) par[0]++;
-			gotoxy(currcons,0,y-par[0]);
+			gotoxy(vc_cons[currcons].d, 0, y-par[0]);
 			return;
 		case 'd':
 			if (par[0]) par[0]--;
@@ -1797,10 +1800,10 @@ static void do_con_trol(struct tty_struc
 			if (!par[0])
 				par[0]++;
 			if (!par[1])
-				par[1] = video_num_lines;
+				par[1] = vc_cons[currcons].d->vc_rows;
 			/* Minimum allowed region is 2 lines */
 			if (par[0] < par[1] &&
-			    par[1] <= video_num_lines) {
+			    par[1] <= vc_cons[currcons].d->vc_rows) {
 				top=par[0]-1;
 				bottom=par[1];
 				gotoxay(currcons,0,0);
@@ -1847,7 +1850,7 @@ static void do_con_trol(struct tty_struc
 			csi_J(currcons, 2);
 			video_erase_char =
 				(video_erase_char & 0xff00) | ' ';
-			do_update_region(currcons, origin, screenbuf_size/2);
+			do_update_region(vc_cons[currcons].d, origin, screenbuf_size/2);
 		}
 		return;
 	case ESsetG0:
@@ -1963,7 +1966,7 @@ static int do_con_write(struct tty_struc
 
 	/* undraw cursor first */
 	if (IS_FG)
-		hide_cursor(currcons);
+		hide_cursor(vc_cons[currcons].d);
 
 	while (!tty->stopped && count) {
 		int orig = *buf;
@@ -2065,7 +2068,7 @@ static int do_con_write(struct tty_struc
 				draw_x = x;
 				draw_from = pos;
 			}
-			if (x == video_num_columns - 1) {
+			if (x == vc_cons[currcons].d->vc_cols - 1) {
 				need_wrap = decawm;
 				draw_to = pos+2;
 			} else {
@@ -2102,7 +2105,7 @@ static void console_callback(void *ignor
 	if (want_console >= 0) {
 		if (want_console != fg_console &&
 		    vc_cons_allocated(want_console)) {
-			hide_cursor(fg_console);
+			hide_cursor(vc_cons[fg_console].d);
 			change_console(want_console);
 			/* we only changed when the console had already
 			   been allocated - a new console is not created
@@ -2176,7 +2179,7 @@ void vt_console_print(struct console *co
 
 	/* undraw cursor first */
 	if (IS_FG)
-		hide_cursor(currcons);
+		hide_cursor(vc_cons[currcons].d);
 
 	start = (ushort *)pos;
 
@@ -2209,7 +2212,7 @@ void vt_console_print(struct console *co
 		}
 		scr_writew((attr << 8) + c, (unsigned short *) pos);
 		cnt++;
-		if (myx == video_num_columns - 1) {
+		if (myx == vc_cons[currcons].d->vc_cols - 1) {
 			need_wrap = 1;
 			continue;
 		}
@@ -2220,12 +2223,12 @@ void vt_console_print(struct console *co
 		if (IS_VISIBLE)
 			sw->con_putcs(vc_cons[currcons].d, start, cnt, y, x);
 		x += cnt;
-		if (x == video_num_columns) {
+		if (x == vc_cons[currcons].d->vc_cols) {
 			x--;
 			need_wrap = 1;
 		}
 	}
-	set_cursor(currcons);
+	set_cursor(vc_cons[currcons].d);
 
 	if (!oops_in_progress)
 		poke_blanked_console();
@@ -2438,7 +2441,7 @@ static void con_flush_chars(struct tty_s
 	acquire_console_sem();
 	vt = tty->driver_data;
 	if (vt)
-		set_cursor(vt->vc_num);
+		set_cursor(vc_cons[vt->vc_num].d);
 	release_console_sem();
 }
 
@@ -2459,8 +2462,8 @@ static int con_open(struct tty_struct *t
 			vc_cons[currcons].d->vc_tty = tty;
 
 			if (!tty->winsize.ws_row && !tty->winsize.ws_col) {
-				tty->winsize.ws_row = video_num_lines;
-				tty->winsize.ws_col = video_num_columns;
+				tty->winsize.ws_row = vc_cons[currcons].d->vc_rows;
+				tty->winsize.ws_col = vc_cons[currcons].d->vc_cols;
 			}
 			release_console_sem();
 			vcs_make_devfs(tty);
@@ -2507,10 +2510,10 @@ static void vc_init(unsigned int currcon
 {
 	int j, k ;
 
-	video_num_columns = cols;
-	video_num_lines = rows;
-	video_size_row = cols<<1;
-	screenbuf_size = video_num_lines * video_size_row;
+	vc_cons[currcons].d->vc_cols = cols;
+	vc_cons[currcons].d->vc_rows = rows;
+	vc_cons[currcons].d->vc_size_row = cols<<1;
+	screenbuf_size = vc_cons[currcons].d->vc_rows * vc_cons[currcons].d->vc_size_row;
 
 	set_origin(currcons);
 	pos = origin;
@@ -2563,22 +2566,23 @@ static int __init con_init(void)
 				alloc_bootmem(sizeof(struct vc_data));
 		vt_cons[currcons] = (struct vt_struct *)
 				alloc_bootmem(sizeof(struct vt_struct));
+		vc_cons[currcons].d->vc_vt = vt_cons[currcons];
 		visual_init(currcons, 1);
 		screenbuf = (unsigned short *) alloc_bootmem(screenbuf_size);
 		kmalloced = 0;
-		vc_init(currcons, video_num_lines, video_num_columns, 
+		vc_init(currcons, vc_cons[currcons].d->vc_rows, vc_cons[currcons].d->vc_cols, 
 			currcons || !sw->con_save_screen);
 	}
 	currcons = fg_console = 0;
 	master_display_fg = vc_cons[currcons].d;
 	set_origin(currcons);
 	save_screen(currcons);
-	gotoxy(currcons,x,y);
+	gotoxy(vc_cons[currcons].d, x, y);
 	csi_J(currcons, 0);
 	update_screen(fg_console);
 	printk("Console: %s %s %dx%d",
-		can_do_color ? "colour" : "mono",
-		display_desc, video_num_columns, video_num_lines);
+		vc_cons[currcons].d->vc_can_do_color ? "colour" : "mono",
+		display_desc, vc_cons[currcons].d->vc_cols, vc_cons[currcons].d->vc_rows);
 	printable = 1;
 	printk("\n");
 
@@ -2690,7 +2694,7 @@ int take_over_console(const struct consw
 		origin = (unsigned long) screenbuf;
 		visible_origin = origin;
 		scr_end = origin + screenbuf_size;
-		pos = origin + video_size_row*y + 2*x;
+		pos = origin + vc_cons[currcons].d->vc_size_row*y + 2*x;
 		visual_init(i, 0);
 		update_attr(i);
 
@@ -2788,7 +2792,7 @@ void do_blank_screen(int entering_gfx)
 
 	/* entering graphics mode? */
 	if (entering_gfx) {
-		hide_cursor(currcons);
+		hide_cursor(vc_cons[currcons].d);
 		save_screen(currcons);
 		sw->con_blank(vc_cons[currcons].d, -1, 1);
 		console_blanked = fg_console + 1;
@@ -2802,7 +2806,7 @@ void do_blank_screen(int entering_gfx)
 		return;
 	}
 
-	hide_cursor(currcons);
+	hide_cursor(vc_cons[currcons].d);
 	del_timer_sync(&console_timer);
 	blank_timer_expired = 0;
 
@@ -2859,7 +2863,7 @@ void do_unblank_screen(int leaving_gfx)
 	if (console_blank_hook)
 		console_blank_hook(0);
 	set_palette(currcons);
-	set_cursor(fg_console);
+	set_cursor(vc_cons[fg_console].d);
 }
 
 /*
@@ -3184,47 +3188,47 @@ int con_font_op(int currcons, struct con
  */
 
 /* used by selection */
-u16 screen_glyph(int currcons, int offset)
+u16 screen_glyph(struct vc_data *vc, int offset)
 {
-	u16 w = scr_readw(screenpos(currcons, offset, 1));
+	u16 w = scr_readw(screenpos(vc, offset, 1));
 	u16 c = w & 0xff;
 
-	if (w & hi_font_mask)
+	if (w & vc->vc_hi_font_mask)
 		c |= 0x100;
 	return c;
 }
 
 /* used by vcs - note the word offset */
-unsigned short *screen_pos(int currcons, int w_offset, int viewed)
+unsigned short *screen_pos(struct vc_data *vc, int w_offset, int viewed)
 {
-	return screenpos(currcons, 2 * w_offset, viewed);
+	return screenpos(vc, 2 * w_offset, viewed);
 }
 
-void getconsxy(int currcons, unsigned char *p)
+void getconsxy(struct vc_data *vc, unsigned char *p)
 {
-	p[0] = x;
-	p[1] = y;
+	p[0] = vc->vc_x;
+	p[1] = vc->vc_y;
 }
 
-void putconsxy(int currcons, unsigned char *p)
+void putconsxy(struct vc_data *vc, unsigned char *p)
 {
-	gotoxy(currcons, p[0], p[1]);
-	set_cursor(currcons);
+	gotoxy(vc, p[0], p[1]);
+	set_cursor(vc);
 }
 
-u16 vcs_scr_readw(int currcons, const u16 *org)
+u16 vcs_scr_readw(struct vc_data *vc, const u16 *org)
 {
-	if ((unsigned long)org == pos && softcursor_original != -1)
+	if ((unsigned long)org == vc->vc_pos && softcursor_original != -1)
 		return softcursor_original;
 	return scr_readw(org);
 }
 
-void vcs_scr_writew(int currcons, u16 val, u16 *org)
+void vcs_scr_writew(struct vc_data *vc, u16 val, u16 *org)
 {
 	scr_writew(val, org);
-	if ((unsigned long)org == pos) {
+	if ((unsigned long)org == vc->vc_pos) {
 		softcursor_original = -1;
-		add_softcursor(currcons);
+		add_softcursor(vc);
 	}
 }
 
===== drivers/char/vt_ioctl.c 1.41 vs edited =====
--- 1.41/drivers/char/vt_ioctl.c	2004-09-29 16:40:49 +02:00
+++ edited/drivers/char/vt_ioctl.c	2004-12-31 14:30:35 +01:00
@@ -37,7 +37,7 @@ char vt_dont_switch;
 extern struct tty_driver *console_driver;
 
 #define VT_IS_IN_USE(i)	(console_driver->ttys[i] && console_driver->ttys[i]->count)
-#define VT_BUSY(i)	(VT_IS_IN_USE(i) || i == fg_console || i == sel_cons)
+#define VT_BUSY(i)	(VT_IS_IN_USE(i) || i == fg_console || vc_cons[i].d == sel_cons)
 
 /*
  * Console (vt and kd) routines, as defined by USL SVR4 manual, and by
--- 1.7/include/linux/console_struct.h	2004-07-29 18:00:40 +02:00
+++ edited/include/linux/console_struct.h	2004-12-31 14:30:35 +01:00
@@ -9,6 +9,8 @@
  * to achieve effects such as fast scrolling by changing the origin.
  */
 
+struct vt_struct;
+
 #define NPAR 16
 
 struct vc_data {
@@ -87,6 +89,7 @@ struct vc_data {
 	struct vc_data **vc_display_fg;		/* [!] Ptr to var holding fg console for this display */
 	unsigned long	vc_uni_pagedir;
 	unsigned long	*vc_uni_pagedir_loc;  /* [!] Location of uni_pagedir variable for this console */
+	struct vt_struct *vc_vt;
 	/* additional information is in vt_kern.h */
 };
 
===== include/linux/selection.h 1.4 vs edited =====
--- 1.4/include/linux/selection.h	2004-05-30 22:37:36 +02:00
+++ edited/include/linux/selection.h	2004-12-31 14:38:29 +01:00
@@ -10,7 +10,7 @@
 #include <linux/tiocl.h>
 #include <linux/vt_buffer.h>
 
-extern int sel_cons;
+extern struct vc_data *sel_cons;
 
 extern void clear_selection(void);
 extern int set_selection(const struct tiocl_selection __user *sel, struct tty_struct *tty);
@@ -19,11 +19,6 @@ extern int sel_loadlut(char __user *p);
 extern int mouse_reporting(void);
 extern void mouse_report(struct tty_struct * tty, int butt, int mrx, int mry);
 
-#define video_num_columns	(vc_cons[currcons].d->vc_cols)
-#define video_num_lines		(vc_cons[currcons].d->vc_rows)
-#define video_size_row		(vc_cons[currcons].d->vc_size_row)
-#define can_do_color		(vc_cons[currcons].d->vc_can_do_color)
-
 extern int console_blanked;
 
 extern unsigned char color_table[];
@@ -31,15 +26,15 @@ extern int default_red[];
 extern int default_grn[];
 extern int default_blu[];
 
-extern unsigned short *screen_pos(int currcons, int w_offset, int viewed);
-extern u16 screen_glyph(int currcons, int offset);
-extern void complement_pos(int currcons, int offset);
-extern void invert_screen(int currcons, int offset, int count, int shift);
+extern unsigned short *screen_pos(struct vc_data *vc, int w_offset, int viewed);
+extern u16 screen_glyph(struct vc_data *vc, int offset);
+extern void complement_pos(struct vc_data *vc, int offset);
+extern void invert_screen(struct vc_data *vc, int offset, int count, int shift);
 
-extern void getconsxy(int currcons, unsigned char *p);
-extern void putconsxy(int currcons, unsigned char *p);
+extern void getconsxy(struct vc_data *vc, unsigned char *p);
+extern void putconsxy(struct vc_data *vc, unsigned char *p);
 
-extern u16 vcs_scr_readw(int currcons, const u16 *org);
-extern void vcs_scr_writew(int currcons, u16 val, u16 *org);
+extern u16 vcs_scr_readw(struct vc_data *vc, const u16 *org);
+extern void vcs_scr_writew(struct vc_data *vc, u16 val, u16 *org);
 
 #endif
