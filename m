Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131634AbRCXKs2>; Sat, 24 Mar 2001 05:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131638AbRCXKsP>; Sat, 24 Mar 2001 05:48:15 -0500
Received: from ns1.samba.org ([203.17.0.92]:35684 "HELO au2.samba.org")
	by vger.kernel.org with SMTP id <S131634AbRCXKr4>;
	Sat, 24 Mar 2001 05:47:56 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15036.30938.433792.953474@argo.linuxcare.com.au>
Date: Sat, 24 Mar 2001 21:37:14 +1100 (EST)
To: torvalds@transmeta.com
Cc: cort@fsmlabs.com, benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [RESEND] update chipsfb driver
X-Mailer: VM 6.75 under Emacs 20.4.1
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

At present, drivers/video/chipsfb.c can only be used on PPC, and it
doesn't compile even on PPC.  The patch below makes it compile, and by
changing it to use the generic inb/outb, means that there is at least
a chance it can be used on other platforms.  The patch is against
2.4.3-pre7, could you apply it please?

Paul.

diff -urN linux/drivers/video/chipsfb.c pmac/drivers/video/chipsfb.c
--- linux/drivers/video/chipsfb.c	Thu Feb 22 14:25:27 2001
+++ pmac/drivers/video/chipsfb.c	Sat Mar  3 21:17:19 2001
@@ -29,17 +29,19 @@
 #include <linux/selection.h>
 #include <linux/init.h>
 #include <linux/pci.h>
+#include <asm/io.h>
+
 #ifdef CONFIG_FB_COMPAT_XPMAC
 #include <asm/vc_ioctl.h>
-#endif
-#include <asm/io.h>
-#include <asm/prom.h>
 #include <asm/pci-bridge.h>
+#endif
 #ifdef CONFIG_PMAC_BACKLIGHT
 #include <asm/backlight.h>
 #endif
+#ifdef CONFIG_PMAC_PBOOK
 #include <linux/adb.h>
 #include <linux/pmu.h>
+#endif
 
 #include <video/fbcon.h>
 #include <video/fbcon-cfb8.h>
@@ -56,14 +58,13 @@
 	struct {
 		__u8 red, green, blue;
 	} palette[256];
+	struct pci_dev *pdev;
 	unsigned long frame_buffer_phys;
 	__u8 *frame_buffer;
 	unsigned long blitter_regs_phys;
 	__u32 *blitter_regs;
 	unsigned long blitter_data_phys;
 	__u8 *blitter_data;
-	unsigned long io_base_phys;
-	__u8 *io_base;
 	struct fb_info_chips *next;
 #ifdef CONFIG_PMAC_PBOOK
 	unsigned char *save_framebuffer;
@@ -74,10 +75,10 @@
 };
 
 #define write_ind(num, val, ap, dp)	do { \
-	out_8(p->io_base + (ap), (num)); out_8(p->io_base + (dp), (val)); \
+	outb((num), (ap)); outb((val), (dp)); \
 } while (0)
 #define read_ind(num, var, ap, dp)	do { \
-	out_8(p->io_base + (ap), (num)); var = in_8(p->io_base + (dp)); \
+	outb((num), (ap)); var = inb((dp)); \
 } while (0);
 
 /* extension registers */
@@ -97,10 +98,10 @@
 #define read_sr(num, var)	read_ind(num, var, 0x3c4, 0x3c5)
 /* attribute registers - slightly strange */
 #define write_ar(num, val)	do { \
-	in_8(p->io_base + 0x3da); write_ind(num, val, 0x3c0, 0x3c0); \
+	inb(0x3da); write_ind(num, val, 0x3c0, 0x3c0); \
 } while (0)
 #define read_ar(num, var)	do { \
-	in_8(p->io_base + 0x3da); read_ind(num, var, 0x3c0, 0x3c1); \
+	inb(0x3da); read_ind(num, var, 0x3c0, 0x3c1); \
 } while (0)
 
 static struct fb_info_chips *all_chips;
@@ -117,7 +118,7 @@
  */
 int chips_init(void);
 
