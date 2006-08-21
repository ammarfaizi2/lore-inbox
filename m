Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964958AbWHUHYY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964958AbWHUHYY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 03:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965009AbWHUHYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 03:24:24 -0400
Received: from ns.suse.de ([195.135.220.2]:5591 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964958AbWHUHYX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 03:24:23 -0400
From: Neil Brown <neilb@suse.de>
To: David Chinner <dgc@sgi.com>
Date: Mon, 21 Aug 2006 17:24:14 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17641.24478.496091.79901@cse.unsw.edu.au>
Cc: Andi Kleen <ak@suse.de>, Jens Axboe <axboe@suse.de>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: RFC - how to balance Dirty+Writeback in the face of slow  writeback.
In-Reply-To: message from David Chinner on Monday August 21
References: <17633.2524.95912.960672@cse.unsw.edu.au>
	<20060815010611.7dc08fb1.akpm@osdl.org>
	<20060815230050.GB51703024@melbourne.sgi.com>
	<17635.60378.733953.956807@cse.unsw.edu.au>
	<20060816231448.cc71fde7.akpm@osdl.org>
	<20060818001102.GW51703024@melbourne.sgi.com>
	<20060817232942.c35b1371.akpm@osdl.org>
	<20060818070314.GE798@suse.de>
	<p73hd0998is.fsf@verdi.suse.de>
	<17640.65491.458305.525471@cse.unsw.edu.au>
	<20060821031505.GQ51703024@melbourne.sgi.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday August 21, dgc@sgi.com wrote:
> On Mon, Aug 21, 2006 at 10:35:31AM +1000, Neil Brown wrote:
> > On  August 18, ak@suse.de wrote:
> > > Jens Axboe <axboe@suse.de> writes:
> > > 
> > > > On Thu, Aug 17 2006, Andrew Morton wrote:
> > > > > It seems that the many-writers-to-different-disks workloads don't happen
> > > > > very often.  We know this because
> > > > > 
> > > > > a) The 2.4 performance is utterly awful, and I never saw anybody
> > > > >    complain and
> > > > 
> > > > Talk to some of the people that used DVD-RAM devices (or other
> > > > excruciatingly slow writers) on their system, and they would disagree
> > > > violently :-)
> > > 
> > > I hit this recently while doing backups to a slow external USB disk.
> > > The system was quite unusable (some commands blocked for over a minute)
> > 
> > Ouch.  
> > I suspect we are going to see more of this, as USB drive for backups
> > is probably a very attractive option for many.
> 
> I can't see how this would occur on a 2.6 kernel unless the problem is
> that all the reclaimable memory in the machine is dirty page cache pages
> every allocation is blocking waiting for writeback to the slow device to
> occur. That is, we filled memory with dirty pages before we got to the
> throttle threshold.

I started writing a longish reply to this explaining how maybe that
could happen, and then realised I had been missing important aspects
of the code.

writeback_inodes doesn't just work on any random device as both you
and I thought.  The 'writeback_control' structure identifies the bdi
to be flushed and it will only call __writeback_sync_inode on inodes
with the same bdi.

This means that any process writing to a particular bdi should throttle
against the queue limits in the bdi once we pass the dirty threshold.
This means that it shouldn't be able to fill memory with dirty pages
for that device (unless the bdi doesn't have a queue limit like
nfs...).


But now I see another way that Jens' problem could occur... maybe.

Suppose the total Dirty+Writeback exceeds the threshold due entirely
to the slow device, and it is slowly working its way through the
writeback pages.

We write to some other device, make 'ratelimit_pages' pages dirty and
then hit balance_dirty_pages.  We now need to either get the total
dirty pages below the threshold or start writeback on 
   1.5 * ratelimit_pages 
pages.  As we only have 'ratelimit_pages' dirty pages we cannot start
writeback on enough, and so must wait until Dirty+Writeback drops
below the threshold.  And as we are waiting on the slow device, that
could take a while (especially as it is possible that no-one is
calling balance_dirty_pages against that bdi).

I think this was the reason for the interesting extra patch that I
mentioned we have is the SuSE kernel.  The effect of that patch is to
break out of balance_dirty_pages as soon as Dirty hits zero.

This should stop a slow device from blocking other traffic but has
unfortunate side effects when combined with nfs which doesn't limit
its writeback queue.

Jens:  Was it s SuSE kernel or a mainline kernel on which you
   experienced this slowdown with an external USB drive?

> 
> > The 'obvious' solution would be to count dirty pages per backing_dev
> > and rate limit writes based on this.
> > But counting pages can be expensive.  I wonder if there might be some
> > way to throttle the required writes without doing too much counting.
> 
> I don't think we want to count pages here.
> 
> My "obvious" solution is a per-backing-dev throttle threshold, just
> like we have per-backing-dev readahead parameters....
> 
> That is, we allow a per-block-dev value to be set that overrides the
> global setting for that blockdev only. Hence for slower devices
> we can set the point at which we throttle at a much lower dirty
> memory threshold when that block device is congested.
> 

I don't think this would help.  The bdi with the higher threshold
could exclude bdis with lower thresholds from making any forward
progress. 


Here is a question:
  Seeing that
      wbc.nonblocking == 0
      wbc.older_than_this == NULL
      wbc.range_cyclic == 0
  in balance_dirty_pages when it calls writeback_inodes, under what
  circumstances will writeback_inodes return with wbc.nr_to_write > 0
  ??

If a write error occurs it could abort early, but otherwise I think
it will only exit early if it runs out of pages to write, because
there aren't any dirty pages.

If that is true, then after calling writeback_inodes once,
balance_dirty_pages should just exit.  It isn't going to find any more
work to do next time it is called anyway.
Either the queue was never congested, in which case we don't need to
throttle writes, or it blocked for a while waiting for the queue to
clean (in ->writepage) and so has successfully throttled writes.


So my feeling (at the moment) is that balance_dirty_pages should look
like:

 if below threshold 
       return
 writeback_inodes({.bdi = mapping->backing_dev_info)} )

 while (above threshold + 10%)
        writeback_inodes(.bdi = NULL)
        blk_congestion_wait

and all bdis should impose a queue limit.

This would limit the extent to which different bdi can interfere with
each other, and make the role of writeback_inodes clear (especially
with a nice big comment).

Then we just need to deal with the case where the some of the queue
limits of all devices exceeds the dirty threshold....
Maybe writeout queues need to auto-adjust their queue length when some
system-wide situation is detected.... sounds messy.

NeilBrown
