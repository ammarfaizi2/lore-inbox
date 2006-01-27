Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030244AbWA0Aed@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030244AbWA0Aed (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 19:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030249AbWA0Aed
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 19:34:33 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:7657 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030244AbWA0Aec (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 19:34:32 -0500
Message-ID: <43D96A93.9000600@us.ibm.com>
Date: Thu, 26 Jan 2006 16:34:27 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Lameter <clameter@engr.sgi.com>
CC: linux-kernel@vger.kernel.org, sri@us.ibm.com, andrea@suse.de,
       pavel@suse.cz, linux-mm@kvack.org
Subject: Re: [patch 3/9] mempool - Make mempools NUMA aware
References: <20060125161321.647368000@localhost.localdomain> <1138233093.27293.1.camel@localhost.localdomain> <Pine.LNX.4.62.0601260953200.15128@schroedinger.engr.sgi.com> <43D953C4.5020205@us.ibm.com> <Pine.LNX.4.62.0601261511520.18716@schroedinger.engr.sgi.com> <43D95A2E.4020002@us.ibm.com> <Pine.LNX.4.62.0601261525570.18810@schroedinger.engr.sgi.com> <43D96633.4080900@us.ibm.com> <Pine.LNX.4.62.0601261619030.19029@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.62.0601261619030.19029@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> On Thu, 26 Jan 2006, Matthew Dobson wrote:
> 
> 
>>Allocations backed by a mempool must always be allocated via
>>mempool_alloc() (or mempool_alloc_node() in this case).  What that means
>>is, without a mempool_alloc_node() function, NO mempool backed allocations
>>will be able to request a specific node, even when the system has PLENTY of
>>memory!  This, IMO, is unacceptable.  Adding more NUMA-awareness to the
>>mempool system allows us to keep the same slab behavior as before, as well
>>as leaving us free to ignore the node requests when memory is low.
> 
> 
> Ok. That makes sense. I thought the mempool_xxx functions were only for 
> emergencies. But nevertheless you still duplicate all memory allocation 
> functions. I already was a bit concerned when I added the _node stuff.

I'm glad we're on the same page now. :)  And yes, adding four "duplicate"
*_mempool allocators was not my first choice, but I couldn't easily see a
better way.


> What may be better is to add some kind of "allocation policy" to an 
> allocation. That allocation policy could require the allocation on a node, 
> distribution over a series of nodes, require allocation on a particular 
> node, or allow the use of emergency pools etc.
> 
> Maybe unify all the different page allocations to one call and do the 
> same with the slab allocator.

Hmmm...  I kinda like that.  Some sort of

struct allocation_policy
{
	enum       policy_type;
	nodemask_t nodes;
	mempool_t  critical_pool;
}

that could be passed to __alloc_pages()?

That seems a bit beyond the scope of what I'd hoped for this patch series,
but if an approach like this is believed to be generally useful, it's
something I'm more than willing to work on...

-Matt
