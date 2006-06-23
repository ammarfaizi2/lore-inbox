Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752045AbWFWUvi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752045AbWFWUvi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 16:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752048AbWFWUvi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 16:51:38 -0400
Received: from outbound-res.frontbridge.com ([63.161.60.49]:56616 "EHLO
	outbound2-res-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1752045AbWFWUvh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 16:51:37 -0400
X-BigFish: V
X-Server-Uuid: 519AC16A-9632-469E-B354-112C592D09E8
Date: Fri, 23 Jun 2006 14:56:37 -0600
From: "Jordan Crouse" <jordan.crouse@amd.com>
To: linux-kernel@vger.kernel.org
cc: linux-fbdev-devel@lists.sourceforge.net, akpm@osdl.org
Subject: Re: Geode patches for 2.6.17
Message-ID: <20060623205637.GD13017@cosmic.amd.com>
References: <20060623170058.GA12819@cosmic.amd.com>
 <449C4E3C.7000107@garzik.org>
MIME-Version: 1.0
In-Reply-To: <449C4E3C.7000107@garzik.org>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 23 Jun 2006 20:51:25.0293 (UTC)
 FILETIME=[CAB279D0:01C69706]
X-WSS-ID: 68828BC71UG3613611-01-01
Content-Type: multipart/mixed;
 boundary=l76fUT7nc3MelDdI
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--l76fUT7nc3MelDdI
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

>Please consider pulling from:
>git://git.infradead.net/users/jcrouse/geode.git linus-upstream
>
>This is the new home for patches for the AMD Geode family of processors.

As Jeff Garzik and others have pointed out, I failed to attach neither
a diffstat nor a patch, so allow me to rectify that now.

Jordan

 arch/i386/Kconfig                |    9 +++++++++
 arch/i386/boot/setup.S           |    5 +++++
 drivers/video/Kconfig            |    6 +++---
 drivers/video/console/Kconfig    |    4 ++--
 drivers/video/geode/Kconfig      |   20 ++++++++++++++++++++
 drivers/video/geode/display_gx.c |   22 +++++++++++++++++++---
 drivers/video/geode/display_gx.h |    3 ++-
 drivers/video/geode/gxfb_core.c  |    8 +++++++-
 drivers/video/geode/video_gx.c   |   24 +++++++++++++++++++++++-
 drivers/video/geode/video_gx.h   |    7 +++++++
 include/linux/pci_ids.h          |    5 ++---
 11 files changed, 99 insertions(+), 14 deletions(-)

--l76fUT7nc3MelDdI
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline;
 filename=linux-2.6.17-geode.patch
Content-Transfer-Encoding: 7bit

diff --git a/arch/i386/Kconfig b/arch/i386/Kconfig
index 8dfa305..b6abc74 100644
--- a/arch/i386/Kconfig
+++ b/arch/i386/Kconfig
@@ -708,6 +708,15 @@ config SECCOMP
 
 	  If unsure, say Y. Only embedded should say N here.
 
+config VGA_NOPROBE
+       bool "Don't probe VGA at boot" if EMBEDDED
+       default n
+       help
+         Saying Y here will cause the kernel to not probe VGA at boot time.
+         This will break everything that depends on the probed screen
+         data.  Say N here unless you are absolutely sure this is what you
+         want.
+
 source kernel/Kconfig.hz
 
 config KEXEC
diff --git a/arch/i386/boot/setup.S b/arch/i386/boot/setup.S
index ca668d9..9c06c84 100644
--- a/arch/i386/boot/setup.S
+++ b/arch/i386/boot/setup.S
@@ -395,10 +395,13 @@ # Set the keyboard repeat rate to the ma
 	xorw	%bx, %bx
 	int	$0x16
 
+#ifndef CONFIG_VGA_NOPROBE
+
 # Check for video adapter and its parameters and allow the
 # user to browse video modes.
 	call	video				# NOTE: we need %ds pointing
 						# to bootsector
+#endif
 
 # Get hd0 data...
 	xorw	%ax, %ax
@@ -1007,9 +1010,11 @@ gdt_48:
 	.word	gdt_end - gdt - 1		# gdt limit
 	.word	0, 0				# gdt base (filled in later)
 
+#ifndef CONFIG_VGA_NOPROBE
 # Include video setup & detection code
 
 #include "video.S"
+#endif
 
 # Setup signature -- must be last
 setup_sig1:	.word	SIG1
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 4587087..e65a492 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -473,7 +473,7 @@ config FB_TGA
 
 config FB_VESA
 	bool "VESA VGA graphics support"
-	depends on (FB = y) && X86
+	depends on (FB = y) && X86 && !VGA_NOPROBE
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
@@ -743,7 +743,7 @@ config FB_I810_I2C
 
 config FB_INTEL
 	tristate "Intel 830M/845G/852GM/855GM/865G support (EXPERIMENTAL)"
-	depends on FB && EXPERIMENTAL && PCI && X86_32
+	depends on FB && EXPERIMENTAL && PCI && X86_32 && !VGA_NOPROBE
 	select AGP
 	select AGP_INTEL
 	select FB_MODE_HELPERS
@@ -1050,7 +1050,7 @@ config FB_SAVAGE_ACCEL
 
 config FB_SIS
 	tristate "SiS/XGI display support"
-	depends on FB && PCI
+	depends on FB && PCI && !VGA_NOPROBE
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
index 4444bef..0be8e3b 100644
--- a/drivers/video/console/Kconfig
+++ b/drivers/video/console/Kconfig
@@ -5,8 +5,8 @@ #
 menu "Console display driver support"
 
 config VGA_CONSOLE
-	bool "VGA text console" if EMBEDDED || !X86
-	depends on !ARCH_ACORN && !ARCH_EBSA110 && !4xx && !8xx && !SPARC && !M68K && !PARISC && !FRV && !ARCH_VERSATILE
+	bool "VGA text console" if (EMBEDDED || !X86)
+	depends on !ARCH_ACORN && !ARCH_EBSA110 && !4xx && !8xx && !SPARC && !M68K && !PARISC && !FRV && !ARCH_VERSATILE && !VGA_NOPROBE
 	default y
 	help
 	  Saying Y here will allow you to use Linux in text mode through a
diff --git a/drivers/video/geode/Kconfig b/drivers/video/geode/Kconfig
index 4e173ef..5704879 100644
--- a/drivers/video/geode/Kconfig
+++ b/drivers/video/geode/Kconfig
@@ -23,6 +23,26 @@ config FB_GEODE_GX
 
 	  If unsure, say N.
 
+config FB_GEODE_GX_SET_FBSIZE
+	bool "Manually specify the Geode GX framebuffer size"
+	depends on FB_GEODE_GX
+	default n
+	---help---
+	  If you want to manually specify the size of your GX framebuffer,
+	  say Y here, otherwise say N to dynamically probe it.
+	  
+	  Say N unless you know what you are doing.
+
+config FB_GEODE_GX_FBSIZE
+	hex "Size of the GX framebuffer, in bytes"
+	depends on FB_GEODE_GX_SET_FBSIZE
+	default "0x1600000"
+	---help---
+	  Specify the size of the GX framebuffer.  Normally, you will
+	  want this to be MB aligned.  Common values are 0x80000 (8MB)
+	  and 0x1600000 (16MB).  Don't change this unless you know what
+	  you are doing
+
 config FB_GEODE_GX1
 	tristate "AMD Geode GX1 framebuffer support (EXPERIMENTAL)"
 	depends on FB && FB_GEODE && EXPERIMENTAL
diff --git a/drivers/video/geode/display_gx.c b/drivers/video/geode/display_gx.c
index 825c340..7faf62a 100644
--- a/drivers/video/geode/display_gx.c
+++ b/drivers/video/geode/display_gx.c
@@ -21,11 +21,26 @@ #include <asm/delay.h>
 #include "geodefb.h"
 #include "display_gx.h"
 
-int gx_frame_buffer_size(void)
+#ifdef CONFIG_FB_GEODE_GX_SET_FBSIZE
+unsigned int gx_frame_buffer_size(void) {
+	return CONFIG_FB_GEODE_GX_FBSIZE;
+}
+#else
+unsigned int gx_frame_buffer_size(void)
 {
-	/* Assuming 16 MiB. */
-	return 16*1024*1024;
+	unsigned int val;
+
+	/* FB size is reported by a virtual register */
+	/* Virtual register class = 0x02 */
+	/* VG_MEM_SIZE(512Kb units) = 0x00 */
+
+	outw(0xFC53, 0xAC1C);
+	outw(0x0200, 0xAC1C);
+
+	val = (unsigned int)(inw(0xAC1E)) & 0xFFl;
+	return (val << 19);
 }
+#endif
 
 int gx_line_delta(int xres, int bpp)
 {
@@ -81,6 +96,7 @@ static void gx_set_mode(struct fb_info *
 	writel(((info->var.xres * info->var.bits_per_pixel/8) >> 3) + 2,
 	       par->dc_regs + DC_LINE_SIZE);
 
+
 	/* Enable graphics and video data and unmask address lines. */
 	dcfg |= DC_DCFG_GDEN | DC_DCFG_VDEN | DC_DCFG_A20M | DC_DCFG_A18M;
 
diff --git a/drivers/video/geode/display_gx.h b/drivers/video/geode/display_gx.h
index 86c6233..e962c76 100644
--- a/drivers/video/geode/display_gx.h
+++ b/drivers/video/geode/display_gx.h
@@ -11,7 +11,7 @@
 #ifndef __DISPLAY_GX_H__
 #define __DISPLAY_GX_H__
 
-int gx_frame_buffer_size(void);
+unsigned int gx_frame_buffer_size(void);
 int gx_line_delta(int xres, int bpp);
 
 extern struct geode_dc_ops gx_dc_ops;
@@ -93,4 +93,5 @@ #define DC_V_SYNC_TIMING   0x58
 #define DC_PAL_ADDRESS 0x70
 #define DC_PAL_DATA    0x74
 
+#define DC_GLIU0_MEM_OFFSET 0x84
 #endif /* !__DISPLAY_GX1_H__ */
diff --git a/drivers/video/geode/gxfb_core.c b/drivers/video/geode/gxfb_core.c
index 89c34b1..61cecbe 100644
--- a/drivers/video/geode/gxfb_core.c
+++ b/drivers/video/geode/gxfb_core.c
@@ -241,6 +241,12 @@ static int __init gxfb_map_video_memory(
 	if (!info->screen_base)
 		return -ENOMEM;
 
+	/* Set the 16MB aligned base address of the graphics memory region
+	 * in the display controller */
+
+	writel(info->fix.smem_start & 0xFF000000,
+			par->dc_regs + DC_GLIU0_MEM_OFFSET);
+
 	dev_info(&dev->dev, "%d Kibyte of video memory at 0x%lx\n",
 		 info->fix.smem_len / 1024, info->fix.smem_start);
 
@@ -384,7 +390,7 @@ static void gxfb_remove(struct pci_dev *
 }
 
 static struct pci_device_id gxfb_id_table[] = {
-	{ PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_CS5535_VIDEO,
+	{ PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_GX_VIDEO,
 	  PCI_ANY_ID, PCI_ANY_ID, PCI_BASE_CLASS_DISPLAY << 16,
 	  0xff0000, 0 },
 	{ 0, }
diff --git a/drivers/video/geode/video_gx.c b/drivers/video/geode/video_gx.c
index 2b2a788..616ce33 100644
--- a/drivers/video/geode/video_gx.c
+++ b/drivers/video/geode/video_gx.c
@@ -178,7 +178,21 @@ static void gx_set_dclk_frequency(struct
 static void gx_configure_display(struct fb_info *info)
 {
 	struct geodefb_par *par = info->par;
-	u32 dcfg, fp_pm;
+	u32 dcfg, fp_pm, misc;
+
+	/* Set up the MISC register */
+
+	misc = readl(par->vid_regs + GX_MISC);
+
+	/* Power up the DAC */
+	misc &= ~(GX_MISC_A_PWRDN | GX_MISC_DAC_PWRDN);
+
+	/* Disable gamma correction */
+	misc |= GX_MISC_GAM_EN;
+
+	writel(misc, par->vid_regs + GX_MISC);
+
+	/* Write the display configuration */
 
 	dcfg = readl(par->vid_regs + GX_DCFG);
 
@@ -199,9 +213,17 @@ static void gx_configure_display(struct 
 	if (info->var.sync & FB_SYNC_VERT_HIGH_ACT)
 		dcfg |= GX_DCFG_CRT_VSYNC_POL;
 
+	/* Enable the display logic */
+	/* Set up the DACS to blank normally */
+
+	dcfg |= GX_DCFG_CRT_EN | GX_DCFG_DAC_BL_EN;
+
+	/* Enable the external DAC VREF? */
+
 	writel(dcfg, par->vid_regs + GX_DCFG);
 
 	/* Power on flat panel. */
+
 	fp_pm = readl(par->vid_regs + GX_FP_PM);
 	fp_pm |= GX_FP_PM_P;
 	writel(fp_pm, par->vid_regs + GX_FP_PM);
diff --git a/drivers/video/geode/video_gx.h b/drivers/video/geode/video_gx.h
index 2d9211f..238181a 100644
--- a/drivers/video/geode/video_gx.h
+++ b/drivers/video/geode/video_gx.h
@@ -28,6 +28,13 @@ #  define GX_DCFG_VG_CK			0x00100000
 #  define GX_DCFG_GV_GAM		0x00200000
 #  define GX_DCFG_DAC_VREF		0x04000000
 
+/* Geode GX MISC video configuration */
+
+#define GX_MISC 0x50
+#define GX_MISC_GAM_EN     0x00000001
+#define GX_MISC_DAC_PWRDN  0x00000400
+#define GX_MISC_A_PWRDN    0x00000800
+
 /* Geode GX flat panel display control registers */
 #define GX_FP_PM 0x410
 #  define GX_FP_PM_P 0x01000000
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 590dc6d..289a4f8 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -387,7 +387,7 @@ #define PCI_DEVICE_ID_NS_CS5535_ISA	0x00
 #define PCI_DEVICE_ID_NS_CS5535_IDE	0x002d
 #define PCI_DEVICE_ID_NS_CS5535_AUDIO	0x002e
 #define PCI_DEVICE_ID_NS_CS5535_USB	0x002f
-#define PCI_DEVICE_ID_NS_CS5535_VIDEO	0x0030
+#define PCI_DEVICE_ID_NS_GX_VIDEO	0x0030
 #define PCI_DEVICE_ID_NS_SATURN		0x0035
 #define PCI_DEVICE_ID_NS_SCx200_BRIDGE	0x0500
 #define PCI_DEVICE_ID_NS_SCx200_SMI	0x0501
@@ -400,8 +400,7 @@ #define PCI_DEVICE_ID_NS_SC1100_SMI	0x05
 #define PCI_DEVICE_ID_NS_SC1100_XBUS	0x0515
 #define PCI_DEVICE_ID_NS_87410		0xd001
 
-#define PCI_DEVICE_ID_NS_CS5535_HOST_BRIDGE  0x0028
-#define PCI_DEVICE_ID_NS_CS5535_ISA_BRIDGE   0x002b
+#define PCI_DEVICE_ID_NS_GX_HOST_BRIDGE  0x0028
 
 #define PCI_VENDOR_ID_TSENG		0x100c
 #define PCI_DEVICE_ID_TSENG_W32P_2	0x3202

--l76fUT7nc3MelDdI--


