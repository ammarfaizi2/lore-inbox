Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262993AbUCSNkl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 08:40:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262992AbUCSNkl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 08:40:41 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:28625 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S262993AbUCSNkb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 08:40:31 -0500
Date: Fri, 19 Mar 2004 14:40:28 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bind Mount Extensions 0.04.1 3/5
Message-ID: <20040319134028.GA5297@MAIL.13thfloor.at>
Mail-Followup-To: viro@parcelfarce.linux.theplanet.co.uk,
	Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <20040315035506.GB30948@MAIL.13thfloor.at> <20040314201457.23fdb96e.akpm@osdl.org> <20040315042541.GA31412@MAIL.13thfloor.at> <20040314203427.27857fd9.akpm@osdl.org> <20040315075814.GE31818@MAIL.13thfloor.at> <20040318122645.GJ31500@parcelfarce.linux.theplanet.co.uk> <20040319025236.GC31040@MAIL.13thfloor.at> <20040319111117.GP31500@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040319111117.GP31500@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2004 at 11:11:17AM +0000, viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Fri, Mar 19, 2004 at 03:52:36AM +0100, Herbert Poetzl wrote:
> > @@ -846,6 +846,16 @@ int presto_permission(struct inode *inod
> >  
> >          cache = presto_get_cache(inode);
> >  
> > +        /* Nobody gets write access to a read-only fs */
> > +        if ((mask & MAY_WRITE) &&
> > +                (S_ISREG(mode) || S_ISDIR(mode) || S_ISLNK(mode)) &&
> > +                (IS_RDONLY(inode) || (nd && MNT_IS_RDONLY(nd->mnt))))
> > +                return -EROFS;
> > +
> > +        /* Nobody gets write access to an immutable file */
> > +        if ((mask & MAY_WRITE) && IS_IMMUTABLE(inode))
> > +                return -EACCES;
> > +
> 
> That is gratitious, since the only way presto_setattr() 
> is ever called is as ->permission().

you mean presto_permission(), and yes, so that can be removed

> > --- linux-2.6.5-rc1-bk3-bme0.04.2-atime/fs/jfs/acl.c	2004-03-11 03:55:21.000000000 +0100
> > +++ linux-2.6.5-rc1-bk3-bme0.04.2-permission/fs/jfs/acl.c	2004-03-19 03:18:12.000000000 +0100
> > @@ -132,21 +132,6 @@ int jfs_permission(struct inode * inode,
> >  	umode_t mode = inode->i_mode;
> >  	struct jfs_inode_info *ji = JFS_IP(inode);
> >  
> > -	if (mask & MAY_WRITE) {
> > -		/*
> 
> ... and that is broken, since jfs_permission() can be called directly.

incomplete, not broken ...

	 -· jfs_permission()
	  ¦-· can_get_xattr()
	  ¦ '-· __jfs_getxattr()
	  ¦   ¦-· jfs_get_acl()
	  ¦   ¦ ¦-· jfs_acl_chmod()
	  ¦   ¦ ¦ '-· jfs_setattr()
	  ¦   ¦ ¦ 
	  ¦   ¦ ¦-· jfs_init_acl()
	  ¦   ¦ ¦ ¦-· jfs_create()
	  ¦   ¦ ¦ ¦-· jfs_mkdir()
	  ¦   ¦ ¦ ¦-· jfs_mknod()
	  ¦   ¦ ¦ '-· jfs_symlink()
	  ¦   ¦ ¦ 
	  ¦   ¦ '-= jfs_permission()
	  ¦   ¦ 
	  ¦   '-· jfs_getxattr()
	  ¦   
	  '-· can_set_xattr()
	    '-· __jfs_setxattr()
	      ¦-· jfs_removexattr()
	      ¦-· jfs_set_acl()
	      ¦ ¦-= jfs_acl_chmod()
	      ¦ '-= jfs_init_acl()
	      ¦ 
	      '-· jfs_setxattr()


the xattr struff needs attention anyway, and many
of the functions calling jfs_permission() directly or
indirectly will have the check at a higher layer ...

> FWIW, I would start with
> 	1) split out simple_permission() - vfs_permission() sans the
> r/o checks; vfs_permission() would call it and all in-tree calls of
> vfs_permission() would get expanded.

	 -· vfs_permission()
	  ¦-· hfs_permission()
	  ¦-· hfsplus_permission()
	  ¦-· nfs_permission()
	  ¦-* permission()
	  ¦-· presto_permission()
	  '-· proc_permission()

please elaborate ...

> 	2) prove that all instances of ->permission() honour r/o checks.
> Fix the broken ones (and yes, we do have them - e.g. hfs_permission()
> or bogus return values in proc_permission()), after we'd shown that
> it's safe.  Note that it's not obvious - e.g. anything around ACLs or
> <barf> XFS ioctls is not just fscking ugly - it's brittle as hell and
> will require very careful treatment.

okay, but why not do it in permission(), and make
the few callers of vfs_permission use that one instead?

except for jfs_permission() and nfsd_permission()
(which is hell enough) there are no direct calls
of *_permission() ...

> 	3) once that is done, put r/o checks into the beginning of
> permission(9)

hmm, obviously you didn't read the patch at all, as that 
is exactly what I did, so please have a look at it ...

> 	4) for all instances of ->permission(), move r/o checks in
> the places that call that instance directly.  Remove them from method
> itself.
> 
> 	And yes, #2 will hurt.  Badly.

I don't see why, please enlighten me ...

> BTW, IS_RDONLY() part of that stuff will really hit the fan when you start
> touching the FPOS in fs/ext2/xattr.c and around it.  Have fun...
> 
> Note that it's not enough to bring relevant vfsmount to every caller of
> IS_RDONLY() - if we are calling it to make sure that fs is not r/o,
> we _really_ want to make sure that it doesn't get remounted r/o just as
> IS_RDONLY() returns.  And yes, there are real bugs in that area.

hmm, well but how would moving the ro checks around
or adding them for the vfs mounts influence that?

I agree that this _is_ an issue but why should this _not_
happen with mount -o remount,ro /xy ?

best,
Herbert

