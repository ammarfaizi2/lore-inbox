Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266124AbUHMQU2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266124AbUHMQU2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 12:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266147AbUHMQU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 12:20:28 -0400
Received: from jade.spiritone.com ([216.99.193.136]:6102 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S266124AbUHMQUX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 12:20:23 -0400
Date: Fri, 13 Aug 2004 09:20:11 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org, steiner@sgi.com
Subject: Re: [PATCH] allocate page caches pages in round robin fasion
Message-ID: <89760000.1092414010@[10.10.2.4]>
In-Reply-To: <200408130859.24637.jbarnes@engr.sgi.com>
References: <200408121646.50740.jbarnes@engr.sgi.com> <84960000.1092408633@[10.10.2.4]> <200408130859.24637.jbarnes@engr.sgi.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I really don't think this is a good idea - you're assuming there's really
>> no locality of reference, which I don't think is at all true in most cases.
> 
> No, not at all, just that locality of reference matters more for stack and 
> anonymous pages than it does for page cache pages.  I.e. we don't want a node 
> to be filled up with page cache pages causing all other memory references 
> from the process to be off node.

Does that actually happen though? Looking at the current code makes me think
it'll keep some pages free on all nodes at all times, and if kswapd does
it's job, we'll never fall back across nodes. Now ... I think that's broken,
but I think that's what currently happens - that was what we discussed at
KS ... I might be misreading it though, I should test it.

Even if that's not true, allocating all your most recent stuff off-node is
still crap (so either way, I'd agree the current situation is broken), but
I don't think the solution is to push ALL your accesses (with n-1/n probability)
off-node ... we need to be more careful than that ...
 
>> If we round-robin it ... surely 7/8 of your data (on your 8 node machine)
>> will ALWAYS be off-node ? I thought we discussed this at KS/OLS - what is
>> needed is to punt old pages back off onto another node, rather than
>> swapping them out. That way all your pages are going to be local.
> 
> That gets complicated pretty quickly I think.  We don't want to constantly 
> shuffle pages between nodes with kswapd, and there's also the problem of 
> deciding when to do it.

When the other zone is above the high watermark (or even some newer watermark,
ie it has lots of free pages). If we have any sort of locality of reference,
we want the most recently used pages on-node, and less recently ones off-node,
and then the least-recently used on disk.
 
>> OK, so it obviously does something ... but is the dd actually faster?
>> I'd think it's slower ...
> 
> Sure, it's probably a tiny bit slower, but assume that dd actually had some 
> compute work to do after it read in a file (like an encoder or fp app), w/o 
> the patch, most of it's time critical references would be off node.  The 
> important thing is to get the file data in memory, since that'll be way 
> faster than reading from disk, but it doesn't really matter *where* it is in 
> memory.  Especially since we want an app's code and data to be node local.

Not sure I'd agree with that - it's the same problem as swappiness on a global
basis for non-NUMA machines. We want the pages we're using MOST to be local,
the others to be not-local, and that doesn't equate (necessarily) to whether
it's pagecache or not. Shared pages could indeed be dealt with differently,
and spread more global ... but I don't agree that pagecache pages equate 1-1
with being globally shared - in fact, I think most often the opposite is true.

So when we're making such decisions, we need to consider the usage of a page
in more careful of a way than whether it's pagecache or not. page->mapcount
would be a better start, I think, than simply pagecache or not. Spreading
pagecache around will just make the most common case slower, I think.

I understand the desire to make node mem pressures equalize somewhat - having
dynamically altered fallback schemes for NUMA nodes to the node with the
most free mem, etc would help ... but we need to be really careful what
we keep local, and what we push remote. Most apps seem to have fairly
good locality

M.

PS. The obvious exceptions to these rules are shmem and shared libs ... 
shmem should probably go round-robin amongst its users nodes by default,
and shared libs replicate ... I'll look at fixing up shmem at least.
