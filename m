Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265946AbUGIL2z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265946AbUGIL2z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 07:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266002AbUGIL2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 07:28:55 -0400
Received: from honk1.physik.uni-konstanz.de ([134.34.140.224]:46226 "EHLO
	honk1.physik.uni-konstanz.de") by vger.kernel.org with ESMTP
	id S265946AbUGIL2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 07:28:19 -0400
Date: Fri, 9 Jul 2004 13:25:40 +0200
From: Guido Guenther <agx@sigxcpu.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Antonino Daplas <adaplas@pol.net>, Andrew Morton <akpm@osdl.org>
Subject: [Patch]: Fix rivafb's NV_ARCH_, cleanup DEBUG, backlight control on ppc
Message-ID: <20040709112539.GA2286@bogon.ms20.nix>
References: <20040601041604.GA2344@bogon.ms20.nix> <1086064086.1978.0.camel@gaston> <20040601135335.GA5406@bogon.ms20.nix> <20040616070326.GE28487@bogon.ms20.nix> <20040620192549.GA4307@bogon.ms20.nix> <1087791100.24157.9.camel@gaston> <20040621071159.GA7017@bogon.ms20.nix> <1087832204.22683.11.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1087832204.22683.11.camel@gaston>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2004 at 10:36:44AM -0500, Benjamin Herrenschmidt wrote:
> Ok, well, it looks good to me. There is no active maintainer for rivafb
> so, I suppose if nobody complains of breakage, it should be fine.
Since this isn't in yet. Here's another version that:
 - fixes the PCI-IDs (needed to get it to work on at least the NV17)
 - cleans up the DEBUG option (similar to the new radeonfb). This also
   makes it easy to replace printk by btext_printf() (on ppc) or similar
   to ease debugging of the fb code when all else fails.
 - adds backlight control for Apple powerbooks
Patch is against 2.6.7-bk20. Please apply,
 -- Guido

Signed-off-by: Guido Guenther <agx@sigxcpu.org>

--- ../linux-2.6.7-bk20.orig/drivers/video/riva/fbdev.c	2004-07-09 10:26:30.000000000 +0200
+++ drivers/video/riva/fbdev.c	2004-07-09 13:06:29.000000000 +0200
@@ -48,6 +48,9 @@
 #include <asm/prom.h>
 #include <asm/pci-bridge.h>
 #endif
+#ifdef CONFIG_PMAC_BACKLIGHT
+#include <asm/backlight.h>
+#endif
 
 #include "rivafb.h"
 #include "nvreg.h"
@@ -64,15 +67,16 @@
  * various helpful macros and constants
  *
  * ------------------------------------------------------------------------- */
-
-#undef RIVAFBDEBUG
-#ifdef RIVAFBDEBUG
-#define DPRINTK(fmt, args...) printk(KERN_DEBUG "%s: " fmt, __FUNCTION__ , ## args)
+#ifdef CONFIG_FB_RIVA_DEBUG
+#define NVTRACE          printk
 #else
-#define DPRINTK(fmt, args...)
+#define NVTRACE          if(0) printk
 #endif
 
-#ifndef RIVA_NDEBUG
+#define NVTRACE_ENTER(...)  NVTRACE("%s START\n", __FUNCTION__)
+#define NVTRACE_LEAVE(...)  NVTRACE("%s END\n", __FUNCTION__)
+
+#ifdef CONFIG_FB_RIVA_DEBUG
 #define assert(expr) \
 	if(!(expr)) { \
 	printk( "Assertion failed! %s,%s,%s,line=%d\n",\
@@ -173,18 +177,18 @@
 	{ "GeForce2-GTS", NV_ARCH_10 },
 	{ "GeForce2-ULTRA", NV_ARCH_10 },
 	{ "Quadro2-PRO", NV_ARCH_10 },
-	{ "GeForce4-MX-460", NV_ARCH_20 },
-	{ "GeForce4-MX-440", NV_ARCH_20 },
-	{ "GeForce4-MX-420", NV_ARCH_20 },
-	{ "GeForce4-440-GO", NV_ARCH_20 },
-	{ "GeForce4-420-GO", NV_ARCH_20 },
-	{ "GeForce4-420-GO-M32", NV_ARCH_20 },
-	{ "Quadro4-500-XGL", NV_ARCH_20 },
-	{ "GeForce4-440-GO-M64", NV_ARCH_20 },
-	{ "Quadro4-200", NV_ARCH_20 },
-	{ "Quadro4-550-XGL", NV_ARCH_20 },
-	{ "Quadro4-500-GOGL", NV_ARCH_20 },
-	{ "GeForce2", NV_ARCH_20 },
+	{ "GeForce4-MX-460", NV_ARCH_10 },
+	{ "GeForce4-MX-440", NV_ARCH_10 },
+	{ "GeForce4-MX-420", NV_ARCH_10 },
+	{ "GeForce4-440-GO", NV_ARCH_10 },
+	{ "GeForce4-420-GO", NV_ARCH_10 },
+	{ "GeForce4-420-GO-M32", NV_ARCH_10 },
+	{ "Quadro4-500-XGL", NV_ARCH_10 },
+	{ "GeForce4-440-GO-M64", NV_ARCH_10 },
+	{ "Quadro4-200", NV_ARCH_10 },
+	{ "Quadro4-550-XGL", NV_ARCH_10 },
+	{ "Quadro4-500-GOGL", NV_ARCH_10 },
+	{ "GeForce2", NV_ARCH_10 },
 	{ "GeForce3", NV_ARCH_20 }, 
 	{ "GeForce3 Ti 200", NV_ARCH_20 },
 	{ "GeForce3 Ti 500", NV_ARCH_20 },
@@ -351,6 +355,38 @@
 	0xEB							/* MISC */
 };
 
+/*
+ * Backlight control
+ */
+#ifdef CONFIG_PMAC_BACKLIGHT
+
+static int riva_backlight_levels[] = {
+    0x158,
+    0x192,
+    0x1c6,
+    0x200,
+    0x234,
+    0x268,
+    0x2a2,
+    0x2d6,
+    0x310,
+    0x344,
+    0x378,
+    0x3b2,
+    0x3e6,
+    0x41a,
+    0x454,
+    0x534,
+};
+
+static int riva_set_backlight_enable(int on, int level, void *data);
+static int riva_set_backlight_level(int level, void *data);
+static struct backlight_controller riva_backlight_controller = {
+	riva_set_backlight_enable,
+	riva_set_backlight_level
+};
+#endif /* CONFIG_PMAC_BACKLIGHT */
+
 /* ------------------------------------------------------------------------- *
  *
  * MMIO access macros
@@ -592,6 +628,7 @@
 {
 	int i;
 
+	NVTRACE_ENTER();
 	par->riva.LockUnlock(&par->riva, 0);
 
 	par->riva.UnloadStateExt(&par->riva, &regs->ext);
@@ -609,6 +646,7 @@
 
 	for (i = 0; i < NUM_SEQ_REGS; i++)
 		regs->seq[i] = SEQin(par, i);
+	NVTRACE_LEAVE();
 }
 
 /**
@@ -630,6 +668,7 @@
 	RIVA_HW_STATE *state = &regs->ext;
 	int i;
 
+	NVTRACE_ENTER();
 	CRTCout(par, 0x11, 0x00);
 
 	par->riva.LockUnlock(&par->riva, 0);
@@ -656,6 +695,7 @@
 
 	for (i = 0; i < NUM_SEQ_REGS; i++)
 		SEQout(par, i, regs->seq[i]);
+	NVTRACE_LEAVE();
 }
 
 /**
@@ -676,6 +716,7 @@
 	struct riva_par *par = (struct riva_par *) info->par;
 	struct riva_regs newmode;
 	
+	NVTRACE_ENTER();
 	/* time to calculate */
 	rivafb_blank(1, info);
 
@@ -806,10 +847,12 @@
 	riva_load_state(par, &par->current_state);
 	par->riva.LockUnlock(&par->riva, 0); /* important for HW cursor */
 	rivafb_blank(0, info);
+	NVTRACE_LEAVE();
 }
 
 static void riva_update_var(struct fb_var_screeninfo *var, struct fb_videomode *modedb)
 {
+	NVTRACE_ENTER();
 	var->xres = var->xres_virtual = modedb->xres;
 	var->yres = modedb->yres;
         if (var->yres_virtual < var->yres)
@@ -824,6 +867,7 @@
         var->vsync_len = modedb->vsync_len;
         var->sync = modedb->sync;
         var->vmode = modedb->vmode;
+	NVTRACE_LEAVE();
 }
 
 /**
@@ -859,6 +903,7 @@
 	};
 	int i;
 
+	NVTRACE_ENTER();
 	/* use highest possible virtual resolution */
 	if (var->xres_virtual == -1 && var->yres_virtual == -1) {
 		printk(KERN_WARNING PFX
@@ -871,7 +916,7 @@
 		if (modes[i].xres == -1) {
 			printk(KERN_ERR PFX
 			       "could not find a virtual resolution that fits into video memory!!\n");
-			DPRINTK("EXIT - EINVAL error\n");
+			NVTRACE("EXIT - EINVAL error\n");
 			return -EINVAL;
 		}
 		var->xres_virtual = modes[i].xres;
@@ -897,7 +942,7 @@
 			printk(KERN_ERR PFX
 			       "mode %dx%dx%d rejected...resolution too high to fit into video memory!\n",
 			       var->xres, var->yres, var->bits_per_pixel);
-			DPRINTK("EXIT - EINVAL error\n");
+			NVTRACE("EXIT - EINVAL error\n");
 			return -EINVAL;
 		}
 	}
@@ -924,7 +969,7 @@
 		var->yres_virtual = 0x7fff/nom;
 	if (var->xres_virtual > 0x7fff/nom)
 		var->xres_virtual = 0x7fff/nom;
-
+	NVTRACE_LEAVE();
 	return 0;
 }
 
