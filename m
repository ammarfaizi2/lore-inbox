Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270171AbTGSGWi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 02:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270493AbTGSGWi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 02:22:38 -0400
Received: from grouse.mail.pas.earthlink.net ([207.217.120.116]:151 "EHLO
	grouse.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S270171AbTGSGWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 02:22:34 -0400
From: Richard Drummond <lists@rcdrummond.net>
Reply-To: lists@rcdrummond.net
Organization: Private
To: <linux-fbdev-devel@lists.sourceforge.net>
Subject: [PATCH] Big-endian fixes for tdfxfb in 2.4.21
Date: Sat, 19 Jul 2003 01:39:14 -0500
User-Agent: KMail/1.5.2
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <200307190131.46394.lists@rcdrummond.net>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_SeOG/GYk5y0PhT9"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_SeOG/GYk5y0PhT9
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The following patch fixes some long-standing problems that I have been 
experiencing with the tdfxfb driver in kernel 2.4 when running on a PPC Mac.

Specifically, it fixes:

1) Endian problems when blitting font glyphs. I have enabled byte-swizzling 
when blitting, so text on the console is now readable.

2) Endian issues with 24-bit framebuffer. I've disabled byte-swizzled access 
to 24-bit framebuffers. This now suits the byte-ordering of framebuffers with 
this depth (at least on my hardware).

3) Endian problems with hwcursor. The cursor should now appear at the cursor 
position, that is, actually at the insertion point. It was simply a question 
of getting the right byte-ordering for each framebuffer depth.

4) Disabled I/O ports when booting from OF (rather than via MacOS) preventing 
use. The driver  now calls pci_enable_device() during init - which should 
enable I/O ports - and checks to see that I/O space is accessible before 
proceeding.

I've tested this patch extensively both on a Voodoo3 and a Voodoo4 on several 
(OldWorld) Macs. I don't have an x86 3dfx card to verify that it still works 
there, but the changes shouldn't affect little-endian machines at all.

A couple of problems still remain:

1) Resource management still needs to be implemented (A corollary is that offb 
will claim the card before tdfxfb - if you have the offb driver built in as 
well - and then tdfxfb will also claim it. Solution: you need to supply the 
kernel option video=offb:off to use tdfxfb). This will be trivial to do.

2) Hardware cursor works fine if I boot via MacOS with BootX, but is invisible 
if I boot from OF with Quik. Not sure why - still needs investigation. 
Solution: turn off hwcursor. (Make that kernel option above 
video=offb:off,tdfx:nohwcursor=1 if you boot from OF.)

3) Memory on Voodoo4 is incorrectly detected. It reports 64MB, but the Voodoo4 
only has 32MB. I don't have any documentation on the Voodoo4/5, so I don't 
know the proper way to detect it.  XFree86 uses the same algorithm as tdfxfb, 
so also gets it wrong.

I have taken a cursory glance at the tdfxfb in 2.5/2.6-test and similar 
changes will need to be applied there too. I intend to look at this when I 
have time.

I'd welcome comments on this patch, particulary from anybody running tdfxfb on 
a big-endian platform other than the Mac.

Cheers,
Rich


--Boundary-00=_SeOG/GYk5y0PhT9
Content-Type: text/x-diff;
  charset="us-ascii";
  name="tdfxfb-20030719.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="tdfxfb-20030719.diff"

--- drivers/video/tdfxfb.c.orig	2003-06-27 08:49:54.000000000 -0500
+++ drivers/video/tdfxfb.c	2003-07-18 16:25:56.000000000 -0500
@@ -764,7 +764,11 @@
    tdfx_outl(SRCXY,     0);
    tdfx_outl(DSTXY,     xx | (yy << 16));
    tdfx_outl(COMMAND_2D, COMMAND_2D_H2S_BITBLT | (ROP_COPY << 24));
