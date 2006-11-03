Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752756AbWKCWKG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752756AbWKCWKG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 17:10:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753213AbWKCWKG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 17:10:06 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:38875 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1752756AbWKCWKE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 17:10:04 -0500
Date: Fri, 3 Nov 2006 14:10:01 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Avoid allocating during interleave from almost full nodes
In-Reply-To: <20061103134633.a815c7b3.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0611031353570.16486@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0611031256190.15870@schroedinger.engr.sgi.com>
 <20061103134633.a815c7b3.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Nov 2006, Andrew Morton wrote:

> > The exact node we choose during interleave does not matter much if we are
> > under memory pressure since the allocations will be redirected anyways
> > after we have overallocated a single node.
> 
> Am not clear on what that means.

If we currently overallocate a node then we fall back to other nodes along 
the zonelist. We will not be able to allocate on the intended node and 
the next interleave node becomes the nearest node with enough memory.

> > This patch checks for the amount of free pages on a node. If it is lower
> > than a predefined limit (in /proc/sys/kernel/min_interleave_ratio) then
> 
> You mean /proc/sys/vm

Right.

> > we avoid allocating from that node. We keep a bitmap of full nodes
> > that is cleared every 2 seconds when draining the pagesets for
> > node 0.
> 
> Wall time is a bogus concept in the VM.  Can we please stop relying upon it?

We use the same 2 second pulse to drain slab caches, and the page 
allocators per cpu caches. The slab draining has been around forever. Its 
relying on jiffies and not on wall time.

> > not matter though since we always can fall back to operating without
> > full_interleave_nodes. As a result of the racyness we may uselessly
> > skip a node or retest a node.
> 
> This design relies upon nodes having certain amounts of free memory.  This
> concept is bogus.  Because it treats clean pagecache which hasn't been used
> since last Saturday as "in use".  It is not in use.

It relies on free pages, not on in use pages. The attempt is to bypass 
expensive reclaim as long as we can find free memory on other nodes.
