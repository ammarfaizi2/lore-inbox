Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751999AbWHNL1c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751999AbWHNL1c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 07:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751997AbWHNL1c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 07:27:32 -0400
Received: from cantor2.suse.de ([195.135.220.15]:46817 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751994AbWHNL1b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 07:27:31 -0400
From: Andi Kleen <ak@suse.de>
References: <20060814 127.183332000@suse.de>
In-Reply-To: <20060814 127.183332000@suse.de>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH] [1/3] Some cleanup in the pipe code
Message-Id: <20060814112730.4B91213BD9@wotan.suse.de>
Date: Mon, 14 Aug 2006 13:27:30 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Split the big and hard to read do_pipe function into smaller pieces.

This creates new create_write_pipe/free_write_pipe/create_read_pipe 
functions. These functions are made global so that they can be
used by other parts of the kernel.

The resulting code is more generic and easier to read and has cleaner error 
handling and less gotos.

Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux/include/linux/fs.h
===================================================================
--- linux.orig/include/linux/fs.h
+++ linux/include/linux/fs.h
@@ -1563,6 +1563,9 @@ static inline void allow_write_access(st
 		atomic_inc(&file->f_dentry->d_inode->i_writecount);
 }
 extern int do_pipe(int *);
+extern struct file *create_read_pipe(struct file *f);
+extern struct file *create_write_pipe(void);
+extern void free_write_pipe(struct file *);
 
 extern int open_namei(int dfd, const char *, int, int, struct nameidata *);
 extern int may_open(struct nameidata *, int, int);
Index: linux/fs/pipe.c
===================================================================
--- linux.orig/fs/pipe.c
+++ linux/fs/pipe.c
@@ -890,87 +890,118 @@ fail_inode:
 	return NULL;
 }
 
-int do_pipe(int *fd)
+struct file *create_write_pipe(void)
 {
-	struct qstr this;
-	char name[32];
+	int err;
+	struct inode *inode;
+	struct file *f;
 	struct dentry *dentry;
-	struct inode * inode;
-	struct file *f1, *f2;
-	int error;
-	int i, j;
-
-	error = -ENFILE;
-	f1 = get_empty_filp();
-	if (!f1)
-		goto no_files;
-
-	f2 = get_empty_filp();
-	if (!f2)
-		goto close_f1;
+	char name[32];
+	struct qstr this;
 
+	f = get_empty_filp();
+	if (!f)
+		return ERR_PTR(-ENFILE);
+	err = -ENFILE;
 	inode = get_pipe_inode();
 	if (!inode)
-		goto close_f12;
-
-	error = get_unused_fd();
-	if (error < 0)
-		goto close_f12_inode;
-	i = error;
-
-	error = get_unused_fd();
-	if (error < 0)
-		goto close_f12_inode_i;
-	j = error;
+		goto err_file;
 
-	error = -ENOMEM;
 	sprintf(name, "[%lu]", inode->i_ino);
 	this.name = name;
 	this.len = strlen(name);
 	this.hash = inode->i_ino; /* will go */
+	err = -ENOMEM;
 	dentry = d_alloc(pipe_mnt->mnt_sb->s_root, &this);
 	if (!dentry)
-		goto close_f12_inode_i_j;
+		goto err_inode;
 
 	dentry->d_op = &pipefs_dentry_operations;
 	d_add(dentry, inode);
-	f1->f_vfsmnt = f2->f_vfsmnt = mntget(mntget(pipe_mnt));
-	f1->f_dentry = f2->f_dentry = dget(dentry);
-	f1->f_mapping = f2->f_mapping = inode->i_mapping;
-
-	/* read file */
-	f1->f_pos = f2->f_pos = 0;
-	f1->f_flags = O_RDONLY;
-	f1->f_op = &read_pipe_fops;
-	f1->f_mode = FMODE_READ;
-	f1->f_version = 0;
-
-	/* write file */
-	f2->f_flags = O_WRONLY;
-	f2->f_op = &write_pipe_fops;
-	f2->f_mode = FMODE_WRITE;
-	f2->f_version = 0;
+	f->f_vfsmnt = mntget(pipe_mnt);
+	f->f_dentry = dentry;
+	f->f_mapping = inode->i_mapping;
+
+	f->f_flags = O_WRONLY;
+	f->f_op = &write_pipe_fops;
+	f->f_mode = FMODE_WRITE;
+	f->f_version = 0;
+
+	return f;
+
+ err_inode:
+	free_pipe_info(inode);
+	iput(inode);
+ err_file:
+	put_filp(f);
+	return ERR_PTR(err);
+}
+
+void free_write_pipe(struct file *f)
+{
+	mntput(f->f_vfsmnt);
+	dput(f->f_dentry);
+	put_filp(f);
+}
+
+struct file *create_read_pipe(struct file *wrf)
+{
+	struct file *f = get_empty_filp();
+	if (!f)
+		return ERR_PTR(-ENFILE);
+
+	/* Grab pipe from the writer */
+	f->f_vfsmnt = mntget(wrf->f_vfsmnt);
+	f->f_dentry = dget(wrf->f_dentry);
+	f->f_mapping = wrf->f_dentry->d_inode->i_mapping;
+
+	f->f_pos = 0;
+	f->f_flags = O_RDONLY;
+	f->f_op = &read_pipe_fops;
+	f->f_mode = FMODE_READ;
+	f->f_version = 0;
+
+	return f;
+}
+
+int do_pipe(int *fd)
+{
+	struct file *fw, *fr;
+	int error;
+	int i, j;
 
-	fd_install(i, f1);
-	fd_install(j, f2);
+	fw = create_write_pipe();
+	if (IS_ERR(fw))
+		return PTR_ERR(fw);
+	fr = create_read_pipe(fw);
+	error = PTR_ERR(fr);
+	if (IS_ERR(fr))
+		goto err_write_pipe;
+
+	error = get_unused_fd();
+	if (error < 0)
+		goto err_read_pipe;
+	i = error;
+
+	error = get_unused_fd();
+	if (error < 0)
+		goto err_i_fd;
+	j = error;
+
+	fd_install(i, fr);
+	fd_install(j, fw);
 	fd[0] = i;
 	fd[1] = j;
 
 	return 0;
 
-close_f12_inode_i_j:
-	put_unused_fd(j);
-close_f12_inode_i:
+ err_i_fd:
 	put_unused_fd(i);
-close_f12_inode:
-	free_pipe_info(inode);
-	iput(inode);
-close_f12:
-	put_filp(f2);
-close_f1:
-	put_filp(f1);
-no_files:
-	return error;	
+ err_read_pipe:
+	put_filp(fr);
+ err_write_pipe:
+	free_write_pipe(fw);
+	return error;
 }
 
 /*
