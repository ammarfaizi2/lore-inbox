Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263369AbTIWOvz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 10:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263373AbTIWOvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 10:51:55 -0400
Received: from verein.lst.de ([212.34.189.10]:45236 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S263369AbTIWOvx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 10:51:53 -0400
Date: Tue, 23 Sep 2003 16:51:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
Subject: [PATCH] check permission in ->open for /proc/sys/
Message-ID: <20030923145149.GA16235@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, akpm@osdl.org,
	viro@parcelfarce.linux.theplanet.co.uk,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -3 () PATCH_UNIFIED_DIFF,USER_AGENT_MUTT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's the only abuse of proc_iops left (escept the totally b0rked comx
driver).  The patch is from Al, I just forward-ported it from 2.4.


--- 1.53/kernel/sysctl.c	Tue Sep  9 02:08:58 2003
+++ edited/kernel/sysctl.c	Tue Sep 23 15:29:35 2003
@@ -136,17 +136,14 @@
 
 static ssize_t proc_readsys(struct file *, char __user *, size_t, loff_t *);
 static ssize_t proc_writesys(struct file *, const char __user *, size_t, loff_t *);
-static int proc_sys_permission(struct inode *, int, struct nameidata *);
+static int proc_opensys(struct inode *, struct file *);
 
 struct file_operations proc_sys_file_operations = {
+	.open		= proc_opensys,
 	.read		= proc_readsys,
 	.write		= proc_writesys,
 };
 
-static struct inode_operations proc_sys_inode_operations = {
-	.permission	= proc_sys_permission,
-};
-
 extern struct proc_dir_entry *proc_sys_root;
 
 static void register_proc_table(ctl_table *, struct proc_dir_entry *);
@@ -1140,10 +1137,8 @@
 			if (!de)
 				continue;
 			de->data = (void *) table;
-			if (table->proc_handler) {
+			if (table->proc_handler)
 				de->proc_fops = &proc_sys_file_operations;
-				de->proc_iops = &proc_sys_inode_operations;
-			}
 		}
 		table->de = de;
 		if (de->mode & S_IFDIR)
@@ -1212,6 +1207,20 @@
 	return res;
 }
 
+static int proc_opensys(struct inode *inode, struct file *file)
+{
+	if (file->f_mode & FMODE_WRITE) {
+		/*
+		 * sysctl entries that are not writable,
+		 * are _NOT_ writable, capabilities or not.
+		 */
+		if (!(inode->i_mode & S_IWUSR))
+			return -EPERM;
+	}
+
+	return 0;
+}
+
 static ssize_t proc_readsys(struct file * file, char __user * buf,
 			    size_t count, loff_t *ppos)
 {
@@ -1222,11 +1231,6 @@
 			     size_t count, loff_t *ppos)
 {
 	return do_rw_proc(1, file, (char __user *) buf, count, ppos);
-}
-
-static int proc_sys_permission(struct inode *inode, int op, struct nameidata *nd)
-{
-	return test_perm(inode->i_mode, op);
 }
 
 /**
