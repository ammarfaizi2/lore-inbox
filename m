Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263201AbUKTXbw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263201AbUKTXbw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 18:31:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261597AbUKTX2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 18:28:16 -0500
Received: from mail.euroweb.hu ([193.226.220.4]:42379 "HELO mail.euroweb.hu")
	by vger.kernel.org with SMTP id S263201AbUKTXK4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 18:10:56 -0500
To: akpm@osdl.org, torvalds@osdl.org
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/13] Filesystem in Userspace
Message-Id: <E1CVeNN-0007Po-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sun, 21 Nov 2004 00:10:41 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the write filesystem operations of FUSE.

The following operations are added:

 o setattr
 o symlink
 o mknod
 o mkdir
 o create
 o unlink
 o rmdir
 o rename
 o link

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
--- linux-2.6.10-rc2/fs/fuse/dir.c	2004-11-20 22:56:24.000000000 +0100
+++ linux-2.6.10-rc2-fuse/fs/fuse/dir.c	2004-11-20 22:56:24.000000000 +0100
@@ -200,6 +200,289 @@ static int fuse_lookup_iget(struct inode
 	return 0;
 }
 
+static void fuse_invalidate_attr(struct inode *inode)
+{
+	struct fuse_inode *fi = INO_FI(inode);
+	fi->i_time = jiffies - 1;
+}
+
+static int lookup_new_entry(struct fuse_conn *fc, struct fuse_req *req,
+			    struct inode *dir, struct dentry *entry,
+			    struct fuse_entry_out *outarg, int version,
+			    int mode)
+{
+	struct inode *inode;
+	struct fuse_inode *fi;
+	inode = fuse_iget(dir->i_sb, outarg->nodeid, outarg->generation, 
+			  &outarg->attr, version);
+	if (!inode) {
+		fuse_send_forget(fc, req, outarg->nodeid, version);
+		return -ENOMEM;
+	}
+	fuse_put_request(fc, req);
+
+	/* Don't allow userspace to do really stupid things... */
+	if ((inode->i_mode ^ mode) & S_IFMT) {
+		iput(inode);
+		printk("fuse_mknod: inode has wrong type\n");
+		return -EPROTO;
+	}
+
+	entry->d_time = time_to_jiffies(outarg->entry_valid,
+					outarg->entry_valid_nsec);
+
+	fi = INO_FI(inode);
+	fi->i_time = time_to_jiffies(outarg->attr_valid,
+				     outarg->attr_valid_nsec);
+
+	d_instantiate(entry, inode);
+	fuse_invalidate_attr(dir);
+	return 0;
+}
+
+static int fuse_mknod(struct inode *dir, struct dentry *entry, int mode,
+		      dev_t rdev)
+{
+	struct fuse_conn *fc = INO_FC(dir);
+	struct fuse_inode *fi = INO_FI(dir);
+	struct fuse_req *req = fuse_get_request(fc);
+	struct fuse_mknod_in inarg;
+	struct fuse_entry_out outarg;
+	int err;
+
+	if (!req)
+		return -ERESTARTSYS;
+
+	memset(&inarg, 0, sizeof(inarg));
+	inarg.mode = mode;
+	inarg.rdev = new_encode_dev(rdev);
+	req->in.h.opcode = FUSE_MKNOD;
+	req->in.h.nodeid = fi->nodeid;
+	req->in.numargs = 2;
+	req->in.args[0].size = sizeof(inarg);
+	req->in.args[0].value = &inarg;
+	req->in.args[1].size = entry->d_name.len + 1;
+	req->in.args[1].value = entry->d_name.name;
+	req->out.numargs = 1;
+	req->out.args[0].size = sizeof(outarg);
+	req->out.args[0].value = &outarg;
+	request_send(fc, req);
+	err = req->out.h.error;
+	if (!err)
+		err = lookup_new_entry(fc, req, dir, entry, &outarg,
+				       req->out.h.unique, mode);
+	else
+		fuse_put_request(fc, req);
+	return err;
+}
+
+static int fuse_create(struct inode *dir, struct dentry *entry, int mode,
+		       struct nameidata *nd)
+{
+	return fuse_mknod(dir, entry, mode, 0);
+}
+
+static int fuse_mkdir(struct inode *dir, struct dentry *entry, int mode)
+{
+	struct fuse_conn *fc = INO_FC(dir);
+	struct fuse_inode *fi = INO_FI(dir);
+	struct fuse_req *req = fuse_get_request(fc);
+	struct fuse_mkdir_in inarg;
+	struct fuse_entry_out outarg;
+	int err;
+
+	if (!req)
+		return -ERESTARTSYS;
+
+	memset(&inarg, 0, sizeof(inarg));
+	inarg.mode = mode;
+	req->in.h.opcode = FUSE_MKDIR;
+	req->in.h.nodeid = fi->nodeid;
+	req->in.numargs = 2;
+	req->in.args[0].size = sizeof(inarg);
+	req->in.args[0].value = &inarg;
+	req->in.args[1].size = entry->d_name.len + 1;
+	req->in.args[1].value = entry->d_name.name;
+	req->out.numargs = 1;
+	req->out.args[0].size = sizeof(outarg);
+	req->out.args[0].value = &outarg;
+	request_send(fc, req);
+	err = req->out.h.error;
+	if (!err)
+		err = lookup_new_entry(fc, req, dir, entry, &outarg,
+				       req->out.h.unique, S_IFDIR);
+	else
+		fuse_put_request(fc, req);
+	return err;
+}
+
+static int fuse_symlink(struct inode *dir, struct dentry *entry,
+			const char *link)
+{
+	struct fuse_conn *fc = INO_FC(dir);
+	struct fuse_inode *fi = INO_FI(dir);
+	struct fuse_req *req;
+	struct fuse_entry_out outarg;
+	unsigned int len = strlen(link) + 1;
+	int err;
+	
+	if (len > FUSE_SYMLINK_MAX)
+		return -ENAMETOOLONG;
+
+	req = fuse_get_request(fc);
+	if (!req)
+		return -ERESTARTSYS;
+
+	req->in.h.opcode = FUSE_SYMLINK;
+	req->in.h.nodeid = fi->nodeid;
+	req->in.numargs = 2;
+	req->in.args[0].size = entry->d_name.len + 1;
+	req->in.args[0].value = entry->d_name.name;
+	req->in.args[1].size = len;
+	req->in.args[1].value = link;
+	req->out.numargs = 1;
+	req->out.args[0].size = sizeof(outarg);
+	req->out.args[0].value = &outarg;
+	request_send(fc, req);
+	err = req->out.h.error;
+	if (!err)
+		err = lookup_new_entry(fc, req, dir, entry, &outarg,
+				       req->out.h.unique, S_IFLNK);
+	else
+		fuse_put_request(fc, req);
+	return err;
+}
+
+static int fuse_unlink(struct inode *dir, struct dentry *entry)
+{
+	struct fuse_conn *fc = INO_FC(dir);
+	struct fuse_inode *fi = INO_FI(dir);
+	struct fuse_req *req = fuse_get_request(fc);
+	int err;
+	
+	if (!req)
+		return -ERESTARTSYS;
+
+	req->in.h.opcode = FUSE_UNLINK;
+	req->in.h.nodeid = fi->nodeid;
+	req->in.numargs = 1;
+	req->in.args[0].size = entry->d_name.len + 1;
+	req->in.args[0].value = entry->d_name.name;
+	request_send(fc, req);
+	err = req->out.h.error;
+	if (!err) {
+		struct inode *inode = entry->d_inode;
+		
+		/* Set nlink to zero so the inode can be cleared, if
+                   the inode does have more links this will be
+                   discovered at the next lookup/getattr */
+		inode->i_nlink = 0;
+		fuse_invalidate_attr(inode);
+		fuse_invalidate_attr(dir);
+	}
+	fuse_put_request(fc, req);
+	return err;
+}
+
+static int fuse_rmdir(struct inode *dir, struct dentry *entry)
+{
+	struct fuse_conn *fc = INO_FC(dir);
+	struct fuse_inode *fi = INO_FI(dir);
+	struct fuse_req *req = fuse_get_request(fc);
+	int err;
+	
+	if (!req)
+		return -ERESTARTSYS;
+
+	req->in.h.opcode = FUSE_RMDIR;
+	req->in.h.nodeid = fi->nodeid;
+	req->in.numargs = 1;
+	req->in.args[0].size = entry->d_name.len + 1;
+	req->in.args[0].value = entry->d_name.name;
+	request_send(fc, req);
+	err = req->out.h.error;
+	if (!err) {
+		entry->d_inode->i_nlink = 0;
+		fuse_invalidate_attr(dir);
+	}
+	fuse_put_request(fc, req);
+	return err;
+}
+
+static int fuse_rename(struct inode *olddir, struct dentry *oldent,
+		       struct inode *newdir, struct dentry *newent)
+{
+	struct fuse_conn *fc = INO_FC(olddir);
+	struct fuse_inode *oldfi = INO_FI(olddir);
+	struct fuse_inode *newfi = INO_FI(newdir);
+	struct fuse_req *req = fuse_get_request(fc);
+	struct fuse_rename_in inarg;
+	int err;
+
+	if (!req)
+		return -ERESTARTSYS;
+
+	memset(&inarg, 0, sizeof(inarg));
+	inarg.newdir = newfi->nodeid;
+	req->in.h.opcode = FUSE_RENAME;
+	req->in.h.nodeid = oldfi->nodeid;
+	req->in.numargs = 3;
+	req->in.args[0].size = sizeof(inarg);
+	req->in.args[0].value = &inarg;
+	req->in.args[1].size = oldent->d_name.len + 1;
+	req->in.args[1].value = oldent->d_name.name;
+	req->in.args[2].size = newent->d_name.len + 1;
+	req->in.args[2].value = newent->d_name.name;
+	request_send(fc, req);
+	err = req->out.h.error;
+	fuse_put_request(fc, req);
+	if (!err) {
+		fuse_invalidate_attr(olddir);
+		if (olddir != newdir)
+			fuse_invalidate_attr(newdir);
+	}
+	return err;
+}
+
+static int fuse_link(struct dentry *entry, struct inode *newdir,
+		     struct dentry *newent)
+{
+	struct inode *inode = entry->d_inode;
+	struct fuse_conn *fc = INO_FC(inode);
+	struct fuse_inode *fi = INO_FI(inode);
+	struct fuse_inode *newfi = INO_FI(newdir);
+	struct fuse_req *req = fuse_get_request(fc);
+	struct fuse_link_in inarg;
+	struct fuse_entry_out outarg;
+	int err;
+
+	if (!req)
+		return -ERESTARTSYS;
+
+	memset(&inarg, 0, sizeof(inarg));
+	inarg.newdir = newfi->nodeid;
+	req->in.h.opcode = FUSE_LINK;
+	req->in.h.nodeid = fi->nodeid;
+	req->in.numargs = 2;
+	req->in.args[0].size = sizeof(inarg);
+	req->in.args[0].value = &inarg;
+	req->in.args[1].size = newent->d_name.len + 1;
+	req->in.args[1].value = newent->d_name.name;
+	req->out.numargs = 1;
+	req->out.args[0].size = sizeof(outarg);
+	req->out.args[0].value = &outarg;
+	request_send(fc, req);
+	err = req->out.h.error;
+	if (!err) {
+		/* Invalidate old entry, so attributes are refreshed */
+		d_invalidate(entry);
+		err = lookup_new_entry(fc, req, newdir, newent, &outarg,
+				       req->out.h.unique, inode->i_mode);
+	} else
+		fuse_put_request(fc, req);
+	return err;
+}
+
 int fuse_do_getattr(struct inode *inode)
 {
 	struct fuse_inode *fi = INO_FI(inode);
@@ -428,6 +711,86 @@ static int fuse_dir_release(struct inode
 	return 0;
 }
 
+static unsigned int iattr_to_fattr(struct iattr *iattr,
+				   struct fuse_attr *fattr)
+{
+	unsigned int ivalid = iattr->ia_valid;
+	unsigned int fvalid = 0;
+	
+	memset(fattr, 0, sizeof(*fattr));
+	
+	if (ivalid & ATTR_MODE)
+		fvalid |= FATTR_MODE,   fattr->mode = iattr->ia_mode;
+	if (ivalid & ATTR_UID)
+		fvalid |= FATTR_UID,    fattr->uid = iattr->ia_uid;
+	if (ivalid & ATTR_GID)
+		fvalid |= FATTR_GID,    fattr->gid = iattr->ia_gid;
+	if (ivalid & ATTR_SIZE)
+		fvalid |= FATTR_SIZE,   fattr->size = iattr->ia_size;
+	/* You can only _set_ these together (they may change by themselves) */
+	if ((ivalid & (ATTR_ATIME | ATTR_MTIME)) == (ATTR_ATIME | ATTR_MTIME)) {
+		fvalid |= FATTR_ATIME | FATTR_MTIME;
+		fattr->atime = iattr->ia_atime.tv_sec;
+		fattr->mtime = iattr->ia_mtime.tv_sec;
+	}
+
+	return fvalid;
+}
+
+static int fuse_setattr(struct dentry *entry, struct iattr *attr)
+{
+	struct inode *inode = entry->d_inode;
+	struct fuse_conn *fc = INO_FC(inode);
+	struct fuse_inode *fi = INO_FI(inode);
+	struct fuse_req *req;
+	struct fuse_setattr_in inarg;
+	struct fuse_attr_out outarg;
+	int err;
+	int is_truncate = 0;
+	
+	if (attr->ia_valid & ATTR_SIZE) {
+		unsigned long limit;
+		is_truncate = 1;
+		limit = current->signal->rlim[RLIMIT_FSIZE].rlim_cur;
+		if (limit != RLIM_INFINITY && attr->ia_size > (loff_t) limit) {
+			send_sig(SIGXFSZ, current, 0);
+			return -EFBIG;
+		}
+	}
+
+	req = fuse_get_request(fc);
+	if (!req)
+		return -ERESTARTSYS;
+
+	memset(&inarg, 0, sizeof(inarg));
+	inarg.valid = iattr_to_fattr(attr, &inarg.attr);
+	req->in.h.opcode = FUSE_SETATTR;
+	req->in.h.nodeid = fi->nodeid;
+	req->in.numargs = 1;
+	req->in.args[0].size = sizeof(inarg);
+	req->in.args[0].value = &inarg;
+	req->out.numargs = 1;
+	req->out.args[0].size = sizeof(outarg);
+	req->out.args[0].value = &outarg;
+	request_send(fc, req);
+	err = req->out.h.error;
+	fuse_put_request(fc, req);
+
+	if (!err) {
+		if (is_truncate) {
+			loff_t origsize = i_size_read(inode);
+			i_size_write(inode, outarg.attr.size);
+			if (origsize > outarg.attr.size)
+				vmtruncate(inode, outarg.attr.size);
+		}
+		change_attributes(inode, &outarg.attr);
+		fi->i_time = time_to_jiffies(outarg.attr_valid,
+					     outarg.attr_valid_nsec);
+	}
+		
+	return err;
+}
+
 static int fuse_dentry_revalidate(struct dentry *entry, struct nameidata *nd)
 {
 	if (!entry->d_inode)
@@ -480,6 +843,15 @@ static struct dentry *fuse_lookup(struct
 
 static struct inode_operations fuse_dir_inode_operations = {
 	.lookup		= fuse_lookup,
+	.mkdir		= fuse_mkdir,
+	.symlink	= fuse_symlink,
+	.unlink		= fuse_unlink,
+	.rmdir		= fuse_rmdir,
+	.rename		= fuse_rename,
+	.link		= fuse_link,
+	.setattr	= fuse_setattr,
+	.create		= fuse_create,
+	.mknod		= fuse_mknod,
 	.permission	= fuse_permission,
 	.getattr	= fuse_getattr,
 };
@@ -492,11 +864,13 @@ static struct file_operations fuse_dir_o
 };
 
 static struct inode_operations fuse_file_inode_operations = {
+	.setattr	= fuse_setattr,
 	.permission	= fuse_permission,
 	.getattr	= fuse_getattr,
 };
 
 static struct inode_operations fuse_symlink_inode_operations = {
+	.setattr	= fuse_setattr,
 	.readlink	= fuse_readlink,
 	.follow_link	= fuse_follow_link,
 	.getattr	= fuse_getattr,
--- linux-2.6.10-rc2/include/linux/fuse.h	2004-11-20 22:56:24.000000000 +0100
+++ linux-2.6.10-rc2-fuse/include/linux/fuse.h	2004-11-20 22:56:24.000000000 +0100
@@ -50,20 +50,28 @@ struct fuse_kstatfs {
 	unsigned int        namelen;
 };
 
+#define FATTR_MODE	(1 << 0)
+#define FATTR_UID	(1 << 1)
+#define FATTR_GID	(1 << 2)
+#define FATTR_SIZE	(1 << 3)
+#define FATTR_ATIME	(1 << 4)
+#define FATTR_MTIME	(1 << 5)
+#define FATTR_CTIME	(1 << 6)
+
 enum fuse_opcode {
 	FUSE_LOOKUP	   = 1,
 	FUSE_FORGET	   = 2,  /* no reply */
 	FUSE_GETATTR	   = 3,
-	/* FUSE_SETATTR	   = 4, */
+	FUSE_SETATTR	   = 4,
 	FUSE_READLINK	   = 5,
-	/* FUSE_SYMLINK	   = 6, */
+	FUSE_SYMLINK	   = 6,
 	FUSE_GETDIR	   = 7,
-	/* FUSE_MKNOD	   = 8, */
-	/* FUSE_MKDIR	   = 9, */
-	/* FUSE_UNLINK	   = 10, */
-	/* FUSE_RMDIR	   = 11, */
-	/* FUSE_RENAME	   = 12, */
-	/* FUSE_LINK	   = 13, */
+	FUSE_MKNOD	   = 8,
+	FUSE_MKDIR	   = 9,
+	FUSE_UNLINK	   = 10,
+	FUSE_RMDIR	   = 11,
+	FUSE_RENAME	   = 12,
+	FUSE_LINK	   = 13,
 	/* FUSE_OPEN	   = 14, */
 	/* FUSE_READ	   = 15, */
 	/* FUSE_WRITE	   = 16, */
@@ -82,6 +90,7 @@ enum fuse_opcode {
 #define FUSE_MAX_IN 8192
 
 #define FUSE_NAME_MAX 1024
+#define FUSE_SYMLINK_MAX 4096
 
 struct fuse_entry_out {
 	unsigned long nodeid;      /* Inode ID */
@@ -108,6 +117,28 @@ struct fuse_getdir_out {
 	int fd;
 };
 
+struct fuse_mknod_in {
+	unsigned int mode;
+	unsigned int rdev;
+};
+
+struct fuse_mkdir_in {
+	unsigned int mode;
+};
+
+struct fuse_rename_in {
+	unsigned long newdir;
+};
+
+struct fuse_link_in {
+	unsigned long newdir;
+};
+
+struct fuse_setattr_in {
+	struct fuse_attr attr;
+	unsigned int valid;
+};
+
 struct fuse_statfs_out {
 	struct fuse_kstatfs st;
 };
