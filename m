Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265433AbUAAV6j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 16:58:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265451AbUAAV6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 16:58:39 -0500
Received: from thunk.org ([140.239.227.29]:4003 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S265433AbUAAVwo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 16:52:44 -0500
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: [PATCH] [2.4.24-pre3] 5/5  EXT2/3 Updates
From: "Theodore Ts'o" <tytso@mit.edu>
Phone: (781) 391-3464
Message-Id: <E1AcAjX-0000Lw-RX@thunk.org>
Date: Thu, 01 Jan 2004 16:51:59 -0500
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1360  -> 1.1361 
#	include/linux/ext3_fs_i.h	1.1     -> 1.2    
#	include/linux/ext3_fs.h	1.8     -> 1.9    
#	include/linux/ext3_jbd.h	1.3     -> 1.4    
#	    fs/ext3/Makefile	1.2     -> 1.3    
#	include/linux/rbtree.h	1.1     -> 1.2    
#	include/linux/ext2_fs_i.h	1.5     -> 1.6    
#	       fs/ext3/dir.c	1.1     -> 1.2    
#	     fs/ext3/namei.c	1.4     -> 1.5    
#	        lib/rbtree.c	1.2     -> 1.3    
#	     fs/ext3/inode.c	1.18    -> 1.19   
#	     fs/ext3/super.c	1.13    -> 1.14   
#	include/linux/ext3_fs_sb.h	1.2     -> 1.3    
#	      fs/ext3/file.c	1.4     -> 1.5    
#	               (new)	        -> 1.1     fs/ext3/hash.c 
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/01/01	tytso@think.thunk.org	1.1361
# Apply all ext2/ext3 htree indexed directory patches, including
# bugfixes from the Linux 2.6.0 tree.   These patches are quite 
# well tested and have been proven very reliable.  
# 
# Includes ext2/3 patches: 4100. 4101. 4102, 4103, 4108, 4109, 4112, 
# 4201, 4204, 4205
# --------------------------------------------
#
diff -Nru a/fs/ext3/Makefile b/fs/ext3/Makefile
--- a/fs/ext3/Makefile	Thu Jan  1 16:29:25 2004
+++ b/fs/ext3/Makefile	Thu Jan  1 16:29:25 2004
@@ -10,7 +10,7 @@
 O_TARGET := ext3.o
 
 obj-y    := balloc.o bitmap.o dir.o file.o fsync.o ialloc.o inode.o \
-		ioctl.o namei.o super.o symlink.o
+		ioctl.o namei.o super.o symlink.o hash.o
 obj-m    := $(O_TARGET)
 
 include $(TOPDIR)/Rules.make
diff -Nru a/fs/ext3/dir.c b/fs/ext3/dir.c
--- a/fs/ext3/dir.c	Thu Jan  1 16:29:25 2004
+++ b/fs/ext3/dir.c	Thu Jan  1 16:29:25 2004
@@ -21,20 +21,40 @@
 #include <linux/fs.h>
 #include <linux/jbd.h>
 #include <linux/ext3_fs.h>
+#include <linux/slab.h>
+#include <linux/rbtree.h>
 
 static unsigned char ext3_filetype_table[] = {
 	DT_UNKNOWN, DT_REG, DT_DIR, DT_CHR, DT_BLK, DT_FIFO, DT_SOCK, DT_LNK
 };
 
 static int ext3_readdir(struct file *, void *, filldir_t);
+static int ext3_dx_readdir(struct file * filp,
+			   void * dirent, filldir_t filldir);
+static int ext3_release_dir (struct inode * inode,
+				struct file * filp);
 
 struct file_operations ext3_dir_operations = {
 	read:		generic_read_dir,
 	readdir:	ext3_readdir,		/* BKL held */
 	ioctl:		ext3_ioctl,		/* BKL held */
 	fsync:		ext3_sync_file,		/* BKL held */
+#ifdef CONFIG_EXT3_INDEX
+	release:	ext3_release_dir
+#endif
 };
 
+
+static unsigned char get_dtype(struct super_block *sb, int filetype)
+{
+	if (!EXT3_HAS_INCOMPAT_FEATURE(sb, EXT3_FEATURE_INCOMPAT_FILETYPE) ||
+	    (filetype >= EXT3_FT_MAX))
+		return DT_UNKNOWN;
+
+	return (ext3_filetype_table[filetype]);
+}
+			       
+
 int ext3_check_dir_entry (const char * function, struct inode * dir,
 			  struct ext3_dir_entry_2 * de,
 			  struct buffer_head * bh,
@@ -79,6 +99,21 @@
 
 	sb = inode->i_sb;
 
+#ifdef CONFIG_EXT3_INDEX
+	if (EXT3_HAS_COMPAT_FEATURE(inode->i_sb,
+				    EXT3_FEATURE_COMPAT_DIR_INDEX) &&
+	    ((EXT3_I(inode)->i_flags & EXT3_INDEX_FL) ||
+	     ((inode->i_size >> sb->s_blocksize_bits) == 1))) {
+		err = ext3_dx_readdir(filp, dirent, filldir);
+		if (err != ERR_BAD_DX_DIR)
+			return err;
+		/*
+		 * We don't set the inode dirty flag since it's not
+		 * critical that it get flushed back to the disk.
+		 */
+		EXT3_I(filp->f_dentry->d_inode)->i_flags &= ~EXT3_INDEX_FL;
+	}
+#endif
 	stored = 0;
 	bh = NULL;
 	offset = filp->f_pos & (sb->s_blocksize - 1);
@@ -162,18 +197,12 @@
 				 * during the copy operation.
 				 */
 				unsigned long version = filp->f_version;
-				unsigned char d_type = DT_UNKNOWN;
 
-				if (EXT3_HAS_INCOMPAT_FEATURE(sb,
-						EXT3_FEATURE_INCOMPAT_FILETYPE)
-						&& de->file_type < EXT3_FT_MAX)
-					d_type =
-					  ext3_filetype_table[de->file_type];
 				error = filldir(dirent, de->name,
 						de->name_len,
 						filp->f_pos,
 						le32_to_cpu(de->inode),
-						d_type);
+						get_dtype(sb, de->file_type));
 				if (error)
 					break;
 				if (version != filp->f_version)
@@ -188,3 +217,294 @@
 	UPDATE_ATIME(inode);
 	return 0;
 }
+
+#ifdef CONFIG_EXT3_INDEX
+/*
+ * These functions convert from the major/minor hash to an f_pos
+ * value.
+ * 
+ * Currently we only use major hash numer.  This is unfortunate, but
+ * on 32-bit machines, the same VFS interface is used for lseek and
+ * llseek, so if we use the 64 bit offset, then the 32-bit versions of
+ * lseek/telldir/seekdir will blow out spectacularly, and from within
+ * the ext2 low-level routine, we don't know if we're being called by
+ * a 64-bit version of the system call or the 32-bit version of the
+ * system call.  Worse yet, NFSv2 only allows for a 32-bit readdir
+ * cookie.  Sigh.
+ */
+#define hash2pos(major, minor)	(major >> 1)
+#define pos2maj_hash(pos)	((pos << 1) & 0xffffffff)
+#define pos2min_hash(pos)	(0)
+
+/*
+ * This structure holds the nodes of the red-black tree used to store
+ * the directory entry in hash order.
+ */
+struct fname {
+	__u32		hash;
+	__u32		minor_hash;
+	rb_node_t	rb_hash; 
+	struct fname	*next;
+	__u32		inode;
+	__u8		name_len;
+	__u8		file_type;
+	char		name[0];
+};
+
+/*
+ * This functoin implements a non-recursive way of freeing all of the
+ * nodes in the red-black tree.
+ */
+static void free_rb_tree_fname(rb_root_t *root)
+{
+	rb_node_t	*n = root->rb_node;
+	rb_node_t	*parent;
+	struct fname	*fname;
+
+	while (n) {
+		/* Do the node's children first */
+		if ((n)->rb_left) {
+			n = n->rb_left;
+			continue;
+		}
+		if (n->rb_right) {
+			n = n->rb_right;
+			continue;
+		}
+		/*
+		 * The node has no children; free it, and then zero
+		 * out parent's link to it.  Finally go to the
+		 * beginning of the loop and try to free the parent
+		 * node.
+		 */
+		parent = n->rb_parent;
+		fname = rb_entry(n, struct fname, rb_hash);
+		while (fname) {
+			struct fname * old = fname;
+			fname = fname->next;
+			kfree (old);
+		}
+		if (!parent)
+			root->rb_node = 0;
+		else if (parent->rb_left == n)
+			parent->rb_left = 0;
+		else if (parent->rb_right == n)
+			parent->rb_right = 0;
+		n = parent;
+	}
+	root->rb_node = 0;
+}
+
+
+struct dir_private_info *create_dir_info(loff_t pos)
+{
+	struct dir_private_info *p;
+
+	p = kmalloc(sizeof(struct dir_private_info), GFP_KERNEL);
+	if (!p)
+		return NULL;
+	p->root.rb_node = 0;
+	p->curr_node = 0;
+	p->extra_fname = 0;
+	p->last_pos = 0;
+	p->curr_hash = pos2maj_hash(pos);
+	p->curr_minor_hash = pos2min_hash(pos);
+	p->next_hash = 0;
+	return p;
+}
+
+void ext3_htree_free_dir_info(struct dir_private_info *p)
+{
+	free_rb_tree_fname(&p->root);
+	kfree(p);
+}
+		
+/*
+ * Given a directory entry, enter it into the fname rb tree.
+ */
+int ext3_htree_store_dirent(struct file *dir_file, __u32 hash,
+			     __u32 minor_hash,
+			     struct ext3_dir_entry_2 *dirent)
+{
+	rb_node_t **p, *parent = NULL;
+	struct fname * fname, *new_fn;
+	struct dir_private_info *info;
+	int len;
+
+	info = (struct dir_private_info *) dir_file->private_data;
+	p = &info->root.rb_node;
+
+	/* Create and allocate the fname structure */
+	len = sizeof(struct fname) + dirent->name_len + 1;
+	new_fn = kmalloc(len, GFP_KERNEL);
+	if (!new_fn)
+		return -ENOMEM;
+	memset(new_fn, 0, len);
+	new_fn->hash = hash;
+	new_fn->minor_hash = minor_hash;
+	new_fn->inode = le32_to_cpu(dirent->inode);
+	new_fn->name_len = dirent->name_len;
+	new_fn->file_type = dirent->file_type;
+	memcpy(new_fn->name, dirent->name, dirent->name_len);
+	new_fn->name[dirent->name_len] = 0;
+	
+	while (*p) {
+		parent = *p;
+		fname = rb_entry(parent, struct fname, rb_hash);
+
+		/*
+		 * If the hash and minor hash match up, then we put
+		 * them on a linked list.  This rarely happens...
+		 */
+		if ((new_fn->hash == fname->hash) &&
+		    (new_fn->minor_hash == fname->minor_hash)) {
+			new_fn->next = fname->next;
+			fname->next = new_fn;
+			return 0;
+		}
+			
+		if (new_fn->hash < fname->hash)
+			p = &(*p)->rb_left;
+		else if (new_fn->hash > fname->hash)
+			p = &(*p)->rb_right;
+		else if (new_fn->minor_hash < fname->minor_hash)
+			p = &(*p)->rb_left;
+		else /* if (new_fn->minor_hash > fname->minor_hash) */
+			p = &(*p)->rb_right;
+	}
+
+	rb_link_node(&new_fn->rb_hash, parent, p);
+	rb_insert_color(&new_fn->rb_hash, &info->root);
+	return 0;
+}
+
+
+
+/*
+ * This is a helper function for ext3_dx_readdir.  It calls filldir
+ * for all entres on the fname linked list.  (Normally there is only
+ * one entry on the linked list, unless there are 62 bit hash collisions.)
+ */
+static int call_filldir(struct file * filp, void * dirent,
+			filldir_t filldir, struct fname *fname)
+{
+	struct dir_private_info *info = filp->private_data;
+	loff_t	curr_pos;
+	struct inode *inode = filp->f_dentry->d_inode;
+	struct super_block * sb;
+	int error;
+
+	sb = inode->i_sb;
+	
+	if (!fname) {
+		printk("call_filldir: called with null fname?!?\n");
+		return 0;
+	}
+	curr_pos = hash2pos(fname->hash, fname->minor_hash);
+	while (fname) {
+		error = filldir(dirent, fname->name,
+				fname->name_len, curr_pos, 
+				fname->inode,
+				get_dtype(sb, fname->file_type));
+		if (error) {
+			filp->f_pos = curr_pos;
+			info->extra_fname = fname->next;
+			return error;
+		}
+		fname = fname->next;
+	}
+	return 0;
+}
+
+static int ext3_dx_readdir(struct file * filp,
+			 void * dirent, filldir_t filldir)
+{
+	struct dir_private_info *info = filp->private_data;
+	struct inode *inode = filp->f_dentry->d_inode;
+	struct fname *fname;
+	int	ret;
+
+	if (!info) {
+		info = create_dir_info(filp->f_pos);
+		if (!info)
+			return -ENOMEM;
+		filp->private_data = info;
+	}
+
+	if (filp->f_pos == EXT3_HTREE_EOF)
+		return 0;	/* EOF */
+
+	/* Some one has messed with f_pos; reset the world */
+	if (info->last_pos != filp->f_pos) {
+		free_rb_tree_fname(&info->root);
+		info->curr_node = 0;
+		info->extra_fname = 0;
+		info->curr_hash = pos2maj_hash(filp->f_pos);
+		info->curr_minor_hash = pos2min_hash(filp->f_pos);
+	}
+
+	/*
+	 * If there are any leftover names on the hash collision
+	 * chain, return them first.
+	 */
+	if (info->extra_fname &&
+	    call_filldir(filp, dirent, filldir, info->extra_fname))
+		goto finished;
+
+	if (!info->curr_node)
+		info->curr_node = rb_get_first(&info->root);
+
+	while (1) {
+		/*
+		 * Fill the rbtree if we have no more entries,
+		 * or the inode has changed since we last read in the
+		 * cached entries. 
+		 */
+		if ((!info->curr_node) ||
+		    (filp->f_version != inode->i_version)) {
+			info->curr_node = 0;
+			free_rb_tree_fname(&info->root);
+			filp->f_version = inode->i_version;
+			ret = ext3_htree_fill_tree(filp, info->curr_hash,
+						   info->curr_minor_hash,
+						   &info->next_hash);
+			if (ret < 0)
+				return ret;
+			if (ret == 0) {
+				filp->f_pos = EXT3_HTREE_EOF;
+				break;
+			}
+			info->curr_node = rb_get_first(&info->root);
+		}
+
+		fname = rb_entry(info->curr_node, struct fname, rb_hash);
+		info->curr_hash = fname->hash;
+		info->curr_minor_hash = fname->minor_hash;
+		if (call_filldir(filp, dirent, filldir, fname))
+			break;
+
+		info->curr_node = rb_get_next(info->curr_node);
+		if (!info->curr_node) {
+			if (info->next_hash == ~0) {
+				filp->f_pos = EXT3_HTREE_EOF;
+				break;
+			}
+			info->curr_hash = info->next_hash;
+			info->curr_minor_hash = 0;
+		}
+	}
+finished:
+	info->last_pos = filp->f_pos;
+	UPDATE_ATIME(inode);
+	return 0;
+}
+
+static int ext3_release_dir (struct inode * inode, struct file * filp)
+{
+       if (filp->private_data)
+		ext3_htree_free_dir_info(filp->private_data);
+
+	return 0;
+}
+
+#endif
diff -Nru a/fs/ext3/file.c b/fs/ext3/file.c
--- a/fs/ext3/file.c	Thu Jan  1 16:29:25 2004
+++ b/fs/ext3/file.c	Thu Jan  1 16:29:25 2004
@@ -35,6 +35,9 @@
 {
 	if (filp->f_mode & FMODE_WRITE)
 		ext3_discard_prealloc (inode);
+	if (is_dx(inode) && filp->private_data)
+		ext3_htree_free_dir_info(filp->private_data);
+
 	return 0;
 }
 
