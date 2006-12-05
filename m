Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030624AbWLETsb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030624AbWLETsb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 14:48:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030620AbWLETsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 14:48:30 -0500
Received: from mailer.gwdg.de ([134.76.10.26]:38284 "EHLO mailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030567AbWLETs3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 14:48:29 -0500
Date: Tue, 5 Dec 2006 20:41:18 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>
cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       hch@infradead.org, viro@ftp.linux.org.uk, linux-fsdevel@vger.kernel.org,
       mhalcrow@us.ibm.com
Subject: Re: [PATCH 31/35] Unionfs: Internal include file
In-Reply-To: <11652354721688-git-send-email-jsipek@cs.sunysb.edu>
Message-ID: <Pine.LNX.4.61.0612052028080.18570@yvahk01.tjqt.qr>
References: <1165235468365-git-send-email-jsipek@cs.sunysb.edu>
 <11652354721688-git-send-email-jsipek@cs.sunysb.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 4 2006 07:31, Josef 'Jeff' Sipek wrote:
>+++ b/fs/unionfs/union.h

>+#include <asm/mman.h>
>+#include <asm/system.h>
>+#include <linux/dcache.h>
>+#include <linux/file.h>

I think someone once said asm/s should be after all the linux/s.
Well, as long as it compiles, I have no objection it being before.

>+/* unionfs file systems superblock magic */
>+#define UNIONFS_SUPER_MAGIC 0xf15f083d

Put this in include/linux/magic.h instead?

>+/* How long should an entry be allowed to persist */
>+#define RDCACHE_JIFFIES 5*HZ

Put () around it.

>+/* Cache creation/deletion routines. */
>+void destroy_filldir_cache(void);
>+int init_filldir_cache(void);
>+int init_inode_cache(void);
>+void destroy_inode_cache(void);
>+int init_dentry_cache(void);
>+void destroy_dentry_cache(void);

In sioq.h and below, "extern"s are present before function
prototypes. No bias, just make it even across all code somehow.

>+/* Initialize and free readdir-specific  state. */
>+int init_rdstate(struct file *file);
>+struct unionfs_dir_state *alloc_rdstate(struct inode *inode, int bindex);
>+struct unionfs_dir_state *find_rdstate(struct inode *inode, loff_t fpos);
>+void free_rdstate(struct unionfs_dir_state *state);
>+int add_filldir_node(struct unionfs_dir_state *rdstate, const char *name,
>+		     int namelen, int bindex, int whiteout);
>+struct filldir_node *find_filldir_node(struct unionfs_dir_state *rdstate,
>+				       const char *name, int namelen);
>+
>+struct dentry **alloc_new_dentries(int objs);
>+struct unionfs_data *alloc_new_data(int objs);
>+
>+/* We can only use 32-bits of offset for rdstate --- blech! */
>+#define DIREOF (0xfffff)
>+#define RDOFFBITS 20		/* This is the number of bits in DIREOF. */
>+#define MAXRDCOOKIE (0xfff)
>+/* Turn an rdstate into an offset. */
>+static inline off_t rdstate2offset(struct unionfs_dir_state *buf)
>+{
>+	off_t tmp;
>+	tmp = ((buf->cookie & MAXRDCOOKIE) << RDOFFBITS)
>+		| (buf->offset & DIREOF);
>+	return tmp;
>+}
>+
>+#define unionfs_read_lock(sb) down_read(&UNIONFS_SB(sb)->rwsem)
>+#define unionfs_read_unlock(sb) up_read(&UNIONFS_SB(sb)->rwsem)
>+#define unionfs_write_lock(sb) down_write(&UNIONFS_SB(sb)->rwsem)
>+#define unionfs_write_unlock(sb) up_write(&UNIONFS_SB(sb)->rwsem)
>+
>+/* The double lock function needs to go after the debugmacros, so that
>+ * dtopd is defined.  */
     ^^^^^

This was changed, was not it? :)

>+static inline void double_lock_dentry(struct dentry *d1, struct dentry *d2)
>+{
>+	if (d2 < d1) {

What is this supposed to do? Is it guaranteed that a
later-allocated dentry always has a lower/higher address than one
allocated before?

>+		struct dentry *tmp = d1;
>+		d1 = d2;
>+		d2 = tmp;
>+	}
>+	lock_dentry(d1);
>+	lock_dentry(d2);
>+}
>+
>+extern int new_dentry_private_data(struct dentry *dentry);
>+void free_dentry_private_data(struct unionfs_dentry_info *udi);
>+void update_bstart(struct dentry *dentry);
>+

[bigger snip]

>+/* The values for unionfs_interpose's flag. */
>+#define INTERPOSE_DEFAULT	0
>+#define INTERPOSE_LOOKUP	1
>+#define INTERPOSE_REVAL		2
>+#define INTERPOSE_REVAL_NEG	3
>+#define INTERPOSE_PARTIAL	4

