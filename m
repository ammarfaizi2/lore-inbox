Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267121AbSLKLmt>; Wed, 11 Dec 2002 06:42:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267122AbSLKLmt>; Wed, 11 Dec 2002 06:42:49 -0500
Received: from dp.samba.org ([66.70.73.150]:64473 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267121AbSLKLmj>;
	Wed, 11 Dec 2002 06:42:39 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15863.9692.239964.520652@argo.ozlabs.ibm.com>
Date: Wed, 11 Dec 2002 22:47:40 +1100
To: James Simmons <jsimmons@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: patch for aty128fb.c
X-Mailer: VM 7.07 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch gets aty128fb.c to compile and work on my G4 powerbook.  I
have fixed the bug where the check_var routine would alter the par
structure, and I have fixed up the errors in the powerbook-specific
sleep/wakeup code.

Currently it can only put one rage 128 chip to sleep, but that is ok
for now since I've never seen a laptop with two rage 128 chips yet. :)
The generic device model will ultimately give us a better way to
handle sleep/wakeup.

Paul.

diff -urN linux-2.5/drivers/video/aty128fb.c pmac-2.5/drivers/video/aty128fb.c
--- linux-2.5/drivers/video/aty128fb.c	2002-12-10 15:20:32.000000000 +1100
+++ pmac-2.5/drivers/video/aty128fb.c	2002-12-11 22:41:38.000000000 +1100
@@ -65,10 +65,7 @@
 #ifdef CONFIG_ALL_PPC
 #include <asm/prom.h>
 #include <asm/pci-bridge.h>
-#include <video/macmodes.h>
-#ifdef CONFIG_NVRAM
-#include <linux/nvram.h>
-#endif
+#include "macmodes.h"
 #endif
 
 #ifdef CONFIG_ADB_PMU
@@ -285,7 +282,6 @@
 
 struct aty128_crtc {
 	u32 gen_cntl;
-	u32 ext_cntl;
 	u32 h_total, h_sync_strt_wid;
 	u32 v_total, v_sync_strt_wid;
 	u32 pitch;
@@ -326,10 +322,13 @@
 	unsigned char *save_framebuffer;
 	int	pm_reg;
 	int crt_on, lcd_on;
+	struct pci_dev *pdev;
+	struct fb_info *next;
 #endif
-	unsigned char red[64];	/* see comments in aty128fb_setcolreg */
-	unsigned char green[64];
-	unsigned char blue[64];
+	u8	red[32];		/* see aty128fb_setcolreg */
+	u8	green[64];
+	u8	blue[32];
+	u32	pseudo_palette[16];	/* used for TRUECOLOR */
 };
 
 #ifdef CONFIG_PMAC_PBOOK
@@ -337,6 +336,7 @@
 static struct pmu_sleep_notifier aty128_sleep_notifier = {
 	aty128_sleep_notify, SLEEP_LEVEL_VIDEO,
 };
+static struct fb_info *aty128_fb = NULL;
 #endif
 
 #define round_div(n, d) ((n+(d/2))/d)
@@ -1203,7 +1203,11 @@
 { 
 	struct aty128fb_par *par = info->par;
 	u32 config;
-    
+	int err;
+
+	if ((err = aty128_decode_var(&info->var, par)) != 0)
+		return err;
+
 	if (par->blitter_may_be_busy)
 		wait_for_idle(par);
 
@@ -1271,15 +1275,22 @@
 aty128_decode_var(struct fb_var_screeninfo *var, struct aty128fb_par *par)
 {
 	int err;
+	struct aty128_crtc crtc;
+	struct aty128_pll pll;
+	struct aty128_ddafifo fifo_reg;
 
-	if ((err = aty128_var_to_crtc(var, &par->crtc, par)))
+	if ((err = aty128_var_to_crtc(var, &crtc, par)))
 		return err;
 
-	if ((err = aty128_var_to_pll(var->pixclock, &par->pll, par)))
+	if ((err = aty128_var_to_pll(var->pixclock, &pll, par)))
 		return err;
 
-	if ((err = aty128_ddafifo(&par->fifo_reg, &par->pll, par->crtc.depth, par)))
+	if ((err = aty128_ddafifo(&fifo_reg, &pll, crtc.depth, par)))
 		return err;
+
+	par->crtc = crtc;
+	par->pll = pll;
+	par->fifo_reg = fifo_reg;
 	par->accel_flags = var->accel_flags;
 
 	return 0;
@@ -1312,12 +1323,13 @@
 static int
 aty128fb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 {
-	struct aty128fb_par *par = info->par;
+	struct aty128fb_par par;
 	int err;
 
-	if ((err = aty128_decode_var(var, par)) != 0)
+	par = *(struct aty128fb_par *)info->par;
+	if ((err = aty128_decode_var(var, &par)) != 0)
 		return err;
-	aty128_encode_var(var, par);
+	aty128_encode_var(var, &par);
 	return 0;
 }
 
@@ -1415,7 +1427,7 @@
 		}
 #endif
 #ifdef CONFIG_ALL_PPC
-		/* vmode and cmode depreciated */
+		/* vmode and cmode deprecated */
 		if (!strncmp(this_opt, "vmode:", 6)) {
 			unsigned int vmode = simple_strtoul(this_opt+6, NULL, 0);
 			if (vmode > 0 && vmode <= VMODE_MAX)
@@ -1602,7 +1614,12 @@
 #endif /* CONFIG_PMAC_BACKLIGHT */
 #ifdef CONFIG_PMAC_PBOOK
 	par->pm_reg = pci_find_capability(pdev, PCI_CAP_ID_PM);
-	pmu_register_sleep_notifier(&aty128_sleep_notifier);
+	if (aty128_fb == NULL) {
+		/* XXX can only put one chip to sleep */
+		aty128_fb = info;
+	} else
+		printk(KERN_WARNING "aty128fb: can only sleep one Rage 128\n");
+	par->pdev = pdev;
 #endif
 
 	printk(KERN_INFO "fb%d: %s frame buffer device on %s\n",
@@ -1647,8 +1664,7 @@
 	}
 
 	/* We have the resources. Now virtualize them */
-	size = sizeof(struct fb_info) + sizeof(struct aty128fb_par) +
-			 sizeof(u32)*16;
+	size = sizeof(struct fb_info) + sizeof(struct aty128fb_par);
 	if (!(info = kmalloc(size, GFP_ATOMIC))) {
 		printk(KERN_ERR "aty128fb: can't alloc fb_info_aty128\n");
 		goto err_unmap_out;
@@ -1656,9 +1672,7 @@
 	memset(info, 0, size);
 
 	par = (struct aty128fb_par *)(info + 1);
-	info->pseudo_palette = (void *) (par + 1);
-
-	memset(info, 0, sizeof(struct fb_info));
+	info->pseudo_palette = par->pseudo_palette;
 
 	info->par = par;
 	info->fix = aty128fb_fix;
@@ -1758,6 +1772,10 @@
 			   pci_resource_len(pdev, 1));
 	release_mem_region(pci_resource_start(pdev, 2),
 			   pci_resource_len(pdev, 2));
+#ifdef CONFIG_PMAC_PBOOK
+	if (info == aty128_fb)
+		aty128_fb = NULL;
+#endif
 	kfree(info);
 }
 #endif /* CONFIG_PCI */
@@ -2008,7 +2026,7 @@
 		}
 	}
 
