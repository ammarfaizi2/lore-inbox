Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263954AbSJOPWA>; Tue, 15 Oct 2002 11:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263997AbSJOPV7>; Tue, 15 Oct 2002 11:21:59 -0400
Received: from mg02.austin.ibm.com ([192.35.232.12]:29626 "EHLO
	mg02.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S263954AbSJOPVy>; Tue, 15 Oct 2002 11:21:54 -0400
Content-Type: text/plain; charset=US-ASCII
From: Kevin Corry <corryk@us.ibm.com>
Organization: IBM
To: Jens Axboe <axboe@suse.de>, Joe Thornber <joe@fib011235813.fsnet.co.uk>
Subject: Re: [linux-lvm] Re: [PATCH] 2.5 version of device mapper submission
Date: Tue, 15 Oct 2002 09:52:37 -0500
X-Mailer: KMail [version 1.2]
Cc: linux-lvm@sistina.com, linux-kernel@vger.kernel.org,
       evms-devel@lists.sourceforge.net
References: <1034453946.15067.22.camel@irongate.swansea.linux.org.uk> <20021015102023.GA3929@fib011235813.fsnet.co.uk> <20021015103427.GH5294@suse.de>
In-Reply-To: <20021015103427.GH5294@suse.de>
MIME-Version: 1.0
Message-Id: <02101509523700.05920@boiler>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 October 2002 05:34, Jens Axboe wrote:
> On Tue, Oct 15 2002, Joe Thornber wrote:
> > Flushing mapped io
> > ------------------
> >
> > Whever a mapping driver changes the mapping of a device that is in use
> > it should ensure that any io already mapped with the previous
> > mapping/table has completed.  At the moment I do this by hooking the
> > bi_endio fn and incrementing an pending count (see
> > dm_suspend/dm_resume).  Your new merge_bvec_fn (which I like) means
> > that the request has effectively been partially remapped *before* it
> > gets into the request function.  ie. the request is now mapping
> > specific.  So before I can use merge_bvec_fn we need to move the
> > suspend/resume functionality up into ll_rw_block (eg, move the pending
> > count into the queue ?).  *Every* driver that dynamically changes a
> > mapping needs this functionality, LVM1 ignores it but is so simple it
> > *might* get away with it, dm certainly needs it, and I presume EVMS
> > has similar code in their application.
> >
> > Agree ?
>
> Agreed, we definitely need some sort of suspend (and flush) + resume
> queue hooks.

Also agreed. Not having to worry about device suspends/resumes will probably 
remove a lot of internal complexity in both EVMS and DM. And like Joe 
said, moving this functionality into the block layer seems to be a 
pre-requisite for the merge_bvec_fn() to really work properly and avoid races 
between adding pages to a bio and changing the mapping of the targetted 
device.


> > I believe it _is_ possible to implement this without incurring
> > significant CPU overhead or extra memory usage in the common case that
> > the mapping boundaries do occur on page breaks (This was another
> > reason why I was trying to get the users of bio_add_page using a
> > slightly higher level api that takes the bio submitting out of their
> > hands).
>
> mpage wasn't really considered, it's a simple enough user that it can be
> made to use basically any interface. The main reason is indeed the way
> it is used right now, directly from any submitter of bio's.
>
> I'd be happy to take patches that change how this works. First patch
> could change merge_bvec_fn() to return number of bytes you can accept at
> this location. This can be done without breaking anything else, as long
> as bio_add_page() is changed to read:
>
> 	if (q->merge_bvec_fn) {
> 		ret = q->merge_bvec_fn(q, bio, bvec);
> 		if (ret != bvec->bv_len)
> 			return 1;
> 	}
>
> Second patch can then add a wrapper around bio_add_page() for queueing a
> range of pages for io to a given device. That solves the very problem
> for not having this in the first place - having a single page in more
> than one bio, this will break several bi_end_io() handling functions. If
> you wrap submission and end_io, it could easily be made to work.

Is there any reason why the call to merge_bvec_fn() couldn't be moved to the 
layer above bio_add_page()?  Calling this for every individual page seems to 
be a lot of extra overhead if you are trying to construct a very large 
request. In other words, in this wrapper around bio_add_page(), call 
merge_bvec_fn() with the initial bio (and hence starting sector of the 
request) and the driver could return the max number of bytes/sectors that 
could possibly be handled starting at that sector. Then the wrapper would 
know up-front how many pages could be safely added to the bio before going 
through any of the work to actually add them.

Also, am I correct in assuming that for merge_bvec_fn() to work properly, a 
driver's merge_bvec_fn() must also call the merge_bvec_fn() of the driver 
below it? For example, lets say we have a DM linear device that maps to two 
underlying devices (or in LVM-speak, a linear LV that spans two PVs), both of 
which are MD RAID-1 devices. For a given large request, DM may decide that it 
is fully contained within one of its two target devices, and allow all the 
requested pages to be added to the bio. However, it also needs to ask MD what 
its limits are for that request, or MD would still have to go through the 
trouble to split up the bio after it has been submitted.

> > I will be very happy when the above two changes have been made to the
> > block layer and the request function can become a simple, single
> > remapping.  No splitting or memory allocations will then be
> > neccessary.
>
> Ok fine.

Agreed. With the above block layer changes, most of the bio splitting that 
EVMS does could be removed, and replaced with appropriate merge_bvec_fn()'s. 
About the only exception I currently see to this is something like 
bad-block-relocation, where the driver can dynamically change the mapping at 
runtime, even without the device being suspended. However, since such dynamic 
remappings should be very rare, they should probably just be handled as a
special case within that driver.

-- 
Kevin Corry
corryk@us.ibm.com
http://evms.sourceforge.net/
