Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265346AbUBPEWp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 23:22:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265365AbUBPEWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 23:22:45 -0500
Received: from gate.crashing.org ([63.228.1.57]:45983 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265346AbUBPEW2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 23:22:28 -0500
Subject: [PATCH] radeonfb: limit ioremap size & debug output
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1076905223.6949.201.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 16 Feb 2004 15:20:24 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus !

This patch adds a limit on how much of the framebuffer is ioremap'ed
by radeonfb, thus enabling it to work with 128Mb VRAM or more on an
x86 with 900Mb of lowmem in the linear mapping.

It also adds a significant amount of debug messages and adds a CONFIG
option to enable the debugging output, that should help with diagnosing
new problems. Among others, it dumps the connector info as I understand
them (so far, they give "strange" informations on laptops, I need more
data on more various laptops to see if there's a pattern I can really use
to figure out on which connector the LVDS is)

Regarding the "lid closed at boot", ultimately, we may want to default
to the VGA output in those cases, though I'm not sure what logic to use
here. Maybe we could standardize some way for the platform to provide
this "environment" information to the driver, but i wouldn't rely on it.

More reliably, if we can find out that there is an LVDS output, and 
LVDS is disabled, just ignore the flat panel...

We could assume any mobility chip has LVDS, which is true, but that would
still cause a problem for laptops with an additional DVI output (only
Macs so far afaik).
 
Ben.

diff -urN linux-2.5/drivers/video/Kconfig linux-2.5-merge/drivers/video/Kconfig
--- linux-2.5/drivers/video/Kconfig	2004-02-15 10:23:41.000000000 +1100
+++ linux-2.5-merge/drivers/video/Kconfig	2004-02-16 15:12:46.795229632 +1100
@@ -650,6 +650,15 @@
 	help
 	  Say Y here if you want DDC/I2C support for your Radeon board. 
 
+config FB_RADEON_DEBUG
+	bool "Lots of debug output from Radeon driver"
+	depends on FB_RADEON
+	default n
+	help
+	  Say Y here if you want the Radeon driver to output all sorts
+	  of debugging informations to provide to the maintainer when
+	  something goes wrong.
+
 config FB_ATY128
 	tristate "ATI Rage128 display support"
 	depends on FB && PCI
diff -urN linux-2.5/drivers/video/aty/radeon_base.c linux-2.5-merge/drivers/video/aty/radeon_base.c
--- linux-2.5/drivers/video/aty/radeon_base.c	2004-02-16 15:09:24.084046416 +1100
+++ linux-2.5-merge/drivers/video/aty/radeon_base.c	2004-02-16 14:56:24.436570848 +1100
@@ -99,6 +99,8 @@
 #include "ati_ids.h"
 #include "radeonfb.h"		    
 
+#define MAX_MAPPED_VRAM	(2048*2048*4)
+#define MIN_MAPPED_VRAM	(1024*768*1)
 
 #define CHIP_DEF(id, family, flags)					\
 	{ PCI_VENDOR_ID_ATI, id, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (flags) | (CHIP_FAMILY_##family) }
@@ -826,6 +828,9 @@
 		v.xres_virtual = (pitch << 6) / ((v.bits_per_pixel + 1) / 8);
 	}
 
+	if (((v.xres_virtual * v.yres_virtual * nom) / den) > rinfo->mapped_vram)
+		return -EINVAL;
+
 	if (v.xres_virtual < v.xres)
 		v.xres = v.xres_virtual;
 
@@ -942,7 +947,7 @@
 static int radeon_screen_blank (struct radeonfb_info *rinfo, int blank)
 {
         u32 val = INREG(CRTC_EXT_CNTL);
-	u32 val2;
+	u32 val2 = 0;
 
 	if (rinfo->mon1_type == MT_LCD)
 		val2 = INREG(LVDS_GEN_CNTL) & ~LVDS_DISPLAY_DIS;
@@ -1023,7 +1028,7 @@
         pindex = regno;
 
         if (!rinfo->asleep) {
-        	u32 dac_cntl2, vclk_cntl;
+        	u32 dac_cntl2, vclk_cntl = 0;
         	
 		if (rinfo->is_mobility) {
 			vclk_cntl = INPLL(VCLK_ECP_CNTL);
@@ -1317,7 +1322,7 @@
 		{ 12, 7 },
 		{ 0,  0 },
 	};
-	int fb_div, pll_output_freq;
+	int fb_div, pll_output_freq = 0;
 	int uses_dvo = 0;
 
 	/* Check if the DVO port is enabled and sourced from the primary CRTC. I'm
@@ -1686,6 +1691,67 @@
 
 
 
+static ssize_t radeonfb_read(struct file *file, char *buf, size_t count, loff_t *ppos)
+{
+	unsigned long p = *ppos;
+	struct inode *inode = file->f_dentry->d_inode;
+	int fbidx = iminor(inode);
+	struct fb_info *info = registered_fb[fbidx];
+	struct radeonfb_info *rinfo = info->par;
+	
+	if (p >= rinfo->mapped_vram)
+	    return 0;
+	if (count >= rinfo->mapped_vram)
+	    count = rinfo->mapped_vram;
+	if (count + p > rinfo->mapped_vram)
+		count = rinfo->mapped_vram - p;
+	radeonfb_sync(info);
+	if (count) {
+	    char *base_addr;
+
+	    base_addr = info->screen_base;
+	    count -= copy_to_user(buf, base_addr+p, count);
+	    if (!count)
+		return -EFAULT;
+	    *ppos += count;
+	}
+	return count;
+}
+
+static ssize_t radeonfb_write(struct file *file, const char *buf, size_t count,
+			      loff_t *ppos)
+{
+	unsigned long p = *ppos;
+	struct inode *inode = file->f_dentry->d_inode;
+	int fbidx = iminor(inode);
+	struct fb_info *info = registered_fb[fbidx];
+	struct radeonfb_info *rinfo = info->par;
+	int err;
+
+	if (p > rinfo->mapped_vram)
+	    return -ENOSPC;
+	if (count >= rinfo->mapped_vram)
+	    count = rinfo->mapped_vram;
+	err = 0;
+	if (count + p > rinfo->mapped_vram) {
+	    count = rinfo->mapped_vram - p;
+	    err = -ENOSPC;
+	}
+	radeonfb_sync(info);
+	if (count) {
+	    char *base_addr;
+
+	    base_addr = info->screen_base;
+	    count -= copy_from_user(base_addr+p, buf, count);
+	    *ppos += count;
+	    err = -EFAULT;
+	}
+	if (count)
+		return count;
+	return err;
+}
+
+
 static struct fb_ops radeonfb_ops = {
 	.owner			= THIS_MODULE,
 	.fb_check_var		= radeonfb_check_var,
@@ -1698,6 +1764,8 @@
 	.fb_fillrect		= radeonfb_fillrect,
 	.fb_copyarea		= radeonfb_copyarea,
 	.fb_imageblit		= radeonfb_imageblit,
+	.fb_read		= radeonfb_read,
+	.fb_write		= radeonfb_write,
 	.fb_cursor		= soft_cursor,
 };
 
@@ -2122,11 +2190,27 @@
 
 	RTRACE("radeonfb: probed %s %ldk videoram\n", (rinfo->ram_type), (rinfo->video_ram/1024));
 
-	rinfo->fb_base = (unsigned long) ioremap (rinfo->fb_base_phys, rinfo->video_ram);
+	rinfo->mapped_vram = MAX_MAPPED_VRAM;
+	if (rinfo->video_ram < rinfo->mapped_vram)
+		rinfo->mapped_vram = rinfo->video_ram;
+	for (;;) {
+		rinfo->fb_base = (unsigned long) ioremap (rinfo->fb_base_phys,
+							  rinfo->mapped_vram);
+		if (rinfo->fb_base == 0 && rinfo->mapped_vram > MIN_MAPPED_VRAM) {
+			rinfo->mapped_vram /= 2;
+			continue;
+		}
+		break;
+	}
+
 	if (!rinfo->fb_base) {
 		printk (KERN_ERR "radeonfb: cannot map FB\n");
 		goto unmap_rom;
 	}
+
+	RTRACE("radeonfb: mapped %ldk videoram\n", rinfo->mapped_vram/1024);
+
+
 	/* Argh. Scary arch !!! */
 #ifdef CONFIG_PPC64
 	rinfo->fb_base = IO_TOKEN_TO_ADDR(rinfo->fb_base);
diff -urN linux-2.5/drivers/video/aty/radeon_i2c.c linux-2.5-merge/drivers/video/aty/radeon_i2c.c
--- linux-2.5/drivers/video/aty/radeon_i2c.c	2004-02-16 15:09:24.086046112 +1100
+++ linux-2.5-merge/drivers/video/aty/radeon_i2c.c	2004-02-16 11:06:36.603640056 +1100
@@ -243,7 +243,8 @@
 		return MT_NONE;
 	}
 	if (edid[0x14] & 0x80) {
-		if (rinfo->is_mobility && conn == ddc_dvi &&
+		/* Fix detection using BIOS tables */
+		if (rinfo->is_mobility /*&& conn == ddc_dvi*/ &&
 		    (INREG(LVDS_GEN_CNTL) & LVDS_ON)) {
 			RTRACE("radeonfb: I2C (port %d) ... found LVDS panel\n", conn);
 			return MT_LCD;
diff -urN linux-2.5/drivers/video/aty/radeon_monitor.c linux-2.5-merge/drivers/video/aty/radeon_monitor.c
--- linux-2.5/drivers/video/aty/radeon_monitor.c	2004-02-16 15:09:24.137038360 +1100
+++ linux-2.5-merge/drivers/video/aty/radeon_monitor.c	2004-02-16 15:04:08.036093008 +1100
@@ -156,6 +156,7 @@
 
 	if (!(tmp = BIOS_IN16(rinfo->fp_bios_start + 0x40))) {
 		printk(KERN_ERR "radeonfb: Failed to detect DFP panel info using BIOS\n");
+		rinfo->panel_info.pwr_delay = 200;
 		return 0;
 	}
 
@@ -169,7 +170,8 @@
 		rinfo->panel_info.xres, rinfo->panel_info.yres);
 
 	rinfo->panel_info.pwr_delay = BIOS_IN16(tmp + 44);
-	if (rinfo->panel_info.pwr_delay > 2000 || rinfo->panel_info.pwr_delay < 0)
+	RTRACE("BIOS provided panel power delay: %d\n", rinfo->panel_info.pwr_delay);
+	if (rinfo->panel_info.pwr_delay > 2000 || rinfo->panel_info.pwr_delay <= 0)
 		rinfo->panel_info.pwr_delay = 2000;
 
 	/*
@@ -182,11 +184,16 @@
 	    rinfo->panel_info.fbk_divider > 3) {
 		rinfo->panel_info.use_bios_dividers = 1;
 		printk(KERN_INFO "radeondb: BIOS provided dividers will be used\n");
+		RTRACE("ref_divider = %x\n", rinfo->panel_info.ref_divider);
+		RTRACE("post_divider = %x\n", rinfo->panel_info.post_divider);
+		RTRACE("fbk_divider = %x\n", rinfo->panel_info.fbk_divider);
 	}
+	RTRACE("Scanning BIOS table ...\n");
 	for(i=0; i<32; i++) {
 		tmp0 = BIOS_IN16(tmp+64+i*2);
 		if (tmp0 == 0)
 			break;
+		RTRACE(" %d x %d\n", BIOS_IN16(tmp0), BIOS_IN16(tmp0+2));
 		if ((BIOS_IN16(tmp0) == rinfo->panel_info.xres) &&
 		    (BIOS_IN16(tmp0+2) == rinfo->panel_info.yres)) {
 			rinfo->panel_info.hblank = (BIOS_IN16(tmp0+17) - BIOS_IN16(tmp0+19)) * 8;
@@ -205,13 +212,68 @@
 			/* Mark panel infos valid */
 			rinfo->panel_info.valid = 1;
 
+			RTRACE("Found panel in BIOS table:\n");
+			RTRACE("  hblank: %d\n", rinfo->panel_info.hblank);
+			RTRACE("  hOver_plus: %d\n", rinfo->panel_info.hOver_plus);
+			RTRACE("  hSync_width: %d\n", rinfo->panel_info.hSync_width);
+			RTRACE("  vblank: %d\n", rinfo->panel_info.vblank);
+			RTRACE("  vOver_plus: %d\n", rinfo->panel_info.vOver_plus);
+			RTRACE("  vSync_width: %d\n", rinfo->panel_info.vSync_width);
+			RTRACE("  clock: %d\n", rinfo->panel_info.clock);
+				
 			return 1;
 		}
 	}
+	RTRACE("Didn't find panel in BIOS table !\n");
 
 	return 0;
 }
 
+/* Try to extract the connector informations from the BIOS. This
+ * doesn't quite work yet, but it's output is still useful for
+ * debugging
+ */
+static void __devinit radeon_parse_connector_info(struct radeonfb_info *rinfo)
+{
+	int offset, chips, connectors, tmp, i, conn, type;
+
+	static char* __conn_type_table[16] = {
+		"NONE", "Proprietary", "CRT", "DVI-I", "DVI-D", "Unknown", "Unknown",
+		"Unknown", "Unknown", "Unknown", "Unknown", "Unknown", "Unknown",
+		"Unknown", "Unknown", "Unknown"
+	};
+
+	if (!rinfo->bios_seg)
+		return;
+
+	offset = BIOS_IN16(rinfo->fp_bios_start + 0x50);
+	if (offset == 0) {
+		printk(KERN_WARNING "radeonfb: No connector info table detected\n");
+		return;
+	}
+
+	/* Don't do much more at this point but displaying the data if
+	 * DEBUG is enabled
+	 */
+	chips = BIOS_IN8(offset++) >> 4;
+	RTRACE("%d chips in connector info\n", chips);
+	for (i = 0; i < chips; i++) {
+		tmp = BIOS_IN8(offset++);
+		connectors = tmp & 0x0f;
+		RTRACE(" - chip %d has %d connectors\n", tmp >> 4, connectors);
+		for (conn = 0; ; conn++) {
+			tmp = BIOS_IN16(offset);
+			if (tmp == 0)
+				break;
+			offset += 2;
+			type = (tmp >> 12) & 0x0f;
+			RTRACE("  * connector %d of type %d (%s) : %04x\n",
+			       conn, type, __conn_type_table[type], tmp);
+		}
+	}
+}
+
+
 /*
  * Probe physical connection of a CRT. This code comes from XFree
  * as well and currently is only implemented for the CRT DAC, the
@@ -224,7 +286,7 @@
     /* the monitor either wasn't connected or it is a non-DDC CRT.
      * try to probe it
      */
-    if(is_crt_dac) {
+    if (is_crt_dac) {
 	unsigned long ulOrigVCLK_ECP_CNTL;
 	unsigned long ulOrigDAC_CNTL;
 	unsigned long ulOrigDAC_EXT_CNTL;
@@ -353,10 +415,12 @@
 				    const char *monitor_layout, int ignore_edid)
 {
 #ifdef CONFIG_FB_RADEON_I2C
-	int ddc_crt2_used = 0;
+	int ddc_crt2_used = 0;	
 #endif
 	int tmp, i;
 
+	radeon_parse_connector_info(rinfo);
+
 	if (radeon_parse_monitor_layout(rinfo, monitor_layout)) {
 
 		/*
@@ -392,13 +456,23 @@
 			rinfo->mon2_EDID = NULL;
 		}
 	} else {
-
 		/*
 		 * Auto-detecting display type (well... trying to ...)
 		 */
 		
 		RTRACE("Starting monitor auto detection...\n");
 
+#if DEBUG
+		{
+			u8 *EDIDs[4] = { NULL, NULL, NULL, NULL };
+			int mon_types[4] = {MT_NONE, MT_NONE, MT_NONE, MT_NONE};
+			int i;
+
+			for (i = 0; i < 4; i++)
+				mon_types[i] = radeon_probe_i2c_connector(rinfo,
+									  i+1, &EDIDs[i]);
+		}
+#endif /* DEBUG */
 		/*
 		 * Old single head cards
 		 */
diff -urN linux-2.5/drivers/video/aty/radeonfb.h linux-2.5-merge/drivers/video/aty/radeonfb.h
--- linux-2.5/drivers/video/aty/radeonfb.h	2004-02-16 15:09:24.194029696 +1100
+++ linux-2.5-merge/drivers/video/aty/radeonfb.h	2004-02-16 15:12:54.260094800 +1100
@@ -282,6 +282,7 @@
 	u8			family;
 	u8			rev;
 	unsigned long		video_ram;
+	unsigned long		mapped_vram;
 
 	int			pitch, bpp, depth;
 
@@ -332,7 +333,11 @@
 /*
  * Debugging stuffs
  */
+#ifdef CONFIG_FB_RADEON_DEBUG
+#define DEBUG		1
+#else
 #define DEBUG		0
+#endif
 
 #if DEBUG
 #define RTRACE		printk


