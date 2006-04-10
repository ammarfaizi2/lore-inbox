Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751207AbWDJVVj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbWDJVVj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 17:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbWDJVVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 17:21:39 -0400
Received: from a1819.adsl.pool.eol.hu ([81.0.120.41]:63209 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1751201AbWDJVVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 17:21:38 -0400
To: akpm@osdl.org
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       viro@ftp.linux.org.uk
Subject: [PATCH 2/2] vfs: fix up signature of flush operations
Message-Id: <E1FT3p2-0006gT-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 10 Apr 2006 23:21:20 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add lock owner ID argument to flush operations.  This makes the
warning go away, but otherwise has no effect.

Compile tested (mostly).

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Index: linux/arch/ia64/kernel/perfmon.c
===================================================================
--- linux.orig/arch/ia64/kernel/perfmon.c	2006-04-09 11:17:01.000000000 +0200
+++ linux/arch/ia64/kernel/perfmon.c	2006-04-09 11:19:01.000000000 +0200
@@ -532,7 +532,6 @@ static ctl_table pfm_sysctl_root[] = {
 static struct ctl_table_header *pfm_sysctl_header;
 
 static int pfm_context_unload(pfm_context_t *ctx, void *arg, int count, struct pt_regs *regs);
-static int pfm_flush(struct file *filp);
 
 #define pfm_get_cpu_var(v)		__ia64_per_cpu_var(v)
 #define pfm_get_cpu_data(a,b)		per_cpu(a, b)
@@ -1773,7 +1772,7 @@ pfm_syswide_cleanup_other_cpu(pfm_contex
  * When caller is self-monitoring, the context is unloaded.
  */
 static int
-pfm_flush(struct file *filp)
+pfm_flush(struct file *filp, fl_owner_t id)
 {
 	pfm_context_t *ctx;
 	struct task_struct *task;
Index: linux/drivers/input/evdev.c
===================================================================
--- linux.orig/drivers/input/evdev.c	2006-04-09 11:17:01.000000000 +0200
+++ linux/drivers/input/evdev.c	2006-04-09 11:19:01.000000000 +0200
@@ -82,7 +82,7 @@ static int evdev_fasync(int fd, struct f
 	return retval < 0 ? retval : 0;
 }
 
-static int evdev_flush(struct file * file)
+static int evdev_flush(struct file * file, fl_owner_t id)
 {
 	struct evdev_list *list = file->private_data;
 	if (!list->evdev->exist) return -ENODEV;
Index: linux/drivers/scsi/osst.c
===================================================================
--- linux.orig/drivers/scsi/osst.c	2006-04-09 11:17:01.000000000 +0200
+++ linux/drivers/scsi/osst.c	2006-04-09 11:19:01.000000000 +0200
@@ -4724,7 +4724,7 @@ err_out:
 
 
 /* Flush the tape buffer before close */
-static int os_scsi_tape_flush(struct file * filp)
+static int os_scsi_tape_flush(struct file * filp, fl_owner_t id)
 {
 	int		      result = 0, result2;
 	struct osst_tape    * STp    = filp->private_data;
Index: linux/drivers/scsi/st.c
===================================================================
--- linux.orig/drivers/scsi/st.c	2006-04-09 11:17:01.000000000 +0200
+++ linux/drivers/scsi/st.c	2006-04-09 11:19:01.000000000 +0200
@@ -1193,7 +1193,7 @@ static int st_open(struct inode *inode, 
 
 
 /* Flush the tape buffer before close */
-static int st_flush(struct file *filp)
+static int st_flush(struct file *filp, fl_owner_t id)
 {
 	int result = 0, result2;
 	unsigned char cmd[MAX_COMMAND_SIZE];
Index: linux/fs/cifs/cifsfs.h
===================================================================
--- linux.orig/fs/cifs/cifsfs.h	2006-04-09 11:17:01.000000000 +0200
+++ linux/fs/cifs/cifsfs.h	2006-04-09 11:19:01.000000000 +0200
@@ -74,7 +74,7 @@ extern ssize_t cifs_user_write(struct fi
 			 size_t write_size, loff_t * poffset);
 extern int cifs_lock(struct file *, int, struct file_lock *);
 extern int cifs_fsync(struct file *, struct dentry *, int);
-extern int cifs_flush(struct file *);
+extern int cifs_flush(struct file *, fl_owner_t id);
 extern int cifs_file_mmap(struct file * , struct vm_area_struct *);
 extern const struct file_operations cifs_dir_ops;
 extern int cifs_dir_open(struct inode *inode, struct file *file);
Index: linux/fs/cifs/file.c
===================================================================
--- linux.orig/fs/cifs/file.c	2006-04-09 11:17:01.000000000 +0200
+++ linux/fs/cifs/file.c	2006-04-09 11:19:01.000000000 +0200
@@ -1409,7 +1409,7 @@ int cifs_fsync(struct file *file, struct
  * As file closes, flush all cached write data for this inode checking
  * for write behind errors.
  */
-int cifs_flush(struct file *file)
+int cifs_flush(struct file *file, fl_owner_t id)
 {
 	struct inode * inode = file->f_dentry->d_inode;
 	int rc = 0;
Index: linux/fs/coda/file.c
===================================================================
--- linux.orig/fs/coda/file.c	2006-04-09 11:17:01.000000000 +0200
+++ linux/fs/coda/file.c	2006-04-09 11:19:01.000000000 +0200
@@ -164,7 +164,7 @@ int coda_open(struct inode *coda_inode, 
 	return 0;
 }
 
-int coda_flush(struct file *coda_file)
+int coda_flush(struct file *coda_file, fl_owner_t id)
 {
 	unsigned short flags = coda_file->f_flags & ~O_EXCL;
 	unsigned short coda_flags = coda_flags_to_cflags(flags);
Index: linux/include/linux/coda_linux.h
===================================================================
--- linux.orig/include/linux/coda_linux.h	2006-04-09 11:17:01.000000000 +0200
+++ linux/include/linux/coda_linux.h	2006-04-09 11:19:01.000000000 +0200
@@ -36,7 +36,7 @@ extern const struct file_operations coda
 
 /* operations shared over more than one file */
 int coda_open(struct inode *i, struct file *f);
-int coda_flush(struct file *f);
+int coda_flush(struct file *f, fl_owner_t id);
 int coda_release(struct inode *i, struct file *f);
 int coda_permission(struct inode *inode, int mask, struct nameidata *nd);
 int coda_revalidate_inode(struct dentry *);
Index: linux/fs/fuse/file.c
===================================================================
--- linux.orig/fs/fuse/file.c	2006-04-09 11:17:01.000000000 +0200
+++ linux/fs/fuse/file.c	2006-04-09 11:19:01.000000000 +0200
@@ -169,7 +169,7 @@ static int fuse_release(struct inode *in
 	return fuse_release_common(inode, file, 0);
 }
 
-static int fuse_flush(struct file *file)
+static int fuse_flush(struct file *file, fl_owner_t id)
 {
 	struct inode *inode = file->f_dentry->d_inode;
 	struct fuse_conn *fc = get_fuse_conn(inode);
Index: linux/fs/nfs/file.c
===================================================================
--- linux.orig/fs/nfs/file.c	2006-04-09 11:17:01.000000000 +0200
+++ linux/fs/nfs/file.c	2006-04-09 11:19:01.000000000 +0200
@@ -43,7 +43,7 @@ static int  nfs_file_mmap(struct file *,
 static ssize_t nfs_file_sendfile(struct file *, loff_t *, size_t, read_actor_t, void *);
 static ssize_t nfs_file_read(struct kiocb *, char __user *, size_t, loff_t);
 static ssize_t nfs_file_write(struct kiocb *, const char __user *, size_t, loff_t);
-static int  nfs_file_flush(struct file *);
+static int  nfs_file_flush(struct file *, fl_owner_t id);
 static int  nfs_fsync(struct file *, struct dentry *dentry, int datasync);
 static int nfs_check_flags(int flags);
 static int nfs_lock(struct file *filp, int cmd, struct file_lock *fl);
@@ -188,7 +188,7 @@ static loff_t nfs_file_llseek(struct fil
  *
  */
 static int
-nfs_file_flush(struct file *file)
+nfs_file_flush(struct file *file, fl_owner_t id)
 {
 	struct nfs_open_context *ctx = (struct nfs_open_context *)file->private_data;
 	struct inode	*inode = file->f_dentry->d_inode;
Index: linux/ipc/mqueue.c
===================================================================
--- linux.orig/ipc/mqueue.c	2006-04-09 11:17:01.000000000 +0200
+++ linux/ipc/mqueue.c	2006-04-09 11:19:01.000000000 +0200
@@ -356,7 +356,7 @@ static ssize_t mqueue_read_file(struct f
 	return count;
 }
 
-static int mqueue_flush_file(struct file *filp)
+static int mqueue_flush_file(struct file *filp, fl_owner_t id)
 {
 	struct mqueue_inode_info *info = MQUEUE_I(filp->f_dentry->d_inode);
 
