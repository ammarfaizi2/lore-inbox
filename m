Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261171AbUKETOG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261171AbUKETOG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 14:14:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261172AbUKETOD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 14:14:03 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:6537 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261167AbUKETNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 14:13:35 -0500
Date: Fri, 5 Nov 2004 13:13:16 -0600
From: Jack Steiner <steiner@sgi.com>
To: Erich Focht <efocht@hpce.nec.com>
Cc: Takayoshi Kochi <t-kochi@bq.jp.nec.com>, ak@suse.de,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Externalize SLIT table
Message-ID: <20041105191316.GA30434@sgi.com>
References: <20041103205655.GA5084@sgi.com> <20041104.135721.08317994.t-kochi@bq.jp.nec.com> <20041105160808.GA26719@sgi.com> <200411051813.24231.efocht@hpce.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411051813.24231.efocht@hpce.nec.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2004 at 06:13:24PM +0100, Erich Focht wrote:
> Hi Jack,
> 
> the patch looks fine, of course.
> > 	# cat ./node/node0/distance
> > 	10 20 64 42 42 22
> Great!
> 
> But:
> > 	# cat ./cpu/cpu8/distance
> > 	42 42 64 64 22 22 42 42 10 10 20 20
> ...
> 
> what exactly do you mean by cpu_to_cpu distance? In analogy with the
> node distance I'd say it is the time (latency) for moving data from
> the register of one CPU into the register of another CPU:
>         cpu*/distance :   cpu -> memory -> cpu
>                          node1   node?    node2
> 

I'm trying to create an easy-to-use metric for finding sets of cpus that
are close to each other. By "close", I mean that the average offnode
reference from a cpu to remote memory in the set is minimized.

The numbers in cpuN/distance represent the distance from cpu N to 
the memory that is local to each of the other cpus. 

I agree that this can be derived from converting cpuN->node, finding
internode distances, then finding the cpus on each remote node.
The cpu metric is much easier to use. 


> On most architectures this means flushing a cacheline to memory on one
> side and reading it on another side. What you actually implement is
> the latency from memory (one node) to a particular cpu (on some
> node). 
>                        memory ->  cpu
>                        node1     node2

I see how the term can be misleading. The metric is intended to 
represent ONLY the cost of remote access to another processor's local memory.
Is there a better way to describe the cpu-to-remote-cpu's-memory metric OR
should we let users contruct their own matrix from the node data?


> 
> That's only half of the story and actually misleading. I don't
> think the complexity hiding is good in this place. Questions coming to
> my mind are: Where is the memory? Is the SLIT matrix really symmetric
> (cpu_to_cpu distance only makes sense for symmetric matrices)? I
> remember talking to IBM people about hardware where the node distance
> matrix was asymmetric.
> 
> Why do you want this distance anyway? libnuma offers you _node_ masks
> for allocating memory from a particular node. And when you want to
> arrange a complex MPI process structure you'll have to think about
> latency for moving data from one processes buffer to the other
> processes buffer. The buffers live on nodes, not on cpus.

One important use is in the creation of cpusets. The batch scheduler needs 
to pick a subset of cpus that are as close together as possible.


-- 
Thanks

Jack Steiner (steiner@sgi.com)          651-683-5302
Principal Engineer                      SGI - Silicon Graphics, Inc.


