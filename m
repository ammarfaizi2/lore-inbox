Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261816AbVF0Erj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261816AbVF0Erj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 00:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261803AbVF0Eri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 00:47:38 -0400
Received: from gate.crashing.org ([63.228.1.57]:43908 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261816AbVF0EoR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 00:44:17 -0400
Subject: [PATCH] ppc32: Remove CONFIG_PMAC_PBOOK
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Mon, 27 Jun 2005 14:39:16 +1000
Message-Id: <1119847159.5133.106.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

This patch removes CONFIG_PMAC_PBOOK (PowerBook support). This is now
split into CONFIG_PMAC_MEDIABAY for the actual hotswap bay that some
powerbooks have, CONFIG_PM for power management related code, and just
left out of any CONFIG_* option for some generally useful stuff that can
be used on non-laptops as well.

It applies on top of my two previous patches removing macserial and
fixing the PMU irq priority.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/drivers/video/aty/aty128fb.c
===================================================================
--- linux-work.orig/drivers/video/aty/aty128fb.c	2005-06-27 14:19:11.000000000 +1000
+++ linux-work/drivers/video/aty/aty128fb.c	2005-06-27 14:19:31.000000000 +1000
@@ -350,10 +350,8 @@
 static int default_cmode __initdata = CMODE_8;
 #endif
 
-#ifdef CONFIG_PMAC_PBOOK
 static int default_crt_on __initdata = 0;
 static int default_lcd_on __initdata = 1;
-#endif
 
 #ifdef CONFIG_MTRR
 static int mtrr = 1;
@@ -1249,7 +1247,6 @@
 	return 0;
 }
 
-#ifdef CONFIG_PMAC_PBOOK
 static void aty128_set_crt_enable(struct aty128fb_par *par, int on)
 {
 	if (on) {
@@ -1284,7 +1281,6 @@
 		aty_st_le32(LVDS_GEN_CNTL, reg);
 	}
 }
-#endif /* CONFIG_PMAC_PBOOK */
 
 static void aty128_set_pll(struct aty128_pll *pll, const struct aty128fb_par *par)
 {
@@ -1491,12 +1487,10 @@
 	info->fix.visual = par->crtc.bpp == 8 ? FB_VISUAL_PSEUDOCOLOR
 		: FB_VISUAL_DIRECTCOLOR;
 
-#ifdef CONFIG_PMAC_PBOOK
 	if (par->chip_gen == rage_M3) {
 		aty128_set_crt_enable(par, par->crt_on);
 		aty128_set_lcd_enable(par, par->lcd_on);
 	}
-#endif
 	if (par->accel_flags & FB_ACCELF_TEXT)
 		aty128_init_engine(par);
 
@@ -1652,7 +1646,6 @@
 		return 0;
 
 	while ((this_opt = strsep(&options, ",")) != NULL) {
-#ifdef CONFIG_PMAC_PBOOK
 		if (!strncmp(this_opt, "lcd:", 4)) {
 			default_lcd_on = simple_strtoul(this_opt+4, NULL, 0);
 			continue;
@@ -1660,7 +1653,6 @@
 			default_crt_on = simple_strtoul(this_opt+4, NULL, 0);
 			continue;
 		}
-#endif
 #ifdef CONFIG_MTRR
 		if(!strncmp(this_opt, "nomtrr", 6)) {
 			mtrr = 0;
@@ -1752,10 +1744,8 @@
 	info->fbops = &aty128fb_ops;
 	info->flags = FBINFO_FLAG_DEFAULT;
 
-#ifdef CONFIG_PMAC_PBOOK
 	par->lcd_on = default_lcd_on;
 	par->crt_on = default_crt_on;
-#endif
 
 	var = default_var;
 #ifdef CONFIG_PPC_PMAC
@@ -2035,12 +2025,10 @@
 
 	aty_st_8(CRTC_EXT_CNTL+1, state);
 
-#ifdef CONFIG_PMAC_PBOOK
 	if (par->chip_gen == rage_M3) {
 		aty128_set_crt_enable(par, par->crt_on && !blank);
 		aty128_set_lcd_enable(par, par->lcd_on && !blank);
 	}
-#endif	
 #ifdef CONFIG_PMAC_BACKLIGHT
 	if ((_machine == _MACH_Pmac) && !blank)
 		set_backlight_enable(1);
@@ -2124,7 +2112,6 @@
 static int aty128fb_ioctl(struct inode *inode, struct file *file, u_int cmd,
 			  u_long arg, struct fb_info *info)
 {
-#ifdef CONFIG_PMAC_PBOOK
 	struct aty128fb_par *par = info->par;
 	u32 value;
 	int rc;
@@ -2149,7 +2136,6 @@
 		value = (par->crt_on << 1) | par->lcd_on;
 		return put_user(value, (__u32 __user *)arg);
 	}
-#endif
 	return -EINVAL;
 }
 
Index: linux-work/drivers/macintosh/Kconfig
===================================================================
--- linux-work.orig/drivers/macintosh/Kconfig	2005-06-27 14:19:11.000000000 +1000
+++ linux-work/drivers/macintosh/Kconfig	2005-06-27 14:19:31.000000000 +1000
@@ -86,33 +86,18 @@
 	  on the "SMU" system control chip which replaces the old PMU.
 	  If you don't know, say Y.
 
-config PMAC_PBOOK
-	bool "Power management support for PowerBooks"
-	depends on ADB_PMU
-	---help---
-	  This provides support for putting a PowerBook to sleep; it also
-	  enables media bay support.  Power management works on the
-	  PB2400/3400/3500, Wallstreet, Lombard, and Bronze PowerBook G3 and
-	  the Titanium Powerbook G4, as well as the iBooks.  You should get
-	  the power management daemon, pmud, to make it work and you must have
-	  the /dev/pmu device (see the pmud README).
-
-	  Get pmud from <ftp://ftp.samba.org/pub/ppclinux/pmud/>.
-
-	  If you have a PowerBook, you should say Y here.
-
-	  You may also want to compile the dma sound driver as a module and
-	  have it autoloaded. The act of removing the module shuts down the
-	  sound hardware for more power savings.
-
-config PM
-	bool
-	depends on PPC_PMAC && ADB_PMU && PMAC_PBOOK
-	default y
-
 config PMAC_APM_EMU
 	tristate "APM emulation"
-	depends on PMAC_PBOOK
+	depends on PPC_PMAC && PPC32 && PM
+
+config PMAC_MEDIABAY
+	bool "Support PowerBook hotswap media bay"
+	depends on PPC_PMAC && PPC32
+	help
+	  This option adds support for older PowerBook's hotswap media bay
+	  that can contains batteries, floppy drives, or IDE devices. PCI
+	  devices are not fully supported in the bay as I never had one to
+	  try with
 
 # made a separate option since backlight may end up beeing used
 # on non-powerbook machines (but only on PMU based ones AFAIK)
Index: linux-work/drivers/macintosh/adb.c
===================================================================
--- linux-work.orig/drivers/macintosh/adb.c	2005-06-27 14:19:11.000000000 +1000
+++ linux-work/drivers/macintosh/adb.c	2005-06-27 14:19:31.000000000 +1000
@@ -90,7 +90,7 @@
 static int autopoll_devs;
 int __adb_probe_sync;
 
-#ifdef CONFIG_PMAC_PBOOK
+#ifdef CONFIG_PM
 static int adb_notify_sleep(struct pmu_sleep_notifier *self, int when);
 static struct pmu_sleep_notifier adb_sleep_notifier = {
 	adb_notify_sleep,
@@ -320,9 +320,9 @@
 		printk(KERN_WARNING "Warning: no ADB interface detected\n");
 		adb_controller = NULL;
 	} else {
-#ifdef CONFIG_PMAC_PBOOK
+#ifdef CONFIG_PM
 		pmu_register_sleep_notifier(&adb_sleep_notifier);
-#endif /* CONFIG_PMAC_PBOOK */
+#endif /* CONFIG_PM */
 #ifdef CONFIG_PPC
 		if (machine_is_compatible("AAPL,PowerBook1998") ||
 			machine_is_compatible("PowerBook1,1"))
@@ -337,7 +337,7 @@
 
 __initcall(adb_init);
 
-#ifdef CONFIG_PMAC_PBOOK
+#ifdef CONFIG_PM
 /*
  * notify clients before sleep and reset bus afterwards
  */
@@ -378,7 +378,7 @@
 	}
 	return PBOOK_SLEEP_OK;
 }
-#endif /* CONFIG_PMAC_PBOOK */
+#endif /* CONFIG_PM */
 
 static int
 do_adb_reset_bus(void)
Index: linux-work/arch/ppc/platforms/pmac_sleep.S
===================================================================
--- linux-work.orig/arch/ppc/platforms/pmac_sleep.S	2005-06-27 14:19:11.000000000 +1000
+++ linux-work/arch/ppc/platforms/pmac_sleep.S	2005-06-27 14:19:31.000000000 +1000
@@ -46,7 +46,7 @@
 	.section .text
 	.align	5
 
-#if defined(CONFIG_PMAC_PBOOK) || defined(CONFIG_CPU_FREQ_PMAC)
+#if defined(CONFIG_PM) || defined(CONFIG_CPU_FREQ_PMAC)
 
 /* This gets called by via-pmu.c late during the sleep process.
  * The PMU was already send the sleep command and will shut us down
@@ -382,7 +382,7 @@
 	isync
 	rfi
 
-#endif /* defined(CONFIG_PMAC_PBOOK) || defined(CONFIG_CPU_FREQ) */
+#endif /* defined(CONFIG_PM) || defined(CONFIG_CPU_FREQ) */
 
 	.section .data
 	.balign	L1_CACHE_LINE_SIZE
Index: linux-work/arch/ppc/platforms/pmac_time.c
===================================================================
--- linux-work.orig/arch/ppc/platforms/pmac_time.c	2005-06-27 14:19:11.000000000 +1000
+++ linux-work/arch/ppc/platforms/pmac_time.c	2005-06-27 14:19:31.000000000 +1000
@@ -206,7 +206,7 @@
 	return 1;
 }
 
