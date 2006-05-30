Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751264AbWE3AFL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbWE3AFL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 20:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266AbWE3AFL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 20:05:11 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:44964 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751264AbWE3AFJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 20:05:09 -0400
Date: Tue, 30 May 2006 10:04:43 +1000
From: David Chinner <dgc@sgi.com>
To: Jan Blunck <jblunck@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       viro@zeniv.linux.org.uk
Subject: Re: [patch 5/5] vfs: per superblock dentry unused list
Message-ID: <20060530000443.GB8069029@melbourne.sgi.com>
References: <20060526110655.197949000@suse.de>> <20060526110803.159085000@suse.de> <20060529030834.GU8069029@melbourne.sgi.com> <20060529115443.GG21024@hasse.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060529115443.GG21024@hasse.suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2006 at 01:54:43PM +0200, Jan Blunck wrote:
> On Mon, May 29, David Chinner wrote:
> 
> > > -	spin_lock(&dcache_lock);
> > > -	list_for_each_entry_safe(dentry, pos, &dentry_unused, d_lru) {
> > > -		if (dentry->d_sb != sb)
> > > -			continue;
> > > -		list_del(&dentry->d_lru);
> > > -		list_add(&dentry->d_lru, &dentry_unused);
> > > +			/*
> > > +			 * Try to be fair to the unused lists:
> > > +			 *  sb_count/sb_unused ~ global_count/global_unused
> > > +			 */
> > > +			tmp = sb->s_dentry_stat.nr_unused/((unused/count)+1);
> > > +			prune_dcache_sb(sb, tmp);
> > 
> > So if count = SHRINK_BATCH = 128, unused is 12800 (for easy maths) and we have
> > 100 unused on the first superbloc, we end up with tmp = 100 / ((12800/128)+1)
> > = 100/101 = 0.
> > 
> > Essentially, if your superblock has less than (global_unused / count) dentries
> > on it, they'll never get shrunk. They need to take at least one dentry off
> > each superblock to ensure that the lru lists are slowly turned over. This is
> > needed to allow pages in the slab pinned by dentries on lesser used or
> > smaller filesystems to be freed before you've trimmed almost every dentry
> > from the superblocks that contain orders of magnitude more dentries...
> > 
> > IOWs, I think that tmp must be >= 1 for all calls here. 
> > 
> > Realistically, we are limited in resolution by the way the shrinker works
> > here. When we have a difference of greater than 2 orders of magnitude between
> > the small superblock and the large superblock lists we are either going to
> > trim the small superblock lists too much or not enough....
> 
> Yeah, I have problems with that part as well. Some of your assumtions are
> wrong. If the sb.nr_unused count is smaller than 128, the superblock is not
> shrinked, thats true. But there is a superblock with more than 128 unused
> dentries (since the global_unused count was 12800). So the prune_dcache() is
> shrinking that one first. After a few runs, prune_dcache() is shrinking the
> superblock with 128 unused dentries aswell.

You've just described the embodiment of the two order's of magnitude
issue I mentioned. That's not a wrong assumption - think of the
above case with global_unused count now being 1.28*10^7 instead of
1.28x10^4. How many dentries do you have to free before freeing any
on the small superblock if we don't free one per call? (quick
answer: 99.9%).

If we shrink one per call, we've freed all 128 dentries while there
is still 1*10^5 dentries on the large list. That seems like a much
better balance to make within the constraints of the shrinker
resolution we have to work with.

FWIW, if we don't free a dentry per sb per prune_dcache call, any
prooblems caused by slab page pinning and fragmetnation get worse
than they are now as some dentries will take far, far longer
to be freed than others regardless of their age.

> Although, what happens when we have 100 superblocks with 128 unused dentries
> each ... I have to think about this. The right solution would be to shrink the
> dentries with the help of their age. But at the moment I don't have any bright
> ideas in that direction.

Hmm - need to do something with that age_limit field, right? That
would imply we need a timestamp in the dentry as well, and we don't
shrink any sb that doesn't have dentries older than the age limit.
If we scan all the sb's and still have more to free, then we halve
the age limit and scan again....

> > > @@ -499,30 +488,16 @@ static void select_sb(struct super_block
> > >   * is used to free the dcache before unmounting a file
> > >   * system
> > >   */
> > > -
> > >  void shrink_dcache_sb(struct super_block * sb)
> > >  {
> > 
> > The only difference between this function and prune_dcache_sb
> > is the handlingof the DCACHE_REFERENCED bit. i built a common
> > function for these, because....
> > 
> > > @@ -671,7 +646,7 @@ void shrink_dcache_parent(struct dentry 
> > >  	int found;
> > >  
> > >  	while ((found = select_parent(parent)) != 0)
> > > -		prune_dcache(found);
> > > +		prune_dcache_sb(parent->d_sb, found);
> > >  }
> > 
> > ... prune_dcache_parent() uses the same code as well....
> 
> No. prune_dcache() is working on the unused list in the opposite (reverse)
> direction. shrink_dcache_sb() (basically my prune_dcache_sb()) is shrinking
> all unused dentries. In that case it is better to visit the unused list in the
> normal (forward) direction (~only one pass).

Why? Forward or reverse it's only one traversal to free all dentries
- you go till the list is empty. Either way, with the prefetch of
the next entry in the list there's little perfomrance difference
once you've got outside some tiny subset of the list that might be
hot in cache....

Cheers,

Dave.
-- 
Dave Chinner
R&D Software Enginner
SGI Australian Software Group
