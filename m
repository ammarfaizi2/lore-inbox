Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266080AbUA1Pu5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 10:50:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266075AbUA1PoN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 10:44:13 -0500
Received: from wombat.indigo.net.au ([202.0.185.19]:12555 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S266054AbUA1Ply (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 10:41:54 -0500
Date: Wed, 28 Jan 2004 23:40:59 +0800 (WST)
From: raven@themaw.net
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Andrew Morton <akpm@osdl.org>, Maneesh Soni <maneesh@in.ibm.com>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Jeremy Fitzhardinge <jeremy@goop.org>,
       Mike Waychison <Michael.Waychison@Sun.COM>
Subject: [PATCH 7/8] autofs4-2.6 - to support autofs 4.1.x
Message-ID: <Pine.LNX.4.58.0401282330320.17471@raven.themaw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=0.3, required 8,
	NO_REAL_NAME, PATCH_UNIFIED_DIFF, USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Patch:

7-autofs4-2.6.0-test9-extra.patch

Present to support coming development plans.

diff -Nur linux-2.6.0-0.test9.misc/fs/autofs4/autofs_i.h linux-2.6.0-0.test9.extra/fs/autofs4/autofs_i.h
--- linux-2.6.0-0.test9.misc/fs/autofs4/autofs_i.h	2003-11-29 21:51:06.000000000 +0800
+++ linux-2.6.0-0.test9.extra/fs/autofs4/autofs_i.h	2003-12-01 21:03:29.447439696 +0800
@@ -98,6 +98,8 @@
 	int version;
 	int sub_version;
 	unsigned long exp_timeout;
+	int reghost_enabled;
+	int needs_reghost;
 	struct super_block *sb;
 	struct autofs_wait_queue *queues; /* Wait queue pointer */
 };
diff -Nur linux-2.6.0-0.test9.misc/fs/autofs4/root.c linux-2.6.0-0.test9.extra/fs/autofs4/root.c
--- linux-2.6.0-0.test9.misc/fs/autofs4/root.c	2003-11-30 10:17:28.000000000 +0800
+++ linux-2.6.0-0.test9.extra/fs/autofs4/root.c	2003-12-01 21:16:25.453468848 +0800
@@ -28,13 +28,15 @@
 static int autofs4_dir_open(struct inode *inode, struct file *file);
 static int autofs4_dir_close(struct inode *inode, struct file *file);
 static int autofs4_dir_readdir(struct file * filp, void * dirent, filldir_t filldir);
+static int autofs4_root_readdir(struct file * filp, void * dirent, filldir_t filldir);
 static struct dentry *autofs4_root_lookup(struct inode *,struct dentry *, struct nameidata *);
+static int autofs4_dcache_readdir(struct file *, void *, filldir_t);
 
 struct file_operations autofs4_root_operations = {
 	.open		= dcache_dir_open,
 	.release	= dcache_dir_close,
 	.read		= generic_read_dir,
-	.readdir	= dcache_readdir,
+	.readdir	= autofs4_root_readdir,
 	.ioctl		= autofs4_root_ioctl,
 };
 
@@ -77,6 +79,27 @@
 	}
 }
 
