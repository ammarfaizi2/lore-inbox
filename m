Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268407AbUIWL6i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268407AbUIWL6i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 07:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268409AbUIWL6h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 07:58:37 -0400
Received: from smtp.infolink.com.br ([200.187.64.6]:7942 "EHLO
	smtp.infolink.com.br") by vger.kernel.org with ESMTP
	id S268407AbUIWL62 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 07:58:28 -0400
Message-ID: <4152BA61.6030400@infolink.com.br>
Date: Thu, 23 Sep 2004 08:58:25 -0300
From: Haroldo Gamal <haroldo.gamal@infolink.com.br>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: urban@teststation.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] smbfs: smbfs do not honor uid, gid, file_mode and dir_mode
 supplied by user mount
Content-Type: multipart/mixed;
 boundary="------------070602050104070209040107"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070602050104070209040107
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

This patch fixes "Samba Bugzilla Bug 999". The last version (2.6.8.1) of 
smbfs kernel module do not honor uid, gid, file_mode and dir_mode 
supplied by user during mount. This bug is also logged as "Kernel Bug 
Tracker Bug 3330".
To fully work, some modifications are needed to samba smbmount.c and 
smbmnt.c files. Those patches are available at  Samba and Kernel Bug 
Tracker pages.
After those patches, if the user do not supply any of the parameters 
above, the uid, gid, file_mode and dir_mode on the server will be used 
by the client.

Haroldo Gamal



--------------070602050104070209040107
Content-Type: text/x-patch;
 name="smbfs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="smbfs.patch"

