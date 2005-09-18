Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932072AbVIROXA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932072AbVIROXA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 10:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932073AbVIROXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 10:23:00 -0400
Received: from ppp-62-11-75-109.dialup.tiscali.it ([62.11.75.109]:28595 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S932072AbVIROW7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 10:22:59 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 03/12] HPPFS: various simple fixes
Date: Sun, 18 Sep 2005 16:09:49 +0200
To: Antoine Martin <antoine@nagafix.co.uk>, Al Viro <viro@zeniv.linux.org.uk>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net
Cc: LKML <linux-kernel@vger.kernel.org>
Message-Id: <20050918140948.31461.89414.stgit@zion.home.lan>
In-Reply-To: 200509181400.39120.blaisorblade@yahoo.it
References: 200509181400.39120.blaisorblade@yahoo.it
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

*) Fix Oops when the underlying file doesn't support
read/write/follow_link/read_link (ported from 2.4)

*) fix get_fs()/set_fs() stuff - would affect anything with get_fs() ==
KERNEL_DS calling hppfs_open, i.e. opening a file.

*) forward-port various fixes from 2.4

*) better error handling, and correct error messages

*) learn that if open() returned 0, it succeeded (see 1st hunk in the
patch).

*) also various whitespace and codingstyle cleanups.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 fs/hppfs/hppfs_kern.c |  110 +++++++++++++++++++++++++++++++------------------
 1 files changed, 70 insertions(+), 40 deletions(-)

