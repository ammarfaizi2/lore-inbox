Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265455AbUFCChu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265455AbUFCChu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 22:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265462AbUFCChu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 22:37:50 -0400
Received: from havoc.gtf.org ([216.162.42.101]:24961 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S265455AbUFCCgz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 22:36:55 -0400
Date: Wed, 2 Jun 2004 22:36:53 -0400
From: David Eger <eger@havoc.gtf.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] fb accel capabilities (resend against 2.6.7-rc2)
Message-ID: <20040603023653.GA20951@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dear Andrew,

I've updated the framebuffer accel capabilities patch to 2.6.7-rc2.
Please apply the core fb-accel-capabilities patch to -mm.

I'm sending the individual driver updates to the driver maintainers.

-dte


Baseline patch to make framebuffer/fbcon interaction more sane by 
basing the fbcon heuristics on capabilities advertized by underlying 
framebuffer via the fb_info.flags field.
    
This patch updates fbcon, fb.h, and skeletonfb.c.
It does *not* yet update the drivers themselves.  They should compile 
and work, but their hinting is not correct yet, meaning most fb drivers
will be slow until I set the flags to the right hinting driver-by-driver

Signed-off-by: David Eger <eger@havoc.gtf.org>

#
# include/linux/fb.h
#   2004/06/02 22:07:12+02:00 eger@rosencrantz.theboonies.us +46 -6
#   accel flags consolidated in fbinfo.flags
# 
# drivers/video/skeletonfb.c
#   2004/06/02 22:07:12+02:00 eger@rosencrantz.theboonies.us +7 -1
#   update skeletonfb to reflect fb driver writer's new responsibility to advertise
#   what hw acceleration their driver provides
# 
# drivers/video/console/fbcon.h
#   2004/06/02 22:07:12+02:00 eger@rosencrantz.theboonies.us +19 -32
#   Make scrollmode reflect the current options for scrolling: pan, wrap, 
#   2.6-style accel (fillrect(), copyarea()), and redrawing
# 
# drivers/video/console/fbcon.c
#   2004/06/02 22:07:12+02:00 eger@rosencrantz.theboonies.us +50 -47
#   make fbcon parse new fbinfo flags to determine proper method of acceleration:
#   fixes slow console in many 2.6 drivers
# 
diff -Nru a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
--- a/drivers/video/console/fbcon.c	Wed Jun  2 22:21:20 2004
+++ b/drivers/video/console/fbcon.c	Wed Jun  2 22:21:20 2004
@@ -601,8 +601,9 @@
 	int display_fg = (*default_mode)->vc_num;
 	int logo = 1, rows, cols, charcnt = 256;
 	unsigned short *save = NULL, *r, *q;
+	int cap = info->flags;
 
