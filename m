Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311444AbSCNAYN>; Wed, 13 Mar 2002 19:24:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311445AbSCNAYF>; Wed, 13 Mar 2002 19:24:05 -0500
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:25555 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S311443AbSCNAX4>; Wed, 13 Mar 2002 19:23:56 -0500
Message-ID: <3C8FE978.9090403@didntduck.org>
Date: Wed, 13 Mar 2002 19:06:16 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] struct super_block cleanup - smbfs
Content-Type: multipart/mixed;
 boundary="------------080005020308010604040508"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080005020308010604040508
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Seperates smb_sb_info from struct super_block.

-- 

						Brian Gerst

--------------080005020308010604040508
Content-Type: text/plain;
 name="sb-smbfs-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sb-smbfs-1"

diff -urN linux-2.5.7-pre1/fs/smbfs/inode.c linux/fs/smbfs/inode.c
--- linux-2.5.7-pre1/fs/smbfs/inode.c	Tue Mar 12 17:35:11 2002
+++ linux/fs/smbfs/inode.c	Tue Mar 12 21:13:04 2002
@@ -400,7 +400,7 @@
 static int
 smb_show_options(struct seq_file *s, struct vfsmount *m)
 {
-	struct smb_mount_data_kernel *mnt = m->mnt_sb->u.smbfs_sb.mnt;
+	struct smb_mount_data_kernel *mnt = SMB_SB(m->mnt_sb)->mnt;
 	int i;
 
 	for (i = 0; opts[i].name != NULL; i++)
@@ -435,7 +435,7 @@
 static void
 smb_put_super(struct super_block *sb)
 {
-	struct smb_sb_info *server = &(sb->u.smbfs_sb);
+	struct smb_sb_info *server = SMB_SB(sb);
 
 	if (server->sock_file) {
 		smb_dont_catch_keepalive(server);
@@ -457,11 +457,13 @@
 		unload_nls(server->local_nls);
 		server->local_nls = NULL;
 	}
+	sb->u.generic_sbp = NULL;
+	smb_kfree(server);
 }
 
 int smb_fill_super(struct super_block *sb, void *raw_data, int silent)
 {
-	struct smb_sb_info *server = &sb->u.smbfs_sb;
+	struct smb_sb_info *server;
 	struct smb_mount_data_kernel *mnt;
 	struct smb_mount_data *oldmnt;
 	struct inode *root_inode;
@@ -482,6 +484,13 @@
 	sb->s_magic = SMB_SUPER_MAGIC;
 	sb->s_op = &smb_sops;
 
+	server = smb_kmalloc(sizeof(struct smb_sb_info), GFP_KERNEL);
+	if (!server)
+		goto out_no_server;
+	sb->u.generic_sbp = server;
+	memset(server, 0, sizeof(struct smb_sb_info));
+
+	server->super_block = sb;
 	server->mnt = NULL;
 	server->sock_file = NULL;
 	init_MUTEX(&server->sem);
@@ -578,6 +587,8 @@
 out_no_mem:
 	if (!server->mnt)
 		printk(KERN_ERR "smb_fill_super: allocation failure\n");
+	sb->u.generic_sbp = NULL;
+	smb_kfree(server);
 	goto out_fail;
 out_wrong_data:
 	printk(KERN_ERR "smbfs: mount_data version %d is not supported\n", ver);
@@ -586,6 +597,9 @@
 	printk(KERN_ERR "smb_fill_super: missing data argument\n");
 out_fail:
 	return -EINVAL;
+out_no_server:
+	printk(KERN_ERR "smb_fill_super: cannot allocate struct smb_sb_info\n");
+	return -ENOMEM;
 }
 
 static int
diff -urN linux-2.5.7-pre1/fs/smbfs/proc.c linux/fs/smbfs/proc.c
--- linux-2.5.7-pre1/fs/smbfs/proc.c	Thu Mar  7 21:18:13 2002
+++ linux/fs/smbfs/proc.c	Tue Mar 12 20:53:59 2002
@@ -2884,7 +2884,7 @@
 int
 smb_proc_dskattr(struct super_block *sb, struct statfs *attr)
 {
-	struct smb_sb_info *server = &(sb->u.smbfs_sb);
+	struct smb_sb_info *server = SMB_SB(sb);
 	int result;
 	char *p;
 	long unit;
diff -urN linux-2.5.7-pre1/include/linux/fs.h linux/include/linux/fs.h
--- linux-2.5.7-pre1/include/linux/fs.h	Tue Mar 12 20:22:02 2002
+++ linux/include/linux/fs.h	Tue Mar 12 21:08:13 2002
@@ -660,7 +660,6 @@
 #include <linux/ufs_fs_sb.h>
 #include <linux/efs_fs_sb.h>
 #include <linux/romfs_fs_sb.h>
-#include <linux/smb_fs_sb.h>
 #include <linux/hfs_fs_sb.h>
 #include <linux/adfs_fs_sb.h>
 #include <linux/qnx4_fs_sb.h>
@@ -717,7 +716,6 @@
 		struct efs_sb_info	efs_sb;
 		struct shmem_sb_info	shmem_sb;
 		struct romfs_sb_info	romfs_sb;
-		struct smb_sb_info	smbfs_sb;
 		struct hfs_sb_info	hfs_sb;
 		struct adfs_sb_info	adfs_sb;
 		struct qnx4_sb_info	qnx4_sb;
diff -urN linux-2.5.7-pre1/include/linux/smb_fs.h linux/include/linux/smb_fs.h
--- linux-2.5.7-pre1/include/linux/smb_fs.h	Thu Mar  7 21:18:55 2002
+++ linux/include/linux/smb_fs.h	Tue Mar 12 21:09:06 2002
@@ -11,6 +11,7 @@
 
 #include <linux/smb.h>
 #include <linux/smb_fs_i.h>
+#include <linux/smb_fs_sb.h>
 
 /*
  * ioctl commands
@@ -29,6 +30,11 @@
 #include <linux/smb_mount.h>
 #include <asm/unaligned.h>
 
+static inline struct smb_sb_info *SMB_SB(struct super_block *sb)
+{
+	return sb->u.generic_sbp;
+}
+
 static inline struct smb_inode_info *SMB_I(struct inode *inode)
 {
 	return list_entry(inode, struct smb_inode_info, vfs_inode);
diff -urN linux-2.5.7-pre1/include/linux/smb_fs_sb.h linux/include/linux/smb_fs_sb.h
--- linux-2.5.7-pre1/include/linux/smb_fs_sb.h	Tue Mar 12 20:22:02 2002
+++ linux/include/linux/smb_fs_sb.h	Tue Mar 12 21:12:19 2002
@@ -15,10 +15,9 @@
 #include <linux/smb.h>
 
 /* structure access macros */
-#define server_from_inode(inode) (&(inode)->i_sb->u.smbfs_sb)
-#define server_from_dentry(dentry) (&(dentry)->d_sb->u.smbfs_sb)
-#define SB_of(server) ((struct super_block *) ((char *)(server) - \
-	(unsigned long)(&((struct super_block *)0)->u.smbfs_sb)))
+#define server_from_inode(inode) SMB_SB((inode)->i_sb)
+#define server_from_dentry(dentry) SMB_SB((dentry)->d_sb)
+#define SB_of(server) ((server)->super_block)
 
 struct smb_sb_info {
         enum smb_conn_state state;
@@ -55,6 +54,7 @@
 	char *name_buf;
 
 	struct smb_ops *ops;
+	struct super_block *super_block;
 };
 
 

--------------080005020308010604040508--


