Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262558AbUKLQBN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262558AbUKLQBN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 11:01:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262559AbUKLQBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 11:01:13 -0500
Received: from fw.osdl.org ([65.172.181.6]:25257 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262558AbUKLQBJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 11:01:09 -0500
Date: Fri, 12 Nov 2004 08:01:00 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Guido Guenther <agx@sigxcpu.org>
cc: adaplas@pol.net,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [Linux-fbdev-devel] Re: [PATCH] fbdev: Fix IO access in rivafb
In-Reply-To: <20041112125125.GA3613@bogon.ms20.nix>
Message-ID: <Pine.LNX.4.58.0411120755570.2301@ppc970.osdl.org>
References: <200411080521.iA85LbG6025914@hera.kernel.org>
 <200411090402.22696.adaplas@hotpop.com> <Pine.LNX.4.58.0411081211270.2301@ppc970.osdl.org>
 <200411090608.02759.adaplas@hotpop.com> <Pine.LNX.4.58.0411081422560.2301@ppc970.osdl.org>
 <20041112125125.GA3613@bogon.ms20.nix>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 12 Nov 2004, Guido Guenther wrote:
>
> Doesn't work for me. This one works:
> 
> diff -u -u linux-2.6.10-rc1-mm5.orig/drivers/video/riva/riva_hw.h linux-2.6.10-rc1-mm5/drivers/video/riva/riva_hw.h
> --- linux-2.6.10-rc1-mm5.orig/drivers/video/riva/riva_hw.h	2004-11-12 13:42:54.000000000 +0100
> +++ linux-2.6.10-rc1-mm5/drivers/video/riva/riva_hw.h	2004-11-12 13:47:29.400807920 +0100
> @@ -75,12 +75,12 @@
>   */
>  #include <asm/io.h>
>  
> -#define NV_WR08(p,i,d)  (__raw_writeb((d), (void __iomem *)(p) + (i)))
> -#define NV_RD08(p,i)    (__raw_readb((void __iomem *)(p) + (i)))
> -#define NV_WR16(p,i,d)  (__raw_writew((d), (void __iomem *)(p) + (i)))
> -#define NV_RD16(p,i)    (__raw_readw((void __iomem *)(p) + (i)))
> -#define NV_WR32(p,i,d)  (__raw_writel((d), (void __iomem *)(p) + (i)))
> -#define NV_RD32(p,i)    (__raw_readl((void __iomem *)(p) + (i)))
> +#define NV_WR08(p,i,d)  (writeb((d), (u8 __iomem *)(p) + (i)))
> +#define NV_RD08(p,i)    (readb((u8 __iomem *)(p) + (i)))
> +#define NV_WR16(p,i,d)  (__raw_writew((d), (u16 __iomem *)(p) + (i)/2))
> +#define NV_RD16(p,i)    (__raw_readw((u16 __iomem *)(p) + (i)/2))
> +#define NV_WR32(p,i,d)  (__raw_writel((d), (u32 __iomem *)(p) + (i)/4))
> +#define NV_RD32(p,i)    (__raw_readl((u32 __iomem *)(p) + (i)/4))

Can you please try without the broken "u16" and "(i/2)" things (and u32
and i/4)? They really should not be needed, unless something is
_seriously_ broken. The only thing they do is the automatically align the
reference - and quite frankly, it looks like anybody passing an unaligned
register offset is _quite_ buggy.

IOW, it would seem that the real difference is the "__raw_writeb" vs
"writeb". Can you test just that change?

>  #define VGA_WR08(p,i,d) NV_WR08(p,i,d)
>  #define VGA_RD08(p,i)   NV_RD08(p,i)
> 
> Interesting enough this one doesn't (only differenc in NV_{WR,RW}08:
> 
> diff -u -u linux-2.6.10-rc1-mm5.orig/drivers/video/riva/riva_hw.h linux-2.6.10-rc1-mm5/drivers/video/riva/riva_hw.h
> --- linux-2.6.10-rc1-mm5.orig/drivers/video/riva/riva_hw.h	2004-11-12 13:42:54.000000000 +0100
> +++ linux-2.6.10-rc1-mm5/drivers/video/riva/riva_hw.h	2004-11-12 13:47:29.400807920 +0100
> @@ -75,12 +75,12 @@
>   */
>  #include <asm/io.h>
>  
> -#define NV_WR08(p,i,d)  (__raw_writeb((d), (void __iomem *)(p) + (i)))
> -#define NV_RD08(p,i)    (__raw_readb((void __iomem *)(p) + (i)))
> -#define NV_WR16(p,i,d)  (__raw_writew((d), (void __iomem *)(p) + (i)))
> -#define NV_RD16(p,i)    (__raw_readw((void __iomem *)(p) + (i)))
> -#define NV_WR32(p,i,d)  (__raw_writel((d), (void __iomem *)(p) + (i)))
> -#define NV_RD32(p,i)    (__raw_readl((void __iomem *)(p) + (i)))
> +#define NV_WR08(p,i,d)  (writeb((d), (u8 __iomem *)(p) + (i)))
> +#define NV_RD08(p,i)    (readb((u8 __iomem *)(p) + (i)))
> +#define NV_WR16(p,i,d)  (__raw_writew((d), (u16 __iomem *)(p) + (i)/2))
> +#define NV_RD16(p,i)    (__raw_readw((u16 __iomem *)(p) + (i)/2))
> +#define NV_WR32(p,i,d)  (__raw_writel((d), (u32 __iomem *)(p) + (i)/4))
> +#define NV_RD32(p,i)    (__raw_readl((u32 __iomem *)(p) + (i)/4))

I don't see the difference to your other patch. Did you put in the wrong
patch?

			Linus
