Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932289AbWFDWYN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932289AbWFDWYN (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 18:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbWFDWYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 18:24:13 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:63753 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932289AbWFDWYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 18:24:13 -0400
Date: Sun, 4 Jun 2006 23:23:48 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Tejun Heo <htejun@gmail.com>, Jens Axboe <axboe@suse.de>,
        James Bottomley <James.Bottomley@SteelEye.com>,
        Dave Miller <davem@redhat.com>, bzolnier@gmail.com,
        james.steward@dynamicratings.com, jgarzik@pobox.com,
        mattjreimer@gmail.com, Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
        lkml <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCHSET] block: fix PIO cache coherency bug, take 2
Message-ID: <20060604222347.GG4484@flint.arm.linux.org.uk>
Mail-Followup-To: Tejun Heo <htejun@gmail.com>, Jens Axboe <axboe@suse.de>,
	James Bottomley <James.Bottomley@SteelEye.com>,
	Dave Miller <davem@redhat.com>, bzolnier@gmail.com,
	james.steward@dynamicratings.com, jgarzik@pobox.com,
	mattjreimer@gmail.com,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
	lkml <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org
References: <1149392479501-git-send-email-htejun@gmail.com> <20060604204444.GF4484@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060604204444.GF4484@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 04, 2006 at 09:44:44PM +0100, Russell King wrote:
> On Sun, Jun 04, 2006 at 12:41:19PM +0900, Tejun Heo wrote:
> > Russell, can you please verify arm's flush_kernel_dcache_page()?
> 
> That should be fine from a theoretical standpoint

I'll add to this statement that the cache flushing on ARM is only
ever required when the page ends up in userspace - if we're reading
a page into the page cache to throw it out via NFS or sendfile then
the cache flush is a complete waste of time.

Why is this?  Well, if the data has been written to the kernel mapping
by the CPU, it may be contained in the cache lines corresponding to
that mapping.  When that memory is passed to a network interface to
send, the network interface either reads data from the kernel mapping
via PIO (in which case it reads the data from the cache), or it
performs DMA.  In the case of DMA, the DMA API handles the cache
coherency issues with respect to dirty data in the kernel mapping.

Moreover, there's the problem of read-ahead.  When data is read from
a block device, more data than that which is required is usually read
in case it's required a short time later.  If the data is not required,
it is thrown away during an eviction cycle.  However, any cache flushing
that you've performed for uses "other than kernel space" is then a waste
of resources - the only time that such handling is needed is when the
data is actually used for these other uses - which in the case of ARM
means userspace.

Given the above, I believe that the method being proposed will be
_far_ too expensive, maybe to the point where (eg) disabling read-
ahead _entirely_ on ARM makes the system overall more efficient.

In this respect, I continue to believe that the way ARM (in principle)
does flush_dcache_page() is what is required here - if the page has
not been mapped into userspace, it merely marks the page as containing
dirty cache lines, and the resulting cache maintainence will only
happen when (and if) the page really does get mapped into userspace.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
