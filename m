Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932077AbVIROYF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbVIROYF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 10:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932082AbVIROXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 10:23:36 -0400
Received: from ppp-62-11-75-109.dialup.tiscali.it ([62.11.75.109]:36531 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S932075AbVIROXc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 10:23:32 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 06/12] HPPFS: add ->release method to fix struct file leak
Date: Sun, 18 Sep 2005 16:09:55 +0200
To: Antoine Martin <antoine@nagafix.co.uk>, Al Viro <viro@zeniv.linux.org.uk>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net
Cc: LKML <linux-kernel@vger.kernel.org>
Message-Id: <20050918140955.31461.2812.stgit@zion.home.lan>
In-Reply-To: 200509181400.39120.blaisorblade@yahoo.it
References: 200509181400.39120.blaisorblade@yahoo.it
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

When hppfs_open is called, we in turn open with dentry_open a file,
referring to the file we are wrapping, and also other resources are
allocated (including a host fd - I have a old report of fd leaks with
hppfs, and this patch seems quite the fix to it).

Add a release method to release all these resources.

Also, clean whitespace where I'm touching code and remove an unused
parameter.

And add copyright.
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 fs/hppfs/hppfs_kern.c |   47 ++++++++++++++++++++++++++++++++++-------------
 1 files changed, 34 insertions(+), 13 deletions(-)

diff --git a/fs/hppfs/hppfs_kern.c b/fs/hppfs/hppfs_kern.c
--- a/fs/hppfs/hppfs_kern.c
+++ b/fs/hppfs/hppfs_kern.c
@@ -1,5 +1,6 @@
 /*
  * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
+ * Copyright (C) 2005 Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
  * Licensed under the GPL
  */
 
@@ -316,6 +317,7 @@ static ssize_t hppfs_read(struct file *f
 
 		if(off + count > hppfs->len)
 			count = hppfs->len - off;
+		/*XXX: we should walk the list of remaining buffers! */
 		err = copy_to_user(buf, &data->contents[off], count);
 		count -= err;
 		if (!count)
@@ -388,7 +390,6 @@ static void free_contents(struct hppfs_d
 
 static struct hppfs_data *hppfs_get_data(int fd, int filter,
 					 struct file *proc_file,
-					 struct file *hppfs_file,
 					 loff_t *size_out)
 {
 	struct hppfs_data *data, *new, *head;
@@ -502,7 +503,6 @@ static int hppfs_open(struct inode *inod
 
 	proc_dentry = HPPFS_I(inode)->proc_dentry;
 
-	/* XXX This isn't closed anywhere */
 	data->proc_file = dentry_open(dget(proc_dentry), mntget(proc_submnt),
 				      file_mode(file->f_mode));
 	err = PTR_ERR(data->proc_file);
@@ -510,7 +510,7 @@ static int hppfs_open(struct inode *inod
 		goto out_free1;
 
 	type = os_file_type(host_file);
-	if(type == OS_TYPE_FILE){
+	if (type == OS_TYPE_FILE) {
 		fd = os_open_file(host_file, of_read(OPENFLAGS()), 0);
 		if (fd >= 0)
 			data->host_fd = fd;
@@ -518,33 +518,53 @@ static int hppfs_open(struct inode *inod
 			    host_file, -fd);
 
 		data->contents = NULL;
-	}
-	else if(type == OS_TYPE_DIR){
+	} else if (type == OS_TYPE_DIR) {
 		fd = open_host_sock(host_file, &filter);
 		if (fd >= 0){
 			data->contents = hppfs_get_data(fd, filter,
 							data->proc_file,
-							file, &data->len);
-			if(!IS_ERR(data->contents))
+							&data->len);
+			if (likely(!IS_ERR(data->contents))) {
 				data->host_fd = fd;
-		}
-		else printk("hppfs_open : failed to open a socket in "
+			} else {
+				printk("hppfs_open : failed to read data from "
+						"host, err = %ld\n",
+						PTR_ERR(data->contents));
+				data->contents = NULL;
+			}
+		} else {
+			printk("hppfs_open : failed to open a socket in "
 			    "'%s', err = %d\n", host_file, -fd);
+		}
 	}
 	kfree(host_file);
 
 	file->private_data = data;
 	return(0);
 
- out_free1:
+out_free1:
 	kfree(host_file);
- out_free2:
-	free_contents(data->contents);
+out_free2:
 	kfree(data);
- out:
+out:
 	return(err);
 }
 
+static int hppfs_release(struct inode *inode, struct file *file)
+{
+	struct hppfs_private *data = file->private_data;
+
+	WARN_ON(file_count(data->proc_file) != 1);
+	fput(data->proc_file);
+	free_contents(data->contents);
+
+	/* close() works on sockets too. */
+	os_close_file(data->host_fd);
+
+	kfree(data);
+	return 0;
+}
+
 static int hppfs_dir_open(struct inode *inode, struct file *file)
 {
 	struct hppfs_private *data;
@@ -595,6 +615,7 @@ static struct file_operations hppfs_file
 	.read		= hppfs_read,
 	.write		= hppfs_write,
 	.open		= hppfs_open,
+	.release	= hppfs_release,
 };
 
 struct hppfs_dirent {

