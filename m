Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932174AbVHITP3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174AbVHITP3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 15:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932189AbVHITP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 15:15:29 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:29763 "EHLO
	amsfep17-int.chello.nl") by vger.kernel.org with ESMTP
	id S932174AbVHITP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 15:15:28 -0400
Subject: Re: [RFC 1/3] non-resident page tracking
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Rik van Riel <riel@redhat.com>
In-Reply-To: <20050809182517.GA20644@dmt.cnet>
References: <20050808201416.450491000@jumble.boston.redhat.com>
	 <20050808202110.744344000@jumble.boston.redhat.com>
	 <20050809182517.GA20644@dmt.cnet>
Content-Type: text/plain
Date: Tue, 09 Aug 2005 21:15:26 +0200
Message-Id: <1123614926.17222.19.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-08-09 at 15:25 -0300, Marcelo Tosatti wrote:
> Hi Rik,
> 
> Two hopefully useful comments:
> 
> i) ARC and its variants requires additional information about page
> replacement (namely whether the page has been reclaimed from the L1 or
> L2 lists).
> 
> How costly would it be to add this information to the hash table?
> 
I've been thinking on reserving another word in the cache-line and use
that as a bit-array to keep that information; the only problems with
that would be atomicy of the {bucket,bit} tuple and very large
cachelines where NUM_NR > 32.

> ii) From my reading of the patch, the provided "distance" information is
> relative to each hash bucket. I'm unable to understand the distance metric
> being useful if measured per-hash-bucket instead of globally?

The assumption is that IFF the hash function has good distribution
properties the per bucket distance is a good approximation of
(distance >> nonres_shift).

> 
> PS: Since remember_page() is always called with the zone->lru_lock held,
> the preempt_disable/enable pair is unecessary at the moment... still, 
> might be better to leave it there for safety reasons.
> 

There being multiple zones; owning zone->lru_lock does not guarantee
uniqueness on the remember_page() path as its a global structure.

-- 
Peter Zijlstra <a.p.zijlstra@chello.nl>

