Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265038AbUGVNNQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265038AbUGVNNQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 09:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265317AbUGVNNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 09:13:15 -0400
Received: from havoc.gtf.org ([216.162.42.101]:36572 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S265038AbUGVNMM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 09:12:12 -0400
Date: Thu, 22 Jul 2004 09:09:12 -0400
From: David Eger <eger@havoc.gtf.org>
To: linux-kernel@vger.kernel.org
Cc: Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>,
       Linux/PPC on APUS development 
	<linux-apus-devel@lists.sourceforge.net>,
       lhecking@nmrc.ie, Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] cirrusfb: update for amiga (zorro)
Message-ID: <20040722130912.GA17834@havoc.gtf.org>
References: <200406261905.22710.blaisorblade_spam@yahoo.it> <20040626130945.190fb199.akpm@osdl.org> <20040627035923.GB8842@ccure.user-mode-linux.org> <20040626233253.06ed314e.pj@sgi.com> <Pine.GSO.4.58.0406271050570.25680@waterleaf.sonytel.be> <20040628181134.GA21360@havoc.gtf.org> <Pine.GSO.4.58.0407201754460.23496@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0407201754460.23496@waterleaf.sonytel.be>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Geert, 

Thanks for bringing the ZORRO paths up to date for the cirrusfb driver.
The code looks good, and I trust your knowledge of Amiga much more than
my own. It would be nice if someone actually has this hardware and can
test the patch... Anyone? Anyone? Lars? Beuler?

There was a trivial problem applying the patch - one of the whitespace
fixes choked, so I took it out of the patch (below).

-dte

---

Cirrusfb updates:
  - Cirrusfb depends on Zorro or PCI
  - Revive Zorro support, using new Zorro driver framework
  - Merge PCI and Zorro code where possible
  - Use C99 initializers
  - Kill superfluous whitespace
  - #undef I/O ops before redefining them on Amiga

From: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: David Eger <eger@havoc.gtf.org>

--- linux-2.6.8-rc2/drivers/video/Kconfig	2004-07-15 23:14:59.000000000 +0200
+++ linux-m68k-2.6.8-rc2/drivers/video/Kconfig	2004-07-19 21:06:17.000000000 +0200
@@ -40,7 +40,7 @@

 config FB_CIRRUS
 	tristate "Cirrus Logic support"
-	depends on FB && (AMIGA || PCI)
+	depends on FB && (ZORRO || PCI)
 	---help---
 	  This enables support for Cirrus Logic GD542x/543x based boards on
 	  Amiga: SD64, Piccolo, Picasso II/II+, Picasso IV, or EGS Spectrum.
--- linux-2.6.8-rc2/drivers/video/cirrusfb.c	2004-07-18 15:55:33.000000000 +0200
+++ linux-m68k-2.6.8-rc2/drivers/video/cirrusfb.c	2004-07-19 21:14:50.000000000 +0200
@@ -5,8 +5,8 @@
  *
  * Contributors (thanks, all!)
  *
- * 	David Eger:
- * 	Overhaul for Linux 2.6
+ *	David Eger:
+ *	Overhaul for Linux 2.6
  *
  *      Jeff Rugen:
  *      Major contributions;  Motorola PowerStack (PPC and PCI) support,
