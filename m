Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261176AbVAMGwb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbVAMGwb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 01:52:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261177AbVAMGwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 01:52:31 -0500
Received: from fw.osdl.org ([65.172.181.6]:61097 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261176AbVAMGwY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 01:52:24 -0500
Date: Wed, 12 Jan 2005 22:51:33 -0800
From: Andrew Morton <akpm@osdl.org>
To: Kevin Corry <kevcorry@us.ibm.com>
Cc: evms-devel@lists.sourceforge.net, rajesh_ghanekar@persistent.co.in,
       dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [Evms-devel] dm snapshot problem
Message-Id: <20050112225133.4848aea4.akpm@osdl.org>
In-Reply-To: <200501121036.35928.kevcorry@us.ibm.com>
References: <41E35950.9040201@persistent.co.in>
	<200501110834.42839.kevcorry@us.ibm.com>
	<41E5116E.7000709@persistent.co.in>
	<200501121036.35928.kevcorry@us.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin Corry <kevcorry@us.ibm.com> wrote:
>
> ...
> 
> A little more background on snapshotting first. When a I/O write request
> is submitted to a snapshot-origin device, and that "chunk" of data on the
> origin has not yet been copied to the snapshot, DM puts the submitted bio
> on an internal queue associated with that chunk. DM then starts to copy
> that chunk from the origin to the snapshot, and when the copy completes,
> it must write out a new mapping table to the snapshot device. When all of
> this is finished, the original bio (and any other bios that might have also
> come in and are waiting for that chunk) can be taken off the queue and
> finally submitted to the origin device.
> 
> Writes to the snapshot device work very similarly.
> 
> The underlying reason for the increased usage in the dm_io and dm_tio
> seems to be related to improvements in the page-cache and I/O-schedulers
> in the 2.6 kernel.

Quite possibly.  Especial problems are caused by the CFQ I/O scheduler,
which allows tremendous numbers of requests to be in flight.  Not that this
is a bad thing per-se (we need to be able to cope with that), but it can
trigger problems more easily than the other I/O schedulers.

> When you start dd, it reads in as much data as it can from the source
> device into the page-cache. At some point, the page-cache starts getting
> full, and pdflush decides to start writing those pages to the snapshot-
> origin device. Each submitted bio goes through the process described above.
> However, as soon as DM puts each bio on its internal per-chunk-queues, DM
> can then return back to pdflush, which continues to drive requests to the
> snapshot-origin device.

Yup.

> After talking with a friend with a bit more understanding of the workings
> of the new I/O scheduler, it seems that the way this process is *intended*
> to work is for pdflush to block once a request-queue for a device fills
> up to a certain point. Until I/Os have been processed from the full
> request-queue, pdflush won't be allowed to submit any new requests, and
> everybody gets to make some forward progress.

Not really.  The VFS/VM takes quite some care to _avoid_ blocking pdflush
on any particular disk.  Because there will always be more disks than there
are pdflush instances, and we want to keep all the disks busy.

So what pdflush will do is to essentially operate in a polling mode. 
pdflush will circulate over all the FS-level superblocks looking for ones
whose backing queues are not write-congested (bdi_write_congested() returns
false).  Any such superblocks will have more writes directed to them. 
After passing over all such superblocks, pdflush will go to sleep and will
be woken by write completion activity from any queue and will then take
another pass across the superblocks.

Under heavy writeout, userspace tasks will also participate in this
activity.  They do basically the same as the above, only we prevent the
userspace tasks from leaving the kernel while there is too much dirty
memory around.  This throttles those tasks which are dirtying memory too
fast.  Care is taken to be "fair", so that one dirtying task doesn't cause
a different dirtying task to get stuck in the kernel for ever.

> The problem is that DM doesn't use a proper request-queue in the way that,
> say, the IDE or SCSI drivers use them. DM's goal is merely to remap a
> given bio and send it down the stack. It doesn't generally want to collect
> multiple bios onto a queue to process them later. But we do get into
> situations like snapshotting where internal queueing becomes necessary. So,
> since DM doesn't have a proper request-queue, it can't force pdflush into
> this throttling mode. So pdflush just continually submits I/Os to the
> snapshot-origin, all while DM is attempting to copy data chunks from the
> origin to the snapshot and update the snapshot metadata. This is why we are
> seeing the dm_io and dm_tio usage go into the millions, since every bio
> submitted to DM has one of each of these.

Some throttling is needed, yes.  The ideal way to do that would be to
arrange for a top-level bdi_write_congested() to return true.  Mechanisms
are present to pass this call down through the I/O stack.

That will help a lot.  But there are probably still ways to trip it up:
say, a tremendous direct-io write() of highmem pages, which will bypass all
the above pagecache stuff.

However the direct-io code itself has explicit throttling of the number of
requests which it will put into flight, so an exploit would probably have
to use a lot of processes operating concurrently.

> So eventually we get into a state where nearly all LowMem is used up,
> because all of these data structures are being allocated from kernel
> memory (hence you see very little HighMem usage).

It would be better if dm could use highmem pages for this operation.

> ...
> 
> So, if my understanding of pdflush is correct (someone please correct me
> if my explaination above is wrong), we need to be doing some sort of
> throttling in the snapshot code when we reach a certain number of
> internally queued bios. Such a throttling mechanism would not be difficult
> to add. Just add a per-snapshot counter for the total number of bios that
> are currently waiting for chunks to be copied. If this number goes over
> some limit, simply block the thread until the number goes back below the
> limit.

Yes, I suspect that something like this will be needed.  It probably needs
to be a global limit, seeing that the resource which is being managed (ie:
memory) is a global thing.

A very easy way of doing that, which for some reason surely will turn out
to be insufficient :( is to just use a semaphore.  Initialise the semaphore
to (say) 1000 and do a down() when a bio is allocated and do an up() when a
bio is freed.  voila: a max of 1000 bios in flight.  Adjust the initial
value of the semaphore according to the amount of lowmem in the machine.

Calculate the amount of lowmem via

	si_meminfo(&x);
	return x.totalram - x.totalhigh;


