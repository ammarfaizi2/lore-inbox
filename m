Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263578AbUCUAXk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 19:23:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263583AbUCUAXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 19:23:40 -0500
Received: from holomorphy.com ([207.189.100.168]:3466 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263578AbUCUAXi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 19:23:38 -0500
Date: Sat, 20 Mar 2004 16:23:25 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: rmk@arm.linux.org.uk, Jaroslav Kysela <perex@suse.cz>,
       Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
Message-ID: <20040321002325.GS2045@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	rmk@arm.linux.org.uk, Jaroslav Kysela <perex@suse.cz>,
	Linus Torvalds <torvalds@osdl.org>,
	LKML <linux-kernel@vger.kernel.org>
References: <20040320133025.GH9009@dualathlon.random> <20040320144022.GC2045@holomorphy.com> <20040320150621.GO9009@dualathlon.random> <20040320154419.A6726@flint.arm.linux.org.uk> <Pine.LNX.4.58.0403201651520.1816@pnote.perex-int.cz> <20040320160911.B6726@flint.arm.linux.org.uk> <Pine.LNX.4.58.0403202038530.1816@pnote.perex-int.cz> <20040320222341.J6726@flint.arm.linux.org.uk> <20040320224518.GQ2045@holomorphy.com> <20040320235445.B24744@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040320235445.B24744@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 20, 2004 at 11:54:45PM +0000, Russell King wrote:
> The issues are:
> 1. ALSA wants to mmap the buffer used to transfer data to/from the
>    card into user space.  This buffer may be direct-mapped RAM,
>    memory allocated via dma_alloc_coherent(), an on-device buffer,
>    or anything else.
>    The user space mapping must likewise be DMA-coherent.
>    Currently, ALSA just does virt_to_page() on whatever address it
>    feels like in its nopage() function, which is obviously not
>    acceptable for two out of the three specific cases above.
> 2. ALSA wants to _coherently_ share data between the kernel-side
>    drivers, and user space ALSA library, mainly the DMA buffer
>    head/tail pointers so both kernel space and user space knows
>    when the buffer is full/empty.

Okay, so we've got these pinned down. So I've got two small ideas
(I mentioned them earlier, but maybe vger dropped the message):

(a) I think prefaulting should work for that in general, though the API
doesn't fit the extra things needed for e.g. DMA. Is there some way we
could extend remap_area_pages() (or provide an alternative interface to
similar functionality with the missing pieces included) to do the extra
things needed to make the coherency and/or DMA (or whatever else is
missing) work?

(b) Alternatively, would dma_coherent_to_pfn() instead of
dma_coherent_to_page() and making ->nopage() return pfns help salvage
the method using non-cachable and/or dma-coherent page protections in
vma->vm_page_prot?


-- wli
