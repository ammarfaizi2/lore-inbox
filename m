Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422660AbWBVUXo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422660AbWBVUXo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 15:23:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbWBVUWI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 15:22:08 -0500
Received: from mx1.redhat.com ([66.187.233.31]:14536 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751423AbWBVUWC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 15:22:02 -0500
Date: Wed, 22 Feb 2006 20:21:46 GMT
Message-Id: <200602222021.k1MKLkZn028351@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no, aviro@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-fsdevel@vger.kernel.org
Fcc: outgoing
Subject: [PATCH 5/5] NFS: Unify NFS superblocks per-protocol per-server
In-Reply-To: <dhowells1140639702@warthog.cambridge.redhat.com>
References: <dhowells1140639702@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch makes NFS share superblocks between mounts from the same
server over the same protocol.

It does this by creating each superblock with a false root and returning the
real root dentry through the new argument added to get_sb() in patch 1/5. The
root dentry returned starts off as an anonymous dentry if we don't already have
the dentry for its inode, otherwise it simply returns the dentry we already
have.

We may thus end up with several trees of dentries in the superblock, and if at
some later point one of anonymous tree roots is discovered by normal filesystem
activity to be located in another tree within the superblock, the anonymous
root is named and materialises attached to the second tree at the appropriate
point.

Why modify get_sb() in this way? Why not pass an extra argument to the mount()
syscall to indicate the subpath and then pathwalk from the server root to the
desired directory? You can't guarantee this will work for two reasons:

 (1) The root and intervening nodes may not be accessible to the client.

     With NFS2 and NFS3, for instance, mountd is called on the server to get
     the filehandle for the tip of a path. mountd won't give us handles for
     anything we don't have permission to access, and so we can't set up NFS
     inodes for such nodes, and so can't easily set up dentries (we'd have to
     have ghost inodes or something).

     With this patch we don't actually create dentries until we get handles
     from the server that we can use to set up their inodes, and we don't
     actually bind them into the tree until we know for sure where they go.

 (2) Inaccessible symbolic links.

     If we're asked to mount two exports from the server, eg:

	mount warthog:/warthog/aaa/xxx /mmm
	mount warthog:/warthog/bbb/yyy /nnn

     We may not be able to access anything nearer the root than xxx and yyy,
     but we may find out later that /mmm/www/yyy, say, is actually the same
     directory as the one mounted on /nnn. What we might then find out, for
     example, is that /warthog/bbb was actually a symbolic link to
     /warthog/aaa/xxx/www, but we can't actually determine that by talking to
     the server until /warthog is made available by NFS.

     This would lead to having constructed an errneous dentry tree which we
     can't easily fix. We can end up with a dentry marked as a directory when
     it should actually be a symlink, or we could end up with an apparently
     hardlinked directory.

     With this patch we need not make assumptions about the type of a dentry
     for which we can't retrieve information, nor need we assume we know its
     place in the grand scheme of things until we actually see that place.


This patch reduces the possibility of aliasing in the inode and page caches for
inodes that may be accessed by more than one NFS export. It also reduces the
number of superblocks required for NFS where there are many NFS exports being
used from a server (home directory server + autofs for example).

This in turn makes it simpler to do local caching of network filesystems, as it
can then be guaranteed that there won't be links from multiple inodes in
separate superblocks to the same cache file.

Obviously, cache aliasing between different levels of NFS protocol is still a
problem, but at least that gives us another key to use when indexing the cache.


The patch also exports some functions required from the core kernel.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 nfs-unify-sb-2616rc4.diff
 fs/namei.c                |    2 
 fs/namespace.c            |    4 
 fs/nfs/Makefile           |    4 
 fs/nfs/dir.c              |   27 +++++
 fs/nfs/getroot.c          |  220 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/nfs/inode.c            |  198 +++++++++++++++++++++--------------------
 fs/nfs/internal.h         |   30 ++++++
 fs/nfs/nfs3proc.c         |    2 
 fs/nfs/nfs4proc.c         |   61 +-----------
 fs/nfs/nfs4state.c        |    2 
 include/linux/nfs_fs_sb.h |    2 
 11 files changed, 393 insertions(+), 159 deletions(-)