diff --git a/fs/hppfs/hppfs_kern.c b/fs/hppfs/hppfs_kern.c
--- a/fs/hppfs/hppfs_kern.c
+++ b/fs/hppfs/hppfs_kern.c
@@ -128,7 +128,7 @@ static int file_removed(struct dentry *d
 
 	fd = os_open_file(host_file, of_read(OPENFLAGS()), 0);
 	kfree(host_file);
-	if(fd > 0){
+	if (fd >= 0) {
 		os_close_file(fd);
 		return(1);
 	}
@@ -221,16 +221,22 @@ static ssize_t read_proc(struct file *fi
 {
 	ssize_t (*read)(struct file *, char *, size_t, loff_t *);
 	ssize_t n;
+	mm_segment_t old_fs;
 
 	read = file->f_dentry->d_inode->i_fop->read;
 
-	if(!is_user)
+	if (read == NULL)
+		return -EINVAL;
+
+	if (!is_user) {
+		old_fs = get_fs();
 		set_fs(KERNEL_DS);
+	}
 
 	n = (*read)(file, buf, count, &file->f_pos);
 
-	if(!is_user)
-		set_fs(USER_DS);
+	if (!is_user)
+		set_fs(old_fs);
 
 	if(ppos) *ppos = file->f_pos;
 	return n;
@@ -253,8 +259,7 @@ static ssize_t hppfs_read_file(int fd, c
 		cur = min_t(ssize_t, count, PAGE_SIZE);
 		err = os_read_file(fd, new_buf, cur);
 		if(err < 0){
-			printk("hppfs_read : read failed, errno = %d\n",
-			       err);
+			printk("hppfs_read : read failed, errno = %d\n", -err);
 			n = err;
 			goto out_free;
 		}
@@ -282,7 +287,7 @@ static ssize_t hppfs_read(struct file *f
 	loff_t off;
 	int err;
 
-	if(hppfs->contents != NULL){
+	if (hppfs->contents != NULL) {
 		if(*ppos >= hppfs->len) return(0);
 
 		data = hppfs->contents;
@@ -297,18 +302,17 @@ static ssize_t hppfs_read(struct file *f
 			count = hppfs->len - off;
 		copy_to_user(buf, &data->contents[off], count);
 		*ppos += count;
-	}
-	else if(hppfs->host_fd != -1){
+	} else if(hppfs->host_fd != -1) {
 		err = os_seek_file(hppfs->host_fd, *ppos);
-		if(err){
+		if (err < 0){
 			printk("hppfs_read : seek failed, errno = %d\n", err);
 			return(err);
 		}
 		count = hppfs_read_file(hppfs->host_fd, buf, count);
 		if(count > 0)
 			*ppos += count;
-	}
-	else count = read_proc(hppfs->proc_file, buf, count, ppos, 1);
+	} else
+		count = read_proc(hppfs->proc_file, buf, count, ppos, 1);
 
 	return(count);
 }
@@ -323,6 +327,9 @@ static ssize_t hppfs_write(struct file *
 
 	write = proc_file->f_dentry->d_inode->i_fop->write;
 
+	if (write == NULL)
+		return -EINVAL;
+
 	proc_file->f_pos = file->f_pos;
 	err = (*write)(proc_file, buf, len, &proc_file->f_pos);
 	file->f_pos = proc_file->f_pos;
@@ -339,7 +346,7 @@ static int open_host_sock(char *host_fil
 	strcpy(end, "/rw");
 	*filter_out = 1;
 	fd = os_connect_socket(host_file);
-	if(fd > 0)
+	if (fd >= 0)
 		return(fd);
 
 	strcpy(end, "/r");
@@ -368,9 +375,9 @@ static struct hppfs_data *hppfs_get_data
 					 loff_t *size_out)
 {
 	struct hppfs_data *data, *new, *head;
-	int n, err;
+	int ret;
 
-	err = -ENOMEM;
+	ret = -ENOMEM;
 	data = kmalloc(sizeof(*data), GFP_KERNEL);
 	if(data == NULL){
 		printk("hppfs_get_data : head allocation failed\n");
@@ -382,37 +389,44 @@ static struct hppfs_data *hppfs_get_data
 	head = data;
 	*size_out = 0;
 
-	if(filter){
-		while((n = read_proc(proc_file, data->contents,
-				     sizeof(data->contents), NULL, 0)) > 0)
-			os_write_file(fd, data->contents, n);
-		err = os_shutdown_socket(fd, 0, 1);
-		if(err){
+	if (filter) {
+		int err = 0;
+		while ((ret = read_proc(proc_file, data->contents,
+			     sizeof(data->contents), NULL, 0)) > 0) {
+			err = os_write_file(fd, data->contents, ret);
+			if (err != ret)
+				printk("hppfs_get_data : failed to write out "
+				       "%d bytes, err = %d\n", ret, -err);
+		}
+		ret = os_shutdown_socket(fd, 0, 1);
+		if (ret) {
 			printk("hppfs_get_data : failed to shut down "
 			       "socket\n");
 			goto failed_free;
 		}
+		/* Handle this *after* closing the socket. */
+		if (err)
+			goto failed_free;
 	}
-	while(1){
-		n = os_read_file(fd, data->contents, sizeof(data->contents));
-		if(n < 0){
-			err = n;
+	while (1) {
+		ret = os_read_file(fd, data->contents, sizeof(data->contents));
+		if (ret < 0) {
 			printk("hppfs_get_data : read failed, errno = %d\n",
-			       err);
+			       -ret);
 			goto failed_free;
 		}
-		else if(n == 0)
+		else if(ret == 0)
 			break;
 
-		*size_out += n;
+		*size_out += ret;
 
-		if(n < sizeof(data->contents))
+		if(ret < sizeof(data->contents))
 			break;
 
 		new = kmalloc(sizeof(*data), GFP_KERNEL);
 		if(new == 0){
 			printk("hppfs_get_data : data allocation failed\n");
-			err = -ENOMEM;
+			ret = -ENOMEM;
 			goto failed_free;
 		}
 
@@ -420,12 +434,12 @@ static struct hppfs_data *hppfs_get_data
 		list_add(&new->list, &data->list);
 		data = new;
 	}
-	return(head);
+	return head;
 
- failed_free:
+failed_free:
 	free_contents(head);
- failed:
-	return(ERR_PTR(err));
+failed:
+	return ERR_PTR(ret);
 }
 
 static struct hppfs_private *hppfs_data(void)
@@ -481,16 +495,16 @@ static int hppfs_open(struct inode *inod
 	type = os_file_type(host_file);
 	if(type == OS_TYPE_FILE){
 		fd = os_open_file(host_file, of_read(OPENFLAGS()), 0);
-		if(fd >= 0)
+		if (fd >= 0)
 			data->host_fd = fd;
-		else printk("hppfs_open : failed to open '%s', errno = %d\n",
+		else printk("hppfs_open : failed to open '%s', err = %d\n",
 			    host_file, -fd);
 
 		data->contents = NULL;
 	}
 	else if(type == OS_TYPE_DIR){
 		fd = open_host_sock(host_file, &filter);
-		if(fd > 0){
+		if (fd >= 0){
 			data->contents = hppfs_get_data(fd, filter,
 							data->proc_file,
 							file, &data->len);
@@ -498,7 +512,7 @@ static int hppfs_open(struct inode *inod
 				data->host_fd = fd;
 		}
 		else printk("hppfs_open : failed to open a socket in "
-			    "'%s', errno = %d\n", host_file, -fd);
+			    "'%s', err = %d\n", host_file, -fd);
 	}
 	kfree(host_file);
 
@@ -589,13 +603,15 @@ static int hppfs_readdir(struct file *fi
 	struct hppfs_private *data = file->private_data;
 	struct file *proc_file = data->proc_file;
 	int (*readdir)(struct file *, void *, filldir_t);
+	int err;
 	struct hppfs_dirent dirent = ((struct hppfs_dirent)
 		                      { .vfs_dirent  	= ent,
 					.filldir 	= filldir,
 					.dentry  	= file->f_dentry } );
-	int err;
 
 	readdir = proc_file->f_dentry->d_inode->i_fop->readdir;
+	if (readdir == NULL)
+		return -ENOTDIR;
 
 	proc_file->f_pos = file->f_pos;
 	err = (*readdir)(proc_file, &dirent, hppfs_filldir);
@@ -662,6 +678,7 @@ static int hppfs_readlink(struct dentry 
 {
 	struct file *proc_file;
 	struct dentry *proc_dentry;
+	int (*readlink)(struct dentry *, char *, int);
 	int ret;
 
 	proc_dentry = HPPFS_I(dentry->d_inode)->proc_dentry;
@@ -669,6 +686,10 @@ static int hppfs_readlink(struct dentry 
 	if (IS_ERR(proc_file))
 		return PTR_ERR(proc_file);
 
+	readlink = proc_dentry->d_inode->i_op->readlink;
+	if (readlink == NULL)
+		return -EINVAL;
+	ret = (*readlink)(proc_dentry, buffer, buflen);
 	ret = proc_dentry->d_inode->i_op->readlink(proc_dentry, buffer, buflen);
 
 	fput(proc_file);
@@ -680,6 +701,7 @@ static void* hppfs_follow_link(struct de
 {
 	struct file *proc_file;
 	struct dentry *proc_dentry;
+	void * (*follow_link)(struct dentry *, struct nameidata *);
 	void *ret;
 
 	proc_dentry = HPPFS_I(dentry->d_inode)->proc_dentry;
@@ -687,7 +709,15 @@ static void* hppfs_follow_link(struct de
 	if (IS_ERR(proc_file))
 		return proc_file;
 
-	ret = proc_dentry->d_inode->i_op->follow_link(proc_dentry, nd);
+	follow_link = proc_dentry->d_inode->i_op->follow_link;
+
+	/* XXX: I took this from 2.4, but we're only called when we're a
+	 * symbolic link (see init_inode S_ISLNK test below). Should we drop
+	 * this check? */
+	if (follow_link == NULL)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	ret = follow_link(proc_dentry, nd);
 
 	fput(proc_file);
 

