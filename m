Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262642AbTDMWgs (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 18:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262649AbTDMWgs (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 18:36:48 -0400
Received: from hera.cwi.nl ([192.16.191.8]:57550 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S262642AbTDMWgr (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Apr 2003 18:36:47 -0400
From: Andries.Brouwer@cwi.nl
Date: Mon, 14 Apr 2003 00:48:33 +0200 (MEST)
Message-Id: <UTC200304132248.h3DMmXb29042.aeb@smtp.cwi.nl>
To: akpm@digeo.com, linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] smb-diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Samba receives a 64+64 bit device number. Instead of throwing all
away and only preserving 8+8 we can now preserve 32+32.

Andries


diff -u --recursive --new-file -X /linux/dontdiff a/fs/smbfs/proc.c b/fs/smbfs/proc.c
--- a/fs/smbfs/proc.c	Tue Apr  8 09:36:43 2003
+++ b/fs/smbfs/proc.c	Sat Apr 12 13:33:39 2003
@@ -2085,7 +2085,6 @@
 void smb_decode_unix_basic(struct smb_fattr *fattr, char *p)
 {
 	/* FIXME: verify nls support. all is sent as utf8? */
-	__u64 devmajor, devminor;
 
 	fattr->f_unix = 1;
 	fattr->f_mode = 0;
@@ -2112,9 +2111,10 @@
 	fattr->f_mode |= smb_filetype_to_mode(WVAL(p, 56));
 
 	if (S_ISBLK(fattr->f_mode) || S_ISCHR(fattr->f_mode)) {
-		devmajor = LVAL(p, 60);
-		devminor = LVAL(p, 68);
-		fattr->f_rdev = ((devmajor & 0xFF) << 8) | (devminor & 0xFF);
+		__u64 major = LVAL(p, 60);
+		__u64 minor = LVAL(p, 68);
+
+		fattr->f_rdev = MKDEV(major & 0xffffffff, minor & 0xffffffff);
 	}
 	fattr->f_mode |= LVAL(p, 84);
 }
@@ -3008,7 +3008,7 @@
  */
 int
 smb_proc_setattr_unix(struct dentry *d, struct iattr *attr,
-		      int major, int minor)
+		      unsigned int major, unsigned int minor)
 {
 	struct smb_sb_info *server = server_from_dentry(d);
 	u64 nttime;
diff -u --recursive --new-file -X /linux/dontdiff a/fs/smbfs/proto.h b/fs/smbfs/proto.h
--- a/fs/smbfs/proto.h	Thu Jan  2 14:32:11 2003
+++ b/fs/smbfs/proto.h	Sat Apr 12 13:34:38 2003
@@ -27,7 +27,7 @@
 extern void smb_decode_unix_basic(struct smb_fattr *fattr, char *p);
 extern int smb_proc_getattr(struct dentry *dir, struct smb_fattr *fattr);
 extern int smb_proc_setattr(struct dentry *dir, struct smb_fattr *fattr);
-extern int smb_proc_setattr_unix(struct dentry *d, struct iattr *attr, int major, int minor);
+extern int smb_proc_setattr_unix(struct dentry *d, struct iattr *attr, unsigned int major, unsigned int minor);
 extern int smb_proc_settime(struct dentry *dentry, struct smb_fattr *fattr);
 extern int smb_proc_dskattr(struct super_block *sb, struct statfs *attr);
 extern int smb_proc_read_link(struct smb_sb_info *server, struct dentry *d, char *buffer, int len);
