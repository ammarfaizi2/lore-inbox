Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261549AbVG2ADd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261549AbVG2ADd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 20:03:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbVG2ADc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 20:03:32 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:12530 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261549AbVG2AD3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 20:03:29 -0400
Message-ID: <42E97236.6080404@mvista.com>
Date: Thu, 28 Jul 2005 17:03:02 -0700
From: Mark Bellon <mbellon@mvista.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc3 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH]  disk quotas fail when /etc/mtab is symlinked to /proc/mounts
Content-Type: multipart/mixed;
 boundary="------------040700050605000408080002"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------040700050605000408080002
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

If /etc/mtab is a regular file all of the mount options (of a file 
system) are written to /etc/mtab by the mount command. The quota tools 
look there for the quota strings for their operation. If, however, 
/etc/mtab is a symlink to /proc/mounts (a "good thing" in some 
environments)  the tools don't write anything - they assume the kernel 
will take care of things.

While the quota options are sent down to the kernel via the mount system 
call and the file system codes handle them properly unfortunately there 
is no code to echo the quota strings into /proc/mounts and the quota 
tools fail in the symlink case.

The attached patchs modify the EXT[2|3] and [X|J]FS codes to add the 
necessary hooks. The show_options function of each file system in these 
patches currently deal with only those things that seemed related to 
quotas; especially in the EXT3 case more can be done (later?).

The EXT3 has added error checking and has two minor changes:
    The "quota" option is considered part of the older style quotas
    Journalled quotas and older style quotas are mutually exclusive.
    - both discussable topics

mark

Signed-off-by: Mark Bellon <mbellon@mvista.com>


--------------040700050605000408080002
Content-Type: text/plain;
 name="quota-patch-2.6.13-rc3-git9"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="quota-patch-2.6.13-rc3-git9"

diff -Naur linux-2.6.13-rc3-git9-orig/include/linux/ext3_fs.h linux-2.6.13-rc3-git9/include/linux/ext3_fs.h
--- linux-2.6.13-rc3-git9-orig/include/linux/ext3_fs.h	2005-07-28 15:12:52.000000000 -0700
+++ linux-2.6.13-rc3-git9/include/linux/ext3_fs.h	2005-07-28 16:18:24.000000000 -0700
@@ -373,6 +373,8 @@
 #define EXT3_MOUNT_BARRIER		0x20000 /* Use block barriers */
 #define EXT3_MOUNT_NOBH			0x40000 /* No bufferheads */
 #define EXT3_MOUNT_QUOTA		0x80000 /* Some quota option set */
+#define EXT3_MOUNT_USRQUOTA		0x100000 /* "old" user quota */
+#define EXT3_MOUNT_GRPQUOTA		0x200000 /* "old" group quota */
 
 /* Compatibility, for having both ext2_fs.h and ext3_fs.h included at once */
 #ifndef _LINUX_EXT2_FS_H
diff -Naur linux-2.6.13-rc3-git9-orig/fs/ext3/super.c linux-2.6.13-rc3-git9/fs/ext3/super.c
--- linux-2.6.13-rc3-git9-orig/fs/ext3/super.c	2005-07-28 15:12:51.000000000 -0700
+++ linux-2.6.13-rc3-git9/fs/ext3/super.c	2005-07-28 16:01:15.000000000 -0700
@@ -35,6 +35,7 @@
 #include <linux/mount.h>
 #include <linux/namei.h>
 #include <linux/quotaops.h>
+#include <linux/seq_file.h>
 #include <asm/uaccess.h>
 #include "xattr.h"
 #include "acl.h"
@@ -510,6 +511,37 @@
 }
 
 #ifdef CONFIG_QUOTA
