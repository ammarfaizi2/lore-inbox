Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964787AbWBUUT6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964787AbWBUUT6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 15:19:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964808AbWBUUT5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 15:19:57 -0500
Received: from ns1.siteground.net ([207.218.208.2]:38874 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S964787AbWBUUT5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 15:19:57 -0500
Date: Tue, 21 Feb 2006 12:20:24 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>
Subject: Re: [patch] Cache align futex hash buckets
Message-ID: <20060221202024.GA3635@localhost.localdomain>
References: <20060220233242.GC3594@localhost.localdomain> <43FA8938.70006@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43FA8938.70006@yahoo.com.au>
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

On Tue, Feb 21, 2006 at 02:30:00PM +1100, Nick Piggin wrote:
> Ravikiran G Thirumalai wrote:
> >Following change places each element of the futex_queues hashtable on a 
> >different cacheline.  Spinlocks of adjacent hash buckets lie on the same 
> >cacheline otherwise.
> >
> 
> It does not make sense to add swaths of unused memory into a hashtable for
> this purpose, does it?

I don't know if having two (or more) spinlocks on the same cacheline is a good 
idea.  Right now, on a 128 B cacheline we have 10 spinlocks on the
same cacheline here!! Things get worse if two futexes from different nodes 
hash on to adjacent, or even nearly adjacent hash buckets.

> 
> For a minimal, naive solution you just increase the size of the hash table.
> This will (given a decent hash function) provide the same reduction in
> cacheline contention, while also reducing collisions.

Given a decent hash function.  I am not sure the hashing function is smart 
enough as of now.  Hashing is not a function of nodeid, and we have some 
instrumentation results which show hashing on NUMA is not good as yet, and
there are collisions from other nodes onto the same hashbucket; Nearby 
buckets have high hit rates too.

I think some sort of NUMA friendly hashing, where futexes from same nodes
hash onto a node local hash table, would be a decent solution here.
As I mentioned earlier, we are working on that, and we can probably allocate
the spinlock from nodelocal memory then and avoid this bloat.
We are hoping to have this as a stop gap fix until we get there.

Thanks,
Kiran

