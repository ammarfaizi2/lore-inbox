Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030222AbVLMVEJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030222AbVLMVEJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 16:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030221AbVLMVEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 16:04:09 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:63174 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030222AbVLMVEG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 16:04:06 -0500
Date: Tue, 13 Dec 2005 13:03:50 -0800
From: Paul Jackson <pj@sgi.com>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: clameter@engr.sgi.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       nickpiggin@yahoo.com.au, Simon.Derr@bull.net, ak@suse.de
Subject: Re: [PATCH] Cpuset: rcu optimization of page alloc hook
Message-Id: <20051213130350.464a3054.pj@sgi.com>
In-Reply-To: <439F0B43.4080500@cosmosbay.com>
References: <20051211233130.18000.2748.sendpatchset@jackhammer.engr.sgi.com>
	<439D39A8.1020806@cosmosbay.com>
	<20051212020211.1394bc17.pj@sgi.com>
	<20051212021247.388385da.akpm@osdl.org>
	<20051213075345.c39f335d.pj@sgi.com>
	<439EF75D.50206@cosmosbay.com>
	<Pine.LNX.4.62.0512130938130.22803@schroedinger.engr.sgi.com>
	<439F0B43.4080500@cosmosbay.com>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric wrote:
> If this variable is not frequently used, why then define its own cache ?
> 
> Ie why not use kmalloc() and let kernel use a general cache ?

This change from kmalloc() to a dedicated slab cache was made just a
couple of days ago, at the suggestion of Andi Kleen and Nick Piggin, in
order to optimize out a tasklock spinlock from the primary code path
for allocating a page of memory.

Indeed, this email thread is the thread that presented that patch.

By using a dedicated slab cache, I was able to make an unusual use of
Hugh Dicken's SLAB_DESTROY_BY_RCU implementation, and access a variable
inside the cpuset structure safely, even after that cpuset structure
might have been asynchronously free'd.  What I read from that variable
might well be garbage, but at least the slab would not have freed that
page of memory entirely, inside my rcu_read_lock section.

Since all I needed was to edge trigger on the condition that the
contents of a variable changed since last read, that was sufficient.

> On a 32 CPUS machine, a kmem_create() costs a *lot* of ram.

Hmmm ... if 32 is bad, then what does it cost for say 512 CPUs?

And when is that memory required?  On many systems, that will have
cpusets CONFIG_CPUSET enabled, but that are not using cpusets, just
the kmem_cache_create() will be called to create cpuset_cache, but
-no- kmem_cache_alloc() calls done.  On those systems using cpusets,
there might be one 'struct cpuset' allocated per gigabyte of ram, as a
rough idea.

Can you quantify "costs a *lot* of ram" ?

I suppose that I could add a little bit of logic that avoided the
initial kmem_cache_create() until needed by actual cpuset usage on the
system (on the first cpuset_create(), the first time that user code
tries to create a cpuset).  In a related optimization, I might be able
to avoid -even- the rcu_read_lock() guards on systems not using
cpusets (never called cpuset_create() since boot), reducing that guard
to a simple comparison of the current tasks cpuset pointer with the
pointer to the one statically allocated global cpuset, known as the root
cpuset.  Actually, that last opimization would benefit any task still
in the root cpuset, even after other cpusets had been dynamically
created.

Or, if using the slab cache was still too expensive for this use, I
could perhaps make a more conventional use of RCU, to guard the kfree()
myself, instead of making this unusual use of SLAB_DESTROY_BY_RCU.  I'd
have to learn more about RCU to know how to do that, or even it made
sense.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
