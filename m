Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752037AbWCHCRn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752037AbWCHCRn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 21:17:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752036AbWCHCRn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 21:17:43 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:52668 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1752037AbWCHCRm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 21:17:42 -0500
Date: Wed, 8 Mar 2006 07:47:31 +0530
From: Balbir Singh <balbir@in.ibm.com>
To: Neil Brown <neilb@suse.de>
Cc: Kirill Korotaev <dev@sw.ru>, Balbir Singh <bsingharora@gmail.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Olaf Hering <olh@suse.de>, Jan Blunck <jblunck@suse.de>,
       Kirill Korotaev <dev@openvz.org>, Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH] Busy inodes after unmount, be more verbose in generic_shutdown_super
Message-ID: <20060308021731.GA29327@in.ibm.com>
Reply-To: balbir@in.ibm.com
References: <17414.38749.886125.282255@cse.unsw.edu.au> <17419.53761.295044.78549@cse.unsw.edu.au> <661de9470603052332s63fd9b2crd60346324af27fbf@mail.gmail.com> <17420.59580.915759.44913@cse.unsw.edu.au> <440D2536.60005@sw.ru> <17422.9555.635650.460131@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17422.9555.635650.460131@cse.unsw.edu.au>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So: we seem to have two different approaches to solving this problem.
> 
> One is to stop any other thread from calling dentry_iput while the
> umount is running generic_shutdown_super.  This cannot be done with
> the PF_MEMALLOC trick and so would require calls to prune_dcache to
> state their intentions (e.g. pass a 'struct super_block *').
> With this approach, generic_shutdown_super needs to wait for stray
> pruning to finish after marking the superblock as being unmounted, and
> before shrinking the dcache.
> 
> The other is to allow other threads to call dentry_iput at any time,
> but to keep track of them, and to wait for all to finish after
> pruning all the filesystem's dentries.  This requires the extra
> locking in prune_one_dentry to make sure we dput the parent before
> releasing dcache_lock.
> 
> Of these two, I prefer the former, because fiddling with the locking
> in prune_one_dentry is rather intrusive.
> 
> Also, the recent 
>    nfs-permit-filesystem-to-override-root-dentry-on-mount.patch 
> patch in -mm means that generic_shutdown_super does not call
> prune_dcache but has it's own pruning code.  This means there is no
> longer a need to pass intentions to prune_dcache.  Prune_dcache can
> always ignore dentries with s->root==NULL, and shrink_dcache_sb only
> works with it's own dentries.
> 
> So: blending the better bits of various patches together, I've come up
> with the following.  It still needs a changelog entry, but does anyone
> want to ACK it ???

I think this patch is much more cleaner and refined.

>From yesterdays comments I am beginning to wonder if it is enough to solve
only the unmount race or should the fix be more generic to address the race
between the shrinkers call to shrink_dcache_memory() and shrink_dcache_parent().

>From what I understand of the race, the race occurs when dput of the
parent fails to happen and because the referecne count is not 0,
shrink_dcache_parent() skips over those dentries. The race occurs for
the dentry and its ancestors above 

I was wondering if the following would work (to solve the generic race)

Add a prune_mutex to the super-block. Hold on to it in prune_one_dentry()
until we hit a parent dentry that is a mount point (d_mounted > 0) or
the parent has a reference count > 1 or at the end of prune_one_dentry().
This should ensure that for each super block dentry counts are consistent.
Also get select_parent() to hold the super block's prune_mutex, so that it
sees a consistent view of the super block.

Oh! now that I think about it, I think your solution looks like an
elegant way to do the same thing. The only draw back is that it solves
only the unmount race and there are some changes in generic_shutdown_super()
which I do not understand.

Please find some comments for your patch below