@@ -1004,6 +1049,36 @@
 
 /* ------------------------------------------------------------------------- *
  *
+ * Backlight operations
+ *
+ * ------------------------------------------------------------------------- */
+
+#ifdef CONFIG_PMAC_BACKLIGHT
+static int riva_set_backlight_enable(int on, int level, void *data)
+{
+	struct riva_par *par = (struct riva_par *)data;
+	U032 tmp_pcrt, tmp_pmc;
+
+	tmp_pmc = par->riva.PMC[0x10F0/4] & 0x0000FFFF;
+	tmp_pcrt = par->riva.PCRTC0[0x081C/4] & 0xFFFFFFFC;
+	if(on && (level > BACKLIGHT_OFF)) {
+		tmp_pcrt |= 0x1;
+		tmp_pmc |= (1 << 31); // backlight bit
+		tmp_pmc |= riva_backlight_levels[level-1] << 16; // level
+	}
+	par->riva.PCRTC0[0x081C/4] = tmp_pcrt;
+	par->riva.PMC[0x10F0/4] = tmp_pmc;
+	return 0;
+}
+
+static int riva_set_backlight_level(int level, void *data)
+{
+	return riva_set_backlight_enable(1, level, data);
+}
+#endif /* CONFIG_PMAC_BACKLIGHT */
+
+/* ------------------------------------------------------------------------- *
+ *
  * framebuffer operations
  *
  * ------------------------------------------------------------------------- */
