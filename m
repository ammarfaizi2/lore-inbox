Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265065AbUEKXpj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265065AbUEKXpj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 19:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263173AbUEKXpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 19:45:39 -0400
Received: from mail.kroah.org ([65.200.24.183]:61154 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265065AbUEKXpZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 19:45:25 -0400
Date: Tue, 11 May 2004 16:33:51 -0700
From: Greg KH <greg@kroah.com>
To: Maneesh Soni <maneesh@in.ibm.com>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org,
       viro@parcelfarce.linux.theplanet.co.uk, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [RFC 2/2] sysfs_rename_dir-cleanup
Message-ID: <20040511233350.GC27069@kroah.com>
References: <20040417082206.GM24997@parcelfarce.linux.theplanet.co.uk> <20040430101333.GB25296@in.ibm.com> <20040430101401.GC25296@in.ibm.com> <200404300748.14151.dtor_core@ameritech.net> <20040504053908.GA2900@in.ibm.com> <20040507222549.GB14660@kroah.com> <20030509153523.A20357@in.ibm.com> <20030509153957.A20432@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030509153957.A20432@in.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 09, 2003 at 03:39:57PM +0530, Maneesh Soni wrote:
> diff -puN fs/sysfs/dir.c~sysfs_rename_dir-cleanup fs/sysfs/dir.c
> --- linux-2.6.6-rc3-mm2/fs/sysfs/dir.c~sysfs_rename_dir-cleanup	2004-05-05 18:22:39.000000000 +0530
> +++ linux-2.6.6-rc3-mm2-maneesh/fs/sysfs/dir.c	2004-05-05 18:33:54.000000000 +0530
> @@ -162,15 +162,16 @@ restart:
>  	dput(dentry);
>  }
>  
> -void sysfs_rename_dir(struct kobject * kobj, const char *new_name)
> +int sysfs_rename_dir(struct kobject * kobj, const char *new_name)
>  {
> +	int error = 0;
>  	struct dentry * new_dentry, * parent;
>  
>  	if (!strcmp(kobject_name(kobj), new_name))
> -		return;
> +		return -EINVAL;
>  
>  	if (!kobj->parent)
> -		return;
> +		return -EINVAL;
>  
>  	down_write(&sysfs_rename_sem);
>  	parent = kobj->parent->dentry;
> @@ -179,13 +180,16 @@ void sysfs_rename_dir(struct kobject * k
>  	new_dentry = sysfs_get_dentry(parent, new_name);
>  	if (!IS_ERR(new_dentry)) {
>  		if (!new_dentry->d_inode) {
> -			d_move(kobj->dentry, new_dentry);
> -			kobject_set_name(kobj,new_name);
> +			error = kobject_set_name(kobj,new_name);
> +			if (!error)
> +				d_move(kobj->dentry, new_dentry);
>  		}
>  		dput(new_dentry);
>  	}
>  	up(&parent->d_inode->i_sem);	
>  	up_write(&sysfs_rename_sem);
> +
> +	return error;
>  }
>  
>  EXPORT_SYMBOL(sysfs_create_dir);

This second chunk fails miserably.  I don't know what you diffed it
against, as it doesn't look like anything that I currently have in that
function...

Anyway, can you grab the next -mm release and rediff this patch against
the bk-driver-2.6 tree, or even against a clean 2.6.6 tree so that I can
apply it?

thanks,

greg k-h
