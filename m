Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750773AbWCYELE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbWCYELE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 23:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbWCYELC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 23:11:02 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:3487 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S1750781AbWCYELA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 23:11:00 -0500
Date: Fri, 24 Mar 2006 20:10:38 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org,
       djohnson@sw.starentnetworks.com,
       djohnson+linux-kernel@sw.starentnetworks.com, olh@suse.de,
       mason@suse.com, agruen@suse.de, Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk
Subject: [PATCH 04/08] cramfs mounts provide corrupted content since 2.6.15
Message-ID: <20060325041038.GE16955@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060325040852.GA16955@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Johnson <djohnson@sw.starentnetworks.com>

Fix handling of cramfs images created by util-linux containing empty
regular files.  Images created by cramfstools 1.x were ok.

Fill out inode contents in cramfs_iget5_set() instead of get_cramfs_inode()
to prevent issues if cramfs_iget5_test() is called with I_LOCK|I_NEW still
set.

Signed-off-by: Dave Johnson <djohnson+linux-kernel@sw.starentnetworks.com>
Cc: Olaf Hering <olh@suse.de>
Cc: Chris Mason <mason@suse.com>
Cc: Andreas Gruenbacher <agruen@suse.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 fs/cramfs/inode.c |   60 ++++++++++++++++++++++++++----------------------------
 1 file changed, 29 insertions(+), 31 deletions(-)

ff3aea0e68bfd46120ce2d08bc1f8240fa2bd36a
--- linux-2.6.15.6.orig/fs/cramfs/inode.c
+++ linux-2.6.15.6/fs/cramfs/inode.c
@@ -36,7 +36,7 @@ static DECLARE_MUTEX(read_mutex);
 
 /* These two macros may change in future, to provide better st_ino
    semantics. */
-#define CRAMINO(x)	((x)->offset?(x)->offset<<2:1)
+#define CRAMINO(x)	(((x)->offset && (x)->size)?(x)->offset<<2:1)
 #define OFFSET(x)	((x)->i_ino)
 
 
@@ -66,8 +66,36 @@ static int cramfs_iget5_test(struct inod
 
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
 
@@ -77,37 +105,7 @@ static struct inode *get_cramfs_inode(st
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
