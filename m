Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129044AbRBBTHG>; Fri, 2 Feb 2001 14:07:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129158AbRBBTG4>; Fri, 2 Feb 2001 14:06:56 -0500
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:36106 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP
	id <S129044AbRBBTGs>; Fri, 2 Feb 2001 14:06:48 -0500
From: bsuparna@in.ibm.com
X-Lotus-FromDomain: IBMIN@IBMAU
To: "Stephen C. Tweedie" <sct@redhat.com>
cc: Ben LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org,
        kiobuf-io-devel@lists.sourceforge.net
Message-ID: <CA2569E7.0068CEBA.00@d73mta05.au.ibm.com>
Date: Fri, 2 Feb 2001 21:01:09 +0530
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait 
	/notify + callback chains
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Hi,
>
>On Thu, Feb 01, 2001 at 01:28:33PM +0530, bsuparna@in.ibm.com wrote:
>>
>> Here's a second pass attempt, based on Ben's wait queue extensions:
> Does this sound any better ?
>
>It's a mechanism, all right, but you haven't described what problems
>it is trying to solve, and where it is likely to be used, so it's hard
>to judge it. :)

Hmm .. I thought I had done that in my first posting, but obviously, I
mustn't have done a good job at expressing it, so let me take another stab
at trying to convey why I started on this.

There are certain specific situations that I have in mind right now, but to
me it looks like the very nature of the abstraction is such that it is
quite likely that there would be uses in some other situations which I may
not have thought of yet, or just do not understand well enough to vouch for
at this point. What those situations could be, and the associated issues
involved (especially performance related) is something that I hope other
people on this forum would be able to help pinpoint, based on their
experiences and areas of expertise.

I do realize that generic and yet simple and performance optimal in all
kinds of situations is a really difficult (if not impossible :-) ) thing to
achieve, but even then, won't it be nice to at least abstract out
uniformity in patterns across situations in a way which can be
tweaked/tuned for each specific class of situations ?

And the nice thing which I see about Ben's wait queue extensions is that it
gives us a route to try to do that ...

Some needs considered (and associated problems):

a. Stacking of completion events - asynchronously, through multiple layers
     - layered drivers  (encryption, conversion)
     - filter filesystems
    Key aspects:
     1. It should be possible to pass the same (original) i/o container
structure all the way down (no copies/clones should need to happen, unless
actual i/o splitting, or extra buffer space or multiple sub-ios are
involved)
     2. Transparency: Neither the upper layer nor the layer below it should
need to have any specific knowledge about the existence/absense of an
intermediate filter layer (the mechanism should hide all that)
     3. LIFO ordering of completion actions
     4. The i/o structure should be marked as up-to-date only after all the
completion actions are done.
     5. Preferably have waiters on the i/o structure woken up only after
all completion actions are through (to avoid spurious/redundant wakeups
since the data won't be ready for use)
     6. Possible to have completion actions execute later in task context

b. Co-relation between multiple completion events and their associated
operations and data structures
     -  (bottom up aspect) merging results of split i/o requests, and
marking the completion of the compound i/o through multiple such layers
(tree), e.g
          - lvm
          - md / raid
          - evms aggregator features
     - (top down aspect) cascading down i/o cancellation requests /
sub-event waits , monitoring sub-io status etc
      Some aspects:
     1. Result of collation of sub-i/os may be driver specific  (In some
situations like lvm  - each sub i/o maps to a particular portion of a
buffer; with software raid or some other kind of scheme the collation may
involve actually interpreting the data read)
     2. Re-start/retries of sub-ios (in case of errors) can be handled.
     3. Transparency : Neither the upper layer nor the layer below it
should need to have any specific knowledge about the existence/absense of
an intermediate layer (that sends out multiple sub i/os)
     4. The system should be devised to avoid extra logic/fields in the
generic i/o structures being passed around, in situations where no compound
i/o is involved (i.e. in the simple i/o cases and most common situations).
As far as possible it is desirable to keep the linkage information outside
of the i/o structure for this reason.
     5. Possible to have collation/completion actions execute later in task
context


Ben LaHaise's wait queue extensions takes care of most of the aspects of
(a), if used with a little care to ensure a(4).
[This just means that function that marks the i/o structure as up-to-date
should be put in the completion queue first]
With this, we don't even need and explicit end_io() in bh/kiobufs etc. Just
the wait queue would do.

Only a(5) needs some thought since cache efficiency is upset by changing
the ordering of waits.

But, (b) needs a little more work as a higher level construct/mechanism
that latches on to the wait queue extensions. That is what the cev_wait
structure was designed for.
It keeps the chaining information outside of the i/o structures by default
(They can be allocated together, if desired anyway)

Is this still too much in the air ? Maybe I should describe the flow in a
specific scenario to illustrate ?

Regards
Suparna


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
