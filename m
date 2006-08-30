Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965199AbWH3Aga@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965199AbWH3Aga (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 20:36:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965190AbWH3Aga
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 20:36:30 -0400
Received: from pat.uio.no ([129.240.10.4]:28613 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S965176AbWH3Ag3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 20:36:29 -0400
Subject: Re: [PATCH] Allow file systems to manually d_move() inside of
	->rename()
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Mark Fasheh <mark.fasheh@oracle.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       hch@infradead.org, viro@ftp.linux.org.uk
In-Reply-To: <20060829215448.GO2874@ca-server1.us.oracle.com>
References: <20060829215448.GO2874@ca-server1.us.oracle.com>
Content-Type: text/plain
Date: Tue, 29 Aug 2006 20:35:52 -0400
Message-Id: <1156898152.5610.32.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.031, required 12,
	autolearn=disabled, AWL 1.97, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-29 at 14:54 -0700, Mark Fasheh wrote:
> diff --git a/fs/namei.c b/fs/namei.c
> index c784e8b..e5a8478 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -2353,7 +2353,8 @@ static int vfs_rename_dir(struct inode *
>  		dput(new_dentry);
>  	}
>  	if (!error)
> -		d_move(old_dentry,new_dentry);
> +		if (!(old_dir->i_sb->s_type->fs_flags & FS_RENAME_DOES_D_MOVE))
> +			d_move(old_dentry,new_dentry);
>  	return error;
>  }
>  
> @@ -2377,7 +2378,7 @@ static int vfs_rename_other(struct inode
>  		error = old_dir->i_op->rename(old_dir, old_dentry, new_dir, new_dentry);
>  	if (!error) {
>  		/* The following d_move() should become unconditional */
> -		if (!(old_dir->i_sb->s_type->fs_flags & FS_ODD_RENAME))
> +		if (!(old_dir->i_sb->s_type->fs_flags & (FS_ODD_RENAME|FS_RENAME_DOES_D_MOVE)))
>  			d_move(old_dentry, new_dentry);
>  	}
>  	if (target)
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index e04a5cf..8e9a7ca 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -87,6 +87,7 @@ #define SEL_EX		4
>  /* public flags for file_system_type */
>  #define FS_REQUIRES_DEV 1 
>  #define FS_BINARY_MOUNTDATA 2
> +#define FS_RENAME_DOES_D_MOVE 4
>  #define FS_REVAL_DOT	16384	/* Check the paths ".", ".." for staleness */
>  #define FS_ODD_RENAME	32768	/* Temporary stuff; will go away as soon
>  				  * as nfs_rename() will be cleaned up
> -

Why have 2 synonyms for the FS_ODD_RENAME stuff? Just fix up the NFS
client to do the d_move() unconditionally, and add a check for
FS_ODD_RENAME to vfs_rename_dir().

Cheers,
  Trond

