Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263507AbUJ2WnJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263507AbUJ2WnJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 18:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263537AbUJ2WV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 18:21:26 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:58636 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S263595AbUJ2V7b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 17:59:31 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Arjan van de Ven <arjan@infradead.org>,
       Andreas Dilger <adilger@clusterfs.com>
Subject: [PATCH] reduce stack usage of NFS (was Re: How to safely reduce...)
Date: Sat, 30 Oct 2004 00:59:06 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <200410290020.01400.vda@port.imtp.ilyichevsk.odessa.ua> <1099040501.2641.9.camel@laptop.fenrus.org> <1099059626.11099.10.camel@dh138.citi.umich.edu>
In-Reply-To: <1099059626.11099.10.camel@dh138.citi.umich.edu>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_q0rgBP4ODrzHf3w"
Message-Id: <200410300059.06497.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_q0rgBP4ODrzHf3w
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

> > > I can convert these into kmalloc'ed variants but hesitate to do so
> > > because of possible 'need to kmalloc in order to free memory for kmalloc'
> > > deadlocks.
> > 
> > how about a memory pool?
> > 
> > It's not THE solution but I suspect the depth of callchains of these isn't too deep so it would work
> 
> I can't see that any of the callchains Denis listed can deadlock. None
> of them appear to lie in the memory reclaim paths.

This patch reduces stack usage to below 100 bytes for
the following functions:

                       stack usage in 2.6.9
nfs3_proc_create:             544
_nfs4_do_open:                516
nfs_readdir:                  412
nfs_symlink:                  368
_nfs4_open_delegation_recall: 368
nfs3_proc_rename:             364
_nfs4_open_reclaim:           364
nfs_mknod:                    352
nfs_mkdir:                    352
nfs_proc_create:              344
nfs3_proc_link:               328
nfs_lookup_revalidate:        312
nfs_lookup:                   292

(btw: in function nfs_readdir: local variable 'desc' seem to be
easily replaceable with &my_desc, or am I missing something?)

Compile tested only. I can't run test it until next Wednesday :(

Please review, especially for leaks on error paths.
--
vda

--Boundary-00=_q0rgBP4ODrzHf3w
Content-Type: text/x-diff;
  charset="koi8-r";
  name="nfs269.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="nfs269.patch"

