Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261599AbUL3Ngo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261599AbUL3Ngo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 08:36:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261636AbUL3Ngo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 08:36:44 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:47768 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261599AbUL3Nfs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 08:35:48 -0500
Date: Thu, 30 Dec 2004 19:04:00 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [Patch] Delete sysfs_dirent.s_count, saving ~100kB on my system
Message-ID: <20041230133400.GA3122@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <200412011856.iB1IuAc21682@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412011856.iB1IuAc21682@adam.yggdrasil.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2004 at 07:09:18PM +0000, Adam J. Richter wrote:
> Hi Maneesh,
> 
> 	Here is a rewrite of my patch to remove sysfs_dirent.s_count,
> reducing the memory chunk that kmalloc uses for sysfs_dirent from
> 64 to 32 bytes, thereby saving about 120kB for the 3700+ nodes in
> /sys on the ordinary PC on which I am typing this message.
> 
> 	Unlike my original patch, this version retains
> sysfs_dentry_ops, because, as you correctly pointed out, the
> current implementation uses sysfs_dirent for file-descriptor
> based operations that can still be done after a node has
> been unlinked.  I still might seek to eliminate sysfs_dentry_ops
> in a future patch, but there are other steps I would
> like to pursue first.
> 
> 	This version replaces the check on sysfs_dirent.s_count
> with a check that syfs_dirent.s_dentry is NULL and that the
> sysfs_dirent is not linked into the directory tree.  If both of
> those conditions are satisfied, then sysfs_dirent is freed.
> 
> 	Note that in sysfs_remove_dir and sysfs_hash_and_remove
> I had to move the call to list_del_init(&sd->s_sibling) to occur
> just before the call to sysfs_put() to avoid confusion that
> can occur in another call to syfs_put() that the previously
> intervening call to sysfs_drop_dentry() could cause.
> 
> 	By the way, I ran a version of sysfs_put that kept the
> reference counting, calculated this new check and would complain if
> the two checks produced a different result, and I saw no complaints,
> including while I ran the test that you previously proposed
> for a while (loading and unloading the dummy networking modules,
> while running "ls -lR" on the /sys and cat'ing of the networking
> /sys files).
> 
> 	I have also run this cleaned up patch with the same test for
> a while with no problems (unlike the situation with my original patch).
> 
> 	So, if you could take a look at it and send it downstream
> for integration if it looks good to you, I would appreciate it.
> I would like to get this patch integrated before I try to implement
> further reductions in pinned memory for sysfs.  After this patch,
> I hope to make a patch to unpin the inode and dentry structures for
> sysfs directories, and then perhaps a patch changing attribute groups
> to have just one sysfs_dirent for the group instead of one for each
> attribute (individual attributes registered directly to a kobject
> would still need one sysfs_dirent each).
> 
> 	Please let me know what you think.
> 

Sorry for very late response due to vacations and transitions. I am
looking at the all the patches from you, not yet in any tree and
hopefully will not miss any.

s_count never increases after 2, one at the time of sysfs_dirent
creation and the other count while connecting sysfs_dirent with the dentry.
So, it should be fine without it. I kept it thinking that it might help in
unpinning directories also. The patch looks good but I think, as usual this 
will also need testing in -mm for some time. 

Thanks
Maneesh

