Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262702AbREOJcc>; Tue, 15 May 2001 05:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262705AbREOJcW>; Tue, 15 May 2001 05:32:22 -0400
Received: from cherry.napri.sk ([194.1.128.4]:9747 "HELO cherry.napri.sk")
	by vger.kernel.org with SMTP id <S262702AbREOJcN>;
	Tue, 15 May 2001 05:32:13 -0400
Date: Tue, 15 May 2001 11:27:26 +0200
From: Peter Kundrat <kundrat@kundrat.sk>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: MS_RDONLY patch (do_remount_sb and cramfs/inode.c)
Message-ID: <20010515112726.A28961@napri.sk>
Mail-Followup-To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch does:
- set MS_RDONLY flag in cramfs superblock
- doesnt allow -w remount in do_remount_sb 
  if the filesystem has MS_RDONLY set.

Without it, it is possible to remount r/o
filesystem with -w and truncate files on it.
I hope that doesnt fall into 'dont do that then'
category.
Please apply.

	Regards,

		pkx

diff -ur -x *~ -x *.o -x .* Linux-2.4.3.orig/fs/cramfs/inode.c Linux-2.4.3.isdn.kgdb/fs/cramfs/inode.c
--- Linux-2.4.3.orig/fs/cramfs/inode.c	Fri Apr  6 08:09:07 2001
+++ Linux-2.4.3.isdn.kgdb/fs/cramfs/inode.c	Mon May 14 18:51:08 2001
@@ -192,6 +192,8 @@
 		goto out;
 	}
 
+	sb->s_flags |= MS_RDONLY;
+
 	/* Set it all up.. */
 	sb->s_op	= &cramfs_ops;
 	sb->s_root 	= d_alloc_root(get_cramfs_inode(sb, &super.root));
diff -ur -x *~ -x *.o -x .* Linux-2.4.3.orig/fs/super.c Linux-2.4.3.isdn.kgdb/fs/super.c
--- Linux-2.4.3.orig/fs/super.c	Fri Apr  6 08:09:08 2001
+++ Linux-2.4.3.isdn.kgdb/fs/super.c	Tue May 15 10:53:12 2001
@@ -944,7 +944,7 @@
 {
 	int retval;
 	
-	if (!(flags & MS_RDONLY) && sb->s_dev && is_read_only(sb->s_dev))
+	if (!(flags & MS_RDONLY) && ((sb->s_flags & MS_RDONLY) || sb->s_dev && is_read_only(sb->s_dev)))
 		return -EACCES;
 		/*flags |= MS_RDONLY;*/
 	/* If we are remounting RDONLY, make sure there are no rw files open */

-- 
Peter Kundrat
peter@kundrat.sk
