Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262725AbVFWH6e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262725AbVFWH6e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 03:58:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262632AbVFWH4Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 03:56:24 -0400
Received: from [24.22.56.4] ([24.22.56.4]:11494 "EHLO
	w-gerrit.beaverton.ibm.com") by vger.kernel.org with ESMTP
	id S262251AbVFWGSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 02:18:40 -0400
Message-Id: <20050623061800.146204000@w-gerrit.beaverton.ibm.com>
References: <20050623061552.833852000@w-gerrit.beaverton.ibm.com>
Date: Wed, 22 Jun 2005 23:16:21 -0700
From: Gerrit Huizenga <gh@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: ckrm-tech@lists.sourceforge.net, Matt Helsley <matthltc@us.ibm.com>,
       Gerrit Huizenga <gh@us.ibm.com>
Subject: [patch 29/38] CKRM e18: Replace target file interface with a writable members file
Content-Disposition: inline; filename=ckrm-remove_target
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the target file interface with a writable members file.

Signed-Off-By: Matt Helsley <matthltc@us.ibm.com>
Signed-Off-By: Gerrit Huizenga <gh@us.ibm.com>

---------------------------------------------------------------------

Index: linux-2.6.12-ckrm1/Documentation/ckrm/ckrm_basics
===================================================================
--- linux-2.6.12-ckrm1.orig/Documentation/ckrm/ckrm_basics	2005-06-20 13:25:01.000000000 -0700
+++ linux-2.6.12-ckrm1/Documentation/ckrm/ckrm_basics	2005-06-20 15:09:24.000000000 -0700
@@ -33,12 +33,16 @@ shares:  allows to change the shares of 
          class
 stats:   allows to see the statistics associated with each resources managed
          by the class
-target:  allows to assign a task to a class. If a CE is present, assigning
-         a task to a class through this interface will prevent CE from
-		 reassigning the task to any class during reclassification.
-members: allows to see which tasks has been assigned to a class
+target:  obsolete. functionality moved to 'members' file.
+members: allows to assign a task to a class and to see which tasks has
+         been assigned to a class.
+         If a CE is present, assigning a task to a class through this
+         interface will prevent CE from reassigning the task to any class
+         during reclassification.
 config:  allow to view and modify configuration information of different
          resources in a class.
+reclassify: When CE is present, allows a task to be reclassified by CE. In
+         the absence of CE, this file provides no functionality.
 
 Resource allocations for a class is controlled by the parameters:
 
Index: linux-2.6.12-ckrm1/Documentation/ckrm/core_usage
===================================================================
--- linux-2.6.12-ckrm1.orig/Documentation/ckrm/core_usage	2005-06-20 13:25:01.000000000 -0700
+++ linux-2.6.12-ckrm1/Documentation/ckrm/core_usage	2005-06-20 15:09:24.000000000 -0700
@@ -9,7 +9,7 @@ Usage of CKRM without a classification e
    creates a socketclass named s1
 
 The newly created class directory is automatically populated by magic files
-shares, stats, members, target and config.
+shares, stats, members, config and reclassify.
 
 2. View default shares
 
@@ -34,11 +34,11 @@ shares, stats, members, target and confi
 
 4. Reclassify a task (listening socket)
 
-   write the pid of the process to the destination class' target file
-   # echo 1004 > /rcfs/taskclass/c1/target
+   write the pid of the process to the destination class' members file
+   # echo 1004 > /rcfs/taskclass/c1/members
 
-   write the "<ipaddress>\<port>" string to the destination class' target file
-   # echo "0.0.0.0\32770"  > /rcfs/taskclass/c1/target
+   write the "<ipaddress>\<port>" string to the destination class' members file
+   # echo "0.0.0.0\32770"  > /rcfs/taskclass/c1/members
 
 5. Get a list of tasks (sockets) assigned to a taskclass (socketclass)
 
Index: linux-2.6.12-ckrm1/fs/rcfs/socket_fs.c
===================================================================
--- linux-2.6.12-ckrm1.orig/fs/rcfs/socket_fs.c	2005-06-20 13:25:01.000000000 -0700
+++ linux-2.6.12-ckrm1/fs/rcfs/socket_fs.c	2005-06-20 15:09:24.000000000 -0700
@@ -65,12 +65,6 @@ struct rcfs_magf rcfs_sock_rootdesc[] = 
 	 .i_fop = &members_fileops,
 	 },
 	{
-	 .name = "target",
-	 .mode = RCFS_DEFAULT_FILE_MODE,
-	 .i_op = &my_iops,
-	 .i_fop = &target_fileops,
-	 },
-	{
 	 .name = "reclassify",
 	 .mode = RCFS_DEFAULT_FILE_MODE,
 	 .i_op = &my_iops,
@@ -103,12 +97,6 @@ struct rcfs_magf rcfs_sock_magf[] = {
 	 .i_op = &my_iops,
 	 .i_fop = &stats_fileops,
 	 },
-	{
-	 .name = "target",
-	 .mode = RCFS_DEFAULT_FILE_MODE,
-	 .i_op = &my_iops,
-	 .i_fop = &target_fileops,
-	 },
 };
 
 struct rcfs_magf sub_magf[] = {
Index: linux-2.6.12-ckrm1/fs/rcfs/magic.c
===================================================================
--- linux-2.6.12-ckrm1.orig/fs/rcfs/magic.c	2005-06-20 13:25:01.000000000 -0700
+++ linux-2.6.12-ckrm1/fs/rcfs/magic.c	2005-06-20 15:09:24.000000000 -0700
@@ -209,29 +209,31 @@ out:
 }
 
 /*
- * Shared function used by Target / Reclassify
+ * Shared function used by Members / Reclassify
  */
