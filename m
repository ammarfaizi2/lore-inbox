Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264961AbUGIPEy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264961AbUGIPEy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 11:04:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264959AbUGIPEy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 11:04:54 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14991 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264966AbUGIPEH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 11:04:07 -0400
Date: Fri, 9 Jul 2004 11:32:42 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Thomas Moestl <moestl@ibr.cs.tu-bs.de>
Cc: linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: umount() and NFS races in 2.4.26
Message-ID: <20040709143242.GB11168@logos.cnet>
References: <20040708180709.GA7704@timesink.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040708180709.GA7704@timesink.dyndns.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 08, 2004 at 08:07:09PM +0200, Thomas Moestl wrote:
> Hi,

Hi Thomas,

> after deploying an SMP machine at work, we started to experience Oopses
> in file-system related code relatively frequently. Investigation
> revealed that they were caused by references using junk pointers from
> freed super blocks via dangling inodes from unmounted file systems;
> Oopses would always be preceded by the warning
>   VFS: Busy inodes after unmount. Self-destruct in 5 seconds.  Have a nice day...
> on an unmount (unmount activity is high on this machine due to heavy use
> of the automounter). The predecessor to this machine, a UP system with
> otherwise almost identical configuration, did never encounter such
> problems, so I went looking for possible SMP races.
> 
> I believe that I have found two problems:
> 
> - The NFS async unlink code (fs/nfs/unlink.c) does keep a dentry for
>   later asynchronous processing, but the mount point is unbusied via
>   path_release() once sys_unlink() returns (fs/namei.c). While it
>   does a dget() on the dentry, this is insufficient to prevent an
>   umount(); when one would happen in the right time window, it seems
>   that it would initially get past the busy check:
> 	if (atomic_read(&mnt->mnt_count) == 2 || flags & MNT_DETACH) {
>   (fs/namespace.c, do_umount()), but invalidate_inodes() in kill_super()
>   (fs/super.c) would then fail because of the inode referenced from
>   the dentry needed for the async unlink (which cannot be removed
>   by shrink_dcache_parent() because the NFS code did dget() it).
> 
>   Please note that this problem is only conjectured, as it turned out
>   to not be our culprit. It looks not completely trivial to fix to me,
>   I believe it might require some changes that would affect other FS
>   implementations. It is not a true SMP race, if it exists it would
>   affect UP systems as well.

Trond?

> - There is a SMP race between the shrink_dcache_parent() (fs/dcache.c)
>   called from kill_super() and prune_dache() called via
>   shrink_dache_memory() (called by kswapd), as follows:
>   shrink_dache_parent() calls select_parent() to both prepare the LRU
>   list for purge_cache() and return the number of unused dcache
>   entries that can likely be removed in the next prune_dache() run.
>   If select_parent() returns 0, shrink_dcache_parent() assumes that
>   its work is done and returns. Now, assume for simplicity that there
>   are only two remaining dcache entries: one for "foo/bar" and for
>   the directory "foo/", which is referenced by the "foo/bar" entry.
>   Furthermore, prune_dcache() is currently running, called from kswapd,
>   and has decided to remove the "foo/bar" entry. To that end, it
>   calls prune_one_dentry(), which dentry_iput()s then "foo/bar" dentry.
>   This causes the dache_lock() to be dropped. Just now select_parent()
>   comes along, and can obtain the dcache_lock(). It now looks for unused
>   dentries; but there is only the "foo/" one left, which has a non-zero
>   d_count because "foo/bar" referenced it as parent, and
>   prune_one_dentry() did not yet have a chance to dput() it because it
>   has to wait for the dcache_lock(). Thus, select_parent() finds no
>   unused dentries, assumes that all is fine and does not purge any
>   more; the "foo/" entry can remain in the cache for much longer
>   because it may have DCACHE_REFERENCED set, so that the kswapd
>   purge_dcache() will leave it alone. The inode corresponding to the
>   dangling dcache entry will still be referenced, and end up dangling,
>   too. kill_super() will print the warning mentioned above.
>   When dentry or inode are touched again later (for example in another
>   purge_dcache() later on) we can end up accessing the super block
>   freed during the unmount, leading to an Oops.
>   This was partially verified by inspecting the dcache state via
>   /dev/kmem after the busy inodes warning had occured (the directory
>   dentry was not busy any more, but still remained in the unused list).
> 
>   In the attached patch, I have used a semaphore to serialize purging
>   accesses to the dentry_unused list. With a kernel so patched, the
>   problem seems to have disappeared. The patch is just a quick hack,
>   the semantics of the semaphore is not really well-defined; but maybe
>   it can serve as a starting point.

This is a fastpath, adding a semaphore here is not a Good Thing from the
performance POV.

Maybe shrink_dcache_parent() when called from kill_super() could be more
picky and loop again when a used dentry is found? I feel that
something along these line could make the problem go away without the
need for a slow sleep-lock.

Thanks for the detailed description of the problem.

> I have not checked whether any of these issues pertain to the 2.6 series
> as well.
> 
> 	- Thomas
> 
> P.S: please CC me in replies, as I am not subscribed to this list.
> 

> --- dcache.c.orig	Wed Jun 16 00:22:03 2004
> +++ dcache.c	Wed Jun 16 01:00:47 2004
> @@ -51,6 +51,7 @@
>  static unsigned int d_hash_shift;
>  static struct list_head *dentry_hashtable;
>  static LIST_HEAD(dentry_unused);
> +struct semaphore dcache_lru_sem;
>  
>  /* Statistics gathering. */
>  struct dentry_stat_t dentry_stat = {0, 0, 45, 0,};
> @@ -381,6 +382,7 @@
>  	struct list_head *tmp, *next;
>  	struct dentry *dentry;
>  
> +	down(&dcache_lru_sem);
>  	/*
>  	 * Pass one ... move the dentries for the specified
>  	 * superblock to the most recent end of the unused list.
> @@ -416,6 +418,7 @@
>  		goto repeat;
>  	}
>  	spin_unlock(&dcache_lock);
> +	up(&dcache_lru_sem);
>  }
>  
>  /*
> @@ -548,8 +551,10 @@
>  {
>  	int found;
>  
> +	down(&dcache_lru_sem);
>  	while ((found = select_parent(parent)) != 0)
>  		prune_dcache(found);
> +	up(&dcache_lru_sem);
>  }
>  
>  /*
> @@ -581,9 +586,11 @@
>  	if (!(gfp_mask & __GFP_FS))
>  		return 0;
>  
> +	down(&dcache_lru_sem);
>  	count = dentry_stat.nr_unused / priority;
>  
>  	prune_dcache(count);
> +	up(&dcache_lru_sem);
>  	return kmem_cache_shrink(dentry_cache);
>  }
>  
> @@ -1247,6 +1254,7 @@
>  		d++;
>  		i--;
>  	} while (i);
> +	sema_init(&dcache_lru_sem, 1);
>  }
>  
>  static void init_buffer_head(void * foo, kmem_cache_t * cachep, unsigned long flags)

