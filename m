Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310513AbSCCKHb>; Sun, 3 Mar 2002 05:07:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310510AbSCCKHZ>; Sun, 3 Mar 2002 05:07:25 -0500
Received: from relay01.valueweb.net ([216.219.253.235]:43270 "EHLO
	relay01.valueweb.net") by vger.kernel.org with ESMTP
	id <S293536AbSCCJ5B>; Sun, 3 Mar 2002 04:57:01 -0500
Content-Type: text/plain; charset=US-ASCII
From: Craig Christophel <merlin@transgeek.com>
To: linux-kernel@vger.kernel.org
Subject: Quota patches for 2.5 - 13
Date: Sun, 3 Mar 2002 04:57:25 -0500
X-Mailer: KMail [version 1.3.1]
Cc: jack@suse.cz, Alexander Viro <viro@math.psu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020303095640Z293043-31625+9@thor.valueweb.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the last of 13 patches.

	Ok.  This is the last patch.  
	
	This one makes everything compile under 2.5.6-pre2 and changes the 
DQUOT_SYNC_DEV to DQUOT_SYNC_ALL as it was only used in sys_sync and there is 
used to sync everything.  Also some human (typographical) errors are fixed 
and all references to dquot->dq_dev are removed and replaced with 
dquot->dq_sb->s_dev for now where possible and all assignations are removed.

	This concludes my interruption to your normal daily news.  



	Craig.



diff -urN -X txt/diff-exclude linux-2.5-linus/fs/buffer.c 
linux-2.5/fs/buffer.c
--- linux-2.5-linus/fs/buffer.c	Sun Mar  3 03:44:02 2002
+++ linux-2.5/fs/buffer.c	Sun Mar  3 03:49:54 2002
@@ -389,7 +389,7 @@
 
 	lock_kernel();
 	sync_inodes();
-	DQUOT_SYNC_DEV(val_to_kdev(0));
+	DQUOT_SYNC_ALL();
 	sync_supers();
 	unlock_kernel();
 
diff -urN -X txt/diff-exclude linux-2.5-linus/fs/dquot.c linux-2.5/fs/dquot.c
--- linux-2.5-linus/fs/dquot.c	Sun Mar  3 03:44:02 2002
+++ linux-2.5/fs/dquot.c	Sun Mar  3 04:14:34 2002
@@ -163,12 +163,12 @@
 	dquot->dq_count--;
 }
 
-static inline void get_dquot_dup_ref(struct *dquot)
+static inline void get_dquot_dup_ref(struct dquot *dquot)
 {
 	dquot->dq_dup_ref++;
 }
 
-static inline void put_dquot_dup_ref(struct *dquot)
+static inline void put_dquot_dup_ref(struct dquot *dquot)
 {
 	dquot->dq_dup_ref--;
 }
@@ -312,7 +312,7 @@
 	current->state = TASK_RUNNING;
 }
 
-stati int read_dqblk(struct dquot *dquot)
+static int read_dqblk(struct dquot *dquot)
 {
 	int ret;
 	struct quota_info *dqopt = sb_dqopt(dquot->dq_sb);
@@ -436,25 +436,16 @@
 	return NULL;
 }
 
-void sync_dquots_dev(kdev_t dev, int type)
+void sync_dquots_all(void)
 {
 	struct super_block *sb;
+	int type = -1;
 
-	if (dev) {
-		if ((sb = get_super(dev))) {
-			lock_kernel();
-			sb->s_qcop->quota_sync(sb, type);
-			unlock_kernel();
-			drop_super(sb);
-		}
-	}
-	else {
-		while ((sb = get_super_to_sync(type))) {
-			lock_kernel();
-			sb->s_qcop->quota_sync(sb, type);
-			unlock_kernel();
-			drop_super(sb);
-		}
+	while ((sb = get_super_to_sync(type))) {
+		lock_kernel();
+		sb->s_qcop->quota_sync(sb, type);
+		unlock_kernel();
+		drop_super(sb);
 	}
 }
 
@@ -570,7 +561,6 @@
 	INIT_LIST_HEAD(&dquot->dq_inuse);
 	INIT_LIST_HEAD(&dquot->dq_hash);
 	dquot->dq_sb = sb;
-	dquot->dq_dev = sb->s_dev;
 	dquot->dq_type = type;
 	dquot->dq_count = 1;
 	/* all dquots go on the inuse_list */
diff -urN -X txt/diff-exclude linux-2.5-linus/fs/quota_v1.c 
linux-2.5/fs/quota_v1.c
--- linux-2.5-linus/fs/quota_v1.c	Sun Mar  3 03:24:09 2002
+++ linux-2.5/fs/quota_v1.c	Sun Mar  3 04:15:56 2002
@@ -91,7 +91,7 @@
 					sizeof(struct v1_disk_dqblk), &offset);
 	if (ret != sizeof(struct v1_disk_dqblk)) {
 		printk(KERN_WARNING "VFS: dquota write failed on dev %s\n",
-			kdevname(dquot->dq_dev));
+			kdevname(dquot->dq_sb->s_dev));
 		if (ret >= 0)
 			ret = -EIO;
 		goto out;