+#define MEMBERS_MAX_INPUT_SIZE MAX_INPUT_SIZE
 
 static ssize_t
-target_reclassify_write(struct file *file, const char __user * buf,
-			size_t count, loff_t * ppos, int manual)
+members_reclassify_write(struct file *file, const char __user * buf,
+ 			 size_t count, loff_t * ppos, int manual)
 {
 	struct rcfs_inode_info *ri = rcfs_get_inode_info(file->f_dentry->d_inode);
 	char *optbuf;
 	int rc = -EINVAL;
 	struct ckrm_classtype *clstype;
 
-	if (count > MAX_INPUT_SIZE)
+	if (count > MEMBERS_MAX_INPUT_SIZE)
 		return -EINVAL;
 	if (!access_ok(VERIFY_READ, buf, count))
 		return -EFAULT;
 	down(&(ri->vfs_inode.i_sem));
-	optbuf = kmalloc(MAX_INPUT_SIZE, GFP_KERNEL);
+	optbuf = kmalloc(MEMBERS_MAX_INPUT_SIZE, GFP_KERNEL);
 	__copy_from_user(optbuf, buf, count);
 	mkvalidstr(optbuf);
 	clstype = ri->core->classtype;
 	if (clstype->forced_reclassify)
-		rc = (*clstype->forced_reclassify) (manual ? ri->core: NULL, optbuf);
+		rc = (*clstype->forced_reclassify) (manual ? ri->core :
+						    NULL, optbuf);
 	up(&(ri->vfs_inode.i_sem));
 	kfree(optbuf);
 	return (!rc ? count : rc);
@@ -239,23 +241,6 @@ target_reclassify_write(struct file *fil
 }
 
 /*
- * Target
- *
- * pseudo file for manually reclassifying members to a class
- */
-
-static ssize_t
-target_write(struct file *file, const char __user * buf,
-	     size_t count, loff_t * ppos)
-{
-	return target_reclassify_write(file, buf, count, ppos, 1);
-}
-
-struct file_operations target_fileops = {
-	.write = target_write,
-};
-
-/*
  * Reclassify
  *
  * pseudo file for reclassification of an object through CE
@@ -265,7 +250,7 @@ static ssize_t
 reclassify_write(struct file *file, const char __user * buf,
 		 size_t count, loff_t * ppos)
 {
-	return target_reclassify_write(file, buf, count, ppos, 0);
+	return members_reclassify_write(file, buf, count, ppos, 0);
 }
 
 struct file_operations reclassify_fileops = {
@@ -296,12 +281,20 @@ struct file_operations config_fileops = 
  *
  * List members of a class
  */
+static ssize_t
+members_write(struct file *file, const char __user * buf,
+ 	      size_t count, loff_t * ppos)
+{
+	return members_reclassify_write(file,buf,count,ppos,1);
+}
+
 
 struct file_operations members_fileops = {
 	.open           = magic_open,
 	.read           = seq_read,
 	.llseek         = seq_lseek,
 	.release        = magic_close,
+	.write          = members_write,
 };
 
 /*

--
