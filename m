Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966310AbWKNULw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966310AbWKNULw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 15:11:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966309AbWKNULZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 15:11:25 -0500
Received: from mx1.redhat.com ([66.187.233.31]:31402 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S966310AbWKNUJk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 15:09:40 -0500
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 06/19] FS-Cache: NFS: Only obtain cache cookies on file open, not on inode read
Date: Tue, 14 Nov 2006 20:06:34 +0000
To: torvalds@osdl.org, akpm@osdl.org, sds@tycho.nsa.gov,
       trond.myklebust@fys.uio.no
Cc: dhowells@redhat.com, selinux@tycho.nsa.gov, linux-kernel@vger.kernel.org,
       aviro@redhat.com, steved@redhat.com
Message-Id: <20061114200634.12943.6815.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20061114200621.12943.18023.stgit@warthog.cambridge.redhat.com>
References: <20061114200621.12943.18023.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make the NFS filesystem only obtain a cache cookie for a regular file when it's
actually opened rather than when the inode is fetched in.  Directories and
special files aren't currently cached on NFS.

Normally, in a filesystem, an inode would be instantiated only when it's
actually going to be used, but in the case of NFS it will be created by readdir
listing a directory entry referring to it too.

This meant that ls -lR or find would attempt to load all the regular file
inodes in a tree into the cache, rather than none of them.  With this patch,
none of them would be loaded.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 fs/nfs/fscache.h       |   41 ++++++++++++++++++++++++++++++++++++-----
 fs/nfs/inode.c         |    5 ++---
 include/linux/nfs_fs.h |    2 ++
 3 files changed, 40 insertions(+), 8 deletions(-)

diff --git a/fs/nfs/fscache.h b/fs/nfs/fscache.h
index 00a2c07..0be6ffe 100644
--- a/fs/nfs/fscache.h
+++ b/fs/nfs/fscache.h
@@ -90,14 +90,25 @@ static inline const char *nfs_server_fsc
 /*
  * get the per-filehandle cookie for an NFS inode
  */
