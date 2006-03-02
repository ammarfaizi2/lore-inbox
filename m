Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751442AbWCBRp6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751442AbWCBRp6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 12:45:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751445AbWCBRp6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 12:45:58 -0500
Received: from newmail.sw.starentnetworks.com ([12.33.234.78]:18950 "EHLO
	mail.sw.starentnetworks.com") by vger.kernel.org with ESMTP
	id S1751442AbWCBRp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 12:45:57 -0500
From: Dave Johnson <djohnson@sw.starentnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17415.12115.309050.248989@zeus.sw.starentnetworks.com>
Date: Thu, 2 Mar 2006 12:45:55 -0500
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: Olaf Hering <olh@suse.de>, mason@suse.com, agruen@suse.de
Subject: [PATCH] Re: cramfs mounts provide corrupted content since 2.6.15
In-Reply-To: <20060302093216.67b90533.akpm@osdl.org>
References: <20060225110844.GA18221@suse.de>
	<20060225220130.GA2748@suse.de>
	<17411.10591.927433.619327@zeus.sw.starentnetworks.com>
	<200602281414.57084.mason@suse.com>
	<20060301155813.245d71ff.akpm@osdl.org>
	<20060301235858.GA6792@suse.de>
	<17414.16541.260439.712849@zeus.sw.starentnetworks.com>
	<20060302115446.GA9708@suse.de>
	<20060302093216.67b90533.akpm@osdl.org>
X-Mailer: VM 7.17 under 21.4 (patch 17) "Jumbo Shrimp" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fix handling of cramfs images created by util-linux containing empty regular
files.  Images created by cramfstools 1.x were ok.

Fill out inode contents in cramfs_iget5_set() instead of get_cramfs_inode() to
prevent issues if cramfs_iget5_test() is called with I_LOCK|I_NEW still set.


Signed-off-by: Dave Johnson <djohnson+linux-kernel@sw.starentnetworks.com>

diff -Naur linux-2.6.15.4.orig/fs/cramfs/inode.c linux-2.6.15.4/fs/cramfs/inode.c
--- linux-2.6.15.4.orig/fs/cramfs/inode.c	2006-02-10 07:22:48.000000000 +0000
+++ linux-2.6.15.4/fs/cramfs/inode.c	2006-03-02 17:38:05.000000000 +0000
@@ -36,7 +36,7 @@
 
 /* These two macros may change in future, to provide better st_ino
    semantics. */
-#define CRAMINO(x)	((x)->offset?(x)->offset<<2:1)
+#define CRAMINO(x)	(((x)->offset && (x)->size)?(x)->offset<<2:1)
 #define OFFSET(x)	((x)->i_ino)
 
 
@@ -66,8 +66,36 @@
 
 static int cramfs_iget5_set(struct inode *inode, void *opaque)
 {
+	static struct timespec zerotime;
 	struct cramfs_inode *cramfs_inode = opaque;
+	inode->i_mode = cramfs_inode->mode;
+	inode->i_uid = cramfs_inode->uid;
+	inode->i_size = cramfs_inode->size;
+	inode->i_blocks = (cramfs_inode->size - 1) / 512 + 1;
+	inode->i_blksize = PAGE_CACHE_SIZE;
+	inode->i_gid = cramfs_inode->gid;
+	/* Struct copy intentional */
+	inode->i_mtime = inode->i_atime = inode->i_ctime = zerotime;
 	inode->i_ino = CRAMINO(cramfs_inode);
+	/* inode->i_nlink is left 1 - arguably wrong for directories,
+	   but it's the best we can do without reading the directory
+           contents.  1 yields the right result in GNU find, even
+	   without -noleaf option. */
+	if (S_ISREG(inode->i_mode)) {
+		inode->i_fop = &generic_ro_fops;
+		inode->i_data.a_ops = &cramfs_aops;
+	} else if (S_ISDIR(inode->i_mode)) {
+		inode->i_op = &cramfs_dir_inode_operations;
+		inode->i_fop = &cramfs_directory_operations;
+	} else if (S_ISLNK(inode->i_mode)) {
+		inode->i_op = &page_symlink_inode_operations;
+		inode->i_data.a_ops = &cramfs_aops;
+	} else {
+		inode->i_size = 0;
+		inode->i_blocks = 0;
+		init_special_inode(inode, inode->i_mode,
+			old_decode_dev(cramfs_inode->size));
+	}
 	return 0;
 }
 
@@ -77,37 +105,7 @@
 	struct inode *inode = iget5_locked(sb, CRAMINO(cramfs_inode),
 					    cramfs_iget5_test, cramfs_iget5_set,
 					    cramfs_inode);
-	static struct timespec zerotime;
-
 	if (inode && (inode->i_state & I_NEW)) {
-		inode->i_mode = cramfs_inode->mode;
-		inode->i_uid = cramfs_inode->uid;
-		inode->i_size = cramfs_inode->size;
-		inode->i_blocks = (cramfs_inode->size - 1) / 512 + 1;
-		inode->i_blksize = PAGE_CACHE_SIZE;
-		inode->i_gid = cramfs_inode->gid;
-		/* Struct copy intentional */
-		inode->i_mtime = inode->i_atime = inode->i_ctime = zerotime;
-		inode->i_ino = CRAMINO(cramfs_inode);
-		/* inode->i_nlink is left 1 - arguably wrong for directories,
-		   but it's the best we can do without reading the directory
-	           contents.  1 yields the right result in GNU find, even
-		   without -noleaf option. */
-		if (S_ISREG(inode->i_mode)) {
-			inode->i_fop = &generic_ro_fops;
-			inode->i_data.a_ops = &cramfs_aops;
-		} else if (S_ISDIR(inode->i_mode)) {
-			inode->i_op = &cramfs_dir_inode_operations;
-			inode->i_fop = &cramfs_directory_operations;
-		} else if (S_ISLNK(inode->i_mode)) {
-			inode->i_op = &page_symlink_inode_operations;
-			inode->i_data.a_ops = &cramfs_aops;
-		} else {
-			inode->i_size = 0;
-			inode->i_blocks = 0;
-			init_special_inode(inode, inode->i_mode,
-				old_decode_dev(cramfs_inode->size));
-		}
 		unlock_new_inode(inode);
 	}
 	return inode;

