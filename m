Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267732AbSLGHWF>; Sat, 7 Dec 2002 02:22:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267735AbSLGHWF>; Sat, 7 Dec 2002 02:22:05 -0500
Received: from willow.compass.com.ph ([202.70.96.38]:8207 "EHLO
	willow.compass.com.ph") by vger.kernel.org with ESMTP
	id <S267732AbSLGHWC>; Sat, 7 Dec 2002 02:22:02 -0500
Subject: Re: Re[2]: [STATUS] fbdev api.
From: Antonino Daplas <adaplas@pol.net>
To: Tobias Rittweiler <inkognito.anonym@uni.de>
Cc: James Simmons <jsimmons@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux console project <linuxconsole-dev@lists.sourceforge.net>
In-Reply-To: <15835232027.20021206235940@uni.de>
References: <6723376646.20021206204207@uni.de>
	<1039218931.989.24.camel@localhost.localdomain> 
	<15835232027.20021206235940@uni.de>
Content-Type: multipart/mixed; boundary="=-Elbb0A8dhipIIB+5dOYq"
Message-Id: <1039256356.1066.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 07 Dec 2002 15:22:07 +0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Elbb0A8dhipIIB+5dOYq
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, 2002-12-07 at 03:59, Tobias Rittweiler wrote:
[...]
> >> c) instruction:          | produces:
> >>    ======================|==================
> >>    1. typing abc def     | $ abc def
> >>                          |          ^ (<- cursor)
> >>    2. going three chars  | $ abc def
> >>       ro the left        |       ^
> >>    3. pressing backspace | $ abcddef
> >>                          |      ^
> >>    4. pressing enter     | -bash: abcdef: command not found
> >>                          |
> 
> AD> I get this also. Seems to occur only with colored terms.  When I do 
> 
> AD> set TERM=vt100
> 
> AD> the problem disappears, so I thought this was an isolated case with my
> AD> setup :-). Similar glitches happen also in emacs with syntax
> AD> highlighting turned on.
> 
> Still there.
> 
Can you try this? It should fix the problem you mentioned as well as the
emacs glitch.  Also, a quick fix for character map generation failures
(KDFONTOP ioctl), ie when selecting console fonts.  Finally, if fbdev
supports blanking, let's use that.

diff -Naur linux-2.5.50-js/drivers/video/console/fbcon.c linux/drivers/video/console/fbcon.c
--- linux-2.5.50-js/drivers/video/console/fbcon.c	2002-12-07 10:10:40.000000000 +0000
+++ linux/drivers/video/console/fbcon.c	2002-12-07 10:12:11.000000000 +0000
@@ -357,7 +357,7 @@
 	area.dx = dx * vc->vc_font.width;
 	area.dy = dy * vc->vc_font.height;
 	area.height = height * vc->vc_font.height;
-	area.width = width * vc->vc_font.height;
+	area.width = width * vc->vc_font.width;
 
 	info->fbops->fb_copyarea(info, &area);
 }
@@ -910,6 +910,12 @@
 
 	info->var.xoffset = info->var.yoffset = p->yscroll = 0;	/* reset wrap/pan */
 
+	/*
+	 * FIXME: need to set this in order for KDFONTOP ioctl
+	 *        to work 
+	 */
+	p->fontwidthmask = FONTWIDTHRANGE(1,16);
+
 	for (i = 0; i < MAX_NR_CONSOLES; i++)
 		if (i != con && fb_display[i].fb_info == info &&
 		    fb_display[i].conp && fb_display[i].fontdata)
@@ -1987,12 +1993,9 @@
 		else
 			update_screen(vc->vc_num);
 		return 0;
-	} else {
-		/* Tell console.c that it has to restore the screen itself */
-		return 1;
-	}
-	fb_blank(blank, info);
-	return 0;
+	} 
+	else 
+		return info->fbops->fb_blank(blank, info);
 }
 
 static void fbcon_free_font(struct display *p)

Tony

PS: James, can you also apply the following riva cleanup patch.  It
fixes compile failures as well as removal of unused defines and
declarations.

Thanks.



--=-Elbb0A8dhipIIB+5dOYq
Content-Disposition: attachment; filename=rivafb.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=rivafb.diff; charset=UTF-8

