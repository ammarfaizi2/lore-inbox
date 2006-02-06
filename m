Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750873AbWBFDaY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750873AbWBFDaY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 22:30:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750931AbWBFDaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 22:30:24 -0500
Received: from ns1.suse.de ([195.135.220.2]:22962 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750873AbWBFDaW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 22:30:22 -0500
From: Neil Brown <neilb@suse.de>
To: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 6 Feb 2006 14:30:03 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17382.49851.373366.929920@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       Chris Leech <christopher.leech@intel.com>,
       "Grover, Andrew" <andrew.grover@intel.com>,
       Deepak Saxena <dsaxena@plexity.net>
Subject: Re: [RFC][PATCH 000 of 3] MD Acceleration and the ADMA interface:
	Introduction
In-Reply-To: message from Dan Williams on Thursday February 2
References: <1138931168.6620.8.camel@dwillia2-linux.ch.intel.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday February 2, dan.j.williams@intel.com wrote:
> This patch set was originally posted to linux-raid, Neil suggested that
> I send to linux-kernel as well:
> 
> Per the discussion in this thread (http://marc.theaimsgroup.com/?
> t=112603120100004&r=1&w=2) these patches implement the first phase of MD
> acceleration, pre-emptible xor.  To date these patches only cover raid5
> calls to compute_parity for read/modify and reconstruct writes.  The
> plan is to expand this to cover raid5 check parity, raid5 compute block,
> as well as the raid6 equivalents.
> 
> The ADMA (Asynchronous / Application Specific DMA) interface is proposed
> as a cross platform mechanism for supporting system CPU offload engines.
> The goal is to provide a unified asynchronous interface to support
> memory copies, block xor, block pattern setting, block compare, CRC
> calculation, cryptography etc.  The ADMA interface should support a PIO
> fallback mode allowing a given ADMA engine implementation to use the
> system CPU for operations without a hardware accelerated backend.  In
> other words a client coded to the ADMA interface transparently receives
> hardware acceleration for its operations depending on the features of
> the underlying platform.

I've looked through the patches - not exhaustively, but hopefully
enough to get a general idea of what is happening.
There are some things I'm not clear on and some things that I could
suggest alternates too...

 - Each ADMA client (e.g. a raid5 array) gets a dedicated adma thread
   to handle all its requests.  And it handles them all in series.  I
   wonder if this is really optimal.  If there are multiple adma
   engines, then a single client could only make use of one of them
   reliably.
   It would seem to make more sense to have just one thread - or maybe
   one per processor or one per adma engine - and have any ordering
   between requests made explicit in the interface.

   Actually as each processor could be seen as an ADMA engine, maybe
   you want one thread per processor AND one per engine.  If there are
   no engines, the per-processor threads run with high priority, else
   with low.

 - I have thought that the way md/raid5 currently does the
   'copy-to-buffer' and 'xor' in two separate operations may not be
   the best use of the memory bus.  If you could have a 3-address
   operation that read from A, stored into B, and xorred into C, then
   A would have to be read half as often.  Would such an interface
   make sense with ADMA?  I don't have sufficient knowledge of
   assemble to do it myself for the current 'xor' code.

 - Your handling of highmem doesn't seem right.  You shouldn't kmap it
   until you have decided that you have to do the operation 'by hand'
   (i.e. in the cpu, not in the DMA engine).  If the dma engine can be
   used at all, kmap isn't needed at all.

 - The interfacing between raid5 and adma seems clumsy... Maybe this
   is just because you were trying to minimise changes to raid5.c.
   I think it would be better to make substantial but elegant changes
   to raid5.c - handle_stripe in particular - so that what is
   happening becomes very obvious.

   For example, one it has been decided to initiate a write (there is
   enough data to correctly update the parity block).  You need to
   perform a sequence of copies and xor operations, and then submit
   write requests.
   This is currently done by the copy/xor happening inline under the
   sh->lock spinlock, and then R5_WantWrite is set.  Then, out side
   the spinlock, if WantWrite is set generic_make_request is calls as
   appropriate. 

   I would change this so that a sequence of descriptors was assembled
   which described that copies and xors.  Appropriate call-backs would
   be set so that the generic_make_request is called at the right time
   (after the copy, or after that last xor for the parity block).
   Then outside the sh->lock spinlock this sequence is passed to the
   ADMA manager.  If there is no ADMA engine present, everything is
   performed inline - multiple xors are possibly combined into
   multi-way xors automatically.  If there is an ADMA engine, it is
   scheduled to do the work.

   The relevant blocks are all 'locked' as they are added to the
   sequence, and unlocked as the writes complete or, for unchanged
   block in RECONSTRUCT_WRITE, when the copy xor that uses them
   completes. 

   resync operations would construct similar descriptor sequences, and
   have a different call-back on completion.


   Doing this would require making sure that get_desc always
   succeeds.  I notice that you currently allow for the possible
   failure of adma_get_desc and fall back to 'pio' in that case (I
   think).  I think it would be better to use a mempool (or similar)
   to ensure that you never fail.  There is a simple upper bound on
   the number of descriptors you need for one stripe.  Make sure you
   have that many from the pool at the top of handle_stripe.  Then use
   as many as you need inside the spinlock in handle_stripe without
   worrying if you have enough or not.

I hope that if helpful and look forward to seeing future progress in
this area.

NeilBrown
