Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261995AbVATAaS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261995AbVATAaS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 19:30:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262008AbVATA3p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 19:29:45 -0500
Received: from mail.mellanox.co.il ([194.90.237.34]:3378 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S261995AbVATA1k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 19:27:40 -0500
Date: Thu, 20 Jan 2005 02:28:06 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Chris Wright <chrisw@osdl.org>
Cc: Andi Kleen <ak@muc.de>, akpm@osdl.org, hch@infradead.org,
       linux-kernel@vger.kernel.org, davem@davemloft.net
Subject: Re: [PATCH 1/5] compat_ioctl call seems to miss a security hook
Message-ID: <20050120002806.GA16674@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20050118072133.GB76018@muc.de> <20050118103418.GA23099@mellanox.co.il> <20050118072133.GB76018@muc.de> <20050118104515.GA23127@mellanox.co.il> <20050118112220.X24171@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050118112220.X24171@build.pdx.osdl.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!
Quoting r. Chris Wright (chrisw@osdl.org) "Re: [PATCH 1/5] compat_ioctl call seems to miss a security hook":
> * Michael S. Tsirkin (mst@mellanox.co.il) wrote:
> > diff -rup linux-2.6.10-orig/fs/compat.c linux-2.6.10-ioctl-sym/fs/compat.c
> > --- linux-2.6.10-orig/fs/compat.c	2005-01-18 10:58:33.609880024 +0200
> > +++ linux-2.6.10-ioctl-sym/fs/compat.c	2005-01-18 10:54:26.289478440 +0200
> > @@ -437,6 +437,11 @@ asmlinkage long compat_sys_ioctl(unsigne
> >  	if (!filp)
> >  		goto out;
> >  
> > +	/* RED-PEN how should LSM module know it's handling 32bit? */
> > +	error = security_file_ioctl(filp, cmd, arg);
> > + 	if (error)
> > + 		goto out_fput;
> > +
> 
> This is now called twice in the plain do_ioctl: case.  A generic vfs handler
> could alleviate that.

I'm all for it, but the way the patch below works, we could end up
calling ->ioctl or ->unlocked_ioctl from the compat 
syscall, and we dont want that.

MST



> ===== fs/ioctl.c 1.15 vs edited =====
> --- 1.15/fs/ioctl.c	2005-01-15 14:31:01 -08:00
> +++ edited/fs/ioctl.c	2005-01-18 11:18:33 -08:00
> @@ -77,21 +77,10 @@ static int file_ioctl(struct file *filp,
>  	return do_ioctl(filp, cmd, arg);
>  }
>  
> -
> -asmlinkage long sys_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
> +int vfs_ioctl(struct file *filp, unsigned int fd, unsigned int cmd, unsigned long arg)
>  {
> -	struct file * filp;
>  	unsigned int flag;
> -	int on, error = -EBADF;
> -	int fput_needed;
> -
> -	filp = fget_light(fd, &fput_needed);
> -	if (!filp)
> -		goto out;
> -
> -	error = security_file_ioctl(filp, cmd, arg);
> -	if (error)
> -		goto out_fput;
> +	int on, error = 0;
>  
>  	switch (cmd) {
>  		case FIOCLEX:
> @@ -157,6 +146,24 @@ asmlinkage long sys_ioctl(unsigned int f
>  				error = do_ioctl(filp, cmd, arg);
>  			break;
>  	}
> +	return error;
> +}
> +
> +asmlinkage long sys_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
> +{
> +	struct file * filp;
> +	int error = -EBADF;
> +	int fput_needed;
> +
> +	filp = fget_light(fd, &fput_needed);
> +	if (!filp)
> +		goto out;
> +
> +	error = security_file_ioctl(filp, cmd, arg);
> +	if (error)
> +		goto out_fput;
> +
> +	error = vfs_ioctl(filp, fd, cmd, arg);
>   out_fput:
>  	fput_light(filp, fput_needed);
>   out:
> ===== fs/compat.c 1.48 vs edited =====
> --- 1.48/fs/compat.c	2005-01-15 14:31:01 -08:00
> +++ edited/fs/compat.c	2005-01-18 11:07:56 -08:00
> @@ -437,6 +437,11 @@ asmlinkage long compat_sys_ioctl(unsigne
>  	if (!filp)
>  		goto out;
>  
> +	/* RED-PEN how should LSM module know it's handling 32bit? */
> +	error = security_file_ioctl(filp, cmd, arg);
> +	if (error)
> +		goto out_fput;
> +
>  	if (filp->f_op && filp->f_op->compat_ioctl) {
>  		error = filp->f_op->compat_ioctl(filp, cmd, arg);
>  		if (error != -ENOIOCTLCMD)
> @@ -477,7 +482,7 @@ asmlinkage long compat_sys_ioctl(unsigne
>  
>  	up_read(&ioctl32_sem);
>   do_ioctl:
> -	error = sys_ioctl(fd, cmd, arg);
> +	error = vfs_ioctl(filp, fd, cmd, arg);
>   out_fput:
>  	fput_light(filp, fput_needed);
>   out:
> ===== include/linux/fs.h 1.373 vs edited =====
> --- 1.373/include/linux/fs.h	2005-01-15 14:31:01 -08:00
> +++ edited/include/linux/fs.h	2005-01-18 11:10:54 -08:00
> @@ -1564,6 +1564,8 @@ extern int vfs_stat(char __user *, struc
>  extern int vfs_lstat(char __user *, struct kstat *);
>  extern int vfs_fstat(unsigned int, struct kstat *);
>  
> +extern int vfs_ioctl(struct file *, unsigned int, unsigned int, unsigned long);
> +
>  extern struct file_system_type *get_fs_type(const char *name);
>  extern struct super_block *get_super(struct block_device *);
>  extern struct super_block *user_get_super(dev_t);
