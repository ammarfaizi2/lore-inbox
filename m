Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750783AbWHUDQE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbWHUDQE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 23:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbWHUDQD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 23:16:03 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:46216 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750783AbWHUDQC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 23:16:02 -0400
Date: Mon, 21 Aug 2006 13:15:05 +1000
From: David Chinner <dgc@sgi.com>
To: Neil Brown <neilb@suse.de>
Cc: Andi Kleen <ak@suse.de>, Jens Axboe <axboe@suse.de>,
       David Chinner <dgc@sgi.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: RFC - how to balance Dirty+Writeback in the face of slow  writeback.
Message-ID: <20060821031505.GQ51703024@melbourne.sgi.com>
References: <17633.2524.95912.960672@cse.unsw.edu.au> <20060815010611.7dc08fb1.akpm@osdl.org> <20060815230050.GB51703024@melbourne.sgi.com> <17635.60378.733953.956807@cse.unsw.edu.au> <20060816231448.cc71fde7.akpm@osdl.org> <20060818001102.GW51703024@melbourne.sgi.com> <20060817232942.c35b1371.akpm@osdl.org> <20060818070314.GE798@suse.de> <p73hd0998is.fsf@verdi.suse.de> <17640.65491.458305.525471@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17640.65491.458305.525471@cse.unsw.edu.au>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2006 at 10:35:31AM +1000, Neil Brown wrote:
> On  August 18, ak@suse.de wrote:
> > Jens Axboe <axboe@suse.de> writes:
> > 
> > > On Thu, Aug 17 2006, Andrew Morton wrote:
> > > > It seems that the many-writers-to-different-disks workloads don't happen
> > > > very often.  We know this because
> > > > 
> > > > a) The 2.4 performance is utterly awful, and I never saw anybody
> > > >    complain and
> > > 
> > > Talk to some of the people that used DVD-RAM devices (or other
> > > excruciatingly slow writers) on their system, and they would disagree
> > > violently :-)
> > 
> > I hit this recently while doing backups to a slow external USB disk.
> > The system was quite unusable (some commands blocked for over a minute)
> 
> Ouch.  
> I suspect we are going to see more of this, as USB drive for backups
> is probably a very attractive option for many.

I can't see how this would occur on a 2.6 kernel unless the problem is
that all the reclaimable memory in the machine is dirty page cache pages
every allocation is blocking waiting for writeback to the slow device to
occur. That is, we filled memory with dirty pages before we got to the
throttle threshold.

> The 'obvious' solution would be to count dirty pages per backing_dev
> and rate limit writes based on this.
> But counting pages can be expensive.  I wonder if there might be some
> way to throttle the required writes without doing too much counting.

I don't think we want to count pages here.

My "obvious" solution is a per-backing-dev throttle threshold, just
like we have per-backing-dev readahead parameters....

That is, we allow a per-block-dev value to be set that overrides the
global setting for that blockdev only. Hence for slower devices
we can set the point at which we throttle at a much lower dirty
memory threshold when that block device is congested.


> Could we watch when the backing_dev is congested and use that?
> e.g.
>  When Dirty+Writeback is between max_dirty/2 and max_dirty,
>   balance_dirty_pages waits until mapping->backing_dev_info
>     is not congested.

The problem with that approach is that writeback_inodes() operates
on "random" block devices, not necessarily the one we are
trying to write to

We don't care what bdi we start write back on - we just want
some dirty pages to come clean. If we can't write the number of
pages we wanted to, that means all bdi's are congested, and we then
wait for one to become uncongested so we can push more data into it.

Hence waiting on a specific bdi to become uncongested is the wrong
thing to do because we could be cleaning pages on a different,
uncongested bdi instead of waiting.

A per-bdi throttle threshold will have the effect of pushing out
pages on faster block devs earlier than they would otherwise be
pushed out, but that will only occur if we are writing to a
slower block device. Also, only the slower bdi will be subject
to this throttling, so it won't get as much memory dirty as
the faster devices....

> That might slow things down, but it is hard to know if it would slow
> things down the right amount...
> 
> Given that large machines are likely to have lots of different
> backing_devs, maybe counting all the dirty pages per backing_dev
> wouldn't be too expensive?

Consider 1024p machines writing in parallel at >10GB/s write speeds
to a single filesystem (i.e. single bdi).

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group
