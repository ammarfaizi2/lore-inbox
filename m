Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265725AbTA2P6N>; Wed, 29 Jan 2003 10:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266175AbTA2P6N>; Wed, 29 Jan 2003 10:58:13 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:3332 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S265725AbTA2P6G>; Wed, 29 Jan 2003 10:58:06 -0500
Date: Wed, 29 Jan 2003 19:06:47 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Martin Mares <mj@ucw.cz>,
       Richard Henderson <rth@twiddle.net>,
       "Wiedemeier, Jeff" <Jeff.Wiedemeier@hp.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2.5] VGA IO on systems with multiple PCI IO domains
Message-ID: <20030129190647.A689@jurassic.park.msu.ru>
References: <20030128132406.A9195@jurassic.park.msu.ru> <Pine.GSO.4.21.0301281126390.9269-100000@vervain.sonytel.be> <20030128201057.A690@jurassic.park.msu.ru> <1043774595.536.4.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1043774595.536.4.camel@zion.wanadoo.fr>; from benh@kernel.crashing.org on Tue, Jan 28, 2003 at 06:23:15PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2003 at 06:23:15PM +0100, Benjamin Herrenschmidt wrote:
> Disabling VGA dynamically depending on the machine have been a real pain
> until now. With that change, it will now just be a matter for our PPC
> implementation of pci_request_legacy_resource() to fail on machines
> where VGA memory can't be reached.

Here's updated version of yesterday's patch that makes this possible.
- pci_request_legacy_resource() is supposed to return two error codes:
  -ENXIO (no such device or address), which must be treated as fatal;
  -EBUSY, returned by request_resource() in the case of resource conflict,
  like i386 case where the startup code reserves certain low memory regions
  including video memory. This error can be ignored for now (at least in the
  vgacon driver), because resource start/end fields are correctly adjusted
  anyway.
- Fixed bug wrt adjusting static struct resource (thanks to Jeff for
  finding that). The vgacon can be started twice: early on startup and,
  if this fails because we assumed the wrong bus, after PCI init when we
  actually located the VGA card. However, static VGA resources are already
  "fixed" after the first try, so the second attempt fails as well.
- Make no_vga case to release VGA resources.

Ivan.

diff -urpN 2.5.59/drivers/video/console/vgacon.c linux/drivers/video/console/vgacon.c
--- 2.5.59/drivers/video/console/vgacon.c	Fri Jan 17 05:22:05 2003
+++ linux/drivers/video/console/vgacon.c	Wed Jan 29 16:40:58 2003
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
+#define dac_reg		(console_io.start + 0x8)
+#define dac_val		(console_io.start + 0x9)
+#define attrib_port	(console_io.start + 0x0)
+#define seq_port_reg	(console_io.start + 0x4)
+#define seq_port_val	(console_io.start + 0x5)
+#define gr_port_reg	(console_io.start + 0xe)
+#define gr_port_val	(console_io.start + 0xf)
+#define video_misc_rd	(console_io.start + 0xc)
+#define video_misc_wr	(console_io.start + 0x2)
 
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
@@ -116,7 +116,11 @@ static int	       vga_is_gfx;
 static int	       vga_512_chars;
 static int	       vga_video_font_height;
 static unsigned int    vga_rolled_over = 0;