-#ifdef CONFIG_PMAC_PBOOK
+#ifdef CONFIG_PM
 /*
  * Reset the time after a sleep.
  */
@@ -238,7 +238,7 @@
 static struct pmu_sleep_notifier time_sleep_notifier __pmacdata = {
 	time_sleep_notify, SLEEP_LEVEL_MISC,
 };
-#endif /* CONFIG_PMAC_PBOOK */
+#endif /* CONFIG_PM */
 
 /*
  * Query the OF and get the decr frequency.
@@ -251,9 +251,9 @@
 	struct device_node *cpu;
 	unsigned int freq, *fp;
 
-#ifdef CONFIG_PMAC_PBOOK
+#ifdef CONFIG_PM
 	pmu_register_sleep_notifier(&time_sleep_notifier);
-#endif /* CONFIG_PMAC_PBOOK */
+#endif /* CONFIG_PM */
 
 	/* We assume MacRISC2 machines have correct device-tree
 	 * calibration. That's better since the VIA itself seems
Index: linux-work/drivers/block/swim3.c
===================================================================
--- linux-work.orig/drivers/block/swim3.c	2005-06-27 14:19:11.000000000 +1000
+++ linux-work/drivers/block/swim3.c	2005-06-27 14:19:31.000000000 +1000
@@ -253,7 +253,7 @@
 static int swim3_add_device(struct device_node *swims);
 int swim3_init(void);
 
-#ifndef CONFIG_PMAC_PBOOK
+#ifndef CONFIG_PMAC_MEDIABAY
 #define check_media_bay(which, what)	1
 #endif
 
@@ -297,9 +297,11 @@
 	int i;
 	for(i=0;i<floppy_count;i++)
 	{
+#ifdef CONFIG_PMAC_MEDIABAY
 		if (floppy_states[i].media_bay &&
 			check_media_bay(floppy_states[i].media_bay, MB_FD))
 			continue;
+#endif /* CONFIG_PMAC_MEDIABAY */
 		start_request(&floppy_states[i]);
 	}
 	sti();
