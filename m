Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422796AbWAMSVE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422796AbWAMSVE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 13:21:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422797AbWAMSVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 13:21:04 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:7699 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1422796AbWAMSVB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 13:21:01 -0500
Date: Fri, 13 Jan 2006 18:20:35 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: James Bottomley <James.Bottomley@SteelEye.com>,
       Dave Miller <davem@redhat.com>
Cc: Tejun Heo <htejun@gmail.com>, axboe@suse.de, bzolnier@gmail.com,
       james.steward@dynamicratings.com, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET] block: fix PIO cache coherency bug
Message-ID: <20060113182035.GC25849@flint.arm.linux.org.uk>
Mail-Followup-To: James Bottomley <James.Bottomley@SteelEye.com>,
	Dave Miller <davem@redhat.com>, Tejun Heo <htejun@gmail.com>,
	axboe@suse.de, bzolnier@gmail.com, james.steward@dynamicratings.com,
	jgarzik@pobox.com, linux-kernel@vger.kernel.org
References: <11371658562541-git-send-email-htejun@gmail.com> <1137167419.3365.5.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137167419.3365.5.camel@mulgrave>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2006 at 09:50:19AM -0600, James Bottomley wrote:
> Actually, this doesn't look to be the correct thing to do.  The
> dma_map/unmap don't make the data coherent with respect to the user
> space, only with respect to the kernel space.  I've never liked this
> (and indeed I wrote an OLS paper in 2004 trying to explain how we could
> fix it) but that's our current model.
> 
> Our classic path for data on machines is that the driver makes the
> kernel coherent and then whatever's transferring from the page cache to
> the user makes user space coherent.  It sounds, therefore, like
> whatever's broken (what is the problem, by the way?) is broken in the
> second half (page cache to user) not in the first half (driver to
> kernel).

I think you're misunderstanding the issue.  I'll give you essentially
my understanding of the explaination that Dave Miller gave me a number
of years ago.  This is from memory, so Dave may wish to correct it.

1. When a driver DMAs data into a page cache page, it is written directly
   to RAM and is made visible to the kernel mapping via the DMA API.  As
   a result, there will be no cache lines associated with the kernel
   mapping at the point when the driver hands the page back to the page
   cache.

   However, in the PIO case, there is the possibility that the data read
   from the device into the kernel mapping results in cache lines
   associated with the page.  Moreover, if the cache is write-allocate,
   you _will_ have cache lines.

   Therefore, you have two completely differing system states depending
   on how the driver decided to transfer data from the device to the page
   cache.

   As such, drivers must ensure that PIO data transfers have the same
   system state guarantees as DMA data transfers.

   ISTR davem recommended flush_dcache_page() be used for this.

2. (this is my own)  The cachetlb document specifies quite clearly what
   is required whenever a page cache page is written to - that is
   flush_dcache_page() is called.  The situation when a driver uses PIO
   quote clearly violates the requirements set out in that document.

>From (2), it is quite clear that flush_dcache_page() is the correct
function to use, otherwise we would end up with random set of state
of pages in the page cache.  (1) merely reinforces that it's the
correct place for the decision to be made.  In fact, it's the only
part of the kernel which _knows_ what needs to be done.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
