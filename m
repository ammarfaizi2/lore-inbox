Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932291AbWA3Oi3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932291AbWA3Oi3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 09:38:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932294AbWA3Oi3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 09:38:29 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:29349 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932291AbWA3Oi2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 09:38:28 -0500
Date: Mon, 30 Jan 2006 20:08:14 +0530
From: Balbir Singh <balbir@in.ibm.com>
To: Jan Blunck <jblunck@suse.de>
Cc: Kirill Korotaev <dev@sw.ru>, viro@zeniv.linux.org.uk,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       olh@suse.de
Subject: Re: [PATCH] shrink_dcache_parent() races against shrink_dcache_memory()
Message-ID: <20060130143814.GA25817@in.ibm.com>
Reply-To: balbir@in.ibm.com
References: <20060120203645.GF24401@hasse.suse.de> <43D48ED4.3010306@sw.ru> <20060130120318.GB9181@hasse.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060130120318.GB9181@hasse.suse.de>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> New patch attached below. Comments are welcome.
> 
> Regards,
> 	Jan
>
[snip]
 
> From: Jan Blunck <jblunck@suse.de>
> Subject: Fix shrink_dcache_parent() against shrink_dcache_memory() race
> References: 136310
> 
> Kirill Korotaev <dev@sw.ru> discovered a race between shrink_dcache_parent()
> and shrink_dcache_memory() which leads to "Busy inodes after unmount".
> When unmounting a file system shrink_dcache_parent() is racing against a
> possible shrink_dcache_memory(). This might lead to the situation that
> shrink_dcache_parent() is returning too early. In this situation the
> super_block is destroyed before shrink_dcache_memory() could put the inode.
> 
> This patch fixes the problem through introducing a prunes counter which is
> incremented when a dentry is pruned but the corresponding inoded isn't put yet.
> When the prunes counter is not null, shrink_dcache_parent() is waiting and
> restarting its work.
> 
> Signed-off-by: Jan Blunck <jblunck@suse.de>
> 
> ---
> 
>  fs/dcache.c        |   36 ++++++++++++++++++++++++++++++++++++
>  fs/super.c         |    4 +++-
>  include/linux/fs.h |    3 +++
>  3 files changed, 42 insertions(+), 1 deletion(-)
> 
> Index: linux-2.6/fs/dcache.c
> ===================================================================
> --- linux-2.6.orig/fs/dcache.c
> +++ linux-2.6/fs/dcache.c
> @@ -364,17 +364,21 @@ restart:
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
> +	wake_up(&sb->s_wait_prunes);
>  }
>
  
We can think about optimizing this to
   if (!sb->sprunes)
	wake_up(&sb->s_wait_prunes);

>  /**
> @@ -623,6 +627,34 @@ out:
>  	return found;
>  }
>  
> +static int wait_on_prunes(struct super_block *sb)
> +{
> +	DEFINE_WAIT(wait);
> +
> +	spin_lock(&dcache_lock);
> +	if (!sb->s_prunes) {
> +		spin_unlock(&dcache_lock);
> +		return 0;
> +	}
> +
> +	printk(KERN_DEBUG "%s: waiting for %d prunes\n", __FUNCTION__,
> +	       sb->s_prunes);
> +
> +	while (1) {
> +		prepare_to_wait(&sb->s_wait_prunes, &wait,
> +				TASK_UNINTERRUPTIBLE);
> +		if (!sb->s_prunes)
> +			break;
> +		spin_unlock(&dcache_lock);
> +		schedule();
> +		spin_lock(&dcache_lock);
> +	}
> +
> +	finish_wait(&sb->s_wait_prunes, &wait);
> +	spin_unlock(&dcache_lock);
> +	return 1;
> +}
> +
>  /**
>   * shrink_dcache_parent - prune dcache
>   * @parent: parent of entries to prune
> @@ -634,8 +666,12 @@ void shrink_dcache_parent(struct dentry 
>  {
>  	int found;
>  
> + again:
>  	while ((found = select_parent(parent)) != 0)
>  		prune_dcache(found);
> +
> +	if (wait_on_prunes(parent->d_sb))
> +		goto again;
>  }

Is the goto again required? At this point select_parent() should have pruned
all entries, except those missed due to the race. These should be captured
by sb->s_prunes. Once the code comes out of wait_on_prunes() everything
should be ok since a dput has happened on the missed parent dentries.

>  
>  /**
> Index: linux-2.6/fs/super.c
> ===================================================================
> --- linux-2.6.orig/fs/super.c
> +++ linux-2.6/fs/super.c
> @@ -80,6 +80,8 @@ static struct super_block *alloc_super(v
>  		sema_init(&s->s_dquot.dqio_sem, 1);
>  		sema_init(&s->s_dquot.dqonoff_sem, 1);
>  		init_rwsem(&s->s_dquot.dqptr_sem);
> +		s->s_prunes = 0;
> +		init_waitqueue_head(&s->s_wait_prunes);
>  		init_waitqueue_head(&s->s_wait_unfrozen);
>  		s->s_maxbytes = MAX_NON_LFS;
>  		s->dq_op = sb_dquot_ops;
> @@ -230,8 +232,8 @@ void generic_shutdown_super(struct super
>  
>  	if (root) {
>  		sb->s_root = NULL;
> -		shrink_dcache_parent(root);
>  		shrink_dcache_anon(&sb->s_anon);
> +		shrink_dcache_parent(root);
>  		dput(root);
>  		fsync_super(sb);
>  		lock_super(sb);
> Index: linux-2.6/include/linux/fs.h
> ===================================================================
> --- linux-2.6.orig/include/linux/fs.h
> +++ linux-2.6/include/linux/fs.h
> @@ -833,6 +833,9 @@ struct super_block {
>  	struct list_head	s_instances;
>  	struct quota_info	s_dquot;	/* Diskquota specific options */
>  
> +	int			s_prunes;

Can this be an unsigned int? Perhaps you might to mention that is protected
by the dcache_lock.

> +	wait_queue_head_t	s_wait_prunes;
> +
>  	int			s_frozen;
>  	wait_queue_head_t	s_wait_unfrozen;
>  


Your fix seems correct at first sight and good to be included. But could you 
please do a correctness/speed/cost analysis of your fix with the fix I 
previously sent out?

Regards,
Balbir
