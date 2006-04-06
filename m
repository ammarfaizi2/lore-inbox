Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751144AbWDFKeh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbWDFKeh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 06:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbWDFKeh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 06:34:37 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:18451 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751144AbWDFKeg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 06:34:36 -0400
Date: Thu, 6 Apr 2006 11:34:27 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>, "Luck, Tony" <tony.luck@intel.com>,
       Zou Nan hai <nanhai.zou@intel.com>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, linux-ia64@vger.kernel.org
Subject: Re: 2.6.17-rc1-mm1
Message-ID: <20060406103427.GC28056@flint.arm.linux.org.uk>
Mail-Followup-To: Bjorn Helgaas <bjorn.helgaas@hp.com>,
	"Luck, Tony" <tony.luck@intel.com>,
	Zou Nan hai <nanhai.zou@intel.com>, Andrew Morton <akpm@osdl.org>,
	LKML <linux-kernel@vger.kernel.org>, linux-ia64@vger.kernel.org
References: <20060404014504.564bf45a.akpm@osdl.org> <200604051015.34217.bjorn.helgaas@hp.com> <20060405211757.GA8536@agluck-lia64.sc.intel.com> <200604051601.08776.bjorn.helgaas@hp.com> <20060406102154.GB28056@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060406102154.GB28056@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2006 at 11:21:54AM +0100, Russell King wrote:
> On Wed, Apr 05, 2006 at 04:01:08PM -0600, Bjorn Helgaas wrote:
> > [PATCH] vgacon: make VGA_MAP_MEM take size, remove extra use
> 
> Ah, seems to be what I just suggested...
> 
> > @@ -1020,14 +1019,14 @@
> >  	char *charmap;
> >  	
> >  	if (vga_video_type != VIDEO_TYPE_EGAM) {
> > -		charmap = (char *) VGA_MAP_MEM(colourmap);
> > +		charmap = (char *) VGA_MAP_MEM(colourmap, 0);
> 
> Don't like this though - can't we pass a real size here rather than zero?
> There seems to be several clues as to the maximum size:
> 
> #define cmapsz 8192
> 
>         if (!vga_font_is_default)
>                 charmap += 4 * cmapsz;
> 
>                         charmap += 2 * cmapsz;
>                                 for (i = 0; i < cmapsz; i++)
>                                         vga_writeb(arg[i], charmap + i);
> 
> so that's about 7 * cmapsz - call that 8 for completeness, which is 64K.

Oh, and obviously, can we also have a VGA_UNMAP_MEM() macro as well please?
8)  IOW, something like this (which I cobbled together from your patch, some
of it by hand-edits - couldn't get it to apply cleanly to current -git.)

diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -391,7 +391,7 @@ static const char __init *vgacon_startup
 			static struct resource ega_console_resource =
 			    { .name = "ega", .start = 0x3B0, .end = 0x3BF };
 			vga_video_type = VIDEO_TYPE_EGAM;
-			vga_vram_end = 0xb8000;
+			vga_vram_size = 0x8000;
 			display_desc = "EGA+";
 			request_resource(&ioport_resource,
 					 &ega_console_resource);
@@ -401,7 +401,7 @@ static const char __init *vgacon_startup
 			static struct resource mda2_console_resource =
 			    { .name = "mda", .start = 0x3BF, .end = 0x3BF };
 			vga_video_type = VIDEO_TYPE_MDA;
-			vga_vram_end = 0xb2000;
+			vga_vram_size = 0x2000;
 			display_desc = "*MDA";
 			request_resource(&ioport_resource,
 					 &mda1_console_resource);
@@ -418,7 +418,7 @@ static const char __init *vgacon_startup
 		if ((ORIG_VIDEO_EGA_BX & 0xff) != 0x10) {
 			int i;
 
-			vga_vram_end = 0xc0000;
+			vga_vram_size = 0x8000;
 
 			if (!ORIG_VIDEO_ISVGA) {
 				static struct resource ega_console_resource
@@ -443,7 +443,7 @@ static const char __init *vgacon_startup
 				 * and COE=1 isn't necessarily a good idea)
 				 */
 				vga_vram_base = 0xa0000;
-				vga_vram_end = 0xb0000;
+				vga_vram_size = 0x10000;
 				outb_p(6, VGA_GFX_I);
 				outb_p(6, VGA_GFX_D);
 #endif
@@ -475,7 +475,7 @@ static const char __init *vgacon_startup
 			static struct resource cga_console_resource =
 			    { .name = "cga", .start = 0x3D4, .end = 0x3D5 };
 			vga_video_type = VIDEO_TYPE_CGA;
-			vga_vram_end = 0xba000;
+			vga_vram_size = 0x2000;
 			display_desc = "*CGA";
 			request_resource(&ioport_resource,
 					 &cga_console_resource);
@@ -483,9 +483,8 @@ static const char __init *vgacon_startup
 		}
 	}
 
-	vga_vram_base = VGA_MAP_MEM(vga_vram_base);
-	vga_vram_end = VGA_MAP_MEM(vga_vram_end);
-	vga_vram_size = vga_vram_end - vga_vram_base;
+	vga_vram_base = VGA_MAP_MEM(vga_vram_base, vga_vram_size);
+	vga_vram_end = vga_vram_base + vga_vram_size;
 
 	/*
 	 *      Find out if there is a graphics card present.
@@ -1020,14 +1019,14 @@ static int vgacon_do_font_op(struct vgas
 	char *charmap;
 	
 	if (vga_video_type != VIDEO_TYPE_EGAM) {
-		charmap = (char *) VGA_MAP_MEM(colourmap);
+		charmap = (char *) VGA_MAP_MEM(colourmap, 8 * cmapsz);
 		beg = 0x0e;
 #ifdef VGA_CAN_DO_64KB
 		if (vga_video_type == VIDEO_TYPE_VGAC)
 			beg = 0x06;
 #endif
 	} else {
-		charmap = (char *) VGA_MAP_MEM(blackwmap);
+		charmap = (char *) VGA_MAP_MEM(blackwmap, 8 * cmapsz);
 		beg = 0x0a;
 	}
 
@@ -1102,6 +1101,8 @@ static int vgacon_do_font_op(struct vgas
 		}
 	}
 
+	VGA_UNMAP_MEM(charmap, 8 * cmapsz);
+
 	spin_lock_irq(&vga_lock);
 	/* First, the sequencer, Synchronous reset */
 	vga_wseq(state->vgabase, VGA_SEQ_RESET, 0x01);	
Index: work-mm5/include/asm-alpha/vga.h
===================================================================
--- work-mm5.orig/include/asm-alpha/vga.h	2006-01-02 20:21:10.000000000 -0700
+++ work-mm5/include/asm-alpha/vga.h	2006-04-05 15:42:35.000000000 -0600
@@ -46,6 +46,7 @@
 #define vga_readb(a)	readb((u8 __iomem *)(a))
 #define vga_writeb(v,a)	writeb(v, (u8 __iomem *)(a))
 
-#define VGA_MAP_MEM(x)	((unsigned long) ioremap(x, 0))
+#define VGA_MAP_MEM(x,s)	((unsigned long) ioremap(x, s))
+#define VGA_UNMAP_MEM(x,s)	do { } while (0)
 
 #endif
Index: work-mm5/include/asm-arm/vga.h
===================================================================
--- work-mm5.orig/include/asm-arm/vga.h	2006-01-02 20:21:10.000000000 -0700
+++ work-mm5/include/asm-arm/vga.h	2006-04-05 15:42:21.000000000 -0600
@@ -4,7 +4,8 @@
 #include <asm/hardware.h>
 #include <asm/io.h>
 
-#define VGA_MAP_MEM(x)	(PCIMEM_BASE + (x))
+#define VGA_MAP_MEM(x,s)	(PCIMEM_BASE + (x))
+#define VGA_UNMAP_MEM(x,s)	do { } while (0)
 
 #define vga_readb(x)	(*((volatile unsigned char *)x))
 #define vga_writeb(x,y)	(*((volatile unsigned char *)y) = (x))
Index: work-mm5/include/asm-i386/vga.h
===================================================================
--- work-mm5.orig/include/asm-i386/vga.h	2006-01-02 20:21:10.000000000 -0700
+++ work-mm5/include/asm-i386/vga.h	2006-04-05 15:42:49.000000000 -0600
@@ -12,7 +12,8 @@
  *	access the videoram directly without any black magic.
  */
 
-#define VGA_MAP_MEM(x) (unsigned long)phys_to_virt(x)
+#define VGA_MAP_MEM(x,s) (unsigned long)phys_to_virt(x)
+#define VGA_UNMAP_MEM(x,s)	do { } while (0)
 
 #define vga_readb(x) (*(x))
 #define vga_writeb(x,y) (*(y) = (x))
Index: work-mm5/include/asm-ia64/vga.h
===================================================================
--- work-mm5.orig/include/asm-ia64/vga.h	2006-04-05 09:57:55.000000000 -0600
+++ work-mm5/include/asm-ia64/vga.h	2006-04-05 15:43:09.000000000 -0600
@@ -17,7 +17,8 @@
 extern unsigned long vga_console_iobase;
 extern unsigned long vga_console_membase;
 
-#define VGA_MAP_MEM(x)	((unsigned long) ioremap_nocache(vga_console_membase + (x), 0))
+#define VGA_MAP_MEM(x,s)	((unsigned long) ioremap_nocache(vga_console_membase + (x), s))
+#define VGA_UNMAP_MEM(x,s)	do { } while (0)
 
 #define vga_readb(x)	(*(x))
 #define vga_writeb(x,y)	(*(y) = (x))
Index: work-mm5/include/asm-m32r/vga.h
===================================================================
--- work-mm5.orig/include/asm-m32r/vga.h	2006-01-02 20:21:10.000000000 -0700
+++ work-mm5/include/asm-m32r/vga.h	2006-04-05 15:43:22.000000000 -0600
@@ -14,7 +14,8 @@
  *	access the videoram directly without any black magic.
  */
 
-#define VGA_MAP_MEM(x) (unsigned long)phys_to_virt(x)
+#define VGA_MAP_MEM(x,s) (unsigned long)phys_to_virt(x)
+#define VGA_UNMAP_MEM(x,s)	do { } while (0)
 
 #define vga_readb(x) (*(x))
 #define vga_writeb(x,y) (*(y) = (x))
Index: work-mm5/include/asm-mips/vga.h
===================================================================
--- work-mm5.orig/include/asm-mips/vga.h	2006-03-23 10:22:17.000000000 -0700
+++ work-mm5/include/asm-mips/vga.h	2006-04-05 15:43:32.000000000 -0600
@@ -13,7 +13,8 @@
  *	access the videoram directly without any black magic.
  */
 
-#define VGA_MAP_MEM(x)	(0xb0000000L + (unsigned long)(x))
+#define VGA_MAP_MEM(x,s)	(0xb0000000L + (unsigned long)(x))
+#define VGA_UNMAP_MEM(x,s)	do { } while (0)
 
 #define vga_readb(x)	(*(x))
 #define vga_writeb(x,y)	(*(y) = (x))
Index: work-mm5/include/asm-powerpc/vga.h
===================================================================
--- work-mm5.orig/include/asm-powerpc/vga.h	2006-01-02 20:21:10.000000000 -0700
+++ work-mm5/include/asm-powerpc/vga.h	2006-04-05 15:43:57.000000000 -0600
@@ -42,9 +42,11 @@
 extern unsigned long vgacon_remap_base;
 
 #ifdef __powerpc64__
-#define VGA_MAP_MEM(x) ((unsigned long) ioremap((x), 0))
+#define VGA_MAP_MEM(x,s) ((unsigned long) ioremap((x), s))
+#define VGA_UNMAP_MEM(x,s)	do { } while (0)
 #else
-#define VGA_MAP_MEM(x) (x + vgacon_remap_base)
+#define VGA_MAP_MEM(x,s) (x + vgacon_remap_base)
+#define VGA_UNMAP_MEM(x,s)	do { } while (0)
 #endif
 
 #define vga_readb(x) (*(x))
Index: work-mm5/include/asm-sparc64/vga.h
===================================================================
--- work-mm5.orig/include/asm-sparc64/vga.h	2006-01-02 20:21:10.000000000 -0700
+++ work-mm5/include/asm-sparc64/vga.h	2006-04-05 15:44:08.000000000 -0600
@@ -28,6 +28,7 @@
 	return *addr;
 }
 
