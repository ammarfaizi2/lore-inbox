Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261794AbVAMWhD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261794AbVAMWhD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 17:37:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261806AbVAMWdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 17:33:42 -0500
Received: from fw.osdl.org ([65.172.181.6]:45249 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261794AbVAMWaW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 17:30:22 -0500
Date: Thu, 13 Jan 2005 14:34:43 -0800
From: Andrew Morton <akpm@osdl.org>
To: Kevin Corry <kevcorry@us.ibm.com>
Cc: evms-devel@lists.sourceforge.net, rajesh_ghanekar@persistent.co.in,
       dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [Evms-devel] dm snapshot problem
Message-Id: <20050113143443.56bd4977.akpm@osdl.org>
In-Reply-To: <200501131526.59220.kevcorry@us.ibm.com>
References: <41E35950.9040201@persistent.co.in>
	<200501121036.35928.kevcorry@us.ibm.com>
	<20050112225133.4848aea4.akpm@osdl.org>
	<200501131526.59220.kevcorry@us.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin Corry <kevcorry@us.ibm.com> wrote:
>
> > Some throttling is needed, yes.  The ideal way to do that would be to
> > arrange for a top-level bdi_write_congested() to return true.  Mechanisms
> > are present to pass this call down through the I/O stack.
> 
> Yes, and DM already has some handling for the bdi_write_congested() code. The 
> problem I see now is that only the DM core knows about this congestion info. 
> When it gets called on its congested_fn routine, the DM core simply looks at 
> each consumed lower-level device and calls bdi_congested() for that device 
> and combines the return codes. But I believe a lot of the congestion is being 
> caused by the private queues within the snapshot module, which the DM core 
> knows nothing about. So it seems like we'll need to add a new call into the 
> DM sub-modules to allow them to return TRUE if they are experiencing any 
> internal congestion, and combine that info with the return codes from the 
> lower-level devices.

Yes, that's the design intent.  Pass the call down the stack and across the
devices.

> ...
> >
> > However the direct-io code itself has explicit throttling of the number of
> > requests which it will put into flight, so an exploit would probably have
> > to use a lot of processes operating concurrently.
> 
> If so, wouldn't that be equally true for any device, and not just DM devices?

It could be true if the top-level I/O scheduler is tuned to support a large
number of in-flight requests (eg: CFQ).  For example, all the user memory
which direct-io places into request queues is pinned for the duration of
the I/O, so it might be possible to temporarily cause a memory squeeze with
enough processes doing the I/O.

> > > So eventually we get into a state where nearly all LowMem is used up,
> > > because all of these data structures are being allocated from kernel
> > > memory (hence you see very little HighMem usage).
> >
> > It would be better if dm could use highmem pages for this operation.
> 
> What's the appropriate mechanism for telling the kernel to use highmem for 
> these structures? Each of these slabs (dm_io and dm_tio) are created with 
> kmem_cache_create(), and I don't see any corresponding flags in slab.h that 
> mention anything about highmem. Items are allocated from this slab through 
> mempool_alloc() with GFP_NOIO, since we're in the middle of processing I/O 
> requests and don't want to start new I/O in order to get memory. Would it be 
> proper to call mempool_alloc(pool, GFP_NOIO|__GFP_HIGHMEM)?

Oh.  slab structures can only be in lowmem.  I thought that you were saying
that the actual I/O data was being copied, and only into lowmem pages.

> ...
> 
> I would hope that if we get DM's congested_fn routine working correctly (as 
> discussed above), then the semaphore idea ought to be unnecessary. Agreed?

It's definitely the first step to be taken.

> Do 
> you think the "congestion" limit should still be based on the amount of 
> lowmem? Some percentage of lowmem? And if so, what would be a reasonable 
> value?

You'd need to do some arithmetic.  If a machine has 32G of highmem and 0.5G
of lowmem and if DM is allocating some lowmem memory on behalf of that
highmem memory then yes, it's possible that all of lowmem will be consumed
to support that highmem.  In which case additional throttling/clamping will
be needed somewhere.

But note that on such a huge highmem box the VM/VFS will no longer permit
40% of memory to be dirtied - the dirty_ratio is reduced on such machines,
in page_writeback_init().  So that lessens the likelihood of
lowmem-exhaustion-due-to-highmem-writeout.