>                     __     ______________
> Adam J. Richter        \ /
> adam@yggdrasil.com      | g g d r a s i l
> 
> 
> --- linux-2.6.10-rc2-bk13/include/linux/sysfs.h	2004-11-17 18:59:17.000000000 +0800
> +++ linux/include/linux/sysfs.h	2004-12-02 01:18:12.000000000 +0800
> @@ -60,7 +60,6 @@
>  };
>  
>  struct sysfs_dirent {
> -	atomic_t		s_count;
>  	struct list_head	s_sibling;
>  	struct list_head	s_children;
>  	void 			* s_element;
> diff -u linux-2.6.10-rc2-bk13/fs/sysfs/dir.c linux/fs/sysfs/dir.c
> --- linux-2.6.10-rc2-bk13/fs/sysfs/dir.c	2004-12-01 11:02:42.000000000 +0800
> +++ linux/fs/sysfs/dir.c	2004-12-02 00:06:12.000000000 +0800
> @@ -41,7 +41,6 @@
>  		return NULL;
>  
>  	memset(sd, 0, sizeof(*sd));
> -	atomic_set(&sd->s_count, 1);
>  	INIT_LIST_HEAD(&sd->s_children);
>  	list_add(&sd->s_sibling, &parent_sd->s_children);
>  	sd->s_element = element;
> @@ -62,7 +61,7 @@
>  	sd->s_type = type;
>  	sd->s_dentry = dentry;
>  	if (dentry) {
> -		dentry->d_fsdata = sysfs_get(sd);
> +		dentry->d_fsdata = sd;
>  		dentry->d_op = &sysfs_dentry_ops;
>  	}
>  
> @@ -180,7 +179,7 @@
>  		dentry->d_inode->i_fop = &bin_fops;
>  	}
>  	dentry->d_op = &sysfs_dentry_ops;
> -	dentry->d_fsdata = sysfs_get(sd);
> +	dentry->d_fsdata = sd;
>  	sd->s_dentry = dentry;
>  	d_rehash(dentry);
>  
> @@ -194,7 +193,7 @@
>  	err = sysfs_create(dentry, S_IFLNK|S_IRWXUGO, init_symlink);
>  	if (!err) {
>  		dentry->d_op = &sysfs_dentry_ops;
> -		dentry->d_fsdata = sysfs_get(sd);
> +		dentry->d_fsdata = sd;
>  		sd->s_dentry = dentry;
>  		d_rehash(dentry);
>  	}
> @@ -280,8 +279,8 @@
>  	list_for_each_entry_safe(sd, tmp, &parent_sd->s_children, s_sibling) {
>  		if (!sd->s_element || !(sd->s_type & SYSFS_NOT_PINNED))
>  			continue;
> -		list_del_init(&sd->s_sibling);
>  		sysfs_drop_dentry(sd, dentry);
> +		list_del_init(&sd->s_sibling);
>  		sysfs_put(sd);
>  	}
>  	up(&dentry->d_inode->i_sem);
> diff -u linux-2.6.10-rc2-bk13/fs/sysfs/inode.c linux/fs/sysfs/inode.c
> --- linux-2.6.10-rc2-bk13/fs/sysfs/inode.c	2004-11-17 18:59:13.000000000 +0800
> +++ linux/fs/sysfs/inode.c	2004-12-02 00:05:25.000000000 +0800
> @@ -149,8 +149,8 @@
>  		if (!sd->s_element)
>  			continue;
>  		if (!strcmp(sysfs_get_name(sd), name)) {
> -			list_del_init(&sd->s_sibling);
>  			sysfs_drop_dentry(sd, dir);
> +			list_del_init(&sd->s_sibling);
>  			sysfs_put(sd);
>  			break;
>  		}
> diff -u linux-2.6.10-rc2-bk13/fs/sysfs/sysfs.h linux/fs/sysfs/sysfs.h
> --- linux-2.6.10-rc2-bk13/fs/sysfs/sysfs.h	2004-11-17 18:59:13.000000000 +0800
> +++ linux/fs/sysfs/sysfs.h	2004-12-02 00:05:35.000000000 +0800
> @@ -77,18 +77,8 @@
>  	kfree(sd);
>  }
>  
> -static inline struct sysfs_dirent * sysfs_get(struct sysfs_dirent * sd)
> -{
> -	if (sd) {
> -		WARN_ON(!atomic_read(&sd->s_count));
> -		atomic_inc(&sd->s_count);
> -	}
> -	return sd;
> -}
> -
>  static inline void sysfs_put(struct sysfs_dirent * sd)
>  {
> -	if (atomic_dec_and_test(&sd->s_count))
> +	if (list_empty(&sd->s_sibling) && sd->s_dentry == NULL)
>  		release_sysfs_dirent(sd);
>  }
> -
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Maneesh Soni
Linux Technology Center, 
IBM India Software Labs,
Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-25044990
