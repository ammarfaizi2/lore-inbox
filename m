Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261939AbULGVbR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbULGVbR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 16:31:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261943AbULGVbQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 16:31:16 -0500
Received: from nwkea-mail-2.sun.com ([192.18.42.14]:16536 "EHLO
	nwkea-mail-2.sun.com") by vger.kernel.org with ESMTP
	id S261939AbULGVap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 16:30:45 -0500
Date: Tue, 07 Dec 2004 16:30:37 -0500
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: [RFC]Add an unlocked_ioctl file operation
In-reply-to: <200412071211.41468.werner@sgi.com>
To: werner@sgi.com
Cc: linux-kernel@vger.kernel.org
Message-id: <41B620FD.6020402@sun.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-2
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <200412071211.41468.werner@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Mike Werner wrote:
> Per Andi Kleen's suggestion.
> 
> # This is a BitKeeper generated diff -Nru style patch.
> #
> #   Run Lindent on ioctl.c
> #   Add an ioctl path which does not take the BKL.
> # 
> diff -Nru a/fs/ioctl.c b/fs/ioctl.c
> --- a/fs/ioctl.c	2004-12-07 11:53:59 -08:00
> +++ b/fs/ioctl.c	2004-12-07 11:53:59 -08:00
> @@ -16,15 +16,15 @@
>  #include <asm/uaccess.h>
>  #include <asm/ioctls.h>
>  
> -static int file_ioctl(struct file *filp,unsigned int cmd,unsigned long arg)
> +static int file_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  {
>  	int error;
>  	int block;
> -	struct inode * inode = filp->f_dentry->d_inode;
> +	struct inode *inode = filp->f_dentry->d_inode;
>  	int __user *p = (int __user *)arg;
>  
>  	switch (cmd) {
> -		case FIBMAP:
> +	case FIBMAP:
>  		{
>  			struct address_space *mapping = filp->f_mapping;
>  			int res;
> @@ -39,101 +39,113 @@
>  			res = mapping->a_ops->bmap(mapping, block);
>  			return put_user(res, p);
>  		}
> -		case FIGETBSZ:
> -			if (inode->i_sb == NULL)
> -				return -EBADF;
> -			return put_user(inode->i_sb->s_blocksize, p);
> -		case FIONREAD:
> -			return put_user(i_size_read(inode) - filp->f_pos, p);
> +	case FIGETBSZ:
> +		if (inode->i_sb == NULL)
> +			return -EBADF;
> +		return put_user(inode->i_sb->s_blocksize, p);
> +	case FIONREAD:
> +		return put_user(i_size_read(inode) - filp->f_pos, p);
>  	}
>  	if (filp->f_op && filp->f_op->ioctl)
>  		return filp->f_op->ioctl(inode, filp, cmd, arg);
>  	return -ENOTTY;
>  }
>  
> -
>  asmlinkage long sys_ioctl(unsigned int fd, unsigned int cmd, unsigned long 
> arg)
> -{	
> -	struct file * filp;
> +{
> +	struct file *filp;
>  	unsigned int flag;
>  	int on, error = -EBADF;
> -
> +	int locked = 1;
>  	filp = fget(fd);
>  	if (!filp)
>  		goto out;
>  
>  	error = security_file_ioctl(filp, cmd, arg);
>  	if (error) {
> -                fput(filp);
> -                goto out;
> -        }
> +		fput(filp);
> +		goto out;
> +	}
> +
> +	if (filp->f_op && filp->f_op->unlocked_ioctl)
> +		locked = 0;
> +	else
> +		lock_kernel();

...

> +	case FIOCLEX:
> +		set_close_on_exec(fd, 1);
> +		break;
> +
> +	case FIONCLEX:
> +		set_close_on_exec(fd, 0);
> +		break;
>  

...

> +	default:
> +		error = -ENOTTY;
> +		if (S_ISREG(filp->f_dentry->d_inode->i_mode))
> +			error = file_ioctl(filp, cmd, arg);
> +		else if (filp->f_op && filp->f_op->unlocked_ioctl)
> +			error =
> +			    filp->f_op->unlocked_ioctl(filp->f_dentry->d_inode,
> +						       filp, cmd, arg);
> +		else if (filp->f_op && filp->f_op->ioctl)
> +			error =
> +			    filp->f_op->ioctl(filp->f_dentry->d_inode, filp,
> +					      cmd, arg);
>  	}
> -	unlock_kernel();
> +	if (locked)
> +		unlock_kernel();

...

This doesn't look right?  Have all the ioctls handled in sys_ioctl been
audited to ensure that they don't need lock_kernel?  I think what you
really want is if a) the ioctl isn't handled in the switch case and b)
unlocked_ioctl is != NULL, _then_ don't lock.  These means you'll need
to either a) grab the BKL in each switch case or b) filter the cmd to
see if it is handled below.

Also, file_ioctl didn't use unlocked_ioctl in the default case if it was
!= NULL.

- --
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me,
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBtiD9dQs4kOxk3/MRAkIPAJ0QjZOj/2ojbZOh/t2lUYQemiOirQCghtNj
IB36Sc4Uqfw7kq3GDuK0Cx4=
=HkMd
-----END PGP SIGNATURE-----
