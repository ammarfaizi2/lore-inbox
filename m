Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264846AbUEPXT0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264846AbUEPXT0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 19:19:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264848AbUEPXT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 19:19:26 -0400
Received: from smtp-out6.xs4all.nl ([194.109.24.7]:36870 "EHLO
	smtp-out6.xs4all.nl") by vger.kernel.org with ESMTP id S264846AbUEPXTT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 19:19:19 -0400
Date: Mon, 17 May 2004 01:19:16 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv.local
To: Martin Schaffner <schaffner@gmx.li>
cc: linux-kernel@vger.kernel.org
Subject: Re: hfsplus bugs in linux-2.6.5
In-Reply-To: <09C01AA8-A53D-11D8-82DC-0003931E0B62@gmx.li>
Message-ID: <Pine.LNX.4.44.0405170100430.766-100000@serv.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 14 May 2004, Martin Schaffner wrote:

> Here's how to trigger a hfsplus bug in linux-2.6.5:
>
> dd if=/dev/zero of=/test bs=1k count=10k
> newfs_hfs /test
> mount -t hfsplus /test /mnt/test -o loop
> cd /mnt/test
> mkdir a; mkdir b
> mv a b

Thanks for the report, renames of directories were broken, the patch below
fixes this. Could you please try again, if it solves your problem?

> A second, less serious wierdness is that directories created with linux
> are bigger than directories created with Mac OS X: When I do "for
> ((i=1;i>0;i++)); do mkdir $i; done" on a new 1MB-HFS+-image on Mac OS
> X, I can create about 6300 directories. With Linux, it's about 3600.
> Funny that for both, I can't free up any space afterwards, even if I
> delete everything inside the volume.

The HFS+ catalog file (roughly equivalent to the ext inode table) grows
dynamically and the space is usually not used completely, OS X currently
allocates them better than Linux and doesn't leave as much holes. The
other problem is that the catalog file doesn't shrink, as that would
require online defragmentation. It's possible but not really a priority
right now.

bye, Roman

Index: fs/hfsplus/catalog.c
===================================================================
RCS file: /usr/src/cvsroot/linux-2.6/fs/hfsplus/catalog.c,v
retrieving revision 1.1.1.1
diff -u -p -r1.1.1.1 catalog.c
--- a/fs/hfsplus/catalog.c	11 Mar 2004 18:33:35 -0000	1.1.1.1
+++ b/fs/hfsplus/catalog.c	16 May 2004 19:04:38 -0000
@@ -165,11 +165,11 @@ int hfsplus_create_cat(u32 cnid, struct
 	if (err != -ENOENT) {
 		if (!err)
 			err = -EEXIST;
-		goto out;
+		goto err2;
 	}
 	err = hfs_brec_insert(&fd, &entry, entry_size);
 	if (err)
-		goto out;
+		goto err2;

 	hfsplus_cat_build_key(fd.search_key, dir->i_ino, str);
 	entry_size = hfsplus_cat_build_record(&entry, cnid, inode);
@@ -178,16 +178,23 @@ int hfsplus_create_cat(u32 cnid, struct
 		/* panic? */
 		if (!err)
 			err = -EEXIST;
-		goto out;
+		goto err1;
 	}
 	err = hfs_brec_insert(&fd, &entry, entry_size);
-	if (!err) {
-		dir->i_size++;
-		mark_inode_dirty(dir);
-	}
-out:
+	if (err)
+		goto err1;
+
+	dir->i_size++;
+	mark_inode_dirty(dir);
 	hfs_find_exit(&fd);
+	return 0;

+err1:
+	hfsplus_cat_build_key(fd.search_key, cnid, NULL);
+	if (!hfs_brec_find(&fd))
+		hfs_brec_remove(&fd);
+err2:
+	hfs_find_exit(&fd);
 	return err;
 }

Index: fs/hfsplus/dir.c
===================================================================
RCS file: /usr/src/cvsroot/linux-2.6/fs/hfsplus/dir.c,v
retrieving revision 1.1.1.1
diff -u -p -r1.1.1.1 dir.c
--- a/fs/hfsplus/dir.c	11 Mar 2004 18:33:35 -0000	1.1.1.1
+++ b/fs/hfsplus/dir.c	16 May 2004 17:36:26 -0000
@@ -18,6 +18,13 @@
 #include "hfsplus_fs.h"
 #include "hfsplus_raw.h"

+static inline void hfsplus_instantiate(struct dentry *dentry,
+				       struct inode *inode, u32 cnid)
+{
+	dentry->d_fsdata = (void *)(unsigned long)cnid;
+	d_instantiate(dentry, inode);
+}
+
 /* Find the entry inside dir named dentry->d_name */
 static struct dentry *hfsplus_lookup(struct inode *dir, struct dentry *dentry,
 				     struct nameidata *nd)
@@ -52,6 +69,7 @@ again:
 			goto fail;
 		}
 		cnid = be32_to_cpu(entry.folder.id);
