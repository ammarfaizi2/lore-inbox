Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268270AbUJOST7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268270AbUJOST7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 14:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268268AbUJOST7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 14:19:59 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:23179 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268270AbUJOSTW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 14:19:22 -0400
Subject: Re: [PATCH] reduce fragmentation due to kmem_cache_alloc_node
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-mm@kvack.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41684BF3.5070108@colorfullife.com>
References: <41684BF3.5070108@colorfullife.com>
Content-Type: text/plain
Organization: 
Message-Id: <1097863727.2861.43.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 15 Oct 2004 11:08:48 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred & Andrew,

I am happy with the patch.This seems to have fixed slab fragmentation
problem with scsi_debug tests.

But I still have issue with my scsi-debug tests. I don't think they
are related to this patch. When I do,

	while :
	do
		simulate 1000 scsi-debug disks
		freeup 1000 scsi-debug disks
	done

I see size-64 "inuse" objects increasing. Eventually, it fills
up entire low-mem. I guess while freeing up scsi-debug disks,
is not cleaning up all the allocations :(

But one question I have is - Is it possible to hold size-64 slab,
because it has a management allocation (slabp - 40 byte allocations)
from alloc_slabmgmt() ?  I remember seeing this earlier. Is it worth
moving all managment allocations to its own slab ? should I try it ?

Thanks,
Badari

On Sat, 2004-10-09 at 13:37, Manfred Spraul wrote:
> Hi Andrew,
> 
> attached is a patch that fixes the fragmentation that Badri noticed with 
> kmem_cache_alloc_node. Could you add it to the mm tree? The patch is 
> against 2.6.9-rc3-mm3.
> 
> Description:
> kmem_cache_alloc_node tries to allocate memory from a given node. The 
> current implementation contains two bugs:
> - the node aware code was used even for !CONFIG_NUMA systems. Fix: 
> inline function that redefines kmem_cache_alloc_node as kmem_cache_alloc 
> for !CONFIG_NUMA.
> - the code always allocated a new slab for each new allocation. This 
> caused severe fragmentation. Fix: walk the slabp lists and search for a 
> matching page instead of allocating a new page.
> - the patch also adds a new statistics field for node-local allocs. They 
> should be rare - the codepath is quite slow, especially compared to the 
> normal kmem_cache_alloc.
> 
> Badri: Could you test it?
> Andrew, could you add the patch to the next -mm kernel? I'm running it 
> right now, no obvious problems.
> 
> Signed-Off-By: Manfred Spraul <manfred@colorfullife.com>


