Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290890AbSASAwT>; Fri, 18 Jan 2002 19:52:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290892AbSASAwG>; Fri, 18 Jan 2002 19:52:06 -0500
Received: from www.transvirtual.com ([206.14.214.140]:27400 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S290890AbSASAvV>; Fri, 18 Jan 2002 19:51:21 -0500
Date: Fri, 18 Jan 2002 16:51:07 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] removal of fbcon_cmap
Message-ID: <Pine.LNX.4.10.10201181648440.14529-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi folks!!

    This patch is against 2.5.2-dj2. It migrates most drivers over to use
pseudo_palette in struct fb_info instead of the struct fbcon_cmap alot of
people where doing. Alot of code cleanup. With this common format I can
again shinrk teh fbdev code even more. Please test it out and let me know
if you have any problems. Note not all drivers are updated to this. 

   . ---
   |o_o |
   |:_/ |   Give Micro$oft the Bird!!!!
  //   \ \  Use Linux!!!!
 (|     | )
 /'_   _/`\
 ___)=(___/

diff -urN -X /home/jsimmons/dontdiff linux-2.5.2-dj2/drivers/video/aty/atyfb.h linux/drivers/video/aty/atyfb.h
--- linux-2.5.2-dj2/drivers/video/aty/atyfb.h	Fri Nov 30 11:45:56 2001
+++ linux/drivers/video/aty/atyfb.h	Fri Jan 18 14:11:32 2002
@@ -112,17 +112,6 @@
     const struct aty_pll_ops *pll_ops;
     struct display disp;
     struct display_switch dispsw;
-    union {
-#ifdef FBCON_HAS_CFB16
-	u16 cfb16[16];
-#endif
-#ifdef FBCON_HAS_CFB24
-	u32 cfb24[16];
-#endif
-#ifdef FBCON_HAS_CFB32
-	u32 cfb32[16];
-#endif
-    } fbcon_cmap;
     u8 blitter_may_be_busy;
 #ifdef __sparc__
     u8 mmaped;
diff -urN -X /home/jsimmons/dontdiff linux-2.5.2-dj2/drivers/video/aty/atyfb_base.c linux/drivers/video/aty/atyfb_base.c
--- linux-2.5.2-dj2/drivers/video/aty/atyfb_base.c	Thu Jan 17 17:34:12 2002
+++ linux/drivers/video/aty/atyfb_base.c	Fri Jan 18 14:15:09 2002
@@ -391,6 +391,7 @@
 };
 #endif /* CONFIG_FB_ATY_CT */
 
+static u32 pseudo_palette[17];
 
 #if defined(CONFIG_PPC)
 
@@ -1068,21 +1069,21 @@
 		case 16:
 		    info->dispsw = accel ? fbcon_aty16 : fbcon_cfb16;
 		    disp->dispsw = &info->dispsw;
-		    disp->dispsw_data = info->fbcon_cmap.cfb16;
+		    disp->dispsw_data = info->fb_info.pseudo_palette;
 		    break;
 #endif
 #ifdef FBCON_HAS_CFB24
 		case 24:
 		    info->dispsw = accel ? fbcon_aty24 : fbcon_cfb24;
 		    disp->dispsw = &info->dispsw;
-		    disp->dispsw_data = info->fbcon_cmap.cfb24;
+		    disp->dispsw_data = info->fb_info.pseudo_palette;
 		    break;
 #endif
 #ifdef FBCON_HAS_CFB32
 		case 32:
 		    info->dispsw = accel ? fbcon_aty32 : fbcon_cfb32;
 		    disp->dispsw = &info->dispsw;
-		    disp->dispsw_data = info->fbcon_cmap.cfb32;
+		    disp->dispsw_data = info->fb_info.pseudo_palette;
 		    break;
 #endif
 		default:
@@ -1986,6 +1987,7 @@
     info->fb_info.node = NODEV;
     info->fb_info.fbops = &atyfb_ops;
     info->fb_info.disp = disp;
+    info->fb_info.pseudo_palette = pseudo_palette;
     strcpy(info->fb_info.fontname, fontname);
     info->fb_info.changevar = NULL;
     info->fb_info.switch_con = &atyfbcon_switch;
@@ -2773,20 +2775,19 @@
 	switch (info->current_par.crtc.bpp) {
 #ifdef FBCON_HAS_CFB16
 	    case 16:
-		info->fbcon_cmap.cfb16[regno] = (regno << 10) | (regno << 5) |
-						regno;
+		((u16 *)(info->fb_info.pseudo_palette))[regno] = (regno << 10) | (regno << 5) | regno;
 		break;
 #endif
 #ifdef FBCON_HAS_CFB24
 	    case 24:
-		info->fbcon_cmap.cfb24[regno] = (regno << 16) | (regno << 8) |
-						regno;
+		((u32 *)(info->fb_info.pseudo_palette))[regno] = (regno << 16) | (regno << 8) | regno;
 		break;
 #endif
 #ifdef FBCON_HAS_CFB32
 	    case 32:
 		i = (regno << 8) | regno;
-		info->fbcon_cmap.cfb32[regno] = (i << 16) | i;
+		
+		((u32 *)(info->fb_info.pseudo_palette))[regno] = (i << 16) | i;
 		break;
 #endif
 	    }
diff -urN -X /home/jsimmons/dontdiff linux-2.5.2-dj2/drivers/video/aty128fb.c linux/drivers/video/aty128fb.c
--- linux-2.5.2-dj2/drivers/video/aty128fb.c	Thu Jan 17 17:34:12 2002
+++ linux/drivers/video/aty128fb.c	Fri Jan 18 16:32:55 2002
@@ -224,6 +224,7 @@
 
 static const char *aty128fb_name = "ATY Rage128";
 static char fontname[40] __initdata = { 0 };
+static u32  pseudo_palette[17];
 
 static int  noaccel __initdata = 0;
 static char *font __initdata = NULL;
@@ -302,17 +303,6 @@
     struct aty128fb_par default_par, current_par;
     struct display disp;
     struct { u8 red, green, blue, pad; } palette[256];
-    union {
-#ifdef FBCON_HAS_CFB16
-    u16 cfb16[16];
-#endif
-#ifdef FBCON_HAS_CFB24
-    u32 cfb24[16];
-#endif
-#ifdef FBCON_HAS_CFB32
-    u32 cfb32[16];
-#endif
-    } fbcon_cmap;
 #ifdef CONFIG_PCI
     struct pci_dev *pdev;
 #endif
@@ -1544,19 +1534,19 @@
 #ifdef FBCON_HAS_CFB16
     case 16:
 	disp->dispsw = accel ? &fbcon_aty128_16 : &fbcon_cfb16;
-	disp->dispsw_data = info->fbcon_cmap.cfb16;
+	disp->dispsw_data = info->fb_info.pseudo_palette;
 	break;
 #endif
 #ifdef FBCON_HAS_CFB24
     case 24:
 	disp->dispsw = accel ? &fbcon_aty128_24 : &fbcon_cfb24;
-	disp->dispsw_data = info->fbcon_cmap.cfb24;
+	disp->dispsw_data = info->fb_info.pseudo_palette;
 	break;
 #endif
 #ifdef FBCON_HAS_CFB32
     case 32:
 	disp->dispsw = accel ? &fbcon_aty128_32 : &fbcon_cfb32;
-	disp->dispsw_data = info->fbcon_cmap.cfb32;
+	disp->dispsw_data = info->fb_info.pseudo_palette;
 	break;
 #endif
     default:
@@ -1811,6 +1801,7 @@
     info->fb_info.node  = NODEV;
     info->fb_info.fbops = &aty128fb_ops;
     info->fb_info.disp  = &info->disp;
+    info->fb_info.pseudo_palette = pseudo_palette;	
     strcpy(info->fb_info.fontname, fontname);
     info->fb_info.changevar  = NULL;
     info->fb_info.switch_con = &aty128fbcon_switch;
