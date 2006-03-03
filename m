Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932155AbWCCJ7y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbWCCJ7y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 04:59:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752239AbWCCJ7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 04:59:53 -0500
Received: from mx1.redhat.com ([66.187.233.31]:22981 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1752234AbWCCJ7w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 04:59:52 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060302213409.7282.29767.stgit@warthog.cambridge.redhat.com> 
References: <20060302213409.7282.29767.stgit@warthog.cambridge.redhat.com>  <20060302213356.7282.26463.stgit@warthog.cambridge.redhat.com> 
To: torvalds@osdl.org, akpm@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no, aviro@redhat.com
Cc: linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] NFS: Unify NFS superblocks per-protocol per-server [try #3a] 
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Fri, 03 Mar 2006 09:59:23 +0000
Message-ID: <11840.1141379963@warthog.cambridge.redhat.com>
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

This patch also cleans up the error handling to make sure the NFS iostats are
released correctly upon error. The server construction and destruction have
been abstracted into functions as the first is done twice and the second four
times.

And finally, the patch exports some functions required from the core kernel.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 fs/namei.c                |    2 
 fs/namespace.c            |    4 +
 fs/nfs/Makefile           |    4 -
 fs/nfs/dir.c              |   65 +++++++++++
 fs/nfs/getroot.c          |  237 ++++++++++++++++++++++++++++++++++++++++
 fs/nfs/inode.c            |  265 ++++++++++++++++++++++++---------------------
 fs/nfs/internal.h         |   30 +++++
 fs/nfs/nfs3proc.c         |    2 
 fs/nfs/nfs4proc.c         |   59 +---------
 fs/nfs/nfs4state.c        |    2 
 include/linux/nfs_fs_sb.h |    2 
 11 files changed, 485 insertions(+), 187 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 557dcf3..81bc997 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -992,6 +992,8 @@ int fastcall link_path_walk(const char *
 	return result;
 }
 
+EXPORT_SYMBOL_GPL(link_path_walk);
+
 int fastcall path_walk(const char * name, struct nameidata *nd)
 {
 	current->total_link_count = 0;
diff --git a/fs/namespace.c b/fs/namespace.c
index 6f13481..ee3b146 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -86,6 +86,8 @@ struct vfsmount *alloc_vfsmnt(const char
 	return mnt;
 }
 
+EXPORT_SYMBOL_GPL(alloc_vfsmnt);
+
 int simple_set_mnt(struct vfsmount *mnt, struct super_block *sb)
 {
 	mnt->mnt_sb = sb;
@@ -101,6 +103,8 @@ void free_vfsmnt(struct vfsmount *mnt)
 	kmem_cache_free(mnt_cache, mnt);
 }
 
+EXPORT_SYMBOL_GPL(free_vfsmnt);
+
 /*
  * find the first or last mount at @dentry on vfsmount @mnt depending on
  * @dir. If @dir is set return the first mount else return the last mount.
diff --git a/fs/nfs/Makefile b/fs/nfs/Makefile
index ec61fd5..43ce192 100644
--- a/fs/nfs/Makefile
+++ b/fs/nfs/Makefile
@@ -4,8 +4,8 @@
 
 obj-$(CONFIG_NFS_FS) += nfs.o
 
-nfs-y 			:= dir.o file.o inode.o nfs2xdr.o pagelist.o \
-			   proc.o read.o symlink.o unlink.o write.o
+nfs-y 			:= dir.o file.o getroot.o inode.o nfs2xdr.o \
+			   pagelist.o proc.o read.o symlink.o unlink.o write.o
 nfs-$(CONFIG_ROOT_NFS)	+= nfsroot.o mount_clnt.o      
 nfs-$(CONFIG_NFS_V3)	+= nfs3proc.o nfs3xdr.o
 nfs-$(CONFIG_NFS_V3_ACL)	+= nfs3acl.o
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 609185a..7fee9e3 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -871,11 +871,12 @@ int nfs_is_exclusive_create(struct inode
 
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
@@ -905,6 +906,30 @@ static struct dentry *nfs_lookup(struct 
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
@@ -1100,11 +1125,49 @@ static struct dentry *nfs_readdir_lookup
 		dput(dentry);
 		return NULL;
 	}
+
+	/* Search for directory aliases arising from multiple mounts from one server */
+	if (S_ISDIR(inode->i_mode) && (alias = d_find_alias(inode))) {
+		int found_alias = 0;
+
+		spin_lock(&alias->d_lock);
+
+		/* Is this a mountpoint that we could splice into our tree? */
+		if (IS_ROOT(alias)) {
+			/* Yes! Convert into an ordinary dentry */
+			d_materialise_dentry(dentry, alias);
+			found_alias = 1;
+		} else if (alias->d_name.len == dentry->d_name.len &&
+			   !memcmp(alias->d_name.name,
+				   dentry->d_name.name,
+				   dentry->d_name.len
+				   ) &&
+			   dentry->d_parent == alias->d_parent
+			   ) {
+			found_alias = 1;
+		}
+
+		spin_unlock(&alias->d_lock);
+		if (found_alias) {
+			iput(inode);
+			dput(dentry);
+			d_drop(alias);
+			d_rehash(alias);
+			dentry = alias;
+			goto use_extant_dentry;
+		}
+
+		/* Doh! Server appears to be aliasing directories */
+		dput(alias);
+	}
+
 	alias = d_add_unique(dentry, inode);
 	if (alias != NULL) {
 		dput(dentry);
 		dentry = alias;
 	}
+
+use_extant_dentry:
 	nfs_renew_times(dentry);
 	nfs_set_verifier(dentry, nfs_save_change_attribute(dir));
 	return dentry;
diff --git a/fs/nfs/getroot.c b/fs/nfs/getroot.c
new file mode 100644
index 0000000..9b72821
--- /dev/null
+++ b/fs/nfs/getroot.c
@@ -0,0 +1,237 @@
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
+	struct fs_struct fs, *realfs;
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
+		sb->s_root->d_op = NFS_PROTO(inode)->dentry_ops;
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
+	/* we're going to override this process's FS settings temporarily to
+	 * prevent absolute symlinks from escaping the namespace
+	 */
+	memset(&fs, 0, sizeof(fs));
+	rwlock_init(&fs.lock);
+	fs.root = mnt->mnt_root;
+	fs.pwd = mnt->mnt_root;
+	fs.rootmnt = mnt;
+	fs.pwdmnt = mnt;
+
+	/* set up the walk we're going to take */
+	memset(&nd, 0, sizeof(nd));
+	nd.last_type = LAST_ROOT;
+	nd.flags = LOOKUP_FOLLOW | LOOKUP_DIRECTORY | LOOKUP_ACCESS;
+	nd.depth = 0;
+
+	nd.mnt = mntget(namespace->root);
+	nd.dentry = dget(nd.mnt->mnt_root);
+
+	/* walk the walk */
+	current->total_link_count = 0;
+	realfs = current->fs;
+	current->fs = &fs;
+	ret = link_path_walk(mntpath, &nd);
+	current->fs = realfs;
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
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 05cd386..7711c7d 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -44,6 +44,7 @@
 #include "callback.h"
 #include "delegation.h"
 #include "iostat.h"
+#include "internal.h"
 
 #define NFSDBG_FACILITY		NFSDBG_VFS
 #define NFS_PARANOIA 1
@@ -235,88 +236,85 @@ nfs_block_size(unsigned long bsize, unsi
 }
 
 /*
- * Obtain the root inode of the file system.
+ * Allocate and initialise a server record
  */
-static struct inode *
-nfs_get_root(struct super_block *sb, struct nfs_fh *rootfh, struct nfs_fsinfo *fsinfo)
+static struct nfs_server *nfs_alloc_server(void)
 {
-	struct nfs_server	*server = NFS_SB(sb);
-	struct inode *rooti;
-	int			error;
+	struct nfs_server *server;
 
-	error = server->rpc_ops->getroot(server, rootfh, fsinfo);
-	if (error < 0) {
-		dprintk("nfs_get_root: getattr error = %d\n", -error);
-		return ERR_PTR(error);
+	server = kzalloc(sizeof(struct nfs_server), GFP_KERNEL);
+	if (!server)
+		return NULL;
+
+	/* Zero out the NFS state stuff */
+	init_nfsv4_state(server);
+	server->client = server->client_sys = server->client_acl = ERR_PTR(-EINVAL);
+
+	server->io_stats = nfs_alloc_iostats();
+	if (!server->io_stats) {
+		kfree(server);
+		return NULL;
 	}
 
-	rooti = nfs_fhget(sb, rootfh, fsinfo->fattr);
-	if (!rooti)
-		return ERR_PTR(-ENOMEM);
-	return rooti;
+	return server;
 }
 
 /*
- * Do NFS version-independent mount processing, and sanity checking
+ * Free up a server record
  */
-static int
-nfs_sb_init(struct super_block *sb, rpc_authflavor_t authflavor)
+static void nfs_free_server(struct nfs_server *server)
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
-	unsigned long max_rpc_payload;
-
-	/* We probably want something more informative here */
-	snprintf(sb->s_id, sizeof(sb->s_id), "%x:%x", MAJOR(sb->s_dev), MINOR(sb->s_dev));
+	nfs_free_iostats(server->io_stats);
+	kfree(server->hostname);
+	kfree(server);
+}
 
-	server = NFS_SB(sb);
+/*
+ * Initialise the common bits of the superblock
+ */
+static inline void nfs_initialise_sb(struct super_block *sb)
+{
+	sb->s_magic = NFS_SUPER_MAGIC;
 
-	sb->s_magic      = NFS_SUPER_MAGIC;
+	/* We probably want something more informative here */
+	snprintf(sb->s_id, sizeof(sb->s_id),
+		 "%x:%x", MAJOR(sb->s_dev), MINOR(sb->s_dev));
+}
 
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
-	}
-	sb->s_root->d_op = server->rpc_ops->dentry_ops;
+/*
+ * Set the communications parameters
+ */
+static void nfs_set_comms_params(struct super_block *sb,
+				 struct nfs_fh *mntfh,
+				 struct nfs_fsinfo *fsinfo)
+{
+	struct nfs_pathconf pathinfo;
+	struct nfs_server *server;
+	unsigned long max_rpc_payload;
 
-	server->io_stats = nfs_alloc_iostats();
-	if (!server->io_stats) {
-		no_root_error = -ENOMEM;
-		goto out_no_root;
-	}
+	server = NFS_SB(sb);
 
 	/* mount time stamp, in seconds */
 	server->mount_time = jiffies;
 
 	/* Get some general file system info */
-	if (server->namelen == 0 &&
-	    server->rpc_ops->pathconf(server, &server->fh, &pathinfo) >= 0)
-		server->namelen = pathinfo.max_namelen;
+	if (server->namelen == 0) {
+		pathinfo.fattr = fsinfo->fattr; /* reuse the fsinfo's attrs */
+
+		if (server->rpc_ops->pathconf(server, mntfh, &pathinfo) >= 0)
+			server->namelen = pathinfo.max_namelen;
+	}
+
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
@@ -334,9 +332,9 @@ nfs_sb_init(struct super_block *sb, rpc_
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
@@ -349,7 +347,7 @@ nfs_sb_init(struct super_block *sb, rpc_
 	}
 	server->backing_dev_info.ra_pages = server->rpages * NFS_MAX_READAHEAD;
 
-	sb->s_maxbytes = fsinfo.maxfilesize;
+	sb->s_maxbytes = fsinfo->maxfilesize;
 	if (sb->s_maxbytes > MAX_LFS_FILESIZE) 
 		sb->s_maxbytes = MAX_LFS_FILESIZE; 
 
@@ -358,13 +356,6 @@ nfs_sb_init(struct super_block *sb, rpc_
 
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
@@ -536,9 +527,13 @@ nfs_fill_super(struct super_block *sb, s
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
@@ -1674,6 +1669,11 @@ static int nfs_update_inode(struct inode
 
 /*
  * File system information
+ * - superblocks are indexed on server only - all inodes, dentries, etc. associated with a
+ *   particular server are held in the same superblock
+ * - NFS superblocks can have several effective roots to the dentry tree
+ * - directory type roots are spliced into the tree when a path from one root reaches the root
+ *   of another (see nfs_lookup())
  */
 
 static int nfs_set_super(struct super_block *s, void *data)
@@ -1691,7 +1691,7 @@ static int nfs_compare_super(struct supe
 		return 0;
 	if (old->addr.sin_port != server->addr.sin_port)
 		return 0;
-	return !nfs_compare_fh(&old->fh, &server->fh);
+	return 1;
 }
 
 static int nfs_get_sb(struct file_system_type *fs_type,
@@ -1700,8 +1700,9 @@ static int nfs_get_sb(struct file_system
 	int error;
 	struct nfs_server *server = NULL;
 	struct super_block *s;
-	struct nfs_fh *root;
+	struct nfs_fh mntfh;
 	struct nfs_mount_data *data = raw_data;
+	struct dentry *mntroot;
 
 	error = -EINVAL;
 	if (data == NULL) {
@@ -1746,24 +1747,25 @@ static int nfs_get_sb(struct file_system
 #endif /* CONFIG_NFS_V3 */
 
 	error = -ENOMEM;
-	server = kzalloc(sizeof(struct nfs_server), GFP_KERNEL);
+	server = nfs_alloc_server();
 	if (!server)
 		goto out_err;
-	/* Zero out the NFS state stuff */
-	init_nfsv4_state(server);
-	server->client = server->client_sys = server->client_acl = ERR_PTR(-EINVAL);
 
-	root = &server->fh;
 	if (data->flags & NFS_MOUNT_VER3)
-		root->size = data->root.size;
+		mntfh.size = data->root.size;
 	else
-		root->size = NFS2_FHSIZE;
+		mntfh.size = NFS2_FHSIZE;
+
 	error = -EINVAL;
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
@@ -1781,32 +1783,41 @@ static int nfs_get_sb(struct file_system
 		goto out_err;
 	}
 
+	/* Get a superblock - note that we may end up sharing one that already exists */
 	s = sget(fs_type, nfs_compare_super, nfs_set_super, server);
 	if (IS_ERR(s)) {
 		error = PTR_ERR(s);
 		goto out_err_rpciod;
 	}
 
-	if (s->s_root) {
-		rpciod_down();
-		goto sb_already_active;
+	if (!s->s_root) {
+		/* initial superblock/root creation */
+		s->s_flags = flags;
+
+		error = nfs_fill_super(s, data, flags & MS_VERBOSE ? 1 : 0);
+		if (error)
+			goto error_splat_super;
 	}
 
-	s->s_flags = flags;
-
-	error = nfs_fill_super(s, data, flags & MS_VERBOSE ? 1 : 0);
-	if (error) {
-		up_write(&s->s_umount);
-		deactivate_super(s);
-		return error;
+	mntroot = nfs_get_root(s, &mntfh, s->s_root ? NULL : nfs_set_comms_params);
+	if (IS_ERR(mntroot)) {
+		error = PTR_ERR(mntroot);
+		goto error_splat_super;
 	}
 	s->s_flags |= MS_ACTIVE;
-sb_already_active:
-	return simple_set_mnt(mnt, s);
+	mnt->mnt_sb = s;
+	mnt->mnt_root = mntroot;
+	return 0;
+
 out_err_rpciod:
 	rpciod_down();
 out_err:
-	kfree(server);
+	nfs_free_server(server);
+	return error;
+
+error_splat_super:
+	up_write(&s->s_umount);
+	deactivate_super(s);
 	return error;
 }
 
@@ -1828,8 +1839,7 @@ static void nfs_kill_super(struct super_
 
 	rpciod_down();		/* release rpciod */
 
-	kfree(server->hostname);
-	kfree(server);
+	nfs_free_server(server);
 }
 
 static struct file_system_type nfs_fs_type = {
@@ -2000,9 +2010,8 @@ static int nfs4_fill_super(struct super_
 	sb->s_time_gran = 1;
 
 	sb->s_op = &nfs4_sops;
-	err = nfs_sb_init(sb, authflavour);
-	if (err == 0)
-		return 0;
+	nfs_initialise_sb(sb);
+	return 0;
 out_fail:
 	if (clp)
 		nfs4_put_client(clp);
@@ -2016,8 +2025,6 @@ static int nfs4_compare_super(struct sup
 
 	if (strcmp(server->hostname, old->hostname) != 0)
 		return 0;
-	if (strcmp(server->mnt_path, old->mnt_path) != 0)
-		return 0;
 	return 1;
 }
 
@@ -2050,6 +2057,8 @@ static int nfs4_get_sb(struct file_syste
 	struct nfs_server *server;
 	struct super_block *s;
 	struct nfs4_mount_data *data = raw_data;
+	struct dentry *mntroot;
+	char *mntpath = NULL;
 	void *p;
 
 	if (data == NULL) {
@@ -2061,12 +2070,9 @@ static int nfs4_get_sb(struct file_syste
 		return -EINVAL;
 	}
 
-	server = kzalloc(sizeof(struct nfs_server), GFP_KERNEL);
+	server = nfs_alloc_server();
 	if (!server)
 		return -ENOMEM;
-	/* Zero out the NFS state stuff */
-	init_nfsv4_state(server);
-	server->client = server->client_sys = server->client_acl = ERR_PTR(-EINVAL);
 
 	p = nfs_copy_user_string(NULL, &data->hostname, 256);
 	if (IS_ERR(p))
@@ -2076,7 +2082,7 @@ static int nfs4_get_sb(struct file_syste
 	p = nfs_copy_user_string(NULL, &data->mnt_path, 1024);
 	if (IS_ERR(p))
 		goto out_err;
-	server->mnt_path = p;
+	mntpath = p;
 
 	p = nfs_copy_user_string(server->ip_addr, &data->client_addr,
 			sizeof(server->ip_addr) - 1);
@@ -2108,6 +2114,7 @@ static int nfs4_get_sb(struct file_syste
 		goto out_free;
 	}
 
+	/* Get a superblock - note that we may end up sharing one that already exists */
 	s = sget(fs_type, nfs4_compare_super, nfs_set_super, server);
 	if (IS_ERR(s)) {
 		error = PTR_ERR(s);
@@ -2115,29 +2122,40 @@ static int nfs4_get_sb(struct file_syste
 		goto out_free;
 	}
 
-	if (s->s_root) {
-		rpciod_down();
-		error = simple_set_mnt(mnt, s);
-		goto out_free;
+	if (!s->s_root) {
+		/* initial superblock/root creation */
+		s->s_flags = flags;
+
+		error = nfs4_fill_super(s, data, flags & MS_VERBOSE ? 1 : 0);
+		if (error)
+			goto error_splat_super;
+	} else {
+		nfs_free_server(server);
 	}
 
-	s->s_flags = flags;
-
-	error = nfs4_fill_super(s, data, flags & MS_VERBOSE ? 1 : 0);
-	if (error) {
-		up_write(&s->s_umount);
-		deactivate_super(s);
-		goto out_free;
+	mntroot = nfs4_get_root(s, mntpath, nfs_set_comms_params);
+	if (IS_ERR(mntroot)) {
+		error = PTR_ERR(mntroot);
+		goto error_splat_super;
 	}
+
+	kfree(mntpath);
 	s->s_flags |= MS_ACTIVE;
-	return simple_set_mnt(mnt, s);
+	mnt->mnt_sb = s;
+	mnt->mnt_root = mntroot;
+	return 0;
+
 out_err:
 	error = PTR_ERR(p);
 out_free:
-	kfree(server->mnt_path);
-	kfree(server->hostname);
-	nfs_free_iostats(server->io_stats);
-	kfree(server);
+	nfs_free_server(server);
+	kfree(mntpath);
+	return error;
+
+error_splat_super:
+	up_write(&s->s_umount);
+	deactivate_super(s);
+	kfree(mntpath);
 	return error;
 }
 
@@ -2157,8 +2175,7 @@ static void nfs4_kill_super(struct super
 
 	rpciod_down();
 
-	kfree(server->hostname);
-	kfree(server);
+	nfs_free_server(server);
 }
 
 static struct file_system_type nfs4_fs_type = {
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
new file mode 100644
index 0000000..25f554f
--- /dev/null
+++ b/fs/nfs/internal.h
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
diff --git a/fs/nfs/nfs3proc.c b/fs/nfs/nfs3proc.c
index cf186f0..fdcee05 100644
--- a/fs/nfs/nfs3proc.c
+++ b/fs/nfs/nfs3proc.c
@@ -82,7 +82,7 @@ do_proc_get_root(struct rpc_clnt *client
 }
 
 /*
- * Bare-bones access to getattr: this is for nfs_read_super.
+ * Bare-bones access to getattr: this is for nfs_get_root/nfs_get_sb
  */
 static int
 nfs3_proc_get_root(struct nfs_server *server, struct nfs_fh *fhandle,
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 2144129..eba5c49 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -1367,70 +1367,19 @@ static int nfs4_lookup_root(struct nfs_s
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
 
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index afad025..dbe3adf 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -69,8 +69,6 @@ init_nfsv4_state(struct nfs_server *serv
 void
 destroy_nfsv4_state(struct nfs_server *server)
 {
-	kfree(server->mnt_path);
-	server->mnt_path = NULL;
 	if (server->nfs4_state) {
 		nfs4_put_client(server->nfs4_state);
 		server->nfs4_state = NULL;
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index 65dec21..691a6cc 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -33,7 +33,6 @@ struct nfs_server {
 	unsigned int		retrans_count;	/* number of retransmit tries */
 	unsigned int		namelen;
 	char *			hostname;	/* remote hostname */
-	struct nfs_fh		fh;
 	struct sockaddr_in	addr;
 	unsigned long		mount_time;	/* when this fs was mounted */
 #ifdef CONFIG_NFS_V4
@@ -41,7 +40,6 @@ struct nfs_server {
 	 * This is used to generate the clientid, and the callback address.
 	 */
 	char			ip_addr[16];
-	char *			mnt_path;
 	struct nfs4_client *	nfs4_state;	/* all NFSv4 state starts here */
 	struct list_head	nfs4_siblings;	/* List of other nfs_server structs
 						 * that share the same clientid
