Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268702AbUIGWRv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268702AbUIGWRv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 18:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268704AbUIGWRg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 18:17:36 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:35079 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S268703AbUIGWQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 18:16:50 -0400
Date: Tue, 7 Sep 2004 23:16:45 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Patrick Gefre <pfg@sgi.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Latest Altix I/O code reorganization code
Message-ID: <20040907231645.A20934@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Patrick Gefre <pfg@sgi.com>, linux-ia64@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <200408042014.i74KE8fD141211@fsgi900.americas.sgi.com> <20040806141836.A9854@infradead.org> <411AAABB.8070707@sgi.com> <412F4EC9.7050003@sgi.com> <20040827165443.A32567@infradead.org> <20040827172131.A473@infradead.org> <20040904004024.A10459@infradead.org> <413E31D1.9090301@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <413E31D1.9090301@sgi.com>; from pfg@sgi.com on Tue, Sep 07, 2004 at 05:10:25PM -0500
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2004 at 05:10:25PM -0500, Patrick Gefre wrote:
>  > of interface beteen upper pci dma code and pcibr code ignored)
>  >
> 
> Guess I'm confused about this then. Are you suggesting putting the pcibr_dma files
> into the pci_dma.c code and not having a pcibr_dma interface ?? The api is there because
> pcibr is an ASIC and is ASIC specific.

No, absolutely not.  I suggested you remove the remaining ASIC-specific
bits from pci_dma.c, namely the decision when to use direct translation
and where to use ates, and the flags and only have a single mapping
routine calling into pcibr code with a prototype ala:

dma_addr_t picbr_dma_map(struct pci_dev *dev, unsigned long phys, size_t size);

>  > > pci_extension.c:
>  > >
>  > >  - dito.  Why does this single function need a separate file?
>  >
>  > Not addressed.  In general your file organization is mess still.
>  >
> 
> How is this:
> arch/ia64/sn/pci/
>                   pci_dma.c
>                   pci_extension.c
>                   pcibr/
>                       pcibr_ate.c
>                       pcibr_dma.c
>                       pcibr_provider.c
>                       pcibr_reg.c
> 
> arch/ia64/sn/kernel/
>                   bte_error.c
>                   io_init.c
>                   iomv.c
> 
> Since pcibr is an ASIC it makes sense for it to have its own directory. There are
> other ASIC interfaces that will be put in in the not too distant future and they
> will go in separate directories also.

Isn't the pcibr_ prefix enough?  This isn't something that would hold up
merging, but I think the additional level is a little silly.

> I will inline free_ate_resource(), alloc_ate_resource() and ate_write(). I want to
> keep the ate code in a separate file - since it is a group of functions with a similar
> theme and is non-trivial.

Okay..

>  > >    of struct tiocp and pic_s (and kill the _s postifx) in syruct pcibus_info.
>  > >    the volatiles looks bogus, if you need it you're missing memorry barries.
>  >
>  > the type pointer isn't done.  Any specific reason?
>  >
> 
> I'm confused on this too. The struct defs are for different MMR sets - so we do need
> to use different types of pointers.

What about adding an union of both _typed_ pointers so you don't need
to cast everytime?


Anyway, it looks like we're making nice progress, thanks for the work.
