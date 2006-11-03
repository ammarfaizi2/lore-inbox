Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753387AbWKCRBp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753387AbWKCRBp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 12:01:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753389AbWKCRBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 12:01:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:60603 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1753387AbWKCRBo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 12:01:44 -0500
From: Andi Kleen <ak@suse.de>
To: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: [x86_64] Strange oprofile results on access to per_cpu data
Date: Fri, 3 Nov 2006 18:01:39 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <20061029024504.760769000@sous-sol.org> <200611030356.54074.ak@suse.de> <454AEF0D.1090402@cosmosbay.com>
In-Reply-To: <454AEF0D.1090402@cosmosbay.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611031801.39780.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 03 November 2006 08:26, Eric Dumazet wrote:
> Hi Andi
> 
> While doing some oprofile analysis, I got this result on ip_route_input() : 
> one particular instruction seems to spend a lot of cycles.
> 
> machine is a dual core 285, 2.6 GHz

Single socket? 


> ################ BEGIN
>     370  0.0017 :ffffffff803e98f1:       mov    %gs:0x8,%rax
> 222769  1.0454 :ffffffff803e98fa:       incl   0x38(%rcx,%rax,1)
> ################ END
>       6 2.8e-05 :ffffffff803e98fe:       mov    (%rdx),%rdx
>     833  0.0039 :ffffffff803e9901:       test   %rdx,%rdx
> 
> __raw_get_cpu_var(rt_cache_stat).field++ appears to be very expensive

First the profile events are not exact. It could be an earlier instruction.
The reordering Window is relatively large (~80 macro ops) 

But let's assume it is this one.

Weird. Maybe it's a cache miss. Can you check with DATA_CACHE_MISSES ? 
Or possible a TLB miss, although that's far less likely (L1_AND_L2_DTLB_MISSES)

> (about 18000 RT_CACHE_STAT_INC(in_hlist_search); are done per second, not an 
> impressive count in fact)
> 
> Are segment prefixes that expensive ?

No, they are supposed to be one cycle only.

> Or is it only the first access to %gs:8 that is doing extra checks ?
> (because other RT_CACHE_STAT_INC() done in the same function dont have this cost)
> is it the loading of %rcx (done in ffffffff803e98bd) that is stalling ?

My first guess would be a cache miss of some sort.

Maybe the rest of the code needs enough cache to push this line out. 
Or since you got dual core with separated caches they are bouncing
for some reason (they shouldn't, but maybe there is a bug) 

> so that RT_CACHE_STAT_INC(field) would map to
> 
>     addl $1,%gs:OFFSET  /* no register needed */

I doubt that will make much difference.

-Andi

