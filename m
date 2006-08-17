Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932450AbWHQIe1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932450AbWHQIe1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 04:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932446AbWHQIe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 04:34:27 -0400
Received: from brick.kernel.dk ([62.242.22.158]:21315 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S932450AbWHQIe0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 04:34:26 -0400
Date: Thu, 17 Aug 2006 10:36:19 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Neil Brown <neilb@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: RFC - how to balance Dirty+Writeback in the face of slow  writeback.
Message-ID: <20060817083619.GB4049@suse.de>
References: <17633.2524.95912.960672@cse.unsw.edu.au> <20060815010611.7dc08fb1.akpm@osdl.org> <17635.59821.21444.287979@cse.unsw.edu.au> <20060816232253.169e8957.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060816232253.169e8957.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16 2006, Andrew Morton wrote:
> On Thu, 17 Aug 2006 13:59:41 +1000
> Neil Brown <neilb@suse.de> wrote:
> 
> > > CFQ used to have 1024 requests and we did have problems with excessive
> > > numbers of writeback pages.  I fixed that in 2.6.early, but that seems to
> > > have got lost as well.
> > > 
> > 
> > What would you say constitutes "excessive"?  Is there any sense in
> > which some absolute number is excessive (as it takes too long to scan
> > some list) or is it just a percent-of-memory thing?
> 
> Excessive = 100% of memory dirty or under writeback against a single disk
> on a 512MB machine.  Perhaps that problem just got forgotten about when CFQ
> went from 1024 requests down to 128.  (That 128 was actually
> 64-available-for-read+64-available-for-write, so it's really 64 requests).

That's not quite true, if you set nr_requests to 128 that's 128 for
reads and 128 for writes. With the batching you will actually typically
see 128 * 3 / 2 == 192 requests allocated. Which translates to about
96MiB of dirty data on the queue, if everything works smoothly. The 3/2
limit is quite new, before I introduced that, if you had a lot of writes
each of them would be allowed 16 requests over the limit. So you would
sometimes see huge queues, as with just eg 16 writes, you could have 128
+ 16*16 requests allocated.

I've always been of the opinion that the vm should handle all of this,
and things should not change or break if I set 10000 as the request
limit. A rate-of-dirtying throttling per process sounds like a really
good idea, we badly need to prevent the occasional write (like a process
doing sync reads, and getting stuck in slooow reclaim) from being
throttled in the presence of a heavy dirtier.

-- 
Jens Axboe

