Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261794AbUC1OIS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 09:08:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbUC1OIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 09:08:18 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:62349 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261794AbUC1OIO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 09:08:14 -0500
Date: Sun, 28 Mar 2004 16:08:07 +0200
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-ide@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] speed up SATA
Message-ID: <20040328140807.GD24370@suse.de>
References: <4066021A.20308@pobox.com> <40661049.1050004@yahoo.com.au> <406611CA.3050804@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <406611CA.3050804@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 27 2004, Jeff Garzik wrote:
> Nick Piggin wrote:
> >I think 32MB is too much. You incur latency and lose
> >scheduling grainularity. I bet returns start diminishing
> >pretty quickly after 1MB or so.
> 
> See my reply to Bart.
> 
> Also, it is not the driver's responsibility to do anything but export 
> the hardware maximums.

The problem is that what the 'reasonable size' is depends highly on the
hardware. The 32MB doesn't make any sense to me for SATA (or for
anything else, for that matter). Back-to-back 1MB requests (this is the
default I chose for PATA) should be practially identical for throughput,
and loads better for optimizing latencies. You cannot do much with 32MB
requests wrt latency...

So you could change ->max_sectors to be 'max allowable io, hardware
limitation' and add ->optimal_sectors to be 'best sized io'. I don't see
tha it buys you anything, since you'd be going for optimal_sectors all
the time anyways.

Additionally, a single bio cannot currently be bigger than 256 pages
(ie 1MB request on 4k page). This _could_ be increased of course, but
not beyond making ->bio_io_vec be bigger than a page. It's already
bigger than that on x86 in fact, if you use 64-bit dma_addr_t. For
32-bit dma_addr_t 256 entries fit a page perfectly. Merging can get you
bigger requests of course.

In summary, there needs to be some extremely good numbers and arguments
for changing any of this, so far I don't see anything except people
drooling over sending 32MB requests.

> It's up to the sysadmin to choose a disk scheduling policy they like, 
> which implies that a _scheduler_, not each individual driver, should 
> place policy limitations on max_sectors.

Not just scheduler, lower layers in general.

-- 
Jens Axboe

