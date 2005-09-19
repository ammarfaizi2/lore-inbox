Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932573AbVISSwl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932573AbVISSwl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 14:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932572AbVISSwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 14:52:41 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:48321 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932575AbVISSwk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 14:52:40 -0400
Date: Mon, 19 Sep 2005 11:51:45 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: Petr Vandrovec <vandrove@vc.cvut.cz>, alokk@calsoftinc.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc1-git-now still dying in mm/slab - this time line 1849
In-Reply-To: <20050919112912.18daf2eb.akpm@osdl.org>
Message-ID: <Pine.LNX.4.62.0509191141380.26105@schroedinger.engr.sgi.com>
References: <4329A6A3.7080506@vc.cvut.cz> <20050916023005.4146e499.akpm@osdl.org>
 <432AA00D.4030706@vc.cvut.cz> <20050916230809.789d6b0b.akpm@osdl.org>
 <432EE103.5020105@vc.cvut.cz> <20050919112912.18daf2eb.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Sep 2005, Andrew Morton wrote:

> Well.  The CPU_UP_CANCELED locking in cpuup_callback() looks borked to me -
> it takes cachep->nodelists[node]->list_lock and then calls
> drain_alien_cache() which appears to take the same lock.  But that's not
> the problem here.
> 
> The code in cache_reap() recalculates numa_node_id() multiple times, so if
> the caller changes CPUs then this assertion will trigger.  However it's
> running under keventd here, which is pinned to a single CPU.  Still, it
> would be useful if you could try putting preempt_disable()s in
> cache_reap(), or change cache_reap() to evaluate numa_node_id() just the
> once, and cache that in a local variable.

drain_array_cache_locked calls check_spinlock_acquired_node which is in 
turn insuring that interrupts are off. So no move to a different processor 
should be possible.

However, that is contradicted by __wake_up calling 
drain_array_cache_locked. The process just woke up?

> I wonder why numa_node_id() uses raw_smp_processor_id()?  That's just
> asking for preempt non-atomicity bugs.

Accessing arrays indexed by node number even works if the process 
continues to be executed on another node.

