Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262634AbUKRBKM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262634AbUKRBKM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 20:10:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262654AbUKRBJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 20:09:23 -0500
Received: from mta1.cl.cam.ac.uk ([128.232.0.15]:28329 "EHLO mta1.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S262634AbUKRBFO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 20:05:14 -0500
To: Dave Hansen <haveblue@us.ibm.com>
cc: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Keir.Fraser@cl.cam.ac.uk,
       Christian.Limpach@cl.cam.ac.uk, Ian.Pratt@cl.cam.ac.uk
Subject: Re: [patch 4/4] Xen core patch : /dev/mem calls io_remap_page_range 
In-reply-to: Your message of "Wed, 17 Nov 2004 16:25:04 PST."
             <1100737504.12373.259.camel@localhost> 
Date: Thu, 18 Nov 2004 01:05:07 +0000
From: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Message-Id: <E1CUajU-0005vu-00@mta1.cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, 2004-11-17 at 15:56, Ian Pratt wrote:
> > +#if defined(CONFIG_XEN)
> > +       if (io_remap_page_range(vma, vma->vm_start, offset, 
> > +                               vma->vm_end-vma->vm_start, vma->vm_page_prot))
> > +               return -EAGAIN;
> > +#else
> >         if (remap_page_range(vma, vma->vm_start, offset, vma->vm_end-vma->vm_start,
> >                              vma->vm_page_prot))
> >                 return -EAGAIN;
> > +#endif
> >         return 0;
> >  }
> 
> Do *all* calls to remap_page_range() under your arch need to be
> converted like this, or is this the only one?  Seems like something that
> should be done with header magic instead.  

It's a bit tricky...

As I understand it, /dev/mem on x86 could potentially be used for
three distinct purposes:

  1 mapping the bottom 1MB of physical (bus) address space
  2 mapping MMIO devices (beyond physical memory)
  3 'copy-on-access' mappings of physical pages

This overloading creates a problem for us, as physical addresses
are not the same as bus addresses in Xen.  The first two uses
require bus addresses, the third physical addresses. 

I'm not actually aware of any applications that use
copy-on-access mappings of physical memory via /dev/mem, but
there are a whole bunch (most notable the X server) that use
/dev/mem for accessing the <1MB (BIOS) and MMIO frame buffer
regions.  Hence, it makes sense for us to choose to interpret the
offset passed in when mapping /dev/mem as a bus address, calling
io_remap_page_range.

As to whether there are any uses of remap_page_range within the
kernel that rely on behaviour 3, I'm not sure. Possibly the use
in af_packet.c does? Not sure. 

If there really are no uses, an alternative patch would be to
introduce an ARCH_HAS_REMAP_PAGE_RANGE. Would this be preferable?

Since drivers/char/mem.c already isn't exactly a thing of beauty
we were hoping we might get away with an extra CONFIG_XEN ;-)

Cheers,
Ian