I vote for enums! Who joins?


>+/* The root directory is unhashed, but isn't deleted. */
>+static inline int d_deleted(struct dentry *d)
>+{
>+	return d_unhashed(d) && (d != d->d_sb->s_root);
>+}

() around the != expr is redundant.

>+/* returns the sum of the n_link values of all the underlying inodes of the
>+ * passed inode */
>+static inline int unionfs_get_nlinks(struct inode *inode)
>+{
>...
>+		/* A broken directory (e.g., squashfs). */
>...

You're so mean :>
Though I can't recall right now, squashfs is not the only one doing
that.

>+#define IS_SET(sb, check_flag) (check_flag & MOUNT_FLAG(sb))

#define IS_SET(sb, check_flag) ((check_flag) & MOUNT_FLAG(sb))

>+#define IS_WRITE_FLAG(flag) ((flag) & (OPEN_WRITE_FLAGS))

#define IS_WRITE_FLAG(flag) ((flag) & OPEN_WRITE_FLAGS)

>+static inline int branchperms(struct super_block *sb, int index)
>+{
>+	BUG_ON(index < 0);
>+
>+	return UNIONFS_SB(sb)->data[index].branchperms;
>+}

This could have const struct super_block *sb;

>+
>+static inline int set_branchperms(struct super_block *sb, int index, int perms)
>+{
>+	BUG_ON(index < 0);
>+
>+	UNIONFS_SB(sb)->data[index].branchperms = perms;
>+
>+	return perms;
>+}

This one I don't think,

>+/* Is this file on a read-only branch? */
>+static inline int is_robranch_super(struct super_block *sb, int index)
>+{
>+	return (!(branchperms(sb, index) & MAY_WRITE)) ? -EROFS : 0;
>+}

But this one. Check others.

>+/* Is this file on a read-only branch? */
>+static inline int is_robranch_idx(struct dentry *dentry, int index)
>+{
>+	int err = 0;
>+
>+	BUG_ON(index < 0);
>+
>+	if ((!(branchperms(dentry->d_sb, index) & MAY_WRITE)) ||
>+	    IS_RDONLY(unionfs_lower_dentry_idx(dentry, index)->d_inode))
>+		err = -EROFS;
>+
>+	return err;
>+}
>+
>+static inline int is_robranch(struct dentry *dentry)
>+{
>+	int index;
>+
>+	index = UNIONFS_D(dentry)->bstart;
>+	BUG_ON(index < 0);
>+
>+	return is_robranch_idx(dentry, index);
>+}
>+
>+/* What do we use for whiteouts. */
>+#define UNIONFS_WHPFX ".wh."
>+#define UNIONFS_WHLEN 4
>+/* If a directory contains this file, then it is opaque.  We start with the
>+ * .wh. flag so that it is blocked by lookup.
>+ */
>+#define UNIONFS_DIR_OPAQUE_NAME "__dir_opaque"
>+#define UNIONFS_DIR_OPAQUE UNIONFS_WHPFX UNIONFS_DIR_OPAQUE_NAME
>+
>+/* construct whiteout filename */
>+static inline char *alloc_whname(const char *name, int len)
>+{
>+	char *buf;
>+
>+	buf = kmalloc(len + UNIONFS_WHLEN + 1, GFP_KERNEL);
>+	if (!buf)
>+		return ERR_PTR(-ENOMEM);
>+
>+	strcpy(buf, UNIONFS_WHPFX);
>+	strlcat(buf, name, len + UNIONFS_WHLEN + 1);
>+
>+	return buf;
>+}
>+
>+#define VALID_MOUNT_FLAGS (0)
>+
>+/*
>+ * MACROS:
>+ */
>+
>+#ifndef DEFAULT_POLLMASK
>+#define DEFAULT_POLLMASK (POLLIN | POLLOUT | POLLRDNORM | POLLWRNORM)
>+#endif
>+
>+/*
>+ * EXTERNALS:
>+ */
>+
>+/* These two functions are here because it is kind of daft to copy and paste the
>+ * contents of the two functions to 32+ places in unionfs
>+ */
>+static inline struct dentry *lock_parent(struct dentry *dentry)
>+{
>+	struct dentry *dir = dget(dentry->d_parent);
>+
>+	mutex_lock(&dir->d_inode->i_mutex);
>+	return dir;
>+}
>+
>+static inline void unlock_dir(struct dentry *dir)
>+{
>+	mutex_unlock(&dir->d_inode->i_mutex);
>+	dput(dir);
>+}
>+
>+extern int make_dir_opaque(struct dentry *dir, int bindex);
>+
>+#endif	/* not _UNION_H_ */
>+


	-`J'
-- 
