Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261270AbVGLIvK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbVGLIvK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 04:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261267AbVGLIvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 04:51:10 -0400
Received: from miranda.org ([65.124.18.202]:55695 "HELO miranda.org")
	by vger.kernel.org with SMTP id S261270AbVGLIvH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 04:51:07 -0400
Date: Tue, 12 Jul 2005 04:51:05 -0400
From: Steve Young <sdyoung@miranda.org>
To: linux-kernel@vger.kernel.org
Cc: vojtech@suse.cz, linuxconsole-dev@lists.sourceforge.net
Subject: PATCH: Move scrollback out of low-level console drivers
Message-ID: <20050712085105.GA30754@miranda.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="k1lZvvs/B4yU6o8G"
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


  Hello,

  Here is a patch that moves scrollback handling out of the low-level *con 
drivers and into the virtual console layer in vt.c.  It's non-intrusive 
insofar as low-level drivers that do not take advantage of it continue to 
function as usual, but drivers that do want to use it (eg, vgacon after 
this patch is applied) can do so through a rather simple API.  Basically a 
low-level driver signals it wants the vt layer to maintain scrollback through 
vc_data->vc_use_scrollback, and then grabs chunks of scrollback by calling
vt_get_scrollback from the consw->con_scrolldelta function.  The payoff for
users is (a) scrollback can now be an arbitrary length, limited only by
memory and (b) scrollback is preserved between console switches, something
vgacon/etc are unable to do when they are relying solely on origin tricks
to make scrollback happen.

  A few points:
  - ioctls are used to control the vt scrollback.  This is probably not the
best way to do it, but I wasn't sure if procfs, sysfs, or sysctl were the
way to go.  If anyone can recommend a better way to do it I'd be happy to
implement it.
  - A userspace program, cfgscroll (attached) is used to configure scrollback.
It has reasonable defaults, but cfgscroll -e needs to be called to enable
scrollback.  This is because we can't start saving scrollback before kmalloc
works, and I couldn't determine a reasonable way to find out if kmalloc is 
working yet (is there some kind of kmalloc_running flag somewhere?).
The source is junky because hopefully it will go away.
  - /dev/vcs* will return whatever is really on the screen, so if the
user is in the middle of scrollback that's what vcs will return.
If/when gpm starts using the vcs devices, this means users will be able
to select text out of scrollback.
  - This patch is against 2.6.13-rc1-mm1.

  Finally, this is my first attempt at a kernel patch so there's probably some
other things that will need attention.  Any constructive criticism would be
appreciated - hopefully this patch doesn't clash with the work being
done by the linuxconsole folks.

  Thanks,
  Steve.

--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=scrback-diff-9

diff -u -r --exclude-from=linux-2.6.12/Documentation/dontdiff linux-2.6.12/drivers/char/selection.c linux-2.6.13-rc1-mm1-devel/drivers/char/selection.c
--- linux-2.6.12/drivers/char/selection.c	2005-06-17 13:48:29.000000000 -0600
+++ linux-2.6.13-rc1-mm1-devel/drivers/char/selection.c	2005-07-12 01:22:01.000000000 -0600
@@ -118,6 +118,9 @@
 
 	poke_blanked_console();
 
