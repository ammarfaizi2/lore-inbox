Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270416AbTG2D0f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 23:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270426AbTG2D0e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 23:26:34 -0400
Received: from fw.osdl.org ([65.172.181.6]:6033 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270416AbTG2D0a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 23:26:30 -0400
Date: Mon, 28 Jul 2003 20:26:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: "S. Anderson" <sa@xmission.com>
Cc: pavel@xal.co.uk, linux-kernel@vger.kernel.org, adaplas@pol.net
Subject: Re: OOPS 2.6.0-test2, modprobe i810fb
Message-Id: <20030728202600.18338fa9.akpm@osdl.org>
In-Reply-To: <20030728201954.A16103@xmission.xmission.com>
References: <20030728171806.GA1860@xal.co.uk>
	<20030728201954.A16103@xmission.xmission.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"S. Anderson" <sa@xmission.com> wrote:
>
> On Mon, Jul 28, 2003 at 06:18:07PM +0100, Pavel Rabel wrote:
> > Got this OOPS when trying "modprobe i810fb",
> > kernel 2.6.0-test2
> > 
> 
> I am also getting this oops, or somthing very simmillar.

yay!  I finally fixed a bug! (sheesh, bad day).

The device table is not null-terminated so we run off the end during
matching and go oops.

I also moved all the statics out of i810_main.h and into i810_main.c. 
There is not a lot of point putting them in a header file: if any other .c
file includes the header we get multiple private instantiatiations of
all that stuff.



 drivers/video/i810/i810_main.c |   51 +++++++++++++++++++++++++++++++++++++++++
 drivers/video/i810/i810_main.h |   50 ----------------------------------------
 2 files changed, 51 insertions(+), 50 deletions(-)

diff -puN drivers/video/i810/i810_main.h~i810-fix drivers/video/i810/i810_main.h
--- 25/drivers/video/i810/i810_main.h~i810-fix	2003-07-28 20:20:15.000000000 -0700
+++ 25-akpm/drivers/video/i810/i810_main.h	2003-07-28 20:20:15.000000000 -0700
@@ -14,62 +14,12 @@
 #ifndef __I810_MAIN_H__
 #define __I810_MAIN_H__
 
-/* PCI */
-static const char *i810_pci_list[] __initdata = {
-	"Intel(R) 810 Framebuffer Device"                                 ,
-	"Intel(R) 810-DC100 Framebuffer Device"                           ,
-	"Intel(R) 810E Framebuffer Device"                                ,
-	"Intel(R) 815 (Internal Graphics 100Mhz FSB) Framebuffer Device"  ,
-	"Intel(R) 815 (Internal Graphics only) Framebuffer Device"        , 
-	"Intel(R) 815 (Internal Graphics with AGP) Framebuffer Device"  
-};
-
-static struct pci_device_id i810fb_pci_tbl[] __initdata = {
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82810_IG1, 
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 }, 
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82810_IG3,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1  },
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82810E_IG,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 2 },
-	/* mvo: added i815 PCI-ID */  
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82815_100,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 3 },
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82815_NOAGP,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 4 },
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82815_CGC,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 5 }
-};	  
-	             
 static int  __init i810fb_init_pci (struct pci_dev *dev, 
 				       const struct pci_device_id *entry);
 static void __exit i810fb_remove_pci(struct pci_dev *dev);
 static int i810fb_resume(struct pci_dev *dev);
 static int i810fb_suspend(struct pci_dev *dev, u32 state);
 
-static struct pci_driver i810fb_driver = {
-	.name     =	"i810fb",
-	.id_table =	i810fb_pci_tbl,
-	.probe    =	i810fb_init_pci,
-	.remove   =	__exit_p(i810fb_remove_pci),
-	.suspend  =     i810fb_suspend,
-	.resume   =     i810fb_resume,
-};	
-
-static int vram       __initdata = 4;
-static int bpp        __initdata = 8;
-static int mtrr       __initdata = 0;
-static int accel      __initdata = 0;
-static int hsync1     __initdata = 0;
-static int hsync2     __initdata = 0;
-static int vsync1     __initdata = 0;
-static int vsync2     __initdata = 0;
-static int xres       __initdata = 640;
-static int yres       __initdata = 480;
-static int vyres      __initdata = 0;
-static int sync       __initdata = 0;
-static int ext_vga    __initdata = 0;
-static int dcolor     __initdata = 0;
-
 /*
  * voffset - framebuffer offset in MiB from aperture start address.  In order for
  * the driver to work with X, we must try to use memory holes left untouched by X. The 
diff -puN drivers/video/i810/i810_main.c~i810-fix drivers/video/i810/i810_main.c
--- 25/drivers/video/i810/i810_main.c~i810-fix	2003-07-28 20:20:15.000000000 -0700
+++ 25-akpm/drivers/video/i810/i810_main.c	2003-07-28 20:20:15.000000000 -0700
@@ -56,6 +56,57 @@
 #include "i810.h"
 #include "i810_main.h"
 
+/* PCI */
+static const char *i810_pci_list[] __initdata = {
+	"Intel(R) 810 Framebuffer Device"                                 ,
+	"Intel(R) 810-DC100 Framebuffer Device"                           ,
+	"Intel(R) 810E Framebuffer Device"                                ,
+	"Intel(R) 815 (Internal Graphics 100Mhz FSB) Framebuffer Device"  ,
+	"Intel(R) 815 (Internal Graphics only) Framebuffer Device"        ,
+	"Intel(R) 815 (Internal Graphics with AGP) Framebuffer Device"
+};
+
+static struct pci_device_id i810fb_pci_tbl[] __initdata = {
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82810_IG1,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82810_IG3,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1  },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82810E_IG,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 2 },
+	/* mvo: added i815 PCI-ID */
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82815_100,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 3 },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82815_NOAGP,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 4 },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82815_CGC,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 5 },
+	{ 0 },
+};
+
+static struct pci_driver i810fb_driver = {
+	.name     =	"i810fb",
+	.id_table =	i810fb_pci_tbl,
+	.probe    =	i810fb_init_pci,
+	.remove   =	__exit_p(i810fb_remove_pci),
+	.suspend  =     i810fb_suspend,
+	.resume   =     i810fb_resume,
+};
+
+static int vram       __initdata = 4;
+static int bpp        __initdata = 8;
+static int mtrr       __initdata = 0;
+static int accel      __initdata = 0;
+static int hsync1     __initdata = 0;
+static int hsync2     __initdata = 0;
+static int vsync1     __initdata = 0;
+static int vsync2     __initdata = 0;
+static int xres       __initdata = 640;
+static int yres       __initdata = 480;
+static int vyres      __initdata = 0;
+static int sync       __initdata = 0;
+static int ext_vga    __initdata = 0;
+static int dcolor     __initdata = 0;
+
 /*------------------------------------------------------------*/
 
 /**************************************************************

_

