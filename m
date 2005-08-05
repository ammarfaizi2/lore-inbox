Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262839AbVHERsP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262839AbVHERsP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 13:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262827AbVHERsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 13:48:15 -0400
Received: from amdext4.amd.com ([163.181.251.6]:24802 "EHLO amdext4.amd.com")
	by vger.kernel.org with ESMTP id S263046AbVHERsN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 13:48:13 -0400
X-Server-Uuid: 8C3DB987-180B-4465-9446-45C15473FD3E
From: "Ray Bryant" <raybry@mpdtxmail.amd.com>
To: "Andi Kleen" <ak@suse.de>
Subject: Re: [PATCH] VM: add vm.free_node_memory sysctl
Date: Fri, 5 Aug 2005 12:45:58 -0500
User-Agent: KMail/1.8
cc: "Martin Hicks" <mort@sgi.com>, "Ingo Molnar" <mingo@elte.hu>,
       "Linux MM" <linux-mm@kvack.org>, "Andrew Morton" <akpm@osdl.org>,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
References: <20050801113913.GA7000@elte.hu>
 <200508031459.22834.raybry@mpdtxmail.amd.com>
 <20050803200808.GE8266@wotan.suse.de>
In-Reply-To: <20050803200808.GE8266@wotan.suse.de>
MIME-Version: 1.0
Message-ID: <200508051245.59528.raybry@mpdtxmail.amd.com>
X-WSS-ID: 6EED79811UW7642043-01-01
Content-Disposition: inline
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 August 2005 15:08, Andi Kleen wrote:

> >
> > Hmmm.... What happens if there are already mapped pages (e. g. mapped in
> > the sense that pages are mapped into an address space) on the node and
> > you want to allocate some more, but can't because the node is full of
> > clean page cache pages?   Then one would have to set the memhog argument
> > to the right thing to
>

> If you have a bind policy in the memory grabbing program then the standard
> try_to_free_pages should DTRT. That is because we generated a custom zone
> list only containing nodes in that zone and the zone reclaim only looks
> into those.
>

It may depend on what your definition of DTRT is here.  :-)

As I understand things, if we have a node that has some mapped memory 
allocated, and if one starts up a numactl -bind node memhog nodesize-slop so 
as to clear some clean page cache pages from that node, then unless the 
"slop" is sized in proportion to the amount of mapped memory used on the 
node, then the existing mapped memory will get swapped out in order to 
satisfy the new request.  In addition, clean page-cache pages will get 
discarded.  I think what Martin and I would prefer to see is an interface 
that allows one to just get rid of the clean page cache (or at least enough 
of it) so that additional mapped page allocations will occur locally to the 
node without causing swapping.

AFAIK, the number of mapped pages on the node is not exported to user space 
(by, for example, /sys).   So there is no good way to size the "slop" to 
allow for an existing allocation.  If there was, then using a bound memory 
hog would likely be a reasonable replacement for Martin's syscall to release 
all free page cache, at least for small to medium sized sized systems.

> With prefered or other policies it's different though, in that cases
> t_t_f_p will also look into other nodes because the policy is not binding.
>
> That said it might be probably possible to even make non bind policies more
> aggressive at freeing in the current node before looking into other nodes.
> I think the zone balancing has been mostly tuned on non NUMA systems, so
> some improvements might be possible here.
>
> Most people don't use BIND and changing the default policies like this
> might give NUMA systems a better "out of the box" experience.  However this
> memory balance is very subtle code and easy to break, so this would need
> some care.
>

Of course!

> I don't think sysctls or new syscalls are the way to go here though.
>

The reason we ended up with a sysctl/syscall (to control the aggressiveness 
with which __alloc_pages will try to free page cache before spilling) is that 
deciding whether or not  to spend the effort to free up page cache pages on 
the local node before  spilling is a workload dependent optimization.   For 
an HPC application it is  typically worth the effort to try to free local 
node page cache before spilling off node because the program will run 
sufficiently long to make the improvement due to getting local storage 
dominates the extra cost of doing the page allocation.   For file server 
workloads, for example, it is typically important to minimize the time to do 
the page allocation; if it turns out to be on a remote node it really doesn't 
matter that much.   So it seems to me that we need some way for the 
application to tell the system which approach it prefers based on the type of 
workload it is -- hence the sysctl or syscall approach.

> -Andi

-- 
Ray Bryant
AMD Performance Labs                   Austin, Tx
512-602-0038 (o)                 512-507-7807 (c)

