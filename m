Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266011AbUGIWbk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266011AbUGIWbk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 18:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266013AbUGIWbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 18:31:40 -0400
Received: from moraine.clusterfs.com ([66.246.132.190]:62940 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S266011AbUGIW0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 18:26:30 -0400
Date: Fri, 9 Jul 2004 16:26:25 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: jmerkey@comcast.net
Cc: Andi Kleen <ak@muc.de>, "Stephen C. Tweedie" <sct@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Ext3 File System "Too many files" with snort
Message-ID: <20040709222625.GP23346@schnapps.adilger.int>
Mail-Followup-To: jmerkey@comcast.net, Andi Kleen <ak@muc.de>,
	"Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org
References: <070920041830.21850.40EEE455000BE22E0000555A2200735446970A059D0A0306@comcast.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s9kDAZ2EyO0AcRYa"
Content-Disposition: inline
In-Reply-To: <070920041830.21850.40EEE455000BE22E0000555A2200735446970A059D0A0306@comcast.net>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--s9kDAZ2EyO0AcRYa
Content-Type: multipart/mixed; boundary="kK1uqZGE6pgsGNyR"
Content-Disposition: inline


--kK1uqZGE6pgsGNyR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jul 09, 2004  18:30 +0000, jmerkey@comcast.net wrote:
> > jmerkey@comcast.net writes:
> Sounds like this is correct.    I will look at statfs().  I am very famil=
iar=20
> with this section of linux with the VFS.  We should make this value 32 bi=
t.
> One solution would be to instrument a versioning field in the superblock =
so
> we can write the smarts into ext3/2/reiser to handle different on-disk
> structures.  when a supoerblock gets read, it could detect waht type of=
=20
> on disk structures are instrumented. =20

Hey what a good idea.  Good thing Ted thought about it 10 years ago.
With the htree support (in 2.6, or a patch for 2.4) it handles millions
of _files_ per directory, but because of the i_nlink =3D=3D 16-bit limitati=
on
it was never bumped to handle i_nlink > 32000.  Usually people have lots
of files but fewer subdirectories.

Our current htree patch against 2.4.21 (RHEL 3 -15 kernel) is attached.
It has seen _extensive_ testing.  Stephen, I'd really encourage you to
try and get this into RHEL 4 if you are doing another 2.4 kernel.


The second patch to fix the i_nlink issues (in the same way as reiserfs
does, by ignoring i_nlink > 65536 and set it to 1 so find doesn't break)
has seen basically no testing so success reports are welcome.  It also
fixes a bug so that you can unlink a directory that is having IO errors.
This patch is also relevant for 2.6 (not sure if it applies cleanly).

It might needs a compat flag, because even though older kernels will just
spit a warning about the link count when unlinking such a directory (they=
=20
walk the directory to see if it is free of files), it might be bad if you
mount it with an older kernel, remove a single subdirectory (drops parent
i_nlink to zero) and then do iput() -> parent will be truncated, unlinked.

In 2.4 kernels inode->i_nlink is still an unsigned short even if stat64
has an int so even if we could store more bits for the link in the inode
(in the high byte of i_dir_acl maybe) it wouldn't work in 2.4 without
other kernel changes.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://members.shaw.ca/adilger/             http://members.shaw.ca/golinux/


--kK1uqZGE6pgsGNyR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ext3-htree-2.4.21-chaos.patch"
Content-Transfer-Encoding: quoted-printable

 fs/ext3/Makefile           |    2=20
 fs/ext3/dir.c              |  302 +++++++++
 fs/ext3/file.c             |    3=20
 fs/ext3/hash.c             |  215 ++++++
 fs/ext3/namei.c            | 1421 ++++++++++++++++++++++++++++++++++++++++=
-----
 fs/ext3/super.c            |    7=20
 include/linux/ext3_fs.h    |   85 ++
 include/linux/ext3_fs_sb.h |    2=20
 include/linux/ext3_jbd.h   |    2=20
 include/linux/rbtree.h     |    2=20
 lib/rbtree.c               |   42 +
 11 files changed, 1922 insertions(+), 161 deletions(-)

Index: linux-2.4.21-chaos/fs/ext3/dir.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.4.21-chaos.orig/fs/ext3/dir.c	2002-05-08 01:53:46.000000000 +04=
00
+++ linux-2.4.21-chaos/fs/ext3/dir.c	2003-12-12 16:18:17.000000000 +0300
@@ -21,12 +21,16 @@
 #include <linux/fs.h>
 #include <linux/jbd.h>
 #include <linux/ext3_fs.h>
+#include <linux/slab.h>
+#include <linux/rbtree.h>
=20
 static unsigned char ext3_filetype_table[] =3D {
 	DT_UNKNOWN, DT_REG, DT_DIR, DT_CHR, DT_BLK, DT_FIFO, DT_SOCK, DT_LNK
 };
=20
 static int ext3_readdir(struct file *, void *, filldir_t);
+static int ext3_dx_readdir(struct file * filp,
+			   void * dirent, filldir_t filldir);
=20
 struct file_operations ext3_dir_operations =3D {
 	read:		generic_read_dir,
@@ -35,6 +39,17 @@
 	fsync:		ext3_sync_file,		/* BKL held */
 };
=20
+
+static unsigned char get_dtype(struct super_block *sb, int filetype)
+{
+	if (!EXT3_HAS_INCOMPAT_FEATURE(sb, EXT3_FEATURE_INCOMPAT_FILETYPE) ||
+	    (filetype >=3D EXT3_FT_MAX))
+		return DT_UNKNOWN;
+
+	return (ext3_filetype_table[filetype]);
+}
+			      =20
+
 int ext3_check_dir_entry (const char * function, struct inode * dir,
 			  struct ext3_dir_entry_2 * de,
 			  struct buffer_head * bh,
@@ -79,6 +94,16 @@
=20
 	sb =3D inode->i_sb;
=20
+	if (is_dx(inode)) {
+		err =3D ext3_dx_readdir(filp, dirent, filldir);
+		if (err !=3D ERR_BAD_DX_DIR)
+			return err;
+		/*
+		 * We don't set the inode dirty flag since it's not
+		 * critical that it get flushed back to the disk.
+		 */
+		EXT3_I(filp->f_dentry->d_inode)->i_flags &=3D ~EXT3_INDEX_FL;
+	}
 	stored =3D 0;
 	bh =3D NULL;
 	offset =3D filp->f_pos & (sb->s_blocksize - 1);
@@ -162,18 +187,12 @@
 				 * during the copy operation.
 				 */
 				unsigned long version =3D filp->f_version;
-				unsigned char d_type =3D DT_UNKNOWN;
=20
-				if (EXT3_HAS_INCOMPAT_FEATURE(sb,
-						EXT3_FEATURE_INCOMPAT_FILETYPE)
-						&& de->file_type < EXT3_FT_MAX)
-					d_type =3D
-					  ext3_filetype_table[de->file_type];
 				error =3D filldir(dirent, de->name,
 						de->name_len,
 						filp->f_pos,
 						le32_to_cpu(de->inode),
-						d_type);
+						get_dtype(sb, de->file_type));
 				if (error)
 					break;
 				if (version !=3D filp->f_version)
@@ -188,3 +207,272 @@
 	UPDATE_ATIME(inode);
 	return 0;
 }
+
+#ifdef CONFIG_EXT3_INDEX
+/*
+ * These functions convert from the major/minor hash to an f_pos
+ * value.
+ *=20
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
+	rb_node_t	rb_hash;=20
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
+	rb_node_t	*n =3D root->rb_node;
+	rb_node_t	*parent;
+	struct fname	*fname;
+
+	while (n) {
+		/* Do the node's children first */
+		if ((n)->rb_left) {
+			n =3D n->rb_left;
+			continue;
+		}
+		if (n->rb_right) {
+			n =3D n->rb_right;
+			continue;
+		}
+		/*
+		 * The node has no children; free it, and then zero
+		 * out parent's link to it.  Finally go to the
+		 * beginning of the loop and try to free the parent
+		 * node.
+		 */
+		parent =3D n->rb_parent;
+		fname =3D rb_entry(n, struct fname, rb_hash);
+		kfree(fname);
+		if (!parent)
+			root->rb_node =3D 0;
+		else if (parent->rb_left =3D=3D n)
+			parent->rb_left =3D 0;
+		else if (parent->rb_right =3D=3D n)
+			parent->rb_right =3D 0;
+		n =3D parent;
+	}
+	root->rb_node =3D 0;
+}
+
+
+struct dir_private_info *create_dir_info(loff_t pos)
+{
+	struct dir_private_info *p;
+
+	p =3D kmalloc(sizeof(struct dir_private_info), GFP_KERNEL);
+	if (!p)
+		return NULL;
+	p->root.rb_node =3D 0;
+	p->curr_node =3D 0;
+	p->extra_fname =3D 0;
+	p->last_pos =3D 0;
+	p->curr_hash =3D pos2maj_hash(pos);
+	p->curr_minor_hash =3D pos2min_hash(pos);
+	p->next_hash =3D 0;
+	return p;
+}
+
+void ext3_htree_free_dir_info(struct dir_private_info *p)
+{
+	free_rb_tree_fname(&p->root);
+	kfree(p);
+}
+	=09
+/*
+ * Given a directory entry, enter it into the fname rb tree.
+ */
+int ext3_htree_store_dirent(struct file *dir_file, __u32 hash,
+			     __u32 minor_hash,
+			     struct ext3_dir_entry_2 *dirent)
+{
+	rb_node_t **p, *parent =3D NULL;
+	struct fname * fname, *new_fn;
+	struct dir_private_info *info;
+	int len;
+
+	info =3D (struct dir_private_info *) dir_file->private_data;
+	p =3D &info->root.rb_node;
+
+	/* Create and allocate the fname structure */
+	len =3D sizeof(struct fname) + dirent->name_len + 1;
+	new_fn =3D kmalloc(len, GFP_KERNEL);
+	if (!new_fn)
+		return -ENOMEM;
+	memset(new_fn, 0, len);
+	new_fn->hash =3D hash;
+	new_fn->minor_hash =3D minor_hash;
+	new_fn->inode =3D le32_to_cpu(dirent->inode);
+	new_fn->name_len =3D dirent->name_len;
+	new_fn->file_type =3D dirent->file_type;
+	memcpy(new_fn->name, dirent->name, dirent->name_len);
+	new_fn->name[dirent->name_len] =3D 0;
+=09
+	while (*p) {
+		parent =3D *p;
+		fname =3D rb_entry(parent, struct fname, rb_hash);
+
+		/*
+		 * If the hash and minor hash match up, then we put
+		 * them on a linked list.  This rarely happens...
+		 */
+		if ((new_fn->hash =3D=3D fname->hash) &&
+		    (new_fn->minor_hash =3D=3D fname->minor_hash)) {
+			new_fn->next =3D fname->next;
+			fname->next =3D new_fn;
+			return 0;
+		}
+		=09
+		if (new_fn->hash < fname->hash)
+			p =3D &(*p)->rb_left;
+		else if (new_fn->hash > fname->hash)
+			p =3D &(*p)->rb_right;
+		else if (new_fn->minor_hash < fname->minor_hash)
+			p =3D &(*p)->rb_left;
+		else /* if (new_fn->minor_hash > fname->minor_hash) */
+			p =3D &(*p)->rb_right;
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
+	struct dir_private_info *info =3D filp->private_data;
+	loff_t	curr_pos;
+	struct inode *inode =3D filp->f_dentry->d_inode;
+	struct super_block * sb;
+	int error;
+
+	sb =3D inode->i_sb;
+=09
+	if (!fname) {
+		printk("call_filldir: called with null fname?!?\n");
+		return 0;
+	}
+	curr_pos =3D hash2pos(fname->hash, fname->minor_hash);
+	while (fname) {
+		error =3D filldir(dirent, fname->name,
+				fname->name_len, curr_pos,=20
+				fname->inode,
+				get_dtype(sb, fname->file_type));
+		if (error) {
+			filp->f_pos =3D curr_pos;
+			info->extra_fname =3D fname->next;
+			return error;
+		}
+		fname =3D fname->next;
+	}
+	return 0;
+}
+
+static int ext3_dx_readdir(struct file * filp,
+			 void * dirent, filldir_t filldir)
+{
+	struct dir_private_info *info =3D filp->private_data;
+	struct inode *inode =3D filp->f_dentry->d_inode;
+	struct fname *fname;
+	int	ret;
+
+	if (!info) {
+		info =3D create_dir_info(filp->f_pos);
+		if (!info)
+			return -ENOMEM;
+		filp->private_data =3D info;
+	}
+
+	/* Some one has messed with f_pos; reset the world */
+	if (info->last_pos !=3D filp->f_pos) {
+		free_rb_tree_fname(&info->root);
+		info->curr_node =3D 0;
+		info->extra_fname =3D 0;
+		info->curr_hash =3D pos2maj_hash(filp->f_pos);
+		info->curr_minor_hash =3D pos2min_hash(filp->f_pos);
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
+		info->curr_node =3D rb_get_first(&info->root);
+
+	while (1) {
+		/*
+		 * Fill the rbtree if we have no more entries,
+		 * or the inode has changed since we last read in the
+		 * cached entries.=20
+		 */
+		if ((!info->curr_node) ||
+		    (filp->f_version !=3D inode->i_version)) {
+			info->curr_node =3D 0;
+			free_rb_tree_fname(&info->root);
+			filp->f_version =3D inode->i_version;
+			ret =3D ext3_htree_fill_tree(filp, info->curr_hash,
+						   info->curr_minor_hash,
+						   &info->next_hash);
+			if (ret < 0)
+				return ret;
+			if (ret =3D=3D 0)
+				break;
+			info->curr_node =3D rb_get_first(&info->root);
+		}
+
+		fname =3D rb_entry(info->curr_node, struct fname, rb_hash);
+		info->curr_hash =3D fname->hash;
+		info->curr_minor_hash =3D fname->minor_hash;
+		if (call_filldir(filp, dirent, filldir, fname))
+			break;
+
+		info->curr_node =3D rb_get_next(info->curr_node);
+		if (!info->curr_node) {
+			info->curr_hash =3D info->next_hash;
+			info->curr_minor_hash =3D 0;
+		}
+	}
+finished:
+	info->last_pos =3D filp->f_pos;
+	UPDATE_ATIME(inode);
+	return 0;
+}
+#endif
Index: linux-2.4.21-chaos/fs/ext3/file.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.4.21-chaos.orig/fs/ext3/file.c	2003-12-05 07:55:47.000000000 +0=
300
+++ linux-2.4.21-chaos/fs/ext3/file.c	2003-12-12 16:18:17.000000000 +0300
@@ -38,6 +38,9 @@
 {
 	if (filp->f_mode & FMODE_WRITE)
 		ext3_discard_prealloc (inode);
+	if (is_dx(inode) && filp->private_data)
+		ext3_htree_free_dir_info(filp->private_data);
+
 	return 0;
 }
=20
Index: linux-2.4.21-chaos/fs/ext3/hash.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.4.21-chaos.orig/fs/ext3/hash.c	2003-01-30 13:24:37.000000000 +0=
300
+++ linux-2.4.21-chaos/fs/ext3/hash.c	2003-12-12 16:18:17.000000000 +0300
@@ -0,0 +1,215 @@
+/*
+ *  linux/fs/ext3/hash.c
+ *
+ * Copyright (C) 2002 by Theodore Ts'o
+ *
+ * This file is released under the GPL v2.
+ *=20
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
+	__u32	sum =3D 0;
+	__u32	b0 =3D buf[0], b1 =3D buf[1];
+	__u32	a =3D in[0], b =3D in[1], c =3D in[2], d =3D in[3];
+	int	n =3D 16;
+
+	do {						=09
+		sum +=3D DELTA;				=09
+		b0 +=3D ((b1 << 4)+a) ^ (b1+sum) ^ ((b1 >> 5)+b);=09
+		b1 +=3D ((b0 << 4)+c) ^ (b0+sum) ^ ((b0 >> 5)+d);=09
+	} while(--n);
+
+	buf[0] +=3D b0;
+	buf[1] +=3D b1;
+}
+
+/* F, G and H are basic MD4 functions: selection, majority, parity */
+#define F(x, y, z) ((z) ^ ((x) & ((y) ^ (z))))
+#define G(x, y, z) (((x) & (y)) + (((x) ^ (y)) & (z)))
+#define H(x, y, z) ((x) ^ (y) ^ (z))
+
+/*
+ * The generic round function.  The application is so specific that
+ * we don't bother protecting all the arguments with parens, as is general=
ly
+ * good macro practice, in favor of extra legibility.
+ * Rotation is separate from addition to prevent recomputation
+ */
+#define ROUND(f, a, b, c, d, x, s)	\
+	(a +=3D f(b, c, d) + x, a =3D (a << s) | (a >> (32-s)))
+#define K1 0
+#define K2 013240474631UL
+#define K3 015666365641UL
+
+/*
+ * Basic cut-down MD4 transform.  Returns only 32 bits of result.
+ */
+static void halfMD4Transform (__u32 buf[4], __u32 const in[])
+{
+	__u32	a =3D buf[0], b =3D buf[1], c =3D buf[2], d =3D buf[3];
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
+	buf[0] +=3D a;
+	buf[1] +=3D b;
+	buf[2] +=3D c;
+	buf[3] +=3D d;
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
+	__u32 hash0 =3D 0x12a3fe2d, hash1 =3D 0x37abe8f9;
+	while (len--) {
+		__u32 hash =3D hash1 + (hash0 ^ (*name++ * 7152373));
+	=09
+		if (hash & 0x80000000) hash -=3D 0x7fffffff;
+		hash1 =3D hash0;
+		hash0 =3D hash;
+	}
+	return (hash0 << 1);
+}
+
+static void str2hashbuf(const char *msg, int len, __u32 *buf, int num)
+{
+	__u32	pad, val;
+	int	i;
+
+	pad =3D (__u32)len | ((__u32)len << 8);
+	pad |=3D pad << 16;
+
+	val =3D pad;
+	if (len > num*4)
+		len =3D num * 4;
+	for (i=3D0; i < len; i++) {
+		if ((i % 4) =3D=3D 0)
+			val =3D pad;
+		val =3D msg[i] + (val << 8);
+		if ((i % 4) =3D=3D 3) {
+			*buf++ =3D val;
+			val =3D pad;
+			num--;
+		}
+	}
+	if (--num >=3D 0)
+		*buf++ =3D val;
+	while (--num >=3D 0)
+		*buf++ =3D pad;
+}
+
+/*
+ * Returns the hash of a filename.  If len is 0 and name is NULL, then
+ * this function can be used to test whether or not a hash version is
+ * supported.
+ *=20
+ * The seed is an 4 longword (32 bits) "secret" which can be used to
+ * uniquify a hash.  If the seed is all zero's, then some default seed
+ * may be used.
+ *=20
+ * A particular hash version specifies whether or not the seed is
+ * represented, and whether or not the returned hash is 32 bits or 64
+ * bits.  32 bit hashes will return 0 for the minor hash.
+ */
+int ext3fs_dirhash(const char *name, int len, struct dx_hash_info *hinfo)
+{
+	__u32	hash;
+	__u32	minor_hash =3D 0;
+	const char	*p;
+	int		i;
+	__u32 		in[8], buf[4];
+
+	/* Initialize the default seed for the hash checksum functions */
+	buf[0] =3D 0x67452301;
+	buf[1] =3D 0xefcdab89;
+	buf[2] =3D 0x98badcfe;
+	buf[3] =3D 0x10325476;
+
+	/* Check to see if the seed is all zero's */
+	if (hinfo->seed) {
+		for (i=3D0; i < 4; i++) {
+			if (hinfo->seed[i])
+				break;
+		}
+		if (i < 4)
+			memcpy(buf, hinfo->seed, sizeof(buf));
+	}
+	=09
+	switch (hinfo->hash_version) {
+	case DX_HASH_LEGACY:
+		hash =3D dx_hack_hash(name, len);
+		break;
+	case DX_HASH_HALF_MD4:
+		p =3D name;
+		while (len > 0) {
+			str2hashbuf(p, len, in, 8);
+			halfMD4Transform(buf, in);
+			len -=3D 32;
+			p +=3D 32;
+		}
+		minor_hash =3D buf[2];
+		hash =3D buf[1];
+		break;
+	case DX_HASH_TEA:
+		p =3D name;
+		while (len > 0) {
+			str2hashbuf(p, len, in, 4);
+			TEA_transform(buf, in);
+			len -=3D 16;
+			p +=3D 16;
+		}
+		hash =3D buf[0];
+		minor_hash =3D buf[1];
+		break;
+	default:
+		hinfo->hash =3D 0;
+		return -1;
+	}
+	hinfo->hash =3D hash & ~1;
+	hinfo->minor_hash =3D minor_hash;
+	return 0;
+}
Index: linux-2.4.21-chaos/fs/ext3/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.4.21-chaos.orig/fs/ext3/Makefile	2003-12-12 16:17:59.000000000 =
+0300
+++ linux-2.4.21-chaos/fs/ext3/Makefile	2003-12-12 16:18:17.000000000 +0300
@@ -12,7 +12,7 @@
 export-objs :=3D	super.o inode.o
=20
 obj-y    :=3D balloc.o bitmap.o dir.o file.o fsync.o ialloc.o inode.o \
-		ioctl.o namei.o super.o symlink.o
+		ioctl.o namei.o super.o symlink.o hash.o
 obj-m    :=3D $(O_TARGET)
=20
 export-objs +=3D xattr.o
Index: linux-2.4.21-chaos/fs/ext3/namei.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.4.21-chaos.orig/fs/ext3/namei.c	2003-07-15 04:41:01.000000000 +=
0400
+++ linux-2.4.21-chaos/fs/ext3/namei.c	2003-12-12 16:18:17.000000000 +0300
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
=20
 #include <linux/fs.h>
@@ -40,6 +46,642 @@
 #define NAMEI_RA_SIZE        (NAMEI_RA_CHUNKS * NAMEI_RA_BLOCKS)
 #define NAMEI_RA_INDEX(c,b)  (((c) * NAMEI_RA_BLOCKS) + (b))
=20
+static struct buffer_head *ext3_append(handle_t *handle,
+					struct inode *inode,
+					u32 *block, int *err)
+{
+	struct buffer_head *bh;
+
+	*block =3D inode->i_size >> inode->i_sb->s_blocksize_bits;
+
+	if ((bh =3D ext3_bread(handle, inode, *block, 1, err))) {
+		inode->i_size +=3D inode->i_sb->s_blocksize;
+		EXT3_I(inode)->i_disksize =3D inode->i_size;
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
+#define swap(x, y) do { typeof(x) z =3D x; x =3D y; y =3D z; } while (0)
+#endif
+
+typedef struct { u32 v; } le_u32;
+typedef struct { u16 v; } le_u16;
+
+#ifdef DX_DEBUG
+#define dxtrace(command) command
+#else
+#define dxtrace(command)=20
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
+ * dirent the two low bits of the hash version will be zero.  Therefore, t=
he
+ * hash version mod 4 should never be 0.  Sincerely, the paranoia departme=
nt.
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
+				 struct dx_frame *frames, int *err,
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
+	entry->block.v =3D cpu_to_le32(value);
+}
+
+static inline unsigned dx_get_hash (struct dx_entry *entry)
+{
+	return le32_to_cpu(entry->hash.v);
+}
+
+static inline void dx_set_hash (struct dx_entry *entry, unsigned value)
+{
+	entry->hash.v =3D cpu_to_le32(value);
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
+	((struct dx_countlimit *) entries)->count.v =3D cpu_to_le16(value);
+}
+
+static inline void dx_set_limit (struct dx_entry *entries, unsigned value)
+{
+	((struct dx_countlimit *) entries)->limit.v =3D cpu_to_le16(value);
+}
+
+static inline unsigned dx_root_limit (struct inode *dir, unsigned infosize)
+{
+	unsigned entry_space =3D dir->i_sb->s_blocksize - EXT3_DIR_REC_LEN(1) -
+		EXT3_DIR_REC_LEN(2) - infosize;
+	return 0? 20: entry_space / sizeof(struct dx_entry);
+}
+
+static inline unsigned dx_node_limit (struct inode *dir)
+{
+	unsigned entry_space =3D dir->i_sb->s_blocksize - EXT3_DIR_REC_LEN(0);
+	return 0? 22: entry_space / sizeof(struct dx_entry);
+}
+
+/*
+ * Debug
+ */
+#ifdef DX_DEBUG
+struct stats
+{=20
+	unsigned names;
+	unsigned space;
+	unsigned bcount;
+};
+
+static struct stats dx_show_leaf(struct dx_hash_info *hinfo, struct ext3_d=
ir_entry_2 *de,
+				 int size, int show_names)
+{
+	unsigned names =3D 0, space =3D 0;
+	char *base =3D (char *) de;
+	struct dx_hash_info h =3D *hinfo;
+=09
+	printk("names: ");
+	while ((char *) de < base + size)
+	{
+		if (de->inode)
+		{
+			if (show_names)
+			{
+				int len =3D de->name_len;
+				char *name =3D de->name;
+				while (len--) printk("%c", *name++);
+				ext3fs_dirhash(de->name, de->name_len, &h);
+				printk(":%x.%u ", h.hash,
+				       ((char *) de - base));
+			}
+			space +=3D EXT3_DIR_REC_LEN(de->name_len);
+	 		names++;
+		}
+		de =3D (struct ext3_dir_entry_2 *) ((char *) de + le16_to_cpu(de->rec_le=
n));
+	}
+	printk("(%i)\n", names);
+	return (struct stats) { names, space, 1 };
+}
+
+struct stats dx_show_entries(struct dx_hash_info *hinfo, struct inode *dir,
+			     struct dx_entry *entries, int levels)
+{
+	unsigned blocksize =3D dir->i_sb->s_blocksize;
+	unsigned count =3D dx_get_count (entries), names =3D 0, space =3D 0, i;
+	unsigned bcount =3D 0;
+	struct buffer_head *bh;
+	int err;
+	printk("%i indexed blocks...\n", count);
+	for (i =3D 0; i < count; i++, entries++)
+	{
+		u32 block =3D dx_get_block(entries), hash =3D i? dx_get_hash(entries): 0;
+		u32 range =3D i < count - 1? (dx_get_hash(entries + 1) - hash): ~hash;
+		struct stats stats;
+		printk("%s%3u:%03u hash %8x/%8x ",levels?"":"   ", i, block, hash, range=
);
+		if (!(bh =3D ext3_bread (NULL,dir, block, 0,&err))) continue;
+		stats =3D levels?
+		   dx_show_entries(hinfo, dir, ((struct dx_node *) bh->b_data)->entries,=
 levels - 1):
+		   dx_show_leaf(hinfo, (struct ext3_dir_entry_2 *) bh->b_data, blocksize=
, 0);
+		names +=3D stats.names;
+		space +=3D stats.space;
+		bcount +=3D stats.bcount;
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
+	struct dx_frame *frame =3D frame_in;
+	u32 hash;
+
+	frame->bh =3D NULL;
+	if (dentry)
+		dir =3D dentry->d_parent->d_inode;
+	if (!(bh =3D ext3_bread (NULL,dir, 0, 0, err)))
+		goto fail;
+	root =3D (struct dx_root *) bh->b_data;
+	if (root->info.hash_version !=3D DX_HASH_TEA &&
+	    root->info.hash_version !=3D DX_HASH_HALF_MD4 &&
+	    root->info.hash_version !=3D DX_HASH_LEGACY) {
+		ext3_warning(dir->i_sb, __FUNCTION__,
+			     "Unrecognised inode hash code %d",
+			     root->info.hash_version);
+		brelse(bh);
+		*err =3D ERR_BAD_DX_DIR;
+		goto fail;
+	}
+	hinfo->hash_version =3D root->info.hash_version;
+	hinfo->seed =3D dir->i_sb->u.ext3_sb.s_hash_seed;
+	if (dentry)
+		ext3fs_dirhash(dentry->d_name.name, dentry->d_name.len, hinfo);
+	hash =3D hinfo->hash;
+
+	if (root->info.unused_flags & 1) {
+		ext3_warning(dir->i_sb, __FUNCTION__,
+			     "Unimplemented inode hash flags: %#06x",
+			     root->info.unused_flags);
+		brelse(bh);
+		*err =3D ERR_BAD_DX_DIR;
+		goto fail;
+	}
+
+	if ((indirect =3D root->info.indirect_levels) > 1) {
+		ext3_warning(dir->i_sb, __FUNCTION__,
+			     "Unimplemented inode hash depth: %#06x",
+			     root->info.indirect_levels);
+		brelse(bh);
+		*err =3D ERR_BAD_DX_DIR;
+		goto fail;
+	}
+
+	entries =3D (struct dx_entry *) (((char *)&root->info) +
+				       root->info.info_length);
+	assert(dx_get_limit(entries) =3D=3D dx_root_limit(dir,
+						      root->info.info_length));
+	dxtrace (printk("Look up %x", hash));
+	while (1)
+	{
+		count =3D dx_get_count(entries);
+		assert (count && count <=3D dx_get_limit(entries));
+		p =3D entries + 1;
+		q =3D entries + count - 1;
+		while (p <=3D q)
+		{
+			m =3D p + (q - p)/2;
+			dxtrace(printk("."));
+			if (dx_get_hash(m) > hash)
+				q =3D m - 1;
+			else
+				p =3D m + 1;
+		}
+
+		if (0) // linear search cross check
+		{
+			unsigned n =3D count - 1;
+			at =3D entries;
+			while (n--)
+			{
+				dxtrace(printk(","));
+				if (dx_get_hash(++at) > hash)
+				{
+					at--;
+					break;
+				}
+			}
+			assert (at =3D=3D p - 1);
+		}
+
+		at =3D p - 1;
+		dxtrace(printk(" %x->%u\n", at =3D=3D entries? 0: dx_get_hash(at), dx_ge=
t_block(at)));
+		frame->bh =3D bh;
+		frame->entries =3D entries;
+		frame->at =3D at;
+		if (!indirect--) return frame;
+		if (!(bh =3D ext3_bread (NULL,dir, dx_get_block(at), 0, err)))
+			goto fail2;
+		at =3D entries =3D ((struct dx_node *) bh->b_data)->entries;
+		assert (dx_get_limit(entries) =3D=3D dx_node_limit (dir));
+		frame++;
+	}
+fail2:
+	while (frame >=3D frame_in) {
+		brelse(frame->bh);
+		frame--;
+	}
+fail:
+	return NULL;
+}
+
+static void dx_release (struct dx_frame *frames)
+{
+	if (frames[0].bh =3D=3D NULL)
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
+ * index blocks, it will return -1.
+ *
+ * If start_hash is non-null, it will be filled in with the starting
+ * hash of the next page.
+ */
+static int ext3_htree_next_block(struct inode *dir, __u32 hash,
+				 struct dx_frame *frame,
+				 struct dx_frame *frames, int *err,
+				 __u32 *start_hash)
+{
+	struct dx_frame *p;
+	struct buffer_head *bh;
+	int num_frames =3D 0;
+	__u32 bhash;
+
+	*err =3D ENOENT;
+	p =3D frame;
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
+		if (p =3D=3D frames)
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
+	bhash =3D dx_get_hash(p->at);
+	if (start_hash)
+		*start_hash =3D bhash;
+	if ((hash & 1) =3D=3D 0) {
+		if ((bhash & ~1) !=3D hash)
+			return 0;
+	}
+	/*
+	 * If the hash is HASH_NB_ALWAYS, we always go to the next
+	 * block so no check is necessary
+	 */
+	while (num_frames--) {
+		if (!(bh =3D ext3_bread(NULL, dir, dx_get_block(p->at),
+				      0, err)))
+			return -1; /* Failure */
+		p++;
+		brelse (p->bh);
+		p->bh =3D bh;
+		p->at =3D p->entries =3D ((struct dx_node *) bh->b_data)->entries;
+	}
+	return 1;
+}
+
+
+/*
+ * p is at least 6 bytes before the end of page
+ */
+static inline struct ext3_dir_entry_2 *ext3_next_entry(struct ext3_dir_ent=
ry_2 *p)
+{
+	return (struct ext3_dir_entry_2 *)((char*)p + le16_to_cpu(p->rec_len));
+}
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
+	struct buffer_head *bh;
+	struct ext3_dir_entry_2 *de, *top;
+	static struct dx_frame frames[2], *frame;
+	struct inode *dir;
+	int block, err;
+	int count =3D 0;
+	int ret;
+	__u32 hashval;
+=09
+	dxtrace(printk("In htree_fill_tree, start hash: %x:%x\n", start_hash,
+		       start_minor_hash));
+	dir =3D dir_file->f_dentry->d_inode;
+	hinfo.hash =3D start_hash;
+	hinfo.minor_hash =3D 0;
+	frame =3D dx_probe(0, dir_file->f_dentry->d_inode, &hinfo, frames, &err);
+	if (!frame)
+		return err;
+
+	/* Add '.' and '..' from the htree header */
+	if (!start_hash && !start_minor_hash) {
+		de =3D (struct ext3_dir_entry_2 *) frames[0].bh->b_data;
+		if ((err =3D ext3_htree_store_dirent(dir_file, 0, 0, de)) !=3D 0)
+			goto errout;
+		de =3D ext3_next_entry(de);
+		if ((err =3D ext3_htree_store_dirent(dir_file, 0, 0, de)) !=3D 0)
+			goto errout;
+		count +=3D 2;
+	}
+
+	while (1) {
+		block =3D dx_get_block(frame->at);
+		dxtrace(printk("Reading block %d\n", block));
+		if (!(bh =3D ext3_bread (NULL, dir, block, 0, &err)))
+			goto errout;
+=09
+		de =3D (struct ext3_dir_entry_2 *) bh->b_data;
+		top =3D (struct ext3_dir_entry_2 *) ((char *) de + dir->i_sb->s_blocksiz=
e -
+				       EXT3_DIR_REC_LEN(0));
+		for (; de < top; de =3D ext3_next_entry(de)) {
+			ext3fs_dirhash(de->name, de->name_len, &hinfo);
+			if ((hinfo.hash < start_hash) ||
+			    ((hinfo.hash =3D=3D start_hash) &&
+			     (hinfo.minor_hash < start_minor_hash)))
+				continue;
+			if ((err =3D ext3_htree_store_dirent(dir_file,
+				   hinfo.hash, hinfo.minor_hash, de)) !=3D 0)
+				goto errout;
+			count++;
+		}
+		brelse (bh);
+		hashval =3D ~1;
+		ret =3D ext3_htree_next_block(dir, HASH_NB_ALWAYS,=20
+					    frame, frames, &err, &hashval);
+		if (next_hash)
+			*next_hash =3D hashval;
+		if (ret =3D=3D -1)
+			goto errout;
+		/*
+		 * Stop if:  (a) there are no more entries, or
+		 * (b) we have inserted at least one entry and the
+		 * next hash value is not a continuation
+		 */
+		if ((ret =3D=3D 0) ||
+		    (count && ((hashval & 1) =3D=3D 0)))
+			break;
+	}
+	dx_release(frames);
+	dxtrace(printk("Fill tree: returned %d entries\n", count));
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
+	int count =3D 0;
+	char *base =3D (char *) de;
+	struct dx_hash_info h =3D *hinfo;
+=09
+	while ((char *) de < base + size)
+	{
+		if (de->name_len && de->inode) {
+			ext3fs_dirhash(de->name, de->name_len, &h);
+			map_tail--;
+			map_tail->hash =3D h.hash;
+			map_tail->offs =3D (u32) ((char *) de - base);
+			count++;
+		}
+		/* XXX: do we need to check rec_len =3D=3D 0 case? -Chris */
+		de =3D (struct ext3_dir_entry_2 *) ((char *) de + le16_to_cpu(de->rec_le=
n));
+	}
+	return count;
+}
+
+static void dx_sort_map (struct dx_map_entry *map, unsigned count)
+{
+	struct dx_map_entry *p, *q, *top =3D map + count - 1;
+	int more;
+	/* Combsort until bubble sort doesn't suck */
+	while (count > 2)
+	{
+		count =3D count*10/13;
+		if (count - 9 < 2) /* 9, 10 -> 11 */
+			count =3D 11;
+		for (p =3D top, q =3D p - count; q >=3D map; p--, q--)
+			if (p->hash < q->hash)
+				swap(*p, *q);
+	}
+	/* Garden variety bubble sort */
+	do {
+		more =3D 0;
+		q =3D top;
+		while (q-- > map)
+		{
+			if (q[1].hash >=3D q[0].hash)
+				continue;
+			swap(*(q+1), *q);
+			more =3D 1;
+		}
+	} while(more);
+}
+
+static void dx_insert_block(struct dx_frame *frame, u32 hash, u32 block)
+{
+	struct dx_entry *entries =3D frame->entries;
+	struct dx_entry *old =3D frame->at, *new =3D old + 1;
+	int count =3D dx_get_count(entries);
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
+		EXT3_I(inode)->i_flags &=3D ~EXT3_INDEX_FL;
+}
+
 /*
  * NOTE! unlike strncmp, ext3_match returns 1 for success, 0 for failure.
  *
@@ -96,6 +738,7 @@
 	return 0;
 }
=20
+
 /*
  *	ext3_find_entry()
  *
@@ -107,6 +750,8 @@
  * The returned buffer_head has ->b_count elevated.  The caller is expected
  * to brelse() it when appropriate.
  */
+
+=09
 static struct buffer_head * ext3_find_entry (struct dentry *dentry,
 					struct ext3_dir_entry_2 ** res_dir)
 {
@@ -121,12 +766,32 @@
 	int num =3D 0;
 	int nblocks, i, err;
 	struct inode *dir =3D dentry->d_parent->d_inode;
+	int namelen;
+	const u8 *name;
+	unsigned blocksize;
=20
 	*res_dir =3D NULL;
 	sb =3D dir->i_sb;
-
+	blocksize =3D sb->s_blocksize;
+	namelen =3D dentry->d_name.len;
+	name =3D dentry->d_name.name;
+	if (namelen > EXT3_NAME_LEN)
+		return NULL;
+#ifdef CONFIG_EXT3_INDEX
+	if (is_dx(dir)) {
+		bh =3D ext3_dx_find_entry(dentry, res_dir, &err);
+		/*
+		 * On success, or if the error was file not found,
+		 * return.  Otherwise, fall back to doing a search the
+		 * old fashioned way.
+		 */
+		if (bh || (err !=3D ERR_BAD_DX_DIR))
+			return bh;
+		dxtrace(printk("ext3_find_entry: dx failed, falling back\n"));
+	}
+#endif
 	nblocks =3D dir->i_size >> EXT3_BLOCK_SIZE_BITS(sb);
-	start =3D dir->u.ext3_i.i_dir_start_lookup;
+	start =3D EXT3_I(dir)->i_dir_start_lookup;
 	if (start >=3D nblocks)
 		start =3D 0;
 	block =3D start;
@@ -167,7 +832,7 @@
 		i =3D search_dirblock(bh, dir, dentry,
 			    block << EXT3_BLOCK_SIZE_BITS(sb), res_dir);
 		if (i =3D=3D 1) {
-			dir->u.ext3_i.i_dir_start_lookup =3D block;
+			EXT3_I(dir)->i_dir_start_lookup =3D block;
 			ret =3D bh;
 			goto cleanup_and_exit;
 		} else {
@@ -198,6 +863,66 @@
 	return ret;
 }
=20
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
+	int namelen =3D dentry->d_name.len;
+	const u8 *name =3D dentry->d_name.name;
+	struct inode *dir =3D dentry->d_parent->d_inode;
+=09
+	sb =3D dir->i_sb;
+	if (!(frame =3D dx_probe (dentry, 0, &hinfo, frames, err)))
+		return NULL;
+	hash =3D hinfo.hash;
+	do {
+		block =3D dx_get_block(frame->at);
+		if (!(bh =3D ext3_bread (NULL,dir, block, 0, err)))
+			goto errout;
+		de =3D (struct ext3_dir_entry_2 *) bh->b_data;
+		top =3D (struct ext3_dir_entry_2 *) ((char *) de + sb->s_blocksize -
+				       EXT3_DIR_REC_LEN(0));
+		for (; de < top; de =3D ext3_next_entry(de))
+		if (ext3_match (namelen, name, de)) {
+			if (!ext3_check_dir_entry("ext3_find_entry",
+						  dir, de, bh,
+				  (block<<EXT3_BLOCK_SIZE_BITS(sb))
+					  +((char *)de - bh->b_data))) {
+				brelse (bh);
+				goto errout;
+			}
+			*res_dir =3D de;
+			dx_release (frames);
+			return bh;
+		}
+		brelse (bh);
+		/* Check to see if we should continue to search */
+		retval =3D ext3_htree_next_block(dir, hash, frame,
+					       frames, err, 0);
+		if (retval =3D=3D -1) {
+			ext3_warning(sb, __FUNCTION__,
+			     "error reading index page in directory #%lu",
+			     dir->i_ino);
+			goto errout;
+		}
+	} while (retval =3D=3D 1);
+=09
+	*err =3D -ENOENT;
+errout:
+	dxtrace(printk("%s not found\n", name));
+	dx_release (frames);
+	return NULL;
+}
+#endif
+
 static struct dentry *ext3_lookup(struct inode * dir, struct dentry *dentr=
y)
 {
 	struct inode * inode;
@@ -214,8 +939,9 @@
 		brelse (bh);
 		inode =3D iget(dir->i_sb, ino);
=20
-		if (!inode)
+		if (!inode) {
 			return ERR_PTR(-EACCES);
+		}
 	}
 	d_add(dentry, inode);
 	return NULL;
@@ -239,6 +965,301 @@
 		de->file_type =3D ext3_type_by_mode[(mode & S_IFMT)>>S_SHIFT];
 }
=20
+#ifdef CONFIG_EXT3_INDEX
+static struct ext3_dir_entry_2 *
+dx_move_dirents(char *from, char *to, struct dx_map_entry *map, int count)
+{
+	unsigned rec_len =3D 0;
+
+	while (count--) {
+		struct ext3_dir_entry_2 *de =3D (struct ext3_dir_entry_2 *) (from + map-=
>offs);
+		rec_len =3D EXT3_DIR_REC_LEN(de->name_len);
+		memcpy (to, de, rec_len);
+		((struct ext3_dir_entry_2 *)to)->rec_len =3D cpu_to_le16(rec_len);
+		de->inode =3D 0;
+		map++;
+		to +=3D rec_len;
+	}
+	return (struct ext3_dir_entry_2 *) (to - rec_len);
+}
+
+static struct ext3_dir_entry_2* dx_pack_dirents(char *base, int size)
+{
+	struct ext3_dir_entry_2 *next, *to, *prev, *de =3D (struct ext3_dir_entry=
_2 *) base;
+	unsigned rec_len =3D 0;
+
+	prev =3D to =3D de;
+	while ((char*)de < base + size) {
+		next =3D (struct ext3_dir_entry_2 *) ((char *) de +
+						    le16_to_cpu(de->rec_len));
+		if (de->inode && de->name_len) {
+			rec_len =3D EXT3_DIR_REC_LEN(de->name_len);
+			if (de > to)
+				memmove(to, de, rec_len);
+			to->rec_len =3D cpu_to_le16(rec_len);
+			prev =3D to;
+			to =3D (struct ext3_dir_entry_2 *)((char *) to + rec_len);
+		}
+		de =3D next;
+	}
+	return prev;
+}
+
+static struct ext3_dir_entry_2 *do_split(handle_t *handle, struct inode *d=
ir,
+			struct buffer_head **bh,struct dx_frame *frame,
+			struct dx_hash_info *hinfo, int *error)
+{
+	unsigned blocksize =3D dir->i_sb->s_blocksize;
+	unsigned count, continued;
+	struct buffer_head *bh2;
+	u32 newblock;
+	u32 hash2;
+	struct dx_map_entry *map;
+	char *data1 =3D (*bh)->b_data, *data2;
+	unsigned split;
+	struct ext3_dir_entry_2 *de =3D NULL, *de2;
+	int	err;
+
+	bh2 =3D ext3_append (handle, dir, &newblock, error);
+	if (!(bh2)) {
+		brelse(*bh);
+		*bh =3D NULL;
+		goto errout;
+	}
+
+	BUFFER_TRACE(*bh, "get_write_access");
+	err =3D ext3_journal_get_write_access(handle, *bh);
+	if (err) {
+	journal_error:
+		brelse(*bh);
+		brelse(bh2);
+		*bh =3D NULL;
+		ext3_std_error(dir->i_sb, err);
+		goto errout;
+	}
+	BUFFER_TRACE(frame->bh, "get_write_access");
+	err =3D ext3_journal_get_write_access(handle, frame->bh);
+	if (err)
+		goto journal_error;
+
+	data2 =3D bh2->b_data;
+
+	/* create map in the end of data2 block */
+	map =3D (struct dx_map_entry *) (data2 + blocksize);
+	count =3D dx_make_map ((struct ext3_dir_entry_2 *) data1,
+			     blocksize, hinfo, map);
+	map -=3D count;
+	split =3D count/2; // need to adjust to actual middle
+	dx_sort_map (map, count);
+	hash2 =3D map[split].hash;
+	continued =3D hash2 =3D=3D map[split - 1].hash;
+	dxtrace(printk("Split block %i at %x, %i/%i\n",
+		dx_get_block(frame->at), hash2, split, count-split));
+
+	/* Fancy dance to stay within two buffers */
+	de2 =3D dx_move_dirents(data1, data2, map + split, count - split);
+	de =3D dx_pack_dirents(data1,blocksize);
+	de->rec_len =3D cpu_to_le16(data1 + blocksize - (char *) de);
+	de2->rec_len =3D cpu_to_le16(data2 + blocksize - (char *) de2);
+	dxtrace(dx_show_leaf (hinfo, (struct ext3_dir_entry_2 *) data1, blocksize=
, 1));
+	dxtrace(dx_show_leaf (hinfo, (struct ext3_dir_entry_2 *) data2, blocksize=
, 1));
+
+	/* Which block gets the new entry? */
+	if (hinfo->hash >=3D hash2)
+	{
+		swap(*bh, bh2);
+		de =3D de2;
+	}
+	dx_insert_block (frame, hash2 + continued, newblock);
+	err =3D ext3_journal_dirty_metadata (handle, bh2);
+	if (err)
+		goto journal_error;
+	err =3D ext3_journal_dirty_metadata (handle, frame->bh);
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
+ *=20
+ * NOTE!  bh is NOT released in the case where ENOSPC is returned.  In
+ * all other cases bh is released.
+ */
+static int add_dirent_to_buf(handle_t *handle, struct dentry *dentry,
+			     struct inode *inode, struct ext3_dir_entry_2 *de,
+			     struct buffer_head * bh)
+{
+	struct inode	*dir =3D dentry->d_parent->d_inode;
+	const char	*name =3D dentry->d_name.name;
+	int		namelen =3D dentry->d_name.len;
+	unsigned long	offset =3D 0;
+	unsigned short	reclen;
+	int		nlen, rlen, err;
+	char		*top;
+=09
+	reclen =3D EXT3_DIR_REC_LEN(namelen);
+	if (!de) {
+		de =3D (struct ext3_dir_entry_2 *)bh->b_data;
+		top =3D bh->b_data + dir->i_sb->s_blocksize - reclen;
+		while ((char *) de <=3D top) {
+			if (!ext3_check_dir_entry("ext3_add_entry", dir, de,
+						  bh, offset)) {
+				brelse (bh);
+				return -EIO;
+			}
+			if (ext3_match (namelen, name, de)) {
+				brelse (bh);
+				return -EEXIST;
+			}
+			nlen =3D EXT3_DIR_REC_LEN(de->name_len);
+			rlen =3D le16_to_cpu(de->rec_len);
+			if ((de->inode? rlen - nlen: rlen) >=3D reclen)
+				break;
+			de =3D (struct ext3_dir_entry_2 *)((char *)de + rlen);
+			offset +=3D rlen;
+		}
+		if ((char *) de > top)
+			return -ENOSPC;
+	}
+	BUFFER_TRACE(bh, "get_write_access");
+	err =3D ext3_journal_get_write_access(handle, bh);
+	if (err) {
+		ext3_std_error(dir->i_sb, err);
+		brelse(bh);
+		return err;
+	}
+=09
+	/* By now the buffer is marked for journaling */
+	nlen =3D EXT3_DIR_REC_LEN(de->name_len);
+	rlen =3D le16_to_cpu(de->rec_len);
+	if (de->inode) {
+		struct ext3_dir_entry_2 *de1 =3D (struct ext3_dir_entry_2 *)((char *)de =
+ nlen);
+		de1->rec_len =3D cpu_to_le16(rlen - nlen);
+		de->rec_len =3D cpu_to_le16(nlen);
+		de =3D de1;
+	}
+	de->file_type =3D EXT3_FT_UNKNOWN;
+	if (inode) {
+		de->inode =3D cpu_to_le32(inode->i_ino);
+		ext3_set_de_type(dir->i_sb, de, inode->i_mode);
+	} else
+		de->inode =3D 0;
+	de->name_len =3D namelen;
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
+	dir->i_mtime =3D dir->i_ctime =3D CURRENT_TIME;
+	ext3_update_dx_flag(dir);
+	dir->i_version =3D ++event;
+	ext3_mark_inode_dirty(handle, dir);
+	BUFFER_TRACE(bh, "call ext3_journal_dirty_metadata");
+	err =3D ext3_journal_dirty_metadata(handle, bh);
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
+	struct inode	*dir =3D dentry->d_parent->d_inode;
+	const char	*name =3D dentry->d_name.name;
+	int		namelen =3D dentry->d_name.len;
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
+	=09
+	blocksize =3D  dir->i_sb->s_blocksize;
+	dxtrace(printk("Creating index\n"));
+	retval =3D ext3_journal_get_write_access(handle, bh);
+	if (retval) {
+		ext3_std_error(dir->i_sb, retval);
+		brelse(bh);
+		return retval;
+	}
+	root =3D (struct dx_root *) bh->b_data;
+	=09
+	EXT3_I(dir)->i_flags |=3D EXT3_INDEX_FL;
+	bh2 =3D ext3_append (handle, dir, &block, &retval);
+	if (!(bh2)) {
+		brelse(bh);
+		return retval;
+	}
+	data1 =3D bh2->b_data;
+
+	/* The 0th block becomes the root, move the dirents out */
+	de =3D (struct ext3_dir_entry_2 *)&root->dotdot;
+	de =3D (struct ext3_dir_entry_2 *)((char *)de + le16_to_cpu(de->rec_len));
+	len =3D ((char *) root) + blocksize - (char *) de;
+	memcpy (data1, de, len);
+	de =3D (struct ext3_dir_entry_2 *) data1;
+	top =3D data1 + len;
+	while (((char *) de2=3D(char*)de+le16_to_cpu(de->rec_len)) < top)
+		de =3D de2;
+	de->rec_len =3D cpu_to_le16(data1 + blocksize - (char *) de);
+	/* Initialize the root; the dot dirents already exist */
+	de =3D (struct ext3_dir_entry_2 *) (&root->dotdot);
+	de->rec_len =3D cpu_to_le16(blocksize - EXT3_DIR_REC_LEN(2));
+	memset (&root->info, 0, sizeof(root->info));
+	root->info.info_length =3D sizeof(root->info);
+	root->info.hash_version =3D dir->i_sb->u.ext3_sb.s_def_hash_version;
+	entries =3D root->entries;
+	dx_set_block (entries, 1);
+	dx_set_count (entries, 1);
+	dx_set_limit (entries, dx_root_limit(dir, sizeof(root->info)));
+
+	/* Initialize as for dx_probe */
+	hinfo.hash_version =3D root->info.hash_version;
+	hinfo.seed =3D dir->i_sb->u.ext3_sb.s_hash_seed;
+	ext3fs_dirhash(name, namelen, &hinfo);
+	frame =3D frames;
+	frame->entries =3D entries;
+	frame->at =3D entries;
+	frame->bh =3D bh;
+	bh =3D bh2;
+	de =3D do_split(handle,dir, &bh, frame, &hinfo, &retval);
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
@@ -249,127 +1270,198 @@
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
 	struct inode *dir =3D dentry->d_parent->d_inode;
-	const char *name =3D dentry->d_name.name;
-	int namelen =3D dentry->d_name.len;
 	unsigned long offset;
-	unsigned short rec_len;
 	struct buffer_head * bh;
-	struct ext3_dir_entry_2 * de, * de1;
+	struct ext3_dir_entry_2 *de;
 	struct super_block * sb;
 	int	retval;
+#ifdef CONFIG_EXT3_INDEX
+	int	dx_fallback=3D0;
+#endif
+	unsigned blocksize;
+	unsigned nlen, rlen;
+	u32 block, blocks;
=20
 	sb =3D dir->i_sb;
-
-	if (!namelen)
+	blocksize =3D sb->s_blocksize;
+	if (!dentry->d_name.len)
 		return -EINVAL;
-	bh =3D ext3_bread (handle, dir, 0, 0, &retval);
+#ifdef CONFIG_EXT3_INDEX
+	if (is_dx(dir)) {
+		retval =3D ext3_dx_add_entry(handle, dentry, inode);
+		if (!retval || (retval !=3D ERR_BAD_DX_DIR))
+			return retval;
+		EXT3_I(dir)->i_flags &=3D ~EXT3_INDEX_FL;
+		dx_fallback++;
+		ext3_mark_inode_dirty(handle, dir);
+	}
+#endif
+	blocks =3D dir->i_size >> sb->s_blocksize_bits;
+	for (block =3D 0, offset =3D 0; block < blocks; block++) {
+		bh =3D ext3_bread(handle, dir, block, 0, &retval);
+		if(!bh)
+			return retval;
+		retval =3D add_dirent_to_buf(handle, dentry, inode, 0, bh);
+		if (retval !=3D -ENOSPC)
+			return retval;
+
+#ifdef CONFIG_EXT3_INDEX
+		if (blocks =3D=3D 1 && !dx_fallback &&
+		    EXT3_HAS_COMPAT_FEATURE(sb, EXT3_FEATURE_COMPAT_DIR_INDEX))
+			return make_indexed_dir(handle, dentry, inode, bh);
+#endif
+		brelse(bh);
+	}
+	bh =3D ext3_append(handle, dir, &block, &retval);
 	if (!bh)
 		return retval;
-	rec_len =3D EXT3_DIR_REC_LEN(namelen);
-	offset =3D 0;
 	de =3D (struct ext3_dir_entry_2 *) bh->b_data;
-	while (1) {
-		if ((char *)de >=3D sb->s_blocksize + bh->b_data) {
-			brelse (bh);
-			bh =3D NULL;
-			bh =3D ext3_bread (handle, dir,
-				offset >> EXT3_BLOCK_SIZE_BITS(sb), 1, &retval);
-			if (!bh)
-				return retval;
-			if (dir->i_size <=3D offset) {
-				if (dir->i_size =3D=3D 0) {
-					brelse(bh);
-					return -ENOENT;
-				}
+	de->inode =3D 0;
+	de->rec_len =3D cpu_to_le16(rlen =3D blocksize);
+	nlen =3D 0;
+	return add_dirent_to_buf(handle, dentry, inode, de, bh);
+}
=20
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
+	struct inode *dir =3D dentry->d_parent->d_inode;
+	struct super_block * sb =3D dir->i_sb;
+	struct ext3_dir_entry_2 *de;
+	int err;
=20
-				BUFFER_TRACE(bh, "get_write_access");
-				ext3_journal_get_write_access(handle, bh);
-				de =3D (struct ext3_dir_entry_2 *) bh->b_data;
-				de->inode =3D 0;
-				de->rec_len =3D le16_to_cpu(sb->s_blocksize);
-				dir->u.ext3_i.i_disksize =3D
-					dir->i_size =3D offset + sb->s_blocksize;
-				dir->u.ext3_i.i_flags &=3D ~EXT3_INDEX_FL;
-				ext3_mark_inode_dirty(handle, dir);
-			} else {
+	frame =3D dx_probe(dentry, 0, &hinfo, frames, &err);
+	if (!frame)
+		return err;
+	entries =3D frame->entries;
+	at =3D frame->at;
=20
-				ext3_debug ("skipping to next block\n");
+	if (!(bh =3D ext3_bread(handle,dir, dx_get_block(frame->at), 0, &err)))
+		goto cleanup;
=20
-				de =3D (struct ext3_dir_entry_2 *) bh->b_data;
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
+	err =3D ext3_journal_get_write_access(handle, bh);
+	if (err)
+		goto journal_error;
+
+	err =3D add_dirent_to_buf(handle, dentry, inode, 0, bh);
+	if (err !=3D -ENOSPC) {
+		bh =3D 0;
+		goto cleanup;
+	}
+
+	/* Block full, should compress but for now just split */
+	dxtrace(printk("using %u of %u node entries\n",
+		       dx_get_count(entries), dx_get_limit(entries)));
+	/* Need to split index? */
+	if (dx_get_count(entries) =3D=3D dx_get_limit(entries)) {
+		u32 newblock;
+		unsigned icount =3D dx_get_count(entries);
+		int levels =3D frame - frames;
+		struct dx_entry *entries2;
+		struct dx_node *node2;
+		struct buffer_head *bh2;
+
+		if (levels && (dx_get_count(frames->entries) =3D=3D
+			       dx_get_limit(frames->entries))) {
+			ext3_warning(sb, __FUNCTION__,
+				     "Directory index full!\n");
+			err =3D -ENOSPC;
+			goto cleanup;
 		}
-		if ((le32_to_cpu(de->inode) =3D=3D 0 &&
-				le16_to_cpu(de->rec_len) >=3D rec_len) ||
-		    (le16_to_cpu(de->rec_len) >=3D
-				EXT3_DIR_REC_LEN(de->name_len) + rec_len)) {
-			BUFFER_TRACE(bh, "get_write_access");
-			ext3_journal_get_write_access(handle, bh);
-			/* By now the buffer is marked for journaling */
-			offset +=3D le16_to_cpu(de->rec_len);
-			if (le32_to_cpu(de->inode)) {
-				de1 =3D (struct ext3_dir_entry_2 *) ((char *) de +
-					EXT3_DIR_REC_LEN(de->name_len));
-				de1->rec_len =3D
-					cpu_to_le16(le16_to_cpu(de->rec_len) -
-					EXT3_DIR_REC_LEN(de->name_len));
-				de->rec_len =3D cpu_to_le16(
-						EXT3_DIR_REC_LEN(de->name_len));
-				de =3D de1;
+		bh2 =3D ext3_append (handle, dir, &newblock, &err);
+		if (!(bh2))
+			goto cleanup;
+		node2 =3D (struct dx_node *)(bh2->b_data);
+		entries2 =3D node2->entries;
+		node2->fake.rec_len =3D cpu_to_le16(sb->s_blocksize);
+		node2->fake.inode =3D 0;
+		BUFFER_TRACE(frame->bh, "get_write_access");
+		err =3D ext3_journal_get_write_access(handle, frame->bh);
+		if (err)
+			goto journal_error;
+		if (levels) {
+			unsigned icount1 =3D icount/2, icount2 =3D icount - icount1;
+			unsigned hash2 =3D dx_get_hash(entries + icount1);
+			dxtrace(printk("Split index %i/%i\n", icount1, icount2));
+			=09
+			BUFFER_TRACE(frame->bh, "get_write_access"); /* index root */
+			err =3D ext3_journal_get_write_access(handle,
+							     frames[0].bh);
+			if (err)
+				goto journal_error;
+			=09
+			memcpy ((char *) entries2, (char *) (entries + icount1),
+				icount2 * sizeof(struct dx_entry));
+			dx_set_count (entries, icount1);
+			dx_set_count (entries2, icount2);
+			dx_set_limit (entries2, dx_node_limit(dir));
+
+			/* Which index block gets the new entry? */
+			if (at - entries >=3D icount1) {
+				frame->at =3D at =3D at - entries - icount1 + entries2;
+				frame->entries =3D entries =3D entries2;
+				swap(frame->bh, bh2);
 			}
-			de->file_type =3D EXT3_FT_UNKNOWN;
-			if (inode) {
-				de->inode =3D cpu_to_le32(inode->i_ino);
-				ext3_set_de_type(dir->i_sb, de, inode->i_mode);
-			} else
-				de->inode =3D 0;
-			de->name_len =3D namelen;
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
-			dir->i_mtime =3D dir->i_ctime =3D CURRENT_TIME;
-			dir->u.ext3_i.i_flags &=3D ~EXT3_INDEX_FL;
-			dir->i_version =3D ++event;
-			ext3_mark_inode_dirty(handle, dir);
-			BUFFER_TRACE(bh, "call ext3_journal_dirty_metadata");
-			ext3_journal_dirty_metadata(handle, bh);
-			brelse(bh);
-			return 0;
+			dx_insert_block (frames + 0, hash2, newblock);
+			dxtrace(dx_show_index ("node", frames[1].entries));
+			dxtrace(dx_show_index ("node",
+			       ((struct dx_node *) bh2->b_data)->entries));
+			err =3D ext3_journal_dirty_metadata(handle, bh2);
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
+			((struct dx_root *) frames[0].bh->b_data)->info.indirect_levels =3D 1;
+
+			/* Add new access path frame */
+			frame =3D frames + 1;
+			frame->at =3D at =3D at - entries + entries2;
+			frame->entries =3D entries =3D entries2;
+			frame->bh =3D bh2;
+			err =3D ext3_journal_get_write_access(handle,
+							     frame->bh);
+			if (err)
+				goto journal_error;
 		}
-		offset +=3D le16_to_cpu(de->rec_len);
-		de =3D (struct ext3_dir_entry_2 *)
-			((char *) de + le16_to_cpu(de->rec_len));
+		ext3_journal_dirty_metadata(handle, frames[0].bh);
 	}
-	brelse (bh);
-	return -ENOSPC;
+	de =3D do_split(handle, dir, &bh, frame, &hinfo, &err);
+	if (!de)
+		goto cleanup;
+	err =3D add_dirent_to_buf(handle, dentry, inode, de, bh);
+	bh =3D 0;
+	goto cleanup;
+=09
+journal_error:
+	ext3_std_error(dir->i_sb, err);
+cleanup:
+	if (bh)
+		brelse(bh);
+	dx_release(frames);
+	return err;
 }
+#endif
=20
 /*
  * ext3_delete_entry deletes a directory entry by merging it with the
@@ -456,9 +1548,11 @@
 	struct inode * inode;
 	int err;
=20
-	handle =3D ext3_journal_start(dir, EXT3_DATA_TRANS_BLOCKS + 3);
-	if (IS_ERR(handle))
+	handle =3D ext3_journal_start(dir, EXT3_DATA_TRANS_BLOCKS +
+					EXT3_INDEX_EXTRA_TRANS_BLOCKS + 3);
+	if (IS_ERR(handle)) {
 		return PTR_ERR(handle);
+	}
=20
 	if (IS_SYNC(dir))
 		handle->h_sync =3D 1;
@@ -482,9 +1576,11 @@
 	struct inode *inode;
 	int err;
=20
-	handle =3D ext3_journal_start(dir, EXT3_DATA_TRANS_BLOCKS + 3);
-	if (IS_ERR(handle))
+	handle =3D ext3_journal_start(dir, EXT3_DATA_TRANS_BLOCKS +
+			 		EXT3_INDEX_EXTRA_TRANS_BLOCKS + 3);
+	if (IS_ERR(handle)) {
 		return PTR_ERR(handle);
+	}
=20
 	if (IS_SYNC(dir))
 		handle->h_sync =3D 1;
@@ -513,9 +1609,11 @@
 	if (dir->i_nlink >=3D EXT3_LINK_MAX)
 		return -EMLINK;
=20
-	handle =3D ext3_journal_start(dir, EXT3_DATA_TRANS_BLOCKS + 3);
-	if (IS_ERR(handle))
+	handle =3D ext3_journal_start(dir, EXT3_DATA_TRANS_BLOCKS +
+					EXT3_INDEX_EXTRA_TRANS_BLOCKS + 3);
+	if (IS_ERR(handle)) {
 		return PTR_ERR(handle);
+	}
=20
 	if (IS_SYNC(dir))
 		handle->h_sync =3D 1;
@@ -527,7 +1625,7 @@
=20
 	inode->i_op =3D &ext3_dir_inode_operations;
 	inode->i_fop =3D &ext3_dir_operations;
-	inode->i_size =3D inode->u.ext3_i.i_disksize =3D inode->i_sb->s_blocksize;
+	inode->i_size =3D EXT3_I(inode)->i_disksize =3D inode->i_sb->s_blocksize;
 	dir_block =3D ext3_bread (handle, inode, 0, 1, &err);
 	if (!dir_block) {
 		inode->i_nlink--; /* is this nlink =3D=3D 0? */
@@ -556,21 +1654,19 @@
 	brelse (dir_block);
 	ext3_mark_inode_dirty(handle, inode);
 	err =3D ext3_add_entry (handle, dentry, inode);
-	if (err)
-		goto out_no_entry;
+	if (err) {
+		inode->i_nlink =3D 0;
+		ext3_mark_inode_dirty(handle, inode);
+		iput (inode);
+		goto out_stop;
+	}
 	dir->i_nlink++;
-	dir->u.ext3_i.i_flags &=3D ~EXT3_INDEX_FL;
+	ext3_update_dx_flag(dir);
 	ext3_mark_inode_dirty(handle, dir);
 	d_instantiate(dentry, inode);
 out_stop:
 	ext3_journal_stop(handle, dir);
 	return err;
-
-out_no_entry:
-	inode->i_nlink =3D 0;
-	ext3_mark_inode_dirty(handle, inode);
-	iput (inode);
-	goto out_stop;
 }
=20
 /*
@@ -657,7 +1753,7 @@
 	int err =3D 0, rc;
 =09
 	lock_super(sb);
-	if (!list_empty(&inode->u.ext3_i.i_orphan))
+	if (!list_empty(&EXT3_I(inode)->i_orphan))
 		goto out_unlock;
=20
 	/* Orphan handling is only valid for files with data blocks
@@ -698,7 +1794,7 @@
 	 * This is safe: on error we're going to ignore the orphan list
 	 * anyway on the next recovery. */
 	if (!err)
-		list_add(&inode->u.ext3_i.i_orphan, &EXT3_SB(sb)->s_orphan);
+		list_add(&EXT3_I(inode)->i_orphan, &EXT3_SB(sb)->s_orphan);
=20
 	jbd_debug(4, "superblock will point to %ld\n", inode->i_ino);
 	jbd_debug(4, "orphan inode %ld will point to %d\n",
@@ -716,25 +1812,26 @@
 int ext3_orphan_del(handle_t *handle, struct inode *inode)
 {
 	struct list_head *prev;
+ 	struct ext3_inode_info *ei =3D EXT3_I(inode);
 	struct ext3_sb_info *sbi;
 	unsigned long ino_next;
 	struct ext3_iloc iloc;
 	int err =3D 0;
=20
 	lock_super(inode->i_sb);
-	if (list_empty(&inode->u.ext3_i.i_orphan)) {
+ 	if (list_empty(&ei->i_orphan)) {
 		unlock_super(inode->i_sb);
 		return 0;
 	}
=20
 	ino_next =3D NEXT_ORPHAN(inode);
-	prev =3D inode->u.ext3_i.i_orphan.prev;
+ 	prev =3D ei->i_orphan.prev;
 	sbi =3D EXT3_SB(inode->i_sb);
=20
 	jbd_debug(4, "remove inode %lu from orphan list\n", inode->i_ino);
=20
-	list_del(&inode->u.ext3_i.i_orphan);
-	INIT_LIST_HEAD(&inode->u.ext3_i.i_orphan);
+ 	list_del(&ei->i_orphan);
+ 	INIT_LIST_HEAD(&ei->i_orphan);
=20
 	/* If we're on an error path, we may not have a valid
 	 * transaction handle with which to update the orphan list on
@@ -795,8 +1892,9 @@
 	handle_t *handle;
=20
 	handle =3D ext3_journal_start(dir, EXT3_DELETE_TRANS_BLOCKS);
-	if (IS_ERR(handle))
+	if (IS_ERR(handle)) {
 		return PTR_ERR(handle);
+	}
=20
 	retval =3D -ENOENT;
 	bh =3D ext3_find_entry (dentry, &de);
@@ -834,7 +1932,7 @@
 	dir->i_nlink--;
 	inode->i_ctime =3D dir->i_ctime =3D dir->i_mtime =3D CURRENT_TIME;
 	ext3_mark_inode_dirty(handle, inode);
-	dir->u.ext3_i.i_flags &=3D ~EXT3_INDEX_FL;
+	ext3_update_dx_flag(dir);
 	ext3_mark_inode_dirty(handle, dir);
=20
 end_rmdir:
@@ -852,8 +1950,9 @@
 	handle_t *handle;
=20
 	handle =3D ext3_journal_start(dir, EXT3_DELETE_TRANS_BLOCKS);
-	if (IS_ERR(handle))
+	if (IS_ERR(handle)) {
 		return PTR_ERR(handle);
+	}
=20
 	if (IS_SYNC(dir))
 		handle->h_sync =3D 1;
@@ -880,7 +1979,7 @@
 	if (retval)
 		goto end_unlink;
 	dir->i_ctime =3D dir->i_mtime =3D CURRENT_TIME;
-	dir->u.ext3_i.i_flags &=3D ~EXT3_INDEX_FL;
+	ext3_update_dx_flag(dir);
 	ext3_mark_inode_dirty(handle, dir);
 	inode->i_nlink--;
 	if (!inode->i_nlink)
@@ -906,9 +2005,11 @@
 	if (l > dir->i_sb->s_blocksize)
 		return -ENAMETOOLONG;
=20
-	handle =3D ext3_journal_start(dir, EXT3_DATA_TRANS_BLOCKS + 5);
-	if (IS_ERR(handle))
+	handle =3D ext3_journal_start(dir, EXT3_DATA_TRANS_BLOCKS +
+			 		EXT3_INDEX_EXTRA_TRANS_BLOCKS + 5);
+	if (IS_ERR(handle)) {
 		return PTR_ERR(handle);
+	}
=20
 	if (IS_SYNC(dir))
 		handle->h_sync =3D 1;
@@ -918,7 +2019,7 @@
 	if (IS_ERR(inode))
 		goto out_stop;
=20
-	if (l > sizeof (inode->u.ext3_i.i_data)) {
+	if (l > sizeof (EXT3_I(inode)->i_data)) {
 		inode->i_op =3D &ext3_symlink_inode_operations;
 		inode->i_mapping->a_ops =3D &ext3_aops;
 		/*
@@ -927,24 +2028,22 @@
 		 * i_size in generic_commit_write().
 		 */
 		err =3D block_symlink(inode, symname, l);
-		if (err)
-			goto out_no_entry;
+ 		if (err) {
+ 			ext3_dec_count(handle, inode);
+ 			ext3_mark_inode_dirty(handle, inode);
+ 			iput (inode);
+ 			goto out_stop;
+ 		}
 	} else {
 		inode->i_op =3D &ext3_fast_symlink_inode_operations;
-		memcpy((char*)&inode->u.ext3_i.i_data,symname,l);
+ 		memcpy((char*)&EXT3_I(inode)->i_data,symname,l);
 		inode->i_size =3D l-1;
 	}
-	inode->u.ext3_i.i_disksize =3D inode->i_size;
+ 	EXT3_I(inode)->i_disksize =3D inode->i_size;
 	err =3D ext3_add_nondir(handle, dentry, inode);
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
=20
 static int ext3_link (struct dentry * old_dentry,
@@ -957,12 +2056,15 @@
 	if (S_ISDIR(inode->i_mode))
 		return -EPERM;
=20
-	if (inode->i_nlink >=3D EXT3_LINK_MAX)
+	if (inode->i_nlink >=3D EXT3_LINK_MAX) {
 		return -EMLINK;
+	}
=20
-	handle =3D ext3_journal_start(dir, EXT3_DATA_TRANS_BLOCKS);
-	if (IS_ERR(handle))
+	handle =3D ext3_journal_start(dir, EXT3_DATA_TRANS_BLOCKS +
+					EXT3_INDEX_EXTRA_TRANS_BLOCKS);
+	if (IS_ERR(handle)) {
 		return PTR_ERR(handle);
+	}
=20
 	if (IS_SYNC(dir))
 		handle->h_sync =3D 1;
@@ -995,9 +2097,11 @@
=20
 	old_bh =3D new_bh =3D dir_bh =3D NULL;
=20
-	handle =3D ext3_journal_start(old_dir, 2 * EXT3_DATA_TRANS_BLOCKS + 2);
-	if (IS_ERR(handle))
+	handle =3D ext3_journal_start(old_dir, 2 * EXT3_DATA_TRANS_BLOCKS +
+			 		EXT3_INDEX_EXTRA_TRANS_BLOCKS + 2);
+	if (IS_ERR(handle)) {
 		return PTR_ERR(handle);
+	}
=20
 	if (IS_SYNC(old_dir) || IS_SYNC(new_dir))
 		handle->h_sync =3D 1;
@@ -1070,14 +2174,37 @@
 	/*
 	 * ok, that's it
 	 */
-	ext3_delete_entry(handle, old_dir, old_de, old_bh);
+	if (le32_to_cpu(old_de->inode) !=3D old_inode->i_ino ||
+	    old_de->name_len !=3D old_dentry->d_name.len ||
+	    strncmp(old_de->name, old_dentry->d_name.name, old_de->name_len) ||
+	    (retval =3D ext3_delete_entry(handle, old_dir,
+					old_de, old_bh)) =3D=3D -ENOENT) {
+		/* old_de could have moved from under us during htree split, so
+		 * make sure that we are deleting the right entry.  We might
+		 * also be pointing to a stale entry in the unused part of
+		 * old_bh so just checking inum and the name isn't enough. */
+		struct buffer_head *old_bh2;
+		struct ext3_dir_entry_2 *old_de2;
+
+		old_bh2 =3D ext3_find_entry(old_dentry, &old_de2);
+		if (old_bh2) {
+			retval =3D ext3_delete_entry(handle, old_dir,
+						   old_de2, old_bh2);
+			brelse(old_bh2);
+		}
+	}
+	if (retval) {
+		ext3_warning(old_dir->i_sb, "ext3_rename",
+				"Deleting old file (%lu), %d, error=3D%d",
+				old_dir->i_ino, old_dir->i_nlink, retval);
+	}
=20
 	if (new_inode) {
 		new_inode->i_nlink--;
 		new_inode->i_ctime =3D CURRENT_TIME;
 	}
 	old_dir->i_ctime =3D old_dir->i_mtime =3D CURRENT_TIME;
-	old_dir->u.ext3_i.i_flags &=3D ~EXT3_INDEX_FL;
+	ext3_update_dx_flag(old_dir);
 	if (dir_bh) {
 		BUFFER_TRACE(dir_bh, "get_write_access");
 		ext3_journal_get_write_access(handle, dir_bh);
@@ -1089,7 +2212,7 @@
 			new_inode->i_nlink--;
 		} else {
 			new_dir->i_nlink++;
-			new_dir->u.ext3_i.i_flags &=3D ~EXT3_INDEX_FL;
+			ext3_update_dx_flag(new_dir);
 			ext3_mark_inode_dirty(handle, new_dir);
 		}
 	}
Index: linux-2.4.21-chaos/fs/ext3/super.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.4.21-chaos.orig/fs/ext3/super.c	2003-12-12 16:17:59.000000000 +=
0300
+++ linux-2.4.21-chaos/fs/ext3/super.c	2003-12-12 16:18:17.000000000 +0300
@@ -777,6 +777,7 @@
 	es->s_mtime =3D cpu_to_le32(CURRENT_TIME);
 	ext3_update_dynamic_rev(sb);
 	EXT3_SET_INCOMPAT_FEATURE(sb, EXT3_FEATURE_INCOMPAT_RECOVER);
+
 	ext3_commit_super (sb, es, 1);
 	if (test_opt (sb, DEBUG))
 		printk (KERN_INFO
@@ -787,6 +788,7 @@
 			EXT3_BLOCKS_PER_GROUP(sb),
 			EXT3_INODES_PER_GROUP(sb),
 			sbi->s_mount_opt);
+
 	printk(KERN_INFO "EXT3 FS " EXT3FS_VERSION ", " EXT3FS_DATE " on %s, ",
 				bdevname(sb->s_dev));
 	if (EXT3_SB(sb)->s_journal->j_inode =3D=3D NULL) {
@@ -960,6 +962,7 @@
 	return res;
 }
=20
+
 struct super_block * ext3_read_super (struct super_block * sb, void * data,
 				      int silent)
 {
@@ -1146,6 +1149,9 @@
 	sbi->s_mount_state =3D le16_to_cpu(es->s_state);
 	sbi->s_addr_per_block_bits =3D log2(EXT3_ADDR_PER_BLOCK(sb));
 	sbi->s_desc_per_block_bits =3D log2(EXT3_DESC_PER_BLOCK(sb));
+	for (i=3D0; i < 4; i++)
+		sbi->s_hash_seed[i] =3D le32_to_cpu(es->s_hash_seed[i]);
+	sbi->s_def_hash_version =3D es->s_def_hash_version;
=20
 	if (sbi->s_blocks_per_group > blocksize * 8) {
 		printk (KERN_ERR
@@ -1938,6 +1944,7 @@
 	unregister_filesystem(&ext3_fs_type);
 }
=20
+EXPORT_SYMBOL(ext3_force_commit);
 EXPORT_SYMBOL(ext3_bread);
=20
 MODULE_AUTHOR("Remy Card, Stephen Tweedie, Andrew Morton, Andreas Dilger, =
Theodore Ts'o and others");
Index: linux-2.4.21-chaos/include/linux/ext3_fs.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.4.21-chaos.orig/include/linux/ext3_fs.h	2003-12-05 16:54:33.000=
000000 +0300
+++ linux-2.4.21-chaos/include/linux/ext3_fs.h	2003-12-12 16:18:17.00000000=
0 +0300
@@ -40,6 +40,11 @@
 #define EXT3FS_VERSION		"2.4-0.9.19"
=20
 /*
+ * Always enable hashed directories
+ */
+#define CONFIG_EXT3_INDEX
+
+/*
  * Debug code
  */
 #ifdef EXT3FS_DEBUG
@@ -415,8 +420,11 @@
 /*E0*/	__u32	s_journal_inum;		/* inode number of journal file */
 	__u32	s_journal_dev;		/* device number of journal file */
 	__u32	s_last_orphan;		/* start of list of inodes to delete */
-
-/*EC*/	__u32	s_reserved[197];	/* Padding to the end of the block */
+	__u32	s_hash_seed[4];		/* HTREE hash seed */
+	__u8	s_def_hash_version;	/* Default hash version to use */
+	__u8	s_reserved_char_pad;
+	__u16	s_reserved_word_pad;
+	__u32	s_reserved[192];	/* Padding to the end of the block */
 };
=20
 #ifdef __KERNEL__
@@ -553,9 +561,46 @@
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
+#define EXT3_DIR_LINK_MAX(dir) (!is_dx(dir) && (dir)->i_nlink >=3D EXT3_LI=
NK_MAX)
+#define EXT3_DIR_LINK_EMPTY(dir) ((dir)->i_nlink =3D=3D 2 || (dir)->i_nlin=
k =3D=3D 1)
+#else
+  #define is_dx(dir) 0
+#define EXT3_DIR_LINK_MAX(dir) ((dir)->i_nlink >=3D EXT3_LINK_MAX)
+#define EXT3_DIR_LINK_EMPTY(dir) ((dir)->i_nlink =3D=3D 2)
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
=20
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
@@ -565,6 +610,27 @@
 	unsigned long block_group;
 };
=20
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
@@ -592,11 +658,20 @@
=20
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
=20
+/* hash.c */
+extern int ext3fs_dirhash(const char *name, int len, struct
+			  dx_hash_info *hinfo);
+
 /* ialloc.c */
 extern struct inode * ext3_new_inode (handle_t *, struct inode *, int);
 extern void ext3_free_inode (handle_t *, struct inode *);
@@ -630,6 +705,8 @@
 /* namei.c */
 extern int ext3_orphan_add(handle_t *, struct inode *);
 extern int ext3_orphan_del(handle_t *, struct inode *);
+extern int ext3_htree_fill_tree(struct file *dir_file, __u32 start_hash,
+				__u32 start_minor_hash, __u32 *next_hash);
=20
 /* super.c */
 extern void ext3_error (struct super_block *, const char *, const char *, =
...)
Index: linux-2.4.21-chaos/include/linux/ext3_fs_sb.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.4.21-chaos.orig/include/linux/ext3_fs_sb.h	2003-12-05 16:54:33.=
000000000 +0300
+++ linux-2.4.21-chaos/include/linux/ext3_fs_sb.h	2003-12-12 16:18:17.00000=
0000 +0300
@@ -62,6 +62,8 @@
 	int s_inode_size;
 	int s_first_ino;
 	u32 s_next_generation;
+	u32 s_hash_seed[4];
+	int s_def_hash_version;
=20
 	/* Journaling */
 	struct inode * s_journal_inode;
Index: linux-2.4.21-chaos/include/linux/ext3_jbd.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.4.21-chaos.orig/include/linux/ext3_jbd.h	2003-12-05 16:54:33.00=
0000000 +0300
+++ linux-2.4.21-chaos/include/linux/ext3_jbd.h	2003-12-12 16:18:17.0000000=
00 +0300
@@ -69,6 +69,8 @@
=20
 #define EXT3_RESERVE_TRANS_BLOCKS	12U
=20
+#define EXT3_INDEX_EXTRA_TRANS_BLOCKS	8
+
 int
 ext3_mark_iloc_dirty(handle_t *handle,=20
 		     struct inode *inode,
Index: linux-2.4.21-chaos/include/linux/rbtree.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.4.21-chaos.orig/include/linux/rbtree.h	2003-12-05 16:54:33.0000=
00000 +0300
+++ linux-2.4.21-chaos/include/linux/rbtree.h	2003-12-12 16:18:17.000000000=
 +0300
@@ -120,6 +120,8 @@
=20
 extern void rb_insert_color(rb_node_t *, rb_root_t *);
 extern void rb_erase(rb_node_t *, rb_root_t *);
+extern rb_node_t *rb_get_first(rb_root_t *root);
+extern rb_node_t *rb_get_next(rb_node_t *n);
=20
 static inline void rb_link_node(rb_node_t * node, rb_node_t * parent, rb_n=
ode_t ** rb_link)
 {
Index: linux-2.4.21-chaos/lib/rbtree.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.4.21-chaos.orig/lib/rbtree.c	2002-09-25 21:14:03.000000000 +0400
+++ linux-2.4.21-chaos/lib/rbtree.c	2003-12-12 16:18:17.000000000 +0300
@@ -17,6 +17,8 @@
   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
=20
   linux/lib/rbtree.c
+
+  rb_get_first and rb_get_next written by Theodore Ts'o, 9/8/2002
 */
=20
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
+	n =3D root->rb_node;
+	if (!n)
+		return 0;
+	while (n->rb_left)
+		n =3D n->rb_left;
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
+		n =3D n->rb_right;
+		while (n->rb_left)
+			n =3D n->rb_left;
+		return n;
+	} else {
+		while ((parent =3D n->rb_parent)) {
+			if (n =3D=3D parent->rb_left)
+				return parent;
+			n =3D parent;
+		}
+		return 0;
+	}
+}
+EXPORT_SYMBOL(rb_get_next);
+

--kK1uqZGE6pgsGNyR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ext3-nlinks.diff"
Content-Transfer-Encoding: quoted-printable

--- ./fs/ext3/namei.c.orig	2004-03-09 16:46:43.000000000 -0700
+++ ./fs/ext3/namei.c	2004-04-21 02:30:25.000000000 -0600
@@ -1533,13 +1539,20 @@ static int ext3_delete_entry (handle_t *
  * if it is needed.
  */
 static inline void ext3_inc_count(handle_t *handle, struct inode *inode)
 {
-	inode->i_nlink++;
+	if (is_dx(inode) && inode->i_nlink > 1) {
+		inode->i_nlink++;
+		if (inode->i_nlink >=3D 65000) /* limit is 16-bit i_links_count */
+			inode->i_nlink =3D 1;
+	} else {
+		inode->i_nlink++;
+	}
 }
=20
 static inline void ext3_dec_count(handle_t *handle, struct inode *inode)
 {
-	inode->i_nlink--;
+	if (!S_ISDIR(inode->i_mode) || inode->i_nlink > 2)
+		inode->i_nlink--;
 }
=20
 static int ext3_add_nondir(handle_t *handle,
@@ -1640,7 +1652,7 @@ static int ext3_mkdir(struct inode * dir
 	struct ext3_dir_entry_2 * de;
 	int err;
=20
-	if (dir->i_nlink >=3D EXT3_LINK_MAX)
+	if (EXT3_DIR_LINK_MAXED(dir))
 		return -EMLINK;
=20
 	handle =3D ext3_journal_start(dir, EXT3_DATA_TRANS_BLOCKS +
@@ -1662,7 +1674,7 @@ static int ext3_mkdir(struct inode * dir
 	inode->i_size =3D EXT3_I(inode)->i_disksize =3D inode->i_sb->s_blocksize;
 	dir_block =3D ext3_bread (handle, inode, 0, 1, &err);
 	if (!dir_block) {
-		inode->i_nlink--; /* is this nlink =3D=3D 0? */
+		ext3_dec_count(handle, inode); /* is this nlink =3D=3D 0? */
 		ext3_mark_inode_dirty(handle, inode);
 		iput (inode);
 		goto out_stop;
@@ -1694,7 +1706,7 @@ static int ext3_mkdir(struct inode * dir
 		iput (inode);
 		goto out_stop;
 	}
-	dir->i_nlink++;
+	ext3_inc_count(handle, dir);
 	ext3_update_dx_flag(dir);
 	ext3_mark_inode_dirty(handle, dir);
 	d_instantiate(dentry, inode);
@@ -1755,10 +1767,11 @@ static int empty_dir (struct inode * ino
 			}
 			de =3D (struct ext3_dir_entry_2 *) bh->b_data;
 		}
-		if (!ext3_check_dir_entry ("empty_dir", inode, de, bh,
-					   offset)) {
-			brelse (bh);
-			return 1;
+		if (!ext3_check_dir_entry("empty_dir", inode, de, bh, offset)) {
+			/* On error skip the de and offset to the next block. */
+			de =3D (void *)(bh->b_data + sb->s_blocksize);
+			offset =3D (offset | (sb->s_blocksize - 1)) + 1;
+			continue;
 		}
 		if (le32_to_cpu(de->inode)) {
 			brelse (bh);
@@ -1951,14 +1964,14 @@ static int ext3_rmdir (struct inode * di
 	retval =3D ext3_delete_entry(handle, dir, de, bh);
 	if (retval)
 		goto end_rmdir;
-	if (inode->i_nlink !=3D 2)
-		ext3_warning (inode->i_sb, "ext3_rmdir",
-			      "empty directory has nlink!=3D2 (%d)",
-			      inode->i_nlink);
+	if (!EXT3_DIR_LINK_EMPTY(inode))
+		ext3_warning(inode->i_sb, __FUNCTION__,
+			     "empty directory has too many links (%d)",
+			     inode->i_nlink);
 	inode->i_version =3D ++event;
 	inode->i_nlink =3D 0;
 	ext3_orphan_add(handle, inode);
-	dir->i_nlink--;
+	ext3_dec_count(handle, dir);
 	inode->i_ctime =3D dir->i_ctime =3D dir->i_mtime =3D CURRENT_TIME;
 	ext3_mark_inode_dirty(handle, inode);
 	ext3_update_dx_flag(dir);
@@ -2044,7 +2053,7 @@ static int ext3_unlink(struct inode * di
 	dir->i_ctime =3D dir->i_mtime =3D CURRENT_TIME;
 	ext3_update_dx_flag(dir);
 	ext3_mark_inode_dirty(handle, dir);
-	inode->i_nlink--;
+	ext3_dec_count(handle, inode);
 	if (!inode->i_nlink) {
 		ext3_try_to_delay_deletion(inode);
 		ext3_orphan_add(handle, inode);
@@ -2121,9 +2147,8 @@ static int ext3_link (struct dentry * ol
 	if (S_ISDIR(inode->i_mode))
 		return -EPERM;
=20
-	if (inode->i_nlink >=3D EXT3_LINK_MAX) {
+	if (EXT3_DIR_LINK_MAXED(inode))
 		return -EMLINK;
-	}
=20
 	handle =3D ext3_journal_start(dir, EXT3_DATA_TRANS_BLOCKS +
 					EXT3_INDEX_EXTRA_TRANS_BLOCKS);
@@ -2138,7 +2163,7 @@ static int ext3_link (struct dentry * ol
 	ext3_inc_count(handle, inode);
 	atomic_inc(&inode->i_count);
=20
-	err =3D ext3_add_nondir(handle, dentry, inode);
+	err =3D ext3_add_link(handle, dentry, inode);
 	ext3_orphan_del(handle, inode);
 	ext3_journal_stop(handle, dir);
 	return err;
@@ -2206,8 +2232,8 @@ static int ext3_rename (struct inode * o
 		if (le32_to_cpu(PARENT_INO(dir_bh->b_data)) !=3D old_dir->i_ino)
 			goto end_rename;
 		retval =3D -EMLINK;
-		if (!new_inode && new_dir!=3Dold_dir &&
-				new_dir->i_nlink >=3D EXT3_LINK_MAX)
+		if (!new_inode && new_dir !=3D old_dir &&
+		    EXT3_DIR_LINK_MAXED(new_dir))
 			goto end_rename;
 	}
 	if (!new_bh) {
@@ -2261,7 +2287,7 @@ static int ext3_rename (struct inode * o
 	}
=20
 	if (new_inode) {
-		new_inode->i_nlink--;
+		ext3_dec_count(handle, new_inode);
 		new_inode->i_ctime =3D CURRENT_TIME;
 	}
 	old_dir->i_ctime =3D old_dir->i_mtime =3D CURRENT_TIME;
@@ -2272,11 +2298,11 @@ static int ext3_rename (struct inode * o
 		PARENT_INO(dir_bh->b_data) =3D le32_to_cpu(new_dir->i_ino);
 		BUFFER_TRACE(dir_bh, "call ext3_journal_dirty_metadata");
 		ext3_journal_dirty_metadata(handle, dir_bh);
-		old_dir->i_nlink--;
+		ext3_dec_count(handle, old_dir);
 		if (new_inode) {
-			new_inode->i_nlink--;
+			ext3_dec_count(handle, new_inode);
 		} else {
-			new_dir->i_nlink++;
+			ext3_inc_count(handle, new_dir);
 			ext3_update_dx_flag(new_dir);
 			ext3_mark_inode_dirty(handle, new_dir);
 		}
--- ./include/linux/ext3_fs.h.orig	2004-03-16 17:33:35.000000000 -0700
+++ ./include/linux/ext3_fs.h	2004-04-21 01:53:21.000000000 -0600
@@ -573,14 +573,15 @@ struct ext3_dir_entry_2 {
  */
=20
 #ifdef CONFIG_EXT3_INDEX
-  #define is_dx(dir) (EXT3_HAS_COMPAT_FEATURE(dir->i_sb, \
-					      EXT3_FEATURE_COMPAT_DIR_INDEX) && \
+#define is_dx(dir) (EXT3_HAS_COMPAT_FEATURE(dir->i_sb, \
+					    EXT3_FEATURE_COMPAT_DIR_INDEX) && \
 		      (EXT3_I(dir)->i_flags & EXT3_INDEX_FL))
-#define EXT3_DIR_LINK_MAX(dir) (!is_dx(dir) && (dir)->i_nlink >=3D EXT3_LI=
NK_MAX)
-#define EXT3_DIR_LINK_EMPTY(dir) ((dir)->i_nlink =3D=3D 2 || (dir)->i_nlin=
k =3D=3D 1)
+#define EXT3_DIR_LINK_MAXED(dir) (!is_dx(dir) && (dir)->i_nlink >=3DEXT3_L=
INK_MAX)
+#define EXT3_DIR_LINK_EMPTY(dir) ((dir)->i_nlink =3D=3D 2 || \
+				  (is_dx(dir) && (dir)->i_nlink =3D=3D 1))
 #else
   #define is_dx(dir) 0
-#define EXT3_DIR_LINK_MAX(dir) ((dir)->i_nlink >=3D EXT3_LINK_MAX)
+#define EXT3_DIR_LINK_MAXED(dir) ((dir)->i_nlink >=3D EXT3_LINK_MAX)
 #define EXT3_DIR_LINK_EMPTY(dir) ((dir)->i_nlink =3D=3D 2)
 #endif
=20

--kK1uqZGE6pgsGNyR--

--s9kDAZ2EyO0AcRYa
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFA7xuRpIg59Q01vtYRAuZjAJ0cjDXEYYdHsxDnbfuFtyUHLdGw6wCeOspe
8J9dBvR8M9866nDXXU6IcZM=
=oC1d
-----END PGP SIGNATURE-----

--s9kDAZ2EyO0AcRYa--
