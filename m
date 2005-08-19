Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932752AbVHSXRJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932752AbVHSXRJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 19:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932750AbVHSXRI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 19:17:08 -0400
Received: from pasta.sw.starentnetworks.com ([12.33.234.10]:65206 "EHLO
	pasta.sw.starentnetworks.com") by vger.kernel.org with ESMTP
	id S932336AbVHSXRG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 19:17:06 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17158.26734.542604.606241@cortez.sw.starentnetworks.com>
Date: Fri, 19 Aug 2005 19:17:02 -0400
From: Dave Johnson <djohnson+linux-kernel@sw.starentnetworks.com>
To: Phillip Lougher <phillip@lougher.demon.co.uk>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fix cramfs making duplicate entries in inode cache
In-Reply-To: <43064E46.3040706@lougher.demon.co.uk>
References: <17158.15932.939201.786982@cortez.sw.starentnetworks.com>
	<43064E46.3040706@lougher.demon.co.uk>
X-Mailer: VM 7.07 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phillip Lougher writes:
> Doesn't iget_locked() assume inode numbers are unique?
> 
> In Cramfs inode numbers are set to 1 for non-data inodes (fifos, 
> sockets, devices, empty directories), i.e
> 
> %stat device namedpipe
>    File: `device'
>    Size: 0               Blocks: 0          IO Block: 4096   character 
> special file
> Device: 700h/1792d      Inode: 1           Links: 1     Device type: 1,1
> Access: (0644/crw-r--r--)  Uid: (    0/    root)   Gid: (    0/    root)
> Access: 1970-01-01 01:00:00.000000000 +0100
> Modify: 1970-01-01 01:00:00.000000000 +0100
> Change: 1970-01-01 01:00:00.000000000 +0100
>    File: `namedpipe'
>    Size: 0               Blocks: 0          IO Block: 4096   fifo
> Device: 700h/1792d      Inode: 1           Links: 1
> Access: (0644/prw-r--r--)  Uid: (    0/    root)   Gid: (    0/    root)
> Access: 1970-01-01 01:00:00.000000000 +0100
> Modify: 1970-01-01 01:00:00.000000000 +0100
> Change: 1970-01-01 01:00:00.000000000 +0100
> 
> Should iget5_locked() be used here?

Yep, that was busted.  Below patch should be better.

-- 
Dave Johnson
Starent Networks


===== fs/cramfs/inode.c 1.42 vs edited =====
--- 1.42/fs/cramfs/inode.c	2005-07-14 12:24:48 -04:00
+++ edited/fs/cramfs/inode.c	2005-08-19 18:47:28 -04:00
@@ -42,12 +42,43 @@
 #define CRAMINO(x)	((x)->offset?(x)->offset<<2:1)
 #define OFFSET(x)	((x)->i_ino)
 
+
+static int cramfs_iget5_test(struct inode *inode, void *opaque)
+{
+	struct cramfs_inode * cramfs_inode = (struct cramfs_inode *)opaque;
+
+	if (inode->i_ino != 1)
+		return 1;
+
+	/* all empty directories, char, block, pipe, and sock, share inode #1 */
+  
+	if ((inode->i_mode != cramfs_inode->mode) ||
+	    (inode->i_gid != cramfs_inode->gid) ||
+	    (inode->i_uid != cramfs_inode->uid))
+		return 0; /* does not match */
+  
+	if ((S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode)) &&
+	    (inode->i_rdev != old_decode_dev(cramfs_inode->size)))
+		return 0; /* does not match */
+
+	return 1; /* matches */
+}
+
+static int cramfs_iget5_set(struct inode *inode, void *opaque)
+{
+	struct cramfs_inode * cramfs_inode = (struct cramfs_inode *)opaque;
+	inode->i_ino = CRAMINO(cramfs_inode);
+	return 0;
+}
+
 static struct inode *get_cramfs_inode(struct super_block *sb, struct cramfs_inode * cramfs_inode)
 {
-	struct inode * inode = new_inode(sb);
+	struct inode * inode = iget5_locked(sb, CRAMINO(cramfs_inode),
+					    cramfs_iget5_test, cramfs_iget5_set,
+					    cramfs_inode);
 	static struct timespec zerotime;
 
-	if (inode) {
+	if (inode && (inode->i_state & I_NEW)) {
 		inode->i_mode = cramfs_inode->mode;
 		inode->i_uid = cramfs_inode->uid;
 		inode->i_size = cramfs_inode->size;
@@ -59,11 +92,6 @@
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
@@ -75,6 +104,7 @@
 			init_special_inode(inode, inode->i_mode,
 				old_decode_dev(cramfs_inode->size));
 		}
+		unlock_new_inode(inode);
 	}
 	return inode;
 }

