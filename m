Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262327AbTK1OyP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 09:54:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbTK1OyP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 09:54:15 -0500
Received: from tolkor.sgi.com ([198.149.18.6]:7647 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id S262327AbTK1OyK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 09:54:10 -0500
Date: Fri, 28 Nov 2003 08:52:55 -0600
From: Jack Steiner <steiner@sgi.com>
To: Jes Sorensen <jes@wildopensource.com>
Cc: Andrew Morton <akpm@osdl.org>, Jesse Barnes <jbarnes@sgi.com>,
       viro@math.psu.edu, wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: Re: hash table sizes
Message-ID: <20031128145255.GA26853@sgi.com>
References: <16323.23221.835676.999857@gargle.gargle.HOWL> <20031125204814.GA19397@sgi.com> <20031125130741.108bf57c.akpm@osdl.org> <20031125211424.GA32636@sgi.com> <20031125132439.3c3254ff.akpm@osdl.org> <yq0d6bcmvfd.fsf@wildopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq0d6bcmvfd.fsf@wildopensource.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 28, 2003 at 09:15:02AM -0500, Jes Sorensen wrote:
> >>>>> "Andrew" == Andrew Morton <akpm@osdl.org> writes:
> 
> Andrew> jbarnes@sgi.com (Jesse Barnes) wrote:
> >> Something like that might be ok, but on our system, all memory is
> >> in ZONE_DMA...
> 
> Andrew> Well yes, we'd want
> 
> Andrew> 	vfs_caches_init(min(num_physpages,
> Andrew> some_platform_limit()));
> 
> Andrew> which on ia32 would evaluate to nr_free_buffer_pages() and on
> Andrew> ia64 would evaluate to the size of one of those zones.
> 
> What about something like this? I believe node_present_pages should be
> the same as nym_physpages on a non-NUMA machine. If not we can make it
> min(num_physpages, NODE_DATA(0)->node_present_pages).


I may be missing something but I dont see how this fixes the original
problem that we started with.

The system has a large number of nodes. Physically, each node has the same 
amount of memory.  After boot, we observe that several nodes have 
substantially less memory than other nodes. Some of the inbalance is
due to the kernel data/text being on node 0, but by far, the major source 
of in the inbalance is the 3 (in 2.4.x) large hash tables that are being 
allocated. 

I suspect the size of the hash tables is a lot bigger than is needed. 
That is certainly the first problem to be fixed, but unless the 
required size is a very small percentage (5-10%) of the amount of memory 
on a node (2GB to 32GB per node & 256 nodes), we still have a problem.

We run large MPI applications that place threads onto each node. Each
thread needs the same amount of local memory. The maximum problem size 
that can be efficiently solved is limited by the amount of free memory 
on the smallest node. We need an allocation scheme that doesn't deplete
a significant amount of memory from any single node.



> 
> Of course this might not work perfectly if one has multiple nodes and
> node 0 has no or very little memory. It would also be nice if one
> could spread the various caches onto various nodes, but we can leave
> that for stage 2 ;-)
> 
> Cheers,
> Jes
> 
> --- orig/linux-2.6.0-test10/init/main.c	Sun Nov 23 17:31:14 2003
> +++ linux-2.6.0-test10/init/main.c	Fri Nov 28 07:06:45 2003
> @@ -447,7 +447,7 @@
>  	proc_caches_init();
>  	buffer_init();
>  	security_scaffolding_startup();
> -	vfs_caches_init(num_physpages);
> +	vfs_caches_init(NODE_DATA(0)->node_present_pages);
>  	radix_tree_init();
>  	signals_init();
>  	/* rootfs populating might need page-writeback */

-- 
Thanks

Jack Steiner (steiner@sgi.com)          651-683-5302
Principal Engineer                      SGI - Silicon Graphics, Inc.


