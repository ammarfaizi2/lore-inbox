Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318448AbSHEM3f>; Mon, 5 Aug 2002 08:29:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318455AbSHEM3f>; Mon, 5 Aug 2002 08:29:35 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:4259 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S318448AbSHEM33>;
	Mon, 5 Aug 2002 08:29:29 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15694.28634.756394.889266@argo.ozlabs.ibm.com>
Date: Mon, 5 Aug 2002 22:30:18 +1000 (EST)
To: James Simmons <jsimmons@transvirtual.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix some FB drivers used on PPC
X-Mailer: VM 6.75 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James,

Here is a patch which gets the offb and atyfb drivers to compile and
run on PPC.  The patch is against 2.5.30.  I also have patches for
aty128fb and radeonfb but they are more extensive and I want to work
on them a little more.

Paul.

diff -urN linux-2.5/drivers/video/Makefile pmac-2.5/drivers/video/Makefile
--- linux-2.5/drivers/video/Makefile	Thu Jul 25 09:57:53 2002
+++ pmac-2.5/drivers/video/Makefile	Fri Jul 26 19:13:22 2002
@@ -60,7 +60,7 @@
 obj-$(CONFIG_FB_3DFX)             += tdfxfb.o
 obj-$(CONFIG_FB_MAC)              += macfb.o macmodes.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o 
 obj-$(CONFIG_FB_HP300)            += hpfb.o cfbfillrect.o cfbimgblt.o
-obj-$(CONFIG_FB_OF)               += offb.o
+obj-$(CONFIG_FB_OF)               += offb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
 obj-$(CONFIG_FB_IMSTT)            += imsttfb.o
 obj-$(CONFIG_FB_RETINAZ3)         += retz3fb.o
 obj-$(CONFIG_FB_CLGEN)            += clgenfb.o
@@ -89,7 +89,7 @@
 obj-$(CONFIG_FB_MATROX)		  += matrox/
 obj-$(CONFIG_FB_RIVA)		  += riva/
 obj-$(CONFIG_FB_SIS)		  += sis/
-obj-$(CONFIG_FB_ATY)		  += aty/
+obj-$(CONFIG_FB_ATY)		  += aty/ cfbimgblt.o
 
 obj-$(CONFIG_FB_SUN3)             += sun3fb.o
 obj-$(CONFIG_FB_BWTWO)            += bwtwofb.o
diff -urN linux-2.5/drivers/video/aty/Makefile pmac-2.5/drivers/video/aty/Makefile
--- linux-2.5/drivers/video/aty/Makefile	Wed Jul 31 10:26:35 2002
+++ pmac-2.5/drivers/video/aty/Makefile	Wed Jul 31 11:52:11 2002
@@ -1,6 +1,6 @@
 obj-$(CONFIG_FB_ATY) += atyfb.o
 
-atyfb-y				:= atyfb_base.o mach64_accel.o ../cfbimgblt.o
+atyfb-y				:= atyfb_base.o mach64_accel.o
 atyfb-$(CONFIG_FB_ATY_GX)	+= mach64_gx.o
 atyfb-$(CONFIG_FB_ATY_CT)	+= mach64_ct.o mach64_cursor.o
 atyfb-objs			:= $(atyfb-y)
diff -urN linux-2.5/drivers/video/aty/atyfb.h pmac-2.5/drivers/video/aty/atyfb.h
--- linux-2.5/drivers/video/aty/atyfb.h	Thu Jul 25 09:57:53 2002
+++ pmac-2.5/drivers/video/aty/atyfb.h	Fri Jul 26 18:27:26 2002
@@ -103,6 +103,7 @@
 	int open;
 #endif
 #ifdef CONFIG_PMAC_PBOOK
+	struct fb_info *next;
 	unsigned char *save_framebuffer;
 	unsigned long save_pll[64];
 #endif
@@ -286,7 +287,7 @@
      *  Text console acceleration
      */
 
