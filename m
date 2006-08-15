Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750799AbWHOXBs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbWHOXBs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 19:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbWHOXBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 19:01:48 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:50591 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750799AbWHOXBs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 19:01:48 -0400
Date: Wed, 16 Aug 2006 09:00:50 +1000
From: David Chinner <dgc@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Neil Brown <neilb@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: RFC - how to balance Dirty+Writeback in the face of slow writeback.
Message-ID: <20060815230050.GB51703024@melbourne.sgi.com>
References: <17633.2524.95912.960672@cse.unsw.edu.au> <20060815010611.7dc08fb1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060815010611.7dc08fb1.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2006 at 01:06:11AM -0700, Andrew Morton wrote:
> On Tue, 15 Aug 2006 09:40:12 +1000
> Neil Brown <neilb@suse.de> wrote:
> > When Dirty hits 0 (and Writeback is theoretically 80% of RAM)
> > balance_dirty_pages will no longer be able to flush the full
> > 'write_chunk' (1.5 times number of recent dirtied pages) and so will
> > spin in a loop calling blk_congestion_wait(WRITE, HZ/10), so it isn't
> > a busy loop, but it won't progress.
> 
> This assumes that the queues are unbounded.  They're not - they're limited
> to 128 requests, which is 60MB or so.
> 
> Per queue.  The scenario you identify can happen if it's spread across
> multiple disks simultaneously.

Though in this situation, you don't usually have slow writeback problems.
I haven't seen any recent problems with insufficient throttling on this
sort of configuration.

> CFQ used to have 1024 requests and we did have problems with excessive
> numbers of writeback pages.  I fixed that in 2.6.early, but that seems to
> have got lost as well.

CFQ still has a queue depth of 128 requests....

> > bdflush should get some writeback underway before we hit the 40%, so
> > balance_dirty_pages shouldn't find itself waiting for the pages it
> > just flushed.

balance_dirty_pages() already kicks the background writeback done
by pdflush when dirty > dirty_background_ratio (10%).

IMO, if you've got slow writeback, you should be reducing the amount
of dirty memory you allow in the machine so that you don't tie up
large amounts of memory that takes a long time to clean. Throttle earlier
and you avoid this problem entirely.

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group
