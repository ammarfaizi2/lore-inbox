Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932356AbVKFLAU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356AbVKFLAU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 06:00:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932355AbVKFLAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 06:00:20 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:26818 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932356AbVKFLAT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 06:00:19 -0500
Date: Sun, 6 Nov 2005 02:59:47 -0800
From: Paul Jackson <pj@sgi.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: andy@thermo.lanl.gov, mingo@elte.hu, akpm@osdl.org, arjan@infradead.org,
       arjanv@infradead.org, haveblue@us.ibm.com, kravetz@us.ibm.com,
       lhms-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, mbligh@mbligh.org, mel@csn.ul.ie,
       nickpiggin@yahoo.com.au
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Message-Id: <20051106025947.2c84d5dd.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.64.0511041310130.28804@g5.osdl.org>
References: <20051104210418.BC56F184739@thermo.lanl.gov>
	<Pine.LNX.4.64.0511041310130.28804@g5.osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How would this hugetlb zone be placed - on which nodes in a NUMA
system?

My understanding is that you are thinking to specify it as a proportion
or amount of total memory, with no particular placement.

I'd rather see it as a subset of the nodes on a system being marked
for use, as much as practical, for easily reclaimed memory (page
cache and user).

My HPC customers normally try to isolate the 'classic Unix load' on
a few nodes that they call the bootcpuset, and keep the other nodes
as unused as practical, except when allocated for dedicated use by a
particular job.  These other nodes need to run with a maximum amount of
easily reclaimed memory, while the bootcpuset nodes have no such need.

They don't just want easily reclaimable memory in order to get
hugetlb pages.  They also want it so that the memory available for
use as ordinary sized pages by one job will not be unduly reduced by
the hard to reclaim pages left over from some previous job.

This would be easy to do with cpusets, adding a second per-cpuset
nodemask that specified where not easily reclaimed kernel allocations
should come from.  The typical HPC user would set that second mask to
their bootcpuset.  The few kmalloc calls in the kernel (page cache and
user space) deemed to be easily reclaimable would have a __GFP_EASYRCLM
flag added, and the cpuset hook in the __alloc_pages code path would
put requests -not- marked __GFP_EASYRCLM on this second set of nodes.

No changes to hugetlbs or to the kernel code that runs at boot,
prior to starting init, would be required at all.  The bootcpuset
stuff is setup by a pre-init program (specified using the kernels
"init=..." boot option.)  This makes all the configuration of this
entirely a user space problem.

Cpuset nodes, not zone sizes, are the proper way to manage this,
in my view.

If you ask what this means for small (1 or 2 node) systems, then
I would first ask you what we are trying to do on those systems.
I suspect that that would involve other classes of users, with
different needs, than what Andy or I can speak to.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
