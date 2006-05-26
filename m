Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030281AbWEZDuy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030281AbWEZDuy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 23:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030288AbWEZDuy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 23:50:54 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:46246 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030281AbWEZDux (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 23:50:53 -0400
Date: Fri, 26 May 2006 13:49:45 +1000
From: David Chinner <dgc@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: balbir@in.ibm.com, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH]  Per-superblock unused dentry LRU lists V3
Message-ID: <20060526034945.GL7418631@melbourne.sgi.com>
References: <20060526023536.GN8069029@melbourne.sgi.com> <20060525200100.142b2124.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060525200100.142b2124.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2006 at 08:01:00PM -0700, Andrew Morton wrote:
> David Chinner <dgc@sgi.com> wrote:
> >
> > Per superblock dentry LRU lists.
> > 
> > ...
> >
> > +/*
> > + * Shrink the dentry LRU on a given superblock.
> > + *
> > + * If flags is non-zero, we need to do special processing based on
> > + * which flags are set. This means we don't need to maintain multiple
> > + * similar copies of this loop.
> > + */
> > +static void __shrink_dcache_sb(struct super_block *sb, int *count, int flags)
> > +{

....

> > +		/*
> > +		 * If we are honouring the DCACHE_REFERENCED flag and the
> > +		 * dentry has this flag set, don't free it. Clear the flag
> > +		 * and put it back on the LRU
> > +		 */
> > +		if ((flags & DCACHE_REFERENCED) &&
> > +		    (dentry->d_flags & DCACHE_REFERENCED)) {
> > +			dentry->d_flags &= ~DCACHE_REFERENCED;
> > +			dentry_lru_add(dentry);
> > +			spin_unlock(&dentry->d_lock);
> > +			continue;
> 
> Here we put the dentry back onto the list which we're currently scanning. 
> So if `cnt' exceeds the number of dentries on this superblock we end up
> scanning some of them more than once.

Good point. Should be easy to fix because we know exactly how
many dentries are on the list before we start scanning...

> Seems odd.
> 
> > -static void prune_dcache(int count, struct super_block *sb)
> > +static void prune_dcache(int count)
> >  {
> >
> > ...
> >
> > +	struct super_block *sb;
> > +	static struct super_block *sb_hand = NULL;
> > +	int work_done = 0;
> > +
> > +	spin_lock(&sb_lock);
> > +	if (sb_hand == NULL)
> > +		sb_hand = sb_entry(super_blocks.next);
> > +restart:
> > +	list_for_each_entry(sb, &super_blocks, s_list) {
> > +		if (sb != sb_hand)
> >  			continue;
> > -		}
> >  		/*
> > -		 * If the dentry is not DCACHED_REFERENCED, it is time
> > -		 * to remove it from the dcache, provided the super block is
> > -		 * NULL (which means we are trying to reclaim memory)
> > -		 * or this dentry belongs to the same super block that
> > -		 * we want to shrink.
> > +		 * Found the next superblock to work on.  Move the hand
> > +		 * forwards so that parallel pruners work on a different sb
> >  		 */
> > +		work_done++;
> > +		sb_hand = sb_entry(sb->s_list.next);
> > +		sb->s_count++;
> > +		spin_unlock(&sb_lock);
> 
> Now sb_hand points at a superblock against which we have no reference.  How
> can we use sb_hand safely next time we call in here?  It could point at a
> now-freed superblock?

Yes, it could. but we don't use what sb_hand points at unless it
matches something in the list. Therefore it only gets used when it is
valid.

If sb_hand is not valid, then it won't match with any of the  sb's in the
list, we exist the loop, work_done is zero, and we restart after setting
sb_hand back to the first entry in the list.

> A better approach might be to rotate the super_blocks list as we walk
> through it, so the search always starts at super_blocks.next - that way,
> there's no need to introduce a new global to record where we're up to.

hmm, that'll stuff up other threads walking the superblock list. If we
rotate the head while they are in the middle of walking the list, then
we'll need more logic in __put_super_and_need_restart() to handle
the list head changing while traversals are occuring. It also makes
it difficult to give parallel shrinkers different superblocks to
work on because we can't rotate the head until we've traversed
the entire list or count is exhausted in prune_dcache....

> >  		/*
> > -		 * If this dentry is for "my" filesystem, then I can prune it
> > -		 * without taking the s_umount lock (I already hold it).
> > +		 * We need to be sure this filesystem isn't being unmounted,
> > +		 * otherwise we could race with generic_shutdown_super(), and
> > +		 * end up holding a reference to an inode while the filesystem
> > +		 * is unmounted.  So we try to get s_umount, and make sure
> > +		 * s_root isn't NULL.
> >  		 */
> > -		if (sb && dentry->d_sb == sb) {
> > -			prune_one_dentry(dentry);
> > -			continue;
> > +		if (down_read_trylock(&sb->s_umount)) {
> > +			if ((sb->s_root != NULL) &&
> > +			    (!list_empty(&sb->s_dentry_lru))) {
> > +				__shrink_dcache_sb(sb, &count,
> > +						DCACHE_REFERENCED);
> 
> um.  If `count' is 10000 and we have 100 superblocks each with 1000
> dentries, we end up scanning the first five to ten (depending upon
> DCACHE_REFERENCED density) superblocks to exhaustion and the rest not at
> all.  I think.

Yes, given the bug you pointed out above, then yes, that is probably correct.
However, given that prune_dcache() only has one caller now - the shrinker -
count is only ever going to be SHRINK_BATCH (128), this is not a big
problem right now because each new call into prune_dcache will start
on a different superblock...

> If so, I'd have thought that we'd be better off putting some balancing
> arithmetic in here.
> 
> number of dentries to scan on this sb =
> 	count * (number of dentries on this sb /
> 		number of dentries in the machine)

Agreed, and as I pointed out in the thread following the first version
of the patch I've been concerned with fixing the bug first. now that it
appears that I've fixed the bug, I'm looking at how to make this fairer.
The above is basically what I was thinking of doing.

It's a bit more complex than that, though. The above will always result
in zero due to the integer division. Turning it around as (count * nr_sb) /
nr_unused will lead to 32bit integer overflow with more than 20 million
dentries on a superblock (which we already exceed quite easily)....

So I'm thinking that the dentry stats need to be converted to longs
from ints as the only platforms where 32bit overflow will be a problem
are 64bit platforms...

Thoughts?

Cheers,

Dave.
-- 
Dave Chinner
R&D Software Enginner
SGI Australian Software Group
