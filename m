Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932191AbVKKHwm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191AbVKKHwm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 02:52:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbVKKHwm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 02:52:42 -0500
Received: from zproxy.gmail.com ([64.233.162.202]:45191 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932191AbVKKHwl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 02:52:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Ox6mCya08LB72CmH1p0SS8k4hFy+G+q9mosZRXzAxmT3Anh1CoKikfBK66bnjT22HZF5y/ICdFjPOGRDc8NIXXVe+0zYRZ4QS6tahYuFl+pcXvpmflUksQckNrtXvR37ZTPlHIkZ73Zbm4TeB+7bbrTFthZ7WRYfF/JNe70rJbE=
Message-ID: <43744DA8.5060007@gmail.com>
Date: Fri, 11 Nov 2005 15:52:08 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
CC: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.14-mm2: loop detected in depmod
References: <20051110203544.027e992c.akpm@osdl.org> <43742AD6.7060407@ens-lyon.org>
In-Reply-To: <43742AD6.7060407@ens-lyon.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brice Goglin wrote:
> Andrew Morton wrote:
> 
> WARNING: Module
> /lib/modules/2.6.14-mm2/kernel/drivers/video/console/fbcon_ud.ko
> ignored, due to loop

Sorry about that, did only a make modules without a make modules_install.
Try this patch.

Tony

Exporting struct fb_display produces this warning error on depmod:

WARNING: Module
/lib/modules/2.6.14-mm2/kernel/drivers/video/console/fbcon_ud.ko
ignored, due to loop
WARNING: Module
/lib/modules/2.6.14-mm2/kernel/drivers/video/console/fbcon_rotate.ko
ignored, due to loop
WARNING: Module
/lib/modules/2.6.14-mm2/kernel/drivers/video/console/fbcon_cw.ko
ignored, due to loop
WARNING: Module
/lib/modules/2.6.14-mm2/kernel/drivers/video/console/fbcon_ccw.ko
ignored, due to loop
WARNING: Module
/lib/modules/2.6.14-mm2/kernel/drivers/video/console/fbcon.ko ignored,
due to loop
WARNING: Loop detected:
/lib/modules/2.6.14-mm2/kernel/drivers/video/console/bitblit.ko needs

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 fbcon.c     |   15 ++++++---------
 fbcon.h     |    3 +--
 fbcon_ccw.c |   14 ++++++--------
 fbcon_cw.c  |   14 ++++++--------
 fbcon_ud.c  |   22 ++++++++++------------
 5 files changed, 29 insertions(+), 39 deletions(-)

diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index e7802ff..bcea87c 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -106,8 +106,7 @@ enum {
 	FBCON_LOGO_DONTSHOW	= -3	/* do not show the logo */
 };
 
-struct display fb_display[MAX_NR_CONSOLES];
-EXPORT_SYMBOL(fb_display);
+static struct display fb_display[MAX_NR_CONSOLES];
 
 static signed char con2fb_map[MAX_NR_CONSOLES];
 static signed char con2fb_map_boot[MAX_NR_CONSOLES];
@@ -653,13 +652,12 @@ static void set_blitting_type(struct vc_
 {
 	struct fbcon_ops *ops = info->fbcon_par;
 
+	ops->p = (p) ? p : &fb_display[vc->vc_num];
+
 	if ((info->flags & FBINFO_MISC_TILEBLITTING))
 		fbcon_set_tileops(vc, info, p, ops);
 	else {
-		struct display *disp;
-
-		disp = (p) ? p : &fb_display[vc->vc_num];
-		fbcon_set_rotation(info, disp);
+		fbcon_set_rotation(info, ops->p);
 		fbcon_set_bitops(ops);
 	}
 }
@@ -668,11 +666,10 @@ static void set_blitting_type(struct vc_
 			      struct display *p)
 {
 	struct fbcon_ops *ops = info->fbcon_par;
-	struct display *disp;
 
 	info->flags &= ~FBINFO_MISC_TILEBLITTING;
-	disp = (p) ? p : &fb_display[vc->vc_num];
-	fbcon_set_rotation(info, disp);
+	ops->p = (p) ? p : &fb_display[vc->vc_num];
+	fbcon_set_rotation(info, ops->p);
 	fbcon_set_bitops(ops);
 }
 #endif /* CONFIG_MISC_TILEBLITTING */
diff --git a/drivers/video/console/fbcon.h b/drivers/video/console/fbcon.h
index accfd7b..6892e7f 100644
--- a/drivers/video/console/fbcon.h
+++ b/drivers/video/console/fbcon.h
@@ -52,8 +52,6 @@ struct display {
     struct fb_videomode *mode;
 };
 
-extern struct display fb_display[];
-
 struct fbcon_ops {
 	void (*bmove)(struct vc_data *vc, struct fb_info *info, int sy,
 		      int sx, int dy, int dx, int height, int width);
@@ -73,6 +71,7 @@ struct fbcon_ops {
 	struct fb_var_screeninfo var;  /* copy of the current fb_var_screeninfo */
 	struct timer_list cursor_timer; /* Cursor timer */
 	struct fb_cursor cursor_state;
+	struct display *p;
         int    currcon;	                /* Current VC. */
 	int    cursor_flash;
 	int    cursor_reset;
diff --git a/drivers/video/console/fbcon_ccw.c b/drivers/video/console/fbcon_ccw.c
index 680aaba..3afd1ee 100644
--- a/drivers/video/console/fbcon_ccw.c
+++ b/drivers/video/console/fbcon_ccw.c
@@ -63,9 +63,9 @@ static inline void ccw_update_attr(u8 *d
 static void ccw_bmove(struct vc_data *vc, struct fb_info *info, int sy,
 		     int sx, int dy, int dx, int height, int width)
 {
-	struct display *p = &fb_display[vc->vc_num];
+	struct fbcon_ops *ops = info->fbcon_par;
 	struct fb_copyarea area;
-	u32 vyres = GETVYRES(p->scrollmode, info);
+	u32 vyres = GETVYRES(ops->p->scrollmode, info);
 
 	area.sx = sy * vc->vc_font.height;
 	area.sy = vyres - ((sx + width) * vc->vc_font.width);
@@ -80,10 +80,10 @@ static void ccw_bmove(struct vc_data *vc
 static void ccw_clear(struct vc_data *vc, struct fb_info *info, int sy,
 		     int sx, int height, int width)
 {
-	struct display *p = &fb_display[vc->vc_num];
+	struct fbcon_ops *ops = info->fbcon_par;
 	struct fb_fillrect region;
 	int bgshift = (vc->vc_hi_font_mask) ? 13 : 12;
-	u32 vyres = GETVYRES(p->scrollmode, info);
+	u32 vyres = GETVYRES(ops->p->scrollmode, info);
 
 	region.color = attr_bgcol_ec(bgshift,vc);
 	region.dx = sy * vc->vc_font.height;
@@ -131,7 +131,6 @@ static void ccw_putcs(struct vc_data *vc
 		      int fg, int bg)
 {
 	struct fb_image image;
-	struct display *p = &fb_display[vc->vc_num];
 	struct fbcon_ops *ops = info->fbcon_par;
 	u32 width = (vc->vc_font.height + 7)/8;
 	u32 cellsize = width * vc->vc_font.width;
@@ -141,7 +140,7 @@ static void ccw_putcs(struct vc_data *vc
 	u32 cnt, pitch, size;
 	u32 attribute = get_attribute(info, scr_readw(s));
 	u8 *dst, *buf = NULL;
-	u32 vyres = GETVYRES(p->scrollmode, info);
+	u32 vyres = GETVYRES(ops->p->scrollmode, info);
 
 	if (!ops->fontbuffer)
 		return;
@@ -397,9 +396,8 @@ static void ccw_cursor(struct vc_data *v
 int ccw_update_start(struct fb_info *info)
 {
 	struct fbcon_ops *ops = info->fbcon_par;
-	struct display *p = &fb_display[ops->currcon];
 	u32 yoffset;
-	u32 vyres = GETVYRES(p->scrollmode, info);
+	u32 vyres = GETVYRES(ops->p->scrollmode, info);
 	int err;
 
 	yoffset = (vyres - info->var.yres) - ops->var.xoffset;
diff --git a/drivers/video/console/fbcon_cw.c b/drivers/video/console/fbcon_cw.c
index 6c6f3b6..6d92b84 100644
--- a/drivers/video/console/fbcon_cw.c
+++ b/drivers/video/console/fbcon_cw.c
@@ -49,9 +49,9 @@ static inline void cw_update_attr(u8 *ds
 static void cw_bmove(struct vc_data *vc, struct fb_info *info, int sy,
 		     int sx, int dy, int dx, int height, int width)
 {
-	struct display *p = &fb_display[vc->vc_num];
+	struct fbcon_ops *ops = info->fbcon_par;
 	struct fb_copyarea area;
-	u32 vxres = GETVXRES(p->scrollmode, info);
+	u32 vxres = GETVXRES(ops->p->scrollmode, info);
 
 	area.sx = vxres - ((sy + height) * vc->vc_font.height);
 	area.sy = sx * vc->vc_font.width;
@@ -66,10 +66,10 @@ static void cw_bmove(struct vc_data *vc,
 static void cw_clear(struct vc_data *vc, struct fb_info *info, int sy,
 		     int sx, int height, int width)
 {
-	struct display *p = &fb_display[vc->vc_num];
+	struct fbcon_ops *ops = info->fbcon_par;
 	struct fb_fillrect region;
 	int bgshift = (vc->vc_hi_font_mask) ? 13 : 12;
-	u32 vxres = GETVXRES(p->scrollmode, info);
+	u32 vxres = GETVXRES(ops->p->scrollmode, info);
 
 	region.color = attr_bgcol_ec(bgshift,vc);
 	region.dx = vxres - ((sy + height) * vc->vc_font.height);
@@ -117,7 +117,6 @@ static void cw_putcs(struct vc_data *vc,
 		      int fg, int bg)
 {
 	struct fb_image image;
-	struct display *p = &fb_display[vc->vc_num];
 	struct fbcon_ops *ops = info->fbcon_par;
 	u32 width = (vc->vc_font.height + 7)/8;
 	u32 cellsize = width * vc->vc_font.width;
@@ -127,7 +126,7 @@ static void cw_putcs(struct vc_data *vc,
 	u32 cnt, pitch, size;
 	u32 attribute = get_attribute(info, scr_readw(s));
 	u8 *dst, *buf = NULL;
-	u32 vxres = GETVXRES(p->scrollmode, info);
+	u32 vxres = GETVXRES(ops->p->scrollmode, info);
 
 	if (!ops->fontbuffer)
 		return;
@@ -381,8 +380,7 @@ static void cw_cursor(struct vc_data *vc
 int cw_update_start(struct fb_info *info)
 {
 	struct fbcon_ops *ops = info->fbcon_par;
-	struct display *p = &fb_display[ops->currcon];
-	u32 vxres = GETVXRES(p->scrollmode, info);
+	u32 vxres = GETVXRES(ops->p->scrollmode, info);
 	u32 xoffset;
 	int err;
 
diff --git a/drivers/video/console/fbcon_ud.c b/drivers/video/console/fbcon_ud.c
index 2e1d9d4..c4d7c89 100644
--- a/drivers/video/console/fbcon_ud.c
+++ b/drivers/video/console/fbcon_ud.c
@@ -48,10 +48,10 @@ static inline void ud_update_attr(u8 *ds
 static void ud_bmove(struct vc_data *vc, struct fb_info *info, int sy,
 		     int sx, int dy, int dx, int height, int width)
 {
-	struct display *p = &fb_display[vc->vc_num];
+	struct fbcon_ops *ops = info->fbcon_par;
 	struct fb_copyarea area;
-	u32 vyres = GETVYRES(p->scrollmode, info);
-	u32 vxres = GETVXRES(p->scrollmode, info);
+	u32 vyres = GETVYRES(ops->p->scrollmode, info);
+	u32 vxres = GETVXRES(ops->p->scrollmode, info);
 
 	area.sy = vyres - ((sy + height) * vc->vc_font.height);
 	area.sx = vxres - ((sx + width) * vc->vc_font.width);
@@ -66,11 +66,11 @@ static void ud_bmove(struct vc_data *vc,
 static void ud_clear(struct vc_data *vc, struct fb_info *info, int sy,
 		     int sx, int height, int width)
 {
-	struct display *p = &fb_display[vc->vc_num];
+	struct fbcon_ops *ops = info->fbcon_par;
 	struct fb_fillrect region;
 	int bgshift = (vc->vc_hi_font_mask) ? 13 : 12;
-	u32 vyres = GETVYRES(p->scrollmode, info);
-	u32 vxres = GETVXRES(p->scrollmode, info);
+	u32 vyres = GETVYRES(ops->p->scrollmode, info);
+	u32 vxres = GETVXRES(ops->p->scrollmode, info);
 
 	region.color = attr_bgcol_ec(bgshift,vc);
 	region.dy = vyres - ((sy + height) * vc->vc_font.height);
@@ -153,7 +153,6 @@ static void ud_putcs(struct vc_data *vc,
 		      int fg, int bg)
 {
 	struct fb_image image;
-	struct display *p = &fb_display[vc->vc_num];
 	struct fbcon_ops *ops = info->fbcon_par;
 	u32 width = (vc->vc_font.width + 7)/8;
 	u32 cellsize = width * vc->vc_font.height;
@@ -163,8 +162,8 @@ static void ud_putcs(struct vc_data *vc,
 	u32 mod = vc->vc_font.width % 8, cnt, pitch, size;
 	u32 attribute = get_attribute(info, scr_readw(s));
 	u8 *dst, *buf = NULL;
-	u32 vyres = GETVYRES(p->scrollmode, info);
-	u32 vxres = GETVXRES(p->scrollmode, info);
+	u32 vyres = GETVYRES(ops->p->scrollmode, info);
+	u32 vxres = GETVXRES(ops->p->scrollmode, info);
 
 	if (!ops->fontbuffer)
 		return;
@@ -421,10 +420,9 @@ static void ud_cursor(struct vc_data *vc
 int ud_update_start(struct fb_info *info)
 {
 	struct fbcon_ops *ops = info->fbcon_par;
-	struct display *p = &fb_display[ops->currcon];
 	u32 xoffset, yoffset;
-	u32 vyres = GETVYRES(p->scrollmode, info);
-	u32 vxres = GETVXRES(p->scrollmode, info);
+	u32 vyres = GETVYRES(ops->p->scrollmode, info);
+	u32 vxres = GETVXRES(ops->p->scrollmode, info);
 	int err;
 
 	xoffset = (vxres - info->var.xres) - ops->var.xoffset;


