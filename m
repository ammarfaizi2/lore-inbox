Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311634AbSCNOy5>; Thu, 14 Mar 2002 09:54:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311636AbSCNOyr>; Thu, 14 Mar 2002 09:54:47 -0500
Received: from artemis.rus.uni-stuttgart.de ([129.69.1.28]:32689 "EHLO
	artemis.rus.uni-stuttgart.de") by vger.kernel.org with ESMTP
	id <S311633AbSCNOyg>; Thu, 14 Mar 2002 09:54:36 -0500
Date: Thu, 14 Mar 2002 15:54:12 +0100 (MET)
From: Erich Focht <focht@ess.nec.de>
To: Jesse Barnes <jbarnes@sgi.com>
cc: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Node affine NUMA scheduler
In-Reply-To: <20020314025818.GA136486@sgi.com>
Message-ID: <Pine.LNX.4.21.0203141459260.12844-100000@sx6.ess.nec.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse,

thanks for running the tests. Actually "hackbench" is a bad example for
the node affinity (though it's a good test for heavy scheduling). The code
forks but doesn't exec and therefore all hackbench tasks have the same
homenode. Also the tasks are not particularly memory bandwidth or latency
hungry, therefore node affinity won't speed them up. I'm actually glad
that they aren't slower, that shows that the additional overhead is small.

Initial balancing is still not well solved, I think we'll need some sort
of (inheritable) policy which should decide whether we want to balance at
fork or exec time or not at all. For example: when running a multithreaded
job with threads sharing the same address space it often makes sense to
share the same homenode. But for huge OpenMP jobs having almost local
memory access and using some first-touch memory allocation, it would make
more sense to distribute the threads across the nodes. The current
approach (initial balancing in do_exec) is more useful for MPI jobs or for
machines running with overcommitted CPUs.

Thanks for sending the macros for SGI_SN1/2, I'll include them. You
probably use the DISCONTIGMEM patch, for that I append a small patch which
"couples" DISCONTIGEMEM with the node affine scheduler such that pages
will be allocated on the node current->node instead of the node on which
the task is currently running. Hackbench might slow down a bit but
AIM7 should improve.

Regards,
Erich


--- 2.4.17-ia64-kdbv2.1-atlas/include/linux/mm.h.~1~	Thu Mar 14 12:05:15 2002
+++ 2.4.17-ia64-kdbv2.1-atlas/include/linux/mm.h	Thu Mar 14 12:23:46 2002
@@ -368,7 +368,7 @@
 	if (order >= MAX_ORDER)
 		return NULL;
 	return __alloc_pages(gfp_mask, order,
-			NODE_DATA(numa_node_id())->node_zonelists + (gfp_mask & GFP_ZONEMASK) );
+			NODE_DATA(current->node)->node_zonelists + (gfp_mask & GFP_ZONEMASK) );
 }
 
 #define alloc_page(gfp_mask) alloc_pages(gfp_mask, 0)

