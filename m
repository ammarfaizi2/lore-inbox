Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287191AbSACMUv>; Thu, 3 Jan 2002 07:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287193AbSACMUn>; Thu, 3 Jan 2002 07:20:43 -0500
Received: from fungus.teststation.com ([212.32.186.211]:516 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S287191AbSACMUV>; Thu, 3 Jan 2002 07:20:21 -0500
Date: Thu, 3 Jan 2002 13:20:05 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: <puw@cola.teststation.com>
To: Linus Torvalds <torvalds@transmeta.com>, Dave Jones <davej@suse.de>
cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] smbfs fsx'ed
Message-ID: <Pine.LNX.4.33.0201031306240.26000-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello

Here are some updates for smbfs:
+ Drops kmap/kunmap from prepare_write/commit_write
+ Fixes two problems spotted by fsx-linux, leaving one unfixed
  - Shared mmaps must be written back before closing as smb does not allow
    you to write after the file is closed. Flushing written pages before
    closing makes smbfs do what the application wants.
  - On truncate, dirty pages need to be written out first because of the
    order of smb_proc_trunc and vmtruncate. I believe this is the same
    issue as NFS had.
  - I can still see one problem, but only with windows servers. When
    creating a hole in a file the hole does not always contain all zeroes.
    As far as I can tell the command to truncate is sent to the server,
    and then the page fsx errors on is re-read.
    Server issue? Don't know but I can't trigger it with a samba server.
+ Rene Scharfe has added options display for /proc/mounts.

Patch vs 2.5.2-pre5, but should work for 2.5.2-pre6 and 2.5.1-dj11.
Please apply.

/Urban


diff -urN -X exclude linux-2.5.2-pre5-orig/fs/smbfs/ChangeLog linux-2.5.2-pre5-smbfs/fs/smbfs/ChangeLog
--- linux-2.5.2-pre5-orig/fs/smbfs/ChangeLog	Thu Nov  8 19:01:00 2001
+++ linux-2.5.2-pre5-smbfs/fs/smbfs/ChangeLog	Thu Jan  3 11:33:52 2002
@@ -1,5 +1,15 @@
 ChangeLog for smbfs.
 
+2001-12-31 René Scharfe <l.s.r@web.de>
+
+	* inode.c: added smb_show_options to show mount options in /proc/mounts
+	* inode.c, getopt.c, getopt.h: merged flag and has_arg in struct option
+	* inode.c: use S_IRWXUGO where appropriate
+
+2001-12-22 Urban Widmark <urban@teststation.com>
+
+	* file.c, proc.c: Fix problems triggered by the "fsx test"
+
 2001-09-17 Urban Widmark <urban@teststation.com>
 
 	* proc.c: Use 4096 (was 512) as the blocksize for better write
diff -urN -X exclude linux-2.5.2-pre5-orig/fs/smbfs/file.c linux-2.5.2-pre5-smbfs/fs/smbfs/file.c
--- linux-2.5.2-pre5-orig/fs/smbfs/file.c	Thu Nov  8 19:01:00 2001
+++ linux-2.5.2-pre5-smbfs/fs/smbfs/file.c	Wed Jan  2 21:11:40 2002
@@ -270,7 +270,6 @@
 static int smb_prepare_write(struct file *file, struct page *page, 
 			     unsigned offset, unsigned to)
 {
-	kmap(page);
 	return 0;
 }
 
@@ -283,7 +282,6 @@
 	lock_kernel();
 	status = smb_updatepage(file, page, offset, to-offset);
 	unlock_kernel();
-	kunmap(page);
 	return status;
 }
 
@@ -349,8 +347,14 @@
 smb_file_release(struct inode *inode, struct file * file)
 {
 	lock_kernel();
-	if (!--inode->u.smbfs_i.openers)
+	if (!--inode->u.smbfs_i.openers) {
+		/* We must flush any dirty pages now as we won't be able to
+		   write anything after close. mmap can trigger this.
+		   "openers" should perhaps include mmap'ers ... */
+		filemap_fdatasync(inode->i_mapping);
+		filemap_fdatawait(inode->i_mapping);
 		smb_close(inode);
+	}
 	unlock_kernel();
 	return 0;
 }