@@ -856,8 +858,10 @@
 	if ((cmd & 0x80) && !capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
+#ifdef CONFIG_PMAC_MEDIABAY
 	if (fs->media_bay && check_media_bay(fs->media_bay, MB_FD))
 		return -ENXIO;
+#endif
 
 	switch (cmd) {
 	case FDEJECT:
@@ -881,8 +885,10 @@
 	int n, err = 0;
 
 	if (fs->ref_count == 0) {
+#ifdef CONFIG_PMAC_MEDIABAY
 		if (fs->media_bay && check_media_bay(fs->media_bay, MB_FD))
 			return -ENXIO;
+#endif
 		out_8(&sw->setup, S_IBM_DRIVE | S_FCLK_DIV2);
 		out_8(&sw->control_bic, 0xff);
 		out_8(&sw->mode, 0x95);
@@ -967,8 +973,10 @@
 	struct swim3 __iomem *sw;
 	int ret, n;
 
+#ifdef CONFIG_PMAC_MEDIABAY
 	if (fs->media_bay && check_media_bay(fs->media_bay, MB_FD))
 		return -ENXIO;
+#endif
 
 	sw = fs->swim3;
 	grab_drive(fs, revalidating, 0);
Index: linux-work/drivers/char/misc.c
===================================================================
--- linux-work.orig/drivers/char/misc.c	2005-06-27 14:19:11.000000000 +1000
+++ linux-work/drivers/char/misc.c	2005-06-27 14:19:31.000000000 +1000
@@ -309,9 +309,6 @@
 #ifdef CONFIG_BVME6000
 	rtc_DP8570A_init();
 #endif
-#ifdef CONFIG_PMAC_PBOOK
-	pmu_device_init();
-#endif
 	if (register_chrdev(MISC_MAJOR,"misc",&misc_fops)) {
 		printk("unable to get major %d for misc devices\n",
 		       MISC_MAJOR);
Index: linux-work/drivers/ide/ppc/pmac.c
===================================================================
--- linux-work.orig/drivers/ide/ppc/pmac.c	2005-06-27 14:19:11.000000000 +1000
+++ linux-work/drivers/ide/ppc/pmac.c	2005-06-27 14:19:31.000000000 +1000
@@ -1324,9 +1324,9 @@
 	/* XXX FIXME: Media bay stuff need re-organizing */
 	if (np->parent && np->parent->name
 	    && strcasecmp(np->parent->name, "media-bay") == 0) {
-#ifdef CONFIG_PMAC_PBOOK
+#ifdef CONFIG_PMAC_MEDIABAY
 		media_bay_set_ide_infos(np->parent, pmif->regbase, pmif->irq, hwif->index);
-#endif /* CONFIG_PMAC_PBOOK */
+#endif /* CONFIG_PMAC_MEDIABAY */
 		pmif->mediabay = 1;
 		if (!bidp)
 			pmif->aapl_bus_id = 1;
@@ -1382,10 +1382,10 @@
 	       hwif->index, model_name[pmif->kind], pmif->aapl_bus_id,
 	       pmif->mediabay ? " (mediabay)" : "", hwif->irq);
 			
-#ifdef CONFIG_PMAC_PBOOK
+#ifdef CONFIG_PMAC_MEDIABAY
 	if (pmif->mediabay && check_media_bay_by_base(pmif->regbase, MB_CD) == 0)
 		hwif->noprobe = 0;
-#endif /* CONFIG_PMAC_PBOOK */
+#endif /* CONFIG_PMAC_MEDIABAY */
 
 	hwif->sg_max_nents = MAX_DCMDS;
 
Index: linux-work/drivers/ieee1394/ohci1394.c
===================================================================
--- linux-work.orig/drivers/ieee1394/ohci1394.c	2005-06-27 14:19:11.000000000 +1000
+++ linux-work/drivers/ieee1394/ohci1394.c	2005-06-27 14:19:31.000000000 +1000
@@ -3538,8 +3538,8 @@
 
 static int ohci1394_pci_resume (struct pci_dev *pdev)
 {
-#ifdef CONFIG_PMAC_PBOOK
-	{
+#ifdef CONFIG_PPC_PMAC
+	if (_machine == _MACH_Pmac) {
 		struct device_node *of_node;
 
 		/* Re-enable 1394 */
@@ -3547,7 +3547,7 @@
 		if (of_node)
 			pmac_call_feature (PMAC_FTR_1394_ENABLE, of_node, 0, 1);
 	}
-#endif
+#endif /* CONFIG_PPC_PMAC */
 
 	pci_enable_device(pdev);
 
@@ -3557,8 +3557,8 @@
 
 static int ohci1394_pci_suspend (struct pci_dev *pdev, pm_message_t state)
 {
-#ifdef CONFIG_PMAC_PBOOK
-	{
+#ifdef CONFIG_PPC_PMAC
+	if (_machine == _MACH_Pmac) {
 		struct device_node *of_node;
 
 		/* Disable 1394 */
Index: linux-work/drivers/macintosh/Makefile
===================================================================
--- linux-work.orig/drivers/macintosh/Makefile	2005-06-27 14:19:11.000000000 +1000
+++ linux-work/drivers/macintosh/Makefile	2005-06-27 14:19:31.000000000 +1000
@@ -6,7 +6,7 @@
 
 obj-$(CONFIG_PPC_PMAC)		+= macio_asic.o
 
-obj-$(CONFIG_PMAC_PBOOK)	+= mediabay.o
+obj-$(CONFIG_PMAC_MEDIABAY)	+= mediabay.o
 obj-$(CONFIG_MAC_EMUMOUSEBTN)	+= mac_hid.o
 obj-$(CONFIG_INPUT_ADBHID)	+= adbhid.o
 obj-$(CONFIG_ANSLCD)		+= ans-lcd.o
Index: linux-work/drivers/usb/host/ohci-pci.c
===================================================================
--- linux-work.orig/drivers/usb/host/ohci-pci.c	2005-06-27 14:19:11.000000000 +1000
+++ linux-work/drivers/usb/host/ohci-pci.c	2005-06-27 14:19:31.000000000 +1000
@@ -14,14 +14,11 @@
  * This file is licenced under the GPL.
  */
  
-#ifdef CONFIG_PMAC_PBOOK
+#ifdef CONFIG_PPC_PMAC
 #include <asm/machdep.h>
 #include <asm/pmac_feature.h>
 #include <asm/pci-bridge.h>
 #include <asm/prom.h>
-#ifndef CONFIG_PM
-#	define CONFIG_PM
-#endif
 #endif
 
 #ifndef CONFIG_PCI
@@ -132,7 +129,7 @@
 	/* let things settle down a bit */
 	msleep (100);
 	
-#ifdef CONFIG_PMAC_PBOOK
+#ifdef CONFIG_PPC_PMAC
 	if (_machine == _MACH_Pmac) {
 	   	struct device_node	*of_node;
  
@@ -141,7 +138,7 @@
 		if (of_node)
 			pmac_call_feature(PMAC_FTR_USB_ENABLE, of_node, 0, 0);
 	}
-#endif /* CONFIG_PMAC_PBOOK */
+#endif /* CONFIG_PPC_PMAC */
 	return 0;
 }
 
@@ -151,7 +148,7 @@
 	struct ohci_hcd		*ohci = hcd_to_ohci (hcd);
 	int			retval = 0;
 
-#ifdef CONFIG_PMAC_PBOOK
+#ifdef CONFIG_PPC_PMAC
 	if (_machine == _MACH_Pmac) {
 		struct device_node *of_node;
 
@@ -160,7 +157,7 @@
 		if (of_node)
 			pmac_call_feature (PMAC_FTR_USB_ENABLE, of_node, 0, 1);
 	}
-#endif /* CONFIG_PMAC_PBOOK */
+#endif /* CONFIG_PPC_PMAC */
 
 	/* resume root hub */
 	if (time_before (jiffies, ohci->next_statechange))
Index: linux-work/drivers/video/chipsfb.c
===================================================================
--- linux-work.orig/drivers/video/chipsfb.c	2005-06-27 14:19:11.000000000 +1000
+++ linux-work/drivers/video/chipsfb.c	2005-06-27 14:19:31.000000000 +1000
@@ -28,22 +28,17 @@
 #include <linux/fb.h>
 #include <linux/init.h>
 #include <linux/pci.h>
+#include <linux/console.h>
 #include <asm/io.h>
 
 #ifdef CONFIG_PMAC_BACKLIGHT
 #include <asm/backlight.h>
 #endif
-#ifdef CONFIG_PMAC_PBOOK
-#include <linux/adb.h>
-#include <linux/pmu.h>
-#endif
 
 /*
  * Since we access the display with inb/outb to fixed port numbers,
  * we can only handle one 6555x chip.  -- paulus
  */
-static struct fb_info chipsfb_info;
-
 #define write_ind(num, val, ap, dp)	do { \
 	outb((num), (ap)); outb((val), (dp)); \
 } while (0)
@@ -74,14 +69,6 @@
 	inb(0x3da); read_ind(num, var, 0x3c0, 0x3c1); \
 } while (0)
 
-#ifdef CONFIG_PMAC_PBOOK
-static unsigned char *save_framebuffer;
-int chips_sleep_notify(struct pmu_sleep_notifier *self, int when);
-static struct pmu_sleep_notifier chips_sleep_notifier = {
-	chips_sleep_notify, SLEEP_LEVEL_VIDEO,
-};
-#endif
-
 /*
  * Exported functions
  */
@@ -356,6 +343,8 @@
 
 static void __init init_chips(struct fb_info *p, unsigned long addr)
 {
+	memset(p->screen_base, 0, 0x100000);
+
 	p->fix = chipsfb_fix;
 	p->fix.smem_start = addr;
 
@@ -366,34 +355,41 @@
 
 	fb_alloc_cmap(&p->cmap, 256, 0);
 
-	if (register_framebuffer(p) < 0) {
-		printk(KERN_ERR "C&T 65550 framebuffer failed to register\n");
-		return;
-	}
-
-	printk(KERN_INFO "fb%d: Chips 65550 frame buffer (%dK RAM detected)\n",
-		p->node, p->fix.smem_len / 1024);
-
 	chips_hw_init();
 }
 
 static int __devinit
 chipsfb_pci_init(struct pci_dev *dp, const struct pci_device_id *ent)
 {
-	struct fb_info *p = &chipsfb_info;
+	struct fb_info *p;
 	unsigned long addr, size;
 	unsigned short cmd;
+	int rc = -ENODEV;
+
+	if (pci_enable_device(dp) < 0) {
+		dev_err(&dp->dev, "Cannot enable PCI device\n");
+		goto err_out;
+	}
 
 	if ((dp->resource[0].flags & IORESOURCE_MEM) == 0)
-		return -ENODEV;
+		goto err_disable;
 	addr = pci_resource_start(dp, 0);
 	size = pci_resource_len(dp, 0);
 	if (addr == 0)
-		return -ENODEV;
-	if (p->screen_base != 0)
-		return -EBUSY;
-	if (!request_mem_region(addr, size, "chipsfb"))
-		return -EBUSY;
+		goto err_disable;
+
+	p = framebuffer_alloc(0, &dp->dev);
+	if (p == NULL) {
+		dev_err(&dp->dev, "Cannot allocate framebuffer structure\n");
+		rc = -ENOMEM;
+		goto err_disable;
+	}
+
+	if (pci_request_region(dp, 0, "chipsfb") != 0) {
+		dev_err(&dp->dev, "Cannot request framebuffer\n");
+		rc = -EBUSY;
+		goto err_release_fb;
+	}
 
 #ifdef __BIG_ENDIAN
 	addr += 0x800000;	// Use big-endian aperture
@@ -411,38 +407,90 @@
 	set_backlight_enable(1);
 #endif /* CONFIG_PMAC_BACKLIGHT */
 
+#ifdef CONFIG_PPC
 	p->screen_base = __ioremap(addr, 0x200000, _PAGE_NO_CACHE);
+#else
+	p->screen_base = ioremap(addr, 0x200000);
+#endif
 	if (p->screen_base == NULL) {
-		release_mem_region(addr, size);
-		return -ENOMEM;
+		dev_err(&dp->dev, "Cannot map framebuffer\n");
+		rc = -ENOMEM;
+		goto err_release_pci;
 	}
+
+	pci_set_drvdata(dp, p);
 	p->device = &dp->dev;
-	init_chips(p, addr);
 
-#ifdef CONFIG_PMAC_PBOOK
-	pmu_register_sleep_notifier(&chips_sleep_notifier);
-#endif /* CONFIG_PMAC_PBOOK */
+	init_chips(p, addr);
 
-	pci_set_drvdata(dp, p);
+	if (register_framebuffer(p) < 0) {
+		dev_err(&dp->dev,"C&T 65550 framebuffer failed to register\n");
+		goto err_unmap;
+	}
+	
+	dev_info(&dp->dev,"fb%d: Chips 65550 frame buffer"
+		 " (%dK RAM detected)\n",
+		 p->node, p->fix.smem_len / 1024);
+  
 	return 0;
+
+ err_unmap:
+	iounmap(p->screen_base);	
+ err_release_pci:
+	pci_release_region(dp, 0);
+ err_release_fb:
+	framebuffer_release(p);
+ err_disable:
+ err_out:
+	return rc;
 }
 
 static void __devexit chipsfb_remove(struct pci_dev *dp)
 {
 	struct fb_info *p = pci_get_drvdata(dp);
 
-	if (p != &chipsfb_info || p->screen_base == NULL)
+	if (p->screen_base == NULL)
 		return;
 	unregister_framebuffer(p);
 	iounmap(p->screen_base);
 	p->screen_base = NULL;
-	release_mem_region(pci_resource_start(dp, 0), pci_resource_len(dp, 0));
+	pci_release_region(dp, 0);
+}
+
+#ifdef CONFIG_PM
+static int chipsfb_pci_suspend(struct pci_dev *pdev, pm_message_t state)
+{
+        struct fb_info *p = pci_get_drvdata(pdev);
+
+	if (state == pdev->dev.power.power_state)
+		return 0;
+	if (state != PM_SUSPEND_MEM)
+		goto done;
 
-#ifdef CONFIG_PMAC_PBOOK
-	pmu_unregister_sleep_notifier(&chips_sleep_notifier);
-#endif /* CONFIG_PMAC_PBOOK */
+	acquire_console_sem();
+	chipsfb_blank(1, p);
+	fb_set_suspend(p, 1);
+	release_console_sem();
+ done:
+	pdev->dev.power.power_state = state;
+	return 0;
 }
 
+static int chipsfb_pci_resume(struct pci_dev *pdev)
+{
+        struct fb_info *p = pci_get_drvdata(pdev);
+
+	acquire_console_sem();
+	fb_set_suspend(p, 0);
+	chipsfb_blank(0, p);
+	release_console_sem();
+
+	pdev->dev.power.power_state = PMSG_ON;
+	return 0;
+}
+#endif /* CONFIG_PM */
+
+
 static struct pci_device_id chipsfb_pci_tbl[] = {
 	{ PCI_VENDOR_ID_CT, PCI_DEVICE_ID_CT_65550, PCI_ANY_ID, PCI_ANY_ID },
 	{ 0 }
@@ -455,6 +503,10 @@
 	.id_table =	chipsfb_pci_tbl,
 	.probe =	chipsfb_pci_init,
 	.remove =	__devexit_p(chipsfb_remove),
+#ifdef CONFIG_PM
+	.suspend =	chipsfb_pci_suspend,
+	.resume =	chipsfb_pci_resume,
+#endif
 };
 
 int __init chips_init(void)
@@ -472,48 +524,4 @@
 	pci_unregister_driver(&chipsfb_driver);
 }
 
-#ifdef CONFIG_PMAC_PBOOK
-/*
- * Save the contents of the frame buffer when we go to sleep,
- * and restore it when we wake up again.
- */
-int
-chips_sleep_notify(struct pmu_sleep_notifier *self, int when)
-{
-	struct fb_info *p = &chipsfb_info;
-	int nb = p->var.yres * p->fix.line_length;
-
-	if (p->screen_base == NULL)
-		return PBOOK_SLEEP_OK;
-
-	switch (when) {
-	case PBOOK_SLEEP_REQUEST:
-		save_framebuffer = vmalloc(nb);
-		if (save_framebuffer == NULL)
-			return PBOOK_SLEEP_REFUSE;
-		break;
-	case PBOOK_SLEEP_REJECT:
-		if (save_framebuffer) {
-			vfree(save_framebuffer);
-			save_framebuffer = NULL;
-		}
-		break;
-	case PBOOK_SLEEP_NOW:
-		chipsfb_blank(1, p);
-		if (save_framebuffer)
-			memcpy(save_framebuffer, p->screen_base, nb);
-		break;
-	case PBOOK_WAKE:
-		if (save_framebuffer) {
-			memcpy(p->screen_base, save_framebuffer, nb);
-			vfree(save_framebuffer);
-			save_framebuffer = NULL;
-		}
-		chipsfb_blank(0, p);
-		break;
-	}
-	return PBOOK_SLEEP_OK;
-}
-#endif /* CONFIG_PMAC_PBOOK */
-
 MODULE_LICENSE("GPL");
Index: linux-work/sound/oss/dmasound/dmasound_awacs.c
===================================================================
--- linux-work.orig/sound/oss/dmasound/dmasound_awacs.c	2005-06-27 14:19:11.000000000 +1000
+++ linux-work/sound/oss/dmasound/dmasound_awacs.c	2005-06-27 14:19:31.000000000 +1000
@@ -255,7 +255,7 @@
 
 static volatile struct dbdma_cmd *emergency_dbdma_cmd;
 
-#ifdef CONFIG_PMAC_PBOOK
+#ifdef CONFIG_PM
 /*
  * Stuff for restoring after a sleep.
  */
@@ -263,7 +263,7 @@
 struct pmu_sleep_notifier awacs_sleep_notifier = {
 	awacs_sleep_notify, SLEEP_LEVEL_SOUND,
 };
-#endif /* CONFIG_PMAC_PBOOK */
+#endif /* CONFIG_PM */
 
 /* for (soft) sample rate translations */
 int expand_bal;		/* Balance factor for expanding (not volume!) */
@@ -675,7 +675,7 @@
 	kfree(awacs_rx_cmd_space);
 	kfree(beep_dbdma_cmd_space);
 	kfree(beep_buf);
-#ifdef CONFIG_PMAC_PBOOK
+#ifdef CONFIG_PM
 	pmu_unregister_sleep_notifier(&awacs_sleep_notifier);
 #endif
 }
@@ -1415,7 +1415,7 @@
 	}
 }
 
-#ifdef CONFIG_PMAC_PBOOK
+#ifdef CONFIG_PM
 /*
  * Save state when going to sleep, restore it afterwards.
  */
@@ -1551,7 +1551,7 @@
 	}
 	return PBOOK_SLEEP_OK;
 }
