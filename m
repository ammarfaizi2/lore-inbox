Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266028AbUGZP0t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266028AbUGZP0t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 11:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265981AbUGZPZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 11:25:51 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:16306 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S265490AbUGZPE2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 11:04:28 -0400
Date: Mon, 26 Jul 2004 20:33:14 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: akpm@osdl.org
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       viro@parcelfarce.linux.theplanet.co.uk, dipankar@in.ibm.com
Subject: [patch] Use kref for struct file.f_count refcounter
Message-ID: <20040726150312.GJ1231@obelix.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,
This patch makes use of the kref api for the 
struct file.f_count refcounter.  This depends
on the new kref apis kref_read and kref_put_last
added by means of my earlier patch today.

Pls include.

Thanks,
Kiran

Signed-off-by: Ravikiran Thirumalai <kiran@in.ibm.com>

 drivers/net/ppp_generic.c |    4 ++--
 fs/affs/file.c            |    4 ++--
 fs/aio.c                  |    4 ++--
 fs/file_table.c           |   29 ++++++++++++++++++++---------
 fs/hfs/inode.c            |    4 ++--
 fs/hfsplus/inode.c        |    4 ++--
 include/linux/fs.h        |    7 ++++---
 security/selinux/hooks.c  |    2 +-
 8 files changed, 35 insertions(+), 23 deletions(-)


diff -ruN -X dontdiff2 linux-2.6.7/drivers/net/ppp_generic.c files_struct-kref-2.6.7/drivers/net/ppp_generic.c
--- linux-2.6.7/drivers/net/ppp_generic.c	2004-06-16 10:50:03.000000000 +0530
+++ files_struct-kref-2.6.7/drivers/net/ppp_generic.c	2004-07-26 19:05:53.000000000 +0530
@@ -525,12 +525,12 @@
 			if (file == ppp->owner)
 				ppp_shutdown_interface(ppp);
 		}
-		if (atomic_read(&file->f_count) <= 2) {
+		if (file_count(file) <= 2) {
 			ppp_release(inode, file);
 			err = 0;
 		} else
 			printk(KERN_DEBUG "PPPIOCDETACH file->f_count=%d\n",
-			       atomic_read(&file->f_count));
+			       file_count(file));
 		return err;
 	}
 
