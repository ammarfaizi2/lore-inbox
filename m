Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314379AbSEBMbD>; Thu, 2 May 2002 08:31:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314380AbSEBMbC>; Thu, 2 May 2002 08:31:02 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:41951 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S314379AbSEBMbA>;
	Thu, 2 May 2002 08:31:00 -0400
From: Paul Mackerras <paulus@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15569.12507.794100.835854@argo.ozlabs.ibm.com>
Date: Thu, 2 May 2002 22:28:11 +1000 (EST)
To: James Simmons <jsimmons@transvirtual.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        benh@kernel.crashing.org
Subject: Re: 2.5.11 framebuffer compilation error 
In-Reply-To: <Pine.LNX.4.10.10204291056490.15166-100000@www.transvirtual.com>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Simmons writes:

> Diff:
> 
> http://www.transvirtual.com/~jsimmons/fbdev_fixs.diff

I tried 2.5.12 with this patch on PPC, with most of the mac
framebuffers selected, and got a few errors.  Here is a patch that
fixes the compilation errors plus a few other things.

The files affected are:

chipsfb.c   )
controlfb.c )		fix compile errors from recent changes
platinumfb.c)
valkyriefb.c)

offb.c			fix a problem with colormap corruption on blank
			add support for IBM GXT2000P display
			fix compile errors from recent changes

aty128.h		remove duplicate definition
aty128fb.c		add btext_update_display call
			add Rage128 Pro TR
			eliminate compile warnings
			make aty128fb_blank be actually used
			add more default resolutions based on
			  which type of powermac we have

imsttfb.c		eliminate compile warning

aty/atyfb_base.c	add btext_update_display call

Some of these changes have come from Ben Herrenschmidt.

I have changes to the radeon driver too but I haven't included them in
this patch since I am using version 0.1.4 in my tree at the moment
whereas Linus' tree only has version 0.1.1.

James, it would be good if you could look at this and either apply it,
or let me know if there is anything you don't like so we can discuss
it.

Regards,
Paul.

diff -urN ltest/drivers/video/aty/atyfb_base.c pmac-2.5/drivers/video/aty/atyfb_base.c
--- ltest/drivers/video/aty/atyfb_base.c	Thu May  2 22:08:08 2002
+++ pmac-2.5/drivers/video/aty/atyfb_base.c	Thu May  2 21:44:26 2002
@@ -87,6 +87,9 @@
 #include <linux/adb.h>
 #include <linux/pmu.h>
 #endif
+#ifdef CONFIG_BOOTX_TEXT
+#include <asm/btext.h>
+#endif
 #ifdef CONFIG_NVRAM
 #include <linux/nvram.h>
 #endif
@@ -815,6 +818,13 @@
 	display_info.disp_reg_address = info->ati_regbase_phys;
     }
 #endif /* CONFIG_FB_COMPAT_XPMAC */
+#ifdef CONFIG_BOOTX_TEXT
+    btext_update_display(info->frame_buffer_phys,
+		    (((par->crtc.h_tot_disp>>16) & 0xff)+1)*8,
+		    ((par->crtc.v_tot_disp>>16) & 0x7ff)+1,
+		    par->crtc.bpp,
+		    par->crtc.vxres*par->crtc.bpp/8);
+#endif /* CONFIG_BOOTX_TEXT */
 }
 
 static int atyfb_decode_var(const struct fb_var_screeninfo *var,
diff -urN ltest/drivers/video/aty128.h pmac-2.5/drivers/video/aty128.h
--- ltest/drivers/video/aty128.h	Wed Feb  6 04:40:16 2002
+++ pmac-2.5/drivers/video/aty128.h	Fri Feb 15 22:04:12 2002
@@ -267,7 +267,6 @@
 #define DAC_MASK				0xFF000000
 #define DAC_BLANKING				0x00000004
 #define DAC_RANGE_CNTL				0x00000003
-#define DAC_RANGE_CNTL				0x00000003
 #define DAC_PALETTE_ACCESS_CNTL			0x00000020
 #define DAC_PDWN				0x00008000
 
diff -urN ltest/drivers/video/aty128fb.c pmac-2.5/drivers/video/aty128fb.c
--- ltest/drivers/video/aty128fb.c	Mon Apr 29 16:25:24 2002
+++ pmac-2.5/drivers/video/aty128fb.c	Thu May  2 19:43:03 2002
@@ -70,6 +70,9 @@
 #ifdef CONFIG_FB_COMPAT_XPMAC
 #include <asm/vc_ioctl.h>
 #endif
+#ifdef CONFIG_BOOTX_TEXT
+#include <asm/btext.h>
+#endif /* CONFIG_BOOTX_TEXT */
 
 #include <video/fbcon.h>
 #include <video/fbcon-cfb8.h>
@@ -154,6 +157,7 @@
     {"Rage128 RL (AGP)", PCI_DEVICE_ID_ATI_RAGE128_RL, rage_128},
     {"Rage128 Pro PF (AGP)", PCI_DEVICE_ID_ATI_RAGE128_PF, rage_128_pro},
     {"Rage128 Pro PR (PCI)", PCI_DEVICE_ID_ATI_RAGE128_PR, rage_128_pro},
+    {"Rage128 Pro TR (AGP)", PCI_DEVICE_ID_ATI_RAGE128_U3, rage_128_pro},
     {"Rage Mobility M3 (PCI)", PCI_DEVICE_ID_ATI_RAGE128_LE, rage_M3},
     {"Rage Mobility M3 (AGP)", PCI_DEVICE_ID_ATI_RAGE128_LF, rage_M3},
     {NULL, 0, rage_128}
@@ -216,9 +220,13 @@
 static char fontname[40] __initdata = { 0 };
 
 static int  noaccel __initdata = 0;
+#ifdef MODULE
 static char *font __initdata = NULL;
 static char *mode __initdata = NULL;
+#ifdef CONFIG_MTRR
 static int  nomtrr __initdata = 0;
+#endif
+#endif /* MODULE */
 
 static char *mode_option __initdata = NULL;
 
@@ -418,6 +426,7 @@
 	fb_set_cmap:	gen_set_cmap,
 	fb_setcolreg:	aty128fb_setcolreg,
 	fb_pan_display:	aty128fb_pan_display,
+	fb_blank:	aty128fb_blank,
 	fb_rasterimg:	aty128fb_rasterimg,
 };
 