-#endif /* CONFIG_PMAC_PBOOK */
+#endif /* CONFIG_PM */
 
 
 /* All the burgundy functions: */
@@ -3053,9 +3053,9 @@
 	if ((res=setup_beep()))
 		return res ;
 
-#ifdef CONFIG_PMAC_PBOOK
+#ifdef CONFIG_PM
 	pmu_register_sleep_notifier(&awacs_sleep_notifier);
-#endif /* CONFIG_PMAC_PBOOK */
+#endif /* CONFIG_PM */
 
 	/* Powerbooks have odd ways of enabling inputs such as
 	   an expansion-bay CD or sound from an internal modem
Index: linux-work/sound/ppc/awacs.c
===================================================================
--- linux-work.orig/sound/ppc/awacs.c	2005-06-27 14:19:11.000000000 +1000
+++ linux-work/sound/ppc/awacs.c	2005-06-27 14:19:31.000000000 +1000
@@ -90,7 +90,7 @@
 	snd_pmac_awacs_write(chip, val | (reg << 12));
 }
 
-#ifdef CONFIG_PMAC_PBOOK
+#ifdef CONFIG_PM
 /* Recalibrate chip */
 static void screamer_recalibrate(pmac_t *chip)
 {
@@ -642,7 +642,7 @@
 	}
 }
 