diff -urN -X exclude linux-2.5.2-pre5-orig/fs/smbfs/getopt.c linux-2.5.2-pre5-smbfs/fs/smbfs/getopt.c
--- linux-2.5.2-pre5-orig/fs/smbfs/getopt.c	Sun Aug 19 12:08:09 2001
+++ linux-2.5.2-pre5-smbfs/fs/smbfs/getopt.c	Thu Jan  3 11:32:54 2002
@@ -46,7 +46,7 @@
 
 	for (i = 0; opts[i].name != NULL; i++) {
 		if (!strcmp(opts[i].name, token)) {
-			if (opts[i].has_arg && (!val || !*val)) {
+			if (!opts[i].flag && (!val || !*val)) {
 				printk("%s: the %s option requires an argument\n",
 				       caller, token);
 				return -1;
diff -urN -X exclude linux-2.5.2-pre5-orig/fs/smbfs/getopt.h linux-2.5.2-pre5-smbfs/fs/smbfs/getopt.h
--- linux-2.5.2-pre5-orig/fs/smbfs/getopt.h	Mon Aug 14 22:31:10 2000
+++ linux-2.5.2-pre5-smbfs/fs/smbfs/getopt.h	Thu Jan  3 11:32:54 2002
@@ -3,7 +3,6 @@
 
 struct option {
 	const char *name;
-	int has_arg;
 	unsigned long flag;
 	int val;
 };
diff -urN -X exclude linux-2.5.2-pre5-orig/fs/smbfs/inode.c linux-2.5.2-pre5-smbfs/fs/smbfs/inode.c
--- linux-2.5.2-pre5-orig/fs/smbfs/inode.c	Thu Nov  8 19:01:00 2001
+++ linux-2.5.2-pre5-smbfs/fs/smbfs/inode.c	Thu Jan  3 11:41:05 2002
@@ -22,6 +22,7 @@
 #include <linux/dcache.h>
 #include <linux/smp_lock.h>
 #include <linux/nls.h>
+#include <linux/seq_file.h>
 
 #include <linux/smb_fs.h>
 #include <linux/smbno.h>
@@ -41,9 +42,12 @@
 #define SMB_NLS_REMOTE ""
 #endif
 
+#define SMB_TTL_DEFAULT 1000
+
 static void smb_delete_inode(struct inode *);
 static void smb_put_super(struct super_block *);
 static int  smb_statfs(struct super_block *, struct statfs *);
+static int  smb_show_options(struct seq_file *, struct vfsmount *);
 
 static struct super_operations smb_sops =
 {
@@ -51,6 +55,7 @@
 	delete_inode:	smb_delete_inode,
 	put_super:	smb_put_super,
 	statfs:		smb_statfs,
+	show_options:	smb_show_options,
 };
 
 
@@ -259,21 +264,20 @@
 	clear_inode(ino);
 }
 
-/* FIXME: flags and has_arg could probably be merged. */
 static struct option opts[] = {
-	{ "version",	1, 0, 'v' },
-	{ "win95",	0, SMB_MOUNT_WIN95, 1 },
-	{ "oldattr",	0, SMB_MOUNT_OLDATTR, 1 },
-	{ "dirattr",	0, SMB_MOUNT_DIRATTR, 1 },
-	{ "case",	0, SMB_MOUNT_CASE, 1 },
-	{ "uid",	1, 0, 'u' },
-	{ "gid",	1, 0, 'g' },
-	{ "file_mode",	1, 0, 'f' },
-	{ "dir_mode",	1, 0, 'd' },
-	{ "iocharset",	1, 0, 'i' },
-	{ "codepage",	1, 0, 'c' },
-	{ "ttl",	1, 0, 't' },
-	{ NULL,		0, 0, 0}
+	{ "version",	0, 'v' },
+	{ "win95",	SMB_MOUNT_WIN95, 1 },
+	{ "oldattr",	SMB_MOUNT_OLDATTR, 1 },
+	{ "dirattr",	SMB_MOUNT_DIRATTR, 1 },
+	{ "case",	SMB_MOUNT_CASE, 1 },
+	{ "uid",	0, 'u' },
+	{ "gid",	0, 'g' },
+	{ "file_mode",	0, 'f' },
+	{ "dir_mode",	0, 'd' },
+	{ "iocharset",	0, 'i' },
+	{ "codepage",	0, 'c' },
+	{ "ttl",	0, 't' },
+	{ NULL,		0, 0}
 };
 
 static int
@@ -310,12 +314,10 @@
 			mnt->gid = value;
 			break;
 		case 'f':
-			mnt->file_mode = value & (S_IRWXU | S_IRWXG | S_IRWXO);
-			mnt->file_mode |= S_IFREG;
+			mnt->file_mode = (value & S_IRWXUGO) | S_IFREG;
 			break;
 		case 'd':
-			mnt->dir_mode = value & (S_IRWXU | S_IRWXG | S_IRWXO);
-			mnt->dir_mode |= S_IFDIR;
+			mnt->dir_mode = (value & S_IRWXUGO) | S_IFDIR;
 			break;
 		case 'i':
 			strncpy(mnt->codepage.local_name, optarg, 
@@ -338,6 +340,45 @@
 	return c;
 }
 
+/*
+ * smb_show_options() is for displaying mount options in /proc/mounts.
+ * It tries to avoid showing settings that were not changed from their
+ * defaults.
+ */
+static int
+smb_show_options(struct seq_file *s, struct vfsmount *m)
+{
+	struct smb_mount_data_kernel *mnt = m->mnt_sb->u.smbfs_sb.mnt;
+	int i;
+
+	for (i = 0; opts[i].name != NULL; i++)
+		if (mnt->flags & opts[i].flag)
+			seq_printf(s, ",%s", opts[i].name);
+
+	if (mnt->uid != 0)
+		seq_printf(s, ",uid=%d", mnt->uid);
+	if (mnt->gid != 0)
+		seq_printf(s, ",gid=%d", mnt->gid);
+	if (mnt->mounted_uid != 0)
+		seq_printf(s, ",mounted_uid=%d", mnt->mounted_uid);
+
+	/* 
+	 * Defaults for file_mode and dir_mode are unknown to us; they
+	 * depend on the current umask of the user doing the mount.
+	 */
+	seq_printf(s, ",file_mode=%04o", mnt->file_mode & S_IRWXUGO);
+	seq_printf(s, ",dir_mode=%04o", mnt->dir_mode & S_IRWXUGO);
+
+	if (strcmp(mnt->codepage.local_name, CONFIG_NLS_DEFAULT))
+		seq_printf(s, ",iocharset=%s", mnt->codepage.local_name);
+	if (strcmp(mnt->codepage.remote_name, SMB_NLS_REMOTE))
+		seq_printf(s, ",codepage=%s", mnt->codepage.remote_name);
+
+	if (mnt->ttl != SMB_TTL_DEFAULT)
+		seq_printf(s, ",ttl=%d", mnt->ttl);
+
+	return 0;
+}
 
 static void
 smb_put_super(struct super_block *sb)
@@ -425,7 +466,7 @@
 	strncpy(mnt->codepage.remote_name, SMB_NLS_REMOTE,
 		SMB_NLS_MAXNAMELEN);
 
-	mnt->ttl = 1000;
+	mnt->ttl = SMB_TTL_DEFAULT;
 	if (ver == SMB_MOUNT_OLDVERSION) {
 		mnt->version = oldmnt->version;
 
@@ -434,12 +475,8 @@
 		mnt->uid = oldmnt->uid;
 		mnt->gid = oldmnt->gid;
 
-		mnt->file_mode =
-			oldmnt->file_mode & (S_IRWXU | S_IRWXG | S_IRWXO);
-		mnt->dir_mode =
-			oldmnt->dir_mode & (S_IRWXU | S_IRWXG | S_IRWXO);
-		mnt->file_mode |= S_IFREG;
-		mnt->dir_mode  |= S_IFDIR;
+		mnt->file_mode = (oldmnt->file_mode & S_IRWXUGO) | S_IFREG;
+		mnt->dir_mode = (oldmnt->dir_mode & S_IRWXUGO) | S_IFDIR;
 
 		mnt->flags = (oldmnt->file_mode >> 9);
 	} else {
@@ -510,7 +547,7 @@
 {
 	struct inode *inode = dentry->d_inode;
 	struct smb_sb_info *server = server_from_dentry(dentry);
-	unsigned int mask = (S_IFREG | S_IFDIR | S_IRWXU | S_IRWXG | S_IRWXO);
+	unsigned int mask = (S_IFREG | S_IFDIR | S_IRWXUGO);
 	int error, changed, refresh = 0;
 	struct smb_fattr fattr;
 
@@ -535,6 +572,10 @@
 		VERBOSE("changing %s/%s, old size=%ld, new size=%ld\n",
 			DENTRY_PATH(dentry),
 			(long) inode->i_size, (long) attr->ia_size);
+
+		filemap_fdatasync(inode->i_mapping);
+		filemap_fdatawait(inode->i_mapping);
+
 		error = smb_open(dentry, O_WRONLY);
 		if (error)
 			goto out;

