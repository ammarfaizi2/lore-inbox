Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750705AbWJGI1K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbWJGI1K (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 04:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750723AbWJGI1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 04:27:10 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:20924 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750705AbWJGI1H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 04:27:07 -0400
Date: Sat, 7 Oct 2006 09:27:05 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, hch@infradead.org
Subject: Re: [RFC][PATCH] filesystem helpers for custom 'struct file's
Message-ID: <20061007082705.GA7294@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dave Hansen <haveblue@us.ibm.com>, linux-kernel@vger.kernel.org
References: <20060920153638.3EB3BE3C@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060920153638.3EB3BE3C@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2006 at 08:36:38AM -0700, Dave Hansen wrote:
> Some filesystems forego the vfs and may_open() and create their
> own 'struct file's.
> 
> This patch creates a couple of helper functions which can be
> used by these filesystems, and will provide a unified place
> which the r/o bind mount code may patch.
> 
> Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
> ---
> 
>  lxc-dave/include/linux/file.h |    8 ++++++++
>  lxc-dave/fs/file_table.c      |   30 ++++++++++++++++++++++++++++++
>  lxc-dave/fs/hugetlbfs/inode.c |   22 +++++++++-------------
>  lxc-dave/mm/shmem.c           |    7 ++-----
>  lxc-dave/mm/tiny-shmem.c      |   24 +++++++++---------------
>  lxc-dave/net/socket.c         |   17 ++++++++---------
>  6 files changed, 66 insertions(+), 42 deletions(-)
> 
> diff -puN include/linux/file.h~B0-helpers-for-custom-struct_files include/linux/file.h
> --- lxc/include/linux/file.h~B0-helpers-for-custom-struct_files	2006-09-19 10:36:47.000000000 -0700
> +++ lxc-dave/include/linux/file.h	2006-09-19 10:36:57.000000000 -0700
> @@ -67,6 +67,14 @@ struct files_struct {
>  extern void FASTCALL(__fput(struct file *));
>  extern void FASTCALL(fput(struct file *));
>  
> +struct file_operations;
> +struct vfsmount;
> +struct dentry;
> +extern int f_init(struct file *, struct vfsmount *, struct dentry *dentry,
> +		mode_t mode, const struct file_operations *fop);
> +extern struct file *f_alloc(struct vfsmount *, struct dentry *dentry,
> +		mode_t mode, const struct file_operations *fop);
> +

To be honest I really hate this names.  init_file and alloc_file sound
a lot better.

> +int f_init(struct file *file, struct vfsmount *mnt,
> +	   struct dentry *dentry, mode_t mode,
> +	   const struct file_operations *fop)
> +{
> +	int error = 0;
> +	file->f_vfsmnt = mntget(mnt);
> +	file->f_dentry = dentry;
> +	file->f_mapping = dentry->d_inode->i_mapping;
> +	file->f_mode = mode;
> +	file->f_op = fop;
> +	return error;
> +}
> +
> +EXPORT_SYMBOL(f_init);

Do we really need this one?  I think we should only need the
alloc version.

> diff -puN mm/shmem.c~B0-helpers-for-custom-struct_files mm/shmem.c
> --- lxc/mm/shmem.c~B0-helpers-for-custom-struct_files	2006-09-19 10:36:47.000000000 -0700
> +++ lxc-dave/mm/shmem.c	2006-09-19 10:36:57.000000000 -0700
> @@ -2411,11 +2411,8 @@ struct file *shmem_file_setup(char *name
>  	d_instantiate(dentry, inode);
>  	inode->i_size = size;
>  	inode->i_nlink = 0;	/* It is unlinked */
> -	file->f_vfsmnt = mntget(shm_mnt);
> -	file->f_dentry = dentry;
> -	file->f_mapping = inode->i_mapping;
> -	file->f_op = &shmem_file_operations;
> -	file->f_mode = FMODE_WRITE | FMODE_READ;
> +	f_init(file, shm_mnt, dentry, FMODE_WRITE | FMODE_READ,
> +			&shmem_file_operations);
>  	return file;
>  

This should be able to use the alloc variant by moving the file allocation
after the inode allocation.  Which makes a lot of sense anyway as
shmem_get_inode can fail for accounting reasons.

>  {
> +	struct dentry *dentry;
>  	struct qstr this;
>  	char name[32];
>  
> @@ -356,18 +357,16 @@ static int sock_attach_fd(struct socket 
>  	this.name = name;
>  	this.hash = SOCK_INODE(sock)->i_ino;
>  
> -	file->f_dentry = d_alloc(sock_mnt->mnt_sb->s_root, &this);
> -	if (unlikely(!file->f_dentry))
> +	dentry = d_alloc(sock_mnt->mnt_sb->s_root, &this);
> +	if (unlikely(!dentry))
>  		return -ENOMEM;
>  
> -	file->f_dentry->d_op = &sockfs_dentry_operations;
> -	d_add(file->f_dentry, SOCK_INODE(sock));
> -	file->f_vfsmnt = mntget(sock_mnt);
> -	file->f_mapping = file->f_dentry->d_inode->i_mapping;
> -
> +	dentry->d_op = &sockfs_dentry_operations;
> +	d_add(dentry, SOCK_INODE(sock));
> +	f_init(file, sock_mnt, dentry, FMODE_READ | FMODE_WRITE,
> +			&socket_file_ops);
> +	SOCK_INODE(sock)->i_fop = &socket_file_ops;
>  	sock->file = file;
> -	file->f_op = SOCK_INODE(sock)->i_fop = &socket_file_ops;
> -	file->f_mode = FMODE_READ | FMODE_WRITE;
>  	file->f_flags = O_RDWR;
>  	file->f_pos = 0;
>  	file->private_data = sock;

Similarly the socket code wants a rework.  The current split into sock_alloc_fd
and sock_attach_fd is highly confusing and the allocation of the file struct
before the inode doesn't make a lot of sense.
