Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264288AbUBOHQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 02:16:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264278AbUBOHQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 02:16:26 -0500
Received: from gate.crashing.org ([63.228.1.57]:34205 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S264291AbUBOHOb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 02:14:31 -0500
Subject: [PATCH] Update aty128fb video driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>,
       James Simmons <jsimmons@infradead.org>
Content-Type: text/plain
Message-Id: <1076829198.6957.18.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 15 Feb 2004 18:13:19 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

This patch updates the aty128fb driver. It adds more PCI IDs, uses
the new framebuffer alloc/release functions, make BIOS PLL data
access more reliable (using ROM whenever possible, with a fallback
to RAM BIOS image), cleanup the Power Management stuff (get rid
of PowerMac specific stuffs, use real PCI ones instead), along
with some style cleanups

Ben.

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/02/15 18:01:38+11:00 benh@kernel.crashing.org 
#   Update aty128fb to new alloc/release, replace old pmac PM stuffs with
#   proper PCI callbacks, add more PCI IDs, retreive ROM PLL info more
#   reliably, ...
# 
# include/video/aty128.h
#   2004/02/15 18:01:26+11:00 benh@kernel.crashing.org +3 -0
#   Update aty128fb to new alloc/release, replace old pmac PM stuffs with
#   proper PCI callbacks, add more PCI IDs, retreive ROM PLL info more
#   reliably, ...
# 
# include/linux/pci_ids.h
#   2004/02/15 18:01:26+11:00 benh@kernel.crashing.org +24 -15
#   Update aty128fb to new alloc/release, replace old pmac PM stuffs with
#   proper PCI callbacks, add more PCI IDs, retreive ROM PLL info more
#   reliably, ...
# 
# drivers/video/aty/aty128fb.c
#   2004/02/15 18:01:26+11:00 benh@kernel.crashing.org +569 -458
#   Update aty128fb to new alloc/release, replace old pmac PM stuffs with
#   proper PCI callbacks, add more PCI IDs, retreive ROM PLL info more
#   reliably, ...
# 
diff -Nru a/drivers/video/aty/aty128fb.c b/drivers/video/aty/aty128fb.c
--- a/drivers/video/aty/aty128fb.c	Sun Feb 15 18:03:31 2004
+++ b/drivers/video/aty/aty128fb.c	Sun Feb 15 18:03:31 2004
@@ -13,6 +13,7 @@
  *
  *                Benjamin Herrenschmidt
  *                      - pmac-specific PM stuff
+ *			- various fixes & cleanups
  *
  *                Andreas Hundt <andi@convergence.de>
  *                      - FB_ACTIVATE fixes
@@ -24,6 +25,10 @@
  *		  Paul Mundt 
  *		  	- PCI hotplug
  *
+ *		  Jon Smirl <jonsmirl@yahoo.com>
+ * 			- PCI ID update
+ * 			- replace ROM BIOS search
+ *
  *  Based off of Geert's atyfb.c and vfb.c.
  *
  *  TODO:
@@ -43,6 +48,7 @@
 
 #include <linux/config.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/string.h>
@@ -57,6 +63,7 @@
 #include <linux/init.h>
 #include <linux/pci.h>
 #include <linux/ioport.h>
+#include <linux/console.h>
 #include <asm/io.h>
 
 #ifdef CONFIG_PPC_PMAC
@@ -65,11 +72,6 @@
 #include "../macmodes.h"
 #endif
 
-#ifdef CONFIG_ADB_PMU
-#include <linux/adb.h>
-#include <linux/pmu.h>
-#endif
-
 #ifdef CONFIG_PMAC_BACKLIGHT
 #include <asm/backlight.h>
 #endif
@@ -136,8 +138,25 @@
 /* Chip generations */
 enum {
 	rage_128,
+	rage_128_pci,
 	rage_128_pro,
-	rage_M3
+	rage_128_pro_pci,
+	rage_M3,
+	rage_M3_pci,
+	rage_M4,
+	rage_128_ultra,
+};
+
+/* Must match above enum */
+static const char *r128_family[] __devinitdata = {
+	"AGP",
+	"PCI",
+	"PRO AGP",
+	"PRO PCI",
+	"M3 AGP",
+	"M3 PCI",
+	"M4 AGP",
+	"Ultra AGP",
 };
 
 /*
@@ -146,35 +165,105 @@
 static int aty128_probe(struct pci_dev *pdev,
                                const struct pci_device_id *ent);
 static void aty128_remove(struct pci_dev *pdev);
+static int aty128_pci_suspend(struct pci_dev *pdev, u32 state);
+static int aty128_pci_resume(struct pci_dev *pdev);
 
 /* supported Rage128 chipsets */
 static struct pci_device_id aty128_pci_tbl[] = {
-	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_RE,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128 },
-	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_RF,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128 },
-	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_RI,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128 },
-	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_RK,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128 },
-	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_RL,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128 },
-	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_Rage128_PD,
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_LE,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_M3_pci },
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_LF,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_M3 },
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_MF,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_M4 },
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_ML,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_M4 },
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_PA,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128_pro },
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_PB,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128_pro },
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_PC,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128_pro },
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_PD,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128_pro_pci },
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_PE,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128_pro },
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_PF,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128_pro },
-	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_PR,
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_PG,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128_pro },
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_PH,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128_pro },
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_PI,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128_pro },
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_PJ,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128_pro },
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_PK,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128_pro },
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_PL,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128_pro },
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_PM,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128_pro },
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_PN,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128_pro },
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_PO,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128_pro },
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_PP,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128_pro_pci },
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_PQ,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128_pro },
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_PR,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128_pro_pci },
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_PS,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128_pro },
-	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_U3,
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_PT,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128_pro },
-	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_U1,
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_PU,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128_pro },
-	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_LE,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_M3 },
-	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_LF,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_M3 },
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_PV,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128_pro },
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_PW,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128_pro },
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_PX,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128_pro },
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_RE,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128_pci },
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_RF,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128 },
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_RG,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128 },
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_RK,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128_pci },
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_RL,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128 },
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_SE,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128 },
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_SF,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128_pci },
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_SG,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128 },
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_SH,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128 },
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_SK,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128 },
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_SL,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128 },
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_SM,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128 },
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_SN,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128 },
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_TF,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128_ultra },
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_TL,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128_ultra },
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_TR,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128_ultra },
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_TS,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128_ultra },
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_TT,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128_ultra },
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RAGE128_TU,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rage_128_ultra },
 	{ 0, }
 };
 
@@ -185,6 +274,8 @@
 	.id_table	= aty128_pci_tbl,
 	.probe		= aty128_probe,
 	.remove		= __devexit_p(aty128_remove),
+	.suspend	= aty128_pci_suspend,
+	.resume		= aty128_pci_resume,
 };
 
 /* packed BIOS settings */
@@ -250,13 +341,6 @@
 	.accel		= FB_ACCEL_ATI_RAGE128,
 };
 
-#ifdef MODULE
-static char *mode __initdata = NULL;
-#ifdef CONFIG_MTRR
-static int  nomtrr __initdata = 0;
-#endif /* CONFIG_MTRR */
-#endif /* MODULE */
-
 static char *mode_option __initdata = NULL;
 
 #ifdef CONFIG_PPC_PMAC
@@ -275,7 +359,7 @@
 
 /* PLL constants */
 struct aty128_constants {
-	u32 dotclock;
+	u32 ref_clk;
 	u32 ppll_min;
 	u32 ppll_max;
 	u32 ref_divider;
@@ -322,26 +406,20 @@
 #endif
 	int blitter_may_be_busy;
 	int fifo_slots;                 /* free slots in FIFO (64 max) */
-#ifdef CONFIG_PMAC_PBOOK
-	unsigned char *save_framebuffer;
+
 	int	pm_reg;
 	int crt_on, lcd_on;
 	struct pci_dev *pdev;
 	struct fb_info *next;
-#endif
+	int	asleep;
+	int	lock_blank;
+
 	u8	red[32];		/* see aty128fb_setcolreg */
 	u8	green[64];
 	u8	blue[32];
 	u32	pseudo_palette[16];	/* used for TRUECOLOR */
 };
 
