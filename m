Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751625AbWB0HCa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751625AbWB0HCa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 02:02:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751627AbWB0HC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 02:02:29 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:61342 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751605AbWB0HC3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 02:02:29 -0500
From: Paul Jackson <pj@sgi.com>
To: akpm@osdl.org
Cc: dgc@sgi.com, steiner@sgi.com, Simon.Derr@bull.net, ak@suse.de,
       linux-kernel@vger.kernel.org, Paul Jackson <pj@sgi.com>,
       clameter@sgi.com
Date: Sun, 26 Feb 2006 23:02:09 -0800
Message-Id: <20060227070209.1994.26823.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH 01/02] cpuset memory spread slab cache filesys
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Jackson <pj@sgi.com>

Mark file system inode and similar slab caches subject to
SLAB_MEM_SPREAD memory spreading.

If a slab cache is marked SLAB_MEM_SPREAD, then anytime that
a task that's in a cpuset with the 'memory_spread_slab' option
enabled goes to allocate from such a slab cache, the allocations
are spread evenly over all the memory nodes (task->mems_allowed)
allowed to that task, instead of favoring allocation on the
node local to the current cpu.

The following inode and similar caches are marked SLAB_MEM_SPREAD:

    file                               cache
    ====                               =====
    fs/adfs/super.c                    adfs_inode_cache
    fs/affs/super.c                    affs_inode_cache
    fs/befs/linuxvfs.c                 befs_inode_cache
    fs/bfs/inode.c                     bfs_inode_cache
    fs/block_dev.c                     bdev_cache
    fs/cifs/cifsfs.c                   cifs_inode_cache
    fs/coda/inode.c                    coda_inode_cache
    fs/dquot.c                         dquot
    fs/efs/super.c                     efs_inode_cache
    fs/ext2/super.c                    ext2_inode_cache
    fs/ext2/xattr.c (fs/mbcache.c)     ext2_xattr
    fs/ext3/super.c                    ext3_inode_cache
    fs/ext3/xattr.c (fs/mbcache.c)     ext3_xattr
    fs/fat/cache.c                     fat_cache
    fs/fat/inode.c                     fat_inode_cache
    fs/freevxfs/vxfs_super.c           vxfs_inode
    fs/hpfs/super.c                    hpfs_inode_cache
    fs/isofs/inode.c                   isofs_inode_cache
    fs/jffs/inode-v23.c                jffs_fm
    fs/jffs2/super.c                   jffs2_i
    fs/jfs/super.c                     jfs_ip
    fs/minix/inode.c                   minix_inode_cache
    fs/ncpfs/inode.c                   ncp_inode_cache
    fs/nfs/direct.c                    nfs_direct_cache
    fs/nfs/inode.c                     nfs_inode_cache
    fs/ntfs/super.c                    ntfs_big_inode_cache_name
    fs/ntfs/super.c                    ntfs_inode_cache
    fs/ocfs2/dlm/dlmfs.c               dlmfs_inode_cache
    fs/ocfs2/super.c                   ocfs2_inode_cache
    fs/proc/inode.c                    proc_inode_cache
    fs/qnx4/inode.c                    qnx4_inode_cache
    fs/reiserfs/super.c                reiser_inode_cache
    fs/romfs/inode.c                   romfs_inode_cache
    fs/smbfs/inode.c                   smb_inode_cache
    fs/sysv/inode.c                    sysv_inode_cache
    fs/udf/super.c                     udf_inode_cache
    fs/ufs/super.c                     ufs_inode_cache
    net/socket.c                       sock_inode_cache
    net/sunrpc/rpc_pipe.c              rpc_inode_cache

The choice of which slab caches to so mark was quite simple.  I
marked those already marked SLAB_RECLAIM_ACCOUNT, except for
fs/xfs, dentry_cache, inode_cache, and buffer_head, which were
marked in a previous patch.  Even though SLAB_RECLAIM_ACCOUNT is
for a different purpose, it marks the same potentially large file
system i/o related slab caches as we need for memory spreading.