-static inline void nfs_fscache_get_fh_cookie(struct inode *inode,
-					     int maycache)
+static inline void nfs_fscache_init_fh_cookie(struct inode *inode)
+{
+	NFS_I(inode)->fscache = NULL;
+	if (S_ISREG(inode->i_mode))
+		set_bit(NFS_INO_CACHEABLE, &NFS_I(inode)->flags);
+}
+
+/*
+ * get the per-filehandle cookie for an NFS inode
+ */
+static inline void nfs_fscache_enable_fh_cookie(struct inode *inode)
 {
 	struct super_block *sb = inode->i_sb;
 	struct nfs_inode *nfsi = NFS_I(inode);
 
-	nfsi->fscache = NULL;
-	if (maycache && (NFS_SB(sb)->flags & NFS_MOUNT_FSCACHE)) {
+	if (nfsi->fscache || !NFS_CACHEABLE(inode))
+		return;
+
+	if ((NFS_SB(sb)->flags & NFS_MOUNT_FSCACHE)) {
 		nfsi->fscache = fscache_acquire_cookie(
 			NFS_SB(sb)->nfs_client->fscache,
 			&nfs_cache_fh_index_def,
@@ -179,6 +190,8 @@ static inline void nfs_fscache_zap_fh_co
  */
 static inline void nfs_fscache_disable_fh_cookie(struct inode *inode)
 {
+	clear_bit(NFS_INO_CACHEABLE, &NFS_I(inode)->flags);
+
 	if (NFS_I(inode)->fscache) {
 		dfprintk(FSCACHE,
 			 "NFS: nfsi 0x%p turning cache off\n", NFS_I(inode));
@@ -194,6 +207,22 @@ static inline void nfs_fscache_disable_f
 }
 
 /*
+ * decide if we should enable or disable the FS cache for this inode
+ * - for now, only regular files that are open read-only will be able to use
+ *   the cache
+ */
+static inline void nfs_fscache_set_fh_cookie(struct inode *inode,
+					     struct file *filp)
+{
+	if (NFS_CACHEABLE(inode)) {
+		if ((filp->f_flags & O_ACCMODE) != O_RDONLY)
+			nfs_fscache_disable_fh_cookie(inode);
+		else
+			nfs_fscache_enable_fh_cookie(inode);
+	}
+}
+
+/*
  * install the VM ops for mmap() of an NFS file so that we can hold up writes
  * to pages on shared writable mappings until the store to the cache is
  * complete
@@ -431,12 +460,14 @@ static inline void nfs4_fscache_get_clie
 static inline void nfs_fscache_release_client_cookie(struct nfs_client *clp) {}
 static inline const char *nfs_server_fscache_state(struct nfs_server *server) { return "no "; }
 
-static inline void nfs_fscache_get_fh_cookie(struct inode *inode, int aycache) {}
+static inline void nfs_fscache_init_fh_cookie(struct inode *inode) {}
+static inline void nfs_fscache_enable_fh_cookie(struct inode *inode) {}
 static inline void nfs_fscache_set_size(struct inode *inode) {}
 static inline void nfs_fscache_release_fh_cookie(struct inode *inode) {}
 static inline void nfs_fscache_zap_fh_cookie(struct inode *inode) {}
 static inline void nfs_fscache_renew_fh_cookie(struct inode *inode) {}
 static inline void nfs_fscache_disable_fh_cookie(struct inode *inode) {}
+static inline void nfs_fscache_set_fh_cookie(struct inode *inode, struct file *filp) {}
 static inline void nfs_fscache_install_vm_ops(struct inode *inode, struct vm_area_struct *vma) {}
 static inline int nfs_fscache_release_page(struct page *page)
 {
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 56acba0..0d683eb 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -299,7 +299,7 @@ nfs_fhget(struct super_block *sb, struct
 		memset(nfsi->cookieverf, 0, sizeof(nfsi->cookieverf));
 		nfsi->access_cache = RB_ROOT;
 
-		nfs_fscache_get_fh_cookie(inode, maycache);
+		nfs_fscache_init_fh_cookie(inode);
 
 		unlock_new_inode(inode);
 	} else
@@ -566,8 +566,7 @@ int nfs_open(struct inode *inode, struct
 	ctx->mode = filp->f_mode;
 	nfs_file_set_open_context(filp, ctx);
 	put_nfs_open_context(ctx);
-	if ((filp->f_flags & O_ACCMODE) != O_RDONLY)
-		nfs_fscache_disable_fh_cookie(inode);
+	nfs_fscache_set_fh_cookie(inode, filp);
 	return 0;
 }
 
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 5ead2bf..b2e5e86 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -205,6 +205,7 @@ #define NFS_INO_REVALIDATING	(0)		/* rev
 #define NFS_INO_ADVISE_RDPLUS	(1)		/* advise readdirplus */
 #define NFS_INO_STALE		(2)		/* possible stale inode */
 #define NFS_INO_ACL_LRU_SET	(3)		/* Inode is on the LRU list */
+#define NFS_INO_CACHEABLE	(4)		/* inode can be cached by FS-Cache */
 
 static inline struct nfs_inode *NFS_I(struct inode *inode)
 {
@@ -230,6 +231,7 @@ #define NFS_ATTRTIMEO_UPDATE(inode)	(NFS
 
 #define NFS_FLAGS(inode)		(NFS_I(inode)->flags)
 #define NFS_STALE(inode)		(test_bit(NFS_INO_STALE, &NFS_FLAGS(inode)))
+#define NFS_CACHEABLE(inode)		(test_bit(NFS_INO_CACHEABLE, &NFS_FLAGS(inode)))
 
 #define NFS_FILEID(inode)		(NFS_I(inode)->fileid)
 
