Return-Path: <linux-kernel-owner+w=401wt.eu-S933254AbXAAIiw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933254AbXAAIiw (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 03:38:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933256AbXAAIiw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 03:38:52 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:48509 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933254AbXAAIiw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 03:38:52 -0500
X-Originating-Ip: 74.109.98.100
Date: Mon, 1 Jan 2007 03:33:47 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Folkert van Heusden <folkert@vanheusden.com>
cc: Paul Mundt <lethal@linux-sh.org>, Arjan van de Ven <arjan@infradead.org>,
       Denis Vlasenko <vda.linux@googlemail.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: replace "memset(...,0,PAGE_SIZE)" calls with "clear_page()"?
In-Reply-To: <20070101015932.GP13521@vanheusden.com>
Message-ID: <Pine.LNX.4.64.0701010332130.3084@localhost.localdomain>
References: <Pine.LNX.4.64.0612290106550.4023@localhost.localdomain>
 <200612302149.35752.vda.linux@googlemail.com>
 <Pine.LNX.4.64.0612301705250.16056@localhost.localdomain>
 <1167518748.20929.578.camel@laptopd505.fenrus.org>
 <Pine.LNX.4.64.0612301750550.16519@localhost.localdomain>
 <20061231183949.GA8323@linux-sh.org> <Pine.LNX.4.64.0612311355520.17978@localhost.localdomain>
 <20070101015932.GP13521@vanheusden.com>
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

On Mon, 1 Jan 2007, Folkert van Heusden wrote:

> > > regarding alignment that don't allow clear_page() to be used
> > > copy_page() in the memcpy() case), but it's going to need a lot of
>
> Maybe these optimalisations should be in the coding style docs?

i was thinking of submitting the following as a new "chapter" for the
doc -- it would address *some* of these issues:


Chapter XX:  Page-related memory management

  The following functions and macro definitions are available via
include/linux/gfp.h for page-based memory management:

  struct page *alloc_pages(gfp_mask, order);
  unsigned long __get_free_pages(gfp_mask, order);
  unsigned long get_zeroed_page(gfp_mask);
  void __free_pages(struct page *page, order);
  void free_pages(unsigned long addr, order);

  #define alloc_page(gfp_mask) alloc_pages(gfp_mask, 0)
  #define __get_free_page(gfp_mask) __get_free_pages((gfp_mask),0)
  #define __free_page(page) __free_pages((page), 0)
  #define free_page(addr) free_pages((addr),0)

  #define __get_dma_pages(gfp_mask, order) \
                __get_free_pages((gfp_mask) | GFP_DMA,(order))

  Given the above, some basic suggestions for page-based memory management:

 (a) If you need to allocate or free a single page, use the single page
     version of the routine/macro, rather than calling the multi-page
     version with an order value of zero, such as:

	alloc_pages(gfp_mask, 0);	/* no */
	alloc_page(gfp_mask);		/* better */

 (b) If you need to allocate a single zeroed page by logical address,
     use get_zeroed_page(), rather than __get_free_page() followed
     by a call to memset() to clear that page.

 (c) If you need to specifically allocate some DMA pages, use the
     __get_dma_pages() macro, as in:

	__get_free_pages(GFP_KERNEL|GFP_DMA, order)	/* no */
	__get_dma_pages(GFP_KERNEL, order)		/* better */

 (d) If you need to clear (zero) a page, be aware that every
     architecture defines a clear_page() routine, either as a macro
     in include/<arch>/page.h or as an assembler routine.

     You should check if it's appropriate to use that routine/macro,
     rather than making an explicit call to memset(...,0, PAGE_SIZE).