-#ifdef CONFIG_PMAC_PBOOK
+#ifdef CONFIG_PM
 static void snd_pmac_awacs_suspend(pmac_t *chip)
 {
 	snd_pmac_awacs_write_noreg(chip, 1, (chip->awacs_reg[1]
@@ -676,7 +676,7 @@
 	}
 #endif
 }
-#endif /* CONFIG_PMAC_PBOOK */
+#endif /* CONFIG_PM */
 
 #ifdef PMAC_SUPPORT_AUTOMUTE
 /*
@@ -883,7 +883,7 @@
 	 * set lowlevel callbacks
 	 */
 	chip->set_format = snd_pmac_awacs_set_format;
-#ifdef CONFIG_PMAC_PBOOK
+#ifdef CONFIG_PM
 	chip->suspend = snd_pmac_awacs_suspend;
 	chip->resume = snd_pmac_awacs_resume;
 #endif
Index: linux-work/sound/ppc/daca.c
===================================================================
--- linux-work.orig/sound/ppc/daca.c	2005-06-27 14:19:11.000000000 +1000
+++ linux-work/sound/ppc/daca.c	2005-06-27 14:19:31.000000000 +1000
@@ -218,7 +218,7 @@
 };
 
 
-#ifdef CONFIG_PMAC_PBOOK
+#ifdef CONFIG_PM
 static void daca_resume(pmac_t *chip)
 {
 	pmac_daca_t *mix = chip->mixer_data;
@@ -227,7 +227,7 @@
 				  mix->amp_on ? 0x05 : 0x04);
 	daca_set_volume(mix);
 }