-#define VGA_MAP_MEM(x) (x)
+#define VGA_MAP_MEM(x,s) (x)
+#define VGA_UNMAP_MEM(x,s)	do { } while (0)
 
 #endif
Index: work-mm5/include/asm-x86_64/vga.h
===================================================================
--- work-mm5.orig/include/asm-x86_64/vga.h	2006-01-02 20:21:10.000000000 -0700
+++ work-mm5/include/asm-x86_64/vga.h	2006-04-05 15:44:18.000000000 -0600
@@ -12,7 +12,8 @@
  *	access the videoram directly without any black magic.
  */
 
-#define VGA_MAP_MEM(x) (unsigned long)phys_to_virt(x)
+#define VGA_MAP_MEM(x,s) (unsigned long)phys_to_virt(x)
+#define VGA_UNMAP_MEM(x,s)	do { } while (0)
 
 #define vga_readb(x) (*(x))
 #define vga_writeb(x,y) (*(y) = (x))
Index: work-mm5/include/asm-xtensa/vga.h
===================================================================
--- work-mm5.orig/include/asm-xtensa/vga.h	2006-01-02 20:21:10.000000000 -0700
+++ work-mm5/include/asm-xtensa/vga.h	2006-04-05 15:44:31.000000000 -0600
@@ -11,7 +11,8 @@
 #ifndef _XTENSA_VGA_H
 #define _XTENSA_VGA_H
 
