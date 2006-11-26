Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935217AbWKZAuv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935217AbWKZAuv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 19:50:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935218AbWKZAuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 19:50:51 -0500
Received: from excu-mxob-2.symantec.com ([198.6.49.23]:19598 "EHLO
	excu-mxob-2.symantec.com") by vger.kernel.org with ESMTP
	id S935217AbWKZAuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 19:50:50 -0500
X-AuditID: c6063117-a39d5bb0000025c0-8f-4568e37298cc 
Date: Sun, 26 Nov 2006 00:44:59 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Mel Gorman <mel@skynet.ie>, Christoph Lameter <clameter@sgi.com>,
       linux-mm@kvack.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/11] Add __GFP_MOVABLE flag and update callers
In-Reply-To: <Pine.LNX.4.64.0611251058350.6991@woody.osdl.org>
Message-ID: <Pine.LNX.4.64.0611260039070.27769@blonde.wat.veritas.com>
References: <20061121225022.11710.72178.sendpatchset@skynet.skynet.ie>
 <20061121225042.11710.15200.sendpatchset@skynet.skynet.ie>
 <Pine.LNX.4.64.0611211529030.32283@schroedinger.engr.sgi.com>
 <Pine.LNX.4.64.0611212340480.11982@skynet.skynet.ie>
 <Pine.LNX.4.64.0611211637120.3338@woody.osdl.org> <20061123163613.GA25818@skynet.ie>
 <Pine.LNX.4.64.0611230906110.27596@woody.osdl.org> <20061124104422.GA23426@skynet.ie>
 <Pine.LNX.4.64.0611241924110.17508@blonde.wat.veritas.com>
 <Pine.LNX.4.64.0611251058350.6991@woody.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 26 Nov 2006 00:44:34.0444 (UTC) FILETIME=[0AE8C4C0:01C710F4]
X-Brightmail-Tracker: AAAAAA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Nov 2006, Linus Torvalds wrote:
> On Fri, 24 Nov 2006, Hugh Dickins wrote:
> > 
> > You need to add in something like the patch below (mutatis mutandis
> > for whichever approach you end up taking): tmpfs uses highmem pages
> > for its swap vector blocks, noting where on swap the data pages are,
> > and allocates them with mapping_gfp_mask(inode->i_mapping); but we
> > don't have any mechanism in place for reclaiming or migrating those.
> 
> I think this really just points out that you should _not_ put MOVABLE into 
> the "mapping_gfp_mask()" at all.
> 
> The mapping_gfp_mask() should really just contain the "constraints" on 
> the allocation, not the "how the allocation is used". So things like "I 
> need all my pages to be in the 32bit DMA'able region" is a constraint on 
> the allocator, as is something like "I need the allocation to be atomic". 
> 
> But MOVABLE is really not a constraint on the allocator, it's a guarantee 
> by the code _calling_ the allocator that it will then make sure that it 
> _uses_ the allocation in a way that means that it is movable.
> 
> So it shouldn't be a property of the mapping itself, it should always be a 
> property of the code that actually does the allocation.
> 
> Hmm?

Not anything I feel strongly about, but I don't see it that way.

mapping_gfp_mask() seems to me nothing more than a pragmatic way
of getting the appropriate gfp_mask down to page_cache_alloc().

alloc_inode() initializes it to whatever suits most filesystems
(currently GFP_HIGHUSER), and those who differ adjust it (e.g.
block_dev has good reason to avoid highmem so sets it to GFP_USER
instead).  It used to be the case that several filesystems lacked
kmap() where needed, and those too would set GFP_USER: what you call
a constraint seems to me equally a property of the surrounding code.

If __GFP_MOVABLE is coming in, and most fs's are indeed allocating
movable pages, then I don't see why MOVABLE shouldn't be in the
mapping_gfp_mask.  Specifying MOVABLE constrains both the caller's
use of the pages, and the way they are allocated; as does HIGHMEM.

And we shouldn't be guided by the way tmpfs (ab?)uses that gfp_mask
for its metadata allocations as well as its page_cache_alloc()s:
that's just a special case.  Though the ramfs case is more telling
(its pagecache pages being not at present movable).

Hugh
