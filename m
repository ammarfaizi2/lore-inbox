Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751453AbWBWRTk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453AbWBWRTk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 12:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751753AbWBWRTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 12:19:40 -0500
Received: from [193.1.99.76] ([193.1.99.76]:44746 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1751453AbWBWRTi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 12:19:38 -0500
Date: Thu, 23 Feb 2006 17:19:19 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet.skynet.ie
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms-devel@lists.sourceforge.net
Subject: Re: [PATCH 4/7] ppc64 - Specify amount of kernel memory at boot time
In-Reply-To: <1140712969.8697.33.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0602231646530.24093@skynet.skynet.ie>
References: <20060217141552.7621.74444.sendpatchset@skynet.csn.ul.ie> 
 <20060217141712.7621.49906.sendpatchset@skynet.csn.ul.ie> 
 <1140196618.21383.112.camel@localhost.localdomain> 
 <Pine.LNX.4.64.0602211445160.4335@skynet.skynet.ie> 
 <1140543359.8693.32.camel@localhost.localdomain> 
 <Pine.LNX.4.64.0602221625100.2801@skynet.skynet.ie>
 <1140712969.8697.33.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Feb 2006, Dave Hansen wrote:

> On Wed, 2006-02-22 at 16:43 +0000, Mel Gorman wrote:
>> Is this a bit clearer? It's built and boot tested on one ppc64 machine. I
>> am having trouble finding a ppc64 machine that *has* memory holes to be
>> 100% sure it's ok.
>
> Yeah, it looks that way.  If you need a machine, see Mike Kravetz.  I
> think he was working on a way to automate creating memory holes.
>

Will do. If there is an automatic way of creating holes, I'll write it 
into the current "compare two running kernels" testing script.

>> diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.16-rc3-mm1-103_x86coremem/arch/powerpc/mm/numa.c linux-2.6.16-rc3-mm1-104_ppc64coremem/arch/powerpc/mm/numa.c
>> --- linux-2.6.16-rc3-mm1-103_x86coremem/arch/powerpc/mm/numa.c	2006-02-16 09:50:42.000000000 +0000
>> +++ linux-2.6.16-rc3-mm1-104_ppc64coremem/arch/powerpc/mm/numa.c	2006-02-22 16:07:35.000000000 +0000
>> @@ -17,10 +17,12 @@
>>   #include <linux/nodemask.h>
>>   #include <linux/cpu.h>
>>   #include <linux/notifier.h>
>> +#include <linux/sort.h>
>>   #include <asm/sparsemem.h>
>>   #include <asm/lmb.h>
>>   #include <asm/system.h>
>>   #include <asm/smp.h>
>> +#include <asm/machdep.h>
>
> Is the email spacing getting screwed up here?
>

Yes, mail client issue. The "real" patch is fine.

>> +/* Initialise the size of each zone in a node */
>> +void __init zone_sizes_init(unsigned int nid,
>> +		unsigned long kernelcore_pages,
>> +		unsigned long *zones_size)
>
> Minor nit territory: set_zone_sizes(), maybe?
>

In this case, the choice of name is to match an x86 function that does 
something very similar. If one had read through the x86 code and then saw 
this function, it would set their expectations of what the code is 
intended to do.

>> +{
>> +	unsigned int i;
>> +	unsigned long pages_present = 0;
>
> pages_present_in_node?
>

That would cause > 80 character violation without a lot of breaking up of 
lines. I think it would end up looking worse.

>> +	/* Get the number of present pages in the node */
>> +	for (i = 0; init_node_data[i].end_pfn; i++) {
>> +		if (init_node_data[i].nid != nid)
>> +			continue;
>> +
>> +		pages_present += init_node_data[i].end_pfn -
>> +			init_node_data[i].start_pfn;
>> +	}
>> +
>> +	if (kernelcore_pages && kernelcore_pages < pages_present) {
>> +		zones_size[ZONE_DMA] = kernelcore_pages;
>> +		zones_size[ZONE_EASYRCLM] = pages_present - kernelcore_pages;
>> +	} else {
>> +		zones_size[ZONE_DMA] = pages_present;
>> +		zones_size[ZONE_EASYRCLM] = 0;
>> +	}
>> +}
>
> I think there are a couple of buglets here.  I think the
> kernelcore_pages is going to be applied per-zone, right?
>

per-node. A node goes no ZONE_EASYRCLM pages if it is not large enough to 
contain kernelcore_pages. That means that on a system with 2 nodes, 
kernelcore=512MB will results in 1024MB of ZONE_DMA in total.

> Also, how do we want to distribute kernelcore memory over each node?
> The way it is coded up for now, it will all be sliced out of the first
> node.  I'm not sure that's a good thing.
>

It gets set in every node.

> My inclination would be to completely separate out the ZONE_EASYRCLM
> into separate code.  It makes it easier to set whatever policy you want
> in one place.  Just a suggestion.
>

It's a possibility. My feeling is that it would be easier to understand 
overall of all the zone-sizing code was in one place.

>> +void __init get_zholes_size(unsigned int nid, unsigned long *zones_size,
>> +		unsigned long *zholes_size) {
>
> nid_zholes_size()?  I'm not too sure about this one.  Just promise me
> you'll think about it a bit more. ;)
>

The choice of names is again to match the name of a equivalent code from 
the x86. I'm not saying it's a great name :)

>> +	unsigned int i = 0;
>> +	unsigned int start_easyrclm_pfn;
>> +	unsigned long last_end_pfn, first;
>> +
>> +	/* Find where the PFN of the end of DMA is */
>> +	unsigned long pages_count = zones_size[ZONE_DMA];
>
> <tangent> This (virtually) proves that zones_size[] needs to get a
> different name.  Perhaps we need to make it more like the zone structure
> itself and go to spanned and present pages? </tangent>
>

zones_size[] is what free_area_init() expects to receive so there is not a 
lot of room to fiddle with it's meaning without causing more trouble.

>> +	for (i = 0; init_node_data[i].end_pfn; i++) {
>> +		unsigned long segment_size;
>> +		if (init_node_data[i].nid != nid)
>> +			continue;
>> +
>> +		/*
>> +		 * Check if the end of ZONE_DMA is in this segment of the
>> +		 * init_node_data
>> +		 */
>> +		segment_size = init_node_data[i].end_pfn -
>> +			init_node_data[i].start_pfn;
>
> "segment" is probably a bad term to use here, especially on ppc.
>

Good point, I forgot that segment has a very different meaning on ppc.

> One other thing, I want to _know_ that variables being compared are in
> the same units.  When one is called "pages_" something and the other is
> something "_size", I don't _know_.
>

chunk_num_pages ?

>> +
>> +	/* Walk the map again and get the size of the holes */
>> +	first = 1;
>> +	zholes_size[ZONE_DMA] = 0;
>> +	zholes_size[ZONE_EASYRCLM] = 0;
>> +	for (i = 1; init_node_data[i].end_pfn; i++) {
>> +		unsigned long hole_size;
>> +		if (init_node_data[i].nid != nid)
>> +			continue;
>> +
>> +		if (first) {
>> +			last_end_pfn = init_node_data[i].end_pfn;
>> +			first = 0;
>> +			continue;
>> +		}
>> +
>> +		/* Hole found */
>> +		hole_size = init_node_data[i].start_pfn - last_end_pfn;
>> +		if (init_node_data[i].start_pfn < start_easyrclm_pfn) {
>> +			zholes_size[ZONE_DMA] += hole_size;
>> +		} else {
>> +			zholes_size[ZONE_EASYRCLM] += hole_size;
>> +		}
>> +		last_end_pfn = init_node_data[i].end_pfn;
>> +	}
>> +}
>
> I'd probably put this loop in another function.  It is pretty
> self-contained, no?
>

yep. get_zholes_size() could be split into two functions 
find_start_easyrclm_pfn() and get_nid_zholes_size(). Would that be pretty 
clear-cut?

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