-#define VGA_MAP_MEM(x) (unsigned long)phys_to_virt(x)
+#define VGA_MAP_MEM(x,s) (unsigned long)phys_to_virt(x)
+#define VGA_UNMAP_MEM(x,s)	do { } while (0)
 
 #define vga_readb(x)	(*(x))
 #define vga_writeb(x,y)	(*(y) = (x))
Index: work-mm5/drivers/video/console/mdacon.c
===================================================================
--- work-mm5.orig/drivers/video/console/mdacon.c	2006-01-02 20:21:10.000000000 -0700
+++ work-mm5/drivers/video/console/mdacon.c	2006-04-05 15:46:33.000000000 -0600
@@ -313,8 +313,8 @@
 	mda_num_columns = 80;
 	mda_num_lines   = 25;
 
-	mda_vram_base = VGA_MAP_MEM(0xb0000);
 	mda_vram_len  = 0x01000;
+	mda_vram_base = VGA_MAP_MEM(0xb0000, mda_vram_len);
 
 	mda_index_port  = 0x3b4;
 	mda_value_port  = 0x3b5;
Index: work-mm5/drivers/video/vga16fb.c
===================================================================
--- work-mm5.orig/drivers/video/vga16fb.c	2006-03-23 10:22:16.000000000 -0700
+++ work-mm5/drivers/video/vga16fb.c	2006-04-05 15:49:34.000000000 -0600
@@ -1351,7 +1351,7 @@
 	}
 
 	/* XXX share VGA_FB_PHYS and I/O region with vgacon and others */
-	info->screen_base = (void __iomem *)VGA_MAP_MEM(VGA_FB_PHYS);
+	info->screen_base = (void __iomem *)VGA_MAP_MEM(VGA_FB_PHYS, VGA_FB_PHYS_LEN);
 
 	if (!info->screen_base) {
 		printk(KERN_ERR "vga16fb: unable to map device\n");

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