+		dentry->d_fsdata = (void *)(unsigned long)cnid;
 	} else if (type == HFSPLUS_FILE) {
 		if (fd.entrylength < sizeof(struct hfsplus_cat_file)) {
 			err = -EIO;
@@ -233,11 +251,11 @@ int hfsplus_create(struct inode *dir, st
 	res = hfsplus_create_cat(inode->i_ino, dir, &dentry->d_name, inode);
 	if (res) {
 		inode->i_nlink = 0;
+		hfsplus_delete_inode(inode);
 		iput(inode);
 		return res;
 	}
-	dentry->d_fsdata = (void *)inode->i_ino;
-	d_instantiate(dentry, inode);
+	hfsplus_instantiate(dentry, inode, inode->i_ino);
 	mark_inode_dirty(inode);
 	return 0;
 }
@@ -284,8 +302,7 @@ int hfsplus_link(struct dentry *src_dent
 		return res;

 	inode->i_nlink++;
-	dst_dentry->d_fsdata = (void *)(unsigned long)cnid;
-	d_instantiate(dst_dentry, inode);
+	hfsplus_instantiate(dst_dentry, inode, cnid);
 	atomic_inc(&inode->i_count);
 	inode->i_ctime = CURRENT_TIME;
 	mark_inode_dirty(inode);
@@ -351,10 +368,11 @@ int hfsplus_mkdir(struct inode *dir, str
 	res = hfsplus_create_cat(inode->i_ino, dir, &dentry->d_name, inode);
 	if (res) {
 		inode->i_nlink = 0;
+		hfsplus_delete_inode(inode);
 		iput(inode);
 		return res;
 	}
-	d_instantiate(dentry, inode);
+	hfsplus_instantiate(dentry, inode, inode->i_ino);
 	mark_inode_dirty(inode);
 	return 0;
 }
@@ -391,7 +409,8 @@ int hfsplus_symlink(struct inode *dir, s
 	res = page_symlink(inode, symname, strlen(symname) + 1);
 	if (res) {
 		inode->i_nlink = 0;
-		iput (inode);
+		hfsplus_delete_inode(inode);
+		iput(inode);
 		return res;
 	}

@@ -399,8 +418,7 @@ int hfsplus_symlink(struct inode *dir, s
 	res = hfsplus_create_cat(inode->i_ino, dir, &dentry->d_name, inode);

 	if (!res) {
-		dentry->d_fsdata = (void *)inode->i_ino;
-		d_instantiate(dentry, inode);
+		hfsplus_instantiate(dentry, inode, inode->i_ino);
 		mark_inode_dirty(inode);
 	}

@@ -421,12 +439,12 @@ int hfsplus_mknod(struct inode *dir, str
 	res = hfsplus_create_cat(inode->i_ino, dir, &dentry->d_name, inode);
 	if (res) {
 		inode->i_nlink = 0;
+		hfsplus_delete_inode(inode);
 		iput(inode);
 		return res;
 	}
 	init_special_inode(inode, mode, rdev);
-	dentry->d_fsdata = (void *)inode->i_ino;
-	d_instantiate(dentry, inode);
+	hfsplus_instantiate(dentry, inode, inode->i_ino);
 	mark_inode_dirty(inode);

 	return 0;

