Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266143AbUHCMpi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266143AbUHCMpi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 08:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266248AbUHCMpi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 08:45:38 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:43402 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266143AbUHCMp3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 08:45:29 -0400
Date: Tue, 3 Aug 2004 13:43:31 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Maneesh Soni <maneesh@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] Add sysfs_dirent to sysfs dentry
Message-ID: <20040803124329.GS12308@parcelfarce.linux.theplanet.co.uk>
References: <20040729203718.GB4592@in.ibm.com> <20040729203821.GC4592@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040729203821.GC4592@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2004 at 03:38:21PM -0500, Maneesh Soni wrote:
> +			} else {
> +				/* error, release the ref taken in
> +				 * sysfs_create()
> +				 */
> +				dput(*d);  

Umm...  Shouldn't we unhash here?  sysfs_create() did hash it, so...
Same goes for other places where we fail to create sysfs_dirent; as
the matter of fact, how about making
	sysfs_make_dirent(dentry, mode, data, type)
that would either allocate sysfs_dirent and bind it to dentry, or
unhash and dput() dentry and return error?  AFAICS, that would make
life easier.

>  int sysfs_create_file(struct kobject * kobj, const struct attribute * attr)
>  {
> -	if (kobj && attr)
> -		return sysfs_add_file(kobj->dentry,attr);
> +	if (kobj && kobj->dentry && attr)
> +		return sysfs_add_file(kobj->dentry, attr, SYSFS_KOBJ_ATTR);

Can we legitimately get NULL kobj or kobj->dentry here?  If not, that'd
better be BUG_ON()...

> @@ -65,15 +98,28 @@ int sysfs_create_link(struct kobject * k
>  	struct dentry * d;
>  	int error = 0;
>  
> +	if (!name)
> +		return -EINVAL;

Again, can that happen legitimately?

>  	down(&dentry->d_inode->i_sem);
>  	d = sysfs_get_dentry(dentry,name);
>  	if (!IS_ERR(d)) {
>  		error = sysfs_create(d, S_IFLNK|S_IRWXUGO, init_symlink);
> -		if (!error)
> -			/* 
> -			 * associate the link dentry with the target kobject 
> -			 */
> -			d->d_fsdata = kobject_get(target);
> +		if (!error) {
> +			struct sysfs_dirent * sd;
> +			sd = sysfs_add_link(dentry->d_fsdata, name, target);
> +			if (!IS_ERR(sd)) {
> +				/* 
> +			 	* associate the link dentry with the target  
> +			 	* through the corresponding sysfs_dirent.
> +			 	*/
> +				d->d_fsdata = sd;
> +				sd->s_dentry = dentry;
> +			} else {
> +				dput(d);
> +				error = PTR_ERR(sd);
> +			}

	I'd pull that inside sysfs_add_link() (and then further into
sysfs_new_dirent()).
