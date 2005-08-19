Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932711AbVHSURE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932711AbVHSURE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 16:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932707AbVHSURE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 16:17:04 -0400
Received: from pasta.sw.starentnetworks.com ([12.33.234.10]:2229 "EHLO
	pasta.sw.starentnetworks.com") by vger.kernel.org with ESMTP
	id S932701AbVHSURC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 16:17:02 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17158.15932.939201.786982@cortez.sw.starentnetworks.com>
Date: Fri, 19 Aug 2005 16:17:00 -0400
From: Dave Johnson <djohnson+linux-kernel@sw.starentnetworks.com>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] fix cramfs making duplicate entries in inode cache
X-Mailer: VM 7.07 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Every time cramfs_lookup() is called to lookup and inode for a dentry,
get_cramfs_inode() will allocate a new inode without checking to see
if that inode already exists in the inode cache.

This is fine the first time, but if the dentry cache entry(ies)
associated with that inode are aged out, but the inode entry is not
aged out (which can be quite common if the inode has buffer cache
linked to it), cramfs_lookup() will be called again and another inode
will be allocated and added to the inode cache creating a duplicate in
the inode cache.

The big issue here is that the buffers associated with each inode
cache entry are not shared between the duplicates!

The older inode entries are now orphaned as no dentry points to it and
won't be freed until the buffer cache assoicated with them are first
freed.  The newest entry will have to create all new buffer cache for
each part of its file as the old buffer cache is now orphaned as well.

Patch below fixes this by making get_cramfs_inode() use the inode
cache before blindly creating a new entry every time.  This eliminates
the duplicate inodes and duplicate buffer cache.

-- 
Dave Johnson
Starent Networks


===== fs/cramfs/inode.c 1.42 vs edited =====
--- 1.42/fs/cramfs/inode.c	2005-07-14 12:24:48 -04:00
+++ edited/fs/cramfs/inode.c	2005-08-19 15:39:05 -04:00
@@ -44,10 +44,10 @@
 
 static struct inode *get_cramfs_inode(struct super_block *sb, struct cramfs_inode * cramfs_inode)
 {
-	struct inode * inode = new_inode(sb);
+	struct inode * inode = iget_locked(sb, CRAMINO(cramfs_inode));
 	static struct timespec zerotime;
 
-	if (inode) {
+	if (inode && (inode->i_state & I_NEW)) {
 		inode->i_mode = cramfs_inode->mode;
 		inode->i_uid = cramfs_inode->uid;
 		inode->i_size = cramfs_inode->size;
@@ -57,11 +57,6 @@
 		/* Struct copy intentional */
 		inode->i_mtime = inode->i_atime = inode->i_ctime = zerotime;
 		inode->i_ino = CRAMINO(cramfs_inode);
-		/* inode->i_nlink is left 1 - arguably wrong for directories,
-		   but it's the best we can do without reading the directory
-	           contents.  1 yields the right result in GNU find, even
-		   without -noleaf option. */
-		insert_inode_hash(inode);
 		if (S_ISREG(inode->i_mode)) {
 			inode->i_fop = &generic_ro_fops;
 			inode->i_data.a_ops = &cramfs_aops;
@@ -76,6 +72,7 @@
 			init_special_inode(inode, inode->i_mode,
 				old_decode_dev(cramfs_inode->size));
 		}
+		unlock_new_inode(inode);
 	}
 	return inode;
 }

