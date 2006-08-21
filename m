Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751235AbWHUWFj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235AbWHUWFj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 18:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbWHUWFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 18:05:39 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:459 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751235AbWHUWFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 18:05:37 -0400
Subject: [PATCH] sstfb : Clean ups
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, linux-kernel@vger.kernel.org, gtoumi@laposte.net
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 21 Aug 2006 23:26:41 +0100
Message-Id: <1156199201.18887.92.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- Remove 24/32bit unused support (the chips don't do 24/32bit anyway)
- Clean up printk obfuscation
- Clean up lispitus in the if(())()) stuff
- Minor tidying

No functionality changes, may have a crack at hardware scrolling based
on my X driver once the cleanups are in.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc4-mm2/drivers/video/sstfb.c linux-2.6.18-rc4-mm2/drivers/video/sstfb.c
--- linux.vanilla-2.6.18-rc4-mm2/drivers/video/sstfb.c	2006-08-21 14:17:44.000000000 +0100
+++ linux-2.6.18-rc4-mm2/drivers/video/sstfb.c	2006-08-21 22:08:01.000000000 +0100
@@ -17,7 +17,10 @@
  *	(port driver to new frambuffer infrastructure)
  * 01/2003 Helge Deller    <deller@gmx.de>
  *	(initial work on fb hardware acceleration for voodoo2)
- *
+ * 08/2006 Alan Cox 	   <alan@redhat.com>
+ *	Remove never finished and bogus 24/32bit support
+ *	Clean up macro abuse
+ *	Minor tidying for format.
  */
 
 /*
@@ -40,6 +43,7 @@
        through the fifo. warning: issuing a nop command seems to need pci_fifo
 -FIXME: in case of failure in the init sequence, be sure we return to a safe
         state.
+- FIXME: Use accelerator for 2D scroll
 -FIXME: 4MB boards have banked memory (FbiInit2 bits 1 & 20)
  */
 
@@ -67,9 +71,6 @@
 
 #undef SST_DEBUG
 
-/* enable 24/32 bpp functions ? (completely untested!) */
-#undef EN_24_32_BPP
-
 /*
   Default video mode .
   0 800x600@60  took from glide
@@ -377,7 +378,11 @@
  *      sstfb_check_var - Optional function.  Validates a var passed in.
  *      @var: frame buffer variable screen structure
  *      @info: frame buffer structure that represents a single frame buffer
+ *
+ *	Limit to the abilities of a single chip as SLI is not supported
+ *	by this driver.
  */