-extern const struct display_switch fbcon_aty8;
-extern const struct display_switch fbcon_aty16;
-extern const struct display_switch fbcon_aty24;
-extern const struct display_switch fbcon_aty32;
+extern struct display_switch fbcon_aty8;
+extern struct display_switch fbcon_aty16;
+extern struct display_switch fbcon_aty24;
+extern struct display_switch fbcon_aty32;
diff -urN linux-2.5/drivers/video/aty/atyfb_base.c pmac-2.5/drivers/video/aty/atyfb_base.c
--- linux-2.5/drivers/video/aty/atyfb_base.c	Thu Jul 25 09:57:53 2002
+++ pmac-2.5/drivers/video/aty/atyfb_base.c	Fri Jul 26 18:34:14 2002
@@ -133,6 +133,7 @@
 	unsigned long prot_mask;
 };
 
+#if 0
 static struct fb_fix_screeninfo atyfb_fix __initdata = {
 	id:		"ATY Mach64",
 	type:		FB_TYPE_PACKED_PIXELS,
@@ -140,6 +141,7 @@
 	xpanstep:	8,
 	ypanstep:	1,
 };
+#endif
 
     /*
      *  Frame buffer device API
@@ -206,7 +208,7 @@
 static void atyfb_set_dispsw(struct display *disp,
 			     struct fb_info *info);
 #ifdef CONFIG_PPC
-static int read_aty_sense(const struct fb_info *info);
+static int read_aty_sense(const struct atyfb_par *par);
 #endif
 
 
@@ -462,36 +464,36 @@
      *  Apple monitor sense
      */
 
-static int __init read_aty_sense(const struct fb_info *info)
+static int __init read_aty_sense(const struct atyfb_par *par)
 {
 	int sense, i;
 
-	aty_st_le32(GP_IO, 0x31003100, info);	/* drive outputs high */
+	aty_st_le32(GP_IO, 0x31003100, par);	/* drive outputs high */
 	__delay(200);
-	aty_st_le32(GP_IO, 0, info);	/* turn off outputs */
+	aty_st_le32(GP_IO, 0, par);	/* turn off outputs */
 	__delay(2000);
-	i = aty_ld_le32(GP_IO, info);	/* get primary sense value */
+	i = aty_ld_le32(GP_IO, par);	/* get primary sense value */
 	sense = ((i & 0x3000) >> 3) | (i & 0x100);
 
 	/* drive each sense line low in turn and collect the other 2 */
-	aty_st_le32(GP_IO, 0x20000000, info);	/* drive A low */
+	aty_st_le32(GP_IO, 0x20000000, par);	/* drive A low */
 	__delay(2000);
-	i = aty_ld_le32(GP_IO, info);
+	i = aty_ld_le32(GP_IO, par);
 	sense |= ((i & 0x1000) >> 7) | ((i & 0x100) >> 4);
-	aty_st_le32(GP_IO, 0x20002000, info);	/* drive A high again */
+	aty_st_le32(GP_IO, 0x20002000, par);	/* drive A high again */
 	__delay(200);
 
-	aty_st_le32(GP_IO, 0x10000000, info);	/* drive B low */
+	aty_st_le32(GP_IO, 0x10000000, par);	/* drive B low */
 	__delay(2000);
-	i = aty_ld_le32(GP_IO, info);
+	i = aty_ld_le32(GP_IO, par);
 	sense |= ((i & 0x2000) >> 10) | ((i & 0x100) >> 6);
-	aty_st_le32(GP_IO, 0x10001000, info);	/* drive B high again */
+	aty_st_le32(GP_IO, 0x10001000, par);	/* drive B high again */
 	__delay(200);
 
-	aty_st_le32(GP_IO, 0x01000000, info);	/* drive C low */
+	aty_st_le32(GP_IO, 0x01000000, par);	/* drive C low */
 	__delay(2000);
-	sense |= (aty_ld_le32(GP_IO, info) & 0x3000) >> 12;
-	aty_st_le32(GP_IO, 0, info);	/* turn off outputs */
+	sense |= (aty_ld_le32(GP_IO, par) & 0x3000) >> 12;
+	aty_st_le32(GP_IO, 0, par);	/* turn off outputs */
 
 	return sense;
 }
@@ -499,26 +501,26 @@
 #endif				/* defined(CONFIG_PPC) */
 
 #if defined(CONFIG_PMAC_PBOOK) || defined(CONFIG_PMAC_BACKLIGHT)