+	if (vc->vc_cumdelta)
+		vc->vc_sw->con_scrolldelta(vc, 0);
+
 	{ unsigned short xs, ys, xe, ye;
 
 	  if (!access_ok(VERIFY_READ, sel, sizeof(*sel)))
diff -u -r --exclude-from=linux-2.6.12/Documentation/dontdiff linux-2.6.12/drivers/char/vt.c linux-2.6.13-rc1-mm1-devel/drivers/char/vt.c
--- linux-2.6.12/drivers/char/vt.c	2005-07-12 01:45:46.000000000 -0600
+++ linux-2.6.13-rc1-mm1-devel/drivers/char/vt.c	2005-07-12 02:03:27.000000000 -0600
@@ -93,6 +93,7 @@
 #include <linux/pm.h>
 #include <linux/font.h>
 #include <linux/bitops.h>
+#include <linux/list.h>
 
 #include <asm/io.h>
 #include <asm/system.h>
@@ -145,6 +146,7 @@
 static void console_callback(void *ignored);
 static void blank_screen_t(unsigned long dummy);
 static void set_palette(struct vc_data *vc);
+static void evict_scrollback(struct vc_data *vc, unsigned int count);
 
 static int printable;		/* Is console ready for printing? */
 
@@ -194,6 +196,11 @@
  */
 static int scrollback_delta;
 
+int vt_max_scrollback_dfl = 32000;
+char vt_scrollback_ready = 0;		/* global scrollback enable */
+static unsigned int scrback_gfpmask = GFP_KERNEL | __GFP_NORETRY 
+						| __GFP_NOWARN;
+
 /*
  * Hook so that the power management routines can (un)blank
  * the console on our behalf.
@@ -245,6 +252,190 @@
 	schedule_work(&console_work);
 }
 
+int vt_set_scrollback(struct vt_scrollparms *sc) 
+{
+	struct vc_data *vc;
+
+	if (sc->vp_con > MAX_NR_CONSOLES || !vc_cons[sc->vp_con].d)
+		return -EINVAL;
+
+	vc = vc_cons[sc->vp_con].d;
+	if (!vc->vc_support_scrollback)
+		return -ENOSYS;
+
+	if (sc->vp_size == vc->vc_maxscrollback)
+		return 0;
+	vc->vc_sw->con_scrolldelta(vc, 0);
+	/* shrink? */
+	if ((sc->vp_size < vc->vc_maxscrollback) && 
+		(vc->vc_scrollbacksz > sc->vp_size))
+		evict_scrollback(vc, vc->vc_scrollbacksz - sc->vp_size);
+	vc->vc_maxscrollback = sc->vp_size;
+
+	return(0);
+}
+EXPORT_SYMBOL(vt_set_scrollback);
+
+unsigned int vt_get_scrollback(unsigned char **rb, 
+				struct vc_data *vc, unsigned int needlines) 
+{
+	static char *retbuf = NULL;
+	static int retbufsz;
+	char *retbufptr;
+	struct vc_scrback *sc;
+	unsigned int bytes_needed, orig_bytes_needed, skip;
+
+	orig_bytes_needed = bytes_needed = needlines * vc->vc_size_row;
+	
+	if (!retbuf || retbufsz != bytes_needed) {
+		if (retbuf)
+			kfree(retbuf);
+		retbufsz = bytes_needed;
+		retbuf = kmalloc(bytes_needed, scrback_gfpmask);
+	}
+
+	*rb = retbufptr = retbuf;
+	if (vc->vc_scrollbacksz > vc->vc_cumdelta * vc->vc_size_row)
+		skip = vc->vc_scrollbacksz - 
+			(vc->vc_cumdelta * vc->vc_size_row);
+	else
+		skip = 0;
+
+	list_for_each_entry(sc, &vc->vc_scrollback, vsc_list) {
+		unsigned int buf_inuse = sc->vsc_bufsize - sc->vsc_bufleft;
+		unsigned int copycount;
+
+		if (!skip) {
+			copycount = min(buf_inuse, bytes_needed);
+			scr_memcpyw(retbufptr, sc->vsc_buf, copycount);
+		} else if (skip < buf_inuse) {
+			copycount = min(buf_inuse - skip, bytes_needed);
+			scr_memcpyw(retbufptr, sc->vsc_buf + skip, copycount);
+			skip = 0;
+		} else {
+			skip -= buf_inuse;
+			continue;
+		}
+
+		bytes_needed -= copycount;
+		retbufptr += copycount;
+
+		if (!bytes_needed)
+			return(needlines);
+	}
+	return((orig_bytes_needed - bytes_needed) / vc->vc_size_row);
+}
+EXPORT_SYMBOL(vt_get_scrollback);
+
+static void evict_scrollback(struct vc_data *vc, unsigned int count) 
+{
+	struct vc_scrback *sc, *tmpsc;
+	unsigned int buf_used;
+
+	list_for_each_entry_safe(sc, tmpsc, &vc->vc_scrollback, vsc_list) {
+		buf_used = sc->vsc_bufsize - sc->vsc_bufleft;
+
+		vc->vc_scrollbacksz -= buf_used;
+		kfree(sc->vsc_buf);
+		list_del(&sc->vsc_list);
+		kfree(sc);
+		if (buf_used >= count)
+			break;
+		count -= buf_used;
+	}
+}
+
+void vt_clear_scrollback(struct vc_data *vc) 
+{
+	if (vc->vc_cumdelta)
+		vc->vc_sw->con_scrolldelta(vc, 0);
+	if(vc->vc_scrollbacksz)
+		evict_scrollback(vc, vc->vc_scrollbacksz);
+}
+EXPORT_SYMBOL(vt_clear_scrollback);
+
+int vt_update_cumdelta(struct vc_data *c, int delta) 
+{
+	int old_cumdelta = c->vc_cumdelta;
+
+	if (!delta || delta > c->vc_cumdelta) {
+		c->vc_cumdelta = 0;
+	} else {
+		c->vc_cumdelta -= delta;
+		c->vc_cumdelta = min(c->vc_cumdelta, 
+			c->vc_scrollbacksz / c->vc_size_row);
+	}
+
+	if (c->vc_cumdelta == old_cumdelta)
+		return 0;
+	return 1;
+}
+EXPORT_SYMBOL(vt_update_cumdelta);
+
+static void save_scrollback(struct vc_data *vc, unsigned short *p, 
+				unsigned int count) 
+{
+	int copycount;
+	struct vc_scrback *sc;
+
+	if (!count || !vc->vc_maxscrollback)
+		return;
+	if (count > vc->vc_maxscrollback) {
+		p += (count - vc->vc_maxscrollback);
+		count = vc->vc_maxscrollback;
+	}
+	if ((vc->vc_scrollbacksz + count) > vc->vc_maxscrollback) 
+		evict_scrollback(vc, count - 
+			(vc->vc_maxscrollback - vc->vc_scrollbacksz));
+	if (!vc->vc_scrollbacksz) {
+		/* no scrollback at all, start everything */
+		sc = kmalloc(sizeof(struct vc_scrback), scrback_gfpmask);
+		if (!sc) 
+			return;		/* out of memory - oh well */
+		sc->vsc_bufleft = sc->vsc_bufsize = 
+			min(vc->vc_screenbuf_size, vc->vc_maxscrollback);
+		sc->vsc_buf = sc->vsc_bufptr = 
+			kmalloc(sc->vsc_bufleft, scrback_gfpmask);
+		if (!sc->vsc_buf) {
+			kfree(sc);
+			return;
+		}
+		list_add(&sc->vsc_list, &vc->vc_scrollback);
+	} else {
+		/* if list is empty this just initializes sc, if list is not 
+		 * empty it points sc to the last entry */
+		sc = list_entry(vc->vc_scrollback.prev, struct vc_scrback,
+			vsc_list);
+	}
+
+	while (count) {
+		/* out of bufspace, alloc a new one */
+		if (!sc->vsc_bufleft) {
+			sc = kmalloc(sizeof(struct vc_scrback), 
+				scrback_gfpmask);
+			if (!sc) 
+				return;		/* drop scrollback */
+			sc->vsc_bufleft = sc->vsc_bufsize = 
+				min(vc->vc_screenbuf_size, 
+				vc->vc_maxscrollback - vc->vc_scrollbacksz);
+			sc->vsc_buf = sc->vsc_bufptr = 
+				kmalloc(sc->vsc_bufleft, scrback_gfpmask);
+			if (!sc->vsc_buf) {
+				kfree(sc);
+				return;
+			}
+			list_add_tail(&sc->vsc_list, &vc->vc_scrollback);
+		}
+		copycount = min(count, sc->vsc_bufleft);
+		scr_memcpyw(sc->vsc_bufptr, p, copycount);
+		vc->vc_scrollbacksz += copycount;
+		sc->vsc_bufleft -= copycount;
+		sc->vsc_bufptr += copycount;
+		p += copycount;
+		count -= copycount;
+	}
+}
+
 static void scrup(struct vc_data *vc, unsigned int t, unsigned int b, int nr)
 {
 	unsigned short *d, *s;
@@ -253,6 +444,10 @@
 		nr = b - t - 1;
 	if (b > vc->vc_rows || t >= b || nr < 1)
 		return;
+	if (vt_scrollback_ready && vc->vc_support_scrollback)
+		if(!t)
+			save_scrollback(vc, (unsigned short *)vc->vc_origin, 
+				nr * vc->vc_size_row);
 	if (CON_IS_VISIBLE(vc) && vc->vc_sw->con_scroll(vc, t, b, SM_UP, nr))
 		return;
 	d = (unsigned short *)(vc->vc_origin + vc->vc_size_row * t);
@@ -677,12 +872,17 @@
 	vc->vc_hi_font_mask = 0;
 	vc->vc_complement_mask = 0;
 	vc->vc_can_do_color = 0;
+	vc->vc_maxscrollback = vt_max_scrollback_dfl;
+	vc->vc_support_scrollback = 0;
 	vc->vc_sw->con_init(vc, init);
 	if (!vc->vc_complement_mask)
 		vc->vc_complement_mask = vc->vc_can_do_color ? 0x7700 : 0x0800;
 	vc->vc_s_complement_mask = vc->vc_complement_mask;
 	vc->vc_size_row = vc->vc_cols << 1;
 	vc->vc_screenbuf_size = vc->vc_rows * vc->vc_size_row;
+	vc->vc_scrollbacksz = 0;
+	vc->vc_scrollback_needsave = 1;
+	INIT_LIST_HEAD(&vc->vc_scrollback);
 }
 
 int vc_allocate(unsigned int currcons)	/* return 0 on success */
