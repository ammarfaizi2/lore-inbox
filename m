Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266291AbUHMRaY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266291AbUHMRaY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 13:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266284AbUHMRaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 13:30:24 -0400
Received: from omx2-ext.SGI.COM ([192.48.171.19]:27044 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S266291AbUHMR3X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 13:29:23 -0400
Message-ID: <411CFAE6.1010109@sgi.com>
Date: Fri, 13 Aug 2004 12:31:18 -0500
From: Ray Bryant <raybry@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
Newsgroups: fa.linux.kernel
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: Jesse Barnes <jbarnes@engr.sgi.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, steiner@sgi.com
Subject: Re: [PATCH] allocate page caches pages in round robin fasion
References: <fa.hmrqqf6.ckie1e@ifi.uio.no> <fa.cg3cafa.ngi9og@ifi.uio.no>
In-Reply-To: <fa.cg3cafa.ngi9og@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

Martin J. Bligh wrote:
<snip>

> 
> Does that actually happen though? Looking at the current code makes me think
> it'll keep some pages free on all nodes at all times, and if kswapd does
> it's job, we'll never fall back across nodes. Now ... I think that's broken,
> but I think that's what currently happens - that was what we discussed at
> KS ... I might be misreading it though, I should test it.
> 
> Even if that's not true, allocating all your most recent stuff off-node is
> still crap (so either way, I'd agree the current situation is broken), but
> I don't think the solution is to push ALL your accesses (with n-1/n probability)
> off-node ... we need to be more careful than that ...
>

I think you're missing out on the typical workload situation where we run into 
this problem.  Just to make things a bit more specific, lets assume we are on 
a 128 node (256 P) system, with 4 GB per node.  Let's assume that we have a 
100 GB data file that we access periodically during the run, accesses to that 
data file are done in random access fashion from each node.

The program starts out by reading in the data file, then forks off 256 copies 
of itself, and allocates 1 GB per CPU of local storage via MPOL_DEFAULT.  All 
of those pages had better be in local or the computation will be unbalanced 
and run as slowly as the slowest node.

As I read the __alloc_pages() code, those 100 GB of data pages will be 
allocated on the node that did the file read; when that node fills up, we will 
spill the allocation to adjacent nodes (this is the first loop of 
__alloc_pages(), kswapd doesn't get invoked until that first loop fails).

(kswapd() doesn't get invoked until all of the zones in the zonelist are full.
All of memory is in that zonelist, unless we have cpusets enabled. So the 
priority is to spill off node first and then swap() second.)

Now the application starts allocating its 2 GB of local, and the nodes where 
the page cache was allocated all get non-local pages allocated.  (Once again, 
this happens in the first loop of __alloc_pages().)  The ratio of accesses to 
local data pages versus access to remote page cache pages is unfavorable for 
local page cache allocation, since the page cache pages are accessed at a tiny 
fraction of the rate of the data pages.

Now I suppose you could argue that the application should fork first and then 
read in 1/256th of the data on each cpu.  The problems with this, in general, 
are twofold:

(1)  It could have been a simple "cp" in a startup script that did the read..
      We can't fix all of those things as well.
(2)  The application may be an ISV's program that is not NUMA aware.  We can
      fix most of that by wrappering the program with control scripts, but
      requiring the ISV to build a specific NUMA aware version of the binary
      for Altix is oftentimes not feasible.  (And because the allocation
      policy is MPOL_DEFAULT, the application doesn't have to have NUMA API
      calls imbedded in the program.)

> 
>>>If we round-robin it ... surely 7/8 of your data (on your 8 node machine)
>>>will ALWAYS be off-node ? I thought we discussed this at KS/OLS - what is
>>>needed is to punt old pages back off onto another node, rather than
>>>swapping them out. That way all your pages are going to be local.
>>

Surely you can't be suggesting that I migrate a page cache page to a local 
node just to read it?  If file accesses are random and global, won't you end 
up just bouncing page cache pages hither and yon?  Surely it is better just to 
copy the data remotely to the current node and leave it where it is?

(YMMV -- all of these tradeoffs are clearly workload dependent.)

>>That gets complicated pretty quickly I think.  We don't want to constantly 
>>shuffle pages between nodes with kswapd, and there's also the problem of 
>>deciding when to do it.

