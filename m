Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261469AbUKLT17@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261469AbUKLT17 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 14:27:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261769AbUKLTZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 14:25:57 -0500
Received: from honk1.physik.uni-konstanz.de ([134.34.140.224]:59820 "EHLO
	honk1.physik.uni-konstanz.de") by vger.kernel.org with ESMTP
	id S261608AbUKLTVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 14:21:12 -0500
Date: Fri, 12 Nov 2004 20:18:52 +0100
From: Guido Guenther <agx@sigxcpu.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: adaplas@pol.net,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [Linux-fbdev-devel] Re: [PATCH] fbdev: Fix IO access in rivafb
Message-ID: <20041112191852.GA4536@bogon.ms20.nix>
References: <200411080521.iA85LbG6025914@hera.kernel.org> <200411090402.22696.adaplas@hotpop.com> <Pine.LNX.4.58.0411081211270.2301@ppc970.osdl.org> <200411090608.02759.adaplas@hotpop.com> <Pine.LNX.4.58.0411081422560.2301@ppc970.osdl.org> <20041112125125.GA3613@bogon.ms20.nix> <Pine.LNX.4.58.0411120755570.2301@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0411120755570.2301@ppc970.osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2004 at 08:01:00AM -0800, Linus Torvalds wrote:
> On Fri, 12 Nov 2004, Guido Guenther wrote:
> >
> > Doesn't work for me. This one works:
> > 
> > diff -u -u linux-2.6.10-rc1-mm5.orig/drivers/video/riva/riva_hw.h linux-2.6.10-rc1-mm5/drivers/video/riva/riva_hw.h
> > --- linux-2.6.10-rc1-mm5.orig/drivers/video/riva/riva_hw.h	2004-11-12 13:42:54.000000000 +0100
> > +++ linux-2.6.10-rc1-mm5/drivers/video/riva/riva_hw.h	2004-11-12 13:47:29.400807920 +0100
> > @@ -75,12 +75,12 @@
> >   */
> >  #include <asm/io.h>
> >  
> > -#define NV_WR08(p,i,d)  (__raw_writeb((d), (void __iomem *)(p) + (i)))
> > -#define NV_RD08(p,i)    (__raw_readb((void __iomem *)(p) + (i)))
> > -#define NV_WR16(p,i,d)  (__raw_writew((d), (void __iomem *)(p) + (i)))
> > -#define NV_RD16(p,i)    (__raw_readw((void __iomem *)(p) + (i)))
> > -#define NV_WR32(p,i,d)  (__raw_writel((d), (void __iomem *)(p) + (i)))
> > -#define NV_RD32(p,i)    (__raw_readl((void __iomem *)(p) + (i)))
> > +#define NV_WR08(p,i,d)  (writeb((d), (u8 __iomem *)(p) + (i)))
> > +#define NV_RD08(p,i)    (readb((u8 __iomem *)(p) + (i)))
> > +#define NV_WR16(p,i,d)  (__raw_writew((d), (u16 __iomem *)(p) + (i)/2))
> > +#define NV_RD16(p,i)    (__raw_readw((u16 __iomem *)(p) + (i)/2))
> > +#define NV_WR32(p,i,d)  (__raw_writel((d), (u32 __iomem *)(p) + (i)/4))
> > +#define NV_RD32(p,i)    (__raw_readl((u32 __iomem *)(p) + (i)/4))
> 
> Can you please try without the broken "u16" and "(i/2)" things (and u32
> and i/4)? They really should not be needed, unless something is
> _seriously_ broken. The only thing they do is the automatically align the
> reference - and quite frankly, it looks like anybody passing an unaligned
> register offset is _quite_ buggy.
O.k., it was the __raw_{write,read}b which broke things, not the
"alignment". This one works:

diff -u -u linux-2.6.10-rc1-mm5.orig/drivers/video/riva/riva_hw.h linux-2.6.10-rc1-mm5/drivers/video/riva/riva_hw.h
--- linux-2.6.10-rc1-mm5.orig/drivers/video/riva/riva_hw.h	2004-11-12 13:42:54.000000000 +0100
+++ linux-2.6.10-rc1-mm5/drivers/video/riva/riva_hw.h	2004-11-12 17:39:22.000000000 +0100
@@ -75,8 +75,8 @@
  */
 #include <asm/io.h>
 
-#define NV_WR08(p,i,d)  (__raw_writeb((d), (void __iomem *)(p) + (i)))
-#define NV_RD08(p,i)    (__raw_readb((void __iomem *)(p) + (i)))
+#define NV_WR08(p,i,d)  (writeb((d), (void __iomem *)(p) + (i)))
+#define NV_RD08(p,i)    (readb((void __iomem *)(p) + (i)))
 #define NV_WR16(p,i,d)  (__raw_writew((d), (void __iomem *)(p) + (i)))
 #define NV_RD16(p,i)    (__raw_readw((void __iomem *)(p) + (i)))
 #define NV_WR32(p,i,d)  (__raw_writel((d), (void __iomem *)(p) + (i)))

Signed-off-by: Guido Guenther <agx@sigxcpu.org>

> IOW, it would seem that the real difference is the "__raw_writeb" vs
> "writeb". Can you test just that change?
> 
> >  #define VGA_WR08(p,i,d) NV_WR08(p,i,d)
> >  #define VGA_RD08(p,i)   NV_RD08(p,i)
> > 
> > Interesting enough this one doesn't (only differenc in NV_{WR,RW}08:
> > 
> 
> I don't see the difference to your other patch. Did you put in the wrong
> patch?
There aren't any, I actually attached the wrong patch. The non-working
version has __raw_{read,write}b8 instead of {read,write}b8. In 2.6.9
riva_hw.h used {in,out}_8 for NV_{RD,WR}08 so using the "non-raw"
writeb/readb now looks correct since these map to {in,out}_8 now.
Cheers,
 -- Guido
