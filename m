Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261541AbUCVALN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 19:11:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261551AbUCVALN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 19:11:13 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12714 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261541AbUCVALI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 19:11:08 -0500
Message-ID: <405E2F0D.3050001@pobox.com>
Date: Sun, 21 Mar 2004 19:10:53 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Russell King <rmk+lkml@arm.linux.org.uk>,
       David Woodhouse <dwmw2@infradead.org>,
       Christoph Hellwig <hch@infradead.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
References: <20040320121345.2a80e6a0.akpm@osdl.org> <20040320205053.GJ2045@holomorphy.com> <20040320222639.K6726@flint.arm.linux.org.uk> <20040320224500.GP2045@holomorphy.com> <1079901914.17681.317.camel@imladris.demon.co.uk> <20040321204931.A11519@infradead.org> <1079902670.17681.324.camel@imladris.demon.co.uk> <Pine.LNX.4.58.0403211349340.1106@ppc970.osdl.org> <20040321222327.D26708@flint.arm.linux.org.uk> <405E1859.5030906@pobox.com> <20040321225117.F26708@flint.arm.linux.org.uk> <Pine.LNX.4.58.0403211504550.1106@ppc970.osdl.org> <405E23A5.7080903@pobox.com> <Pine.LNX.4.58.0403211542051.1106@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0403211542051.1106@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sun, 21 Mar 2004, Jeff Garzik wrote:
> 
>>That would be nice, though the reason I avoided remap_page_range() in 
>>via82cxxx_audio is that it discourages S/G.  Because remap_page_range() 
>>is easier and more portable, several drivers allocate one-big-area and 
>>then create an S/G list describing individual portions of that area.
> 
> 
> Note that there is really two different kinds of IO memory:
>  - real IO-mapped memory on the other side of a bus
>  - real RAM which is on the CPU side of the bus, but that has additionally 
>    been "mapped" some way as to be visible from devices.

Yes.  via audio example is DMA (second kind), and an fbdev driver would 
need to worry about the first kind (MMIO).

For the second kind, your solution (snipped) seems sane, though I wonder 
where dma_unmap_to_page() is called.

For the first kind, please read fb_mmap in drivers/video/fbmem.c.  Look 
at the _horror_ of ifdefs in exporting the framebuffer.  And that horror 
is what's often needed when letting userspace mmap(2) PCI memory IO regions.

So, an mmio_map() in addition to dma_map*?

	Jeff