diff -Naur linux-2.5.50-js/drivers/video/riva/fbdev.c linux/drivers/video/r=
iva/fbdev.c
--- linux-2.5.50-js/drivers/video/riva/fbdev.c	2002-12-07 09:50:22.00000000=
0 +0000
+++ linux/drivers/video/riva/fbdev.c	2002-12-07 09:53:45.000000000 +0000
@@ -214,31 +214,6 @@
 };
 MODULE_DEVICE_TABLE(pci, rivafb_pci_tbl);
=20
-
-
-/* -----------------------------------------------------------------------=
-- *
- *
- * framebuffer related structures
- *
- * -----------------------------------------------------------------------=
-- */
-
-extern struct display_switch fbcon_riva8;
-extern struct display_switch fbcon_riva16;
-extern struct display_switch fbcon_riva32;
-
-struct riva_cursor {
-	int enable;
-	int on;
-	int vbl_cnt;
-	int last_move_delay;
-	int blink_rate;
-	struct {
-		u16 x, y;
-	} pos, size;
-	unsigned short image[MAX_CURS*MAX_CURS];
-	struct timer_list *timer;
-};
-
 /* -----------------------------------------------------------------------=
-- *
  *
  * global variables
@@ -1167,7 +1142,7 @@
=20
 	if (!cnt) {
 		memset(&par->state, 0, sizeof(struct fb_vgastate));
-		par->state.flags =3D VGA_SAVE_MODE  | VGA_SAVE_FONTS;
+		par->state.flags =3D VGA_SAVE_MODE  | VGA_SAVE_FONT0;
 		/* save the DAC for Riva128 */
 		if (par->riva.Architecture =3D=3D NV_ARCH_03)
 			par->state.flags |=3D VGA_SAVE_CMAP;
@@ -1189,11 +1164,10 @@
 	if (!cnt)
 		return -EINVAL;
 	if (cnt =3D=3D 1) {
-		par->riva.LockUnlock(&par->riva, 0);
-		par->riva.LoadStateExt(&par->riva, &par->initial_state.ext);
+		riva_load_state(par, &par->initial_state);
+		par->riva.LockUnlock(&par->riva, 1);
=20
 		fb_restore_vga(&par->state);
-		par->riva.LockUnlock(&par->riva, 1);
 	}
=20
 	atomic_dec(&par->ref_count);
@@ -1566,6 +1540,16 @@
 		fb_find_mode(&info->var, info, mode_option,
 			     NULL, 0, NULL, 8);
 #endif
+
+	info->var.yres_virtual =3D -1;
+	info->var.xres_virtual =3D info->var.xres;
+	if (rivafb_check_var(&info->var, info))
+		return 1;
+
+	info->fix.line_length =3D (info->var.xres_virtual * (info->var.bits_per_p=
ixel >> 3));
+	info->fix.visual =3D (info->var.bits_per_pixel =3D=3D 8) ?=20
+				FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_DIRECTCOLOR;
+=09
 	return 0;
 }
=20
@@ -1883,10 +1867,8 @@
 	while ((this_opt =3D strsep(&options, ",")) !=3D NULL) {
 		if (!*this_opt)
 			continue;
-		if (!strncmp(this_opt, "nomove", 6)) {
-			nomove =3D 1;
 #ifdef CONFIG_MTRR
-		} else if (!strncmp(this_opt, "nomtrr", 6)) {
+		if (!strncmp(this_opt, "nomtrr", 6)) {
 			nomtrr =3D 1;
 #endif
 		} else
@@ -1935,8 +1917,6 @@
 MODULE_PARM_DESC(font, "Specifies one of the compiled-in fonts (default=3D=
none)");
 MODULE_PARM(noaccel, "i");
 MODULE_PARM_DESC(noaccel, "Disables hardware acceleration (0 or 1=3Ddisabl=
ed) (default=3D0)");
-MODULE_PARM(nomove, "i");
-MODULE_PARM_DESC(nomove, "Enables YSCROLL_NOMOVE (0 or 1=3Denabled) (defau=
lt=3D0)");
 #ifdef CONFIG_MTRR
 MODULE_PARM(nomtrr, "i");
 MODULE_PARM_DESC(nomtrr, "Disables MTRR support (0 or 1=3Ddisabled) (defau=
lt=3D0)");

--=-Elbb0A8dhipIIB+5dOYq--


