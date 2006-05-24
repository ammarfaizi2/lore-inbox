Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932480AbWEXECM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932480AbWEXECM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 00:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932551AbWEXECM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 00:02:12 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:11405 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932480AbWEXECK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 00:02:10 -0400
Date: Wed, 24 May 2006 14:01:42 +1000
From: David Chinner <dgc@sgi.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Per-superblock unused dentry LRU lists.
Message-ID: <20060524040142.GC7418631@melbourne.sgi.com>
References: <20060524012412.GB7412499@melbourne.sgi.com> <1148435980.3049.11.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1148435980.3049.11.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2006 at 03:59:40AM +0200, Arjan van de Ven wrote:
> On Wed, 2006-05-24 at 11:24 +1000, David Chinner wrote:
> 
> 
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=114491661527656&w=2
> > 
> > shrink_dcache_sb() becomes a severe bottleneck when the unused dentry
> > list becomes long and mounts and unmounts occur frequently on the
> > machine.
> 
> how does a per SB list deal with umounts that occur frequently? I
> suppose it means destroying just your list... 

shrink_dcache_sb no longer walks the single unsed dentry list
with the dcache lock held. With many millions of dentries on the
unused list, this meant that all dentry operations come to a
halt while one process executes shrink_dcache_sb().

With a per-sb lru, we no longer have to walk a global list to find
all the dentries that belong to the superblock we are unmounting.
Hence we only hold the dcache_lock for as long as it takes to pull
a dentry of the list and free it.

> > I've attempted to make reclaim fair by keeping track of the last superblock
> > we pruned, and starting from the next on in the list each time.
> 
> how fair is this in the light of a non-equal sizes?

It's not. If you read the thread I pointed at, you'll note that
I commented at the time this method introduces "interesting" reclaim
fairness issues, and this is one of the reasons I didn't implement
this method straight away.

> say you have a 4Gb
> fs and a 1Tb list. Will your approach result in trying to prune 1000
> from the 4Gb, then 1000 from the 1Tb, then 1000 from the 4Gb etc ?
> while that is fair in absolute terms, in relative terms it's highly not
> fair to the small filesystem.... 

Yup, that is what the current code I've written will do. I just
wanted someting that worked over all superblocks to begin with.
It's not very smart, but improving it can be done incrementally.

> (I'm not sure there is ONE right answer here, well maybe by scaling the
> count to the per fs count rather than to the total...)

Agreed - scaling is probably going to result in the fairest reclaim,
but I prefered to focus on getting the mechanism working properly
and testing that before considering optimising the reclaim algorithm.

Also, I'd prefer to address deficiencies as they arise, rather than
make optimisations based on assumptions that may be incorrect....

> this makes me wonder btw if we can do a per superblock slab for these
> dentries, that may decrease fragmentation of slabs in combination with
> your patch....

That doesn't prevent slab fragmentation per filesystem. And most of
the fragmentation problems I see are in the inode caches so at best
this would be a bandaid rather than a real solution to the fundamental
problems....

Cheers,

Dave.
-- 
Dave Chinner
R&D Software Enginner
SGI Australian Software Group