-static void chips_of_init(struct device_node *dp);
+static void chips_pci_init(struct pci_dev *dp);
 static int chips_get_fix(struct fb_fix_screeninfo *fix, int con,
 			 struct fb_info *info);
 static int chips_get_var(struct fb_var_screeninfo *var, int con,
@@ -253,29 +254,29 @@
 #endif /* CONFIG_PMAC_BACKLIGHT */
 		/* get the palette from the chip */
 		for (i = 0; i < 256; ++i) {
-			out_8(p->io_base + 0x3c7, i);
+			outb(i, 0x3c7);
 			udelay(1);
-			p->palette[i].red = in_8(p->io_base + 0x3c9);
-			p->palette[i].green = in_8(p->io_base + 0x3c9);
-			p->palette[i].blue = in_8(p->io_base + 0x3c9);
+			p->palette[i].red = inb(0x3c9);
+			p->palette[i].green = inb(0x3c9);
+			p->palette[i].blue = inb(0x3c9);
 		}
 		for (i = 0; i < 256; ++i) {
-			out_8(p->io_base + 0x3c8, i);
+			outb(i, 0x3c8);
 			udelay(1);
-			out_8(p->io_base + 0x3c9, 0);
-			out_8(p->io_base + 0x3c9, 0);
-			out_8(p->io_base + 0x3c9, 0);
+			outb(0, 0x3c9);
+			outb(0, 0x3c9);
+			outb(0, 0x3c9);
 		}
 	} else {
 #ifdef CONFIG_PMAC_BACKLIGHT
 		set_backlight_enable(1);
 #endif /* CONFIG_PMAC_BACKLIGHT */
 		for (i = 0; i < 256; ++i) {
-			out_8(p->io_base + 0x3c8, i);
+			outb(i, 0x3c8);
 			udelay(1);
-			out_8(p->io_base + 0x3c9, p->palette[i].red);
-			out_8(p->io_base + 0x3c9, p->palette[i].green);
-			out_8(p->io_base + 0x3c9, p->palette[i].blue);
+			outb(p->palette[i].red, 0x3c9);
+			outb(p->palette[i].green, 0x3c9);
+			outb(p->palette[i].blue, 0x3c9);
 		}
 	}
 }
@@ -307,11 +308,11 @@
 	p->palette[regno].red = red;
 	p->palette[regno].green = green;
 	p->palette[regno].blue = blue;
-	out_8(p->io_base + 0x3c8, regno);
+	outb(regno, 0x3c8);
 	udelay(1);
-	out_8(p->io_base + 0x3c9, red);
-	out_8(p->io_base + 0x3c9, green);
-	out_8(p->io_base + 0x3c9, blue);
+	outb(red, 0x3c9);
+	outb(green, 0x3c9);
+	outb(blue, 0x3c9);
 
 #ifdef FBCON_HAS_CFB16
 	if (regno < 16)
@@ -388,7 +389,7 @@
 	disp->visual = fix->visual;
 	disp->var = *var;
 
-#if (defined(CONFIG_PMAC_PBOOK) || defined(CONFIG_FB_COMPAT_XPMAC))
+#ifdef CONFIG_FB_COMPAT_XPMAC
 	display_info.depth = bpp;
 	display_info.pitch = fix->line_length;
 #endif
@@ -517,7 +518,7 @@
 
 	for (i = 0; i < N_ELTS(chips_init_xr); ++i)
 		write_xr(chips_init_xr[i].addr, chips_init_xr[i].data);
-	out_8(p->io_base + 0x3c2, 0x29); /* set misc output reg */
+	outb(0x29, 0x3c2); /* set misc output reg */
 	for (i = 0; i < N_ELTS(chips_init_sr); ++i)
 		write_sr(chips_init_sr[i].addr, chips_init_sr[i].data);
 	for (i = 0; i < N_ELTS(chips_init_gr); ++i)
@@ -545,7 +546,6 @@
 // * 3400 has 1MB (I think).  Don't know if it's expandable.
 // -- Tim Seufert
 	p->fix.smem_len = 0x100000;	// 1MB
-	p->fix.mmio_start = p->io_base_phys;
 	p->fix.type = FB_TYPE_PACKED_PIXELS;
 	p->fix.visual = FB_VISUAL_PSEUDOCOLOR;
 	p->fix.line_length = 800;