@@ -1243,6 +1252,13 @@
 	display_info.disp_reg_address = info->regbase_phys;
     }
 #endif /* CONFIG_FB_COMPAT_XPMAC */
+#if defined(CONFIG_BOOTX_TEXT)
+    btext_update_display(info->frame_buffer_phys,
+		    (((par->crtc.h_total>>16) & 0xff)+1)*8,
+		    ((par->crtc.v_total>>16) & 0x7ff)+1,
+		    par->crtc.bpp,
+		    par->crtc.vxres*par->crtc.bpp/8);
+#endif /* CONFIG_BOOTX_TEXT */
 }
 
     /*
@@ -1584,7 +1600,7 @@
     if (!options || !*options)
 	return 0;
 
-    while (this_opt = strsep(&options, ",")) {
+    while ((this_opt = strsep(&options, ",")) != NULL) {
 	if (!strncmp(this_opt, "font:", 5)) {
 	    char *p;
 	    int i;
@@ -1686,6 +1702,29 @@
         } else {
             if (default_vmode <= 0 || default_vmode > VMODE_MAX)
                 default_vmode = VMODE_1024_768_60;
+
+	    /* iMacs need that resolution
+	     * PowerMac2,1 first r128 iMacs
+	     * PowerMac2,2 summer 2000 iMacs
+	     * PowerMac4,1 january 2001 iMacs "flower power"
+	     */
+	    if (machine_is_compatible("PowerMac2,1") ||
+		machine_is_compatible("PowerMac2,2") ||
+		machine_is_compatible("PowerMac4,1"))
+		default_vmode = VMODE_1024_768_75;
+
+	    /* iBook SE */
+	    if (machine_is_compatible("PowerBook2,2"))
+		default_vmode = VMODE_800_600_60;
+ 
+	    /* PowerBook Firewire (Pismo), iBook Dual USB */
+	    if (machine_is_compatible("PowerBook3,1") ||
+	    	machine_is_compatible("PowerBook4,1"))
+		default_vmode = VMODE_1024_768_60;
+
+	    /* PowerBook Titanium */
+	    if (machine_is_compatible("PowerBook3,2"))
+		default_vmode = VMODE_1152_768_60;
 
             if (default_cmode < CMODE_8 || default_cmode > CMODE_32)
                 default_cmode = CMODE_8;
