Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965096AbWBGOXr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965096AbWBGOXr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 09:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965097AbWBGOXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 09:23:47 -0500
Received: from ns2.suse.de ([195.135.220.15]:46536 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965096AbWBGOXq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 09:23:46 -0500
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1/5] cpuset memory spread basic implementation
Date: Tue, 7 Feb 2006 15:23:19 +0100
User-Agent: KMail/1.8.2
Cc: steiner@sgi.com, Paul Jackson <pj@sgi.com>, clameter@engr.sgi.com,
       akpm@osdl.org, dgc@sgi.com, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com> <200602071414.31119.ak@suse.de> <20060207141141.GA14706@elte.hu>
In-Reply-To: <20060207141141.GA14706@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602071523.20174.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 February 2006 15:11, Ingo Molnar wrote:
> 
> * Andi Kleen <ak@suse.de> wrote:
> 
> > I meant it's not that big an issue if it's remote, but it's bad if it 
> > fills up the local node.
> 
> are you sure this is not some older VM issue? 

Unless you implement page migration for all caches it's still there.
The only way to get rid of caches on a node currently is to throw them
away.  And refetching them from disk is quite costly.

> Unless it's a fundamental  
> property of NUMA systems, it would be bad to factor in some VM artifact 
> into the caching design.

Why not? It has to work with the real existing VM, not some imaginary perfect
one.
 
> > Basically you have to consider the frequency of access:
> > 
> > Mapped memory is very frequently accessed. For it memory placement is 
> > really important. Optimizing it at the cost of everything else is a 
> > good default strategy
> > 
> > File cache is much less frequently accessed (most programs buffer 
> > read/write well) and when it is accessed it is using functions that 
> > are relatively latency tolerant (kernel memcpy). So memory placement 
> > is much less important here.
> > 
> > And d/inode are also very infrequently accessed compared to local 
> > memory, so the occasionally additional latency is better than 
> > competing too much with local memory allocation.
> 
> Most pagecache pages are clean, 


... unless you've just written a lot of data.

> and it's easy and fast to zap a clean  
> page when a new anonymous page needs space. So i dont really see why the 
> pagecache is such a big issue - it should in essence be invisible to the 
> rest of the VM. (barring the extreme case of lots of dirty pages in the 
> pagecache) What am i missing?

d/icaches for once don't work this way. Do a find / and watch the results on
your local node.  

And in practice your assumption of everything clean and nice in page cache is 
also often not true.
 
> > > i also mentioned software-based clusters in the previous mail, so it's 
> > > not only about big systems. Caching attributes are very much relevant 
> > > there. Tightly integrated clusters can be considered NUMA systems with a 
> > > NUMA factor of 1000 or so (or worse).
> > 
> > To be honest I don't think systems with such a NUMA factor will ever 
> > work well in the general case. So I wouldn't recommend considering 
> > them much if at all in your design thoughts. The result would likely 
> > not be a good balanced design.
> 
> loosely coupled clusters do seem to work quite well, since the 
> overwhelming majority of computing jobs tend to deal with easily 
> partitionable workloads. 

Yes, but with message passing but without any kind of shared memory.

> Making clusters more seemless via software  
> (a'ka OpenMosix) is still quite tempting i think.

Ok we agree on that then. Great.

-Andi

