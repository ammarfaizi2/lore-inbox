Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262604AbTBSXkr>; Wed, 19 Feb 2003 18:40:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262807AbTBSXkA>; Wed, 19 Feb 2003 18:40:00 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:32018 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262604AbTBSXjX>;
	Wed, 19 Feb 2003 18:39:23 -0500
Date: Wed, 19 Feb 2003 15:42:28 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: [PATCH] LSM changes for 2.5.62
Message-ID: <20030219234228.GD18590@kroah.com>
References: <20030219234140.GA18590@kroah.com> <20030219234203.GB18590@kroah.com> <20030219234216.GC18590@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030219234216.GC18590@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.914.34.3, 2003/01/16 14:35:24-08:00, sds@epoch.ncsc.mil

[PATCH] allocate and free security structures for private files

This patch adds a security_file_alloc call to init_private_file and
creates a close_private_file function to encapsulate the release of
private file structures.  These changes ensure that security
structures for private files will be allocated and freed
appropriately.  Per Andi Kleen's comments, the patch also renames
init_private_file to open_private_file to force updating of all
callers, since they will also need to be updated to use
close_private_file to avoid a leak of the security structure.  Per
Christoph Hellwig's comments, the patch also replaces the 'mode'
argument with a 'flags' argument, computing the f_mode from the flags,
and it explicitly tests f_op prior to dereferencing, as in
dentry_open().


diff -Nru a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
--- a/fs/exportfs/expfs.c	Wed Feb 19 15:39:10 2003
+++ b/fs/exportfs/expfs.c	Wed Feb 19 15:39:10 2003
@@ -353,7 +353,7 @@
 	/*
 	 * Open the directory ...
 	 */
-	error = init_private_file(&file, dentry, FMODE_READ);
+	error = open_private_file(&file, dentry, O_RDONLY);
 	if (error)
 		goto out;
 	error = -EINVAL;
@@ -381,8 +381,7 @@
 	}
 
 out_close:
-	if (file.f_op->release)
-		file.f_op->release(dir, &file);
+	close_private_file(&file);
 out:
 	return error;
 }
diff -Nru a/fs/file_table.c b/fs/file_table.c
--- a/fs/file_table.c	Wed Feb 19 15:39:10 2003
+++ b/fs/file_table.c	Wed Feb 19 15:39:10 2003
@@ -93,23 +93,42 @@
 
 /*
  * Clear and initialize a (private) struct file for the given dentry,
- * and call the open function (if any).  The caller must verify that
- * inode->i_fop is not NULL.
+ * allocate the security structure, and call the open function (if any).  
+ * The file should be released using close_private_file.
  */
-int init_private_file(struct file *filp, struct dentry *dentry, int mode)
+int open_private_file(struct file *filp, struct dentry *dentry, int flags)
 {
+	int error;
 	memset(filp, 0, sizeof(*filp));
 	eventpoll_init_file(filp);
-	filp->f_mode   = mode;
+	filp->f_flags  = flags;
+	filp->f_mode   = (flags+1) & O_ACCMODE;
 	atomic_set(&filp->f_count, 1);
 	filp->f_dentry = dentry;
 	filp->f_uid    = current->fsuid;
 	filp->f_gid    = current->fsgid;
 	filp->f_op     = dentry->d_inode->i_fop;
-	if (filp->f_op->open)
-		return filp->f_op->open(dentry->d_inode, filp);
-	else
-		return 0;
+	error = security_file_alloc(filp);
+	if (!error)
+		if (filp->f_op && filp->f_op->open) {
+			error = filp->f_op->open(dentry->d_inode, filp);
+			if (error)
+				security_file_free(filp);
+		}
+	return error;
+}
+
+/*
+ * Release a private file by calling the release function (if any) and
+ * freeing the security structure.
+ */
+void close_private_file(struct file *file)
+{
+	struct inode * inode = file->f_dentry->d_inode;
+
+	if (file->f_op && file->f_op->release)
+		file->f_op->release(inode, file);
+	security_file_free(file);
 }
 
 void fput(struct file * file)
diff -Nru a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
--- a/fs/nfsd/vfs.c	Wed Feb 19 15:39:10 2003
+++ b/fs/nfsd/vfs.c	Wed Feb 19 15:39:10 2003
@@ -426,7 +426,7 @@
 {
 	struct dentry	*dentry;
 	struct inode	*inode;
-	int		flags = O_RDONLY|O_LARGEFILE, mode = FMODE_READ, err;
+	int		flags = O_RDONLY|O_LARGEFILE, err;
 
 	/*
 	 * If we get here, then the client has already done an "open",
@@ -463,14 +463,12 @@
 			goto out_nfserr;
 
 		flags = O_WRONLY|O_LARGEFILE;
-		mode  = FMODE_WRITE;
 
 		DQUOT_INIT(inode);
 	}
 
-	err = init_private_file(filp, dentry, mode);
+	err = open_private_file(filp, dentry, flags);
 	if (!err) {
-		filp->f_flags = flags;
 		filp->f_vfsmnt = fhp->fh_export->ex_mnt;
 	} else if (access & MAY_WRITE)
 		put_write_access(inode);
@@ -491,8 +489,7 @@
 	struct dentry	*dentry = filp->f_dentry;
 	struct inode	*inode = dentry->d_inode;
 
-	if (filp->f_op->release)
-		filp->f_op->release(inode, filp);
+	close_private_file(filp);
 	if (filp->f_mode & FMODE_WRITE)
 		put_write_access(inode);
 }
diff -Nru a/include/linux/fs.h b/include/linux/fs.h
--- a/include/linux/fs.h	Wed Feb 19 15:39:10 2003
+++ b/include/linux/fs.h	Wed Feb 19 15:39:10 2003
@@ -489,7 +489,10 @@
 #define get_file(x)	atomic_inc(&(x)->f_count)
 #define file_count(x)	atomic_read(&(x)->f_count)
 
-extern int init_private_file(struct file *, struct dentry *, int);
+/* Initialize and open a private file and allocate its security structure. */
+extern int open_private_file(struct file *, struct dentry *, int);
+/* Release a private file and free its security structure. */
+extern void close_private_file(struct file *file);
 
 #define	MAX_NON_LFS	((1UL<<31) - 1)
 
diff -Nru a/kernel/ksyms.c b/kernel/ksyms.c
--- a/kernel/ksyms.c	Wed Feb 19 15:39:10 2003
+++ b/kernel/ksyms.c	Wed Feb 19 15:39:10 2003
@@ -179,7 +179,8 @@
 EXPORT_SYMBOL(end_buffer_io_sync);
 EXPORT_SYMBOL(__mark_inode_dirty);
 EXPORT_SYMBOL(get_empty_filp);
-EXPORT_SYMBOL(init_private_file);
+EXPORT_SYMBOL(open_private_file);
+EXPORT_SYMBOL(close_private_file);
 EXPORT_SYMBOL(filp_open);
 EXPORT_SYMBOL(filp_close);
 EXPORT_SYMBOL(put_filp);
