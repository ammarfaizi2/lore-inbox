Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262604AbUKRF5a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262604AbUKRF5a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 00:57:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262607AbUKRF53
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 00:57:29 -0500
Received: from smtp.infolink.com.br ([200.187.64.6]:8465 "EHLO
	smtp.infolink.com.br") by vger.kernel.org with ESMTP
	id S262604AbUKRF4S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 00:56:18 -0500
Subject: [PATCH] smbfs: Bug #3758 - Broken symlinks on smbfs with
	2.6.10-rc[12]
From: Haroldo Gamal <haroldo.gamal@infolink.com.br>
Reply-To: haroldo.gamal@infolink.com.br
To: Andrew Morton <akpm@osdl.org>
Cc: trewas@gmail.com, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-SikZJBn+3oCm+bMq1ONX"
Organization: Infolink LTDA
Message-Id: <1100757377.3504.39.camel@gamal>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 18 Nov 2004 03:56:18 -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-SikZJBn+3oCm+bMq1ONX
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The patches attached here fixes the BUG #3758 - "Broken symlinks on
smbfs with 2.6.10-rc[12]". There are two patches, one to be applied over
version 2.6.9 and the other over 2.6.10-rc2.

The old utilities (and the old driver) uses uid=0, gid=0, dmask=0 and
fmask=0 to flag the lack of this parameters on the mount command line.
When the user do not specify the uid, gid, fmask or dmask, the current
driver will assign gid=root,  gid=root, dmask=755, fmask=755. This
behavior is similar to the old 2.x samba versions.

To make the driver see the permissions and ownership assigned on the
server, "smbmount" and "smbmnt" utilities must be patched. The patches
is already available on the attached patches at Bug #3330 or Samba Bug
#999.

[]s,

Haroldo Gamal



--=-SikZJBn+3oCm+bMq1ONX
Content-Disposition: attachment; filename=smbfs-2.6.10.rc2-2.6.10.rc2.hg.patch
Content-Type: text/x-patch; name=smbfs-2.6.10.rc2-2.6.10.rc2.hg.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -Naur linux-2.6.10-rc2/fs/smbfs/inode.c linux-2.6.10-rc2-hg/fs/smbfs/inode.c
--- linux-2.6.10-rc2/fs/smbfs/inode.c	2004-11-18 03:30:31.000000000 -0200
+++ linux-2.6.10-rc2-hg/fs/smbfs/inode.c	2004-11-18 00:17:12.000000000 -0200
@@ -574,10 +574,10 @@
 		mnt->flags = (oldmnt->file_mode >> 9) | SMB_MOUNT_UID |
 			SMB_MOUNT_GID | SMB_MOUNT_FMODE | SMB_MOUNT_DMODE;
 	} else {
-		mnt->file_mode = mnt->dir_mode = S_IRWXU | S_IRGRP | S_IXGRP |
-						S_IROTH | S_IXOTH | S_IFREG;
-		mnt->dir_mode = mnt->dir_mode = S_IRWXU | S_IRGRP | S_IXGRP |
-						S_IROTH | S_IXOTH | S_IFDIR;
+		mnt->file_mode = S_IRWXU | S_IRGRP | S_IXGRP |
+				S_IROTH | S_IXOTH | S_IFREG;
+		mnt->dir_mode = S_IRWXU | S_IRGRP | S_IXGRP |
+				S_IROTH | S_IXOTH | S_IFDIR;
 		if (parse_options(mnt, raw_data))
 			goto out_bad_option;
 	}
diff -Naur linux-2.6.10-rc2/fs/smbfs/proc.c linux-2.6.10-rc2-hg/fs/smbfs/proc.c
--- linux-2.6.10-rc2/fs/smbfs/proc.c	2004-11-18 03:30:31.000000000 -0200
+++ linux-2.6.10-rc2-hg/fs/smbfs/proc.c	2004-11-18 00:02:35.000000000 -0200
@@ -2138,10 +2138,11 @@
 
 	if ( (server->mnt->flags & SMB_MOUNT_DMODE) &&
 	     (S_ISDIR(fattr->f_mode)) )
-		fattr->f_mode = (server->mnt->dir_mode & (S_IRWXU | S_IRWXG | S_IRWXO)) | S_IFDIR;
+		fattr->f_mode = (server->mnt->dir_mode & S_IRWXUGO) | S_IFDIR;
 	else if ( (server->mnt->flags & SMB_MOUNT_FMODE) &&
 	          !(S_ISDIR(fattr->f_mode)) )
-		fattr->f_mode = (server->mnt->file_mode & (S_IRWXU | S_IRWXG | S_IRWXO)) | S_IFREG;
+		fattr->f_mode = (server->mnt->file_mode & S_IRWXUGO) | 
+				(fattr->f_mode & S_IFMT);
 
 }
 

