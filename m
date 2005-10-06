Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751343AbVJFUPf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343AbVJFUPf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 16:15:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751344AbVJFUPf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 16:15:35 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:7884 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751343AbVJFUPe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 16:15:34 -0400
Date: Thu, 6 Oct 2005 21:15:34 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: [RFC] gfp flags annotations
Message-ID: <20051006201534.GX7992@ftp.linux.org.uk>
References: <20050905155522.GA8057@mipter.zuzino.mipt.ru> <20050905160313.GH5155@ZenIV.linux.org.uk> <20050905164712.GI5155@ZenIV.linux.org.uk> <20050905212026.GL5155@ZenIV.linux.org.uk> <20050907183131.GF5155@ZenIV.linux.org.uk> <20050912191744.GN25261@ZenIV.linux.org.uk> <20050912192049.GO25261@ZenIV.linux.org.uk> <20050930120831.GI7992@ftp.linux.org.uk> <20051004203009.GQ7992@ftp.linux.org.uk> <20051005202904.GA27229@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051005202904.GA27229@mipter.zuzino.mipt.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2005 at 12:29:04AM +0400, Alexey Dobriyan wrote:
> > --- RC14-rc3-git4/arch/arm/mm/consistent.c
> > +++ RC14-rc3-git4-final/arch/arm/mm/consistent.c
> 
> > -vm_region_alloc(struct vm_region *head, size_t size, int gfp)
> > +vm_region_alloc(struct vm_region *head, size_t size, unsigned int gfp)
> 
> > -__dma_alloc(struct device *dev, size_t size, dma_addr_t *handle, int gfp,
> > -	    pgprot_t prot)
> > +__dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
> > +	    unsigned int gfp, pgprot_t prot)
> 
> 	unsigned int __nocast gfp
> 
> 	=> dma_alloc_coherent
> 	=> dma_alloc_writecombine

Speaking of that...  IMO we should do the following:

a) typedef unsigned int __nocast gfp_t;
b) replace __nocast uses for gfp flags with gfp_t - it gives exactly the same
warnings as far as sparse is concerned, doesn't change generated code and
documents what's going on far better.  If we are using __nocast for anything
else - sure, let it stay.
c) then replace __nocast in declaration of gfp_t with __bitwise [*], add
force cast to gfp_t to definitions of __GFP_... and deal with resulting
warnings.

Note that unlike __nocast, __bitwise is hard to lose; lossage like the above
will not go unnoticed.  We will need a couple of inline helpers to deal with
extraction of zone from gfp, etc., but after that it's basically a matter of
switching the missed chunks like the above.

I've done that several months ago, but that patch series had been killed
by bitrot (patches fixing the bugs I've found back then had been merged,
the rest had gone to bitbucket after a while).  It's not hard to reproduce,
though.

Objections?


[*] since endainness annotations are nowhere near complete, I suggest
the following: define __bitwise__ as __attribute__((bitwise)) or empty,
depending on __CHECKER__, then have

#ifdef __CHECK_ENDIAN__
#define __bitwise __bitwise__
#else
#define __bitwise
#endif
typedef unsigned int __bitwise__ gfp_t;

with -Wbitwise unconditionally in CHECKFLAGS.  Then normal run will pick
the places that use __bitwise__ and CF=-D__CHECK_ENDIAN__ will pick all
endianness warnings on top of that.  Basically, that allows to use
bitwise annotations while endianness stuff is not finished and do that
without drowning in warnings.
