Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269973AbUICXlQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269973AbUICXlQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 19:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269985AbUICXlQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 19:41:16 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:51973 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S269973AbUICXk2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 19:40:28 -0400
Date: Sat, 4 Sep 2004 00:40:24 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Christoph Hellwig <hch@infradead.org>, Patrick Gefre <pfg@sgi.com>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Latest Altix I/O code reorganization code
Message-ID: <20040904004024.A10459@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Patrick Gefre <pfg@sgi.com>, linux-ia64@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <200408042014.i74KE8fD141211@fsgi900.americas.sgi.com> <20040806141836.A9854@infradead.org> <411AAABB.8070707@sgi.com> <412F4EC9.7050003@sgi.com> <20040827165443.A32567@infradead.org> <20040827172131.A473@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040827172131.A473@infradead.org>; from hch@infradead.org on Fri, Aug 27, 2004 at 05:21:31PM +0100
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Crosscheck of your new code vs the review:

> io_init.c:
> 
>  - sal_get_hubdev_info
> 	umm, you're getting a kernel pointer by a SAL
>  	call.  I wonders how this is supposed to work when the kernel
> 	changes it's VA layout.  (Dito for a bunch of other functions)

Still not explanation

>  - sn_io_init
> 	what's going on here?

gone

> iomv.c:
> 
>  - okay, could use some reformatting to fit 80 chars

ok

> pci_dma.c:
> 
>  - still using all those indirections althoug there's only a single backend

this comment is fixed, but the one later sent in private (stupid choice
of interface beteen upper pci dma code and pcibr code ignored)

> pci_extension.c:
> 
>  - dito.  Why does this single function need a separate file?

Not addressed.  In general your file organization is mess still.

Just do arch/ia64/sn/pci/ for all pci code and move the rest to
arch/ia64/sn/kernel.  That how most arches work.

> pcibr_ate.c:
> 
>  - doesn't look to bad, but should probably merged into pcibr_dma.c.  And
>    the trivial < 10 line function opencoded in their only callers.

Not addressed or commented on yet.

> pcibr_provider.c
> 
>  actual code code looks okay, but:
> 
>   - sal_pcibr_slot_enable/sal_pcibr_slot_disabl are completely unused

you still have typedefs for these around

>   - the pci_provider abstraction is right now completely useless, please
>     add such abstractions only when you need them (and if you'll ever need
>     that a few hints:  stop that casting of methods silliness but use
>     container_of, use C99 initializers, stop the typedef abuse)

ok

>   - request_irq return value needs checking

ok

> 
> pcibr_reg.c:
> 
>  - all this casting is rather horrible.  At least keep a pointer to each
>    of struct tiocp and pic_s (and kill the _s postifx) in syruct pcibus_info.
>    the volatiles looks bogus, if you need it you're missing memorry barries.

the type pointer isn't done.  Any specific reason?

> xtalk_providers.c:
> 
>  - bogus indirection again.  if you actually do have different lowlevel
>    implementations they should be hidden inside the prom.  While at it I think
>    the two calls could just move to arch/ia64/sn/kernel/irq.c

ok

More items:

 - sal_pcibr_rrb_alloc should be merged into its only caller
 - io_init.c still has KDB ifdefs
 - sn_pci_set_vchan should absolutely _not_ be placed in qla1280.c,
   and while you're at it there extern for snia_pcibr_rrb_alloc should
   move to a header
 - kill HUBREG_CAST instead of touching it
 - please don't put your ASSERT into asm/ headers.  In general you
   should use BUG_ON
 - why do you add a pfn_t typedef that's not used anywhere
 - the patch adds include/asm-ia64/sn/xtalk/xtalk_provider.h but there's
   no more xtalk providers

Your headers are still a complete mess.  There's no point exposing tons
of defails about the pci interface in include/asm - just keep and
pci_extensions.h there for non-standard PCI APIs, and the rest should
stay private inisde arch/ia64/sn/pci/.
