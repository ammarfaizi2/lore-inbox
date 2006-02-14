Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030283AbWBND3t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030283AbWBND3t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 22:29:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750976AbWBND3s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 22:29:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:57244 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750962AbWBND3r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 22:29:47 -0500
From: Neil Brown <neilb@suse.de>
To: Dan Williams <dan.j.williams@gmail.com>
Date: Tue, 14 Feb 2006 14:29:31 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17393.20123.482714.560397@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       Chris Leech <christopher.leech@intel.com>,
       "Grover, Andrew" <andrew.grover@intel.com>,
       Deepak Saxena <dsaxena@plexity.net>
Subject: Re: [RFC][PATCH 000 of 3] MD Acceleration and the ADMA interface: Introduction
In-Reply-To: message from Dan Williams on Monday February 6
References: <1138931168.6620.8.camel@dwillia2-linux.ch.intel.com>
	<17382.49851.373366.929920@cse.unsw.edu.au>
	<e9c3a7c20602061125j4a1fb48agd23cd600b0cdf6d0@mail.gmail.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday February 6, dan.j.williams@gmail.com wrote:
> On 2/5/06, Neil Brown <neilb@suse.de> wrote:
> > I've looked through the patches - not exhaustively, but hopefully
> > enough to get a general idea of what is happening.
> > There are some things I'm not clear on and some things that I could
> > suggest alternates too...
> 
> I have a few questions to check that I understand your suggestions.

(sorry for the delay).

> 
> >  - Each ADMA client (e.g. a raid5 array) gets a dedicated adma thread
> >    to handle all its requests.  And it handles them all in series.  I
> >    wonder if this is really optimal.  If there are multiple adma
> >    engines, then a single client could only make use of one of them
> >    reliably.
> >    It would seem to make more sense to have just one thread - or maybe
> >    one per processor or one per adma engine - and have any ordering
> >    between requests made explicit in the interface.
> >
> >    Actually as each processor could be seen as an ADMA engine, maybe
> >    you want one thread per processor AND one per engine.  If there are
> >    no engines, the per-processor threads run with high priority, else
> >    with low.
> 
> ...so the engine thread would handle explicit client requested
> ordering constraints and then hand the operations off to per processor
> worker threads in the "pio" case or queue directly to hardware in the
> presence of such an engine.  In md_thread you talk about priority
> inversion deadlocks, do those same concerns apply here?

That comment in md.c about priority inversion deadlocks predates my
involvement - making it "soooo last millennium"...
I don't think it is relevant any more, and possibly never was.

I don't see any room for priority inversion here.

I probably wouldn't even have an 'engine thread'.  If I were to write
'md' today, it probably wouldn't have a dedicate thread but would use
'schedule_work' to arrange for code to be run in process-context.
The ADMA engine could do the same.
Note: I'm not saying this is the "right" way to go.  But I do think it
is worth exploring.

I'm not sure about threads for the 'pio' case.  It would probably be
easiest that way, but I would explore the 'schedule_work' family of
services first.

But yes, the ADMA engine would handle explicit client requested
ordering and arrange for work to be done somehow.

> 
> >  - I have thought that the way md/raid5 currently does the
> >    'copy-to-buffer' and 'xor' in two separate operations may not be
> >    the best use of the memory bus.  If you could have a 3-address
> >    operation that read from A, stored into B, and xorred into C, then
> >    A would have to be read half as often.  Would such an interface
> >    make sense with ADMA?  I don't have sufficient knowledge of
> >    assemble to do it myself for the current 'xor' code.
> 
> At the very least I can add a copy+xor command to ADMA, that way
> developers implementing engines can optimize for this case, if the
> hardware supports it, and the hand coded assembly guys can do their
> thing.
> 
> >  - Your handling of highmem doesn't seem right.  You shouldn't kmap it
> >    until you have decided that you have to do the operation 'by hand'
> >    (i.e. in the cpu, not in the DMA engine).  If the dma engine can be
> >    used at all, kmap isn't needed at all.
> 
> I made the assumption that if CONFIG_HIGHMEM is not set then the kmap
> call resolves to a simple page_address() call.  I think its "ok", but
> it does look fishy so I will revise this code.  I also was looking to
> handle the case where the underlying hardware DMA engine does not
> support high memory addresses.

