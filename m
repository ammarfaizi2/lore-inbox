Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268971AbUJULnn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268971AbUJULnn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 07:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269072AbUJULlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 07:41:21 -0400
Received: from rproxy.gmail.com ([64.233.170.204]:59962 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268971AbUJULiC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 07:38:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=XHwPVR6uxME4P4J8Tlc6AuO8qS1MZsrzZTrfvjMxg1hoteMSs0aLZL/+eUuwIUof4WsQizXONKc2AG8uR8TPL2JcSGRyLWNZLMKS0zb80eZtprtJeKmO1sJfljgl1wzcwY0/qlrtHaDmMBd4swR4UPTVWN6I1elrlk+W+/FJTr4=
Message-ID: <2c59f0030410210438586cb2db@mail.gmail.com>
Date: Thu, 21 Oct 2004 17:08:01 +0530
From: Amit Gud <amitgud1@gmail.com>
Reply-To: Amit Gud <amitgud1@gmail.com>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org, gud@eth.net
Subject: [PATCH] Remove union intent from struct nameidata
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Again, I can't see any obvious use of this union in struct nameidata
in linux/namei.h -- it contains just one entry.

If we have not used it for a long time now and if there are no plans
to use it in the future, is it worth keeping?

Following patch removes the union and any references to it. Applies to 2.6.9.


AG


Signed-off-by: Amit Gud <gud@eth.net>

diff -uprN -X dontdiff linux-2.6.9/fs/cifs/dir.c tmp-2.6.9/fs/cifs/dir.c
--- linux-2.6.9/fs/cifs/dir.c	2004-10-19 03:24:37.000000000 +0530
+++ tmp-2.6.9/fs/cifs/dir.c	2004-10-21 15:59:42.000000000 +0530
@@ -199,23 +199,23 @@ cifs_create(struct inode *inode, struct 
 	}
 
 	if(nd) {
-		if ((nd->intent.open.flags & O_ACCMODE) == O_RDONLY)
+		if ((nd->open.flags & O_ACCMODE) == O_RDONLY)
 			desiredAccess = GENERIC_READ;
-		else if ((nd->intent.open.flags & O_ACCMODE) == O_WRONLY) {
+		else if ((nd->open.flags & O_ACCMODE) == O_WRONLY) {
 			desiredAccess = GENERIC_WRITE;
 			write_only = TRUE;
-		} else if ((nd->intent.open.flags & O_ACCMODE) == O_RDWR) {
+		} else if ((nd->open.flags & O_ACCMODE) == O_RDWR) {
 			/* GENERIC_ALL is too much permission to request */
 			/* can cause unnecessary access denied on create */
 			/* desiredAccess = GENERIC_ALL; */
 			desiredAccess = GENERIC_READ | GENERIC_WRITE;
 		}
 
-		if((nd->intent.open.flags & (O_CREAT | O_EXCL)) == (O_CREAT | O_EXCL))
+		if((nd->open.flags & (O_CREAT | O_EXCL)) == (O_CREAT | O_EXCL))
 			disposition = FILE_CREATE;
-		else if((nd->intent.open.flags & (O_CREAT | O_TRUNC)) == (O_CREAT | O_TRUNC))
+		else if((nd->open.flags & (O_CREAT | O_TRUNC)) == (O_CREAT | O_TRUNC))
 			disposition = FILE_OVERWRITE_IF;
-		else if((nd->intent.open.flags & O_CREAT) == O_CREAT)
+		else if((nd->open.flags & O_CREAT) == O_CREAT)
 			disposition = FILE_OPEN_IF;
 		else {
 			cFYI(1,("Create flag not set in create function"));
@@ -400,7 +400,7 @@ cifs_lookup(struct inode *parent_dir_ino
 	      parent_dir_inode, direntry->d_name.name, direntry));
 
 	if(nd) {  /* BB removeme */
-		cFYI(1,("In lookup nd flags 0x%x open intent flags
0x%x",nd->flags,nd->intent.open.flags));
+		cFYI(1,("In lookup nd flags 0x%x open intent flags
0x%x",nd->flags,nd->open.flags));
 	} /* BB removeme BB */
 	/* BB Add check of incoming data - e.g. frame not longer than
maximum SMB - let server check the namelen BB */
 
diff -uprN -X dontdiff linux-2.6.9/fs/exec.c tmp-2.6.9/fs/exec.c
--- linux-2.6.9/fs/exec.c	2004-10-19 03:23:51.000000000 +0530
+++ tmp-2.6.9/fs/exec.c	2004-10-21 16:02:16.000000000 +0530
@@ -121,7 +121,7 @@ asmlinkage long sys_uselib(const char __
 	struct nameidata nd;
 	int error;
 
-	nd.intent.open.flags = FMODE_READ;
+	nd.open.flags = FMODE_READ;
 	error = __user_walk(library, LOOKUP_FOLLOW|LOOKUP_OPEN, &nd);
 	if (error)
 		goto out;
@@ -474,7 +474,7 @@ struct file *open_exec(const char *name)
 	int err;
 	struct file *file;
 
-	nd.intent.open.flags = FMODE_READ;
+	nd.open.flags = FMODE_READ;
 	err = path_lookup(name, LOOKUP_FOLLOW|LOOKUP_OPEN, &nd);
 	file = ERR_PTR(err);
 
diff -uprN -X dontdiff linux-2.6.9/fs/namei.c tmp-2.6.9/fs/namei.c
--- linux-2.6.9/fs/namei.c	2004-10-19 03:23:46.000000000 +0530
+++ tmp-2.6.9/fs/namei.c	2004-10-21 16:01:30.000000000 +0530
@@ -1339,8 +1339,8 @@ int open_namei(const char * pathname, in
 		acc_mode |= MAY_APPEND;
 
 	/* Fill in the open() intent data */
-	nd->intent.open.flags = flag;
-	nd->intent.open.create_mode = mode;
+	nd->open.flags = flag;
+	nd->open.create_mode = mode;
 
 	/*
 	 * The simplest case - just a plain lookup.
diff -uprN -X dontdiff linux-2.6.9/fs/nfs/dir.c tmp-2.6.9/fs/nfs/dir.c
--- linux-2.6.9/fs/nfs/dir.c	2004-10-19 03:24:08.000000000 +0530
+++ tmp-2.6.9/fs/nfs/dir.c	2004-10-21 15:57:01.000000000 +0530
@@ -718,7 +718,7 @@ int nfs_is_exclusive_create(struct inode
 		return 0;
 	if (!nd || (nd->flags & LOOKUP_CONTINUE) || !(nd->flags & LOOKUP_CREATE))
 		return 0;
-	return (nd->intent.open.flags & O_EXCL) != 0;
+	return (nd->open.flags & O_EXCL) != 0;
 }
 
 static struct dentry *nfs_lookup(struct inode *dir, struct dentry *
dentry, struct nameidata *nd)
@@ -791,7 +791,7 @@ static int is_atomic_open(struct inode *
 	if (nd->flags & LOOKUP_DIRECTORY)
 		return 0;
 	/* Are we trying to write to a read only partition? */
-	if (IS_RDONLY(dir) && (nd->intent.open.flags & (O_CREAT|O_TRUNC|FMODE_WRITE)))
+	if (IS_RDONLY(dir) && (nd->open.flags & (O_CREAT|O_TRUNC|FMODE_WRITE)))
 		return 0;
 	return 1;
 }
@@ -812,7 +812,7 @@ static struct dentry *nfs_atomic_lookup(
 	dentry->d_op = NFS_PROTO(dir)->dentry_ops;
 
 	/* Let vfs_create() deal with O_EXCL */
-	if (nd->intent.open.flags & O_EXCL)
+	if (nd->open.flags & O_EXCL)
 		goto no_entry;
 
 	/* Open the file on the server */
@@ -820,7 +820,7 @@ static struct dentry *nfs_atomic_lookup(
 	/* Revalidate parent directory attribute cache */
 	nfs_revalidate_inode(NFS_SERVER(dir), dir);
 
-	if (nd->intent.open.flags & O_CREAT) {
+	if (nd->open.flags & O_CREAT) {
 		nfs_begin_data_update(dir);
 		inode = nfs4_atomic_open(dir, dentry, nd);
 		nfs_end_data_update(dir);
@@ -836,7 +836,7 @@ static struct dentry *nfs_atomic_lookup(
 				break;
 			/* This turned out not to be a regular file */
 			case -ELOOP:
-				if (!(nd->intent.open.flags & O_NOFOLLOW))
+				if (!(nd->open.flags & O_NOFOLLOW))
 					goto no_open;
 			/* case -EISDIR: */
 			/* case -EINVAL: */
@@ -875,7 +875,7 @@ static int nfs_open_revalidate(struct de
 	/* NFS only supports OPEN on regular files */
 	if (!S_ISREG(inode->i_mode))
 		goto no_open;
-	openflags = nd->intent.open.flags;
+	openflags = nd->open.flags;
 	/* We cannot do exclusive creation on a positive dentry */
 	if ((openflags & (O_CREAT|O_EXCL)) == (O_CREAT|O_EXCL))
 		goto no_open;
@@ -1043,7 +1043,7 @@ static int nfs_create(struct inode *dir,
 	attr.ia_valid = ATTR_MODE;
 
 	if (nd && (nd->flags & LOOKUP_CREATE))
-		open_flags = nd->intent.open.flags;
+		open_flags = nd->open.flags;
 
 	/*
 	 * The 0 argument passed into the create function should one day
diff -uprN -X dontdiff linux-2.6.9/fs/nfs/nfs4proc.c tmp-2.6.9/fs/nfs/nfs4proc.c
--- linux-2.6.9/fs/nfs/nfs4proc.c	2004-10-19 03:24:40.000000000 +0530
+++ tmp-2.6.9/fs/nfs/nfs4proc.c	2004-10-21 15:58:24.000000000 +0530
@@ -775,17 +775,17 @@ nfs4_atomic_open(struct inode *dir, stru
 	struct nfs4_state *state;
 
 	if (nd->flags & LOOKUP_CREATE) {
-		attr.ia_mode = nd->intent.open.create_mode;
+		attr.ia_mode = nd->open.create_mode;
 		attr.ia_valid = ATTR_MODE;
 		if (!IS_POSIXACL(dir))
 			attr.ia_mode &= ~current->fs->umask;
 	} else {
 		attr.ia_valid = 0;
-		BUG_ON(nd->intent.open.flags & O_CREAT);
+		BUG_ON(nd->open.flags & O_CREAT);
 	}
 
 	cred = rpcauth_lookupcred(NFS_SERVER(dir)->client->cl_auth, 0);
-	state = nfs4_do_open(dir, &dentry->d_name, nd->intent.open.flags,
&attr, cred);
+	state = nfs4_do_open(dir, &dentry->d_name, nd->open.flags, &attr, cred);
 	put_rpccred(cred);
 	if (IS_ERR(state))
 		return (struct inode *)state;
diff -uprN -X dontdiff linux-2.6.9/include/linux/namei.h
tmp-2.6.9/include/linux/namei.h
--- linux-2.6.9/include/linux/namei.h	2004-10-19 03:23:46.000000000 +0530
+++ tmp-2.6.9/include/linux/namei.h	2004-10-21 16:14:04.000000000 +0530
@@ -22,9 +22,7 @@ struct nameidata {
 	char *saved_names[MAX_NESTED_LINKS + 1];
 
 	/* Intent data */
-	union {
-		struct open_intent open;
-	} intent;
+	struct open_intent open;
 };
 
 /*
