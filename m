Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261429AbUKMLZn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261429AbUKMLZn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 06:25:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261823AbUKMLZn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 06:25:43 -0500
Received: from honk1.physik.uni-konstanz.de ([134.34.140.224]:47028 "EHLO
	honk1.physik.uni-konstanz.de") by vger.kernel.org with ESMTP
	id S261429AbUKMLZd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 06:25:33 -0500
Date: Sat, 13 Nov 2004 12:22:35 +0100
From: Guido Guenther <agx@sigxcpu.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@osdl.org>, adaplas@pol.net,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [Linux-fbdev-devel] Re: [PATCH] fbdev: Fix IO access in rivafb
Message-ID: <20041113112234.GA5523@bogon.ms20.nix>
References: <200411080521.iA85LbG6025914@hera.kernel.org> <200411090402.22696.adaplas@hotpop.com> <Pine.LNX.4.58.0411081211270.2301@ppc970.osdl.org> <200411090608.02759.adaplas@hotpop.com> <Pine.LNX.4.58.0411081422560.2301@ppc970.osdl.org> <20041112125125.GA3613@bogon.ms20.nix> <Pine.LNX.4.58.0411120755570.2301@ppc970.osdl.org> <20041112191852.GA4536@bogon.ms20.nix> <1100309972.20511.103.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1100309972.20511.103.camel@gaston>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 13, 2004 at 12:39:32PM +1100, Benjamin Herrenschmidt wrote:
> On Fri, 2004-11-12 at 20:18 +0100, Guido Guenther wrote:
> 
> > O.k., it was the __raw_{write,read}b which broke things, not the
> > "alignment". This one works:
> > 
> > diff -u -u linux-2.6.10-rc1-mm5.orig/drivers/video/riva/riva_hw.h linux-2.6.10-rc1-mm5/drivers/video/riva/riva_hw.h
> > --- linux-2.6.10-rc1-mm5.orig/drivers/video/riva/riva_hw.h	2004-11-12 13:42:54.000000000 +0100
> > +++ linux-2.6.10-rc1-mm5/drivers/video/riva/riva_hw.h	2004-11-12 17:39:22.000000000 +0100
> > @@ -75,8 +75,8 @@
> >   */
> >  #include <asm/io.h>
> >  
> > -#define NV_WR08(p,i,d)  (__raw_writeb((d), (void __iomem *)(p) + (i)))
> > -#define NV_RD08(p,i)    (__raw_readb((void __iomem *)(p) + (i)))
> > +#define NV_WR08(p,i,d)  (writeb((d), (void __iomem *)(p) + (i)))
> > +#define NV_RD08(p,i)    (readb((void __iomem *)(p) + (i)))
> 
> Interesting. The only difference here should be barriers. I hate the
> lack of barriers in that driver ... I'm not sure the driver may not have
Yes, it's a real pain. Missing barriers in RIVA_FIFO_FREE caused lots of
lockups, until I found them in your 2.4 tree.

> other bugs related to the lack of them in the 16 and 32 bits accessors.
> It does use non-barrier version on purpose in some accel ops though,
> when filling the fifo with pixels, but that's pretty much the only case
> where it makes sense.
> 
> > There aren't any, I actually attached the wrong patch. The non-working
> > version has __raw_{read,write}b8 instead of {read,write}b8. In 2.6.9
> > riva_hw.h used {in,out}_8 for NV_{RD,WR}08 so using the "non-raw"
> > writeb/readb now looks correct since these map to {in,out}_8 now.
> 
> {in,out}_8 are ppc-specific things that are identical to readb/writeb
> indeed, with barriers.
In 2.6.10-rc1-mm5 {in,out}_8 and read/writeb are exactly identical, only
__raw_{read,write}b is different. So you mean __raw_{read,write}b in the
above? (no nitpicking, just want to be sure I understand this
correctly).
Cheers,
 -- Guido
