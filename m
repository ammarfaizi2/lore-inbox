Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262706AbUKMBpp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262706AbUKMBpp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 20:45:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262747AbUKMBmg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 20:42:36 -0500
Received: from gate.crashing.org ([63.228.1.57]:61366 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262688AbUKMBkP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 20:40:15 -0500
Subject: Re: [Linux-fbdev-devel] Re: [PATCH] fbdev: Fix IO access in rivafb
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Guido Guenther <agx@sigxcpu.org>
Cc: Linus Torvalds <torvalds@osdl.org>, adaplas@pol.net,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20041112191852.GA4536@bogon.ms20.nix>
References: <200411080521.iA85LbG6025914@hera.kernel.org>
	 <200411090402.22696.adaplas@hotpop.com>
	 <Pine.LNX.4.58.0411081211270.2301@ppc970.osdl.org>
	 <200411090608.02759.adaplas@hotpop.com>
	 <Pine.LNX.4.58.0411081422560.2301@ppc970.osdl.org>
	 <20041112125125.GA3613@bogon.ms20.nix>
	 <Pine.LNX.4.58.0411120755570.2301@ppc970.osdl.org>
	 <20041112191852.GA4536@bogon.ms20.nix>
Content-Type: text/plain
Date: Sat, 13 Nov 2004 12:39:32 +1100
Message-Id: <1100309972.20511.103.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-11-12 at 20:18 +0100, Guido Guenther wrote:

> O.k., it was the __raw_{write,read}b which broke things, not the
> "alignment". This one works:
> 
> diff -u -u linux-2.6.10-rc1-mm5.orig/drivers/video/riva/riva_hw.h linux-2.6.10-rc1-mm5/drivers/video/riva/riva_hw.h
> --- linux-2.6.10-rc1-mm5.orig/drivers/video/riva/riva_hw.h	2004-11-12 13:42:54.000000000 +0100
> +++ linux-2.6.10-rc1-mm5/drivers/video/riva/riva_hw.h	2004-11-12 17:39:22.000000000 +0100
> @@ -75,8 +75,8 @@
>   */
>  #include <asm/io.h>
>  
> -#define NV_WR08(p,i,d)  (__raw_writeb((d), (void __iomem *)(p) + (i)))
> -#define NV_RD08(p,i)    (__raw_readb((void __iomem *)(p) + (i)))
> +#define NV_WR08(p,i,d)  (writeb((d), (void __iomem *)(p) + (i)))
> +#define NV_RD08(p,i)    (readb((void __iomem *)(p) + (i)))

Interesting. The only difference here should be barriers. I hate the
lack of barriers in that driver ... I'm not sure the driver may not have
other bugs related to the lack of them in the 16 and 32 bits accessors.
It does use non-barrier version on purpose in some accel ops though,
when filling the fifo with pixels, but that's pretty much the only case
where it makes sense.

> There aren't any, I actually attached the wrong patch. The non-working
> version has __raw_{read,write}b8 instead of {read,write}b8. In 2.6.9
> riva_hw.h used {in,out}_8 for NV_{RD,WR}08 so using the "non-raw"
> writeb/readb now looks correct since these map to {in,out}_8 now.

{in,out}_8 are ppc-specific things that are identical to readb/writeb
indeed, with barriers.

Ben.