+static int autofs4_root_readdir(struct file *file, void *dirent, filldir_t filldir)
+{
+	struct autofs_sb_info *sbi = autofs4_sbi(file->f_dentry->d_sb);
+	int oz_mode = autofs4_oz_mode(sbi);
+
+	DPRINTK(("autofs4_root_readdir called, filp->f_pos = %lld\n", file->f_pos));
+
+	/*
+	 * Don't set reghost flag if:
+	 * 1) f_pos is larger than zero -- we've already been here.
+	 * 2) we haven't even enabled reghosting in the 1st place.
+	 * 3) this is the daemon doing a readdir
+	 */
+	if ( oz_mode && file->f_pos == 0 && sbi->reghost_enabled )
+		sbi->needs_reghost = 1;
+
+	DPRINTK(("autofs4_root_readdir: needs_reghost = %d\n", sbi->needs_reghost));
+
+	return autofs4_dcache_readdir(file, dirent, filldir);
+}
+
 static void autofs4_check_pwd(struct file *file, struct file *fp)
 {
 	struct dentry *pwd = file->f_dentry;
@@ -796,6 +819,61 @@
 }
 
 /*
+ * Tells the daemon whether we need to reghost or not. Also, clears
+ * the reghost_needed flag.
+ */
+static inline int autofs4_ask_reghost(struct autofs_sb_info *sbi, int *p)
+{
+	int status;
+
+	DPRINTK(("autofs_ask_reghost: returning %d\n", sbi->needs_reghost));
+
+	status = put_user(sbi->needs_reghost, p);
+	if ( status )
+		return status;
+
+	sbi->needs_reghost = 0;
+	return 0;
+}
+
+/*
+ * Enable / Disable reghosting ioctl() operation
+ */
+static inline int autofs4_toggle_reghost(struct autofs_sb_info *sbi, int *p)
+{
+	int status;
+	int val;
+
+	status = get_user(val, p);
+
+	DPRINTK(("autofs4_toggle_reghost: reghost = %d\n", val));
+
+	if (status)
+		return status;
+
+	/* turn on/off reghosting, with the val */
+	sbi->reghost_enabled = val;
+	return 0;
+}
+
+/*
+ * Tells the daemon whether we can umaont the autofs mount.
+ */
+static inline int autofs4_ask_umount(struct vfsmount *mnt, int *p)
+{
+	int status = 0;
+
+	if (may_umount(mnt) == 0)
+		status = 1;
+
+	DPRINTK(("autofs_ask_umount: returning %d\n", status));
+
+	status = put_user(status, p);
+
+	return status;
+}
+
+/*
  * ioctl()'s on the root directory is the chief method for the daemon to
  * generate kernel reactions
  */
@@ -829,6 +907,14 @@
 	case AUTOFS_IOC_SETTIMEOUT:
 		return autofs4_get_set_timeout(sbi,(unsigned long *)arg);
 
+	case AUTOFS_IOC_TOGGLEREGHOST:
+		return autofs4_toggle_reghost(sbi, (int *) arg);
+	case AUTOFS_IOC_ASKREGHOST:
+		return autofs4_ask_reghost(sbi, (int *) arg);
+
+	case AUTOFS_IOC_ASKUMOUNT:
+		return autofs4_ask_umount(filp->f_vfsmnt, (int *) arg);
+
 	/* return a single thing to expire */
 	case AUTOFS_IOC_EXPIRE:
 		return autofs4_expire_run(inode->i_sb,filp->f_vfsmnt,sbi,
diff -Nur linux-2.6.0-0.test9.misc/include/linux/auto_fs4.h linux-2.6.0-0.test9.extra/include/linux/auto_fs4.h
--- linux-2.6.0-0.test9.misc/include/linux/auto_fs4.h	2003-11-29 21:51:06.000000000 +0800
+++ linux-2.6.0-0.test9.extra/include/linux/auto_fs4.h	2003-12-01 21:00:05.434454384 +0800
@@ -47,8 +47,10 @@
 	struct autofs_packet_expire_multi expire_multi;
 };
 
-#define AUTOFS_IOC_EXPIRE_MULTI _IOW(0x93,0x66,int)
-#define AUTOFS_IOC_PROTOSUBVER  _IOR(0x93,0x67,int)
-
+#define AUTOFS_IOC_EXPIRE_MULTI		_IOW(0x93,0x66,int)
+#define AUTOFS_IOC_PROTOSUBVER		_IOR(0x93,0x67,int)
+#define AUTOFS_IOC_ASKREGHOST           _IOR(0x93,0x68,int)
+#define AUTOFS_IOC_TOGGLEREGHOST        _IOR(0x93,0x69,int)
+#define AUTOFS_IOC_ASKUMOUNT            _IOR(0x93,0x70,int)
 
 #endif /* _LINUX_AUTO_FS4_H */