-#endif /* CONFIG_PMAC_PBOOK */
+#endif /* CONFIG_PM */
 
 
 static void daca_cleanup(pmac_t *chip)
@@ -275,7 +275,7 @@
 			return err;
 	}
 
-#ifdef CONFIG_PMAC_PBOOK
+#ifdef CONFIG_PM
 	chip->resume = daca_resume;
 #endif
 
Index: linux-work/sound/ppc/pmac.c
===================================================================
--- linux-work.orig/sound/ppc/pmac.c	2005-06-27 14:19:11.000000000 +1000
+++ linux-work/sound/ppc/pmac.c	2005-06-27 14:19:31.000000000 +1000
@@ -36,7 +36,7 @@
 #include <asm/pci-bridge.h>
 
 
-#if defined(CONFIG_PM) && defined(CONFIG_PMAC_PBOOK)
+#ifdef CONFIG_PM
 static int snd_pmac_register_sleep_notifier(pmac_t *chip);
 static int snd_pmac_unregister_sleep_notifier(pmac_t *chip);
 static int snd_pmac_suspend(snd_card_t *card, pm_message_t state);
@@ -782,7 +782,7 @@
 	}
 
 	snd_pmac_sound_feature(chip, 0);
-#if defined(CONFIG_PM) && defined(CONFIG_PMAC_PBOOK)
+#ifdef CONFIG_PM
 	snd_pmac_unregister_sleep_notifier(chip);
 #endif
 
@@ -1292,7 +1292,7 @@
 	/* Reset dbdma channels */
 	snd_pmac_dbdma_reset(chip);
 
-#if defined(CONFIG_PM) && defined(CONFIG_PMAC_PBOOK)
+#ifdef CONFIG_PM
 	/* add sleep notifier */
 	if (! snd_pmac_register_sleep_notifier(chip))
 		snd_card_set_pm_callback(chip->card, snd_pmac_suspend, snd_pmac_resume, chip);
@@ -1316,7 +1316,7 @@
  * sleep notify for powerbook
  */
 
-#if defined(CONFIG_PM) && defined(CONFIG_PMAC_PBOOK)
+#ifdef CONFIG_PM
 
 /*
  * Save state when going to sleep, restore it afterwards.
@@ -1414,4 +1414,5 @@
 	return 0;
 }
 
-#endif /* CONFIG_PM && CONFIG_PMAC_PBOOK */
+#endif /* CONFIG_PM */
+
Index: linux-work/sound/ppc/pmac.h
===================================================================
--- linux-work.orig/sound/ppc/pmac.h	2005-06-27 14:19:11.000000000 +1000
+++ linux-work/sound/ppc/pmac.h	2005-06-27 14:19:31.000000000 +1000
@@ -167,7 +167,7 @@
 	void (*set_format)(pmac_t *chip);
 	void (*update_automute)(pmac_t *chip, int do_notify);
 	int (*detect_headphone)(pmac_t *chip);
-#ifdef CONFIG_PMAC_PBOOK
+#ifdef CONFIG_PM
 	void (*suspend)(pmac_t *chip);
 	void (*resume)(pmac_t *chip);
 #endif
Index: linux-work/sound/ppc/tumbler.c
===================================================================
--- linux-work.orig/sound/ppc/tumbler.c	2005-06-27 14:19:11.000000000 +1000
+++ linux-work/sound/ppc/tumbler.c	2005-06-27 14:19:31.000000000 +1000
@@ -1128,7 +1128,7 @@
 	}
 }
 
