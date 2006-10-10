Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965031AbWJJSXK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965031AbWJJSXK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 14:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965028AbWJJSXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 14:23:09 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:56580 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S965010AbWJJSXE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 14:23:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=K9o66Gc3PocKPJlrU3QROzzE77iVD9MnAKNZhqZIUtJK64/w/HyJNKUnvlHnmZ1Jmsh+1kqTZDIfxY3RWBAQ6VjiuoPw0VPyxsCVqQG2dSZ3vaTfKS4FBe9fLXPjjJPQ3pIJuuDhF0uI2Xx/9Vs8JLCApGAwRXrWIVcQwRvBE/w=
Message-ID: <e9c3a7c20610101123t5e763297i1f0525893f6f11b6@mail.gmail.com>
Date: Tue, 10 Oct 2006 11:23:02 -0700
From: "Dan Williams" <dan.j.williams@intel.com>
To: "Neil Brown" <neilb@suse.de>
Subject: Re: [PATCH 00/19] Hardware Accelerated MD RAID5: Introduction
Cc: linux-raid@vger.kernel.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       christopher.leech@intel.com
In-Reply-To: <17705.31033.706571.150023@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1158015632.4241.31.camel@dwillia2-linux.ch.intel.com>
	 <17705.31033.706571.150023@cse.unsw.edu.au>
X-Google-Sender-Auth: 0acbe48e2703d2bd
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/8/06, Neil Brown <neilb@suse.de> wrote:
>
>
> On Monday September 11, dan.j.williams@intel.com wrote:
> > Neil,
> >
> > The following patches implement hardware accelerated raid5 for the Intel
> > Xscale(r) series of I/O Processors.  The MD changes allow stripe
> > operations to run outside the spin lock in a work queue.  Hardware
> > acceleration is achieved by using a dma-engine-aware work queue routine
> > instead of the default software only routine.
>
> Hi Dan,
>  Sorry for the delay in replying.
>  I've looked through these patches at last (mostly the raid-specific
>  bits) and while there is clearly a lot of good stuff here, it does
>  'feel' right - it just seems too complex.
>
>  The particular issues that stand out to me are:
>    - 33 new STRIPE_OP_* flags.  I'm sure there doesn't need to be that
>       many new flags.
>    - the "raid5 dma client" patch moves far too much internal
>      knowledge about raid5 into drivers/dma.
>
>  Clearly there are some complex issues being dealt with and some
>  complexity is to be expected, but I feel there must be room for some
>  serious simplification.
A valid criticism.  There was definitely a push to just get it
functional, so I can now see how the complexity crept into the
implementation.  The primary cause was the choice to explicitly handle
channel switching in raid5-dma.  However, relieving "client" code from
this responsibility is something I am taking care of in the async api
changes.