diff -Nru a/fs/ext3/hash.c b/fs/ext3/hash.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/fs/ext3/hash.c	Thu Jan  1 16:29:25 2004
@@ -0,0 +1,218 @@
+/*
+ *  linux/fs/ext3/hash.c
+ *
+ * Copyright (C) 2002 by Theodore Ts'o
+ *
+ * This file is released under the GPL v2.
+ * 
+ * This file may be redistributed under the terms of the GNU Public
+ * License.
+ */
+
+#include <linux/fs.h>
+#include <linux/jbd.h>
+#include <linux/sched.h>
+#include <linux/ext3_fs.h>
+
+#define DELTA 0x9E3779B9
+
+static void TEA_transform(__u32 buf[4], __u32 const in[])
+{
+	__u32	sum = 0;
+	__u32	b0 = buf[0], b1 = buf[1];
+	__u32	a = in[0], b = in[1], c = in[2], d = in[3];
+	int	n = 16;
+
+	do {							
+		sum += DELTA;					
+		b0 += ((b1 << 4)+a) ^ (b1+sum) ^ ((b1 >> 5)+b);	
+		b1 += ((b0 << 4)+c) ^ (b0+sum) ^ ((b0 >> 5)+d);	
+	} while(--n);
+
+	buf[0] += b0;
+	buf[1] += b1;
+}
+
+/* F, G and H are basic MD4 functions: selection, majority, parity */
+#define F(x, y, z) ((z) ^ ((x) & ((y) ^ (z))))
+#define G(x, y, z) (((x) & (y)) + (((x) ^ (y)) & (z)))
+#define H(x, y, z) ((x) ^ (y) ^ (z))
+
+/*
+ * The generic round function.  The application is so specific that
+ * we don't bother protecting all the arguments with parens, as is generally
+ * good macro practice, in favor of extra legibility.
+ * Rotation is separate from addition to prevent recomputation
+ */
+#define ROUND(f, a, b, c, d, x, s)	\
+	(a += f(b, c, d) + x, a = (a << s) | (a >> (32-s)))
+#define K1 0
+#define K2 013240474631UL
+#define K3 015666365641UL
+
+/*
+ * Basic cut-down MD4 transform.  Returns only 32 bits of result.
+ */
+static void halfMD4Transform (__u32 buf[4], __u32 const in[])
+{
+	__u32	a = buf[0], b = buf[1], c = buf[2], d = buf[3];
+
+	/* Round 1 */
+	ROUND(F, a, b, c, d, in[0] + K1,  3);
+	ROUND(F, d, a, b, c, in[1] + K1,  7);
+	ROUND(F, c, d, a, b, in[2] + K1, 11);
+	ROUND(F, b, c, d, a, in[3] + K1, 19);
+	ROUND(F, a, b, c, d, in[4] + K1,  3);
+	ROUND(F, d, a, b, c, in[5] + K1,  7);
+	ROUND(F, c, d, a, b, in[6] + K1, 11);
+	ROUND(F, b, c, d, a, in[7] + K1, 19);
+
+	/* Round 2 */
+	ROUND(G, a, b, c, d, in[1] + K2,  3);
+	ROUND(G, d, a, b, c, in[3] + K2,  5);
+	ROUND(G, c, d, a, b, in[5] + K2,  9);
+	ROUND(G, b, c, d, a, in[7] + K2, 13);
+	ROUND(G, a, b, c, d, in[0] + K2,  3);
+	ROUND(G, d, a, b, c, in[2] + K2,  5);
+	ROUND(G, c, d, a, b, in[4] + K2,  9);
+	ROUND(G, b, c, d, a, in[6] + K2, 13);
+
+	/* Round 3 */
+	ROUND(H, a, b, c, d, in[3] + K3,  3);
+	ROUND(H, d, a, b, c, in[7] + K3,  9);
+	ROUND(H, c, d, a, b, in[2] + K3, 11);
+	ROUND(H, b, c, d, a, in[6] + K3, 15);
+	ROUND(H, a, b, c, d, in[1] + K3,  3);
+	ROUND(H, d, a, b, c, in[5] + K3,  9);
+	ROUND(H, c, d, a, b, in[0] + K3, 11);
+	ROUND(H, b, c, d, a, in[4] + K3, 15);
+
+	buf[0] += a;
+	buf[1] += b;
+	buf[2] += c;
+	buf[3] += d;
+}
+
+#undef ROUND
+#undef F
+#undef G
+#undef H
+#undef K1
+#undef K2
+#undef K3
+
+/* The old legacy hash */
+static __u32 dx_hack_hash (const char *name, int len)
+{
+	__u32 hash0 = 0x12a3fe2d, hash1 = 0x37abe8f9;
+	while (len--) {
+		__u32 hash = hash1 + (hash0 ^ (*name++ * 7152373));
+		
+		if (hash & 0x80000000) hash -= 0x7fffffff;
+		hash1 = hash0;
+		hash0 = hash;
+	}
+	return (hash0 << 1);
+}
+
+static void str2hashbuf(const char *msg, int len, __u32 *buf, int num)
+{
+	__u32	pad, val;
+	int	i;
+
+	pad = (__u32)len | ((__u32)len << 8);
+	pad |= pad << 16;
+
+	val = pad;
+	if (len > num*4)
+		len = num * 4;
+	for (i=0; i < len; i++) {
+		if ((i % 4) == 0)
+			val = pad;
+		val = msg[i] + (val << 8);
+		if ((i % 4) == 3) {
+			*buf++ = val;
+			val = pad;
+			num--;
+		}
+	}
+	if (--num >= 0)
+		*buf++ = val;
+	while (--num >= 0)
+		*buf++ = pad;
+}
+
+/*
+ * Returns the hash of a filename.  If len is 0 and name is NULL, then
+ * this function can be used to test whether or not a hash version is
+ * supported.
+ * 
+ * The seed is an 4 longword (32 bits) "secret" which can be used to
+ * uniquify a hash.  If the seed is all zero's, then some default seed
+ * may be used.
+ * 
+ * A particular hash version specifies whether or not the seed is
+ * represented, and whether or not the returned hash is 32 bits or 64
+ * bits.  32 bit hashes will return 0 for the minor hash.
+ */
+int ext3fs_dirhash(const char *name, int len, struct dx_hash_info *hinfo)
+{
+	__u32	hash;
+	__u32	minor_hash = 0;
+	const char	*p;
+	int		i;
+	__u32 		in[8], buf[4];
+
+	/* Initialize the default seed for the hash checksum functions */
+	buf[0] = 0x67452301;
+	buf[1] = 0xefcdab89;
+	buf[2] = 0x98badcfe;
+	buf[3] = 0x10325476;
+
+	/* Check to see if the seed is all zero's */
+	if (hinfo->seed) {
+		for (i=0; i < 4; i++) {
+			if (hinfo->seed[i])
+				break;
+		}
+		if (i < 4)
+			memcpy(buf, hinfo->seed, sizeof(buf));
+	}
+		
+	switch (hinfo->hash_version) {
+	case DX_HASH_LEGACY:
+		hash = dx_hack_hash(name, len);
+		break;
+	case DX_HASH_HALF_MD4:
+		p = name;
+		while (len > 0) {
+			str2hashbuf(p, len, in, 8);
+			halfMD4Transform(buf, in);
+			len -= 32;
+			p += 32;
+		}
+		minor_hash = buf[2];
+		hash = buf[1];
+		break;
+	case DX_HASH_TEA:
+		p = name;
+		while (len > 0) {
+			str2hashbuf(p, len, in, 4);
+			TEA_transform(buf, in);
+			len -= 16;
+			p += 16;
+		}
+		hash = buf[0];
+		minor_hash = buf[1];
+		break;
+	default:
+		hinfo->hash = 0;
+		return -1;
+	}
+	hash = hash & ~1;
+	if (hash == (EXT3_HTREE_EOF << 1))
+		hash = (EXT3_HTREE_EOF-1) << 1;
+	hinfo->hash = hash;
+	hinfo->minor_hash = minor_hash;
+	return 0;
+}
diff -Nru a/fs/ext3/inode.c b/fs/ext3/inode.c
--- a/fs/ext3/inode.c	Thu Jan  1 16:29:25 2004
+++ b/fs/ext3/inode.c	Thu Jan  1 16:29:25 2004
@@ -33,13 +33,6 @@
 #include <linux/module.h>
 
 /*
- * SEARCH_FROM_ZERO forces each block allocation to search from the start
- * of the filesystem.  This is to force rapid reallocation of recently-freed
- * blocks.  The file fragmentation is horrendous.
- */
-#undef SEARCH_FROM_ZERO
-
-/*
  * Test whether an inode is a fast symlink.
  */
 static inline int ext3_inode_is_fast_symlink(struct inode *inode)
@@ -507,10 +500,6 @@
 		inode->u.ext3_i.i_next_alloc_block++;
 		inode->u.ext3_i.i_next_alloc_goal++;
 	}
-#ifdef SEARCH_FROM_ZERO
-	inode->u.ext3_i.i_next_alloc_block = 0;
-	inode->u.ext3_i.i_next_alloc_goal = 0;
-#endif
 	/* Writer: end */
 	/* Reader: pointers, ->i_next_alloc* */
 	if (verify_chain(chain, partial)) {
@@ -522,9 +511,6 @@
 			*goal = inode->u.ext3_i.i_next_alloc_goal;
 		if (!*goal)
 			*goal = ext3_find_near(inode, partial);
-#ifdef SEARCH_FROM_ZERO
-		*goal = 0;
-#endif
 		return 0;
 	}
 	/* Reader: end */
@@ -669,10 +655,6 @@
 	*where->p = where->key;
 	inode->u.ext3_i.i_next_alloc_block = block;
 	inode->u.ext3_i.i_next_alloc_goal = le32_to_cpu(where[num-1].key);
-#ifdef SEARCH_FROM_ZERO
-	inode->u.ext3_i.i_next_alloc_block = 0;
-	inode->u.ext3_i.i_next_alloc_goal = 0;
-#endif
 	/* Writer: end */
 
 	/* We are done with atomic stuff, now do the rest of housekeeping */
diff -Nru a/fs/ext3/namei.c b/fs/ext3/namei.c
--- a/fs/ext3/namei.c	Thu Jan  1 16:29:25 2004
+++ b/fs/ext3/namei.c	Thu Jan  1 16:29:25 2004
@@ -16,6 +16,12 @@
  *        David S. Miller (davem@caip.rutgers.edu), 1995
  *  Directory entry file type support and forward compatibility hooks
  *  	for B-tree directories by Theodore Ts'o (tytso@mit.edu), 1998