+#ifdef __BIG_ENDIAN
+   tdfx_outl(SRCFORMAT, 0x400000 | BIT(20) );   
+#else
    tdfx_outl(SRCFORMAT, 0x400000);
+#endif
    tdfx_outl(DSTFORMAT, fmt);
    tdfx_outl(DSTSIZE,   fontwidth(p) | (fontheight(p) << 16));
    i=fontheight(p);
@@ -822,7 +826,11 @@
    tdfx_outl(COMMAND_3D, COMMAND_3D_NOP);
    tdfx_outl(COLORFORE, fgx);
    tdfx_outl(COLORBACK, bgx);
+#ifdef __BIG_ENDIAN
+   tdfx_outl(SRCFORMAT, 0x400000 | BIT(20) );   
+#else
    tdfx_outl(SRCFORMAT, 0x400000);
+#endif   
    tdfx_outl(DSTFORMAT, fmt);
    tdfx_outl(DSTSIZE, w | (h << 16));
    tdfx_outl(SRCXY,     0);
@@ -1475,6 +1483,7 @@
 #if defined(__BIG_ENDIAN)
   switch (par->bpp) {
     case 8:
+    case 24:
       reg.miscinit0 &= ~(1 << 30);
       reg.miscinit0 &= ~(1 << 31);
       break;
@@ -1482,7 +1491,6 @@
       reg.miscinit0 |= (1 << 30);
       reg.miscinit0 |= (1 << 31);
       break;
-    case 24:
     case 32:
       reg.miscinit0 |= (1 << 30);
       reg.miscinit0 &= ~(1 << 31);
@@ -1635,10 +1643,6 @@
     v.blue.length  = 5;
     break;
   case 24:
-    v.red.offset=16;
-    v.green.offset=8;
-    v.blue.offset=0;
-    v.red.length = v.green.length = v.blue.length = 8;
   case 32:
     v.red.offset   = 16;
     v.green.offset = 8;
@@ -1942,6 +1946,12 @@
 			break;
 	}
 	
+        if (pci_enable_device(pdev)) 
+        {
+                printk(KERN_WARNING "fb: Unable to enable %s PCI device.\n", name);
+                return -ENXIO;
+        }
+
 	fb_info.regbase_phys = pci_resource_start(pdev, 0);
 	fb_info.regbase_size = 1 << 24;
 	fb_info.regbase_virt = ioremap_nocache(fb_info.regbase_phys, 1 << 24);
@@ -1970,6 +1980,13 @@
 
 	fb_info.iobase = pci_resource_start (pdev, 2);
       
+        if (!fb_info.iobase) {
+	        printk(KERN_WARNING "fb: Can't access %s I/O ports.\n", name);
+		iounmap(fb_info.regbase_virt);
+		iounmap(fb_info.bufbase_virt);
+                return -ENXIO;
+	}
+   
 	printk("fb: %s memory = %ldK\n", name, fb_info.bufbase_size >> 10);
 
 #ifdef CONFIG_MTRR
@@ -2363,10 +2380,25 @@
    unsigned int h,to;
 
    tdfxfb_createcursorshape(p);
-   xline = ~((1 << (32 - fb_info.cursor.w)) - 1);
+   xline = (~0) << (32 - fb_info.cursor.w);
 
 #ifdef __LITTLE_ENDIAN
    xline = swab32(xline);
+#else
+   switch (p->var.bits_per_pixel) {
+      case 8:
+      case 24:
+         xline = swab32(xline);
+         break;
+      case 16:
+         xline = ((xline & 0xff000000 ) >> 16 )
+               | ((xline & 0x00ff0000 ) >> 16 )
+               | ((xline & 0x0000ff00 ) << 16 )
+               | ((xline & 0x000000ff ) << 16 );
+         break;
+      case 32:
+         break;
+   }
 #endif
 
    cursorbase=(u8*)fb_info.bufbase_virt;

--Boundary-00=_SeOG/GYk5y0PhT9--

