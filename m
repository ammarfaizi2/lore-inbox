Return-Path: <linux-kernel-owner+w=401wt.eu-S1753681AbXAAKdl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753681AbXAAKdl (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 05:33:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755191AbXAAKdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 05:33:41 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:56164 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753681AbXAAKdk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 05:33:40 -0500
X-Originating-Ip: 74.109.98.100
Date: Mon, 1 Jan 2007 05:27:10 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Arjan van de Ven <arjan@infradead.org>
cc: Folkert van Heusden <folkert@vanheusden.com>,
       Paul Mundt <lethal@linux-sh.org>,
       Denis Vlasenko <vda.linux@googlemail.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: replace "memset(...,0,PAGE_SIZE)" calls with "clear_page()"?
In-Reply-To: <1167646450.20929.921.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.64.0701010515560.6039@localhost.localdomain>
References: <Pine.LNX.4.64.0612290106550.4023@localhost.localdomain> 
 <200612302149.35752.vda.linux@googlemail.com> 
 <Pine.LNX.4.64.0612301705250.16056@localhost.localdomain> 
 <1167518748.20929.578.camel@laptopd505.fenrus.org> 
 <Pine.LNX.4.64.0612301750550.16519@localhost.localdomain> 
 <20061231183949.GA8323@linux-sh.org>  <Pine.LNX.4.64.0612311355520.17978@localhost.localdomain>
  <20070101015932.GP13521@vanheusden.com>  <Pine.LNX.4.64.0701010332130.3084@localhost.localdomain>
 <1167646450.20929.921.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Jan 2007, Arjan van de Ven wrote:

> >   Given the above, some basic suggestions for page-based memory management:
> >
> >  (a) If you need to allocate or free a single page, use the single page
> >      version of the routine/macro, rather than calling the multi-page
> >      version with an order value of zero, such as:
> >
> > 	alloc_pages(gfp_mask, 0);	/* no */
> > 	alloc_page(gfp_mask);		/* better */
> >
> >  (b) If you need to allocate a single zeroed page by logical address,
> >      use get_zeroed_page(), rather than __get_free_page() followed
> >      by a call to memset() to clear that page.
>
> both look good... I'd be in favor of this. Maybe also add a part
> about using GFP_KERNEL whenever possible, GFP_NOFS from filesystem
> writeout code and GFP_NOIO from block writeout code (and never doing
> in_interrupt()?GFP_ATOMIC:GFP_KERNEL !)

it strikes me that that latter part is starting to go beyond the scope
of simple coding style aesthetics and getting into actual coding
distinctions.  would that really be appropriate for the CodingStyle
doc?  i'm just asking.

> >  (c) If you need to specifically allocate some DMA pages, use the
> >      __get_dma_pages() macro, as in:
> >
> > 	__get_free_pages(GFP_KERNEL|GFP_DMA, order)	/* no */
> > 	__get_dma_pages(GFP_KERNEL, order)		/* better */
>
> this.. does not really. GFP_DMA is an ancient artifact from the ISA
> days. Better to describe the dma mapping interface (well give a
> pointer to the doc that already exists about that), that one is
> REALLY for allocating dma pages in this century.

ok, i was just trying to make the calls consistent based on what i
could see in the current source code.  i'm still reviewing the
material on DMA -- feel free to suggest better wording.

rday

p.s.  what DMA doc are you referring to above?  DMA-mapping.txt?
