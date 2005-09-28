Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964871AbVI1BjS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964871AbVI1BjS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 21:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964905AbVI1BjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 21:39:18 -0400
Received: from zproxy.gmail.com ([64.233.162.201]:9019 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964871AbVI1BjR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 21:39:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=FjMuG0TrFRx6SG/SyWpxBK5JUA2KwrVUHAIfs07frv0O9Q9EJo64GTSyAY2icsvEsewgNCzS+4tTJM85fEcn9dtbMIHQv3EaFr7dZpR/nuT61EWRLelbJcjZJCy336lCxZPH5fzLv0bu1hZslOtDtlsEPR0TJw5Y5OawQz9Lem8=
Message-ID: <4339F43C.3020507@gmail.com>
Date: Wed, 28 Sep 2005 09:39:08 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: janik holy <divizion@pobox.sk>
CC: linux-kernel@vger.kernel.org
Subject: Re: intelfb broken ?
References: <6c784b3971ca4a3293c1d745feaa6010@pobox.sk>
In-Reply-To: <6c784b3971ca4a3293c1d745feaa6010@pobox.sk>
Content-Type: text/plain; charset=windows-1250
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

janik holy wrote:
> Hello, i have hp compaq nx9020 with Display controller: Intel Corp. 82852/855GM Integrated Graphics Device (rev 02), im trying run console with framebuffer -> intelfb, in kernel 2.6.11, and vga=792, all work ok, just cursor is not visible. In all kernel > 2.6.11, vga=792, my laptop just booting, all should work, but display is all the time blank, nothing is seen.
> 
> this is log from 2.6.11, where all work but cursor is not visible, in lilo vga=792, because append=intelfb... is impossible to use if laptop...
> 
> intelfb: 00:02.0: Intel(R) 852GM, aperture size 128MB, stolen memory 32636kB
> intelfb: MTRR is disabled in the kernel
> intelfb: Non-CRT device is enabled ( LVDS port ).  Disabling mode switching.
> intelfb: Initial video mode is 1024x768-32@60.
> intelfb: Changing the video mode is not supported.
> Console: switching to colour frame buffer device 128x48
> 
> with > 2.6.11, actually 2.6.13.2 laptop boot, but on display is nothing, just black .. better blank display i try to look at dmesg (by blind)
> intelfb: Framebuffer driver for Intel(R) 830M/845G/852GM/855GM/865G/915G chipset
> s
> intelfb: Version 0.9.2
> ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
> PCI: setting IRQ 10 as level-triggered
> ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [LNKA] -> GSI 10 (level, low) -> IRQ
>  10
> intelfb: 00:02.0: Intel(R) 852GM, aperture size 128MB, stolen memory 32636kB
> intelfb: MTRR is disabled in the kernel
> intelfb: Non-CRT device is enabled ( LVDS port ).  Disabling mode switching.
> intelfb: Initial video mode is 1024x768-32@60.
> intelfb: Changing the video mode is not supported.
> Console: switching to colour frame buffer device 128x48
> 
> then same stuff like in 2.6.11 but dont work ;-/
> 
> In kernel i have compiled Graphic support -> * Support for the frame buffer devices -> * Intel 830/....
> 
>  Console display and driver support -> * Video mode selection support , * Framebuffer console support
> 
>  all this stuff compiled in kernel, not as module.
> 
> 
> 
> Any idea where can be problem ? why it doesnt work with new kernel, so its this drivers broken ? Thanks
> 
> 

Yes there was a regression when 2.6.13 came out.  Try this patch until the
intelfb maintainer has time to submit a definitive fix.

- Workaround for the ioremap patch that produces a blank display on some
  chipsets
- Make hwcursor = 0 the default.  The hardware cursor does not work with all
  hardware.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -767,6 +767,7 @@ config FB_INTEL
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
+	select FB_SOFT_CURSOR
 	help
 	  This driver supports the on-board graphics built in to the Intel
           830M/845G/852GM/855GM/865G chipsets.
diff --git a/drivers/video/intelfb/intelfbdrv.c b/drivers/video/intelfb/intelfbdrv.c
--- a/drivers/video/intelfb/intelfbdrv.c
+++ b/drivers/video/intelfb/intelfbdrv.c
@@ -226,7 +226,7 @@ MODULE_DEVICE_TABLE(pci, intelfb_pci_tab
 
 static int accel        = 1;
 static int vram         = 4;
-static int hwcursor     = 1;
+static int hwcursor     = 0;
 static int mtrr         = 1;
 static int fixed        = 0;
 static int noinit       = 0;
@@ -609,15 +609,9 @@ intelfb_pci_register(struct pci_dev *pde
 		dinfo->accel = 0;
 	}
 
-	if (MB(voffset) < stolen_size)
-		offset = (stolen_size >> 12);
-	else
-		offset = ROUND_UP_TO_PAGE(MB(voffset))/GTT_PAGE_SIZE;
-
 	/* Framebuffer parameters - Use all the stolen memory if >= vram */
-	if (ROUND_UP_TO_PAGE(stolen_size) >= ((offset << 12) +  MB(vram))) {
+	if (ROUND_UP_TO_PAGE(stolen_size) >= MB(vram)) {
 		dinfo->fb.size = ROUND_UP_TO_PAGE(stolen_size);
-		dinfo->fb.offset = 0;
 		dinfo->fbmem_gart = 0;
 	} else {
 		dinfo->fb.size =  MB(vram);
@@ -648,6 +642,11 @@ intelfb_pci_register(struct pci_dev *pde
 		return -ENODEV;
 	}
 
+	if (MB(voffset) < stolen_size)
+		offset = (stolen_size >> 12);
+	else
+		offset = ROUND_UP_TO_PAGE(MB(voffset))/GTT_PAGE_SIZE;
+
 	/* set the mem offsets - set them after the already used pages */
 	if (dinfo->accel) {
 		dinfo->ring.offset = offset + gtt_info.current_memory;
@@ -662,10 +661,11 @@ intelfb_pci_register(struct pci_dev *pde
 			+ (dinfo->cursor.size >> 12);
 	}
 
+	/* Allocate memories (which aren't stolen) */
 	/* Map the fb and MMIO regions */
 	/* ioremap only up to the end of used aperture */
 	dinfo->aperture.virtual = (u8 __iomem *)ioremap_nocache
-		(dinfo->aperture.physical, (dinfo->fb.offset << 12)
+		(dinfo->aperture.physical, ((offset + dinfo->fb.offset) << 12)
 		 + dinfo->fb.size);
 	if (!dinfo->aperture.virtual) {
 		ERR_MSG("Cannot remap FB region.\n");
@@ -682,7 +682,6 @@ intelfb_pci_register(struct pci_dev *pde
 		return -ENODEV;
 	}
 
-	/* Allocate memories (which aren't stolen) */
 	if (dinfo->accel) {
 		if (!(dinfo->gtt_ring_mem =
 		      agp_allocate_memory(bridge, dinfo->ring.size >> 12,
@@ -1484,7 +1483,7 @@ intelfb_cursor(struct fb_info *info, str
 #endif
 
 	if (!dinfo->hwcursor)
-		return -ENXIO;
+		return soft_cursor(info, cursor);
 
 	intelfbhw_cursor_hide(dinfo);
 
