Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317351AbSGDHJH>; Thu, 4 Jul 2002 03:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317352AbSGDHJG>; Thu, 4 Jul 2002 03:09:06 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:7174 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317351AbSGDHJF>;
	Thu, 4 Jul 2002 03:09:05 -0400
Date: Thu, 4 Jul 2002 00:10:04 -0700
From: Greg KH <greg@kroah.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: mochel@osdl.org, Greg KH <gregkh@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove BKL from driverfs
Message-ID: <20020704071004.GI29657@kroah.com>
References: <3D23EA93.7090106@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D23EA93.7090106@us.ibm.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Thu, 06 Jun 2002 04:03:30 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 03, 2002 at 11:26:27PM -0700, Dave Hansen wrote:
> I saw your talk about driverfs at OLS and it got my attention.  When 
> my BKL debugging patch showed some use of the BKL in driverfs, I was 
> very dissapointed (you can blame Greg if you want).

Blame me?  Al Viro pushed that BKL into the file, not I :)

> text from dmesg after BKL debugging patch:
> release of recursive BKL hold, depth: 1
> [ 0]main:492
> [ 1]inode:149

This means what?

> I see no reason to hold the BKL in your situation.  I replaced it with 
> i_sem in some places and just plain removed it in others.  I believe 
> that you get all of the protection that you need from dcache_lock in 
> the dentry insert and activate.  Can you prove me wrong?

I see no reason to really care :)
Can you prove that driverfs (or pcihpfs or usbfs) accesses are on a
critical path that removing the BKL usage here actually helps?


> --- linux-2.5.24-clean/fs/driverfs/inode.c	Thu Jun 20 15:53:45 2002
> +++ linux/fs/driverfs/inode.c	Wed Jul  3 23:18:23 2002
> @@ -146,20 +146,16 @@
>  static int driverfs_mkdir(struct inode *dir, struct dentry *dentry, int mode)
>  {
>  	int res;
> -	lock_kernel();
>  	dentry->d_op = &driverfs_dentry_dir_ops;
>   	res = driverfs_mknod(dir, dentry, mode | S_IFDIR, 0);
> -	unlock_kernel();
>  	return res;
>  }

I think that driverfs_mknod() needs some kind of protection now that you
have removed it.


>  
>  static int driverfs_create(struct inode *dir, struct dentry *dentry, int mode)
>  {
>  	int res;
> -	lock_kernel();
>  	dentry->d_op = &driverfs_dentry_file_ops;
>   	res = driverfs_mknod(dir, dentry, mode | S_IFREG, 0);
> -	unlock_kernel();
>  	return res;
>  }
>  
> @@ -211,9 +207,9 @@
>  	if (driverfs_empty(dentry)) {
>  		struct inode *inode = dentry->d_inode;
>  
> -		lock_kernel();
> +		down(&inode->i_sem);
>  		inode->i_nlink--;
> -		unlock_kernel();
> +		up(&inode->i_sem);
>  		dput(dentry);
>  		error = 0;
>  	}
> @@ -353,8 +349,9 @@
>  driverfs_file_lseek(struct file *file, loff_t offset, int orig)
>  {
>  	loff_t retval = -EINVAL;
> +        struct inode *inode = file->f_dentry->d_inode->i_mapping->host;

Um, you used spaces, please use tabs like the rest of the file, and how
Documentation/CodingStyle mandates.

thanks,

greg k-h
