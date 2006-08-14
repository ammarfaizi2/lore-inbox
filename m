Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751793AbWHNBzS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751793AbWHNBzS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 21:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751796AbWHNBzR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 21:55:17 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:21199 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751793AbWHNBzQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 21:55:16 -0400
Date: Mon, 14 Aug 2006 11:54:38 +1000
From: Nathan Scott <nathans@sgi.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org, xfs-masters@oss.sgi.com, xfs@oss.sgi.com
Subject: Re: [PATCH] XFS: possibly uninitialized variable use in fs/xfs/xfs_da_btree.c::xfs_da_node_lookup_int()
Message-ID: <20060814115438.D2698880@wobbly.melbourne.sgi.com>
References: <200608122334.21901.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200608122334.21901.jesper.juhl@gmail.com>; from jesper.juhl@gmail.com on Sat, Aug 12, 2006 at 11:34:21PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2006 at 11:34:21PM +0200, Jesper Juhl wrote:
> Ok, I'll honestly admit that I'm in over my head here. But, coverity found
> a potential use of an uninitialized variable in 
> fs/xfs/xfs_da_btree.c::xfs_da_node_lookup_int() and I think it might be 
> correct (coverity bug #900).

It looks like a false positive to me.

> Nothing initializes 'retval' before this bit of code, so if 'blk->magic' is 
> neither == XFS_DIR2_LEAFN_MAGIC or XFS_ATTR_LEAF_MAGIC then it'll be in an 
> uninitialized state when we get to the "if (((retval == ENOENT) ..." bit.

blk->magic is guaranteed to be one of those two things by the first
loop.

> Since there is code above that check 'blk->magic' against 
> being == XFS_DA_NODE_MAGIC and I don't see how we would be skipping the 

Reading closely through the 1st loop we can see that there's no way
to get to the second loop without having one of the LEAF variants in
the magic#.  The NODE variant indicates its an internal btree node,
and we move down the btree toward the leaves, at which point we jump
out into the second loop.

> I suspect I may be completely wrong, and if that's the case I'd sure like 
> an explanation of where I went wrong along with the NACK for the patch.
> In case my understanding is in fact correct and the patch below makes sense,
> then kindly apply :-)

Its not correct.  What I think we should do is add a third branch into
that second loop which just ASSERTs (to trip up a debug build) and set
retval to EFSCORRUPTED (to shut these tools up).

cheers.

-- 
Nathan