+
 static int sstfb_check_var(struct fb_var_screeninfo *var,
 		struct fb_info *info)
 {
@@ -390,7 +395,7 @@
 	unsigned int freq;
 
 	if (sst_calc_pll(PICOS2KHZ(var->pixclock), &freq, &par->pll)) {
-		eprintk("Pixclock at %ld KHZ out of range\n",
+		printk(KERN_ERR "sstfb: Pixclock at %ld KHZ out of range\n",
 				PICOS2KHZ(var->pixclock));
 		return -EINVAL;
 	}
@@ -409,27 +414,15 @@
 	case 0 ... 16 :
 		var->bits_per_pixel = 16;
 		break;
-#ifdef EN_24_32_BPP
-	case 17 ... 24 :
-		var->bits_per_pixel = 24;
-		break;
-	case 25 ... 32 :
-		var->bits_per_pixel = 32;
-		break;
-#endif
 	default :
-		eprintk("Unsupported bpp %d\n", var->bits_per_pixel);
+		printk(KERN_ERR "sstfb: Unsupported bpp %d\n", var->bits_per_pixel);
 		return -EINVAL;
 	}
 	
 	/* validity tests */
-	if ((var->xres <= 1) || (yDim <= 0 )
-	   || (var->hsync_len <= 1)
-	   || (hSyncOff <= 1)
-	   || (var->left_margin <= 2)
-	   || (vSyncOn <= 0)
-	   || (vSyncOff <= 0)
-	   || (vBackPorch <= 0)) {
+	if (var->xres <= 1 || yDim <= 0 || var->hsync_len <= 1  || 
+	    hSyncOff <= 1  || var->left_margin <= 2  || vSyncOn <= 0 || 
+	    vSyncOff <= 0 || vBackPorch <= 0) {
 		return -EINVAL;
 	}
 
@@ -437,21 +430,17 @@
 		/* Voodoo 2 limits */
 		tiles_in_X = (var->xres + 63 ) / 64 * 2;		
 
-		if (((var->xres - 1) >= POW2(11)) || (yDim >= POW2(11))) {
-			eprintk("Unsupported resolution %dx%d\n",
+		if (var->xres  > POW2(11) || yDim >= POW2(11)) {
+			printk(KERN_ERR "sstfb: Unsupported resolution %dx%d\n",
 			         var->xres, var->yres);
 			return -EINVAL;
 		}
 
-		if (((var->hsync_len-1) >= POW2(9))
-		   || ((hSyncOff-1) >= POW2(11))
-		   || ((var->left_margin - 2) >= POW2(9))
-		   || (vSyncOn >= POW2(13))
-		   || (vSyncOff >= POW2(13))
-		   || (vBackPorch >= POW2(9))
-		   || (tiles_in_X >= POW2(6))
-		   || (tiles_in_X <= 0)) {
-			eprintk("Unsupported Timings\n");
+		if (var->hsync_len > POW2(9) || hSyncOff > POW2(11) ||
+		    var->left_margin - 2 >= POW2(9) || vSyncOn >= POW2(13) ||
+		    vSyncOff >= POW2(13) || vBackPorch >= POW2(9) ||
+		    tiles_in_X >= POW2(6) || tiles_in_X <= 0) {
+			printk(KERN_ERR "sstfb: Unsupported timings\n");
 			return -EINVAL;
 		}
 	} else {
@@ -459,24 +448,20 @@
 		tiles_in_X = (var->xres + 63 ) / 64;
 
 		if (var->vmode) {
-			eprintk("Interlace/Doublescan not supported %#x\n",
+			printk(KERN_ERR "sstfb: Interlace/doublescan not supported %#x\n",
 				var->vmode);
 			return -EINVAL;
 		}
-		if (((var->xres - 1) >= POW2(10)) || (var->yres >= POW2(10))) {
-			eprintk("Unsupported resolution %dx%d\n",
+		if (var->xres > POW2(10) || var->yres >= POW2(10)) {
+			printk(KERN_ERR "sstfb: Unsupported resolution %dx%d\n",
 			         var->xres, var->yres);
 			return -EINVAL;
 		}
-		if (((var->hsync_len - 1) >= POW2(8))
-		   || ((hSyncOff-1) >= POW2(10))
-		   || ((var->left_margin - 2) >= POW2(8))
-		   || (vSyncOn >= POW2(12))
-		   || (vSyncOff >= POW2(12))
-		   || (vBackPorch >= POW2(8))
-		   || (tiles_in_X >= POW2(4))
-		   || (tiles_in_X <= 0)) {
-			eprintk("Unsupported Timings\n");
+		if (var->hsync_len > POW2(8) || hSyncOff - 1 > POW2(10) ||
+		    var->left_margin - 2 >= POW2(8) || vSyncOn >= POW2(12) ||
+		    vSyncOff >= POW2(12) || vBackPorch >= POW2(8) ||
+		    tiles_in_X >= POW2(4) || tiles_in_X <= 0) {
+			printk(KERN_ERR "sstfb: Unsupported timings\n");
 			return -EINVAL;
 		}
 	}
@@ -486,8 +471,8 @@
 	real_length = tiles_in_X  * (IS_VOODOO2(par) ? 32 : 64 )
 	              * ((var->bits_per_pixel == 16) ? 2 : 4);
 
-	if ((real_length * yDim) > info->fix.smem_len) {
-		eprintk("Not enough video memory\n");
+	if (real_length * yDim > info->fix.smem_len) {
+		printk(KERN_ERR "sstfb: Not enough video memory\n");
 		return -ENOMEM;
 	}
 
@@ -515,20 +500,6 @@
 		var->blue.offset   = 0;
 		var->transp.offset = 0;
 		break;
-#ifdef EN_24_32_BPP
-	case 24:	/* RGB 888 LfbMode 4 */
-	case 32:	/* ARGB 8888 LfbMode 5 */
-		var->red.length    = 8;
-		var->green.length  = 8;
-		var->blue.length   = 8;
-		var->transp.length = 0;
-
-		var->red.offset    = 16;
-		var->green.offset  = 8;
-		var->blue.offset   = 0;
-		var->transp.offset = 0; /* in 24bpp we fake a 32 bpp mode */
-		break;
-#endif
 	default:
 		return -EINVAL;
 	}
@@ -653,13 +624,6 @@
 	case 16:
 		fbiinit1 |=  SEL_SOURCE_VCLK_2X_SEL;
 		break;
-#ifdef EN_24_32_BPP
-	case 24:
-	case 32:
-		/* sst_set_bits(FBIINIT1, SEL_SOURCE_VCLK_2X_DIV2 | EN_24BPP);*/
-		fbiinit1 |= SEL_SOURCE_VCLK_2X_SEL | EN_24BPP;
-		break;
-#endif
 	default:
 		return -EINVAL;
 	}
@@ -690,14 +654,6 @@
 	case 16:
 		lfbmode = LFB_565;
 		break;
-#ifdef EN_24_32_BPP
-	case 24:
-		lfbmode = LFB_888;
-		break;
-	case 32:
-		lfbmode = LFB_8888;
-		break;
-#endif
 	default:
 		return -EINVAL;
 	}
@@ -789,8 +745,7 @@
 			return -EFAULT;
 		if (val > info->fix.smem_len)
 			val = info->fix.smem_len;
-		printk("filling %#x \n", val);
-		for (p=0 ; p<val; p+=2)
+		for (p = 0 ; p < val; p += 2)
 			writew(p >> 6, info->screen_base + p);
 		return 0;
 		
@@ -802,13 +757,10 @@
 		pci_write_config_dword(sst_dev, PCI_INIT_ENABLE,
 				       tmp | PCI_EN_INIT_WR );
 		fbiinit0 = sst_read (FBIINIT0);
-		if (val) {
+		if (val)
 			sst_write(FBIINIT0, fbiinit0 & ~EN_VGA_PASSTHROUGH);
-			iprintk("Disabling VGA pass-through\n");
-		} else {
+		else
 			sst_write(FBIINIT0, fbiinit0 | EN_VGA_PASSTHROUGH);
-			iprintk("Enabling VGA pass-through\n");
-		}
 		pci_write_config_dword(sst_dev, PCI_INIT_ENABLE, tmp);
 		return 0;
 		
@@ -884,9 +836,9 @@
 	u8 __iomem *fbbase_virt = info->screen_base;
 
 	/* force memsize */
-	if ((mem >= 1 ) &&  (mem <= 4)) {
+	if (mem >= 1  && mem <= 4) {
 		*memsize = (mem * 0x100000);
-		iprintk("supplied memsize: %#x\n", *memsize);
+		printk(KERN_INFO "supplied memsize: %#x\n", *memsize);
 		return 1;
 	}
 
@@ -927,7 +879,7 @@
 	struct sstfb_par *par = info->par;
 	int i, mir, dir;
 
-	for (i=0; i<3; i++) {
+	for (i = 0; i < 3; i++) {
 		sst_dac_write(DACREG_WMA, 0); 	/* backdoor */
 		sst_dac_read(DACREG_RMR);	/* read 4 times RMR */
 		sst_dac_read(DACREG_RMR);
@@ -940,7 +892,7 @@
 		/*the 7th, device ID register */
 		dir = sst_dac_read(DACREG_RMR);
 		f_ddprintk("mir: %#x, dir: %#x\n", mir, dir);
-		if ((mir == DACREG_MIR_ATT ) && (dir == DACREG_DIR_ATT)) {
+		if (mir == DACREG_MIR_ATT && dir == DACREG_DIR_ATT) {
 			return 1;
 		}
 	}
@@ -1134,12 +1086,6 @@
 	case 16:
 		sst_dac_write(DACREG_RMR, (cr0 & 0x0f) | DACREG_CR0_16BPP);
 		break;
-#ifdef EN_24_32_BPP
-	case 24:
-	case 32:
-		sst_dac_write(DACREG_RMR, (cr0 & 0x0f) | DACREG_CR0_24BPP);
-		break;
-#endif
 	default:
 		dprintk("%s: bad depth '%u'\n", __FUNCTION__, bpp);
 		break;
@@ -1154,12 +1100,6 @@
 	case 16:
 		sst_dac_write(DACREG_ICS_CMD, DACREG_ICS_CMD_16BPP);
 		break;
-#ifdef EN_24_32_BPP
-	case 24:
-	case 32:
-		sst_dac_write(DACREG_ICS_CMD, DACREG_ICS_CMD_24BPP);
-		break;
-#endif
 	default:
 		dprintk("%s: bad depth '%u'\n", __FUNCTION__, bpp);
 		break;
@@ -1250,7 +1190,7 @@
 				PCI_EN_INIT_WR | PCI_REMAP_DAC );
 	/* detect dac type */
 	if (!sst_detect_dactype(info, par)) {
-		eprintk("Unknown dac type\n");
+		printk(KERN_ERR "sstfb: unknown dac type.\n");
 		//FIXME watch it: we are not in a safe state, bad bad bad.
 		return 0;
 	}
@@ -1258,10 +1198,10 @@
 	/* set graphic clock */
 	par->gfx_clock = spec->default_gfx_clock;
 	if ((gfxclk >10 ) && (gfxclk < spec->max_gfxclk)) {
-		iprintk("Using supplied graphic freq : %dMHz\n", gfxclk);
+		printk(KERN_INFO "sstfb: Using supplied graphic freq : %dMHz\n", gfxclk);
 		 par->gfx_clock = gfxclk *1000;
 	} else if (gfxclk) {
-		wprintk ("%dMhz is way out of spec! Using default\n", gfxclk);
+		printk(KERN_WARNING "sstfb: %dMhz is way out of spec! Using default\n", gfxclk);
 	}
 
 	sst_calc_pll(par->gfx_clock, &Fout, &gfx_timings);
@@ -1396,7 +1336,7 @@
 
 	/* Enable device in PCI config. */
 	if ((err=pci_enable_device(pdev))) {
-		eprintk("cannot enable device\n");
+		printk(KERN_ERR "cannot enable device\n");
 		return err;
 	}
 
@@ -1422,39 +1362,39 @@
 	fix->smem_start = fix->mmio_start + 0x400000;
 
 	if (!request_mem_region(fix->mmio_start, fix->mmio_len, "sstfb MMIO")) {
-		eprintk("cannot reserve mmio memory\n");
+		printk(KERN_ERR "sstfb: cannot reserve mmio memory\n");
 		goto fail_mmio_mem;
 	}
 
 	if (!request_mem_region(fix->smem_start, 0x400000,"sstfb FB")) {
-		eprintk("cannot reserve fb memory\n");
+		printk(KERN_ERR "sstfb: cannot reserve fb memory\n");
 		goto fail_fb_mem;
 	}
 
 	par->mmio_vbase = ioremap_nocache(fix->mmio_start,
 					fix->mmio_len);
 	if (!par->mmio_vbase) {
-		eprintk("cannot remap register area %#lx\n",
+		printk(KERN_ERR "sstfb: cannot remap register area %#lx\n",
 		        fix->mmio_start);
 		goto fail_mmio_remap;
 	}
 	info->screen_base = ioremap_nocache(fix->smem_start, 0x400000);
 	if (!info->screen_base) {
-		eprintk("cannot remap framebuffer %#lx\n",
+		printk(KERN_ERR "sstfb: cannot remap framebuffer %#lx\n",
 		        fix->smem_start);
 		goto fail_fb_remap;
 	}
 
 	if (!sst_init(info, par)) {
-		eprintk("Init failed\n");
+		printk(KERN_ERR "sstfb: Init failed\n");
 		goto fail;
 	}
 	sst_get_memsize(info, &fix->smem_len);
 	strlcpy(fix->id, spec->name, sizeof(fix->id));
 
-	iprintk("%s (revision %d) with %s dac\n",
+	printk(KERN_INFO "%s (revision %d) with %s dac\n",
 		fix->id, par->revision, par->dac_sw.name);
-	iprintk("framebuffer at %#lx, mapped to 0x%p, size %dMB\n",
+	printk(KERN_INFO "framebuffer at %#lx, mapped to 0x%p, size %dMB\n",
 	        fix->smem_start, info->screen_base,
 	        fix->smem_len >> 20);
 
@@ -1471,24 +1411,25 @@
 	fix->accel	= FB_ACCEL_NONE;  /* FIXME */
 	/*
 	 * According to the specs, the linelength must be of 1024 *pixels*
-	 * and the 24bpp mode is in fact a 32 bpp mode.
+	 * and the 24bpp mode is in fact a 32 bpp mode (and both are in
+	 * fact dithered to 16bit).
 	 */
 	fix->line_length = 2048; /* default value, for 24 or 32bit: 4096 */
 	
 	if ( mode_option &&
 	     fb_find_mode(&info->var, info, mode_option, NULL, 0, NULL, 16)) {
-		eprintk("can't set supplied video mode. Using default\n");
+		printk(KERN_ERR "sstfb: can't set supplied video mode. Using default\n");
 		info->var = sstfb_default;
 	} else
 		info->var = sstfb_default;
 
 	if (sstfb_check_var(&info->var, info)) {
-		eprintk("invalid default video mode.\n");
+		printk(KERN_ERR "sstfb: invalid default video mode.\n");
 		goto fail;
 	}
 
 	if (sstfb_set_par(info)) {
-		eprintk("can't set default video mode.\n");
+		printk(KERN_ERR "sstfb: can't set default video mode.\n");
 		goto fail;
 	}
 	
@@ -1497,7 +1438,7 @@
 	/* register fb */
 	info->device = &pdev->dev;
 	if (register_framebuffer(info) < 0) {
-		eprintk("can't register framebuffer.\n");
+		printk(KERN_ERR "sstfb: can't register framebuffer.\n");
 		goto fail;
 	}
 
@@ -1711,4 +1652,3 @@
 MODULE_PARM_DESC(gfxclk, "Force graphic chip frequency in MHz. DANGEROUS. (default=auto)");
 module_param(slowpci, bool, 0);
 MODULE_PARM_DESC(slowpci, "Uses slow PCI settings (0 or 1) (default=0)");
-
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc4-mm2/include/video/sstfb.h linux-2.6.18-rc4-mm2/include/video/sstfb.h
--- linux.vanilla-2.6.18-rc4-mm2/include/video/sstfb.h	2006-08-21 14:17:59.000000000 +0100
+++ linux-2.6.18-rc4-mm2/include/video/sstfb.h	2006-08-21 21:56:26.000000000 +0100
@@ -68,10 +68,6 @@
 #  define print_var(X,Y...)
 #endif
 
-#define eprintk(X...)	printk(KERN_ERR "sstfb: " X)
-#define iprintk(X...)	printk(KERN_INFO "sstfb: " X)
-#define wprintk(X...)	printk(KERN_WARNING "sstfb: " X)
-
 #define BIT(x)		(1ul<<(x))
 #define POW2(x)		(1ul<<(x))
 

