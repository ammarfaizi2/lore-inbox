Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318223AbSHDUXE>; Sun, 4 Aug 2002 16:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318224AbSHDUXE>; Sun, 4 Aug 2002 16:23:04 -0400
Received: from holomorphy.com ([66.224.33.161]:29314 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S318223AbSHDUXC>;
	Sun, 4 Aug 2002 16:23:02 -0400
Date: Sun, 4 Aug 2002 13:23:22 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Hubertus Franke <frankeh@watson.ibm.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       "David S. Miller" <davem@redhat.com>, davidm@hpl.hp.com,
       davidm@napali.hpl.hp.com, gh@us.ibm.com, Martin.Bligh@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: large page patch (fwd) (fwd)
Message-ID: <20020804202322.GA4020@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Hubertus Franke <frankeh@watson.ibm.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	"David S. Miller" <davem@redhat.com>, davidm@hpl.hp.com,
	davidm@napali.hpl.hp.com, gh@us.ibm.com, Martin.Bligh@us.ibm.com,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0208041131380.10314-100000@home.transmeta.com> <200208041530.24661.frankeh@watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <200208041530.24661.frankeh@watson.ibm.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 04, 2002 at 03:30:24PM -0400, Hubertus Franke wrote:
> As long as the alignments are observed, which you I guess imply by the range.

On Sunday 04 August 2002 02:38 pm, Linus Torvalds wrote:
>>    If the order-X allocation fails, we're likely low on memory (this is
>>    _especially_ true since the very fact that we do lots of order-X
>>    allocations will probably actually help keep fragementation down
>>    normally), and we just allocate one page (with a regular GFP_USER this
>>    time).

Later on I can redo one of the various online defragmentation things
that went around last October or so if it would help with this.


On Sunday 04 August 2002 02:38 pm, Linus Torvalds wrote:
>>    Map in all pages.
>>  - do the same for page_cache_readahead() (this, btw, is where radix trees
>>    will kick some serious ass - we'd have had a hard time doing the "is
>>    this range of order-X pages populated" efficiently with the old hashes.

On Sun, Aug 04, 2002 at 03:30:24PM -0400, Hubertus Franke wrote:
> Hey, we use the radix tree to track page cache mappings for large pages
> particularly for this reason...

Proportion of radix tree populated beneath a given node can be computed
by means of traversals adding up ->count or by incrementally maintaining
a secondary counter for ancestors within the radix tree node. I can look
into this when I go over the path compression heuristics, which would
help the space consumption for access patterns fooling the current one.
Getting physical contiguity out of that is another matter, but the code
can be used for other things (e.g. exec()-time prefaulting) until that's
worked out, and it's not a focus or requirement of this code anyway.


On Sunday 04 August 2002 02:38 pm, Linus Torvalds wrote:
>> I bet just those fairly small changes will give you effective coloring,
>> _and_ they are also what you want for doing small superpages.

On Sun, Aug 04, 2002 at 03:30:24PM -0400, Hubertus Franke wrote:
> The HW TLB case can be extended to not store the same PA in all the PTEs,
> but conceptually carry the superpage concept for the purpose described above.

Pagetable walking gets a tiny hook, not much interesting goes on there.
A specialized wrapper for extracting physical pfn's from the pmd's like
the one for testing whether they're terminal nodes might look more
polished, but that's mostly cosmetic.

Hmm, from looking at the "small" vs. "large" page bits, I have an
inkling this may be relative to the machine size. 256GB boxen will
probably think of 4MB pages as small.


On Sun, Aug 04, 2002 at 03:30:24PM -0400, Hubertus Franke wrote:
> But to go down this route we need the concept of a superpage in the VM,
> not just at TLB time or a hack that throws these things over the fence. 

The bit throwing it over the fence is probably still useful, as Oracle
knows what it's doing and I suspect it's largely to dodge pagetable
space consumption OOM'ing machines as opposed to optimizing anything.
It pretty much wants the kernel out of the way aside from as a big bag
of device drivers, so I'm not surprised they're more than happy to have
the MMU in their hands too. The more I think about it, the less related
to superpages it seems. The motive for superpages is 100% TLB, not a
workaround for pagetable OOM.


Cheers,
Bill
