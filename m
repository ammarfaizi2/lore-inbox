Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262669AbUKRIg7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262669AbUKRIg7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 03:36:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262683AbUKRIg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 03:36:58 -0500
Received: from mta1.cl.cam.ac.uk ([128.232.0.15]:61389 "EHLO mta1.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S262669AbUKRIgJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 03:36:09 -0500
To: Dave Hansen <haveblue@us.ibm.com>
cc: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Keir.Fraser@cl.cam.ac.uk,
       Christian.Limpach@cl.cam.ac.uk
Subject: Re: [patch 2] Xen core patch : arch_free_page return value 
In-Reply-To: Your message of "Wed, 17 Nov 2004 17:26:41 PST."
             <1100741201.12373.276.camel@localhost> 
Date: Thu, 18 Nov 2004 08:35:57 +0000
From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Message-Id: <E1CUhlm-0003Ro-00@mta1.cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Pages that have been allocated by our custom allocators get passed
> > into standard linux subsystems where we get no control over how
> > they're freed.
> 
> OK, then how are they allocated?  Are they only allocated by your
> special drivers or in your architecture?

Yes, they are only allocated within our own code. I use "allocation"
loosely here -- in the case of our network backend driver, the page
fragments that we pass into the network subsystem are actually
temporary mappings of other domains' RAM -- not allocated from this
kernel's heap at all.

> I think allowing this is weird:
> 
>         foo = special_zen_malloc();
>         bar = kmalloc();
>         kfree(foo);
>         kfree(bar);
>         
> Shoudn't it be
> 
> 	special_zen_free(free);?

We don't hook into the slab allocator, but into the page_alloc zoned
buddy allocator: so in your example replace kmalloc() with
get_free_page(), and kfree() with free_page(). The point is that we
can't always use 'special_xen_free_page()' because the page's refcnt
may fall to zero within a generic Linux subsystem (e.g., the network
stack). So we need to be able to hook of free_page().

It would be great if we could have a "destructor hook" per page that
points at the relevant heap-free function to use, but that'd never fly
here. This is the best we can do with absolutely minimal source
impact, and no run-time impact on other arches.

> BTW, your arch-specific definition of PG_foreign is a little goofy.  If
> you need the bit, then put it in page-flags.h now.  The memory hotplug
> people have an evil plan to consume all unused bits in page->flags
> (determined at compile-time) and that little gem will certainly break
> it.  

The whole of our foreign_page.h was in page-flags.h. Do you think the
whole lot should go back, or just the bit definition? 

> It's great that you contained stuff to your architecture, but little
> bits like the page-flags thing don't make me think you've done it for
> real, only hacked around it :)

We hacked around it in this case because the PageForeign stuff was
entirely within page_alloc.c and page-flags.h. Since only Xen used it
we were asked if we could have less non-arch source impact and this is
what we came up with. :-) Point taken on PG_foreign though.

 -- Keir
