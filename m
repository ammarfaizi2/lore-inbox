Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932094AbWDEWBO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbWDEWBO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 18:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932093AbWDEWBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 18:01:14 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:3204 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S932091AbWDEWBN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 18:01:13 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: "Luck, Tony" <tony.luck@intel.com>
Subject: Re: 2.6.17-rc1-mm1
Date: Wed, 5 Apr 2006 16:01:08 -0600
User-Agent: KMail/1.8.3
Cc: Zou Nan hai <nanhai.zou@intel.com>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, linux-ia64@vger.kernel.org
References: <20060404014504.564bf45a.akpm@osdl.org> <200604051015.34217.bjorn.helgaas@hp.com> <20060405211757.GA8536@agluck-lia64.sc.intel.com>
In-Reply-To: <20060405211757.GA8536@agluck-lia64.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604051601.08776.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 05 April 2006 15:17, Luck, Tony wrote:
> On Wed, Apr 05, 2006 at 10:15:34AM -0600, Bjorn Helgaas wrote:
> > Huh.  Intel firmware used to just not mention the VGA framebuffer
> > (0xa0000-0xc0000) at all in the EFI memory map.  I think that was
> > clearly a bug.  So maybe they fixed that by marking it WB (and
> > hopefully UC as well).
> 
> Nope ... not fixed (at least not in the f/w that I'm running). The
> VGA buffer is still simply not mentioned in the EFI memory map.
> 
> The problem looks to come from this code in vgacon.c:
> 
> 	vga_vram_base = VGA_MAP_MEM(vga_vram_base);
> 	vga_vram_end = VGA_MAP_MEM(vga_vram_end);
> 	vga_vram_size = vga_vram_end - vga_vram_base;
> 
> vga_vram_base is 0xb8000, and this call gets a UC return of
> c0000000000b8000.  But vga_vram_end is 0xc0000 ... which is
> the address of the start of a block of memory that is both
> WB and UC capable.  So ioremap() gives us e0000000000c0000
> (which means that vga_vram_size is 2000000000008000, surely
> the biggest, baddest video card in the history of the world!).
> 
> Perhaps the right fix is to subtract 1 from vga_vram_end and pass
> that into VGA_MAP_MEM(), and then add the 1 byte back when computing
> the size?  But I don't know whether that might do something bad on
> some other architecture that uses vgacon.c.

I think the VGA_MAP_MEM(vga_vram_end) is just bogus -- it's not
that we need to map the memory starting at vga_vram_end.  I think
it would cleaner (though much more intrusive) to do something like
the patch below, which basically just hard-codes (base, size)
rather than (base, end).

> If this is not 
> acceptable, then we can fall back and use the Nanhai/Bjorn fix
> of using ioremap_nocache().

Regardless of how we solve the vga_vram_size issue, I still think
ioremap_nocache() is more appropriate in this case.  A framebuffer
won't work like we expect if it's mapped WB, will it?

(The patch below assumes the ioremap_nocache change precedes it.)


[PATCH] vgacon: make VGA_MAP_MEM take size, remove extra use

VGA_MAP_MEM translates to ioremap() on some architectures.  It
makes sense to do this to vga_vram_base, because we're going to
access memory between vga_vram_base and vga_vram_end.

But it doesn't really make sense to map starting at vga_vram_end,
because we aren't going to access memory starting there.  On ia64,
which always has to be different, ioremapping vga_vram_end gives
you something completely incompatible with ioremapped vga_vram_start,
so vga_vram_size ends up being nonsense.

As a bonus, we often know the size up front, so we can use ioremap()
correctly, rather than giving it a zero size.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work-mm5/drivers/video/console/vgacon.c
===================================================================
--- work-mm5.orig/drivers/video/console/vgacon.c	2006-04-03 15:04:48.000000000 -0600
+++ work-mm5/drivers/video/console/vgacon.c	2006-04-05 15:48:37.000000000 -0600
@@ -391,7 +391,7 @@
 			static struct resource ega_console_resource =
 			    { .name = "ega", .start = 0x3B0, .end = 0x3BF };
 			vga_video_type = VIDEO_TYPE_EGAM;
-			vga_vram_end = 0xb8000;
+			vga_vram_size = 0x8000;
 			display_desc = "EGA+";
 			request_resource(&ioport_resource,
 					 &ega_console_resource);
@@ -401,7 +401,7 @@
 			static struct resource mda2_console_resource =
 			    { .name = "mda", .start = 0x3BF, .end = 0x3BF };
 			vga_video_type = VIDEO_TYPE_MDA;
-			vga_vram_end = 0xb2000;
+			vga_vram_size = 0x2000;
 			display_desc = "*MDA";
 			request_resource(&ioport_resource,
 					 &mda1_console_resource);
@@ -418,7 +418,7 @@
 		if ((ORIG_VIDEO_EGA_BX & 0xff) != 0x10) {
 			int i;
 
-			vga_vram_end = 0xc0000;
+			vga_vram_size = 0x8000;
 
 			if (!ORIG_VIDEO_ISVGA) {
 				static struct resource ega_console_resource
@@ -443,7 +443,7 @@
 				 * and COE=1 isn't necessarily a good idea)
 				 */
 				vga_vram_base = 0xa0000;
-				vga_vram_end = 0xb0000;
+				vga_vram_size = 0x10000;
 				outb_p(6, VGA_GFX_I);
 				outb_p(6, VGA_GFX_D);
 #endif
@@ -475,7 +475,7 @@
 			static struct resource cga_console_resource =
 			    { .name = "cga", .start = 0x3D4, .end = 0x3D5 };
 			vga_video_type = VIDEO_TYPE_CGA;
-			vga_vram_end = 0xba000;
+			vga_vram_size = 0x2000;
 			display_desc = "*CGA";
 			request_resource(&ioport_resource,
 					 &cga_console_resource);
@@ -483,9 +483,8 @@
 		}
 	}
 
-	vga_vram_base = VGA_MAP_MEM(vga_vram_base);
-	vga_vram_end = VGA_MAP_MEM(vga_vram_end);
-	vga_vram_size = vga_vram_end - vga_vram_base;
+	vga_vram_base = VGA_MAP_MEM(vga_vram_base, vga_vram_size);
+	vga_vram_end = vga_vram_base + vga_vram_size;
 
 	/*
 	 *      Find out if there is a graphics card present.
@@ -1020,14 +1019,14 @@
 	char *charmap;
 	
 	if (vga_video_type != VIDEO_TYPE_EGAM) {
-		charmap = (char *) VGA_MAP_MEM(colourmap);
+		charmap = (char *) VGA_MAP_MEM(colourmap, 0);
 		beg = 0x0e;
 #ifdef VGA_CAN_DO_64KB
 		if (vga_video_type == VIDEO_TYPE_VGAC)
 			beg = 0x06;
 #endif
 	} else {
-		charmap = (char *) VGA_MAP_MEM(blackwmap);
+		charmap = (char *) VGA_MAP_MEM(blackwmap, 0);
 		beg = 0x0a;
 	}
 
Index: work-mm5/include/asm-alpha/vga.h
===================================================================
--- work-mm5.orig/include/asm-alpha/vga.h	2006-01-02 20:21:10.000000000 -0700
+++ work-mm5/include/asm-alpha/vga.h	2006-04-05 15:42:35.000000000 -0600
@@ -46,6 +46,6 @@
 #define vga_readb(a)	readb((u8 __iomem *)(a))
 #define vga_writeb(v,a)	writeb(v, (u8 __iomem *)(a))
 
-#define VGA_MAP_MEM(x)	((unsigned long) ioremap(x, 0))
+#define VGA_MAP_MEM(x,s)	((unsigned long) ioremap(x, s))
 
 #endif
Index: work-mm5/include/asm-arm/vga.h
===================================================================
--- work-mm5.orig/include/asm-arm/vga.h	2006-01-02 20:21:10.000000000 -0700
+++ work-mm5/include/asm-arm/vga.h	2006-04-05 15:42:21.000000000 -0600
@@ -4,7 +4,7 @@
 #include <asm/hardware.h>
 #include <asm/io.h>
 
-#define VGA_MAP_MEM(x)	(PCIMEM_BASE + (x))
+#define VGA_MAP_MEM(x,s)	(PCIMEM_BASE + (x))
 
 #define vga_readb(x)	(*((volatile unsigned char *)x))
 #define vga_writeb(x,y)	(*((volatile unsigned char *)y) = (x))
Index: work-mm5/include/asm-i386/vga.h
===================================================================
--- work-mm5.orig/include/asm-i386/vga.h	2006-01-02 20:21:10.000000000 -0700
+++ work-mm5/include/asm-i386/vga.h	2006-04-05 15:42:49.000000000 -0600
@@ -12,7 +12,7 @@
  *	access the videoram directly without any black magic.
  */
 
-#define VGA_MAP_MEM(x) (unsigned long)phys_to_virt(x)
+#define VGA_MAP_MEM(x,s) (unsigned long)phys_to_virt(x)
 
 #define vga_readb(x) (*(x))
 #define vga_writeb(x,y) (*(y) = (x))
Index: work-mm5/include/asm-ia64/vga.h
===================================================================
--- work-mm5.orig/include/asm-ia64/vga.h	2006-04-05 09:57:55.000000000 -0600
+++ work-mm5/include/asm-ia64/vga.h	2006-04-05 15:43:09.000000000 -0600
@@ -17,7 +17,7 @@
 extern unsigned long vga_console_iobase;
 extern unsigned long vga_console_membase;
 
-#define VGA_MAP_MEM(x)	((unsigned long) ioremap_nocache(vga_console_membase + (x), 0))
+#define VGA_MAP_MEM(x,s)	((unsigned long) ioremap_nocache(vga_console_membase + (x), s))
 
 #define vga_readb(x)	(*(x))
 #define vga_writeb(x,y)	(*(y) = (x))
Index: work-mm5/include/asm-m32r/vga.h
===================================================================
--- work-mm5.orig/include/asm-m32r/vga.h	2006-01-02 20:21:10.000000000 -0700
+++ work-mm5/include/asm-m32r/vga.h	2006-04-05 15:43:22.000000000 -0600
@@ -14,7 +14,7 @@
  *	access the videoram directly without any black magic.
  */
 
-#define VGA_MAP_MEM(x) (unsigned long)phys_to_virt(x)
+#define VGA_MAP_MEM(x,s) (unsigned long)phys_to_virt(x)
 
 #define vga_readb(x) (*(x))
 #define vga_writeb(x,y) (*(y) = (x))
Index: work-mm5/include/asm-mips/vga.h
===================================================================
--- work-mm5.orig/include/asm-mips/vga.h	2006-03-23 10:22:17.000000000 -0700
+++ work-mm5/include/asm-mips/vga.h	2006-04-05 15:43:32.000000000 -0600
@@ -13,7 +13,7 @@
  *	access the videoram directly without any black magic.
  */
 
-#define VGA_MAP_MEM(x)	(0xb0000000L + (unsigned long)(x))
+#define VGA_MAP_MEM(x,s)	(0xb0000000L + (unsigned long)(x))
 
 #define vga_readb(x)	(*(x))
 #define vga_writeb(x,y)	(*(y) = (x))
Index: work-mm5/include/asm-powerpc/vga.h
===================================================================
--- work-mm5.orig/include/asm-powerpc/vga.h	2006-01-02 20:21:10.000000000 -0700
+++ work-mm5/include/asm-powerpc/vga.h	2006-04-05 15:43:57.000000000 -0600
@@ -42,9 +42,9 @@
 extern unsigned long vgacon_remap_base;
 
 #ifdef __powerpc64__
-#define VGA_MAP_MEM(x) ((unsigned long) ioremap((x), 0))
+#define VGA_MAP_MEM(x,s) ((unsigned long) ioremap((x), s))
 #else
-#define VGA_MAP_MEM(x) (x + vgacon_remap_base)
+#define VGA_MAP_MEM(x,s) (x + vgacon_remap_base)
 #endif
 
 #define vga_readb(x) (*(x))
Index: work-mm5/include/asm-sparc64/vga.h
===================================================================
--- work-mm5.orig/include/asm-sparc64/vga.h	2006-01-02 20:21:10.000000000 -0700
+++ work-mm5/include/asm-sparc64/vga.h	2006-04-05 15:44:08.000000000 -0600
@@ -28,6 +28,6 @@
 	return *addr;
 }
 