--=-SikZJBn+3oCm+bMq1ONX
Content-Disposition: attachment; filename=smbfs-2.6.9-2.6.10.rc2.hg.patch
Content-Type: text/x-patch; name=smbfs-2.6.9-2.6.10.rc2.hg.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -Naur linux-2.6.9.org/fs/smbfs/inode.c linux-2.6.10-rc2-hg/fs/smbfs/inode.c
--- linux-2.6.9.org/fs/smbfs/inode.c	2004-10-18 18:53:21.000000000 -0300
+++ linux-2.6.10-rc2-hg/fs/smbfs/inode.c	2004-11-18 00:17:12.000000000 -0200
@@ -368,7 +368,6 @@
 				&optopt, &optarg, &flags, &value)) > 0) {
 
 		VERBOSE("'%s' -> '%s'\n", optopt, optarg ? optarg : "<none>");
-
 		switch (c) {
 		case 1:
 			/* got a "flag" option */
@@ -383,15 +382,19 @@
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
@@ -429,9 +432,9 @@
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
@@ -440,8 +443,10 @@
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
@@ -566,8 +571,13 @@
 		mnt->file_mode = (oldmnt->file_mode & S_IRWXUGO) | S_IFREG;
 		mnt->dir_mode = (oldmnt->dir_mode & S_IRWXUGO) | S_IFDIR;
 
-		mnt->flags = (oldmnt->file_mode >> 9);
+		mnt->flags = (oldmnt->file_mode >> 9) | SMB_MOUNT_UID |
+			SMB_MOUNT_GID | SMB_MOUNT_FMODE | SMB_MOUNT_DMODE;
 	} else {
+		mnt->file_mode = S_IRWXU | S_IRGRP | S_IXGRP |
+				S_IROTH | S_IXOTH | S_IFREG;
+		mnt->dir_mode = S_IRWXU | S_IRGRP | S_IXGRP |
+				S_IROTH | S_IXOTH | S_IFDIR;
 		if (parse_options(mnt, raw_data))
 			goto out_bad_option;
 	}
@@ -599,6 +609,7 @@
 	sb->s_root = d_alloc_root(root_inode);
 	if (!sb->s_root)
 		goto out_no_root;
+
 	smb_new_dentry(sb->s_root);
 
 	return 0;
diff -Naur linux-2.6.9.org/fs/smbfs/proc.c linux-2.6.10-rc2-hg/fs/smbfs/proc.c
--- linux-2.6.9.org/fs/smbfs/proc.c	2004-10-18 18:53:21.000000000 -0300
+++ linux-2.6.10-rc2-hg/fs/smbfs/proc.c	2004-11-18 00:02:35.000000000 -0200
@@ -2074,7 +2074,7 @@
 	return result;
 }
 
-void smb_decode_unix_basic(struct smb_fattr *fattr, char *p)
+void smb_decode_unix_basic(struct smb_fattr *fattr, struct smb_sb_info *server, char *p)
 {
 	u64 size, disk_bytes;
 
@@ -2111,8 +2111,17 @@
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
@@ -2121,10 +2130,20 @@
 
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
+		fattr->f_mode = (server->mnt->dir_mode & S_IRWXUGO) | S_IFDIR;
+	else if ( (server->mnt->flags & SMB_MOUNT_FMODE) &&
+	          !(S_ISDIR(fattr->f_mode)) )
+		fattr->f_mode = (server->mnt->file_mode & S_IRWXUGO) | 
+				(fattr->f_mode & S_IFMT);
+
 }
 
 /*
@@ -2210,7 +2229,7 @@
 		/* FIXME: should we check the length?? */
 
 		p += 8;
-		smb_decode_unix_basic(fattr, p);
+		smb_decode_unix_basic(fattr, server, p);
 		VERBOSE("info SMB_FIND_FILE_UNIX at %p, len=%d, name=%.*s\n",
 			p, len, len, qname->name);
 		break;
@@ -2769,7 +2788,7 @@
 	if (result < 0)
 		goto out_free;
 
-	smb_decode_unix_basic(attr, req->rq_data);
+	smb_decode_unix_basic(attr, server, req->rq_data);
 
 out_free:
 	smb_rput(req);
diff -Naur linux-2.6.9.org/fs/smbfs/proto.h linux-2.6.10-rc2-hg/fs/smbfs/proto.h
--- linux-2.6.9.org/fs/smbfs/proto.h	2004-10-18 18:54:37.000000000 -0300
+++ linux-2.6.10-rc2-hg/fs/smbfs/proto.h	2004-11-17 23:41:44.000000000 -0200
@@ -24,7 +24,7 @@
 extern int smb_proc_unlink(struct dentry *dentry);
 extern int smb_proc_flush(struct smb_sb_info *server, __u16 fileid);
 extern void smb_init_root_dirent(struct smb_sb_info *server, struct smb_fattr *fattr);
-extern void smb_decode_unix_basic(struct smb_fattr *fattr, char *p);
+extern void smb_decode_unix_basic(struct smb_fattr *fattr, struct smb_sb_info *server, char *p);
 extern int smb_proc_getattr(struct dentry *dir, struct smb_fattr *fattr);
 extern int smb_proc_setattr(struct dentry *dir, struct smb_fattr *fattr);
 extern int smb_proc_setattr_unix(struct dentry *d, struct iattr *attr, unsigned int major, unsigned int minor);
--- linux-2.6.9.org/include/linux/smb_mount.h	2004-10-18 18:53:06.000000000 -0300
+++ linux-2.6.10-rc2-hg/include/linux/smb_mount.h	2004-11-17 23:41:47.000000000 -0200
@@ -38,7 +38,10 @@
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

--=-SikZJBn+3oCm+bMq1ONX--

