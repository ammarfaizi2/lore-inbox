Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262844AbVAKQo7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262844AbVAKQo7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 11:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262838AbVAKQoW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 11:44:22 -0500
Received: from adsl-298.mirage.euroweb.hu ([193.226.239.42]:30080 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262825AbVAKQ1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 11:27:50 -0500
To: akpm@osdl.org, torvalds@osdl.org
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/11] FUSE - read-write operations
Message-Id: <E1CoOrf-0003Km-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 11 Jan 2005 17:27:27 +0100
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
diff -Nurp a/fs/fuse/dir.c b/fs/fuse/dir.c
--- a/fs/fuse/dir.c	2005-01-11 16:28:29.000000000 +0100
+++ b/fs/fuse/dir.c	2005-01-11 16:28:28.000000000 +0100
@@ -120,6 +120,266 @@ static int fuse_lookup_iget(struct inode
 	return 0;
 }
 
+void fuse_invalidate_attr(struct inode *inode)
+{
+	get_fuse_inode(inode)->i_time = jiffies - 1;
+}
+
+static void fuse_invalidate_entry(struct dentry *entry)
+{
+	d_invalidate(entry);
+	entry->d_time = jiffies - 1;
+}
+
+static int create_new_entry(struct fuse_conn *fc, struct fuse_req *req,
+			    struct inode *dir, struct dentry *entry,
+			    int mode)
+{
+	struct fuse_entry_out outarg;
+	struct inode *inode;
+	struct fuse_inode *fi;
+	int version;
+	int err;
+
+	req->in.h.nodeid = get_node_id(dir);
+	req->inode = dir;
+	req->out.numargs = 1;
+	req->out.args[0].size = sizeof(outarg);
+	req->out.args[0].value = &outarg;
+	request_send(fc, req);
+	version = req->out.h.unique;
+	err = req->out.h.error;
+	if (err) {
+		fuse_put_request(fc, req);
+		return err;
+	}
+	inode = fuse_iget(dir->i_sb, outarg.nodeid, outarg.generation,
+			  &outarg.attr, version);
+	if (!inode) {
+		fuse_send_forget(fc, req, outarg.nodeid, version);
+		return -ENOMEM;
+	}
+	fuse_put_request(fc, req);
+
+	/* Don't allow userspace to do really stupid things... */
+	if ((inode->i_mode ^ mode) & S_IFMT) {
+		iput(inode);
+		return -EIO;
+	}
+
+	entry->d_time = time_to_jiffies(outarg.entry_valid,
+					outarg.entry_valid_nsec);
+
+	fi = get_fuse_inode(inode);
+	fi->i_time = time_to_jiffies(outarg.attr_valid,
+				     outarg.attr_valid_nsec);
+
+	d_instantiate(entry, inode);
+	fuse_invalidate_attr(dir);
+	return 0;
+}
+
+static int fuse_mknod(struct inode *dir, struct dentry *entry, int mode,
+		      dev_t rdev)
+{
+	struct fuse_mknod_in inarg;
+	struct fuse_conn *fc = get_fuse_conn(dir);
+	struct fuse_req *req = fuse_get_request(fc);
+	if (!req)
+		return -ERESTARTNOINTR;
+
+	memset(&inarg, 0, sizeof(inarg));
+	inarg.mode = mode;
+	inarg.rdev = new_encode_dev(rdev);
+	req->in.h.opcode = FUSE_MKNOD;
+	req->in.numargs = 2;
+	req->in.args[0].size = sizeof(inarg);
+	req->in.args[0].value = &inarg;
+	req->in.args[1].size = entry->d_name.len + 1;
+	req->in.args[1].value = entry->d_name.name;
+	return create_new_entry(fc, req, dir, entry, mode);
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
+	struct fuse_mkdir_in inarg;
+	struct fuse_conn *fc = get_fuse_conn(dir);
+	struct fuse_req *req = fuse_get_request(fc);
+	if (!req)
+		return -ERESTARTNOINTR;
+
+	memset(&inarg, 0, sizeof(inarg));
+	inarg.mode = mode;
+	req->in.h.opcode = FUSE_MKDIR;
+	req->in.numargs = 2;
+	req->in.args[0].size = sizeof(inarg);
+	req->in.args[0].value = &inarg;
+	req->in.args[1].size = entry->d_name.len + 1;
+	req->in.args[1].value = entry->d_name.name;
+	return create_new_entry(fc, req, dir, entry, S_IFDIR);
+}
+
+static int fuse_symlink(struct inode *dir, struct dentry *entry,
+			const char *link)
+{
+	struct fuse_conn *fc = get_fuse_conn(dir);
+	unsigned len = strlen(link) + 1;
+	struct fuse_req *req;
+
+	if (len > FUSE_SYMLINK_MAX)
+		return -ENAMETOOLONG;
+
+	req = fuse_get_request(fc);
+	if (!req)
+		return -ERESTARTNOINTR;
+
+	req->in.h.opcode = FUSE_SYMLINK;
+	req->in.numargs = 2;
+	req->in.args[0].size = entry->d_name.len + 1;
+	req->in.args[0].value = entry->d_name.name;
+	req->in.args[1].size = len;
+	req->in.args[1].value = link;
+	return create_new_entry(fc, req, dir, entry, S_IFLNK);
+}
+
+static int fuse_unlink(struct inode *dir, struct dentry *entry)
+{
+	int err;
+	struct fuse_conn *fc = get_fuse_conn(dir);
+	struct fuse_req *req = fuse_get_request(fc);
+	if (!req)
+		return -ERESTARTNOINTR;
+
+	req->in.h.opcode = FUSE_UNLINK;
+	req->in.h.nodeid = get_node_id(dir);
+	req->inode = dir;
+	req->in.numargs = 1;
+	req->in.args[0].size = entry->d_name.len + 1;
+	req->in.args[0].value = entry->d_name.name;
+	request_send(fc, req);
+	err = req->out.h.error;
+	fuse_put_request(fc, req);
+	if (!err) {
+		struct inode *inode = entry->d_inode;
+
+		/* Set nlink to zero so the inode can be cleared, if
+                   the inode does have more links this will be
+                   discovered at the next lookup/getattr */
+		inode->i_nlink = 0;
+		fuse_invalidate_attr(inode);
+		fuse_invalidate_attr(dir);
+	} else if (err == -EINTR)
+		fuse_invalidate_entry(entry);
+	return err;
+}
+
+static int fuse_rmdir(struct inode *dir, struct dentry *entry)
+{
+	int err;
+	struct fuse_conn *fc = get_fuse_conn(dir);
+	struct fuse_req *req = fuse_get_request(fc);
+	if (!req)
+		return -ERESTARTNOINTR;
+
+	req->in.h.opcode = FUSE_RMDIR;
+	req->in.h.nodeid = get_node_id(dir);
+	req->inode = dir;
+	req->in.numargs = 1;
+	req->in.args[0].size = entry->d_name.len + 1;
+	req->in.args[0].value = entry->d_name.name;
+	request_send(fc, req);
+	err = req->out.h.error;
+	fuse_put_request(fc, req);
+	if (!err) {
+		entry->d_inode->i_nlink = 0;
+		fuse_invalidate_attr(dir);
+	} else if (err == -EINTR)
+		fuse_invalidate_entry(entry);
+	return err;
+}
+
+static int fuse_rename(struct inode *olddir, struct dentry *oldent,
+		       struct inode *newdir, struct dentry *newent)
+{
+	int err;
+	struct fuse_rename_in inarg;
+	struct fuse_conn *fc = get_fuse_conn(olddir);
+	struct fuse_req *req = fuse_get_request(fc);
+	if (!req)
+		return -ERESTARTNOINTR;
+
+	memset(&inarg, 0, sizeof(inarg));
+	inarg.newdir = get_node_id(newdir);
+	req->in.h.opcode = FUSE_RENAME;
+	req->in.h.nodeid = get_node_id(olddir);
+	req->inode = olddir;
+	req->inode2 = newdir;
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
+	} else if (err == -EINTR) {
+		/* If request was interrupted, DEITY only knows if the
+		   rename actually took place.  If the invalidation
+		   fails (e.g. some process has CWD under the renamed
+		   directory), then there can be inconsistency between
+		   the dcache and the real filesystem.  Tough luck. */
+		fuse_invalidate_entry(oldent);
+		if (newent->d_inode)
+			fuse_invalidate_entry(newent);
+	}
+		
+	return err;
+}
+
+static int fuse_link(struct dentry *entry, struct inode *newdir,
+		     struct dentry *newent)
+{
+	int err;
+	struct fuse_link_in inarg;
+	struct inode *inode = entry->d_inode;
+	struct fuse_conn *fc = get_fuse_conn(inode);
+	struct fuse_req *req = fuse_get_request(fc);
+	if (!req)
+		return -ERESTARTNOINTR;
+
+	memset(&inarg, 0, sizeof(inarg));
+	inarg.newdir = get_node_id(newdir);
+	req->in.h.opcode = FUSE_LINK;
+	req->inode2 = newdir;
+	req->in.numargs = 2;
+	req->in.args[0].size = sizeof(inarg);
+	req->in.args[0].value = &inarg;
+	req->in.args[1].size = newent->d_name.len + 1;
+	req->in.args[1].value = newent->d_name.name;
+	err = create_new_entry(fc, req, newdir, newent, inode->i_mode);
+	/* Contrary to "normal" filesystems it can happen that link
+	   makes two "logical" inodes point to the same "physical"
+	   inode.  We invalidate the attributes of the old one, so it
+	   will reflect changes in the backing inode (link count,
+	   etc.)
+	*/
+	if (!err || err == -EINTR)
+		fuse_invalidate_attr(inode);
+	return err;
+}
+
 int fuse_do_getattr(struct inode *inode)
 {
 	int err;
@@ -341,6 +601,91 @@ static int fuse_dir_release(struct inode
 	return 0;
 }
 
+static unsigned iattr_to_fattr(struct iattr *iattr, struct fuse_attr *fattr)
+{
+	unsigned ivalid = iattr->ia_valid;
+	unsigned fvalid = 0;
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
+	struct fuse_conn *fc = get_fuse_conn(inode);
+	struct fuse_inode *fi = get_fuse_inode(inode);
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
+		return -ERESTARTNOINTR;
+
+	memset(&inarg, 0, sizeof(inarg));
+	inarg.valid = iattr_to_fattr(attr, &inarg.attr);
+	req->in.h.opcode = FUSE_SETATTR;
+	req->in.h.nodeid = get_node_id(inode);
+	req->inode = inode;
+	req->in.numargs = 1;
+	req->in.args[0].size = sizeof(inarg);
+	req->in.args[0].value = &inarg;
+	req->out.numargs = 1;
+	req->out.args[0].size = sizeof(outarg);
+	req->out.args[0].value = &outarg;
+	request_send(fc, req);
+	err = req->out.h.error;
+	fuse_put_request(fc, req);
+	if (!err) {
+		if ((inode->i_mode ^ outarg.attr.mode) & S_IFMT) {
+			make_bad_inode(inode);
+			err = -EIO;
+		} else {
+			if (is_truncate) {
+				loff_t origsize = i_size_read(inode);
+				i_size_write(inode, outarg.attr.size);
+				if (origsize > outarg.attr.size)
+					vmtruncate(inode, outarg.attr.size);
+			}
+			fuse_change_attributes(inode, &outarg.attr);
+			fi->i_time = time_to_jiffies(outarg.attr_valid,
+						     outarg.attr_valid_nsec);
+		}
+	} else if (err == -EINTR)
+		fuse_invalidate_attr(inode);
+
+	return err;
+}
+
 static int fuse_getattr(struct vfsmount *mnt, struct dentry *entry,
 			struct kstat *stat)
 {
@@ -364,6 +709,15 @@ static struct dentry *fuse_lookup(struct
 
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
@@ -376,11 +730,13 @@ static struct file_operations fuse_dir_o
 };
 
 static struct inode_operations fuse_common_inode_operations = {
+	.setattr	= fuse_setattr,
 	.permission	= fuse_permission,
 	.getattr	= fuse_getattr,
 };
 
 static struct inode_operations fuse_symlink_inode_operations = {
+	.setattr	= fuse_setattr,
 	.follow_link	= fuse_follow_link,
 	.put_link	= fuse_put_link,
 	.readlink	= generic_readlink,
diff -Nurp a/include/linux/fuse.h b/include/linux/fuse.h
--- a/include/linux/fuse.h	2005-01-11 16:28:29.000000000 +0100
+++ b/include/linux/fuse.h	2005-01-11 16:28:28.000000000 +0100
@@ -52,12 +52,28 @@ struct fuse_kstatfs {
 	__u32	namelen;
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
+	FUSE_SETATTR	   = 4,
 	FUSE_READLINK	   = 5,
+	FUSE_SYMLINK	   = 6,
 	FUSE_GETDIR	   = 7,
+	FUSE_MKNOD	   = 8,
+	FUSE_MKDIR	   = 9,
+	FUSE_UNLINK	   = 10,
+	FUSE_RMDIR	   = 11,
+	FUSE_RENAME	   = 12,
+	FUSE_LINK	   = 13,
 	FUSE_STATFS	   = 17,
 	FUSE_INIT          = 26
 };
@@ -66,6 +82,7 @@ enum fuse_opcode {
 #define FUSE_MAX_IN 8192
 
 #define FUSE_NAME_MAX 1024
+#define FUSE_SYMLINK_MAX 4096
 
 struct fuse_entry_out {
 	__u64	nodeid;		/* Inode ID */
@@ -93,6 +110,28 @@ struct fuse_getdir_out {
 	__u32	fd;
 };
 
+struct fuse_mknod_in {
+	__u32	mode;
+	__u32	rdev;
+};
+
+struct fuse_mkdir_in {
+	__u32	mode;
+};
+
+struct fuse_rename_in {
+	__u64	newdir;
+};
+
+struct fuse_link_in {
+	__u64	newdir;
+};
+
+struct fuse_setattr_in {
+	__u32	valid;
+	struct fuse_attr attr;
+};
+
 struct fuse_statfs_out {
 	struct fuse_kstatfs st;
 };
