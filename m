Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965094AbWBGONV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965094AbWBGONV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 09:13:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965096AbWBGONV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 09:13:21 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:30610 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965094AbWBGONV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 09:13:21 -0500
Date: Tue, 7 Feb 2006 15:11:41 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: steiner@sgi.com, Paul Jackson <pj@sgi.com>, clameter@engr.sgi.com,
       akpm@osdl.org, dgc@sgi.com, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] cpuset memory spread basic implementation
Message-ID: <20060207141141.GA14706@elte.hu>
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com> <200602071343.59384.ak@suse.de> <20060207125845.GB634@elte.hu> <200602071414.31119.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602071414.31119.ak@suse.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.2
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.2 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.6 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andi Kleen <ak@suse.de> wrote:

> I meant it's not that big an issue if it's remote, but it's bad if it 
> fills up the local node.

are you sure this is not some older VM issue? Unless it's a fundamental 
property of NUMA systems, it would be bad to factor in some VM artifact 
into the caching design.

> Basically you have to consider the frequency of access:
> 
> Mapped memory is very frequently accessed. For it memory placement is 
> really important. Optimizing it at the cost of everything else is a 
> good default strategy
> 
> File cache is much less frequently accessed (most programs buffer 
> read/write well) and when it is accessed it is using functions that 
> are relatively latency tolerant (kernel memcpy). So memory placement 
> is much less important here.
> 
> And d/inode are also very infrequently accessed compared to local 
> memory, so the occasionally additional latency is better than 
> competing too much with local memory allocation.

Most pagecache pages are clean, and it's easy and fast to zap a clean 
page when a new anonymous page needs space. So i dont really see why the 
pagecache is such a big issue - it should in essence be invisible to the 
rest of the VM. (barring the extreme case of lots of dirty pages in the 
pagecache) What am i missing?

> > i also mentioned software-based clusters in the previous mail, so it's 
> > not only about big systems. Caching attributes are very much relevant 
> > there. Tightly integrated clusters can be considered NUMA systems with a 
> > NUMA factor of 1000 or so (or worse).
> 
> To be honest I don't think systems with such a NUMA factor will ever 
> work well in the general case. So I wouldn't recommend considering 
> them much if at all in your design thoughts. The result would likely 
> not be a good balanced design.

loosely coupled clusters do seem to work quite well, since the 
overwhelming majority of computing jobs tend to deal with easily 
partitionable workloads. Making clusters more seemless via software 
(a'ka OpenMosix) is still quite tempting i think.

> > Small systems (to me) are just a flat and symmetric hierarchy of nodes - 
> > the next step from SMP. So there's really just two distances: local to 
> > the node, and one level of 'alien'. Or do you include systems in this 
> > category that have bigger assymetries?
> 
> Even a 4 way Opteron has two hierarchies [...]

yeah, you are right.

	Ingo
