Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263245AbUKTX01@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263245AbUKTX01 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 18:26:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263206AbUKTXYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 18:24:45 -0500
Received: from mail.euroweb.hu ([193.226.220.4]:34699 "HELO mail.euroweb.hu")
	by vger.kernel.org with SMTP id S263209AbUKTXK1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 18:10:27 -0500
To: akpm@osdl.org, torvalds@osdl.org
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/13] Filesystem in Userspace
Message-Id: <E1CVeMy-0007PT-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sun, 21 Nov 2004 00:10:16 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the read-only filesystem operations of FUSE.

The following operations are added:

 o getattr
 o readlink
 o follow_link
 o directory open
 o readdir
 o directory release
 o permission
 o dentry revalidate
 o statfs

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
--- linux-2.6.10-rc2/fs/fuse/dev.c	2004-11-20 22:56:25.000000000 +0100
+++ linux-2.6.10-rc2-fuse/fs/fuse/dev.c	2004-11-20 22:56:23.000000000 +0100
@@ -268,6 +268,12 @@ static struct fuse_req *request_find(str
 	return req;
 }
 
+static void process_getdir(struct fuse_req *req)
+{
+	struct fuse_getdir_out_i *arg = req->out.args[0].value;
+	arg->file = fget(arg->fd);
+}
+
 static inline int copy_out_one(struct fuse_out_arg *arg,
 			       const char __user **srcp,
 			       size_t *srclenp, int allowvar)
@@ -378,7 +384,11 @@ static ssize_t fuse_dev_write(struct fil
 	spin_lock(&fuse_lock);
 	if (err)
 		req->out.h.error = -EPROTO;
-
+	else {
+		/* fget() needs to be done in this context */
+		if (req->in.h.opcode == FUSE_GETDIR && !oh.error)
+			process_getdir(req);
+	}	
 	req->finished = 1;
 	/* Unlocks fuse_lock: */
 	request_end(fc, req);
--- linux-2.6.10-rc2/fs/fuse/dir.c	2004-11-20 22:56:25.000000000 +0100
+++ linux-2.6.10-rc2-fuse/fs/fuse/dir.c	2004-11-20 22:56:25.000000000 +0100
@@ -10,8 +10,14 @@
 
 #include <linux/pagemap.h>
 #include <linux/file.h>
+#include <linux/gfp.h>
+#include <linux/sched.h>
 
 static struct inode_operations fuse_dir_inode_operations;
+static struct inode_operations fuse_file_inode_operations;
+static struct inode_operations fuse_symlink_inode_operations;
+static struct file_operations fuse_dir_operations;
+static struct dentry_operations fuse_dentry_operations;
 
 static void change_attributes(struct inode *inode, struct fuse_attr *attr)
 {
@@ -39,8 +45,27 @@ static void fuse_init_inode(struct inode
 {
 	inode->i_mode = attr->mode & S_IFMT;
 	i_size_write(inode, attr->size);
-	if (S_ISDIR(inode->i_mode))
+	if (S_ISREG(inode->i_mode)) {
+		inode->i_op = &fuse_file_inode_operations;
+	}
+	else if (S_ISDIR(inode->i_mode)) {
 		inode->i_op = &fuse_dir_inode_operations;
+		inode->i_fop = &fuse_dir_operations;
+	}
+	else if (S_ISLNK(inode->i_mode)) {
+		inode->i_op = &fuse_symlink_inode_operations;
+	}
+	else if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode) || 
+		 S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode)) {
+		inode->i_op = &fuse_file_inode_operations;
+		init_special_inode(inode, inode->i_mode,
+				   new_decode_dev(attr->rdev));
+	} else {
+		/* Don't let user create weird files */
+		printk("fuse_init_inode: bad file type: %o\n", inode->i_mode);
+		inode->i_mode = S_IFREG;
+		inode->i_op = &fuse_file_inode_operations;
+	}
 }
 
 static int fuse_inode_eq(struct inode *inode, void *_nodeidp)
@@ -82,6 +107,11 @@ struct inode *fuse_iget(struct super_blo
 	return inode;
 }
 
+struct inode *fuse_ilookup(struct super_block *sb, unsigned long nodeid)
+{
+	return ilookup5(sb, nodeid, fuse_inode_eq, &nodeid);
+}
+
 static int fuse_send_lookup(struct fuse_conn *fc, struct fuse_req *req,
 			    struct inode *dir, struct dentry *entry, 
 			    struct fuse_entry_out *outarg, int *version)
