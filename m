Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751136AbVIWSk5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbVIWSk5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 14:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbVIWSk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 14:40:56 -0400
Received: from serv01.siteground.net ([70.85.91.68]:3030 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1751133AbVIWSk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 14:40:56 -0400
Date: Fri, 23 Sep 2005 11:40:52 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andrew Morton <akpm@osdl.org>
Cc: davem@davemloft.net, rusty@rustcorp.com.au, dipankar@in.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 0/6] mm: alloc_percpu and  bigrefs
Message-ID: <20050923184052.GA4103@localhost.localdomain>
References: <20050923062529.GA4209@localhost.localdomain> <20050923001013.28b7f032.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050923001013.28b7f032.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2005 at 12:10:13AM -0700, Andrew Morton wrote:
> 
> (Added linux-kernel)
> 
> Ravikiran G Thirumalai <kiran@scalex86.org> wrote:
> >
> > Hi Andrew,
> > This patchset contains alloc_percpu + bigrefs + bigrefs for netdevice
> > refcount.  This patchset improves tbench lo performance by 6% on a 8 way IBM
> > x445.
> 
> I think we'd need more comprehensive benchmarks than this before adding
> large amounts of complex core code.
> 
> We'd also need to know how much of any performance improvement was due to
> alloc_percpu versus bigrefs, please.
> 
> Bigrefs look reasonably sane to me, but a whole new memory allocator is a
> big deal.  Given that alloc_percpu() is already numa-aware, is that extra
> cross-node fetch and pointer hop really worth all that new code?  The new
> version will have to do a tlb load (including a cross-node fetch)
> approximately as often as the old version will get a CPU cache miss on the
> percpu array, maybe?
> 
> 

The extra pointer dereference saving with the re-implementation saved 10 %
with the dst changes.  With just the net_device refcount, there was a
difference of 2 % with the existing implementation.  So 1 extra dereference
does matter.

That said, the re-implementation does have other advantages;
1. It avoids the memory bloat caused by the existing implementation as it does 
not pad all objects to cacheline size like the existing implementation
does,  This helps small objects like bigrefs.  Additionally, it results in
better cacheline utilization now as many per-cpu objects  share the same
cacheline.
2. It is hotplug friendly.  In case you want to offline a node, you can
easily free the per-cpu memory corresponding to that node.  You cannot do
that with the current scheme.
3. It can work early.  We did some experimentation with struct
vfsmount.mnt_count refcounter (It is per-mount point so it is not too many
objects), and the old alloc_percpu refused to work early.  Yes, now I guess
there are workarounds to make cpu_possible_mask bits set for NR_CPUS early,
but wouldn't that result in memory being allocated for cpus which can
never be present?
4. With the re-implementation, it might be possible to make often used 
structures like cpu_pda truly node local with alloc_percpu..

As for the benchmarks, tbench on lo was used indicatively.  lo performance
does matter for quite a few benchmarks. There are apps which do use lo 
extensively.  The dst and netdevice changes were made after profiling such 
real wold apps.  Agreed, per-cpufication of objects which can go up in 
size is not the right approach on hindsight, but netdevice.refcount is not 
one of those.  I can try running a standard mpi benchmark or some
other indicative benchmark if that would help?

Thanks,
Kiran
