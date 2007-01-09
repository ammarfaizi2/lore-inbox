Return-Path: <linux-kernel-owner+w=401wt.eu-S932231AbXAIUob@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbXAIUob (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 15:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932417AbXAIUob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 15:44:31 -0500
Received: from extu-mxob-2.symantec.com ([216.10.194.135]:11106 "EHLO
	extu-mxob-2.symantec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932231AbXAIUoa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 15:44:30 -0500
X-AuditID: d80ac287-9eed1bb000002536-3c-45a3ffcacc8d 
Date: Tue, 9 Jan 2007 20:44:43 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Hua Zhong <hzhong@gmail.com>
cc: linux-kernel@vger.kernel.org, hch@infradead.org, kenneth.w.chen@intel.com,
       akpm@osdl.org, torvalds@osdl.org, mjt@tls.msk.ru
Subject: Re: [PATCH] support O_DIRECT in tmpfs/ramfs
In-Reply-To: <Pine.LNX.4.64.0701081729100.2747@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0701092002350.21638@blonde.wat.veritas.com>
References: <Pine.LNX.4.64.0701081729100.2747@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 09 Jan 2007 20:44:29.0033 (UTC) FILETIME=[F5343D90:01C7342E]
X-Brightmail-Tracker: AAAAAA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jan 2007, Hua Zhong wrote:
> A while ago there was a discussion about supporting direct-io on tmpfs.

Ah, I think I can just about remember that... ;)

> 
> Here is a simple patch that does it.

Looks more likely to work than Ken's - which I didn't try,
but I couldn't see what magic prevented it from just going BUG.

But I have to say, having seen the ensuing requests for this to impose
the same constraints as other implementations of O_DIRECT (though NFS
does not), I've veered right back to my original position: this all
just seems silly to me.  O_DIRECT is and always has been rather an
awkward hack (Linus described it in stronger terms!), supported by
many but not all filesystems: shall we just leave it at that?

In particular, having now looked into the code, I'm amused to be
reminded that one of its particular effects is to invalidate the
pagecache for the area directly written.  Well, it's hardly going
to be worth replicating that behaviour with tmpfs or ramfs; yet
if we don't, then we stand accused of it behaving misleadingly
differently on them.

I think Michael, who started off this discussion, did just the right
thing: used a direct_IO filesystem on a loop device on a tmpfs file.

> 
> 1. A new fs flag FS_RAM_BASED is added and the O_DIRECT flag is ignored
>    if this flag is set (suggestions on a better name?)
> 
> 2. Specify FS_RAM_BASED for tmpfs and ramfs.

If this is pursued (not my preference, but let me stand aside now),
you'd want to add in at least hugetlbfs and tiny-shmem.c.  And set
your (renamed) FS_RAM_BASED flag in ext2_aops_xip: that seems to
be what they're wanting, then you can remove that strange test
for f->f_mapping->a_ops->get_xip_page from __dentry_open.

> 
> 3. When EINVAL is returned only a fput is done. I changed it to go
>    through cleanup_all. But there is still a cleanup problem:

Is that change correct?  Are you saying that the existing code leaks
some structures?  If so, please do send a patch to fix just that as
soon as you can.  But are you sure?

> 
>   If a new file is created and then EINVAL is returned due to O_DIRECT,
>   the file is still left on the disk. I am not exactly sure how to fix
>   it other than adding another fs flag so we could check O_DIRECT
>   support at a much earlier stage. Comments on how to fix it?

None from me, sorry.  It's untidy, but not a new issue you have to fix.

Hugh

> 
> Signed-off-by: Hua Zhong <hzhong@gmail.com>
> 
> diff --git a/fs/open.c b/fs/open.c
> index c989fb4..c03285f 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -708,11 +708,13 @@ static struct file *__dentry_open(struct
>  
>  	/* NB: we're sure to have correct a_ops only after f_op->open */
>  	if (f->f_flags & O_DIRECT) {
> -		if (!f->f_mapping->a_ops ||
> -		    ((!f->f_mapping->a_ops->direct_IO) &&
> -		    (!f->f_mapping->a_ops->get_xip_page))) {
> -			fput(f);
> -			f = ERR_PTR(-EINVAL);
> +		if (dentry->d_sb->s_type->fs_flags & FS_RAM_BASED)
> +			f->f_flags &= ~O_DIRECT;
> +		else if (!f->f_mapping->a_ops ||
> +			 ((!f->f_mapping->a_ops->direct_IO) &&
> +			  (!f->f_mapping->a_ops->get_xip_page))) {
> +			error = -EINVAL;
> +			goto cleanup_all;
>  		}
>  	}
>  
> diff --git a/fs/ramfs/inode.c b/fs/ramfs/inode.c
> index 2faf4cd..0d4bebc 100644
> --- a/fs/ramfs/inode.c
> +++ b/fs/ramfs/inode.c
> @@ -199,11 +199,13 @@ static int rootfs_get_sb(struct file_sys
>  
>  static struct file_system_type ramfs_fs_type = {
>  	.name		= "ramfs",
> +	.fs_flags	= FS_RAM_BASED,
>  	.get_sb		= ramfs_get_sb,
>  	.kill_sb	= kill_litter_super,
>  };
>  static struct file_system_type rootfs_fs_type = {
>  	.name		= "rootfs",
> +	.fs_flags	= FS_RAM_BASED,	
>  	.get_sb		= rootfs_get_sb,
>  	.kill_sb	= kill_litter_super,
>  };
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 186da81..0d95988 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -91,6 +91,7 @@ extern int dir_notify_enable;
>  /* public flags for file_system_type */
>  #define FS_REQUIRES_DEV 1 
>  #define FS_BINARY_MOUNTDATA 2
> +#define FS_RAM_BASED	8192	/* Ignore O_DIRECT */
>  #define FS_REVAL_DOT	16384	/* Check the paths ".", ".." for staleness */
>  #define FS_RENAME_DOES_D_MOVE	32768	/* FS will handle d_move()
>  					 * during rename() internally.
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 70da7a0..5d23e8a 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2413,6 +2413,7 @@ static int shmem_get_sb(struct file_syst
>  static struct file_system_type tmpfs_fs_type = {
>  	.owner		= THIS_MODULE,
>  	.name		= "tmpfs",
> +	.fs_flags	= FS_RAM_BASED,
>  	.get_sb		= shmem_get_sb,
>  	.kill_sb	= kill_litter_super,
>  };