>
>  Let me try to describe how I envisage it might work.
>
>  As you know, the theory-of-operation of handle_stripe is that it
>  assesses the state of a stripe deciding what actions to perform and
>  then performs them.  Synchronous actions (e.g. current parity calcs)
>  are performed 'in-line'.  Async actions (reads, writes) and actions
>  that cannot be performed under a spinlock (->b_end_io) are recorded
>  as being needed and then are initiated at the end of handle_stripe
>  outside of the sh->lock.
>
>  The proposal is to bring the parity and other bulk-memory operations
>  out of the spinlock and make them optionally asynchronous.
>
>  The set of tasks that might be needed to be performed on a stripe
>  are:
>         Clear a target cache block
>         pre-xor various cache blocks into a target
>         copy data out of bios into cache blocks. (drain)
>         post-xor various cache blocks into a target
>         copy data into bios out of cache blocks (fill)
>         test if a cache block is all zeros
>         start a read on a cache block
>         start a write on a cache block
>
>  (There is also a memcpy when expanding raid5.  I think I would try to
>   simply avoid that copy and move pointers around instead).
>
>  Some of these steps require sequencing. e.g.
>    clear, pre-xor, copy, post-xor, write
>  for a rwm cycle.
>  We could require handle_stripe to be called again for each step.
>  i.e. first call just clears the target and flags it as clear.  Next
>  call initiates the pre-xor and flags that as done.  Etc.  However I
>  think that would make the non-offloaded case too slow, or at least
>  too clumsy.
>
>  So instead we set flags to say what needs to be done and have a
>  workqueue system that does it.
>
>  (so far this is all quite similar to what you have done.)
>
>  So handle_stripe would set various flag and other things (like
>  identify which block was the 'target' block) and run the following
>  in a workqueue:
>
> raid5_do_stuff(struct stripe_head *sh)
> {
>         raid5_cont_t *conf = sh->raid_conf;
>
>         if (test_bit(CLEAR_TARGET, &sh->ops.pending)) {
>                 struct page = *p->sh->dev[sh->ops.target].page;
>                 rv = async_memset(p, 0, 0, PAGE_SIZE, ops_done, sh);
>                 if (rv != BUSY)
>                         clear_bit(CLEAR_TARGET, &sh->ops.pending);
>                 if (rv != COMPLETE)
>                         goto out;
>         }
>
>         while (test_bit(PRE_XOR, &sh->ops.pending)) {
>                 struct page *plist[XOR_MAX];
>                 int offset[XOR_MAX];
>                 int pos = 0;
>                 int d;
>
>                 for (d = sh->ops.nextdev;
>                      d < conf->raid_disks && pos < XOR_MAX ;
>                      d++) {
>                         if (sh->ops.nextdev == sh->ops.target)
>                                 continue;
>                         if (!test_bit(R5_WantPreXor, &sh->dev[d].flags))
>                                 continue;
>                         plist[pos] = sh->dev[d].page;
>                         offset[pos++] = 0;
>                 }
>                 if (pos) {
>                         struct page *p = sh->dev[sh->ops.target].page;
>                         rv = async_xor(p, 0, plist, offset, pos, PAGE_SIZE,
>                                        ops_done, sh);
>                         if (rv != BUSY)
>                                 sh->ops.nextdev = d;
>                         if (rv != COMPLETE)
>                                 goto out;
>                 } else {
>                         clear_bit(PRE_XOR, &sh->ops.pending);
>                         sh->ops.nextdev = 0;
>                 }
>         }
>
>         while (test_bit(COPY_IN, &sh0>ops.pending)) {
>                 ...
>         }
>         ....
>
>         if (test_bit(START_IO, &sh->ops.pending)) {
>                 int d;
>                 for (d = 0 ; d < conf->raid_disk ; d++) {
>                         /* all that code from the end of handle_stripe */
>                 }
>
>         release_stripe(conf, sh);
>         return;
>
>  out:
>         if (rv == BUSY) {
>                 /* wait on something and try again ???*/
>         }
>         return;
> }
>
> ops_done(struct stripe_head *sh)
> {
>         queue_work(....whatever..);
> }
>
>
> Things to note:
>  - we keep track of where we are up to in sh->ops.
>       .pending is flags saying what is left to be done
>       .next_dev is the next device to process for operations that
>         work on several devices
>       .next_bio, .next_iov will be needed for copy operations that
>         cross multiple bios and iovecs.
>
>  - Each sh->dev has R5_Want flags reflecting which multi-device
>    operations are wanted on each device.
>
>  - async bulk-memory operations take pages, offsets, and lengths,
>    and can return COMPLETE (if the operation was performed
>    synchronously) IN_PROGRESS (if it has been started, or at least
>    queued) or BUSY if it couldn't even be queued.  Exactly what to do
>    in that case I'm not sure.  Probably we need a waitqueue to wait
>    on.
>
>  - The interface between the client and the ADMA hardware is a
>    collection of async_ functions.  async_memcpy, async_xor,
>    async_memset etc.
>
>    I gather there needs to be some understanding
>    about whether the pages are already appropriately mapped for DMA or
>    whether a mapping is needed.  Maybe an extra flag argument should
>    be passed.
>
>    I imagine that any piece of ADMA hardware would register with the
>    'async_*' subsystem, and a call to async_X would be routed as
>    appropriate, or be run in-line.
>
> This approach introduces 8 flags for sh->ops.pending and maybe two or
> three new R5_Want* flags.  It also keeps the raid5 knowledge firmly in
> the raid5 code base.  So it seems to keep the complexity under control
>
> Would this approach make sense to you?
Definitely.

> Is there something really important I have missed?
No, nothing important jumps out.  Just a follow up question/note about
the details.

You imply that the async path and the sync path are unified in this
implementation.  I think it is doable but it will add some complexity
since the sync case is not a distinct subset of the async case.  For
example "Clear a target cache block" is required for the sync case,
but it can go away when using hardware engines.  Engines typically
have their own accumulator buffer to store the temporary result,
whereas software only operates on memory.

What do you think of adding async tests for these situations?
test_bit(XOR, &conf->async)

Where a flag is set if calls to async_<operation> may be routed to
hardware engine?  Otherwise skip any async specific details.

>
> (I'll try and be more responsive next time).
Thanks for shepherding this along.

>
> Thanks,
> NeilBrown

Regards,
Dan