@@ -1013,6 +1088,7 @@
 	struct riva_par *par = (struct riva_par *) info->par;
 	int cnt = atomic_read(&par->ref_count);
 
+	NVTRACE_ENTER();
 	if (!cnt) {
 		memset(&par->state, 0, sizeof(struct vgastate));
 		par->state.flags = VGA_SAVE_MODE  | VGA_SAVE_FONTS;
@@ -1029,6 +1105,7 @@
 		riva_save_state(par, &par->initial_state);
 	}
 	atomic_inc(&par->ref_count);
+	NVTRACE_LEAVE();
 	return 0;
 }
 
@@ -1037,6 +1114,7 @@
 	struct riva_par *par = (struct riva_par *) info->par;
 	int cnt = atomic_read(&par->ref_count);
 
+	NVTRACE_ENTER();
 	if (!cnt)
 		return -EINVAL;
 	if (cnt == 1) {
@@ -1047,6 +1125,7 @@
 		par->riva.LockUnlock(&par->riva, 1);
 	}
 	atomic_dec(&par->ref_count);
+	NVTRACE_LEAVE();
 	return 0;
 }
 
@@ -1056,6 +1135,7 @@
 	int nom, den;		/* translating from pixels->bytes */
 	int mode_valid = 0;
 	
+	NVTRACE_ENTER();
 	switch (var->bits_per_pixel) {
 	case 1 ... 8:
 		var->red.offset = var->green.offset = var->blue.offset = 0;
@@ -1101,7 +1181,7 @@
 		printk(KERN_ERR PFX
 		       "mode %dx%dx%d rejected...color depth not supported.\n",
 		       var->xres, var->yres, var->bits_per_pixel);
-		DPRINTK("EXIT, returning -EINVAL\n");
+		NVTRACE("EXIT, returning -EINVAL\n");
 		return -EINVAL;
 	}
 
