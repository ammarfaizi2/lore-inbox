Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266181AbUHMQce@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266181AbUHMQce (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 12:32:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266200AbUHMQce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 12:32:34 -0400
Received: from omx2-ext.SGI.COM ([192.48.171.19]:16770 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S266181AbUHMQca (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 12:32:30 -0400
Message-ID: <411CED72.9090307@sgi.com>
Date: Fri, 13 Aug 2004 11:33:54 -0500
From: Ray Bryant <raybry@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
Newsgroups: fa.linux.kernel
To: Dave Hansen <haveblue@us.ibm.com>
CC: Jesse Barnes <jbarnes@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       steiner@sgi.com
Subject: Re: [PATCH] allocate page caches pages in round robin fasion
References: <fa.hmbmqn2.d4ef9c@ifi.uio.no> <fa.g1i2d5e.1kgqq80@ifi.uio.no>
In-Reply-To: <fa.g1i2d5e.1kgqq80@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Dave Hansen wrote:
> On Thu, 2004-08-12 at 16:38, Jesse Barnes wrote:
> 
>>On a NUMA machine, page cache pages should be spread out across the system 
>>since they're generally global in nature and can eat up whole nodes worth of 
>>memory otherwise.  This can end up hurting performance since jobs will have 
>>to make off node references for much or all of their non-file data.
> 
> 
> Wouldn't this be painful for any workload that accesses a unique set of
> files on each node?  If an application knows that it is touching truly
> shared data which every node could possibly access, then they can use
> the NUMA API to cause round-robin allocations to occur.  
> 

I suppose it is possible for some workloads to be able to tell the difference 
between a locally and globally allocated page cache page.  It all depends on 
the rate of access of data pages versus page cache pages.

For workloads that read in some data, then process that data for a very long 
time (e. g. typical HPC workloads), it is more important to make sure those 
data pages are allocated locally, and the page cache pages are touched much 
less frequently, so making them globally round-robin'd is a marginal 
performance hit.  The problem we are trying to avoid here is to make sure the 
node doesn't fill up with page cache pages, resulting in non-local allocations 
for those data pages, which is not a good thing [tm].

On the other hand, if your workload spends most of its time writing buffered 
file I/O to a set of pages that will comfotably fit on node, then it is 
important to have the page cache pages allocated locally.  So I can see the 
need for some program control of placement.

However, using the NUMA API to cause round-robin allocations to occur would 
use the process level policy, right?  So the same decision will be made on how 
to allocate data pages and page cache pages?  Might it not be possible that an 
application would like its page cache pages allocated globally round-robin, 
but it still wants its data pages allocated via MPOL_DEFAULT?

Perhaps what is needed is the ability to associate a mem_policy with the page 
cache allocation (or, perhaps, more generally, a default "kernel storage 
allocation policy" for storage that the kernel allocates on behalf of a 
process).  System admins could set the default according to overall workload 
considerations, and, perhaps, we would allow processes with sufficient 
priviledge to set their own policy.

> Maybe a per-node watermark on page cache usage would be more useful. 
> Once a node starts to get full, and it's past the watermark, we can go
> and shoot down some of the node's page cache.  If the data access is
> truly global, then it has a good chance of being brought in on a
> different node.

I think this could be inefficient if the file access is truly global and the 
file is large.  (Think of a file that is significantly larger than the local 
memory of any node.)  Pages would be pulled into each node in turn as they are 
accessed, then discarded as they go over the watermark, to be pulled in on 
another node, etc.  It would be better in this case just to round robin the 
allocation on first access and be done with it.

> 
> -- Dave
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

