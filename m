Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268707AbUIGWLS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268707AbUIGWLS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 18:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268701AbUIGWLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 18:11:16 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:44471 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S268702AbUIGWKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 18:10:24 -0400
Message-ID: <413E31D1.9090301@sgi.com>
Date: Tue, 07 Sep 2004 17:10:25 -0500
From: Patrick Gefre <pfg@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Latest Altix I/O code reorganization code
References: <200408042014.i74KE8fD141211@fsgi900.americas.sgi.com> <20040806141836.A9854@infradead.org> <411AAABB.8070707@sgi.com> <412F4EC9.7050003@sgi.com> <20040827165443.A32567@infradead.org> <20040827172131.A473@infradead.org> <20040904004024.A10459@infradead.org>
In-Reply-To: <20040904004024.A10459@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

> Crosscheck of your new code vs the review:
> 
> 
> >io_init.c:
> >
> > - sal_get_hubdev_info
> >	umm, you're getting a kernel pointer by a SAL
> > 	call.  I wonders how this is supposed to work when the kernel
> >	changes it's VA layout.  (Dito for a bunch of other functions)
> 
> 

I will change the ptr passed to a physical address.


 > >  - sn_io_init
 > >       what's going on here?
 >
 > gone
 >
 > > iomv.c:
 > >
 > >  - okay, could use some reformatting to fit 80 chars
 >
 > ok
 >
 > > pci_dma.c:
 > >
 > >  - still using all those indirections althoug there's only a single backend
 >
 > this comment is fixed, but the one later sent in private (stupid choice
 > of interface beteen upper pci dma code and pcibr code ignored)
 >

Guess I'm confused about this then. Are you suggesting putting the pcibr_dma files
into the pci_dma.c code and not having a pcibr_dma interface ?? The api is there because
pcibr is an ASIC and is ASIC specific.


 > > pci_extension.c:
 > >
 > >  - dito.  Why does this single function need a separate file?
 >
 > Not addressed.  In general your file organization is mess still.
 >

How is this:
arch/ia64/sn/pci/
                  pci_dma.c
                  pci_extension.c
                  pcibr/
                      pcibr_ate.c
                      pcibr_dma.c
                      pcibr_provider.c
                      pcibr_reg.c

arch/ia64/sn/kernel/
                  bte_error.c
                  io_init.c
                  iomv.c

Since pcibr is an ASIC it makes sense for it to have its own directory. There are
other ASIC interfaces that will be put in in the not too distant future and they
will go in separate directories also.



 > Just do arch/ia64/sn/pci/ for all pci code and move the rest to
 > arch/ia64/sn/kernel.  That how most arches work.
 >
 > > pcibr_ate.c:
 > >
 > >  - doesn't look to bad, but should probably merged into pcibr_dma.c.  And
 > >    the trivial < 10 line function opencoded in their only callers.
 >
 > Not addressed or commented on yet.
 >

I will inline free_ate_resource(), alloc_ate_resource() and ate_write(). I want to
keep the ate code in a separate file - since it is a group of functions with a similar
theme and is non-trivial.


 > > pcibr_provider.c
 > >
 > >  actual code code looks okay, but:
 > >
 > >   - sal_pcibr_slot_enable/sal_pcibr_slot_disabl are completely unused
 >
 > you still have typedefs for these around
 >

Missed them - I'll take them out.


 > >   - the pci_provider abstraction is right now completely useless, please
 > >     add such abstractions only when you need them (and if you'll ever need
 > >     that a few hints:  stop that casting of methods silliness but use
 > >     container_of, use C99 initializers, stop the typedef abuse)
 >
 > ok
 >
 > >   - request_irq return value needs checking
 >
 > ok
 >> > pcibr_reg.c:
 > >
 > >  - all this casting is rather horrible.  At least keep a pointer to each
 > >    of struct tiocp and pic_s (and kill the _s postifx) in syruct pcibus_info.
 > >    the volatiles looks bogus, if you need it you're missing memorry barries.
 >
 > the type pointer isn't done.  Any specific reason?
 >

I'm confused on this too. The struct defs are for different MMR sets - so we do need
to use different types of pointers.


 > > xtalk_providers.c:
 > >
 > >  - bogus indirection again.  if you actually do have different lowlevel
 > >    implementations they should be hidden inside the prom.  While at it I think
 > >    the two calls could just move to arch/ia64/sn/kernel/irq.c
 >
 > ok
 >
 > More items:
 >
 >  - sal_pcibr_rrb_alloc should be merged into its only caller

I'll move the sal_pcibr_rrb_alloc() code into snia_pcibr_rrb_alloc()


 >  - io_init.c still has KDB ifdefs

Sorry, missed this....


 >  - sn_pci_set_vchan should absolutely _not_ be placed in qla1280.c,

I'll fix this.


 >    and while you're at it there extern for snia_pcibr_rrb_alloc should
 >    move to a header

OK.

 >  - kill HUBREG_CAST instead of touching it

OK.

 >  - please don't put your ASSERT into asm/ headers.  In general you
 >    should use BUG_ON

OK.

 >  - why do you add a pfn_t typedef that's not used anywhere
 >  - the patch adds include/asm-ia64/sn/xtalk/xtalk_provider.h but there's
 >    no more xtalk providers
 >

Missed these too.


 > Your headers are still a complete mess.  There's no point exposing tons
 > of defails about the pci interface in include/asm - just keep and
 > pci_extensions.h there for non-standard PCI APIs, and the rest should
 > stay private inisde arch/ia64/sn/pci/.

I'll work on fixing this up.


