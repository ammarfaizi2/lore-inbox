Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932292AbWA3Ol1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932292AbWA3Ol1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 09:41:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932294AbWA3Ol1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 09:41:27 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:51551 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S932292AbWA3Ol1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 09:41:27 -0500
Message-ID: <43DE25F0.6070709@sw.ru>
Date: Mon, 30 Jan 2006 17:42:56 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Jan Blunck <jblunck@suse.de>
CC: viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, olh@suse.de, balbir@in.ibm.com
Subject: Re: [PATCH] shrink_dcache_parent() races against shrink_dcache_memory()
References: <20060120203645.GF24401@hasse.suse.de> <43D48ED4.3010306@sw.ru> <20060130120318.GB9181@hasse.suse.de>
In-Reply-To: <20060130120318.GB9181@hasse.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jan,

this is much cleaner now and looks more like my original patch and is 
smaller/more beautifull with counters usage. Thanks.

However, with counters instead of list it is possible to create a live 
lock :( So I'm not sure it is really ok.
BTW, what kernel is it for? 2.6.15 or 2.6.16-X?

Kirill

>>1. this patch doesn't fix the whole problem. iput() after sb free is 
>>still possible. So busy inodes after umount too.
>>2. it has big problems with locking...
>>
> 
> 
> Uh yeah! I fixed the second issue but since the patch doesnt helped and only
> gots the reference counting a little bit cleaner I don't post it.
> 
> 
>>comments below inside.
>>
> 
> 
> New patch attached below. Comments are welcome.
> 
> Regards,
> 	Jan
> 
> 
> 
> ------------------------------------------------------------------------
> 
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
> +	wait_queue_head_t	s_wait_prunes;
> +
>  	int			s_frozen;
>  	wait_queue_head_t	s_wait_unfrozen;
>  


