Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267425AbTA1RCX>; Tue, 28 Jan 2003 12:02:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267426AbTA1RCW>; Tue, 28 Jan 2003 12:02:22 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:2564 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S267425AbTA1RCG>; Tue, 28 Jan 2003 12:02:06 -0500
Date: Tue, 28 Jan 2003 20:10:57 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Martin Mares <mj@ucw.cz>, Richard Henderson <rth@twiddle.net>,
       "Wiedemeier, Jeff" <Jeff.Wiedemeier@hp.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2.5] VGA IO on systems with multiple PCI IO domains
Message-ID: <20030128201057.A690@jurassic.park.msu.ru>
References: <20030128132406.A9195@jurassic.park.msu.ru> <Pine.GSO.4.21.0301281126390.9269-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0301281126390.9269-100000@vervain.sonytel.be>; from geert@linux-m68k.org on Tue, Jan 28, 2003 at 11:27:21AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's the patch that converts vgacon.c to pci_request_legacy_resource().
Tested on i386 and a single-bus alpha (alpha specific bits not included
here).

Note that it breaks ppc, as VGA_MAP_MEM() is removed...

Ivan.


diff -urpN 2.5.59/drivers/video/console/vgacon.c linux/drivers/video/console/vgacon.c
--- 2.5.59/drivers/video/console/vgacon.c	Fri Jan 17 05:22:05 2003
+++ linux/drivers/video/console/vgacon.c	Tue Jan 28 15:54:41 2003
@@ -47,8 +47,8 @@
 #include <linux/vt_kern.h>
 #include <linux/selection.h>
 #include <linux/spinlock.h>
-#include <linux/ioport.h>
 #include <linux/init.h>
+#include <linux/pci.h>
 
 #include <asm/io.h>
 
@@ -66,15 +66,15 @@ static spinlock_t vga_lock = SPIN_LOCK_U
  */
 #undef TRIDENT_GLITCH
 
-#define dac_reg		0x3c8
-#define dac_val		0x3c9
-#define attrib_port	0x3c0
-#define seq_port_reg	0x3c4
-#define seq_port_val	0x3c5
-#define gr_port_reg	0x3ce
-#define gr_port_val	0x3cf
-#define video_misc_rd	0x3cc
-#define video_misc_wr	0x3c2
+#define dac_reg		(console_resource->start + 0x8)
+#define dac_val		(console_resource->start + 0x9)
+#define attrib_port	(console_resource->start + 0x0)
+#define seq_port_reg	(console_resource->start + 0x4)
+#define seq_port_val	(console_resource->start + 0x5)
+#define gr_port_reg	(console_resource->start + 0xe)
+#define gr_port_val	(console_resource->start + 0xf)
+#define video_misc_rd	(console_resource->start + 0xc)
+#define video_misc_wr	(console_resource->start + 0x2)
 
 /*
  *  Interface used by the world
@@ -100,8 +100,8 @@ static unsigned long vgacon_uni_pagedir[
 /* Description of the hardware situation */
 static unsigned long   vga_vram_base;		/* Base of video memory */
 static unsigned long   vga_vram_end;		/* End of video memory */
-static u16             vga_video_port_reg;	/* Video register select port */
-static u16             vga_video_port_val;	/* Video register value port */
+static unsigned long   vga_video_port_reg;	/* Video register select port */
+static unsigned long   vga_video_port_val;	/* Video register value port */
 static unsigned int    vga_video_num_columns;	/* Number of text columns */
 static unsigned int    vga_video_num_lines;	/* Number of text lines */
 static int	       vga_can_do_color = 0;	/* Do we support colors? */
@@ -116,6 +116,7 @@ static int	       vga_is_gfx;
 static int	       vga_512_chars;
 static int	       vga_video_font_height;
 static unsigned int    vga_rolled_over = 0;
+static struct resource *console_resource;
 
 
 static int __init no_scroll(char *str)
