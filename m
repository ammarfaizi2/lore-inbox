Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264700AbUDVVi7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264700AbUDVVi7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 17:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264694AbUDVVi6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 17:38:58 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30697 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264700AbUDVVhl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 17:37:41 -0400
Date: Thu, 22 Apr 2004 22:37:37 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Maneesh Soni <maneesh@in.ibm.com>
Cc: Greg KH <greg@kroah.com>, Jeff Garzik <jgarzik@pobox.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] fix sysfs symlinks
Message-ID: <20040422213736.GL17014@parcelfarce.linux.theplanet.co.uk>
References: <20040413133615.GZ31500@parcelfarce.linux.theplanet.co.uk> <20040415220232.GC23039@kroah.com> <20040416152448.GF24997@parcelfarce.linux.theplanet.co.uk> <20040416223732.GC21701@kroah.com> <20040416234601.GL24997@parcelfarce.linux.theplanet.co.uk> <40807466.1020701@pobox.com> <20040417090712.B11481@flint.arm.linux.org.uk> <20040417082206.GM24997@parcelfarce.linux.theplanet.co.uk> <20040420161602.GB9603@kroah.com> <20040421101104.GA7921@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040421101104.GA7921@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2004 at 03:41:04PM +0530, Maneesh Soni wrote:
> +			/* release the target kobject in case of 
> +			 * a symlink
> +			 */
> +			if (S_ISLNK(d->d_inode->i_mode))
> +				kobject_put(d->d_fsdata);
> +			
>  			d_delete(d);
>  			simple_unlink(dentry->d_inode,d);
>  			dput(d);

I would unhash before doing kobject_put() here.  Otherwise you are risking
->follow_link() or ->readlink() coming between kobject_put() and unhashing,
which will screw you when sysfs_get_kobject() tries to grab a reference to
(already freed) ->d_fsdata.

> +			/* release the target kobject in case of 
> +			 * a symlink
> +			 */
> +			if (S_ISLNK(victim->d_inode->i_mode))
> +				kobject_put(victim->d_fsdata);
>  			d_delete(victim);

Ditto.

> +	if (!IS_ERR(d)) {
> +		error = sysfs_create(d, S_IFLNK|S_IRWXUGO, init_symlink);
> +		if (!error)
> +			/* 
> +			 * associate the link dentry with the target kobject 
> +			 */
> +			d->d_fsdata = kobject_get(target);
> +	} else 
>  		error = PTR_ERR(d);
>  	dput(d);

Huh?  Not to mention anything else, dput(d) is guaranteed to screw you if
IS_ERR(d) is true.

> +	down(&target_parent->d_inode->i_sem);
> +	error = sysfs_get_target_path(kobj, target_kobj, path);
> +	up(&target_parent->d_inode->i_sem);

You need to be careful in sysfs_get_target_path() - this ->i_sem doesn't
prevent renames of ancestors.  rwsem held exclusive by renaming and shared
by sysfs_get_target_path(), maybe?  FWIW, even rwlock might be sufficient...
