Return-Path: <linux-kernel-owner+w=401wt.eu-S1754169AbXAAKOZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754169AbXAAKOZ (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 05:14:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754226AbXAAKOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 05:14:25 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:56213 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753681AbXAAKOZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 05:14:25 -0500
Subject: Re: replace "memset(...,0,PAGE_SIZE)" calls with "clear_page()"?
From: Arjan van de Ven <arjan@infradead.org>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Folkert van Heusden <folkert@vanheusden.com>,
       Paul Mundt <lethal@linux-sh.org>,
       Denis Vlasenko <vda.linux@googlemail.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0701010332130.3084@localhost.localdomain>
References: <Pine.LNX.4.64.0612290106550.4023@localhost.localdomain>
	 <200612302149.35752.vda.linux@googlemail.com>
	 <Pine.LNX.4.64.0612301705250.16056@localhost.localdomain>
	 <1167518748.20929.578.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.64.0612301750550.16519@localhost.localdomain>
	 <20061231183949.GA8323@linux-sh.org>
	 <Pine.LNX.4.64.0612311355520.17978@localhost.localdomain>
	 <20070101015932.GP13521@vanheusden.com>
	 <Pine.LNX.4.64.0701010332130.3084@localhost.localdomain>
Content-Type: text/plain
Organization: Intel International BV
Date: Mon, 01 Jan 2007 11:14:10 +0100
Message-Id: <1167646450.20929.921.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>   Given the above, some basic suggestions for page-based memory management:
> 
>  (a) If you need to allocate or free a single page, use the single page
>      version of the routine/macro, rather than calling the multi-page
>      version with an order value of zero, such as:
> 
> 	alloc_pages(gfp_mask, 0);	/* no */
> 	alloc_page(gfp_mask);		/* better */
> 
>  (b) If you need to allocate a single zeroed page by logical address,
>      use get_zeroed_page(), rather than __get_free_page() followed
>      by a call to memset() to clear that page.

both look good... I'd be in favor of this.
Maybe also add a part about using GFP_KERNEL whenever possible, GFP_NOFS
from filesystem writeout code and GFP_NOIO from block writeout code
(and never doing   in_interrupt()?GFP_ATOMIC:GFP_KERNEL !)


> 
>  (c) If you need to specifically allocate some DMA pages, use the
>      __get_dma_pages() macro, as in:
> 
> 	__get_free_pages(GFP_KERNEL|GFP_DMA, order)	/* no */
> 	__get_dma_pages(GFP_KERNEL, order)		/* better */

this.. does not really. GFP_DMA is an ancient artifact from the ISA
days. Better to describe the dma mapping interface (well give a pointer
to the doc that already exists about that), that one is REALLY for
allocating dma pages in this century.

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