-#ifdef CONFIG_PMAC_PBOOK
-int aty128_sleep_notify(struct pmu_sleep_notifier *self, int when);
-static struct pmu_sleep_notifier aty128_sleep_notifier = {
-	aty128_sleep_notify, SLEEP_LEVEL_VIDEO,
-};
-static struct fb_info *aty128_fb = NULL;
-#endif
 
 #define round_div(n, d) ((n+(d/2))/d)
 
@@ -349,7 +427,6 @@
      *  Interface used by the world
      */
 int aty128fb_init(void);
-int aty128fb_setup(char *options);
 
 static int aty128fb_check_var(struct fb_var_screeninfo *var,
 			      struct fb_info *info);
@@ -371,10 +448,10 @@
                              const struct aty128fb_par *par);
 static int aty128_decode_var(struct fb_var_screeninfo *var,
                              struct aty128fb_par *par);
-#if !defined(CONFIG_PPC) && !defined(__sparc__)
+#if 0
 static void __init aty128_get_pllinfo(struct aty128fb_par *par,
 				      void *bios);
-static void __init *aty128_map_ROM(struct pci_dev *pdev);
+static void __init *aty128_map_ROM(struct pci_dev *pdev, const struct aty128fb_par *par);
 static void __init aty128_unmap_ROM(struct pci_dev *dev, void * rom);
 #endif
 static void aty128_timings(struct aty128fb_par *par);
@@ -386,6 +463,15 @@
 static void wait_for_idle(struct aty128fb_par *par);
 static u32 depth_to_dst(u32 depth);
 
+#define BIOS_IN8(v)  	(readb(bios + (v)))
+#define BIOS_IN16(v) 	(readb(bios + (v)) | \
+			  (readb(bios + (v) + 1) << 8))
+#define BIOS_IN32(v) 	(readb(bios + (v)) | \
+			  (readb(bios + (v) + 1) << 8) | \
+			  (readb(bios + (v) + 2) << 16) | \
+			  (readb(bios + (v) + 3) << 24))
+
+
 static struct fb_ops aty128fb_ops = {
 	.owner		= THIS_MODULE,
 	.fb_check_var	= aty128fb_check_var,
@@ -395,15 +481,9 @@
 	.fb_blank	= aty128fb_blank,
 	.fb_ioctl	= aty128fb_ioctl,
 	.fb_sync	= aty128fb_sync,
-#if 0
-	.fb_fillrect	= aty128fb_fillrect,
-	.fb_copyarea	= aty128fb_copyarea,
-	.fb_imageblit	= aty128fb_imageblit,
-#else
 	.fb_fillrect	= cfb_fillrect,
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
-#endif
 	.fb_cursor	= soft_cursor,
 };
 
@@ -422,40 +502,26 @@
      *	- endian conversions may possibly be avoided by
      *    using the other register aperture. TODO.
      */
-static inline u32
-_aty_ld_le32(volatile unsigned int regindex, const struct aty128fb_par *par)
+static inline u32 _aty_ld_le32(volatile unsigned int regindex, 
+			       const struct aty128fb_par *par)
 {
-	u32 val;
-
-#if defined(__powerpc__)
-	asm("lwbrx %0,%1,%2;eieio" : "=r"(val) : "b"(regindex), "r"(par->regbase));
-#else
-	val = readl (par->regbase + regindex);
-#endif
-
-	return val;
+	return readl (par->regbase + regindex);
 }
 
-static inline void
-_aty_st_le32(volatile unsigned int regindex, u32 val, 
-                               const struct aty128fb_par *par)
+static inline void _aty_st_le32(volatile unsigned int regindex, u32 val, 
+				const struct aty128fb_par *par)
 {
-#if defined(__powerpc__)
-	asm("stwbrx %0,%1,%2;eieio" : : "r"(val), "b"(regindex),
-	    "r"(par->regbase) : "memory");
-#else
 	writel (val, par->regbase + regindex);
-#endif
 }
 
-static inline u8
-_aty_ld_8(unsigned int regindex, const struct aty128fb_par *par)
+static inline u8 _aty_ld_8(unsigned int regindex,
+			   const struct aty128fb_par *par)
 {
 	return readb (par->regbase + regindex);
 }
 
-static inline void
-_aty_st_8(unsigned int regindex, u8 val, const struct aty128fb_par *par)
+static inline void _aty_st_8(unsigned int regindex, u8 val,
+			     const struct aty128fb_par *par)
 {
 	writeb (val, par->regbase + regindex);
 }
@@ -473,17 +539,15 @@
 #define aty_st_pll(pll_index, val)	_aty_st_pll(pll_index, val, par)
 
 
-static u32
-_aty_ld_pll(unsigned int pll_index,
-			const struct aty128fb_par *par)
+static u32 _aty_ld_pll(unsigned int pll_index,
+		       const struct aty128fb_par *par)
 {       
 	aty_st_8(CLOCK_CNTL_INDEX, pll_index & 0x3F);
 	return aty_ld_le32(CLOCK_CNTL_DATA);
 }
 
     