+static int ext3_show_options(struct seq_file *seq, struct vfsmount *vfs)
+{
+	struct ext3_sb_info *sbi = EXT3_SB(vfs->mnt_sb);
+
+	if (sbi->s_mount_opt & EXT3_MOUNT_JOURNAL_DATA)
+		seq_puts(seq, ",data=journal");
+
+	if (sbi->s_mount_opt & EXT3_MOUNT_ORDERED_DATA)
+		seq_puts(seq, ",data=ordered");
+
+	if (sbi->s_mount_opt & EXT3_MOUNT_WRITEBACK_DATA)
+		seq_puts(seq, ",data=writeback");
+
+	if (sbi->s_jquota_fmt)
+		seq_printf(seq, ",jqfmt=%s",
+		(sbi->s_jquota_fmt == QFMT_VFS_OLD) ? "vfsold": "vfsv0");
+
+	if (sbi->s_qf_names[USRQUOTA])
+		seq_printf(seq, ",usrjquota=%s", sbi->s_qf_names[USRQUOTA]);
+
+	if (sbi->s_qf_names[GRPQUOTA])
+		seq_printf(seq, ",grpjquota=%s", sbi->s_qf_names[GRPQUOTA]);
+
+	if (sbi->s_mount_opt & EXT3_MOUNT_USRQUOTA)
+		seq_puts(seq, ",usrquota");
+
+	if (sbi->s_mount_opt & EXT3_MOUNT_GRPQUOTA)
+		seq_puts(seq, ",grpquota");
+
+	return 0;
+}
 
 #define QTYPE2NAME(t) ((t)==USRQUOTA?"user":"group")
 #define QTYPE2MOPT(on, t) ((t)==USRQUOTA?((on)##USRJQUOTA):((on)##GRPJQUOTA))
@@ -572,6 +604,7 @@
 #ifdef CONFIG_QUOTA
 	.quota_read	= ext3_quota_read,
 	.quota_write	= ext3_quota_write,
+	.show_options	= ext3_show_options,
 #endif
 };
 
@@ -590,7 +623,8 @@
 	Opt_abort, Opt_data_journal, Opt_data_ordered, Opt_data_writeback,
 	Opt_usrjquota, Opt_grpjquota, Opt_offusrjquota, Opt_offgrpjquota,
 	Opt_jqfmt_vfsold, Opt_jqfmt_vfsv0, Opt_quota, Opt_noquota,
-	Opt_ignore, Opt_barrier, Opt_err, Opt_resize,
+	Opt_ignore, Opt_barrier, Opt_err, Opt_resize, Opt_usrquota,
+	Opt_grpquota
 };
 
 static match_table_t tokens = {
@@ -634,10 +668,10 @@
 	{Opt_grpjquota, "grpjquota=%s"},
 	{Opt_jqfmt_vfsold, "jqfmt=vfsold"},
 	{Opt_jqfmt_vfsv0, "jqfmt=vfsv0"},
-	{Opt_quota, "grpquota"},
+	{Opt_grpquota, "grpquota"},
 	{Opt_noquota, "noquota"},
 	{Opt_quota, "quota"},
-	{Opt_quota, "usrquota"},
+	{Opt_usrquota, "usrquota"},
 	{Opt_barrier, "barrier=%u"},
 	{Opt_err, NULL},
 	{Opt_resize, "resize"},
@@ -902,8 +936,18 @@
 		case Opt_jqfmt_vfsv0:
 			sbi->s_jquota_fmt = QFMT_VFS_V0;
 			break;
+		case Opt_usrquota:
+			set_opt(sbi->s_mount_opt, QUOTA);
+			set_opt(sbi->s_mount_opt, USRQUOTA);
+			break;
+		case Opt_grpquota:
+			set_opt(sbi->s_mount_opt, QUOTA);
+			set_opt(sbi->s_mount_opt, GRPQUOTA);
+			break;
 		case Opt_quota:
 			set_opt(sbi->s_mount_opt, QUOTA);
+			set_opt(sbi->s_mount_opt, GRPQUOTA);
+			set_opt(sbi->s_mount_opt, USRQUOTA);
 			break;
 		case Opt_noquota:
 			if (sb_any_quota_enabled(sb)) {
@@ -912,8 +956,13 @@
 				return 0;
 			}
 			clear_opt(sbi->s_mount_opt, QUOTA);
+			clear_opt(sbi->s_mount_opt, USRQUOTA);
+			clear_opt(sbi->s_mount_opt, GRPQUOTA);
 			break;
 #else
+		case Opt_quota:
+		case Opt_usrquota:
+		case Opt_grpquota:
 		case Opt_usrjquota:
 		case Opt_grpjquota:
 		case Opt_offusrjquota:
@@ -924,7 +973,6 @@
 				"EXT3-fs: journalled quota options not "
 				"supported.\n");
 			break;
