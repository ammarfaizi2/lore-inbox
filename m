Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751160AbWFEOpY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbWFEOpY (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 10:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbWFEOpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 10:45:23 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:1551 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751160AbWFEOpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 10:45:21 -0400
Date: Mon, 5 Jun 2006 15:44:56 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Tejun Heo <htejun@gmail.com>, Jens Axboe <axboe@suse.de>,
        Dave Miller <davem@redhat.com>, bzolnier@gmail.com,
        james.steward@dynamicratings.com, jgarzik@pobox.com,
        mattjreimer@gmail.com, Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
        lkml <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCHSET] block: fix PIO cache coherency bug, take 2
Message-ID: <20060605144456.GA26666@flint.arm.linux.org.uk>
Mail-Followup-To: James Bottomley <James.Bottomley@SteelEye.com>,
	Tejun Heo <htejun@gmail.com>, Jens Axboe <axboe@suse.de>,
	Dave Miller <davem@redhat.com>, bzolnier@gmail.com,
	james.steward@dynamicratings.com, jgarzik@pobox.com,
	mattjreimer@gmail.com,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
	lkml <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org
References: <1149392479501-git-send-email-htejun@gmail.com> <20060604204444.GF4484@flint.arm.linux.org.uk> <20060604222347.GG4484@flint.arm.linux.org.uk> <1149517656.3489.15.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149517656.3489.15.camel@mulgrave.il.steeleye.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2006 at 09:27:36AM -0500, James Bottomley wrote:
> On Sun, 2006-06-04 at 23:23 +0100, Russell King wrote:
> > I'll add to this statement that the cache flushing on ARM is only
> > ever required when the page ends up in userspace - if we're reading
> > a page into the page cache to throw it out via NFS or sendfile then
> > the cache flush is a complete waste of time.
> 
> Right .. and this is the scenario.  There are two cases where devices
> kmap a user page into kernel space and then proceed to read from or
> write to it (flush_dcache_page() is specifically for the latter because
> the user won't see the data the kernel just wrote unless this happens
> because kernel and user addresses aren't congruent on parisc).
> 
> The first case is manufactured data (such as command emulation) and the
> second is pio data rather than DMA (such as command re-completion or
> IDE).

When a user program wants to obtain data from a block device, there are
two ways it goes about it:

1. via read().  Read copies the data out of the kernel mapping of the
   page cache, so there's no coherency issues as far as PIO is concerned.

2. via a page which has been mmap()'d.  In this case, we are performing a
   "PIO read from device write" operation to page to fill the page cache
   with data, which must complete _before_ we hand the page to userspace.

In neither case will the page be available to the user before the PIO
operation has been completed - if it was, there would be one very big
security hole since the previous data would be visible.

Hence I find your comment "There are two cases where devices kmap a
user page into kernel space and then proceed to read from or write to
it" to be misleading - at the exact point in time that the device
driver is manipulating the data in that page, it is not a user page.

> > In this respect, I continue to believe that the way ARM (in principle)
> > does flush_dcache_page() is what is required here - if the page has
> > not been mapped into userspace, it merely marks the page as containing
> > dirty cache lines, and the resulting cache maintainence will only
> > happen when (and if) the page really does get mapped into userspace.
> 
> For this particular scenario, the page is almost always mapped initially
> in user space because the user is requesting the I/O to a given
> userspace address ...

Here we fundamentally disagree - and I'm afraid that it seems that you
didn't actually read what I wrote since there's an obvious disparity
between me saying "if the page has not been mapped into userspace" and
you saying "the page is almost always mapped initially in user space" -
we're _definitely_ talking about different things here.

How can we proceed with this if this kind of misintepretation is rampant?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
