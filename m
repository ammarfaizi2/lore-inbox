Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932618AbWEXGUA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932618AbWEXGUA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 02:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932616AbWEXGUA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 02:20:00 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:38044 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932609AbWEXGT7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 02:19:59 -0400
Date: Wed, 24 May 2006 16:19:33 +1000
From: David Chinner <dgc@sgi.com>
To: Balbir Singh <balbir@in.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Per-superblock unused dentry LRU lists.
Message-ID: <20060524061933.GG7418631@melbourne.sgi.com>
References: <20060524012412.GB7412499@melbourne.sgi.com> <20060524050214.GB9639@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060524050214.GB9639@in.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2006 at 10:32:14AM +0530, Balbir Singh wrote:
> On Wed, May 24, 2006 at 11:24:12AM +1000, David Chinner wrote:
> > +}
> > +
> > +static void
> > +dentry_lru_del_init(struct dentry *dentry)
> > +{
> > +	if (likely(!list_empty(&dentry->d_lru))) {
> > +		list_del_init(&dentry->d_lru);
> > +		dentry_stat.nr_unused--;
> > +	}
> > +}
> > +
> 
> I wonder if there should be per-sb count of number of used dentries. This
> will help us while unmounting. Instead of passing count as NULL, the number
> of dentries in the super block can be passed.

Possibly.

> May be we should have
> per-dentry stats along with global statistics.

per-sb, you mean? ;)

> 
> <snip>
> 
> >  
> > +/*
> > + * Shrink the dentry LRU on æ given superblock.
> > + */
> > +static void
> > +__shrink_dcache_sb(struct super_block *sb, int *count, int flags)
> > +{
> > +	struct dentry *dentry;
> > +	int cnt = (count == NULL) ? -1 : *count;
> 
> This code seems hacky. Some comments please. Negative counters are generally
> not good IMHO. This can be avoided by per-sb dentry stats (please see
> the comment above)

I'll fix that up...

> > +
> > +	spin_lock(&dcache_lock);
> > +	while (!list_empty(&sb->s_dentry_lru) && cnt--) {
> > +		dentry = list_entry(sb->s_dentry_lru.prev,
> > +					struct dentry, d_lru);
> > +		dentry_lru_del_init(dentry);
> > +		BUG_ON(dentry->d_sb != sb);
> > +		prefetch(sb->s_dentry_lru.prev);
> > +
> > +		spin_lock(&dentry->d_lock);
> > +		/*
> > +		 * We found an inuse dentry which was not removed from
> > +		 * the LRU because of laziness during lookup.  Do not free
> > +		 * it - just keep it off the LRU list.
> > +		 */
> > +		if (atomic_read(&dentry->d_count)) {
> > +			spin_unlock(&dentry->d_lock);
> > +			continue;
> > +		}
> > +		/* If the dentry matches the flags passed in, don't free it.
> > +		 * clear the flags and put it back on the LRU */
> 
> The comment does not follow coding style conventions. What do these flags
> typically contain - DCACHE_REFERENCED? Could you clean up this comment
> please.

DCACHE_REFERENCED is the only one at the moment. I'll make that more obvious.

> > +		if (flags && (dentry->d_flags & flags)) {
> > +			dentry->d_flags &= ~flags;
> > +			dentry_lru_add(dentry);
> > +			spin_unlock(&dentry->d_lock);
> > +			continue;
> > +		}
> > +		prune_one_dentry(dentry);
> > +	}
> > +	spin_unlock(&dcache_lock);
> > +	if (count)
> > +		*count = cnt;
> > +}
> > +
> >  /**
> >   * prune_dcache - shrink the dcache
> >   * @count: number of entries to try and free
> > @@ -392,42 +456,44 @@ static inline void prune_one_dentry(stru
> >   
> >  static void prune_dcache(int count)
> >  {
> > -	spin_lock(&dcache_lock);
> > -	for (; count ; count--) {
> > -		struct dentry *dentry;
> > -		struct list_head *tmp;
> > -
> > -		cond_resched_lock(&dcache_lock);
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
> > +			continue;
> > +		/* Found the next superblock to work on.
> > +		 * Move the hand forwards so that parallel
> > +		 * pruners will work on a different sb */
> > +		work_done++;
> > +		sb_hand = sb_entry(sb->s_list.next);
> > +		sb->s_count++;
> > +		spin_unlock(&sb_lock);
> > +
> > +		/* we don't take the s_umount lock here because
> > +		 * because we can be called already holding a
> > +		 * write lock on a superblock */
> 
> You can use trylock. Please see the patches in -mm to fix the umount
> race.

I'm not sure what unmount race you are talking about.

AFAICT, there is no race here - we've got a reference on the superblock so  it
can't go away and the lru list is protected by the dcache_lock, so there's
nothing else we can race with. However, we can deadlock by taking the
s_umount lock here. So why even bother to try to take the lock when we don't
actually need it?

