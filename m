Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266655AbUFUXJU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266655AbUFUXJU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 19:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266604AbUFUXJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 19:09:20 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:33804 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S266588AbUFUXIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 19:08:48 -0400
Date: Tue, 22 Jun 2004 00:08:38 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Takashi Iwai <tiwai@suse.de>
Cc: Matt Porter <mporter@kernel.crashing.org>,
       Jamey Hicks <jamey.hicks@hp.com>, Ian Molton <spyro@f2s.com>,
       linux-kernel@vger.kernel.org, greg@kroah.com, tony@atomide.com,
       david-b@pacbell.net, joshua@joshuawise.com
Subject: Re: DMA API issues
Message-ID: <20040622000838.B7802@flint.arm.linux.org.uk>
Mail-Followup-To: Takashi Iwai <tiwai@suse.de>,
	Matt Porter <mporter@kernel.crashing.org>,
	Jamey Hicks <jamey.hicks@hp.com>, Ian Molton <spyro@f2s.com>,
	linux-kernel@vger.kernel.org, greg@kroah.com, tony@atomide.com,
	david-b@pacbell.net, joshua@joshuawise.com
References: <20040618175902.778e616a.spyro@f2s.com> <20040618110721.B3851@home.com> <40D3356E.8040800@hp.com> <20040618122112.D3851@home.com> <20040618204322.C17516@flint.arm.linux.org.uk> <s5hoendm3td.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <s5hoendm3td.wl@alsa2.suse.de>; from tiwai@suse.de on Mon, Jun 21, 2004 at 03:35:42PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2004 at 03:35:42PM +0200, Takashi Iwai wrote:
> At Fri, 18 Jun 2004 20:43:22 +0100,
> Russell King wrote:
> > 
> > On Fri, Jun 18, 2004 at 12:21:12PM -0700, Matt Porter wrote:
> > > > page_to_dma so that device specific dma addresses can be constructed.
> > > 
> > > A struct device argument to page_to_dma seems like a no brainer to be
> > > included.
> > 
> > Tony Lindgren recently submitted a patch for this:
> > 
> > http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=1931/1
> > 
> > which now pending for Linus.  ARM platforms now have three macros to
> > define if they want to override the default struct page to DMA address
> > translation.
> 
> Wouldn't it be nicer to define a more generic style like
> 
> struct page *dma_to_page(struct device *, void *, dma_addr_t)

What's the 'void *' for?  Hint: this has nothing to do with the virtual
address and DMA address returned from dma_alloc_coherent().

page_to_dma - converts a struct page to a DMA address for a given device
dma_to_virt - converts a DMA address to a CPU direct-mapped virtual address
virt_to_dma - converts a CPU direct-mapped virtual address to a DMA address

Each one well defined for our _current_ interfaces.

> Yes, the struct page pointer is needed for vma_ops.nopage in mmap on
> ALSA.  So far, this is broken on some architectures like ARM.  We need
> a proper conversion from virtual/bus pointer to a page struct.

Please get away from your nopage implementation.  We've been around this
before with Linus, and the conclusion was that it's up to architectures
to provide a MMAP method for DMA memory, which _may_ use the nopage
method if and only if it is appropriate for their implementation.

There's just no way I'm going to implement a half-baked "nopage" function
for ALSA.

This is actually the same issue for some framebuffer devices as well -
which also need DMA MMAP to be correct.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
