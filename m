Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932384AbWG3Rhx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932384AbWG3Rhx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 13:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932385AbWG3Rhx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 13:37:53 -0400
Received: from extu-mxob-1.symantec.com ([216.10.194.28]:42700 "EHLO
	extu-mxob-1.symantec.com") by vger.kernel.org with ESMTP
	id S932384AbWG3Rhw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 13:37:52 -0400
Date: Sun, 30 Jul 2006 18:36:30 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Al Boldi <a1426z@gawab.com>
cc: "H. Peter Anvin" <hpa@zytor.com>, Rob Landley <rob@landley.net>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, stable@kernel.org,
       akpm@osdl.org, chrisw@sous-sol.org, grim@undead.cc
Subject: Re: [PATCH] initramfs:  Allow rootfs to use tmpfs instead of ramfs
In-Reply-To: <200607301808.14299.a1426z@gawab.com>
Message-ID: <Pine.LNX.4.64.0607301750080.10648@blonde.wat.veritas.com>
References: <200607301808.14299.a1426z@gawab.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 30 Jul 2006 17:37:02.0199 (UTC) FILETIME=[C43C5070:01C6B3FE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Jul 2006, Al Boldi wrote:
> 
> Replugs rootfs to use tmpfs instead of ramfs as a Kconfig option.

Why?  Looking further down we see what you should have explained here:
> + This option switches rootfs so that it uses tmpfs rather than ramfs
> + for its file storage.  This makes rootfs swappable so having a large
> + initrd or initramfs image won't eat up valuable RAM.

Now, I'm far from an expert on initramfs and early userspace, but my
understanding is that the "init" of a (properly designed) initramfs
would pretty much "rm -rf" everything in the initramfs before passing
control to the final "init".  So (almost?) no valuable RAM is eaten
up, nor the less valuable swap if you do extend this to tmpfs (unless
something gets left open, which I think should not be the case).

So I'm inclined to say that this patch is simply unnecessary.  But
if people who know better think it's a good thing, I've no objection
(though I've not tried it): the Kconfiggery looks more likely to
provoke argument than the tmpfs/ramfs mods.

> 
> This patch is based on John Zielinski's 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=107013630212011&w=4 patch.
> 
> Modified for 2.6.17.
> 
> RunTime tested on i386.
> 
> This trivial patch should go into 2.6.18.

Well...

> 
> Cc: <stable@kernel.org>
> Cc: Chris Wright <chrisw@sous-sol.org>

Umm, the -stable tree doesn't usually take enhancements,
even if you think it's a very stable enhancement.

> Cc: Andrew Morton <akpm@osdl.org>
> Cc: John Zielinski <grim@undead.cc>
> Signed-off-by: Al Boldi <a1426z@gawab.com>
> 
> ---
> --- a/drivers/block/Kconfig	2006-07-30 16:44:59.000000000 +0300
> +++ b/drivers/block/Kconfig	2006-07-30 16:45:53.000000000 +0300
> @@ -412,6 +412,22 @@ config BLK_DEV_INITRD
>  	  If RAM disk support (BLK_DEV_RAM) is also included, this
>  	  also enables initial RAM disk (initrd) support.
>  
> +config SHM_ROOTFS

Please say TMPFS_ROOTFS rather than SHM_ROOTFS throughout.

> +	bool "Use tmpfs (shm) instead of ramfs for rootfs"
> +	depends on BLK_DEV_INITRD
> +	default n
> +	select TMPFS
> +	select SHMEM

Selects can be troublesome, but you may well have decided right.

> +	help
> +	  This option switches rootfs so that it uses tmpfs rather than ramfs
> +	  for it's file storage.  This makes rootfs swappable so having a large
              
              its

> +	  initrd or initramfs image won't eat up valuable RAM.
> +
> +config RAMFS_ROOTFS
> +	bool 
> +	depends on !SHM_ROOTFS
> +	default y
> +	select RAMFS
>  
>  config CDROM_PKTCDVD
>  	tristate "Packet writing on CD/DVD media"
> --- a/fs/Kconfig	2006-07-30 16:45:25.000000000 +0300
> +++ b/fs/Kconfig	2006-07-30 16:46:36.000000000 +0300
> @@ -853,7 +853,7 @@ config HUGETLB_PAGE
>  	def_bool HUGETLBFS
>  
>  config RAMFS
> -	bool
> +	tristate "Ramfs file system support"
>  	default y
>  	---help---
>  	  Ramfs is a file system which keeps all files in RAM. It allows
> --- a/fs/ramfs/inode.c	2006-07-30 16:45:37.000000000 +0300
> +++ b/fs/ramfs/inode.c	2006-07-30 16:46:36.000000000 +0300
> @@ -191,22 +191,27 @@ struct super_block *ramfs_get_sb(struct 
>  	return get_sb_nodev(fs_type, flags, data, ramfs_fill_super);
>  }
>  
> +#ifdef CONFIG_RAMFS_ROOTFS
>  static struct super_block *rootfs_get_sb(struct file_system_type *fs_type,
>  	int flags, const char *dev_name, void *data)
>  {
>  	return get_sb_nodev(fs_type, flags|MS_NOUSER, data, ramfs_fill_super);
>  }
> +#endif
>  
>  static struct file_system_type ramfs_fs_type = {
>  	.name		= "ramfs",
>  	.get_sb		= ramfs_get_sb,
>  	.kill_sb	= kill_litter_super,
>  };
> +
> +#ifdef CONFIG_RAMFS_ROOTFS
>  static struct file_system_type rootfs_fs_type = {
>  	.name		= "rootfs",
>  	.get_sb		= rootfs_get_sb,
>  	.kill_sb	= kill_litter_super,
>  };
> +#endif
>  
>  static int __init init_ramfs_fs(void)
>  {
> @@ -221,9 +226,11 @@ static void __exit exit_ramfs_fs(void)
>  module_init(init_ramfs_fs)
>  module_exit(exit_ramfs_fs)
>  
> +#ifdef CONFIG_RAMFS_ROOTFS
>  int __init init_rootfs(void)
>  {
>  	return register_filesystem(&rootfs_fs_type);
>  }
> +#endif
>  
>  MODULE_LICENSE("GPL");
> --- a/mm/shmem.c	2006-07-30 16:45:54.000000000 +0300
> +++ b/mm/shmem.c	2006-07-30 16:47:11.000000000 +0300
> @@ -2123,7 +2123,7 @@ failed:
>  	return err;
>  }
>  
> -static struct kmem_cache *shmem_inode_cachep;
> +static struct kmem_cache *shmem_inode_cachep = NULL;

No need to initialize static variables to 0 (or is someone going to
raise the spectre of NULL being non-0 on some future architecture?)

>  
>  static struct inode *shmem_alloc_inode(struct super_block *sb)
>  {
> @@ -2156,11 +2156,13 @@ static void init_once(void *foo, struct 
>  
>  static int init_inodecache(void)
>  {
> -	shmem_inode_cachep = kmem_cache_create("shmem_inode_cache",
> -				sizeof(struct shmem_inode_info),
> -				0, 0, init_once, NULL);
> -	if (shmem_inode_cachep == NULL)
> -		return -ENOMEM;
> +	if(!shmem_inode_cachep) {

        if (shmem_inode_cachep == NULL) {
is more consistent with the nearby style

> +		shmem_inode_cachep = kmem_cache_create("shmem_inode_cache",
> +					sizeof(struct shmem_inode_info),
> +					0, 0, init_once, NULL);
> +		if (shmem_inode_cachep == NULL)
> +			return -ENOMEM;
> +	}
>  	return 0;
>  }
>  
> @@ -2345,6 +2347,27 @@ put_memory:
>  	return ERR_PTR(error);
>  }
>  
> +#ifdef CONFIG_SHM_ROOTFS
> +static struct super_block *rootfs_get_sb(struct file_system_type *fs_type,
> +	int flags, const char *dev_name, void *data)
> +{
> +	return get_sb_single(fs_type, flags, data, shmem_fill_super);
> +}
> +
> +static struct file_system_type rootfs_fs_type = {
> +	.name		= "rootfs",
> +	.get_sb		= rootfs_get_sb,
> +	.kill_sb	= kill_litter_super,
> +};
> +
> +int __init init_rootfs(void)
> +{
> +	if (init_inodecache())
> +		panic("Can't initialize shm inode cache");

                                        "tmpfs inode cache"
                                     or "shmem inode cache"

> +	return register_filesystem(&rootfs_fs_type);
> +}
> +#endif
> +
>  /*
>   * shmem_zero_setup - setup a shared anonymous mapping
>   *