@@ -724,7 +924,8 @@
 	return 0;
 }
 
-static inline int resize_screen(struct vc_data *vc, int width, int height)
+static inline int resize_screen(struct vc_data *vc, unsigned int width, 
+				unsigned int height)
 {
 	/* Resizes the resolution of the display adapater */
 	int err = 0;
@@ -1947,8 +2148,11 @@
 	charmask = himask ? 0x1ff : 0xff;
 
 	/* undraw cursor first */
-	if (IS_FG(vc))
+	if (IS_FG(vc)) {
+		if (vc->vc_cumdelta)
+			vc->vc_sw->con_scrolldelta(vc, 0);
 		hide_cursor(vc);
+	}
 
 	while (!tty->stopped && count) {
 		int orig = *buf;
@@ -2102,7 +2306,7 @@
 	if (scrollback_delta) {
 		struct vc_data *vc = vc_cons[fg_console].d;
 		clear_selection();
-		if (vc->vc_mode == KD_TEXT)
+		if (vc->vc_mode == KD_TEXT && vc->vc_sw->con_scrolldelta)
 			vc->vc_sw->con_scrolldelta(vc, scrollback_delta);
 		scrollback_delta = 0;
 	}
@@ -2160,8 +2364,11 @@
 		goto quit;
 
 	/* undraw cursor first */
-	if (IS_FG(vc))
+	if (IS_FG(vc)) {
+		if (vc->vc_cumdelta)
+			vc->vc_sw->con_scrolldelta(vc, 0);
 		hide_cursor(vc);
+	}
 
 	start = (ushort *)vc->vc_pos;
 
@@ -2877,6 +3084,8 @@
 
 void poke_blanked_console(void)
 {
+	struct vc_data *vc = vc_cons[fg_console].d;
+
 	WARN_CONSOLE_UNLOCKED();
 
 	/* Add this so we quickly catch whoever might call us in a non
@@ -2893,7 +3102,7 @@
 	del_timer(&console_timer);
 	blank_timer_expired = 0;
 
-	if (ignore_poke || !vc_cons[fg_console].d || vc_cons[fg_console].d->vc_mode == KD_GRAPHICS)
+	if (ignore_poke || !vc || vc->vc_mode == KD_GRAPHICS)
 		return;
 	if (console_blanked)
 		unblank_screen();
diff -u -r --exclude-from=linux-2.6.12/Documentation/dontdiff linux-2.6.12/drivers/char/vt_ioctl.c linux-2.6.13-rc1-mm1-devel/drivers/char/vt_ioctl.c
--- linux-2.6.12/drivers/char/vt_ioctl.c	2005-07-12 01:45:46.000000000 -0600
+++ linux-2.6.13-rc1-mm1-devel/drivers/char/vt_ioctl.c	2005-07-12 02:04:33.000000000 -0600
@@ -37,6 +37,7 @@
 
 static char vt_dont_switch;
 extern struct tty_driver *console_driver;
+extern char vt_scrollback_ready;
 
 #define VT_IS_IN_USE(i)	(console_driver->ttys[i] && console_driver->ttys[i]->count)
 #define VT_BUSY(i)	(VT_IS_IN_USE(i) || i == fg_console || vc_cons[i].d == sel_cons)
@@ -650,6 +651,55 @@
 		return 0;
 	}
 
+	case VT_ENABLESCROLLBACK:
+	{
+		if (!perm)
+			return -EPERM;
+		vt_scrollback_ready = 1;
+		return 0;
+	}
+
+	case VT_SETSCROLLBACK:
+	{
+		struct vt_scrollparms sp;
+		int ret;
+
+		if (!perm)
+			return -EPERM;
+		if (!vt_scrollback_ready)
+			return -ENOSYS;
+		if (copy_from_user(&sp, up, sizeof(struct vt_scrollparms)))
+			return -EFAULT;
+		acquire_console_sem();
+		ret = vt_set_scrollback(&sp);
+		release_console_sem();
+		return(ret);
+	}
+
+	case VT_GETSCROLLBACK:
+	{
+		struct vt_scrollparms sp;
+
+		if (!vt_scrollback_ready)
+			return -ENOSYS;
+
+		if (copy_from_user(&sp, up, sizeof(struct vt_scrollparms)))
+			return -EFAULT;
+		acquire_console_sem();
+		if (sp.vp_con > MAX_NR_CONSOLES || !vc_cons[sp.vp_con].d || 
+		  	 !vc_cons[sp.vp_con].d->vc_support_scrollback) {
+			release_console_sem();
+			return -EINVAL;
+		}
+
+		sp.vp_size = vc_cons[sp.vp_con].d->vc_maxscrollback;
+		release_console_sem();
+
+		if (copy_to_user(up, &sp, sizeof(struct vt_scrollparms)))
+			return -EFAULT;
+		return 0;
+	}
+
 	case VT_SETMODE:
 	{
 		struct vt_mode tmp;
diff -u -r --exclude-from=linux-2.6.12/Documentation/dontdiff linux-2.6.12/drivers/video/console/vgacon.c linux-2.6.13-rc1-mm1-devel/drivers/video/console/vgacon.c
--- linux-2.6.12/drivers/video/console/vgacon.c	2005-07-12 01:45:48.000000000 -0600
+++ linux-2.6.13-rc1-mm1-devel/drivers/video/console/vgacon.c	2005-07-12 02:07:23.000000000 -0600
@@ -57,6 +57,7 @@
 static int cursor_size_lastfrom;
 static int cursor_size_lastto;
 static struct vgastate state;
+extern int vt_max_scrollback_dfl;
 
 #define BLANK 0x0020
 
@@ -339,6 +340,10 @@
 	c->vc_scan_lines = vga_scan_lines;
 	c->vc_font.height = vga_video_font_height;
 	c->vc_complement_mask = 0x7700;
+
+	/* we are willing to use vt-provided scrollback */
+	c->vc_support_scrollback = 1;
+
 	if (vga_512_chars)
 		c->vc_hi_font_mask = 0x0800;
 	p = *c->vc_uni_pagedir_loc;
@@ -365,6 +370,8 @@
 		con_free_unimap(c);
 	}
 	c->vc_uni_pagedir_loc = &c->vc_uni_pagedir;
+	if (c->vc_scrollbacksz)
+		vt_clear_scrollback(c);
 	con_set_default_unimap(c);
 }
 
@@ -962,34 +969,44 @@
 
 #endif
 
-static int vgacon_scrolldelta(struct vc_data *c, int lines)
+static int vgacon_scrolldelta(struct vc_data *c, int delta)
 {
-	if (!lines)		/* Turn scrollback off */
-		c->vc_visible_origin = c->vc_origin;
-	else {
-		int margin = c->vc_size_row * 4;
-		int ul, we, p, st;
-
-		if (vga_rolled_over >
-		    (c->vc_scr_end - vga_vram_base) + margin) {
-			ul = c->vc_scr_end - vga_vram_base;
-			we = vga_rolled_over + c->vc_size_row;
-		} else {
-			ul = 0;
-			we = vga_vram_size;
+	unsigned char *sp;
+	int gotback;
+
+	if (!c->vc_scrollbacksz) 
+		return(1);
+		
+	if (!vt_update_cumdelta(c, delta))
+		return 1;
+
+	if (!c->vc_cumdelta) {		/* Turn scrollback off */
+		scr_memcpyw((void *) c->vc_origin, (void *) c->vc_screenbuf, 
+				c->vc_screenbuf_size);
+		c->vc_scrollback_needsave = 1;
+		c->vc_cumdelta = 0;
+		vgacon_cursor(c, CM_DRAW);
+	} else {
+		vgacon_cursor(c, CM_ERASE);
+		gotback = vt_get_scrollback(&sp, c, c->vc_rows);
+
+		if (!gotback) 
+			return 1;
+			
+		if (c->vc_scrollback_needsave) {
+			scr_memcpyw((void *)c->vc_screenbuf, 
+				(void *)c->vc_origin, c->vc_screenbuf_size);
+			c->vc_scrollback_needsave = 0;
 		}
-		p = (c->vc_visible_origin - vga_vram_base - ul + we) % we +
-		    lines * c->vc_size_row;
-		st = (c->vc_origin - vga_vram_base - ul + we) % we;
-		if (st < 2 * margin)
-			margin = 0;
-		if (p < margin)
-			p = 0;
-		if (p > st - margin)
-			p = st;
-		c->vc_visible_origin = vga_vram_base + (p + ul) % we;
+	
+		if (gotback < c->vc_rows) 
+			scr_memcpyw((void *)(sp + c->vc_size_row * gotback),
+				(void *) c->vc_screenbuf, 
+				(c->vc_rows - gotback) * c->vc_size_row);
+
+		scr_memcpyw((void *)c->vc_origin, 
+			(void *)sp, c->vc_screenbuf_size);
 	}
-	vga_set_mem_top(c);
 	return 1;
 }
 
@@ -1021,9 +1038,12 @@
 	/* We can't copy in more then the size of the video buffer,
 	 * or we'll be copying in VGA BIOS */
 
-	if (!vga_is_gfx)
+	if (!vga_is_gfx) {
+		if(c->vc_cumdelta)
+			vgacon_scrolldelta(c, 0);
 		scr_memcpyw((u16 *) c->vc_screenbuf, (u16 *) c->vc_origin,
 			    c->vc_screenbuf_size > vga_vram_size ? vga_vram_size : c->vc_screenbuf_size);
+	}
 }
 
 static int vgacon_scroll(struct vc_data *c, int t, int b, int dir,
@@ -1035,7 +1055,7 @@
 	if (t || b != c->vc_rows || vga_is_gfx)
 		return 0;
 
-	if (c->vc_origin != c->vc_visible_origin)
+	if (c->vc_cumdelta)
 		vgacon_scrolldelta(c, 0);
 
 	if (!vga_hardscroll_enabled || lines >= c->vc_rows / 2)
@@ -1054,7 +1074,7 @@
 			c->vc_origin += delta;
 		scr_memsetw((u16 *) (c->vc_origin + c->vc_screenbuf_size -
 				     delta), c->vc_video_erase_char,
-			    delta);
+		 	    delta);
 	} else {
 		if (oldo - delta < vga_vram_base) {
 			scr_memmovew((u16 *) (vga_vram_end -
@@ -1076,6 +1096,17 @@
 	return 1;
 }
 
+/* 
+ * we don't really do anything here except erase all the old scrollback
+ * that's stored at the wrong resolution 
+ */
+static int vgacon_resize(struct vc_data *c, unsigned int width, 
+				unsigned int height) 
+{
+	if (c->vc_scrollbacksz)
+		vt_clear_scrollback(c);
+	return 0;
+}
 
 /*
  *  The console `switch' structure for the VGA based console
@@ -1083,6 +1114,8 @@
 
 static int vgacon_dummy(struct vc_data *c)
 {
+	if (c->vc_cumdelta)
+		vgacon_scrolldelta(c, 0);
 	return 0;
 }
 
@@ -1100,6 +1133,7 @@
 	.con_scroll = vgacon_scroll,
 	.con_bmove = DUMMY,
 	.con_switch = vgacon_switch,
+	.con_resize = vgacon_resize,
 	.con_blank = vgacon_blank,
 	.con_font_set = vgacon_font_set,
 	.con_font_get = vgacon_font_get,
diff -u -r --exclude-from=linux-2.6.12/Documentation/dontdiff linux-2.6.12/include/linux/console_struct.h linux-2.6.13-rc1-mm1-devel/include/linux/console_struct.h
--- linux-2.6.12/include/linux/console_struct.h	2005-06-17 13:48:29.000000000 -0600
+++ linux-2.6.13-rc1-mm1-devel/include/linux/console_struct.h	2005-07-12 02:08:06.000000000 -0600
@@ -13,6 +13,14 @@
 
 #define NPAR 16
 
+struct vc_scrback {
+	struct list_head		vsc_list;
+	unsigned char	*vsc_buf;
+	unsigned char	*vsc_bufptr;
+	unsigned int	vsc_bufleft;
+	unsigned int	vsc_bufsize;
+};
+
 struct vc_data {
 	unsigned short	vc_num;			/* Console number */
 	unsigned int	vc_cols;		/* [#] Console size */
@@ -26,6 +34,13 @@
 	const struct consw *vc_sw;
 	unsigned short	*vc_screenbuf;		/* In-memory character/attribute buffer */
 	unsigned int	vc_screenbuf_size;
+	/* scrollback */
+	struct list_head	vc_scrollback;
+	unsigned int	vc_scrollbacksz;	/* no. bytes in scrollback */
+	unsigned int	vc_maxscrollback;	/* max scrollback size */
+	int		vc_cumdelta;		/* cumulative delta */
+	short		vc_scrollback_needsave;	
+	int		vc_support_scrollback : 1; /* driver support? */
 	unsigned char	vc_mode;		/* KD_TEXT, ... */
 	/* attributes for all characters on screen */
 	unsigned char	vc_attr;		/* Current attributes */
diff -u -r --exclude-from=linux-2.6.12/Documentation/dontdiff linux-2.6.12/include/linux/vt.h linux-2.6.13-rc1-mm1-devel/include/linux/vt.h
--- linux-2.6.12/include/linux/vt.h	2005-06-17 13:48:29.000000000 -0600
+++ linux-2.6.13-rc1-mm1-devel/include/linux/vt.h	2005-07-10 23:12:13.000000000 -0600
@@ -51,4 +51,12 @@
 #define VT_LOCKSWITCH   0x560B  /* disallow vt switching */
 #define VT_UNLOCKSWITCH 0x560C  /* allow vt switching */
 
+#define VT_ENABLESCROLLBACK	0x560D	/* turn on global scrollback */
+#define VT_SETSCROLLBACK	0x560E	/* change scrollback properties */
+#define VT_GETSCROLLBACK	0x560F	/* get scrollback properties */
+
+struct vt_scrollparms {
+	unsigned int	vp_con;
+	unsigned int	vp_size;
+};
 #endif /* _LINUX_VT_H */
diff -u -r --exclude-from=linux-2.6.12/Documentation/dontdiff linux-2.6.12/include/linux/vt_kern.h linux-2.6.13-rc1-mm1-devel/include/linux/vt_kern.h
--- linux-2.6.12/include/linux/vt_kern.h	2005-06-17 13:48:29.000000000 -0600
+++ linux-2.6.13-rc1-mm1-devel/include/linux/vt_kern.h	2005-07-12 02:08:23.000000000 -0600
@@ -46,6 +46,12 @@
 void scrollfront(struct vc_data *vc, int lines);
 void update_region(struct vc_data *vc, unsigned long start, int count);
 void redraw_screen(struct vc_data *vc, int is_switch);
+int vt_set_scrollback(struct vt_scrollparms *sc);
+void vt_clear_scrollback(struct vc_data *vc);
+unsigned int vt_get_scrollback(unsigned char **rb, struct vc_data *vc, 
+				unsigned int needlines);
+int vt_update_cumdelta(struct vc_data *c, int delta);
+
 #define update_screen(x) redraw_screen(x, 0)
 #define switch_screen(x) redraw_screen(x, 1)
 

--k1lZvvs/B4yU6o8G
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="cfgscroll.c"

#include <stdio.h>
#include <unistd.h>
#include <sysexits.h>
#include <string.h>
#include <stdlib.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <linux/vt.h>

struct vt_scrollparms sp;

int openconsole(void) {
	char *dev = "/dev/console";
	int fd;

	fd = open(dev, O_RDWR);
	if(fd == -1) {
		perror("unable to open console");
		return(-1);
	}
	return(fd);
}

int enable_scrollback(void) {
	int ret, fd;
	fd = openconsole();

	if(fd == -1)
		return(EX_TEMPFAIL);

	ret = ioctl(fd, VT_ENABLESCROLLBACK);
	if(ret == -1) {
		perror("unable to enable scrollback");
		return(EX_TEMPFAIL);
	}
	return(EX_OK);
}

int set_scrollback(void) {
	int ret, fd;

	fd = openconsole();

	if(fd == -1)
		return(EX_TEMPFAIL);

	ret = ioctl(fd, VT_SETSCROLLBACK, &sp);
	if(ret == -1) {
		perror("unable to configure scrollback");
		return(EX_TEMPFAIL);
	}
	return(EX_OK);
}

int get_scrollback(void) {
	int ret, fd;

	fd = openconsole();

	if(fd == -1)
		return(EX_TEMPFAIL);
	
	ret = ioctl(fd, VT_GETSCROLLBACK, &sp);
	if(ret == -1) {
		perror("unable to get scrollback parameters");
		return(EX_TEMPFAIL);
	}
	return(EX_OK);
}

int clear_scrollback(void) {
	unsigned int savesize;
	int ret;

	ret = get_scrollback();
	if(ret != EX_OK) 
		return(ret);

	savesize = sp.vp_size;
	sp.vp_size = 0;

	ret = set_scrollback();
	if(ret != EX_OK)
		return(ret);

	sp.vp_size = savesize;

	return(set_scrollback());
}
	
int main(int argc, char **argv) {
	/* usage: cfgscroll -e
	   enable global scrollback (cannot be disabled)
	   usage: cfgscroll -s con size
	   set scrollback for specific console
	   usage: cfgscroll -g con
	   get scrollback for specific console
	   usage: cfgscroll -c con
	   clear scrollback for specific console */
	int ret;

	if(argc == 2) {
		if(!strcmp(argv[1], "-e")) 
			return(enable_scrollback());
		goto dispusage;
	} else if(argc == 3) {
		if(!strcmp(argv[1], "-g")) {
			sscanf(argv[2], "%u", &sp.vp_con);
			ret = get_scrollback();
			if(ret == EX_OK);
				printf("console %u: max scrollback = %u\n", sp.vp_con, sp.vp_size);
			return(ret);
		} else if(!strcmp(argv[1], "-c")) {
			sscanf(argv[2], "%u", &sp.vp_con);
			return(clear_scrollback());
		}
		goto dispusage;
	} else if(argc == 4) {
		if(!strcmp(argv[1], "-s")) {
			sscanf(argv[2], "%u", &sp.vp_con);
			sscanf(argv[3], "%u", &sp.vp_size);
			return(set_scrollback());
		}
	}

dispusage:
	printf("usage: cfgscroll [-e] || [-s console size] || [-g console] || [-c console]\n");
	exit(EX_USAGE);
}
			

--k1lZvvs/B4yU6o8G--