> > +		if (!list_empty(&sb->s_dentry_lru))
> > +			__shrink_dcache_sb(sb, &count, DCACHE_REFERENCED);
> >  
> > -		tmp = dentry_unused.prev;
> > -		if (tmp == &dentry_unused)
> > +		spin_lock(&sb_lock);
> > +		if (__put_super_and_need_restart(sb) && count)
> > +			goto restart;
> 
> Comment please.

I'm not sure what a comment needs to explain that the code doesn't.
Which bit do you think needs commenting?

> > -	spin_unlock(&dcache_lock);
> > +	if (!work_done) {
> > +		/* sb_hand is stale. Start and the beginning of the
> > +		 * list again. */

*nod*

> >  }
> >  
> >  /*
> > @@ -454,41 +520,7 @@ static void prune_dcache(int count)
> >  
> >  void shrink_dcache_sb(struct super_block * sb)
> >  {
> > -	struct list_head *tmp, *next;
> > -	struct dentry *dentry;
> > -
> > -	/*
> > -	 * Pass one ... move the dentries for the specified
> > -	 * superblock to the most recent end of the unused list.
> > -	 */
> > -	spin_lock(&dcache_lock);
> > -	list_for_each_safe(tmp, next, &dentry_unused) {
> > -		dentry = list_entry(tmp, struct dentry, d_lru);
> > -		if (dentry->d_sb != sb)
> > -			continue;
> > -		list_del(tmp);
> > -		list_add(tmp, &dentry_unused);
> > -	}
> > -
> > -	/*
> > -	 * Pass two ... free the dentries for this superblock.
> > -	 */
> > -repeat:
> > -	list_for_each_safe(tmp, next, &dentry_unused) {
> > -		dentry = list_entry(tmp, struct dentry, d_lru);
> > -		if (dentry->d_sb != sb)
> > -			continue;
> > -		dentry_stat.nr_unused--;
> > -		list_del_init(tmp);
> > -		spin_lock(&dentry->d_lock);
> > -		if (atomic_read(&dentry->d_count)) {
> > -			spin_unlock(&dentry->d_lock);
> > -			continue;
> > -		}
> > -		prune_one_dentry(dentry);
> > -		goto repeat;
> > -	}
> > -	spin_unlock(&dcache_lock);
> > +	__shrink_dcache_sb(sb, NULL, 0);
> >  }
> >  
> >  /*
> > @@ -572,17 +604,13 @@ resume:
> >  		struct dentry *dentry = list_entry(tmp, struct dentry, d_u.d_child);
> >  		next = tmp->next;
> >  
> > -		if (!list_empty(&dentry->d_lru)) {
> > -			dentry_stat.nr_unused--;
> > -			list_del_init(&dentry->d_lru);
> > -		}
> > +		dentry_lru_del_init(dentry);
> >  		/* 
> >  		 * move only zero ref count dentries to the end 
> >  		 * of the unused list for prune_dcache
> >  		 */
> >  		if (!atomic_read(&dentry->d_count)) {
> > -			list_add(&dentry->d_lru, dentry_unused.prev);
> > -			dentry_stat.nr_unused++;
> > +			dentry_lru_add_tail(dentry);
> >  			found++;
> >  		}
> 
> This should not be required with per super-block dentries. The only
> reason, I think we moved dentries to the tail is to club all entries
> from the sb together (to free them all at once).

I think we still need to do that. We get called in contexts that aren't
related to unmounting, so we want these dentries to be the first
to be reclaimed from that superblock when we next call prune_dcache().

> > @@ -657,18 +685,14 @@ void shrink_dcache_anon(struct hlist_hea
> >  		spin_lock(&dcache_lock);
> >  		hlist_for_each(lp, head) {
> >  			struct dentry *this = hlist_entry(lp, struct dentry, d_hash);
> > -			if (!list_empty(&this->d_lru)) {
> > -				dentry_stat.nr_unused--;
> > -				list_del_init(&this->d_lru);
> > -			}
> >  
> > +			dentry_lru_del_init(this);
> >  			/* 
> >  			 * move only zero ref count dentries to the end 
> >  			 * of the unused list for prune_dcache
> >  			 */
> >  			if (!atomic_read(&this->d_count)) {
> > -				list_add_tail(&this->d_lru, &dentry_unused);
> > -				dentry_stat.nr_unused++;
> > +				dentry_lru_add_tail(this);
> >  				found++;
> >  			}
> >  		}
> 
> This might still be required. Do you want to split out the anonymous dcache
> entries as well? I am not sure what their superblock points to.

No. Right now I just want to fix the problem that has been reported with
shrink_dcache_sb().

> 
> 
> 
> 
> 	Balbir Singh,
> 	Linux Technology Center,
> 	IBM Software Labs

-- 
Dave Chinner
R&D Software Enginner
SGI Australian Software Group
