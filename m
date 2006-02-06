Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932306AbWBFTZZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbWBFTZZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 14:25:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932308AbWBFTZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 14:25:25 -0500
Received: from zproxy.gmail.com ([64.233.162.207]:49823 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932306AbWBFTZY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 14:25:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MxGJNLkcf10+vUQCzxxPGn6B9T8+1zoZsYnhLut5VjzEhqVugYZCyfDrBe0RMu1zmEA+6vLCh8xwK+qqM2Y5hAVI6aO60StpCd6j71AfKhajq4/CpLuTpA4Ph3brEpALMdup/ttEwuT6in141BmfAqsZdDmHZNGjIlI/H48wclk=
Message-ID: <e9c3a7c20602061125j4a1fb48agd23cd600b0cdf6d0@mail.gmail.com>
Date: Mon, 6 Feb 2006 12:25:22 -0700
From: Dan Williams <dan.j.williams@gmail.com>
To: Neil Brown <neilb@suse.de>
Subject: Re: [RFC][PATCH 000 of 3] MD Acceleration and the ADMA interface: Introduction
Cc: Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org,
       linux-raid@vger.kernel.org, Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       Chris Leech <christopher.leech@intel.com>,
       "Grover, Andrew" <andrew.grover@intel.com>,
       Deepak Saxena <dsaxena@plexity.net>
In-Reply-To: <17382.49851.373366.929920@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1138931168.6620.8.camel@dwillia2-linux.ch.intel.com>
	 <17382.49851.373366.929920@cse.unsw.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/5/06, Neil Brown <neilb@suse.de> wrote:
> I've looked through the patches - not exhaustively, but hopefully
> enough to get a general idea of what is happening.
> There are some things I'm not clear on and some things that I could
> suggest alternates too...

I have a few questions to check that I understand your suggestions.

>  - Each ADMA client (e.g. a raid5 array) gets a dedicated adma thread
>    to handle all its requests.  And it handles them all in series.  I
>    wonder if this is really optimal.  If there are multiple adma
>    engines, then a single client could only make use of one of them
>    reliably.
>    It would seem to make more sense to have just one thread - or maybe
>    one per processor or one per adma engine - and have any ordering
>    between requests made explicit in the interface.
>
>    Actually as each processor could be seen as an ADMA engine, maybe
>    you want one thread per processor AND one per engine.  If there are
>    no engines, the per-processor threads run with high priority, else
>    with low.

...so the engine thread would handle explicit client requested
ordering constraints and then hand the operations off to per processor
worker threads in the "pio" case or queue directly to hardware in the
presence of such an engine.  In md_thread you talk about priority
inversion deadlocks, do those same concerns apply here?

>  - I have thought that the way md/raid5 currently does the
>    'copy-to-buffer' and 'xor' in two separate operations may not be
>    the best use of the memory bus.  If you could have a 3-address
>    operation that read from A, stored into B, and xorred into C, then
>    A would have to be read half as often.  Would such an interface
>    make sense with ADMA?  I don't have sufficient knowledge of
>    assemble to do it myself for the current 'xor' code.

At the very least I can add a copy+xor command to ADMA, that way
developers implementing engines can optimize for this case, if the
hardware supports it, and the hand coded assembly guys can do their
thing.

>  - Your handling of highmem doesn't seem right.  You shouldn't kmap it
>    until you have decided that you have to do the operation 'by hand'
>    (i.e. in the cpu, not in the DMA engine).  If the dma engine can be
>    used at all, kmap isn't needed at all.

I made the assumption that if CONFIG_HIGHMEM is not set then the kmap
call resolves to a simple page_address() call.  I think its "ok", but
it does look fishy so I will revise this code.  I also was looking to
handle the case where the underlying hardware DMA engine does not
support high memory addresses.

>  - The interfacing between raid5 and adma seems clumsy... Maybe this
>    is just because you were trying to minimise changes to raid5.c.
>    I think it would be better to make substantial but elegant changes
>    to raid5.c - handle_stripe in particular - so that what is
>    happening becomes very obvious.

Yes, I went into this with the idea of being minimally intrusive, but
you are right the end result should have MD optimized for ADMA rather
than ADMA shoe-horned into MD.

>    For example, one it has been decided to initiate a write (there is
>    enough data to correctly update the parity block).  You need to
>    perform a sequence of copies and xor operations, and then submit
>    write requests.
>    This is currently done by the copy/xor happening inline under the
>    sh->lock spinlock, and then R5_WantWrite is set.  Then, out side
>    the spinlock, if WantWrite is set generic_make_request is calls as
>    appropriate.
>
>    I would change this so that a sequence of descriptors was assembled
>    which described that copies and xors.  Appropriate call-backs would
>    be set so that the generic_make_request is called at the right time
>    (after the copy, or after that last xor for the parity block).
>    Then outside the sh->lock spinlock this sequence is passed to the
>    ADMA manager.  If there is no ADMA engine present, everything is
>    performed inline - multiple xors are possibly combined into
>    multi-way xors automatically.  If there is an ADMA engine, it is
>    scheduled to do the work.

I like this idea of clearly separated stripe assembly (finding work
while under the lock) and stripe execute (running copy+xor / touching
disks) stages.

Can you elaborate on a scenario where xors are combined into multi-way xors?

>    The relevant blocks are all 'locked' as they are added to the
>    sequence, and unlocked as the writes complete or, for unchanged
>    block in RECONSTRUCT_WRITE, when the copy xor that uses them
>    completes.
>
>    resync operations would construct similar descriptor sequences, and
>    have a different call-back on completion.
>
>
>    Doing this would require making sure that get_desc always
>    succeeds.  I notice that you currently allow for the possible
>    failure of adma_get_desc and fall back to 'pio' in that case (I
>    think).  I think it would be better to use a mempool (or similar)
>    to ensure that you never fail.  There is a simple upper bound on
>    the number of descriptors you need for one stripe.  Make sure you
>    have that many from the pool at the top of handle_stripe.  Then use
>    as many as you need inside the spinlock in handle_stripe without
>    worrying if you have enough or not.

Yes, this is a common feedback to not handle per descriptor allocation
failures.  So, to check your intention, you envision handle_stripe
deciding early and only once whether copy+xor work will be done
synchronously under the lock or allowed to run asynchronously.

> I hope that if helpful and look forward to seeing future progress in
> this area.

Thanks,

Dan
