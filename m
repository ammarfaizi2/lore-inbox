Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262755AbVCPS47@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262755AbVCPS47 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 13:56:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262746AbVCPSzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 13:55:39 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:53729 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262753AbVCPSy2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 13:54:28 -0500
Date: Wed, 16 Mar 2005 10:54:09 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Manfred Spraul <manfred@colorfullife.com>,
       Christoph Lameter <christoph@lameter.com>
cc: Andrew Morton <akpm@osdl.org>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: Fw: [PATCH] NUMA Slab Allocator
Message-ID: <273220000.1110999247@[10.10.2.4]>
In-Reply-To: <42387C2E.4040106@colorfullife.com>
References: <20050315204110.6664771d.akpm@osdl.org> <42387C2E.4040106@colorfullife.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Do you have profile data from your modification? Which percentage of the allocations is node-local, which percentage is from foreign nodes? Preferably per-cache. It shouldn't be difficult to add statistics counters to your patch.
> And: Can you estaimate which percentage is really accessed node-local and which percentage are long-living structures that are accessed from all cpus in the system?
> I had discussions with guys from IBM and SGI regarding a numa allocator, and we decided that we need profile data before we can decide if we need one:
> - A node-local allocator reduces the inter-node traffic, because the callers get node-local memory
> - A node-local allocator increases the inter-node traffic, because objects that are kfree'd on the wrong node must be returned to their home node.

One of the big problems is that much of the slab data really is more global
(ie dentry, inodes, etc). Some of it is more localized (typically the 
kmalloc style stuff). I can't really generate any data easily, as most
of my NUMA boxes are either small Opterons / midsized PPC64, which have 
a fairly low NUMA factor, or large ia32, which only has kernel mem on 
node 0 ;-(

> IIRC the conclusion from our discussion was, that there are at least four possible implementations:
> - your version
> - Add a second per-cpu array for off-node allocations. __cache_free batches, free_block then returns. Global spinlock or per-node spinlock. A patch with a global spinlock is in
> http://www.colorfullife.com/~manfred/Linux-kernel/slab/patch-slab-numa-2.5.66
> per-node spinlocks would require a restructuring of free_block.
> - Add per-node array for each cpu for wrong node allocations. Allows very fast batch return: each array contains memory just from one node, usefull if per-node spinlocks are used.
> - do nothing. Least overhead within slab.
> 
> I'm fairly certains that "do nothing" is the right answer for some caches. 
> For example the dentry-cache: The object lifetime is seconds to minutes, 
> the objects are stored in a global hashtable. They will be touched from 
> all cpus in the system, thus guaranteeing that kmem_cache_alloc returns 
> node-local memory won't help. But the added overhead within slab.c will hurt.

That'd be my inclination .... but OTOH, we do that for pagecache OK. Dunno, 
I'm torn. Depends if there's locality on the file access or not, I guess.
Is there any *harm* in doing it node local .... perhaps creating a node
mem pressure imbalance (OTOH, there's loads of stuff that does that anyway ;-))

The other thing that needs serious thought is how we balance reclaim pressure.

M.

