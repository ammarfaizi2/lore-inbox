Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264863AbUD2PlJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264863AbUD2PlJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 11:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264876AbUD2PlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 11:41:09 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8888 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264863AbUD2PlG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 11:41:06 -0400
Date: Thu, 29 Apr 2004 16:41:04 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Maneesh Soni <maneesh@in.ibm.com>
Cc: Greg KH <greg@kroah.com>, Jeff Garzik <jgarzik@pobox.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] fix sysfs symlinks
Message-ID: <20040429154104.GI17014@parcelfarce.linux.theplanet.co.uk>
References: <20040416234601.GL24997@parcelfarce.linux.theplanet.co.uk> <40807466.1020701@pobox.com> <20040417090712.B11481@flint.arm.linux.org.uk> <20040417082206.GM24997@parcelfarce.linux.theplanet.co.uk> <20040420161602.GB9603@kroah.com> <20040421101104.GA7921@in.ibm.com> <20040422213736.GL17014@parcelfarce.linux.theplanet.co.uk> <20040423085218.GB27638@in.ibm.com> <20040423092641.GM17014@parcelfarce.linux.theplanet.co.uk> <20040429130353.GC11624@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040429130353.GC11624@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2004 at 06:33:53PM +0530, Maneesh Soni wrote:

[snip]

> @@ -167,10 +175,14 @@ void sysfs_rename_dir(struct kobject * k
>  	parent = kobj->parent->dentry;
>  
>  	down(&parent->d_inode->i_sem);
> -
>  	new_dentry = sysfs_get_dentry(parent, new_name);
> -	d_move(kobj->dentry, new_dentry);
> -	kobject_set_name(kobj,new_name);
> +	if (!IS_ERR(new_dentry)) {
> +		down_write(&sysfs_rename_sem);
> +		d_move(kobj->dentry, new_dentry);
> +		kobject_set_name(kobj,new_name);
> +		up_write(&sysfs_rename_sem);
> +		dput(new_dentry);
> +	}
>  	up(&parent->d_inode->i_sem);	
>  }

I would probably lift that rwsem all way up - in front of any other locks
in sysfs_rename_dir().  Note that kobject_set_name() can very well lead to
allocations, so just to make the lock hierarchy cleaner...  Another thing:
please, check that new_dentry is negative here.  Other than that, I've
got no problems with the patch.