+ *  Hash Tree Directory indexing (c)
+ *  	Daniel Phillips, 2001
+ *  Hash Tree Directory indexing porting
+ *  	Christopher Li, 2002
+ *  Hash Tree Directory indexing cleanup
+ * 	Theodore Ts'o, 2002
  */
 
 #include <linux/fs.h>
@@ -38,6 +44,689 @@
 #define NAMEI_RA_SIZE        (NAMEI_RA_CHUNKS * NAMEI_RA_BLOCKS)
 #define NAMEI_RA_INDEX(c,b)  (((c) * NAMEI_RA_BLOCKS) + (b))
 
+static struct buffer_head *ext3_append(handle_t *handle,
+					struct inode *inode,
+					u32 *block, int *err)
+{
+	struct buffer_head *bh;
+
+	*block = inode->i_size >> inode->i_sb->s_blocksize_bits;
+
+	if ((bh = ext3_bread(handle, inode, *block, 1, err))) {
+		inode->i_size += inode->i_sb->s_blocksize;
+		EXT3_I(inode)->i_disksize = inode->i_size;
+		ext3_journal_get_write_access(handle,bh);
+	}
+	return bh;
+}
+
+#ifndef assert
+#define assert(test) J_ASSERT(test)
+#endif
+
+#ifndef swap
+#define swap(x, y) do { typeof(x) z = x; x = y; y = z; } while (0)
+#endif
+
+typedef struct { u32 v; } le_u32;
+typedef struct { u16 v; } le_u16;
+
+#ifdef DX_DEBUG
+#define dxtrace(command) command
+#else
+#define dxtrace(command) 
+#endif
+
+struct fake_dirent
+{
+	/*le*/u32 inode;
+	/*le*/u16 rec_len;
+	u8 name_len;
+	u8 file_type;
+};
+
+struct dx_countlimit
+{
+	le_u16 limit;
+	le_u16 count;
+};
+
+struct dx_entry
+{
+	le_u32 hash;
+	le_u32 block;
+};
+
+/*
+ * dx_root_info is laid out so that if it should somehow get overlaid by a
+ * dirent the two low bits of the hash version will be zero.  Therefore, the
+ * hash version mod 4 should never be 0.  Sincerely, the paranoia department.
+ */
+
+struct dx_root
+{
+	struct fake_dirent dot;
+	char dot_name[4];
+	struct fake_dirent dotdot;
+	char dotdot_name[4];
+	struct dx_root_info
+	{
+		le_u32 reserved_zero;
+		u8 hash_version;
+		u8 info_length; /* 8 */
+		u8 indirect_levels;
+		u8 unused_flags;
+	}
+	info;
+	struct dx_entry	entries[0];
+};
+
+struct dx_node
+{
+	struct fake_dirent fake;
+	struct dx_entry	entries[0];
+};
+
+
+struct dx_frame
+{
+	struct buffer_head *bh;
+	struct dx_entry *entries;
+	struct dx_entry *at;
+};
+
+struct dx_map_entry
+{
+	u32 hash;
+	u32 offs;
+};
+
+#ifdef CONFIG_EXT3_INDEX
+static inline unsigned dx_get_block (struct dx_entry *entry);
+static void dx_set_block (struct dx_entry *entry, unsigned value);
+static inline unsigned dx_get_hash (struct dx_entry *entry);
+static void dx_set_hash (struct dx_entry *entry, unsigned value);
+static unsigned dx_get_count (struct dx_entry *entries);
+static unsigned dx_get_limit (struct dx_entry *entries);
+static void dx_set_count (struct dx_entry *entries, unsigned value);
+static void dx_set_limit (struct dx_entry *entries, unsigned value);
+static unsigned dx_root_limit (struct inode *dir, unsigned infosize);
+static unsigned dx_node_limit (struct inode *dir);
+static struct dx_frame *dx_probe(struct dentry *dentry,
+				 struct inode *dir,
+				 struct dx_hash_info *hinfo,
+				 struct dx_frame *frame,
+				 int *err);
+static void dx_release (struct dx_frame *frames);
+static int dx_make_map (struct ext3_dir_entry_2 *de, int size,
+			struct dx_hash_info *hinfo, struct dx_map_entry map[]);
+static void dx_sort_map(struct dx_map_entry *map, unsigned count);
+static struct ext3_dir_entry_2 *dx_move_dirents (char *from, char *to,
+		struct dx_map_entry *offsets, int count);
+static struct ext3_dir_entry_2* dx_pack_dirents (char *base, int size);
+static void dx_insert_block (struct dx_frame *frame, u32 hash, u32 block);
+static int ext3_htree_next_block(struct inode *dir, __u32 hash,
+				 struct dx_frame *frame,
+				 struct dx_frame *frames, 
+				 __u32 *start_hash);
+static struct buffer_head * ext3_dx_find_entry(struct dentry *dentry,
+		       struct ext3_dir_entry_2 **res_dir, int *err);
+static int ext3_dx_add_entry(handle_t *handle, struct dentry *dentry,
+			     struct inode *inode);
+
+/*
+ * Future: use high four bits of block for coalesce-on-delete flags
+ * Mask them off for now.
+ */
+
+static inline unsigned dx_get_block (struct dx_entry *entry)
+{
+	return le32_to_cpu(entry->block.v) & 0x00ffffff;
+}
+
+static inline void dx_set_block (struct dx_entry *entry, unsigned value)
+{
+	entry->block.v = cpu_to_le32(value);
+}
+
+static inline unsigned dx_get_hash (struct dx_entry *entry)
+{
+	return le32_to_cpu(entry->hash.v);
+}
+
+static inline void dx_set_hash (struct dx_entry *entry, unsigned value)
+{
+	entry->hash.v = cpu_to_le32(value);
+}
+
+static inline unsigned dx_get_count (struct dx_entry *entries)
+{
+	return le16_to_cpu(((struct dx_countlimit *) entries)->count.v);
+}
+
+static inline unsigned dx_get_limit (struct dx_entry *entries)
+{
+	return le16_to_cpu(((struct dx_countlimit *) entries)->limit.v);
+}
+
+static inline void dx_set_count (struct dx_entry *entries, unsigned value)
+{
+	((struct dx_countlimit *) entries)->count.v = cpu_to_le16(value);
+}
+
+static inline void dx_set_limit (struct dx_entry *entries, unsigned value)
+{
+	((struct dx_countlimit *) entries)->limit.v = cpu_to_le16(value);
+}
+
+static inline unsigned dx_root_limit (struct inode *dir, unsigned infosize)
+{
+	unsigned entry_space = dir->i_sb->s_blocksize - EXT3_DIR_REC_LEN(1) -
+		EXT3_DIR_REC_LEN(2) - infosize;
+	return 0? 20: entry_space / sizeof(struct dx_entry);
+}
+
+static inline unsigned dx_node_limit (struct inode *dir)
+{
+	unsigned entry_space = dir->i_sb->s_blocksize - EXT3_DIR_REC_LEN(0);
+	return 0? 22: entry_space / sizeof(struct dx_entry);
+}
+
+/*
+ * Debug
+ */
+#ifdef DX_DEBUG
+static void dx_show_index (char * label, struct dx_entry *entries)
+{
+        int i, n = dx_get_count (entries);
+        printk("%s index ", label);
+        for (i = 0; i < n; i++)
+        {
+                printk("%x->%u ", i? dx_get_hash(entries + i): 0, dx_get_block(entries + i));
+        }
+        printk("\n");
+}
+
+struct stats
+{ 
+	unsigned names;
+	unsigned space;
+	unsigned bcount;
+};
+
+static struct stats dx_show_leaf(struct dx_hash_info *hinfo, struct ext3_dir_entry_2 *de,
+				 int size, int show_names)
+{
+	unsigned names = 0, space = 0;
+	char *base = (char *) de;
+	struct dx_hash_info h = *hinfo;
+	
+	printk("names: ");
+	while ((char *) de < base + size)
+	{
+		if (de->inode)
+		{
+			if (show_names)
+			{
+				int len = de->name_len;
+				char *name = de->name;
+				while (len--) printk("%c", *name++);
+				ext3fs_dirhash(de->name, de->name_len, &h);
+				printk(":%x.%u ", h.hash,
+				       ((char *) de - base));
+			}
+			space += EXT3_DIR_REC_LEN(de->name_len);
+	 		names++;
+		}
+		de = (struct ext3_dir_entry_2 *) ((char *) de + le16_to_cpu(de->rec_len));
+	}
+	printk("(%i)\n", names);
+	return (struct stats) { names, space, 1 };
+}
+
+struct stats dx_show_entries(struct dx_hash_info *hinfo, struct inode *dir,
+			     struct dx_entry *entries, int levels)
+{
+	unsigned blocksize = dir->i_sb->s_blocksize;
+	unsigned count = dx_get_count (entries), names = 0, space = 0, i;
+	unsigned bcount = 0;
+	struct buffer_head *bh;
+	int err;
+	printk("%i indexed blocks...\n", count);
+	for (i = 0; i < count; i++, entries++)
+	{
+		u32 block = dx_get_block(entries), hash = i? dx_get_hash(entries): 0;
+		u32 range = i < count - 1? (dx_get_hash(entries + 1) - hash): ~hash;
+		struct stats stats;
+		printk("%s%3u:%03u hash %8x/%8x ",levels?"":"   ", i, block, hash, range);
+		if (!(bh = ext3_bread (NULL,dir, block, 0,&err))) continue;
+		stats = levels?
+		   dx_show_entries(hinfo, dir, ((struct dx_node *) bh->b_data)->entries, levels - 1):
+		   dx_show_leaf(hinfo, (struct ext3_dir_entry_2 *) bh->b_data, blocksize, 0);
+		names += stats.names;
+		space += stats.space;
+		bcount += stats.bcount;
+		brelse (bh);
+	}
+	if (bcount)
+		printk("%snames %u, fullness %u (%u%%)\n", levels?"":"   ",
+			names, space/bcount,(space/bcount)*100/blocksize);
+	return (struct stats) { names, space, bcount};
+}
+#endif /* DX_DEBUG */
+
+/*
+ * Probe for a directory leaf block to search.
+ *
+ * dx_probe can return ERR_BAD_DX_DIR, which means there was a format
+ * error in the directory index, and the caller should fall back to
+ * searching the directory normally.  The callers of dx_probe **MUST**
+ * check for this error code, and make sure it never gets reflected
+ * back to userspace.
+ */
+static struct dx_frame *
+dx_probe(struct dentry *dentry, struct inode *dir,
+	 struct dx_hash_info *hinfo, struct dx_frame *frame_in, int *err)
+{
+	unsigned count, indirect;
+	struct dx_entry *at, *entries, *p, *q, *m;
+	struct dx_root *root;
+	struct buffer_head *bh;
+	struct dx_frame *frame = frame_in;
+	u32 hash;
+
+	frame->bh = NULL;
+	if (dentry)
+		dir = dentry->d_parent->d_inode;
+	if (!(bh = ext3_bread (NULL,dir, 0, 0, err)))
+		goto fail;
+	root = (struct dx_root *) bh->b_data;
+	if (root->info.hash_version != DX_HASH_TEA &&
+	    root->info.hash_version != DX_HASH_HALF_MD4 &&
+	    root->info.hash_version != DX_HASH_LEGACY) {
+		ext3_warning(dir->i_sb, __FUNCTION__,
+			     "Unrecognised inode hash code %d",
+			     root->info.hash_version);
+		brelse(bh);
+		*err = ERR_BAD_DX_DIR;
+		goto fail;
+	}
+	hinfo->hash_version = root->info.hash_version;
+	hinfo->seed = dir->i_sb->u.ext3_sb.s_hash_seed;
+	if (dentry)
+		ext3fs_dirhash(dentry->d_name.name, dentry->d_name.len, hinfo);
+	hash = hinfo->hash;
+
+	if (root->info.unused_flags & 1) {
+		ext3_warning(dir->i_sb, __FUNCTION__,
+			     "Unimplemented inode hash flags: %#06x",
+			     root->info.unused_flags);
+		brelse(bh);
+		*err = ERR_BAD_DX_DIR;
+		goto fail;
+	}
+
+	if ((indirect = root->info.indirect_levels) > 1) {
+		ext3_warning(dir->i_sb, __FUNCTION__,
+			     "Unimplemented inode hash depth: %#06x",
+			     root->info.indirect_levels);
+		brelse(bh);
+		*err = ERR_BAD_DX_DIR;
+		goto fail;
+	}
+
+	entries = (struct dx_entry *) (((char *)&root->info) +
+				       root->info.info_length);
+	assert(dx_get_limit(entries) == dx_root_limit(dir,
+						      root->info.info_length));
+	dxtrace (printk("Look up %x", hash));
+	while (1)
+	{
+		count = dx_get_count(entries);
+		assert (count && count <= dx_get_limit(entries));
+		p = entries + 1;
+		q = entries + count - 1;
+		while (p <= q)
+		{
+			m = p + (q - p)/2;
+			dxtrace(printk("."));
+			if (dx_get_hash(m) > hash)
+				q = m - 1;
+			else
+				p = m + 1;
+		}
+
+		if (0) // linear search cross check
+		{
+			unsigned n = count - 1;
+			at = entries;
+			while (n--)
+			{
+				dxtrace(printk(","));
+				if (dx_get_hash(++at) > hash)
+				{
+					at--;
+					break;
+				}
+			}
+			assert (at == p - 1);
+		}
+
+		at = p - 1;
+		dxtrace(printk(" %x->%u\n", at == entries? 0: dx_get_hash(at), dx_get_block(at)));
+		frame->bh = bh;
+		frame->entries = entries;
+		frame->at = at;
+		if (!indirect--) return frame;
+		if (!(bh = ext3_bread (NULL,dir, dx_get_block(at), 0, err)))
+			goto fail2;
+		at = entries = ((struct dx_node *) bh->b_data)->entries;
+		assert (dx_get_limit(entries) == dx_node_limit (dir));
+		frame++;
+	}
+fail2:
+	while (frame >= frame_in) {
+		brelse(frame->bh);
+		frame--;
+	}
+fail:
+	return NULL;
+}
+
+static void dx_release (struct dx_frame *frames)
+{
+	if (frames[0].bh == NULL)
+		return;
+
+	if (((struct dx_root *) frames[0].bh->b_data)->info.indirect_levels)
+		brelse(frames[1].bh);
+	brelse(frames[0].bh);
+}
+
+/*
+ * This function increments the frame pointer to search the next leaf
+ * block, and reads in the necessary intervening nodes if the search
+ * should be necessary.  Whether or not the search is necessary is
+ * controlled by the hash parameter.  If the hash value is even, then
+ * the search is only continued if the next block starts with that
+ * hash value.  This is used if we are searching for a specific file.
+ *
+ * If the hash value is HASH_NB_ALWAYS, then always go to the next block.
+ *
+ * This function returns 1 if the caller should continue to search,
+ * or 0 if it should not.  If there is an error reading one of the
+ * index blocks, it will a negative error code.
+ *
+ * If start_hash is non-null, it will be filled in with the starting
+ * hash of the next page.
+ */
+static int ext3_htree_next_block(struct inode *dir, __u32 hash,
+				 struct dx_frame *frame,
+				 struct dx_frame *frames, 
+				 __u32 *start_hash)
+{
+	struct dx_frame *p;
+	struct buffer_head *bh;
+	int err, num_frames = 0;
+	__u32 bhash;
+
+	p = frame;
+	/*
+	 * Find the next leaf page by incrementing the frame pointer.
+	 * If we run out of entries in the interior node, loop around and
+	 * increment pointer in the parent node.  When we break out of
+	 * this loop, num_frames indicates the number of interior
+	 * nodes need to be read.
+	 */
+	while (1) {
+		if (++(p->at) < p->entries + dx_get_count(p->entries))
+			break;
+		if (p == frames)
+			return 0;
+		num_frames++;
+		p--;
+	}
+
+	/*
+	 * If the hash is 1, then continue only if the next page has a
+	 * continuation hash of any value.  This is used for readdir
+	 * handling.  Otherwise, check to see if the hash matches the
+	 * desired contiuation hash.  If it doesn't, return since
+	 * there's no point to read in the successive index pages.
+	 */
+	bhash = dx_get_hash(p->at);
+	if (start_hash)
+		*start_hash = bhash;
+	if ((hash & 1) == 0) {
+		if ((bhash & ~1) != hash)
+			return 0;
+	}
+	/*
+	 * If the hash is HASH_NB_ALWAYS, we always go to the next
+	 * block so no check is necessary
+	 */
+	while (num_frames--) {
+		if (!(bh = ext3_bread(NULL, dir, dx_get_block(p->at),
+				      0, &err)))
+			return err; /* Failure */
+		p++;
+		brelse (p->bh);
+		p->bh = bh;
+		p->at = p->entries = ((struct dx_node *) bh->b_data)->entries;
+	}
+	return 1;
+}
+
+
+/*
+ * p is at least 6 bytes before the end of page
+ */
+static inline struct ext3_dir_entry_2 *ext3_next_entry(struct ext3_dir_entry_2 *p)
+{
+	return (struct ext3_dir_entry_2 *)((char*)p + le16_to_cpu(p->rec_len));
+}
+
+/*
+ * This function fills a red-black tree with information from a
+ * directory block.  It returns the number directory entries loaded
+ * into the tree.  If there is an error it is returned in err.
+ */
+static int htree_dirblock_to_tree(struct file *dir_file,
+				  struct inode *dir, int block,
+				  struct dx_hash_info *hinfo,
+				  __u32 start_hash, __u32 start_minor_hash)
+{
+	struct buffer_head *bh;
+	struct ext3_dir_entry_2 *de, *top;
+	int err, count = 0;
+
+	dxtrace(printk("In htree dirblock_to_tree: block %d\n", block));
+	if (!(bh = ext3_bread (NULL, dir, block, 0, &err)))
+		return err;
+	
+	de = (struct ext3_dir_entry_2 *) bh->b_data;
+	top = (struct ext3_dir_entry_2 *) ((char *) de +
+					   dir->i_sb->s_blocksize -
+					   EXT3_DIR_REC_LEN(0));
+	for (; de < top; de = ext3_next_entry(de)) {
+		ext3fs_dirhash(de->name, de->name_len, hinfo);
+		if ((hinfo->hash < start_hash) ||
+		    ((hinfo->hash == start_hash) &&
+		     (hinfo->minor_hash < start_minor_hash)))
+			continue;
+		if ((err = ext3_htree_store_dirent(dir_file,
+				   hinfo->hash, hinfo->minor_hash, de)) != 0) {
+			brelse(bh);
+			return err;
+		}
+		count++;
+	}
+	brelse(bh);
+	return count;
+}
+
+
+/*
+ * This function fills a red-black tree with information from a
+ * directory.  We start scanning the directory in hash order, starting
+ * at start_hash and start_minor_hash.
+ *
+ * This function returns the number of entries inserted into the tree,
+ * or a negative error code.
+ */
+int ext3_htree_fill_tree(struct file *dir_file, __u32 start_hash,
+			 __u32 start_minor_hash, __u32 *next_hash)
+{
+	struct dx_hash_info hinfo;
+	struct ext3_dir_entry_2 *de;
+	struct dx_frame frames[2], *frame;
+	struct inode *dir;
+	int block, err;
+	int count = 0;
+	int ret;
+	__u32 hashval;
+	
+	dxtrace(printk("In htree_fill_tree, start hash: %x:%x\n", start_hash,
+		       start_minor_hash));
+	dir = dir_file->f_dentry->d_inode;
+	if (!(EXT3_I(dir)->i_flags & EXT3_INDEX_FL)) {	
+		hinfo.hash_version = EXT3_SB(dir->i_sb)->s_def_hash_version;
+		hinfo.seed = EXT3_SB(dir->i_sb)->s_hash_seed;
+		count = htree_dirblock_to_tree(dir_file, dir, 0, &hinfo,
+					       start_hash, start_minor_hash);
+		*next_hash = ~0;
+		return count;
+	}
+	hinfo.hash = start_hash;
+	hinfo.minor_hash = 0;
+	frame = dx_probe(0, dir_file->f_dentry->d_inode, &hinfo, frames, &err);
+	if (!frame)
+		return err;
+
+	/* Add '.' and '..' from the htree header */
+	if (!start_hash && !start_minor_hash) {
+		de = (struct ext3_dir_entry_2 *) frames[0].bh->b_data;
+		if ((err = ext3_htree_store_dirent(dir_file, 0, 0, de)) != 0)
+			goto errout;
+		de = ext3_next_entry(de);
+		if ((err = ext3_htree_store_dirent(dir_file, 0, 0, de)) != 0)
+			goto errout;
+		count += 2;
+	}
+
+	while (1) {
+		block = dx_get_block(frame->at);
+		ret = htree_dirblock_to_tree(dir_file, dir, block, &hinfo,
+					     start_hash, start_minor_hash);
+		if (ret < 0) {
+			err = ret;
+			goto errout;
+		}
+		count += ret;
+		hashval = ~0;
+		ret = ext3_htree_next_block(dir, HASH_NB_ALWAYS, 
+					    frame, frames, &hashval);
+		*next_hash = hashval;
+		if (ret < 0) {
+			err = ret;
+			goto errout;
+		}
+		/*
+		 * Stop if:  (a) there are no more entries, or
+		 * (b) we have inserted at least one entry and the
+		 * next hash value is not a continuation
+		 */
+		if ((ret == 0) ||
+		    (count && ((hashval & 1) == 0)))
+			break;
+	}
+	dx_release(frames);
+	dxtrace(printk("Fill tree: returned %d entries, next hash: %x\n", 
+		       count, *next_hash));
+	return count;
+errout:
+	dx_release(frames);
+	return (err);
+}
+
+
+/*
+ * Directory block splitting, compacting
+ */
+
+static int dx_make_map (struct ext3_dir_entry_2 *de, int size,
+			struct dx_hash_info *hinfo, struct dx_map_entry *map_tail)
+{
+	int count = 0;
+	char *base = (char *) de;
+	struct dx_hash_info h = *hinfo;
+	
+	while ((char *) de < base + size)
+	{
+		if (de->name_len && de->inode) {
+			ext3fs_dirhash(de->name, de->name_len, &h);
+			map_tail--;
+			map_tail->hash = h.hash;
+			map_tail->offs = (u32) ((char *) de - base);
+			count++;
+		}
+		/* XXX: do we need to check rec_len == 0 case? -Chris */
+		de = (struct ext3_dir_entry_2 *) ((char *) de + le16_to_cpu(de->rec_len));
+	}
+	return count;
+}
+
+static void dx_sort_map (struct dx_map_entry *map, unsigned count)
+{
+        struct dx_map_entry *p, *q, *top = map + count - 1;
+        int more;
+        /* Combsort until bubble sort doesn't suck */
+        while (count > 2)
+	{
+                count = count*10/13;
+                if (count - 9 < 2) /* 9, 10 -> 11 */
+                        count = 11;
+                for (p = top, q = p - count; q >= map; p--, q--)
+                        if (p->hash < q->hash)
+                                swap(*p, *q);
+        }
+        /* Garden variety bubble sort */
+        do {
+                more = 0;
+                q = top;
+                while (q-- > map)
+		{
+                        if (q[1].hash >= q[0].hash)
+				continue;
+                        swap(*(q+1), *q);
+                        more = 1;
+		}
+	} while(more);
+}
+
+static void dx_insert_block(struct dx_frame *frame, u32 hash, u32 block)
+{
+	struct dx_entry *entries = frame->entries;
+	struct dx_entry *old = frame->at, *new = old + 1;
+	int count = dx_get_count(entries);
+
+	assert(count < dx_get_limit(entries));
+	assert(old < entries + count);
+	memmove(new + 1, new, (char *)(entries + count) - (char *)(new));
+	dx_set_hash(new, hash);
+	dx_set_block(new, block);
+	dx_set_count(entries, count + 1);
+}
+#endif
+
+
+static void ext3_update_dx_flag(struct inode *inode)
+{
+	if (!EXT3_HAS_COMPAT_FEATURE(inode->i_sb,
+				     EXT3_FEATURE_COMPAT_DIR_INDEX))
+		EXT3_I(inode)->i_flags &= ~EXT3_INDEX_FL;
+}
+
 /*
  * NOTE! unlike strncmp, ext3_match returns 1 for success, 0 for failure.
  *
@@ -94,6 +783,7 @@
 	return 0;
 }
 
+
 /*
  *	ext3_find_entry()
  *
@@ -105,6 +795,8 @@
  * The returned buffer_head has ->b_count elevated.  The caller is expected
  * to brelse() it when appropriate.
  */