@@ -2391,24 +2382,21 @@
 	switch (info->current_par.crtc.depth) {
 #ifdef FBCON_HAS_CFB16
 	case 15:
-	    info->fbcon_cmap.cfb16[regno] = (regno << 10) | (regno << 5) |
-                regno;
+	    ((u16 *)(info->fb_info.pseudo_palette))[regno] = (regno << 10) | (regno << 5) | regno;
 	    break;
 	case 16:
-	    info->fbcon_cmap.cfb16[regno] = (regno << 11) | (regno << 5) |
-                regno;
+	    ((u16 *)(info->fb_info.pseudo_palette))[regno] = (regno << 11) | (regno << 5) | regno;
 	    break;
 #endif
 #ifdef FBCON_HAS_CFB24
 	case 24:
-	    info->fbcon_cmap.cfb24[regno] = (regno << 16) | (regno << 8) |
-		regno;
+	    ((u32 *)(info->fb_info.pseudo_palette))[regno] = (regno << 16) | (regno << 8) | regno;
 	    break;
 #endif
 #ifdef FBCON_HAS_CFB32
 	case 32: {
             u32 i = (regno << 8) | regno;
-            info->fbcon_cmap.cfb32[regno] = (i << 16) | i;
+            ((u32 *)(info->fb_info.pseudo_palette))[regno] = (i << 16) | i;
 	    break;
         }
 #endif
diff -urN -X /home/jsimmons/dontdiff linux-2.5.2-dj2/drivers/video/clgenfb.c linux/drivers/video/clgenfb.c
--- linux-2.5.2-dj2/drivers/video/clgenfb.c	Thu Jan 17 17:34:12 2002
+++ linux/drivers/video/clgenfb.c	Fri Jan 18 13:02:17 2002
@@ -383,18 +383,6 @@
 
 	struct { u8 red, green, blue, pad; } palette[256];
 
-	union {
-#ifdef FBCON_HAS_CFB16
-		u16 cfb16[16];
-#endif
-#ifdef FBCON_HAS_CFB24
-		u32 cfb24[16];
-#endif
-#ifdef FBCON_HAS_CFB32
-		u32 cfb32[16];
-#endif
-	} fbcon_cmap;
-
 #ifdef CONFIG_ZORRO
 	unsigned long board_addr,
 		      board_size;
@@ -409,7 +397,7 @@
 
 
 static struct display disp;
-
+static u32 pseudo_palette[17];
 static struct clgenfb_info boards[MAX_NUM_BOARDS];	/* the boards */
 
 static unsigned clgen_def_mode = 1;
@@ -1711,13 +1699,13 @@
 	case 16:
 		assert (regno < 16);
 		if(isPReP) {
-			fb_info->fbcon_cmap.cfb16[regno] =
+			((u16 *)(fb_info->gen.info.pseudo_palette))[regno] =
 			    ((red & 0xf800) >> 9) |
 			    ((green & 0xf800) >> 14) |
 			    ((green & 0xf800) << 2) |
 			    ((blue & 0xf800) >> 3);
 		} else {
-			fb_info->fbcon_cmap.cfb16[regno] =
+			((u16 *)(fb_info->gen.info.pseudo_palette))[regno] =
 			    ((red & 0xf800) >> 1) |
 			    ((green & 0xf800) >> 6) |
 			    ((blue & 0xf800) >> 11);
@@ -1727,7 +1715,7 @@
 #ifdef FBCON_HAS_CFB24
 	case 24:
 		assert (regno < 16);
-		fb_info->fbcon_cmap.cfb24[regno] =
+		((u32 *)(fb_info->gen.info.pseudo_palette))[regno] =
 			(red   << fb_info->currentmode.var.red.offset)   |
 			(green << fb_info->currentmode.var.green.offset) |
 			(blue  << fb_info->currentmode.var.blue.offset);
@@ -1738,12 +1726,12 @@
 	case 32:
 		assert (regno < 16);
 		if(isPReP) {
-			fb_info->fbcon_cmap.cfb32[regno] =
+			((u32 *)(fb_info->gen.info.pseudo_palette))[regno] =
 			    ((red & 0xff00)) |
 			    ((green & 0xff00) << 8) |
 			    ((blue & 0xff00) << 16);
 		} else {
-			fb_info->fbcon_cmap.cfb32[regno] =
+			((u32 *)(fb_info->gen.info.pseudo_palette))[regno] =
 			    ((red & 0xff00) << 8) |
 			    ((green & 0xff00)) |
 			    ((blue & 0xff00) >> 8);
@@ -2212,7 +2200,7 @@
 			disp->dispsw = &fbcon_cfb16;
 		if (fb_info->btype == BT_GD5480)
 			disp->screen_base = (char *) fb_info->fbmem + 1 * MB_;
-		disp->dispsw_data = fb_info->fbcon_cmap.cfb16;
+		disp->dispsw_data = fb_info->gen.info.pseudo_palette;
 		break;
 #endif
 #ifdef FBCON_HAS_CFB24
@@ -2221,7 +2209,7 @@
 		disp->dispsw = &fbcon_cfb24;
 		if (fb_info->btype == BT_GD5480)
 			disp->screen_base = (char *) fb_info->fbmem + 2 * MB_;
-		disp->dispsw_data = fb_info->fbcon_cmap.cfb24;
+		disp->dispsw_data = fb_info->gen.info.pseudo_palette;
 		break;
 #endif
 #ifdef FBCON_HAS_CFB32
@@ -2233,7 +2221,7 @@
 			disp->dispsw = &fbcon_cfb32;
 		if (fb_info->btype == BT_GD5480)
 			disp->screen_base = (char *) fb_info->fbmem + 2 * MB_;
-		disp->dispsw_data = fb_info->fbcon_cmap.cfb32;
+		disp->dispsw_data = fb_info->gen.info.pseudo_palette;
 		break;
 #endif
 
@@ -2782,6 +2770,7 @@
 	fb_info->gen.info.node = NODEV;
 	fb_info->gen.info.fbops = &clgenfb_ops;
 	fb_info->gen.info.disp = &disp;
+	fb_info->gen.info.pseudo_palette = pseudo_palette;
 	fb_info->gen.info.changevar = NULL;
 	fb_info->gen.info.switch_con = &fbgen_switch;
 	fb_info->gen.info.updatevar = &fbgen_update_var;
diff -urN -X /home/jsimmons/dontdiff linux-2.5.2-dj2/drivers/video/controlfb.c linux/drivers/video/controlfb.c
--- linux-2.5.2-dj2/drivers/video/controlfb.c	Thu Jan 17 17:34:12 2002
+++ linux/drivers/video/controlfb.c	Fri Jan 18 13:05:26 2002
@@ -121,16 +121,10 @@
 	int			control_use_bank2;
 	unsigned long		total_vram;
 	unsigned char		vram_attr;
-	union {
-#ifdef FBCON_HAS_CFB16
-		u16 cfb16[16];
-#endif
-#ifdef FBCON_HAS_CFB32
-		u32 cfb32[16];
-#endif
-	} fbcon_cmap;
 };
 
+static u32 pseudo_palette[17];
+
 /* control register access macro */
 #define CNTRL_REG(INFO,REG) (&(((INFO)->control_regs-> ## REG).r))
 
@@ -546,13 +540,13 @@
 		switch (p->par.cmode) {
 #ifdef FBCON_HAS_CFB16
 			case CMODE_16:
-				p->fbcon_cmap.cfb16[regno] = (regno << 10) | (regno << 5) | regno;
+				((u16 *)(p->info.pseudo_palette))[regno] = (regno << 10) | (regno << 5) | regno;
 				break;
 #endif
 #ifdef FBCON_HAS_CFB32
 			case CMODE_32:
 				i = (regno << 8) | regno;
-				p->fbcon_cmap.cfb32[regno] = (i << 16) | i;
+				((u32 *)(p->info.pseudo_palette))[regno] = (i << 16) | i;
 				break;
 #endif
 		}
@@ -1317,13 +1311,13 @@
 #ifdef FBCON_HAS_CFB16
 		case CMODE_16:
 			disp->dispsw = &control_cfb16;
-			disp->dispsw_data = p->fbcon_cmap.cfb16;
+			disp->dispsw_data = p->info.pseudo_palette;
 			break;
 #endif
 #ifdef FBCON_HAS_CFB32
 		case CMODE_32:
 			disp->dispsw = &control_cfb32;
-			disp->dispsw_data = p->fbcon_cmap.cfb32;
+			disp->dispsw_data = p->info.pseudo_palette;
 			break;
 #endif
 		default:
diff -urN -X /home/jsimmons/dontdiff linux-2.5.2-dj2/drivers/video/hitfb.c linux/drivers/video/hitfb.c
--- linux-2.5.2-dj2/drivers/video/hitfb.c	Thu Jan 17 17:34:12 2002
+++ linux/drivers/video/hitfb.c	Fri Jan 18 13:07:40 2002
@@ -49,11 +49,6 @@
     struct fb_var_screeninfo default_var;
     int current_par_valid;
     unsigned long hit_videobase, hit_videosize;
-    union {
-#ifdef FBCON_HAS_CFB16
-	u16 cfb16[16];
-#endif
-    } fbcon_cmap;
 } fb_info = {
     {},
     {},
@@ -63,6 +58,7 @@
     {},
 };
 
+static u16 pseudo_palette[17];
 
 static void hitfb_set_par(const void *fb_par, struct fb_info_gen *info);
 static int hitfb_encode_var(struct fb_var_screeninfo *var, const void *fb_par,
@@ -257,7 +253,7 @@
 	switch(fb_info.current_par.bpp) {
 #ifdef FBCON_HAS_CFB16
 	case 16:
-	    fb_info.fbcon_cmap.cfb16[regno] =
+	    ((u16 *)(fb_info.gen.info.pseudo_palette))[regno] =
 		((red   & 0xf800)      ) |
 		((green & 0xfc00) >>  5) |
 		((blue  & 0xf800) >> 11);
@@ -306,7 +302,7 @@
 #ifdef FBCON_HAS_CFB16
     case 16:
 	disp->dispsw = &fbcon_cfb16;
-	disp->dispsw_data = fb_info.fbcon_cmap.cfb16;
+	disp->dispsw_data = fb_info.gen.info.pseudo_palette;
 	break;
 #endif
     default:
@@ -349,6 +345,7 @@
     fb_info.gen.info.flags = FBINFO_FLAG_DEFAULT;
     fb_info.gen.info.fbops = &hitfb_ops;
     fb_info.gen.info.disp = &fb_info.disp;
+    fb_info.gen.info.pseudo_palette = pseudo_palette;	
     fb_info.gen.info.changevar = NULL;
     fb_info.gen.info.switch_con = &fbgen_switch;
     fb_info.gen.info.updatevar = &fbgen_update_var;
diff -urN -X /home/jsimmons/dontdiff linux-2.5.2-dj2/drivers/video/igafb.c linux/drivers/video/igafb.c
--- linux-2.5.2-dj2/drivers/video/igafb.c	Thu Jan 17 17:34:12 2002
+++ linux/drivers/video/igafb.c	Fri Jan 18 13:11:23 2002
@@ -64,6 +64,7 @@
 
 static char igafb_name[16] = "IGA 1682";
 static char fontname[40] __initdata = { 0 };
+static u32 pseudo_palette[17];
 
 struct pci_mmap_map {
     unsigned long voff;
@@ -85,17 +86,6 @@
     int video_cmap_len;
     struct display disp;
     struct display_switch dispsw; 
-    union {
-#ifdef FBCON_HAS_CFB16
-	    u16 cfb16[16];  
-#endif
-#ifdef FBCON_HAS_CFB24
-	    u32 cfb24[16];
-#endif
-#ifdef FBCON_HAS_CFB32
-	    u32 cfb32[16];
-#endif
-    } fbcon_cmap;
 #ifdef __sparc__
     u8 open;
     u8 mmaped;
@@ -359,13 +349,13 @@
 		switch (default_var.bits_per_pixel) {
 #ifdef FBCON_HAS_CFB16
 		case 16:
-			info->fbcon_cmap.cfb16[regno] = 
+			((u16 *)(info->fb_info.psuedo_palette))[regno] = 
 				(regno << 10) | (regno << 5) | regno;
 			break;
 #endif
 #ifdef FBCON_HAS_CFB24
 		case 24:
-			info->fbcon_cmap.cfb24[regno] = 
+			((u32 *)(info->fb_info.psuedo_palette))[regno] = 
 				(regno << 16) | (regno << 8) | regno;
 		break;
 #endif
@@ -373,7 +363,9 @@
 		case 32:
 			{ int i;
 			i = (regno << 8) | regno;
-			info->fbcon_cmap.cfb32[regno] = (i << 16) | i;
+			
+			((u32 *)(info->fb_info.psuedo_palette))[regno] = 
+				 (i << 16) | i;
 			}
 			break;
 #endif
@@ -468,20 +460,20 @@
         case 15:
         case 16:
                 sw = &fbcon_cfb16;
-		display->dispsw_data = info->fbcon_cmap.cfb16;
+		display->dispsw_data = info->fb_info.pseudo_palette;
                 break;
 #endif
 #ifdef FBCON_HAS_CFB24
 	case 24:
 		sw = &fbcon_cfb24;
-		display->dispsw_data = info->fbcon_cmap.cfb24;
+		display->dispsw_data = info->fb_info.pseudo_palette;
 		break;
 #endif
 #ifdef FBCON_HAS_CFB32
         case 32:
                 sw = &fbcon_cfb32;
-		display->dispsw_data = info->fbcon_cmap.cfb32;
-                break;
+		display->dispsw_data = info->fb_info.pseudo_palette;
+		break;
 #endif
         default:
 		printk(KERN_WARNING "igafb_set_disp: unknown resolution %d\n",
@@ -547,6 +539,7 @@
 	info->fb_info.node = NODEV;
 	info->fb_info.fbops = &igafb_ops;
 	info->fb_info.disp = &info->disp;
+	info->fb_info.pseudo_palette = pseudo_palette;
 	strcpy(info->fb_info.fontname, fontname);
 	info->fb_info.changevar = NULL;
 	info->fb_info.switch_con = &igafb_switch;
diff -urN -X /home/jsimmons/dontdiff linux-2.5.2-dj2/drivers/video/imsttfb.c linux/drivers/video/imsttfb.c
--- linux-2.5.2-dj2/drivers/video/imsttfb.c	Thu Jan 17 17:34:12 2002
+++ linux/drivers/video/imsttfb.c	Fri Jan 18 13:20:59 2002
@@ -339,17 +339,6 @@
 	struct fb_fix_screeninfo fix;
 	struct display disp;
 	struct display_switch dispsw;
-	union {
-#ifdef FBCON_HAS_CFB16
-		__u16 cfb16[16];
-#endif
-#ifdef FBCON_HAS_CFB24
-		__u32 cfb24[16];
-#endif
-#ifdef FBCON_HAS_CFB32
-		__u32 cfb32[16];
-#endif
-	} fbcon_cmap;
 	struct {
 		__u8 red, green, blue;
 	} palette[256];
@@ -379,6 +368,7 @@
 
 static int inverse = 0;
 static char fontname[40] __initdata = { 0 };
+static u32 pseudo_palette[17];
 static char curblink __initdata = 1;
 static char noaccel __initdata = 0;
 #if defined(CONFIG_PPC)
@@ -1268,18 +1258,18 @@
 		switch (bpp) {
 #ifdef FBCON_HAS_CFB16
 			case 16:
-				p->fbcon_cmap.cfb16[regno] = (regno << (fb_display[info->currcon].var.green.length == 5 ? 10 : 11)) | (regno << 5) | regno;
+				((u16 *)(p->info.pseudo_palette))[regno] = (regno << (fb_display[info->currcon].var.green.length == 5 ? 10 : 11)) | (regno << 5) | regno;
 				break;
 #endif
 #ifdef FBCON_HAS_CFB24
 			case 24:
-				p->fbcon_cmap.cfb24[regno] = (regno << 16) | (regno << 8) | regno;
+				((u32 *)(p->info.pseudo_palette))[regno] = (regno << 16) | (regno << 8) | regno;
 				break;
 #endif
 #ifdef FBCON_HAS_CFB32
 			case 32: {
 				int i = (regno << 8) | regno;
-				p->fbcon_cmap.cfb32[regno] = (i << 16) | i;
+				((u32 *)(p->info.pseudo_palette))[regno] = (i << 16) | i;
 				break;
 			}
 #endif
@@ -1348,7 +1338,7 @@
 			disp->var.transp.length = 0;
 #ifdef FBCON_HAS_CFB16
 			p->dispsw = accel ? fbcon_imstt16 : fbcon_cfb16;
-			disp->dispsw_data = p->fbcon_cmap.cfb16;
+			disp->dispsw_data = p->info.pseudo_palette;
 #endif
 			break;
 		case 24:	/* RGB 888 */
@@ -1362,7 +1352,7 @@
 			disp->var.transp.length = 0;
 #ifdef FBCON_HAS_CFB24
 			p->dispsw = accel ? fbcon_imstt24 : fbcon_cfb24;
-			disp->dispsw_data = p->fbcon_cmap.cfb24;
+			disp->dispsw_data = p->info.pseudo_palette;
 #endif
 			break;
 		case 32:	/* RGBA 8888 */
@@ -1376,7 +1366,7 @@
 			disp->var.transp.length = 8;
 #ifdef FBCON_HAS_CFB32
 			p->dispsw = accel ? fbcon_imstt32 : fbcon_cfb32;
-			disp->dispsw_data = p->fbcon_cmap.cfb32;
+			disp->dispsw_data = p->info.pseudo_palette;
 #endif
 			break;
 	}
diff -urN -X /home/jsimmons/dontdiff linux-2.5.2-dj2/drivers/video/macfb.c linux/drivers/video/macfb.c
--- linux-2.5.2-dj2/drivers/video/macfb.c	Thu Jan 17 17:34:12 2002
+++ linux/drivers/video/macfb.c	Fri Jan 18 13:25:10 2002
@@ -191,18 +191,7 @@
 static struct display disp;
 static struct fb_info fb_info;
 static struct { u_short blue, green, red, pad; } palette[256];
-static union {
-#ifdef FBCON_HAS_CFB16
-    u16 cfb16[16];
-#endif
-#ifdef FBCON_HAS_CFB24
-    u32 cfb24[16];
-#endif
-#ifdef FBCON_HAS_CFB32
-    u32 cfb32[16];
-#endif
-} fbcon_cmap;
-
+static u32 pseudo_palette[17];
 static int             inverse   = 0;
 static int             vidtest   = 0;
 
@@ -288,19 +277,19 @@
 	case 15:
 	case 16:
 		display->dispsw = &fbcon_cfb16;
-		display->dispsw_data = fbcon_cmap.cfb16;
+		display->dispsw_data = fb_info.pseudo_palette;
 		break;
 #endif
 #ifdef FBCON_HAS_CFB24
 	case 24:
 		display->dispsw = &fbcon_cfb24;
-		display->dispsw_data = fbcon_cmap.cfb24;
+		display->dispsw_data = fb_info.pseudo_palette;
 		break;
 #endif
 #ifdef FBCON_HAS_CFB32
 	case 32:
 		display->dispsw = &fbcon_cfb32;
-		display->dispsw_data = fbcon_cmap.cfb32;
+		display->dispsw_data = fb_info.pseudo_palette;
 		break;
 #endif
 	default:
@@ -753,7 +742,7 @@
 	case 15:
 	case 16:
 		/* 1:5:5:5 */
-		fbcon_cmap.cfb16[regno] =
+		((u16 *)(fb_info->psuedo_palette))[regno] =
 			((red   & 0xf800) >>  1) |
 			((green & 0xf800) >>  6) |
 			((blue  & 0xf800) >> 11) |
@@ -764,21 +753,13 @@
 		   doesn't exist on 68k Macs */
 #ifdef FBCON_HAS_CFB24
 	case 24:
-		red   >>= 8;
-		green >>= 8;
-		blue  >>= 8;
-		fbcon_cmap.cfb24[regno] =
-			(red   << macfb_defined.red.offset)   |
-			(green << macfb_defined.green.offset) |
-			(blue  << macfb_defined.blue.offset);
-		break;
-#endif
 #ifdef FBCON_HAS_CFB32
 	case 32:
+#endif	
 		red   >>= 8;
 		green >>= 8;
 		blue  >>= 8;
-		fbcon_cmap.cfb32[regno] =
+		((u32 *)(fb_info->psuedo_palette))[regno] =
 			(red   << macfb_defined.red.offset)   |
 			(green << macfb_defined.green.offset) |
 			(blue  << macfb_defined.blue.offset);
@@ -1191,6 +1172,7 @@
 	fb_info.node       = NODEV;
 	fb_info.fbops      = &macfb_ops;
 	fb_info.disp       = &disp;
+	fb_info.pseudo_palette = pseudo_palette;
 	fb_info.switch_con = &macfb_switch;
 	fb_info.updatevar  = &macfb_update_var;
 	fb_info.flags      = FBINFO_FLAG_DEFAULT;
diff -urN -X /home/jsimmons/dontdiff linux-2.5.2-dj2/drivers/video/offb.c linux/drivers/video/offb.c
--- linux-2.5.2-dj2/drivers/video/offb.c	Thu Jan 17 17:34:12 2002
+++ linux/drivers/video/offb.c	Fri Jan 18 13:32:25 2002
@@ -63,16 +63,10 @@
     volatile unsigned char *cmap_data;
     int cmap_type;
     int blanked;
-    union {
-#ifdef FBCON_HAS_CFB16
-	u16 cfb16[16];
-#endif
-#ifdef FBCON_HAS_CFB32
-	u32 cfb32[16];
-#endif
-    } fbcon_cmap;
 };
 
+static u32 pseudo_palette[17];
+
 #ifdef __powerpc__
 #define mach_eieio()	eieio()
 #else
@@ -381,6 +375,7 @@
     fix = &info->fix;
     var = &info->var;
     disp = &info->disp;
+    info->pseudo_palette = pseudo_palette;	
 
     strcpy(fix->id, "OFfb ");
     strncat(fix->id, name, sizeof(fix->id));
@@ -512,30 +507,30 @@
 #ifdef FBCON_HAS_CFB16
         case 16:
             disp->dispsw = &fbcon_cfb16;
-            disp->dispsw_data = info->fbcon_cmap.cfb16;
+            disp->dispsw_data = info->info.pseudo_palette;
             for (i = 0; i < 16; i++)
             	if (fix->visual == FB_VISUAL_TRUECOLOR)
-		    info->fbcon_cmap.cfb16[i] =
+		    ((u16 *)(info->info.pseudo_palette))[i] =
 			    (((default_blu[i] >> 3) & 0x1f) << 10) |
 			    (((default_grn[i] >> 3) & 0x1f) << 5) |
 			    ((default_red[i] >> 3) & 0x1f);
 		else
-		    info->fbcon_cmap.cfb16[i] =
+		    ((u16 *)(info->info.pseudo_palette))[i] =
 			    (i << 10) | (i << 5) | i;
             break;
 #endif
 #ifdef FBCON_HAS_CFB32
         case 32:
             disp->dispsw = &fbcon_cfb32;
-            disp->dispsw_data = info->fbcon_cmap.cfb32;
+            disp->dispsw_data = info->info.pseudo_palette;
             for (i = 0; i < 16; i++)
             	if (fix->visual == FB_VISUAL_TRUECOLOR)
-		    info->fbcon_cmap.cfb32[i] =
+		    ((u32 *)(info->info.pseudo_palette))[i] =
 			(default_blu[i] << 16) |
 			(default_grn[i] << 8) |
 			default_red[i];
 		else
-		    info->fbcon_cmap.cfb32[i] =
+		    ((u32 *)(info->info.pseudo_palette))[i] =
 			    (i << 16) | (i << 8) | i;
             break;
 #endif
@@ -774,14 +769,14 @@
 	switch (info2->var.bits_per_pixel) {
 #ifdef FBCON_HAS_CFB16
 	    case 16:
-		info2->fbcon_cmap.cfb16[regno] = (regno << 10) | (regno << 5) | regno;
+		((u16 *)(info2->info.pseudo_palette))[regno] = (regno << 10) | (regno << 5) | regno;
 		break;
 #endif
 #ifdef FBCON_HAS_CFB32
 	    case 32:
 	    {
 		int i = (regno << 8) | regno;
-		info2->fbcon_cmap.cfb32[regno] = (i << 16) | i;
+		((u32 *)(info2->info.pseudo_palette))[regno] = (i << 16) | i;
 		break;
 	    }
 #endif
diff -urN -X /home/jsimmons/dontdiff linux-2.5.2-dj2/drivers/video/platinumfb.c linux/drivers/video/platinumfb.c
--- linux-2.5.2-dj2/drivers/video/platinumfb.c	Thu Jan 17 17:34:12 2002
+++ linux/drivers/video/platinumfb.c	Fri Jan 18 13:34:58 2002
@@ -49,7 +49,7 @@
 #include "platinumfb.h"
 
 static char fontname[40] __initdata = { 0 };
-
+static u32 pseudo_palette[17];
 static int default_vmode = VMODE_NVRAM;
 static int default_cmode = CMODE_NVRAM;
 
@@ -83,15 +83,6 @@
 	unsigned long			total_vram;
 	int				clktype;
 	int				dactype;
-
-	union {
-#ifdef FBCON_HAS_CFB16
-		u16 cfb16[16];
-#endif
-#ifdef FBCON_HAS_CFB32
-		u32 cfb32[16];
-#endif
-	} fbcon_cmap;
 };
 
 /*
@@ -203,13 +194,13 @@
 #ifdef FBCON_HAS_CFB16
 	    case CMODE_16:
 		disp->dispsw = &fbcon_cfb16;
-		disp->dispsw_data = info->fbcon_cmap.cfb16;
+		disp->dispsw_data = info->fb_info.pseudo_palette;
 		break;
 #endif
 #ifdef FBCON_HAS_CFB32
 	    case CMODE_32:
 		disp->dispsw = &fbcon_cfb32;
-		disp->dispsw_data = info->fbcon_cmap.cfb32;
+		disp->dispsw_data = info->fb_info.pseudo_palette;
 		break;
 #endif
 	    default:
@@ -393,10 +384,10 @@
 
 	if(regno < 16) {
 #ifdef FBCON_HAS_CFB16
-		info->fbcon_cmap.cfb16[regno] = (regno << 10) | (regno << 5) | (regno << 0);
+		((u16 *)(info->fb_info.pseudo_palette))[regno] = (regno << 10) | (regno << 5) | (regno << 0);
 #endif
 #ifdef FBCON_HAS_CFB32
-		info->fbcon_cmap.cfb32[regno] = (regno << 24) | (regno << 16) | (regno << 8) | regno;
+		((u32 *)(info->fb_info.pseudo_palette))[regno] = (regno << 24) | (regno << 16) | (regno << 8) | regno;
 #endif
 	}
 	return 0;
@@ -560,6 +551,7 @@
 	info->fb_info.node = NODEV;
 	info->fb_info.fbops = &platinumfb_ops;
 	info->fb_info.disp = disp;
+	info->fb_info.pseudo_palette = pseudo_palette;
 	strcpy(info->fb_info.fontname, fontname);
 	info->fb_info.changevar = NULL;
 	info->fb_info.switch_con = &platinum_switch;
diff -urN -X /home/jsimmons/dontdiff linux-2.5.2-dj2/drivers/video/pvr2fb.c linux/drivers/video/pvr2fb.c
--- linux-2.5.2-dj2/drivers/video/pvr2fb.c	Thu Jan 17 17:34:12 2002
+++ linux/drivers/video/pvr2fb.c	Fri Jan 18 13:50:24 2002
@@ -163,17 +163,6 @@
 static int pvr2fb_inverse = 0;
 
 static struct { u_short red, green, blue, alpha; } palette[256];
-static union {
-#ifdef FBCON_HAS_CFB16
-	u16 cfb16[16];
-#endif
-#ifdef FBCON_HAS_CFB24
-	u32 cfb24[16];
-#endif
-#ifdef FBCON_HAS_CFB32
-	u32 cfb32[16];
-#endif
-} fbcon_cmap;
 
 static char pvr2fb_name[16] = "NEC PowerVR2";
 
@@ -393,19 +382,19 @@
 #ifdef FBCON_HAS_CFB16
 			    case 16:
 				display->dispsw = &fbcon_cfb16;
-				display->dispsw_data = fbcon_cmap.cfb16;
+				display->dispsw_data = info->pseudo_palette;
 				break;
 #endif
 #ifdef FBCON_HAS_CFB24
 			    case 24:
 				display->dispsw = &fbcon_cfb24;
-				display->dispsw_data = fbcon_cmap.cfb24;
+				display->dispsw_data = info->pseudo_palette;
 				break;
 #endif
 #ifdef FBCON_HAS_CFB32
 			    case 32:
 				display->dispsw = &fbcon_cfb32;
-				display->dispsw_data = fbcon_cmap.cfb32;
+				display->dispsw_data = info->pseudo_palette;
 				break;
 #endif
 			    default:
@@ -553,7 +542,7 @@
 		switch (currbpp) {
 #ifdef FBCON_HAS_CFB16
 		    case 16: /* RGB 565 */
-			fbcon_cmap.cfb16[regno] = (red & 0xf800) |
+			((u16 *)(info->pseudo_palette))[regno] = (red & 0xf800) |
 			                          ((green & 0xfc00) >> 5) |
 						  ((blue & 0xf800) >> 11);
 			break;
@@ -561,13 +550,13 @@
 #ifdef FBCON_HAS_CFB24
 		    case 24: /* RGB 888 */
 			red >>= 8; green >>= 8; blue >>= 8;
-			fbcon_cmap.cfb24[regno] = (red << 16) | (green << 8) | blue;
+			((u32 *)(info->pseudo_palette))[regno] = (red << 16) | (green << 8) | blue;
 			break;
 #endif
 #ifdef FBCON_HAS_CFB32
 		    case 32: /* ARGB 8888 */
 			red >>= 8; green >>= 8; blue >>= 8;
-			fbcon_cmap.cfb32[regno] = (red << 16) | (green << 8) | blue;
+			((u32 *)(info->pseudo_palette))[regno] = (red << 16) | (green << 8) | blue;
 			break;
 #endif
 		    default:
@@ -1000,6 +989,7 @@
 	fb_info.changevar = NULL;
 	fb_info.node = NODEV;
 	fb_info.fbops = &pvr2fb_ops;
+	fb_info.pseudo_palette = pseudo_palette;
 	fb_info.disp = &disp;
 	fb_info.switch_con = &pvr2fbcon_switch;
 	fb_info.updatevar = &pvr2fbcon_updatevar;
diff -urN -X /home/jsimmons/dontdiff linux-2.5.2-dj2/drivers/video/q40fb.c linux/drivers/video/q40fb.c
--- linux-2.5.2-dj2/drivers/video/q40fb.c	Thu Jan 17 17:34:12 2002
+++ linux/drivers/video/q40fb.c	Fri Jan 18 13:52:55 2002
@@ -24,7 +24,7 @@
 #define Q40_PHYS_SCREEN_ADDR 0xFE800000
 static unsigned long q40_screen_addr;
 
-static u16 fbcon_cmap_cfb16[16];
+static u16 pseudo_palette[17];
 
 /* frame buffer operations */
 
@@ -173,9 +173,9 @@
     if (regno>=16) return 1;
 
     *transp=0;
-    *green = ((fbcon_cmap_cfb16[regno]>>11) & 31)<<11;
-    *red   = ((fbcon_cmap_cfb16[regno]>>6) & 31)<<11;
-    *blue  = ((fbcon_cmap_cfb16[regno]) & 63)<<10;
+    *green = ((info->pseudo_palette[regno]>>11) & 31)<<11;
+    *red   = ((info->pseudo_palette[regno]>>6) & 31)<<11;
+    *blue  = ((info->pseudo_palette[regno]) & 63)<<10;
 
     return 0;
 }
@@ -195,7 +195,7 @@
   blue>>=10;
 
     if (regno < 16) {
-      fbcon_cmap_cfb16[regno] = ((red & 31) <<6) |
+      info->pseudo_palette[regno] = ((red & 31) <<6) |
 	                         ((green & 31) << 11) |
 	                         (blue & 63);
     }
@@ -249,7 +249,7 @@
 
 #ifdef FBCON_HAS_CFB16
    display->dispsw = &fbcon_cfb16;
-   disp->dispsw_data = fbcon_cmap_cfb16;
+   disp->dispsw_data = info->pseudo_palette;
 #else
    display->dispsw = &fbcon_dummy;
 #endif
@@ -270,6 +270,7 @@
 	fb_info.changevar=NULL;
 	strcpy(&fb_info.modename[0],q40fb_name);
 	fb_info.fontname[0]=0;
+	fb_info.pseudo_palette = pseudo_palette;
 	fb_info.disp=disp;
 	fb_info.switch_con=&q40con_switch;
 	fb_info.updatevar=&q40con_updatevar;
diff -urN -X /home/jsimmons/dontdiff linux-2.5.2-dj2/drivers/video/riva/fbdev.c linux/drivers/video/riva/fbdev.c
--- linux-2.5.2-dj2/drivers/video/riva/fbdev.c	Thu Jan 17 17:34:12 2002
+++ linux/drivers/video/riva/fbdev.c	Fri Jan 18 15:34:14 2002
@@ -271,6 +271,7 @@
 
 /* command line data, set in rivafb_setup() */
 static char fontname[40] __initdata = { 0 };
+static u32  pseudo_palette[17];
 static char noaccel __initdata = 0;
 static char nomove = 0;
 static char nohwcursor __initdata = 0;
@@ -702,7 +703,7 @@
 #ifdef FBCON_HAS_CFB16
 	case 16:
 		rinfo->dispsw = accel ? fbcon_riva16 : fbcon_cfb16;
-		disp->dispsw_data = &rinfo->con_cmap.cfb16;
+		disp->dispsw_data = &rinfo->info.pseudo_palette;
 		disp->dispsw = &rinfo->dispsw;
 		disp->line_length = disp->var.xres_virtual * 2;
 		disp->visual = FB_VISUAL_DIRECTCOLOR;
@@ -711,7 +712,7 @@
 #ifdef FBCON_HAS_CFB32
 	case 32:
 		rinfo->dispsw = accel ? fbcon_riva32 : fbcon_cfb32;
-		disp->dispsw_data = rinfo->con_cmap.cfb32;
+		disp->dispsw_data = &rinfo->info.pseudo_palette;
 		disp->dispsw = &rinfo->dispsw;
 		disp->line_length = disp->var.xres_virtual * 4;
 		disp->visual = FB_VISUAL_DIRECTCOLOR;
@@ -1255,12 +1256,12 @@
 		assert(regno < 16);
 		if (p->var.green.length == 5) {
 			/* 0rrrrrgg gggbbbbb */
-			rivainfo->con_cmap.cfb16[regno] =
+			((u16 *)(rivainfo->info.pseudo_palette))[regno] =
 			    ((red & 0xf800) >> 1) |
 			    ((green & 0xf800) >> 6) | ((blue & 0xf800) >> 11);
 		} else {
 			/* rrrrrggg gggbbbbb */
-			rivainfo->con_cmap.cfb16[regno] =
+			((u16 *)(rivainfo->info.pseudo_palette))[regno] =
 			    ((red & 0xf800) >> 0) |
 			    ((green & 0xf800) >> 5) | ((blue & 0xf800) >> 11);
 		}
@@ -1269,7 +1270,7 @@
 #ifdef FBCON_HAS_CFB32
 	case 32:
 		assert(regno < 16);
-		rivainfo->con_cmap.cfb32[regno] =
+		((u32 *)(rivainfo->info.pseudo_palette))[regno] =
 		    ((red & 0xff00) << 8) |
 		    ((green & 0xff00)) | ((blue & 0xff00) >> 8);
 		break;
@@ -1842,6 +1843,7 @@
 	/* FIXME: set monspecs to what??? */
 
 	info->display_fg = NULL;
+	info->pseudo_palette = pseudo_palette;
 	strncpy(info->fontname, fontname, sizeof(info->fontname));
 	info->fontname[sizeof(info->fontname) - 1] = 0;
 
diff -urN -X /home/jsimmons/dontdiff linux-2.5.2-dj2/drivers/video/riva/rivafb.h linux/drivers/video/riva/rivafb.h
--- linux-2.5.2-dj2/drivers/video/riva/rivafb.h	Thu Jan 17 17:34:12 2002
+++ linux/drivers/video/riva/rivafb.h	Fri Jan 18 15:29:31 2002
@@ -66,16 +66,6 @@
 
 	riva_cfb8_cmap_t palette[256];	/* VGA DAC palette cache */
 
-#if defined(FBCON_HAS_CFB16) || defined(FBCON_HAS_CFB32)
-	union {
-#ifdef FBCON_HAS_CFB16
-		u_int16_t cfb16[16];
-#endif
-#ifdef FBCON_HAS_CFB32
-		u_int32_t cfb32[16];
-#endif
-	} con_cmap;
-#endif				/* FBCON_HAS_CFB16 | FBCON_HAS_CFB32 */
 #ifdef CONFIG_MTRR
 	struct { int vram; int vram_valid; } mtrr;
 #endif
diff -urN -X /home/jsimmons/dontdiff linux-2.5.2-dj2/drivers/video/sgivwfb.c linux/drivers/video/sgivwfb.c
--- linux-2.5.2-dj2/drivers/video/sgivwfb.c	Thu Jan 17 17:34:12 2002
+++ linux/drivers/video/sgivwfb.c	Fri Jan 18 13:54:34 2002
@@ -63,15 +63,7 @@
 
 /* console related variables */
 static struct display disp;
-
-static union {
-#ifdef FBCON_HAS_CFB16
-  u16 cfb16[16];
-#endif
-#ifdef FBCON_HAS_CFB32
-  u32 cfb32[16];
-#endif
-} fbcon_cmap;
+static u32 pseudo_palette[17];
 
 static struct sgivwfb_par par_current = {
   {                             /* var (screeninfo) */
@@ -763,13 +755,13 @@
 #ifdef FBCON_HAS_CFB16
       case 16:
 	display->dispsw = &fbcon_cfb16;
-	display->dispsw_data = fbcon_cmap.cfb16;
+	display->dispsw_data = info->pseudo_palette;
 	break;
 #endif
 #ifdef FBCON_HAS_CFB32
       case 32:
 	display->dispsw = &fbcon_cfb32;
-	display->dispsw_data = fbcon_cmap.cfb32;
+	display->dispsw_data = info->pseudo_palette;
 	break;
 #endif
       default:
@@ -858,6 +850,7 @@
   fb_info.node = NODEV;
   fb_info.fbops = &sgivwfb_ops;
   fb_info.disp = &disp;
+  fb_info.pseudo_palette = pseudo_palette;
   fb_info.switch_con = &sgivwfbcon_switch;
   fb_info.updatevar = &sgivwfbcon_updatevar;
   fb_info.flags = FBINFO_FLAG_DEFAULT;
diff -urN -X /home/jsimmons/dontdiff linux-2.5.2-dj2/drivers/video/sis/sis_main.c linux/drivers/video/sis/sis_main.c
--- linux-2.5.2-dj2/drivers/video/sis/sis_main.c	Thu Jan 17 17:34:12 2002
+++ linux/drivers/video/sis/sis_main.c	Fri Jan 18 16:30:21 2002
@@ -429,7 +429,7 @@
 #ifdef FBCON_HAS_CFB16
 	case 15:
 	case 16:
-		fbcon_cmap.cfb16[regno] =
+		((u16 *)(fb_info->pseudo_palette))[regno] =
 		    ((red & 0xf800)) |
 		    ((green & 0xfc00) >> 5) | ((blue & 0xf800) >> 11);
 		break;
@@ -439,7 +439,8 @@
 		red >>= 8;
 		green >>= 8;
 		blue >>= 8;
-		fbcon_cmap.cfb24[regno] = (red << 16) | (green << 8) | (blue);
+		((u32 *)(fb_info->pseudo_palette))[regno] =
+					(red << 16) | (green << 8) | (blue);
 		break;
 #endif
 #ifdef FBCON_HAS_CFB32
@@ -447,7 +448,8 @@
 		red >>= 8;
 		green >>= 8;
 		blue >>= 8;
-		fbcon_cmap.cfb32[regno] = (red << 16) | (green << 8) | (blue);
+		((u32 *)(fb_info->pseudo_palette))[regno] =
+				(red << 16) | (green << 8) | (blue);
 		break;
 #endif
 	}
@@ -602,19 +604,19 @@
 	case 15:
 	case 16:
 		sw = &fbcon_cfb16;
-		display->dispsw_data = fbcon_cmap.cfb16;
+		display->dispsw_data = fb_info.pseudo_palette;
 		break;
 #endif
 #ifdef FBCON_HAS_CFB24
 	case 24:
 		sw = &fbcon_cfb24;
-		display->dispsw_data = fbcon_cmap.cfb24;
+		display->dispsw_data = fb_info.pseudo_palette;
 		break;
 #endif
 #ifdef FBCON_HAS_CFB32
 	case 32:
 		sw = &fbcon_cfb32;
-		display->dispsw_data = fbcon_cmap.cfb32;
+		display->dispsw_data = fb_info.pseudo_palette;
 		break;
 #endif
 	default:
@@ -2760,6 +2762,7 @@
 	fb_info.node = NODEV;
 	fb_info.fbops = &sisfb_ops;
 	fb_info.disp = &disp;
+	fb_info.pseudo_palette = pseudo_palette;
 	fb_info.switch_con = &sisfb_switch;
 	fb_info.updatevar = &sisfb_update_var;
 	fb_info.flags = FBINFO_FLAG_DEFAULT;
diff -urN -X /home/jsimmons/dontdiff linux-2.5.2-dj2/drivers/video/sis/sis_main.h linux/drivers/video/sis/sis_main.h
--- linux-2.5.2-dj2/drivers/video/sis/sis_main.h	Thu Jan 17 17:34:12 2002
+++ linux/drivers/video/sis/sis_main.h	Fri Jan 18 16:29:11 2002
@@ -202,6 +202,7 @@
 /* Fbcon variables */
 static struct fb_info fb_info;
 static struct display disp;
+static u32 pseudo_palette[17];
 static int video_type = FB_TYPE_PACKED_PIXELS;
 static int video_linelength;
 static int video_cmap_len;
@@ -225,17 +226,6 @@
 static struct {
 	u16 blue, green, red, pad;
 } palette[256];
-static union {
-#ifdef FBCON_HAS_CFB16
-	u16 cfb16[16];
-#endif
-#ifdef FBCON_HAS_CFB24
-	u32 cfb24[16];
-#endif
-#ifdef FBCON_HAS_CFB32
-	u32 cfb32[16];
-#endif
-} fbcon_cmap;
 
 /* display status */
 static int sisfb_off = 0;
diff -urN -X /home/jsimmons/dontdiff linux-2.5.2-dj2/drivers/video/skeletonfb.c linux/drivers/video/skeletonfb.c
--- linux-2.5.2-dj2/drivers/video/skeletonfb.c	Thu Jan 17 17:34:12 2002
+++ linux/drivers/video/skeletonfb.c	Fri Jan 18 13:57:45 2002
@@ -65,6 +65,7 @@
 
 static struct xxxfb_info fb_info;
 static struct xxxfb_par current_par;
+static u32 pseudo_palette[17];
 static int current_par_valid = 0;
 static struct display disp;
 
@@ -190,19 +191,19 @@
 	 *  Make the first 16 colors of the palette available to fbcon
 	 */
 	if (is_cfb15)		/* RGB 555 */
-	    ...fbcon_cmap.cfb16[regno] = ((red & 0xf800) >> 1) |
+	    ((u16 *)(info->pseudo_palette))[regno] = ((red & 0xf800) >> 1) |
 					 ((green & 0xf800) >> 6) |
 					 ((blue & 0xf800) >> 11);
 	if (is_cfb16)		/* RGB 565 */
-	    ...fbcon_cmap.cfb16[regno] = (red & 0xf800) |
+	    ((u16 *)(info->pseudo_palette))[regno] = (red & 0xf800) |
 					 ((green & 0xfc00) >> 5) |
 					 ((blue & 0xf800) >> 11);
 	if (is_cfb24)		/* RGB 888 */
-	    ...fbcon_cmap.cfb24[regno] = ((red & 0xff00) << 8) |
+	    ((u32 *)(info->pseudo_palette))[regno] = ((red & 0xff00) << 8) |
 					 (green & 0xff00) |
 					 ((blue & 0xff00) >> 8);
 	if (is_cfb32)		/* RGBA 8888 */
-	    ...fbcon_cmap.cfb32[regno] = ((red & 0xff00) << 16) |
+	    ((u32 *)(info->pseudo_palette))[regno] = ((red & 0xff00) << 16) |
 					 ((green & 0xff00) << 8) |
 					 (blue & 0xff00) |
 					 ((transp & 0xff00) >> 8);
@@ -262,19 +263,19 @@
 #ifdef FBCON_HAS_CFB16
     if (is_cfb16) {
 	disp->dispsw = fbcon_cfb16;
-	disp->dispsw_data = ...fbcon_cmap.cfb16;	/* console palette */
+	disp->dispsw_data = info->info.pseudo_palette;	/* console palette */
     } else
 #endif
 #ifdef FBCON_HAS_CFB24
     if (is_cfb24) {
 	disp->dispsw = fbcon_cfb24;
-	disp->dispsw_data = ...fbcon_cmap.cfb24;	/* console palette */
+	disp->dispsw_data = info->info.pseudo_palette;	/* console palette */
     } else
 #endif
 #ifdef FBCON_HAS_CFB32
     if (is_cfb32) {
 	disp->dispsw = fbcon_cfb32;
-	disp->dispsw_data = ...fbcon_cmap.cfb32;	/* console palette */
+	disp->dispsw_data = info->info.pseudo_palette;	/* console palette */
     } else
 #endif
 	disp->dispsw = &fbcon_dummy;
@@ -307,6 +308,7 @@
     fb_info.gen.info.changevar = NULL;
     fb_info.gen.info.node = NODEV;
     fb_info.gen.info.fbops = &xxxfb_ops;
+    fb_info.gen.info.pseudo_palette = pseudo_palette;
     fb_info.gen.info.disp = &disp;
     fb_info.gen.info.switch_con = &xxxfb_switch;
     fb_info.gen.info.updatevar = &xxxfb_update_var;
diff -urN -X /home/jsimmons/dontdiff linux-2.5.2-dj2/drivers/video/sstfb.c linux/drivers/video/sstfb.c
--- linux-2.5.2-dj2/drivers/video/sstfb.c	Thu Jan 17 17:34:12 2002
+++ linux/drivers/video/sstfb.c	Fri Jan 18 16:40:20 2002
@@ -188,20 +188,8 @@
 static int dev = -1;		/* specify device (0..n) */
 static char * mode_option ;
 
-
-#if defined(FBCON_HAS_CFB16) || defined(FBCON_HAS_CFB24) || defined(FBCON_HAS_CFB32)
-union {
-#  ifdef FBCON_HAS_CFB16
-	u16 cfb16[16];
-#  endif
-#ifdef EN_24_32_BPP
-#  if defined (FBCON_HAS_CFB24) || defined(FBCON_HAS_CFB32)
-	u32 cfb32[16];
-#  endif
-#endif
-	} fbcon_cmap;
-#endif
 static struct { u_int red, green, blue, transp; } palette[16];
+static u32 pseudo_palette[17];
 static struct sstfb_info fb_info;
 static struct display disp;
 
@@ -541,18 +529,18 @@
 	switch(disp.var.bits_per_pixel) {
 #ifdef FBCON_HAS_CFB16
 	case 16:
-		fbcon_cmap.cfb16[regno]=(u16)col;
+		((u16 *)(info->pseudo_palette))[regno] = (u16)col;
 		break;
 #endif
 #ifdef EN_24_32_BPP
 #ifdef FBCON_HAS_CFB24
 	case 24:
-		fbcon_cmap.cfb32[regno]=col;
+		((u32 *)(info->pseudo_palette))[regno] = col;
 		break;
 #endif
 #ifdef FBCON_HAS_CFB32
 	case 32:
-		fbcon_cmap.cfb32[regno]=col;
+		((u32 *)(info->pseudo_palette))[regno] = col;
 		break;
 #endif
 #endif
@@ -819,7 +807,7 @@
 #ifdef FBCON_HAS_CFB16
 		case 16:
 			display->dispsw = &fbcon_cfb16;
-			display->dispsw_data = fbcon_cmap.cfb16;
+			display->dispsw_data = sst_info->info.pseudo_palette;
 			break;
 #endif
 #ifdef EN_24_32_BPP
@@ -827,7 +815,7 @@
 		case 24: /*24bpp non packed <=> 32 bpp */
 		case 32:
 			display->dispsw = &fbcon_cfb32;
-			display->dispsw_data = fbcon_cmap.cfb32;
+			display->dispsw_data = sst_info->info.pseudo_palette;
 			break;
 #endif
 #endif
@@ -854,36 +842,13 @@
 	if (old_bpp != var->bits_per_pixel) {
 	    if ((err = fb_alloc_cmap(&display->cmap, 0, 0)))
 		return err;
-	    fbgen_install_cmap(con, info);
+	    do_install_cmap(con, info);
 	}
 
 	return 0;
 #undef sst_info
 }
 
-
-static int sstfb_set_cmap(struct fb_cmap *cmap, int kspc,
-                          int con, struct fb_info *info)
-{
-	struct display *d = (con<0) ? info->disp : fb_display + con;
-
-	f_dprintk("sstfb_set_cmap\n");
-	f_ddprintk("con: %d, currcon: %d, d->cmap.len %d\n",
-		 con, info->currcon, d->cmap.len);
-
-	if (d->cmap.len != 16 ) {	/* or test if cmap.len == 0 ? */
-		int err;
-		err = fb_alloc_cmap(&d->cmap, 16, 0); /* cmap size=16 */
-		if (err) return err;
-	}
-	if (con == info->currcon) {
-		return fb_set_cmap(cmap, kspc, info);
-	} else {
-		fb_copy_cmap(cmap, &d->cmap, kspc ? 0 : 1);
-	}
-	return 0;
-}
-
 static int sstfb_get_cmap(struct fb_cmap *cmap, int kspc,
                           int con, struct fb_info *info)
 {
@@ -891,7 +856,7 @@
 	f_ddprintk("con %d, curcon %d, cmap.len %d\n",
 		 con, info->currcon, fb_display[con].cmap.len);
 
-	/* FIXME: check if con = -1 ? cf sstfb_set_cmap...  */
+	/* FIXME: check if con = -1 ? cf fbgen_set_cmap...  */
 	if (con == info->currcon)
 		return fb_get_cmap(cmap, kspc, sstfb_getcolreg, info);
 	else if (fb_display[con].cmap.len)
@@ -1782,6 +1747,7 @@
 		fb_info.info.flags      = FBINFO_FLAG_DEFAULT;
 		fb_info.info.fbops      = &sstfb_ops;
 		fb_info.info.disp       = &disp;
+		fb_info.info.pseudo_palette = pseudo_palette;
 		fb_info.info.changevar  = NULL;
 		fb_info.info.switch_con = &sstfbcon_switch;
 		fb_info.info.updatevar  = &sstfbcon_updatevar;
@@ -1845,7 +1811,7 @@
 	if (memcmp(&par,&(sst_info->current_par),sizeof(par))) {
 		sstfb_set_par(&par, sst_info);
 	}
-	fbgen_install_cmap(con, info);
+	do_install_cmap(con, info);
 	return 0;
 #undef sst_info
 }
diff -urN -X /home/jsimmons/dontdiff linux-2.5.2-dj2/drivers/video/tdfxfb.c linux/drivers/video/tdfxfb.c
--- linux-2.5.2-dj2/drivers/video/tdfxfb.c	Thu Jan 17 17:34:12 2002
+++ linux/drivers/video/tdfxfb.c	Fri Jan 18 16:34:45 2002
@@ -335,19 +335,6 @@
   struct tdfxfb_par default_par;
   struct tdfxfb_par current_par;
   struct display disp;
-#if defined(FBCON_HAS_CFB16) || defined(FBCON_HAS_CFB24) || defined(FBCON_HAS_CFB32)  
-  union {
-#ifdef FBCON_HAS_CFB16
-    u16 cfb16[16];
-#endif
-#ifdef FBCON_HAS_CFB24
-    u32 cfb24[16];
-#endif
-#ifdef FBCON_HAS_CFB32
-    u32 cfb32[16];
-#endif
-  } fbcon_cmap;
-#endif
   struct { 
      int type;             
      int state;             
@@ -364,6 +351,8 @@
 #endif
 };
 
+static u32 pseudo_palette[17];
+
 /*
  *  Frame buffer device API
  */
@@ -391,6 +380,10 @@
 			   int kspc, 
 			   int con,
 			   struct fb_info* info);
+static int tdfxfb_set_cmap(struct fb_cmap *cmap, 
+			   int kspc, 
+			   int con,
+			   struct fb_info *fb); 
 
 /*
  *  Interface to the low level console driver
@@ -470,7 +463,7 @@
 	fb_get_var:	tdfxfb_get_var,
 	fb_set_var:	tdfxfb_set_var,
 	fb_get_cmap:	tdfxfb_get_cmap,
-	fb_set_cmap:	fbgen_set_cmap,
+	fb_set_cmap:	tdfxfb_set_cmap,
 	fb_setcolreg:	tdfxfb_setcolreg,
 	fb_pan_display:	tdfxfb_pan_display,
 	fb_blank:	tdfxfb_blank,
@@ -1722,21 +1715,21 @@
 #ifdef FBCON_HAS_CFB16
   case 16:
     disp->dispsw = noaccel ? &fbcon_cfb16 : &fbcon_banshee16;
-    disp->dispsw_data = info->fbcon_cmap.cfb16;
+    disp->dispsw_data = info->fb_info.pseudo_palette;
     if (nohwcursor) fbcon_banshee16.cursor = NULL;
     break;
 #endif
 #ifdef FBCON_HAS_CFB24
   case 24:
     disp->dispsw = noaccel ? &fbcon_cfb24 : &fbcon_banshee24; 
-    disp->dispsw_data = info->fbcon_cmap.cfb24;
+    disp->dispsw_data = info->fb_info.pseudo_palette;
     if (nohwcursor) fbcon_banshee24.cursor = NULL;
     break;
 #endif
 #ifdef FBCON_HAS_CFB32
   case 32:
     disp->dispsw = noaccel ? &fbcon_cfb32 : &fbcon_banshee32;
-    disp->dispsw_data = info->fbcon_cmap.cfb32;
+    disp->dispsw_data = info->fb_info.pseudo_palette;
     if (nohwcursor) fbcon_banshee32.cursor = NULL;
     break;
 #endif
@@ -1980,6 +1973,7 @@
 	fb_info.fb_info.changevar  = NULL;
 	fb_info.fb_info.node       = NODEV;
 	fb_info.fb_info.fbops      = &tdfxfb_ops;
+	fb_info.fb_info.pseudo_palette = pseudo_palette;
 	fb_info.fb_info.disp       = &fb_info.disp;
 	strcpy(fb_info.fb_info.fontname, fontname);
 	fb_info.fb_info.switch_con = &tdfxfb_switch_con;
@@ -2258,7 +2252,7 @@
 #endif
 #ifdef FBCON_HAS_CFB16
     case 16:
-      i->fbcon_cmap.cfb16[regno] =
+      ((u16 *)(i->fb_info.pseudo_palette))[regno] =
 	(((u32)red   & 0xf800) >> 0) |
 	(((u32)green & 0xfc00) >> 5) |
 	(((u32)blue  & 0xf800) >> 11);
@@ -2266,7 +2260,7 @@
 #endif
 #ifdef FBCON_HAS_CFB24
     case 24:
-      i->fbcon_cmap.cfb24[regno] =
+      ((u32 *)(i->fb_info.pseudo_palette))[regno] =
 	(((u32)red & 0xff00) << 8) |
 	(((u32)green & 0xff00) << 0) |
 	(((u32)blue & 0xff00) >> 8);
@@ -2274,7 +2268,7 @@
 #endif
 #ifdef FBCON_HAS_CFB32
     case 32:
-      i->fbcon_cmap.cfb32[regno] =
+      ((u32 *)(i->fb_info.pseudo_palette))[regno] =
 	(((u32)red   & 0xff00) << 8) |
 	(((u32)green & 0xff00) << 0) |
 	(((u32)blue  & 0xff00) >> 8);
diff -urN -X /home/jsimmons/dontdiff linux-2.5.2-dj2/drivers/video/tx3912fb.c linux/drivers/video/tx3912fb.c
--- linux-2.5.2-dj2/drivers/video/tx3912fb.c	Thu Jan 17 17:34:12 2002
+++ linux/drivers/video/tx3912fb.c	Fri Jan 18 14:07:42 2002
@@ -34,6 +34,7 @@
  */
 static struct fb_info fb_info;
 static struct { u_char red, green, blue, pad; } palette[256];
+static u32 pseudo_palette[17];
 static struct display global_disp;
 
 /*
@@ -265,7 +266,7 @@
 #ifdef CONFIG_FBCON_CFB8
 			case 8:
 				display->dispsw = &fbcon_cfb8;
-				display->dispsw_data = fbcon_cmap.cfb8;
+				display->dispsw_data = info->pseudo_palette;
 				break;
 #endif
 			default:
@@ -373,6 +374,7 @@
 	fb_info.changevar = NULL;
 	fb_info.node = NODEV;
 	fb_info.fbops = &tx3912fb_ops;
+	fb_info.pseudo_palette = pseudo_palette;
 	fb_info.disp = &global_disp;
 	fb_info.switch_con = &tx3912fbcon_switch;
 	fb_info.updatevar = &tx3912fbcon_updatevar;
@@ -461,7 +463,7 @@
 
 #ifdef FBCON_HAS_CFB8
 	if( regno < 16 )
-		fbcon_cmap.cfb8[regno] = ((red & 0xe000) >> 8)
+		((u16 *)(info->pseudo_palette))[regno] = ((red & 0xe000) >> 8)
 					| ((green & 0xe000) >> 11)
 					| ((blue & 0xc000) >> 14);
 #endif 
diff -urN -X /home/jsimmons/dontdiff linux-2.5.2-dj2/drivers/video/vesafb.c linux/drivers/video/vesafb.c
--- linux-2.5.2-dj2/drivers/video/vesafb.c	Thu Jan 17 17:34:12 2002
+++ linux/drivers/video/vesafb.c	Fri Jan 18 12:49:36 2002
@@ -80,18 +80,7 @@
 static struct display disp;
 static struct fb_info fb_info;
 static struct { u_short blue, green, red, pad; } palette[256];
-static union {
-#ifdef FBCON_HAS_CFB16
-    u16 cfb16[16];
-#endif
-#ifdef FBCON_HAS_CFB24
-    u32 cfb24[16];
-#endif
-#ifdef FBCON_HAS_CFB32
-    u32 cfb32[16];
-#endif
-} fbcon_cmap;
-
+static u32		pseudo_palette[17];
 static int             inverse   = 0;
 static int             mtrr      = 0;
 
@@ -204,19 +193,19 @@
 	case 15:
 	case 16:
 		sw = &fbcon_cfb16;
-		display->dispsw_data = fbcon_cmap.cfb16;
+		display->dispsw_data = fb_info.pseudo_palette;
 		break;
 #endif
 #ifdef FBCON_HAS_CFB24
 	case 24:
 		sw = &fbcon_cfb24;
-		display->dispsw_data = fbcon_cmap.cfb24;
+		display->dispsw_data = fb_info.pseudo_palette;
 		break;
 #endif
 #ifdef FBCON_HAS_CFB32
 	case 32:
 		sw = &fbcon_cfb32;
-		display->dispsw_data = fbcon_cmap.cfb32;
+		display->dispsw_data = fb_info.pseudo_palette;
 		break;
 #endif
 	default:
@@ -357,13 +346,13 @@
 	case 16:
 		if (vesafb_defined.red.offset == 10) {
 			/* 1:5:5:5 */
-			fbcon_cmap.cfb16[regno] =
+			((u16 *)(fb_info->pseudo_palette))[regno] =
 				((red   & 0xf800) >>  1) |
 				((green & 0xf800) >>  6) |
 				((blue  & 0xf800) >> 11);
 		} else {
 			/* 0:5:6:5 */
-			fbcon_cmap.cfb16[regno] =
+			((u16 *)(fb_info->pseudo_palette))[regno] =
 				((red   & 0xf800)      ) |
 				((green & 0xfc00) >>  5) |
 				((blue  & 0xf800) >> 11);
@@ -372,21 +361,13 @@
 #endif
 #ifdef FBCON_HAS_CFB24
 	case 24:
-		red   >>= 8;
-		green >>= 8;
-		blue  >>= 8;
-		fbcon_cmap.cfb24[regno] =
-			(red   << vesafb_defined.red.offset)   |
-			(green << vesafb_defined.green.offset) |
-			(blue  << vesafb_defined.blue.offset);
-		break;
-#endif
 #ifdef FBCON_HAS_CFB32
 	case 32:
+#endif
 		red   >>= 8;
 		green >>= 8;
 		blue  >>= 8;
-		fbcon_cmap.cfb32[regno] =
+		((u32 *)(fb_info->pseudo_palette))[regno] =
 			(red   << vesafb_defined.red.offset)   |
 			(green << vesafb_defined.green.offset) |
 			(blue  << vesafb_defined.blue.offset);
@@ -619,6 +600,7 @@
 	fb_info.switch_con=&vesafb_switch;
 	fb_info.updatevar=&vesafb_update_var;
 	fb_info.flags=FBINFO_FLAG_DEFAULT;
+	fb_info.pseudo_palette = pseudo_palette;
 	vesafb_set_disp(-1);
 
 	if (register_framebuffer(&fb_info)<0)
diff -urN -X /home/jsimmons/dontdiff linux-2.5.2-dj2/drivers/video/vfb.c linux/drivers/video/vfb.c
--- linux-2.5.2-dj2/drivers/video/vfb.c	Thu Jan 17 17:34:12 2002
+++ linux/drivers/video/vfb.c	Fri Jan 18 14:09:12 2002
@@ -46,17 +46,7 @@
 static struct display disp;
 static struct fb_info fb_info;
 static struct { u_char red, green, blue, pad; } palette[256];
-static union {
-#ifdef FBCON_HAS_CFB16
-    u16 cfb16[16];
-#endif
-#ifdef FBCON_HAS_CFB24
-    u32 cfb24[16];
-#endif
-#ifdef FBCON_HAS_CFB32
-    u32 cfb32[16];
-#endif
-} fbcon_cmap;
+static u32 pseudo_palette[17];
 static char vfb_name[16] = "Virtual FB";
 
 static struct fb_var_screeninfo vfb_default = {
@@ -263,19 +253,19 @@
 #ifdef FBCON_HAS_CFB16
 		case 16:
 		    display->dispsw = &fbcon_cfb16;
-		    display->dispsw_data = fbcon_cmap.cfb16;
+		    display->dispsw_data = info->pseudo_palette;
 		    break;
 #endif
 #ifdef FBCON_HAS_CFB24
 		case 24:
 		    display->dispsw = &fbcon_cfb24;
-		    display->dispsw_data = fbcon_cmap.cfb24;
+		    display->dispsw_data = info->pseudo_palette;
 		    break;
 #endif
 #ifdef FBCON_HAS_CFB32
 		case 32:
 		    display->dispsw = &fbcon_cfb32;
-		    display->dispsw_data = fbcon_cmap.cfb32;
+		    display->dispsw_data = info->pseudo_palette;
 		    break;
 #endif
 		default:
@@ -377,6 +367,7 @@
     fb_info.changevar = NULL;
     fb_info.node = NODEV;
     fb_info.fbops = &vfb_ops;
+    fb_info.pseudo_palette = pseudo_palette;	
     fb_info.disp = &disp;
     fb_info.switch_con = &vfbcon_switch;
     fb_info.updatevar = &vfbcon_updatevar;
diff -urN -X /home/jsimmons/dontdiff linux-2.5.2-dj2/drivers/video/virgefb.c linux/drivers/video/virgefb.c
--- linux-2.5.2-dj2/drivers/video/virgefb.c	Thu Jan 17 17:34:12 2002
+++ linux/drivers/video/virgefb.c	Fri Jan 18 14:10:49 2002
@@ -111,12 +111,7 @@
 
 static struct display disp;
 static struct fb_info fb_info;
-
-static union {
-#ifdef FBCON_HAS_CFB16
-    u16 cfb16[16];
-#endif
-} fbcon_cmap;
+static u16 pseudo_palette[17]; 
 
 /*
  *    Switch for Chipset Independency
@@ -589,7 +584,7 @@
 #endif
 #ifdef FBCON_HAS_CFB16
 		case 16:
-			fbcon_cmap.cfb16[regno] =
+			((u16 *)(info->pseudo_palette))[regno] =
 				((red  & 0xf800) |
 				((green & 0xfc00) >> 5) |
 				((blue  & 0xf800) >> 11));
@@ -961,7 +956,7 @@
 				display->dispsw = &fbcon_virge16;
 			} else
 				display->dispsw = &fbcon_cfb16;
-			display->dispsw_data = &fbcon_cmap.cfb16;
+			display->dispsw_data = &info->pseudo_palette;
 			break;
 #endif
 		default:
@@ -1129,6 +1124,7 @@
 	    fb_info.changevar = NULL;
 	    fb_info.node = NODEV;
 	    fb_info.fbops = &virgefb_ops;
+	    fb_info.pseudo_palette = pseudo_palette;
 	    fb_info.disp = &disp;
 	    fb_info.switch_con = &Cyberfb_switch;
 	    fb_info.updatevar = &Cyberfb_updatevar;

