Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266161AbSLCJXP>; Tue, 3 Dec 2002 04:23:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266175AbSLCJXO>; Tue, 3 Dec 2002 04:23:14 -0500
Received: from [203.167.79.9] ([203.167.79.9]:58895 "EHLO
	willow.compass.com.ph") by vger.kernel.org with ESMTP
	id <S266161AbSLCJW7>; Tue, 3 Dec 2002 04:22:59 -0500
Subject: Re: [STATUS] fbdev api.
From: Antonino Daplas <adaplas@pol.net>
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux console project <linuxconsole-dev@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0212022051320.20834-100000@phoenix.infradead.org>
References: <Pine.LNX.4.44.0212022051320.20834-100000@phoenix.infradead.org>
Content-Type: multipart/mixed; boundary="=-HzWixbUXBTE1p3S7BdEY"
Message-Id: <1038918094.1225.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 Dec 2002 17:23:17 +0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-HzWixbUXBTE1p3S7BdEY
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2002-12-03 at 02:07, James Simmons wrote:
> 
> Hi!
> 
>   I have a new patch avaiable. It is against 2.5.50. The patch is at 
> 
> http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz
> 
> Have fun!!!!
> 
> Drivers ported are: (Give them a try)
> 
>     ATI Mach 64
>     ATI 128
>     VESA 
>     VGA16
>     HGA
>     NIVIDA
>     NEOMAGIC
>      
> The BIG changes are:
> 
> 1) The seperation of the console code out of the fbdev drivers. 
> 
> 2) Total modularity of the frmaebuffer console system. Yes that is 
>    right. You can build it has modules. Great for testing.
> 
> The following are results of the new changes which I have tested.
> 
>    With my VIA laptop with my neomagic card I was able to build it with 
> vgacon and no fbcon. Then I insmod neofb and the soft accel (cfb*.c) 
> needed. It loading and did NOT change the video hardware state. At this 
> point I could run fbdev apps including a X server using /dev/fb solely. 
> On opening /dev/fb0 the graphics hardware state changed. In theory I could 
> exit X and get vgacon back. In order to do this I have to reset the 
> hardware back to vga text mode in the fb_release function. It can be done 
> but I haven't done it yet.
>    With the second experiment I was able to insmod the fonts and fbcon.o.
> Then it switched from vgacon to fbcon. In theory I could again call the 
> release function and reset the hardware back to a text mode state. All 
> that is needed is the hardware specific code to do this.
> 
> Things to be done:
> 
>     1) A few bugs in fbcon to hammer out. 
>  
>     2) Fbcon to support changing resolution via the console layer. 
> 
>     3) Move the logo code out of fbcon.c to fbmem.c. With pure fbdev 
>        you need something to let you know things worked.
> 
>     4) Software rotation.
> 

Attached is a patch against linux-2.5.50 + your fbdev.diff.

a.  changed __MOD_INC_USE_COUNT and __MOD_DEC_USE_COUNT to
try_module_get() and module_put() respectively.  This will allow modules
to be safely unloaded.

b.  Another rewrite of fbcon_show_logo() so it's more understandable
(hopefully).  I also added support for the rest of the visuals, but
untested yet.  

Tested with different hardware (little endian):
truecolor, directcolor, pseudocolor, vga 4-bit pseudocolor.  

Not tested:
static psuedocolor, mono01, and mono10.

c.  prevent fbcon module from loading if no fbdev is registered.  Also
made fbcon module unsafe to unload (for now).  This is optional, of course.


--=-HzWixbUXBTE1p3S7BdEY
Content-Disposition: attachment; filename=fbcon.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=fbcon.diff; charset=UTF-8

