Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263453AbUCTP4z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 10:56:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263455AbUCTP4y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 10:56:54 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:35797
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263453AbUCTP4t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 10:56:49 -0500
Date: Sat, 20 Mar 2004 16:57:39 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
Message-ID: <20040320155739.GQ9009@dualathlon.random>
References: <20040320133025.GH9009@dualathlon.random> <20040320144022.GC2045@holomorphy.com> <20040320150621.GO9009@dualathlon.random> <20040320154419.A6726@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040320154419.A6726@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 20, 2004 at 03:44:19PM +0000, Russell King wrote:
> On Sat, Mar 20, 2004 at 04:06:21PM +0100, Andrea Arcangeli wrote:
> > On Sat, Mar 20, 2004 at 06:40:22AM -0800, William Lee Irwin III wrote:
> > > On Sat, Mar 20, 2004 at 02:30:25PM +0100, Andrea Arcangeli wrote:
> > > > Anyways returning to the non-ram returned by ->nopage see the below
> > > > email exchange with Jens. the bug triggering of course is the
> > > > BUG_ON(!pfn_valid(page_to_pfn(new_page))).
> > > > If we want to return non-ram, we could, but I believe we should change
> > > > the API to return a pfn not a page_t * if we want to.
> > > 
> > > This would be very helpful for other reasons also. There's a general
> > > API issue with drivers that want or need to do this. The one I've
> > 
> > I'm afraid I'll have to teach ->nopage how to deal with non-ram with
> > this page_t API too (changing it to pfn sounds too intrusive in the
> > short term), it seems to me that alsa can return non-ram (in the nopage
> > callback there's a virt_to_page on some iomm region), and changing alsa
> > to use remap_file_pages sounds too intrusive too. 
> 
> Actually, ALSA is broken in that respect - it isn't portable as it
> stands.  It isn't the API which is broken - it's ALSA which is broken.
> Performing virt_to_page() on any non-direct mapped RAM page (which
> means the value returned from dma_alloc_coherent or pci_alloc_consistent)
> is undefined.

this is exactly the problem.

> One of my current projects is fixing this crap in ALSA.

Do you agree it should be fixed by returning a PFN from ->nopage? or are
you doing it differently with remap_file_pages or peraphs you're just
multiplying the right pfn for sizeof(page_t) ingoring the misleading API?

> Besides, returning an invalid struct page will lead to Bad Things(tm)
> in set_pte().

you mean in the non-x86 archs right?

there is no way I can change ->nopage to return a pfn right now (this
stuff must work stable ASAP), so I'm currently teaching do_no_page to
handle non-ram pages (for the first time ever it will be able to do
that), I expect this at least will make it work right on x86 w/o iommu.

for mainline 2.6 if we want to keep using ->nopage I agree with Wli that
an API change is reasonable.

BTW, I was wrong talking about machine checks, the problem here is
reading random _virtual_ address (not phyisical ones), so it could oops
too on x86, and starting from 2.6.5-rc1 it'll corrupt mem too.