Given that the rule now becomes "wherever you would have used a
SLAB_RECLAIM_ACCOUNT slab cache flag before (usually the inode
cache), use the SLAB_MEM_SPREAD flag too", this should be easy
enough to maintain.  Future file system writers will just copy
one of the existing file system slab cache setups and tend to
get it right without thinking.

==> This patch violates line length constraints, pushing
    many lines past 80 columns.  The next patch wraps
    text to fit within 80 columns again.  I split these
    two so that it would be easy to see the changes caused
    by adding the SLAB_MEM_SPREAD option separately from
    the formatting changes caused by rewrapping source lines.

Signed-off-by: Paul Jackson <pj@sgi.com>

---

Andrew - these two cpuset-memory-spread-slab-cache-hooks-filesys
and *-spacing patches should fit nicely in your *-mm stack,
right after cpuset-memory-spread-slab-cache-hooks.patch.    -pj


 fs/adfs/super.c          |    2 +-
 fs/affs/super.c          |    2 +-
 fs/befs/linuxvfs.c       |    2 +-
 fs/bfs/inode.c           |    2 +-
 fs/block_dev.c           |    2 +-
 fs/cifs/cifsfs.c         |    2 +-
 fs/coda/inode.c          |    2 +-
 fs/dquot.c               |    2 +-
 fs/efs/super.c           |    2 +-
 fs/ext2/super.c          |    2 +-
 fs/ext3/super.c          |    2 +-
 fs/fat/cache.c           |    2 +-
 fs/fat/inode.c           |    2 +-
 fs/freevxfs/vxfs_super.c |    2 +-
 fs/hpfs/super.c          |    2 +-
 fs/isofs/inode.c         |    2 +-
 fs/jffs/inode-v23.c      |    4 ++--
 fs/jffs2/super.c         |    2 +-
 fs/jfs/super.c           |    2 +-
 fs/mbcache.c             |    2 +-
 fs/minix/inode.c         |    2 +-
 fs/ncpfs/inode.c         |    2 +-
 fs/nfs/direct.c          |    2 +-
 fs/nfs/inode.c           |    2 +-
 fs/ntfs/super.c          |    4 ++--
 fs/ocfs2/dlm/dlmfs.c     |    2 +-
 fs/ocfs2/super.c         |    2 +-
 fs/proc/inode.c          |    2 +-
 fs/qnx4/inode.c          |    2 +-
 fs/reiserfs/super.c      |    2 +-
 fs/romfs/inode.c         |    2 +-
 fs/smbfs/inode.c         |    2 +-
 fs/sysv/inode.c          |    2 +-
 fs/udf/super.c           |    2 +-
 fs/ufs/super.c           |    2 +-
 net/socket.c             |    2 +-
 net/sunrpc/rpc_pipe.c    |    2 +-
 37 files changed, 39 insertions(+), 39 deletions(-)