@@ -166,6 +167,9 @@ static inline void write_vga(unsigned ch
 static const char __init *vgacon_startup(void)
 {
 	const char *display_desc = NULL;
+	static struct resource console_mem_resource = { "Video RAM area", 0, 0,
+							IORESOURCE_MEM };
+	unsigned long vram_size;
 	u16 saved1, saved2;
 	volatile u16 *p;
 
@@ -193,34 +197,35 @@ static const char __init *vgacon_startup
 	if (ORIG_VIDEO_MODE == 7)	/* Is this a monochrome display? */
 	{
 		vga_vram_base = 0xb0000;
-		vga_video_port_reg = 0x3b4;
-		vga_video_port_val = 0x3b5;
 		if ((ORIG_VIDEO_EGA_BX & 0xff) != 0x10)
 		{
-			static struct resource ega_console_resource = { "ega", 0x3B0, 0x3BF };
+			static struct resource ega_console_resource = { "ega", 0x3B0, 0x3BF, IORESOURCE_IO };
 			vga_video_type = VIDEO_TYPE_EGAM;
 			vga_vram_end = 0xb8000;
 			display_desc = "EGA+";
-			request_resource(&ioport_resource, &ega_console_resource);
+			console_resource = &ega_console_resource;
 		}
 		else
 		{
-			static struct resource mda1_console_resource = { "mda", 0x3B0, 0x3BB };
-			static struct resource mda2_console_resource = { "mda", 0x3BF, 0x3BF };
+			static struct resource mda1_console_resource = { "mda", 0x3B0, 0x3BB, IORESOURCE_IO };
+			static struct resource mda2_console_resource = { "mda", 0x3BF, 0x3BF, IORESOURCE_IO };
 			vga_video_type = VIDEO_TYPE_MDA;
 			vga_vram_end = 0xb2000;
 			display_desc = "*MDA";
-			request_resource(&ioport_resource, &mda1_console_resource);
-			request_resource(&ioport_resource, &mda2_console_resource);
+			if (pci_request_legacy_resource(NULL, &mda2_console_resource) < 0)
+				goto no_vga;
+			console_resource = &mda1_console_resource;
 			vga_video_font_height = 14;
 		}
+		if (pci_request_legacy_resource(NULL, console_resource) < 0)
+			goto no_vga;
+		vga_video_port_reg = console_resource->start + 0x4;	/* 0x3b4 */
+		vga_video_port_val = console_resource->start + 0x5;	/* 0x3b5 */
 	}
 	else				/* If not, it is color. */
 	{
 		vga_can_do_color = 1;
 		vga_vram_base = 0xb8000;
-		vga_video_port_reg = 0x3d4;
-		vga_video_port_val = 0x3d5;
 		if ((ORIG_VIDEO_EGA_BX & 0xff) != 0x10)
 		{
 			int i;
@@ -228,15 +233,19 @@ static const char __init *vgacon_startup
 			vga_vram_end = 0xc0000;
 
 			if (!ORIG_VIDEO_ISVGA) {
-				static struct resource ega_console_resource = { "ega", 0x3C0, 0x3DF };
+				static struct resource ega_console_resource = { "ega", 0x3C0, 0x3DF, IORESOURCE_IO };
 				vga_video_type = VIDEO_TYPE_EGAC;
 				display_desc = "EGA";
-				request_resource(&ioport_resource, &ega_console_resource);
+				console_resource = &ega_console_resource;
+				if (pci_request_legacy_resource(NULL, console_resource) < 0)
+					goto no_vga;
 			} else {
-				static struct resource vga_console_resource = { "vga+", 0x3C0, 0x3DF };
+				static struct resource vga_console_resource = { "vga+", 0x3C0, 0x3DF, IORESOURCE_IO };
 				vga_video_type = VIDEO_TYPE_VGAC;
 				display_desc = "VGA+";
-				request_resource(&ioport_resource, &vga_console_resource);
+				console_resource = &vga_console_resource;
+				if (pci_request_legacy_resource(NULL, console_resource) < 0)
+					goto no_vga;
 
 #ifdef VGA_CAN_DO_64KB
 				/*
@@ -247,8 +256,8 @@ static const char __init *vgacon_startup
 				 */
 				vga_vram_base = 0xa0000;
 				vga_vram_end = 0xb0000;
-				outb_p (6, 0x3ce) ;
-				outb_p (6, 0x3cf) ;
+				outb_p (6, gr_port_reg) ;
+				outb_p (6, gr_port_val) ;
 #endif
 
 				/*
@@ -258,36 +267,47 @@ static const char __init *vgacon_startup
 				 */
 
 				for (i=0; i<16; i++) {
-					inb_p (0x3da) ;
-					outb_p (i, 0x3c0) ;
-					outb_p (i, 0x3c0) ;
+					inb_p (console_resource->start + 0x1a) ; /* 0x3da */
+					outb_p (i, attrib_port) ;
+					outb_p (i, attrib_port) ;
 				}
-				outb_p (0x20, 0x3c0) ;
+				outb_p (0x20, attrib_port) ;
 
 				/* now set the DAC registers back to their
 				 * default values */
 
 				for (i=0; i<16; i++) {
-					outb_p (color_table[i], 0x3c8) ;
-					outb_p (default_red[i], 0x3c9) ;
-					outb_p (default_grn[i], 0x3c9) ;
-					outb_p (default_blu[i], 0x3c9) ;
+					outb_p (color_table[i], dac_reg) ;
+					outb_p (default_red[i], dac_val) ;
+					outb_p (default_grn[i], dac_val) ;
+					outb_p (default_blu[i], dac_val) ;
 				}
 			}
+			vga_video_port_reg = console_resource->start + 0x14; /* 0x3d4 */
+			vga_video_port_val = console_resource->start + 0x15; /* 0x3d5 */
 		}
 		else
 		{
-			static struct resource cga_console_resource = { "cga", 0x3D4, 0x3D5 };
+			static struct resource cga_console_resource = { "cga", 0x3D4, 0x3D5, IORESOURCE_IO };
 			vga_video_type = VIDEO_TYPE_CGA;
 			vga_vram_end = 0xba000;
 			display_desc = "*CGA";
-			request_resource(&ioport_resource, &cga_console_resource);
+			console_resource = &cga_console_resource;
+			if (pci_request_legacy_resource(NULL, console_resource) < 0)
+				goto no_vga;
 			vga_video_font_height = 8;
+			vga_video_port_reg = console_resource->start + 0x0; /* 0x3d4 */
+			vga_video_port_val = console_resource->start + 0x1; /* 0x3d5 */
 		}
 	}
 
-	vga_vram_base = VGA_MAP_MEM(vga_vram_base);
-	vga_vram_end = VGA_MAP_MEM(vga_vram_end);
+	console_mem_resource.start = vga_vram_base;
+	console_mem_resource.end = vga_vram_end - 1;
+	pci_request_legacy_resource(NULL, &console_mem_resource);
+	vram_size = vga_vram_end - vga_vram_base;
+	vga_vram_base = (unsigned long)ioremap(console_mem_resource.start,
+					       vram_size);
+	vga_vram_end = vga_vram_base + vram_size;
 
 	/*
 	 *	Find out if there is a graphics card present.
@@ -697,10 +717,10 @@ static int vgacon_blank(struct vc_data *
 
 #ifdef CAN_LOAD_EGA_FONTS
 
-#define colourmap 0xa0000
+#define colourmap 	(vga_vram_base & ~0x1ffffUL)	/* 0xa0000 */
 /* Pauline Middelink <middelin@polyware.iaf.nl> reports that we
    should use 0xA0000 for the bwmap as well.. */
-#define blackwmap 0xa0000
+#define blackwmap 	(vga_vram_base & ~0x1ffffUL)	/* 0xa0000 */
 #define cmapsz 8192
 
 static int
@@ -713,14 +733,14 @@ vgacon_do_font_op(char *arg, int set, in
 	int font_select = 0x00;
 
 	if (vga_video_type != VIDEO_TYPE_EGAM) {
-		charmap = (char *)VGA_MAP_MEM(colourmap);
+		charmap = (char *)(colourmap);
 		beg = 0x0e;
 #ifdef VGA_CAN_DO_64KB
 		if (vga_video_type == VIDEO_TYPE_VGAC)
 			beg = 0x06;
 #endif
 	} else {
-		charmap = (char *)VGA_MAP_MEM(blackwmap);
+		charmap = (char *)(blackwmap);
 		beg = 0x0a;
 	}
 	
diff -urpN 2.5.59/include/linux/pci.h linux/include/linux/pci.h
--- 2.5.59/include/linux/pci.h	Fri Jan 17 05:22:08 2003
+++ linux/include/linux/pci.h	Tue Jan 28 15:53:02 2003
@@ -677,6 +677,17 @@ extern struct pci_dev *isa_bridge;
 
 #include <asm/pci.h>
 
+#ifndef __HAVE_ARCH_LEGACY_REMAP
+/* Default for architectures with a single I/O address space. */
+static inline int
+pci_request_legacy_resource(struct pci_bus *bus, struct resource *res)
+{
+	struct resource *root = res->flags & IORESOURCE_IO ?
+				&ioport_resource : &iomem_resource;
+	return request_resource(root, res);
+}
+#endif
+
 /*
  *  If the system does not have PCI, clearly these return errors.  Define
  *  these as simple inline functions to avoid hair in drivers.