-
+static struct resource console_io   = {	.flags	= IORESOURCE_IO, };
+static struct resource console_io1  = { .name	= "mda",
+					.flags	= IORESOURCE_IO, };
+static struct resource console_mem  = {	.name	= "Video RAM",
+					.flags	= IORESOURCE_MEM, };
 
 static int __init no_scroll(char *str)
 {
@@ -166,11 +170,18 @@ static inline void write_vga(unsigned ch
 static const char __init *vgacon_startup(void)
 {
 	const char *display_desc = NULL;
+	unsigned long vram_size;
 	u16 saved1, saved2;
 	volatile u16 *p;
 
 	if (ORIG_VIDEO_ISVGA == VIDEO_TYPE_VLFB) {
 	no_vga:
+		if (console_io.parent)
+			release_resource(&console_io);
+		if (console_io1.parent)
+			release_resource(&console_io1);
+		if (console_mem.parent)
+			release_resource(&console_mem);
 #ifdef CONFIG_DUMMY_CONSOLE
 		conswitchp = &dummy_con;
 		return conswitchp->con_startup();
@@ -193,51 +204,57 @@ static const char __init *vgacon_startup
 	if (ORIG_VIDEO_MODE == 7)	/* Is this a monochrome display? */
 	{
 		vga_vram_base = 0xb0000;
-		vga_video_port_reg = 0x3b4;
-		vga_video_port_val = 0x3b5;
+		console_io.start = 0x3b0;
+
 		if ((ORIG_VIDEO_EGA_BX & 0xff) != 0x10)
 		{
-			static struct resource ega_console_resource = { "ega", 0x3B0, 0x3BF };
 			vga_video_type = VIDEO_TYPE_EGAM;
 			vga_vram_end = 0xb8000;
+			console_io.name = "ega";
+			console_io.end = 0x3bf;
 			display_desc = "EGA+";
-			request_resource(&ioport_resource, &ega_console_resource);
 		}
 		else
 		{
-			static struct resource mda1_console_resource = { "mda", 0x3B0, 0x3BB };
-			static struct resource mda2_console_resource = { "mda", 0x3BF, 0x3BF };
 			vga_video_type = VIDEO_TYPE_MDA;
 			vga_vram_end = 0xb2000;
 			display_desc = "*MDA";
-			request_resource(&ioport_resource, &mda1_console_resource);
-			request_resource(&ioport_resource, &mda2_console_resource);
+			console_io1.start = 0x3bf;
+			console_io1.end = 0x3bf;
+			if (pci_request_legacy_resource(NULL, &console_io1)
+			    == -ENXIO)
+				goto no_vga;
+			console_io.name = "mda";
+			console_io.end = 0x3bb;
 			vga_video_font_height = 14;
 		}
+		if (pci_request_legacy_resource(NULL, &console_io) == -ENXIO)
+			goto no_vga;
+		vga_video_port_reg = console_io.start + 0x4;	/* 0x3b4 */
+		vga_video_port_val = console_io.start + 0x5;	/* 0x3b5 */
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
 
 			vga_vram_end = 0xc0000;
+			console_io.name = ORIG_VIDEO_ISVGA ? "vga+" : "ega";
+			console_io.start = 0x3c0;
+			console_io.end = 0x3df;
+			if (pci_request_legacy_resource(NULL, &console_io)
+			    == -ENXIO)
+				goto no_vga;
 
 			if (!ORIG_VIDEO_ISVGA) {
-				static struct resource ega_console_resource = { "ega", 0x3C0, 0x3DF };
 				vga_video_type = VIDEO_TYPE_EGAC;
 				display_desc = "EGA";
-				request_resource(&ioport_resource, &ega_console_resource);
 			} else {
-				static struct resource vga_console_resource = { "vga+", 0x3C0, 0x3DF };
 				vga_video_type = VIDEO_TYPE_VGAC;
 				display_desc = "VGA+";
-				request_resource(&ioport_resource, &vga_console_resource);
-
 #ifdef VGA_CAN_DO_64KB
 				/*
 				 * get 64K rather than 32K of video RAM.
@@ -247,8 +264,8 @@ static const char __init *vgacon_startup
 				 */
 				vga_vram_base = 0xa0000;
 				vga_vram_end = 0xb0000;
-				outb_p (6, 0x3ce) ;
-				outb_p (6, 0x3cf) ;
+				outb_p (6, gr_port_reg) ;
+				outb_p (6, gr_port_val) ;
 #endif
 
 				/*
@@ -258,36 +275,49 @@ static const char __init *vgacon_startup
 				 */
 
 				for (i=0; i<16; i++) {
-					inb_p (0x3da) ;
-					outb_p (i, 0x3c0) ;
-					outb_p (i, 0x3c0) ;
+					inb_p (console_io.start + 0x1a); /* 0x3da */
+					outb_p (i, attrib_port);
+					outb_p (i, attrib_port);
 				}
-				outb_p (0x20, 0x3c0) ;
+				outb_p (0x20, attrib_port);
 
 				/* now set the DAC registers back to their
 				 * default values */
 
 				for (i=0; i<16; i++) {
-					outb_p (color_table[i], 0x3c8) ;
-					outb_p (default_red[i], 0x3c9) ;
-					outb_p (default_grn[i], 0x3c9) ;
-					outb_p (default_blu[i], 0x3c9) ;
+					outb_p (color_table[i], dac_reg);
+					outb_p (default_red[i], dac_val);
+					outb_p (default_grn[i], dac_val);
+					outb_p (default_blu[i], dac_val);
 				}
 			}
+			vga_video_port_reg = console_io.start + 0x14; /* 0x3d4 */
+			vga_video_port_val = console_io.start + 0x15; /* 0x3d5 */
 		}
 		else
 		{
-			static struct resource cga_console_resource = { "cga", 0x3D4, 0x3D5 };
 			vga_video_type = VIDEO_TYPE_CGA;
 			vga_vram_end = 0xba000;
 			display_desc = "*CGA";
-			request_resource(&ioport_resource, &cga_console_resource);
+			console_io.name = "cga";
+			console_io.start = 0x3d4;
+			console_io.end = 0x3d5;
+			if (pci_request_legacy_resource(NULL, &console_io)
+			    == -ENXIO)
+				goto no_vga;
 			vga_video_font_height = 8;
+			vga_video_port_reg = console_io.start + 0x0; /* 0x3d4 */
+			vga_video_port_val = console_io.start + 0x1; /* 0x3d5 */
 		}
 	}
 
-	vga_vram_base = VGA_MAP_MEM(vga_vram_base);
-	vga_vram_end = VGA_MAP_MEM(vga_vram_end);
+	console_mem.start = vga_vram_base;
+	console_mem.end = vga_vram_end - 1;
+	if (pci_request_legacy_resource(NULL, &console_mem) == -ENXIO)
+		goto no_vga;
+	vram_size = vga_vram_end - vga_vram_base;
+	vga_vram_base = (unsigned long)ioremap(console_mem.start, vram_size);
+	vga_vram_end = vga_vram_base + vram_size;
 
 	/*
 	 *	Find out if there is a graphics card present.
@@ -697,10 +727,10 @@ static int vgacon_blank(struct vc_data *
 
 #ifdef CAN_LOAD_EGA_FONTS
 
-#define colourmap 0xa0000
+#define colourmap 	(vga_vram_base & ~0x1ffffUL)	/* 0xa0000 */
 /* Pauline Middelink <middelin@polyware.iaf.nl> reports that we
    should use 0xA0000 for the bwmap as well.. */
-#define blackwmap 0xa0000
+#define blackwmap 	(vga_vram_base & ~0x1ffffUL)	/* 0xa0000 */
 #define cmapsz 8192
 
 static int
@@ -713,14 +743,14 @@ vgacon_do_font_op(char *arg, int set, in
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