-		case Opt_quota:
 		case Opt_noquota:
 			break;
 #endif
@@ -962,11 +1010,36 @@
 		}
 	}
 #ifdef CONFIG_QUOTA
-	if (!sbi->s_jquota_fmt && (sbi->s_qf_names[USRQUOTA] ||
-	    sbi->s_qf_names[GRPQUOTA])) {
-		printk(KERN_ERR
+	if (sbi->s_qf_names[USRQUOTA] || sbi->s_qf_names[GRPQUOTA]) {
+		if ((sbi->s_mount_opt & EXT3_MOUNT_USRQUOTA) || 
+		    (sbi->s_mount_opt & EXT3_MOUNT_GRPQUOTA)) {
+			printk(KERN_ERR
+			"EXT3-fs: only one type of quotas allowed.\n");
+
+			return 0;
+		}
+
+		if (!sbi->s_jquota_fmt) {
+			printk(KERN_ERR
 			"EXT3-fs: journalled quota format not specified.\n");
-		return 0;
+
+			return 0;
+		}
+
+		if ((sbi->s_mount_opt & EXT3_MOUNT_JOURNAL_DATA) == 0) {
+			printk(KERN_ERR
+	"EXT3-fs: journalled quota specified when data journalling is not.\n");
+
+			return 0;
+		}
+	}
+	else {
+		if (sbi->s_jquota_fmt) {
+			printk(KERN_ERR
+"EXT3-fs: journalled quota format specified with no journalling enabled.\n");
+
+			return 0;
+		}
 	}
 #endif
 
diff -Naur linux-2.6.13-rc3-git9-orig/include/linux/ext2_fs.h linux-2.6.13-rc3-git9/include/linux/ext2_fs.h
--- linux-2.6.13-rc3-git9-orig/include/linux/ext2_fs.h	2005-07-28 15:12:52.000000000 -0700
+++ linux-2.6.13-rc3-git9/include/linux/ext2_fs.h	2005-07-28 15:35:31.000000000 -0700
@@ -313,6 +313,9 @@
 #define EXT2_MOUNT_XATTR_USER		0x004000  /* Extended user attributes */
 #define EXT2_MOUNT_POSIX_ACL		0x008000  /* POSIX Access Control Lists */
 #define EXT2_MOUNT_XIP			0x010000  /* Execute in place */
+#define EXT2_MOUNT_USRQUOTA		0x020000 /* user quota */
+#define EXT2_MOUNT_GRPQUOTA		0x040000 /* group quota */
+
 
 #define clear_opt(o, opt)		o &= ~EXT2_MOUNT_##opt
 #define set_opt(o, opt)			o |= EXT2_MOUNT_##opt
diff -Naur linux-2.6.13-rc3-git9-orig/fs/ext2/super.c linux-2.6.13-rc3-git9/fs/ext2/super.c
--- linux-2.6.13-rc3-git9-orig/fs/ext2/super.c	2005-07-28 15:12:51.000000000 -0700
+++ linux-2.6.13-rc3-git9/fs/ext2/super.c	2005-07-28 15:36:51.000000000 -0700
@@ -19,6 +19,7 @@
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/string.h>
+#include <linux/fs.h>
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/blkdev.h>
@@ -27,6 +28,8 @@
 #include <linux/buffer_head.h>
 #include <linux/smp_lock.h>
 #include <linux/vfs.h>
+#include <linux/seq_file.h>
+#include <linux/mount.h>
 #include <asm/uaccess.h>
 #include "ext2.h"
 #include "xattr.h"
@@ -204,6 +207,19 @@
 #ifdef CONFIG_QUOTA
 static ssize_t ext2_quota_read(struct super_block *sb, int type, char *data, size_t len, loff_t off);
 static ssize_t ext2_quota_write(struct super_block *sb, int type, const char *data, size_t len, loff_t off);
+
+static int ext2_show_options(struct seq_file *seq, struct vfsmount *vfs)
+{
+	struct ext2_sb_info *sbi = EXT2_SB(vfs->mnt_sb);
+
+	if (sbi->s_mount_opt & EXT2_MOUNT_USRQUOTA)
+		seq_puts(seq, ",usrquota");
+
+	if (sbi->s_mount_opt & EXT2_MOUNT_GRPQUOTA)
+		seq_puts(seq, ",grpquota");
+
+	return 0;
+}
 #endif
 
 static struct super_operations ext2_sops = {
@@ -221,6 +237,7 @@
 #ifdef CONFIG_QUOTA
 	.quota_read	= ext2_quota_read,
 	.quota_write	= ext2_quota_write,
+	.show_options	= ext2_show_options
 #endif
 };
 
@@ -256,10 +273,11 @@
 
 enum {
 	Opt_bsd_df, Opt_minix_df, Opt_grpid, Opt_nogrpid,
-	Opt_resgid, Opt_resuid, Opt_sb, Opt_err_cont, Opt_err_panic, Opt_err_ro,
-	Opt_nouid32, Opt_check, Opt_nocheck, Opt_debug, Opt_oldalloc, Opt_orlov, Opt_nobh,
-	Opt_user_xattr, Opt_nouser_xattr, Opt_acl, Opt_noacl, Opt_xip,
-	Opt_ignore, Opt_err,
+	Opt_resgid, Opt_resuid, Opt_sb, Opt_err_cont, Opt_err_panic,
+	Opt_err_ro, Opt_nouid32, Opt_check, Opt_nocheck, Opt_debug,
+	Opt_oldalloc, Opt_orlov, Opt_nobh, Opt_user_xattr, Opt_nouser_xattr,
+	Opt_acl, Opt_noacl, Opt_xip, Opt_ignore, Opt_err, Opt_quota,
+	Opt_usrquota, Opt_grpquota
 };
 
 static match_table_t tokens = {
@@ -288,10 +306,10 @@
 	{Opt_acl, "acl"},
 	{Opt_noacl, "noacl"},
 	{Opt_xip, "xip"},
-	{Opt_ignore, "grpquota"},
+	{Opt_grpquota, "grpquota"},
 	{Opt_ignore, "noquota"},
-	{Opt_ignore, "quota"},
-	{Opt_ignore, "usrquota"},
+	{Opt_quota, "quota"},
+	{Opt_usrquota, "usrquota"},
 	{Opt_err, NULL}
 };
 
@@ -406,6 +424,30 @@
 			printk("EXT2 xip option not supported\n");
 #endif
 			break;
+
+#if defined(CONFIG_QUOTA)
+		case Opt_usrquota:
+			set_opt(sbi->s_mount_opt, USRQUOTA);
+			break;
+
+		case Opt_grpquota:
+			set_opt(sbi->s_mount_opt, GRPQUOTA);
+			break;
+
+		case Opt_quota:
+			set_opt(sbi->s_mount_opt, GRPQUOTA);
+			set_opt(sbi->s_mount_opt, USRQUOTA);
+			break;
+#else
+		case Opt_quota:
+		case Opt_usrquota:
+		case Opt_grpquota:
+			printk(KERN_ERR
+				"EXT2-fs: quota operations not supported.\n");
+
+			break;
+#endif
+
 		case Opt_ignore:
 			break;
 		default:
diff -Naur linux-2.6.13-rc3-git9-orig/fs/jfs/jfs_filsys.h linux-2.6.13-rc3-git9/fs/jfs/jfs_filsys.h
--- linux-2.6.13-rc3-git9-orig/fs/jfs/jfs_filsys.h	2005-07-15 14:18:57.000000000 -0700
+++ linux-2.6.13-rc3-git9/fs/jfs/jfs_filsys.h	2005-07-28 15:36:00.000000000 -0700
@@ -37,6 +37,9 @@
 #define JFS_ERR_CONTINUE   0x00000004   /* continue */
 #define JFS_ERR_PANIC      0x00000008   /* panic */
 
+#define	JFS_USRQUOTA	0x00000010
+#define	JFS_GRPQUOTA	0x00000020
+
 /* platform option (conditional compilation) */
 #define JFS_AIX		0x80000000	/* AIX support */
 /*	POSIX name/directory  support */
diff -Naur linux-2.6.13-rc3-git9-orig/fs/jfs/super.c linux-2.6.13-rc3-git9/fs/jfs/super.c
--- linux-2.6.13-rc3-git9-orig/fs/jfs/super.c	2005-07-28 15:12:51.000000000 -0700
+++ linux-2.6.13-rc3-git9/fs/jfs/super.c	2005-07-28 15:36:00.000000000 -0700
@@ -23,9 +23,11 @@
 #include <linux/parser.h>
 #include <linux/completion.h>
 #include <linux/vfs.h>
+#include <linux/mount.h>
 #include <linux/moduleparam.h>
 #include <linux/posix_acl.h>
 #include <asm/uaccess.h>
+#include <linux/seq_file.h>
 
 #include "jfs_incore.h"
 #include "jfs_filsys.h"
@@ -190,7 +192,8 @@
 
 enum {
 	Opt_integrity, Opt_nointegrity, Opt_iocharset, Opt_resize,
-	Opt_resize_nosize, Opt_errors, Opt_ignore, Opt_err,
+	Opt_resize_nosize, Opt_errors, Opt_ignore, Opt_err, Opt_quota,
+	Opt_usrquota, Opt_grpquota
 };
 
 static match_table_t tokens = {
@@ -291,6 +294,27 @@
 			}
 			break;
 		}
+
+#if defined(CONFIG_QUOTA)
+		case Opt_usrquota:
+			*flag |= JFS_USRQUOTA;
+			break;
+		case Opt_grpquota:
+			*flag |= JFS_GRPQUOTA;
+			break;
+		case Opt_quota:
+			*flag |= JFS_USRQUOTA;
+			*flag |= JFS_GRPQUOTA;
+			break;
+#else
+		case Opt_usrquota:
+		case Opt_grpquota:
+		case Opt_quota:
+			printk(KERN_ERR
+			       "JFS: quota operations not supported\n");
+			break;
+#endif
+
 		default:
 			printk("jfs: Unrecognized mount option \"%s\" "
 					" or missing value\n", p);
@@ -537,6 +561,21 @@
 	return 0;
 }
 
