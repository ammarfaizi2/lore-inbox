Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262553AbUKAQgY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262553AbUKAQgY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 11:36:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268823AbUKAQaO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 11:30:14 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:17645 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S270158AbUKAQ2G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 11:28:06 -0500
Date: Mon, 1 Nov 2004 17:27:47 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Horms <horms@verge.net.au>
cc: LKML <linux-kernel@vger.kernel.org>, Siep Kroonenberg <siepo@cybercomm.nl>,
       278068@bugs.debian.org
Subject: Re: chmod messes up permissions on hfs filesystem
In-Reply-To: <20041101043559.GA12500@verge.net.au>
Message-ID: <Pine.LNX.4.61.0411011721560.877@scrub.home>
References: <20041101043559.GA12500@verge.net.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 1 Nov 2004, Horms wrote:

> -rw-r--r--
> after chmod g+w:
> -rw-rw-rw-

No, this command will do nothing, as only the owner write bit is checked  
and the owner bit is mirrored in the other parts (minus umask).
Below is a patch which should fix the original problem.

bye, Roman


Index: fs/hfs/inode.c
===================================================================
RCS file: /home/other/cvs/linux/linux-2.6/fs/hfs/inode.c,v
retrieving revision 1.1.1.5
diff -u -p -r1.1.1.5 inode.c
--- fs/hfs/inode.c	17 Jun 2004 08:39:32 -0000	1.1.1.5
+++ fs/hfs/inode.c	1 Nov 2004 16:14:50 -0000
@@ -313,7 +313,7 @@ int hfs_read_inode(struct inode *inode, 
 		inode->i_mode = S_IRUGO | S_IXUGO;
 		if (!(rec->file.Flags & HFS_FIL_LOCK))
 			inode->i_mode |= S_IWUGO;
-		inode->i_mode &= hsb->s_file_umask;
+		inode->i_mode &= ~hsb->s_file_umask;
 		inode->i_mode |= S_IFREG;
 		inode->i_ctime = inode->i_atime = inode->i_mtime =
 				hfs_m_to_utime(rec->file.MdDat);
@@ -326,7 +326,7 @@ int hfs_read_inode(struct inode *inode, 
 		inode->i_ino = be32_to_cpu(rec->dir.DirID);
 		inode->i_blocks = 0;
 		inode->i_size = be16_to_cpu(rec->dir.Val) + 2;
-		inode->i_mode = S_IFDIR | (S_IRWXUGO & hsb->s_dir_umask);
+		inode->i_mode = S_IFDIR | (S_IRWXUGO & ~hsb->s_dir_umask);
 		inode->i_ctime = inode->i_atime = inode->i_mtime =
 				hfs_m_to_utime(rec->file.MdDat);
 		inode->i_op = &hfs_dir_inode_operations;
Index: fs/hfs/super.c
===================================================================
RCS file: /home/other/cvs/linux/linux-2.6/fs/hfs/super.c,v
retrieving revision 1.1.1.5
diff -u -p -r1.1.1.5 super.c
--- fs/hfs/super.c	10 May 2004 15:02:37 -0000	1.1.1.5
+++ fs/hfs/super.c	1 Nov 2004 16:03:14 -0000
@@ -150,8 +150,8 @@ static int parse_options(char *options, 
 	/* initialize the sb with defaults */
 	hsb->s_uid = current->uid;
 	hsb->s_gid = current->gid;
-	hsb->s_file_umask = 0644;
-	hsb->s_dir_umask = 0755;
+	hsb->s_file_umask = 0133;
+	hsb->s_dir_umask = 0022;
 	hsb->s_type = 0x3f3f3f3f;	/* == '????' */
 	hsb->s_creator = 0x3f3f3f3f;	/* == '????' */
 	hsb->s_quiet = 0;
