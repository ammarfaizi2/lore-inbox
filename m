Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262488AbUCSLLV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 06:11:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262750AbUCSLLU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 06:11:20 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25579 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262488AbUCSLLS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 06:11:18 -0500
Date: Fri, 19 Mar 2004 11:11:17 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bind Mount Extensions 0.04.1 3/5
Message-ID: <20040319111117.GP31500@parcelfarce.linux.theplanet.co.uk>
References: <20040315035506.GB30948@MAIL.13thfloor.at> <20040314201457.23fdb96e.akpm@osdl.org> <20040315042541.GA31412@MAIL.13thfloor.at> <20040314203427.27857fd9.akpm@osdl.org> <20040315075814.GE31818@MAIL.13thfloor.at> <20040318122645.GJ31500@parcelfarce.linux.theplanet.co.uk> <20040319025236.GC31040@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040319025236.GC31040@MAIL.13thfloor.at>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2004 at 03:52:36AM +0100, Herbert Poetzl wrote:
> @@ -846,6 +846,16 @@ int presto_permission(struct inode *inod
>  
>          cache = presto_get_cache(inode);
>  
> +        /* Nobody gets write access to a read-only fs */
> +        if ((mask & MAY_WRITE) &&
> +                (S_ISREG(mode) || S_ISDIR(mode) || S_ISLNK(mode)) &&
> +                (IS_RDONLY(inode) || (nd && MNT_IS_RDONLY(nd->mnt))))
> +                return -EROFS;
> +
> +        /* Nobody gets write access to an immutable file */
> +        if ((mask & MAY_WRITE) && IS_IMMUTABLE(inode))
> +                return -EACCES;
> +

That is gratitious, since the only way presto_setattr() is ever called is
as ->permission().

> --- linux-2.6.5-rc1-bk3-bme0.04.2-atime/fs/jfs/acl.c	2004-03-11 03:55:21.000000000 +0100
> +++ linux-2.6.5-rc1-bk3-bme0.04.2-permission/fs/jfs/acl.c	2004-03-19 03:18:12.000000000 +0100
> @@ -132,21 +132,6 @@ int jfs_permission(struct inode * inode,
>  	umode_t mode = inode->i_mode;
>  	struct jfs_inode_info *ji = JFS_IP(inode);
>  
> -	if (mask & MAY_WRITE) {
> -		/*

... and that is broken, since jfs_permission() can be called directly.

FWIW, I would start with
	1) split out simple_permission() - vfs_permission() sans the
r/o checks; vfs_permission() would call it and all in-tree calls of
vfs_permission() would get expanded.

	2) prove that all instances of ->permission() honour r/o checks.
Fix the broken ones (and yes, we do have them - e.g. hfs_permission()
or bogus return values in proc_permission()), after we'd shown that
it's safe.  Note that it's not obvious - e.g. anything around ACLs or
<barf> XFS ioctls is not just fscking ugly - it's brittle as hell and
will require very careful treatment.

	3) once that is done, put r/o checks into the beginning of
permission(9)

	4) for all instances of ->permission(), move r/o checks in
the places that call that instance directly.  Remove them from method
itself.

	And yes, #2 will hurt.  Badly.

BTW, IS_RDONLY() part of that stuff will really hit the fan when you start
touching the FPOS in fs/ext2/xattr.c and around it.  Have fun...

Note that it's not enough to bring relevant vfsmount to every caller of
IS_RDONLY() - if we are calling it to make sure that fs is not r/o,
we _really_ want to make sure that it doesn't get remounted r/o just as
IS_RDONLY() returns.  And yes, there are real bugs in that area.