+
+	
 static struct buffer_head * ext3_find_entry (struct dentry *dentry,
 					struct ext3_dir_entry_2 ** res_dir)
 {
@@ -119,12 +811,32 @@
 	int num = 0;
 	int nblocks, i, err;
 	struct inode *dir = dentry->d_parent->d_inode;
+	int namelen;
+	const u8 *name;
+	unsigned blocksize;
 
 	*res_dir = NULL;
 	sb = dir->i_sb;
-
+	blocksize = sb->s_blocksize;
+	namelen = dentry->d_name.len;
+	name = dentry->d_name.name;
+	if (namelen > EXT3_NAME_LEN)
+		return NULL;
+#ifdef CONFIG_EXT3_INDEX
+	if (is_dx(dir)) {
+		bh = ext3_dx_find_entry(dentry, res_dir, &err);
+		/*
+		 * On success, or if the error was file not found,
+		 * return.  Otherwise, fall back to doing a search the
+		 * old fashioned way.
+		 */
+		if (bh || (err != ERR_BAD_DX_DIR))
+			return bh;
+		dxtrace(printk("ext3_find_entry: dx failed, falling back\n"));
+	}
+#endif
 	nblocks = dir->i_size >> EXT3_BLOCK_SIZE_BITS(sb);
-	start = dir->u.ext3_i.i_dir_start_lookup;
+	start = EXT3_I(dir)->i_dir_start_lookup;
 	if (start >= nblocks)
 		start = 0;
 	block = start;
@@ -165,7 +877,7 @@
 		i = search_dirblock(bh, dir, dentry,
 			    block << EXT3_BLOCK_SIZE_BITS(sb), res_dir);
 		if (i == 1) {
-			dir->u.ext3_i.i_dir_start_lookup = block;
+			EXT3_I(dir)->i_dir_start_lookup = block;
 			ret = bh;
 			goto cleanup_and_exit;
 		} else {
@@ -196,6 +908,67 @@
 	return ret;
 }
 
+#ifdef CONFIG_EXT3_INDEX
+static struct buffer_head * ext3_dx_find_entry(struct dentry *dentry,
+		       struct ext3_dir_entry_2 **res_dir, int *err)
+{
+	struct super_block * sb;
+	struct dx_hash_info	hinfo;
+	u32 hash;
+	struct dx_frame frames[2], *frame;
+	struct ext3_dir_entry_2 *de, *top;
+	struct buffer_head *bh;
+	unsigned long block;
+	int retval;
+	int namelen = dentry->d_name.len;
+	const u8 *name = dentry->d_name.name;
+	struct inode *dir = dentry->d_parent->d_inode;
+	
+	sb = dir->i_sb;
+	if (!(frame = dx_probe (dentry, 0, &hinfo, frames, err)))
+		return NULL;
+	hash = hinfo.hash;
+	do {
+		block = dx_get_block(frame->at);
+		if (!(bh = ext3_bread (NULL,dir, block, 0, err)))
+			goto errout;
+		de = (struct ext3_dir_entry_2 *) bh->b_data;
+		top = (struct ext3_dir_entry_2 *) ((char *) de + sb->s_blocksize -
+				       EXT3_DIR_REC_LEN(0));
+		for (; de < top; de = ext3_next_entry(de))
+		if (ext3_match (namelen, name, de)) {
+			if (!ext3_check_dir_entry("ext3_find_entry",
+						  dir, de, bh,
+				  (block<<EXT3_BLOCK_SIZE_BITS(sb))
+					  +((char *)de - bh->b_data))) {
+				brelse (bh);
+				goto errout;
+			}
+			*res_dir = de;
+			dx_release (frames);
+			return bh;
+		}
+		brelse (bh);
+		/* Check to see if we should continue to search */
+		retval = ext3_htree_next_block(dir, hash, frame,
+					       frames, 0);
+		if (retval < 0) {
+			ext3_warning(sb, __FUNCTION__,
+			     "error reading index page in directory #%lu",
+			     dir->i_ino);
+			*err = retval;
+			goto errout;
+		}
+	} while (retval == 1);
+	
+	*err = -ENOENT;
+errout:
+	dxtrace(printk("%s not found\n", name));
+	dx_release (frames);
+	return NULL;
+}
+#endif
+
 static struct dentry *ext3_lookup(struct inode * dir, struct dentry *dentry)
 {
 	struct inode * inode;
@@ -212,8 +985,9 @@
 		brelse (bh);
 		inode = iget(dir->i_sb, ino);
 
-		if (!inode)
+		if (!inode) {
 			return ERR_PTR(-EACCES);
+		}
 	}
 	d_add(dentry, inode);
 	return NULL;
@@ -237,6 +1011,303 @@
 		de->file_type = ext3_type_by_mode[(mode & S_IFMT)>>S_SHIFT];
 }
 
