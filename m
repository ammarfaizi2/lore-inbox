Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751118AbWE2DJG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbWE2DJG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 23:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751117AbWE2DJF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 23:09:05 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:20375 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751090AbWE2DJE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 23:09:04 -0400
Date: Mon, 29 May 2006 13:08:34 +1000
From: David Chinner <dgc@sgi.com>
To: Jan Blunck <jblunck@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       viro@zeniv.linux.org.uk
Subject: Re: [patch 5/5] vfs: per superblock dentry unused list
Message-ID: <20060529030834.GU8069029@melbourne.sgi.com>
References: <20060526110655.197949000@suse.de>> <20060526110803.159085000@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060526110803.159085000@suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2006 at 01:07:00PM +0200, Jan Blunck wrote:
> This patch adds per superblock dentry unused lists. This should speedup the
> umounting/remounting of filesystems when there are alot of dentries in use.
> 
> Signed-off-by: Jan Blunck <jblunck@suse.de>
> ---
>  fs/dcache.c        |  143 +++++++++++++++++++++--------------------------------
>  fs/super.c         |    1 
>  include/linux/fs.h |    1 
>  3 files changed, 61 insertions(+), 84 deletions(-)
> 
> Index: work-2.6/fs/dcache.c
> ===================================================================
> --- work-2.6.orig/fs/dcache.c
> +++ work-2.6/fs/dcache.c
> @@ -61,7 +61,6 @@ static kmem_cache_t *dentry_cache __read
>  static unsigned int d_hash_mask __read_mostly;
>  static unsigned int d_hash_shift __read_mostly;
>  static struct hlist_head *dentry_hashtable __read_mostly;
> -static LIST_HEAD(dentry_unused);
>  
>  /* Statistics gathering. */
>  struct dentry_stat global_dentry_stat = {
> @@ -167,12 +166,15 @@ repeat:
>  		if (dentry->d_op->d_delete(dentry))
>  			goto unhash_it;
>  	}
> +	/* Kill dentry without superblock */
> +	if (unlikely(!dentry->d_sb))
> +		goto unhash_it;
>  	/* Unreachable? Get rid of it */
>  	if (d_unhashed(dentry))
>  		goto kill_it;
>  	if (list_empty(&dentry->d_lru)) {
>  		dentry->d_flags |= DCACHE_REFERENCED;
> -		list_add(&dentry->d_lru, &dentry_unused);
> +		list_add(&dentry->d_lru, &dentry->d_sb->s_unused);
>  		dentry_stat_inc(dentry->d_sb, nr_unused);
>  	}
>  	spin_unlock(&dentry->d_lock);
> @@ -382,19 +384,22 @@ static inline void prune_one_dentry(stru
>  }
>  
>  /**
> - * prune_dcache - shrink the dcache
> + * prune_dcache_sb - prune the dcache for a superblock
> + * @sb: superblock
>   * @count: number of entries to try and free
>   *
> - * Shrink the dcache. This is done when we need
> - * more memory. When we need to unmount something
> - * we call shrink_dcache_sb().
> + * Prune the dcache for the specified super block. This
> + * is called from prune_dcache().
>   *
> - * This function may fail to free any resources if
> - * all the dentries are in use.
> + * You need to have a reference to the super block and
> + * should have sb->s_umount locked. This function may fail
> + * to free any resources if all the dentries are in use.
>   */
> -
> -static void prune_dcache(int count)
> +static void prune_dcache_sb(struct super_block *sb, int count)
>  {
> +	if (count <= 0)
> +		return;
> +
>  	spin_lock(&dcache_lock);
>  	for (; count ; count--) {
>  		struct dentry *dentry;
> @@ -402,10 +407,10 @@ static void prune_dcache(int count)
>  
>  		cond_resched_lock(&dcache_lock);
>  
> -		tmp = dentry_unused.prev;
> -		if (tmp == &dentry_unused)
> +		tmp = sb->s_unused.prev;
> +		if (tmp == &sb->s_unused)
>  			break;
> -		prefetch(dentry_unused.prev);
> +		prefetch(sb->s_unused.prev);
>  		dentry = list_entry(tmp, struct dentry, d_lru);
>  		dentry_stat_dec(dentry->d_sb, nr_unused);
>  		list_del_init(&dentry->d_lru);
> @@ -423,7 +428,7 @@ static void prune_dcache(int count)
>  		/* If the dentry was recently referenced, don't free it. */
>  		if (dentry->d_flags & DCACHE_REFERENCED) {
>  			dentry->d_flags &= ~DCACHE_REFERENCED;
> -			list_add(&dentry->d_lru, &dentry_unused);
> +			list_add(&dentry->d_lru, &sb->s_unused);
>  			dentry_stat_inc(dentry->d_sb, nr_unused);
>  			spin_unlock(&dentry->d_lock);
>  			continue;
> @@ -433,64 +438,48 @@ static void prune_dcache(int count)
>  	spin_unlock(&dcache_lock);
>  }
>  
> -
> -/*
> - * parsing d_hash list does not hlist_for_each_entry_rcu() as it
> - * done under dcache_lock.
> +/**
> + * prune_dcache - shrink the dcache
> + * @count: number of entries to try and free
> + *
> + * Prune the dcache. This is done when we need
> + * more memory.
> + *
> + * This function may fail to free any resources if
> + * all the dentries are in use.
>   */
> -static void select_anon(struct super_block *sb)
> +static void prune_dcache(int count)
>  {
> -	struct dentry *dentry;
> -	struct hlist_node *lp;
> -
> -	spin_lock(&dcache_lock);
> -	hlist_for_each_entry(dentry, lp, &sb->s_anon, d_hash) {
> -		if (!list_empty(&dentry->d_lru)) {
> -			dentry_stat_dec(sb, nr_unused);
> -			list_del_init(&dentry->d_lru);
> -		}
> +	struct super_block *sb;
> +	int unused = global_dentry_stat.nr_unused;
>  
> -		/*
> -		 * move only zero ref count dentries to the beginning
> -		 * (the most recent end) of the unused list
> -		 */
> -		spin_lock(&dentry->d_lock);
> -		if (!atomic_read(&dentry->d_count)) {
> -			list_add(&dentry->d_lru, &dentry_unused);
> -			dentry_stat_inc(sb, nr_unused);
> -		}
> -		spin_unlock(&dentry->d_lock);
> -	}
> -	spin_unlock(&dcache_lock);
> -}
> +	if (count <= 0)
> +		return;
>  
> -static void select_sb(struct super_block *sb)
> -{
> -	struct dentry *dentry, *pos;
> +	spin_lock(&sb_lock);
> + restart:
> +	list_for_each_entry(sb, &super_blocks, s_list) {
> +		sb->s_count++;
> +		spin_unlock(&sb_lock);
> +		down_read(&sb->s_umount);

This should probably be a try-lock. See the comment in
writeback_inodes()....

> +		if (sb->s_root) {
> +			int tmp;
>  
> -	spin_lock(&dcache_lock);
> -	list_for_each_entry_safe(dentry, pos, &dentry_unused, d_lru) {
> -		if (dentry->d_sb != sb)
> -			continue;
> -		list_del(&dentry->d_lru);
> -		list_add(&dentry->d_lru, &dentry_unused);
> +			/*
> +			 * Try to be fair to the unused lists:
> +			 *  sb_count/sb_unused ~ global_count/global_unused
> +			 */
> +			tmp = sb->s_dentry_stat.nr_unused/((unused/count)+1);
> +			prune_dcache_sb(sb, tmp);

So if count = SHRINK_BATCH = 128, unused is 12800 (for easy maths) and we have
100 unused on the first superbloc, we end up with tmp = 100 / ((12800/128)+1)
= 100/101 = 0.

Essentially, if your superblock has less than (global_unused / count) dentries
on it, they'll never get shrunk. They need to take at least one dentry off
each superblock to ensure that the lru lists are slowly turned over. This is
needed to allow pages in the slab pinned by dentries on lesser used or
smaller filesystems to be freed before you've trimmed almost every dentry
from the superblocks that contain orders of magnitude more dentries...

IOWs, I think that tmp must be >= 1 for all calls here. 

Realistically, we are limited in resolution by the way the shrinker works
here. When we have a difference of greater than 2 orders of magnitude between
the small superblock and the large superblock lists we are either going to
trim the small superblock lists too much or not enough....

> @@ -499,30 +488,16 @@ static void select_sb(struct super_block
>   * is used to free the dcache before unmounting a file
>   * system
>   */
> -
>  void shrink_dcache_sb(struct super_block * sb)
>  {

The only difference between this function and prune_dcache_sb
is the handlingof the DCACHE_REFERENCED bit. i built a common
function for these, because....

> @@ -671,7 +646,7 @@ void shrink_dcache_parent(struct dentry 
>  	int found;
>  
>  	while ((found = select_parent(parent)) != 0)
> -		prune_dcache(found);
> +		prune_dcache_sb(parent->d_sb, found);
>  }

... prune_dcache_parent() uses the same code as well....

> Index: work-2.6/include/linux/fs.h
> ===================================================================
> --- work-2.6.orig/include/linux/fs.h
> +++ work-2.6/include/linux/fs.h
> @@ -846,6 +846,7 @@ struct super_block {
>  	struct list_head	s_io;		/* parked for writeback */
>  	struct hlist_head	s_anon;		/* anonymous dentries for (nfs) exporting */
>  	struct list_head	s_files;
> +	struct list_head	s_unused;	/* unused dentries */

Maybe change that name to something that has "dentry" in the name?

>  	struct dentry_stat	s_dentry_stat;

... especially as the matching stats structure uses that convention...

Cheers,

Dave.
-- 
Dave Chinner
R&D Software Enginner
SGI Australian Software Group
