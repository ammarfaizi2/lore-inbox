Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261763AbSI2UVH>; Sun, 29 Sep 2002 16:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261771AbSI2UUI>; Sun, 29 Sep 2002 16:20:08 -0400
Received: from fungus.teststation.com ([212.32.186.211]:40463 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S261781AbSI2USQ>; Sun, 29 Sep 2002 16:18:16 -0400
Date: Sun, 29 Sep 2002 22:22:55 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: puw@cola.enlightnet.local
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [patch] SMB Unix Extensions (3/3)
Message-ID: <Pine.LNX.4.44.0209292125550.19464-100000@cola.enlightnet.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds symlinks, hardlinks, device nodes, uid/gid, unix
permissions vs servers that support it (ie samba). Most of this is the
work of John Newbigin, I just modified it for 2.5.

There are issues with what samba allows (eg you can't make arbitrary
symlinks) and room for improvements (use the servers value for ino?). But
it doesn't affect "normal" users.

Please apply.

/Urban


diff -urN -X exclude linux-2.5.39-orig/fs/smbfs/ChangeLog linux-2.5.39-smbfs/fs/smbfs/ChangeLog
--- linux-2.5.39-orig/fs/smbfs/ChangeLog	Sun Jun  9 07:31:18 2002
+++ linux-2.5.39-smbfs/fs/smbfs/ChangeLog	Sun Sep 29 21:48:37 2002
@@ -1,5 +1,10 @@
 ChangeLog for smbfs.
 
+2002-04-19 John Newbigin <jn@it.swin.edu.au>
+
+	* Implementation of CIFS Extensions for UNIX systems, including soft
+	  and hard links.
+
 2001-08-03 Urban Widmark <urban@teststation.com>
 
 	* *.c: Unicode support
diff -urN -X exclude linux-2.5.39-orig/fs/smbfs/Makefile linux-2.5.39-smbfs/fs/smbfs/Makefile
--- linux-2.5.39-orig/fs/smbfs/Makefile	Sun Sep 29 21:56:28 2002
+++ linux-2.5.39-smbfs/fs/smbfs/Makefile	Sun Sep 29 21:48:37 2002
@@ -5,7 +5,7 @@
 obj-$(CONFIG_SMB_FS) += smbfs.o
 
 smbfs-objs := proc.o dir.o cache.o sock.o inode.o file.o ioctl.o getopt.o \
-		smbiod.o request.o
+		symlink.o smbiod.o request.o
 
 # If you want debugging output, you may add these flags to the EXTRA_CFLAGS
 # SMBFS_PARANOIA should normally be enabled.
@@ -24,7 +24,8 @@
 #
 
 # getopt.c not included. It is intentionally separate
-SRC = proc.c dir.c cache.c sock.c inode.c file.c ioctl.c smbiod.c request.c
+SRC = proc.c dir.c cache.c sock.c inode.c file.c ioctl.c smbiod.c request.c \
+	symlink.c
 
 proto:
 	-rm -f proto.h
diff -urN -X exclude linux-2.5.39-orig/fs/smbfs/dir.c linux-2.5.39-smbfs/fs/smbfs/dir.c
--- linux-2.5.39-orig/fs/smbfs/dir.c	Sat Sep 21 15:48:18 2002
+++ linux-2.5.39-smbfs/fs/smbfs/dir.c	Sun Sep 29 21:48:37 2002
@@ -30,6 +30,8 @@
 static int smb_unlink(struct inode *, struct dentry *);
 static int smb_rename(struct inode *, struct dentry *,
 		      struct inode *, struct dentry *);
+static int smb_make_node(struct inode *,struct dentry *,int,int);
+static int smb_link(struct dentry *, struct inode *, struct dentry *);
 
 struct file_operations smb_dir_operations =
 {
@@ -51,6 +53,21 @@
 	.setattr	= smb_notify_change,
 };
 
+struct inode_operations smb_dir_inode_operations_unix =
+{
+	.create		= smb_create,
+	.lookup		= smb_lookup,
+	.unlink		= smb_unlink,
+	.mkdir		= smb_mkdir,
+	.rmdir		= smb_rmdir,
+	.rename		= smb_rename,
+	.getattr	= smb_getattr,
+	.setattr	= smb_notify_change,
+	.symlink	= smb_symlink,
+	.mknod		= smb_make_node,
+	.link		= smb_link,
+};
+
 /*
  * Read a directory, using filldir to fill the dirent memory.
  * smb_proc_readdir does the actual reading from the smb server.
@@ -485,8 +502,10 @@
 static int
 smb_create(struct inode *dir, struct dentry *dentry, int mode)
 {
+	struct smb_sb_info *server = server_from_dentry(dentry);
 	__u16 fileid;
 	int error;
+	struct iattr attr;
 
 	VERBOSE("creating %s/%s, mode=%d\n", DENTRY_PATH(dentry), mode);
 
@@ -494,6 +513,12 @@
 	smb_invalid_dir_cache(dir);
 	error = smb_proc_create(dentry, 0, CURRENT_TIME, &fileid);
 	if (!error) {
+		if (server->opt.capabilities & SMB_CAP_UNIX) {
+			/* Set attributes for new file */
+			attr.ia_valid = ATTR_MODE;
+			attr.ia_mode = mode;
+			error = smb_proc_setattr_unix(dentry, &attr, 0, 0);
+		}
 		error = smb_instantiate(dentry, fileid, 1);
 	} else {
 		PARANOIA("%s/%s failed, error=%d\n",
@@ -507,12 +532,20 @@
 static int
 smb_mkdir(struct inode *dir, struct dentry *dentry, int mode)
 {
+	struct smb_sb_info *server = server_from_dentry(dentry);
 	int error;
+	struct iattr attr;
 
 	lock_kernel();
 	smb_invalid_dir_cache(dir);
 	error = smb_proc_mkdir(dentry);
 	if (!error) {
+		if (server->opt.capabilities & SMB_CAP_UNIX) {
+			/* Set attributes for new directory */
+			attr.ia_valid = ATTR_MODE;
+			attr.ia_mode = mode;
+			error = smb_proc_setattr_unix(dentry, &attr, 0, 0);
+		}
 		error = smb_instantiate(dentry, 0, 0);
 	}
 	unlock_kernel();
@@ -601,3 +634,46 @@
 	unlock_kernel();
 	return error;
 }
+
+/*
+ * FIXME: samba servers won't let you create device nodes unless uid/gid
+ * matches the connection credentials (and we don't know which those are ...)
+ */
+static int
+smb_make_node(struct inode *dir, struct dentry *dentry, int mode, int dev)
+{
+	int error;
+	struct iattr attr;
+
+	attr.ia_valid = ATTR_MODE | ATTR_UID | ATTR_GID;
+	attr.ia_mode = mode;
+	attr.ia_uid = current->euid;
+	attr.ia_gid = current->egid;
+
+	smb_invalid_dir_cache(dir);
+	error = smb_proc_setattr_unix(dentry, &attr, MAJOR(dev), MINOR(dev));
+	if (!error) {
+		error = smb_instantiate(dentry, 0, 0);
+	}
+	return error;
+}
+
+/*
+ * dentry = existing file
+ * new_dentry = new file
+ */
+static int
+smb_link(struct dentry *dentry, struct inode *dir, struct dentry *new_dentry)
+{
+	int error;
+
+	DEBUG1("smb_link old=%s/%s new=%s/%s\n",
+	       DENTRY_PATH(dentry), DENTRY_PATH(new_dentry));
+	smb_invalid_dir_cache(dir);
+	error = smb_proc_link(server_from_dentry(dentry), dentry, new_dentry);
+	if (!error) {
+		smb_renew_times(dentry);
+		error = smb_instantiate(new_dentry, 0, 0);
+	}
+	return error;
+}
diff -urN -X exclude linux-2.5.39-orig/fs/smbfs/inode.c linux-2.5.39-smbfs/fs/smbfs/inode.c
--- linux-2.5.39-orig/fs/smbfs/inode.c	Sun Sep 29 21:56:28 2002
+++ linux-2.5.39-smbfs/fs/smbfs/inode.c	Sun Sep 29 21:48:37 2002
@@ -106,6 +106,7 @@
 struct inode *
 smb_iget(struct super_block *sb, struct smb_fattr *fattr)
 {
+	struct smb_sb_info *server = SMB_SB(sb);
 	struct inode *result;
 
 	DEBUG1("smb_iget: %p\n", fattr);
@@ -126,8 +127,15 @@
 		result->i_fop = &smb_file_operations;
 		result->i_data.a_ops = &smb_file_aops;
 	} else if (S_ISDIR(result->i_mode)) {
-		result->i_op = &smb_dir_inode_operations;
+		if (server->opt.capabilities & SMB_CAP_UNIX)
+			result->i_op = &smb_dir_inode_operations_unix;
+		else
+			result->i_op = &smb_dir_inode_operations;
 		result->i_fop = &smb_dir_operations;
+	} else if (S_ISLNK(result->i_mode)) {
+		result->i_op = &smb_link_inode_operations;
+	} else {
+		init_special_inode(result, result->i_mode, fattr->f_rdev);
 	}
 	insert_inode_hash(result);
 	return result;
@@ -235,7 +243,14 @@
 		/*
 		 * Check whether the type part of the mode changed,
 		 * and don't update the attributes if it did.
+		 *
+		 * And don't dick with the root inode
 		 */
+		if (inode->i_ino == 2)
+			return error;
+		if (S_ISLNK(inode->i_mode))
+			return error;	/* VFS will deal with it */
+
 		if ((inode->i_mode & S_IFMT) == (fattr.f_mode & S_IFMT)) {
 			smb_set_inode_attr(inode, &fattr);
 		} else {
@@ -664,6 +679,17 @@
 		refresh = 1;
 	}
 
+	if (server->opt.capabilities & SMB_CAP_UNIX) {
+		/* For now we don't want to set the size with setattr_unix */
+		attr->ia_valid &= ~ATTR_SIZE;
+		/* FIXME: only call if we actually want to set something? */
+		error = smb_proc_setattr_unix(dentry, attr, 0, 0);
+		if (!error)
+			refresh = 1;
+
+		goto out;
+	}
+
 	/*
 	 * Initialize the fattr and check for changed fields.
 	 * Note: CTIME under SMB is creation time rather than
diff -urN -X exclude linux-2.5.39-orig/fs/smbfs/proc.c linux-2.5.39-smbfs/fs/smbfs/proc.c
--- linux-2.5.39-orig/fs/smbfs/proc.c	Sun Sep 29 21:56:28 2002
+++ linux-2.5.39-smbfs/fs/smbfs/proc.c	Sun Sep 29 21:48:37 2002
@@ -54,6 +54,7 @@
 static struct smb_ops smb_ops_os2;
 static struct smb_ops smb_ops_win95;
 static struct smb_ops smb_ops_winNT;
+static struct smb_ops smb_ops_unix;
 
 static void
 smb_init_dirent(struct smb_sb_info *server, struct smb_fattr *fattr);
@@ -71,6 +72,8 @@
 static int
 smb_proc_setattr_ext(struct smb_sb_info *server,
 		     struct inode *inode, struct smb_fattr *fattr);
+int
+smb_proc_query_cifsunix(struct smb_sb_info *server);
 static void
 install_ops(struct smb_ops *dst, struct smb_ops *src);
 
@@ -521,15 +524,47 @@
 	return (time_t)t;
 }
 
-#if 0
 /* Convert the Unix UTC into NT time */
 static u64
-smb_unixutc2ntutc(struct smb_sb_info *server, time_t t)
+smb_unixutc2ntutc(time_t t)
 {
 	/* Note: timezone conversion is probably wrong. */
-	return ((u64)utc2local(server, t)) * 10000000 + NTFS_TIME_OFFSET;
+	/* return ((u64)utc2local(server, t)) * 10000000 + NTFS_TIME_OFFSET; */
+	return ((u64)t) * 10000000 + NTFS_TIME_OFFSET;
+}
+
+#define MAX_FILE_MODE	6
+static mode_t file_mode[] = {
+	S_IFREG, S_IFDIR, S_IFLNK, S_IFCHR, S_IFBLK, S_IFIFO, S_IFSOCK
+};
+
+static int smb_filetype_to_mode(u32 filetype)
+{
+	if (filetype > MAX_FILE_MODE) {
+		PARANOIA("Filetype out of range: %d\n", filetype);
+		return S_IFREG;
+	}
+	return file_mode[filetype];
+}
+
+static u32 smb_filetype_from_mode(int mode)
+{
+	if (mode & S_IFREG)
+		return UNIX_TYPE_FILE;
+	if (mode & S_IFDIR)
+		return UNIX_TYPE_DIR;
+	if (mode & S_IFLNK)
+		return UNIX_TYPE_SYMLINK;
+	if (mode & S_IFCHR)
+		return UNIX_TYPE_CHARDEV;
+	if (mode & S_IFBLK)
+		return UNIX_TYPE_BLKDEV;
+	if (mode & S_IFIFO)
+		return UNIX_TYPE_FIFO;
+	if (mode & S_IFSOCK)
+		return UNIX_TYPE_SOCKET;
+	return UNIX_TYPE_UNKNOWN;
 }
-#endif
 
 
 /*****************************************************************************/
@@ -913,6 +948,14 @@
 		VERBOSE("Large writes enabled\n");
 	}
 #endif
+	if (server->opt.capabilities & SMB_CAP_UNIX) {
+		struct inode *inode;
+		VERBOSE("Using UNIX CIFS extensions\n");
+		install_ops(server->ops, &smb_ops_unix);
+		inode = SB_of(server)->s_root->d_inode;
+		if (inode)
+			inode->i_op = &smb_dir_inode_operations_unix;
+	}
 
 	VERBOSE("protocol=%d, max_xmit=%d, pid=%d capabilities=0x%x\n",
 		server->opt.protocol, server->opt.max_xmit, server->conn_pid,
@@ -923,6 +966,12 @@
 		server->opt.max_xmit = SMB_MAX_PACKET_SIZE;
 	}
 
+	smb_unlock_server(server);
+	smbiod_wake_up();
+	if (server->opt.capabilities & SMB_CAP_UNIX)
+		smb_proc_query_cifsunix(server);
+	return error;
+
 out:
 	smb_unlock_server(server);
 	smbiod_wake_up();
@@ -1198,7 +1247,8 @@
 		 * If the file is open with write permissions,
 		 * update the time stamps to sync mtime and atime.
 		 */
-		if ((server->opt.protocol >= SMB_PROTOCOL_LANMAN2) &&
+		if ((server->opt.capabilities & SMB_CAP_UNIX) == 0 &&
+		    (server->opt.protocol >= SMB_PROTOCOL_LANMAN2) &&
 		    !(ei->access == SMB_O_RDONLY))
 		{
 			struct smb_fattr fattr;
@@ -1594,6 +1644,8 @@
 	int result;
 	struct smb_fattr fattr;
 
+	/* FIXME: cifsUE should allow removing a readonly file. */
+
 	/* first get current attribute */
 	smb_init_dirent(server, &fattr);
 	result = server->ops->getattr(server, dentry, &fattr);
@@ -1764,14 +1816,17 @@
 	fattr->f_uid = server->mnt->uid;
 	fattr->f_gid = server->mnt->gid;
 	fattr->f_blksize = SMB_ST_BLKSIZE;
+	fattr->f_unix = 0;
 }
 
 static void
 smb_finish_dirent(struct smb_sb_info *server, struct smb_fattr *fattr)
 {
+	if (fattr->f_unix)
+		return;
+
 	fattr->f_mode = server->mnt->file_mode;
-	if (fattr->attr & aDIR)
-	{
+	if (fattr->attr & aDIR) {
 		fattr->f_mode = server->mnt->dir_mode;
 		fattr->f_size = SMB_ST_BLKSIZE;
 	}
@@ -2008,6 +2063,43 @@
 	return result;
 }
 
+void smb_decode_unix_basic(struct smb_fattr *fattr, char *p)
+{
+	/* FIXME: verify nls support. all is sent as utf8? */
+	__u64 devmajor, devminor;
+
+	fattr->f_unix = 1;
+	fattr->f_mode = 0;
+
+	/* FIXME: use the uniqueID from the remote instead? */
+	/* 0 L file size in bytes */
+	/* 8 L file size on disk in bytes (block count) */
+	/* 40 L uid */
+	/* 48 L gid */
+	/* 56 W file type */
+	/* 60 L devmajor */
+	/* 68 L devminor */
+	/* 76 L unique ID (inode) */
+	/* 84 L permissions */
+	/* 92 L link count */
+
+	fattr->f_size = LVAL(p, 0);
+	fattr->f_blocks = LVAL(p, 8);
+	fattr->f_ctime = smb_ntutc2unixutc(LVAL(p, 16));
+	fattr->f_atime = smb_ntutc2unixutc(LVAL(p, 24));
+	fattr->f_mtime = smb_ntutc2unixutc(LVAL(p, 32));
+	fattr->f_uid = LVAL(p, 40); 
+	fattr->f_gid = LVAL(p, 48); 
+	fattr->f_mode |= smb_filetype_to_mode(WVAL(p, 56));
+
+	if (S_ISBLK(fattr->f_mode) || S_ISCHR(fattr->f_mode)) {
+		devmajor = LVAL(p, 60);
+		devminor = LVAL(p, 68);
+		fattr->f_rdev = ((devmajor & 0xFF) << 8) | (devminor & 0xFF);
+	}
+	fattr->f_mode |= LVAL(p, 84);
+}
+
 /*
  * Interpret a long filename structure using the specified info level:
  *   level 1 for anything below NT1 protocol
@@ -2080,6 +2172,18 @@
 		VERBOSE("info 260 at %p, len=%d, name=%.*s\n",
 			p, len, len, qname->name);
 		break;
+	case SMB_FIND_FILE_UNIX:
+		result = p + WVAL(p, 0);
+		qname->name = p + 108;
+
+		len = strlen(qname->name);
+		/* FIXME: should we check the length?? */
+
+		p += 8;
+		smb_decode_unix_basic(fattr, p);
+		VERBOSE("info SMB_FIND_FILE_UNIX at %p, len=%d, name=%.*s\n",
+			p, len, len, qname->name);
+		break;
 	default:
 		PARANOIA("Unknown info level %d\n", level);
 		result = p + WVAL(p, 0);
@@ -2168,9 +2272,12 @@
 	lock_kernel();
 
 	/*
-	 * use info level 1 for older servers that don't do 260
+	 * We always prefer unix style. Use info level 1 for older
+	 * servers that don't do 260.
 	 */
-	if (server->opt.protocol < SMB_PROTOCOL_NT1)
+	if (server->opt.capabilities & SMB_CAP_UNIX)
+		info_level = SMB_FIND_FILE_UNIX;
+	else if (server->opt.protocol < SMB_PROTOCOL_NT1)
 		info_level = 1;
 
 	result = -ENOMEM;
@@ -2311,13 +2418,18 @@
 		 * here that those who do not point to a filename do not need
 		 * this info to continue the listing.
 		 *
-		 * OS/2 needs this and talks infolevel 1
-		 * NetApps want lastname with infolevel 260
+		 * OS/2 needs this and talks infolevel 1.
+		 * NetApps want lastname with infolevel 260.
+		 * win2k want lastname with infolevel 260, and points to
+		 *       the record not to the name.
+		 * Samba+CifsUnixExt doesn't need lastname.
 		 *
 		 * Both are happy if we return the data they point to. So we do.
+		 * (FIXME: above is not true with win2k)
 		 */
 		mask_len = 0;
-		if (ff_lastname > 0 && ff_lastname < req->rq_ldata) {
+		if (info_level != SMB_FIND_FILE_UNIX &&
+		    ff_lastname > 0 && ff_lastname < req->rq_ldata) {
 			lastname = req->rq_data + ff_lastname;
 
 			switch (info_level) {
@@ -2609,6 +2721,30 @@
 }
 
 static int
+smb_proc_getattr_unix(struct smb_sb_info *server, struct dentry *dir,
+		      struct smb_fattr *attr)
+{
+	struct smb_request *req;
+	int result;
+
+	result = -ENOMEM;
+	if (! (req = smb_alloc_request(server, PAGE_SIZE)))
+		goto out;
+
+	result = smb_proc_getattr_trans2(server, dir, req,
+					 SMB_QUERY_FILE_UNIX_BASIC);
+	if (result < 0)
+		goto out_free;
+
+	smb_decode_unix_basic(attr, req->rq_data);
+
+out_free:
+	smb_rput(req);
+out:
+	return result;
+}
+
+static int
 smb_proc_getattr_95(struct smb_sb_info *server, struct dentry *dir,
 		    struct smb_fattr *attr)
 {
@@ -2827,6 +2963,120 @@
 }
 
 /*
+ * ATTR_MODE      0x001
+ * ATTR_UID       0x002
+ * ATTR_GID       0x004
+ * ATTR_SIZE      0x008
+ * ATTR_ATIME     0x010
+ * ATTR_MTIME     0x020
+ * ATTR_CTIME     0x040
+ * ATTR_ATIME_SET 0x080
+ * ATTR_MTIME_SET 0x100
+ * ATTR_FORCE     0x200	
+ * ATTR_ATTR_FLAG 0x400
+ *
+ * major/minor should only be set by mknod.
+ */
+int
+smb_proc_setattr_unix(struct dentry *d, struct iattr *attr,
+		      int major, int minor)
+{
+	struct smb_sb_info *server = server_from_dentry(d);
+	u64 nttime;
+	char *p, *param;
+	int result;
+	char data[100];
+	struct smb_request *req;
+
+	result = -ENOMEM;
+	if (! (req = smb_alloc_request(server, PAGE_SIZE)))
+		goto out;
+	param = req->rq_buffer;
+
+	DEBUG1("valid flags = 0x%04x\n", attr->ia_valid);
+
+	WSET(param, 0, SMB_SET_FILE_UNIX_BASIC);
+	DSET(param, 2, 0);
+	result = smb_encode_path(server, param+6, SMB_MAXPATHLEN+1, d, NULL);
+	if (result < 0)
+		goto out_free;
+	p = param + 6 + result;
+
+	/* 0 L file size in bytes */
+	/* 8 L file size on disk in bytes (block count) */
+	/* 40 L uid */
+	/* 48 L gid */
+	/* 56 W file type enum */
+	/* 60 L devmajor */
+	/* 68 L devminor */
+	/* 76 L unique ID (inode) */
+	/* 84 L permissions */
+	/* 92 L link count */
+	LSET(data, 0, SMB_SIZE_NO_CHANGE);
+	LSET(data, 8, SMB_SIZE_NO_CHANGE);
+	LSET(data, 16, SMB_TIME_NO_CHANGE);
+	LSET(data, 24, SMB_TIME_NO_CHANGE);
+	LSET(data, 32, SMB_TIME_NO_CHANGE);
+	LSET(data, 40, SMB_UID_NO_CHANGE);
+	LSET(data, 48, SMB_GID_NO_CHANGE);
+	LSET(data, 56, smb_filetype_from_mode(attr->ia_mode));
+	LSET(data, 60, major);
+	LSET(data, 68, minor);
+	LSET(data, 76, 0);
+	LSET(data, 84, SMB_MODE_NO_CHANGE);
+	LSET(data, 92, 0);
+
+	if (attr->ia_valid & ATTR_SIZE) {
+		LSET(data, 0, attr->ia_size);
+		LSET(data, 8, 0); /* can't set anyway */
+	}
+
+	/*
+	 * FIXME: check the conversion function it the correct one
+	 *
+	 * we can't set ctime but we might as well pass this to the server
+	 * and let it ignore it.
+	 */
+	if (attr->ia_valid & ATTR_CTIME) {
+		nttime = smb_unixutc2ntutc(attr->ia_ctime);
+		LSET(data, 16, nttime);
+	}
+	if (attr->ia_valid & ATTR_ATIME) {
+		nttime = smb_unixutc2ntutc(attr->ia_atime);
+		LSET(data, 24, nttime);
+	}
+	if (attr->ia_valid & ATTR_MTIME) {
+		nttime = smb_unixutc2ntutc(attr->ia_mtime);
+		LSET(data, 32, nttime);
+	}
+	
+	if (attr->ia_valid & ATTR_UID) {
+		LSET(data, 40, attr->ia_uid);
+	}
+	if (attr->ia_valid & ATTR_GID) {
+		LSET(data, 48, attr->ia_gid); 
+	}
+	
+	if (attr->ia_valid & ATTR_MODE) {
+		LSET(data, 84, attr->ia_mode);
+	}
+
+	req->rq_trans2_command = TRANSACT2_SETPATHINFO;
+	req->rq_ldata = 100;
+	req->rq_data  = data;
+	req->rq_lparm = p - param;
+	req->rq_parm  = param;
+	req->rq_flags = 0;
+	result = smb_add_request(req);
+
+out_free:
+	smb_rput(req);
+out:
+	return result;
+}
+
+
+/*
  * Set the modify and access timestamps for a file.
  *
  * Incredibly enough, in all of SMB there is no message to allow
@@ -2909,6 +3159,189 @@
 	return result;
 }
 
+int
+smb_proc_read_link(struct smb_sb_info *server, struct dentry *d,
+		   char *buffer, int len)
+{
+	char *p, *param;
+	int result;
+	struct smb_request *req;
+
+	DEBUG1("readlink of %s/%s\n", DENTRY_PATH(d));
+
+	result = -ENOMEM;
+	if (! (req = smb_alloc_request(server, PAGE_SIZE)))
+		goto out;
+	param = req->rq_buffer;
+
+	WSET(param, 0, SMB_QUERY_FILE_UNIX_LINK);
+	DSET(param, 2, 0);
+	result = smb_encode_path(server, param+6, SMB_MAXPATHLEN+1, d, NULL);
+	if (result < 0)
+		goto out_free;
+	p = param + 6 + result;
+
+	req->rq_trans2_command = TRANSACT2_QPATHINFO;
+	req->rq_ldata = 0;
+	req->rq_data  = NULL;
+	req->rq_lparm = p - param;
+	req->rq_parm  = param;
+	req->rq_flags = 0;
+	result = smb_add_request(req);
+	if (result < 0)
+		goto out_free;
+	DEBUG1("for %s: result=%d, rcls=%d, err=%d\n",
+		&param[6], result, server->rcls, server->err);
+
+	/* copy data up to the \0 or buffer length */
+	result = len;
+	if (req->rq_ldata < len)
+		result = req->rq_ldata;
+	strncpy(buffer, req->rq_data, result);
+
+out_free:
+	smb_rput(req);
+out:
+	return result;
+}
+
+
+/*
+ * Create a symlink object called dentry which points to oldpath.
+ * Samba does not permit dangling links but returns a suitable error message.
+ */
+int
+smb_proc_symlink(struct smb_sb_info *server, struct dentry *d,
+		 const char *oldpath)
+{
+	char *p, *param;
+	int result;
+	struct smb_request *req;
+
+	result = -ENOMEM;
+	if (! (req = smb_alloc_request(server, PAGE_SIZE)))
+		goto out;
+	param = req->rq_buffer;
+
+	WSET(param, 0, SMB_SET_FILE_UNIX_LINK);
+	DSET(param, 2, 0);
+	result = smb_encode_path(server, param + 6, SMB_MAXPATHLEN+1, d, NULL);
+	if (result < 0)
+		goto out_free;
+	p = param + 6 + result;
+
+	req->rq_trans2_command = TRANSACT2_SETPATHINFO;
+	req->rq_ldata = strlen(oldpath) + 1;
+	req->rq_data  = (char *) oldpath;
+	req->rq_lparm = p - param;
+	req->rq_parm  = param;
+	req->rq_flags = 0;
+	result = smb_add_request(req);
+	if (result < 0)
+		goto out_free;
+
+	DEBUG1("for %s: result=%d, rcls=%d, err=%d\n",
+		&param[6], result, server->rcls, server->err);
+	result = 0;
+
+out_free:
+	smb_rput(req);
+out:
+	return result;
+}
+
+/*
+ * Create a hard link object called new_dentry which points to dentry.
+ */
+int
+smb_proc_link(struct smb_sb_info *server, struct dentry *dentry,
+	      struct dentry *new_dentry)
+{
+	char *p, *param;
+	int result;
+	struct smb_request *req;
+
+	result = -ENOMEM;
+	if (! (req = smb_alloc_request(server, PAGE_SIZE)))
+		goto out;
+	param = req->rq_buffer;
+
+	WSET(param, 0, SMB_SET_FILE_UNIX_HLINK);
+	DSET(param, 2, 0);
+	result = smb_encode_path(server, param + 6, SMB_MAXPATHLEN+1,
+				 new_dentry, NULL);
+	if (result < 0)
+		goto out_free;
+	p = param + 6 + result;
+
+	/* Grr, pointless separation of parameters and data ... */
+	req->rq_data = p;
+	req->rq_ldata = smb_encode_path(server, p, SMB_MAXPATHLEN+1,
+					dentry, NULL);
+
+	req->rq_trans2_command = TRANSACT2_SETPATHINFO;
+	req->rq_lparm = p - param;
+	req->rq_parm  = param;
+	req->rq_flags = 0;
+	result = smb_add_request(req);
+	if (result < 0)
+		goto out_free;
+
+	DEBUG1("for %s: result=%d, rcls=%d, err=%d\n",
+	       &param[6], result, server->rcls, server->err);
+	result = 0;
+
+out_free:
+	smb_rput(req);
+out:
+	return result;
+}
+
+int
+smb_proc_query_cifsunix(struct smb_sb_info *server)
+{
+	int result;
+	int major, minor;
+	u64 caps;
+	char param[2];
+	struct smb_request *req;
+
+	result = -ENOMEM;
+	if (! (req = smb_alloc_request(server, 100)))
+		goto out;
+
+	WSET(param, 0, SMB_QUERY_CIFS_UNIX_INFO);
+
+	req->rq_trans2_command = TRANSACT2_QFSINFO;
+	req->rq_ldata = 0;
+	req->rq_data  = NULL;
+	req->rq_lparm = 2;
+	req->rq_parm  = param;
+	req->rq_flags = 0;
+	result = smb_add_request(req);
+	if (result < 0)
+		goto out_free;
+
+	if (req->rq_ldata < 12) {
+		PARANOIA("Not enough data\n");
+		goto out_free;
+	}
+	major = WVAL(req->rq_data, 0);
+	minor = WVAL(req->rq_data, 2);
+
+	DEBUG1("Server implements CIFS Extensions for UNIX systems v%d.%d\n",
+	       major, minor);
+	/* FIXME: verify that we are ok with this major/minor? */
+
+	caps = LVAL(req->rq_data, 4);
+	DEBUG1("Server capabilities 0x%016llx\n", caps);
+
+out_free:
+	smb_rput(req);
+out:
+	return result;
+}
+
 
 static void
 install_ops(struct smb_ops *dst, struct smb_ops *src)
@@ -2955,3 +3388,15 @@
 	.getattr	= smb_proc_getattr_trans2_all,
 	.truncate	= smb_proc_trunc64,
 };
+
+/* Samba w/ unix extensions. Others? */
+static struct smb_ops smb_ops_unix =
+{
+	.read		= smb_proc_readX,
+	.write		= smb_proc_writeX,
+	.readdir	= smb_proc_readdir_long,
+	.getattr	= smb_proc_getattr_unix,
+	/* FIXME: core/ext/time setattr needs to be cleaned up! */
+	/* .setattr	= smb_proc_setattr_unix, */
+	.truncate	= smb_proc_trunc64,
+};
diff -urN -X exclude linux-2.5.39-orig/fs/smbfs/proto.h linux-2.5.39-smbfs/fs/smbfs/proto.h
--- linux-2.5.39-orig/fs/smbfs/proto.h	Tue Sep 17 20:05:34 2002
+++ linux-2.5.39-smbfs/fs/smbfs/proto.h	Sun Sep 29 21:49:03 2002
@@ -1,5 +1,5 @@
 /*
- *  Autogenerated with cproto on:  Fri Jul 12 22:15:26 CEST 2002
+ *  Autogenerated with cproto on:  Sun Sep 29 21:48:59 CEST 2002
  */
 
 struct smb_request;
@@ -22,13 +22,20 @@
 extern int smb_proc_unlink(struct dentry *dentry);
 extern int smb_proc_flush(struct smb_sb_info *server, __u16 fileid);
 extern void smb_init_root_dirent(struct smb_sb_info *server, struct smb_fattr *fattr);
+extern void smb_decode_unix_basic(struct smb_fattr *fattr, char *p);
 extern int smb_proc_getattr(struct dentry *dir, struct smb_fattr *fattr);
 extern int smb_proc_setattr(struct dentry *dir, struct smb_fattr *fattr);
+extern int smb_proc_setattr_unix(struct dentry *d, struct iattr *attr, int major, int minor);
 extern int smb_proc_settime(struct dentry *dentry, struct smb_fattr *fattr);
 extern int smb_proc_dskattr(struct super_block *sb, struct statfs *attr);
+extern int smb_proc_read_link(struct smb_sb_info *server, struct dentry *d, char *buffer, int len);
+extern int smb_proc_symlink(struct smb_sb_info *server, struct dentry *d, const char *oldpath);
+extern int smb_proc_link(struct smb_sb_info *server, struct dentry *dentry, struct dentry *new_dentry);
+extern int smb_proc_query_cifsunix(struct smb_sb_info *server);
 /* dir.c */
 extern struct file_operations smb_dir_operations;
 extern struct inode_operations smb_dir_inode_operations;
+extern struct inode_operations smb_dir_inode_operations_unix;
 extern void smb_new_dentry(struct dentry *dentry);
 extern void smb_renew_times(struct dentry *dentry);
 /* cache.c */
@@ -76,3 +83,8 @@
 extern int smb_request_send_req(struct smb_request *req);
 extern int smb_request_send_server(struct smb_sb_info *server);
 extern int smb_request_recv(struct smb_sb_info *server);
+/* symlink.c */
+extern int smb_read_link(struct dentry *dentry, char *buffer, int len);
+extern int smb_symlink(struct inode *inode, struct dentry *dentry, const char *oldname);
+extern int smb_follow_link(struct dentry *dentry, struct nameidata *nd);
+extern struct inode_operations smb_link_inode_operations;
diff -urN -X exclude linux-2.5.39-orig/fs/smbfs/symlink.c linux-2.5.39-smbfs/fs/smbfs/symlink.c
--- linux-2.5.39-orig/fs/smbfs/symlink.c	Thu Jan  1 01:00:00 1970
+++ linux-2.5.39-smbfs/fs/smbfs/symlink.c	Sun Sep 29 21:50:13 2002
@@ -0,0 +1,68 @@
+/*
+ *  symlink.c
+ *
+ *  Copyright (C) 2002 by John Newbigin
+ *
+ *  Please add a note about your changes to smbfs in the ChangeLog file.
+ */
+
+#include <linux/sched.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/fcntl.h>
+#include <linux/stat.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/pagemap.h>
+#include <linux/smp_lock.h>
+
+#include <asm/uaccess.h>
+#include <asm/system.h>
+
+#include <linux/smbno.h>
+#include <linux/smb_fs.h>
+
+#include "smb_debug.h"
+#include "proto.h"
+
+int smb_read_link(struct dentry *dentry, char *buffer, int len)
+{
+	char link[256];		/* FIXME: pain ... */
+	int r;
+	DEBUG1("read link buffer len = %d\n", len);
+
+	r = smb_proc_read_link(server_from_dentry(dentry), dentry, link,
+			       sizeof(link) - 1);
+	if (r < 0)
+		return -ENOENT;
+	return vfs_readlink(dentry, buffer, len, link);
+}
+
+int smb_symlink(struct inode *inode, struct dentry *dentry, const char *oldname)
+{
+	DEBUG1("create symlink %s -> %s/%s\n", oldname, DENTRY_PATH(dentry));
+
+	return smb_proc_symlink(server_from_dentry(dentry), dentry, oldname);
+}
+
+int smb_follow_link(struct dentry *dentry, struct nameidata *nd)
+{
+	char link[256];		/* FIXME: pain ... */
+	int len;
+	DEBUG1("followlink of %s/%s\n", DENTRY_PATH(dentry));
+
+	len = smb_proc_read_link(server_from_dentry(dentry), dentry, link,
+				 sizeof(link) - 1);
+	if(len < 0)
+		return -ENOENT;
+
+	link[len] = 0;
+	return vfs_follow_link(nd, link);
+}
+
+
+struct inode_operations smb_link_inode_operations =
+{
+	.readlink	smb_read_link,
+	.follow_link	smb_follow_link,
+};
diff -urN -X exclude linux-2.5.39-orig/include/linux/smb.h linux-2.5.39-smbfs/include/linux/smb.h
--- linux-2.5.39-orig/include/linux/smb.h	Tue Sep 17 20:05:32 2002
+++ linux-2.5.39-smbfs/include/linux/smb.h	Sun Sep 29 21:48:37 2002
@@ -76,7 +76,6 @@
  * Contains all relevant data on a SMB networked file.
  */
 struct smb_fattr {
-
 	__u16 attr;
 
 	unsigned long	f_ino;
@@ -84,12 +83,14 @@
 	nlink_t		f_nlink;
 	uid_t		f_uid;
 	gid_t		f_gid;
+	dev_t		f_rdev;
 	loff_t		f_size;
 	time_t		f_atime;
 	time_t		f_mtime;
 	time_t		f_ctime;
 	unsigned long	f_blksize;
 	unsigned long	f_blocks;
+	int		f_unix;
 };
 
 enum smb_conn_state {
diff -urN -X exclude linux-2.5.39-orig/include/linux/smb_fs.h linux-2.5.39-smbfs/include/linux/smb_fs.h
--- linux-2.5.39-orig/include/linux/smb_fs.h	Tue Sep 17 20:05:40 2002
+++ linux-2.5.39-smbfs/include/linux/smb_fs.h	Sun Sep 29 21:48:37 2002
@@ -112,19 +112,20 @@
 
 
 /* NT1 protocol capability bits */
-#define SMB_CAP_RAW_MODE         0x0001
-#define SMB_CAP_MPX_MODE         0x0002
-#define SMB_CAP_UNICODE          0x0004
-#define SMB_CAP_LARGE_FILES      0x0008
-#define SMB_CAP_NT_SMBS          0x0010
-#define SMB_CAP_RPC_REMOTE_APIS  0x0020
-#define SMB_CAP_STATUS32         0x0040
-#define SMB_CAP_LEVEL_II_OPLOCKS 0x0080
-#define SMB_CAP_LOCK_AND_READ    0x0100
-#define SMB_CAP_NT_FIND          0x0200
-#define SMB_CAP_DFS              0x1000
-#define SMB_CAP_LARGE_READX      0x4000
-#define SMB_CAP_LARGE_WRITEX     0x8000
+#define SMB_CAP_RAW_MODE         0x00000001
+#define SMB_CAP_MPX_MODE         0x00000002
+#define SMB_CAP_UNICODE          0x00000004
+#define SMB_CAP_LARGE_FILES      0x00000008
+#define SMB_CAP_NT_SMBS          0x00000010
+#define SMB_CAP_RPC_REMOTE_APIS  0x00000020
+#define SMB_CAP_STATUS32         0x00000040
+#define SMB_CAP_LEVEL_II_OPLOCKS 0x00000080
+#define SMB_CAP_LOCK_AND_READ    0x00000100
+#define SMB_CAP_NT_FIND          0x00000200
+#define SMB_CAP_DFS              0x00001000
+#define SMB_CAP_LARGE_READX      0x00004000
+#define SMB_CAP_LARGE_WRITEX     0x00008000
+#define SMB_CAP_UNIX             0x00800000	/* unofficial ... */
 
 
 /*
diff -urN -X exclude linux-2.5.39-orig/include/linux/smbno.h linux-2.5.39-smbfs/include/linux/smbno.h
--- linux-2.5.39-orig/include/linux/smbno.h	Sun Jun  9 07:30:31 2002
+++ linux-2.5.39-smbfs/include/linux/smbno.h	Sun Sep 29 21:48:37 2002
@@ -328,4 +328,36 @@
 #define SMB_FLAGS2_32_BIT_ERROR_CODES		0x4000 
 #define SMB_FLAGS2_UNICODE_STRINGS		0x8000
 
+
+/*
+ * UNIX stuff  (from samba trans2.h)
+ */
+#define MIN_UNIX_INFO_LEVEL		0x200
+#define MAX_UNIX_INFO_LEVEL		0x2FF
+#define SMB_FIND_FILE_UNIX		0x202
+#define SMB_QUERY_FILE_UNIX_BASIC	0x200
+#define SMB_QUERY_FILE_UNIX_LINK	0x201
+#define SMB_QUERY_FILE_UNIX_HLINK	0x202
+#define SMB_SET_FILE_UNIX_BASIC		0x200
+#define SMB_SET_FILE_UNIX_LINK		0x201
+#define SMB_SET_FILE_UNIX_HLINK		0x203
+#define SMB_QUERY_CIFS_UNIX_INFO	0x200
+
+/* values which means "don't change it" */
+#define SMB_MODE_NO_CHANGE		0xFFFFFFFF
+#define SMB_UID_NO_CHANGE		0xFFFFFFFF
+#define SMB_GID_NO_CHANGE		0xFFFFFFFF
+#define SMB_TIME_NO_CHANGE		0xFFFFFFFFFFFFFFFF
+#define SMB_SIZE_NO_CHANGE		0xFFFFFFFFFFFFFFFF
+
+/* UNIX filetype mappings. */
+#define UNIX_TYPE_FILE		0
+#define UNIX_TYPE_DIR		1
+#define UNIX_TYPE_SYMLINK	2
+#define UNIX_TYPE_CHARDEV	3
+#define UNIX_TYPE_BLKDEV	4
+#define UNIX_TYPE_FIFO		5
+#define UNIX_TYPE_SOCKET	6
+#define UNIX_TYPE_UNKNOWN	0xFFFFFFFF
+
 #endif /* _SMBNO_H_ */