-#ifdef CONFIG_PMAC_PBOOK
+#ifdef CONFIG_PM
 /* suspend mixer */
 static void tumbler_suspend(pmac_t *chip)
 {
@@ -1370,7 +1370,7 @@
 	if ((err = snd_ctl_add(chip->card, chip->drc_sw_ctl)) < 0)
 		return err;
 
-#ifdef CONFIG_PMAC_PBOOK
+#ifdef CONFIG_PM
 	chip->suspend = tumbler_suspend;
 	chip->resume = tumbler_resume;
 #endif
Index: linux-work/drivers/macintosh/via-pmu.c
===================================================================
--- linux-work.orig/drivers/macintosh/via-pmu.c	2005-06-27 14:19:30.000000000 +1000
+++ linux-work/drivers/macintosh/via-pmu.c	2005-06-27 14:28:01.000000000 +1000
@@ -155,10 +155,10 @@
 static u8 pmu_intr_mask;
 static int pmu_version;
 static int drop_interrupts;
-#ifdef CONFIG_PMAC_PBOOK
+#ifdef CONFIG_PM
 static int option_lid_wakeup = 1;
 static int sleep_in_progress;
-#endif /* CONFIG_PMAC_PBOOK */
+#endif /* CONFIG_PM */
 static unsigned long async_req_locks;
 static unsigned int pmu_irq_stats[11];
 
@@ -168,7 +168,6 @@
 static struct proc_dir_entry *proc_pmu_options;
 static int option_server_mode;
 
-#ifdef CONFIG_PMAC_PBOOK
 int pmu_battery_count;
 int pmu_cur_battery;
 unsigned int pmu_power_flags;
@@ -176,7 +175,6 @@
 static int query_batt_timer = BATTERY_POLLING_COUNT;
 static struct adb_request batt_req;
 static struct proc_dir_entry *proc_pmu_batt[PMU_MAX_BATTERIES];
-#endif /* CONFIG_PMAC_PBOOK */
 
 #if defined(CONFIG_INPUT_ADBHID) && defined(CONFIG_PMAC_BACKLIGHT)
 extern int disable_kernel_backlight;
@@ -210,11 +208,9 @@
 static int pmu_set_backlight_level(int level, void* data);
 static int pmu_set_backlight_enable(int on, int level, void* data);
 #endif /* CONFIG_PMAC_BACKLIGHT */
-#ifdef CONFIG_PMAC_PBOOK
 static void pmu_pass_intr(unsigned char *data, int len);
 static int proc_get_batt(char *page, char **start, off_t off,
 			int count, int *eof, void *data);
-#endif /* CONFIG_PMAC_PBOOK */
 static int proc_read_options(char *page, char **start, off_t off,
 			int count, int *eof, void *data);
 static int proc_write_options(struct file *file, const char __user *buffer,
@@ -407,9 +403,7 @@
 
 	bright_req_1.complete = 1;
 	bright_req_2.complete = 1;
-#ifdef CONFIG_PMAC_PBOOK
 	batt_req.complete = 1;
-#endif
 
 #ifdef CONFIG_PPC32
 	if (pmu_kind == PMU_KEYLARGO_BASED)
@@ -468,7 +462,7 @@
 	register_backlight_controller(&pmu_backlight_controller, NULL, "pmu");
 #endif /* CONFIG_PMAC_BACKLIGHT */
 
-#ifdef CONFIG_PMAC_PBOOK
+#ifdef CONFIG_PPC32
   	if (machine_is_compatible("AAPL,3400/2400") ||
   		machine_is_compatible("AAPL,3500")) {
 		int mb = pmac_call_feature(PMAC_FTR_GET_MB_INFO,
@@ -496,20 +490,19 @@
 				pmu_batteries[1].flags |= PMU_BATT_TYPE_SMART;
 		}
 	}
-#endif /* CONFIG_PMAC_PBOOK */
+#endif /* CONFIG_PPC32 */
+
 	/* Create /proc/pmu */
 	proc_pmu_root = proc_mkdir("pmu", NULL);
 	if (proc_pmu_root) {
-#ifdef CONFIG_PMAC_PBOOK
-		int i;
+		long i;
 
 		for (i=0; i<pmu_battery_count; i++) {
 			char title[16];
-			sprintf(title, "battery_%d", i);
+			sprintf(title, "battery_%ld", i);
 			proc_pmu_batt[i] = create_proc_read_entry(title, 0, proc_pmu_root,
 						proc_get_batt, (void *)i);
 		}
-#endif /* CONFIG_PMAC_PBOOK */
 
 		proc_pmu_info = create_proc_read_entry("info", 0, proc_pmu_root,
 					proc_get_info, NULL);
@@ -629,8 +622,6 @@
 	pmu_wait_complete(&req);
 }
 
-#ifdef CONFIG_PMAC_PBOOK
-
 /* This new version of the code for 2400/3400/3500 powerbooks
  * is inspired from the implementation in gkrellm-pmu
  */
@@ -813,8 +804,6 @@
 			2, PMU_SMART_BATTERY_STATE, pmu_cur_battery+1);
 }
 
-#endif /* CONFIG_PMAC_PBOOK */
-
 static int __pmac
 proc_get_info(char *page, char **start, off_t off,
 		int count, int *eof, void *data)
@@ -823,11 +812,9 @@
 
 	p += sprintf(p, "PMU driver version     : %d\n", PMU_DRIVER_VERSION);
 	p += sprintf(p, "PMU firmware version   : %02x\n", pmu_version);
-#ifdef CONFIG_PMAC_PBOOK
 	p += sprintf(p, "AC Power               : %d\n",
 		((pmu_power_flags & PMU_PWR_AC_PRESENT) != 0));
 	p += sprintf(p, "Battery count          : %d\n", pmu_battery_count);
-#endif /* CONFIG_PMAC_PBOOK */
 
 	return p - page;
 }
@@ -859,12 +846,11 @@
 	return p - page;
 }
 
-#ifdef CONFIG_PMAC_PBOOK
 static int __pmac
 proc_get_batt(char *page, char **start, off_t off,
 		int count, int *eof, void *data)
 {
-	int batnum = (int)data;
+	long batnum = (long)data;
 	char *p = page;
 	
 	p += sprintf(p, "\n");
@@ -883,7 +869,6 @@
 
 	return p - page;
 }