@@ -145,9 +145,6 @@
  * a run-time table?
  */
 static const struct cirrusfb_board_info_rec {
-	cirrusfb_board_t btype;	/* chipset enum, not strictly necessary, as
-				 * cirrusfb_board_info[] is directly indexed
-				 * by this value */
 	char *name;		/* ASCII name of chipset */
 	long maxclock[5];		/* maximum video clock */
 	/* for  1/4bpp, 8bpp 15/16bpp, 24bpp, 32bpp - numbers from xorg code */
@@ -164,104 +161,115 @@

 	unsigned char sr1f;	/* SR1F VGA initial register value */
 } cirrusfb_board_info[] = {
-	{ BT_NONE, }, /* dummy record */
-	{ BT_SD64,
-		"CL SD64",
-		{ 140000, 140000, 140000, 140000, 140000, },	/* guess */
-		/* the SD64/P4 have a higher max. videoclock */
-		TRUE,
-		TRUE,
-		TRUE,
-		0xF0,
-		0xF0,
-		0,		/* unused, does not multiplex */
-		0xF1,
-		0,		/* unused, does not multiplex */
-		0x20 },
-	{ BT_PICCOLO,
-		"CL Piccolo",
-		{ 90000, 90000, 90000, 90000, 90000 },	/* guess */
-		TRUE,
-		TRUE,
-		FALSE,
-		0x80,
-		0x80,
-		0,		/* unused, does not multiplex */
-		0x81,
-		0,		/* unused, does not multiplex */
-		0x22 },
-	{ BT_PICASSO,
-		"CL Picasso",
-		{ 90000, 90000, 90000, 90000, 90000, },	/* guess */
-		TRUE,
-		TRUE,
-		FALSE,
-		0x20,
-		0x20,
-		0,		/* unused, does not multiplex */
-		0x21,
-		0,		/* unused, does not multiplex */
-		0x22 },
-	{ BT_SPECTRUM,
-		"CL Spectrum",
-		{ 90000, 90000, 90000, 90000, 90000, },	/* guess */
-		TRUE,
-		TRUE,
-		FALSE,
-		0x80,
-		0x80,
-		0,		/* unused, does not multiplex */
-		0x81,
-		0,		/* unused, does not multiplex */
-		0x22 },
-	{ BT_PICASSO4,
-		"CL Picasso4",
-		{ 135100, 135100, 85500, 85500, 0 },
-		TRUE,
-		FALSE,
-		TRUE,
-		0x20,
-		0x20,
-		0,		/* unused, does not multiplex */
-		0x21,
-		0,		/* unused, does not multiplex */
-		0 },
-	{ BT_ALPINE,
-		"CL Alpine",
-		{ 85500, 85500, 50000, 28500, 0}, /* for the GD5430.  GD5446 can do more... */
-		TRUE,
-		TRUE,
-		TRUE,
-		0xA0,
-		0xA1,
-		0xA7,
-		0xA1,
-		0xA7,
-		0x1C },
-	{ BT_GD5480,
-		"CL GD5480",
-		{ 135100, 200000, 200000, 135100, 135100 },
-		TRUE,
-		TRUE,
-		TRUE,
-		0x10,
-		0x11,
-		0,		/* unused, does not multiplex */
-		0x11,
-		0,		/* unused, does not multiplex */
-		0x1C },
-	{ BT_LAGUNA,
-		"CL Laguna",
-		{ 135100, 135100, 135100, 135100, 135100, }, /* guess */
-		FALSE,
-		FALSE,
-		TRUE,
-		0,		/* unused */
-		0,		/* unused */
-		0,		/* unused */
-		0,		/* unused */
-		0,		/* unused */
-		0 },		/* unused */
+	[BT_SD64] = {
+		.name			= "CL SD64",
+		.maxclock		= {
+			/* guess */
+			/* the SD64/P4 have a higher max. videoclock */
+			140000, 140000, 140000, 140000, 140000,
+		},
+		.init_sr07		= TRUE,
+		.init_sr1f		= TRUE,
+		.scrn_start_bit19	= TRUE,
+		.sr07			= 0xF0,
+		.sr07_1bpp		= 0xF0,
+		.sr07_8bpp		= 0xF1,
+		.sr1f			= 0x20
+	},
+	[BT_PICCOLO] = {
+		.name			= "CL Piccolo",
+		.maxclock		= {
+			/* guess */
+			90000, 90000, 90000, 90000, 90000
+		},
+		.init_sr07		= TRUE,
+		.init_sr1f		= TRUE,
+		.scrn_start_bit19	= FALSE,
+		.sr07			= 0x80,
+		.sr07_1bpp		= 0x80,
+		.sr07_8bpp		= 0x81,
+		.sr1f			= 0x22
+	},
+	[BT_PICASSO] = {
+		.name			= "CL Picasso",
+		.maxclock		= {
+			/* guess */
+			90000, 90000, 90000, 90000, 90000
+		},
+		.init_sr07		= TRUE,
+		.init_sr1f		= TRUE,
+		.scrn_start_bit19	= FALSE,
+		.sr07			= 0x20,
+		.sr07_1bpp		= 0x20,
+		.sr07_8bpp		= 0x21,
+		.sr1f			= 0x22
+	},
+	[BT_SPECTRUM] = {
+		.name			= "CL Spectrum",
+		.maxclock		= {
+			/* guess */
+			90000, 90000, 90000, 90000, 90000
+		},
+		.init_sr07		= TRUE,
+		.init_sr1f		= TRUE,
+		.scrn_start_bit19	= FALSE,
+		.sr07			= 0x80,
+		.sr07_1bpp		= 0x80,
+		.sr07_8bpp		= 0x81,
+		.sr1f			= 0x22
+	},
+	[BT_PICASSO4] = {
+		.name			= "CL Picasso4",
+		.maxclock		= {
+			135100, 135100, 85500, 85500, 0
+		},
+		.init_sr07		= TRUE,
+		.init_sr1f		= FALSE,
+		.scrn_start_bit19	= TRUE,
+		.sr07			= 0x20,
+		.sr07_1bpp		= 0x20,
+		.sr07_8bpp		= 0x21,
+		.sr1f			= 0
+	},
+	[BT_ALPINE] = {
+		.name			= "CL Alpine",
+		.maxclock		= {
+			/* for the GD5430.  GD5446 can do more... */
+			85500, 85500, 50000, 28500, 0
+		},
+		.init_sr07		= TRUE,
+		.init_sr1f		= TRUE,
+		.scrn_start_bit19	= TRUE,
+		.sr07			= 0xA0,
+		.sr07_1bpp		= 0xA1,
+		.sr07_1bpp_mux		= 0xA7,
+		.sr07_8bpp		= 0xA1,
+		.sr07_8bpp_mux		= 0xA7,
+		.sr1f			= 0x1C
+	},
+	[BT_GD5480] = {
+		.name			= "CL GD5480",
+		.maxclock		= {
+			135100, 200000, 200000, 135100, 135100
+		},
+		.init_sr07		= TRUE,
+		.init_sr1f		= TRUE,
+		.scrn_start_bit19	= TRUE,
+		.sr07			= 0x10,
+		.sr07_1bpp		= 0x11,
+		.sr07_8bpp		= 0x11,
+		.sr1f			= 0x1C
+	},
+	[BT_LAGUNA] = {
+		.name			= "CL Laguna",
+		.maxclock		= {
+			/* guess */
+			135100, 135100, 135100, 135100, 135100,
+		},
+		.init_sr07		= FALSE,
+		.init_sr1f		= FALSE,
+		.scrn_start_bit19	= TRUE,
+	}
 };