diff -urN ltest/drivers/video/chipsfb.c pmac-2.5/drivers/video/chipsfb.c
--- ltest/drivers/video/chipsfb.c	Thu May  2 22:08:08 2002
+++ pmac-2.5/drivers/video/chipsfb.c	Thu May  2 21:44:26 2002
@@ -312,7 +312,7 @@
 	struct fb_var_screeninfo* var = &p->var;
 	
 	if (bpp == 16) {
-		if (con == info->currcon) {
+		if (con == p->info.currcon) {
 			write_cr(0x13, 200);		// Set line length (doublewords)
 			write_xr(0x81, 0x14);		// 15 bit (555) color mode
 			write_xr(0x82, 0x00);		// Disable palettes
@@ -334,7 +334,7 @@
 		disp->dispsw = &fbcon_dummy;
 #endif
 	} else if (bpp == 8) {
-		if (con == info->currcon) {
+		if (con == p->info.currcon) {
 			write_cr(0x13, 100);		// Set line length (doublewords)
 			write_xr(0x81, 0x12);		// 8 bit color mode
 			write_xr(0x82, 0x08);		// Graphics gamma enable
diff -urN ltest/drivers/video/controlfb.c pmac-2.5/drivers/video/controlfb.c
--- ltest/drivers/video/controlfb.c	Thu May  2 22:08:08 2002
+++ pmac-2.5/drivers/video/controlfb.c	Thu May  2 21:46:35 2002
@@ -149,7 +149,7 @@
 	struct fb_info *info);
 static int control_get_cmap(struct fb_cmap *cmap, int kspc, int con,
 	struct fb_info *info);
-static int controlfb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
+static int control_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
 	u_int transp, struct fb_info *info);
 static int controlfb_blank(int blank_mode, struct fb_info *info);
 static int control_mmap(struct fb_info *info, struct file *file,
@@ -225,7 +225,7 @@
 	fb_set_var:	control_set_var,
 	fb_get_cmap:	control_get_cmap,
 	fb_set_cmap:	gen_set_cmap,
-	fb_setcolreg:	controlfb_setcolreg,
+	fb_setcolreg:	control_setcolreg,
 	fb_pan_display:	control_pan_display,
 	fb_blank:	controlfb_blank,
 	fb_mmap:	control_mmap,
@@ -520,7 +520,7 @@
 	return 0;
 }
 
-static int controlfb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
+static int control_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
 			     u_int transp, struct fb_info *info)
 {
 	struct fb_info_control *p = (struct fb_info_control *) info;
@@ -1238,7 +1238,7 @@
     u8 *dest;
     int bytes = p->next_line, rows;
 
-    dest = p->info.screen_base + yy * fontheight(p) * bytes + xx * fontwidth(p)*2;
+    dest = p->fb_info->screen_base + yy * fontheight(p) * bytes + xx * fontwidth(p)*2;
     for (rows = fontheight(p); rows--; dest += bytes) {
        switch (fontwidth(p)) {
        case 16:
@@ -1261,7 +1261,7 @@
     u8 *dest;
     int bytes = p->next_line, rows;
 
-    dest = p->info.screen_base + yy * fontheight(p) * bytes + xx * fontwidth(p) * 4;
+    dest = p->fb_info->screen_base + yy * fontheight(p) * bytes + xx * fontwidth(p) * 4;
     for (rows = fontheight(p); rows--; dest += bytes) {
        switch (fontwidth(p)) {
        case 16:
diff -urN ltest/drivers/video/imsttfb.c pmac-2.5/drivers/video/imsttfb.c
--- ltest/drivers/video/imsttfb.c	Mon Apr 29 16:25:24 2002
+++ pmac-2.5/drivers/video/imsttfb.c	Wed May  1 10:54:14 2002
@@ -1908,7 +1908,7 @@
 			p->ramdac = TVP;
 			break;
 		default:
-			printk(KERN_INFO "imsttfb: Device 0x%lx unknown, "
+			printk(KERN_INFO "imsttfb: Device 0x%x unknown, "
 					 "contact maintainer.\n", pdev->device);
 			return -ENODEV;
 	}
diff -urN ltest/drivers/video/offb.c pmac-2.5/drivers/video/offb.c
--- ltest/drivers/video/offb.c	Mon Apr 29 16:25:24 2002
+++ pmac-2.5/drivers/video/offb.c	Thu May  2 21:46:47 2002
@@ -49,7 +49,8 @@
 	cmap_r128,	/* ATI Rage128 */
 	cmap_M3A,	/* ATI Rage Mobility M3 Head A */
 	cmap_M3B,	/* ATI Rage Mobility M3 Head B */
-	cmap_radeon	/* ATI Radeon */
+	cmap_radeon,	/* ATI Radeon */
+	cmap_gxt2000	/* IBM GXT2000 */
 };
 
 struct fb_info_offb {
@@ -61,6 +62,7 @@
     volatile unsigned char *cmap_adr;
     volatile unsigned char *cmap_data;
     int cmap_type;
+    int blanked;
     union {
 #ifdef FBCON_HAS_CFB16
 	u16 cfb16[16];
@@ -207,9 +209,11 @@
 static int offb_get_cmap(struct fb_cmap *cmap, int kspc, int con,
 			 struct fb_info *info)
 {
-    if (con == info->currcon) /* current console? */
+    struct fb_info_offb *info2 = (struct fb_info_offb *)info;
+
+    if (con == info->currcon && !info2->blanked) /* current console? */
 	return fb_get_cmap(cmap, kspc, offb_getcolreg, info);
-    else if (fb_display[con].cmap.len) /* non default colormap? */
+    if (fb_display[con].cmap.len) /* non default colormap? */
 	fb_copy_cmap(&fb_display[con].cmap, cmap, kspc ? 0 : 2);
     else
     {
@@ -237,7 +241,7 @@
 	if ((err = fb_alloc_cmap(&fb_display[con].cmap, size, 0)))
 	    return err;
     }
-    if (con == info->currcon)			/* current console? */
+    if (con == info->currcon && !info2->blanked)	/* current console? */
 	return fb_set_cmap(cmap, kspc, info);
     else
 	fb_copy_cmap(cmap, &fb_display[con].cmap, kspc ? 0 : 1);
@@ -254,7 +258,16 @@
     int i, j;
 
     if (!info2->cmap_adr)
-	return;
+	return 0;
+
+    if (!info2->blanked) {
+	if (!blank)
+	    return 0;
+	if (fb_display[info->currcon].cmap.len)
+	    fb_get_cmap(&fb_display[info->currcon].cmap, 1, offb_getcolreg, info);
+    }
+
+    info2->blanked = blank;
 
     if (blank)
 	for (i = 0; i < 256; i++) {
@@ -288,6 +301,9 @@
     	        out_8(info2->cmap_adr + 0xb0, i);
 	    	out_le32((unsigned *)(info2->cmap_adr + 0xb4), 0);
 	    	break;
+	    case cmap_gxt2000:
+		out_le32((unsigned *)info2->cmap_adr + i, 0);
+		break;
 	    }
 	}
     else
@@ -496,6 +512,10 @@
 		info->cmap_adr = ioremap(base + 0x7ff000, 0x1000) + 0xcc0;
 		info->cmap_data = info->cmap_adr + 1;
 		info->cmap_type = cmap_m64;
+	} else if (device_is_compatible(dp, "pci1014,b7")) {
+		unsigned long regbase = dp->addrs[0].address;
+		info->cmap_adr = ioremap(regbase + 0x6000, 0x1000);
+		info->cmap_type = cmap_gxt2000;
 	}
         fix->visual = info->cmap_adr ? FB_VISUAL_PSEUDOCOLOR
 				     : FB_VISUAL_STATIC_PSEUDOCOLOR;
@@ -667,8 +687,10 @@
 
 static int offbcon_switch(int con, struct fb_info *info)
 {
+    struct fb_info_offb *info2 = (struct fb_info_offb *)info;
+
     /* Do we have to save the colormap? */
-    if (fb_display[info->currcon].cmap.len)
+    if (fb_display[info->currcon].cmap.len && !info2->blanked)
 	fb_get_cmap(&fb_display[info->currcon].cmap, 1, offb_getcolreg, info);
 
     info->currcon = con;
@@ -765,6 +787,10 @@
 	out_8(info2->cmap_adr + 0xb0, regno);
   	out_le32((unsigned *)(info2->cmap_adr + 0xb4),
     		(red << 16 | green << 8 | blue));
+	break;
+    case cmap_gxt2000:
+	out_le32((unsigned *)info2->cmap_adr + regno,
+		 (red << 16 | green << 8 | blue));
 	break;
     }
 
diff -urN ltest/drivers/video/platinumfb.c pmac-2.5/drivers/video/platinumfb.c
--- ltest/drivers/video/platinumfb.c	Thu May  2 22:08:08 2002
+++ pmac-2.5/drivers/video/platinumfb.c	Thu May  2 21:44:26 2002
@@ -329,10 +329,10 @@
 	struct fb_info_platinum *info = (struct fb_info_platinum *) fb;
 	struct fb_par_platinum par;
 
-	if (fb_display[info->currcon].cmap.len)
-		fb_get_cmap(&fb_display[info->currcon].cmap, 1, platinum_getcolreg,
+	if (fb_display[fb->currcon].cmap.len)
+		fb_get_cmap(&fb_display[fb->currcon].cmap, 1, platinum_getcolreg,
 			    fb);
-	info->currcon = con;
+	fb->currcon = con;
 
 	platinum_var_to_par(&fb_display[con].var, &par, info);
 	platinum_set_par(&par, info);
diff -urN ltest/drivers/video/valkyriefb.c pmac-2.5/drivers/video/valkyriefb.c
--- ltest/drivers/video/valkyriefb.c	Mon Apr 29 16:25:25 2002
+++ pmac-2.5/drivers/video/valkyriefb.c	Thu May  2 21:37:03 2002
@@ -260,7 +260,7 @@
 			    fb);
 	fb->currcon = con;
 #if 1
-	valkyrie_var_to_par(&fb_display[currcon].var, &par, fb);
+	valkyrie_var_to_par(&fb_display[fb->currcon].var, &par, fb);
 	valkyrie_set_par(&par, info);
 	do_install_cmap(con, fb);
 #else
