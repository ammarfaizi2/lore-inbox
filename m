Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315634AbSEIIJg>; Thu, 9 May 2002 04:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315646AbSEIIJf>; Thu, 9 May 2002 04:09:35 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:52159 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S315634AbSEIIJd>;
	Thu, 9 May 2002 04:09:33 -0400
Date: Thu, 9 May 2002 18:08:54 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@transmeta.com>
Cc: Dave Jones <davej@suse.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] Directory Notification Fix
Message-Id: <20020509180854.0cc7935e.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.7.5 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Forward port of the patch that I just sent Marcelo.

The patch below fixes directory notification so that notifications
get cancelled when a process exits.  This make dnotify MUCH more stable
and usable :-)

Please apply.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.14/fs/dnotify.c 2.5.14-dnot/fs/dnotify.c
--- 2.5.14/fs/dnotify.c	Tue Mar 19 15:12:05 2002
+++ 2.5.14-dnot/fs/dnotify.c	Thu May  9 17:52:44 2002
@@ -38,60 +38,74 @@
 	inode->i_dnotify_mask = new_mask;
 }
 
+void dnotify_flush(struct file *filp, fl_owner_t id)
+{
+	struct dnotify_struct *dn;
+	struct dnotify_struct **prev;
+	struct inode *inode;
+
+	inode = filp->f_dentry->d_inode;
+	if (!S_ISDIR(inode->i_mode))
+		return;
+	write_lock(&dn_lock);
+	prev = &inode->i_dnotify;
+	while ((dn = *prev) != NULL) {
+		if ((dn->dn_owner == id) && (dn->dn_filp == filp)) {
+			*prev = dn->dn_next;
+			redo_inode_mask(inode);
+			kmem_cache_free(dn_cache, dn);
+			break;
+		}
+		prev = &dn->dn_next;
+	}
+	write_unlock(&dn_lock);
+}
+
 int fcntl_dirnotify(int fd, struct file *filp, unsigned long arg)
 {
-	struct dnotify_struct *dn = NULL;
+	struct dnotify_struct *dn;
 	struct dnotify_struct *odn;
 	struct dnotify_struct **prev;
 	struct inode *inode;
-	int turning_off = (arg & ~DN_MULTISHOT) == 0;
+	fl_owner_t id = current->files;
 
-	if (!turning_off && !dir_notify_enable)
+	if ((arg & ~DN_MULTISHOT) == 0) {
+		dnotify_flush(filp, id);
+		return 0;
+	}
+	if (!dir_notify_enable)
 		return -EINVAL;
 	inode = filp->f_dentry->d_inode;
 	if (!S_ISDIR(inode->i_mode))
 		return -ENOTDIR;
-	if (!turning_off) {
-		dn = kmem_cache_alloc(dn_cache, SLAB_KERNEL);
-		if (dn == NULL)
-			return -ENOMEM;
-	}
+	dn = kmem_cache_alloc(dn_cache, SLAB_KERNEL);
+	if (dn == NULL)
+		return -ENOMEM;
 	write_lock(&dn_lock);
 	prev = &inode->i_dnotify;
-	for (odn = *prev; odn != NULL; prev = &odn->dn_next, odn = *prev)
-		if ((odn->dn_owner == current->files) && (odn->dn_filp == filp))
-			break;
-	if (odn != NULL) {
-		if (turning_off) {
-			*prev = odn->dn_next;
-			redo_inode_mask(inode);
-			dn = odn;
-			goto out_free;
+	while ((odn = *prev) != NULL) {
+		if ((odn->dn_owner == id) && (odn->dn_filp == filp)) {
+			odn->dn_fd = fd;
+			odn->dn_mask |= arg;
+			inode->i_dnotify_mask |= arg & ~DN_MULTISHOT;
+			kmem_cache_free(dn_cache, dn);
+			goto out;
 		}
-		odn->dn_fd = fd;
-		odn->dn_mask |= arg;
-		inode->i_dnotify_mask |= arg & ~DN_MULTISHOT;
-		goto out_free;
+		prev = &odn->dn_next;
 	}
-	if (turning_off)
-		goto out;
 	filp->f_owner.pid = current->pid;
 	filp->f_owner.uid = current->uid;
 	filp->f_owner.euid = current->euid;
-	dn->dn_magic = DNOTIFY_MAGIC;
 	dn->dn_mask = arg;
 	dn->dn_fd = fd;
 	dn->dn_filp = filp;
-	dn->dn_owner = current->files;
+	dn->dn_owner = id;
 	inode->i_dnotify_mask |= arg & ~DN_MULTISHOT;
 	dn->dn_next = inode->i_dnotify;
 	inode->i_dnotify = dn;
 out:
 	write_unlock(&dn_lock);
 	return 0;
-out_free:
-	kmem_cache_free(dn_cache, dn);
-	goto out;
 }
 
 void __inode_dir_notify(struct inode *inode, unsigned long event)
@@ -104,11 +118,6 @@
 	write_lock(&dn_lock);
 	prev = &inode->i_dnotify;
 	while ((dn = *prev) != NULL) {
-		if (dn->dn_magic != DNOTIFY_MAGIC) {
-		        printk(KERN_ERR "__inode_dir_notify: bad magic "
-				"number in dnotify_struct!\n");
-		        goto out;
-		}
 		if ((dn->dn_mask & event) == 0) {
 			prev = &dn->dn_next;
 			continue;
diff -ruN 2.5.14/fs/open.c 2.5.14-dnot/fs/open.c
--- 2.5.14/fs/open.c	Wed May  1 11:56:52 2002
+++ 2.5.14-dnot/fs/open.c	Thu May  9 17:52:44 2002
@@ -835,7 +835,7 @@
 		retval = filp->f_op->flush(filp);
 		unlock_kernel();
 	}
-	fcntl_dirnotify(0, filp, 0);
+	dnotify_flush(filp, id);
 	locks_remove_posix(filp, id);
 	fput(filp);
 	return retval;
diff -ruN 2.5.14/include/linux/dnotify.h 2.5.14-dnot/include/linux/dnotify.h
--- 2.5.14/include/linux/dnotify.h	Tue May  7 09:57:10 2002
+++ 2.5.14-dnot/include/linux/dnotify.h	Thu May  9 17:54:40 2002
@@ -1,14 +1,13 @@
 /*
  * Directory notification for Linux
  *
- * Copyright 2000 (C) Stephen Rothwell
+ * Copyright (C) 2000,2002 Stephen Rothwell
  */
 
 #include <linux/fs.h>
 
 struct dnotify_struct {
 	struct dnotify_struct *	dn_next;
-	int			dn_magic;
 	unsigned long		dn_mask;	/* Events to be notified
 						   see linux/fcntl.h */
 	int			dn_fd;
@@ -16,9 +15,8 @@
 	fl_owner_t		dn_owner;
 };
 
-#define DNOTIFY_MAGIC	0x444E4F54
-
 extern void __inode_dir_notify(struct inode *, unsigned long);
+extern void dnotify_flush(struct file *filp, fl_owner_t id);
 extern int fcntl_dirnotify(int, struct file *, unsigned long);
 
 static inline void inode_dir_notify(struct inode *inode, unsigned long event)