@@ -270,12 +278,12 @@
 	{ PCI_VENDOR_ID_CIRRUS, PCI_DEVICE_ID_##id, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (btype) }

 static struct pci_device_id cirrusfb_pci_table[] = {
-	CHIP( CIRRUS_5436, 	BT_ALPINE ),
-	CHIP( CIRRUS_5434_8, 	BT_ALPINE ),
-	CHIP( CIRRUS_5434_4, 	BT_ALPINE ),
-	CHIP( CIRRUS_5430, 	BT_ALPINE ), /* GD-5440 has identical id */
-	CHIP( CIRRUS_7543, 	BT_ALPINE ),
-	CHIP( CIRRUS_7548, 	BT_ALPINE ),
+	CHIP( CIRRUS_5436,	BT_ALPINE ),
+	CHIP( CIRRUS_5434_8,	BT_ALPINE ),
+	CHIP( CIRRUS_5434_4,	BT_ALPINE ),
+	CHIP( CIRRUS_5430,	BT_ALPINE ), /* GD-5440 has identical id */
+	CHIP( CIRRUS_7543,	BT_ALPINE ),
+	CHIP( CIRRUS_7548,	BT_ALPINE ),
 	CHIP( CIRRUS_5480,	BT_GD5480 ), /* MacPicasso probably */
 	CHIP( CIRRUS_5446,	BT_PICASSO4 ), /* Picasso 4 is a GD5446 */
 	CHIP( CIRRUS_5462,	BT_LAGUNA ), /* CL Laguna */
@@ -289,31 +297,50 @@


 #ifdef CONFIG_ZORRO
+static const struct zorro_device_id cirrusfb_zorro_table[] = {
+	{
+		.id		= ZORRO_PROD_HELFRICH_SD64_RAM,
+		.driver_data	= BT_SD64,
+	}, {
+		.id		= ZORRO_PROD_HELFRICH_PICCOLO_RAM,
+		.driver_data	= BT_PICCOLO,
+	}, {
+		.id		= ZORRO_PROD_VILLAGE_TRONIC_PICASSO_II_II_PLUS_RAM,
+		.driver_data	= BT_PICASSO,
+	}, {
+		.id		= ZORRO_PROD_GVP_EGS_28_24_SPECTRUM_RAM,
+		.driver_data	= BT_SPECTRUM,
+	}, {
+		.id		= ZORRO_PROD_VILLAGE_TRONIC_PICASSO_IV_Z3,
+		.driver_data	= BT_PICASSO4,
+	},
+	{ 0 }
+};
+
 static const struct {
-	cirrusfb_board_t btype;
-	zorro_id id, id2;
+	zorro_id id2;
 	unsigned long size;
-} cirrusfb_zorro_probe_list[] __initdata = {
-	{ BT_SD64,
-		ZORRO_PROD_HELFRICH_SD64_RAM,
-		ZORRO_PROD_HELFRICH_SD64_REG,
-		0x400000 },
-	{ BT_PICCOLO,
-		ZORRO_PROD_HELFRICH_PICCOLO_RAM,
-		ZORRO_PROD_HELFRICH_PICCOLO_REG,
-		0x200000 },
-	{ BT_PICASSO,
-		ZORRO_PROD_VILLAGE_TRONIC_PICASSO_II_II_PLUS_RAM,
-		ZORRO_PROD_VILLAGE_TRONIC_PICASSO_II_II_PLUS_REG,
-		0x200000 },
-	{ BT_SPECTRUM,
-		ZORRO_PROD_GVP_EGS_28_24_SPECTRUM_RAM,
-		ZORRO_PROD_GVP_EGS_28_24_SPECTRUM_REG,
-		0x200000 },
-	{ BT_PICASSO4,
-		ZORRO_PROD_VILLAGE_TRONIC_PICASSO_IV_Z3,
-		0,
-		0x400000 },
+} cirrusfb_zorro_table2[] = {
+	[BT_SD64] = {
+		.id2	= ZORRO_PROD_HELFRICH_SD64_REG,
+		.size	= 0x400000
+	},
+	[BT_PICCOLO] = {
+		.id2	= ZORRO_PROD_HELFRICH_PICCOLO_REG,
+		.size	= 0x200000
+	},
+	[BT_PICASSO] = {
+		.id2	= ZORRO_PROD_VILLAGE_TRONIC_PICASSO_II_II_PLUS_REG,
+		.size	= 0x200000
+	},
+	[BT_SPECTRUM] = {
+		.id2	= ZORRO_PROD_GVP_EGS_28_24_SPECTRUM_REG,
+		.size	= 0x200000
+	},
+	[BT_PICASSO4] = {
+		.id2	= 0,
+		.size	= 0x400000
+	}
 };
 #endif /* CONFIG_ZORRO */

@@ -381,13 +408,12 @@
 	struct { u8 red, green, blue, pad; } palette[256];

 #ifdef CONFIG_ZORRO
-	unsigned long board_addr,
-		      board_size;
+	struct zorro_dev *zdev;
 #endif
-
 #ifdef CONFIG_PCI
 	struct pci_dev *pdev;
 #endif
+	void (*unmap)(struct cirrusfb_info *cinfo);
 };


@@ -401,50 +427,83 @@
 static const struct {
 	const char *name;
 	struct fb_var_screeninfo var;
-} cirrusfb_predefined[] =
-
-{
-	{"Autodetect",		/* autodetect mode */
-	 {0}
-	},
-
-	{"640x480",		/* 640x480, 31.25 kHz, 60 Hz, 25 MHz PixClock */
-	 {
-		 640, 480, 640, 480, 0, 0, 8, 0,
-		 {0, 8, 0},
-		 {0, 8, 0},
-		 {0, 8, 0},
-		 {0, 0, 0},
-	       0, 0, -1, -1, FB_ACCEL_NONE, 40000, 48, 16, 32, 8, 96, 4,
-     FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
-	 }
-	},
-
-	{"800x600",		/* 800x600, 48 kHz, 76 Hz, 50 MHz PixClock */
-	 {
-		 800, 600, 800, 600, 0, 0, 8, 0,
-		 {0, 8, 0},
-		 {0, 8, 0},
-		 {0, 8, 0},
-		 {0, 0, 0},
-	       0, 0, -1, -1, FB_ACCEL_NONE, 20000, 128, 16, 24, 2, 96, 6,
-     0, FB_VMODE_NONINTERLACED
-	 }
-	},
-
-	/*
-	   Modeline from XF86Config:
-	   Mode "1024x768" 80  1024 1136 1340 1432  768 770 774 805
-	 */
-	{"1024x768",		/* 1024x768, 55.8 kHz, 70 Hz, 80 MHz PixClock */
-		{
-			1024, 768, 1024, 768, 0, 0, 8, 0,
-			{0, 8, 0},
-			{0, 8, 0},
-			{0, 8, 0},
-			{0, 0, 0},
-	      0, 0, -1, -1, FB_ACCEL_NONE, 12500, 144, 32, 30, 2, 192, 6,
-     0, FB_VMODE_NONINTERLACED
+} cirrusfb_predefined[] = {
+	{
+		/* autodetect mode */
+		.name	= "Autodetect",
+	}, {
+		/* 640x480, 31.25 kHz, 60 Hz, 25 MHz PixClock */
+		.name	= "640x480",
+		.var	= {
+			.xres		= 640,
+			.yres		= 480,
+			.xres_virtual	= 640,
+			.yres_virtual	= 480,
+			.bits_per_pixel	= 8,
+			.red		= { .length = 8 },
+			.green		= { .length = 8 },
+			.blue		= { .length = 8 },
+			.width		= -1,
+			.height		= -1,
+			.pixclock	= 40000,
+			.left_margin	= 48,
+			.right_margin	= 16,
+			.upper_margin	= 32,
+			.lower_margin	= 8,
+			.hsync_len	= 96,
+			.vsync_len	= 4,
+			.sync		= FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+			.vmode		= FB_VMODE_NONINTERLACED
+		 }
+	}, {
+		/* 800x600, 48 kHz, 76 Hz, 50 MHz PixClock */
+		.name	= "800x600",
+		.var	= {
+			.xres		= 800,
+			.yres		= 600,
+			.xres_virtual	= 800,
+			.yres_virtual	= 600,
+			.bits_per_pixel	= 8,
+			.red		= { .length = 8 },
+			.green		= { .length = 8 },
+			.blue		= { .length = 8 },
+			.width		= -1,
+			.height		= -1,
+			.pixclock	= 20000,
+			.left_margin	= 128,
+			.right_margin	= 16,
+			.upper_margin	= 24,
+			.lower_margin	= 2,
+			.hsync_len	= 96,
+			.vsync_len	= 6,
+			.vmode		= FB_VMODE_NONINTERLACED
+		 }
+	}, {
+		/*
+		 * Modeline from XF86Config:
+		 * Mode "1024x768" 80  1024 1136 1340 1432  768 770 774 805
+		 */
+		/* 1024x768, 55.8 kHz, 70 Hz, 80 MHz PixClock */
+		.name	= "1024x768",
+		.var	= {
+			.xres		= 1024,
+			.yres		= 768,
+			.xres_virtual	= 1024,
+			.yres_virtual	= 768,
+			.bits_per_pixel	= 8,
+			.red		= { .length = 8 },
+			.green		= { .length = 8 },
+			.blue		= { .length = 8 },
+			.width		= -1,
+			.height		= -1,
+			.pixclock	= 12500,
+			.left_margin	= 144,
+			.right_margin	= 32,
+			.upper_margin	= 30,
+			.lower_margin	= 2,
+			.hsync_len	= 192,
+			.vsync_len	= 6,
+			.vmode		= FB_VMODE_NONINTERLACED
 		}
 	}
 };
@@ -478,7 +537,7 @@
 static struct fb_ops cirrusfb_ops = {
 	.owner		= THIS_MODULE,
 	.fb_open	= cirrusfb_open,
-	.fb_release 	= cirrusfb_release,
+	.fb_release	= cirrusfb_release,
 	.fb_setcolreg	= cirrusfb_setcolreg,
 	.fb_check_var	= cirrusfb_check_var,
 	.fb_set_par	= cirrusfb_set_par,
@@ -1132,7 +1191,7 @@
 			DPRINTK (" (for GD54xx)\n");
 			vga_wseq (regbase, CL_SEQR7,
 				  regs.multiplexing ?
-				  	bi->sr07_1bpp_mux : bi->sr07_1bpp);
+					bi->sr07_1bpp_mux : bi->sr07_1bpp);
 			break;

 		case BT_LAGUNA:
@@ -1216,7 +1275,7 @@
 			DPRINTK (" (for GD54xx)\n");
 			vga_wseq (regbase, CL_SEQR7,
 				  regs.multiplexing ?
-				  	bi->sr07_8bpp_mux : bi->sr07_8bpp);
+					bi->sr07_8bpp_mux : bi->sr07_8bpp);
 			break;

 		case BT_LAGUNA:
@@ -2156,10 +2215,144 @@
 	framebuffer_release(cinfo->info);
 	pci_disable_device(pdev);
 }
+#endif /* CONFIG_PCI */
+
+
+#ifdef CONFIG_ZORRO
+static void __devexit cirrusfb_zorro_unmap (struct cirrusfb_info *cinfo)
+{
+	zorro_release_device(cinfo->zdev);
+
+	if (cinfo->btype == BT_PICASSO4) {
+		cinfo->regbase -= 0x600000;
+		iounmap ((void *)cinfo->regbase);
+		iounmap ((void *)cinfo->fbmem);
+	} else {
+		if (zorro_resource_start(cinfo->zdev) > 0x01000000)
+			iounmap ((void *)cinfo->fbmem);
+	}
+	framebuffer_release(cinfo->info);
+}
+#endif /* CONFIG_ZORRO */
+
+static int cirrusfb_set_fbinfo(struct cirrusfb_info *cinfo)
+{
+	struct fb_info *info = cinfo->info;
+	struct fb_var_screeninfo *var = &info->var;
+
+	info->currcon = -1;
+	info->par = cinfo;
+	info->pseudo_palette = cinfo->pseudo_palette;
+	info->flags = FBINFO_DEFAULT
+		    | FBINFO_HWACCEL_XPAN
+		    | FBINFO_HWACCEL_YPAN
+		    | FBINFO_HWACCEL_FILLRECT
+		    | FBINFO_HWACCEL_COPYAREA;
+	if (noaccel)
+		info->flags |= FBINFO_HWACCEL_DISABLED;
+	info->fbops = &cirrusfb_ops;
+	info->screen_base = cinfo->fbmem;
+	if (cinfo->btype == BT_GD5480) {
+		if (var->bits_per_pixel == 16)
+			info->screen_base += 1 * MB_;
+		if (var->bits_per_pixel == 24 || var->bits_per_pixel == 32)
+			info->screen_base += 2 * MB_;
+	}
+
+	/* Fill fix common fields */
+	strlcpy(info->fix.id, cirrusfb_board_info[cinfo->btype].name,
+		sizeof(info->fix.id));
+
+	/* monochrome: only 1 memory plane */
+	/* 8 bit and above: Use whole memory area */
+	info->fix.smem_start = cinfo->fbmem_phys;
+	info->fix.smem_len   = (var->bits_per_pixel == 1) ? cinfo->size / 4 : cinfo->size;
+	info->fix.type       = cinfo->currentmode.type;
+	info->fix.type_aux   = 0;
+	info->fix.visual     = cinfo->currentmode.visual;
+	info->fix.xpanstep   = 1;
+	info->fix.ypanstep   = 1;
+	info->fix.ywrapstep  = 0;
+	info->fix.line_length = cinfo->currentmode.line_length;
+
+	/* FIXME: map region at 0xB8000 if available, fill in here */
+	info->fix.mmio_start = cinfo->fbregs_phys;
+	info->fix.mmio_len   = 0;
+	info->fix.accel = FB_ACCEL_NONE;
+
+	fb_alloc_cmap(&info->cmap, 256, 0);
+
+	return 0;
+}

+static int cirrusfb_register(struct cirrusfb_info *cinfo)
+{
+	struct fb_info *info;
+	int err;
+	cirrusfb_board_t btype;
+
+	DPRINTK ("ENTER\n");

-static struct cirrusfb_info *cirrusfb_pci_setup (struct pci_dev *pdev,
-				   		 const struct pci_device_id *ent)
+	printk (KERN_INFO "cirrusfb: Driver for Cirrus Logic based graphic boards, v" CIRRUSFB_VERSION "\n");
+
+	info = cinfo->info;
+	btype = cinfo->btype;
+
+	/* sanity checks */
+	assert (btype != BT_NONE);
+
+	DPRINTK ("cirrusfb: (RAM start set to: 0x%p)\n", cinfo->fbmem);
+
+	/* Make pretend we've set the var so our structures are in a "good" */
+	/* state, even though we haven't written the mode to the hw yet...  */
+	info->var = cirrusfb_predefined[cirrusfb_def_mode].var;
+	info->var.activate = FB_ACTIVATE_NOW;
+
+	err = cirrusfb_decode_var(&info->var, &cinfo->currentmode, info);
+	if (err < 0) {
+		/* should never happen */
+		DPRINTK("choking on default var... umm, no good.\n");
+		goto err_unmap_cirrusfb;
+	}
+
+	/* set all the vital stuff */
+	cirrusfb_set_fbinfo(cinfo);
+
+	err = register_framebuffer(info);
+	if (err < 0) {
+		printk (KERN_ERR "cirrusfb: could not register fb device; err = %d!\n", err);
+		goto err_dealloc_cmap;
+	}
+
+	DPRINTK ("EXIT, returning 0\n");
+	return 0;
+
+err_dealloc_cmap:
+	fb_dealloc_cmap(&info->cmap);
+err_unmap_cirrusfb:
+	cinfo->unmap(cinfo);
+	return err;
+}
+
+static void __devexit cirrusfb_cleanup (struct fb_info *info)
+{
+	struct cirrusfb_info *cinfo = info->par;
+	DPRINTK ("ENTER\n");
+
+	switch_monitor (cinfo, 0);
+
+	unregister_framebuffer (info);
+	fb_dealloc_cmap (&info->cmap);
+	printk ("Framebuffer unregistered\n");
+	cinfo->unmap(cinfo);
+
+	DPRINTK ("EXIT\n");
+}
+
+
+#ifdef CONFIG_PCI
+static int cirrusfb_pci_register (struct pci_dev *pdev,
+				  const struct pci_device_id *ent)
 {
 	struct cirrusfb_info *cinfo;
 	struct fb_info *info;
@@ -2233,11 +2426,13 @@

 	cinfo->fbmem_phys = board_addr;
 	cinfo->size = board_size;
+	cinfo->unmap = cirrusfb_pci_unmap;

 	printk (" RAM (%lu kB) at 0xx%lx, ", cinfo->size / KB_, board_addr);
 	printk ("Cirrus Logic chipset on PCI bus\n");
+	pci_set_drvdata(pdev, info);

-	return cinfo;
+	return cirrusfb_register(cinfo);

 err_release_legacy:
 	if (release_io_ports)
@@ -2252,77 +2447,51 @@
 err_disable:
 	pci_disable_device(pdev);
 err_out:
-	return ERR_PTR(ret);
+	return ret;
 }
-#endif				/* CONFIG_PCI */
-
-

-
-#ifdef CONFIG_ZORRO
-static int cirrusfb_zorro_find (struct zorro_dev **z_o,
-				    struct zorro_dev **z2_o,
-				    cirrusfb_board_t *btype, unsigned long *size)
+void __devexit cirrusfb_pci_unregister (struct pci_dev *pdev)
 {
-	struct zorro_dev *z = NULL;
-	int i;
-
-	assert (z_o != NULL);
-	assert (btype != NULL);
-
-	for (i = 0; i < ARRAY_SIZE(cirrusfb_zorro_probe_list); i++)
-		if ((z = zorro_find_device(cirrusfb_zorro_probe_list[i].id, NULL)))
-			break;
-
-	if (z) {
-		*z_o = z;
-		if (cirrusfb_zorro_probe_list[i].id2)
-			*z2_o = zorro_find_device(cirrusfb_zorro_probe_list[i].id2, NULL);
-		else
-			*z2_o = NULL;
-
-		*btype = cirrusfb_zorro_probe_list[i].btype;
-		*size = cirrusfb_zorro_probe_list[i].size;
-
-		printk (KERN_INFO "cirrusfb: %s board detected; ",
-			cirrusfb_board_info[*btype].name);
+	struct fb_info *info = pci_get_drvdata(pdev);
+	DPRINTK ("ENTER\n");

-		return 0;
-	}
+	cirrusfb_cleanup (info);

-	printk (KERN_NOTICE "cirrusfb: no supported board found.\n");
-	return -ENODEV;
+	DPRINTK ("EXIT\n");
 }

-
-static void __devexit cirrusfb_zorro_unmap (struct cirrusfb_info *cinfo)
-{
-	release_mem_region(cinfo->board_addr, cinfo->board_size);
-
-	if (cinfo->btype == BT_PICASSO4) {
-		cinfo->regbase -= 0x600000;
-		iounmap ((void *)cinfo->regbase);
-		iounmap ((void *)cinfo->fbmem);
-	} else {
-		if (cinfo->board_addr > 0x01000000)
-			iounmap ((void *)cinfo->fbmem);
-	}
-	framebuffer_release(cinfo->info);
-}
+static struct pci_driver cirrusfb_pci_driver = {
+	.name		= "cirrusfb",
+	.id_table	= cirrusfb_pci_table,
+	.probe		= cirrusfb_pci_register,
+	.remove		= __devexit_p(cirrusfb_pci_unregister),
+#ifdef CONFIG_PM
+#if 0
+	.suspend	= cirrusfb_pci_suspend,
+	.resume		= cirrusfb_pci_resume,
+#endif
+#endif
+};
+#endif /* CONFIG_PCI */


-static struct cirrusfb_info *cirrusfb_zorro_setup(void)
+#ifdef CONFIG_ZORRO
+static int cirrusfb_zorro_register(struct zorro_dev *z,
+				   const struct zorro_device_id *ent)
 {
 	struct cirrusfb_info *cinfo;
 	struct fb_info *info;
 	cirrusfb_board_t btype;
-	struct zorro_dev *z = NULL, *z2 = NULL;
+	struct zorro_dev *z2 = NULL;
 	unsigned long board_addr, board_size, size;
 	int ret;

-	ret = cirrusfb_zorro_find (&z, &z2, &btype, &size);
-	if (ret < 0)
-		goto err_out;
+	btype = ent->driver_data;
+	if (cirrusfb_zorro_table2[btype].id2)
+		z2 = zorro_find_device(cirrusfb_zorro_table2[btype].id2, NULL);
+	size = cirrusfb_zorro_table2[btype].size;
+	printk(KERN_INFO "cirrusfb: %s board detected; ",
+	       cirrusfb_board_info[btype].name);

 	info = framebuffer_alloc(sizeof(struct cirrusfb_info), &z->dev);
 	if (!info) {
@@ -2339,11 +2508,12 @@
 	assert (z2 >= 0);
 	assert (btype != BT_NONE);

-	cinfo->board_addr = board_addr = z->resource.start;
-	cinfo->board_size = board_size = z->resource.end-z->resource.start+1;
+	cinfo->zdev = z;
+	board_addr = zorro_resource_start(z);
+	board_size = zorro_resource_len(z);
 	cinfo->size = size;

-	if (!request_mem_region(board_addr, board_size, "cirrusfb")) {
+	if (!zorro_request_device(z, "cirrusfb")) {
 		printk(KERN_ERR "cirrusfb: cannot reserve region 0x%lx, abort\n",
 		       board_addr);
 		ret = -EBUSY;
@@ -2370,7 +2540,7 @@
 		cinfo->fbregs_phys = board_addr + 0x600000;

 		cinfo->fbmem_phys = board_addr + 16777216;
-		cinfo->fbmem = ioremap (info->fbmem_phys, 16777216);
+		cinfo->fbmem = ioremap (cinfo->fbmem_phys, 16777216);
 		if (!cinfo->fbmem)
 			goto err_unmap_regbase;
 	} else {
@@ -2390,10 +2560,12 @@

 		DPRINTK ("cirrusfb: Virtual address for board set to: $%p\n", cinfo->regbase);
 	}
+	cinfo->unmap = cirrusfb_zorro_unmap;

 	printk (KERN_INFO "Cirrus Logic chipset on Zorro bus\n");
+	zorro_set_drvdata(z, info);

-	return 0;
+	return cirrusfb_register(cinfo);

 err_unmap_regbase:
 	/* Parental advisory: explicit hack */
@@ -2403,153 +2575,12 @@
 err_release_fb:
 	framebuffer_release(info);
 err_out:
-	return ERR_PTR(ret);
+	return ret;
 }
-#endif /* CONFIG_ZORRO */

-static int cirrusfb_set_fbinfo(struct cirrusfb_info *cinfo)
+void __devexit cirrusfb_zorro_unregister(struct zorro_dev *z)
 {
-	struct fb_info *info = cinfo->info;
-	struct fb_var_screeninfo *var = &info->var;
-
-	info->currcon = -1;
-	info->par = cinfo;
-	info->pseudo_palette = cinfo->pseudo_palette;
-	info->flags = FBINFO_DEFAULT
-		    | FBINFO_HWACCEL_XPAN
-		    | FBINFO_HWACCEL_YPAN
-		    | FBINFO_HWACCEL_FILLRECT
-		    | FBINFO_HWACCEL_COPYAREA;
-	if (noaccel)
-		info->flags |= FBINFO_HWACCEL_DISABLED;
-	info->fbops = &cirrusfb_ops;
-	info->screen_base = cinfo->fbmem;
-	if (cinfo->btype == BT_GD5480) {
-		if (var->bits_per_pixel == 16)
-			info->screen_base += 1 * MB_;
-		if (var->bits_per_pixel == 24 || var->bits_per_pixel == 32)
-			info->screen_base += 2 * MB_;
-	}
-
-	/* Fill fix common fields */
-	strlcpy(info->fix.id, cirrusfb_board_info[cinfo->btype].name,
-		sizeof(info->fix.id));
-
-	/* monochrome: only 1 memory plane */
-	/* 8 bit and above: Use whole memory area */
-	info->fix.smem_start = cinfo->fbmem_phys;
-	info->fix.smem_len   = (var->bits_per_pixel == 1) ? cinfo->size / 4 : cinfo->size;
-	info->fix.type       = cinfo->currentmode.type;
-	info->fix.type_aux   = 0;
-	info->fix.visual     = cinfo->currentmode.visual;
-	info->fix.xpanstep   = 1;
-	info->fix.ypanstep   = 1;
-	info->fix.ywrapstep  = 0;
-	info->fix.line_length = cinfo->currentmode.line_length;
-
-	/* FIXME: map region at 0xB8000 if available, fill in here */
-	info->fix.mmio_start = cinfo->fbregs_phys;
-	info->fix.mmio_len   = 0;
-	info->fix.accel = FB_ACCEL_NONE;
-
-	fb_alloc_cmap(&info->cmap, 256, 0);
-
-	return 0;
-}
-
-#if defined(CONFIG_PCI)
-#define cirrusfb_unmap cirrusfb_pci_unmap
-#define cirrusfb_bus_setup cirrusfb_pci_setup
-#elif defined(CONFIG_ZORRO)
-#define cirrusfb_unmap cirrusfb_zorro_unmap
-#define cirrusfb_bus_setup cirrusfb_zorro_setup
-#endif
-
-
-static int cirrusfb_pci_register (struct pci_dev *pdev,
-				  const struct pci_device_id *ent)
-{
-	struct fb_info *info;
-	struct cirrusfb_info *cinfo = NULL;
-	int err;
-	cirrusfb_board_t btype;
-
-	DPRINTK ("ENTER\n");
-
-	printk (KERN_INFO "cirrusfb: Driver for Cirrus Logic based graphic boards, v" CIRRUSFB_VERSION "\n");
-
-	cinfo = cirrusfb_bus_setup(pdev, ent);
-
-	if (IS_ERR(cinfo)) {
-		err = PTR_ERR(cinfo);
-		goto err_out;
-	}
-
-	info = cinfo->info;
-	btype = cinfo->btype;
-
-	/* sanity checks */
-	assert (btype != BT_NONE);
-	assert (btype == cirrusfb_board_info[btype].btype);
-
-	DPRINTK ("cirrusfb: (RAM start set to: 0x%p)\n", cinfo->fbmem);
-
-	/* Make pretend we've set the var so our structures are in a "good" */
-	/* state, even though we haven't written the mode to the hw yet...  */
-	info->var = cirrusfb_predefined[cirrusfb_def_mode].var;
-	info->var.activate = FB_ACTIVATE_NOW;
-
-	err = cirrusfb_decode_var(&info->var, &cinfo->currentmode, info);
-	if (err < 0) {
-		/* should never happen */
-		DPRINTK("choking on default var... umm, no good.\n");
-		goto err_unmap_cirrusfb;
-	}
-
-	/* set all the vital stuff */
-	cirrusfb_set_fbinfo(cinfo);
-
-	pci_set_drvdata(pdev, info);
-
-	err = register_framebuffer(info);
-	if (err < 0) {
-		printk (KERN_ERR "cirrusfb: could not register fb device; err = %d!\n", err);
-		goto err_dealloc_cmap;
-	}
-
-	DPRINTK ("EXIT, returning 0\n");
-	return 0;
-
-err_dealloc_cmap:
-	fb_dealloc_cmap(&info->cmap);
-err_unmap_cirrusfb:
-	cirrusfb_unmap(cinfo);
-err_out:
-	return err;
-}
-
-
-static void __devexit cirrusfb_cleanup (struct fb_info *info)
-{
-	struct cirrusfb_info *cinfo = info->par;
-	DPRINTK ("ENTER\n");
-
-#ifdef CONFIG_ZORRO
-	switch_monitor (cinfo, 0);
-#endif
-
-	unregister_framebuffer (info);
-	fb_dealloc_cmap (&info->cmap);
-	printk ("Framebuffer unregistered\n");
-	cirrusfb_unmap (cinfo);
-
-	DPRINTK ("EXIT\n");
-}
-
-
-void __devexit cirrusfb_pci_unregister (struct pci_dev *pdev)
-{
-	struct fb_info *info = pci_get_drvdata(pdev);
+	struct fb_info *info = zorro_get_drvdata(z);
 	DPRINTK ("ENTER\n");

 	cirrusfb_cleanup (info);
@@ -2557,26 +2588,25 @@
 	DPRINTK ("EXIT\n");
 }

-static struct pci_driver cirrusfb_driver = {
-	.name	= "cirrusfb",
-	.id_table	= cirrusfb_pci_table,
-	.probe		= cirrusfb_pci_register,
-	.remove		= __devexit_p(cirrusfb_pci_unregister),
-#ifdef CONFIG_PM
-#if 0
-	.suspend	= cirrusfb_pci_suspend,
-	.resume		= cirrusfb_pci_resume,
-#endif
-#endif
+static struct zorro_driver cirrusfb_zorro_driver = {
+	.name		= "cirrusfb",
+	.id_table	= cirrusfb_zorro_table,
+	.probe		= cirrusfb_zorro_register,
+	.remove		= __devexit_p(cirrusfb_zorro_unregister),
 };
+#endif /* CONFIG_ZORRO */

 int __init cirrusfb_init(void)
 {
+	int error = 0;
+
 #ifdef CONFIG_ZORRO
-	return cirrusfb_pci_register(NULL, NULL);
-#else
-	return pci_module_init(&cirrusfb_driver);
+	error |= zorro_module_init(&cirrusfb_zorro_driver);
 #endif
+#ifdef CONFIG_PCI
+	error |= pci_module_init(&cirrusfb_pci_driver);
+#endif
+	return error;
 }


@@ -2619,7 +2649,12 @@

 void __exit cirrusfb_exit (void)
 {
-	pci_unregister_driver (&cirrusfb_driver);
+#ifdef CONFIG_PCI
+	pci_unregister_driver(&cirrusfb_pci_driver);
+#endif
+#ifdef CONFIG_ZORRO
+	zorro_unregister_driver(&cirrusfb_zorro_driver);
+#endif
 }

 #ifdef MODULE
@@ -2830,7 +2865,7 @@

 static void cirrusfb_BitBLT (caddr_t regbase, int bits_per_pixel,
 			     u_short curx, u_short cury, u_short destx, u_short desty,
-		  	     u_short width, u_short height, u_short line_length)
+			     u_short width, u_short height, u_short line_length)
 {
 	u_short nwidth, nheight;
 	u_long nsrc, ndest;
--- linux-2.6.8-rc2/include/video/vga.h	2003-03-25 10:07:30.000000000 +0100
+++ linux-m68k-2.6.8-rc2/include/video/vga.h	2004-07-19 19:38:47.000000000 +0200
@@ -26,8 +26,15 @@
 /*
  * FIXME
  * Ugh, we don't have PCI space, so map readb() and friends to use Zorro space
- * for MMIO accesses. This should make clgenfb work again on Amiga
+ * for MMIO accesses. This should make cirrusfb work again on Amiga
  */
+#undef inb_p
+#undef inw_p
+#undef outb_p
+#undef outw
+#undef readb
+#undef writeb
+#undef writew
 #define inb_p(port)	0
 #define inw_p(port)	0
 #define outb_p(port, val)	do { } while (0)