-static void aty_st_lcd(int index, u32 val, const struct fb_info *info)
+static void aty_st_lcd(int index, u32 val, const struct atyfb_par *par)
 {
 	unsigned long temp;
 
 	/* write addr byte */
-	temp = aty_ld_le32(LCD_INDEX, info);
-	aty_st_le32(LCD_INDEX, (temp & ~LCD_INDEX_MASK) | index, info);
+	temp = aty_ld_le32(LCD_INDEX, par);
+	aty_st_le32(LCD_INDEX, (temp & ~LCD_INDEX_MASK) | index, par);
 	/* write the register value */
-	aty_st_le32(LCD_DATA, val, info);
+	aty_st_le32(LCD_DATA, val, par);
 }
 
-static u32 aty_ld_lcd(int index, const struct fb_info *info)
+static u32 aty_ld_lcd(int index, const struct atyfb_par *par)
 {
 	unsigned long temp;
 
 	/* write addr byte */
-	temp = aty_ld_le32(LCD_INDEX, info);
-	aty_st_le32(LCD_INDEX, (temp & ~LCD_INDEX_MASK) | index, info);
+	temp = aty_ld_le32(LCD_INDEX, par);
+	aty_st_le32(LCD_INDEX, (temp & ~LCD_INDEX_MASK) | index, par);
 	/* read the register value */
-	return aty_ld_le32(LCD_DATA, info);
+	return aty_ld_le32(LCD_DATA, par);
 }
 #endif				/* CONFIG_PMAC_PBOOK || CONFIG_PMAC_BACKLIGHT */
 
@@ -1447,8 +1449,8 @@
 		tmp = aty_ld_8(DAC_CNTL, info) & 0xfc;
 		if (M64_HAS(EXTRA_BRIGHT))
 			tmp |= 0x2;
-		aty_st_8(DAC_CNTL, tmp, info);
-		aty_st_8(DAC_MASK, 0xff, info);
+		aty_st_8(DAC_CNTL, tmp, par);
+		aty_st_8(DAC_MASK, 0xff, par);
 
 		writeb(i, &par->aty_cmap_regs->rindex);
 		atyfb_save.r[enter][i] = readb(&par->aty_cmap_regs->lut);
