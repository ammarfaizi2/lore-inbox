Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283588AbRLOUNp>; Sat, 15 Dec 2001 15:13:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283592AbRLOUNf>; Sat, 15 Dec 2001 15:13:35 -0500
Received: from ns.caldera.de ([212.34.180.1]:47331 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S283588AbRLOUNU>;
	Sat, 15 Dec 2001 15:13:20 -0500
Date: Sat, 15 Dec 2001 21:13:11 +0100
From: Christoph Hellwig <hch@caldera.de>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix for OOPS on failed sysvfs mount
Message-ID: <20011215211311.A2247@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>,
	marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

currently sysvfs lacks to mark inodes for which ->read_inode failed
to be bad.  This make read_super OOPS if the root inode is invalid.

Doesn't touch generic code, ext2 does the same for ages.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.

diff -uNr -Xdontdiff linux-2.4.16/fs/sysv/ChangeLog linux/fs/sysv/ChangeLog
--- linux-2.4.16/fs/sysv/ChangeLog	Mon Dec 10 10:04:53 2001
+++ linux/fs/sysv/ChangeLog	Sat Dec 15 16:56:16 2001
@@ -1,3 +1,12 @@
+Sat Dec 15 2001  Christoph Hellwig  <hch@caldera.de>
+
+	* inode.c (sysv_read_inode): Mark inode as bad in case of failure.
+	* super.c (complete_read_super): Check for bad root inode.
+
+Wed Nov 21 2001  Andrew Morton  <andrewm@uow.edu.au>
+
+	* file.c (sysv_sync_file): Call fsync_inode_data_buffers.
+
 Fri Oct 26 2001  Christoph Hellwig  <hch@caldera.de>
 
 	* dir.c, ialloc.c, namei.c, include/linux/sysv_fs_i.h:
diff -uNr -Xdontdiff linux-2.4.16/fs/sysv/inode.c linux/fs/sysv/inode.c
--- linux-2.4.16/fs/sysv/inode.c	Mon Dec 10 10:04:53 2001
+++ linux/fs/sysv/inode.c	Sat Dec 15 12:56:04 2001
@@ -152,13 +152,13 @@
 		printk("Bad inode number on dev %s"
 		       ": %d is out of range\n",
 		       kdevname(inode->i_dev), ino);
-		return;
+		goto bad_inode;
 	}
 	raw_inode = sysv_raw_inode(sb, ino, &bh);
 	if (!raw_inode) {
 		printk("Major problem: unable to read inode from dev %s\n",
 		       bdevname(inode->i_dev));
-		return;
+		goto bad_inode;
 	}
 	/* SystemV FS: kludge permissions if ino==SYSV_ROOT_INO ?? */
 	inode->i_mode = fs16_to_cpu(sb, raw_inode->i_mode);
@@ -178,6 +178,11 @@
 		rdev = (u16)fs32_to_cpu(sb, inode->u.sysv_i.i_data[0]);
 	inode->u.sysv_i.i_dir_start_lookup = 0;
 	sysv_set_inode(inode, rdev);
+	return;
+
+bad_inode:
+	make_bad_inode(inode);
+	return;
 }
 
 static struct buffer_head * sysv_update_inode(struct inode * inode)
diff -uNr -Xdontdiff linux-2.4.16/fs/sysv/super.c linux/fs/sysv/super.c
--- linux-2.4.16/fs/sysv/super.c	Mon Dec 10 10:04:53 2001
+++ linux/fs/sysv/super.c	Sat Dec 15 12:36:59 2001
@@ -325,7 +325,7 @@
 	/* set up enough so that it can read an inode */
 	sb->s_op = &sysv_sops;
 	root_inode = iget(sb,SYSV_ROOT_INO);
-	if (!root_inode) {
+	if (!root_inode || is_bad_inode(root_inode)) {
 		printk("SysV FS: get root inode failed\n");
 		return 0;
 	}