> 
> Thanks,
> NeilBrown
> 
> Signed-off-by: Neil Brown <neilb@suse.de>
> 
> ### Diffstat output
>  ./fs/dcache.c            |   32 ++++++++++++++++++++++++++++++--
>  ./fs/super.c             |    3 +++
>  ./include/linux/dcache.h |    1 +
>  ./include/linux/fs.h     |    3 +++
>  4 files changed, 37 insertions(+), 2 deletions(-)
> 
> diff ./fs/dcache.c~current~ ./fs/dcache.c
> --- ./fs/dcache.c~current~	2006-03-08 10:42:56.000000000 +1100
> +++ ./fs/dcache.c	2006-03-08 11:24:11.000000000 +1100
> @@ -364,17 +364,43 @@ restart:
>   */
>  static inline void prune_one_dentry(struct dentry * dentry)
>  {
> +	struct super_block *sb = dentry->d_sb;
>  	struct dentry * parent;
>  
>  	__d_drop(dentry);
>  	list_del(&dentry->d_u.d_child);
>  	dentry_stat.nr_dentry--;	/* For d_free, below */
> +	sb->s_prunes++;
>  	dentry_iput(dentry);
>  	parent = dentry->d_parent;
>  	d_free(dentry);
>  	if (parent != dentry)
>  		dput(parent);
>  	spin_lock(&dcache_lock);
> +	sb->s_prunes--;
> +	if (waitqueue_active(&sb->s_wait_prunes))
> +		wake_up(&sb->s_wait_prunes);
> +}
> +
> +/* As prune_one_dentry can hold an input with calling
> + * dentry_iput, generic_shutdown_super needs to wait for any
> + * pending pruning to stop before doing it's own dentry
> + * pruning.
> + */
> +void wait_on_prunes(struct super_block *sb)
> +{
> +	DEFINE_WAIT(w);
> +	spin_lock(&dcache_lock);
> +	for (;;) {
> +		prepare_to_wait(&sb->s_wait_prunes, &w, TASK_UNINTERRUPTIBLE);
> +		if (sb->s_prunes == 0)
> +			break;
> +		spin_unlock(&dcache_lock);
> +		schedule();
> +		spin_lock(&dcache_lock);
> +	}
> +	spin_unlock(&dcache_lock);
> +	finish_wait(&sb->s_wait_prunes, &w);
>  }
>  
>  /**
> @@ -417,8 +443,10 @@ static void prune_dcache(int count)
>   			spin_unlock(&dentry->d_lock);
>  			continue;
>  		}
> -		/* If the dentry was recently referenced, don't free it. */
> -		if (dentry->d_flags & DCACHE_REFERENCED) {
> +		/* If the dentry was recently referenced, or if the filesystem
> +		 * is being unmounted, don't free it. */
> +		if ((dentry->d_flags & DCACHE_REFERENCED) ||
> +		    dentry->d_sb->s_root == NULL) {
>  			dentry->d_flags &= ~DCACHE_REFERENCED;
>   			list_add(&dentry->d_lru, &dentry_unused);
>   			dentry_stat.nr_unused++;
> 
> diff ./fs/super.c~current~ ./fs/super.c
> --- ./fs/super.c~current~	2006-03-08 10:50:37.000000000 +1100
> +++ ./fs/super.c	2006-03-08 11:02:12.000000000 +1100
> @@ -81,6 +81,8 @@ static struct super_block *alloc_super(v
>  		mutex_init(&s->s_dquot.dqio_mutex);
>  		mutex_init(&s->s_dquot.dqonoff_mutex);
>  		init_rwsem(&s->s_dquot.dqptr_sem);
> +		s->s_prunes = 0;
> +		init_waitqueue_head(&s->s_wait_prunes);
>  		init_waitqueue_head(&s->s_wait_unfrozen);
>  		s->s_maxbytes = MAX_NON_LFS;
>  		s->dq_op = sb_dquot_ops;
> @@ -231,6 +233,7 @@ void generic_shutdown_super(struct super
>  
>  	if (root) {
>  		sb->s_root = NULL;
> +		wait_on_prunes(sb);
>  		shrink_dcache_sb(sb);

Hmm... in 2.6.16-rc5, I see

shrink_dcache_parent(root);
shrink_dcache_anon(&sb->sb_anon);

without these calls, some dentries might not get moved to LRU list.

Am I missing something here?

[snip]

Balbir