diff -ruN -X dontdiff2 linux-2.6.7/fs/affs/file.c files_struct-kref-2.6.7/fs/affs/file.c
--- linux-2.6.7/fs/affs/file.c	2004-06-16 10:49:22.000000000 +0530
+++ files_struct-kref-2.6.7/fs/affs/file.c	2004-07-26 19:05:53.000000000 +0530
@@ -62,7 +62,7 @@
 static int
 affs_file_open(struct inode *inode, struct file *filp)
 {
-	if (atomic_read(&filp->f_count) != 1)
+	if (file_count(filp) != 1)
 		return 0;
 	pr_debug("AFFS: open(%d)\n", AFFS_I(inode)->i_opencnt);
 	AFFS_I(inode)->i_opencnt++;
@@ -72,7 +72,7 @@
 static int
 affs_file_release(struct inode *inode, struct file *filp)
 {
-	if (atomic_read(&filp->f_count) != 0)
+	if (file_count(filp) != 0)
 		return 0;
 	pr_debug("AFFS: release(%d)\n", AFFS_I(inode)->i_opencnt);
 	AFFS_I(inode)->i_opencnt--;
diff -ruN -X dontdiff2 linux-2.6.7/fs/aio.c files_struct-kref-2.6.7/fs/aio.c
--- linux-2.6.7/fs/aio.c	2004-06-16 10:49:22.000000000 +0530
+++ files_struct-kref-2.6.7/fs/aio.c	2004-07-26 19:05:53.000000000 +0530
@@ -475,7 +475,7 @@
 static int __aio_put_req(struct kioctx *ctx, struct kiocb *req)
 {
 	dprintk(KERN_DEBUG "aio_put(%p): f_count=%d\n",
-		req, atomic_read(&req->ki_filp->f_count));
+		req, file_count(req->ki_filp));
 
 	req->ki_users --;
 	if (unlikely(req->ki_users < 0))
@@ -489,7 +489,7 @@
 	/* Must be done under the lock to serialise against cancellation.
 	 * Call this aio_fput as it duplicates fput via the fput_work.
 	 */
-	if (unlikely(atomic_dec_and_test(&req->ki_filp->f_count))) {
+	if (unlikely(kref_put_last(&req->ki_filp->f_count))) {
 		get_ioctx(ctx);
 		spin_lock(&fput_lock);
 		list_add(&req->ki_list, &fput_head);
diff -ruN -X dontdiff2 linux-2.6.7/fs/file_table.c files_struct-kref-2.6.7/fs/file_table.c
--- linux-2.6.7/fs/file_table.c	2004-06-16 10:48:56.000000000 +0530
+++ files_struct-kref-2.6.7/fs/file_table.c	2004-07-26 19:08:55.000000000 +0530
@@ -81,7 +81,7 @@
 				goto fail;
 			}
 			eventpoll_init_file(f);
-			atomic_set(&f->f_count, 1);
+			kref_init(&f->f_count);
 			f->f_uid = current->fsuid;
 			f->f_gid = current->fsgid;
 			f->f_owner.lock = RW_LOCK_UNLOCKED;
@@ -118,7 +118,7 @@
 	eventpoll_init_file(filp);
 	filp->f_flags  = flags;
 	filp->f_mode   = (flags+1) & O_ACCMODE;
-	atomic_set(&filp->f_count, 1);
+	kref_init(&filp->f_count);
 	filp->f_dentry = dentry;
 	filp->f_mapping = dentry->d_inode->i_mapping;
 	filp->f_uid    = current->fsuid;
@@ -152,10 +152,17 @@
 
 EXPORT_SYMBOL(close_private_file);
 
+#define kref_to_file(kref) container_of(kref, struct file, f_count)
+
+static void __fput_kref(struct kref *kref)
+{
+	struct file *file = kref_to_file(kref);
+	__fput(file);
+}
+
 void fastcall fput(struct file *file)
 {
-	if (atomic_dec_and_test(&file->f_count))
-		__fput(file);
+	kref_put(&file->f_count, __fput_kref);
 }
 
 EXPORT_SYMBOL(fput);
@@ -235,13 +242,17 @@
 }
 
 
+static void put_filp_kref(struct kref *kref)
+{
+	struct file *file = kref_to_file(kref);
+	security_file_free(file);
+	file_kill(file);
+	file_free(file);
+}
+	
 void put_filp(struct file *file)
 {
-	if (atomic_dec_and_test(&file->f_count)) {
-		security_file_free(file);
-		file_kill(file);
-		file_free(file);
-	}
+	kref_put(&file->f_count, put_filp_kref);
 }
 
 EXPORT_SYMBOL(put_filp);
diff -ruN -X dontdiff2 linux-2.6.7/fs/hfs/inode.c files_struct-kref-2.6.7/fs/hfs/inode.c
--- linux-2.6.7/fs/hfs/inode.c	2004-06-16 10:50:26.000000000 +0530
+++ files_struct-kref-2.6.7/fs/hfs/inode.c	2004-07-26 19:05:53.000000000 +0530
@@ -523,7 +523,7 @@
 {
 	if (HFS_IS_RSRC(inode))
 		inode = HFS_I(inode)->rsrc_inode;
-	if (atomic_read(&file->f_count) != 1)
+	if (file_count(file) != 1)
 		return 0;
 	atomic_inc(&HFS_I(inode)->opencnt);
 	return 0;
@@ -535,7 +535,7 @@
 
 	if (HFS_IS_RSRC(inode))
 		inode = HFS_I(inode)->rsrc_inode;
-	if (atomic_read(&file->f_count) != 0)
+	if (file_count(file) != 0)
 		return 0;
 	if (atomic_dec_and_test(&HFS_I(inode)->opencnt)) {
 		down(&inode->i_sem);
diff -ruN -X dontdiff2 linux-2.6.7/fs/hfsplus/inode.c files_struct-kref-2.6.7/fs/hfsplus/inode.c
--- linux-2.6.7/fs/hfsplus/inode.c	2004-06-16 10:49:02.000000000 +0530
+++ files_struct-kref-2.6.7/fs/hfsplus/inode.c	2004-07-26 19:05:53.000000000 +0530
@@ -268,7 +268,7 @@
 {
 	if (HFSPLUS_IS_RSRC(inode))
 		inode = HFSPLUS_I(inode).rsrc_inode;
-	if (atomic_read(&file->f_count) != 1)
+	if (file_count(file) != 1)
 		return 0;
 	atomic_inc(&HFSPLUS_I(inode).opencnt);
 	return 0;
@@ -280,7 +280,7 @@
 
 	if (HFSPLUS_IS_RSRC(inode))
 		inode = HFSPLUS_I(inode).rsrc_inode;
-	if (atomic_read(&file->f_count) != 0)
+	if (file_count(file) != 0)
 		return 0;
 	if (atomic_dec_and_test(&HFSPLUS_I(inode).opencnt)) {
 		down(&inode->i_sem);
diff -ruN -X dontdiff2 linux-2.6.7/include/linux/fs.h files_struct-kref-2.6.7/include/linux/fs.h
--- linux-2.6.7/include/linux/fs.h	2004-06-16 10:49:02.000000000 +0530
+++ files_struct-kref-2.6.7/include/linux/fs.h	2004-07-26 19:05:53.000000000 +0530
@@ -18,6 +18,7 @@
 #include <linux/cache.h>
 #include <linux/prio_tree.h>
 #include <linux/kobject.h>
+#include <linux/kref.h>
 #include <asm/atomic.h>
 
 struct iovec;
@@ -558,7 +559,7 @@
 	struct dentry		*f_dentry;
 	struct vfsmount         *f_vfsmnt;
 	struct file_operations	*f_op;
-	atomic_t		f_count;
+	struct kref		f_count;
 	unsigned int 		f_flags;
 	mode_t			f_mode;
 	int			f_error;
@@ -584,8 +585,8 @@
 #define file_list_lock() spin_lock(&files_lock);
 #define file_list_unlock() spin_unlock(&files_lock);
 
-#define get_file(x)	atomic_inc(&(x)->f_count)
-#define file_count(x)	atomic_read(&(x)->f_count)
+#define get_file(x)	kref_get(&(x)->f_count)
+#define file_count(x)	kref_read(&(x)->f_count)
 
 /* Initialize and open a private file and allocate its security structure. */
 extern int open_private_file(struct file *, struct dentry *, int);
diff -ruN -X dontdiff2 linux-2.6.7/security/selinux/hooks.c files_struct-kref-2.6.7/security/selinux/hooks.c
--- linux-2.6.7/security/selinux/hooks.c	2004-06-16 10:50:04.000000000 +0530
+++ files_struct-kref-2.6.7/security/selinux/hooks.c	2004-07-26 19:05:53.000000000 +0530
@@ -1811,7 +1811,7 @@
 						continue;
 					}
 					if (devnull) {
-						atomic_inc(&devnull->f_count);
+						kref_get(&devnull->f_count);
 					} else {
 						devnull = open_devnull();
 						if (!devnull) {
