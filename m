Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135868AbREIXlE>; Wed, 9 May 2001 19:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135874AbREIXky>; Wed, 9 May 2001 19:40:54 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:17935 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S135868AbREIXko>; Wed, 9 May 2001 19:40:44 -0400
Date: Wed, 9 May 2001 19:02:16 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Kurt Garloff <garloff@suse.de>, Andrea Arcangeli <andrea@suse.de>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: nfs MAP_SHARED corruption fix
In-Reply-To: <15096.61962.130340.998058@charged.uio.no>
Message-ID: <Pine.LNX.4.21.0105091859340.14172-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 9 May 2001, Trond Myklebust wrote:

> 
> In addition to the two changes I proposed to Andrea's new patch, I
> also realized we might want to do a fdatasync() when locking files. If
> we don't, then locking won't be atomic on mmap()...
> 
> Here therefore is Andrea's patch with the changes I propose. Opinions?
> 
> Cheers,
>   Trond
> 
> diff -u --recursive --new-file linux-2.4.4-fixes/fs/nfs/file.c linux-2.4.4-mmap/fs/nfs/file.c
> --- linux-2.4.4/fs/nfs/file.c	Fri Feb  9 20:29:44 2001
> +++ linux-2.4.4-mmap/fs/nfs/file.c	Wed May  9 09:18:45 2001
> @@ -39,6 +39,7 @@
>  static ssize_t nfs_file_write(struct file *, const char *, size_t, loff_t *);
>  static int  nfs_file_flush(struct file *);
>  static int  nfs_fsync(struct file *, struct dentry *dentry, int datasync);
> +static void nfs_file_close_vma(struct vm_area_struct *);
>  
>  struct file_operations nfs_file_operations = {
>  	read:		nfs_file_read,
> @@ -57,6 +58,11 @@
>  	setattr:	nfs_notify_change,
>  };
>  
> +static struct vm_operations_struct nfs_file_vm_ops = {
> +	nopage:		filemap_nopage,
> +	close:		nfs_file_close_vma,
> +};
> +
>  /* Hack for future NFS swap support */
>  #ifndef IS_SWAPFILE
>  # define IS_SWAPFILE(inode)	(0)
> @@ -104,6 +110,20 @@
>  	return result;
>  }
>  
> +static void nfs_file_close_vma(struct vm_area_struct * vma)
> +{
> +	struct inode * inode;
> +
> +	inode = vma->vm_file->f_dentry->d_inode;
> +
> +	if (inode->i_state & I_DIRTY_PAGES) {
> +		down(&inode->i_sem);
> +		filemap_fdatasync(inode->i_mapping);
> +		nfs_wb_all(inode);
> +		up(&inode->i_sem);
> +	}
> +}
> +

Why don't you clean I_DIRTY_PAGES ? 

