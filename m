Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966288AbWKTSMn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966288AbWKTSMn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 13:12:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966342AbWKTSL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 13:11:29 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:11110 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S966336AbWKTSLO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 13:11:14 -0500
Message-ID: <4561EFAB.8050508@oracle.com>
Date: Mon, 20 Nov 2006 10:10:51 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Miklos Szeredi <miklos@szeredi.hu>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] fuse: fix compile without CONFIG_BLOCK
References: <E1Gm5zn-0002tV-00@dorka.pomaz.szeredi.hu>
In-Reply-To: <E1Gm5zn-0002tV-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi wrote:
> Thanks Randy.
> 
> Andrew, can you please add this patch in place of
> fuse-depends-on-block.patch?

Acked-by: Randy Dunlap <randy.dunlap@oracle.com>

> Thanks,
> Miklos
> ----
> 
> Randy Dunlap wote:
>> Should FUSE depend on BLOCK?  Without that and with BLOCK=n, I get:
>>
>> inode.c:(.text+0x3acc5): undefined reference to `sb_set_blocksize'
>> inode.c:(.text+0x3a393): undefined reference to `get_sb_bdev'
>> fs/built-in.o:(.data+0xd718): undefined reference to `kill_block_super
> 
> Most fuse filesystems work fine without block device support, so I
> think a better solution is to disable the 'fuseblk' filesystem type if
> BLOCK=n.
> 
> Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
> CC: Randy Dunlap <randy.dunlap@oracle.com>
> 
> ---
> Index: linux/fs/fuse/inode.c
> ===================================================================
> --- linux.orig/fs/fuse/inode.c	2006-11-19 21:09:19.000000000 +0100
> +++ linux/fs/fuse/inode.c	2006-11-19 23:12:03.000000000 +0100
> @@ -535,8 +535,10 @@ static int fuse_fill_super(struct super_
>  		return -EINVAL;
>  
>  	if (is_bdev) {
> +#ifdef CONFIG_BLOCK
>  		if (!sb_set_blocksize(sb, d.blksize))
>  			return -EINVAL;
> +#endif
>  	} else {
>  		sb->s_blocksize = PAGE_CACHE_SIZE;
>  		sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
> @@ -629,6 +631,14 @@ static int fuse_get_sb(struct file_syste
>  	return get_sb_nodev(fs_type, flags, raw_data, fuse_fill_super, mnt);
>  }
>  
> +static struct file_system_type fuse_fs_type = {
> +	.owner		= THIS_MODULE,
> +	.name		= "fuse",
> +	.get_sb		= fuse_get_sb,
> +	.kill_sb	= kill_anon_super,
> +};
> +
> +#ifdef CONFIG_BLOCK
>  static int fuse_get_sb_blk(struct file_system_type *fs_type,
>  			   int flags, const char *dev_name,
>  			   void *raw_data, struct vfsmount *mnt)
> @@ -637,13 +647,6 @@ static int fuse_get_sb_blk(struct file_s
>  			   mnt);
>  }
>  
> -static struct file_system_type fuse_fs_type = {
> -	.owner		= THIS_MODULE,
> -	.name		= "fuse",
> -	.get_sb		= fuse_get_sb,
> -	.kill_sb	= kill_anon_super,
> -};
> -
>  static struct file_system_type fuseblk_fs_type = {
>  	.owner		= THIS_MODULE,
>  	.name		= "fuseblk",
> @@ -652,6 +655,26 @@ static struct file_system_type fuseblk_f
>  	.fs_flags	= FS_REQUIRES_DEV,
>  };
>  
> +static inline int register_fuseblk(void)
> +{
> +	return register_filesystem(&fuseblk_fs_type);
> +}
> +
> +static inline void unregister_fuseblk(void)
> +{
> +	unregister_filesystem(&fuseblk_fs_type);
> +}
> +#else
> +static inline int register_fuseblk(void)
> +{
> +	return 0;
> +}
> +
> +static inline void unregister_fuseblk(void)
> +{
> +}
> +#endif
> +
>  static decl_subsys(fuse, NULL, NULL);
>  static decl_subsys(connections, NULL, NULL);
>  
> @@ -673,7 +696,7 @@ static int __init fuse_fs_init(void)
>  	if (err)
>  		goto out;
>  
> -	err = register_filesystem(&fuseblk_fs_type);
> +	err = register_fuseblk();
>  	if (err)
>  		goto out_unreg;
>  
> @@ -688,7 +711,7 @@ static int __init fuse_fs_init(void)
>  	return 0;
>  
>   out_unreg2:
> -	unregister_filesystem(&fuseblk_fs_type);
> +	unregister_fuseblk();
>   out_unreg:
>  	unregister_filesystem(&fuse_fs_type);
>   out:
> @@ -698,7 +721,7 @@ static int __init fuse_fs_init(void)
>  static void fuse_fs_cleanup(void)
>  {
>  	unregister_filesystem(&fuse_fs_type);
> -	unregister_filesystem(&fuseblk_fs_type);
> +	unregister_fuseblk();
>  	kmem_cache_destroy(fuse_inode_cachep);
>  }
>  


-- 
~Randy