@@ -1191,6 +1271,7 @@
 	    var->green.msb_right =
 	    var->blue.msb_right =
 	    var->transp.offset = var->transp.length = var->transp.msb_right = 0;
+	NVTRACE_LEAVE();
 	return 0;
 }
 
@@ -1198,6 +1279,7 @@
 {
 	struct riva_par *par = (struct riva_par *) info->par;
 
+	NVTRACE_ENTER();
 	riva_common_setup(par);
 	RivaGetConfig(&par->riva, par->Chipset);
 	/* vgaHWunlock() + riva unlock (0x7F) */
@@ -1211,6 +1293,7 @@
 	info->fix.line_length = (info->var.xres_virtual * (info->var.bits_per_pixel >> 3));
 	info->fix.visual = (info->var.bits_per_pixel == 8) ?
 				FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_DIRECTCOLOR;
+	NVTRACE_LEAVE();
 	return 0;
 }
 
@@ -1233,6 +1316,7 @@
 	struct riva_par *par = (struct riva_par *)info->par;
 	unsigned int base;
 
+	NVTRACE_ENTER();
 	if (var->xoffset > (var->xres_virtual - var->xres))
 		return -EINVAL;
 	if (var->yoffset > (var->yres_virtual - var->yres))
@@ -1259,6 +1343,7 @@
 		info->var.vmode |= FB_VMODE_YWRAP;
 	else
 		info->var.vmode &= ~FB_VMODE_YWRAP;
+	NVTRACE_LEAVE();
 	return 0;
 }
 
@@ -1270,6 +1355,7 @@
 	tmp = SEQin(par, 0x01) & ~0x20;	/* screen on/off */
 	vesa = CRTCin(par, 0x1a) & ~0xc0;	/* sync on/off */
 
+	NVTRACE_ENTER();
 	if (blank) {
 		tmp |= 0x20;
 		switch (blank - 1) {
@@ -1288,6 +1374,14 @@
 	}
 	SEQout(par, 0x01, tmp);
 	CRTCout(par, 0x1a, vesa);
+
+#ifdef CONFIG_PMAC_BACKLIGHT
+	if ( par->FlatPanel && _machine == _MACH_Pmac) {
+		set_backlight_enable(!blank);
+	}
+#endif
+
+	NVTRACE_LEAVE();
 	return 0;
 }
 
@@ -1676,6 +1770,7 @@
 {
 	unsigned int cmap_len;
 
+	NVTRACE_ENTER();
 	info->flags = FBINFO_DEFAULT
 		    | FBINFO_HWACCEL_XPAN
 		    | FBINFO_HWACCEL_YPAN
@@ -1696,6 +1791,7 @@
 	info->pixmap.scan_align = 4;
 	info->pixmap.flags = FB_PIXMAP_SYSTEM;
 	info->var.yres_virtual = -1;
+	NVTRACE_LEAVE();
 	return (rivafb_check_var(&info->var, info));
 }
 
