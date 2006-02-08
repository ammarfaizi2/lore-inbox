Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030452AbWBHPmq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030452AbWBHPmq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 10:42:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030453AbWBHPmq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 10:42:46 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:3244 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030451AbWBHPmo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 10:42:44 -0500
Date: Wed, 8 Feb 2006 07:42:01 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Bharata B Rao <bharata@in.ibm.com>
cc: Andi Kleen <ak@suse.de>, Ray Bryant <raybry@mpdtxmail.amd.com>,
       discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] mmap, mbind and write to mmap'ed memory crashes
 2.6.16-rc1[2] on 2 node X86_64
In-Reply-To: <20060208121000.GA9906@in.ibm.com>
Message-ID: <Pine.LNX.4.62.0602080736510.908@schroedinger.engr.sgi.com>
References: <20060205163618.GB21972@in.ibm.com>
 <Pine.LNX.4.62.0602070848450.24487@schroedinger.engr.sgi.com>
 <200602071727.18359.raybry@mpdtxmail.amd.com> <200602080036.31059.ak@suse.de>
 <20060208121000.GA9906@in.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Feb 2006, Bharata B Rao wrote:

> The zones in my machine look like this:
> 
> On node 0 totalpages: 773791
>   DMA zone: 2151 pages, LIFO batch:0
>   DMA32 zone: 771640 pages, LIFO batch:31
>   Normal zone: 0 pages, LIFO batch:0
>   HighMem zone: 0 pages, LIFO batch:0
> On node 1 totalpages: 500592
>   DMA zone: 0 pages, LIFO batch:0
>   DMA32 zone: 242032 pages, LIFO batch:31
>   Normal zone: 258560 pages, LIFO batch:31
>   HighMem zone: 0 pages, LIFO batch:0
> 
> So it can be seen that the node 0 has only DMA and DMA32 zones while
> node 1 has only DMA32 and Normal zones.

Uhh... Thats a rather asymmetric arrangement.
 
> The current mempolicy code assumes that the highest zone(policy_zone) that
> comes under the memory policy is valid (by which I mean zone->present_pages
> is non-zero) for all nodes, which is not true in my case. In this case
> the policy_zone gets set to ZONE_NORMAL (highest zone here). 

Right.

> When mbind'ing to node 0, bind_zonelist()(and subsequent functions) binds
> the ZONE_NORMAL zone to vma->vm_policy. During the write fault, the allocator
> is asked to allocate from a non-existent ZONE_NORMAL zone for node 0. This
> I believe is causing the oops I am seeing. It is still not clear to me
> why doesn't the allocator fail the allocations from a zone which has 
> zone->present_pages=0 gracefully.

Hmm....
 
> This whole problem wasn't seen on 2.6.15.2 because, bind_zonelist()
> actually makes sure that the zone it is binding to has a non-zero
> zone->present_pages.

Correct there was a loop in bind_zonelist that I moved to the zone 
initialization to simplify it.

However, this has implications for policy_zone. This variable should store
the zone that policies apply to. However, in your case this zone will vary 
which may lead to all sorts of weird behavior even if we fix 
bind_zonelist. To which zone does policy apply? ZONE_NORMAL or ZONE_DMA32?