-#define VGA_MAP_MEM(x) (x)
+#define VGA_MAP_MEM(x,s) (x)
 
 #endif
Index: work-mm5/include/asm-x86_64/vga.h
===================================================================
--- work-mm5.orig/include/asm-x86_64/vga.h	2006-01-02 20:21:10.000000000 -0700
+++ work-mm5/include/asm-x86_64/vga.h	2006-04-05 15:44:18.000000000 -0600
@@ -12,7 +12,7 @@
  *	access the videoram directly without any black magic.
  */
 
-#define VGA_MAP_MEM(x) (unsigned long)phys_to_virt(x)
+#define VGA_MAP_MEM(x,s) (unsigned long)phys_to_virt(x)
 
 #define vga_readb(x) (*(x))
 #define vga_writeb(x,y) (*(y) = (x))
Index: work-mm5/include/asm-xtensa/vga.h
===================================================================
--- work-mm5.orig/include/asm-xtensa/vga.h	2006-01-02 20:21:10.000000000 -0700
+++ work-mm5/include/asm-xtensa/vga.h	2006-04-05 15:44:31.000000000 -0600
@@ -11,7 +11,7 @@
 #ifndef _XTENSA_VGA_H
 #define _XTENSA_VGA_H
 
-#define VGA_MAP_MEM(x) (unsigned long)phys_to_virt(x)
+#define VGA_MAP_MEM(x,s) (unsigned long)phys_to_virt(x)
 
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
+	info->screen_base = (void __iomem *)VGA_MAP_MEM(VGA_FB_PHYS, 0);
 
 	if (!info->screen_base) {
 		printk(KERN_ERR "vga16fb: unable to map device\n");
