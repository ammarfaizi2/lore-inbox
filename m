Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263679AbTI2QUR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 12:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263681AbTI2QUR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 12:20:17 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:34500 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S263679AbTI2QUF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 12:20:05 -0400
Date: Mon, 29 Sep 2003 18:20:04 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: =?iso-8859-1?B?R+Fib3IgTOlu4XJ0?= <lgb@lgb.hu>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Bind Mount Extensions (RO --bind mounts)
Message-ID: <20030929162004.GB21717@DUK2.13thfloor.at>
Mail-Followup-To: =?iso-8859-1?B?R+Fib3IgTOlu4XJ0?= <lgb@lgb.hu>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030928155515.GA4325@DUK2.13thfloor.at> <20030929111941.GG11543@vega.digitel2002.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030929111941.GG11543@vega.digitel2002.hu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 29, 2003 at 01:19:41PM +0200, Gábor Lénárt wrote:
> tatus: O
> Content-Length: 1317
> Lines: 31
> 
> Hi!
> 
> On Sun, Sep 28, 2003 at 05:55:15PM +0200, Herbert Poetzl wrote:
> > verified that the patches apply on linux-2.6.0-test6
> > and work as expected ...
> > 
> > FYI, this patch (hopefully) allows RO --bind mounts
> > to 'behave' like other ro mounted filesystems, and
> > I hope that they will be included in the mainline
> > in the near future ;)
> 
> Maybe (sure ;-) it will be somewhat newbie question ...

you are welcome to ask!

> I don't know too much on kernel internals, but imho --bind 
> mounts and likes should be implemented at VFS layer. 

yes they are

> So then why the patch effects filesystems like ext2 and ext3? 

because ext2 and ext3 (and the other FS too) use them ;)

> Till now I've thought that VFS is a general layer, and syscalls 
> about file operations use general VFS functions which of course 
> call the desired functions from filesystem implementations to do a
> certain work. 

except for FS specific ioctls/features this is true ...

> If it's true (is it?) why not only VFS is needed to change to
> support eg ro --bind? 

hmm, IIRC I never mentioned any filesystem except intermezzo
which is a special case ...

> Does your patch mean that reiserfs or something else
> does not work with it? Because your patch contains filesystem 
> code modifications so I can inmagine that it won't work with 
> a great number of filesystems, like Minix, AFFS, msdos, etc etc ...

I've extracted the relevant hunks from the patch, and
you can see, that those FS specific modifications only
affect the FS specific ioctls, which do not use the
VFS layer (yet?) ... (at end of mail)

> BTW. It would be much more funny to have --bind mounts
> supporting all general mount options, like ro (ok so this is the patch),
> noexec, and such. 

yes, I will implement them, but until now, only a few
people seem to care about this stuff, so there seems
no hurry, but you are right, all the other mount features
should be implemented for --bind mounts too ...

best,
Herbert

--- linux-2.6.0-test3/fs/ext2/ioctl.c	2003-07-14 05:39:30.000000000 +0200
+++ linux-2.6.0-test3-bme0.03/fs/ext2/ioctl.c	2003-08-09 17:05:51.000000000 +0200
@@ -29,7 +30,7 @@
 	case EXT2_IOC_SETFLAGS: {
 		unsigned int oldflags;
 
-		if (IS_RDONLY(inode))
+		if (IS_RDONLY(inode) || MNT_IS_RDONLY(filp->f_vfsmnt))
 			return -EROFS;
 
 		if ((current->fsuid != inode->i_uid) && !capable(CAP_FOWNER))
@@ -68,7 +69,7 @@
 	case EXT2_IOC_SETVERSION:
 		if ((current->fsuid != inode->i_uid) && !capable(CAP_FOWNER))
 			return -EPERM;
-		if (IS_RDONLY(inode))
+		if (IS_RDONLY(inode) || MNT_IS_RDONLY(filp->f_vfsmnt))
 			return -EROFS;
 		if (get_user(inode->i_generation, (int *) arg))
 			return -EFAULT;	
--- linux-2.6.0-test3/fs/ext3/ioctl.c	2003-07-14 05:33:10.000000000 +0200
+++ linux-2.6.0-test3-bme0.03/fs/ext3/ioctl.c	2003-08-09 17:06:08.000000000 +0200
@@ -34,7 +35,7 @@
 		unsigned int oldflags;
 		unsigned int jflag;
 
-		if (IS_RDONLY(inode))
+		if (IS_RDONLY(inode) || MNT_IS_RDONLY(filp->f_vfsmnt))
 			return -EROFS;
 
 		if ((current->fsuid != inode->i_uid) && !capable(CAP_FOWNER))
@@ -110,7 +111,7 @@
 
 		if ((current->fsuid != inode->i_uid) && !capable(CAP_FOWNER))
 			return -EPERM;
-		if (IS_RDONLY(inode))
+		if (IS_RDONLY(inode) || MNT_IS_RDONLY(filp->f_vfsmnt))
 			return -EROFS;
 		if (get_user(generation, (int *) arg))
 			return -EFAULT;
--- linux-2.6.0-test3/fs/reiserfs/ioctl.c	2003-07-14 05:33:11.000000000 +0200
+++ linux-2.6.0-test3-bme0.03/fs/reiserfs/ioctl.c	2003-08-09 17:06:22.000000000 +0200
@@ -38,7 +39,7 @@
 		i_attrs_to_sd_attrs( inode, ( __u16 * ) &flags );
 		return put_user(flags, (int *) arg);
 	case REISERFS_IOC_SETFLAGS: {
-		if (IS_RDONLY(inode))
+		if (IS_RDONLY(inode) || MNT_IS_RDONLY(filp->f_vfsmnt))
 			return -EROFS;
 
 		if ((current->fsuid != inode->i_uid) && !capable(CAP_FOWNER))
@@ -70,7 +71,7 @@
 	case REISERFS_IOC_SETVERSION:
 		if ((current->fsuid != inode->i_uid) && !capable(CAP_FOWNER))
 			return -EPERM;
-		if (IS_RDONLY(inode))
+		if (IS_RDONLY(inode) || MNT_IS_RDONLY(filp->f_vfsmnt))
 			return -EROFS;
 		if (get_user(inode->i_generation, (int *) arg))
 			return -EFAULT;	

