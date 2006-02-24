Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932144AbWBXJEu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932144AbWBXJEu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 04:04:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932146AbWBXJEu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 04:04:50 -0500
Received: from [193.1.99.76] ([193.1.99.76]:58553 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S932144AbWBXJEt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 04:04:49 -0500
Date: Fri, 24 Feb 2006 09:04:24 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet.skynet.ie
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms-devel@lists.sourceforge.net
Subject: Re: [PATCH 4/7] ppc64 - Specify amount of kernel memory at boot time
In-Reply-To: <1140718555.8697.73.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0602240902220.19157@skynet.skynet.ie>
References: <20060217141552.7621.74444.sendpatchset@skynet.csn.ul.ie> 
 <20060217141712.7621.49906.sendpatchset@skynet.csn.ul.ie> 
 <1140196618.21383.112.camel@localhost.localdomain> 
 <Pine.LNX.4.64.0602211445160.4335@skynet.skynet.ie> 
 <1140543359.8693.32.camel@localhost.localdomain> 
 <Pine.LNX.4.64.0602221625100.2801@skynet.skynet.ie> 
 <1140712969.8697.33.camel@localhost.localdomain> 
 <Pine.LNX.4.64.0602231646530.24093@skynet.skynet.ie> 
 <1140716304.8697.53.camel@localhost.localdomain> 
 <Pine.LNX.4.64.0602231740410.24093@skynet.skynet.ie>
 <1140718555.8697.73.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Feb 2006, Dave Hansen wrote:

> On Thu, 2006-02-23 at 18:01 +0000, Mel Gorman wrote:
>> On Thu, 23 Feb 2006, Dave Hansen wrote:
>>> OK, back to the hapless system admin using kernelcore. They have a
>>> 4-node system with 2GB of RAM in each node for 8GB total.  They use
>>> kernelcore=1GB.  They end up with 4x1GB ZONE_DMA and 4x1GB
>>> ZONE_EASYRCLM.  Perfect.  You can safely remove 4GB of RAM.
>>>
>>> Now, imagine that the machine has been heavily used for a while, there
>>> is only 1 node's memory available, but CPUs are available in the same
>>> places as before.  So, you start up your partition again have 8GB of
>>> memory in one node.  Same kernelcore=1GB option.  You get 1x7GB ZONE_DMA
>>> and 1x1GB ZONE_EASYRCLM.  I'd argue this is going to be a bit of a
>>> surprise to the poor admin.
>>>
>>
>> That sort of surprise is totally unacceptable but the behaviour of
>> kernelcore needs to be consistent on both the x86 and the ppc (any any
>> other ar. How about;
>>
>> 1. kernelcore=X determines the total amount of memory for !ZONE_EASYRCLM
>>     (be it ZONE_DMA, ZONE_NORMAL or ZONE_HIGHMEM)
>
> Sounds reasonable.  But, if you're going to do that, should we just make
> it the opposite and explicitly be easy_reclaim_mem=?  Do we want the
> limit to be set as "I need this much kernel memory", or "I want this
> much removable memory".  I dunno.
>

I think we should keep it at kernelcore=. If you have too little easyrclm 
memory, then hot-remove and hugetlb availability is impaired. If you 
have too little kernel memory, you have a really bad day.

>> 2. For every node that can have ZONE_EASYRCLM, split the kernelcore across
>>     the nodes as a percentage of the node size
>>
>>     Example: 4 nodes, 1 GiB each, kernelcore=512MB
>>  		node 0 ZONE_DMA = 128MB
>>  		node 1 ZONE_DMA = 128MB
>>  		node 2 ZONE_DMA = 128MB
>>  		node 3 ZONE_DMA = 128MB
>>
>>  	    2 nodes, 3GiB and 1GIB, kernelcore=512MB
>>  		node 0 ZONE_DMA = 384
>>  		node 1 ZONE_DMA = 128
>>
>> It gets a bit more complex on NUMA for x86 because ZONE_NORMAL is
>> involved but the idea would essentially be the same.
>
> Yes, chopping it up seems like the right thing (or as close as we can
> get) to me.
>

Ok, will rework the code to make it happen.

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