diff -urN -X txt/diff-exclude linux-2.5-linus/fs/quota_v2.c 
linux-2.5/fs/quota_v2.c
--- linux-2.5-linus/fs/quota_v2.c	Sun Mar  3 03:30:20 2002
+++ linux-2.5/fs/quota_v2.c	Sun Mar  3 04:16:41 2002
@@ -424,7 +424,7 @@
 	ret = filp->f_op->write(filp, (char *)&ddquot, sizeof(struct 
v2_disk_dqblk), &offset);
 	set_fs(fs);
 	if (ret != sizeof(struct v2_disk_dqblk)) {
-		printk(KERN_WARNING "VFS: dquota write failed on dev %s\n", 
kdevname(dquot->dq_dev));
+		printk(KERN_WARNING "VFS: dquota write failed on dev %s\n", 
kdevname(dquot->dq_sb->s_dev));
 		if (ret >= 0)
 			ret = -ENOSPC;
 	}
diff -urN -X txt/diff-exclude linux-2.5-linus/fs/super.c linux-2.5/fs/super.c
--- linux-2.5-linus/fs/super.c	Sun Mar  3 03:17:15 2002
+++ linux-2.5/fs/super.c	Sun Mar  3 04:09:34 2002
@@ -27,6 +27,7 @@
 #include <linux/devfs_fs_kernel.h>
 #include <linux/major.h>
 #include <linux/acct.h>
+#include <linux/quotaops.h>
 
 #include <asm/uaccess.h>
 
diff -urN -X txt/diff-exclude linux-2.5-linus/include/linux/quotaops.h 
linux-2.5/include/linux/quotaops.h
--- linux-2.5-linus/include/linux/quotaops.h	Sun Mar  3 03:44:02 2002
+++ linux-2.5/include/linux/quotaops.h	Sun Mar  3 04:12:39 2002
@@ -40,7 +40,7 @@
  * declaration of quota_function calls in kernel.
  */
 /* Al this will be changed as soon as I release the first patch */
-extern void sync_dquots_dev(kdev_t dev, int type);
+extern void sync_dquots_all(void);
 extern void sync_dquots_sb(struct super_block *sb, int type);
 
 extern void dquot_initialize(struct inode *inode, int type);
@@ -184,7 +184,7 @@
 	return 0;
 }
 
-#define DQUOT_SYNC_DEV(dev)	sync_dquots_dev(dev, -1)
+#define DQUOT_SYNC_ALL()	sync_dquots_all()
 #define DQUOT_SYNC_SB(sb)	sync_dquots_sb(sb, -1)
 #define DQUOT_OFF(sb)		((sb)->s_qcop->quota_off(sb, -1))
 
@@ -199,7 +199,7 @@
 #define DQUOT_DROP(inode)			do { } while(0)
 #define DQUOT_ALLOC_INODE(inode)		(0)
 #define DQUOT_FREE_INODE(inode)			do { } while(0)
-#define DQUOT_SYNC_DEV(dev)			do { } while(0)
+#define DQUOT_SYNC_ALL(dev)			do { } while(0)
 #define DQUOT_SYNC_SB(sb)			do { } while(0)
 #define DQUOT_OFF(sb)				do { } while(0)
 #define DQUOT_TRANSFER(inode, iattr)		(0)
