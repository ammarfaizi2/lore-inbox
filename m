Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262669AbUKMNBL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262669AbUKMNBL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 08:01:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262679AbUKMNBL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 08:01:11 -0500
Received: from honk1.physik.uni-konstanz.de ([134.34.140.224]:9909 "EHLO
	honk1.physik.uni-konstanz.de") by vger.kernel.org with ESMTP
	id S262669AbUKMNBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 08:01:08 -0500
Date: Sat, 13 Nov 2004 13:57:53 +0100
From: Guido Guenther <agx@sigxcpu.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: adaplas@pol.net,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [Linux-fbdev-devel] Re: [PATCH] fbdev: Fix IO access in rivafb
Message-ID: <20041113125753.GA4763@bogon.ms20.nix>
References: <200411080521.iA85LbG6025914@hera.kernel.org> <200411090402.22696.adaplas@hotpop.com> <Pine.LNX.4.58.0411081211270.2301@ppc970.osdl.org> <200411090608.02759.adaplas@hotpop.com> <Pine.LNX.4.58.0411081422560.2301@ppc970.osdl.org> <20041112125125.GA3613@bogon.ms20.nix> <Pine.LNX.4.58.0411120755570.2301@ppc970.osdl.org> <20041112191852.GA4536@bogon.ms20.nix> <Pine.LNX.4.58.0411121130550.2301@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0411121130550.2301@ppc970.osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2004 at 11:32:07AM -0800, Linus Torvalds wrote:
> 
> 
> On Fri, 12 Nov 2004, Guido Guenther wrote:
> >
> > O.k., it was the __raw_{write,read}b which broke things, not the
> > "alignment". This one works:
> 
> All right, that's as expected. However, it does seem to point out that the 
> riva driver depends on _different_ memory ordering guarantees for the 
> 8-bit accesses as opposed to the other ones. Whee. Can you say "UGGLEE"?

Aglie. This scared me too, so I had another look. It seems P{V,C}IO
areas are only accessed using VGA_{RD,WR}8 macros. NV_{RW,WR}08 are
never actually used directly. So this patch makes at least usage
consistent. VGA_{RD,WR}8 to access "I/O areas" in an ordered way. NV_*
for the rest. Please apply.
Cheers,
 -- Guido

--- linux-2.6.10-rc1-mm5/drivers/video/riva/riva_hw.orig.2	2004-11-13 12:24:48.000000000 +0100
+++ linux-2.6.10-rc1-mm5/drivers/video/riva/riva_hw.h	2004-11-13 12:24:56.000000000 +0100
@@ -75,15 +75,15 @@
  */
 #include <asm/io.h>
 
-#define NV_WR08(p,i,d)  (writeb((d), (void __iomem *)(p) + (i)))
-#define NV_RD08(p,i)    (readb((void __iomem *)(p) + (i)))
+#define NV_WR08(p,i,d)  (__raw_writeb((d), (void __iomem *)(p) + (i)))
+#define NV_RD08(p,i)    (__raw_readb((void __iomem *)(p) + (i)))
 #define NV_WR16(p,i,d)  (__raw_writew((d), (void __iomem *)(p) + (i)))
 #define NV_RD16(p,i)    (__raw_readw((void __iomem *)(p) + (i)))
 #define NV_WR32(p,i,d)  (__raw_writel((d), (void __iomem *)(p) + (i)))
 #define NV_RD32(p,i)    (__raw_readl((void __iomem *)(p) + (i)))
 
-#define VGA_WR08(p,i,d) NV_WR08(p,i,d)
-#define VGA_RD08(p,i)   NV_RD08(p,i)
+#define VGA_WR08(p,i,d) (writeb((d), (void __iomem *)(p) + (i)))
+#define VGA_RD08(p,i)   (readb((void __iomem *)(p) + (i)))
 
 /*
  * Define different architectures.

Signed-Off-By: Guido Guenther <agx@sigxcpu.org>
