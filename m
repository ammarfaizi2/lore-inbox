Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131063AbRCGRq1>; Wed, 7 Mar 2001 12:46:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131005AbRCGRqR>; Wed, 7 Mar 2001 12:46:17 -0500
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:39824 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S131125AbRCGRqH>; Wed, 7 Mar 2001 12:46:07 -0500
Date: Wed, 07 Mar 2001 09:43:11 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: SLAB vs. pci_alloc_xxx in usb-uhci patch
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Peter Zaitcev <zaitcev@redhat.com>, "David S. Miller" <davem@redhat.com>,
        Russell King <rmk@arm.linux.org.uk>,
        linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Message-id: <003501c0a72e$168c46c0$6800000a@brownell.org>
MIME-version: 1.0
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
Content-type: text/plain; charset="iso-8859-1"
Content-transfer-encoding: 7bit
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
In-Reply-To: <20010306004454.A12846@devserv.devel.redhat.com>
 <023301c0a693$087591e0$6800000a@brownell.org>
 <3AA5DDCC.7F9CBA91@colorfullife.com>
X-Priority: 3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > (1) CONFIG_SLAB_DEBUG breaks the documented
> > requirement that the slab cache return adequately aligned
> > data ...
> 
> adequately aligned for the _cpu_, not for some controllers. It's neither
> documented that HW_CACHEALIGN aligns to 16 byte boundaries

It's documented in mm/slab.c (line 612 in my ac7+tweaks).
"Aligns to hardware cache line."  The only cacheline define
I've found is in <asm/cache.h> for L1_CACHE_BYTES,
which is often more than 16 (not on x86).

If you don't like the patch I forwarded, then please submit
one that changes the kmem_cache_create() API spec ...
one or the other is needed.  (I'd not change that API!!)


> nor that kmalloc uses HW_CACHEALIGN. ...
>
> > + /* redzoning would break cache alignment requirements */
> > + if (flags & SLAB_HWCACHE_ALIGN)
> > +  flags &= ~SLAB_RED_ZONE;
> 
> The problem is that you've just disabled red zoning for kmalloc.   And
> kmalloc is the only case where redzoning is important: ...

If kmalloc wants to get auto redzoning, then I think it shouldn't be
using SLAB_HWCACHE_ALIGN when CONFIG_SLAB_DEBUG.
That'd be another simple fix.  (Or, make it use some new flag that's
just a performance hint that can be ignored for debugging.)

 
> I think everyone agrees that (2) correct fix.

I was saying that there were two bugs (two fixes needed), and you're
saying that there's only one ... despite the evidence of the API spec.
But you could persuade me there's a third bug:  kmalloc misuse of
that kmem_cache API.


> I see 2 temporary workarounds: either your patch or
> 
> + #ifdef CONFIG_SLAB_DEBUG
> + #error
> + #endif
> 
> in uhci.c.

Better in linux/drivers/usb/Config.in instead.  All the host controller
drivers rely on the kmem_cache_create() API spec to be followed.
(Even the OHCI driver, when using kmalloc not kmem_cache.)

- Dave