+#if defined(CONFIG_QUOTA)
+static int jfs_show_options(struct seq_file *seq, struct vfsmount *vfs)
+{
+	struct jfs_sb_info *sbi = JFS_SBI(vfs->mnt_sb);
+
+	if (sbi->flag & JFS_USRQUOTA)
+		seq_puts(seq, ",usrquota");
+
+	if (sbi->flag & JFS_GRPQUOTA)
+		seq_puts(seq, ",grpquota");
+
+	return 0;
+}
+#endif
+
 static struct super_operations jfs_super_operations = {
 	.alloc_inode	= jfs_alloc_inode,
 	.destroy_inode	= jfs_destroy_inode,
@@ -550,6 +589,9 @@
 	.unlockfs       = jfs_unlockfs,
 	.statfs		= jfs_statfs,
 	.remount_fs	= jfs_remount,
+#if defined(CONFIG_QUOTA)
+	.show_options	= jfs_show_options
+#endif
 };
 
 static struct export_operations jfs_export_operations = {
diff -Naur linux-2.6.13-rc3-git9-orig/fs/xfs/xfs_vfsops.c linux-2.6.13-rc3-git9/fs/xfs/xfs_vfsops.c
--- linux-2.6.13-rc3-git9-orig/fs/xfs/xfs_vfsops.c	2005-07-28 15:12:51.000000000 -0700
+++ linux-2.6.13-rc3-git9/fs/xfs/xfs_vfsops.c	2005-07-28 15:36:00.000000000 -0700
@@ -1886,6 +1886,8 @@
 		{ XFS_MOUNT_OSYNCISOSYNC,	"," MNTOPT_OSYNCISOSYNC },
 		{ XFS_MOUNT_NOLOGFLUSH,		"," MNTOPT_NOLOGFLUSH },
 		{ XFS_MOUNT_IDELETE,		"," MNTOPT_NOIKEEP },
+		{ XFS_UQUOTA_ACTIVE,		"," "usrquota" },
+		{ XFS_GQUOTA_ACTIVE,		"," "grpquota" },
 		{ 0, NULL }
 	};
 	struct proc_xfs_info	*xfs_infop;

--------------040700050605000408080002--
