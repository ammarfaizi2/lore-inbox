Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932186AbWJIAb2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbWJIAb2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 20:31:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932188AbWJIAb1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 20:31:27 -0400
Received: from ns.suse.de ([195.135.220.2]:48822 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932185AbWJIAb0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 20:31:26 -0400
From: Neil Brown <neilb@suse.de>
To: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 9 Oct 2006 08:18:33 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-ID: <17705.31033.706571.150023@cse.unsw.edu.au>
Cc: linux-raid@vger.kernel.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       christopher.leech@intel.com
Subject: Re: [PATCH 00/19] Hardware Accelerated MD RAID5: Introduction
In-Reply-To: message from Dan Williams on Monday September 11
References: <1158015632.4241.31.camel@dwillia2-linux.ch.intel.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Monday September 11, dan.j.williams@intel.com wrote:
> Neil,
> 
> The following patches implement hardware accelerated raid5 for the Intel
> Xscale® series of I/O Processors.  The MD changes allow stripe
> operations to run outside the spin lock in a work queue.  Hardware
> acceleration is achieved by using a dma-engine-aware work queue routine
> instead of the default software only routine.

Hi Dan,
 Sorry for the delay in replying.
 I've looked through these patches at last (mostly the raid-specific
 bits) and while there is clearly a lot of good stuff here, it does
 'feel' right - it just seems too complex.

 The particular issues that stand out to me are:
   - 33 new STRIPE_OP_* flags.  I'm sure there doesn't need to be that
      many new flags.
   - the "raid5 dma client" patch moves far too much internal
     knowledge about raid5 into drivers/dma.

 Clearly there are some complex issues being dealt with and some
 complexity is to be expected, but I feel there must be room for some
 serious simplification.

 Let me try to describe how I envisage it might work.

 As you know, the theory-of-operation of handle_stripe is that it
 assesses the state of a stripe deciding what actions to perform and
 then performs them.  Synchronous actions (e.g. current parity calcs)
 are performed 'in-line'.  Async actions (reads, writes) and actions
 that cannot be performed under a spinlock (->b_end_io) are recorded
 as being needed and then are initiated at the end of handle_stripe
 outside of the sh->lock.

 The proposal is to bring the parity and other bulk-memory operations
 out of the spinlock and make them optionally asynchronous.

 The set of tasks that might be needed to be performed on a stripe
 are:
	Clear a target cache block
	pre-xor various cache blocks into a target
	copy data out of bios into cache blocks. (drain)
	post-xor various cache blocks into a target
	copy data into bios out of cache blocks (fill)
	test if a cache block is all zeros
	start a read on a cache block
	start a write on a cache block

 (There is also a memcpy when expanding raid5.  I think I would try to
  simply avoid that copy and move pointers around instead).

 Some of these steps require sequencing. e.g.
   clear, pre-xor, copy, post-xor, write
 for a rwm cycle.
 We could require handle_stripe to be called again for each step.
 i.e. first call just clears the target and flags it as clear.  Next
 call initiates the pre-xor and flags that as done.  Etc.  However I
 think that would make the non-offloaded case too slow, or at least
 too clumsy.

 So instead we set flags to say what needs to be done and have a
 workqueue system that does it.

 (so far this is all quite similar to what you have done.)

 So handle_stripe would set various flag and other things (like
 identify which block was the 'target' block) and run the following
 in a workqueue:

raid5_do_stuff(struct stripe_head *sh)
{
	raid5_cont_t *conf = sh->raid_conf;

	if (test_bit(CLEAR_TARGET, &sh->ops.pending)) {
		struct page = *p->sh->dev[sh->ops.target].page;
		rv = async_memset(p, 0, 0, PAGE_SIZE, ops_done, sh);
		if (rv != BUSY)
			clear_bit(CLEAR_TARGET, &sh->ops.pending);
		if (rv != COMPLETE)
			goto out;
	}

	while (test_bit(PRE_XOR, &sh->ops.pending)) {
		struct page *plist[XOR_MAX];
		int offset[XOR_MAX];
		int pos = 0;
		int d;

		for (d = sh->ops.nextdev;
		     d < conf->raid_disks && pos < XOR_MAX ;
		     d++) {
			if (sh->ops.nextdev == sh->ops.target)
				continue;
			if (!test_bit(R5_WantPreXor, &sh->dev[d].flags))
				continue;
			plist[pos] = sh->dev[d].page;
			offset[pos++] = 0;
		}
		if (pos) {
			struct page *p = sh->dev[sh->ops.target].page;
			rv = async_xor(p, 0, plist, offset, pos, PAGE_SIZE,
				       ops_done, sh);
			if (rv != BUSY)
				sh->ops.nextdev = d;
			if (rv != COMPLETE)
				goto out;
		} else {
			clear_bit(PRE_XOR, &sh->ops.pending);
			sh->ops.nextdev = 0;
		}
	}
		
	while (test_bit(COPY_IN, &sh0>ops.pending)) {
		...
	}
	....

	if (test_bit(START_IO, &sh->ops.pending)) {
		int d;
		for (d = 0 ; d < conf->raid_disk ; d++) {
			/* all that code from the end of handle_stripe */
		}

	release_stripe(conf, sh);
	return;

 out:
	if (rv == BUSY) {
		/* wait on something and try again ???*/
	}
	return;
}

ops_done(struct stripe_head *sh)
{
	queue_work(....whatever..);
}


Things to note:
 - we keep track of where we are up to in sh->ops.
      .pending is flags saying what is left to be done
      .next_dev is the next device to process for operations that
        work on several devices
      .next_bio, .next_iov will be needed for copy operations that
        cross multiple bios and iovecs.

 - Each sh->dev has R5_Want flags reflecting which multi-device
   operations are wanted on each device.

 - async bulk-memory operations take pages, offsets, and lengths,
   and can return COMPLETE (if the operation was performed
   synchronously) IN_PROGRESS (if it has been started, or at least
   queued) or BUSY if it couldn't even be queued.  Exactly what to do
   in that case I'm not sure.  Probably we need a waitqueue to wait
   on.

 - The interface between the client and the ADMA hardware is a
   collection of async_ functions.  async_memcpy, async_xor,
   async_memset etc.

   I gather there needs to be some understanding
   about whether the pages are already appropriately mapped for DMA or
   whether a mapping is needed.  Maybe an extra flag argument should
   be passed.

   I imagine that any piece of ADMA hardware would register with the
   'async_*' subsystem, and a call to async_X would be routed as
   appropriate, or be run in-line.

This approach introduces 8 flags for sh->ops.pending and maybe two or
three new R5_Want* flags.  It also keeps the raid5 knowledge firmly in
the raid5 code base.  So it seems to keep the complexity under control

Would this approach make sense to you?  Is there something really
important I have missed?

(I'll try and be more responsive next time).

Thanks,
NeilBrown