-#endif /* CONFIG_PMAC_PBOOK */
 
 static int __pmac
 proc_read_options(char *page, char **start, off_t off,
@@ -891,11 +876,11 @@
 {
 	char *p = page;
 
-#ifdef CONFIG_PMAC_PBOOK
+#ifdef CONFIG_PM
 	if (pmu_kind == PMU_KEYLARGO_BASED &&
 	    pmac_call_feature(PMAC_FTR_SLEEP_STATE,NULL,0,-1) >= 0)
 		p += sprintf(p, "lid_wakeup=%d\n", option_lid_wakeup);
-#endif /* CONFIG_PMAC_PBOOK */
+#endif
 	if (pmu_kind == PMU_KEYLARGO_BASED)
 		p += sprintf(p, "server_mode=%d\n", option_server_mode);
 
@@ -932,12 +917,12 @@
 	*(val++) = 0;
 	while(*val == ' ')
 		val++;
-#ifdef CONFIG_PMAC_PBOOK
+#ifdef CONFIG_PM
 	if (pmu_kind == PMU_KEYLARGO_BASED &&
 	    pmac_call_feature(PMAC_FTR_SLEEP_STATE,NULL,0,-1) >= 0)
 		if (!strcmp(label, "lid_wakeup"))
 			option_lid_wakeup = ((*val) == '1');
-#endif /* CONFIG_PMAC_PBOOK */
+#endif
 	if (pmu_kind == PMU_KEYLARGO_BASED && !strcmp(label, "server_mode")) {
 		int new_value;
 		new_value = ((*val) == '1');
@@ -1432,7 +1417,6 @@
 	}
 	/* Tick interrupt */
 	else if ((1 << pirq) & PMU_INT_TICK) {
-#ifdef CONFIG_PMAC_PBOOK
 		/* Environement or tick interrupt, query batteries */
 		if (pmu_battery_count) {
 			if ((--query_batt_timer) == 0) {
@@ -1447,7 +1431,6 @@
 		pmu_pass_intr(data, len);
 	} else {
 	       pmu_pass_intr(data, len);
-#endif /* CONFIG_PMAC_PBOOK */
 	}
 	goto next;
 }
@@ -2062,7 +2045,7 @@
 	return -1;
 }
 
-#ifdef CONFIG_PMAC_PBOOK
+#ifdef CONFIG_PM
 
 static LIST_HEAD(sleep_notifiers);
 
@@ -2715,6 +2698,8 @@
 	return 0;
 }
 
+#endif /* CONFIG_PM */
+
 /*
  * Support for /dev/pmu device
  */
@@ -2894,11 +2879,11 @@
 pmu_ioctl(struct inode * inode, struct file *filp,
 		     u_int cmd, u_long arg)
 {
-	struct pmu_private *pp = filp->private_data;
 	__u32 __user *argp = (__u32 __user *)arg;
-	int error;
+	int error = -EINVAL;
 
 	switch (cmd) {
+#ifdef CONFIG_PM
 	case PMU_IOC_SLEEP:
 		if (!capable(CAP_SYS_ADMIN))
 			return -EACCES;
@@ -2920,12 +2905,13 @@
 			error = -ENOSYS;
 		}
 		sleep_in_progress = 0;
-		return error;
+		break;
 	case PMU_IOC_CAN_SLEEP:
 		if (pmac_call_feature(PMAC_FTR_SLEEP_STATE,NULL,0,-1) < 0)
 			return put_user(0, argp);
 		else
 			return put_user(1, argp);
+#endif /* CONFIG_PM */
 
 #ifdef CONFIG_PMAC_BACKLIGHT
 	/* Backlight should have its own device or go via
@@ -2946,11 +2932,13 @@
 		error = get_user(value, argp);
 		if (!error)
 			error = set_backlight_level(value);
-		return error;
+		break;
 	}
 #ifdef CONFIG_INPUT_ADBHID
 	case PMU_IOC_GRAB_BACKLIGHT: {
+		struct pmu_private *pp = filp->private_data;
 		unsigned long flags;
+
 		if (pp->backlight_locker)
 			return 0;
 		pp->backlight_locker = 1;
@@ -2966,7 +2954,7 @@
 	case PMU_IOC_HAS_ADB:
 		return put_user(pmu_has_adb, argp);
 	}
-	return -EINVAL;
+	return error;
 }
 
 static struct file_operations pmu_device_fops __pmacdata = {
@@ -2982,14 +2970,16 @@
 	PMU_MINOR, "pmu", &pmu_device_fops
 };
 
-void pmu_device_init(void)
+static int pmu_device_init(void)
 {
 	if (!via)
-		return;
+		return 0;
 	if (misc_register(&pmu_device) < 0)
 		printk(KERN_ERR "via-pmu: cannot register misc device.\n");
+	return 0;
 }
-#endif /* CONFIG_PMAC_PBOOK */
+device_initcall(pmu_device_init);
+
 
 #ifdef DEBUG_SLEEP
 static inline void  __pmac
@@ -3157,12 +3147,12 @@
 EXPORT_SYMBOL(pmu_i2c_stdsub_write);
 EXPORT_SYMBOL(pmu_i2c_simple_read);
 EXPORT_SYMBOL(pmu_i2c_simple_write);
-#ifdef CONFIG_PMAC_PBOOK
+#ifdef CONFIG_PM
 EXPORT_SYMBOL(pmu_register_sleep_notifier);
 EXPORT_SYMBOL(pmu_unregister_sleep_notifier);
 EXPORT_SYMBOL(pmu_enable_irled);
 EXPORT_SYMBOL(pmu_battery_count);
 EXPORT_SYMBOL(pmu_batteries);
 EXPORT_SYMBOL(pmu_power_flags);
-#endif /* CONFIG_PMAC_PBOOK */
+#endif /* CONFIG_PM */
 
Index: linux-work/include/linux/pmu.h
===================================================================
--- linux-work.orig/include/linux/pmu.h	2005-06-27 14:19:11.000000000 +1000
+++ linux-work/include/linux/pmu.h	2005-06-27 14:19:31.000000000 +1000
@@ -166,7 +166,7 @@
 extern int pmu_i2c_simple_write(int bus, int addr,  u8* data, int len);
 
 
-#ifdef CONFIG_PMAC_PBOOK
+#ifdef CONFIG_PM
 /*
  * Stuff for putting the powerbook to sleep and waking it again.
  *
@@ -208,6 +208,8 @@
 int pmu_register_sleep_notifier(struct pmu_sleep_notifier* notifier);
 int pmu_unregister_sleep_notifier(struct pmu_sleep_notifier* notifier);
 
+#endif /* CONFIG_PM */
+
 #define PMU_MAX_BATTERIES	2
 
 /* values for pmu_power_flags */
@@ -235,6 +237,4 @@
 extern struct pmu_battery_info pmu_batteries[PMU_MAX_BATTERIES];
 extern unsigned int pmu_power_flags;
 
-#endif /* CONFIG_PMAC_PBOOK */
-
 #endif	/* __KERNEL__ */


