Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271791AbRH3JQB>; Thu, 30 Aug 2001 05:16:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271741AbRH3JPv>; Thu, 30 Aug 2001 05:15:51 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:55801 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S272009AbRH3JPf>; Thu, 30 Aug 2001 05:15:35 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Thu, 30 Aug 2001 03:15:02 -0600
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Manik Raina <manik@cisco.com>, linux-kernel@vger.kernel.org
Subject: Re: ioctl conflicts
Message-ID: <20010830031502.G541@turbolinux.com>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Manik Raina <manik@cisco.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3B8DEF9D.26F7544D@cisco.com> <E15cN49-0000fz-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15cN49-0000fz-00@the-village.bc.nu>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 30, 2001  09:20 +0100, Alan Cox wrote:
> Manik Raina wrote:
> > I was grep-ing on a 2.4 source tree when i found the
> > following :
> > 
> > ./include/linux/videodev.h:#define VIDIOCGCAP          
> > _IOR('v',1,struct video_capability)
> > ./include/linux/ext2_fs.h:#define  EXT2_IOC_GETVERSION  _IOR('v',1,
> > long)   

Note that these ioctls _should_ still have different numbers because
of the struct sizes, but it is still a small conflict.

> Thats fine. ext2 ioctls and video ioctls go to different places

I had proposed a patch to the ext2 folks to remove the use of the 'v'
space ioctls from ext2.  This would (naturally) be a slow process,
first adding new ioctl numbers in the 'f' space with equivalent function,
then when we expect a reasonable percentage of systems with the new
ioctls, change the tools to try the new ones first and fall back to the
old ones, and finally removing the old ioctls completely.

While there were no complaints, it was a rather luke-warm reception.
There is one good reason to fix the conflict - strace doesn't have
to worry about IOC number conflicts, and can print the symbolic name.

Since these particular ioctls (EXT2_IOC_{GET,SET}VERSION) are not
particularly widely used, it shouldn't be a huge effort to change.
The first part of the change is below (it is already part of ext3 for
2.4).  It should pretty much apply cleanly to 2.2 as well as I don't
think this area has changed very much at all, and it can not possibly
do any harm.

Maybe for 2.5/2.6 a warning message would be printed if the old ioctl
number is being used, and 3.x would remove the old ioctl (4+ years
from now or so).

Cheers, Andreas
=======================================================================
diff -ru linux-2.4.7.orig/fs/ext2/ioctl.c linux-2.4.7-aed/fs/ext2/ioctl.c
--- linux-2.4.7.orig/fs/ext2/ioctl.c	Wed Sep 27 14:41:33 2000
+++ linux-2.4.7-aed/fs/ext2/ioctl.c	Tue Jul 31 16:27:55 2001
@@ -73,9 +73,11 @@
 		mark_inode_dirty(inode);
 		return 0;
 	}
-	case EXT2_IOC_GETVERSION:
+	case EXT2_IOC_GETVERSION_OLD:
+	case EXT2_IOC_GETVERSION_NEW:
 		return put_user(inode->i_generation, (int *) arg);
-	case EXT2_IOC_SETVERSION:
+	case EXT2_IOC_SETVERSION_OLD:
+	case EXT2_IOC_SETVERSION_NEW:
 		if ((current->fsuid != inode->i_uid) && !capable(CAP_FOWNER))
 			return -EPERM;
 		if (IS_RDONLY(inode))
diff -ru linux-2.4.7.orig/include/linux/ext2_fs.h linux-2.4.7-aed/include/linux/ext2_fs.h
--- linux-2.4.7.orig/include/linux/ext2_fs.h	Tue Jul 31 15:00:43 2001
+++ linux-2.4.7-aed/include/linux/ext2_fs.h	Tue Jul 31 16:27:45 2001
@@ -208,8 +212,15 @@
  */
 #define	EXT2_IOC_GETFLAGS		_IOR('f', 1, long)
 #define	EXT2_IOC_SETFLAGS		_IOW('f', 2, long)
-#define	EXT2_IOC_GETVERSION		_IOR('v', 1, long)
-#define	EXT2_IOC_SETVERSION		_IOW('v', 2, long)
+#define	EXT2_IOC_GETVERSION_NEW		_IOR('f', 3, long)
+#define	EXT2_IOC_SETVERSION_NEW		_IOW('f', 4, long)
+#define	EXT2_IOC_GETVERSION_OLD		_IOR('v', 1, long)
+#define	EXT2_IOC_SETVERSION_OLD		_IOW('v', 2, long)
+/* Use the old ioctl numbers for now, until we have had the new ioctl
+ * numbers around for a good while (in case user-space includes this file).
+ */
+#define EXT2_IOC_GETVERSION EXT2_IOC_GETVERSION_OLD
+#define EXT2_IOC_SETVERSION EXT2_IOC_SETVERSION_OLD
 
 /*
  * Structure of an inode on the disk
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

