Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030881AbWK3Rrq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030881AbWK3Rrq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 12:47:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030885AbWK3Rrp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 12:47:45 -0500
Received: from mail.keyvoice.com ([12.153.69.53]:63141 "EHLO
	outbound.comdial.com") by vger.kernel.org with ESMTP
	id S1030881AbWK3Rrp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 12:47:45 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Re: Reserving a fixed physical address page of RAM.
Date: Thu, 30 Nov 2006 12:47:42 -0500
Message-ID: <22170ADB26112F478A4E293FF9D449F44D105B@secure.comdial.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Reserving a fixed physical address page of RAM.
Thread-Index: AccUpXLJ2/Z4a+SAQzSzq0FEfkXeogAANb1w
From: "Jon Ringle" <JRingle@vertical.com>
To: "Fawad Lateef" <fawadlateef@gmail.com>
Cc: "Dave Airlie" <airlied@gmail.com>, "Robert Hancock" <hancockr@shaw.ca>,
       <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fawad Lateef wrote:
> On 11/30/06, Jon Ringle <JRingle@vertical.com> wrote:
> > Fawad Lateef wrote:
> > > Yes, this can be used if required physical-memory exists 
> in the last 
> > > part of RAM as if you use mem=<xxxM> then kernel will only use 
> > > memory less than or equal-to <xxxM> and above can be used 
> by drivers 
> > > (or any kernel module) might be through ioremap which takes 
> > > physical-address.
> >
> > Seems that using mem= has to be in 1MB increments, where I 
> only need 4K.
> >
> 
> No AFAIK you can specify it in KBs (see
> http://sosdg.org/~coywolf/lxr/source/Documentation/kernel-para
> meters.txt#L869)

Yes, you can specify the mem= using K notation, but there is a test in
arch/arm/mm/mm-armv.c:create_mapping() that prevents the mapping from
being created if the boundaries are not MB aligned:

	if (mem_types[md->type].prot_l1 == 0 &&
	    (virt & 0xfffff || (virt + off) & 0xfffff || (virt + length)
& 0xfffff)) {
		printk(KERN_WARNING "BUG: map for 0x%08lx at 0x%08lx can
not "
		       "be mapped using pages, ignoring.\n",
		       __pfn_to_phys(md->pfn), md->virtual);
		return;
	}

This is in linux-2.6.16.29.

> 
> > >
> > > But if lets say we need only 1MB portion of specific 
> physical-memory 
> > > region then AFAIK it must be done by hacking in kernel 
> code during 
> > > memory-initialization (mem_init
> > > function) where it is marking/checking pages as/are reserved; you 
> > > can simply mark you required pages as reserved too and set their 
> > > count to some-value if you want to know later which pages are 
> > > reserved by you. (can do this reservation work
> > > here: 
> http://lxr.free-electrons.com/source/arch/i386/mm/init.c#605).
> >
> > Do you think that the following would work to properly reserve the 
> > memory. If it does, then I think I can just do a ioremap(0x0ffff000,
> > 0x1000) to obtain a virtual address. (Ofcourse I would actually use 
> > symbolic names rather than the hardcoded addesses shown here).
> >
> > Index: linux/arch/arm/mm/init.c
> > ===================================================================
> > --- linux.orig/arch/arm/mm/init.c       2006-11-30 
> 11:03:00.000000000
> > -0500
> > +++ linux/arch/arm/mm/init.c    2006-11-30 11:09:09.000000000 -0500
> > @@ -429,6 +429,10 @@
> >         unsigned long addr;
> >         void *vectors;
> >
> > +#ifdef CONFIG_MACH_VERTICAL_RSC4
> > +       reserve_bootmem (0x0ffff000, 0x1000); #endif
> > +
> >         /*
> >          * Allocate the vector page early.
> >          */
> >
> >
> 
> I think you can do like this but can't say accurately because 
> I havn't worked on arm architecture and also you havn't 
> mentioned your kernel-version or function (in file 
> arch/arm/mm/init.c) which you are going to do call reserve_bootmem !

Kernel version is 2.6.16.29 and the reserve_bootmem() call above is at
the top of the function devicemaps_init().

Jon
