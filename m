Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262734AbREOLTW>; Tue, 15 May 2001 07:19:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262736AbREOLTM>; Tue, 15 May 2001 07:19:12 -0400
Received: from cherry.napri.sk ([194.1.128.4]:21511 "HELO cherry.napri.sk")
	by vger.kernel.org with SMTP id <S262734AbREOLTB>;
	Tue, 15 May 2001 07:19:01 -0400
Date: Tue, 15 May 2001 13:16:49 +0200
From: Peter Kundrat <kundrat@kundrat.sk>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: MS_RDONLY patch (do_remount_sb and cramfs/inode.c)
Message-ID: <20010515131649.A8151@napri.sk>
Mail-Followup-To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <20010515112726.A28961@napri.sk> <20010515122406.A4564@napri.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0i
In-Reply-To: <20010515122406.A4564@napri.sk>; from kundrat on Tue, May 15, 2001 at 12:24:06PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2001 at 12:24:06PM +0200, Peter Kundrat wrote:
> On Tue, May 15, 2001 at 11:27:26AM +0200, Peter Kundrat wrote:
> > This patch does:
> > - set MS_RDONLY flag in cramfs superblock
> > - doesnt allow -w remount in do_remount_sb 
> >   if the filesystem has MS_RDONLY set.
> 
> Oh, ignore the second part. Seems i'd have to supply remount_fs super
> op to prevent that.

How about this one ? Similar thing could be done to other fs as well.
	
		pkx

diff -ur -x *~ -x *.o -x .* Linux-2.4.3.orig/fs/cramfs/inode.c Linux-2.4.3.isdn.kgdb/fs/cramfs/inode.c
--- Linux-2.4.3.orig/fs/cramfs/inode.c	Fri Apr  6 08:09:07 2001
+++ Linux-2.4.3.isdn.kgdb/fs/cramfs/inode.c	Tue May 15 12:56:32 2001
@@ -192,6 +192,8 @@
 		goto out;
 	}
 
+	sb->s_flags |= MS_RDONLY;
+
 	/* Set it all up.. */
 	sb->s_op	= &cramfs_ops;
 	sb->s_root 	= d_alloc_root(get_cramfs_inode(sb, &super.root));
@@ -212,6 +214,14 @@
 	return 0;
 }
 
+static int cramfs_remount (struct super_block * sb, int * flags, char * data)
+{
+	if (*flags & MS_RDONLY) 
+		return 0;
+	else
+		return -EROFS;
+}
+
 /*
  * Read a cramfs directory entry.
  */
@@ -358,6 +368,7 @@
 
 static struct super_operations cramfs_ops = {
 	statfs:		cramfs_statfs,
+	remount_fs:	cramfs_remount,
 };
 
 static DECLARE_FSTYPE_DEV(cramfs_fs_type, "cramfs", cramfs_read_super);
-- 
Peter Kundrat
peter@kundrat.sk
