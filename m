Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267691AbTATAvK>; Sun, 19 Jan 2003 19:51:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267695AbTATAvJ>; Sun, 19 Jan 2003 19:51:09 -0500
Received: from pat.uio.no ([129.240.130.16]:40581 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S267691AbTATAvI>;
	Sun, 19 Jan 2003 19:51:08 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15915.18967.933150.49658@charged.uio.no>
Date: Mon, 20 Jan 2003 02:00:07 +0100
To: Martin Josefsson <gandalf@wlug.westbo.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: problems with nfs-server in 2.5 bk as of 030115
In-Reply-To: <1043021842.679.1.camel@tux.rsn.bth.se>
References: <1043012373.7986.94.camel@tux.rsn.bth.se>
	<15915.8496.899499.957528@charged.uio.no>
	<1043016608.727.0.camel@tux.rsn.bth.se>
	<15915.13242.291976.585239@charged.uio.no>
	<1043021842.679.1.camel@tux.rsn.bth.se>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Martin Josefsson <gandalf@wlug.westbo.se> writes:

     > With two added ; the patch compiled and produced this output:

     > Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
     > rpc_destroy_client: rpc_rmdir(/portmap/clnteb10c63c) failed
     > with error -39 RPC: Couldn't create pipefs entry
     > /portmap/clnteb10c63c, error -17 RPC: Couldn't create pipefs
     > entry /portmap/clnteb10c63c, error -17 RPC: Couldn't create
     > pipefs entry /portmap/clnteb10c63c, error -17

Hmm... Does the following help?

Cheers,
  Trond

--- linux-2.5.59-00-fix/net/sunrpc/rpc_pipe.c.orig	2003-01-14 16:29:23.000000000 +0100
+++ linux-2.5.59-00-fix/net/sunrpc/rpc_pipe.c	2003-01-20 01:38:59.000000000 +0100
@@ -476,15 +476,16 @@
  * FIXME: This probably has races.
  */
 static void
-rpc_depopulate(struct dentry *dir)
+rpc_depopulate(struct dentry *parent)
 {
+	struct inode *dir = parent->d_inode;
 	LIST_HEAD(head);
 	struct list_head *pos, *next;
 	struct dentry *dentry;
 
-	down(&dir->d_inode->i_sem);
+	down(&dir->i_sem);
 	spin_lock(&dcache_lock);
-	list_for_each_safe(pos, next, &dir->d_subdirs) {
+	list_for_each_safe(pos, next, &parent->d_subdirs) {
 		dentry = list_entry(pos, struct dentry, d_child);
 		if (!d_unhashed(dentry)) {
 			dget_locked(dentry);
@@ -498,32 +499,34 @@
 		list_del_init(&dentry->d_hash);
 		if (dentry->d_inode) {
 			rpc_inode_setowner(dentry->d_inode, NULL);
-			simple_unlink(dir->d_inode, dentry);
+			simple_unlink(dir, dentry);
 		}
 		dput(dentry);
 	}
-	up(&dir->d_inode->i_sem);
+	up(&dir->i_sem);
 }
 
 static int
-rpc_populate(struct dentry *dir,
+rpc_populate(struct dentry *parent,
 		struct rpc_filelist *files,
 		int start, int eof)
 {
-	void *private = RPC_I(dir->d_inode)->private;
+	struct inode *inode, *dir = parent->d_inode;
+	void *private = RPC_I(dir)->private;
 	struct qstr name;
 	struct dentry *dentry;
-	struct inode *inode;
 	int mode, i;
+
+	down(&dir->i_sem);
 	for (i = start; i < eof; i++) {
 		name.name = files[i].name;
 		name.len = strlen(name.name);
 		name.hash = full_name_hash(name.name, name.len);
-		dentry = d_alloc(dir, &name);
+		dentry = d_alloc(parent, &name);
 		if (!dentry)
 			goto out_bad;
 		mode = files[i].mode;
-		inode = rpc_get_inode(dir->d_inode->i_sb, mode);
+		inode = rpc_get_inode(dir->i_sb, mode);
 		if (!inode) {
 			dput(dentry);
 			goto out_bad;
@@ -534,13 +537,15 @@
 		if (private)
 			rpc_inode_setowner(inode, private);
 		if (S_ISDIR(mode))
-			dir->d_inode->i_nlink++;
+			dir->i_nlink++;
 		d_add(dentry, inode);
 	}
+	up(&dir->i_sem);
 	return 0;
 out_bad:
+	up(&dir->i_sem);
 	printk(KERN_WARNING "%s: %s failed to populate directory %s\n",
-			__FILE__, __FUNCTION__, dir->d_name.name);
+			__FILE__, __FUNCTION__, parent->d_name.name);
 	return -ENOMEM;
 }
 