@@ -607,6 +607,8 @@
 
 #ifdef CONFIG_FB_COMPAT_XPMAC
 	if (!console_fb_info) {
+		unsigned long iobase;
+
 		display_info.height = p->var.yres;
 		display_info.width = p->var.xres;
 		display_info.depth = 8;
@@ -615,8 +617,9 @@
 		strncpy(display_info.name, "chips65550",
 			sizeof(display_info.name));
 		display_info.fb_address = p->frame_buffer_phys;
-		display_info.cmap_adr_address = p->io_base_phys + 0x3c8;
-		display_info.cmap_data_address = p->io_base_phys + 0x3c9;
+		iobase = pci_bus_io_base_phys(p->pdev->bus->number);
+		display_info.cmap_adr_address = iobase + 0x3c8;
+		display_info.cmap_data_address = iobase + 0x3c9;
 		display_info.disp_reg_address = p->blitter_regs_phys;
 		console_fb_info = &p->info;
 	}
@@ -632,35 +635,39 @@
 
 int __init chips_init(void)
 {
-	struct device_node *dp;
+	struct pci_dev *dp = NULL;
 
-	dp = find_devices("chips65550");
-	if (dp != 0)
-		chips_of_init(dp);
-	return 0;
+	while ((dp = pci_find_device(PCI_VENDOR_ID_CT,
+				     PCI_DEVICE_ID_CT_65550, dp)) != NULL)
+		if ((dp->class >> 16) == PCI_BASE_CLASS_DISPLAY)
+			chips_pci_init(dp);
+	return all_chips? 0: -ENODEV;
 }
 
-static void __init chips_of_init(struct device_node *dp)
+static void __init chips_pci_init(struct pci_dev *dp)
 {
 	struct fb_info_chips *p;
-	unsigned long addr;
-	unsigned char bus, devfn;
+	unsigned long addr, size;
 	unsigned short cmd;
 
-	if (dp->n_addrs == 0)
+	if ((dp->resource[0].flags & IORESOURCE_MEM) == 0)
+		return;
+	addr = dp->resource[0].start;
+	size = dp->resource[0].end + 1 - addr;
+	if (addr == 0)
 		return;
 	p = kmalloc(sizeof(*p), GFP_ATOMIC);
 	if (p == 0)
 		return;
 	memset(p, 0, sizeof(*p));
-	addr = dp->addrs[0].address;
-	if (!request_mem_region(addr, dp->addrs[0].size, "chipsfb")) {
+	if (!request_mem_region(addr, size, "chipsfb")) {
 		kfree(p);
 		return;
 	}
 #ifdef __BIG_ENDIAN
 	addr += 0x800000;	// Use big-endian aperture
 #endif
+	p->pdev = dp;
 	p->frame_buffer_phys = addr;
 	p->frame_buffer = __ioremap(addr, 0x200000, _PAGE_NO_CACHE);
 	p->blitter_regs_phys = addr + 0x400000;
@@ -668,14 +675,12 @@
 	p->blitter_data_phys = addr + 0x410000;
 	p->blitter_data = ioremap(addr + 0x410000, 0x10000);
 
-	if (pci_device_loc(dp, &bus, &devfn) == 0) {
-		pcibios_read_config_word(bus, devfn, PCI_COMMAND, &cmd);
-		cmd |= 3;	/* enable memory and IO space */
-		pcibios_write_config_word(bus, devfn, PCI_COMMAND, cmd);
-		p->io_base = (__u8 *) pci_io_base(bus);
-		/* XXX really want the physical address here */
-		p->io_base_phys = (unsigned long) pci_io_base(bus);
-	}
+	/* we should use pci_enable_device here, but,
+	   the device doesn't declare its I/O ports in its BARs
+	   so pci_enable_device won't turn on I/O responses */
+	pci_read_config_word(dp, PCI_COMMAND, &cmd);
+	cmd |= 3;	/* enable memory and IO space */
+	pci_write_config_word(dp, PCI_COMMAND, cmd);
 
 	/* Clear the entire framebuffer */
 	memset(p->frame_buffer, 0, 0x100000);
