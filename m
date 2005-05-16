Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261798AbVEPSPR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261798AbVEPSPR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 14:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261781AbVEPSOv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 14:14:51 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:23233 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261780AbVEPSMo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 14:12:44 -0400
Subject: Re: NUMA aware slab allocator V3
From: Dave Hansen <haveblue@us.ibm.com>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       shai@scalex86.org, steiner@sgi.com
In-Reply-To: <Pine.LNX.4.62.0505161046430.1653@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0505110816020.22655@schroedinger.engr.sgi.com>
	 <20050512000444.641f44a9.akpm@osdl.org>
	 <Pine.LNX.4.58.0505121252390.32276@schroedinger.engr.sgi.com>
	 <20050513000648.7d341710.akpm@osdl.org>
	 <Pine.LNX.4.58.0505130411300.4500@schroedinger.engr.sgi.com>
	 <20050513043311.7961e694.akpm@osdl.org>
	 <Pine.LNX.4.62.0505131823210.12315@schroedinger.engr.sgi.com>
	 <1116251568.1005.29.camel@localhost>
	 <Pine.LNX.4.62.0505160943140.1330@schroedinger.engr.sgi.com>
	 <1116264135.1005.73.camel@localhost>
	 <Pine.LNX.4.62.0505161046430.1653@schroedinger.engr.sgi.com>
Content-Type: text/plain
Date: Mon, 16 May 2005 11:12:29 -0700
Message-Id: <1116267149.1005.85.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-05-16 at 10:54 -0700, Christoph Lameter wrote:
> > Remember, as you saw, you can't assume that MAX_NUMNODES=1 when NUMA=n
> > because of the DISCONTIG=y case.
> 
> I have never seen such a machine. A SMP machine with multiple 
> "nodes"?

Yes.  "discontigmem nodes" 

> So essentially one NUMA node has multiple discontig "nodes"?

Yes, in theory.

A discontig node is just a contiguous area of physical memory.

> This means that the concept of a node suddenly changes if there is just 
> one numa node(CONFIG_NUMA off implies one numa node)? 

Correct as well.

> > So, in summary, if you want to do it right: use the
> > CONFIG_NEED_MULTIPLE_NODES that you see in -mm.  As plain DISCONTIG=y
> > gets replaced by sparsemem any code using this is likely to stay
> > working.
> 
> s/CONFIG_NUMA/CONFIG_NEED_MULTIPLE_NODES?
> 
> That will not work because the idea is the localize the slabs to each 
> node. 
> 
> If there are multiple nodes per numa node then invariable one node in the 
> numa node (sorry for this duplication of what node means but I did not 
> do it) must be preferred since numa_node_id() does not return a set of 
> discontig nodes.

I know it's confusing.  I feel your pain :)

You're right, I think you completely want CONFIG_NUMA, not
NEED_MULTIPLE_NODES.  So, toss out that #ifdef, and everything should be
in pretty good shape.  Just don't make any assumptions about how many
'struct zone' or 'pg_data_t's a single "node's" pages can come from.

Although it doesn't help your issue, you may want to read the comments
in here, I wrote it when my brain was twisting around the same issues:

http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc4/2.6.12-rc4-mm2/broken-out/introduce-new-kconfig-option-for-numa-or-discontig.patch

> Sorry but this all sounds like an flaw in the design. There is no 
> consistent notion of node.

It's not really a flaw in the design, it's a misinterpretation of the
original design as new architectures implemented things.  I hope to
completely ditch DISCONTIGMEM, eventually.

> Are you sure that this is not a ppc64 screwup?

Yeah, ppc64 is not at fault, it just provides the most obvious exposure
of the issue.

-- Dave

