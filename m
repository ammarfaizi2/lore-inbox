Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263448AbUCTPoZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 10:44:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263449AbUCTPoZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 10:44:25 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:17936 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263448AbUCTPoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 10:44:24 -0500
Date: Sat, 20 Mar 2004 15:44:19 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrea Arcangeli <andrea@suse.de>
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
Message-ID: <20040320154419.A6726@flint.arm.linux.org.uk>
Mail-Followup-To: Andrea Arcangeli <andrea@suse.de>,
	William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>
References: <20040320133025.GH9009@dualathlon.random> <20040320144022.GC2045@holomorphy.com> <20040320150621.GO9009@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040320150621.GO9009@dualathlon.random>; from andrea@suse.de on Sat, Mar 20, 2004 at 04:06:21PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 20, 2004 at 04:06:21PM +0100, Andrea Arcangeli wrote:
> On Sat, Mar 20, 2004 at 06:40:22AM -0800, William Lee Irwin III wrote:
> > On Sat, Mar 20, 2004 at 02:30:25PM +0100, Andrea Arcangeli wrote:
> > > Anyways returning to the non-ram returned by ->nopage see the below
> > > email exchange with Jens. the bug triggering of course is the
> > > BUG_ON(!pfn_valid(page_to_pfn(new_page))).
> > > If we want to return non-ram, we could, but I believe we should change
> > > the API to return a pfn not a page_t * if we want to.
> > 
> > This would be very helpful for other reasons also. There's a general
> > API issue with drivers that want or need to do this. The one I've
> 
> I'm afraid I'll have to teach ->nopage how to deal with non-ram with
> this page_t API too (changing it to pfn sounds too intrusive in the
> short term), it seems to me that alsa can return non-ram (in the nopage
> callback there's a virt_to_page on some iomm region), and changing alsa
> to use remap_file_pages sounds too intrusive too. 

Actually, ALSA is broken in that respect - it isn't portable as it
stands.  It isn't the API which is broken - it's ALSA which is broken.
Performing virt_to_page() on any non-direct mapped RAM page (which
means the value returned from dma_alloc_coherent or pci_alloc_consistent)
is undefined.

One of my current projects is fixing this crap in ALSA.

Besides, returning an invalid struct page will lead to Bad Things(tm)
in set_pte().

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