--- 2.6.16-rc4-mm2.orig/fs/adfs/super.c	2006-02-26 17:53:50.424915062 -0800
+++ 2.6.16-rc4-mm2/fs/adfs/super.c	2006-02-26 18:40:51.420223812 -0800
@@ -241,7 +241,7 @@ static int init_inodecache(void)
 {
 	adfs_inode_cachep = kmem_cache_create("adfs_inode_cache",
 					     sizeof(struct adfs_inode_info),
-					     0, SLAB_RECLAIM_ACCOUNT,
+					     0, SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD,
 					     init_once, NULL);
 	if (adfs_inode_cachep == NULL)
 		return -ENOMEM;
--- 2.6.16-rc4-mm2.orig/fs/affs/super.c	2006-02-26 17:53:50.546986722 -0800
+++ 2.6.16-rc4-mm2/fs/affs/super.c	2006-02-26 18:40:51.431942693 -0800
@@ -98,7 +98,7 @@ static int init_inodecache(void)
 {
 	affs_inode_cachep = kmem_cache_create("affs_inode_cache",
 					     sizeof(struct affs_inode_info),
-					     0, SLAB_RECLAIM_ACCOUNT,
+					     0, SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD,
 					     init_once, NULL);
 	if (affs_inode_cachep == NULL)
 		return -ENOMEM;
--- 2.6.16-rc4-mm2.orig/fs/befs/linuxvfs.c	2006-02-26 17:53:51.230588018 -0800
+++ 2.6.16-rc4-mm2/fs/befs/linuxvfs.c	2006-02-26 18:40:51.436825560 -0800
@@ -427,7 +427,7 @@ befs_init_inodecache(void)
 {
 	befs_inode_cachep = kmem_cache_create("befs_inode_cache",
 					      sizeof (struct befs_inode_info),
-					      0, SLAB_RECLAIM_ACCOUNT,
+					      0, SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD,
 					      init_once, NULL);
 	if (befs_inode_cachep == NULL) {
 		printk(KERN_ERR "befs_init_inodecache: "
--- 2.6.16-rc4-mm2.orig/fs/bfs/inode.c	2006-02-26 17:53:51.320432760 -0800
+++ 2.6.16-rc4-mm2/fs/bfs/inode.c	2006-02-26 18:40:51.440731854 -0800
@@ -257,7 +257,7 @@ static int init_inodecache(void)
 {
 	bfs_inode_cachep = kmem_cache_create("bfs_inode_cache",
 					     sizeof(struct bfs_inode_info),
-					     0, SLAB_RECLAIM_ACCOUNT,
+					     0, SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD,
 					     init_once, NULL);
 	if (bfs_inode_cachep == NULL)
 		return -ENOMEM;
--- 2.6.16-rc4-mm2.orig/fs/block_dev.c	2006-02-26 18:32:36.363896034 -0800
+++ 2.6.16-rc4-mm2/fs/block_dev.c	2006-02-26 18:40:51.441708427 -0800
@@ -319,7 +319,7 @@ void __init bdev_cache_init(void)
 {
 	int err;
 	bdev_cachep = kmem_cache_create("bdev_cache", sizeof(struct bdev_inode),
-			0, SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT|SLAB_PANIC,
+			0, SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD|SLAB_PANIC,
 			init_once, NULL);
 	err = register_filesystem(&bd_type);
 	if (err)
--- 2.6.16-rc4-mm2.orig/fs/cifs/cifsfs.c	2006-02-26 18:32:13.289418922 -0800
+++ 2.6.16-rc4-mm2/fs/cifs/cifsfs.c	2006-02-26 18:40:51.444638148 -0800
@@ -692,7 +692,7 @@ cifs_init_inodecache(void)
 {
 	cifs_inode_cachep = kmem_cache_create("cifs_inode_cache",
 					      sizeof (struct cifsInodeInfo),
-					      0, SLAB_RECLAIM_ACCOUNT,
+					      0, SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD,
 					      cifs_init_once, NULL);
 	if (cifs_inode_cachep == NULL)
 		return -ENOMEM;
--- 2.6.16-rc4-mm2.orig/fs/coda/inode.c	2006-02-26 18:32:39.268225430 -0800
+++ 2.6.16-rc4-mm2/fs/coda/inode.c	2006-02-26 18:40:51.447567868 -0800
@@ -71,7 +71,7 @@ int coda_init_inodecache(void)
 {
 	coda_inode_cachep = kmem_cache_create("coda_inode_cache",
 				sizeof(struct coda_inode_info),
-				0, SLAB_RECLAIM_ACCOUNT,
+				0, SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD,
 				init_once, NULL);
 	if (coda_inode_cachep == NULL)
 		return -ENOMEM;
--- 2.6.16-rc4-mm2.orig/fs/dquot.c	2006-02-26 18:32:36.401982398 -0800
+++ 2.6.16-rc4-mm2/fs/dquot.c	2006-02-26 18:40:51.449521015 -0800
@@ -1817,7 +1817,7 @@ static int __init dquot_init(void)
 
 	dquot_cachep = kmem_cache_create("dquot", 
 			sizeof(struct dquot), sizeof(unsigned long) * 4,
-			SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT|SLAB_PANIC,
+			SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD|SLAB_PANIC,
 			NULL, NULL);
 
 	order = 0;
--- 2.6.16-rc4-mm2.orig/fs/efs/super.c	2006-02-26 17:53:54.602695556 -0800
+++ 2.6.16-rc4-mm2/fs/efs/super.c	2006-02-26 18:40:51.451474162 -0800
@@ -81,7 +81,7 @@ static int init_inodecache(void)
 {
 	efs_inode_cachep = kmem_cache_create("efs_inode_cache",
 				sizeof(struct efs_inode_info),
-				0, SLAB_RECLAIM_ACCOUNT,
+				0, SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD,
 				init_once, NULL);
 	if (efs_inode_cachep == NULL)
 		return -ENOMEM;
--- 2.6.16-rc4-mm2.orig/fs/ext2/super.c	2006-02-26 18:32:39.237951654 -0800
+++ 2.6.16-rc4-mm2/fs/ext2/super.c	2006-02-26 18:40:51.453427309 -0800
@@ -175,7 +175,7 @@ static int init_inodecache(void)
 {
 	ext2_inode_cachep = kmem_cache_create("ext2_inode_cache",
 					     sizeof(struct ext2_inode_info),
-					     0, SLAB_RECLAIM_ACCOUNT,
+					     0, SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD,
 					     init_once, NULL);
 	if (ext2_inode_cachep == NULL)
 		return -ENOMEM;
--- 2.6.16-rc4-mm2.orig/fs/ext3/super.c	2006-02-26 18:32:37.414689050 -0800
+++ 2.6.16-rc4-mm2/fs/ext3/super.c	2006-02-26 18:40:51.458310176 -0800
@@ -481,7 +481,7 @@ static int init_inodecache(void)
 {
 	ext3_inode_cachep = kmem_cache_create("ext3_inode_cache",
 					     sizeof(struct ext3_inode_info),
-					     0, SLAB_RECLAIM_ACCOUNT,
+					     0, SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD,
 					     init_once, NULL);
 	if (ext3_inode_cachep == NULL)
 		return -ENOMEM;
--- 2.6.16-rc4-mm2.orig/fs/fat/cache.c	2006-02-26 17:53:55.388837047 -0800
+++ 2.6.16-rc4-mm2/fs/fat/cache.c	2006-02-26 18:40:51.460263323 -0800
@@ -49,7 +49,7 @@ int __init fat_cache_init(void)
 {
 	fat_cache_cachep = kmem_cache_create("fat_cache",
 				sizeof(struct fat_cache),
-				0, SLAB_RECLAIM_ACCOUNT,
+				0, SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD,
 				init_once, NULL);
 	if (fat_cache_cachep == NULL)
 		return -ENOMEM;
--- 2.6.16-rc4-mm2.orig/fs/fat/inode.c	2006-02-26 17:53:55.446454870 -0800
+++ 2.6.16-rc4-mm2/fs/fat/inode.c	2006-02-26 18:40:51.462216470 -0800
@@ -518,7 +518,7 @@ static int __init fat_init_inodecache(vo
 {
 	fat_inode_cachep = kmem_cache_create("fat_inode_cache",
 					     sizeof(struct msdos_inode_info),
-					     0, SLAB_RECLAIM_ACCOUNT,
+					     0, SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD,
 					     init_once, NULL);
 	if (fat_inode_cachep == NULL)
 		return -ENOMEM;
--- 2.6.16-rc4-mm2.orig/fs/freevxfs/vxfs_super.c	2006-02-26 17:53:55.733567415 -0800
+++ 2.6.16-rc4-mm2/fs/freevxfs/vxfs_super.c	2006-02-26 18:40:51.465146190 -0800
@@ -260,7 +260,7 @@ vxfs_init(void)
 {
 	vxfs_inode_cachep = kmem_cache_create("vxfs_inode",
 			sizeof(struct vxfs_inode_info), 0, 
-			SLAB_RECLAIM_ACCOUNT, NULL, NULL);
+			SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD, NULL, NULL);
 	if (vxfs_inode_cachep)
 		return register_filesystem(&vxfs_fs_type);
 	return -ENOMEM;
--- 2.6.16-rc4-mm2.orig/fs/hpfs/super.c	2006-02-26 18:32:37.378555833 -0800
+++ 2.6.16-rc4-mm2/fs/hpfs/super.c	2006-02-26 18:40:51.467099337 -0800
@@ -191,7 +191,7 @@ static int init_inodecache(void)
 {
 	hpfs_inode_cachep = kmem_cache_create("hpfs_inode_cache",
 					     sizeof(struct hpfs_inode_info),
-					     0, SLAB_RECLAIM_ACCOUNT,
+					     0, SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD,
 					     init_once, NULL);
 	if (hpfs_inode_cachep == NULL)
 		return -ENOMEM;
--- 2.6.16-rc4-mm2.orig/fs/isofs/inode.c	2006-02-26 17:53:57.740425507 -0800
+++ 2.6.16-rc4-mm2/fs/isofs/inode.c	2006-02-26 18:40:51.471005631 -0800
@@ -87,7 +87,7 @@ static int init_inodecache(void)
 {
 	isofs_inode_cachep = kmem_cache_create("isofs_inode_cache",
 					     sizeof(struct iso_inode_info),
-					     0, SLAB_RECLAIM_ACCOUNT,
+					     0, SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD,
 					     init_once, NULL);
 	if (isofs_inode_cachep == NULL)
 		return -ENOMEM;
--- 2.6.16-rc4-mm2.orig/fs/jffs/inode-v23.c	2006-02-26 18:32:37.170545692 -0800
+++ 2.6.16-rc4-mm2/fs/jffs/inode-v23.c	2006-02-26 18:40:51.473935351 -0800
@@ -1812,14 +1812,14 @@ init_jffs_fs(void)
 	}
 #endif
 	fm_cache = kmem_cache_create("jffs_fm", sizeof(struct jffs_fm),
-				     0, SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT, 
+				     0, SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD,
 				     NULL, NULL);
 	if (!fm_cache) {
 		return -ENOMEM;
 	}
 
 	node_cache = kmem_cache_create("jffs_node",sizeof(struct jffs_node),
-				       0, SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT, 
+				       0, SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD,
 				       NULL, NULL);
 	if (!node_cache) {
 		kmem_cache_destroy(fm_cache);
--- 2.6.16-rc4-mm2.orig/fs/jffs2/super.c	2006-02-26 17:53:59.195519696 -0800
+++ 2.6.16-rc4-mm2/fs/jffs2/super.c	2006-02-26 18:40:51.477841645 -0800
@@ -331,7 +331,7 @@ static int __init init_jffs2_fs(void)
 
 	jffs2_inode_cachep = kmem_cache_create("jffs2_i",
 					     sizeof(struct jffs2_inode_info),
-					     0, SLAB_RECLAIM_ACCOUNT,
+					     0, SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD,
 					     jffs2_i_init_once, NULL);
 	if (!jffs2_inode_cachep) {
 		printk(KERN_ERR "JFFS2 error: Failed to initialise inode cache\n");
--- 2.6.16-rc4-mm2.orig/fs/jfs/super.c	2006-02-26 18:32:16.663480138 -0800
+++ 2.6.16-rc4-mm2/fs/jfs/super.c	2006-02-26 18:40:51.479794792 -0800
@@ -634,7 +634,7 @@ static int __init init_jfs_fs(void)
 
 	jfs_inode_cachep =
 	    kmem_cache_create("jfs_ip", sizeof(struct jfs_inode_info), 0, 
-			    SLAB_RECLAIM_ACCOUNT, init_once, NULL);
+			    SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD, init_once, NULL);
 	if (jfs_inode_cachep == NULL)
 		return -ENOMEM;
 
--- 2.6.16-rc4-mm2.orig/fs/mbcache.c	2006-02-26 17:53:59.930879377 -0800
+++ 2.6.16-rc4-mm2/fs/mbcache.c	2006-02-26 18:40:51.480771365 -0800
@@ -288,7 +288,7 @@ mb_cache_create(const char *name, struct
 			INIT_LIST_HEAD(&cache->c_indexes_hash[m][n]);
 	}
 	cache->c_entry_cache = kmem_cache_create(name, entry_size, 0,
-		SLAB_RECLAIM_ACCOUNT, NULL, NULL);
+		SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD, NULL, NULL);
 	if (!cache->c_entry_cache)
 		goto fail;
 
--- 2.6.16-rc4-mm2.orig/fs/minix/inode.c	2006-02-26 17:53:59.975801748 -0800
+++ 2.6.16-rc4-mm2/fs/minix/inode.c	2006-02-26 18:40:51.508115422 -0800
@@ -80,7 +80,7 @@ static int init_inodecache(void)
 {
 	minix_inode_cachep = kmem_cache_create("minix_inode_cache",
 					     sizeof(struct minix_inode_info),
-					     0, SLAB_RECLAIM_ACCOUNT,
+					     0, SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD,
 					     init_once, NULL);
 	if (minix_inode_cachep == NULL)
 		return -ENOMEM;
--- 2.6.16-rc4-mm2.orig/fs/ncpfs/inode.c	2006-02-26 18:32:37.448869121 -0800
+++ 2.6.16-rc4-mm2/fs/ncpfs/inode.c	2006-02-26 18:40:51.512021716 -0800
@@ -72,7 +72,7 @@ static int init_inodecache(void)
 {
 	ncp_inode_cachep = kmem_cache_create("ncp_inode_cache",
 					     sizeof(struct ncp_inode_info),
-					     0, SLAB_RECLAIM_ACCOUNT,
+					     0, SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD,
 					     init_once, NULL);
 	if (ncp_inode_cachep == NULL)
 		return -ENOMEM;
--- 2.6.16-rc4-mm2.orig/fs/nfs/direct.c	2006-02-26 17:54:00.385962526 -0800
+++ 2.6.16-rc4-mm2/fs/nfs/direct.c	2006-02-26 18:40:51.513974863 -0800
@@ -771,7 +771,7 @@ int nfs_init_directcache(void)
 {
 	nfs_direct_cachep = kmem_cache_create("nfs_direct_cache",
 						sizeof(struct nfs_direct_req),
-						0, SLAB_RECLAIM_ACCOUNT,
+						0, SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD,
 						NULL, NULL);
 	if (nfs_direct_cachep == NULL)
 		return -ENOMEM;
--- 2.6.16-rc4-mm2.orig/fs/nfs/inode.c	2006-02-26 18:32:38.669585914 -0800
+++ 2.6.16-rc4-mm2/fs/nfs/inode.c	2006-02-26 18:40:51.515928009 -0800
@@ -2163,7 +2163,7 @@ static int nfs_init_inodecache(void)
 {
 	nfs_inode_cachep = kmem_cache_create("nfs_inode_cache",
 					     sizeof(struct nfs_inode),
-					     0, SLAB_RECLAIM_ACCOUNT,
+					     0, SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD,
 					     init_once, NULL);
 	if (nfs_inode_cachep == NULL)
 		return -ENOMEM;
--- 2.6.16-rc4-mm2.orig/fs/ntfs/super.c	2006-02-26 18:32:37.234022965 -0800
+++ 2.6.16-rc4-mm2/fs/ntfs/super.c	2006-02-26 18:40:51.518857730 -0800
@@ -3084,7 +3084,7 @@ static int __init init_ntfs_fs(void)
 
 	ntfs_inode_cache = kmem_cache_create(ntfs_inode_cache_name,
 			sizeof(ntfs_inode), 0,
-			SLAB_RECLAIM_ACCOUNT, NULL, NULL);
+			SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD, NULL, NULL);
 	if (!ntfs_inode_cache) {
 		printk(KERN_CRIT "NTFS: Failed to create %s!\n",
 				ntfs_inode_cache_name);
@@ -3093,7 +3093,7 @@ static int __init init_ntfs_fs(void)
 
 	ntfs_big_inode_cache = kmem_cache_create(ntfs_big_inode_cache_name,
 			sizeof(big_ntfs_inode), 0,
-			SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT,
+			SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD,
 			ntfs_big_inode_init_once, NULL);
 	if (!ntfs_big_inode_cache) {
 		printk(KERN_CRIT "NTFS: Failed to create %s!\n",
--- 2.6.16-rc4-mm2.orig/fs/ocfs2/dlm/dlmfs.c	2006-02-26 17:54:04.293232225 -0800
+++ 2.6.16-rc4-mm2/fs/ocfs2/dlm/dlmfs.c	2006-02-26 18:40:51.521787450 -0800
@@ -596,7 +596,7 @@ static int __init init_dlmfs_fs(void)
 
 	dlmfs_inode_cache = kmem_cache_create("dlmfs_inode_cache",
 				sizeof(struct dlmfs_inode_private),
-				0, SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT,
+				0, SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD,
 				dlmfs_init_once, NULL);
 	if (!dlmfs_inode_cache)
 		return -ENOMEM;
--- 2.6.16-rc4-mm2.orig/fs/ocfs2/super.c	2006-02-26 18:32:31.194892844 -0800
+++ 2.6.16-rc4-mm2/fs/ocfs2/super.c	2006-02-26 18:40:51.523740597 -0800
@@ -951,7 +951,7 @@ static int ocfs2_initialize_mem_caches(v
 {
 	ocfs2_inode_cachep = kmem_cache_create("ocfs2_inode_cache",
 					       sizeof(struct ocfs2_inode_info),
-					       0, SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT,
+					       0, SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD,
 					       ocfs2_inode_init_once, NULL);
 	if (!ocfs2_inode_cachep)
 		return -ENOMEM;
--- 2.6.16-rc4-mm2.orig/fs/proc/inode.c	2006-02-26 18:31:43.848659613 -0800
+++ 2.6.16-rc4-mm2/fs/proc/inode.c	2006-02-26 18:40:51.526670317 -0800
@@ -121,7 +121,7 @@ int __init proc_init_inodecache(void)
 {
 	proc_inode_cachep = kmem_cache_create("proc_inode_cache",
 					     sizeof(struct proc_inode),
-					     0, SLAB_RECLAIM_ACCOUNT,
+					     0, SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD,
 					     init_once, NULL);
 	if (proc_inode_cachep == NULL)
 		return -ENOMEM;
--- 2.6.16-rc4-mm2.orig/fs/qnx4/inode.c	2006-02-26 17:54:05.782506480 -0800
+++ 2.6.16-rc4-mm2/fs/qnx4/inode.c	2006-02-26 18:40:51.529600038 -0800
@@ -546,7 +546,7 @@ static int init_inodecache(void)
 {
 	qnx4_inode_cachep = kmem_cache_create("qnx4_inode_cache",
 					     sizeof(struct qnx4_inode_info),
-					     0, SLAB_RECLAIM_ACCOUNT,
+					     0, SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD,
 					     init_once, NULL);
 	if (qnx4_inode_cachep == NULL)
 		return -ENOMEM;
--- 2.6.16-rc4-mm2.orig/fs/reiserfs/super.c	2006-02-26 17:54:06.364544156 -0800
+++ 2.6.16-rc4-mm2/fs/reiserfs/super.c	2006-02-26 18:40:51.534482905 -0800
@@ -521,7 +521,7 @@ static int init_inodecache(void)
 	reiserfs_inode_cachep = kmem_cache_create("reiser_inode_cache",
 						  sizeof(struct
 							 reiserfs_inode_info),
-						  0, SLAB_RECLAIM_ACCOUNT,
+						  0, SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD,
 						  init_once, NULL);
 	if (reiserfs_inode_cachep == NULL)
 		return -ENOMEM;
--- 2.6.16-rc4-mm2.orig/fs/romfs/inode.c	2006-02-26 17:54:06.543257067 -0800
+++ 2.6.16-rc4-mm2/fs/romfs/inode.c	2006-02-26 18:40:51.536436052 -0800
@@ -579,7 +579,7 @@ static int init_inodecache(void)
 {
 	romfs_inode_cachep = kmem_cache_create("romfs_inode_cache",
 					     sizeof(struct romfs_inode_info),
-					     0, SLAB_RECLAIM_ACCOUNT,
+					     0, SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD,
 					     init_once, NULL);
 	if (romfs_inode_cachep == NULL)
 		return -ENOMEM;
--- 2.6.16-rc4-mm2.orig/fs/smbfs/inode.c	2006-02-26 17:54:06.662399007 -0800
+++ 2.6.16-rc4-mm2/fs/smbfs/inode.c	2006-02-26 18:40:51.539365772 -0800
@@ -80,7 +80,7 @@ static int init_inodecache(void)
 {
 	smb_inode_cachep = kmem_cache_create("smb_inode_cache",
 					     sizeof(struct smb_inode_info),
-					     0, SLAB_RECLAIM_ACCOUNT,
+					     0, SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD,
 					     init_once, NULL);
 	if (smb_inode_cachep == NULL)
 		return -ENOMEM;
--- 2.6.16-rc4-mm2.orig/fs/sysv/inode.c	2006-02-26 17:54:08.139954383 -0800
+++ 2.6.16-rc4-mm2/fs/sysv/inode.c	2006-02-26 18:40:51.544248639 -0800
@@ -342,7 +342,7 @@ int __init sysv_init_icache(void)
 {
 	sysv_inode_cachep = kmem_cache_create("sysv_inode_cache",
 			sizeof(struct sysv_inode_info), 0,
-			SLAB_RECLAIM_ACCOUNT,
+			SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD,
 			init_once, NULL);
 	if (!sysv_inode_cachep)
 		return -ENOMEM;
--- 2.6.16-rc4-mm2.orig/fs/udf/super.c	2006-02-26 18:32:38.690093957 -0800
+++ 2.6.16-rc4-mm2/fs/udf/super.c	2006-02-26 18:40:51.545225213 -0800
@@ -140,7 +140,7 @@ static int init_inodecache(void)
 {
 	udf_inode_cachep = kmem_cache_create("udf_inode_cache",
 					     sizeof(struct udf_inode_info),
-					     0, SLAB_RECLAIM_ACCOUNT,
+					     0, SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD,
 					     init_once, NULL);
 	if (udf_inode_cachep == NULL)
 		return -ENOMEM;
--- 2.6.16-rc4-mm2.orig/fs/ufs/super.c	2006-02-26 17:54:08.721015486 -0800
+++ 2.6.16-rc4-mm2/fs/ufs/super.c	2006-02-26 18:40:51.548154933 -0800
@@ -1184,7 +1184,7 @@ static int init_inodecache(void)
 {
 	ufs_inode_cachep = kmem_cache_create("ufs_inode_cache",
 					     sizeof(struct ufs_inode_info),
-					     0, SLAB_RECLAIM_ACCOUNT,
+					     0, SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD,
 					     init_once, NULL);
 	if (ufs_inode_cachep == NULL)
 		return -ENOMEM;
--- 2.6.16-rc4-mm2.orig/net/socket.c	2006-02-26 18:32:21.592246261 -0800
+++ 2.6.16-rc4-mm2/net/socket.c	2006-02-26 18:40:51.550108080 -0800
@@ -319,7 +319,7 @@ static int init_inodecache(void)
 {
 	sock_inode_cachep = kmem_cache_create("sock_inode_cache",
 				sizeof(struct socket_alloc),
-				0, SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT,
+				0, SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD,
 				init_once, NULL);
 	if (sock_inode_cachep == NULL)
 		return -ENOMEM;
--- 2.6.16-rc4-mm2.orig/net/sunrpc/rpc_pipe.c	2006-02-26 17:56:16.829852669 -0800
+++ 2.6.16-rc4-mm2/net/sunrpc/rpc_pipe.c	2006-02-26 18:40:51.554990947 -0800
@@ -850,7 +850,7 @@ int register_rpc_pipefs(void)
 {
 	rpc_inode_cachep = kmem_cache_create("rpc_inode_cache",
                                              sizeof(struct rpc_inode),
-                                             0, SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT,
+                                             0, SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD,
                                              init_once, NULL);
 	if (!rpc_inode_cachep)
 		return -ENOMEM;

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