@@ -1710,6 +1806,7 @@
 		"DFP,EDID", "LCD,EDID", "EDID", "EDID1", "EDID,B", "EDID,A", NULL };
 	int i;
 
+	NVTRACE_ENTER();
 	dp = pci_device_to_OF_node(pd);
 	for (; dp != NULL; dp = dp->child) {
 		disptype = (unsigned char *)get_property(dp, "display-type", NULL);
@@ -1726,6 +1823,7 @@
 			}
 		}
 	}
+	NVTRACE_LEAVE();
 		return 0;
 }
 #endif /* CONFIG_PPC_OF */
@@ -1735,6 +1833,7 @@
 	struct fb_monspecs *specs = &info->monspecs;
 	struct fb_videomode modedb;
 
+	NVTRACE_ENTER();
 	/* respect mode options */
 	if (mode_option) {
 		fb_find_mode(var, info, mode_option,
@@ -1759,11 +1858,13 @@
 		riva_update_var(var, &modedb);
 	}
 	var->accel_flags |= FB_ACCELF_TEXT;
+	NVTRACE_LEAVE();
 }
 
 
 static void riva_get_EDID(struct fb_info *info, struct pci_dev *pdev)
 {
+	NVTRACE_ENTER();
 #ifdef CONFIG_PPC_OF
 	if (!riva_get_EDID_OF(info, pdev))
 		printk("rivafb: could not retrieve EDID from OF\n");
@@ -1784,6 +1885,7 @@
 	riva_delete_i2c_busses(par);
 #endif
 #endif
+	NVTRACE_LEAVE();
 }
 
 
@@ -1813,6 +1915,7 @@
 	struct riva_par *default_par;
 	struct fb_info *info;
 
+	NVTRACE_ENTER();
 	assert(pd != NULL);
 	assert(rci != NULL);
 
@@ -1958,6 +2061,12 @@
 		info->fix.id,
 		info->fix.smem_len / (1024 * 1024),
 		info->fix.smem_start);
+#ifdef CONFIG_PMAC_BACKLIGHT
+	if (default_par->FlatPanel && _machine == _MACH_Pmac)
+	register_backlight_controller(&riva_backlight_controller,
+						default_par, "mnca");
+#endif
+	NVTRACE_LEAVE();
 	return 0;
 
 err_out_iounmap_fb:
@@ -1986,6 +2095,7 @@
 	struct fb_info *info = pci_get_drvdata(pd);
 	struct riva_par *par = (struct riva_par *) info->par;
 	
+	NVTRACE_ENTER();
 	if (!info)
 		return;
 
@@ -2007,6 +2117,7 @@
 	kfree(par);
 	kfree(info);
 	pci_set_drvdata(pd, NULL);
+	NVTRACE_LEAVE();
 }
 
 /* ------------------------------------------------------------------------- *
@@ -2020,6 +2131,7 @@
 {
 	char *this_opt;
 
+	NVTRACE_ENTER();
 	if (!options || !*options)
 		return 0;
 
@@ -2043,6 +2155,7 @@
 		} else
 			mode_option = this_opt;
 	}
+	NVTRACE_LEAVE();
 	return 0;
 }
 #endif /* !MODULE */
--- ../linux-2.6.7-bk20.orig/drivers/video/Kconfig	2004-07-09 10:26:29.000000000 +0200
+++ drivers/video/Kconfig	2004-07-09 10:33:11.000000000 +0200
@@ -446,6 +446,15 @@
 	  independently validate video mode parameters, you should say Y
 	  here.
 
+config FB_RIVA_DEBUG
+	bool "Lots of debug output from Riva(nVidia) driver"
+	depends on FB_RIVA
+	default n
+	help
+	  Say Y here if you want the Riva driver to output all sorts
+	  of debugging informations to provide to the maintainer when
+	  something goes wrong.
+
 config FB_I810
 	tristate "Intel 810/815 support (EXPERIMENTAL)"
 	depends on FB && AGP && AGP_INTEL && EXPERIMENTAL && PCI	
