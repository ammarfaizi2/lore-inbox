Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbUCUWYk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 17:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261416AbUCUWYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 17:24:40 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:31249 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261422AbUCUWXh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 17:23:37 -0500
Date: Sun, 21 Mar 2004 22:23:27 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Woodhouse <dwmw2@infradead.org>,
       Christoph Hellwig <hch@infradead.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
Message-ID: <20040321222327.D26708@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Christoph Hellwig <hch@infradead.org>,
	William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
	linux-kernel@vger.kernel.org
References: <20040320144022.GC2045@holomorphy.com> <20040320150621.GO9009@dualathlon.random> <20040320121345.2a80e6a0.akpm@osdl.org> <20040320205053.GJ2045@holomorphy.com> <20040320222639.K6726@flint.arm.linux.org.uk> <20040320224500.GP2045@holomorphy.com> <1079901914.17681.317.camel@imladris.demon.co.uk> <20040321204931.A11519@infradead.org> <1079902670.17681.324.camel@imladris.demon.co.uk> <Pine.LNX.4.58.0403211349340.1106@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0403211349340.1106@ppc970.osdl.org>; from torvalds@osdl.org on Sun, Mar 21, 2004 at 01:53:41PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 21, 2004 at 01:53:41PM -0800, Linus Torvalds wrote:
> So I really put my veto on "nopage()" returning a PFN. That's just wrong, 
> wrong, wrong. It returns a "struct page" pointer, and it has lots of 
> reasons for that.

Ok then.  We leave nopage() as is, and define that for returning RAM
backed pages.

We also have a fault() handler which is used for faulting in driver
mappings, which returns a PFN suitable for set_pte().  The fault()
would be separate from do_no_page() in much the same way as
do_anonymous_page() is separate, and it knows that PFNs returned
from this have nothing to do with struct pages.  All it does is
set the relevant PTE entry in the page tables to create the mapping.

I don't think remap_area_pages() solves the problem - think about
the DMA ring buffer returned by dma_alloc_coherent().  This returns
an architectually defined virtual address and a DMA address.

Neither of these two addresses can be converted today to a struct
page or a PFN.  Sure, we can invent some architecture defined
interface to get hold of this information, but take a moment to
consider all the cases where this type of activity goes on.

What about the case where the buffer is scatter-gather in nature,
just like we're so fond of telling driver writers who want to grab
(eg) 1MB of contiguous kernel memory for video buffers and the like?
Do we really want to tell driver writers to walk over 1MB of pages,
page by page, inserting them into the processes page tables via
remap_area_pages()?

Or does the ->fault() method make sense in all these cases?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
