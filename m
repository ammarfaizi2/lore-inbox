Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266553AbUFRTos@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266553AbUFRTos (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 15:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266552AbUFRToU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 15:44:20 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:3603 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S266553AbUFRTnd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 15:43:33 -0400
Date: Fri, 18 Jun 2004 20:43:22 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Matt Porter <mporter@kernel.crashing.org>
Cc: Jamey Hicks <jamey.hicks@hp.com>, Ian Molton <spyro@f2s.com>,
       linux-kernel@vger.kernel.org, greg@kroah.com, tony@atomide.com,
       david-b@pacbell.net, joshua@joshuawise.com
Subject: Re: DMA API issues
Message-ID: <20040618204322.C17516@flint.arm.linux.org.uk>
Mail-Followup-To: Matt Porter <mporter@kernel.crashing.org>,
	Jamey Hicks <jamey.hicks@hp.com>, Ian Molton <spyro@f2s.com>,
	linux-kernel@vger.kernel.org, greg@kroah.com, tony@atomide.com,
	david-b@pacbell.net, joshua@joshuawise.com
References: <20040618175902.778e616a.spyro@f2s.com> <20040618110721.B3851@home.com> <40D3356E.8040800@hp.com> <20040618122112.D3851@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040618122112.D3851@home.com>; from mporter@kernel.crashing.org on Fri, Jun 18, 2004 at 12:21:12PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2004 at 12:21:12PM -0700, Matt Porter wrote:
> > page_to_dma so that device specific dma addresses can be constructed.
> 
> A struct device argument to page_to_dma seems like a no brainer to be
> included.

Tony Lindgren recently submitted a patch for this:

http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=1931/1

which now pending for Linus.  ARM platforms now have three macros to
define if they want to override the default struct page to DMA address
translation.

> I see that's somewhat like what David Brownell suggested before...a single
> pointer to a set of dma ops from struct device.  hppa_dma_ops translated
> into a generic dma_ops entity with fields corresponding to existing
> DMA API calls would be a good starting point. We can get rid of some
> address translation hacks in a lot of custom embedded PPC drivers
> with something like this.

I really don't think we need to go this far.

As I understand it, the issue seems to surround DMA coherent memory
for USB descriptors, and what happens when we call the streaming DMA
API.

We have the latter solved with Deepak's DMA bounce code (already merged)
provided it's given the right information to determine when bounce
buffers are needed.

The bounce code only needs a way to get at the "safe" DMA memory, and
it uses DMA pools for that.  DMA pools in turn take their memory from
dma_alloc_coherent.

So, we just need a way to make dma_alloc_coherent do the right thing.
One suggestion from James yesterday was to have a way to register
device-private "coherent DMA" backing memory with dma_alloc_coherent,
which it would use in preference to calling alloc_pages().  However,
this memory would have no struct page pointer associated with it, and
our dma_alloc_coherent implementation currently relies completely on
that condition existing - so it would mean a complete rewrite of that.

Note also that some drivers (notably ALSA) assume that memory returned
from dma_alloc_coherent() does have struct page pointers, so this would
also break ALSA (which in turn provides much more of a justification
for the DMA MMAP API I was trying (and failed) to propose a few months
back.)

Also, we need to consider what the DMA mask means in this case?  Should
it be zero (to mean "can't DMA from system memory"?)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
