Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261729AbVAMVmv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261729AbVAMVmv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 16:42:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261725AbVAMV1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 16:27:54 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:14054 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261714AbVAMV0Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 16:26:25 -0500
From: Kevin Corry <kevcorry@us.ibm.com>
To: evms-devel@lists.sourceforge.net
Subject: Re: [Evms-devel] dm snapshot problem
Date: Thu, 13 Jan 2005 15:26:59 -0600
User-Agent: KMail/1.7.1
Cc: Andrew Morton <akpm@osdl.org>, rajesh_ghanekar@persistent.co.in,
       dm-devel@redhat.com, linux-kernel@vger.kernel.org
References: <41E35950.9040201@persistent.co.in> <200501121036.35928.kevcorry@us.ibm.com> <20050112225133.4848aea4.akpm@osdl.org>
In-Reply-To: <20050112225133.4848aea4.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501131526.59220.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 13 January 2005 12:51 am, Andrew Morton wrote:
> Kevin Corry <kevcorry@us.ibm.com> wrote:
> > After talking with a friend with a bit more understanding of the workings
> > of the new I/O scheduler, it seems that the way this process is
> > *intended* to work is for pdflush to block once a request-queue for a
> > device fills up to a certain point. Until I/Os have been processed from
> > the full request-queue, pdflush won't be allowed to submit any new
> > requests, and everybody gets to make some forward progress.
>
> Not really.  The VFS/VM takes quite some care to _avoid_ blocking pdflush
> on any particular disk.  Because there will always be more disks than there
> are pdflush instances, and we want to keep all the disks busy.
>
> So what pdflush will do is to essentially operate in a polling mode.
> pdflush will circulate over all the FS-level superblocks looking for ones
> whose backing queues are not write-congested (bdi_write_congested() returns
> false).  Any such superblocks will have more writes directed to them.
> After passing over all such superblocks, pdflush will go to sleep and will
> be woken by write completion activity from any queue and will then take
> another pass across the superblocks.

Thanks for the explaination, Andrew. Perhaps I simply misunderstood the info I 
got about pdflush and "blocking". Obviously if there are only a few pdflush 
daemons, we don't want to have one waiting indefinitely on a single device.

> > The problem is that DM doesn't use a proper request-queue in the way
> > that, say, the IDE or SCSI drivers use them. DM's goal is merely to remap
> > a given bio and send it down the stack. It doesn't generally want to
> > collect multiple bios onto a queue to process them later. But we do get
> > into situations like snapshotting where internal queueing becomes
> > necessary. So, since DM doesn't have a proper request-queue, it can't
> > force pdflush into this throttling mode. So pdflush just continually
> > submits I/Os to the snapshot-origin, all while DM is attempting to copy
> > data chunks from the origin to the snapshot and update the snapshot
> > metadata. This is why we are seeing the dm_io and dm_tio usage go into
> > the millions, since every bio submitted to DM has one of each of these.
>
> Some throttling is needed, yes.  The ideal way to do that would be to
> arrange for a top-level bdi_write_congested() to return true.  Mechanisms
> are present to pass this call down through the I/O stack.

Yes, and DM already has some handling for the bdi_write_congested() code. The 
problem I see now is that only the DM core knows about this congestion info. 
When it gets called on its congested_fn routine, the DM core simply looks at 
each consumed lower-level device and calls bdi_congested() for that device 
and combines the return codes. But I believe a lot of the congestion is being 
caused by the private queues within the snapshot module, which the DM core 
knows nothing about. So it seems like we'll need to add a new call into the 
DM sub-modules to allow them to return TRUE if they are experiencing any 
internal congestion, and combine that info with the return codes from the 
lower-level devices.

Or perhaps a slightly simpler idea would be to just add an atomic counter to 
the DM-device private-data to keep a count of the number of dm_io structures 
currently allocated for that device, and return TRUE on the congested_fn call 
when it gets above some value. This is simpler from a code standpoint, since 
it means the DM core can still handle all the congestion stuff without 
involving the sub-modules. But on the other hand, for simple dm-linear 
devices that are effectively just a pass-through-with-offset, it seems kinda 
silly to impose such an arbitrary limit when the lower-level device's 
congested_fn routine would adequately handle notifying pdflush when it's 
congested.

> That will help a lot.  But there are probably still ways to trip it up:
> say, a tremendous direct-io write() of highmem pages, which will bypass all
> the above pagecache stuff.
>
> However the direct-io code itself has explicit throttling of the number of
> requests which it will put into flight, so an exploit would probably have
> to use a lot of processes operating concurrently.

If so, wouldn't that be equally true for any device, and not just DM devices?

> > So eventually we get into a state where nearly all LowMem is used up,
> > because all of these data structures are being allocated from kernel
> > memory (hence you see very little HighMem usage).
>
> It would be better if dm could use highmem pages for this operation.

What's the appropriate mechanism for telling the kernel to use highmem for 
these structures? Each of these slabs (dm_io and dm_tio) are created with 
kmem_cache_create(), and I don't see any corresponding flags in slab.h that 
mention anything about highmem. Items are allocated from this slab through 
mempool_alloc() with GFP_NOIO, since we're in the middle of processing I/O 
requests and don't want to start new I/O in order to get memory. Would it be 
proper to call mempool_alloc(pool, GFP_NOIO|__GFP_HIGHMEM)?

> > So, if my understanding of pdflush is correct (someone please correct me
> > if my explaination above is wrong), we need to be doing some sort of
> > throttling in the snapshot code when we reach a certain number of
> > internally queued bios. Such a throttling mechanism would not be
> > difficult to add. Just add a per-snapshot counter for the total number of
> > bios that are currently waiting for chunks to be copied. If this number
> > goes over some limit, simply block the thread until the number goes back
> > below the limit.
>
> Yes, I suspect that something like this will be needed.  It probably needs
> to be a global limit, seeing that the resource which is being managed (ie:
> memory) is a global thing.
>
> A very easy way of doing that, which for some reason surely will turn out
> to be insufficient :( is to just use a semaphore.  Initialise the semaphore
> to (say) 1000 and do a down() when a bio is allocated and do an up() when a
> bio is freed.  voila: a max of 1000 bios in flight.  Adjust the initial
> value of the semaphore according to the amount of lowmem in the machine.
>
> Calculate the amount of lowmem via
>
>  si_meminfo(&x);
>  return x.totalram - x.totalhigh;

I would hope that if we get DM's congested_fn routine working correctly (as 
discussed above), then the semaphore idea ought to be unnecessary. Agreed? Do 
you think the "congestion" limit should still be based on the amount of 
lowmem? Some percentage of lowmem? And if so, what would be a reasonable 
value?

Thanks for the tips!

-- 
Kevin Corry
kevcorry@us.ibm.com
http://evms.sourceforge.net/
