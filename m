Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750849AbWE2Lyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849AbWE2Lyr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 07:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbWE2Lyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 07:54:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:27360 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750811AbWE2Lyq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 07:54:46 -0400
Date: Mon, 29 May 2006 13:54:43 +0200
From: Jan Blunck <jblunck@suse.de>
To: David Chinner <dgc@sgi.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       viro@zeniv.linux.org.uk
Subject: Re: [patch 5/5] vfs: per superblock dentry unused list
Message-ID: <20060529115443.GG21024@hasse.suse.de>
References: <20060526110655.197949000@suse.de>> <20060526110803.159085000@suse.de> <20060529030834.GU8069029@melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060529030834.GU8069029@melbourne.sgi.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, David Chinner wrote:

> > -	spin_lock(&dcache_lock);
> > -	list_for_each_entry_safe(dentry, pos, &dentry_unused, d_lru) {
> > -		if (dentry->d_sb != sb)
> > -			continue;
> > -		list_del(&dentry->d_lru);
> > -		list_add(&dentry->d_lru, &dentry_unused);
> > +			/*
> > +			 * Try to be fair to the unused lists:
> > +			 *  sb_count/sb_unused ~ global_count/global_unused
> > +			 */
> > +			tmp = sb->s_dentry_stat.nr_unused/((unused/count)+1);
> > +			prune_dcache_sb(sb, tmp);
> 
> So if count = SHRINK_BATCH = 128, unused is 12800 (for easy maths) and we have
> 100 unused on the first superbloc, we end up with tmp = 100 / ((12800/128)+1)
> = 100/101 = 0.
> 
> Essentially, if your superblock has less than (global_unused / count) dentries
> on it, they'll never get shrunk. They need to take at least one dentry off
> each superblock to ensure that the lru lists are slowly turned over. This is
> needed to allow pages in the slab pinned by dentries on lesser used or
> smaller filesystems to be freed before you've trimmed almost every dentry
> from the superblocks that contain orders of magnitude more dentries...
> 
> IOWs, I think that tmp must be >= 1 for all calls here. 
> 
> Realistically, we are limited in resolution by the way the shrinker works
> here. When we have a difference of greater than 2 orders of magnitude between
> the small superblock and the large superblock lists we are either going to
> trim the small superblock lists too much or not enough....

Yeah, I have problems with that part as well. Some of your assumtions are
wrong. If the sb.nr_unused count is smaller than 128, the superblock is not
shrinked, thats true. But there is a superblock with more than 128 unused
dentries (since the global_unused count was 12800). So the prune_dcache() is
shrinking that one first. After a few runs, prune_dcache() is shrinking the
superblock with 128 unused dentries aswell.

Although, what happens when we have 100 superblocks with 128 unused dentries
each ... I have to think about this. The right solution would be to shrink the
dentries with the help of their age. But at the moment I don't have any bright
ideas in that direction.

> > @@ -499,30 +488,16 @@ static void select_sb(struct super_block
> >   * is used to free the dcache before unmounting a file
> >   * system
> >   */
> > -
> >  void shrink_dcache_sb(struct super_block * sb)
> >  {
> 
> The only difference between this function and prune_dcache_sb
> is the handlingof the DCACHE_REFERENCED bit. i built a common
> function for these, because....
> 
> > @@ -671,7 +646,7 @@ void shrink_dcache_parent(struct dentry 
> >  	int found;
> >  
> >  	while ((found = select_parent(parent)) != 0)
> > -		prune_dcache(found);
> > +		prune_dcache_sb(parent->d_sb, found);
> >  }
> 
> ... prune_dcache_parent() uses the same code as well....

No. prune_dcache() is working on the unused list in the opposite (reverse)
direction. shrink_dcache_sb() (basically my prune_dcache_sb()) is shrinking
all unused dentries. In that case it is better to visit the unused list in the
normal (forward) direction (~only one pass).

Jan
