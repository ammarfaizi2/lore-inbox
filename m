Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266304AbUFUQcW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266304AbUFUQcW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 12:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266307AbUFUQcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 12:32:22 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:48646 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP id S266304AbUFUQcQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 12:32:16 -0400
Date: Mon, 21 Jun 2004 17:32:13 +0100
From: John Levon <levon@movementarian.org>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org
Subject: [PATCH] OProfile: allow normal user to trigger sample dumps
Message-ID: <20040621163212.GA9990@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: King of Woolworths - L'Illustration Musicale
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1BcRiP-000LwV-3p*zoixV3Yq3.2*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In 2.4, OProfile allowed normal users to trigger sample dumps (useful
under low sample load). The patch below, by Will Cohen, allows this
for 2.6 too. Against 2.6.7

Please apply

thanks
john


--- linux-2.6.0-0.test11.1.100/drivers/oprofile/oprofile_files.c.userdump	2003-12-09 10:46:54.947629369 -0500
+++ linux-2.6.0-0.test11.1.100/drivers/oprofile/oprofile_files.c	2003-12-09 11:27:44.903151844 -0500
@@ -90,7 +90,7 @@
 void oprofile_create_files(struct super_block * sb, struct dentry * root)
 {
 	oprofilefs_create_file(sb, root, "enable", &enable_fops);
-	oprofilefs_create_file(sb, root, "dump", &dump_fops);
+	oprofilefs_create_file_perm(sb, root, "dump", &dump_fops, 0666);
 	oprofilefs_create_file(sb, root, "buffer", &event_buffer_fops);
 	oprofilefs_create_ulong(sb, root, "buffer_size", &fs_buffer_size);
 	oprofilefs_create_ulong(sb, root, "buffer_watershed", &fs_buffer_watershed);
--- linux-2.6.0-0.test11.1.100/drivers/oprofile/oprofilefs.c.userdump	2003-12-09 10:58:57.858593945 -0500
+++ linux-2.6.0-0.test11.1.100/drivers/oprofile/oprofilefs.c	2003-12-09 11:28:24.125874244 -0500
@@ -165,7 +165,8 @@
 
 
 static struct dentry * __oprofilefs_create_file(struct super_block * sb,
-	struct dentry * root, char const * name, struct file_operations * fops)
+	struct dentry * root, char const * name, struct file_operations * fops,
+	int perm)
 {
 	struct dentry * dentry;
 	struct inode * inode;
@@ -176,7 +177,7 @@
 	dentry = d_alloc(root, &qname);
 	if (!dentry)
 		return 0;
-	inode = oprofilefs_get_inode(sb, S_IFREG | 0644);
+	inode = oprofilefs_get_inode(sb, S_IFREG | perm);
 	if (!inode) {
 		dput(dentry);
 		return 0;
@@ -190,7 +191,8 @@
 int oprofilefs_create_ulong(struct super_block * sb, struct dentry * root,
 	char const * name, unsigned long * val)
 {
-	struct dentry * d = __oprofilefs_create_file(sb, root, name, &ulong_fops);
+	struct dentry * d = __oprofilefs_create_file(sb, root, name,
+						     &ulong_fops, 0644);
 	if (!d)
 		return -EFAULT;
 
@@ -202,7 +204,8 @@
 int oprofilefs_create_ro_ulong(struct super_block * sb, struct dentry * root,
 	char const * name, unsigned long * val)
 {
-	struct dentry * d = __oprofilefs_create_file(sb, root, name, &ulong_ro_fops);
+	struct dentry * d = __oprofilefs_create_file(sb, root, name,
+						     &ulong_ro_fops, 0444);
 	if (!d)
 		return -EFAULT;
 
@@ -227,7 +230,8 @@
 int oprofilefs_create_ro_atomic(struct super_block * sb, struct dentry * root,
 	char const * name, atomic_t * val)
 {
-	struct dentry * d = __oprofilefs_create_file(sb, root, name, &atomic_ro_fops);
+	struct dentry * d = __oprofilefs_create_file(sb, root, name,
+						     &atomic_ro_fops, 0444);
 	if (!d)
 		return -EFAULT;
 
@@ -239,7 +243,16 @@
 int oprofilefs_create_file(struct super_block * sb, struct dentry * root,
 	char const * name, struct file_operations * fops)
 {
-	if (!__oprofilefs_create_file(sb, root, name, fops))
+	if (!__oprofilefs_create_file(sb, root, name, fops, 0644))
+		return -EFAULT;
+	return 0;
+}
+
+
+int oprofilefs_create_file_perm(struct super_block * sb, struct dentry * root,
+	char const * name, struct file_operations * fops, int perm)
+{
+	if (!__oprofilefs_create_file(sb, root, name, fops, perm))
 		return -EFAULT;
 	return 0;
 }
--- linux-2.6.0-0.test11.1.100/include/linux/oprofile.h.userdump	2003-12-09 11:12:44.250469922 -0500
+++ linux-2.6.0-0.test11.1.100/include/linux/oprofile.h	2003-12-09 11:23:00.006494400 -0500
@@ -65,6 +65,9 @@
  */
 int oprofilefs_create_file(struct super_block * sb, struct dentry * root,
 	char const * name, struct file_operations * fops);
+
+int oprofilefs_create_file_perm(struct super_block * sb, struct dentry * root,
+	char const * name, struct file_operations * fops, int perm);
  
 /** Create a file for read/write access to an unsigned long. */
 int oprofilefs_create_ulong(struct super_block * sb, struct dentry * root,
