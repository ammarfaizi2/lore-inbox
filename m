Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030230AbWAZXYf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030230AbWAZXYf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 18:24:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030232AbWAZXYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 18:24:35 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:47237 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030230AbWAZXYf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 18:24:35 -0500
Message-ID: <43D95A2E.4020002@us.ibm.com>
Date: Thu, 26 Jan 2006 15:24:30 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Lameter <clameter@engr.sgi.com>
CC: linux-kernel@vger.kernel.org, sri@us.ibm.com, andrea@suse.de,
       pavel@suse.cz, linux-mm@kvack.org
Subject: Re: [patch 3/9] mempool - Make mempools NUMA aware
References: <20060125161321.647368000@localhost.localdomain> <1138233093.27293.1.camel@localhost.localdomain> <Pine.LNX.4.62.0601260953200.15128@schroedinger.engr.sgi.com> <43D953C4.5020205@us.ibm.com> <Pine.LNX.4.62.0601261511520.18716@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.62.0601261511520.18716@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> On Thu, 26 Jan 2006, Matthew Dobson wrote:
> 
> 
>>Not all requests for memory from a specific node are performance
>>enhancements, some are for correctness.  With large machines, especially as
> 
> 
> alloc_pages_node and friends do not guarantee allocation on that specific 
> node. That argument for "correctness" is bogus.

alloc_pages_node() does not guarantee allocation on a specific node, but
calling __alloc_pages() with a specific nodelist would.


>>>You do not need this.... 
>>
>>I do not agree...
> 
> 
> There is no way that you would need this patch.

My goal was to not change the behavior of the slab allocator when inserting
a mempool-backed allocator "under" it.  Without support for at least
*requesting* allocations from a specific node when allocating from a
mempool, this would change how the slab allocator works.  That would be
bad.  The slab allocator now does not guarantee that, for example, a
kmalloc_node() request is satisfied by memory from the requested node, but
it does at least TRY.  Without adding mempool_alloc_node() then I would
never be able to even TRY to satisfy a mempool-backed kmalloc_node()
request from the correct node.  I believe that would constitute an
unacceptable breakage from normal, documented behavior.  So, I *do* need
this patch.

-Matt
