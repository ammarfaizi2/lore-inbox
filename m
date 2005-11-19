Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751351AbVKSEVi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbVKSEVi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 23:21:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbVKSEVh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 23:21:37 -0500
Received: from c-67-182-200-232.hsd1.ut.comcast.net ([67.182.200.232]:17654
	"EHLO sshock.homelinux.net") by vger.kernel.org with ESMTP
	id S1751320AbVKSEVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 23:21:35 -0500
Date: Fri, 18 Nov 2005 21:21:30 -0700
From: Phillip Hellewell <phillip@hellewell.homeip.net>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       viro@ftp.linux.org.uk, mike@halcrow.us, mhalcrow@us.ibm.com,
       mcthomps@us.ibm.com, yoder1@us.ibm.com
Subject: [PATCH 9/12: eCryptfs] Inode operations
Message-ID: <20051119042130.GI15747@sshock.rn.byu.edu>
References: <20051119041130.GA15559@sshock.rn.byu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051119041130.GA15559@sshock.rn.byu.edu>
X-URL: http://hellewell.homeip.net/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

eCryptfs inode operations. Includes functions to support inode
interpolation between upper and lower inodes.

Signed-off-by: Phillip Hellewell <phillip@hellewell.homeip.net>
Signed-off-by: Michael Halcrow <mhalcrow@us.ibm.com>
Signed-off-by: Michael Thompson <mcthomps@us.ibm.com>

---

 inode.c | 1084 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 1084 insertions(+)
