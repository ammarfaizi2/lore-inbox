Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932078AbWBWRij@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbWBWRij (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 12:38:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932288AbWBWRij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 12:38:39 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:62342 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932078AbWBWRii
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 12:38:38 -0500
Subject: Re: [PATCH 4/7] ppc64 - Specify amount of kernel memory at boot
	time
From: Dave Hansen <haveblue@us.ibm.com>
To: Mel Gorman <mel@csn.ul.ie>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms-devel@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.64.0602231646530.24093@skynet.skynet.ie>
References: <20060217141552.7621.74444.sendpatchset@skynet.csn.ul.ie>
	 <20060217141712.7621.49906.sendpatchset@skynet.csn.ul.ie>
	 <1140196618.21383.112.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0602211445160.4335@skynet.skynet.ie>
	 <1140543359.8693.32.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0602221625100.2801@skynet.skynet.ie>
	 <1140712969.8697.33.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0602231646530.24093@skynet.skynet.ie>
Content-Type: text/plain
Date: Thu, 23 Feb 2006 09:38:24 -0800
Message-Id: <1140716304.8697.53.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-02-23 at 17:19 +0000, Mel Gorman wrote:
> On Thu, 23 Feb 2006, Dave Hansen wrote:
> >> +/* Initialise the size of each zone in a node */
> >> +void __init zone_sizes_init(unsigned int nid,
> >> +		unsigned long kernelcore_pages,
> >> +		unsigned long *zones_size)
> >
> > Minor nit territory: set_zone_sizes(), maybe?
> >
> 
> In this case, the choice of name is to match an x86 function that does 
> something very similar. If one had read through the x86 code and then saw 
> this function, it would set their expectations of what the code is 
> intended to do.

x86 is bad.  Try to do better. :)

> per-node. A node goes no ZONE_EASYRCLM pages if it is not large enough to 
> contain kernelcore_pages. That means that on a system with 2 nodes, 
> kernelcore=512MB will results in 1024MB of ZONE_DMA in total.
> 
> > Also, how do we want to distribute kernelcore memory over each node?
> > The way it is coded up for now, it will all be sliced out of the first
> > node.  I'm not sure that's a good thing.
> 
> It gets set in every node.

They hypervisor has a memory allocator which it uses to piece out memory
to various LPARs.  When things like partition memory resizing or reboots
occur, that memory gets allocated and freed and so forth.

These machines are _also_ NUMA.  Memory can effectively get lumped so
that you can't always get memory on a single NUMA node.  Because of all
of the other actions of other partitions, these conditions are always
changing.  The end result is that the amount of memory which each NUMA
node has *in* *a* *single* *partition* can theoretically change between
reboots.

OK, back to the hapless system admin using kernelcore.  They have a
4-node system with 2GB of RAM in each node for 8GB total.  They use
kernelcore=1GB.  They end up with 4x1GB ZONE_DMA and 4x1GB
ZONE_EASYRCLM.  Perfect.  You can safely remove 4GB of RAM.

Now, imagine that the machine has been heavily used for a while, there
is only 1 node's memory available, but CPUs are available in the same
places as before.  So, you start up your partition again have 8GB of
memory in one node.  Same kernelcore=1GB option.  You get 1x7GB ZONE_DMA
and 1x1GB ZONE_EASYRCLM.  I'd argue this is going to be a bit of a
surprise to the poor admin.

> zones_size[] is what free_area_init() expects to receive so there is not a 
> lot of room to fiddle with it's meaning without causing more trouble.

It is just passed in there as an argument.  If you can think of a way to
make it more understandable, change it in your architecture, and send
the patch for the main one.

> > One other thing, I want to _know_ that variables being compared are in
> > the same units.  When one is called "pages_" something and the other is
> > something "_size", I don't _know_.
> 
> chunk_num_pages ?

No. :)  The words "chunks" and "clumps" have a bit of a stigma, just
like the number "3".  Ask Matt Dobson.

num_pages_WHAT?  node_num_pages?  silly_num_pages?

Chunk is pretty meaningless.

> yep. get_zholes_size() could be split into two functions 
> find_start_easyrclm_pfn() and get_nid_zholes_size(). Would that be pretty 
> clear-cut?

I think so.

-- Dave