I think the only way to handle the ADMA engine not supporting high
memory is to do the operation 'polled' - i.e. in the CPU.
The alternative is to copy it to somewhere that the DMA engine can
reach, and if you are going to do that, you have done most of the work
already.
Possibly you could still gain by using the engine for RAID6
calculations, but not for copy, compare, or xor operations.

And if you are using the DMA engine, then you don't want the
page_address. You want to use pci_map_page (or similar?) to get a
dma_handle. 

> >    For example, one it has been decided to initiate a write (there is
> >    enough data to correctly update the parity block).  You need to
> >    perform a sequence of copies and xor operations, and then submit
> >    write requests.
> >    This is currently done by the copy/xor happening inline under the
> >    sh->lock spinlock, and then R5_WantWrite is set.  Then, out side
> >    the spinlock, if WantWrite is set generic_make_request is calls as
> >    appropriate.
> >
> >    I would change this so that a sequence of descriptors was assembled
> >    which described that copies and xors.  Appropriate call-backs would
> >    be set so that the generic_make_request is called at the right time
> >    (after the copy, or after that last xor for the parity block).
> >    Then outside the sh->lock spinlock this sequence is passed to the
> >    ADMA manager.  If there is no ADMA engine present, everything is
> >    performed inline - multiple xors are possibly combined into
> >    multi-way xors automatically.  If there is an ADMA engine, it is
> >    scheduled to do the work.
> 
> I like this idea of clearly separated stripe assembly (finding work
> while under the lock) and stripe execute (running copy+xor / touching
> disks) stages.
> 
> Can you elaborate on a scenario where xors are combined into multi-way xors?

Any xor operation in raid5 is (potentially) over multiple block.
You xor n-1 data blocks together to get the parity block.

The xor_block function takes an array of blocks and xors them all
together into the first.
I don't know if a separate DMA engine would be able to get any benefit
from xoring multiple things at one, but the CPU does so the ADMA
engine would need to know about it atleast when using the CPU to
perform xor operations.

> 
> >    The relevant blocks are all 'locked' as they are added to the
> >    sequence, and unlocked as the writes complete or, for unchanged
> >    block in RECONSTRUCT_WRITE, when the copy xor that uses them
> >    completes.
> >
> >    resync operations would construct similar descriptor sequences, and
> >    have a different call-back on completion.
> >
> >
> >    Doing this would require making sure that get_desc always
> >    succeeds.  I notice that you currently allow for the possible
> >    failure of adma_get_desc and fall back to 'pio' in that case (I
> >    think).  I think it would be better to use a mempool (or similar)
> >    to ensure that you never fail.  There is a simple upper bound on
> >    the number of descriptors you need for one stripe.  Make sure you
> >    have that many from the pool at the top of handle_stripe.  Then use
> >    as many as you need inside the spinlock in handle_stripe without
> >    worrying if you have enough or not.
> 
> Yes, this is a common feedback to not handle per descriptor allocation
> failures.  So, to check your intention, you envision handle_stripe
> deciding early and only once whether copy+xor work will be done
> synchronously under the lock or allowed to run asynchronously.

Not exactly.
I would always have the copy+xor done separately, out side the lock
under which we examine the stripe and decide what to do next.

To achieve this, we would pre-allocate enough descriptors so that a
suitable number of operations could all be happening at once.  Then if
handle_stripe cannot get enough descriptors at the start (i.e. if the
pool is empty), it delays handling of the stripe until descriptors are
available.

NeilBrown
