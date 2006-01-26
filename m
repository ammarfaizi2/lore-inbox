Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030234AbWAZXaG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030234AbWAZXaG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 18:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030240AbWAZXaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 18:30:05 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:49844 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030234AbWAZXaE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 18:30:04 -0500
Date: Thu, 26 Jan 2006 15:29:55 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Matthew Dobson <colpatch@us.ibm.com>
cc: linux-kernel@vger.kernel.org, sri@us.ibm.com, andrea@suse.de,
       pavel@suse.cz, linux-mm@kvack.org
Subject: Re: [patch 3/9] mempool - Make mempools NUMA aware
In-Reply-To: <43D95A2E.4020002@us.ibm.com>
Message-ID: <Pine.LNX.4.62.0601261525570.18810@schroedinger.engr.sgi.com>
References: <20060125161321.647368000@localhost.localdomain>
 <1138233093.27293.1.camel@localhost.localdomain>
 <Pine.LNX.4.62.0601260953200.15128@schroedinger.engr.sgi.com>
 <43D953C4.5020205@us.ibm.com> <Pine.LNX.4.62.0601261511520.18716@schroedinger.engr.sgi.com>
 <43D95A2E.4020002@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jan 2006, Matthew Dobson wrote:

> alloc_pages_node() does not guarantee allocation on a specific node, but
> calling __alloc_pages() with a specific nodelist would.

True but you have emergency *_node function that do not take nodelists.

> > There is no way that you would need this patch.
> 
> My goal was to not change the behavior of the slab allocator when inserting
> a mempool-backed allocator "under" it.  Without support for at least
> *requesting* allocations from a specific node when allocating from a
> mempool, this would change how the slab allocator works.  That would be
> bad.  The slab allocator now does not guarantee that, for example, a
> kmalloc_node() request is satisfied by memory from the requested node, but
> it does at least TRY.  Without adding mempool_alloc_node() then I would
> never be able to even TRY to satisfy a mempool-backed kmalloc_node()
> request from the correct node.  I believe that would constitute an
> unacceptable breakage from normal, documented behavior.  So, I *do* need
> this patch.

If you get to the emergency lists then you are already in a tight memory 
situation. In that situation it does not make sense to worry about the 
node number the memory is coming from. kmalloc_node is just a kmalloc with 
an indication of a preference of where the memory should be coming from. 
The node locality only influences performance and not correctness.

There is no change to the way the slab allocator works. Just drop the 
*_node variants.