diff -Naur linux-2.5.50-js/drivers/video/console/fbcon.c linux/drivers/vide=
o/console/fbcon.c
--- linux-2.5.50-js/drivers/video/console/fbcon.c	2002-12-03 10:55:55.00000=
0000 +0000
+++ linux/drivers/video/console/fbcon.c	2002-12-03 10:56:26.000000000 +0000
@@ -317,18 +317,16 @@
 	if (newidx !=3D con2fb_map[unit]) {
 		oldfb =3D registered_fb[oldidx];
 		newfb =3D registered_fb[newidx];
-		if (newfb->fbops->owner)
-			__MOD_INC_USE_COUNT(newfb->fbops->owner);
+		if (!try_module_get(newfb->fbops->owner))
+			return;
 		if (newfb->fbops->fb_open
 		    && newfb->fbops->fb_open(newfb, 0)) {
-			if (newfb->fbops->owner)
-				__MOD_DEC_USE_COUNT(newfb->fbops->owner);
+			module_put(newfb->fbops->owner);
 			return;
 		}
 		if (oldfb->fbops->fb_release)
 			oldfb->fbops->fb_release(oldfb, 0);
-		if (oldfb->fbops->owner)
-			__MOD_DEC_USE_COUNT(oldfb->fbops->owner);
+		module_put(oldfb->fbops->owner);
 		vc =3D fb_display[unit].conp;
 		fontdata =3D fb_display[unit].fontdata;
 		userfont =3D fb_display[unit].userfont;
@@ -596,10 +594,10 @@
 	info->currcon =3D -1;
 =09
 	owner =3D info->fbops->owner;
-	if (owner)
-		__MOD_INC_USE_COUNT(owner);
-	if (info->fbops->fb_open && info->fbops->fb_open(info, 0) && owner)
-		__MOD_DEC_USE_COUNT(owner);
+	if (!try_module_get(owner))
+		return NULL;
+	if (info->fbops->fb_open && info->fbops->fb_open(info, 0))
+		module_put(owner);
 =09
 	if (info->fix.type !=3D FB_TYPE_TEXT) {
 		if (fbcon_softback_size) {
@@ -2549,111 +2547,226 @@
 	return n < 0 ? d >> -n : d << n;
 }
=20
-static int __init fbcon_show_logo(void)
+static void __init fbcon_set_logocmap(struct fb_info *info)
+{
+	int i, j, n;
+
+	for (i =3D 0; i < LINUX_LOGO_COLORS; i +=3D n) {
+		n =3D LINUX_LOGO_COLORS - i;
+		if (n > 16)
+			/* palette_cmap provides space for only 16 colors at once */
+			n =3D 16;
+		palette_cmap.start =3D 32 + i;
+		palette_cmap.len =3D n;
+		for (j =3D 0; j < n; ++j) {
+			palette_cmap.red[j] =3D
+				(linux_logo_red[i + j] << 8) |
+				linux_logo_red[i + j];
+			palette_cmap.green[j] =3D
+				(linux_logo_green[i + j] << 8) |
+				linux_logo_green[i + j];
+			palette_cmap.blue[j] =3D
+				(linux_logo_blue[i + j] << 8) |
+				linux_logo_blue[i + j];
+		}
+		fb_set_cmap(&palette_cmap, 1, info);
+	}
+}
+
+static void  __init fbcon_set_logo_truepalette(struct fb_info *info, u32 *=
palette)
+{
+	unsigned char mask[9] =3D { 0,0x80,0xc0,0xe0,0xf0,0xf8,0xfc,0xfe,0xff };
+	unsigned char redmask, greenmask, bluemask;
+	int redshift, greenshift, blueshift;
+	int i;
+=09
+	/*
+	 * We have to create a temporary palette since console palette is only
+	 * 16 colors long.
+	 */
+	/* Bug: Doesn't obey msb_right ... (who needs that?) */
+	redmask   =3D mask[info->var.red.length   < 8 ? info->var.red.length   : =
8];
+	greenmask =3D mask[info->var.green.length < 8 ? info->var.green.length : =
8];
+	bluemask  =3D mask[info->var.blue.length  < 8 ? info->var.blue.length  : =
8];
+	redshift   =3D info->var.red.offset   - (8 - info->var.red.length);
+	greenshift =3D info->var.green.offset - (8 - info->var.green.length);
+	blueshift  =3D info->var.blue.offset  - (8 - info->var.blue.length);
+=09
+=09
+	for ( i =3D 0; i < LINUX_LOGO_COLORS; i++) {
+		palette[i+32] =3D (safe_shift((linux_logo_red[i]   & redmask), redshift)=
 |
+				 safe_shift((linux_logo_green[i] & greenmask), greenshift) |
+				 safe_shift((linux_logo_blue[i]  & bluemask), blueshift));
+	}
+}
+
+static void __init fbcon_set_logo_directpalette(struct fb_info *info, u32 =
*palette)
+{
+	int redshift, greenshift, blueshift;
+	int i;
+
+	redshift =3D info->var.red.offset;
+	greenshift =3D info->var.green.offset;
+	blueshift =3D info->var.blue.offset;
+=09
+	for (i =3D 32; i < LINUX_LOGO_COLORS; i++)=20
+		palette[i] =3D i << redshift | i << greenshift | i << blueshift;
+
+}
+=09
+static void __init fbcon_set_logo(struct fb_info *info, u8 *logo, int need=
s_logo)
 {
-	struct display *p =3D &fb_display[fg_console];	/* draw to vt in foregroun=
d */
+	int i, j;
+
+	switch (needs_logo) {
+	case 4:
+		for (i =3D 0; i < (LOGO_W * LOGO_H)/2; i++) {
+			logo[i*2] =3D linux_logo16[i] >> 4;
+			logo[(i*2)+1] =3D linux_logo16[i] & 0xf;
+		}
+		break;
+	case 1:
+	case ~1:
+	default:
+		for (i =3D 0; i < (LOGO_W * LOGO_H)/8; i++)=20
+			for (j =3D 0; j < 8; j++)=20
+				logo[i*2] =3D (linux_logo_bw[i] &  (7 - j)) ?=20
+					((needs_logo =3D=3D 1) ? 1 : 0) :
+					((needs_logo =3D=3D 1) ? 0 : 1);
+			=09
+		break;
+	}=20
+}=09
+=09
+/*
+ * Three (3) kinds of logo maps exist.  linux_logo (>16 colors), linux_log=
o_16=20
+ * (16 colors) and linux_logo_bw (2 colors).  Depending on the visual form=
at and
+ * color depth of the framebuffer, the DAC, the pseudo_palette, and the lo=
go data
+ * will be adjusted accordingly.
+ *
+ * Case 1 - linux_logo:
+ * Color exceeds the number of console colors (16), thus we set the hardwa=
re DAC=20
+ * using fb_set_cmap() appropriately.  The "needs_cmapreset"  flag will be=
 set.=20
+ *
+ * For visuals that require color info from the pseudo_palette, we also co=
nstruct
+ * one for temporary use. The "needs_directpalette" or "needs_truepalette"=
 flags
+ * will be set.
+ *
+ * Case 2 - linux_logo_16:
+ * The number of colors just matches the console colors, thus there is no =
need
+ * to set the DAC or the pseudo_palette.  However, the bitmap is packed, i=
e,=20
+ * each byte contains color information for two pixels (upper and lower ni=
bble). =20
+ * To be consistent with fb_imageblit() usage, we therefore separate the t=
wo=20
+ * nibbles into separate bytes. The "needs_logo" flag will be set to 4.
+ *
+ * Case 3 - linux_logo_bw:
+ * This is similar with Case 2.  Each byte contains information for 8 pixe=
ls.
+ * We isolate each bit and expand each into a byte. The "needs_logo" flag =
will
+ * be set to 1.
+ */
+static int __init fbcon_show_logo(void)
+	{
+		struct display *p =3D &fb_display[fg_console];	/* draw to vt in foregrou=
nd */
 	struct fb_info *info =3D p->fb_info;
 	struct vc_data *vc =3D info->display_fg;
 	struct fb_image image;
 	u32 *palette =3D NULL, *saved_palette =3D NULL;
-	int depth =3D info->var.bits_per_pixel;
-	unsigned char *fb =3D info->screen_base;
-	unsigned char *logo;
-	int i, j, n, x;
-	int logo_depth, done =3D 0;
+	unsigned char *fb =3D info->screen_base, *logo_new =3D NULL;
+	int done =3D 0, x;
+	int needs_cmapreset =3D 0;
+	int needs_truepalette =3D 0;
+	int needs_directpalette =3D 0;
+	int needs_logo =3D 0;
=20
 	/* Return if the frame buffer is not mapped */
-	if (!fb)
+	if (!fb || !info->fbops->fb_imageblit)
 		return 0;
=20
-	/*
-	 * Set colors if visual is PSEUDOCOLOR and we have enough colors, or for
-	 * DIRECTCOLOR
-	 * We don't have to set the colors for the 16-color logo, since that logo
-	 * uses the standard VGA text console palette
-	 */
-	if ((info->fix.visual =3D=3D FB_VISUAL_PSEUDOCOLOR && depth >=3D 8) ||
-	    (info->fix.visual =3D=3D FB_VISUAL_DIRECTCOLOR && depth >=3D 24))
-		for (i =3D 0; i < LINUX_LOGO_COLORS; i +=3D n) {
-			n =3D LINUX_LOGO_COLORS - i;
-			if (n > 16)
-				/* palette_cmap provides space for only 16 colors at once */
-				n =3D 16;
-			palette_cmap.start =3D 32 + i;
-			palette_cmap.len =3D n;
-			for (j =3D 0; j < n; ++j) {
-				palette_cmap.red[j] =3D
-				    (linux_logo_red[i + j] << 8) |
-				    linux_logo_red[i + j];
-				palette_cmap.green[j] =3D
-				    (linux_logo_green[i + j] << 8) |
-				    linux_logo_green[i + j];
-				palette_cmap.blue[j] =3D
-				    (linux_logo_blue[i + j] << 8) |
-				    linux_logo_blue[i + j];
-			}
-			fb_set_cmap(&palette_cmap, 1, info);
-		}
-
-	if (depth >=3D 8) {
-		logo =3D linux_logo;
-		logo_depth =3D 8;
-	} else if (depth >=3D 4) {
-		logo =3D linux_logo16;
-		logo_depth =3D 4;
-	} else {
-		logo =3D linux_logo_bw;
-		logo_depth =3D 1;
-	}
-
-	if (info->fix.visual =3D=3D FB_VISUAL_TRUECOLOR) {
-		unsigned char mask[9] =3D
-		    { 0, 0x80, 0xc0, 0xe0, 0xf0, 0xf8, 0xfc, 0xfe, 0xff };
-		unsigned char redmask, greenmask, bluemask;
-		int redshift, greenshift, blueshift;
-
-		/* Bug: Doesn't obey msb_right ... (who needs that?) */
-		redmask =3D
-		    mask[info->var.red.length <
-			 8 ? info->var.red.length : 8];
-		greenmask =3D
-		    mask[info->var.green.length <
-			 8 ? info->var.green.length : 8];
-		bluemask =3D
-		    mask[info->var.blue.length <
-			 8 ? info->var.blue.length : 8];
-		redshift =3D
-		    info->var.red.offset - (8 - info->var.red.length);
-		greenshift =3D
-		    info->var.green.offset - (8 - info->var.green.length);
-		blueshift =3D
-		    info->var.blue.offset - (8 - info->var.blue.length);
+	image.depth =3D info->var.bits_per_pixel;
=20
-		/*
-		 * We have to create a temporary palette since console palette is only
-		 * 16 colors long.
-		 */
+	/* reasonable default */
+	if (image.depth >=3D 8)
+		image.data =3D linux_logo;
+	else if (image.depth >=3D 4)=20
+		image.data =3D linux_logo16;
+	else=20
+		image.data =3D linux_logo_bw;
+
+	switch (info->fix.visual) {
+	case FB_VISUAL_TRUECOLOR:
+		needs_truepalette =3D 1;
+		if (image.depth >=3D 4 && image.depth <=3D 8)
+			needs_logo =3D 4;
+		else if (image.depth < 4)
+			needs_logo =3D 1;
+		break;
+	case FB_VISUAL_DIRECTCOLOR:
+		if (image.depth >=3D 24) {
+			needs_directpalette =3D 1;
+			needs_cmapreset =3D 1;
+		}
+		/* 16 colors */
+		else if (image.depth >=3D 16)
+			needs_logo =3D 4;
+		/* 2 colors */
+		else
+			needs_logo =3D 1;
+		break;
+	case FB_VISUAL_MONO01:
+		/* reversed 0 =3D fg, 1 =3D bg */
+		needs_logo =3D ~1;
+		break;
+	case FB_VISUAL_MONO10:
+		needs_logo =3D 1;
+		break;
+	case FB_VISUAL_PSEUDOCOLOR:
+	default:
+		if (image.depth >=3D 8)
+			needs_cmapreset =3D 1;
+		/* fall through */
+	case FB_VISUAL_STATIC_PSEUDOCOLOR:
+		/* 16 colors */
+		if (image.depth >=3D 4 && image.depth < 8)
+			needs_logo =3D 4;
+		/* 2 colors */
+		else if (image.depth < 4)
+			needs_logo =3D 1;
+		break;
+	}		   =20
+=09
+	if (needs_cmapreset)=20
+		fbcon_set_logocmap(info);
+=09
+	if (needs_truepalette || needs_directpalette) {
 		palette =3D kmalloc(256 * 4, GFP_KERNEL);
 		if (palette =3D=3D NULL)
-			return (LOGO_H + vc->vc_font.height - 1)/vc->vc_font.height;
+			return 1;
+
+		if (needs_truepalette)
+			fbcon_set_logo_truepalette(info, palette);
+		else
+			fbcon_set_logo_directpalette(info, palette);
=20
-		for (i =3D 0; i < LINUX_LOGO_COLORS; i++) {
-			palette[i + 32] =3D
-			    (safe_shift
-			     ((linux_logo_red[i] & redmask),
-			      redshift) | safe_shift((linux_logo_green[i] &
-						      greenmask),
-						     greenshift) |
-			     safe_shift((linux_logo_blue[i] & bluemask),
-					blueshift));
-		}
 		saved_palette =3D info->pseudo_palette;
 		info->pseudo_palette =3D palette;
 	}
+=09
+	if (needs_logo) {
+		logo_new =3D kmalloc(LOGO_W * LOGO_H, GFP_KERNEL);
+		if (logo_new =3D=3D NULL) {
+			if (palette)
+				kfree(palette);
+			if (saved_palette)
+				info->pseudo_palette =3D saved_palette;
+			return 1;
+		}
+
+		image.data =3D logo_new;
+		fbcon_set_logo(info, logo_new, needs_logo);
+	}
+
 	image.width =3D LOGO_W;
 	image.height =3D LOGO_H;
-	image.depth =3D depth;
-	image.data =3D logo;
 	image.dy =3D 0;
=20
 	for (x =3D 0; x < num_online_cpus() * (LOGO_W + 8) &&
@@ -2667,6 +2780,8 @@
 		kfree(palette);
 	if (saved_palette !=3D NULL)
 		info->pseudo_palette =3D saved_palette;
+	if (logo_new !=3D NULL)
+		kfree(logo_new);
 	/*=20
 	 * Modes not yet supported: packed pixels with depth !=3D 8 (does such a
 	 * thing exist in reality?)=20
@@ -2701,7 +2816,10 @@
=20
 int __init fb_console_init(void)
 {
+	if (!num_registered_fb)
+		return -ENODEV;
 	take_over_console(&fb_con, first_fb_vc, last_fb_vc, fbcon_is_default);
+	__unsafe(THIS_MODULE);
 	return 0;
 }
=20
diff -Naur linux-2.5.50-js/drivers/video/fbmem.c linux/drivers/video/fbmem.=
c
--- linux-2.5.50-js/drivers/video/fbmem.c	2002-12-03 10:55:42.000000000 +00=
00
+++ linux/drivers/video/fbmem.c	2002-12-03 10:57:29.000000000 +0000
@@ -730,12 +730,12 @@
 #endif /* CONFIG_KMOD */
 	if (!(info =3D registered_fb[fbidx]))
 		return -ENODEV;
-	if (info->fbops->owner)
-		__MOD_INC_USE_COUNT(info->fbops->owner);
+	if (!try_module_get(info->fbops->owner))
+		return -ENODEV;
 	if (info->fbops->fb_open) {
 		res =3D info->fbops->fb_open(info,1);
-		if (res && info->fbops->owner)
-			__MOD_DEC_USE_COUNT(info->fbops->owner);
+		if (res)
+			module_put(info->fbops->owner);
 	}
 	return res;
 }
@@ -750,8 +750,7 @@
 	info =3D registered_fb[fbidx];
 	if (info->fbops->fb_release)
 		info->fbops->fb_release(info,1);
-	if (info->fbops->owner)
-		__MOD_DEC_USE_COUNT(info->fbops->owner);
+	module_put(info->fbops->owner);
 	unlock_kernel();
 	return 0;
 }

--=-HzWixbUXBTE1p3S7BdEY--


