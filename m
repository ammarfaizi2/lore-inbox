Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261292AbVALSJL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbVALSJL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 13:09:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbVALSI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 13:08:56 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:5357 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261293AbVALSHm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 13:07:42 -0500
Date: Wed, 12 Jan 2005 23:42:30 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       pbadari@us.ibm.com
Subject: Re: [RFC] Reimplementation of linux dynamic percpu memory allocator
Message-ID: <20050112181230.GA2035@impedimenta.in.ibm.com>
References: <41C35DD6.1050804@colorfullife.com> <20041220182057.GA16859@in.ibm.com> <41C718C7.1020908@colorfullife.com> <20041220192558.GA17194@in.ibm.com> <41D2DC68.5080805@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41D2DC68.5080805@colorfullife.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 29, 2004 at 05:33:44PM +0100, Manfred Spraul wrote:
> Ravikiran G Thirumalai wrote:
> 
> >
> Could you ask Badari Pulavarty (pbadari@us.ibm.com)?
> He noticed the fragmentation problem with the original 
> kmem_cache_alloc_node implementation. Perhaps he could just run your 
> version with his test setup:
> The thread with the fix is at:
> 
> http://marc.theaimsgroup.com/?t=109735434400002&r=1&w=2
> 

Manfred,
Badari's test was to create thousands of scsi devices with
scsi_debug on a multiprocessor x86_64 box with CONFIG_NUMA.  
I tried out something similar -- create 2000 scsi disks on 2 way x86_64 box.
Here are the results; All numbers in kB from /proc/meminfo.

1) Without your patch to reduce fragmentation due to kmem_cache_alloc_node:
		Before  After disk	Difference
		disks	creation	
		----------------------------------
MemTotal	5009956	5009956		0
MemFree		4949428	4868300		81128

2) With your patch to reduce fragmentation due to kmem_cache_alloc_node:
		Before  After disk	Difference
		disks	creation	
		----------------------------------
MemTotal	5009956	5009956		0
MemFree		4947380	4874876		72504

3) With the new alloc_percpu implementation which does not use slab:
		Before  After disk	Difference
		disks	creation	
		----------------------------------
MemTotal	5009956	5009956		0
MemFree		4923244	4851648		71596

As you can see, the alloc_percpu reimplementation doesn't fragment.

Also, I'd ran some user space stress tests to check the allocator's
utilization levels.  I reran them and here's the result:

A) Test description and results for a 'counters only' test run:
With a block size of 8192 bytes,
1. Allocate 2000 4 byte counters 
	At the end of allocation, 1 8192byte block exists with a usecount
	of 8000 
2. Free a random number of objects in random order.
	After freeing 3992 bytes of memory, one block exists in the
	allocator with a usecount of 4008
3. Allocate 2000 4 byte counters again
	At the end of allocation 2 blocks exists with usecounts of 
	8192 and 3816
4. Free all remaining objects
	All objects go away and the allocator doesn't have any blocks left

B) Test description and results for a 'random sized objects' test run:
With a block size of 8192 bytes,
1. Allocate 2000 random sized objects with random alignment specifications
	At the end of allocation, 504 8192byte blocks exist in the system
	after allocating 4076556 bytes of objects -- with 98.7 % utilization
2. Free a random number of objects in random order.
	After freeing 2020220 bytes of memory, 458 blocks exist. 
	Utilization is 2056336/3751936 -- 54.8 %
3. Allocate 2000 random sized objects as in step 1 again
	After adding 4155972 bytes of objects, 772 blocks summing up to
	6324224 bytes exist in the allocator.  objects adding up  to 
	6212308 bytes have been allocated, which means a utilization
	level of 98.2 %.

I guess this proves that the allocator behaves quite well in terms of
fragmentation.

Thanks,
Kiran
