Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262519AbUKLMwo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262519AbUKLMwo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 07:52:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262525AbUKLMwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 07:52:43 -0500
Received: from honk1.physik.uni-konstanz.de ([134.34.140.224]:13736 "EHLO
	honk1.physik.uni-konstanz.de") by vger.kernel.org with ESMTP
	id S262519AbUKLMwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 07:52:40 -0500
Date: Fri, 12 Nov 2004 13:51:26 +0100
From: Guido Guenther <agx@sigxcpu.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: adaplas@pol.net,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [Linux-fbdev-devel] Re: [PATCH] fbdev: Fix IO access in rivafb
Message-ID: <20041112125125.GA3613@bogon.ms20.nix>
References: <200411080521.iA85LbG6025914@hera.kernel.org> <200411090402.22696.adaplas@hotpop.com> <Pine.LNX.4.58.0411081211270.2301@ppc970.osdl.org> <200411090608.02759.adaplas@hotpop.com> <Pine.LNX.4.58.0411081422560.2301@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0411081422560.2301@ppc970.osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2004 at 02:25:04PM -0800, Linus Torvalds wrote:
> 
> 
> On Tue, 9 Nov 2004, Antonino A. Daplas wrote:
> > 
> > In big endian machines, the read*/write* accessors do a byteswap for an
> > inherently little endian PCI bus.  However, rivafb puts the hardwire in big
> > endian register access, thus the byteswap is not needed. So for 16- and
> > 32-bit access, instead of read*/write*, use __raw_read*/__raw_write* for all
> > archs.
> 
> Ok, applied with some further simplifications (use "void __iomem *" and 
> suddenly those /2 and /4 just go away - also use __raw_xxxx for the 
> single-byte versions to be consistent).
Doesn't work for me. This one works:

diff -u -u linux-2.6.10-rc1-mm5.orig/drivers/video/riva/riva_hw.h linux-2.6.10-rc1-mm5/drivers/video/riva/riva_hw.h
--- linux-2.6.10-rc1-mm5.orig/drivers/video/riva/riva_hw.h	2004-11-12 13:42:54.000000000 +0100
+++ linux-2.6.10-rc1-mm5/drivers/video/riva/riva_hw.h	2004-11-12 13:47:29.400807920 +0100
@@ -75,12 +75,12 @@
  */
 #include <asm/io.h>
 
-#define NV_WR08(p,i,d)  (__raw_writeb((d), (void __iomem *)(p) + (i)))
-#define NV_RD08(p,i)    (__raw_readb((void __iomem *)(p) + (i)))
-#define NV_WR16(p,i,d)  (__raw_writew((d), (void __iomem *)(p) + (i)))
-#define NV_RD16(p,i)    (__raw_readw((void __iomem *)(p) + (i)))
-#define NV_WR32(p,i,d)  (__raw_writel((d), (void __iomem *)(p) + (i)))
-#define NV_RD32(p,i)    (__raw_readl((void __iomem *)(p) + (i)))
+#define NV_WR08(p,i,d)  (writeb((d), (u8 __iomem *)(p) + (i)))
+#define NV_RD08(p,i)    (readb((u8 __iomem *)(p) + (i)))
+#define NV_WR16(p,i,d)  (__raw_writew((d), (u16 __iomem *)(p) + (i)/2))
+#define NV_RD16(p,i)    (__raw_readw((u16 __iomem *)(p) + (i)/2))
+#define NV_WR32(p,i,d)  (__raw_writel((d), (u32 __iomem *)(p) + (i)/4))
+#define NV_RD32(p,i)    (__raw_readl((u32 __iomem *)(p) + (i)/4))
 
 #define VGA_WR08(p,i,d) NV_WR08(p,i,d)
 #define VGA_RD08(p,i)   NV_RD08(p,i)

Interesting enough this one doesn't (only differenc in NV_{WR,RW}08:

diff -u -u linux-2.6.10-rc1-mm5.orig/drivers/video/riva/riva_hw.h linux-2.6.10-rc1-mm5/drivers/video/riva/riva_hw.h
--- linux-2.6.10-rc1-mm5.orig/drivers/video/riva/riva_hw.h	2004-11-12 13:42:54.000000000 +0100
+++ linux-2.6.10-rc1-mm5/drivers/video/riva/riva_hw.h	2004-11-12 13:47:29.400807920 +0100
@@ -75,12 +75,12 @@
  */
 #include <asm/io.h>
 
-#define NV_WR08(p,i,d)  (__raw_writeb((d), (void __iomem *)(p) + (i)))
-#define NV_RD08(p,i)    (__raw_readb((void __iomem *)(p) + (i)))
-#define NV_WR16(p,i,d)  (__raw_writew((d), (void __iomem *)(p) + (i)))
-#define NV_RD16(p,i)    (__raw_readw((void __iomem *)(p) + (i)))
-#define NV_WR32(p,i,d)  (__raw_writel((d), (void __iomem *)(p) + (i)))
-#define NV_RD32(p,i)    (__raw_readl((void __iomem *)(p) + (i)))
+#define NV_WR08(p,i,d)  (writeb((d), (u8 __iomem *)(p) + (i)))
+#define NV_RD08(p,i)    (readb((u8 __iomem *)(p) + (i)))
+#define NV_WR16(p,i,d)  (__raw_writew((d), (u16 __iomem *)(p) + (i)/2))
+#define NV_RD16(p,i)    (__raw_readw((u16 __iomem *)(p) + (i)/2))
+#define NV_WR32(p,i,d)  (__raw_writel((d), (u32 __iomem *)(p) + (i)/4))
+#define NV_RD32(p,i)    (__raw_readl((u32 __iomem *)(p) + (i)/4))
 
 #define VGA_WR08(p,i,d) NV_WR08(p,i,d)
 #define VGA_RD08(p,i)   NV_RD08(p,i)

Cheers,
 -- Guido