+#ifdef CONFIG_EXT3_INDEX
+static struct ext3_dir_entry_2 *
+dx_move_dirents(char *from, char *to, struct dx_map_entry *map, int count)
+{
+	unsigned rec_len = 0;
+
+	while (count--) {
+		struct ext3_dir_entry_2 *de = (struct ext3_dir_entry_2 *) (from + map->offs);
+		rec_len = EXT3_DIR_REC_LEN(de->name_len);
+		memcpy (to, de, rec_len);
+		((struct ext3_dir_entry_2 *) to)->rec_len =
+				cpu_to_le16(rec_len);
+		de->inode = 0;
+		map++;
+		to += rec_len;
+	}
+	return (struct ext3_dir_entry_2 *) (to - rec_len);
+}
+
+static struct ext3_dir_entry_2* dx_pack_dirents(char *base, int size)
+{
+	struct ext3_dir_entry_2 *next, *to, *prev, *de = (struct ext3_dir_entry_2 *) base;
+	unsigned rec_len = 0;
+
+	prev = to = de;
+	while ((char*)de < base + size) {
+		next = (struct ext3_dir_entry_2 *) ((char *) de +
+						    le16_to_cpu(de->rec_len));
+		if (de->inode && de->name_len) {
+			rec_len = EXT3_DIR_REC_LEN(de->name_len);
+			if (de > to)
+				memmove(to, de, rec_len);
+			to->rec_len = cpu_to_le16(rec_len);
+			prev = to;
+			to = (struct ext3_dir_entry_2 *) (((char *) to) + rec_len);
+		}
+		de = next;
+	}
+	return prev;
+}
+
+static struct ext3_dir_entry_2 *do_split(handle_t *handle, struct inode *dir,
+			struct buffer_head **bh,struct dx_frame *frame,
+			struct dx_hash_info *hinfo, int *error)
+{
+	unsigned blocksize = dir->i_sb->s_blocksize;
+	unsigned count, continued;
+	struct buffer_head *bh2;
+	u32 newblock;
+	u32 hash2;
+	struct dx_map_entry *map;
+	char *data1 = (*bh)->b_data, *data2;
+	unsigned split;
+	struct ext3_dir_entry_2 *de = NULL, *de2;
+	int	err;
+
+	bh2 = ext3_append (handle, dir, &newblock, error);
+	if (!(bh2)) {
+		brelse(*bh);
+		*bh = NULL;
+		goto errout;
+	}
+
+	BUFFER_TRACE(*bh, "get_write_access");
+	err = ext3_journal_get_write_access(handle, *bh);
+	if (err) {
+	journal_error:
+		brelse(*bh);
+		brelse(bh2);
+		*bh = NULL;
+		ext3_std_error(dir->i_sb, err);
+		goto errout;
+	}
+	BUFFER_TRACE(frame->bh, "get_write_access");
+	err = ext3_journal_get_write_access(handle, frame->bh);
+	if (err)
+		goto journal_error;
+
+	data2 = bh2->b_data;
+
+	/* create map in the end of data2 block */
+	map = (struct dx_map_entry *) (data2 + blocksize);
+	count = dx_make_map ((struct ext3_dir_entry_2 *) data1,
+			     blocksize, hinfo, map);
+	map -= count;
+	split = count/2; // need to adjust to actual middle
+	dx_sort_map (map, count);
+	hash2 = map[split].hash;
+	continued = hash2 == map[split - 1].hash;
+	dxtrace(printk("Split block %i at %x, %i/%i\n",
+		dx_get_block(frame->at), hash2, split, count-split));
+
+	/* Fancy dance to stay within two buffers */
+	de2 = dx_move_dirents(data1, data2, map + split, count - split);
+	de = dx_pack_dirents(data1,blocksize);
+	de->rec_len = cpu_to_le16(data1 + blocksize - (char *) de);
+	de2->rec_len = cpu_to_le16(data2 + blocksize - (char *) de2);
+	dxtrace(dx_show_leaf (hinfo, (struct ext3_dir_entry_2 *) data1, blocksize, 1));
+	dxtrace(dx_show_leaf (hinfo, (struct ext3_dir_entry_2 *) data2, blocksize, 1));
+
+	/* Which block gets the new entry? */
+	if (hinfo->hash >= hash2)
+	{
+		swap(*bh, bh2);
+		de = de2;
+	}
+	dx_insert_block (frame, hash2 + continued, newblock);
+	err = ext3_journal_dirty_metadata (handle, bh2);
+	if (err)
+		goto journal_error;
+	err = ext3_journal_dirty_metadata (handle, frame->bh);
+	if (err)
+		goto journal_error;
+	brelse (bh2);
+	dxtrace(dx_show_index ("frame", frame->entries));
+errout:
+	return de;
+}
+#endif
+
+
+/*
+ * Add a new entry into a directory (leaf) block.  If de is non-NULL,
+ * it points to a directory entry which is guaranteed to be large
+ * enough for new directory entry.  If de is NULL, then
+ * add_dirent_to_buf will attempt search the directory block for
+ * space.  It will return -ENOSPC if no space is available, and -EIO
+ * and -EEXIST if directory entry already exists.
+ * 
+ * NOTE!  bh is NOT released in the case where ENOSPC is returned.  In
+ * all other cases bh is released.
+ */
+static int add_dirent_to_buf(handle_t *handle, struct dentry *dentry,
+			     struct inode *inode, struct ext3_dir_entry_2 *de,
+			     struct buffer_head * bh)
+{
+	struct inode	*dir = dentry->d_parent->d_inode;
+	const char	*name = dentry->d_name.name;
+	int		namelen = dentry->d_name.len;
+	unsigned long	offset = 0;
+	unsigned short	reclen;
+	int		nlen, rlen, err;
+	char		*top;
+	
+	reclen = EXT3_DIR_REC_LEN(namelen);
+	if (!de) {
+		de = (struct ext3_dir_entry_2 *)bh->b_data;
+		top = bh->b_data + dir->i_sb->s_blocksize - reclen;
+		while ((char *) de <= top) {
+			if (!ext3_check_dir_entry("ext3_add_entry", dir, de,
+						  bh, offset)) {
+				brelse (bh);
+				return -EIO;
+			}
+			if (ext3_match (namelen, name, de)) {
+				brelse (bh);
+				return -EEXIST;
+			}
+			nlen = EXT3_DIR_REC_LEN(de->name_len);
+			rlen = le16_to_cpu(de->rec_len);
+			if ((de->inode? rlen - nlen: rlen) >= reclen)
+				break;
+			de = (struct ext3_dir_entry_2 *)((char *)de + rlen);
+			offset += rlen;
+		}
+		if ((char *) de > top)
+			return -ENOSPC;
+	}
+	BUFFER_TRACE(bh, "get_write_access");
+	err = ext3_journal_get_write_access(handle, bh);
+	if (err) {
+		ext3_std_error(dir->i_sb, err);
+		brelse(bh);
+		return err;
+	}
+	
+	/* By now the buffer is marked for journaling */
+	nlen = EXT3_DIR_REC_LEN(de->name_len);
+	rlen = le16_to_cpu(de->rec_len);
+	if (de->inode) {
+		struct ext3_dir_entry_2 *de1 = (struct ext3_dir_entry_2 *)((char *)de + nlen);
+		de1->rec_len = cpu_to_le16(rlen - nlen);
+		de->rec_len = cpu_to_le16(nlen);
+		de = de1;
+	}
+	de->file_type = EXT3_FT_UNKNOWN;
+	if (inode) {
+		de->inode = cpu_to_le32(inode->i_ino);
+		ext3_set_de_type(dir->i_sb, de, inode->i_mode);
+	} else
+		de->inode = 0;
+	de->name_len = namelen;
+	memcpy (de->name, name, namelen);
+	/*
+	 * XXX shouldn't update any times until successful
+	 * completion of syscall, but too many callers depend
+	 * on this.
+	 *
+	 * XXX similarly, too many callers depend on
+	 * ext3_new_inode() setting the times, but error
+	 * recovery deletes the inode, so the worst that can
+	 * happen is that the times are slightly out of date
+	 * and/or different from the directory change time.
+	 */
+	dir->i_mtime = dir->i_ctime = CURRENT_TIME;
+	ext3_update_dx_flag(dir);
+	dir->i_version = ++event;
+	ext3_mark_inode_dirty(handle, dir);
+	BUFFER_TRACE(bh, "call ext3_journal_dirty_metadata");
+	err = ext3_journal_dirty_metadata(handle, bh);
+	if (err)
+		ext3_std_error(dir->i_sb, err);
+	brelse(bh);
+	return 0;
+}
+
+#ifdef CONFIG_EXT3_INDEX
+/*
+ * This converts a one block unindexed directory to a 3 block indexed
+ * directory, and adds the dentry to the indexed directory.
+ */
+static int make_indexed_dir(handle_t *handle, struct dentry *dentry,
+			    struct inode *inode, struct buffer_head *bh)
+{
+	struct inode	*dir = dentry->d_parent->d_inode;
+	const char	*name = dentry->d_name.name;
+	int		namelen = dentry->d_name.len;
+	struct buffer_head *bh2;
+	struct dx_root	*root;
+	struct dx_frame	frames[2], *frame;
+	struct dx_entry *entries;
+	struct ext3_dir_entry_2	*de, *de2;
+	char		*data1, *top;
+	unsigned	len;
+	int		retval;
+	unsigned	blocksize;
+	struct dx_hash_info hinfo;
+	u32		block;
+	struct fake_dirent *fde;
+		
+	blocksize =  dir->i_sb->s_blocksize;
+	dxtrace(printk("Creating index\n"));
+	retval = ext3_journal_get_write_access(handle, bh);
+	if (retval) {
+		ext3_std_error(dir->i_sb, retval);
+		brelse(bh);
+		return retval;
+	}
+	root = (struct dx_root *) bh->b_data;
+		
+	bh2 = ext3_append (handle, dir, &block, &retval);
+	if (!(bh2)) {
+		brelse(bh);
+		return retval;
+	}
+	EXT3_I(dir)->i_flags |= EXT3_INDEX_FL;
+	data1 = bh2->b_data;
+
+	/* The 0th block becomes the root, move the dirents out */
+	fde = &root->dotdot;
+	de = (struct ext3_dir_entry_2 *)((char *)fde + le16_to_cpu(fde->rec_len));
+	len = ((char *) root) + blocksize - (char *) de;
+	memcpy (data1, de, len);
+	de = (struct ext3_dir_entry_2 *) data1;
+	top = data1 + len;
+	while (((char *) de2=(char*)de+le16_to_cpu(de->rec_len)) < top)
+		de = de2;
+	de->rec_len = cpu_to_le16(data1 + blocksize - (char *) de);
+	/* Initialize the root; the dot dirents already exist */
+	de = (struct ext3_dir_entry_2 *) (&root->dotdot);
+	de->rec_len = cpu_to_le16(blocksize - EXT3_DIR_REC_LEN(2));
+	memset (&root->info, 0, sizeof(root->info));
+	root->info.info_length = sizeof(root->info);
+	root->info.hash_version = dir->i_sb->u.ext3_sb.s_def_hash_version;
+	entries = root->entries;
+	dx_set_block (entries, 1);
+	dx_set_count (entries, 1);
+	dx_set_limit (entries, dx_root_limit(dir, sizeof(root->info)));
+
+	/* Initialize as for dx_probe */
+	hinfo.hash_version = root->info.hash_version;
+	hinfo.seed = dir->i_sb->u.ext3_sb.s_hash_seed;
+	ext3fs_dirhash(name, namelen, &hinfo);
+	frame = frames;
+	frame->entries = entries;
+	frame->at = entries;
+	frame->bh = bh;
+	bh = bh2;
+	de = do_split(handle,dir, &bh, frame, &hinfo, &retval);
+	dx_release (frames);
+	if (!(de))
+		return retval;
+
+	return add_dirent_to_buf(handle, dentry, inode, de, bh);
+}
+#endif
+
 /*
  *	ext3_add_entry()
  *
@@ -247,127 +1318,198 @@
  * may not sleep between calling this and putting something into
  * the entry, as someone else might have used it while you slept.
  */
