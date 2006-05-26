Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030250AbWEZDBi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030250AbWEZDBi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 23:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030229AbWEZDBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 23:01:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20920 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030212AbWEZDBh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 23:01:37 -0400
Date: Thu, 25 May 2006 20:01:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Chinner <dgc@sgi.com>
Cc: balbir@in.ibm.com, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH]  Per-superblock unused dentry LRU lists V3
Message-Id: <20060525200100.142b2124.akpm@osdl.org>
In-Reply-To: <20060526023536.GN8069029@melbourne.sgi.com>
References: <20060526023536.GN8069029@melbourne.sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Chinner <dgc@sgi.com> wrote:
>
> Per superblock dentry LRU lists.
> 
> ...
>
> +/*
> + * Shrink the dentry LRU on a given superblock.
> + *
> + * If flags is non-zero, we need to do special processing based on
> + * which flags are set. This means we don't need to maintain multiple
> + * similar copies of this loop.
> + */
> +static void __shrink_dcache_sb(struct super_block *sb, int *count, int flags)
> +{
> +	struct dentry *dentry;
> +	int cnt = *count;
> +
> +	spin_lock(&dcache_lock);
> +	while (!list_empty(&sb->s_dentry_lru) && cnt--) {
> +		dentry = list_entry(sb->s_dentry_lru.prev,
> +					struct dentry, d_lru);
> +		dentry_lru_del_init(dentry);
> +		BUG_ON(dentry->d_sb != sb);
> +		prefetch(sb->s_dentry_lru.prev);
> +
> +		spin_lock(&dentry->d_lock);
> +		/*
> +		 * We found an inuse dentry which was not removed from
> +		 * the LRU because of laziness during lookup.  Do not free
> +		 * it - just keep it off the LRU list.
> +		 */
> +		if (atomic_read(&dentry->d_count)) {
> +			spin_unlock(&dentry->d_lock);
> +			continue;
> +		}
> +		/*
> +		 * If we are honouring the DCACHE_REFERENCED flag and the
> +		 * dentry has this flag set, don't free it. Clear the flag
> +		 * and put it back on the LRU
> +		 */
> +		if ((flags & DCACHE_REFERENCED) &&
> +		    (dentry->d_flags & DCACHE_REFERENCED)) {
> +			dentry->d_flags &= ~DCACHE_REFERENCED;
> +			dentry_lru_add(dentry);
> +			spin_unlock(&dentry->d_lock);
> +			continue;

Here we put the dentry back onto the list which we're currently scanning. 
So if `cnt' exceeds the number of dentries on this superblock we end up
scanning some of them more than once.

Seems odd.

> -static void prune_dcache(int count, struct super_block *sb)
> +static void prune_dcache(int count)
>  {
>
> ...
>
> +	struct super_block *sb;
> +	static struct super_block *sb_hand = NULL;
> +	int work_done = 0;
> +
> +	spin_lock(&sb_lock);
> +	if (sb_hand == NULL)
> +		sb_hand = sb_entry(super_blocks.next);
> +restart:
> +	list_for_each_entry(sb, &super_blocks, s_list) {
> +		if (sb != sb_hand)
>  			continue;
> -		}
>  		/*
> -		 * If the dentry is not DCACHED_REFERENCED, it is time
> -		 * to remove it from the dcache, provided the super block is
> -		 * NULL (which means we are trying to reclaim memory)
> -		 * or this dentry belongs to the same super block that
> -		 * we want to shrink.
> +		 * Found the next superblock to work on.  Move the hand
> +		 * forwards so that parallel pruners work on a different sb
>  		 */
> +		work_done++;
> +		sb_hand = sb_entry(sb->s_list.next);
> +		sb->s_count++;
> +		spin_unlock(&sb_lock);

Now sb_hand points at a superblock against which we have no reference.  How
can we use sb_hand safely next time we call in here?  It could point at a
now-freed superblock?

A better approach might be to rotate the super_blocks list as we walk
through it, so the search always starts at super_blocks.next - that way,
there's no need to introduce a new global to record where we're up to.

>  		/*
> -		 * If this dentry is for "my" filesystem, then I can prune it
> -		 * without taking the s_umount lock (I already hold it).
> +		 * We need to be sure this filesystem isn't being unmounted,
> +		 * otherwise we could race with generic_shutdown_super(), and
> +		 * end up holding a reference to an inode while the filesystem
> +		 * is unmounted.  So we try to get s_umount, and make sure
> +		 * s_root isn't NULL.
>  		 */
> -		if (sb && dentry->d_sb == sb) {
> -			prune_one_dentry(dentry);
> -			continue;
> +		if (down_read_trylock(&sb->s_umount)) {
> +			if ((sb->s_root != NULL) &&
> +			    (!list_empty(&sb->s_dentry_lru))) {
> +				__shrink_dcache_sb(sb, &count,
> +						DCACHE_REFERENCED);

um.  If `count' is 10000 and we have 100 superblocks each with 1000
dentries, we end up scanning the first five to ten (depending upon
DCACHE_REFERENCED density) superblocks to exhaustion and the rest not at
all.  I think.

If so, I'd have thought that we'd be better off putting some balancing
arithmetic in here.

number of dentries to scan on this sb =
	count * (number of dentries on this sb /
		number of dentries in the machine)


