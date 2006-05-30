Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932310AbWE3PEq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932310AbWE3PEq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 11:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbWE3PEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 11:04:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:22975 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932307AbWE3PEp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 11:04:45 -0400
Date: Tue, 30 May 2006 17:04:38 +0200
From: Jan Blunck <jblunck@suse.de>
To: David Chinner <dgc@sgi.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       Balbir Singh <balbir@in.ibm.com>
Subject: Re: [PATCH] Per-superblock unused dentry LRU lists V3
Message-ID: <20060530150438.GB4377@hasse.suse.de>
References: <20060526023536.GN8069029@melbourne.sgi.com> <4de7f8a60605300753j3b1e257u3849b72e7bc4d100@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4de7f8a60605300753j3b1e257u3849b72e7bc4d100@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> David Chinner <dgc@sgi.com> wrote:
>
> +/*
> + * Shrink the dentry LRU on a given superblock.
> + *
> + * If flags is non-zero, we need to do special processing based on
> + * which flags are set. This means we don't need to maintain multiple
> + * similar copies of this loop.
> + */
> +static void __shrink_dcache_sb(struct super_block *sb, int *count, int 
> flags)
> +{
> +       struct dentry *dentry;
> +       int cnt = *count;
> +
> +       spin_lock(&dcache_lock);
> +       while (!list_empty(&sb->s_dentry_lru) && cnt--) {
> +               dentry = list_entry(sb->s_dentry_lru.prev,
> +                                       struct dentry, d_lru);
> +               dentry_lru_del_init(dentry);
> +               BUG_ON(dentry->d_sb != sb);
> +               prefetch(sb->s_dentry_lru.prev);
> +
> +               spin_lock(&dentry->d_lock);
> +               /*
> +                * We found an inuse dentry which was not removed from
> +                * the LRU because of laziness during lookup.  Do not free
> +                * it - just keep it off the LRU list.
> +                */
> +               if (atomic_read(&dentry->d_count)) {
> +                       spin_unlock(&dentry->d_lock);
> +                       continue;
> +               }
> +               /*
> +                * If we are honouring the DCACHE_REFERENCED flag and the
> +                * dentry has this flag set, don't free it. Clear the flag
> +                * and put it back on the LRU
> +                */
> +               if ((flags & DCACHE_REFERENCED) &&
> +                   (dentry->d_flags & DCACHE_REFERENCED)) {
> +                       dentry->d_flags &= ~DCACHE_REFERENCED;
> +                       dentry_lru_add(dentry);
> +                       spin_unlock(&dentry->d_lock);
> +                       continue;
> +               }
> +               prune_one_dentry(dentry);
> +       }
> +       spin_unlock(&dcache_lock);
> +       *count = cnt;
> +}
> +
> /**
>  * shrink_dcache_sb - shrink dcache for a superblock
>  * @sb: superblock
> @@ -507,44 +529,9 @@ static void prune_dcache(int count, stru
>  * is used to free the dcache before unmounting a file
>  * system
>  */
> -
> void shrink_dcache_sb(struct super_block * sb)
> {
> -       struct list_head *tmp, *next;
> -       struct dentry *dentry;
> -
> -       /*
> -        * Pass one ... move the dentries for the specified
> -        * superblock to the most recent end of the unused list.
> -        */
> -       spin_lock(&dcache_lock);
> -       list_for_each_safe(tmp, next, &dentry_unused) {
> -               dentry = list_entry(tmp, struct dentry, d_lru);
> -               if (dentry->d_sb != sb)
> -                       continue;
> -               list_move(tmp, &dentry_unused);
> -       }
> -
> -       /*
> -        * Pass two ... free the dentries for this superblock.
> -        */
> -repeat:
> -       list_for_each_safe(tmp, next, &dentry_unused) {
> -               dentry = list_entry(tmp, struct dentry, d_lru);
> -               if (dentry->d_sb != sb)
> -                       continue;
> -               dentry_stat.nr_unused--;
> -               list_del_init(tmp);
> -               spin_lock(&dentry->d_lock);
> -               if (atomic_read(&dentry->d_count)) {
> -                       spin_unlock(&dentry->d_lock);
> -                       continue;
> -               }
> -               prune_one_dentry(dentry);
> -               cond_resched_lock(&dcache_lock);
> -               goto repeat;
> -       }
> -       spin_unlock(&dcache_lock);
> +       __shrink_dcache_sb(sb, &sb->s_dentry_lru_nr, 0);
> }

This doesn't prune all the dentries on the unused list. The parents of the
pruned dentries are added to the unused list. Therefore just shrinking
sb->s_dentry_lru_nr dentries isn't enough.

Jan
