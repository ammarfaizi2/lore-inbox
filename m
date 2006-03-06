Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751262AbWCFLwg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbWCFLwg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 06:52:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbWCFLwg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 06:52:36 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:46860 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751262AbWCFLwg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 06:52:36 -0500
Message-ID: <440C236A.90700@openvz.org>
Date: Mon, 06 Mar 2006 14:56:26 +0300
From: Kirill Korotaev <dev@openvz.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Neil Brown <neilb@suse.de>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Olaf Hering <olh@suse.de>, Jan Blunck <jblunck@suse.de>,
       Kirill Korotaev <dev@openvz.org>, Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH] Busy inodes after unmount, be more verbose in generic_shutdown_super
References: <17414.38749.886125.282255@cse.unsw.edu.au> <17419.53761.295044.78549@cse.unsw.edu.au>
In-Reply-To: <17419.53761.295044.78549@cse.unsw.edu.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>Comments?  Please :-?
ok :) see inline.

> Somewhere in among the comments (thanks), I realised that I was only
> closing half the race.  I had tried to make sure there were no stray
> references to any dentries, but there is still the inode which is
> being iput which can cause problem.
> 
> The following patch takes a totally different approach, is based on an
> idea from Jan Kara, and is much less intrusive.
> 
> We:
>   - keep track of "who" is calling prune_dcache, and when a filesystem
>     is being unmounted (s_root == NULL) we only allow the unmount thread
>     to prune dentries.
>   - keep track of how many dentries are in the process of having
>     dentry_iput called on them for pruning
>   - don't allow umount to proceed until that count hits zero
>   - bias the count this way and that to make sure we get a wake_up at
>     the right time
>   - reuse 's_wait_unfrozen' to wait on the iput to complete.
> 
> Again, I'm very keen on feedback.  This race is very hard to trigger,
> so code review is the only real way to evaluate that patch.
hmm... It's not that very hard. I suppose no one ever tried except us.
We have a test which does mounts/umounts and lots of other activity 
which makes memory pressure. AFAIR, it takes us ~3 hours to trigger this 
bug on SMP.

In general your patch is still does what mine do, so I will be happy if 
any of this is commited mainstream. In future, please, keep the 
reference to original authors, this will also make sure that I'm on CC 
if something goes wrong.

Thanks,
Kiril

> Signed-off-by: Neil Brown <neilb@suse.de>
> 
> ### Diffstat output
>  ./fs/dcache.c        |   17 +++++++++++++----
>  ./fs/super.c         |   11 +++++++++++
>  ./include/linux/fs.h |    2 ++
>  3 files changed, 26 insertions(+), 4 deletions(-)
> 
> diff ./fs/dcache.c~current~ ./fs/dcache.c
> --- ./fs/dcache.c~current~	2006-03-06 16:54:59.000000000 +1100
> +++ ./fs/dcache.c	2006-03-06 16:55:33.000000000 +1100
> @@ -366,6 +366,7 @@ static inline void prune_one_dentry(stru
>  {
>  	struct dentry * parent;
>  
> +	dentry->d_sb->s_pending_iputs ++;
>  	__d_drop(dentry);
>  	list_del(&dentry->d_u.d_child);
>  	dentry_stat.nr_dentry--;	/* For d_free, below */
> @@ -375,6 +376,9 @@ static inline void prune_one_dentry(stru
>  	if (parent != dentry)
>  		dput(parent);
>  	spin_lock(&dcache_lock);
> +	dentry->d_sb->s_pending_iputs --;
> +	if (dentry->d_sb->s_pending_iputs < 0)
> +		wake_up(&dentry->d_sb->s_wait_unfrozen);
>  }
>  
>  /**
> @@ -390,7 +394,7 @@ static inline void prune_one_dentry(stru
>   * all the dentries are in use.
>   */
>   
> -static void prune_dcache(int count)
> +static void prune_dcache(int count, struct dentry *parent)
>  {
>  	spin_lock(&dcache_lock);
>  	for (; count ; count--) {
> @@ -407,6 +411,11 @@ static void prune_dcache(int count)
>   		dentry_stat.nr_unused--;
>  		dentry = list_entry(tmp, struct dentry, d_lru);
>  
> +		if (dentry->d_sb->s_root == NULL &&
> +		    (parent == NULL ||
> +		     parent->d_sb != dentry->d_sb))
> +			continue;
<<<<
- we select some dentries in select_parent and then try to prune N 
dentries. But this can be other N dentries :/ It's not the problem with 
your code, but... adding 'parent' arg to prune_dcache() makes me feel 
the same as with 'found' arg: you don't use it actually right way. You 
don't prune only its children, you see? It is better to pass 'sb' arg then.

> +
>   		spin_lock(&dentry->d_lock);
>  		/*
>  		 * We found an inuse dentry which was not removed from
> @@ -635,7 +644,7 @@ void shrink_dcache_parent(struct dentry 
>  	int found;
>  
>  	while ((found = select_parent(parent)) != 0)
> -		prune_dcache(found);
> +		prune_dcache(found, parent);
>  }
>  
>  /**
> @@ -673,7 +682,7 @@ void shrink_dcache_anon(struct hlist_hea
>  			}
>  		}
>  		spin_unlock(&dcache_lock);
> -		prune_dcache(found);
> +		prune_dcache(found, NULL);
>  	} while(found);
>  }
>  
> @@ -694,7 +703,7 @@ static int shrink_dcache_memory(int nr, 
>  	if (nr) {
>  		if (!(gfp_mask & __GFP_FS))
>  			return -1;
> -		prune_dcache(nr);
> +		prune_dcache(nr, NULL);
>  	}
>  	return (dentry_stat.nr_unused / 100) * sysctl_vfs_cache_pressure;
>  }
> 
> diff ./fs/super.c~current~ ./fs/super.c
> --- ./fs/super.c~current~	2006-03-06 16:54:59.000000000 +1100
> +++ ./fs/super.c	2006-03-06 16:57:19.000000000 +1100
> @@ -230,7 +230,18 @@ void generic_shutdown_super(struct super
>  	struct super_operations *sop = sb->s_op;
>  
>  	if (root) {
> +		spin_lock(&dcache_lock);
> +		/* disable stray dputs */
>  		sb->s_root = NULL;
> +
> +		/* trigger a wake_up */
> +		sb->s_pending_iputs --;
> +		spin_unlock(&dcache_lock);
> +		wait_event(sb->s_wait_unfrozen,
> +			   sb->s_pending_iputs < 0);
> +		/* avoid further wakeups */
> +		sb->s_pending_iputs = 65000;
<<< its ulgy... :( why don't you do wait after shrink's and dput(root) 
below?

> +
>  		shrink_dcache_parent(root);
>  		shrink_dcache_anon(&sb->s_anon);
>  		dput(root);
> 
> diff ./include/linux/fs.h~current~ ./include/linux/fs.h
> --- ./include/linux/fs.h~current~	2006-03-06 16:54:59.000000000 +1100
> +++ ./include/linux/fs.h	2006-03-06 12:49:55.000000000 +1100
> @@ -833,6 +833,8 @@ struct super_block {
>  	struct hlist_head	s_anon;		/* anonymous dentries for (nfs) exporting */
>  	struct list_head	s_files;
>  
> +	int			s_pending_iputs;
> +
>  	struct block_device	*s_bdev;
>  	struct list_head	s_instances;
>  	struct quota_info	s_dquot;	/* Diskquota specific options */
> 