--- linux-2.6.15-rc1-mm1/fs/ecryptfs/inode.c	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.15-rc1-mm1-ecryptfs/fs/ecryptfs/inode.c	2005-11-18 11:20:09.000000000 -0600
@@ -0,0 +1,1084 @@
+/**
+ * eCryptfs: Linux filesystem encryption layer
+ *
+ * Copyright (c) 1997-2004 Erez Zadok
+ * Copyright (c) 2001-2004 Stony Brook University
+ * Copyright (c) 2005 International Business Machines Corp.
+ *   Author(s): Michael A. Halcrow <mahalcro@us.ibm.com>
+ *              Michael C. Thompsion <mcthomps@us.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
+ * 02111-1307, USA.
+ */
+
+#include <linux/file.h>
+#include <linux/vmalloc.h>
+#include <linux/pagemap.h>
+#include <linux/dcache.h>
+#include <linux/namei.h>
+#include <linux/mount.h>
+#include <linux/crypto.h>
+#include "ecryptfs_kernel.h"
+
+static inline struct dentry *lock_parent(struct dentry *dentry)
+{
+	struct dentry *dir;
+
+	dir = dget(dentry->d_parent);
+	down(&(dir->d_inode->i_sem));
+	return dir;
+}
+
+static inline void unlock_parent(struct dentry *dentry)
+{
+	up(&(dentry->d_parent->d_inode->i_sem));
+	dput(dentry->d_parent);
+}
+
+static inline void unlock_dir(struct dentry *dir)
+{
+	up(&dir->d_inode->i_sem);
+	dput(dir);
+}
+
+void ecryptfs_copy_inode_size(struct inode *dst, const struct inode *src)
+{
+	ecryptfs_printk(1, KERN_NOTICE, "Enter\n");
+	ecryptfs_printk(1, KERN_NOTICE, "src->i_size = [%lld]\n", src->i_size);
+	ecryptfs_printk(1, KERN_NOTICE, "src->i_blocks = [%lu]\n",
+			src->i_blocks);
+	i_size_write(dst, i_size_read((struct inode *)src));
+	dst->i_blocks = src->i_blocks;
+	ecryptfs_printk(1, KERN_NOTICE, "Exit\n");
+}
+
+void ecryptfs_copy_attr_atime(struct inode *dest, const struct inode *src)
+{
+	ASSERT(dest != NULL);
+	ASSERT(src != NULL);
+	dest->i_atime = src->i_atime;
+}
+
+void ecryptfs_copy_attr_times(struct inode *dest, const struct inode *src)
+{
+	ASSERT(dest != NULL);
+	ASSERT(src != NULL);
+	dest->i_atime = src->i_atime;
+	dest->i_mtime = src->i_mtime;
+	dest->i_ctime = src->i_ctime;
+}
+
+static void ecryptfs_copy_attr_timesizes(struct inode *dest,
+					 const struct inode *src)
+{
+	ASSERT(dest != NULL);
+	ASSERT(src != NULL);
+	dest->i_atime = src->i_atime;
+	dest->i_mtime = src->i_mtime;
+	dest->i_ctime = src->i_ctime;
+	ecryptfs_copy_inode_size(dest, src);
+}
+
+void ecryptfs_copy_attr_all(struct inode *dest, const struct inode *src)
+{
+	ecryptfs_printk(1, KERN_NOTICE, "Enter\n");
+	ASSERT(dest != NULL);
+	ASSERT(src != NULL);
+	dest->i_mode = src->i_mode;
+	dest->i_nlink = src->i_nlink;
+	dest->i_uid = src->i_uid;
+	dest->i_gid = src->i_gid;
+	dest->i_rdev = src->i_rdev;
+	dest->i_atime = src->i_atime;
+	dest->i_mtime = src->i_mtime;
+	dest->i_ctime = src->i_ctime;
+	dest->i_blksize = src->i_blksize;
+	ecryptfs_printk(1, KERN_NOTICE, "src->i_blksize = [%lu]\n",
+			src->i_blksize);
+	dest->i_blkbits = src->i_blkbits;
+	dest->i_flags = src->i_flags;
+	ecryptfs_printk(1, KERN_NOTICE, "Exit\n");
+}
+
+/**
+ * Creates our file in the lower file system
+ *
+ * @param lower_dir_inode   inode of the parent in the lower fs of the new file
+ * @param lower_dentry	    New file's dentry in the lower fs
+ * @param ecryptfs_dentry   New file's dentry in ecryptfs
+ * @param mode		    The mode of the new file
+ * @param nd		    nameidata of ecryptfs' parent's dentry & vfsmnt
+ * @return		    0 on success; non-zero on error condition
+ */
+static int
+ecryptfs_create_underlying_file(struct inode *lower_dir_inode,
+				struct dentry *lower_dentry,
+				struct dentry *ecryptfs_dentry, int mode,
+				struct nameidata *nd)
+{
+	int rc;
+	struct dentry *saved_dentry = NULL;
+	struct vfsmount *saved_vfsmount = NULL;
+
+	ecryptfs_printk(1, KERN_NOTICE, "Enter\n");
+	saved_dentry = nd->dentry;
+	saved_vfsmount = nd->mnt;
+	nd->dentry = lower_dentry;
+	nd->mnt = ECRYPTFS_SUPERBLOCK_TO_PRIVATE(
+		ecryptfs_dentry->d_sb)->lower_mnt;
+	rc = vfs_create(lower_dir_inode, lower_dentry, mode, nd);
+	nd->dentry = saved_dentry;
+	nd->mnt = saved_vfsmount;
+	ecryptfs_printk(1, KERN_NOTICE, "Exit; rc = [%d]\n", rc);
+	return rc;
+}
+
+/**
+ * Creates the underlying file and the eCryptfs inode which will link to
+ * it. It will also update the eCryptfs directory inode to mimic the
+ * stats of the lower directory inode
+ *
+ * @param directory_inode   inode of the new file's dentry's parent in ecryptfs
+ * @param ecryptfs_dentry   New file's dentry in ecryptfs
+ * @param mode		    The mode of the new file
+ * @param nd		    nameidata of ecryptfs' parent's dentry & vfsmnt
+ * @return		    0 on success; non-zero on error condition
+ */
+static int
+ecryptfs_do_create(struct inode *directory_inode,
+		   struct dentry *ecryptfs_dentry, int mode,
+		   struct nameidata *nd)
+{
+	int rc;
+	struct dentry *lower_dentry;
+	struct dentry *lower_dir_dentry;
+
+	ecryptfs_printk(1, KERN_NOTICE, "Enter\n");
+	lower_dentry = ecryptfs_lower_dentry(ecryptfs_dentry);
+	if (IS_ERR(lower_dentry)) {
+		ecryptfs_printk(0, KERN_ERR, "ecryptfs dentry doesn't know"
+				"about its lower counterpart\n");
+		rc = PTR_ERR(lower_dentry);
+		goto out;
+	}
+	lower_dir_dentry = lock_parent(lower_dentry);
+	if (unlikely(IS_ERR(lower_dir_dentry))) {
+		ecryptfs_printk(0, KERN_ERR, "Error locking directory of "
+				"dentry\n");
+		rc = PTR_ERR(lower_dir_dentry);
+		goto out;
+	}
+	rc = ecryptfs_create_underlying_file(lower_dir_dentry->d_inode,
+					     lower_dentry, ecryptfs_dentry,
+					     mode, nd);
+	if (unlikely(rc)) {
+		ecryptfs_printk(0, KERN_ERR,
+				"Failure to create underlying file\n");
+		goto out_lock;
+	}
+	rc = ecryptfs_interpose(lower_dentry, ecryptfs_dentry,
+				directory_inode->i_sb, 0);
+	if (rc) {
+		ecryptfs_printk(0, KERN_ERR, "Failure in ecryptfs_interpose\n");
+		goto out_lock;
+	}
+	ecryptfs_copy_attr_timesizes(directory_inode,
+				     lower_dir_dentry->d_inode);
+out_lock:
+	unlock_dir(lower_dir_dentry);
+out:
+	ecryptfs_printk(1, KERN_NOTICE, "Exit; rc = [%d]\n", rc);
+	return rc;
+}
+
+/**
+ * This is the code which will grow the file to be 8192 or
+ * 12288, depending on whether the file derived-IV or
+ * written-IV formatted.
+ */
+static int grow_file(struct dentry *ecryptfs_dentry, struct file *lower_file,
+		     struct inode *inode, struct inode *lower_inode)
+{
+	int rc = 0;
+	struct file fake_file;
+
+	memset(&fake_file, 0, sizeof(fake_file));
+	fake_file.f_dentry = ecryptfs_dentry;
+	ECRYPTFS_FILE_TO_PRIVATE_SM(&fake_file) =
+		kmem_cache_alloc(ecryptfs_file_info_cache, SLAB_KERNEL);
+	if (!(ECRYPTFS_FILE_TO_PRIVATE_SM(&fake_file))) {
+		rc = -ENOMEM;
+		goto out;
+	}
+	ECRYPTFS_FILE_TO_LOWER(&fake_file) = lower_file;
+	ecryptfs_fill_zeros(&fake_file, 1);
+	kmem_cache_free(ecryptfs_file_info_cache,
+			ECRYPTFS_FILE_TO_PRIVATE(&fake_file));
+	i_size_write(inode, 0);
+	ecryptfs_write_inode_size_to_header(lower_file, lower_inode, inode);
+	ECRYPTFS_INODE_TO_PRIVATE(inode)->crypt_stats.new_file = 1;
+out:
+	return rc;
+}
+
+/**
+ * Force the file to be changed from a basic empty file to an ecryptfs file
+ * with a header, 1st IV page & 1st data page
+ *
+ * @return Zero on success
+ */
+static int ecryptfs_initialize_file(struct dentry *ecryptfs_dentry)
+{
+	int rc = 0;
+	int lower_flags;
+	struct ecryptfs_crypt_stats *crypt_stats;
+	struct dentry *lower_dentry;
+	struct dentry *tlower_dentry = NULL;
+	struct file *lower_file;
+	struct inode *inode, *lower_inode;
+	struct vfsmount *lower_mnt;
+
+	ecryptfs_printk(1, KERN_NOTICE, "Enter; dentry->d_name.name = [%s]\n",
+			ecryptfs_dentry->d_name.name);
+
+	lower_dentry = ecryptfs_lower_dentry(ecryptfs_dentry);
+	if (IS_ERR(lower_dentry)) {
+		ecryptfs_printk(0, KERN_ERR, "ecryptfs dentry doesn't know"
+				"about its lower counterpart\n");
+		rc = PTR_ERR(lower_dentry);
+		goto out;
+	}
+
+	ecryptfs_printk(1, KERN_NOTICE, "lower_dentry->d_name.name = [%s]\n",
+			lower_dentry->d_name.name);
+
+	/* This code is migrated from ecryptfs_open... 
+	 * there is no reason that this shouldn't just "work"
+	 * The flags and mode for the file passed into ecryptfs_open is:
+	 * f->f_flags = flags;
+	 * f->f_mode = ((flags+1) & O_ACCMODE) 
+	 *                      | FMODE_LSEEK | FMODE_PREAD | FMODE_PWRITE;
+	 * 
+	 * Where flags = O_CREAT | O_WRONLY | O_TRUNC &
+	 *      ( #if BITS_PER_LONG != 32 ; flags |= O_LARGEFILE; #endif )
+	 *
+	 * Code to initialize the file to be a valid ecryptfs file
+	 */
+	inode = ecryptfs_dentry->d_inode;
+	crypt_stats = &(ECRYPTFS_INODE_TO_PRIVATE(inode)->crypt_stats);
+	/* TODO: Initialization is done in alloc_inode, BUG if its not done */
+	if (!crypt_stats->struct_initialized)
+		BUG();
+	tlower_dentry = dget(lower_dentry);
+	if (!tlower_dentry) {
+		rc = -ENOMEM;
+		ecryptfs_printk(0, KERN_ERR, "Error dget'ing lower_dentry\n");
+		goto out;
+	}
+	lower_flags = ((O_CREAT | O_WRONLY | O_TRUNC) & O_ACCMODE) | O_RDWR;
+#if BITS_PER_LONG != 32
+	lower_flags |= O_LARGEFILE;
+#endif
+	lower_mnt = ECRYPTFS_SUPERBLOCK_TO_PRIVATE(inode->i_sb)->lower_mnt;
+	mntget(lower_mnt);
+	/* Corresponding fput() at end of func */
+	lower_file = dentry_open(tlower_dentry, lower_mnt, lower_flags);
+	if (IS_ERR(lower_file)) {
+		rc = PTR_ERR(lower_file);
+		ecryptfs_printk(0, KERN_ERR,
+				"Error opening dentry; rc = [%i]\n", rc);
+		goto out;
+	}
+	/* fput(lower_file) should handle the puts if we do this */
+	lower_file->f_dentry = tlower_dentry;
+	lower_file->f_vfsmnt = lower_mnt;
+	lower_inode = tlower_dentry->d_inode;
+	if (S_ISDIR(ecryptfs_dentry->d_inode->i_mode)) {
+		ecryptfs_printk(1, KERN_NOTICE, "This is a directory\n");
+		crypt_stats->encrypted = 0;
+		goto out_fput;
+	}
+	crypt_stats->new_file = 1;
+	ecryptfs_printk(1, KERN_NOTICE, "Initializing crypto context\n");
+	rc = ecryptfs_new_file_context(ecryptfs_dentry);	/* crypto.c */
+	if (rc) {
+		ecryptfs_printk(1, KERN_NOTICE, "Error creating new file "
+				"context\n");
+		goto out_fput;
+	}
+	rc = ecryptfs_write_headers(ecryptfs_dentry, lower_file);
+	if (rc) {
+		ecryptfs_printk(1, KERN_NOTICE, "Error writing headers\n");
+		goto out_fput;
+	}
+	rc = grow_file(ecryptfs_dentry, lower_file, inode, lower_inode);
+out_fput:
+	fput(lower_file);
+out:
+	ecryptfs_printk(1, KERN_NOTICE, "Exit; rc = [%d]\n", rc);
+	return rc;
+}
+
+/**
+ * Creates a new file.
+ *
+ * @param dir The inode of the directory in which to create the file.
+ * @param dentry The eCryptfs dentry
+ * @param mode The mode of the new file.
+ * @param nd nameidata
+ * @return 0 on success; non-zero on error condition
+ */
+static int
+ecryptfs_create(struct inode *directory_inode, struct dentry *ecryptfs_dentry,
+		int mode, struct nameidata *nd)
+{
+	int rc;
+
+	ecryptfs_printk(1, KERN_NOTICE, "Enter; ecryptfs_dentry->d_name.name = "
+			"[%s], directory_inode=[%p], ecryptfs_dentry->d_parent"
+			"->d_inode=[%p], nd->dentry=[%p], nd->last.name=[%s], "
+			"ecryptfs_dentry=[%p]\n", ecryptfs_dentry->d_name.name,
+			directory_inode, ecryptfs_dentry->d_parent->d_inode,
+			nd->dentry, nd->last.name, ecryptfs_dentry);
+
+	rc = ecryptfs_do_create(directory_inode, ecryptfs_dentry, mode, nd);
+	if (unlikely(rc)) {
+		ecryptfs_printk(0, KERN_WARNING, "Failed to create file in"
+				"lower filesystem\n");
+		goto out;
+	}
+	/* At this point, a file exists on "disk", we need to make sure
+	 * that this on disk file is prepared to be an ecryptfs file */
+	rc = ecryptfs_initialize_file(ecryptfs_dentry);
+      out:
+	ecryptfs_printk(1, KERN_NOTICE, "Exit; rc = [%d]\n", rc);
+	return rc;
+}
+
+/**
+ * Find a file on disk. If the file does not exist, then we'll add it to the
+ * dentry cache and continue on to read it from the disk.
+ *
+ * @param dir	 inode
+ * @param dentry dentry
+ * @param nd	 nameidata; may be NULL
+ */
+static struct dentry *ecryptfs_lookup(struct inode *dir, struct dentry *dentry,
+				      struct nameidata *nd)
+{
+	int err = 0;
+	struct dentry *lower_dir_dentry;
+	struct dentry *lower_dentry;
+	struct dentry *tlower_dentry = NULL;
+	char *encoded_name;
+	unsigned int encoded_namelen;
+	struct ecryptfs_crypt_stats *crypt_stats = NULL;
+	char *page_virt = NULL;
+	struct inode *lower_inode;
+	unsigned long long file_size;
+
+	ecryptfs_printk(1, KERN_NOTICE, "Enter; dir = [%p], dentry->d_name.nam"
+			"e = [%s], nd = [%p]\n", dir, dentry->d_name.name, nd);
+
+	lower_dir_dentry = ecryptfs_lower_dentry(dentry->d_parent);
+	dentry->d_op = &ecryptfs_dops;
+
+	/* Sanity Check: Make sure we can operate on the file */
+	if ((dentry->d_name.len == 1 && !strcmp(dentry->d_name.name, "."))
+	    || (dentry->d_name.len == 2 && !strcmp(dentry->d_name.name, "..")))
+		goto out_drop;
+
+	encoded_namelen = ecryptfs_encode_filename(dentry->d_name.name,
+						   dentry->d_name.len,
+						   &encoded_name,
+						   ECRYPTFS_SKIP_DOTS,
+						   crypt_stats);
+	if (encoded_namelen < 0) {
+		err = encoded_namelen;
+		goto out_drop;
+	}
+	/* TODO: pretty sure we need to do a dput(lower_dentry) to
+	 * counter */
+	ecryptfs_printk(1, KERN_NOTICE, "encoded_name = [%s]; encoded_namelen "
+			"= [%d]\n", encoded_name, encoded_namelen);
+	/* TODO: BUG: What to do on symlink to directory? */
+	lower_dentry = lookup_one_len(encoded_name, lower_dir_dentry,
+				      encoded_namelen - 1);
+	kfree(encoded_name);
+	if (IS_ERR(lower_dentry)) {
+		ecryptfs_printk(0, KERN_ERR, "ERR from lower_dentry\n");
+		err = PTR_ERR(lower_dentry);
+		goto out_drop;
+	}
+	ecryptfs_printk(1, KERN_NOTICE, "lower_dentry = [%p]; lower_dentry->"
+       		"d_name.name = [%s]\n", lower_dentry,
+		lower_dentry->d_name.name);
+	lower_inode = lower_dentry->d_inode;
+	ecryptfs_copy_attr_atime(dir, lower_dir_dentry->d_inode);
+
+	/* Sanity check */
+	ASSERT(atomic_read(&lower_dentry->d_count));
+
+	/* Private allocation */
+	ECRYPTFS_DENTRY_TO_PRIVATE_SM(dentry) =
+		kmem_cache_alloc(ecryptfs_dentry_info_cache, SLAB_KERNEL);
+	if (!ECRYPTFS_DENTRY_TO_PRIVATE_SM(dentry)) {
+		err = -ENOMEM;
+		ecryptfs_printk(0, KERN_ERR, "Out of memory whilst attempting "
+				"to allocate ecryptfs_dentry_info struct\n");
+		goto out_dput;
+	}
+
+	ECRYPTFS_DENTRY_TO_LOWER(dentry) = lower_dentry;
+	if (!lower_dentry->d_inode) {
+		/* We want to add because we couldn't find in lower */
+		d_add(dentry, NULL);
+		goto out;
+	}
+	err = ecryptfs_interpose(lower_dentry, dentry, dir->i_sb, 1);
+	if (err) {
+		ecryptfs_printk(0, KERN_ERR, "Error interposing\n");
+		goto out_dput;
+	}
+	/* Do we want to just get a handle to the directory and its lower
+	 * and not abort with puts?
+	 */
+	if (S_ISDIR(lower_inode->i_mode)) {
+		ecryptfs_printk(1, KERN_NOTICE, "Is a directory; returning\n");
+		goto out;
+	}
+	if (S_ISLNK(lower_inode->i_mode)) {
+		ecryptfs_printk(1, KERN_NOTICE, "Is a symlink; returning\n");
+		goto out;
+	}
+	/* We have a NULL dentry, can we just skip over the read here? */
+	if (!nd) {
+		ecryptfs_printk(1, KERN_NOTICE, "We have a NULL nd, just leave"
+				"as we *think* we are about to unlink\n");
+		goto out;
+	}
+	tlower_dentry = dget(lower_dentry);
+	if (!tlower_dentry || IS_ERR(tlower_dentry)) {
+		err = -ENOMEM;
+		ecryptfs_printk(0, KERN_ERR, "Cannot dget lower_dentry\n");
+		goto out_dput;
+	}
+	/* Released in this function */
+	page_virt =
+	    (char *)kmem_cache_alloc(ecryptfs_header_cache_2,
+				     SLAB_USER);
+	if (!page_virt) {
+		err = -ENOMEM;
+		ecryptfs_printk(0, KERN_ERR,
+				"Cannot ecryptfs_kmalloc a page\n");
+		goto out_dput;
+	}
+
+	/* Use the file's "header" to determine if its an ecryptfs file */
+	err = ecryptfs_read_header_region(page_virt, tlower_dentry, nd);
+	/* Force default values if we haven't parsed the header */
+	crypt_stats = 
+		&(ECRYPTFS_INODE_TO_PRIVATE(dentry->d_inode)->crypt_stats);
+	if (!crypt_stats->policy_applied)
+		ecryptfs_set_default_sizes(crypt_stats);
+
+	if (err) {
+		err = 0;
+		ecryptfs_printk(1, KERN_WARNING, "Error reading header region;"
+				" assuming unencrypted\n");
+	} else {
+		if (!contains_ecryptfs_marker(page_virt
+					      + ECRYPTFS_FILE_SIZE_BYTES)) {
+			ecryptfs_printk(0, KERN_WARNING, "Underlying file "
+					"lacks recognizable eCryptfs marker\n");
+		}
+		memcpy(&file_size, page_virt, sizeof(file_size));
+		dentry->d_inode->i_size = file_size;
+	}
+	kmem_cache_free(ecryptfs_header_cache_2, page_virt);
+	goto out;
+
+out_dput:
+	dput(lower_dentry);
+	if (tlower_dentry)
+		dput(tlower_dentry);
+out_drop:
+	d_drop(dentry);
+out:
+	ecryptfs_printk(1, KERN_NOTICE, "Exit; err = [%d]\n", err);
+	return ERR_PTR(err);
+}
+
+static int ecryptfs_link(struct dentry *old_dentry, struct inode *dir,
+			 struct dentry *new_dentry)
+{
+	int err;
+	struct dentry *lower_old_dentry;
+	struct dentry *lower_new_dentry;
+	struct dentry *lower_dir_dentry;
+
+	ecryptfs_printk(1, KERN_NOTICE, "Enter\n");
+	lower_old_dentry = ecryptfs_lower_dentry(old_dentry);
+	lower_new_dentry = ecryptfs_lower_dentry(new_dentry);
+	dget(lower_old_dentry);
+	dget(lower_new_dentry);
+	lower_dir_dentry = lock_parent(lower_new_dentry);
+	err = vfs_link(lower_old_dentry, lower_dir_dentry->d_inode,
+		       lower_new_dentry);
+	if (err || !lower_new_dentry->d_inode)
+		goto out_lock;
+	err = ecryptfs_interpose(lower_new_dentry, new_dentry, dir->i_sb, 0);
+	if (err)
+		goto out_lock;
+	ecryptfs_copy_attr_timesizes(dir, lower_new_dentry->d_inode);
+	old_dentry->d_inode->i_nlink =
+	    ECRYPTFS_INODE_TO_LOWER(old_dentry->d_inode)->i_nlink;
+out_lock:
+	unlock_dir(lower_dir_dentry);
+	dput(lower_new_dentry);
+	dput(lower_old_dentry);
+	if (!new_dentry->d_inode)
+		d_drop(new_dentry);
+	ecryptfs_printk(1, KERN_NOTICE, "Exit; err = [%d]\n", err);
+	return err;
+}
+
+static int ecryptfs_unlink(struct inode *dir, struct dentry *dentry)
+{
+	int rc = 0;
+	struct dentry *lower_dentry = ECRYPTFS_DENTRY_TO_LOWER(dentry);
+	struct inode *lower_dir_inode = ECRYPTFS_INODE_TO_LOWER(dir);
+	ecryptfs_printk(1, KERN_NOTICE, "Enter; dentry->d_name = [%s]\n",
+			dentry->d_name.name);
+	lock_parent(lower_dentry);
+	rc = vfs_unlink(lower_dir_inode, lower_dentry);
+	if (rc) {
+		ecryptfs_printk(1, KERN_ERR, "Error in vfs_unlink\n");
+		goto out_unlock;
+	}
+	ecryptfs_copy_attr_times(dir, lower_dir_inode);
+	dentry->d_inode->i_nlink = 
+		ECRYPTFS_INODE_TO_LOWER(dentry->d_inode)->i_nlink;
+        dentry->d_inode->i_ctime = dir->i_ctime;	
+out_unlock:	
+	unlock_parent(lower_dentry);
+	ecryptfs_printk(1, KERN_NOTICE, "Exit; rc = [%d]",rc);
+	return rc;
+}
+
+static int ecryptfs_symlink(struct inode *dir, struct dentry *dentry,
+			    const char *symname)
+{
+	int err;
+	struct dentry *lower_dentry;
+	struct dentry *lower_dir_dentry;
+	umode_t mode;
+	char *encoded_symname;
+	unsigned int encoded_symlen;
+	struct ecryptfs_crypt_stats *crypt_stats = NULL;
+
+	ecryptfs_printk(1, KERN_NOTICE, "Enter\n");
+	lower_dentry = ecryptfs_lower_dentry(dentry);
+	dget(lower_dentry);
+	lower_dir_dentry = lock_parent(lower_dentry);
+	mode = S_IALLUGO;
+	encoded_symlen = ecryptfs_encode_filename(symname, strlen(symname),
+						  &encoded_symname,
+						  ECRYPTFS_DO_DOTS,
+						  crypt_stats);
+	if (encoded_symlen < 0) {
+		err = encoded_symlen;
+		goto out_lock;
+	}
+	err = vfs_symlink(lower_dir_dentry->d_inode, lower_dentry,
+			  encoded_symname, mode);
+	kfree(encoded_symname);
+	if (err || !lower_dentry->d_inode)
+		goto out_lock;
+	err = ecryptfs_interpose(lower_dentry, dentry, dir->i_sb, 0);
+	if (err)
+		goto out_lock;
+	ecryptfs_copy_attr_timesizes(dir, lower_dir_dentry->d_inode);
+out_lock:
+	unlock_dir(lower_dir_dentry);
+	dput(lower_dentry);
+	if (!dentry->d_inode)
+		d_drop(dentry);
+	return err;
+}
+
+static int ecryptfs_mkdir(struct inode *dir, struct dentry *dentry, int mode)
+{
+	int err;
+	struct dentry *lower_dentry;
+	struct dentry *lower_dir_dentry;
+
+	ecryptfs_printk(1, KERN_NOTICE, "Enter\n");
+	lower_dentry = ecryptfs_lower_dentry(dentry);
+	lower_dir_dentry = lock_parent(lower_dentry);
+	err = vfs_mkdir(lower_dir_dentry->d_inode, lower_dentry, mode);
+	if (err || !lower_dentry->d_inode)
+		goto out;
+	err = ecryptfs_interpose(lower_dentry, dentry, dir->i_sb, 0);
+	if (err)
+		goto out;
+	ecryptfs_copy_attr_timesizes(dir, lower_dir_dentry->d_inode);
+	dir->i_nlink = lower_dir_dentry->d_inode->i_nlink;
+out:
+	unlock_dir(lower_dir_dentry);
+	if (!dentry->d_inode)
+		d_drop(dentry);
+	ecryptfs_printk(1, KERN_NOTICE, "Exit; err = [%d]\n", err);
+	return err;
+}
+
+static int ecryptfs_rmdir(struct inode *dir, struct dentry *dentry)
+{
+	int err = 0;
+	struct dentry *tdentry = NULL;
+	struct dentry *lower_dentry;
+	struct dentry *tlower_dentry = NULL;
+	struct dentry *lower_dir_dentry;
+	struct dentry *tlower_dir_dentry = NULL;
+
+	ecryptfs_printk(1, KERN_NOTICE, "Enter\n");
+	lower_dentry = ecryptfs_lower_dentry(dentry);
+	if (!(tdentry = dget(dentry))) {
+		err = -EINVAL;
+		ecryptfs_printk(0, KERN_ERR, "Error dget'ing dentry [%p]\n",
+				dentry);
+		goto out;
+	}
+	lower_dir_dentry = lock_parent(lower_dentry);
+	if (!(tlower_dentry = dget(lower_dentry))) {
+		err = -EINVAL;
+		ecryptfs_printk(0, KERN_ERR, "Error dget'ing lower_dentry "
+				"[%p]\n", lower_dentry);
+		goto out;
+	}
+	err = vfs_rmdir(lower_dir_dentry->d_inode, lower_dentry);
+	if (!err) {
+		d_delete(tlower_dentry);
+		tlower_dentry = NULL;
+	}
+	ecryptfs_copy_attr_times(dir, lower_dir_dentry->d_inode);
+	dir->i_nlink = lower_dir_dentry->d_inode->i_nlink;
+	unlock_dir(lower_dir_dentry);
+	if (!err)
+		d_drop(dentry);
+out:
+	if (tdentry)
+		dput(tdentry);
+	if (tlower_dentry)
+		dput(tlower_dentry);
+	if (tlower_dir_dentry)
+		dput(tlower_dir_dentry);
+	ecryptfs_printk(1, KERN_NOTICE, "Exit; err = [%d]\n", err);
+	return err;
+}
+
+static int
+ecryptfs_mknod(struct inode *dir, struct dentry *dentry, int mode, dev_t dev)
+{
+	int err;
+	struct dentry *lower_dentry;
+	struct dentry *lower_dir_dentry;
+
+	ecryptfs_printk(1, KERN_NOTICE, "Enter\n");
+	lower_dentry = ecryptfs_lower_dentry(dentry);
+	lower_dir_dentry = lock_parent(lower_dentry);
+	err = vfs_mknod(lower_dir_dentry->d_inode, lower_dentry, mode, dev);
+	if (err || !lower_dentry->d_inode)
+		goto out;
+	err = ecryptfs_interpose(lower_dentry, dentry, dir->i_sb, 0);
+	if (err)
+		goto out;
+	ecryptfs_copy_attr_timesizes(dir, lower_dir_dentry->d_inode);
+out:
+	unlock_dir(lower_dir_dentry);
+	if (!dentry->d_inode)
+		d_drop(dentry);
+	return err;
+}
+
+static int
+ecryptfs_rename(struct inode *old_dir, struct dentry *old_dentry,
+		struct inode *new_dir, struct dentry *new_dentry)
+{
+	int err;
+	struct dentry *lower_old_dentry;
+	struct dentry *lower_new_dentry;
+	struct dentry *lower_old_dir_dentry;
+	struct dentry *lower_new_dir_dentry;
+
+	ecryptfs_printk(1, KERN_NOTICE, "Enter\n");
+	lower_old_dentry = ecryptfs_lower_dentry(old_dentry);
+	lower_new_dentry = ecryptfs_lower_dentry(new_dentry);
+	dget(lower_old_dentry);
+	dget(lower_new_dentry);
+	lower_old_dir_dentry = dget_parent(lower_old_dentry);
+	lower_new_dir_dentry = dget_parent(lower_new_dentry);
+	lock_rename(lower_old_dir_dentry, lower_new_dir_dentry);
+	err = vfs_rename(lower_old_dir_dentry->d_inode, lower_old_dentry,
+			 lower_new_dir_dentry->d_inode, lower_new_dentry);
+	if (err)
+		goto out_lock;
+	ecryptfs_copy_attr_all(new_dir, lower_new_dir_dentry->d_inode);
+	if (new_dir != old_dir)
+		ecryptfs_copy_attr_all(old_dir, lower_old_dir_dentry->d_inode);
+out_lock:
+	unlock_rename(lower_old_dir_dentry, lower_new_dir_dentry);
+	dput(lower_new_dentry);
+	dput(lower_old_dentry);
+	return err;
+}
+
+static int
+ecryptfs_readlink(struct dentry *dentry, char __user * buf, int bufsiz)
+{
+	int err;
+	struct dentry *lower_dentry;
+	char *decoded_name;
+	char *lower_buf;
+	mm_segment_t old_fs;
+	struct ecryptfs_crypt_stats *crypt_stats;
+
+	ecryptfs_printk(1, KERN_NOTICE, "Enter\n");
+	lower_dentry = ecryptfs_lower_dentry(dentry);
+	if (!lower_dentry->d_inode->i_op ||
+	    !lower_dentry->d_inode->i_op->readlink) {
+		err = -EINVAL;
+		goto out;
+	}
+	/* Released in this function */
+	lower_buf = kmalloc(bufsiz, GFP_KERNEL);
+	if (lower_buf == NULL) {
+		ecryptfs_printk(0, KERN_ERR, "Out of memory\n");
+		err = -ENOMEM;
+		goto out;
+	}
+	old_fs = get_fs();
+	set_fs(get_ds());
+	ecryptfs_printk(1, KERN_NOTICE, "Calling readlink w/ "
+			"lower_dentry->d_name.name = [%s]\n",
+			lower_dentry->d_name.name);
+	err = lower_dentry->d_inode->i_op->readlink(lower_dentry, 
+						    (char __user *)lower_buf,
+						    bufsiz);
+	set_fs(old_fs);
+	if (err >= 0) {
+		crypt_stats = NULL;
+		err = ecryptfs_decode_filename(lower_buf, err,
+					       &decoded_name,
+					       ECRYPTFS_DO_DOTS, crypt_stats);
+		if (err == -ENOMEM)
+			goto out_free_lower_buf;
+		if (err > 0) {
+			ecryptfs_printk(1, KERN_NOTICE, "Copying [%d] bytes "
+					"to userspace: [%*s]\n", err, err,
+					decoded_name);
+			if (copy_to_user(buf, decoded_name, err))
+				err = -EFAULT;
+		}
+		kfree(decoded_name);
+		ecryptfs_copy_attr_atime(dentry->d_inode,
+					 lower_dentry->d_inode);
+	}
+out_free_lower_buf:
+	kfree(lower_buf);
+out:
+	ecryptfs_printk(1, KERN_NOTICE, "Exit; err = [%d]\n", err);
+	return err;
+}
+
+static void *ecryptfs_follow_link(struct dentry *dentry, struct nameidata *nd)
+{
+	char *buf;
+	int len = PAGE_SIZE, rc;
+	mm_segment_t old_fs;
+
+	ecryptfs_printk(1, KERN_NOTICE, "Enter; dentry->d_name.name = [%s]\n",
+			dentry->d_name.name);
+	/* Released in ecryptfs_put_link(); only release here on error */
+	buf = kmalloc(len, GFP_KERNEL);
+	if (!buf) {
+		rc = -ENOMEM;
+		goto out;
+	}
+	old_fs = get_fs();
+	set_fs(get_ds());
+	ecryptfs_printk(1, KERN_NOTICE, "Calling readlink w/ "
+			"dentry->d_name.name = [%s]\n", dentry->d_name.name);
+	rc = dentry->d_inode->i_op->readlink(dentry, (char __user *)buf, len);
+	buf[rc] = '\0';
+	set_fs(old_fs);
+	if (rc < 0)
+		goto out_free;
+	rc = 0;
+	nd_set_link(nd, buf);
+	goto out;
+out_free:
+	kfree(buf);
+out:
+	return ERR_PTR(rc);
+}
+
+static inline void
+ecryptfs_put_link(struct dentry *dentry, struct nameidata *nd, void *ptr)
+{
+	/* Free the char* */
+	kfree(nd_get_link(nd));
+}
+
+/**
+ * Calculate the requried size of the lower file based on the specified size
+ * of the upper file. This calculation is based on the number of headers in
+ * the underlying file, the number of records (IV/HMAC/IV+HMAC) per page
+ * that can be stored, and the extent size of the underlying file (page size).
+ *
+ * @param crypt_stats crypt_stats associated with file
+ * @param upper_size size of the upper file
+ * @return calculated size of the lower file.
+ */
+static loff_t
+upper_size_to_lower_size(struct ecryptfs_crypt_stats *crypt_stats,
+			 loff_t upper_size)
+{
+	int upper_idx = 0;
+	int lower_idx;
+	loff_t lower_size = upper_size;
+
+	ecryptfs_printk(1, KERN_NOTICE, "Enter; upper_size = [%lld]\n",
+			upper_size);
+	/* TODO: Does this need to be based on the extent size? */
+	if (likely(upper_size > 0))
+		upper_idx = (upper_size - 1) >> PAGE_CACHE_SHIFT;
+	else if (!upper_size)
+		upper_idx = 0;
+	else /* Sanity check, size shouldn't be negative */
+		BUG();
+	lower_idx = ecryptfs_pg_idx_to_lwr_pg_idx(crypt_stats, upper_idx);
+	lower_size = ((lower_idx + 1) << PAGE_CACHE_SHIFT);
+	ecryptfs_printk(1, KERN_NOTICE, "Exit; lower_size = [%lld]\n",
+			lower_size);
+	return lower_size;
+}
+
+/**
+ * Function to handle truncations modifying the size of the file. Note
+ * that the file sizes are interpolated. When expanding, we are simply
+ * writing strings of 0's out. When truncating, we need to modify the
+ * underlying file size accordingly to the page index interpolations.
+ *
+ * N.B. No claims are made about integrety of the encrypted data when
+ * 	shrinking a file. (But its probably going to be lost)
+ *
+ * TODO: Support holes. Should we also be supporting preservation of
+ * 	 the encrypted data?
+ *
+ * @param dentry	The ecryptfs layer dentry
+ * @param new_length	The length to expand the file to
+ * @return		Zero on success; non-zero otherwise
+ */
+int ecryptfs_truncate(struct dentry *dentry, loff_t new_length)
+{
+	int rc = 0;
+	struct inode *inode = dentry->d_inode;
+	struct dentry *lower_dentry;
+	struct file fake_ecryptfs_file, *lower_file = NULL;
+	struct ecryptfs_crypt_stats *crypt_stats;
+	loff_t i_size = i_size_read(inode);
+	loff_t lower_size_before_truncate;
+	loff_t lower_size_after_truncate;
+
+	ecryptfs_printk(1, KERN_NOTICE, "Enter; dentry = [%p], new_length = "
+			"[%lld], i_size_read(inode) = [%lld]\n",
+			dentry, new_length, i_size);
+	/* Sanity checks */
+	if (unlikely((new_length == i_size)))
+		goto out;
+	crypt_stats = &ECRYPTFS_INODE_TO_PRIVATE(dentry->d_inode)->crypt_stats;
+	if (unlikely(!crypt_stats)) {
+		ecryptfs_printk(0, KERN_ERR, "NULL crypt_stats on dentry with "
+				"d_name.name = [%s]\n", dentry->d_name.name);
+		rc = -EINVAL;
+		goto out;
+	}
+
+	/* Set up a fake ecryptfs file, this is used to interface with the file
+	 * in the underlying filesystem so that the truncation has an effect
+	 * there as well. */
+	memset(&fake_ecryptfs_file, 0, sizeof(struct file));
+	fake_ecryptfs_file.f_dentry = dentry;
+	/* Released at out_free: */
+	ECRYPTFS_FILE_TO_PRIVATE_SM(&fake_ecryptfs_file) =
+		kmem_cache_alloc(ecryptfs_file_info_cache, SLAB_KERNEL);
+	if (unlikely(!ECRYPTFS_FILE_TO_PRIVATE(&fake_ecryptfs_file))) {
+		rc = -ENOMEM;
+		goto out;
+	}
+	lower_dentry = ecryptfs_lower_dentry(dentry);
+	/* This dget & mntget is released through fput at out_fput: */
+	dget(lower_dentry);
+	mntget(ECRYPTFS_SUPERBLOCK_TO_PRIVATE(inode->i_sb)->lower_mnt);
+	lower_file = dentry_open(
+		lower_dentry,
+		ECRYPTFS_SUPERBLOCK_TO_PRIVATE(inode->i_sb)->lower_mnt, O_RDWR);
+	if (unlikely(IS_ERR(lower_file))) {
+		rc = PTR_ERR(lower_file);
+		goto out_free;
+	}
+	ECRYPTFS_FILE_TO_LOWER(&fake_ecryptfs_file) = lower_file;
+
+	/* Switch on growing or shrinking file */
+	if (new_length > i_size) {
+		rc = ecryptfs_fill_zeros(&fake_ecryptfs_file, new_length);
+		if (rc) {
+			ecryptfs_printk(0, KERN_ERR,
+					"Problem with fill_zeros\n");
+			goto out_fput;
+		}
+		i_size_write(inode, new_length);
+		rc = ecryptfs_write_inode_size_to_header(lower_file,
+							 lower_dentry->d_inode,
+							 inode);
+		if (rc) {
+			ecryptfs_printk(0, KERN_ERR,
+					"Problem with ecryptfs_write"
+					"_inode_size\n");
+			goto out_fput;
+		}
+	} else {		/* new_length < i_size_read(inode) */
+		vmtruncate(inode, new_length);
+		ecryptfs_write_inode_size_to_header(lower_file,
+						    lower_dentry->d_inode,
+						    inode);
+		/* We are reducing the size of the ecryptfs file, and need to
+		 * know if we need to reduce the size of the lower file. */
+		lower_size_before_truncate =
+		    upper_size_to_lower_size(crypt_stats, i_size);
+		lower_size_after_truncate =
+		    upper_size_to_lower_size(crypt_stats, new_length);
+		if (lower_size_after_truncate < lower_size_before_truncate)
+			vmtruncate(lower_dentry->d_inode,
+				   lower_size_after_truncate);
+	}
+	/* Update the access times */
+	lower_dentry->d_inode->i_mtime = CURRENT_TIME;
+	lower_dentry->d_inode->i_ctime = CURRENT_TIME;
+	mark_inode_dirty_sync(inode);
+out_fput:
+	/* TODO: Determine which of these need to really be called.
+	 * filp_close() will call fput(), but do we need to do the extra work
+	 * that filp_close() provides?
+	 if (lower_file)
+	 filp_close(lower_file, NULL);
+	 */
+	fput(lower_file);
+out_free:
+	if (ECRYPTFS_FILE_TO_PRIVATE(&fake_ecryptfs_file))
+		kmem_cache_free(ecryptfs_file_info_cache,
+				ECRYPTFS_FILE_TO_PRIVATE(&fake_ecryptfs_file));
+out:
+	ecryptfs_printk(1, KERN_NOTICE, "Exit; rc = [%d]\n", rc);
+	return rc;
+}
+
+static int
+ecryptfs_permission(struct inode *inode, int mask, struct nameidata *nd)
+{
+	struct inode *lower_inode;
+	int rc = 0;
+
+	ecryptfs_printk(1, KERN_NOTICE, "Enter; inode = [%p], mask=[%d], nd ="
+			"[%p]\n", inode, mask, nd);
+	lower_inode = ECRYPTFS_INODE_TO_LOWER(inode);
+	if (nd)
+		ecryptfs_printk(1, KERN_NOTICE, "nd->dentry = [%p]\n",
+				nd->dentry);
+	rc = permission(lower_inode, mask, nd);
+	ecryptfs_printk(1, KERN_NOTICE, "Exit; rc = [%d]\n", rc);
+	return rc;
+}
+
+/**
+ * Updates the metadata of an inode. If the update is to the size
+ * i.e. truncation, then ecryptfs_truncate will handle the size modification
+ * of both the ecryptfs inode and the lower inode.
+ * 
+ * All other metadata changes will be passed right to the lower filesystem,
+ * and we will just update our inode to look like the lower.
+ *
+ * @param dentry	dentry handle to the inode to modify
+ * @param ia		structure with flags of what to change and values
+ */
+static int ecryptfs_setattr(struct dentry *dentry, struct iattr *ia)
+{
+	int err = 0;
+	struct dentry *lower_dentry;
+	struct inode *inode;
+	struct inode *lower_inode;
+	struct ecryptfs_crypt_stats *crypt_stats;
+	ecryptfs_printk(1, KERN_NOTICE, "Enter; dentry->d_name.name = [%s]\n",
+			dentry->d_name.name);
+	crypt_stats = &ECRYPTFS_INODE_TO_PRIVATE(dentry->d_inode)->crypt_stats;
+	lower_dentry = ecryptfs_lower_dentry(dentry);
+	inode = dentry->d_inode;
+	lower_inode = ECRYPTFS_INODE_TO_LOWER(inode);
+	if (ia->ia_valid & ATTR_SIZE) {
+		ecryptfs_printk(1, KERN_NOTICE,
+				"ia->ia_valid = [0x%x] ATTR_SIZE" " = [0x%x]\n",
+				ia->ia_valid, ATTR_SIZE);
+		err = ecryptfs_truncate(dentry, ia->ia_size);
+		/* ecryptfs_truncate handles resizing of the lower file */
+		ia->ia_valid &= ~ATTR_SIZE;
+		ecryptfs_printk(1, KERN_NOTICE, "ia->ia_valid = [%x]\n",
+				ia->ia_valid);
+		if (err < 0)
+			goto out;
+	}
+	err = notify_change(lower_dentry, ia);
+out:
+	ecryptfs_copy_attr_all(inode, lower_inode);
+	ecryptfs_printk(1, KERN_NOTICE, "Exit; err = [%d]\n");
+	return err;
+}
+
+struct inode_operations ecryptfs_symlink_iops = {
+	.readlink = ecryptfs_readlink,
+	.follow_link = ecryptfs_follow_link,
+	.put_link = ecryptfs_put_link,
+	.permission = ecryptfs_permission,
+	.setattr = ecryptfs_setattr,
+};
+
+struct inode_operations ecryptfs_dir_iops = {
+	.create = ecryptfs_create,
+	.lookup = ecryptfs_lookup,
+	.link = ecryptfs_link,
+	.unlink = ecryptfs_unlink,
+	.symlink = ecryptfs_symlink,
+	.mkdir = ecryptfs_mkdir,
+	.rmdir = ecryptfs_rmdir,
+	.mknod = ecryptfs_mknod,
+	.rename = ecryptfs_rename,
+	.permission = ecryptfs_permission,
+	.setattr = ecryptfs_setattr,
+};
+
+struct inode_operations ecryptfs_main_iops = {
+	.permission = ecryptfs_permission,
+	.setattr = ecryptfs_setattr,
+};
