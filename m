Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751954AbWCFHcv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751954AbWCFHcv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 02:32:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752029AbWCFHcv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 02:32:51 -0500
Received: from xproxy.gmail.com ([66.249.82.193]:17814 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751954AbWCFHcu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 02:32:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iPVHT5kbWTfBTZI3R85r/ws90Oa53AJvrpQXqX4xjAMIC33JuB/xoc9VVtA0d6+Yg9fSHqoF6fJ5fqjm4kSnqim5pCSoQ73rIJNPbtCzou2MHfJF3PeKnZG5vJPo90xG62H2WGQBPlWkVoW7oi0uxqNposaHk/lwOZWGv0wPA/0=
Message-ID: <661de9470603052332s63fd9b2crd60346324af27fbf@mail.gmail.com>
Date: Mon, 6 Mar 2006 13:02:49 +0530
From: "Balbir Singh" <bsingharora@gmail.com>
To: "Neil Brown" <neilb@suse.de>
Subject: Re: [PATCH] Busy inodes after unmount, be more verbose in generic_shutdown_super
Cc: linux-kernel@vger.kernel.org, "Andrew Morton" <akpm@osdl.org>,
       "Olaf Hering" <olh@suse.de>, "Jan Blunck" <jblunck@suse.de>,
       "Kirill Korotaev" <dev@openvz.org>, "Al Viro" <viro@ftp.linux.org.uk>
In-Reply-To: <17419.53761.295044.78549@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <17414.38749.886125.282255@cse.unsw.edu.au>
	 <17419.53761.295044.78549@cse.unsw.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
>
> Thanks,
> NeilBrown
>

The code changes look big, have you looked at
http://marc.theaimsgroup.com/?l=linux-kernel&m=113817279225962&w=2

Some top of the head feedback below. Will try and do a detailed review later.

>
> Signed-off-by: Neil Brown <neilb@suse.de>
>
> ### Diffstat output
>  ./fs/dcache.c        |   17 +++++++++++++----
>  ./fs/super.c         |   11 +++++++++++
>  ./include/linux/fs.h |    2 ++
>  3 files changed, 26 insertions(+), 4 deletions(-)
>
> diff ./fs/dcache.c~current~ ./fs/dcache.c
> --- ./fs/dcache.c~current~      2006-03-06 16:54:59.000000000 +1100
> +++ ./fs/dcache.c       2006-03-06 16:55:33.000000000 +1100
> @@ -366,6 +366,7 @@ static inline void prune_one_dentry(stru
>  {
>         struct dentry * parent;
>
> +       dentry->d_sb->s_pending_iputs ++;
>         __d_drop(dentry);
>         list_del(&dentry->d_u.d_child);
>         dentry_stat.nr_dentry--;        /* For d_free, below */
> @@ -375,6 +376,9 @@ static inline void prune_one_dentry(stru
>         if (parent != dentry)
>                 dput(parent);
>         spin_lock(&dcache_lock);
> +       dentry->d_sb->s_pending_iputs --;
> +       if (dentry->d_sb->s_pending_iputs < 0)
> +               wake_up(&dentry->d_sb->s_wait_unfrozen);
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
>         spin_lock(&dcache_lock);
>         for (; count ; count--) {
> @@ -407,6 +411,11 @@ static void prune_dcache(int count)
>                 dentry_stat.nr_unused--;
>                 dentry = list_entry(tmp, struct dentry, d_lru);
>
> +               if (dentry->d_sb->s_root == NULL &&
> +                   (parent == NULL ||
> +                    parent->d_sb != dentry->d_sb))
> +                       continue;
> +
>                 spin_lock(&dentry->d_lock);
>                 /*
>                  * We found an inuse dentry which was not removed from
> @@ -635,7 +644,7 @@ void shrink_dcache_parent(struct dentry
>         int found;
>
>         while ((found = select_parent(parent)) != 0)
> -               prune_dcache(found);
> +               prune_dcache(found, parent);
>  }
>
>  /**
> @@ -673,7 +682,7 @@ void shrink_dcache_anon(struct hlist_hea
>                         }
>                 }
>                 spin_unlock(&dcache_lock);
> -               prune_dcache(found);
> +               prune_dcache(found, NULL);
>         } while(found);
>  }
>
> @@ -694,7 +703,7 @@ static int shrink_dcache_memory(int nr,
>         if (nr) {
>                 if (!(gfp_mask & __GFP_FS))
>                         return -1;
> -               prune_dcache(nr);
> +               prune_dcache(nr, NULL);
>         }
>         return (dentry_stat.nr_unused / 100) * sysctl_vfs_cache_pressure;
>  }
>
> diff ./fs/super.c~current~ ./fs/super.c
> --- ./fs/super.c~current~       2006-03-06 16:54:59.000000000 +1100
> +++ ./fs/super.c        2006-03-06 16:57:19.000000000 +1100
> @@ -230,7 +230,18 @@ void generic_shutdown_super(struct super
>         struct super_operations *sop = sb->s_op;
>
>         if (root) {
> +               spin_lock(&dcache_lock);
> +               /* disable stray dputs */
>                 sb->s_root = NULL;
> +
> +               /* trigger a wake_up */
> +               sb->s_pending_iputs --;
> +               spin_unlock(&dcache_lock);
> +               wait_event(sb->s_wait_unfrozen,
> +                          sb->s_pending_iputs < 0);
> +               /* avoid further wakeups */
> +               sb->s_pending_iputs = 65000;

This looks a bit ugly, what is 65000?

> +
>                 shrink_dcache_parent(root);
>                 shrink_dcache_anon(&sb->s_anon);
>                 dput(root);
>
> diff ./include/linux/fs.h~current~ ./include/linux/fs.h
> --- ./include/linux/fs.h~current~       2006-03-06 16:54:59.000000000 +1100
> +++ ./include/linux/fs.h        2006-03-06 12:49:55.000000000 +1100
> @@ -833,6 +833,8 @@ struct super_block {
>         struct hlist_head       s_anon;         /* anonymous dentries for (nfs) exporting */
>         struct list_head        s_files;
>
> +       int                     s_pending_iputs;
> +
>         struct block_device     *s_bdev;
>         struct list_head        s_instances;
>         struct quota_info       s_dquot;        /* Diskquota specific options */
