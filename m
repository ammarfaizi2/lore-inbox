Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262265AbUC1RqB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 12:46:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262273AbUC1RqB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 12:46:01 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:13510 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262265AbUC1Rpt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 12:45:49 -0500
Date: Sun, 28 Mar 2004 19:45:44 +0200
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-ide@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] speed up SATA
Message-ID: <20040328174543.GK24370@suse.de>
References: <4066021A.20308@pobox.com> <40661049.1050004@yahoo.com.au> <406611CA.3050804@pobox.com> <20040328140807.GD24370@suse.de> <40670D7B.5070506@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40670D7B.5070506@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 28 2004, Jeff Garzik wrote:
> Jens Axboe wrote:
> >On Sat, Mar 27 2004, Jeff Garzik wrote:
> >
> >>Nick Piggin wrote:
> >>
> >>>I think 32MB is too much. You incur latency and lose
> >>>scheduling grainularity. I bet returns start diminishing
> >>>pretty quickly after 1MB or so.
> >>
> >>See my reply to Bart.
> >>
> >>Also, it is not the driver's responsibility to do anything but export 
> >>the hardware maximums.
> >
> >
> >The problem is that what the 'reasonable size' is depends highly on the
> >hardware. The 32MB doesn't make any sense to me for SATA (or for
> >anything else, for that matter). Back-to-back 1MB requests (this is the
> >default I chose for PATA) should be practially identical for throughput,
> >and loads better for optimizing latencies. You cannot do much with 32MB
> >requests wrt latency...
> >
> >So you could change ->max_sectors to be 'max allowable io, hardware
> >limitation' and add ->optimal_sectors to be 'best sized io'. I don't see
> >tha it buys you anything, since you'd be going for optimal_sectors all
> >the time anyways.
> >
> >Additionally, a single bio cannot currently be bigger than 256 pages
> >(ie 1MB request on 4k page). This _could_ be increased of course, but
> >not beyond making ->bio_io_vec be bigger than a page. It's already
> >bigger than that on x86 in fact, if you use 64-bit dma_addr_t. For
> >32-bit dma_addr_t 256 entries fit a page perfectly. Merging can get you
> >bigger requests of course.
> >
> >In summary, there needs to be some extremely good numbers and arguments
> >for changing any of this, so far I don't see anything except people
> >drooling over sending 32MB requests.
> 
> I think you're way too stuck on the 32MB number.  Other limitations 
> already limit that further.

Of course I am, this is what you are proposing as the 'optimal io size'
for SATA. I already explain that ->max_sectors is more of a 'best io
size' not 'hardware limit' setting. So if you set that to 32MB, then
that is what you are indicating.

> If and when the upper layers pass down such requests, my driver can
> handle that.  For today, various external limitations and factors --
> such as what you describe above -- mean the driver won't be getting
> anywhere near 32MB requests.  And my driver can handle that just fine
> too.

In that light, I don't think your change makes any sense whatsoever. You
have a different understanding of what max_sectors member does, that's
basically the heart of the discussion.

I don't think it would be too hard to send down a 32MB request if you
just bypass the file system, in fact I would have thought you would have
benched this long before proposing such a modification.

-- 
Jens Axboe

