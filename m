Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964895AbVITHRq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964895AbVITHRq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 03:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964893AbVITHRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 03:17:46 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:13486 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932754AbVITHRp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 03:17:45 -0400
Date: Tue, 20 Sep 2005 08:17:41 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Ram <linuxram@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, akpm@osdl.org,
       miklos@szeredi.hu, mike@waychison.com, bfields@fieldses.org,
       serue@us.ibm.com
Subject: Re: [RFC PATCH 5/10] vfs: shared subtree aware bind mounts
Message-ID: <20050920071741.GI7992@ftp.linux.org.uk>
References: <20050916182619.GA28489@RAM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050916182619.GA28489@RAM>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2005 at 11:26:19AM -0700, Ram wrote:

This patch needs to be split *AND* accompanied by locking rules.  It's
pretty much the core of the entire thing; if it's possible to offload
chunks elsewhere, life would become easier.  Locking rules are badly
needed, along with the comments re "why can't that mntput()/dput()
block under a spinlock", etc.

BTW, how are you dealing with MS_MOVE?

> +void do_detach_prepare_mnt(struct vfsmount *mnt)
> +{
> +	mnt->mnt_mountpoint->d_mounted--;
> +	mntput(mnt->mnt_parent);
> +	dput(mnt->mnt_mountpoint);
> +	mnt->mnt_parent = mnt;
> +}

General note: mntput() should go _after_ dput() when we deal with pairs.
Doesn't cost anything, trivially safe.

>  	if (res) {
>  		spin_lock(&vfsmount_lock);
> +		clean_propagation_reference(res);

Uh-oh...  What makes that safe?  We do mntput() here; are we guaranteed
that these pointers won't be the last references?

> +		spin_lock(&vfspnode_lock);
> +		propagate_abort_mount(m);

Calls do_detach_prepare() -> dput(), mntput().  At the very least such
cases need comments...

> +static void __do_make_private(struct vfsmount *mnt)
> +{
> +	__do_make_slave(mnt);
> +	list_del_init(&mnt->mnt_slave);
> +	mnt->mnt_master = NULL;
> +	set_mnt_private(mnt);
> +}
> +
>  int do_make_private(struct vfsmount *mnt)
>  {
>  	/*
>  	 * a private mount is nothing but a
>  	 * slave mount with no incoming
>  	 * propagations.
>  	 */
>  	spin_lock(&vfspnode_lock);
> -	__do_make_slave(mnt);
> -	list_del_init(&mnt->mnt_slave);
> +	__do_make_private(mnt);
>  	spin_unlock(&vfspnode_lock);
> -	mnt->mnt_master = NULL;
> -	set_mnt_private(mnt);
>  	return 0;
>  }

Why not do that from the very beginning, BTW?

>  	/*
> -	 * a unclonable mount is nothing but a
> +	 * a unclonable mount is a
>  	 * private mount which is unclonnable.
>  	 */
>  	spin_lock(&vfspnode_lock);
> -	__do_make_slave(mnt);
> -	list_del_init(&mnt->mnt_slave);
> +	__do_make_private(mnt);
>  	spin_unlock(&vfspnode_lock);
> -	mnt->mnt_master = NULL;
>  	set_mnt_unclonable(mnt);
>  	return 0;
>  }
