Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264775AbUDWJ0x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264775AbUDWJ0x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 05:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264776AbUDWJ0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 05:26:53 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29391 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264775AbUDWJ0n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 05:26:43 -0400
Date: Fri, 23 Apr 2004 10:26:41 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Maneesh Soni <maneesh@in.ibm.com>
Cc: Greg KH <greg@kroah.com>, Jeff Garzik <jgarzik@pobox.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] fix sysfs symlinks
Message-ID: <20040423092641.GM17014@parcelfarce.linux.theplanet.co.uk>
References: <20040416152448.GF24997@parcelfarce.linux.theplanet.co.uk> <20040416223732.GC21701@kroah.com> <20040416234601.GL24997@parcelfarce.linux.theplanet.co.uk> <40807466.1020701@pobox.com> <20040417090712.B11481@flint.arm.linux.org.uk> <20040417082206.GM24997@parcelfarce.linux.theplanet.co.uk> <20040420161602.GB9603@kroah.com> <20040421101104.GA7921@in.ibm.com> <20040422213736.GL17014@parcelfarce.linux.theplanet.co.uk> <20040423085218.GB27638@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040423085218.GB27638@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2004 at 02:22:18PM +0530, Maneesh Soni wrote:
> @@ -136,6 +138,12 @@ restart:
>  			 */
>  			spin_unlock(&dcache_lock);
>  			d_delete(d);

ITYM "d_drop(d)" here.  Right now these are equivalent (and d_drop() is
less work) since we are holding at least two references to d; if/when
we stop pinning leaves of the tree in core, the check below will become
unsafe with d_delete().

>  	new_dentry = sysfs_get_dentry(parent, new_name);
> -	d_move(kobj->dentry, new_dentry);
> -	kobject_set_name(kobj,new_name);
> +	if (!IS_ERR(new_dentry)) {
> +		down_write(&sysfs_rename_sem);
> +		d_move(kobj->dentry, new_dentry);
> +		kobject_set_name(kobj,new_name);
> +		up_write(&sysfs_rename_sem);
> +	}
>  	up(&parent->d_inode->i_sem);	
>  }

BTW, the above leaks because of unbalanced sysfs_get_dentry().  You need
a dput() in there.

> diff -puN fs/sysfs/inode.c~sysfs-symlinks-fix fs/sysfs/inode.c
> --- linux-2.6.6-rc2-mm1/fs/sysfs/inode.c~sysfs-symlinks-fix	2004-04-23 10:22:41.000000000 +0530
> +++ linux-2.6.6-rc2-mm1-maneesh/fs/sysfs/inode.c	2004-04-23 11:03:38.000000000 +0530
> @@ -97,6 +97,11 @@ void sysfs_hash_and_remove(struct dentry
>  				 atomic_read(&victim->d_count));
>  
>  			d_delete(victim);
> +			/* release the target kobject in case of 
> +			 * a symlink
> +			 */
> +			if (S_ISLNK(victim->d_inode->i_mode))
> +				kobject_put(victim->d_fsdata);

Same s/d_delete/d_drop/ issue.

>  			simple_unlink(dir->d_inode,victim);
>  		}

> @@ -70,11 +70,13 @@ void sysfs_remove_group(struct kobject *
>  	else
>  		dir = dget(kobj->dentry);
>  
> -	remove_files(dir,grp);
> -	if (grp->name)
> -		sysfs_remove_subdir(dir);
> -	/* release the ref. taken in this routine */
> -	dput(dir);
> +	if (dir && !IS_ERR(dir)) {
> +		remove_files(dir,grp);
> +		if (grp->name)
> +			sysfs_remove_subdir(dir);
> +		/* release the ref. taken in this routine */
> +		dput(dir);
> +	}
>  }

Hmm...  I thought that's what
		if (error)
			return error;
several lines above had been about.  Can we get there with NULL or ERR_PTR()
in dir?