@@ -1506,32 +1508,32 @@
  * management registers. There's is some confusion about which
  * chipID is a Rage LT or LT pro :(
  */
-static int aty_power_mgmt_LT(int sleep, struct fb_info *info)
+static int aty_power_mgmt_LT(int sleep, struct atyfb_par *par)
 {
 	unsigned int pm;
 	int timeout;
 
-	pm = aty_ld_le32(POWER_MANAGEMENT_LG, info);
+	pm = aty_ld_le32(POWER_MANAGEMENT_LG, par);
 	pm = (pm & ~PWR_MGT_MODE_MASK) | PWR_MGT_MODE_REG;
-	aty_st_le32(POWER_MANAGEMENT_LG, pm, info);
-	pm = aty_ld_le32(POWER_MANAGEMENT_LG, info);
+	aty_st_le32(POWER_MANAGEMENT_LG, pm, par);
+	pm = aty_ld_le32(POWER_MANAGEMENT_LG, par);
 
 	timeout = 200000;
 	if (sleep) {
 		/* Sleep */
 		pm &= ~PWR_MGT_ON;
-		aty_st_le32(POWER_MANAGEMENT_LG, pm, info);
-		pm = aty_ld_le32(POWER_MANAGEMENT_LG, info);
+		aty_st_le32(POWER_MANAGEMENT_LG, pm, par);
+		pm = aty_ld_le32(POWER_MANAGEMENT_LG, par);
 		udelay(10);
 		pm &= ~(PWR_BLON | AUTO_PWR_UP);
 		pm |= SUSPEND_NOW;
-		aty_st_le32(POWER_MANAGEMENT_LG, pm, info);
-		pm = aty_ld_le32(POWER_MANAGEMENT_LG, info);
+		aty_st_le32(POWER_MANAGEMENT_LG, pm, par);
+		pm = aty_ld_le32(POWER_MANAGEMENT_LG, par);
 		udelay(10);
 		pm |= PWR_MGT_ON;
-		aty_st_le32(POWER_MANAGEMENT_LG, pm, info);
+		aty_st_le32(POWER_MANAGEMENT_LG, pm, par);
 		do {
-			pm = aty_ld_le32(POWER_MANAGEMENT_LG, info);
+			pm = aty_ld_le32(POWER_MANAGEMENT_LG, par);
 			udelay(10);
 			if ((--timeout) == 0)
 				break;
@@ -1540,18 +1542,18 @@
 	} else {
 		/* Wakeup */
 		pm &= ~PWR_MGT_ON;
-		aty_st_le32(POWER_MANAGEMENT_LG, pm, info);
-		pm = aty_ld_le32(POWER_MANAGEMENT_LG, info);
+		aty_st_le32(POWER_MANAGEMENT_LG, pm, par);
+		pm = aty_ld_le32(POWER_MANAGEMENT_LG, par);
 		udelay(10);
 		pm |= (PWR_BLON | AUTO_PWR_UP);
 		pm &= ~SUSPEND_NOW;
-		aty_st_le32(POWER_MANAGEMENT_LG, pm, info);
-		pm = aty_ld_le32(POWER_MANAGEMENT_LG, info);
+		aty_st_le32(POWER_MANAGEMENT_LG, pm, par);
+		pm = aty_ld_le32(POWER_MANAGEMENT_LG, par);
 		udelay(10);
 		pm |= PWR_MGT_ON;
-		aty_st_le32(POWER_MANAGEMENT_LG, pm, info);
+		aty_st_le32(POWER_MANAGEMENT_LG, pm, par);
 		do {
-			pm = aty_ld_le32(POWER_MANAGEMENT_LG, info);
+			pm = aty_ld_le32(POWER_MANAGEMENT_LG, par);
 			udelay(10);
 			if ((--timeout) == 0)
 				break;
@@ -1562,32 +1564,32 @@
 	return timeout ? PBOOK_SLEEP_OK : PBOOK_SLEEP_REFUSE;
 }
 
-static int aty_power_mgmt_LTPro(int sleep, struct fb_info *info)
+static int aty_power_mgmt_LTPro(int sleep, struct atyfb_par *par)
 {
 	unsigned int pm;
 	int timeout;
 
-	pm = aty_ld_lcd(POWER_MANAGEMENT, info);
+	pm = aty_ld_lcd(POWER_MANAGEMENT, par);
 	pm = (pm & ~PWR_MGT_MODE_MASK) | PWR_MGT_MODE_REG;
-	aty_st_lcd(POWER_MANAGEMENT, pm, info);
-	pm = aty_ld_lcd(POWER_MANAGEMENT, info);
+	aty_st_lcd(POWER_MANAGEMENT, pm, par);
+	pm = aty_ld_lcd(POWER_MANAGEMENT, par);
 
 	timeout = 200;
 	if (sleep) {
 		/* Sleep */
 		pm &= ~PWR_MGT_ON;
-		aty_st_lcd(POWER_MANAGEMENT, pm, info);
-		pm = aty_ld_lcd(POWER_MANAGEMENT, info);
+		aty_st_lcd(POWER_MANAGEMENT, pm, par);
+		pm = aty_ld_lcd(POWER_MANAGEMENT, par);
 		udelay(10);
 		pm &= ~(PWR_BLON | AUTO_PWR_UP);
 		pm |= SUSPEND_NOW;
-		aty_st_lcd(POWER_MANAGEMENT, pm, info);
-		pm = aty_ld_lcd(POWER_MANAGEMENT, info);
+		aty_st_lcd(POWER_MANAGEMENT, pm, par);
+		pm = aty_ld_lcd(POWER_MANAGEMENT, par);
 		udelay(10);
 		pm |= PWR_MGT_ON;
-		aty_st_lcd(POWER_MANAGEMENT, pm, info);
+		aty_st_lcd(POWER_MANAGEMENT, pm, par);
 		do {
-			pm = aty_ld_lcd(POWER_MANAGEMENT, info);
+			pm = aty_ld_lcd(POWER_MANAGEMENT, par);
 			mdelay(1);
 			if ((--timeout) == 0)
 				break;
@@ -1596,18 +1598,18 @@
 	} else {
 		/* Wakeup */
 		pm &= ~PWR_MGT_ON;
-		aty_st_lcd(POWER_MANAGEMENT, pm, info);
-		pm = aty_ld_lcd(POWER_MANAGEMENT, info);
+		aty_st_lcd(POWER_MANAGEMENT, pm, par);
+		pm = aty_ld_lcd(POWER_MANAGEMENT, par);
 		udelay(10);
 		pm &= ~SUSPEND_NOW;
 		pm |= (PWR_BLON | AUTO_PWR_UP);
-		aty_st_lcd(POWER_MANAGEMENT, pm, info);
-		pm = aty_ld_lcd(POWER_MANAGEMENT, info);
+		aty_st_lcd(POWER_MANAGEMENT, pm, par);
+		pm = aty_ld_lcd(POWER_MANAGEMENT, par);
 		udelay(10);
 		pm |= PWR_MGT_ON;
-		aty_st_lcd(POWER_MANAGEMENT, pm, info);
+		aty_st_lcd(POWER_MANAGEMENT, pm, par);
 		do {
-			pm = aty_ld_lcd(POWER_MANAGEMENT, info);
+			pm = aty_ld_lcd(POWER_MANAGEMENT, par);
 			mdelay(1);
 			if ((--timeout) == 0)
 				break;
@@ -1617,10 +1619,10 @@
 	return timeout ? PBOOK_SLEEP_OK : PBOOK_SLEEP_REFUSE;
 }
 
-static int aty_power_mgmt(int sleep, struct fb_info *info)
+static int aty_power_mgmt(int sleep, struct atyfb_par *par)
 {
-	return M64_HAS(LT_SLEEP) ? aty_power_mgmt_LT(sleep, info)
-	    : aty_power_mgmt_LTPro(sleep, info);
+	return M64_HAS(LT_SLEEP) ? aty_power_mgmt_LT(sleep, par)
+	    : aty_power_mgmt_LTPro(sleep, par);
 }
 
 /*
@@ -1630,15 +1632,16 @@
 static int aty_sleep_notify(struct pmu_sleep_notifier *self, int when)
 {
 	struct fb_info *info;
-	struct atyfb_par *par = (struct atyfb_par *) info->fb.par;
+	struct atyfb_par *par;
 	int result;
 
 	result = PBOOK_SLEEP_OK;
 
-	for (info = first_display; info != NULL; info = info->next) {
+	for (info = first_display; info != NULL; info = par->next) {
 		struct fb_fix_screeninfo fix;
 		int nb;
 
+		par = (struct atyfb_par *) info->par;
 		atyfb_get_fix(&fix, fg_console, info);
 		nb = fb_display[fg_console].var.yres * fix.line_length;
 
@@ -1659,7 +1662,7 @@
 				wait_for_idle(par);
 			/* Stop accel engine (stop bus mastering) */
 			if (par->accel_flags & FB_ACCELF_TEXT)
-				aty_reset_engine(info);
+				aty_reset_engine(par);
 
 			/* Backup fb content */
 			if (par->save_framebuffer)
@@ -1670,11 +1673,11 @@
 			atyfb_blank(VESA_POWERDOWN + 1, info);
 
 			/* Set chip to "suspend" mode */
-			result = aty_power_mgmt(1, info);
+			result = aty_power_mgmt(1, par);
 			break;
 		case PBOOK_WAKE:
 			/* Wakeup chip */
-			result = aty_power_mgmt(0, info);
+			result = aty_power_mgmt(0, par);
 
 			/* Restore fb content */
 			if (par->save_framebuffer) {
@@ -1684,7 +1687,7 @@
 				par->save_framebuffer = 0;
 			}
 			/* Restore display */
-			atyfb_set_par(par->par, info);
+			atyfb_set_par(par, info);
 			atyfb_blank(0, info);
 			break;
 		}
@@ -1711,7 +1714,8 @@
 static int aty_set_backlight_enable(int on, int level, void *data)
 {
 	struct fb_info *info = (struct fb_info *) data;
-	unsigned int reg = aty_ld_lcd(LCD_MISC_CNTL, info);
+	struct atyfb_par *par = (struct atyfb_par *) info->par;
+	unsigned int reg = aty_ld_lcd(LCD_MISC_CNTL, par);
 
 	reg |= (BLMOD_EN | BIASMOD_EN);
 	if (on && level > BACKLIGHT_OFF) {
@@ -1721,7 +1725,7 @@
 		reg &= ~BIAS_MOD_LEVEL_MASK;
 		reg |= (backlight_conv[0] << BIAS_MOD_LEVEL_SHIFT);
 	}
-	aty_st_lcd(LCD_MISC_CNTL, reg, info);
+	aty_st_lcd(LCD_MISC_CNTL, reg, par);
 
 	return 0;
 }
@@ -1784,7 +1788,7 @@
 	if (!M64_HAS(INTEGRATED)) {
 		u32 stat0;
 		u8 dac_type, dac_subtype, clk_type;
-		stat0 = aty_ld_le32(CONFIG_STAT0, info);
+		stat0 = aty_ld_le32(CONFIG_STAT0, par);
 		par->bus_type = (stat0 >> 0) & 0x07;
 		par->ram_type = (stat0 >> 3) & 0x07;
 		ramname = aty_gx_ram[par->ram_type];
@@ -2093,7 +2097,7 @@
 					default_vmode = VMODE_800_600_60;
 				else
 					default_vmode = VMODE_640_480_67;
-				sense = read_aty_sense(info);
+				sense = read_aty_sense(par);
 				printk(KERN_INFO
 				       "atyfb: monitor sense=%x, mode %d\n",
 				       sense,
@@ -2187,6 +2191,7 @@
 	struct fb_info *info;
 	unsigned long addr, res_start, res_size;
 	int i;
+	struct atyfb_par *default_par;
 #ifdef __sparc__
 	extern void (*prom_palette) (int);
 	extern int con_is_present(void);
@@ -2201,7 +2206,6 @@
 #else
 	u16 tmp;
 #endif
-	struct atyfb_par *default_par;
 
 	while ((pdev =
 		pci_find_device(PCI_VENDOR_ID_ATI, PCI_ANY_ID, pdev))) {
@@ -2258,7 +2262,7 @@
 			/*
 			 * Map memory-mapped registers.
 			 */
-			par->ati_regbase = addr + 0x7ffc00UL;
+			default_par->ati_regbase = addr + 0x7ffc00UL;
 			info->fix.mmio_start = addr + 0x7ffc00UL;
 
 			/*
@@ -2389,7 +2393,7 @@
 						mem &= ~(0x00700000);
 				}
 				mem &= ~(0xcf80e000);	/* Turn off all undocumented bits. */
-				aty_st_le32(MEM_CNTL, mem, info);
+				aty_st_le32(MEM_CNTL, mem, default_par);
 			}
 
 			/*
@@ -2555,28 +2559,28 @@
 			/*
 			 * Add /dev/fb mmap values.
 			 */
-			par->mmap_map[0].voff = 0x8000000000000000UL;
-			par->mmap_map[0].poff =
+			default_par->mmap_map[0].voff = 0x8000000000000000UL;
+			default_par->mmap_map[0].poff =
 			    info->screen_base & PAGE_MASK;
-			par->mmap_map[0].size =
+			default_par->mmap_map[0].size =
 			    info->fix.smem_len;
-			par->mmap_map[0].prot_mask = _PAGE_CACHE;
-			par->mmap_map[0].prot_flag = _PAGE_E;
-			par->mmap_map[1].voff =
-			    par->mmap_map[0].voff +
+			default_par->mmap_map[0].prot_mask = _PAGE_CACHE;
+			default_par->mmap_map[0].prot_flag = _PAGE_E;
+			default_par->mmap_map[1].voff =
+			    default_par->mmap_map[0].voff +
 			    info->fix.smem_len;
-			par->mmap_map[1].poff =
-			    par->ati_regbase & PAGE_MASK;
-			par->mmap_map[1].size = PAGE_SIZE;
-			par->mmap_map[1].prot_mask = _PAGE_CACHE;
-			par->mmap_map[1].prot_flag = _PAGE_E;
+			default_par->mmap_map[1].poff =
+			    default_par->ati_regbase & PAGE_MASK;
+			default_par->mmap_map[1].size = PAGE_SIZE;
+			default_par->mmap_map[1].prot_mask = _PAGE_CACHE;
+			default_par->mmap_map[1].prot_flag = _PAGE_E;
 #endif				/* __sparc__ */
 
 #ifdef CONFIG_PMAC_PBOOK
 			if (first_display == NULL)
 				pmu_register_sleep_notifier
 				    (&aty_sleep_notifier);
-			/* FIXME info->next = first_display; */
+			default_par->next = first_display;
 			first_display = info;
 #endif
 		}
@@ -2610,25 +2614,25 @@
 		info->screen_base = (unsigned long)ioremap(phys_vmembase[m64_num],
 					 		   phys_size[m64_num]);	
 		info->fix.smem_start = info->screen_base;	/* Fake! */
-		par->ati_regbase = (unsigned long)ioremap(phys_guiregbase[m64_num],
+		default_par->ati_regbase = (unsigned long)ioremap(phys_guiregbase[m64_num],
 							  0x10000) + 0xFC00ul;
-		info->fix.mmio_start = par->ati_regbase; /* Fake! */
+		info->fix.mmio_start = default_par->ati_regbase; /* Fake! */
 
-		aty_st_le32(CLOCK_CNTL, 0x12345678, info);
-		clock_r = aty_ld_le32(CLOCK_CNTL, info);
+		aty_st_le32(CLOCK_CNTL, 0x12345678, default_par);
+		clock_r = aty_ld_le32(CLOCK_CNTL, default_par);
 
 		switch (clock_r & 0x003F) {
 		case 0x12:
-			par->clk_wr_offset = 3;	/*  */
+			default_par->clk_wr_offset = 3;	/*  */
 			break;
 		case 0x34:
-			par->clk_wr_offset = 2;	/* Medusa ST-IO ISA Adapter etc. */
+			default_par->clk_wr_offset = 2;	/* Medusa ST-IO ISA Adapter etc. */
 			break;
 		case 0x16:
-			par->clk_wr_offset = 1;	/*  */
+			default_par->clk_wr_offset = 1;	/*  */
 			break;
 		case 0x38:
-			par->clk_wr_offset = 0;	/* Panther 1 ISA Adapter (Gerald) */
+			default_par->clk_wr_offset = 0;	/* Panther 1 ISA Adapter (Gerald) */
 			break;
 		}
 
diff -urN linux-2.5/drivers/video/aty/mach64_accel.c pmac-2.5/drivers/video/aty/mach64_accel.c
--- linux-2.5/drivers/video/aty/mach64_accel.c	Thu Jul 25 09:57:53 2002
+++ pmac-2.5/drivers/video/aty/mach64_accel.c	Fri Jul 26 18:34:39 2002
@@ -340,7 +340,7 @@
 		     fbcon_cfb##width##_clear_margins(conp, p, bottom_only), \
 		     int bottom_only) \
  \
-const struct display_switch fbcon_aty##width = { \
+struct display_switch fbcon_aty##width = { \
     setup:		fbcon_cfb##width##_setup, \
     bmove:		fbcon_aty_bmove, \
     clear:		fbcon_aty_clear, \
diff -urN linux-2.5/drivers/video/offb.c pmac-2.5/drivers/video/offb.c
--- linux-2.5/drivers/video/offb.c	Thu Jul 25 09:57:53 2002
+++ pmac-2.5/drivers/video/offb.c	Thu Jul 25 22:45:36 2002
@@ -399,7 +399,6 @@
 	struct fb_fix_screeninfo *fix;
 	struct fb_var_screeninfo *var;
 	struct fb_info *info;
-	int i;
 
 	if (!request_mem_region(res_start, res_size, "offb"))
 		return;
@@ -465,7 +464,7 @@
 			unsigned long base = address & 0xff000000UL;
 			par->cmap_adr =
 			    ioremap(base + 0x7ff000, 0x1000) + 0xcc0;
-			par->cmap_data = info->cmap_adr + 1;
+			par->cmap_data = par->cmap_adr + 1;
 			par->cmap_type = cmap_m64;
 		} else if (device_is_compatible(dp, "pci1014,b7")) {
 			unsigned long regbase = dp->addrs[0].address;
@@ -555,7 +554,7 @@
 	}
 
 	printk(KERN_INFO "fb%d: Open Firmware frame buffer device on %s\n",
-	       GET_FB_IDX(info->info.node), full_name);
+	       GET_FB_IDX(info->node), full_name);
 }
 
 MODULE_LICENSE("GPL");
