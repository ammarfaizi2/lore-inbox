Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261790AbVEPSLa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261790AbVEPSLa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 14:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261783AbVEPSLS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 14:11:18 -0400
Received: from dvhart.com ([64.146.134.43]:50593 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S261786AbVEPSIk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 14:08:40 -0400
Date: Mon, 16 May 2005 11:08:35 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Christoph Lameter <clameter@engr.sgi.com>,
       Dave Hansen <haveblue@us.ibm.com>, Andy Whitcroft <apw@shadowen.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       shai@scalex86.org, steiner@sgi.com
Subject: Re: NUMA aware slab allocator V3
Message-ID: <714210000.1116266915@flay>
In-Reply-To: <Pine.LNX.4.62.0505161046430.1653@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0505110816020.22655@schroedinger.engr.sgi.com> <20050512000444.641f44a9.akpm@osdl.org>  <Pine.LNX.4.58.0505121252390.32276@schroedinger.engr.sgi.com> <20050513000648.7d341710.akpm@osdl.org>  <Pine.LNX.4.58.0505130411300.4500@schroedinger.engr.sgi.com> <20050513043311.7961e694.akpm@osdl.org>  <Pine.LNX.4.62.0505131823210.12315@schroedinger.engr.sgi.com> <1116251568.1005.29.camel@localhost>  <Pine.LNX.4.62.0505160943140.1330@schroedinger.engr.sgi.com><1116264135.1005.73.camel@localhost> <Pine.LNX.4.62.0505161046430.1653@schroedinger.engr.sgi.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > How do the concepts of numa node id relate to discontig node ids?
>> 
>> I believe there are quite a few assumptions on some architectures that,
>> when NUMA is on, they are equivalent.  It appears to be pretty much
>> assumed everywhere that CONFIG_NUMA=y means one pg_data_t per NUMA node.
> 
> Ah. That sounds much better.
> 
>> Remember, as you saw, you can't assume that MAX_NUMNODES=1 when NUMA=n
>> because of the DISCONTIG=y case.
> 
> I have never seen such a machine. A SMP machine with multiple 
> "nodes"? So essentially one NUMA node has multiple discontig "nodes"?

I believe you (SGI) make one ;-) Anywhere where you have large gaps in
the physical address range within a node, this is what you really need.
Except ia64 has this wierd virtual mem_map thing that can go away once
we have sparsemem.

> This means that the concept of a node suddenly changes if there is just 
> one numa node(CONFIG_NUMA off implies one numa node)? 

The end point of where we're getting to is 1 node = 1 pgdat (which we can
then rename to struct node or something). All this confusing mess of 
config options is just a migration path, which I'll leave it to Andy to
explain ;-)

> s/CONFIG_NUMA/CONFIG_NEED_MULTIPLE_NODES?
> 
> That will not work because the idea is the localize the slabs to each 
> node. 
> 
> If there are multiple nodes per numa node then invariable one node in the 
> numa node (sorry for this duplication of what node means but I did not 
> do it) must be preferred since numa_node_id() does not return a set of 
> discontig nodes.
>  
> Sorry but this all sounds like an flaw in the design. There is no 
> consistent notion of node. Are you sure that this is not a ppc64 screwup?

No, it's a discontigmem screwup. Currently a pgdat represents 2 different
scenarios: 

(1) physically discontiguous memory chunk.
(2) a NUMA node.

I don't think we support both at the same time with the old code. So it
seems to me like your numa aware slab code (which I'm still intending to
go read, but haven't yet) is only interested in real nodes. Logically
speaking, that would be CONFIG_NUMA. The current transition config options
are a bit of a mess ... Andy, I presume CONFIG_NEED_MULTIPLE_NODES is
really CONFIG_NEED_MULTIPLE_PGDATS ?

M.