diff -uprN -X dontdiff linux-2.6.8.1.org/fs/smbfs/inode.c linux-2.6.8.1/fs/smbfs/inode.c
--- linux-2.6.8.1.org/fs/smbfs/inode.c	2004-08-14 07:54:50.000000000 -0300
+++ linux-2.6.8.1/fs/smbfs/inode.c	2004-09-01 16:38:14.000000000 -0300
@@ -368,7 +368,6 @@ parse_options(struct smb_mount_data_kern
 				&optopt, &optarg, &flags, &value)) > 0) {
 
 		VERBOSE("'%s' -> '%s'\n", optopt, optarg ? optarg : "<none>");
-
 		switch (c) {
 		case 1:
 			/* got a "flag" option */
@@ -383,15 +382,19 @@ parse_options(struct smb_mount_data_kern
 			break;
 		case 'u':
 			mnt->uid = value;
+			flags |= SMB_MOUNT_UID;
 			break;
 		case 'g':
 			mnt->gid = value;
+			flags |= SMB_MOUNT_GID;
 			break;
 		case 'f':
 			mnt->file_mode = (value & S_IRWXUGO) | S_IFREG;
+			flags |= SMB_MOUNT_FMODE;
 			break;
 		case 'd':
 			mnt->dir_mode = (value & S_IRWXUGO) | S_IFDIR;
+			flags |= SMB_MOUNT_DMODE;
 			break;
 		case 'i':
 			strlcpy(mnt->codepage.local_name, optarg, 
@@ -429,9 +432,9 @@ smb_show_options(struct seq_file *s, str
 		if (mnt->flags & opts[i].flag)
 			seq_printf(s, ",%s", opts[i].name);
 
-	if (mnt->uid != 0)
+	if (mnt->flags & SMB_MOUNT_UID)
 		seq_printf(s, ",uid=%d", mnt->uid);
-	if (mnt->gid != 0)
+	if (mnt->flags & SMB_MOUNT_GID)
 		seq_printf(s, ",gid=%d", mnt->gid);
 	if (mnt->mounted_uid != 0)
 		seq_printf(s, ",mounted_uid=%d", mnt->mounted_uid);
@@ -440,8 +443,10 @@ smb_show_options(struct seq_file *s, str
 	 * Defaults for file_mode and dir_mode are unknown to us; they
 	 * depend on the current umask of the user doing the mount.
 	 */
-	seq_printf(s, ",file_mode=%04o", mnt->file_mode & S_IRWXUGO);
-	seq_printf(s, ",dir_mode=%04o", mnt->dir_mode & S_IRWXUGO);
+	if (mnt->flags & SMB_MOUNT_FMODE)
+		seq_printf(s, ",file_mode=%04o", mnt->file_mode & S_IRWXUGO);
+	if (mnt->flags & SMB_MOUNT_DMODE)
+		seq_printf(s, ",dir_mode=%04o", mnt->dir_mode & S_IRWXUGO);
 
 	if (strcmp(mnt->codepage.local_name, CONFIG_NLS_DEFAULT))
 		seq_printf(s, ",iocharset=%s", mnt->codepage.local_name);
@@ -566,8 +571,13 @@ int smb_fill_super(struct super_block *s
 		mnt->file_mode = (oldmnt->file_mode & S_IRWXUGO) | S_IFREG;
 		mnt->dir_mode = (oldmnt->dir_mode & S_IRWXUGO) | S_IFDIR;
 
-		mnt->flags = (oldmnt->file_mode >> 9);
+		mnt->flags = (oldmnt->file_mode >> 9) | SMB_MOUNT_UID | 
+			SMB_MOUNT_GID | SMB_MOUNT_FMODE | SMB_MOUNT_DMODE;
 	} else {
+		mnt->file_mode = mnt->dir_mode = S_IRWXU | S_IRGRP | S_IXGRP | 
+						S_IROTH | S_IXOTH | S_IFREG;
+		mnt->dir_mode = mnt->dir_mode = S_IRWXU | S_IRGRP | S_IXGRP | 
+						S_IROTH | S_IXOTH | S_IFDIR;
 		if (parse_options(mnt, raw_data))
 			goto out_bad_option;
 	}
@@ -599,6 +609,7 @@ int smb_fill_super(struct super_block *s
 	sb->s_root = d_alloc_root(root_inode);
 	if (!sb->s_root)
 		goto out_no_root;
+
 	smb_new_dentry(sb->s_root);
 
 	return 0;
diff -uprN -X dontdiff linux-2.6.8.1.org/fs/smbfs/proc.c linux-2.6.8.1/fs/smbfs/proc.c
--- linux-2.6.8.1.org/fs/smbfs/proc.c	2004-08-14 07:54:50.000000000 -0300
+++ linux-2.6.8.1/fs/smbfs/proc.c	2004-09-01 12:22:56.000000000 -0300
@@ -2074,7 +2074,7 @@ out:
 	return result;
 }
 
-void smb_decode_unix_basic(struct smb_fattr *fattr, char *p)
+void smb_decode_unix_basic(struct smb_fattr *fattr, struct smb_sb_info *server, char *p)
 {
 	/* FIXME: verify nls support. all is sent as utf8? */
 
@@ -2098,8 +2098,17 @@ void smb_decode_unix_basic(struct smb_fa
 	fattr->f_ctime = smb_ntutc2unixutc(LVAL(p, 16));
 	fattr->f_atime = smb_ntutc2unixutc(LVAL(p, 24));
 	fattr->f_mtime = smb_ntutc2unixutc(LVAL(p, 32));
-	fattr->f_uid = LVAL(p, 40); 
-	fattr->f_gid = LVAL(p, 48); 
+
+	if (server->mnt->flags & SMB_MOUNT_UID)
+		fattr->f_uid = server->mnt->uid;
+	else
+		fattr->f_uid = LVAL(p, 40); 
+
+	if (server->mnt->flags & SMB_MOUNT_GID)
+		fattr->f_gid = server->mnt->gid;
+	else
+		fattr->f_gid = LVAL(p, 48); 
+
 	fattr->f_mode |= smb_filetype_to_mode(WVAL(p, 56));
 
 	if (S_ISBLK(fattr->f_mode) || S_ISCHR(fattr->f_mode)) {
@@ -2108,10 +2117,19 @@ void smb_decode_unix_basic(struct smb_fa
 
 		fattr->f_rdev = MKDEV(major & 0xffffffff, minor & 0xffffffff);
 		if (MAJOR(fattr->f_rdev) != (major & 0xffffffff) ||
-		    MINOR(fattr->f_rdev) != (minor & 0xffffffff))
+	    	MINOR(fattr->f_rdev) != (minor & 0xffffffff))
 			fattr->f_rdev = 0;
 	}
+
 	fattr->f_mode |= LVAL(p, 84);
+
+	if ( (server->mnt->flags & SMB_MOUNT_DMODE) &&
+	     (S_ISDIR(fattr->f_mode)) ) 
+		fattr->f_mode = (server->mnt->dir_mode & (S_IRWXU | S_IRWXG | S_IRWXO)) | S_IFDIR;
+	else if ( (server->mnt->flags & SMB_MOUNT_FMODE) &&
+	          !(S_ISDIR(fattr->f_mode)) ) 
+		fattr->f_mode = (server->mnt->file_mode & (S_IRWXU | S_IRWXG | S_IRWXO)) | S_IFREG;
+
 }
 
 /*
@@ -2197,7 +2215,7 @@ smb_decode_long_dirent(struct smb_sb_inf
 		/* FIXME: should we check the length?? */
 
 		p += 8;
-		smb_decode_unix_basic(fattr, p);
+		smb_decode_unix_basic(fattr, server, p);
 		VERBOSE("info SMB_FIND_FILE_UNIX at %p, len=%d, name=%.*s\n",
 			p, len, len, qname->name);
 		break;
@@ -2756,7 +2774,7 @@ smb_proc_getattr_unix(struct smb_sb_info
 	if (result < 0)
 		goto out_free;
 
-	smb_decode_unix_basic(attr, req->rq_data);
+	smb_decode_unix_basic(attr, server, req->rq_data);
 
 out_free:
 	smb_rput(req);
diff -uprN -X dontdiff linux-2.6.8.1.org/fs/smbfs/proto.h linux-2.6.8.1/fs/smbfs/proto.h
--- linux-2.6.8.1.org/fs/smbfs/proto.h	2004-08-14 07:55:34.000000000 -0300
+++ linux-2.6.8.1/fs/smbfs/proto.h	2004-08-31 13:10:37.000000000 -0300
@@ -24,7 +24,7 @@ extern int smb_proc_rmdir(struct dentry 
 extern int smb_proc_unlink(struct dentry *dentry);
 extern int smb_proc_flush(struct smb_sb_info *server, __u16 fileid);
 extern void smb_init_root_dirent(struct smb_sb_info *server, struct smb_fattr *fattr);
-extern void smb_decode_unix_basic(struct smb_fattr *fattr, char *p);
+extern void smb_decode_unix_basic(struct smb_fattr *fattr, struct smb_sb_info *server, char *p);
 extern int smb_proc_getattr(struct dentry *dir, struct smb_fattr *fattr);
 extern int smb_proc_setattr(struct dentry *dir, struct smb_fattr *fattr);
 extern int smb_proc_setattr_unix(struct dentry *d, struct iattr *attr, unsigned int major, unsigned int minor);
diff -uprN -X dontdiff linux-2.6.8.1.org/include/linux/smb_mount.h linux-2.6.8.1/include/linux/smb_mount.h
--- linux-2.6.8.1.org/include/linux/smb_mount.h	2004-08-14 07:54:46.000000000 -0300
+++ linux-2.6.8.1/include/linux/smb_mount.h	2004-08-31 13:10:29.000000000 -0300
@@ -38,7 +38,10 @@ struct smb_mount_data {
 #define SMB_MOUNT_DIRATTR	0x0004	/* Use find_first for getattr */
 #define SMB_MOUNT_CASE		0x0008	/* Be case sensitive */
 #define SMB_MOUNT_UNICODE	0x0010	/* Server talks unicode */
-
+#define SMB_MOUNT_UID		0x0020  /* Use user specified uid */
+#define SMB_MOUNT_GID		0x0040  /* Use user specified gid */
+#define SMB_MOUNT_FMODE		0x0080  /* Use user specified file mode */
+#define SMB_MOUNT_DMODE		0x0100  /* Use user specified dir mode */
 
 struct smb_mount_data_kernel {
 	int version;

--------------070602050104070209040107--
