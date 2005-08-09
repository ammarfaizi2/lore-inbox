Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964977AbVHIVSQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964977AbVHIVSQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 17:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964979AbVHIVSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 17:18:16 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17322 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S964977AbVHIVSQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 17:18:16 -0400
Date: Tue, 9 Aug 2005 18:13:05 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Rik van Riel <riel@redhat.com>
Subject: Re: [RFC 1/3] non-resident page tracking
Message-ID: <20050809211305.GA23675@dmt.cnet>
References: <20050808201416.450491000@jumble.boston.redhat.com> <20050808202110.744344000@jumble.boston.redhat.com> <20050809182517.GA20644@dmt.cnet> <1123614926.17222.19.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1123614926.17222.19.camel@twins>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2005 at 09:15:26PM +0200, Peter Zijlstra wrote:
> On Tue, 2005-08-09 at 15:25 -0300, Marcelo Tosatti wrote:
> > Hi Rik,
> > 
> > Two hopefully useful comments:
> > 
> > i) ARC and its variants requires additional information about page
> > replacement (namely whether the page has been reclaimed from the L1 or
> > L2 lists).
> > 
> > How costly would it be to add this information to the hash table?
> > 
> I've been thinking on reserving another word in the cache-line and use
> that as a bit-array to keep that information; the only problems with
> that would be atomicy of the {bucket,bit} tuple and very large
> cachelines where NUM_NR > 32. 

The chance for a lookup hit to happen on a hash value which is in a
modified-state in a different CPU's cacheline should be pretty small
(depends on the architecture also, but shouldnt be much of an issue I
guess).

Hoping on that, guaranteed validity of data is not necessary, it is OK
to be incorrect occasionally.

> > ii) From my reading of the patch, the provided "distance" information is
> > relative to each hash bucket. I'm unable to understand the distance metric
> > being useful if measured per-hash-bucket instead of globally?
> 
> The assumption is that IFF the hash function has good distribution
> properties the per bucket distance is a good approximation of
> (distance >> nonres_shift).

Well, not really "good approximation" it sounds to me, the sensibility
goes down to L1_CACHE_LINE/sizeof(u32), which is:

- 8 on 32-byte cacheline
- 16 on 64-byte cacheline 
- 32 on 128-byte cacheline

Right?

So the (nice!) refault histogram gets limited to those values?

> > PS: Since remember_page() is always called with the zone->lru_lock held,
> > the preempt_disable/enable pair is unecessary at the moment... still, 
> > might be better to leave it there for safety reasons.
> > 
> 
> There being multiple zones; owning zone->lru_lock does not guarantee
> uniqueness on the remember_page() path as its a global structure.

True, but it guarantees disabled preemption. No big deal...