-
-/*
- * AKPM: the journalling code here looks wrong on the error paths
- */
 static int ext3_add_entry (handle_t *handle, struct dentry *dentry,
 	struct inode *inode)
 {
 	struct inode *dir = dentry->d_parent->d_inode;
-	const char *name = dentry->d_name.name;
-	int namelen = dentry->d_name.len;
 	unsigned long offset;
-	unsigned short rec_len;
 	struct buffer_head * bh;
-	struct ext3_dir_entry_2 * de, * de1;
+	struct ext3_dir_entry_2 *de;
 	struct super_block * sb;
 	int	retval;
+#ifdef CONFIG_EXT3_INDEX
+	int	dx_fallback=0;
+#endif
+	unsigned blocksize;
+	unsigned nlen, rlen;
+	u32 block, blocks;
 
 	sb = dir->i_sb;
-
-	if (!namelen)
+	blocksize = sb->s_blocksize;
+	if (!dentry->d_name.len)
 		return -EINVAL;
-	bh = ext3_bread (handle, dir, 0, 0, &retval);
+#ifdef CONFIG_EXT3_INDEX
+	if (is_dx(dir)) {
+		retval = ext3_dx_add_entry(handle, dentry, inode);
+		if (!retval || (retval != ERR_BAD_DX_DIR))
+			return retval;
+		EXT3_I(dir)->i_flags &= ~EXT3_INDEX_FL;
+		dx_fallback++;
+		ext3_mark_inode_dirty(handle, dir);
+	}
+#endif
+	blocks = dir->i_size >> sb->s_blocksize_bits;
+	for (block = 0, offset = 0; block < blocks; block++) {
+		bh = ext3_bread(handle, dir, block, 0, &retval);
+		if(!bh)
+			return retval;
+		retval = add_dirent_to_buf(handle, dentry, inode, 0, bh);
+		if (retval != -ENOSPC)
+			return retval;
+
+#ifdef CONFIG_EXT3_INDEX
+		if (blocks == 1 && !dx_fallback &&
+		    EXT3_HAS_COMPAT_FEATURE(sb, EXT3_FEATURE_COMPAT_DIR_INDEX))
+			return make_indexed_dir(handle, dentry, inode, bh);
+#endif
+		brelse(bh);
+	}
+	bh = ext3_append(handle, dir, &block, &retval);
 	if (!bh)
 		return retval;
-	rec_len = EXT3_DIR_REC_LEN(namelen);
-	offset = 0;
 	de = (struct ext3_dir_entry_2 *) bh->b_data;
-	while (1) {
-		if ((char *)de >= sb->s_blocksize + bh->b_data) {
-			brelse (bh);
-			bh = NULL;
-			bh = ext3_bread (handle, dir,
-				offset >> EXT3_BLOCK_SIZE_BITS(sb), 1, &retval);
-			if (!bh)
-				return retval;
-			if (dir->i_size <= offset) {
-				if (dir->i_size == 0) {
-					brelse(bh);
-					return -ENOENT;
-				}
+	de->inode = 0;
+	de->rec_len = cpu_to_le16(rlen = blocksize);
+	nlen = 0;
+	return add_dirent_to_buf(handle, dentry, inode, de, bh);
+}
 
-				ext3_debug ("creating next block\n");
+#ifdef CONFIG_EXT3_INDEX
+/*
+ * Returns 0 for success, or a negative error value
+ */
+static int ext3_dx_add_entry(handle_t *handle, struct dentry *dentry,
+			     struct inode *inode)
+{
+	struct dx_frame frames[2], *frame;
+	struct dx_entry *entries, *at;
+	struct dx_hash_info hinfo;
+	struct buffer_head * bh;
+	struct inode *dir = dentry->d_parent->d_inode;
+	struct super_block * sb = dir->i_sb;
+	struct ext3_dir_entry_2 *de;
+	int err;
 
-				BUFFER_TRACE(bh, "get_write_access");
-				ext3_journal_get_write_access(handle, bh);
-				de = (struct ext3_dir_entry_2 *) bh->b_data;
-				de->inode = 0;
-				de->rec_len = le16_to_cpu(sb->s_blocksize);
-				dir->u.ext3_i.i_disksize =
-					dir->i_size = offset + sb->s_blocksize;
-				dir->u.ext3_i.i_flags &= ~EXT3_INDEX_FL;
-				ext3_mark_inode_dirty(handle, dir);
-			} else {
+	frame = dx_probe(dentry, 0, &hinfo, frames, &err);
+	if (!frame)
+		return err;
+	entries = frame->entries;
+	at = frame->at;
 
-				ext3_debug ("skipping to next block\n");
+	if (!(bh = ext3_bread(handle,dir, dx_get_block(frame->at), 0, &err)))
+		goto cleanup;
 
-				de = (struct ext3_dir_entry_2 *) bh->b_data;
-			}
-		}
-		if (!ext3_check_dir_entry ("ext3_add_entry", dir, de, bh,
-					   offset)) {
-			brelse (bh);
-			return -ENOENT;
-		}
-		if (ext3_match (namelen, name, de)) {
-				brelse (bh);
-				return -EEXIST;
+	BUFFER_TRACE(bh, "get_write_access");
+	err = ext3_journal_get_write_access(handle, bh);
+	if (err)
+		goto journal_error;
+
+	err = add_dirent_to_buf(handle, dentry, inode, 0, bh);
+	if (err != -ENOSPC) {
+		bh = 0;
+		goto cleanup;
+	}
+
+	/* Block full, should compress but for now just split */
+	dxtrace(printk("using %u of %u node entries\n",
+		       dx_get_count(entries), dx_get_limit(entries)));
+	/* Need to split index? */
+	if (dx_get_count(entries) == dx_get_limit(entries)) {
+		u32 newblock;
+		unsigned icount = dx_get_count(entries);
+		int levels = frame - frames;
+		struct dx_entry *entries2;
+		struct dx_node *node2;
+		struct buffer_head *bh2;
+
+		if (levels && (dx_get_count(frames->entries) ==
+			       dx_get_limit(frames->entries))) {
+			ext3_warning(sb, __FUNCTION__,
+				     "Directory index full!\n");
+			err = -ENOSPC;
+			goto cleanup;
 		}
-		if ((le32_to_cpu(de->inode) == 0 &&
-				le16_to_cpu(de->rec_len) >= rec_len) ||
-		    (le16_to_cpu(de->rec_len) >=
-				EXT3_DIR_REC_LEN(de->name_len) + rec_len)) {
-			BUFFER_TRACE(bh, "get_write_access");
-			ext3_journal_get_write_access(handle, bh);
-			/* By now the buffer is marked for journaling */
-			offset += le16_to_cpu(de->rec_len);
-			if (le32_to_cpu(de->inode)) {
-				de1 = (struct ext3_dir_entry_2 *) ((char *) de +
-					EXT3_DIR_REC_LEN(de->name_len));
-				de1->rec_len =
-					cpu_to_le16(le16_to_cpu(de->rec_len) -
-					EXT3_DIR_REC_LEN(de->name_len));
-				de->rec_len = cpu_to_le16(
-						EXT3_DIR_REC_LEN(de->name_len));
-				de = de1;
+		bh2 = ext3_append (handle, dir, &newblock, &err);
+		if (!(bh2))
+			goto cleanup;
+		node2 = (struct dx_node *)(bh2->b_data);
+		entries2 = node2->entries;
+		node2->fake.rec_len = cpu_to_le16(sb->s_blocksize);
+		node2->fake.inode = 0;
+		BUFFER_TRACE(frame->bh, "get_write_access");
+		err = ext3_journal_get_write_access(handle, frame->bh);
+		if (err)
+			goto journal_error;
+		if (levels) {
+			unsigned icount1 = icount/2, icount2 = icount - icount1;
+			unsigned hash2 = dx_get_hash(entries + icount1);
+			dxtrace(printk("Split index %i/%i\n", icount1, icount2));
+				
+			BUFFER_TRACE(frame->bh, "get_write_access"); /* index root */
+			err = ext3_journal_get_write_access(handle,
+							     frames[0].bh);
+			if (err)
+				goto journal_error;
+				
+			memcpy ((char *) entries2, (char *) (entries + icount1),
+				icount2 * sizeof(struct dx_entry));
+			dx_set_count (entries, icount1);
+			dx_set_count (entries2, icount2);
+			dx_set_limit (entries2, dx_node_limit(dir));
+
+			/* Which index block gets the new entry? */
+			if (at - entries >= icount1) {
+				frame->at = at = at - entries - icount1 + entries2;
+				frame->entries = entries = entries2;
+				swap(frame->bh, bh2);
 			}
-			de->file_type = EXT3_FT_UNKNOWN;
-			if (inode) {
-				de->inode = cpu_to_le32(inode->i_ino);
-				ext3_set_de_type(dir->i_sb, de, inode->i_mode);
-			} else
-				de->inode = 0;
-			de->name_len = namelen;
-			memcpy (de->name, name, namelen);
-			/*
-			 * XXX shouldn't update any times until successful
-			 * completion of syscall, but too many callers depend
-			 * on this.
-			 *
-			 * XXX similarly, too many callers depend on
-			 * ext3_new_inode() setting the times, but error
-			 * recovery deletes the inode, so the worst that can
-			 * happen is that the times are slightly out of date
-			 * and/or different from the directory change time.
-			 */
-			dir->i_mtime = dir->i_ctime = CURRENT_TIME;
-			dir->u.ext3_i.i_flags &= ~EXT3_INDEX_FL;
-			dir->i_version = ++event;
-			ext3_mark_inode_dirty(handle, dir);
-			BUFFER_TRACE(bh, "call ext3_journal_dirty_metadata");
-			ext3_journal_dirty_metadata(handle, bh);
-			brelse(bh);
-			return 0;
+			dx_insert_block (frames + 0, hash2, newblock);
+			dxtrace(dx_show_index ("node", frames[1].entries));
+			dxtrace(dx_show_index ("node",
+			       ((struct dx_node *) bh2->b_data)->entries));
+			err = ext3_journal_dirty_metadata(handle, bh2);
+			if (err)
+				goto journal_error;
+			brelse (bh2);
+		} else {
+			dxtrace(printk("Creating second level index...\n"));
+			memcpy((char *) entries2, (char *) entries,
+			       icount * sizeof(struct dx_entry));
+			dx_set_limit(entries2, dx_node_limit(dir));
+
+			/* Set up root */
+			dx_set_count(entries, 1);
+			dx_set_block(entries + 0, newblock);
+			((struct dx_root *) frames[0].bh->b_data)->info.indirect_levels = 1;
+
+			/* Add new access path frame */
+			frame = frames + 1;
+			frame->at = at = at - entries + entries2;
+			frame->entries = entries = entries2;
+			frame->bh = bh2;
+			err = ext3_journal_get_write_access(handle,
+							     frame->bh);
+			if (err)
+				goto journal_error;
 		}
-		offset += le16_to_cpu(de->rec_len);
-		de = (struct ext3_dir_entry_2 *)
-			((char *) de + le16_to_cpu(de->rec_len));
+		ext3_journal_dirty_metadata(handle, frames[0].bh);
 	}
-	brelse (bh);
-	return -ENOSPC;
+	de = do_split(handle, dir, &bh, frame, &hinfo, &err);
+	if (!de)
+		goto cleanup;
+	err = add_dirent_to_buf(handle, dentry, inode, de, bh);
+	bh = 0;
+	goto cleanup;
+	
+journal_error:
+	ext3_std_error(dir->i_sb, err);
+cleanup:
+	if (bh)
+		brelse(bh);
+	dx_release(frames);
+	return err;
 }
+#endif
 
 /*
  * ext3_delete_entry deletes a directory entry by merging it with the
@@ -454,9 +1596,11 @@
 	struct inode * inode;
 	int err;
 
-	handle = ext3_journal_start(dir, EXT3_DATA_TRANS_BLOCKS + 3);
-	if (IS_ERR(handle))
+	handle = ext3_journal_start(dir, EXT3_DATA_TRANS_BLOCKS +
+					EXT3_INDEX_EXTRA_TRANS_BLOCKS + 3);
+	if (IS_ERR(handle)) {
 		return PTR_ERR(handle);
+	}
 
 	if (IS_SYNC(dir))
 		handle->h_sync = 1;
@@ -480,9 +1624,11 @@
 	struct inode *inode;
 	int err;
 
-	handle = ext3_journal_start(dir, EXT3_DATA_TRANS_BLOCKS + 3);
-	if (IS_ERR(handle))
+	handle = ext3_journal_start(dir, EXT3_DATA_TRANS_BLOCKS +
+			 		EXT3_INDEX_EXTRA_TRANS_BLOCKS + 3);
+	if (IS_ERR(handle)) {
 		return PTR_ERR(handle);
+	}
 
 	if (IS_SYNC(dir))
 		handle->h_sync = 1;
@@ -508,9 +1654,11 @@
 	if (dir->i_nlink >= EXT3_LINK_MAX)
 		return -EMLINK;
 
-	handle = ext3_journal_start(dir, EXT3_DATA_TRANS_BLOCKS + 3);
-	if (IS_ERR(handle))
+	handle = ext3_journal_start(dir, EXT3_DATA_TRANS_BLOCKS +
+					EXT3_INDEX_EXTRA_TRANS_BLOCKS + 3);
+	if (IS_ERR(handle)) {
 		return PTR_ERR(handle);
+	}
 
 	if (IS_SYNC(dir))
 		handle->h_sync = 1;
@@ -522,7 +1670,7 @@
 
 	inode->i_op = &ext3_dir_inode_operations;
 	inode->i_fop = &ext3_dir_operations;
-	inode->i_size = inode->u.ext3_i.i_disksize = inode->i_sb->s_blocksize;
+	inode->i_size = EXT3_I(inode)->i_disksize = inode->i_sb->s_blocksize;
 	inode->i_blocks = 0;	
 	dir_block = ext3_bread (handle, inode, 0, 1, &err);
 	if (!dir_block) {
@@ -555,21 +1703,19 @@
 		inode->i_mode |= S_ISGID;
 	ext3_mark_inode_dirty(handle, inode);
 	err = ext3_add_entry (handle, dentry, inode);
-	if (err)
-		goto out_no_entry;
+	if (err) {
+		inode->i_nlink = 0;
+		ext3_mark_inode_dirty(handle, inode);
+		iput (inode);
+		goto out_stop;
+	}
 	dir->i_nlink++;
-	dir->u.ext3_i.i_flags &= ~EXT3_INDEX_FL;
+	ext3_update_dx_flag(dir);
 	ext3_mark_inode_dirty(handle, dir);
 	d_instantiate(dentry, inode);
 out_stop:
 	ext3_journal_stop(handle, dir);
 	return err;
-
-out_no_entry:
-	inode->i_nlink = 0;
-	ext3_mark_inode_dirty(handle, inode);
-	iput (inode);
-	goto out_stop;
 }
 
 /*
@@ -656,7 +1802,7 @@
 	int err = 0, rc;
 	
 	lock_super(sb);
-	if (!list_empty(&inode->u.ext3_i.i_orphan))
+	if (!list_empty(&EXT3_I(inode)->i_orphan))
 		goto out_unlock;
 
 	/* Orphan handling is only valid for files with data blocks
@@ -697,7 +1843,7 @@
 	 * This is safe: on error we're going to ignore the orphan list
 	 * anyway on the next recovery. */
 	if (!err)
-		list_add(&inode->u.ext3_i.i_orphan, &EXT3_SB(sb)->s_orphan);
+		list_add(&EXT3_I(inode)->i_orphan, &EXT3_SB(sb)->s_orphan);
 
 	jbd_debug(4, "superblock will point to %ld\n", inode->i_ino);
 	jbd_debug(4, "orphan inode %ld will point to %d\n",
@@ -715,25 +1861,26 @@
 int ext3_orphan_del(handle_t *handle, struct inode *inode)
 {
 	struct list_head *prev;
+	struct ext3_inode_info *ei = EXT3_I(inode);
 	struct ext3_sb_info *sbi;
 	unsigned long ino_next;
 	struct ext3_iloc iloc;
 	int err = 0;
 
 	lock_super(inode->i_sb);
-	if (list_empty(&inode->u.ext3_i.i_orphan)) {
+	if (list_empty(&ei->i_orphan)) {
 		unlock_super(inode->i_sb);
 		return 0;
 	}
 
 	ino_next = NEXT_ORPHAN(inode);
-	prev = inode->u.ext3_i.i_orphan.prev;
+	prev = ei->i_orphan.prev;
 	sbi = EXT3_SB(inode->i_sb);
 
 	jbd_debug(4, "remove inode %lu from orphan list\n", inode->i_ino);
 
-	list_del(&inode->u.ext3_i.i_orphan);
-	INIT_LIST_HEAD(&inode->u.ext3_i.i_orphan);
+	list_del(&ei->i_orphan);
+	INIT_LIST_HEAD(&ei->i_orphan);
 
 	/* If we're on an error path, we may not have a valid
 	 * transaction handle with which to update the orphan list on
@@ -794,8 +1941,9 @@
 	handle_t *handle;
 
 	handle = ext3_journal_start(dir, EXT3_DELETE_TRANS_BLOCKS);
-	if (IS_ERR(handle))
+	if (IS_ERR(handle)) {
 		return PTR_ERR(handle);
+	}
 
 	retval = -ENOENT;
 	bh = ext3_find_entry (dentry, &de);
@@ -830,10 +1978,10 @@
 	 * recovery. */
 	inode->i_size = 0;
 	ext3_orphan_add(handle, inode);
-	dir->i_nlink--;
 	inode->i_ctime = dir->i_ctime = dir->i_mtime = CURRENT_TIME;
+	dir->i_nlink--;
 	ext3_mark_inode_dirty(handle, inode);
-	dir->u.ext3_i.i_flags &= ~EXT3_INDEX_FL;
+	ext3_update_dx_flag(dir);
 	ext3_mark_inode_dirty(handle, dir);
 
 end_rmdir:
@@ -851,8 +1999,9 @@
 	handle_t *handle;
 
 	handle = ext3_journal_start(dir, EXT3_DELETE_TRANS_BLOCKS);
-	if (IS_ERR(handle))
+	if (IS_ERR(handle)) {
 		return PTR_ERR(handle);
+	}
 
 	if (IS_SYNC(dir))
 		handle->h_sync = 1;
@@ -879,7 +2028,7 @@
 	if (retval)
 		goto end_unlink;
 	dir->i_ctime = dir->i_mtime = CURRENT_TIME;
-	dir->u.ext3_i.i_flags &= ~EXT3_INDEX_FL;
+	ext3_update_dx_flag(dir);
 	ext3_mark_inode_dirty(handle, dir);
 	inode->i_nlink--;
 	if (!inode->i_nlink)
@@ -905,9 +2054,11 @@
 	if (l > dir->i_sb->s_blocksize)
 		return -ENAMETOOLONG;
 
-	handle = ext3_journal_start(dir, EXT3_DATA_TRANS_BLOCKS + 5);
-	if (IS_ERR(handle))
+	handle = ext3_journal_start(dir, EXT3_DATA_TRANS_BLOCKS +
+			 		EXT3_INDEX_EXTRA_TRANS_BLOCKS + 5);
+	if (IS_ERR(handle)) {
 		return PTR_ERR(handle);
+	}
 
 	if (IS_SYNC(dir))
 		handle->h_sync = 1;
@@ -917,7 +2068,7 @@
 	if (IS_ERR(inode))
 		goto out_stop;
 
-	if (l > sizeof (inode->u.ext3_i.i_data)) {
+	if (l > sizeof (EXT3_I(inode)->i_data)) {
 		inode->i_op = &page_symlink_inode_operations;
 		inode->i_mapping->a_ops = &ext3_aops;
 		/*
@@ -926,24 +2077,22 @@
 		 * i_size in generic_commit_write().
 		 */
 		err = block_symlink(inode, symname, l);
-		if (err)
-			goto out_no_entry;
+		if (err) {
+			ext3_dec_count(handle, inode);
+			ext3_mark_inode_dirty(handle, inode);
+			iput (inode);
+			goto out_stop;
+		}
 	} else {
 		inode->i_op = &ext3_fast_symlink_inode_operations;
-		memcpy((char*)&inode->u.ext3_i.i_data,symname,l);
+		memcpy((char*)&EXT3_I(inode)->i_data,symname,l);
 		inode->i_size = l-1;
 	}
-	inode->u.ext3_i.i_disksize = inode->i_size;
+	EXT3_I(inode)->i_disksize = inode->i_size;
 	err = ext3_add_nondir(handle, dentry, inode);
 out_stop:
 	ext3_journal_stop(handle, dir);
 	return err;
-
-out_no_entry:
-	ext3_dec_count(handle, inode);
-	ext3_mark_inode_dirty(handle, inode);
-	iput (inode);
-	goto out_stop;
 }
 
 static int ext3_link (struct dentry * old_dentry,
@@ -956,12 +2105,15 @@
 	if (S_ISDIR(inode->i_mode))
 		return -EPERM;
 
-	if (inode->i_nlink >= EXT3_LINK_MAX)
+	if (inode->i_nlink >= EXT3_LINK_MAX) {
 		return -EMLINK;
+	}
 
-	handle = ext3_journal_start(dir, EXT3_DATA_TRANS_BLOCKS);
-	if (IS_ERR(handle))
+	handle = ext3_journal_start(dir, EXT3_DATA_TRANS_BLOCKS +
+					EXT3_INDEX_EXTRA_TRANS_BLOCKS);
+	if (IS_ERR(handle)) {
 		return PTR_ERR(handle);
+	}
 
 	if (IS_SYNC(dir))
 		handle->h_sync = 1;
@@ -994,9 +2146,11 @@
 
 	old_bh = new_bh = dir_bh = NULL;
 
-	handle = ext3_journal_start(old_dir, 2 * EXT3_DATA_TRANS_BLOCKS + 2);
-	if (IS_ERR(handle))
+	handle = ext3_journal_start(old_dir, 2 * EXT3_DATA_TRANS_BLOCKS +
+			 		EXT3_INDEX_EXTRA_TRANS_BLOCKS + 2);
+	if (IS_ERR(handle)) {
 		return PTR_ERR(handle);
+	}
 
 	if (IS_SYNC(old_dir) || IS_SYNC(new_dir))
 		handle->h_sync = 1;
@@ -1046,7 +2200,6 @@
 			goto end_rename;
 	} else {
 		BUFFER_TRACE(new_bh, "get write access");
-		BUFFER_TRACE(new_bh, "get_write_access");
 		ext3_journal_get_write_access(handle, new_bh);
 		new_de->inode = le32_to_cpu(old_inode->i_ino);
 		if (EXT3_HAS_INCOMPAT_FEATURE(new_dir->i_sb,
@@ -1069,14 +2222,33 @@
 	/*
 	 * ok, that's it
 	 */
-	ext3_delete_entry(handle, old_dir, old_de, old_bh);
+	retval = ext3_delete_entry(handle, old_dir, old_de, old_bh);
+	if (retval == -ENOENT) {
+		/*
+		 * old_de could have moved out from under us.
+		 */
+		struct buffer_head *old_bh2;
+		struct ext3_dir_entry_2 *old_de2;
+		
+		old_bh2 = ext3_find_entry(old_dentry, &old_de2);
+		if (old_bh2) {
+			retval = ext3_delete_entry(handle, old_dir,
+						   old_de2, old_bh2);
+			brelse(old_bh2);
+		}
+	}
+	if (retval) {
+		ext3_warning(old_dir->i_sb, "ext3_rename",
+				"Deleting old file (%lu), %d, error=%d",
+				old_dir->i_ino, old_dir->i_nlink, retval);
+	}
 
 	if (new_inode) {
 		new_inode->i_nlink--;
 		new_inode->i_ctime = CURRENT_TIME;
 	}
 	old_dir->i_ctime = old_dir->i_mtime = CURRENT_TIME;
-	old_dir->u.ext3_i.i_flags &= ~EXT3_INDEX_FL;
+	ext3_update_dx_flag(old_dir);
 	if (dir_bh) {
 		BUFFER_TRACE(dir_bh, "get_write_access");
 		ext3_journal_get_write_access(handle, dir_bh);
@@ -1088,7 +2260,7 @@
 			new_inode->i_nlink--;
 		} else {
 			new_dir->i_nlink++;
-			new_dir->u.ext3_i.i_flags &= ~EXT3_INDEX_FL;
+			ext3_update_dx_flag(new_dir);
 			ext3_mark_inode_dirty(handle, new_dir);
 		}
 	}
diff -Nru a/fs/ext3/super.c b/fs/ext3/super.c
--- a/fs/ext3/super.c	Thu Jan  1 16:29:25 2004
+++ b/fs/ext3/super.c	Thu Jan  1 16:29:25 2004
@@ -712,6 +712,7 @@
 	es->s_mtime = cpu_to_le32(CURRENT_TIME);
 	ext3_update_dynamic_rev(sb);
 	EXT3_SET_INCOMPAT_FEATURE(sb, EXT3_FEATURE_INCOMPAT_RECOVER);
+
 	ext3_commit_super (sb, es, 1);
 	if (test_opt (sb, DEBUG))
 		printk (KERN_INFO
@@ -722,6 +723,7 @@
 			EXT3_BLOCKS_PER_GROUP(sb),
 			EXT3_INODES_PER_GROUP(sb),
 			sbi->s_mount_opt);
+
 	printk(KERN_INFO "EXT3 FS " EXT3FS_VERSION ", " EXT3FS_DATE " on %s, ",
 				bdevname(sb->s_dev));
 	if (EXT3_SB(sb)->s_journal->j_inode == NULL) {
@@ -915,6 +917,7 @@
 	return res;
 }
 
+
 struct super_block * ext3_read_super (struct super_block * sb, void * data,
 				      int silent)
 {
@@ -1094,6 +1097,9 @@
 	sbi->s_mount_state = le16_to_cpu(es->s_state);
 	sbi->s_addr_per_block_bits = log2(EXT3_ADDR_PER_BLOCK(sb));
 	sbi->s_desc_per_block_bits = log2(EXT3_DESC_PER_BLOCK(sb));
+	for (i=0; i < 4; i++)
+		sbi->s_hash_seed[i] = le32_to_cpu(es->s_hash_seed[i]);
+	sbi->s_def_hash_version = es->s_def_hash_version;
 
 	if (sbi->s_blocks_per_group > blocksize * 8) {
 		printk (KERN_ERR
diff -Nru a/include/linux/ext2_fs_i.h b/include/linux/ext2_fs_i.h
--- a/include/linux/ext2_fs_i.h	Thu Jan  1 16:29:25 2004
+++ b/include/linux/ext2_fs_i.h	Thu Jan  1 16:29:25 2004
@@ -29,8 +29,30 @@
 	__u32	i_file_acl;
 	__u32	i_dir_acl;
 	__u32	i_dtime;
+ 
+ 	/*
+ 	 * i_block_group is the number of the block group which contains
+ 	 * this file's inode.  Constant across the lifetime of the inode,
+ 	 * it is ued for making block allocation decisions - we try to
+ 	 * place a file's data blocks near its inode block, and new inodes
+ 	 * near to their parent directory's inode.
+ 	 */
 	__u32	i_block_group;
+ 
+	/*
+	 * i_next_alloc_block is the logical (file-relative) number of the
+	 * most-recently-allocated block in this file.  Yes, it is misnamed.
+	 * We use this for detecting linearly ascending allocation requests.
+	 */
 	__u32	i_next_alloc_block;
+
+	/*
+	 * i_next_alloc_goal is the *physical* companion to
+	 * i_next_alloc_block.  it the the physical block number of
+	 * the block which was most-recently allocated to this file.
+	 * This give us the goal (target) for the next allocation when
+	 * we detect linearly ascending requests.
+	 */
 	__u32	i_next_alloc_goal;
 	__u32	i_prealloc_block;
 	__u32	i_prealloc_count;
diff -Nru a/include/linux/ext3_fs.h b/include/linux/ext3_fs.h
--- a/include/linux/ext3_fs.h	Thu Jan  1 16:29:25 2004
+++ b/include/linux/ext3_fs.h	Thu Jan  1 16:29:25 2004
@@ -37,7 +37,12 @@
  * The second extended file system version
  */
 #define EXT3FS_DATE		"19 August 2002"
-#define EXT3FS_VERSION		"2.4-0.9.19"
+#define EXT3FS_VERSION		"2.4-0.9.19+htree"
+
+/*
+ * Always enable hashed directories
+ */
+#define CONFIG_EXT3_INDEX
 
 /*
  * Debug code
@@ -593,9 +598,48 @@
 #define EXT3_DIR_ROUND			(EXT3_DIR_PAD - 1)
 #define EXT3_DIR_REC_LEN(name_len)	(((name_len) + 8 + EXT3_DIR_ROUND) & \
 					 ~EXT3_DIR_ROUND)
+/*
+ * Hash Tree Directory indexing
+ * (c) Daniel Phillips, 2001
+ */
+
+#ifdef CONFIG_EXT3_INDEX
+  #define is_dx(dir) (EXT3_HAS_COMPAT_FEATURE(dir->i_sb, \
+					      EXT3_FEATURE_COMPAT_DIR_INDEX) && \
+		      (EXT3_I(dir)->i_flags & EXT3_INDEX_FL))
+#define EXT3_DIR_LINK_MAX(dir) (!is_dx(dir) && (dir)->i_nlink >= EXT3_LINK_MAX)
+#define EXT3_DIR_LINK_EMPTY(dir) ((dir)->i_nlink == 2 || (dir)->i_nlink == 1)
+#else
+  #define is_dx(dir) 0
+#define EXT3_DIR_LINK_MAX(dir) ((dir)->i_nlink >= EXT3_LINK_MAX)
+#define EXT3_DIR_LINK_EMPTY(dir) ((dir)->i_nlink == 2)
+#endif
+
+/* Legal values for the dx_root hash_version field: */
+
+#define DX_HASH_LEGACY		0
+#define DX_HASH_HALF_MD4	1
+#define DX_HASH_TEA		2
+
+/* hash info structure used by the directory hash */
+struct dx_hash_info
+{
+	u32		hash;
+	u32		minor_hash;
+	int		hash_version;
+	u32		*seed;
+};
+
+#define EXT3_HTREE_EOF	0x7fffffff
 
 #ifdef __KERNEL__
 /*
+ * Control parameters used by ext3_htree_next_block
+ */
+#define HASH_NB_ALWAYS		1
+
+
+/*
  * Describe an inode's exact location on disk and in memory
  */
 struct ext3_iloc
@@ -605,6 +649,27 @@
 	unsigned long block_group;
 };
 
+
+/*
+ * This structure is stuffed into the struct file's private_data field
+ * for directories.  It is where we put information so that we can do
+ * readdir operations in hash tree order.
+ */
+struct dir_private_info {
+	rb_root_t	root;
+	rb_node_t	*curr_node;
+	struct fname	*extra_fname;
+	loff_t		last_pos;
+	__u32		curr_hash;
+	__u32		curr_minor_hash;
+	__u32		next_hash;
+};
+
+/*
+ * Special error return code only used by dx_probe() and its callers.
+ */
+#define ERR_BAD_DX_DIR	-75000
+
 /*
  * Function prototypes
  */
@@ -632,11 +697,20 @@
 
 /* dir.c */
 extern int ext3_check_dir_entry(const char *, struct inode *,
-				struct ext3_dir_entry_2 *, struct buffer_head *,
-				unsigned long);
+				struct ext3_dir_entry_2 *,
+				struct buffer_head *, unsigned long);
+extern int ext3_htree_store_dirent(struct file *dir_file, __u32 hash,
+				    __u32 minor_hash,
+				    struct ext3_dir_entry_2 *dirent);
+extern void ext3_htree_free_dir_info(struct dir_private_info *p);
+
 /* fsync.c */
 extern int ext3_sync_file (struct file *, struct dentry *, int);
 
+/* hash.c */
+extern int ext3fs_dirhash(const char *name, int len, struct
+			  dx_hash_info *hinfo);
+
 /* ialloc.c */
 extern struct inode * ext3_new_inode (handle_t *, const struct inode *, int);
 extern void ext3_free_inode (handle_t *, struct inode *);
@@ -669,6 +743,8 @@
 /* namei.c */
 extern int ext3_orphan_add(handle_t *, struct inode *);
 extern int ext3_orphan_del(handle_t *, struct inode *);
+extern int ext3_htree_fill_tree(struct file *dir_file, __u32 start_hash,
+				__u32 start_minor_hash, __u32 *next_hash);
 
 /* super.c */
 extern void ext3_error (struct super_block *, const char *, const char *, ...)
diff -Nru a/include/linux/ext3_fs_i.h b/include/linux/ext3_fs_i.h
--- a/include/linux/ext3_fs_i.h	Thu Jan  1 16:29:25 2004
+++ b/include/linux/ext3_fs_i.h	Thu Jan  1 16:29:25 2004
@@ -33,9 +33,30 @@
 	__u32	i_file_acl;
 	__u32	i_dir_acl;
 	__u32	i_dtime;
+
+	/*
+	 * i_block_group is the number of the block group which contains
+	 * this file's inode.  Constant across the lifetime of the inode,
+	 * it is ued for making block allocation decisions - we try to
+	 * place a file's data blocks near its inode block, and new inodes
+	 * near to their parent directory's inode.
+	 */
 	__u32	i_block_group;
 	__u32	i_state;		/* Dynamic state flags for ext3 */
+
+	/*
+	 * i_next_alloc_block is the logical (file-relative) number of the
+	 * most-recently-allocated block in this file.  Yes, it is misnamed.
+	 * We use this for detecting linearly ascending allocation requests.
+	 */
 	__u32	i_next_alloc_block;
+
+	/*
+	 * i_next_alloc_goal is the *physical* companion to i_next_alloc_block.
+	 * it the the physical block number of the block which was most-recently
+	 * allocated to this file.  This give us the goal (target) for the next
+	 * allocation when we detect linearly ascending requests.
+	 */
 	__u32	i_next_alloc_goal;
 #ifdef EXT3_PREALLOCATE
 	__u32	i_prealloc_block;
diff -Nru a/include/linux/ext3_fs_sb.h b/include/linux/ext3_fs_sb.h
--- a/include/linux/ext3_fs_sb.h	Thu Jan  1 16:29:25 2004
+++ b/include/linux/ext3_fs_sb.h	Thu Jan  1 16:29:25 2004
@@ -62,6 +62,8 @@
 	int s_inode_size;
 	int s_first_ino;
 	u32 s_next_generation;
+	u32 s_hash_seed[4];
+	int s_def_hash_version;
 
 	/* Journaling */
 	struct inode * s_journal_inode;
diff -Nru a/include/linux/ext3_jbd.h b/include/linux/ext3_jbd.h
--- a/include/linux/ext3_jbd.h	Thu Jan  1 16:29:25 2004
+++ b/include/linux/ext3_jbd.h	Thu Jan  1 16:29:25 2004
@@ -63,6 +63,8 @@
 
 #define EXT3_RESERVE_TRANS_BLOCKS	12U
 
+#define EXT3_INDEX_EXTRA_TRANS_BLOCKS	8
+
 int
 ext3_mark_iloc_dirty(handle_t *handle, 
 		     struct inode *inode,
diff -Nru a/include/linux/rbtree.h b/include/linux/rbtree.h
--- a/include/linux/rbtree.h	Thu Jan  1 16:29:25 2004
+++ b/include/linux/rbtree.h	Thu Jan  1 16:29:25 2004
@@ -120,6 +120,8 @@
 
 extern void rb_insert_color(rb_node_t *, rb_root_t *);
 extern void rb_erase(rb_node_t *, rb_root_t *);
+extern rb_node_t *rb_get_first(rb_root_t *root);
+extern rb_node_t *rb_get_next(rb_node_t *n);
 
 static inline void rb_link_node(rb_node_t * node, rb_node_t * parent, rb_node_t ** rb_link)
 {
diff -Nru a/lib/rbtree.c b/lib/rbtree.c
--- a/lib/rbtree.c	Thu Jan  1 16:29:25 2004
+++ b/lib/rbtree.c	Thu Jan  1 16:29:25 2004
@@ -17,6 +17,8 @@
   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 
   linux/lib/rbtree.c
+
+  rb_get_first and rb_get_next written by Theodore Ts'o, 9/8/2002
 */
 
 #include <linux/rbtree.h>
@@ -294,3 +296,43 @@
 		__rb_erase_color(child, parent, root);
 }
 EXPORT_SYMBOL(rb_erase);
+
+/*
+ * This function returns the first node (in sort order) of the tree.
+ */
+rb_node_t *rb_get_first(rb_root_t *root)
+{
+	rb_node_t	*n;
+
+	n = root->rb_node;
+	if (!n)
+		return 0;
+	while (n->rb_left)
+		n = n->rb_left;
+	return n;
+}
+EXPORT_SYMBOL(rb_get_first);
+
+/*
+ * Given a node, this function will return the next node in the tree.
+ */
+rb_node_t *rb_get_next(rb_node_t *n)
+{
+	rb_node_t	*parent;
+
+	if (n->rb_right) {
+		n = n->rb_right;
+		while (n->rb_left)
+			n = n->rb_left;
+		return n;
+	} else {
+		while ((parent = n->rb_parent)) {
+			if (n == parent->rb_left)
+				return parent;
+			n = parent;
+		}
+		return 0;
+	}
+}
+EXPORT_SYMBOL(rb_get_next);
+