-static void
-_aty_st_pll(unsigned int pll_index, u32 val,
+static void _aty_st_pll(unsigned int pll_index, u32 val,
 			const struct aty128fb_par *par)
 {
 	aty_st_8(CLOCK_CNTL_INDEX, (pll_index & 0x3F) | PLL_WR_EN);
@@ -492,15 +556,13 @@
 
 
 /* return true when the PLL has completed an atomic update */
-static int
-aty_pll_readupdate(const struct aty128fb_par *par)
+static int aty_pll_readupdate(const struct aty128fb_par *par)
 {
 	return !(aty_ld_pll(PPLL_REF_DIV) & PPLL_ATOMIC_UPDATE_R);
 }
 
 
-static void
-aty_pll_wait_readupdate(const struct aty128fb_par *par)
+static void aty_pll_wait_readupdate(const struct aty128fb_par *par)
 {
 	unsigned long timeout = jiffies + HZ/100; // should be more than enough
 	int reset = 1;
@@ -517,8 +579,7 @@
 
 
 /* tell PLL to update */
-static void
-aty_pll_writeupdate(const struct aty128fb_par *par)
+static void aty_pll_writeupdate(const struct aty128fb_par *par)
 {
 	aty_pll_wait_readupdate(par);
 
@@ -528,8 +589,7 @@
 
 
 /* write to the scratch register to test r/w functionality */
-static int __init
-register_test(const struct aty128fb_par *par)
+static int __init register_test(const struct aty128fb_par *par)
 {
 	u32 val;
 	int flag = 0;
@@ -552,8 +612,7 @@
 /*
  * Accelerator engine functions
  */
-static void
-do_wait_for_fifo(u16 entries, struct aty128fb_par *par)
+static void do_wait_for_fifo(u16 entries, struct aty128fb_par *par)
 {
 	int i;
 
@@ -568,8 +627,7 @@
 }
 
 
-static void
-wait_for_idle(struct aty128fb_par *par)
+static void wait_for_idle(struct aty128fb_par *par)
 {
 	int i;
 
@@ -588,8 +646,7 @@
 }
 
 
-static void
-wait_for_fifo(u16 entries, struct aty128fb_par *par)
+static void wait_for_fifo(u16 entries, struct aty128fb_par *par)
 {
 	if (par->fifo_slots < entries)
 		do_wait_for_fifo(64, par);
@@ -597,8 +654,7 @@
 }
 
 
-static void
-aty128_flush_pixel_cache(const struct aty128fb_par *par)
+static void aty128_flush_pixel_cache(const struct aty128fb_par *par)
 {
 	int i;
 	u32 tmp;
@@ -614,8 +670,7 @@
 }
 
 
-static void
-aty128_reset_engine(const struct aty128fb_par *par)
+static void aty128_reset_engine(const struct aty128fb_par *par)
 {
 	u32 gen_reset_cntl, clock_cntl_index, mclk_cntl;
 
@@ -643,8 +698,7 @@
 }
 
 
-static void
-aty128_init_engine(struct aty128fb_par *par)
+static void aty128_init_engine(struct aty128fb_par *par)
 {
 	u32 pitch_value;
 
@@ -712,8 +766,7 @@
 
 
 /* convert depth values to their register representation */
-static u32
-depth_to_dst(u32 depth)
+static u32 depth_to_dst(u32 depth)
 {
 	if (depth <= 8)
 		return DST_8BPP;
@@ -729,15 +782,247 @@
 	return -EINVAL;
 }
 
+/*
+ * PLL informations retreival
+ */
+
+
+#ifndef __sparc__
+static void __init aty128_unmap_ROM(struct pci_dev *dev, void * rom)
+{
+	struct resource *r = &dev->resource[PCI_ROM_RESOURCE];
+	
+	iounmap(rom);
+	
+	/* Release the ROM resource if we used it in the first place */
+	if (r->parent && r->flags & PCI_ROM_ADDRESS_ENABLE) {
+		release_resource(r);
+		r->flags &= ~PCI_ROM_ADDRESS_ENABLE;
+		r->end -= r->start;
+		r->start = 0;
+	}
+	/* This will disable and set address to unassigned */
+	pci_write_config_dword(dev, dev->rom_base_reg, 0);
+}
+
+
+static void * __init aty128_map_ROM(const struct aty128fb_par *par, struct pci_dev *dev)
+{
+	struct resource *r;
+	u16 dptr;
+	u8 rom_type;
+	void *bios;
+
+    	/* Fix from ATI for problem with Rage128 hardware not leaving ROM enabled */
+    	unsigned int temp;
+	temp = aty_ld_le32(RAGE128_MPP_TB_CONFIG);
+	temp &= 0x00ffffffu;
+	temp |= 0x04 << 24;
+	aty_st_le32(RAGE128_MPP_TB_CONFIG, temp);
+	temp = aty_ld_le32(RAGE128_MPP_TB_CONFIG);
+
+	/* no need to search for the ROM, just ask the card where it is. */
+	r = &dev->resource[PCI_ROM_RESOURCE];
+
+	/* assign the ROM an address if it doesn't have one */
+	if (r->parent == NULL)
+		pci_assign_resource(dev, PCI_ROM_RESOURCE);
+	
+	/* enable if needed */
+	if (!(r->flags & PCI_ROM_ADDRESS_ENABLE)) {
+		pci_write_config_dword(dev, dev->rom_base_reg,
+				       r->start | PCI_ROM_ADDRESS_ENABLE);
+		r->flags |= PCI_ROM_ADDRESS_ENABLE;
+	}
+	
+	bios = ioremap(r->start, r->end - r->start + 1);
+	if (!bios) {
+		printk(KERN_ERR "aty128fb: ROM failed to map\n");
+		return NULL;
+	}
+	
+	/* Very simple test to make sure it appeared */
+	if (BIOS_IN16(0) != 0xaa55) {
+		printk(KERN_ERR "aty128fb: Invalid ROM signature %x should be 0xaa55\n",
+		       BIOS_IN16(0));
+		goto failed;
+	}
+
+	/* Look for the PCI data to check the ROM type */
+	dptr = BIOS_IN16(0x18);
+
+	/* Check the PCI data signature. If it's wrong, we still assume a normal x86 ROM
+	 * for now, until I've verified this works everywhere. The goal here is more
+	 * to phase out Open Firmware images.
+	 *
+	 * Currently, we only look at the first PCI data, we could iteratre and deal with
+	 * them all, and we should use fb_bios_start relative to start of image and not
+	 * relative start of ROM, but so far, I never found a dual-image ATI card
+	 *
+	 * typedef struct {
+	 * 	u32	signature;	+ 0x00
+	 * 	u16	vendor;		+ 0x04
+	 * 	u16	device;		+ 0x06
+	 * 	u16	reserved_1;	+ 0x08
+	 * 	u16	dlen;		+ 0x0a
+	 * 	u8	drevision;	+ 0x0c
+	 * 	u8	class_hi;	+ 0x0d
+	 * 	u16	class_lo;	+ 0x0e
+	 * 	u16	ilen;		+ 0x10
+	 * 	u16	irevision;	+ 0x12
+	 * 	u8	type;		+ 0x14
+	 * 	u8	indicator;	+ 0x15
+	 * 	u16	reserved_2;	+ 0x16
+	 * } pci_data_t;
+	 */
+	if (BIOS_IN32(dptr) !=  (('R' << 24) | ('I' << 16) | ('C' << 8) | 'P')) {
+		printk(KERN_WARNING "aty128fb: PCI DATA signature in ROM incorrect: %08x\n",
+		       BIOS_IN32(dptr));
+		goto anyway;
+	}
+	rom_type = BIOS_IN8(dptr + 0x14);
+	switch(rom_type) {
+	case 0:
+		printk(KERN_INFO "aty128fb: Found Intel x86 BIOS ROM Image\n");
+		break;
+	case 1:
+		printk(KERN_INFO "aty128fb: Found Open Firmware ROM Image\n");
+		goto failed;
+	case 2:
+		printk(KERN_INFO "aty128fb: Found HP PA-RISC ROM Image\n");
+		goto failed;
+	default:
+		printk(KERN_INFO "aty128fb: Found unknown type %d ROM Image\n", rom_type);
+		goto failed;
+	}
+ anyway:
+	return bios;
+
+ failed:
+	aty128_unmap_ROM(dev, bios);
+	return NULL;
+}
+
+static void __init aty128_get_pllinfo(struct aty128fb_par *par, unsigned char *bios)
+{
+	unsigned int bios_hdr;
+	unsigned int bios_pll;
+
+	bios_hdr = BIOS_IN16(0x48);
+	bios_pll = BIOS_IN16(bios_hdr + 0x30);
+	
+	par->constants.ppll_max = BIOS_IN32(bios_pll + 0x16);
+	par->constants.ppll_min = BIOS_IN32(bios_pll + 0x12);
+	par->constants.xclk = BIOS_IN16(bios_pll + 0x08);
+	par->constants.ref_divider = BIOS_IN16(bios_pll + 0x10);
+	par->constants.ref_clk = BIOS_IN16(bios_pll + 0x0e);
+
+	DBG("ppll_max %d ppll_min %d xclk %d ref_divider %d ref clock %d\n",
+			par->constants.ppll_max, par->constants.ppll_min,
+			par->constants.xclk, par->constants.ref_divider,
+			par->constants.ref_clk);
+
+}           
+
+#ifdef __i386__
+static void *  __devinit aty128_find_mem_vbios(struct aty128fb_par *par)
+{
+	/* I simplified this code as we used to miss the signatures in
+	 * a lot of case. It's now closer to XFree, we just don't check
+	 * for signatures at all... Something better will have to be done
+	 * if we end up having conflicts
+	 */
+        u32  segstart;
+        unsigned char *rom_base = NULL;
+                                                
+        for (segstart=0x000c0000; segstart<0x000f0000; segstart+=0x00001000) {
+                rom_base = (char *)ioremap(segstart, 0x10000);
+		if (rom_base == NULL)
+			return NULL;
+                if ((*rom_base == 0x55) && (((*(rom_base + 1)) & 0xff) == 0xaa))
+	                break;
+                iounmap(rom_base);
+		rom_base = NULL;
+        }
+	return rom_base;
+}
+#endif /* __i386__ */
+#endif /* ndef(__sparc__) */
+
+/* fill in known card constants if pll_block is not available */
+static void __init aty128_timings(struct aty128fb_par *par)
+{
+#ifdef CONFIG_PPC_OF
+	/* instead of a table lookup, assume OF has properly
+	 * setup the PLL registers and use their values
+	 * to set the XCLK values and reference divider values */
+
+	u32 x_mpll_ref_fb_div;
+	u32 xclk_cntl;
+	u32 Nx, M;
+	unsigned PostDivSet[] = { 0, 1, 2, 4, 8, 3, 6, 12 };
+#endif
+
+	if (!par->constants.ref_clk)
+		par->constants.ref_clk = 2950;
+
+#ifdef CONFIG_PPC_OF
+	x_mpll_ref_fb_div = aty_ld_pll(X_MPLL_REF_FB_DIV);
+	xclk_cntl = aty_ld_pll(XCLK_CNTL) & 0x7;
+	Nx = (x_mpll_ref_fb_div & 0x00ff00) >> 8;
+	M  = x_mpll_ref_fb_div & 0x0000ff;
+
+	par->constants.xclk = round_div((2 * Nx * par->constants.ref_clk),
+					(M * PostDivSet[xclk_cntl]));
+
+	par->constants.ref_divider =
+		aty_ld_pll(PPLL_REF_DIV) & PPLL_REF_DIV_MASK;
+#endif
+
+	if (!par->constants.ref_divider) {
+		par->constants.ref_divider = 0x3b;
+
+		aty_st_pll(X_MPLL_REF_FB_DIV, 0x004c4c1e);
+		aty_pll_writeupdate(par);
+	}
+	aty_st_pll(PPLL_REF_DIV, par->constants.ref_divider);
+	aty_pll_writeupdate(par);
+
+	/* from documentation */
+	if (!par->constants.ppll_min)
+		par->constants.ppll_min = 12500;
+	if (!par->constants.ppll_max)
+		par->constants.ppll_max = 25000;    /* 23000 on some cards? */
+	if (!par->constants.xclk)
+		par->constants.xclk = 0x1d4d;	     /* same as mclk */
+
+	par->constants.fifo_width = 128;
+	par->constants.fifo_depth = 32;
+
+	switch (aty_ld_le32(MEM_CNTL) & 0x3) {
+	case 0:
+		par->mem = &sdr_128;
+		break;
+	case 1:
+		par->mem = &sdr_sgram;
+		break;
+	case 2:
+		par->mem = &ddr_sgram;
+		break;
+	default:
+		par->mem = &sdr_sgram;
+	}
+}
+
+
 
 /*
-     * CRTC programming
-     */
+ * CRTC programming
+ */
 
 /* Program the CRTC registers */
-static void
-aty128_set_crtc(const struct aty128_crtc *crtc,
-		const struct aty128fb_par *par)
+static void aty128_set_crtc(const struct aty128_crtc *crtc,
+			    const struct aty128fb_par *par)
 {
 	aty_st_le32(CRTC_GEN_CNTL, crtc->gen_cntl);
 	aty_st_le32(CRTC_H_TOTAL_DISP, crtc->h_total);
@@ -752,10 +1037,9 @@
 }
 
 
-static int
-aty128_var_to_crtc(const struct fb_var_screeninfo *var,
-		   struct aty128_crtc *crtc,
-		   const struct aty128fb_par *par)
+static int aty128_var_to_crtc(const struct fb_var_screeninfo *var,
+			      struct aty128_crtc *crtc,
+			      const struct aty128fb_par *par)
 {
 	u32 xres, yres, vxres, vyres, xoffset, yoffset, bpp, dst;
 	u32 left, right, upper, lower, hslen, vslen, sync, vmode;
@@ -881,8 +1165,7 @@
 }
 
 
-static int
-aty128_pix_width_to_var(int pix_width, struct fb_var_screeninfo *var)
+static int aty128_pix_width_to_var(int pix_width, struct fb_var_screeninfo *var)
 {
 
 	/* fill in pixel info */
@@ -945,9 +1228,8 @@
 }
 
 
-static int
-aty128_crtc_to_var(const struct aty128_crtc *crtc,
-		   struct fb_var_screeninfo *var)
+static int aty128_crtc_to_var(const struct aty128_crtc *crtc,
+			      struct fb_var_screeninfo *var)
 {
 	u32 xres, yres, left, right, upper, lower, hslen, vslen, sync;
 	u32 h_total, h_disp, h_sync_strt, h_sync_dly, h_sync_wid, h_sync_pol;
@@ -1003,8 +1285,7 @@
 }
 
 #ifdef CONFIG_PMAC_PBOOK
-static void
-aty128_set_crt_enable(struct aty128fb_par *par, int on)
+static void aty128_set_crt_enable(struct aty128fb_par *par, int on)
 {
 	if (on) {
 		aty_st_le32(CRTC_EXT_CNTL, aty_ld_le32(CRTC_EXT_CNTL) | CRT_CRTC_ON);
@@ -1013,8 +1294,7 @@
 		aty_st_le32(CRTC_EXT_CNTL, aty_ld_le32(CRTC_EXT_CNTL) & ~CRT_CRTC_ON);
 }
 
-static void
-aty128_set_lcd_enable(struct aty128fb_par *par, int on)
+static void aty128_set_lcd_enable(struct aty128fb_par *par, int on)
 {
 	u32 reg;
 
@@ -1039,10 +1319,9 @@
 		aty_st_le32(LVDS_GEN_CNTL, reg);
 	}
 }
-#endif
+#endif /* CONFIG_PMAC_PBOOK */
 
-static void
-aty128_set_pll(struct aty128_pll *pll, const struct aty128fb_par *par)
+static void aty128_set_pll(struct aty128_pll *pll, const struct aty128fb_par *par)
 {
 	u32 div3;
 
@@ -1081,9 +1360,8 @@
 }
 
 
-static int
-aty128_var_to_pll(u32 period_in_ps, struct aty128_pll *pll,
-		  const struct aty128fb_par *par)
+static int aty128_var_to_pll(u32 period_in_ps, struct aty128_pll *pll,
+			     const struct aty128fb_par *par)
 {
 	const struct aty128_constants c = par->constants;
 	unsigned char post_dividers[] = {1,2,4,8,3,6,12};
@@ -1109,7 +1387,7 @@
 
 	/* calculate feedback divider */
 	n = c.ref_divider * output_freq;
-	d = c.dotclock;
+	d = c.ref_clk;
 
 	pll->post_divider = post_dividers[i];
 	pll->feedback_divider = round_div(n, d);
@@ -1124,8 +1402,7 @@
 }
 
 
-static int
-aty128_pll_to_var(const struct aty128_pll *pll, struct fb_var_screeninfo *var)
+static int aty128_pll_to_var(const struct aty128_pll *pll, struct fb_var_screeninfo *var)
 {
 	var->pixclock = 100000000 / pll->vclk;
 
@@ -1133,20 +1410,18 @@
 }
 
 
-static void
-aty128_set_fifo(const struct aty128_ddafifo *dsp,
-		const struct aty128fb_par *par)
+static void aty128_set_fifo(const struct aty128_ddafifo *dsp,
+			    const struct aty128fb_par *par)
 {
 	aty_st_le32(DDA_CONFIG, dsp->dda_config);
 	aty_st_le32(DDA_ON_OFF, dsp->dda_on_off);
 }
 
 
-static int
-aty128_ddafifo(struct aty128_ddafifo *dsp,
-	       const struct aty128_pll *pll,
-	       u32 depth,
-	       const struct aty128fb_par *par)
+static int aty128_ddafifo(struct aty128_ddafifo *dsp,
+			  const struct aty128_pll *pll,
+			  u32 depth,
+			  const struct aty128fb_par *par)
 {
 	const struct aty128_meminfo *m = par->mem;
 	u32 xclk = par->constants.xclk;
@@ -1203,8 +1478,7 @@
 /*
  * This actually sets the video mode.
  */
-static int
-aty128fb_set_par(struct fb_info *info)
+static int aty128fb_set_par(struct fb_info *info)
 { 
 	struct aty128fb_par *par = info->par;
 	u32 config;
@@ -1276,8 +1550,7 @@
  *  encode/decode the User Defined Part of the Display
  */
 
-static int
-aty128_decode_var(struct fb_var_screeninfo *var, struct aty128fb_par *par)
+static int aty128_decode_var(struct fb_var_screeninfo *var, struct aty128fb_par *par)
 {
 	int err;
 	struct aty128_crtc crtc;
@@ -1302,9 +1575,8 @@
 }
 
 
-static int
-aty128_encode_var(struct fb_var_screeninfo *var,
-		  const struct aty128fb_par *par)
+static int aty128_encode_var(struct fb_var_screeninfo *var,
+			     const struct aty128fb_par *par)
 {
 	int err;
 
@@ -1325,8 +1597,7 @@
 }           
 
 
-static int
-aty128fb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
+static int aty128fb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 {
 	struct aty128fb_par par;
 	int err;
@@ -1342,8 +1613,7 @@
 /*
  *  Pan or Wrap the Display
  */
-static int
-aty128fb_pan_display(struct fb_var_screeninfo *var, struct fb_info *fb) 
+static int aty128fb_pan_display(struct fb_var_screeninfo *var, struct fb_info *fb) 
 {
 	struct aty128fb_par *par = fb->par;
 	u32 xoffset, yoffset;
@@ -1376,9 +1646,8 @@
 /*
  *  Helper function to store a single palette register
  */
-static void
-aty128_st_pal(u_int regno, u_int red, u_int green, u_int blue,
-	      struct aty128fb_par *par)
+static void aty128_st_pal(u_int regno, u_int red, u_int green, u_int blue,
+			  struct aty128fb_par *par)
 {
 	if (par->chip_gen == rage_M3) {
 #if 0
@@ -1400,8 +1669,7 @@
 	aty_st_le32(PALETTE_DATA, (red<<16)|(green<<8)|blue);
 }
 
-static int
-aty128fb_sync(struct fb_info *info)
+static int aty128fb_sync(struct fb_info *info)
 {
 	struct aty128fb_par *par = info->par;
 
@@ -1410,8 +1678,7 @@
 	return 0;
 }
 
-int __init
-aty128fb_setup(char *options)
+int __init aty128fb_setup(char *options)
 {
 	char *this_opt;
 
@@ -1470,13 +1737,12 @@
  *  Initialisation
  */
 
-static int __init
-aty128_init(struct pci_dev *pdev, const struct pci_device_id *ent)
+static int __init aty128_init(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	struct fb_info *info = pci_get_drvdata(pdev);
 	struct aty128fb_par *par = info->par;
 	struct fb_var_screeninfo var;
-	char video_card[25];
+	char video_card[DEVICE_NAME_SIZE];
 	u8 chip_rev;
 	u32 dac;
 
@@ -1486,43 +1752,13 @@
 	/* Get the chip revision */
 	chip_rev = (aty_ld_le32(CONFIG_CNTL) >> 16) & 0x1F;
 
-	switch (pdev->device) {
-		case PCI_DEVICE_ID_ATI_RAGE128_RE:
-			strcpy(video_card, "Rage128 RE (PCI)");
-			break;
-		case PCI_DEVICE_ID_ATI_RAGE128_RF:
-			strcpy(video_card, "Rage128 RF (AGP)");
-			break;
-		case PCI_DEVICE_ID_ATI_RAGE128_RK:
-			strcpy(video_card, "Rage128 RK (PCI)");
-			break;
-		case PCI_DEVICE_ID_ATI_RAGE128_RL:
-			strcpy(video_card, "Rage128 RL (AGP)");
-			break;
-		case PCI_DEVICE_ID_ATI_Rage128_PD:
-			strcpy(video_card, "Rage128 Pro PD (PCI)");
-			break;
-		case PCI_DEVICE_ID_ATI_RAGE128_PF:
-			strcpy(video_card, "Rage128 Pro PF (AGP)");
-			break;
-		case PCI_DEVICE_ID_ATI_RAGE128_PR:
-			strcpy(video_card, "Rage128 Pro PR (PCI)");
-			break;
-		case PCI_DEVICE_ID_ATI_RAGE128_U3:
-			strcpy(video_card, "Rage128 Pro TR (AGP)");
-			break;
-		case PCI_DEVICE_ID_ATI_RAGE128_U1:
-			strcpy(video_card, "Rage128 Pro TF (AGP)");
-			break;
-		case PCI_DEVICE_ID_ATI_RAGE128_LE:
-			strcpy(video_card, "Rage Mobility M3 (PCI)");
-			break;
-		case PCI_DEVICE_ID_ATI_RAGE128_LF:
-			strcpy(video_card, "Rage Mobility M3 (AGP)");
-			break;
-		default:
-			return -ENODEV;
-	}
+	strcpy(video_card, "Rage128 XX ");
+	video_card[8] = ent->device >> 8;
+	video_card[9] = ent->device & 0xFF;
+	    
+	/* range check to make sure */
+	if (ent->driver_data < (sizeof(r128_family)/sizeof(char *)))
+	    strncat(video_card, r128_family[ent->driver_data], sizeof(video_card));
 
 	printk(KERN_INFO "aty128fb: %s [chip rev 0x%x] ", video_card, chip_rev);
 
@@ -1575,8 +1811,12 @@
 			if (machine_is_compatible("PowerBook3,2"))
 				default_vmode = VMODE_1152_768_60;
 	
-			if (default_cmode < CMODE_8 || default_cmode > CMODE_32)
-				default_cmode = CMODE_8;
+			if (default_cmode > 16) 
+			    default_cmode = CMODE_32;
+			else if (default_cmode > 8) 
+			    default_cmode = CMODE_16;
+			else 
+			    default_cmode = CMODE_8;
 
 			if (mac_vmode_to_var(default_vmode, default_cmode, &var))
 				var = default_var;
@@ -1584,9 +1824,10 @@
 	} else
 #endif /* CONFIG_PPC_PMAC */
 	{
-		if (fb_find_mode(&var, info, mode_option, NULL, 0,
-				 &defaultmode, 8) == 0)
-			var = default_var;
+		if (mode_option)
+			if (fb_find_mode(&var, info, mode_option, NULL, 
+					 0, &defaultmode, 8) == 0)
+				var = default_var;
 	}
 
 	var.accel_flags &= ~FB_ACCELF_TEXT;
@@ -1623,16 +1864,12 @@
 	if (par->chip_gen == rage_M3)
 		register_backlight_controller(&aty128_backlight_controller, par, "ati");
 #endif /* CONFIG_PMAC_BACKLIGHT */
-#ifdef CONFIG_PMAC_PBOOK
+
 	par->pm_reg = pci_find_capability(pdev, PCI_CAP_ID_PM);
-	if (aty128_fb == NULL) {
-		/* XXX can only put one chip to sleep */
-		aty128_fb = info;
-	} else
-		printk(KERN_WARNING "aty128fb: can only sleep one Rage 128\n");
 	par->pdev = pdev;
-#endif
-
+	par->asleep = 0;
+	par->lock_blank = 0;
+	
 	printk(KERN_INFO "fb%d: %s frame buffer device on %s\n",
 	       info->node, info->fix.id, video_card);
 
@@ -1641,14 +1878,13 @@
 
 #ifdef CONFIG_PCI
 /* register a card    ++ajoshi */
-static int __init
-aty128_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
+static int __init aty128_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	unsigned long fb_addr, reg_addr;
 	struct aty128fb_par *par;
 	struct fb_info *info;
-	int err, size;
-#if !defined(CONFIG_PPC) && !defined(__sparc__)
+	int err;
+#ifndef __sparc__
 	void *bios = NULL;
 #endif
 
@@ -1675,17 +1911,14 @@
 	}
 
 	/* We have the resources. Now virtualize them */
-	size = sizeof(struct fb_info) + sizeof(struct aty128fb_par);
-	if (!(info = kmalloc(size, GFP_ATOMIC))) {
+	info = framebuffer_alloc(sizeof(struct aty128fb_par), &pdev->dev);
+	if (info == NULL) {
 		printk(KERN_ERR "aty128fb: can't alloc fb_info_aty128\n");
 		goto err_free_mmio;
 	}
-	memset(info, 0, size);
+	par = info->par;
 
-	par = (struct aty128fb_par *)(info + 1);
 	info->pseudo_palette = par->pseudo_palette;
-
-	info->par = par;
 	info->fix = aty128fb_fix;
 
 	/* Virtualize mmio region */
@@ -1715,16 +1948,21 @@
 		goto err_out;
 	}
 
-#if !defined(CONFIG_PPC) && !defined(__sparc__)
-	if (!(bios = aty128_map_ROM(pdev)))
+#ifndef __sparc__
+	bios = aty128_map_ROM(par, pdev);
+#ifdef __i386__
+	if (bios == NULL)
+		bios = aty128_find_mem_vbios(par, pdev);
+#endif
+	if (bios == NULL)
 		printk(KERN_INFO "aty128fb: BIOS not located, guessing timings.\n");
 	else {
-		printk(KERN_INFO "aty128fb: Rage128 BIOS located at %lx\n",
-				pdev->resource[PCI_ROM_RESOURCE].start);
+		printk(KERN_INFO "aty128fb: Rage128 BIOS located\n");
 		aty128_get_pllinfo(par, bios);
 		aty128_unmap_ROM(pdev, bios);
 	}
-#endif
+#endif /* __sparc__ */
+
 	aty128_timings(par);
 	pci_set_drvdata(pdev, info);
 
@@ -1747,7 +1985,7 @@
 err_unmap_out:
 	iounmap(par->regbase);
 err_free_info:
-	kfree(info);
+	framebuffer_release(info);
 err_free_mmio:
 	release_mem_region(pci_resource_start(pdev, 2),
 			pci_resource_len(pdev, 2));
@@ -1780,170 +2018,23 @@
 			   pci_resource_len(pdev, 1));
 	release_mem_region(pci_resource_start(pdev, 2),
 			   pci_resource_len(pdev, 2));
-#ifdef CONFIG_PMAC_PBOOK
-	if (info == aty128_fb)
-		aty128_fb = NULL;
-#endif
-	kfree(info);
+	framebuffer_release(info);
 }
 #endif /* CONFIG_PCI */
 
-/* PPC and Sparc cannot read video ROM */
-#if !defined(CONFIG_PPC) && !defined(__sparc__)
-static void * __init aty128_map_ROM(struct pci_dev *dev)
-{
-	// If this is a primary card, there is a shadow copy of the
-	// ROM somewhere in the first meg. We will just ignore the copy
-	// and use the ROM directly.
-	
-	// no need to search for the ROM, just ask the card where it is.
-	struct resource *r = &dev->resource[PCI_ROM_RESOURCE];
-	unsigned char *addr;
-	
-	// assign the ROM an address if it doesn't have one
-	if (r->start == 0)
-		pci_assign_resource(dev, PCI_ROM_RESOURCE);
-	
-	// enable if needed
-	if (!(r->flags & PCI_ROM_ADDRESS_ENABLE))
-		pci_write_config_dword(dev, dev->rom_base_reg, r->start | PCI_ROM_ADDRESS_ENABLE);
-	
-	addr = ioremap(r->start, r->end - r->start + 1);
-	
-	// Very simple test to make sure it appeared
-	if (addr && (*addr != 0x55)) {
-		printk("aty128fb: Invalid ROM signature %x\n", *addr);
-		iounmap(addr);
-		return NULL;
-	}
-	return (void *)addr;
-}
-
-static void __init aty128_unmap_ROM(struct pci_dev *dev, void * rom)
-{
-	// leave it disabled and unassigned
-	struct resource *r = &dev->resource[PCI_ROM_RESOURCE];
-	
-	iounmap(rom);
-	
-	r->flags &= !PCI_ROM_ADDRESS_ENABLE;
-	r->end -= r->start;
-	r->start = 0;
-	pci_write_config_dword(dev, dev->rom_base_reg, 0);
-}
-
-static void __init
-aty128_get_pllinfo(struct aty128fb_par *par, void *bios)
-{
-	void *bios_header;
-	void *header_ptr;
-	u16 bios_header_offset, pll_info_offset;
-	PLL_BLOCK pll;
-
-	bios_header = (char *)bios + 0x48L;
-	header_ptr  = bios_header;
-
-	bios_header_offset = readw(header_ptr);
-	bios_header = (char *)bios + bios_header_offset;
-	bios_header += 0x30;
-
-	header_ptr = bios_header;
-	pll_info_offset = readw(header_ptr);
-	header_ptr = (char *)bios + pll_info_offset;
-
-	memcpy_fromio(&pll, header_ptr, 50);
-
-	par->constants.ppll_max = pll.PCLK_max_freq;
-	par->constants.ppll_min = pll.PCLK_min_freq;
-	par->constants.xclk = (u32)pll.XCLK;
-	par->constants.ref_divider = (u32)pll.PCLK_ref_divider;
-	par->constants.dotclock = (u32)pll.PCLK_ref_freq;
-
-	DBG("ppll_max %d ppll_min %d xclk %d ref_divider %d dotclock %d\n",
-			par->constants.ppll_max, par->constants.ppll_min,
-			par->constants.xclk, par->constants.ref_divider,
-			par->constants.dotclock);
-
-}           
-#endif /* !CONFIG_PPC */
-
-
-/* fill in known card constants if pll_block is not available */
-static void __init
-aty128_timings(struct aty128fb_par *par)
-{
-#ifdef CONFIG_PPC_OF
-	/* instead of a table lookup, assume OF has properly
-	 * setup the PLL registers and use their values
-	 * to set the XCLK values and reference divider values */
-
-	u32 x_mpll_ref_fb_div;
-	u32 xclk_cntl;
-	u32 Nx, M;
-	unsigned PostDivSet[] = { 0, 1, 2, 4, 8, 3, 6, 12 };
-#endif
-
-	if (!par->constants.dotclock)
-		par->constants.dotclock = 2950;
-
-#ifdef CONFIG_PPC_OF
-	x_mpll_ref_fb_div = aty_ld_pll(X_MPLL_REF_FB_DIV);
-	xclk_cntl = aty_ld_pll(XCLK_CNTL) & 0x7;
-	Nx = (x_mpll_ref_fb_div & 0x00ff00) >> 8;
-	M  = x_mpll_ref_fb_div & 0x0000ff;
-
-	par->constants.xclk = round_div((2 * Nx * par->constants.dotclock),
-					(M * PostDivSet[xclk_cntl]));
-
-	par->constants.ref_divider =
-		aty_ld_pll(PPLL_REF_DIV) & PPLL_REF_DIV_MASK;
-#endif
-
-	if (!par->constants.ref_divider) {
-		par->constants.ref_divider = 0x3b;
-
-		aty_st_pll(X_MPLL_REF_FB_DIV, 0x004c4c1e);
-		aty_pll_writeupdate(par);
-	}
-	aty_st_pll(PPLL_REF_DIV, par->constants.ref_divider);
-	aty_pll_writeupdate(par);
-
-	/* from documentation */
-	if (!par->constants.ppll_min)
-		par->constants.ppll_min = 12500;
-	if (!par->constants.ppll_max)
-		par->constants.ppll_max = 25000;    /* 23000 on some cards? */
-	if (!par->constants.xclk)
-		par->constants.xclk = 0x1d4d;	     /* same as mclk */
-
-	par->constants.fifo_width = 128;
-	par->constants.fifo_depth = 32;
-
-	switch (aty_ld_le32(MEM_CNTL) & 0x3) {
-	case 0:
-		par->mem = &sdr_128;
-		break;
-	case 1:
-		par->mem = &sdr_sgram;
-		break;
-	case 2:
-		par->mem = &ddr_sgram;
-		break;
-	default:
-		par->mem = &sdr_sgram;
-	}
-}
 
 
     /*
      *  Blank the display.
      */
-static int
-aty128fb_blank(int blank, struct fb_info *fb)
+static int aty128fb_blank(int blank, struct fb_info *fb)
 {
 	struct aty128fb_par *par = fb->par;
 	u8 state = 0;
 
+	if (par->lock_blank || par->asleep)
+		return 0;
+
 #ifdef CONFIG_PMAC_BACKLIGHT
 	if ((_machine == _MACH_Pmac) && blank)
 		set_backlight_enable(0);
@@ -1976,9 +2067,8 @@
  *  rounded down to the hardware's capabilities (according to the
  *  entries in the var structure). Return != 0 for invalid regno.
  */
-static int
-aty128fb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
-                         u_int transp, struct fb_info *info)
+static int aty128fb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
+			      u_int transp, struct fb_info *info)
 {
 	struct aty128fb_par *par = info->par;
 
@@ -2041,9 +2131,9 @@
 #define ATY_MIRROR_CRT_ON	0x00000002
 
 /* out param: u32*	backlight value: 0 to 15 */
-#define FBIO_ATY128_GET_MIRROR	_IOR('@', 1, __u32*)
+#define FBIO_ATY128_GET_MIRROR	_IOR('@', 1, __u32)
 /* in param: u32*	backlight value: 0 to 15 */
-#define FBIO_ATY128_SET_MIRROR	_IOW('@', 2, __u32*)
+#define FBIO_ATY128_SET_MIRROR	_IOW('@', 2, __u32)
 
 static int aty128fb_ioctl(struct inode *inode, struct file *file, u_int cmd,
 			  u_long arg, struct fb_info *info)
@@ -2091,8 +2181,7 @@
 /* That one prevents proper CRT output with LCD off */
 #undef BACKLIGHT_DAC_OFF
 
-static int
-aty128_set_backlight_enable(int on, int level, void *data)
+static int aty128_set_backlight_enable(int on, int level, void *data)
 {
 	struct aty128fb_par *par = data;
 	unsigned int reg = aty_ld_le32(LVDS_GEN_CNTL);
@@ -2139,8 +2228,7 @@
 	return 0;
 }
 
-static int
-aty128_set_backlight_level(int level, void* data)
+static int aty128_set_backlight_level(int level, void* data)
 {
 	return aty128_set_backlight_enable(1, level, data);
 }
@@ -2151,10 +2239,9 @@
      *  Accelerated functions
      */
 
-static inline void
-aty128_rectcopy(int srcx, int srcy, int dstx, int dsty,
-		u_int width, u_int height,
-		struct fb_info_aty128 *par)
+static inline void aty128_rectcopy(int srcx, int srcy, int dstx, int dsty,
+				   u_int width, u_int height,
+				   struct fb_info_aty128 *par)
 {
     u32 save_dp_datatype, save_dp_cntl, dstval;
 
@@ -2196,8 +2283,7 @@
      * Text mode accelerated functions
      */
 
-static void
-fbcon_aty128_bmove(struct display *p, int sy, int sx, int dy, int dx,
+static void fbcon_aty128_bmove(struct display *p, int sy, int sx, int dy, int dx,
 			int height, int width)
 {
     sx     *= fontwidth(p);
@@ -2212,9 +2298,7 @@
 }
 #endif /* 0 */
 
-#ifdef CONFIG_PMAC_PBOOK
-static void
-aty128_set_suspend(struct aty128fb_par *par, int suspend)
+static void aty128_set_suspend(struct aty128fb_par *par, int suspend)
 {
 	u32	pmgt;
 	u16	pwr_command;
@@ -2257,95 +2341,122 @@
 	}
 }
 
-/*
- * Save the contents of the frame buffer when we go to sleep,
- * and restore it when we wake up again.
- */
-int
-aty128_sleep_notify(struct pmu_sleep_notifier *self, int when)
+static int aty128_pci_suspend(struct pci_dev *pdev, u32 state)
 {
- 	int nb;
-	struct fb_info *info = aty128_fb;
-	struct aty128fb_par *par;
+	struct fb_info *info = pci_get_drvdata(pdev);
+	struct aty128fb_par *par = info->par;
 
-	if (info == NULL)
-		return PBOOK_SLEEP_OK;
-	par = info->par;
-	nb = info->var.yres * info->fix.line_length;
+	/* We don't do anything but D2, for now we return 0, but
+	 * we may want to change that. How do we know if the BIOS
+	 * can properly take care of D3 ? Also, with swsusp, we
+	 * know we'll be rebooted, ...
+	 */
+#ifdef CONFIG_PPC_PMAC
+	/* HACK ALERT ! Once I find a proper way to say to each driver
+	 * individually what will happen with it's PCI slot, I'll change
+	 * that. On laptops, the AGP slot is just unclocked, so D2 is
+	 * expected, while on desktops, the card is powered off
+	 */
+	if (state >= 3)
+		state = 2;
+#endif /* CONFIG_PPC_PMAC */
+	 
+	if (state != 2 || state == pdev->dev.power_state)
+		return 0;
 
-	switch (when) {
-	case PBOOK_SLEEP_REQUEST:
-		par->save_framebuffer = vmalloc(nb);
-		if (par->save_framebuffer == NULL)
-			return PBOOK_SLEEP_REFUSE;
-		break;
-	case PBOOK_SLEEP_REJECT:
-		if (par->save_framebuffer) {
-			vfree(par->save_framebuffer);
-			par->save_framebuffer = 0;
-		}
-		break;
-	case PBOOK_SLEEP_NOW:
-		wait_for_idle(par);
-		aty128_reset_engine(par);
-		wait_for_idle(par);
+	printk(KERN_DEBUG "aty128fb: suspending...\n");
+	
+	acquire_console_sem();
+
+	fb_set_suspend(info, 1);
+
+	/* Make sure engine is reset */
+	wait_for_idle(par);
+	aty128_reset_engine(par);
+	wait_for_idle(par);
+
+	/* Blank display and LCD */
+	aty128fb_blank(VESA_POWERDOWN, info);
 
-		/* Backup fb content */	
-		if (par->save_framebuffer)
-			memcpy_fromio(par->save_framebuffer,
-			       info->screen_base, nb);
-
-		/* Blank display and LCD */
-		aty128fb_blank(VESA_POWERDOWN, info);
-			
-		/* Sleep the chip */
+	/* Sleep */
+	par->asleep = 1;
+	par->lock_blank = 1;
+
+	/* We need a way to make sure the fbdev layer will _not_ touch the
+	 * framebuffer before we put the chip to suspend state. On 2.4, I
+	 * used dummy fb ops, 2.5 need proper support for this at the
+	 * fbdev level
+	 */
+	if (state == 2)
 		aty128_set_suspend(par, 1);
 
-		break;
-	case PBOOK_WAKE:
-		/* Wake the chip */
+	release_console_sem();
+
+	pdev->dev.power_state = state;
+
+	return 0;
+}
+
+static int aty128_pci_resume(struct pci_dev *pdev)
+{
+	struct fb_info *info = pci_get_drvdata(pdev);
+	struct aty128fb_par *par = info->par;
+
+	if (pdev->dev.power_state == 0)
+		return 0;
+
+	acquire_console_sem();
+
+	/* Wakeup chip */
+	if (pdev->dev.power_state == 2)
 		aty128_set_suspend(par, 0);
-		
-		aty128_reset_engine(par);
-		wait_for_idle(par);
+	par->asleep = 0;
 
-		/* Restore fb content */			
-		if (par->save_framebuffer) {
-			memcpy_toio(info->screen_base,
-			       par->save_framebuffer, nb);
-			vfree(par->save_framebuffer);
-			par->save_framebuffer = 0;
-		}
-		aty128fb_blank(0, info);
-		break;
-	}
-	return PBOOK_SLEEP_OK;
+	/* Restore display & engine */
+	aty128_reset_engine(par);
+	wait_for_idle(par);
+	aty128fb_set_par(info);
+	fb_pan_display(info, &info->var);
+	fb_set_cmap(&info->cmap, 1, info);
+
+	/* Refresh */
+	fb_set_suspend(info, 0);
+
+	/* Unblank */
+	par->lock_blank = 0;
+	aty128fb_blank(0, info);
+
+	release_console_sem();
+
+	pdev->dev.power_state = 0;
+
+	printk(KERN_DEBUG "aty128fb: resumed !\n");
+
+	return 0;
 }
-#endif /* CONFIG_PMAC_PBOOK */
 
 int __init aty128fb_init(void)
 {
-#ifdef CONFIG_PMAC_PBOOK
-	pmu_register_sleep_notifier(&aty128_sleep_notifier);
-#endif
 	return pci_module_init(&aty128fb_driver);
 }
 
 static void __exit aty128fb_exit(void)
 {
-#ifdef CONFIG_PMAC_PBOOK
-	pmu_unregister_sleep_notifier(&aty128_sleep_notifier);
-#endif
 	pci_unregister_driver(&aty128fb_driver);
 }
 
+#ifdef MODULE
+module_init(aty128fb_init);
+module_exit(aty128fb_exit);
+
 MODULE_AUTHOR("(c)1999-2003 Brad Douglas <brad@neruo.com>");
 MODULE_DESCRIPTION("FBDev driver for ATI Rage128 / Pro cards");
 MODULE_LICENSE("GPL");
-MODULE_PARM(mode, "s");
+module_param(mode_option, charp, 0);
 MODULE_PARM_DESC(mode, "Specify resolution as \"<xres>x<yres>[-<bpp>][@<refresh>]\" ");
 #ifdef CONFIG_MTRR
-MODULE_PARM(nomtrr, "i");
-MODULE_PARM_DESC(nomtrr, "Disable MTRR support (0 or 1=disabled) (default=0)");
+module_param_named(nomtrr, mtrr, invbool, 0);
+MODULE_PARM_DESC(mtrr, "bool: Disable MTRR support (0 or 1=disabled) (default=0)");
+#endif
 #endif
 
diff -Nru a/include/linux/pci_ids.h b/include/linux/pci_ids.h
--- a/include/linux/pci_ids.h	Sun Feb 15 18:03:31 2004
+++ b/include/linux/pci_ids.h	Sun Feb 15 18:03:31 2004
@@ -216,28 +216,37 @@
 /* Rage128 GL */
 #define PCI_DEVICE_ID_ATI_RAGE128_RE	0x5245
 #define PCI_DEVICE_ID_ATI_RAGE128_RF	0x5246
-#define PCI_DEVICE_ID_ATI_RAGE128_RG	0x534b
-#define PCI_DEVICE_ID_ATI_RAGE128_RH	0x534c
-#define PCI_DEVICE_ID_ATI_RAGE128_RI	0x534d
+#define PCI_DEVICE_ID_ATI_RAGE128_RG	0x5247
 /* Rage128 VR */
 #define PCI_DEVICE_ID_ATI_RAGE128_RK	0x524b
 #define PCI_DEVICE_ID_ATI_RAGE128_RL	0x524c
-#define PCI_DEVICE_ID_ATI_RAGE128_RM	0x5345
-#define PCI_DEVICE_ID_ATI_RAGE128_RN	0x5346
-#define PCI_DEVICE_ID_ATI_RAGE128_RO	0x5347
+#define PCI_DEVICE_ID_ATI_RAGE128_SE	0x5345
+#define PCI_DEVICE_ID_ATI_RAGE128_SF	0x5346
+#define PCI_DEVICE_ID_ATI_RAGE128_SG	0x5347
+#define PCI_DEVICE_ID_ATI_RAGE128_SH	0x5348
+#define PCI_DEVICE_ID_ATI_RAGE128_SK	0x534b
+#define PCI_DEVICE_ID_ATI_RAGE128_SL	0x534c
+#define PCI_DEVICE_ID_ATI_RAGE128_SM	0x534d
+#define PCI_DEVICE_ID_ATI_RAGE128_SN	0x534e
+/* Rage128 Ultra */
+#define PCI_DEVICE_ID_ATI_RAGE128_TF	0x5446
+#define PCI_DEVICE_ID_ATI_RAGE128_TL	0x544c
+#define PCI_DEVICE_ID_ATI_RAGE128_TR	0x5452
+#define PCI_DEVICE_ID_ATI_RAGE128_TS	0x5453
+#define PCI_DEVICE_ID_ATI_RAGE128_TT	0x5454
+#define PCI_DEVICE_ID_ATI_RAGE128_TU	0x5455
 /* Rage128 M3 */
 #define PCI_DEVICE_ID_ATI_RAGE128_LE	0x4c45
 #define PCI_DEVICE_ID_ATI_RAGE128_LF	0x4c46
-/* Rage128 Pro Ultra */
-#define PCI_DEVICE_ID_ATI_RAGE128_U1	0x5446
-#define PCI_DEVICE_ID_ATI_RAGE128_U2	0x544C
-#define PCI_DEVICE_ID_ATI_RAGE128_U3	0x5452
+/* Rage128 M4 */
+#define PCI_DEVICE_ID_ATI_RAGE128_MF    0x4d46
+#define PCI_DEVICE_ID_ATI_RAGE128_ML    0x4d4c
 /* Rage128 Pro GL */
-#define PCI_DEVICE_ID_ATI_Rage128_PA	0x5041
-#define PCI_DEVICE_ID_ATI_Rage128_PB	0x5042
-#define PCI_DEVICE_ID_ATI_Rage128_PC	0x5043
-#define PCI_DEVICE_ID_ATI_Rage128_PD	0x5044
-#define PCI_DEVICE_ID_ATI_Rage128_PE	0x5045
+#define PCI_DEVICE_ID_ATI_RAGE128_PA	0x5041
+#define PCI_DEVICE_ID_ATI_RAGE128_PB	0x5042
+#define PCI_DEVICE_ID_ATI_RAGE128_PC	0x5043
+#define PCI_DEVICE_ID_ATI_RAGE128_PD	0x5044
+#define PCI_DEVICE_ID_ATI_RAGE128_PE	0x5045
 #define PCI_DEVICE_ID_ATI_RAGE128_PF	0x5046
 /* Rage128 Pro VR */
 #define PCI_DEVICE_ID_ATI_RAGE128_PG	0x5047
diff -Nru a/include/video/aty128.h b/include/video/aty128.h
--- a/include/video/aty128.h	Sun Feb 15 18:03:31 2004
+++ b/include/video/aty128.h	Sun Feb 15 18:03:31 2004
@@ -415,5 +415,8 @@
 #define PWR_MGT_SLOWDOWN_MCLK			0x00002000
 
 #define PMI_PMSCR_REG				0x60
+                                                                                
+/* used by ATI bug fix for hardware ROM */
+#define RAGE128_MPP_TB_CONFIG                   0x01c0
 
 #endif				/* REG_RAGE128_H */