-	if (vc->vc_num != display_fg || (info->flags & FBINFO_FLAG_MODULE) ||
+	if (vc->vc_num != display_fg || (info->flags & FBINFO_MODULE) ||
 	    (info->fix.type == FB_TYPE_TEXT))
 		logo = 0;
 
@@ -635,10 +636,10 @@
 	rows = info->var.yres / vc->vc_font.height;
 	vc_resize(vc->vc_num, cols, rows);
 
-	if (info->var.accel_flags)
-		p->scrollmode = SCROLL_YNOMOVE;
-	else
-		p->scrollmode = SCROLL_YREDRAW;
+	if ((cap & FBINFO_HWACCEL_COPYAREA) && !(cap & FBINFO_HWACCEL_DISABLED))
+		p->scrollmode = SCROLL_ACCEL;
+	else /* default to something safe */
+		p->scrollmode = SCROLL_REDRAW;
 
 	/*
 	 *  ++guenther: console.c:vc_allocate() relies on initializing
@@ -1245,7 +1246,7 @@
 {
 	struct fb_info *info = registered_fb[(int) con2fb_map[vc->vc_num]];
 	struct display *p = &fb_display[vc->vc_num];
-	int scroll_partial = !(p->scrollmode & __SCROLL_YNOPARTIAL);
+	int scroll_partial = info->flags & FBINFO_PARTIAL_PAN_OK;
 
 	if (!info->fbops->fb_blank && console_blanked)
 		return 0;
@@ -1269,15 +1270,15 @@
 			fbcon_softback_note(vc, t, count);
 		if (logo_shown >= 0)
 			goto redraw_up;
-		switch (p->scrollmode & __SCROLL_YMASK) {
-		case __SCROLL_YMOVE:
+		switch (p->scrollmode) {
+		case SCROLL_ACCEL:
 			accel_bmove(vc, info, t + count, 0, t, 0,
 					 b - t - count, vc->vc_cols);
 			accel_clear(vc, info, b - count, 0, count,
 					 vc->vc_cols);
 			break;
 
-		case __SCROLL_YWRAP:
+		case SCROLL_WRAP:
 			if (b - t - count > 3 * vc->vc_rows >> 2) {
 				if (t > 0)
 					fbcon_bmove(vc, 0, 0, count, 0, t,
@@ -1287,15 +1288,15 @@
 					fbcon_bmove(vc, b - count, 0, b, 0,
 						    vc->vc_rows - b,
 						    vc->vc_cols);
-			} else if (p->scrollmode & __SCROLL_YPANREDRAW)
-				goto redraw_up;
-			else
+			} else if (info->flags & FBINFO_READS_FAST)
 				fbcon_bmove(vc, t + count, 0, t, 0,
 					    b - t - count, vc->vc_cols);
+			else
+				goto redraw_up;
 			fbcon_clear(vc, b - count, 0, count, vc->vc_cols);
 			break;
 
-		case __SCROLL_YPAN:
+		case SCROLL_PAN:
 			if ((p->yscroll + count <=
 			     2 * (p->vrows - vc->vc_rows))
 			    && ((!scroll_partial && (b - t == vc->vc_rows))
@@ -1310,15 +1311,15 @@
 					fbcon_bmove(vc, b - count, 0, b, 0,
 						    vc->vc_rows - b,
 						    vc->vc_cols);
-			} else if (p->scrollmode & __SCROLL_YPANREDRAW)
-				goto redraw_up;
-			else
+			} else if (info->flags & FBINFO_READS_FAST)
 				fbcon_bmove(vc, t + count, 0, t, 0,
 					    b - t - count, vc->vc_cols);
+			else
+				goto redraw_up;
 			fbcon_clear(vc, b - count, 0, count, vc->vc_cols);
 			break;
 
-		case __SCROLL_YREDRAW:
+		case SCROLL_REDRAW:
 		      redraw_up:
 			fbcon_redraw(vc, p, t, b - t - count,
 				     count * vc->vc_cols);
@@ -1336,14 +1337,14 @@
 	case SM_DOWN:
 		if (count > vc->vc_rows)	/* Maximum realistic size */
 			count = vc->vc_rows;
-		switch (p->scrollmode & __SCROLL_YMASK) {
-		case __SCROLL_YMOVE:
+		switch (p->scrollmode) {
+		case SCROLL_ACCEL:
 			accel_bmove(vc, info, t, 0, t + count, 0,
 					 b - t - count, vc->vc_cols);
 			accel_clear(vc, info, t, 0, count, vc->vc_cols);
 			break;
 
-		case __SCROLL_YWRAP:
+		case SCROLL_WRAP:
 			if (b - t - count > 3 * vc->vc_rows >> 2) {
 				if (vc->vc_rows - b > 0)
 					fbcon_bmove(vc, b, 0, b - count, 0,
@@ -1353,15 +1354,15 @@
 				if (t > 0)
 					fbcon_bmove(vc, count, 0, 0, 0, t,
 						    vc->vc_cols);
-			} else if (p->scrollmode & __SCROLL_YPANREDRAW)
-				goto redraw_down;
-			else
+			} else if (info->flags & FBINFO_READS_FAST)
 				fbcon_bmove(vc, t, 0, t + count, 0,
 					    b - t - count, vc->vc_cols);
+			else
+				goto redraw_down;
 			fbcon_clear(vc, t, 0, count, vc->vc_cols);
 			break;
 
-		case __SCROLL_YPAN:
+		case SCROLL_PAN:
 			if ((count - p->yscroll <= p->vrows - vc->vc_rows)
 			    && ((!scroll_partial && (b - t == vc->vc_rows))
 				|| (scroll_partial
@@ -1375,15 +1376,15 @@
 				if (t > 0)
 					fbcon_bmove(vc, count, 0, 0, 0, t,
 						    vc->vc_cols);
-			} else if (p->scrollmode & __SCROLL_YPANREDRAW)
-				goto redraw_down;
-			else
+			} else if (info->flags & FBINFO_READS_FAST)
 				fbcon_bmove(vc, t, 0, t + count, 0,
 					    b - t - count, vc->vc_cols);
+			else
+				goto redraw_down;
 			fbcon_clear(vc, t, 0, count, vc->vc_cols);
 			break;
 
-		case __SCROLL_YREDRAW:
+		case SCROLL_REDRAW:
 		      redraw_down:
 			fbcon_redraw(vc, p, b - 1, b - t - count,
 				     -count * vc->vc_cols);
@@ -1467,21 +1468,23 @@
 
 static __inline__ void updatescrollmode(struct display *p, struct fb_info *info, struct vc_data *vc)
 {
-	int m;
+	int cap = info->flags;
 
-	if (p->scrollmode & __SCROLL_YFIXED)
-		return;
-	if (divides(info->fix.ywrapstep, vc->vc_font.height) &&
-	    divides(vc->vc_font.height, info->var.yres_virtual))
-		m = __SCROLL_YWRAP;
-	else if (divides(info->fix.ypanstep, vc->vc_font.height) &&
+	if ((cap & FBINFO_HWACCEL_COPYAREA) && !(cap & FBINFO_HWACCEL_DISABLED))
+		p->scrollmode = SCROLL_ACCEL;
+	else if ((cap & FBINFO_HWACCEL_YWRAP) &&
+		 divides(info->fix.ywrapstep, vc->vc_font.height) &&
+		 divides(vc->vc_font.height, info->var.yres_virtual))
+		p->scrollmode = SCROLL_WRAP;
+	else if ((cap & FBINFO_HWACCEL_YPAN) &&
+		 divides(info->fix.ypanstep, vc->vc_font.height) &&
 		 info->var.yres_virtual >= info->var.yres + vc->vc_font.height)
-		m = __SCROLL_YPAN;
-	else if (p->scrollmode & __SCROLL_YNOMOVE)
-		m = __SCROLL_YREDRAW;
+		p->scrollmode = SCROLL_PAN;
+	else if (cap & FBINFO_READS_FAST)
+		/* okay, we'll use software version of accel funcs... */
+		p->scrollmode = SCROLL_ACCEL; 
 	else
-		m = __SCROLL_YMOVE;
-	p->scrollmode = (p->scrollmode & ~__SCROLL_YMASK) | m;
+		p->scrollmode = SCROLL_REDRAW;
 }
 
 static int fbcon_resize(struct vc_data *vc, unsigned int width, 
@@ -1555,12 +1558,12 @@
 	}
 	if (info)
 		info->var.yoffset = p->yscroll = 0;
-        fbcon_resize(vc, vc->vc_cols, vc->vc_rows);
-	switch (p->scrollmode & __SCROLL_YMASK) {
-	case __SCROLL_YWRAP:
+ 	fbcon_resize(vc, vc->vc_cols, vc->vc_rows);
+	switch (p->scrollmode) {
+	case SCROLL_WRAP:
 		scrollback_phys_max = p->vrows - vc->vc_rows;
 		break;
-	case __SCROLL_YPAN:
+	case SCROLL_PAN:
 		scrollback_phys_max = p->vrows - 2 * vc->vc_rows;
 		if (scrollback_phys_max < 0)
 			scrollback_phys_max = 0;
@@ -2133,11 +2136,11 @@
 
 	offset = p->yscroll - scrollback_current;
 	limit = p->vrows;
-	switch (p->scrollmode && __SCROLL_YMASK) {
-	case __SCROLL_YWRAP:
+	switch (p->scrollmode) {
+	case SCROLL_WRAP:
 		info->var.vmode |= FB_VMODE_YWRAP;
 		break;
-	case __SCROLL_YPAN:
+	case SCROLL_PAN:
 		limit -= vc->vc_rows;
 		info->var.vmode &= ~FB_VMODE_YWRAP;
 		break;
diff -Nru a/drivers/video/console/fbcon.h b/drivers/video/console/fbcon.h
--- a/drivers/video/console/fbcon.h	Wed Jun  2 22:21:20 2004
+++ b/drivers/video/console/fbcon.h	Wed Jun  2 22:21:20 2004
@@ -67,40 +67,27 @@
      *  Scroll Method
      */
      
-/* Internal flags */
-#define __SCROLL_YPAN		0x001
-#define __SCROLL_YWRAP		0x002
-#define __SCROLL_YMOVE		0x003
-#define __SCROLL_YREDRAW	0x004
-#define __SCROLL_YMASK		0x00f
-#define __SCROLL_YFIXED		0x010
-#define __SCROLL_YNOMOVE	0x020
-#define __SCROLL_YPANREDRAW	0x040
-#define __SCROLL_YNOPARTIAL	0x080
-
-/* Only these should be used by the drivers */
-/* Which one should you use? If you have a fast card and slow bus,
-   then probably just 0 to indicate fbcon should choose between
-   YWRAP/YPAN+MOVE/YMOVE. On the other side, if you have a fast bus
-   and even better if your card can do fonting (1->8/32bit painting),
-   you should consider either SCROLL_YREDRAW (if your card is
-   able to do neither YPAN/YWRAP), or SCROLL_YNOMOVE.
-   The best is to test it with some real life scrolling (usually, not
-   all lines on the screen are filled completely with non-space characters,
-   and REDRAW performs much better on such lines, so don't cat a file
-   with every line covering all screen columns, it would not be the right
-   benchmark).
+/* There are several methods fbcon can use to move text around the screen:
+ *
+ * + use the hardware engine to move the text
+ *    (hw-accelerated copyarea() and fillrect())
+ * + use hardware-supported panning on a large virtual screen
+ * + amifb can not only pan, but also wrap the display by N lines
+ *    (i.e. visible line i = physical line (i+N) % yres).
+ * + read what's already rendered on the screen and
+ *     write it in a different place (this is cfb_copyarea())
+ * + re-render the text to the screen
+ *
+ * Whether to use wrapping or panning can only be figured out at 
+ * runtime (when we know whether our font height is a multiple
+ * of the pan/wrap step)
+ *
  */
-#define SCROLL_YREDRAW		(__SCROLL_YFIXED|__SCROLL_YREDRAW)
-#define SCROLL_YNOMOVE		(__SCROLL_YNOMOVE|__SCROLL_YPANREDRAW)
 
-/* SCROLL_YNOPARTIAL, used in combination with the above, is for video
-   cards which can not handle using panning to scroll a portion of the
-   screen without excessive flicker.  Panning will only be used for
-   whole screens.
- */
-/* Namespace consistency */
-#define SCROLL_YNOPARTIAL	__SCROLL_YNOPARTIAL
+#define SCROLL_ACCEL	0x001
+#define SCROLL_PAN	0x002
+#define SCROLL_WRAP	0x003
+#define SCROLL_REDRAW	0x004
 
 extern int fb_console_init(void);
 
diff -Nru a/drivers/video/skeletonfb.c b/drivers/video/skeletonfb.c
--- a/drivers/video/skeletonfb.c	Wed Jun  2 22:21:20 2004
+++ b/drivers/video/skeletonfb.c	Wed Jun  2 22:21:20 2004
@@ -539,7 +539,13 @@
     info.fbops = &xxxfb_ops;
     info.fix = xxxfb_fix;
     info.pseudo_palette = pseudo_palette;
-    info.flags = FBINFO_FLAG_DEFAULT;
+
+    /*
+     * Set up flags to indicate what sort of acceleration your
+     * driver can provide (pan/wrap/copyarea/etc.) and whether it 
+     * is a module -- see FBINFO_* in include/linux/fb.h
+     */
+    info.flags = FBINFO_DEFAULT;
     info.par = current_par;
 
     /*
diff -Nru a/include/linux/fb.h b/include/linux/fb.h
--- a/include/linux/fb.h	Wed Jun  2 22:21:20 2004
+++ b/include/linux/fb.h	Wed Jun  2 22:21:20 2004
@@ -125,7 +125,8 @@
 	unsigned long mmio_start;	/* Start of Memory Mapped I/O   */
 					/* (physical address) */
 	__u32 mmio_len;			/* Length of Memory Mapped I/O  */
-	__u32 accel;			/* Type of acceleration available */
+	__u32 accel;			/* Indicate to driver which	*/
+					/*  specific chip/card we have	*/
 	__u16 reserved[3];		/* Reserved for future compatibility */
 };
 
@@ -154,7 +155,7 @@
 #define FB_ACTIVATE_ALL	       64	/* change all VCs on this fb	*/
 #define FB_ACTIVATE_FORCE     128	/* force apply even when no change*/
 
-#define FB_ACCELF_TEXT		1	/* text mode acceleration */
+#define FB_ACCELF_TEXT		1	/* (OBSOLETE) see fb_info.flags and vc_mode */
 
 #define FB_SYNC_HOR_HIGH_ACT	1	/* horizontal sync high active	*/
 #define FB_SYNC_VERT_HIGH_ACT	2	/* vertical sync high active	*/
@@ -200,7 +201,7 @@
 	__u32 height;			/* height of picture in mm    */
 	__u32 width;			/* width of picture in mm     */
 
-	__u32 accel_flags;		/* acceleration flags (hints)	*/
+	__u32 accel_flags;		/* (OBSOLETE) see fb_info.flags */
 
 	/* Timing: All values in pixclocks, except pixclock (of course) */
 	__u32 pixclock;			/* pixel clock in ps (pico seconds) */
@@ -502,10 +503,37 @@
 	int (*fb_mmap)(struct fb_info *info, struct file *file, struct vm_area_struct *vma);
 };
 
+/* FBINFO_* = fb_info.flags bit flags */
+#define FBINFO_MODULE		0x0001	/* Low-level driver is a module */
+#define FBINFO_HWACCEL_DISABLED	0x0002
+	/* When FBINFO_HWACCEL_DISABLED is set:
+	 *  Hardware acceleration is turned off.  Software implementations 
+	 *  of required functions (copyarea(), fillrect(), and imageblit())
+	 *  takes over; acceleration engine should be in a quiescent state */
+
+/* hints */
+#define FBINFO_PARTIAL_PAN_OK	0x0040 /* otw use pan only for double-buffering */
+#define FBINFO_READS_FAST	0x0080 /* soft-copy faster than rendering */
+
+/* hardware supported ops */
+/*  semantics: when a bit is set, it indicates that the operation is
+ *   accelerated by hardware.  
+ *  required functions will still work even if the bit is not set.  
+ *  optional functions may not even exist if the flag bit is not set.
+ */
+#define FBINFO_HWACCEL_NONE		0x0000
+#define FBINFO_HWACCEL_COPYAREA		0x0100 /* required */
+#define FBINFO_HWACCEL_FILLRECT		0x0200 /* required */
+#define FBINFO_HWACCEL_IMAGEBLIT	0x0400 /* required */
+#define FBINFO_HWACCEL_ROTATE		0x0800 /* optional */
+#define FBINFO_HWACCEL_XPAN		0x1000 /* optional */
+#define FBINFO_HWACCEL_YPAN		0x2000 /* optional */
+#define FBINFO_HWACCEL_YWRAP		0x4000 /* optional */
+
+
 struct fb_info {
 	int node;
 	int flags;
-#define FBINFO_FLAG_MODULE	1	/* Low-level driver is a module */
 	struct fb_var_screeninfo var;	/* Current var */
 	struct fb_fix_screeninfo fix;	/* Current fix */
 	struct fb_monspecs monspecs;	/* Current Monitor specs */
@@ -527,10 +555,22 @@
 };
 
 #ifdef MODULE
-#define FBINFO_FLAG_DEFAULT	FBINFO_FLAG_MODULE
+#define FBINFO_DEFAULT	FBINFO_MODULE
 #else
-#define FBINFO_FLAG_DEFAULT	0
+#define FBINFO_DEFAULT	0
 #endif
+
+// This will go away
+#define FBINFO_FLAG_MODULE	FBINFO_MODULE
+#define FBINFO_FLAG_DEFAULT	FBINFO_DEFAULT
+
+/* This will go away
+ * fbset currently hacks in FB_ACCELF_TEXT into var.accel_flags
+ * when it wants to turn the acceleration engine on.  This is
+ * really a separate operation, and should be modified via sysfs.
+ *  But for now, we leave it broken with the following define
+ */
+#define STUPID_ACCELF_TEXT_SHIT
 
 // This will go away
 #if defined(__sparc__)