@@ -100,6 +130,24 @@ static int fuse_send_lookup(struct fuse_
 	return req->out.h.error;
 }
 
+static int fuse_do_lookup(struct inode *dir, struct dentry *entry,
+			  struct fuse_entry_out *outarg, int *version)
+{
+	struct fuse_conn *fc = INO_FC(dir);
+	struct fuse_req *req;
+	int err;
+
+	if (entry->d_name.len > FUSE_NAME_MAX)
+		return -ENAMETOOLONG;
+	req = fuse_get_request(fc);
+	if (!req)
+		return -ERESTARTSYS;
+	
+	err = fuse_send_lookup(fc, req, dir, entry, outarg, version);
+	fuse_put_request(fc, req);
+	return err;
+}
+
 static inline unsigned long time_to_jiffies(unsigned long sec,
 					    unsigned long nsec)
 {
@@ -147,10 +195,279 @@ static int fuse_lookup_iget(struct inode
 					     outarg.attr_valid_nsec);
 	}
 
+	entry->d_op = &fuse_dentry_operations;
 	*inodep = inode;
 	return 0;
 }
 
+int fuse_do_getattr(struct inode *inode)
+{
+	struct fuse_inode *fi = INO_FI(inode);
+	struct fuse_conn *fc = INO_FC(inode);
+	struct fuse_req *req = fuse_get_request(fc);
+	struct fuse_attr_out arg;
+	int err;
+
+	if (!req)
+		return -ERESTARTSYS;
+
+	req->in.h.opcode = FUSE_GETATTR;
+	req->in.h.nodeid = fi->nodeid;
+	req->out.numargs = 1;
+	req->out.args[0].size = sizeof(arg);
+	req->out.args[0].value = &arg;
+	request_send(fc, req);
+	err = req->out.h.error;	
+	if (!err) {
+		change_attributes(inode, &arg.attr);
+		fi->i_time = time_to_jiffies(arg.attr_valid,
+					     arg.attr_valid_nsec);
+	}
+	fuse_put_request(fc, req);
+	return err;
+}
+
+static int fuse_revalidate(struct dentry *entry)
+{
+	struct inode *inode = entry->d_inode;
+	struct fuse_inode *fi = INO_FI(inode);
+	struct fuse_conn *fc = INO_FC(inode);
+
+	if (fi->nodeid == FUSE_ROOT_ID) {
+		if (current->fsuid != fc->uid)
+			return -EACCES;
+	} else if (!fi->i_time || time_before_eq(jiffies, fi->i_time))
+		return 0;
+
+	return fuse_do_getattr(inode);
+}
+
+static int fuse_permission(struct inode *inode, int mask, struct nameidata *nd)
+{
+	struct fuse_conn *fc = INO_FC(inode);
+
+	if (current->fsuid != fc->uid)
+		return -EACCES;
+	else
+		return 0;
+}
+
+static int parse_dirfile(char *buf, size_t nbytes, struct file *file,
+			 void *dstbuf, filldir_t filldir)
+{
+	while (nbytes >= FUSE_NAME_OFFSET) {
+		struct fuse_dirent *dirent = (struct fuse_dirent *) buf;
+		size_t reclen = FUSE_DIRENT_SIZE(dirent);
+		int over;
+		if (dirent->namelen > NAME_MAX) {
+			printk("fuse_readdir: name too long\n");
+			return -EPROTO;
+		}
+		if (reclen > nbytes)
+			break;
+
+		over = filldir(dstbuf, dirent->name, dirent->namelen,
+			      file->f_pos, dirent->ino, dirent->type);
+		if (over)
+			break;
+
+		buf += reclen;
+		file->f_pos += reclen;
+		nbytes -= reclen;
+	}
+
+	return 0;
+}
+
+static int fuse_checkdir(struct file *cfile, struct file *file)
+{
+	struct inode *inode;
+	if (!cfile) {
+		printk("fuse_getdir: invalid file\n");
+		return -EPROTO;
+	}
+	inode = cfile->f_dentry->d_inode;
+	if (!S_ISREG(inode->i_mode)) {
+		printk("fuse_getdir: not a regular file\n");
+		fput(cfile);
+		return -EPROTO;
+	}
+	
+	file->private_data = cfile;
+	return 0;
+}
+
+static int fuse_getdir(struct file *file)
+{
+	struct inode *inode = file->f_dentry->d_inode;
+	struct fuse_conn *fc = INO_FC(inode);
+	struct fuse_inode *fi = INO_FI(inode);
+	struct fuse_req *req = fuse_get_request(fc);
+	struct fuse_getdir_out_i outarg;
+	int err;
+
+	if (!req)
+		return -ERESTARTSYS;
+
+	req->in.h.opcode = FUSE_GETDIR;
+	req->in.h.nodeid = fi->nodeid;
+	req->out.numargs = 1;
+	req->out.args[0].size = sizeof(struct fuse_getdir_out);
+	req->out.args[0].value = &outarg;
+	request_send(fc, req);
+	err = req->out.h.error;	
+	if (!err)
+		err = fuse_checkdir(outarg.file, file);
+	fuse_put_request(fc, req);
+	return err;
+}
+
+static int fuse_readdir(struct file *file, void *dstbuf, filldir_t filldir)
+{
+	struct file *cfile = file->private_data;
+	char *buf;
+	int ret;
+
+	if (!cfile) {
+		ret = fuse_getdir(file);
+		if (ret)
+			return ret;
+
+		cfile = file->private_data;
+	}
+
+	buf = (char *) __get_free_page(GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+	
+	ret = kernel_read(cfile, file->f_pos, buf, PAGE_SIZE);
+	if (ret < 0)
+		printk("fuse_readdir: failed to read container file\n");
+	else 
+		ret = parse_dirfile(buf, ret, file, dstbuf, filldir);
+
+	free_page((unsigned long) buf);
+	return ret;
+}
+
+static char *read_link(struct dentry *dentry)
+{
+	struct inode *inode = dentry->d_inode;
+	struct fuse_conn *fc = INO_FC(inode);
+	struct fuse_inode *fi = INO_FI(inode);
+	struct fuse_req *req = fuse_get_request(fc);
+	char *link;
+
+	if (!req)
+		return ERR_PTR(-ERESTARTSYS);
+
+	link = (char *) __get_free_page(GFP_KERNEL);
+	if (!link) {
+		link = ERR_PTR(-ENOMEM);
+		goto out;
+	}
+	req->in.h.opcode = FUSE_READLINK;
+	req->in.h.nodeid = fi->nodeid;
+	req->out.argvar = 1;
+	req->out.numargs = 1;
+	req->out.args[0].size = PAGE_SIZE - 1;
+	req->out.args[0].value = link;
+	request_send(fc, req);
+	if (req->out.h.error) {
+		free_page((unsigned long) link);
+		link = ERR_PTR(req->out.h.error);
+	} else
+		link[req->out.args[0].size] = '\0';
+ out:
+	fuse_put_request(fc, req);
+	return link;
+}
+
+static void free_link(char *link)
+{
+	if (!IS_ERR(link))
+		free_page((unsigned long) link);
+}
+
+static int fuse_readlink(struct dentry *dentry, char __user *buffer,
+			 int buflen)
+{
+	int ret;
+	char *link;
+
+	link = read_link(dentry);
+	ret = vfs_readlink(dentry, buffer, buflen, link);
+	free_link(link);
+	return ret;
+}
+
+static int fuse_follow_link(struct dentry *dentry, struct nameidata *nd)
+{
+	int ret;
+	char *link;
+
+	link = read_link(dentry);
+	ret = vfs_follow_link(nd, link);
+	free_link(link);
+	return ret;
+}
+
+static int fuse_dir_open(struct inode *inode, struct file *file)
+{
+	file->private_data = NULL;
+	return 0;
+}
+
+static int fuse_dir_release(struct inode *inode, struct file *file)
+{
+	struct file *cfile = file->private_data;
+
+	if (cfile)
+		fput(cfile);
+
+	return 0;
+}
+
+static int fuse_dentry_revalidate(struct dentry *entry, struct nameidata *nd)
+{
+	if (!entry->d_inode)
+		return 0;
+	else if (entry->d_time && time_after(jiffies, entry->d_time)) {
+		struct inode *inode = entry->d_inode;
+		struct fuse_inode *fi = INO_FI(inode);
+		struct fuse_entry_out outarg;
+		int version;
+		int ret;
+		
+		ret = fuse_do_lookup(entry->d_parent->d_inode, entry, &outarg,
+				     &version);
+		if (ret)
+			return 0;
+		
+		if (outarg.nodeid != fi->nodeid)
+			return 0;
+		
+		change_attributes(inode, &outarg.attr);
+		inode->i_version = version;
+		entry->d_time = time_to_jiffies(outarg.entry_valid,
+						outarg.entry_valid_nsec);
+		fi->i_time = time_to_jiffies(outarg.attr_valid,
+					     outarg.attr_valid_nsec);
+	}
+	return 1;
+}
+
+static int fuse_getattr(struct vfsmount *mnt, struct dentry *entry,
+			struct kstat *stat)
+{
+	struct inode *inode = entry->d_inode;
+	int err = fuse_revalidate(entry);
+	if (!err)
+		generic_fillattr(inode, stat);
+	
+	return err;
+}
+
 static struct dentry *fuse_lookup(struct inode *dir, struct dentry *entry,
 				   struct nameidata *nd)
 {
@@ -163,4 +480,28 @@ static struct dentry *fuse_lookup(struct
 
 static struct inode_operations fuse_dir_inode_operations = {
 	.lookup		= fuse_lookup,
+	.permission	= fuse_permission,
+	.getattr	= fuse_getattr,
+};
+
+static struct file_operations fuse_dir_operations = {
+	.read		= generic_read_dir,
+	.readdir	= fuse_readdir,
+	.open		= fuse_dir_open,
+	.release	= fuse_dir_release,
+};
+
+static struct inode_operations fuse_file_inode_operations = {
+	.permission	= fuse_permission,
+	.getattr	= fuse_getattr,
+};
+
+static struct inode_operations fuse_symlink_inode_operations = {
+	.readlink	= fuse_readlink,
+	.follow_link	= fuse_follow_link,
+	.getattr	= fuse_getattr,
+};
+
+static struct dentry_operations fuse_dentry_operations = {
+	.d_revalidate	= fuse_dentry_revalidate,
 };
--- linux-2.6.10-rc2/fs/fuse/fuse_i.h	2004-11-20 22:56:25.000000000 +0100
+++ linux-2.6.10-rc2-fuse/fs/fuse/fuse_i.h	2004-11-20 22:56:24.000000000 +0100
@@ -121,6 +121,11 @@ struct fuse_conn {
 	int reqctr;
 };
 
+struct fuse_getdir_out_i {
+	int fd;
+	void *file; /* Used by kernel only */
+};
+
 #define SB_FC(sb) ((sb)->s_fs_info)
 #define INO_FC(inode) SB_FC((inode)->i_sb)
 #define INO_FI(i) ((struct fuse_inode *) (((struct inode *)(i))+1))
@@ -148,6 +153,8 @@ extern spinlock_t fuse_lock;
 struct inode *fuse_iget(struct super_block *sb, unsigned long nodeid,
 			int generation, struct fuse_attr *attr, int version);
 
+struct inode *fuse_ilookup(struct super_block *sb, unsigned long nodeid);
+
 /**
  * Send FORGET command
  */
@@ -214,3 +221,8 @@ void request_send(struct fuse_conn *fc, 
  * Send a request for which a reply is not expected
  */
 void request_send_noreply(struct fuse_conn *fc, struct fuse_req *req);
+
+/**
+ * Get the attributes of a file
+ */
+int fuse_do_getattr(struct inode *inode);
--- linux-2.6.10-rc2/fs/fuse/inode.c	2004-11-20 22:56:25.000000000 +0100
+++ linux-2.6.10-rc2-fuse/fs/fuse/inode.c	2004-11-20 22:56:24.000000000 +0100
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/parser.h>
+#include <linux/statfs.h>
 
 static kmem_cache_t *fuse_inode_cachep;
 
@@ -98,6 +99,43 @@ static void fuse_put_super(struct super_
 	spin_unlock(&fuse_lock);
 }
 
+static void convert_fuse_statfs(struct kstatfs *stbuf, struct fuse_kstatfs *attr)
+{
+	stbuf->f_type    = FUSE_SUPER_MAGIC;
+	stbuf->f_bsize   = attr->bsize;
+	stbuf->f_blocks  = attr->blocks;
+	stbuf->f_bfree   = attr->bfree;
+	stbuf->f_bavail  = attr->bavail;
+	stbuf->f_files   = attr->files;
+	stbuf->f_ffree   = attr->ffree;
+	stbuf->f_namelen = attr->namelen;
+	/* fsid is left zero */
+}
+
+static int fuse_statfs(struct super_block *sb, struct kstatfs *buf)
+{
+	struct fuse_conn *fc = SB_FC(sb);
+	struct fuse_req *req;
+	struct fuse_statfs_out outarg;
+	int err;
+
+        req = fuse_get_request(fc);
+	if (!req)
+		return -ERESTARTSYS;
+
+	req->in.numargs = 0;
+	req->in.h.opcode = FUSE_STATFS;
+	req->out.numargs = 1;
+	req->out.args[0].size = sizeof(outarg);
+	req->out.args[0].value = &outarg;
+	request_send(fc, req);
+	err = req->out.h.error;
+	if (!err)
+		convert_fuse_statfs(buf, &outarg.st);
+	fuse_put_request(fc, req);
+	return err;
+}
+
 enum {
 	OPT_FD,
 	OPT_ROOTMODE,
@@ -254,6 +292,7 @@ static struct super_operations fuse_supe
 	.read_inode	= fuse_read_inode,
 	.clear_inode	= fuse_clear_inode,
 	.put_super	= fuse_put_super,
+	.statfs		= fuse_statfs,
 	.show_options	= fuse_show_options,
 };
 
--- linux-2.6.10-rc2/include/linux/fuse.h	2004-11-20 22:56:25.000000000 +0100
+++ linux-2.6.10-rc2-fuse/include/linux/fuse.h	2004-11-20 22:56:25.000000000 +0100
@@ -40,14 +40,24 @@ struct fuse_attr {
 	unsigned long       ctimensec;
 };
 
+struct fuse_kstatfs {
+	unsigned int        bsize;
+	unsigned long long  blocks;
+	unsigned long long  bfree;
+	unsigned long long  bavail;
+	unsigned long long  files;
+	unsigned long long  ffree;
+	unsigned int        namelen;
+};
+
 enum fuse_opcode {
 	FUSE_LOOKUP	   = 1,
 	FUSE_FORGET	   = 2,  /* no reply */
-	/* FUSE_GETATTR	   = 3, */
+	FUSE_GETATTR	   = 3,
 	/* FUSE_SETATTR	   = 4, */
-	/* FUSE_READLINK   = 5, */
+	FUSE_READLINK	   = 5,
 	/* FUSE_SYMLINK	   = 6, */
-	/* FUSE_GETDIR	   = 7, */
+	FUSE_GETDIR	   = 7,
 	/* FUSE_MKNOD	   = 8, */
 	/* FUSE_MKDIR	   = 9, */
 	/* FUSE_UNLINK	   = 10, */
@@ -57,7 +67,7 @@ enum fuse_opcode {
 	/* FUSE_OPEN	   = 14, */
 	/* FUSE_READ	   = 15, */
 	/* FUSE_WRITE	   = 16, */
-	/* FUSE_STATFS	   = 17, */
+	FUSE_STATFS	   = 17,
 	/* FUSE_RELEASE       = 18, */
 	/* FUSE_INVALIDATE    = 19, */
 	/* FUSE_FSYNC         = 20, */
@@ -88,6 +98,20 @@ struct fuse_forget_in {
 	int version;
 };
 
+struct fuse_attr_out {
+	unsigned long attr_valid;  /* Cache timeout for the attributes */
+	unsigned long attr_valid_nsec;
+	struct fuse_attr attr;
+};
+
+struct fuse_getdir_out {
+	int fd;
+};
+
+struct fuse_statfs_out {
+	struct fuse_kstatfs st;
+};
+
 struct fuse_in_header {
 	int unique;
 	enum fuse_opcode opcode;
@@ -101,3 +125,15 @@ struct fuse_out_header {
 	int unique;
 	int error;
 };
+
+struct fuse_dirent {
+	unsigned long ino;
+	unsigned short namelen;
+	unsigned char type;
+	char name[256];
+};
+
+#define FUSE_NAME_OFFSET ((unsigned int) ((struct fuse_dirent *) 0)->name)
+#define FUSE_DIRENT_ALIGN(x) (((x) + sizeof(long) - 1) & ~(sizeof(long) - 1))
+#define FUSE_DIRENT_SIZE(d) \
+	FUSE_DIRENT_ALIGN(FUSE_NAME_OFFSET + (d)->namelen)