diff -urpN linux-2.6.9-org.src/fs/nfs/dir.c linux-2.6.9.src/fs/nfs/dir.c
--- linux-2.6.9-org.src/fs/nfs/dir.c	Tue Oct 19 00:54:08 2004
+++ linux-2.6.9.src/fs/nfs/dir.c	Sat Oct 30 00:43:59 2004
@@ -423,18 +423,27 @@ static int nfs_readdir(struct file *filp
 {
 	struct dentry	*dentry = filp->f_dentry;
 	struct inode	*inode = dentry->d_inode;
-	nfs_readdir_descriptor_t my_desc,
-			*desc = &my_desc;
-	struct nfs_entry my_entry;
-	struct nfs_fh	 fh;
-	struct nfs_fattr fattr;
-	long		res;
+	nfs_readdir_descriptor_t *desc;
+	struct {
+		struct nfs_entry my_entry;
+		struct nfs_fh	 fh;
+		struct nfs_fattr fattr;
+		nfs_readdir_descriptor_t my_desc;
+	} *loc;
+	long res;
+
+	loc = kmalloc(sizeof(*loc), GFP_KERNEL);
+	if (!loc)
+		return -ENOMEM;
+
+	desc = &loc->my_desc;
 
 	lock_kernel();
 
 	res = nfs_revalidate_inode(NFS_SERVER(inode), inode);
 	if (res < 0) {
 		unlock_kernel();
+		kfree(loc);
 		return res;
 	}
 
@@ -451,11 +460,11 @@ static int nfs_readdir(struct file *filp
 	desc->decode = NFS_PROTO(inode)->decode_dirent;
 	desc->plus = NFS_USE_READDIRPLUS(inode);
 
-	my_entry.cookie = my_entry.prev_cookie = 0;
-	my_entry.eof = 0;
-	my_entry.fh = &fh;
-	my_entry.fattr = &fattr;
-	desc->entry = &my_entry;
+	loc->my_entry.cookie = loc->my_entry.prev_cookie = 0;
+	loc->my_entry.eof = 0;
+	loc->my_entry.fh = &loc->fh;
+	loc->my_entry.fattr = &loc->fattr;
+	desc->entry = &loc->my_entry;
 
 	while(!desc->entry->eof) {
 		res = readdir_search_pagecache(desc);
@@ -488,10 +497,11 @@ static int nfs_readdir(struct file *filp
 	}
 	unlock_kernel();
 	if (desc->error < 0)
-		return desc->error;
-	if (res < 0)
-		return res;
-	return 0;
+		res = desc->error;
+	kfree(loc);
+	if (res > 0)
+		res = 0;
+	return res;
 }
 
 /*
@@ -576,15 +586,21 @@ int nfs_neg_need_reval(struct inode *dir
  */
 static int nfs_lookup_revalidate(struct dentry * dentry, struct nameidata *nd)
 {
+	struct {
+		struct nfs_fh fhandle;
+		struct nfs_fattr fattr;
+	} *loc;
 	struct inode *dir;
 	struct inode *inode;
 	struct dentry *parent;
 	int error;
-	struct nfs_fh fhandle;
-	struct nfs_fattr fattr;
 	unsigned long verifier;
 	int isopen = 0;
 
+	loc = kmalloc(sizeof(*loc), GFP_KERNEL);
+	if (!loc)
+		return -ENOMEM;
+
 	parent = dget_parent(dentry);
 	lock_kernel();
 	dir = parent->d_inode;
@@ -621,9 +637,9 @@ static int nfs_lookup_revalidate(struct 
 	 * change attribute *before* we do the RPC call.
 	 */
 	verifier = nfs_save_change_attribute(dir);
-	error = nfs_cached_lookup(dir, dentry, &fhandle, &fattr);
+	error = nfs_cached_lookup(dir, dentry, &loc->fhandle, &loc->fattr);
 	if (!error) {
-		if (nfs_compare_fh(NFS_FH(inode), &fhandle))
+		if (nfs_compare_fh(NFS_FH(inode), &loc->fhandle))
 			goto out_bad;
 		if (nfs_lookup_verify_inode(inode, isopen))
 			goto out_zap_parent;
@@ -633,12 +649,12 @@ static int nfs_lookup_revalidate(struct 
 	if (NFS_STALE(inode))
 		goto out_bad;
 
-	error = NFS_PROTO(dir)->lookup(dir, &dentry->d_name, &fhandle, &fattr);
+	error = NFS_PROTO(dir)->lookup(dir, &dentry->d_name, &loc->fhandle, &loc->fattr);
 	if (error)
 		goto out_bad;
-	if (nfs_compare_fh(NFS_FH(inode), &fhandle))
+	if (nfs_compare_fh(NFS_FH(inode), &loc->fhandle))
 		goto out_bad;
-	if ((error = nfs_refresh_inode(inode, &fattr)) != 0)
+	if ((error = nfs_refresh_inode(inode, &loc->fattr)) != 0)
 		goto out_bad;
 
  out_valid_renew:
@@ -647,7 +663,9 @@ static int nfs_lookup_revalidate(struct 
  out_valid:
 	unlock_kernel();
 	dput(parent);
+	kfree(loc);
 	return 1;
+
 out_zap_parent:
 	nfs_zap_caches(dir);
  out_bad:
@@ -663,6 +681,7 @@ out_zap_parent:
 	d_drop(dentry);
 	unlock_kernel();
 	dput(parent);
+	kfree(loc);
 	return 0;
 }
 
@@ -725,8 +744,14 @@ static struct dentry *nfs_lookup(struct 
 {
 	struct inode *inode = NULL;
 	int error;
-	struct nfs_fh fhandle;
-	struct nfs_fattr fattr;
+	struct {
+		struct nfs_fh fhandle;
+		struct nfs_fattr fattr;
+	} *loc;
+
+	loc = kmalloc(sizeof(*loc), GFP_KERNEL);
+	if (!loc)
+		return ERR_PTR(-ENOMEM);
 
 	dfprintk(VFS, "NFS: lookup(%s/%s)\n",
 		dentry->d_parent->d_name.name, dentry->d_name.name);
@@ -746,17 +771,17 @@ static struct dentry *nfs_lookup(struct 
 	if (nfs_is_exclusive_create(dir, nd))
 		goto no_entry;
 
-	error = nfs_cached_lookup(dir, dentry, &fhandle, &fattr);
+	error = nfs_cached_lookup(dir, dentry, &loc->fhandle, &loc->fattr);
 	if (error != 0) {
 		error = NFS_PROTO(dir)->lookup(dir, &dentry->d_name,
-				&fhandle, &fattr);
+				&loc->fhandle, &loc->fattr);
 		if (error == -ENOENT)
 			goto no_entry;
 		if (error != 0)
 			goto out_unlock;
 	}
 	error = -EACCES;
-	inode = nfs_fhget(dentry->d_sb, &fhandle, &fattr);
+	inode = nfs_fhget(dentry->d_sb, &loc->fhandle, &loc->fattr);
 	if (!inode)
 		goto out_unlock;
 no_entry:
@@ -767,6 +792,7 @@ no_entry:
 out_unlock:
 	unlock_kernel();
 out:
+	kfree(loc);
 	BUG_ON(error > 0);
 	return ERR_PTR(error);
 }
@@ -1074,9 +1100,11 @@ static int nfs_create(struct inode *dir,
 static int
 nfs_mknod(struct inode *dir, struct dentry *dentry, int mode, dev_t rdev)
 {
-	struct iattr attr;
-	struct nfs_fattr fattr;
-	struct nfs_fh fhandle;
+	struct{
+		struct iattr attr;
+		struct nfs_fattr fattr;
+		struct nfs_fh fhandle;
+	} *loc;
 	int error;
 
 	dfprintk(VFS, "NFS: mknod(%s/%ld, %s\n", dir->i_sb->s_id,
@@ -1085,19 +1113,24 @@ nfs_mknod(struct inode *dir, struct dent
 	if (!new_valid_dev(rdev))
 		return -EINVAL;
 
-	attr.ia_mode = mode;
-	attr.ia_valid = ATTR_MODE;
+	loc = kmalloc(sizeof(*loc), GFP_KERNEL);
+	if (!loc)
+		return -ENOMEM;
+
+	loc->attr.ia_mode = mode;
+	loc->attr.ia_valid = ATTR_MODE;
 
 	lock_kernel();
 	nfs_begin_data_update(dir);
-	error = NFS_PROTO(dir)->mknod(dir, &dentry->d_name, &attr, rdev,
-					&fhandle, &fattr);
+	error = NFS_PROTO(dir)->mknod(dir, &dentry->d_name, &loc->attr, rdev,
+					&loc->fhandle, &loc->fattr);
 	nfs_end_data_update(dir);
 	if (!error)
-		error = nfs_instantiate(dentry, &fhandle, &fattr);
+		error = nfs_instantiate(dentry, &loc->fhandle, &loc->fattr);
 	else
 		d_drop(dentry);
 	unlock_kernel();
+	kfree(loc);
 	return error;
 }
 
@@ -1106,16 +1139,22 @@ nfs_mknod(struct inode *dir, struct dent
  */
 static int nfs_mkdir(struct inode *dir, struct dentry *dentry, int mode)
 {
-	struct iattr attr;
-	struct nfs_fattr fattr;
-	struct nfs_fh fhandle;
+	struct{
+		struct iattr attr;
+		struct nfs_fattr fattr;
+		struct nfs_fh fhandle;
+	} *loc;
 	int error;
 
+	loc = kmalloc(sizeof(*loc), GFP_KERNEL);
+	if (!loc)
+		return -ENOMEM;
+
 	dfprintk(VFS, "NFS: mkdir(%s/%ld, %s\n", dir->i_sb->s_id,
 		dir->i_ino, dentry->d_name.name);
 
-	attr.ia_valid = ATTR_MODE;
-	attr.ia_mode = mode | S_IFDIR;
+	loc->attr.ia_valid = ATTR_MODE;
+	loc->attr.ia_mode = mode | S_IFDIR;
 
 	lock_kernel();
 #if 0
@@ -1128,14 +1167,15 @@ static int nfs_mkdir(struct inode *dir, 
 	d_drop(dentry);
 #endif
 	nfs_begin_data_update(dir);
-	error = NFS_PROTO(dir)->mkdir(dir, &dentry->d_name, &attr, &fhandle,
-					&fattr);
+	error = NFS_PROTO(dir)->mkdir(dir, &dentry->d_name, &loc->attr, &loc->fhandle,
+					&loc->fattr);
 	nfs_end_data_update(dir);
 	if (!error)
-		error = nfs_instantiate(dentry, &fhandle, &fattr);
+		error = nfs_instantiate(dentry, &loc->fhandle, &loc->fattr);
 	else
 		d_drop(dentry);
 	unlock_kernel();
+	kfree(loc);
 	return error;
 }
 
@@ -1311,12 +1351,18 @@ static int nfs_unlink(struct inode *dir,
 static int
 nfs_symlink(struct inode *dir, struct dentry *dentry, const char *symname)
 {
-	struct iattr attr;
-	struct nfs_fattr sym_attr;
-	struct nfs_fh sym_fh;
-	struct qstr qsymname;
+	struct {
+		struct iattr attr;
+		struct nfs_fattr sym_attr;
+		struct nfs_fh sym_fh;
+		struct qstr qsymname;
+	} *loc;
 	int error;
 
+	loc = kmalloc(sizeof(*loc), GFP_KERNEL);
+	if (!loc)
+		return -ENOMEM;
+
 	dfprintk(VFS, "NFS: symlink(%s/%ld, %s, %s)\n", dir->i_sb->s_id,
 		dir->i_ino, dentry->d_name.name, symname);
 
@@ -1329,19 +1375,19 @@ dentry->d_parent->d_name.name, dentry->d
 	 * Fill in the sattr for the call.
  	 * Note: SunOS 4.1.2 crashes if the mode isn't initialized!
 	 */
-	attr.ia_valid = ATTR_MODE;
-	attr.ia_mode = S_IFLNK | S_IRWXUGO;
+	loc->attr.ia_valid = ATTR_MODE;
+	loc->attr.ia_mode = S_IFLNK | S_IRWXUGO;
 
-	qsymname.name = symname;
-	qsymname.len  = strlen(symname);
+	loc->qsymname.name = symname;
+	loc->qsymname.len  = strlen(symname);
 
 	lock_kernel();
 	nfs_begin_data_update(dir);
-	error = NFS_PROTO(dir)->symlink(dir, &dentry->d_name, &qsymname,
-					  &attr, &sym_fh, &sym_attr);
+	error = NFS_PROTO(dir)->symlink(dir, &dentry->d_name, &loc->qsymname,
+				&loc->attr, &loc->sym_fh, &loc->sym_attr);
 	nfs_end_data_update(dir);
 	if (!error) {
-		error = nfs_instantiate(dentry, &sym_fh, &sym_attr);
+		error = nfs_instantiate(dentry, &loc->sym_fh, &loc->sym_attr);
 	} else {
 		if (error == -EEXIST)
 			printk("nfs_proc_symlink: %s/%s already exists??\n",
@@ -1349,6 +1395,7 @@ dentry->d_parent->d_name.name, dentry->d
 		d_drop(dentry);
 	}
 	unlock_kernel();
+	kfree(loc);
 	return error;
 }
 
diff -urpN linux-2.6.9-org.src/fs/nfs/nfs3proc.c linux-2.6.9.src/fs/nfs/nfs3proc.c
--- linux-2.6.9-org.src/fs/nfs/nfs3proc.c	Tue Oct 19 00:54:08 2004
+++ linux-2.6.9.src/fs/nfs/nfs3proc.c	Sat Oct 30 00:44:14 2004
@@ -299,46 +299,52 @@ static struct inode *
 nfs3_proc_create(struct inode *dir, struct qstr *name, struct iattr *sattr,
 		 int flags)
 {
-	struct nfs_fh		fhandle;
-	struct nfs_fattr	fattr;
-	struct nfs_fattr	dir_attr;
-	struct nfs3_createargs	arg = {
-		.fh		= NFS_FH(dir),
-		.name		= name->name,
-		.len		= name->len,
-		.sattr		= sattr,
-	};
-	struct nfs3_diropres	res = {
-		.dir_attr	= &dir_attr,
-		.fh		= &fhandle,
-		.fattr		= &fattr
-	};
-	int			status;
+	struct {
+		struct nfs_fh		fhandle;
+		struct nfs_fattr	fattr;
+		struct nfs_fattr	dir_attr;
+		struct nfs3_createargs	arg;
+		struct nfs3_diropres	res;
+	} *loc;
+	int status;
+
+	loc = kmalloc(sizeof(*loc), GFP_KERNEL);
+	if (!loc)
+		return ERR_PTR(-ENOMEM);
+		
+	loc->arg.fh		= NFS_FH(dir);
+	loc->arg.name		= name->name;
+	loc->arg.len		= name->len;
+	loc->arg.sattr		= sattr;
+	loc->arg.createmode	= NFS3_CREATE_UNCHECKED;
+	
+	loc->res.dir_attr	= &loc->dir_attr;
+	loc->res.fh		= &loc->fhandle;
+	loc->res.fattr		= &loc->fattr;
 
 	dprintk("NFS call  create %s\n", name->name);
-	arg.createmode = NFS3_CREATE_UNCHECKED;
 	if (flags & O_EXCL) {
-		arg.createmode  = NFS3_CREATE_EXCLUSIVE;
-		arg.verifier[0] = jiffies;
-		arg.verifier[1] = current->pid;
+		loc->arg.createmode  = NFS3_CREATE_EXCLUSIVE;
+		loc->arg.verifier[0] = jiffies;
+		loc->arg.verifier[1] = current->pid;
 	}
 
 again:
-	dir_attr.valid = 0;
-	fattr.valid = 0;
-	status = rpc_call(NFS_CLIENT(dir), NFS3PROC_CREATE, &arg, &res, 0);
-	nfs_refresh_inode(dir, &dir_attr);
+	loc->dir_attr.valid = 0;
+	loc->fattr.valid = 0;
+	status = rpc_call(NFS_CLIENT(dir), NFS3PROC_CREATE, &loc->arg, &loc->res, 0);
+	nfs_refresh_inode(dir, &loc->dir_attr);
 
 	/* If the server doesn't support the exclusive creation semantics,
 	 * try again with simple 'guarded' mode. */
 	if (status == NFSERR_NOTSUPP) {
-		switch (arg.createmode) {
+		switch (loc->arg.createmode) {
 			case NFS3_CREATE_EXCLUSIVE:
-				arg.createmode = NFS3_CREATE_GUARDED;
+				loc->arg.createmode = NFS3_CREATE_GUARDED;
 				break;
 
 			case NFS3_CREATE_GUARDED:
-				arg.createmode = NFS3_CREATE_UNCHECKED;
+				loc->arg.createmode = NFS3_CREATE_UNCHECKED;
 				break;
 
 			case NFS3_CREATE_UNCHECKED:
@@ -352,20 +358,20 @@ exit:
 
 	if (status != 0)
 		goto out;
-	if (fhandle.size == 0 || !(fattr.valid & NFS_ATTR_FATTR)) {
-		status = nfs3_proc_lookup(dir, name, &fhandle, &fattr);
+	if (loc->fhandle.size == 0 || !(loc->fattr.valid & NFS_ATTR_FATTR)) {
+		status = nfs3_proc_lookup(dir, name, &loc->fhandle, &loc->fattr);
 		if (status != 0)
 			goto out;
 	}
 
 	/* When we created the file with exclusive semantics, make
 	 * sure we set the attributes afterwards. */
-	if (arg.createmode == NFS3_CREATE_EXCLUSIVE) {
+	if (loc->arg.createmode == NFS3_CREATE_EXCLUSIVE) {
 		struct nfs3_sattrargs	arg = {
-			.fh		= &fhandle,
+			.fh		= &loc->fhandle,
 			.sattr		= sattr,
 		};
-		dprintk("NFS call  setattr (post-create)\n");
+		dprintk("NFS call setattr (post-create)\n");
 
 		if (!(sattr->ia_valid & ATTR_ATIME_SET))
 			sattr->ia_valid |= ATTR_ATIME;
@@ -375,19 +381,22 @@ exit:
 		/* Note: we could use a guarded setattr here, but I'm
 		 * not sure this buys us anything (and I'd have
 		 * to revamp the NFSv3 XDR code) */
-		fattr.valid = 0;
+		loc->fattr.valid = 0;
 		status = rpc_call(NFS_CLIENT(dir), NFS3PROC_SETATTR,
-						&arg, &fattr, 0);
+						&arg, &loc->fattr, 0);
 		dprintk("NFS reply setattr (post-create): %d\n", status);
 	}
 	if (status == 0) {
 		struct inode *inode;
-		inode = nfs_fhget(dir->i_sb, &fhandle, &fattr);
-		if (inode)
+		inode = nfs_fhget(dir->i_sb, &loc->fhandle, &loc->fattr);
+		if (inode) {
+			kfree(loc);
 			return inode;
+		}
 		status = -ENOMEM;
 	}
 out:
+	kfree(loc);
 	return ERR_PTR(status);
 }
 
@@ -456,27 +465,35 @@ static int
 nfs3_proc_rename(struct inode *old_dir, struct qstr *old_name,
 		 struct inode *new_dir, struct qstr *new_name)
 {
-	struct nfs_fattr	old_dir_attr, new_dir_attr;
-	struct nfs3_renameargs	arg = {
-		.fromfh		= NFS_FH(old_dir),
-		.fromname	= old_name->name,
-		.fromlen	= old_name->len,
-		.tofh		= NFS_FH(new_dir),
-		.toname		= new_name->name,
-		.tolen		= new_name->len
-	};
-	struct nfs3_renameres	res = {
-		.fromattr	= &old_dir_attr,
-		.toattr		= &new_dir_attr
-	};
-	int			status;
+	struct {
+		struct nfs_fattr old_dir_attr, new_dir_attr;
+		struct nfs3_renameargs arg;
+		struct nfs3_renameres res;
+	} *loc;
+	int status;
+
+	loc = kmalloc(sizeof(*loc), GFP_KERNEL);
+	if (!loc)
+		return -ENOMEM;
+
+	loc->arg.fromfh		= NFS_FH(old_dir);
+	loc->arg.fromname	= old_name->name;
+	loc->arg.fromlen	= old_name->len;
+	loc->arg.tofh		= NFS_FH(new_dir);
+	loc->arg.toname		= new_name->name;
+	loc->arg.tolen		= new_name->len;
+
+	loc->res.fromattr	= &loc->old_dir_attr;
+	loc->res.toattr		= &loc->new_dir_attr;
 
 	dprintk("NFS call  rename %s -> %s\n", old_name->name, new_name->name);
-	old_dir_attr.valid = 0;
-	new_dir_attr.valid = 0;
-	status = rpc_call(NFS_CLIENT(old_dir), NFS3PROC_RENAME, &arg, &res, 0);
-	nfs_refresh_inode(old_dir, &old_dir_attr);
-	nfs_refresh_inode(new_dir, &new_dir_attr);
+	loc->old_dir_attr.valid = 0;
+	loc->new_dir_attr.valid = 0;
+	status = rpc_call(NFS_CLIENT(old_dir), NFS3PROC_RENAME,
+				&loc->arg, &loc->res, 0);
+	nfs_refresh_inode(old_dir, &loc->old_dir_attr);
+	nfs_refresh_inode(new_dir, &loc->new_dir_attr);
+	kfree(loc);
 	dprintk("NFS reply rename: %d\n", status);
 	return status;
 }
@@ -484,25 +501,32 @@ nfs3_proc_rename(struct inode *old_dir, 
 static int
 nfs3_proc_link(struct inode *inode, struct inode *dir, struct qstr *name)
 {
-	struct nfs_fattr	dir_attr, fattr;
-	struct nfs3_linkargs	arg = {
-		.fromfh		= NFS_FH(inode),
-		.tofh		= NFS_FH(dir),
-		.toname		= name->name,
-		.tolen		= name->len
-	};
-	struct nfs3_linkres	res = {
-		.dir_attr	= &dir_attr,
-		.fattr		= &fattr
-	};
-	int			status;
+	struct {
+		struct nfs_fattr dir_attr, fattr;
+		struct nfs3_linkargs arg;
+		struct nfs3_linkres res;
+	} *loc;
+	int status;
+
+	loc = kmalloc(sizeof(*loc), GFP_KERNEL);
+	if (!loc)
+		return -ENOMEM;
+
+	loc->arg.fromfh		= NFS_FH(inode);
+	loc->arg.tofh		= NFS_FH(dir);
+	loc->arg.toname		= name->name;
+	loc->arg.tolen		= name->len;
+
+	loc->res.dir_attr	= &loc->dir_attr;
+	loc->res.fattr		= &loc->fattr;
 
 	dprintk("NFS call  link %s\n", name->name);
-	dir_attr.valid = 0;
-	fattr.valid = 0;
-	status = rpc_call(NFS_CLIENT(inode), NFS3PROC_LINK, &arg, &res, 0);
-	nfs_refresh_inode(dir, &dir_attr);
-	nfs_refresh_inode(inode, &fattr);
+	loc->dir_attr.valid = 0;
+	loc->fattr.valid = 0;
+	status = rpc_call(NFS_CLIENT(inode), NFS3PROC_LINK, &loc->arg, &loc->res, 0);
+	nfs_refresh_inode(dir, &loc->dir_attr);
+	nfs_refresh_inode(inode, &loc->fattr);
+	kfree(loc);
 	dprintk("NFS reply link: %d\n", status);
 	return status;
 }
diff -urpN linux-2.6.9-org.src/fs/nfs/nfs4proc.c linux-2.6.9.src/fs/nfs/nfs4proc.c
--- linux-2.6.9-org.src/fs/nfs/nfs4proc.c	Tue Oct 19 00:54:40 2004
+++ linux-2.6.9.src/fs/nfs/nfs4proc.c	Sat Oct 30 00:44:25 2004
@@ -198,46 +198,55 @@ static int _nfs4_open_reclaim(struct nfs
 	struct inode *inode = state->inode;
 	struct nfs_server *server = NFS_SERVER(inode);
 	struct nfs_delegation *delegation = NFS_I(inode)->delegation;
-	struct nfs_openargs o_arg = {
-		.fh = NFS_FH(inode),
-		.seqid = sp->so_seqid,
-		.id = sp->so_id,
-		.open_flags = state->state,
-		.clientid = server->nfs4_state->cl_clientid,
-		.claim = NFS4_OPEN_CLAIM_PREVIOUS,
-		.bitmask = server->attr_bitmask,
-	};
-	struct nfs_openres o_res = {
-		.server = server,	/* Grrr */
-	};
-	struct rpc_message msg = {
-		.rpc_proc       = &nfs4_procedures[NFSPROC4_CLNT_OPEN_NOATTR],
-		.rpc_argp       = &o_arg,
-		.rpc_resp	= &o_res,
-		.rpc_cred	= sp->so_cred,
-	};
+
+	struct {
+		struct nfs_openargs o_arg;
+		struct nfs_openres o_res;
+		struct rpc_message msg;
+	} *loc;
 	int status;
 
+	loc = kmalloc(sizeof(*loc), GFP_KERNEL);
+	if (!loc)
+		return -ENOMEM;
+
+	loc->o_arg.fh = NFS_FH(inode);
+	loc->o_arg.seqid = sp->so_seqid;
+	loc->o_arg.id = sp->so_id;
+	loc->o_arg.open_flags = state->state;
+	loc->o_arg.clientid = server->nfs4_state->cl_clientid;
+	loc->o_arg.claim = NFS4_OPEN_CLAIM_PREVIOUS;
+	loc->o_arg.bitmask = server->attr_bitmask;
+
+	loc->o_res.server = server;	/* Grrr */
+
+	loc->msg.rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_OPEN_NOATTR];
+	loc->msg.rpc_argp = &loc->o_arg;
+	loc->msg.rpc_resp = &loc->o_res;
+	loc->msg.rpc_cred = sp->so_cred;
+
 	if (delegation != NULL) {
 		if (!(delegation->flags & NFS_DELEGATION_NEED_RECLAIM)) {
 			memcpy(&state->stateid, &delegation->stateid,
 					sizeof(state->stateid));
 			set_bit(NFS_DELEGATED_STATE, &state->flags);
+			kfree(loc);
 			return 0;
 		}
-		o_arg.u.delegation_type = delegation->type;
+		loc->o_arg.u.delegation_type = delegation->type;
 	}
-	status = rpc_call_sync(server->client, &msg, RPC_TASK_NOINTR);
+	status = rpc_call_sync(server->client, &loc->msg, RPC_TASK_NOINTR);
 	nfs4_increment_seqid(status, sp);
 	if (status == 0) {
-		memcpy(&state->stateid, &o_res.stateid, sizeof(state->stateid));
-		if (o_res.delegation_type != 0) {
-			nfs_inode_reclaim_delegation(inode, sp->so_cred, &o_res);
+		memcpy(&state->stateid, &loc->o_res.stateid, sizeof(state->stateid));
+		if (loc->o_res.delegation_type != 0) {
+			nfs_inode_reclaim_delegation(inode, sp->so_cred, &loc->o_res);
 			/* Did the server issue an immediate delegation recall? */
-			if (o_res.do_recall)
-				nfs_async_inode_return_delegation(inode, &o_res.stateid);
+			if (loc->o_res.do_recall)
+				nfs_async_inode_return_delegation(inode, &loc->o_res.stateid);
 		}
 	}
+	kfree(loc);
 	clear_bit(NFS_DELEGATED_STATE, &state->flags);
 	/* Ensure we update the inode attributes */
 	NFS_CACHEINV(inode);
@@ -265,47 +274,58 @@ int nfs4_open_reclaim(struct nfs4_state_
 
 static int _nfs4_open_delegation_recall(struct dentry *dentry, struct nfs4_state *state)
 {
-	struct nfs4_state_owner  *sp  = state->owner;
+	struct nfs4_state_owner *sp = state->owner;
 	struct inode *inode = dentry->d_inode;
 	struct nfs_server *server = NFS_SERVER(inode);
-	struct dentry *parent = dget_parent(dentry);
-	struct nfs_openargs arg = {
-		.fh = NFS_FH(parent->d_inode),
-		.clientid = server->nfs4_state->cl_clientid,
-		.name = &dentry->d_name,
-		.id = sp->so_id,
-		.server = server,
-		.bitmask = server->attr_bitmask,
-		.claim = NFS4_OPEN_CLAIM_DELEGATE_CUR,
-	};
-	struct nfs_openres res = {
-		.server = server,
-	};
-	struct 	rpc_message msg = {
-		.rpc_proc       = &nfs4_procedures[NFSPROC4_CLNT_OPEN_NOATTR],
-		.rpc_argp       = &arg,
-		.rpc_resp       = &res,
-		.rpc_cred	= sp->so_cred,
-	};
+	struct dentry *parent;
+
+	struct {
+		struct nfs_openargs arg;
+		struct nfs_openres res;
+		struct 	rpc_message msg;
+	} *loc;
 	int status = 0;
 
+	loc = kmalloc(sizeof(*loc), GFP_KERNEL);
+	if (!loc)
+		return -ENOMEM;
+
+	parent = dget_parent(dentry);
+
+	loc->arg.fh = NFS_FH(parent->d_inode);
+	loc->arg.clientid = server->nfs4_state->cl_clientid;
+	loc->arg.name = &dentry->d_name;
+	loc->arg.id = sp->so_id;
+	loc->arg.server = server;
+	loc->arg.bitmask = server->attr_bitmask;
+	loc->arg.claim = NFS4_OPEN_CLAIM_DELEGATE_CUR;
+	
+	loc->res.server = server;
+	
+	loc->msg.rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_OPEN_NOATTR];
+	loc->msg.rpc_argp = &loc->arg;
+	loc->msg.rpc_resp = &loc->res;
+	loc->msg.rpc_cred = sp->so_cred,
+
 	down(&sp->so_sema);
 	if (!test_bit(NFS_DELEGATED_STATE, &state->flags))
 		goto out;
 	if (state->state == 0)
 		goto out;
-	arg.seqid = sp->so_seqid;
-	arg.open_flags = state->state;
-	memcpy(arg.u.delegation.data, state->stateid.data, sizeof(arg.u.delegation.data));
-	status = rpc_call_sync(server->client, &msg, RPC_TASK_NOINTR);
+	loc->arg.seqid = sp->so_seqid;
+	loc->arg.open_flags = state->state;
+	memcpy(loc->arg.u.delegation.data, state->stateid.data,
+				sizeof(loc->arg.u.delegation.data));
+	status = rpc_call_sync(server->client, &loc->msg, RPC_TASK_NOINTR);
 	nfs4_increment_seqid(status, sp);
 	if (status >= 0) {
-		memcpy(state->stateid.data, res.stateid.data,
+		memcpy(state->stateid.data, loc->res.stateid.data,
 				sizeof(state->stateid.data));
 		clear_bit(NFS_DELEGATED_STATE, &state->flags);
 	}
 out:
 	up(&sp->so_sema);
+	kfree(loc);
 	dput(parent);
 	return status;
 }
@@ -479,33 +499,40 @@ static struct nfs4_state *nfs4_open_dele
  */
 static int _nfs4_do_open(struct inode *dir, struct qstr *name, int flags, struct iattr *sattr, struct rpc_cred *cred, struct nfs4_state **res)
 {
-	struct nfs4_state_owner  *sp;
-	struct nfs4_state     *state = NULL;
-	struct nfs_server       *server = NFS_SERVER(dir);
+	struct nfs4_state_owner *sp;
+	struct nfs4_state *state = NULL;
+	struct nfs_server *server = NFS_SERVER(dir);
 	struct nfs4_client *clp = server->nfs4_state;
 	struct inode *inode = NULL;
-	int                     status;
-	struct nfs_fattr        f_attr = {
-		.valid          = 0,
-	};
-	struct nfs_openargs o_arg = {
-		.fh             = NFS_FH(dir),
-		.open_flags	= flags,
-		.name           = name,
-		.server         = server,
-		.bitmask = server->attr_bitmask,
-		.claim = NFS4_OPEN_CLAIM_NULL,
-	};
-	struct nfs_openres o_res = {
-		.f_attr         = &f_attr,
-		.server         = server,
-	};
-	struct rpc_message msg = {
-		.rpc_proc       = &nfs4_procedures[NFSPROC4_CLNT_OPEN],
-		.rpc_argp       = &o_arg,
-		.rpc_resp       = &o_res,
-		.rpc_cred	= cred,
-	};
+	int status;
+
+	struct {
+		struct nfs_fattr f_attr;
+		struct nfs_openargs o_arg;
+		struct nfs_openres o_res;
+		struct rpc_message msg;
+	} *loc;
+
+	loc = kmalloc(sizeof(*loc), GFP_KERNEL);
+	if (!loc)
+		return -ENOMEM;
+
+	loc->f_attr.valid       = 0;
+	
+	loc->o_arg.fh           = NFS_FH(dir);
+	loc->o_arg.open_flags	= flags;
+	loc->o_arg.name         = name;
+	loc->o_arg.server       = server;
+	loc->o_arg.bitmask      = server->attr_bitmask;
+	loc->o_arg.claim        = NFS4_OPEN_CLAIM_NULL;
+	
+	loc->o_res.f_attr       = &loc->f_attr;
+	loc->o_res.server       = server;
+	
+	loc->msg.rpc_proc       = &nfs4_procedures[NFSPROC4_CLNT_OPEN];
+	loc->msg.rpc_argp       = &loc->o_arg;
+	loc->msg.rpc_resp       = &loc->o_res;
+	loc->msg.rpc_cred	= cred;
 
 	/* Protect against reboot recovery conflicts */
 	down_read(&clp->cl_sem);
@@ -515,42 +542,42 @@ static int _nfs4_do_open(struct inode *d
 		goto out_err;
 	}
 	if (flags & O_EXCL) {
-		u32 *p = (u32 *) o_arg.u.verifier.data;
+		u32 *p = (u32 *) loc->o_arg.u.verifier.data;
 		p[0] = jiffies;
 		p[1] = current->pid;
 	} else
-		o_arg.u.attrs = sattr;
+		loc->o_arg.u.attrs = sattr;
 	/* Serialization for the sequence id */
 	down(&sp->so_sema);
-	o_arg.seqid = sp->so_seqid;
-	o_arg.id = sp->so_id;
-	o_arg.clientid = clp->cl_clientid,
+	loc->o_arg.seqid = sp->so_seqid;
+	loc->o_arg.id = sp->so_id;
+	loc->o_arg.clientid = clp->cl_clientid,
 
-	status = rpc_call_sync(server->client, &msg, RPC_TASK_NOINTR);
+	status = rpc_call_sync(server->client, &loc->msg, RPC_TASK_NOINTR);
 	nfs4_increment_seqid(status, sp);
 	if (status)
 		goto out_err;
-	update_changeattr(dir, &o_res.cinfo);
-	if(o_res.rflags & NFS4_OPEN_RESULT_CONFIRM) {
-		status = _nfs4_proc_open_confirm(server->client, &o_res.fh,
-				sp, &o_res.stateid);
+	update_changeattr(dir, &loc->o_res.cinfo);
+	if(loc->o_res.rflags & NFS4_OPEN_RESULT_CONFIRM) {
+		status = _nfs4_proc_open_confirm(server->client, &loc->o_res.fh,
+				sp, &loc->o_res.stateid);
 		if (status != 0)
 			goto out_err;
 	}
-	if (!(f_attr.valid & NFS_ATTR_FATTR)) {
-		status = server->rpc_ops->getattr(server, &o_res.fh, &f_attr);
+	if (!(loc->f_attr.valid & NFS_ATTR_FATTR)) {
+		status = server->rpc_ops->getattr(server, &loc->o_res.fh, &loc->f_attr);
 		if (status < 0)
 			goto out_err;
 	}
 
 	status = -ENOMEM;
-	inode = nfs_fhget(dir->i_sb, &o_res.fh, &f_attr);
+	inode = nfs_fhget(dir->i_sb, &loc->o_res.fh, &loc->f_attr);
 	if (!inode)
 		goto out_err;
 	state = nfs4_get_open_state(inode, sp);
 	if (!state)
 		goto out_err;
-	memcpy(&state->stateid, &o_res.stateid, sizeof(state->stateid));
+	memcpy(&state->stateid, &loc->o_res.stateid, sizeof(state->stateid));
 	spin_lock(&inode->i_lock);
 	if (flags & FMODE_READ)
 		state->nreaders++;
@@ -558,14 +585,17 @@ static int _nfs4_do_open(struct inode *d
 		state->nwriters++;
 	state->state |= flags & (FMODE_READ|FMODE_WRITE);
 	spin_unlock(&inode->i_lock);
-	if (o_res.delegation_type != 0)
-		nfs_inode_set_delegation(inode, cred, &o_res);
+	if (loc->o_res.delegation_type != 0)
+		nfs_inode_set_delegation(inode, cred, &loc->o_res);
+	kfree(loc);
 	up(&sp->so_sema);
 	nfs4_put_state_owner(sp);
 	up_read(&clp->cl_sem);
 	*res = state;
 	return 0;
+
 out_err:
+	kfree(loc);
 	if (sp != NULL) {
 		if (state != NULL)
 			nfs4_put_open_state(state);
diff -urpN linux-2.6.9-org.src/fs/nfs/proc.c linux-2.6.9.src/fs/nfs/proc.c
--- linux-2.6.9-org.src/fs/nfs/proc.c	Tue Oct 19 00:55:21 2004
+++ linux-2.6.9.src/fs/nfs/proc.c	Sat Oct 30 00:44:03 2004
@@ -216,31 +216,40 @@ static struct inode *
 nfs_proc_create(struct inode *dir, struct qstr *name, struct iattr *sattr,
 		int flags)
 {
-	struct nfs_fh		fhandle;
-	struct nfs_fattr	fattr;
-	struct nfs_createargs	arg = {
-		.fh		= NFS_FH(dir),
-		.name		= name->name,
-		.len		= name->len,
-		.sattr		= sattr
-	};
-	struct nfs_diropok	res = {
-		.fh		= &fhandle,
-		.fattr		= &fattr
-	};
-	int			status;
+	struct {
+		struct nfs_fh		fhandle;
+		struct nfs_fattr	fattr;
+		struct nfs_createargs	arg;
+		struct nfs_diropok	res;
+	} *loc;
+	int status;
 
-	fattr.valid = 0;
+	loc = kmalloc(sizeof(*loc), GFP_KERNEL);
+	if (!loc)
+		return ERR_PTR(-ENOMEM);
+
+	loc->arg.fh		= NFS_FH(dir);
+	loc->arg.name		= name->name;
+	loc->arg.len		= name->len;
+	loc->arg.sattr		= sattr;
+
+	loc->res.fh		= &loc->fhandle;
+	loc->res.fattr		= &loc->fattr;
+
+	loc->fattr.valid = 0;
 	dprintk("NFS call  create %s\n", name->name);
-	status = rpc_call(NFS_CLIENT(dir), NFSPROC_CREATE, &arg, &res, 0);
+	status = rpc_call(NFS_CLIENT(dir), NFSPROC_CREATE, &loc->arg, &loc->res, 0);
 	dprintk("NFS reply create: %d\n", status);
 	if (status == 0) {
 		struct inode *inode;
-		inode = nfs_fhget(dir->i_sb, &fhandle, &fattr);
-		if (inode)
+		inode = nfs_fhget(dir->i_sb, &loc->fhandle, &loc->fattr);
+		if (inode) {
+			kfree(loc);
 			return inode;
+		}
 		status = -ENOMEM;
 	}
+	kfree(loc);
 	return ERR_PTR(status);
 }
 

--Boundary-00=_q0rgBP4ODrzHf3w--