diff -uNrp linux-2.6.16-rc4-getsb/include/linux/nfs_fs_sb.h linux-2.6.16-rc4-getsb-nfs/include/linux/nfs_fs_sb.h
--- linux-2.6.16-rc4-getsb/include/linux/nfs_fs_sb.h	2005-08-30 13:56:36.000000000 +0100
+++ linux-2.6.16-rc4-getsb-nfs/include/linux/nfs_fs_sb.h	2006-02-22 17:34:57.000000000 +0000
@@ -28,14 +28,12 @@ struct nfs_server {
 	unsigned int		acdirmax;
 	unsigned int		namelen;
 	char *			hostname;	/* remote hostname */
-	struct nfs_fh		fh;
 	struct sockaddr_in	addr;
 #ifdef CONFIG_NFS_V4
 	/* Our own IP address, as a null-terminated string.
 	 * This is used to generate the clientid, and the callback address.
 	 */
 	char			ip_addr[16];
-	char *			mnt_path;
 	struct nfs4_client *	nfs4_state;	/* all NFSv4 state starts here */
 	struct list_head	nfs4_siblings;	/* List of other nfs_server structs
 						 * that share the same clientid
diff -uNrp linux-2.6.16-rc4-getsb/fs/nfs/Makefile linux-2.6.16-rc4-getsb-nfs/fs/nfs/Makefile
--- linux-2.6.16-rc4-getsb/fs/nfs/Makefile	2006-02-22 17:00:37.000000000 +0000
+++ linux-2.6.16-rc4-getsb-nfs/fs/nfs/Makefile	2006-02-22 17:34:57.000000000 +0000
@@ -4,8 +4,8 @@
 
 obj-$(CONFIG_NFS_FS) += nfs.o
 
-nfs-y 			:= dir.o file.o inode.o nfs2xdr.o pagelist.o \
-			   proc.o read.o symlink.o unlink.o write.o
+nfs-y 			:= dir.o file.o getroot.o inode.o nfs2xdr.o \
+			   pagelist.o proc.o read.o symlink.o unlink.o write.o
 nfs-$(CONFIG_ROOT_NFS)	+= nfsroot.o mount_clnt.o      
 nfs-$(CONFIG_NFS_V3)	+= nfs3proc.o nfs3xdr.o
 nfs-$(CONFIG_NFS_V3_ACL)	+= nfs3acl.o
diff -uNrp linux-2.6.16-rc4-getsb/fs/nfs/internal.h linux-2.6.16-rc4-getsb-nfs/fs/nfs/internal.h
--- linux-2.6.16-rc4-getsb/fs/nfs/internal.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.16-rc4-getsb-nfs/fs/nfs/internal.h	2006-02-22 17:34:57.000000000 +0000
@@ -0,0 +1,30 @@
+/* internal.h: internal NFS definitions
+ *
+ * Copyright (C) 2005 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+
+/*
+ * getroot.c
+ */
+typedef void (*nfs_set_params_func)(struct super_block *sb,
+				    struct nfs_fh *mntfh,
+				    struct nfs_fsinfo *fsinfo);
+
+extern struct dentry *nfs_get_root(struct super_block *sb,
+				   struct nfs_fh *mntfh,
+				   nfs_set_params_func set_params);
+
+#ifdef CONFIG_NFS_V4
+
+extern struct dentry *nfs4_get_root(struct super_block *sb,
+				    const char *mntpath,
+				    nfs_set_params_func set_params);
+
+#endif
diff -uNrp linux-2.6.16-rc4-getsb/fs/nfs/dir.c linux-2.6.16-rc4-getsb-nfs/fs/nfs/dir.c
--- linux-2.6.16-rc4-getsb/fs/nfs/dir.c	2006-02-22 17:00:37.000000000 +0000
+++ linux-2.6.16-rc4-getsb-nfs/fs/nfs/dir.c	2006-02-22 17:34:57.000000000 +0000
@@ -836,11 +836,12 @@ int nfs_is_exclusive_create(struct inode
 
 static struct dentry *nfs_lookup(struct inode *dir, struct dentry * dentry, struct nameidata *nd)
 {
-	struct dentry *res;
+	struct dentry *res, *anon;
 	struct inode *inode = NULL;
 	int error;
 	struct nfs_fh fhandle;
 	struct nfs_fattr fattr;
+ 	int found_alias = 0;
 
 	dfprintk(VFS, "NFS: lookup(%s/%s)\n",
 		dentry->d_parent->d_name.name, dentry->d_name.name);
@@ -869,6 +870,30 @@ static struct dentry *nfs_lookup(struct 
 	inode = nfs_fhget(dentry->d_sb, &fhandle, &fattr);
 	if (!inode)
 		goto out_unlock;
+
+	/* Search for directory aliases arising from multiple mounts from one server */
+	if (S_ISDIR(inode->i_mode) && (anon = d_find_alias(inode))) {
+		spin_lock(&anon->d_lock);
+		/* Is this a mountpoint that we could splice into our tree? */
+		if (IS_ROOT(anon)) {
+			/* Yes! Convert into an ordinary dentry */
+			d_materialise_dentry(dentry, anon);
+			found_alias = 1;
+		} else if (anon->d_name.len == dentry->d_name.len &&
+			   !memcmp(anon->d_name.name, dentry->d_name.name, dentry->d_name.len) &&
+			   dentry->d_parent == anon->d_parent)
+			found_alias = 1;
+		spin_unlock(&anon->d_lock);
+		if (found_alias) {
+			d_drop(anon);
+			iput(inode);
+			d_rehash(anon);
+			return anon;
+		}
+		/* Doh! Server appears to be aliasing directories */
+		dput(anon);
+	}
+
 no_entry:
 	res = d_add_unique(dentry, inode);
 	if (res != NULL)
diff -uNrp linux-2.6.16-rc4-getsb/fs/nfs/getroot.c linux-2.6.16-rc4-getsb-nfs/fs/nfs/getroot.c
--- linux-2.6.16-rc4-getsb/fs/nfs/getroot.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.16-rc4-getsb-nfs/fs/nfs/getroot.c	2006-02-22 18:47:00.000000000 +0000
@@ -0,0 +1,220 @@
+/* getroot.c: get the root dentry for an NFS mount
+ *
+ * Copyright (C) 2005 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/init.h>
+
+#include <linux/time.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/string.h>
+#include <linux/stat.h>
+#include <linux/errno.h>
+#include <linux/unistd.h>
+#include <linux/sunrpc/clnt.h>
+#include <linux/sunrpc/stats.h>
+#include <linux/nfs_fs.h>
+#include <linux/nfs_mount.h>
+#include <linux/nfs4_mount.h>
+#include <linux/lockd/bind.h>
+#include <linux/smp_lock.h>
+#include <linux/seq_file.h>
+#include <linux/mount.h>
+#include <linux/nfs_idmap.h>
+#include <linux/vfs.h>
+#include <linux/namei.h>
+#include <linux/namespace.h>
+
+#include <asm/system.h>
+#include <asm/uaccess.h>
+
+#include "nfs4_fs.h"
+#include "delegation.h"
+#include "internal.h"
+
+#define NFSDBG_FACILITY		NFSDBG_VFS
+#define NFS_PARANOIA 1
+
+/*
+ * get an NFS2/NFS3 root dentry from the root filehandle
+ */
+struct dentry *nfs_get_root(struct super_block *sb,
+			    struct nfs_fh *mntfh,
+			    nfs_set_params_func set_params)
+{
+	struct nfs_server *server = NFS_SB(sb);
+	struct nfs_fsinfo fsinfo;
+	struct nfs_fattr fattr;
+	struct dentry *mntroot;
+	struct inode *inode;
+	int error;
+
+	/* create a dummy root dentry with dummy inode for this superblock */
+	if (!sb->s_root) {
+		struct nfs_fh dummyfh;
+		struct dentry *root;
+		struct inode *iroot;
+
+		memset(&dummyfh, 0, sizeof(dummyfh));
+		memset(&fattr, 0, sizeof(fattr));
+		nfs_fattr_init(&fattr);
+		fattr.valid = NFS_ATTR_FATTR;
+		fattr.type = NFDIR;
+		fattr.mode = S_IFDIR | S_IRUSR | S_IWUSR;
+		fattr.nlink = 2;
+		iroot = nfs_fhget(sb, &dummyfh, &fattr);
+		if (!iroot)
+			return ERR_PTR(-ENOMEM);
+
+		root = d_alloc_root(iroot);
+		if (!root) {
+			iput(iroot);
+			return ERR_PTR(-ENOMEM);
+		}
+
+		sb->s_root = root;
+	}
+
+	/* get the actual root for this mount */
+	fsinfo.fattr = &fattr;
+
+	error = server->rpc_ops->getroot(server, mntfh, &fsinfo);
+	if (error < 0) {
+		dprintk("nfs_get_root: getattr error = %d\n", -error);
+		return ERR_PTR(error);
+	}
+
+	inode = nfs_fhget(sb, mntfh, fsinfo.fattr);
+	if (!inode) {
+		dprintk("nfs_get_root: get root inode failed\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	/* root dentries start off anonymous and get spliced in later if the
+	 * dentry tree reaches them */
+	mntroot = d_alloc_anon(inode);
+	if (!mntroot) {
+		iput(inode);
+		dprintk("nfs_get_root: get root dentry failed\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	if (!mntroot->d_op)
+		mntroot->d_op = server->rpc_ops->dentry_ops;
+
+	/* make use of the fsinfo if requested */
+	if (set_params)
+		set_params(sb, mntfh, &fsinfo);
+
+	return mntroot;
+}
+
+#ifdef CONFIG_NFS_V4
+
+/*
+ * walk the path to the specified mountpoint on an NFS4 server
+ */
+struct dentry *nfs4_get_root(struct super_block *sb,
+			     const char *mntpath,
+			     nfs_set_params_func set_params)
+{
+	struct namespace *namespace = NULL;
+	struct nameidata nd;
+	struct vfsmount *mnt = NULL;
+	struct dentry *mntroot;
+	struct inode *inode;
+	int ret;
+	int saved_link_count = current->link_count;
+	int saved_total_link_count = current->total_link_count;
+
+	/* get the dentry for the "/" directory on the server */
+	if (!sb->s_root) {
+		struct nfs_server *server = sb->s_fs_info;
+		struct nfs_fsinfo fsinfo;
+		struct nfs_fattr fattr;
+		struct nfs_fh rootfh;
+
+		/* need the filehandle first */
+		nfs_fattr_init(&fattr);
+		fsinfo.fattr = &fattr;
+
+		ret = server->rpc_ops->getroot(server, &rootfh, &fsinfo);
+		if (ret < 0) {
+			dprintk("nfs4_get_root: getroot error = %d\n", -ret);
+			return ERR_PTR(ret);
+		}
+		
+		inode = nfs_fhget(sb, &rootfh, &fattr);
+		if (!inode) {
+			dprintk("nfs4_get_root: get root inode failed\n");
+			return ERR_PTR(-ENOMEM);
+		}
+
+		sb->s_root = d_alloc_root(inode);
+		if (!sb->s_root) {
+			iput(inode);
+			return ERR_PTR(-ENOMEM);
+		}
+
+		/* make use of the fsinfo if requested */
+		if (set_params)
+			set_params(sb, &rootfh, &fsinfo);
+	}
+
+	/* create a mount to represent the NFS server's FH tree */
+	mnt = alloc_vfsmnt(NULL);
+	if (!mnt)
+		return ERR_PTR(-ENOMEM);
+
+	mnt->mnt_sb = sb;
+	mnt->mnt_root = sb->s_root;
+	mnt->mnt_mountpoint = sb->s_root;
+	mnt->mnt_parent = mnt;
+
+	/* create a namespace through which to walk */
+	namespace = kmalloc(sizeof(*namespace), GFP_KERNEL);
+	if (!namespace) {
+		kfree(mnt);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	init_namespace(namespace, mnt);
+
+	/* set up the walk we're going to take */
+	nd.last_type = LAST_ROOT;
+	nd.flags = LOOKUP_FOLLOW | LOOKUP_DIRECTORY | LOOKUP_ACCESS;
+	nd.depth = 0;
+
+	nd.mnt = mntget(namespace->root);
+	nd.dentry = dget(nd.mnt->mnt_root);
+
+	/* walk the walk */
+	current->total_link_count = 0;
+	ret = link_path_walk(mntpath, &nd);
+	if (ret < 0) {
+		mntroot = ERR_PTR(ret);
+		goto error;
+	}
+
+	/* we've found the directory we're going to mount */
+	mntput(nd.mnt);
+	mntroot = nd.dentry;
+
+error:
+	free_vfsmnt(namespace->root);
+	kfree(namespace);
+	current->link_count = saved_link_count;
+	current->total_link_count = saved_total_link_count;
+	return mntroot;
+}
+
+#endif /* CONFIG_NFS_V4 */
diff -uNrp linux-2.6.16-rc4-getsb/fs/nfs/inode.c linux-2.6.16-rc4-getsb-nfs/fs/nfs/inode.c
--- linux-2.6.16-rc4-getsb/fs/nfs/inode.c	2006-02-22 17:08:48.000000000 +0000
+++ linux-2.6.16-rc4-getsb-nfs/fs/nfs/inode.c	2006-02-22 18:48:30.000000000 +0000
@@ -42,6 +42,7 @@
 #include "nfs4_fs.h"
 #include "callback.h"
 #include "delegation.h"
+#include "internal.h"
 
 #define NFSDBG_FACILITY		NFSDBG_VFS
 #define NFS_PARANOIA 1
@@ -231,79 +232,48 @@ nfs_block_size(unsigned long bsize, unsi
 }
 
 /*
- * Obtain the root inode of the file system.
+ * Initialise the common bits of the superblock
  */
-static struct inode *
-nfs_get_root(struct super_block *sb, struct nfs_fh *rootfh, struct nfs_fsinfo *fsinfo)
+static inline void nfs_initialise_sb(struct super_block *sb)
 {
-	struct nfs_server	*server = NFS_SB(sb);
-	struct inode *rooti;
-	int			error;
+	sb->s_magic = NFS_SUPER_MAGIC;
 
-	error = server->rpc_ops->getroot(server, rootfh, fsinfo);
-	if (error < 0) {
-		dprintk("nfs_get_root: getattr error = %d\n", -error);
-		return ERR_PTR(error);
-	}
-
-	rooti = nfs_fhget(sb, rootfh, fsinfo->fattr);
-	if (!rooti)
-		return ERR_PTR(-ENOMEM);
-	return rooti;
+	/* We probably want something more informative here */
+	snprintf(sb->s_id, sizeof(sb->s_id),
+		 "%x:%x", MAJOR(sb->s_dev), MINOR(sb->s_dev));
 }
 
 /*
- * Do NFS version-independent mount processing, and sanity checking
+ * Set the communications parameters
  */
-static int
-nfs_sb_init(struct super_block *sb, rpc_authflavor_t authflavor)
+static void nfs_set_comms_params(struct super_block *sb,
+				 struct nfs_fh *mntfh,
+				 struct nfs_fsinfo *fsinfo)
 {
-	struct nfs_server	*server;
-	struct inode		*root_inode;
-	struct nfs_fattr	fattr;
-	struct nfs_fsinfo	fsinfo = {
-					.fattr = &fattr,
-				};
-	struct nfs_pathconf pathinfo = {
-			.fattr = &fattr,
-	};
-	int no_root_error = 0;
+	struct nfs_pathconf pathinfo;
+	struct nfs_server *server;
 	unsigned long max_rpc_payload;
 
-	/* We probably want something more informative here */
-	snprintf(sb->s_id, sizeof(sb->s_id), "%x:%x", MAJOR(sb->s_dev), MINOR(sb->s_dev));
-
 	server = NFS_SB(sb);
 
-	sb->s_magic      = NFS_SUPER_MAGIC;
+	/* Get some general file system info */
+	if (server->namelen == 0) {
+		pathinfo.fattr = fsinfo->fattr; /* reuse the fsinfo's attrs */
 
-	root_inode = nfs_get_root(sb, &server->fh, &fsinfo);
-	/* Did getting the root inode fail? */
-	if (IS_ERR(root_inode)) {
-		no_root_error = PTR_ERR(root_inode);
-		goto out_no_root;
-	}
-	sb->s_root = d_alloc_root(root_inode);
-	if (!sb->s_root) {
-		no_root_error = -ENOMEM;
-		goto out_no_root;
+		if (server->rpc_ops->pathconf(server, mntfh, &pathinfo) >= 0)
+			server->namelen = pathinfo.max_namelen;
 	}
-	sb->s_root->d_op = server->rpc_ops->dentry_ops;
 
-	/* Get some general file system info */
-	if (server->namelen == 0 &&
-	    server->rpc_ops->pathconf(server, &server->fh, &pathinfo) >= 0)
-		server->namelen = pathinfo.max_namelen;
 	/* Work out a lot of parameters */
 	if (server->rsize == 0)
-		server->rsize = nfs_block_size(fsinfo.rtpref, NULL);
+		server->rsize = nfs_block_size(fsinfo->rtpref, NULL);
 	if (server->wsize == 0)
-		server->wsize = nfs_block_size(fsinfo.wtpref, NULL);
+		server->wsize = nfs_block_size(fsinfo->wtpref, NULL);
 
-	if (fsinfo.rtmax >= 512 && server->rsize > fsinfo.rtmax)
-		server->rsize = nfs_block_size(fsinfo.rtmax, NULL);
-	if (fsinfo.wtmax >= 512 && server->wsize > fsinfo.wtmax)
-		server->wsize = nfs_block_size(fsinfo.wtmax, NULL);
+	if (fsinfo->rtmax >= 512 && server->rsize > fsinfo->rtmax)
+		server->rsize = nfs_block_size(fsinfo->rtmax, NULL);
+	if (fsinfo->wtmax >= 512 && server->wsize > fsinfo->wtmax)
+		server->wsize = nfs_block_size(fsinfo->wtmax, NULL);
 
 	max_rpc_payload = nfs_block_size(rpc_max_payload(server->client), NULL);
 	if (server->rsize > max_rpc_payload)
@@ -321,9 +291,9 @@ nfs_sb_init(struct super_block *sb, rpc_
 	if (sb->s_blocksize == 0)
 		sb->s_blocksize = nfs_block_bits(server->wsize,
 							 &sb->s_blocksize_bits);
-	server->wtmult = nfs_block_bits(fsinfo.wtmult, NULL);
+	server->wtmult = nfs_block_bits(fsinfo->wtmult, NULL);
 
-	server->dtsize = nfs_block_size(fsinfo.dtpref, NULL);
+	server->dtsize = nfs_block_size(fsinfo->dtpref, NULL);
 	if (server->dtsize > PAGE_CACHE_SIZE)
 		server->dtsize = PAGE_CACHE_SIZE;
 	if (server->dtsize > server->rsize)
@@ -336,7 +306,7 @@ nfs_sb_init(struct super_block *sb, rpc_
 	}
 	server->backing_dev_info.ra_pages = server->rpages * NFS_MAX_READAHEAD;
 
-	sb->s_maxbytes = fsinfo.maxfilesize;
+	sb->s_maxbytes = fsinfo->maxfilesize;
 	if (sb->s_maxbytes > MAX_LFS_FILESIZE) 
 		sb->s_maxbytes = MAX_LFS_FILESIZE; 
 
@@ -345,13 +315,6 @@ nfs_sb_init(struct super_block *sb, rpc_
 
 	/* We're airborne Set socket buffersize */
 	rpc_setbufsize(server->client, server->wsize + 100, server->rsize + 100);
-	return 0;
-	/* Yargs. It didn't work out. */
-out_no_root:
-	dprintk("nfs_sb_init: get root inode failed: errno %d\n", -no_root_error);
-	if (!IS_ERR(root_inode))
-		iput(root_inode);
-	return no_root_error;
 }
 
 static void nfs_init_timeout_values(struct rpc_timeout *to, int proto, unsigned int timeo, unsigned int retrans)
@@ -520,9 +483,13 @@ nfs_fill_super(struct super_block *sb, s
 	}
 
 	sb->s_op = &nfs_sops;
-	return nfs_sb_init(sb, authflavor);
+	nfs_initialise_sb(sb);
+	return 0;
 }
 
+/*
+ * return NFS filesystem statistics to userspace
+ */
 static int
 nfs_statfs(struct super_block *sb, struct kstatfs *buf)
 {
@@ -1565,6 +1532,11 @@ static int nfs_update_inode(struct inode
 
 /*
  * File system information
+ * - superblocks are indexed on server only - all inodes, dentries, etc. associated with a
+ *   particular server are held in the same superblock
+ * - NFS superblocks can have several effective roots to the dentry tree
+ * - directory type roots are spliced into the tree when a path from one root reaches the root
+ *   of another (see nfs_lookup())
  */
 
 static int nfs_set_super(struct super_block *s, void *data)
@@ -1582,7 +1554,7 @@ static int nfs_compare_super(struct supe
 		return 0;
 	if (old->addr.sin_port != server->addr.sin_port)
 		return 0;
-	return !nfs_compare_fh(&old->fh, &server->fh);
+	return 1;
 }
 
 static struct super_block *nfs_get_sb(struct file_system_type *fs_type,
@@ -1591,8 +1563,9 @@ static struct super_block *nfs_get_sb(st
 	int error;
 	struct nfs_server *server = NULL;
 	struct super_block *s;
-	struct nfs_fh *root;
+	struct nfs_fh mntfh;
 	struct nfs_mount_data *data = raw_data;
+	struct dentry *mntroot;
 
 	s = ERR_PTR(-EINVAL);
 	if (data == NULL) {
@@ -1640,22 +1613,28 @@ static struct super_block *nfs_get_sb(st
 	server = kmalloc(sizeof(struct nfs_server), GFP_KERNEL);
 	if (!server)
 		goto out_err;
+
 	memset(server, 0, sizeof(struct nfs_server));
+
 	/* Zero out the NFS state stuff */
 	init_nfsv4_state(server);
 	server->client = server->client_sys = server->client_acl = ERR_PTR(-EINVAL);
 
-	root = &server->fh;
 	if (data->flags & NFS_MOUNT_VER3)
-		root->size = data->root.size;
+		mntfh.size = data->root.size;
 	else
-		root->size = NFS2_FHSIZE;
+		mntfh.size = NFS2_FHSIZE;
+
 	s = ERR_PTR(-EINVAL);
-	if (root->size > sizeof(root->data)) {
+	if (mntfh.size > sizeof(mntfh.data)) {
 		dprintk("%s: invalid root filehandle\n", __FUNCTION__);
 		goto out_err;
 	}
-	memcpy(root->data, data->root.data, root->size);
+
+	memcpy(mntfh.data, data->root.data, mntfh.size);
+	if (mntfh.size < sizeof(mntfh.data))
+		memset(mntfh.data + mntfh.size, 0,
+		       sizeof(mntfh.data) - mntfh.size);
 
 	/* We now require that the mount process passes the remote address */
 	memcpy(&server->addr, &data->addr, sizeof(server->addr));
@@ -1673,18 +1652,27 @@ static struct super_block *nfs_get_sb(st
 		goto out_err;
 	}
 
+	/* Get a superblock - note that we may end up sharing one that already exists */
 	s = sget(fs_type, nfs_compare_super, nfs_set_super, server);
-	if (IS_ERR(s) || s->s_root)
+	if (IS_ERR(s))
 		goto out_rpciod_down;
 
-	s->s_flags = flags;
+	if (!s->s_root) {
+		/* initial superblock/root creation */
+		s->s_flags = flags;
 
-	error = nfs_fill_super(s, data, flags & MS_VERBOSE ? 1 : 0);
-	if (error) {
-		up_write(&s->s_umount);
-		deactivate_super(s);
-		return ERR_PTR(error);
+		error = nfs_fill_super(s, data, flags & MS_VERBOSE ? 1 : 0);
+		if (error)
+			goto error_splat_super;
 	}
+
+	mntroot = nfs_get_root(s, &mntfh, s->s_root ? NULL : nfs_set_comms_params);
+	if (IS_ERR(mntroot)) {
+		error = PTR_ERR(mntroot);
+		goto error_splat_super;
+	}
+
+	*_root = mntroot;
 	s->s_flags |= MS_ACTIVE;
 	return s;
 out_rpciod_down:
@@ -1692,6 +1680,11 @@ out_rpciod_down:
 out_err:
 	kfree(server);
 	return s;
+
+error_splat_super:
+	up_write(&s->s_umount);
+	deactivate_super(s);
+	return ERR_PTR(error);
 }
 
 static void nfs_kill_super(struct super_block *s)
@@ -1771,7 +1764,8 @@ static void nfs4_clear_inode(struct inod
 }
 
 
-static int nfs4_fill_super(struct super_block *sb, struct nfs4_mount_data *data, int silent)
+static int nfs4_fill_super(struct super_block *sb,
+			   struct nfs4_mount_data *data, int silent)
 {
 	struct nfs_server *server;
 	struct nfs4_client *clp = NULL;
@@ -1880,9 +1874,7 @@ static int nfs4_fill_super(struct super_
 	sb->s_time_gran = 1;
 
 	sb->s_op = &nfs4_sops;
-	err = nfs_sb_init(sb, authflavour);
-	if (err == 0)
-		return 0;
+	nfs_initialise_sb(sb);
 out_fail:
 	if (clp)
 		nfs4_put_client(clp);
@@ -1896,8 +1888,6 @@ static int nfs4_compare_super(struct sup
 
 	if (strcmp(server->hostname, old->hostname) != 0)
 		return 0;
-	if (strcmp(server->mnt_path, old->mnt_path) != 0)
-		return 0;
 	return 1;
 }
 
@@ -1930,6 +1920,8 @@ static struct super_block *nfs4_get_sb(s
 	struct nfs_server *server;
 	struct super_block *s;
 	struct nfs4_mount_data *data = raw_data;
+	struct dentry *mntroot;
+	char *mntpath = NULL;
 	void *p;
 
 	if (data == NULL) {
@@ -1957,7 +1949,7 @@ static struct super_block *nfs4_get_sb(s
 	p = nfs_copy_user_string(NULL, &data->mnt_path, 1024);
 	if (IS_ERR(p))
 		goto out_err;
-	server->mnt_path = p;
+	mntpath = p;
 
 	p = nfs_copy_user_string(server->ip_addr, &data->client_addr,
 			sizeof(server->ip_addr) - 1);
@@ -1989,28 +1981,43 @@ static struct super_block *nfs4_get_sb(s
 		goto out_free;
 	}
 
+	/* Get a superblock - note that we may end up sharing one that already exists */
 	s = sget(fs_type, nfs4_compare_super, nfs_set_super, server);
-
-	if (IS_ERR(s) || s->s_root)
+	if (IS_ERR(s))
 		goto out_free;
 
-	s->s_flags = flags;
+	if (!s->s_root) {
+		/* initial superblock/root creation */
+		s->s_flags = flags;
+
+		error = nfs4_fill_super(s, data, flags & MS_VERBOSE ? 1 : 0);
+		if (error)
+			goto error_splat_super;
+	}
 
-	error = nfs4_fill_super(s, data, flags & MS_VERBOSE ? 1 : 0);
-	if (error) {
-		up_write(&s->s_umount);
-		deactivate_super(s);
-		return ERR_PTR(error);
+	mntroot = nfs4_get_root(s, mntpath, nfs_set_comms_params);
+	if (IS_ERR(mntroot)) {
+		error = PTR_ERR(mntroot);
+		goto error_splat_super;
 	}
+
+	*_root = mntroot;
+
+	kfree(mntpath);
 	s->s_flags |= MS_ACTIVE;
 	return s;
 out_err:
 	s = (struct super_block *)p;
 out_free:
-	kfree(server->mnt_path);
+	kfree(mntpath);
 	kfree(server->hostname);
 	kfree(server);
 	return s;
+
+error_splat_super:
+	up_write(&s->s_umount);
+	deactivate_super(s);
+	return ERR_PTR(error);
 }
 
 static void nfs4_kill_super(struct super_block *sb)
@@ -2131,6 +2138,7 @@ static struct inode *nfs_alloc_inode(str
 #ifdef CONFIG_NFS_V4
 	nfsi->nfs4_acl = NULL;
 #endif /* CONFIG_NFS_V4 */
+
 	return &nfsi->vfs_inode;
 }
 
diff -uNrp linux-2.6.16-rc4-getsb/fs/nfs/nfs3proc.c linux-2.6.16-rc4-getsb-nfs/fs/nfs/nfs3proc.c
--- linux-2.6.16-rc4-getsb/fs/nfs/nfs3proc.c	2006-02-22 17:00:37.000000000 +0000
+++ linux-2.6.16-rc4-getsb-nfs/fs/nfs/nfs3proc.c	2006-02-22 17:34:57.000000000 +0000
@@ -86,7 +86,7 @@ do_proc_get_root(struct rpc_clnt *client
 }
 
 /*
- * Bare-bones access to getattr: this is for nfs_read_super.
+ * Bare-bones access to getattr: this is for nfs_get_root/nfs_get_sb
  */
 static int
 nfs3_proc_get_root(struct nfs_server *server, struct nfs_fh *fhandle,
diff -uNrp linux-2.6.16-rc4-getsb/fs/nfs/nfs4proc.c linux-2.6.16-rc4-getsb-nfs/fs/nfs/nfs4proc.c
--- linux-2.6.16-rc4-getsb/fs/nfs/nfs4proc.c	2006-02-22 17:00:37.000000000 +0000
+++ linux-2.6.16-rc4-getsb-nfs/fs/nfs/nfs4proc.c	2006-02-22 18:25:55.000000000 +0000
@@ -908,7 +908,7 @@ out_put_state_owner:
 static struct nfs4_state *nfs4_open_delegated(struct inode *inode, int flags, struct rpc_cred *cred)
 {
 	struct nfs4_exception exception = { };
-	struct nfs4_state *res;
+	struct nfs4_state *res = NULL;
 	int err;
 
 	do {
@@ -1366,70 +1366,19 @@ static int nfs4_lookup_root(struct nfs_s
 	return err;
 }
 
+/*
+ * get the file handle for the "/" directory on the server
+ */
 static int nfs4_proc_get_root(struct nfs_server *server, struct nfs_fh *fhandle,
-		struct nfs_fsinfo *info)
+			      struct nfs_fsinfo *info)
 {
-	struct nfs_fattr *	fattr = info->fattr;
-	unsigned char *		p;
-	struct qstr		q;
-	struct nfs4_lookup_arg args = {
-		.dir_fh = fhandle,
-		.name = &q,
-		.bitmask = nfs4_fattr_bitmap,
-	};
-	struct nfs4_lookup_res res = {
-		.server = server,
-		.fattr = fattr,
-		.fh = fhandle,
-	};
-	struct rpc_message msg = {
-		.rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_LOOKUP],
-		.rpc_argp = &args,
-		.rpc_resp = &res,
-	};
 	int status;
 
-	/*
-	 * Now we do a separate LOOKUP for each component of the mount path.
-	 * The LOOKUPs are done separately so that we can conveniently
-	 * catch an ERR_WRONGSEC if it occurs along the way...
-	 */
 	status = nfs4_lookup_root(server, fhandle, info);
-	if (status)
-		goto out;
-
-	p = server->mnt_path;
-	for (;;) {
-		struct nfs4_exception exception = { };
-
-		while (*p == '/')
-			p++;
-		if (!*p)
-			break;
-		q.name = p;
-		while (*p && (*p != '/'))
-			p++;
-		q.len = p - q.name;
-
-		do {
-			nfs_fattr_init(fattr);
-			status = nfs4_handle_exception(server,
-					rpc_call_sync(server->client, &msg, 0),
-					&exception);
-		} while (exception.retry);
-		if (status == 0)
-			continue;
-		if (status == -ENOENT) {
-			printk(KERN_NOTICE "NFS: mount path %s does not exist!\n", server->mnt_path);
-			printk(KERN_NOTICE "NFS: suggestion: try mounting '/' instead.\n");
-		}
-		break;
-	}
 	if (status == 0)
 		status = nfs4_server_capabilities(server, fhandle);
 	if (status == 0)
 		status = nfs4_do_fsinfo(server, fhandle, info);
-out:
 	return status;
 }
 
diff -uNrp linux-2.6.16-rc4-getsb/fs/nfs/nfs4state.c linux-2.6.16-rc4-getsb-nfs/fs/nfs/nfs4state.c
--- linux-2.6.16-rc4-getsb/fs/nfs/nfs4state.c	2006-02-22 17:00:37.000000000 +0000
+++ linux-2.6.16-rc4-getsb-nfs/fs/nfs/nfs4state.c	2006-02-22 17:46:54.000000000 +0000
@@ -69,8 +69,6 @@ init_nfsv4_state(struct nfs_server *serv
 void
 destroy_nfsv4_state(struct nfs_server *server)
 {
-	kfree(server->mnt_path);
-	server->mnt_path = NULL;
 	if (server->nfs4_state) {
 		nfs4_put_client(server->nfs4_state);
 		server->nfs4_state = NULL;
diff -uNrp linux-2.6.16-rc4-getsb/fs/namei.c linux-2.6.16-rc4-getsb-nfs/fs/namei.c
--- linux-2.6.16-rc4-getsb/fs/namei.c	2006-02-22 17:00:37.000000000 +0000
+++ linux-2.6.16-rc4-getsb-nfs/fs/namei.c	2006-02-22 18:27:19.000000000 +0000
@@ -992,6 +992,8 @@ int fastcall link_path_walk(const char *
 	return result;
 }
 
+EXPORT_SYMBOL_GPL(link_path_walk);
+
 int fastcall path_walk(const char * name, struct nameidata *nd)
 {
 	current->total_link_count = 0;
diff -uNrp linux-2.6.16-rc4-getsb/fs/namespace.c linux-2.6.16-rc4-getsb-nfs/fs/namespace.c
--- linux-2.6.16-rc4-getsb/fs/namespace.c	2006-02-22 17:00:37.000000000 +0000
+++ linux-2.6.16-rc4-getsb-nfs/fs/namespace.c	2006-02-22 18:21:52.000000000 +0000
@@ -86,12 +86,16 @@ struct vfsmount *alloc_vfsmnt(const char
 	return mnt;
 }
 
+EXPORT_SYMBOL_GPL(alloc_vfsmnt);
+
 void free_vfsmnt(struct vfsmount *mnt)
 {
 	kfree(mnt->mnt_devname);
 	kmem_cache_free(mnt_cache, mnt);
 }
 
+EXPORT_SYMBOL_GPL(free_vfsmnt);
+
 /*
  * find the first or last mount at @dentry on vfsmount @mnt depending on
  * @dir. If @dir is set return the first mount else return the last mount.
