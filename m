Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964866AbWIABpl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964866AbWIABpl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 21:45:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964881AbWIABpl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 21:45:41 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:64134 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S964866AbWIABpk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 21:45:40 -0400
Date: Thu, 31 Aug 2006 21:45:27 -0400
From: Josef Sipek <jsipek@cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, hch@infradead.org, akpm@osdl.org,
       viro@ftp.linux.org.uk
Subject: [PATCH 07/22][RFC] Unionfs: Directory file operations
Message-ID: <20060901014527.GH5788@fsl.cs.sunysb.edu>
References: <20060901013512.GA5788@fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060901013512.GA5788@fsl.cs.sunysb.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

This patch provides directory file operations.

Signed-off-by: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
Signed-off-by: David Quigley <dquigley@fsl.cs.sunysb.edu>
Signed-off-by: Erez Zadok <ezk@cs.sunysb.edu>

---

 fs/unionfs/dirfops.c |  270 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 270 insertions(+)

diff -Nur -x linux-2.6-git/Documentation/dontdiff linux-2.6-git/fs/unionfs/dirfops.c linux-2.6-git-unionfs/fs/unionfs/dirfops.c
--- linux-2.6-git/fs/unionfs/dirfops.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6-git-unionfs/fs/unionfs/dirfops.c	2006-08-31 19:04:00.000000000 -0400
@@ -0,0 +1,270 @@
+/*
+ * Copyright (c) 2003-2006 Erez Zadok
+ * Copyright (c) 2003-2006 Charles P. Wright
+ * Copyright (c) 2005-2006 Josef 'Jeff' Sipek
+ * Copyright (c) 2005-2006 Junjiro Okajima
+ * Copyright (c) 2005      Arun M. Krishnakumar
+ * Copyright (c) 2004-2006 David P. Quigley
+ * Copyright (c) 2003-2004 Mohammad Nayyer Zubair
+ * Copyright (c) 2003      Puja Gupta
+ * Copyright (c) 2003      Harikesavan Krishnan
+ * Copyright (c) 2003-2006 Stony Brook University
+ * Copyright (c) 2003-2006 The Research Foundation of State University of New York
+ *
+ * For specific licensing information, see the COPYING file distributed with
+ * this package.
+ *
+ * This Copyright notice must be kept intact and distributed with all sources.
+ */
+
+#include "union.h"
+
+/* Make sure our rdstate is playing by the rules. */
+static void verify_rdstate_offset(struct unionfs_dir_state *rdstate)
+{
+	BUG_ON(rdstate->uds_offset >= DIREOF);
+	BUG_ON(rdstate->uds_cookie >= MAXRDCOOKIE);
+}
+
+struct unionfs_getdents_callback {
+	struct unionfs_dir_state *rdstate;
+	void *dirent;
+	int entries_written;
+	int filldir_called;
+	int filldir_error;
+	filldir_t filldir;
+	struct super_block *sb;
+};
+
+/* copied from generic filldir in fs/readir.c */
+static int unionfs_filldir(void *dirent, const char *name, int namelen,
+			   loff_t offset, ino_t ino, unsigned int d_type)
+{
+	struct unionfs_getdents_callback *buf =
+	    (struct unionfs_getdents_callback *)dirent;
+	struct filldir_node *found = NULL;
+	int err = 0;
+	int is_wh_entry = 0;
+
+	buf->filldir_called++;
+
+	if ((namelen > UNIONFS_WHLEN) && !strncmp(name, UNIONFS_WHPFX, UNIONFS_WHLEN)) {
+		name += UNIONFS_WHLEN;
+		namelen -= UNIONFS_WHLEN;
+		is_wh_entry = 1;
+	}
+
+	found = find_filldir_node(buf->rdstate, name, namelen);
+
+	if (found)
+		goto out;
+
+	/* if 'name' isn't a whiteout filldir it. */
+	if (!is_wh_entry) {
+		off_t pos = rdstate2offset(buf->rdstate);
+		ino_t unionfs_ino = ino;
+
+		if (!err) {
+			err = buf->filldir(buf->dirent, name, namelen, pos,
+					   unionfs_ino, d_type);
+			buf->rdstate->uds_offset++;
+			verify_rdstate_offset(buf->rdstate);
+		}
+	}
+	/* If we did fill it, stuff it in our hash, otherwise return an error */
+	if (err) {
+		buf->filldir_error = err;
+		goto out;
+	}
+	buf->entries_written++;
+	if ((err = add_filldir_node(buf->rdstate, name, namelen,
+				    buf->rdstate->uds_bindex, is_wh_entry)))
+		buf->filldir_error = err;
+
+out:
+	return err;
+}
+
+static int unionfs_readdir(struct file *file, void *dirent, filldir_t filldir)
+{
+	int err = 0;
+	struct file *hidden_file = NULL;
+	struct inode *inode = NULL;
+	struct unionfs_getdents_callback buf;
+	struct unionfs_dir_state *uds;
+	int bend;
+	loff_t offset;
+
+	if ((err = unionfs_file_revalidate(file, 0)))
+		goto out;
+
+	inode = file->f_dentry->d_inode;
+
+	uds = ftopd(file)->rdstate;
+	if (!uds) {
+		if (file->f_pos == DIREOF) {
+			goto out;
+		} else if (file->f_pos > 0) {
+			uds = find_rdstate(inode, file->f_pos);
+			if (!uds) {
+				err = -ESTALE;
+				goto out;
+			}
+			ftopd(file)->rdstate = uds;
+		} else {
+			init_rdstate(file);
+			uds = ftopd(file)->rdstate;
+		}
+	}
+	bend = fbend(file);
+
+	while (uds->uds_bindex <= bend) {
+		hidden_file = ftohf_index(file, uds->uds_bindex);
+		if (!hidden_file) {
+			uds->uds_bindex++;
+			uds->uds_dirpos = 0;
+			continue;
+		}
+
+		/* prepare callback buffer */
+		buf.filldir_called = 0;
+		buf.filldir_error = 0;
+		buf.entries_written = 0;
+		buf.dirent = dirent;
+		buf.filldir = filldir;
+		buf.rdstate = uds;
+		buf.sb = inode->i_sb;
+
+		/* Read starting from where we last left off. */
+		offset = vfs_llseek(hidden_file, uds->uds_dirpos, 0);
+		if (offset < 0) {
+			err = offset;
+			goto out;
+		}
+		err = vfs_readdir(hidden_file, unionfs_filldir, (void *)&buf);
+		/* Save the position for when we continue. */
+
+		offset = vfs_llseek(hidden_file, 0, 1);
+		if (offset < 0) {
+			err = offset;
+			goto out;
+		}
+		uds->uds_dirpos = offset;
+
+		/* Copy the atime. */
+		fist_copy_attr_atime(inode, hidden_file->f_dentry->d_inode);
+
+		if (err < 0) {
+			goto out;
+		}
+
+		if (buf.filldir_error) {
+			break;
+		}
+
+		if (!buf.entries_written) {
+			uds->uds_bindex++;
+			uds->uds_dirpos = 0;
+		}
+	}
+
+	if (!buf.filldir_error && uds->uds_bindex >= bend) {
+		/* Save the number of hash entries for next time. */
+		itopd(inode)->uii_hashsize = uds->uds_hashentries;
+		free_rdstate(uds);
+		ftopd(file)->rdstate = NULL;
+		file->f_pos = DIREOF;
+	} else {
+		file->f_pos = rdstate2offset(uds);
+	}
+
+out:
+	return err;
+}
+
+/* This is not meant to be a generic repositioning function.  If you do
+ * things that aren't supported, then we return EINVAL.
+ *
+ * What is allowed:
+ *  (1) seeking to the same position that you are currently at
+ *	This really has no effect, but returns where you are.
+ *  (2) seeking to the end of the file, if you've read everything
+ *	This really has no effect, but returns where you are.
+ *  (3) seeking to the beginning of the file
+ *	This throws out all state, and lets you begin again.
+ */
+static loff_t unionfs_dir_llseek(struct file *file, loff_t offset, int origin)
+{
+	struct unionfs_dir_state *rdstate;
+	loff_t err;
+
+	if ((err = unionfs_file_revalidate(file, 0)))
+		goto out;
+
+	rdstate = ftopd(file)->rdstate;
+
+	/* We let users seek to their current position, but not anywhere else. */
+	if (!offset) {
+		switch (origin) {
+		case SEEK_SET:
+			if (rdstate) {
+				free_rdstate(rdstate);
+				ftopd(file)->rdstate = NULL;
+			}
+			init_rdstate(file);
+			err = 0;
+			break;
+		case SEEK_CUR:
+			err = file->f_pos;
+			break;
+		case SEEK_END:
+			/* Unsupported, because we would break everything.  */
+			err = -EINVAL;
+			break;
+		}
+	} else {
+		switch (origin) {
+		case SEEK_SET:
+			if (rdstate) {
+				if (offset == rdstate2offset(rdstate)) {
+					err = offset;
+				} else if (file->f_pos == DIREOF) {
+					err = DIREOF;
+				} else {
+					err = -EINVAL;
+				}
+			} else {
+				if ((rdstate = find_rdstate(file->f_dentry->d_inode,
+							offset))) {
+					ftopd(file)->rdstate = rdstate;
+					err = rdstate->uds_offset;
+				} else {
+					err = -EINVAL;
+				}
+			}
+			break;
+		case SEEK_CUR:
+		case SEEK_END:
+			/* Unsupported, because we would break everything.  */
+			err = -EINVAL;
+			break;
+		}
+	}
+
+out:
+	return err;
+}
+
+/* Trimmed directory options, we shouldn't pass everything down since
+ * we don't want to operate on partial directories.
+ */
+struct file_operations unionfs_dir_fops = {
+	.llseek = unionfs_dir_llseek,
+	.read = generic_read_dir,
+	.readdir = unionfs_readdir,
+	.unlocked_ioctl = unionfs_ioctl,
+	.open = unionfs_open,
+	.release = unionfs_file_release,
+	.flush = unionfs_flush,
+};
+
