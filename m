Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261602AbUFVJZ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbUFVJZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 05:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261857AbUFVJZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 05:25:59 -0400
Received: from smtp8.wanadoo.fr ([193.252.22.23]:16001 "EHLO
	mwinf0804.wanadoo.fr") by vger.kernel.org with ESMTP
	id S261602AbUFVJZx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 05:25:53 -0400
Date: Tue, 22 Jun 2004 11:28:29 +0000
From: Philippe Elie <phil.el@wanadoo.fr>
To: John Levon <levon@movementarian.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org
Subject: Re: [PATCH] OProfile: allow normal user to trigger sample dumps
Message-ID: <20040622112829.GA385@zaniah>
References: <20040621163212.GA9990@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040621163212.GA9990@compsoc.man.ac.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jun 2004 at 17:32 +0000, John Levon wrote:

> 
> In 2.4, OProfile allowed normal users to trigger sample dumps (useful
> under low sample load). The patch below, by Will Cohen, allows this
> for 2.6 too. Against 2.6.7
> 

The patch didn't apply cleanly (minor problem but I redo the diff), it works fine on my box and it's usefull imho. Please apply

regards,
Phil



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