-	if (par->crtc.depth == 16) {
+	if (par->crtc.depth == 16 && regno > 0) {
 		/*
 		 * With the 5-6-5 split of bits for RGB at 16 bits/pixel, we
 		 * have 32 slots for R and B values but 64 slots for G values.
@@ -2016,12 +2034,13 @@
 		 * goes in a different slot, and we have to avoid disturbing
 		 * the other fields in the slots we touch.
 		 */
-		par->red[regno] = red;
 		par->green[regno] = green;
-		par->blue[regno] = blue;
-		if (regno > 0 && regno < 32)
+		if (regno < 32) {
+			par->red[regno] = red;
+			par->blue[regno] = blue;
 			aty128_st_pal(regno * 8, red, par->green[regno*2],
 				      blue, par);
+		}
 		red = par->red[regno/2];
 		blue = par->blue[regno/2];
 		regno <<= 2;
@@ -2213,6 +2232,7 @@
 {
 	u32	pmgt;
 	u16	pwr_command;
+	struct pci_dev *pdev = par->pdev;
 
 	if (!par->pm_reg)
 		return;
@@ -2237,17 +2257,16 @@
 		aty_st_le32(BUS_CNTL1, 0x00000010);
 		aty_st_le32(MEM_POWER_MISC, 0x0c830000);
 		mdelay(100);
-		pci_read_config_word(par->pdev, par->pm_reg+PCI_PM_CTRL, &pwr_command);
+		pci_read_config_word(pdev, par->pm_reg+PCI_PM_CTRL, &pwr_command);
 		/* Switch PCI power management to D2 */
-		pci_write_config_word(par->pdev, par->pm_reg+PCI_PM_CTRL,
+		pci_write_config_word(pdev, par->pm_reg+PCI_PM_CTRL,
 			(pwr_command & ~PCI_PM_CTRL_STATE_MASK) | 2);
-		pci_read_config_word(par->pdev, par->pm_reg+PCI_PM_CTRL, &pwr_command);
+		pci_read_config_word(pdev, par->pm_reg+PCI_PM_CTRL, &pwr_command);
 	} else {
 		/* Switch back PCI power management to D0 */
 		mdelay(100);
-		pci_write_config_word(par->pdev, par->pm_reg+PCI_PM_CTRL, 0);
-		mdelay(100);
-		pci_read_config_word(par->pdev, par->pm_reg+PCI_PM_CTRL, &pwr_command);
+		pci_write_config_word(pdev, par->pm_reg+PCI_PM_CTRL, 0);
+		pci_read_config_word(pdev, par->pm_reg+PCI_PM_CTRL, &pwr_command);
 		mdelay(100);
 	}
 }
@@ -2259,10 +2278,13 @@
 int
 aty128_sleep_notify(struct pmu_sleep_notifier *self, int when)
 {
- 	int result = PBOOK_SLEEP_OK, nb;
-	struct fb_info *info = info;	/* FIXME!!! How do find which framebuffer  */
-	struct aty128fb_par *par = info->par;
+ 	int nb;
+	struct fb_info *info = aty128_fb;
+	struct aty128fb_par *par;
 
+	if (info == NULL)
+		return PBOOK_SLEEP_OK;
+	par = info->par;
 	nb = info->var.yres * info->fix.line_length;
 
 	switch (when) {
@@ -2311,17 +2333,23 @@
 		aty128fb_blank(0, info);
 		break;
 	}
-	return result;
+	return PBOOK_SLEEP_OK;
 }
 #endif /* CONFIG_PMAC_PBOOK */
 
 int __init aty128fb_init(void)
 {
+#ifdef CONFIG_PMAC_PBOOK
+	pmu_register_sleep_notifier(&aty128_sleep_notifier);
+#endif
 	return pci_module_init(&aty128fb_driver);
 }
 
 static void __exit aty128fb_exit(void)
 {
+#ifdef CONFIG_PMAC_PBOOK
+	pmu_unregister_sleep_notifier(&aty128_sleep_notifier);
+#endif
 	pci_unregister_driver(&aty128fb_driver);
 }
 
