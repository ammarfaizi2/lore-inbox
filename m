Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132708AbRDXCxl>; Mon, 23 Apr 2001 22:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132710AbRDXCxW>; Mon, 23 Apr 2001 22:53:22 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:31455 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S132708AbRDXCxR>;
	Mon, 23 Apr 2001 22:53:17 -0400
Date: Mon, 23 Apr 2001 22:53:15 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Jan Harkes <jaharkes@cs.cmu.edu>
cc: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        Christoph Rohland <cr@sap.com>,
        "David L. Parsley" <parsley@linuxjedi.org>,
        linux-kernel@vger.kernel.org
Subject: Re: hundreds of mount --bind mountpoints?
In-Reply-To: <20010423213709.A19705@cs.cmu.edu>
Message-ID: <Pine.GSO.4.21.0104232241130.4968-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 23 Apr 2001, Jan Harkes wrote:

> On Mon, Apr 23, 2001 at 10:45:05PM +0200, Ingo Oeser wrote:

> > BTW: Is it still less than one page? Then it doesn't make me
> >    nervous. Why? Guess what granularity we allocate at, if we
> >    just store pointers instead of the inode.u. Or do you like
> >    every FS creating his own slab cache?

Oh, for crying out loud. All it takes is half an hour per filesystem.
Here - completely untested patch that does it for NFS. Took about that
long. Absolutely straightforward, very easy to verify correctness.

Some stuff may need tweaking, but not much (e.g. some functions
should take nfs_inode_info instead of inodes, etc.). From the look
of flushd cache it seems that we would be better off with cyclic
lists instead of single-linked ones for the hash, but I didn't look
deep enough.

So consider the patch below as proof-of-concept. Enjoy:

diff -urN S4-pre6/fs/nfs/flushd.c S4-pre6-nfs/fs/nfs/flushd.c
--- S4-pre6/fs/nfs/flushd.c	Sat Apr 21 14:35:21 2001
+++ S4-pre6-nfs/fs/nfs/flushd.c	Mon Apr 23 22:23:11 2001
@@ -162,11 +162,11 @@
 
 	if (NFS_FLAGS(inode) & NFS_INO_FLUSH)
 		goto out;
-	inode->u.nfs_i.hash_next = NULL;
+	NFS_I(inode)->hash_next = NULL;
 
 	q = &cache->inodes;
 	while (*q)
-		q = &(*q)->u.nfs_i.hash_next;
+		q = &NFS_I(*q)->hash_next;
 	*q = inode;
 
 	/* Note: we increase the inode i_count in order to prevent
@@ -188,9 +188,9 @@
 
 	q = &cache->inodes;
 	while (*q && *q != inode)
-		q = &(*q)->u.nfs_i.hash_next;
+		q = &NFS_I(*q)->hash_next;
 	if (*q) {
-		*q = inode->u.nfs_i.hash_next;
+		*q = NFS_I(inode)->hash_next;
 		NFS_FLAGS(inode) &= ~NFS_INO_FLUSH;
 		iput(inode);
 	}
@@ -238,8 +238,8 @@
 	cache->inodes = NULL;
 
 	while ((inode = next) != NULL) {
-		next = next->u.nfs_i.hash_next;
-		inode->u.nfs_i.hash_next = NULL;
+		next = NFS_I(next)->hash_next;
+		NFS_I(inode)->hash_next = NULL;
 		NFS_FLAGS(inode) &= ~NFS_INO_FLUSH;
 
 		if (flush) {
diff -urN S4-pre6/fs/nfs/inode.c S4-pre6-nfs/fs/nfs/inode.c
--- S4-pre6/fs/nfs/inode.c	Sat Apr 21 14:35:21 2001
+++ S4-pre6-nfs/fs/nfs/inode.c	Mon Apr 23 22:43:45 2001
@@ -40,11 +40,14 @@
 #define NFSDBG_FACILITY		NFSDBG_VFS
 #define NFS_PARANOIA 1
 
+static kmem_cache_t *nfs_inode_cachep;
+
 static struct inode * __nfs_fhget(struct super_block *, struct nfs_fh *, struct nfs_fattr *);
 void nfs_zap_caches(struct inode *);
 static void nfs_invalidate_inode(struct inode *);
 
 static void nfs_read_inode(struct inode *);
+static void nfs_clear_inode(struct inode *);
 static void nfs_delete_inode(struct inode *);
 static void nfs_put_super(struct super_block *);
 static void nfs_umount_begin(struct super_block *);
@@ -52,6 +55,7 @@
 
 static struct super_operations nfs_sops = { 
 	read_inode:	nfs_read_inode,
+	clear_inode:	nfs_clear_inode,
 	put_inode:	force_delete,
 	delete_inode:	nfs_delete_inode,
 	put_super:	nfs_put_super,
@@ -96,23 +100,44 @@
 static void
 nfs_read_inode(struct inode * inode)
 {
+	struct nfs_inode_info *nfsi;
+
+	nfsi = kmem_cache_alloc(nfs_inode_cachep, GFP_KERNEL);
+	if (!nfsi)
+		goto Enomem;
+
 	inode->i_blksize = inode->i_sb->s_blocksize;
 	inode->i_mode = 0;
 	inode->i_rdev = 0;
+	inode->u.generic_ip = nfsi;
 	NFS_FILEID(inode) = 0;
 	NFS_FSID(inode) = 0;
 	NFS_FLAGS(inode) = 0;
-	INIT_LIST_HEAD(&inode->u.nfs_i.read);
-	INIT_LIST_HEAD(&inode->u.nfs_i.dirty);
-	INIT_LIST_HEAD(&inode->u.nfs_i.commit);
-	INIT_LIST_HEAD(&inode->u.nfs_i.writeback);
-	inode->u.nfs_i.nread = 0;
-	inode->u.nfs_i.ndirty = 0;
-	inode->u.nfs_i.ncommit = 0;
-	inode->u.nfs_i.npages = 0;
+	INIT_LIST_HEAD(&nfsi->read);
+	INIT_LIST_HEAD(&nfsi->dirty);
+	INIT_LIST_HEAD(&nfsi->commit);
+	INIT_LIST_HEAD(&nfsi->writeback);
+	nfsi->nread = 0;
+	nfsi->ndirty = 0;
+	nfsi->ncommit = 0;
+	nfsi->npages = 0;
 	NFS_CACHEINV(inode);
 	NFS_ATTRTIMEO(inode) = NFS_MINATTRTIMEO(inode);
 	NFS_ATTRTIMEO_UPDATE(inode) = jiffies;
+	return;
+
+Enomem:
+	make_bad_inode(inode);
+	return;
+}
+
+static void
+nfs_clear_inode(struct inode * inode)
+{
+	struct nfs_inode_info *p = NFS_I(inode);
+	inode->u.generic_ip = NULL;
+	if (p)
+		kmem_cache_free(nfs_inode_cachep, p);
 }
 
 static void
@@ -594,7 +619,7 @@
 		NFS_CACHE_ISIZE(inode) = fattr->size;
 		NFS_ATTRTIMEO(inode) = NFS_MINATTRTIMEO(inode);
 		NFS_ATTRTIMEO_UPDATE(inode) = jiffies;
-		memcpy(&inode->u.nfs_i.fh, fh, sizeof(inode->u.nfs_i.fh));
+		memcpy(NFS_FH(inode), fh, sizeof(struct nfs_fh));
 	}
 	nfs_refresh_inode(inode, fattr);
 }
@@ -621,7 +646,7 @@
 		return 0;
 	if (NFS_FILEID(inode) != fattr->fileid)
 		return 0;
-	if (memcmp(&inode->u.nfs_i.fh, fh, sizeof(inode->u.nfs_i.fh)) != 0)
+	if (memcmp(NFS_FH(inode), fh, sizeof(struct nfs_fh)) != 0)
 		return 0;
 	return 1;
 }
@@ -640,7 +665,7 @@
 		return 1;
 
 	/* Has the filehandle changed? If so is the old one stale? */
-	if (memcmp(&inode->u.nfs_i.fh, fh, sizeof(inode->u.nfs_i.fh)) != 0 &&
+	if (memcmp(NFS_FH(inode), fh, sizeof(struct nfs_fh)) != 0 &&
 	    __nfs_revalidate_inode(NFS_SERVER(inode),inode) == -ESTALE)
 		return 1;
 
@@ -1056,6 +1081,24 @@
 extern int nfs_init_readpagecache(void);
 extern int nfs_destroy_readpagecache(void);
 
+int nfs_init_inodecache(void)
+{
+	nfs_inode_cachep = kmem_cache_create("nfs_inode_cache",
+					     sizeof(struct nfs_inode_info),
+					     0, SLAB_HWCACHE_ALIGN,
+					     NULL, NULL);
+	if (nfs_inode_cachep == NULL)
+		return -ENOMEM;
+
+	return 0;
+}
+
+void nfs_destroy_inodecache(void)
+{
+	if (kmem_cache_destroy(nfs_inode_cachep))
+		printk(KERN_INFO "nfs_inode_cache: not all structures were freed\n");
+}
+
 /*
  * Initialize NFS
  */
@@ -1067,6 +1110,10 @@
 	if (err)
 		return err;
 
+	err = nfs_init_inodecache();
+	if (err)
+		return err;
+
 	err = nfs_init_readpagecache();
 	if (err)
 		return err;
@@ -1080,6 +1127,7 @@
 static void __exit exit_nfs_fs(void)
 {
 	nfs_destroy_readpagecache();
+	nfs_destroy_inodecache();
 	nfs_destroy_nfspagecache();
 #ifdef CONFIG_PROC_FS
 	rpc_proc_unregister("nfs");
diff -urN S4-pre6/fs/nfs/read.c S4-pre6-nfs/fs/nfs/read.c
--- S4-pre6/fs/nfs/read.c	Sat Apr 21 14:35:21 2001
+++ S4-pre6-nfs/fs/nfs/read.c	Mon Apr 23 22:18:25 2001
@@ -153,7 +153,7 @@
 {
 	struct list_head	*head, *next;
 
-	head = &inode->u.nfs_i.read;
+	head = &NFS_I(inode)->read;
 	next = head->next;
 	while (next != head) {
 		struct nfs_page *req = nfs_list_entry(next);
@@ -183,11 +183,12 @@
 nfs_mark_request_read(struct nfs_page *req)
 {
 	struct inode *inode = req->wb_inode;
+	struct nfs_inode_info *nfsi = NFS_I(inode);
 
 	spin_lock(&nfs_wreq_lock);
 	if (list_empty(&req->wb_list)) {
-		nfs_list_add_request(req, &inode->u.nfs_i.read);
-		inode->u.nfs_i.nread++;
+		nfs_list_add_request(req, &nfsi->read);
+		nfsi->nread++;
 	}
 	spin_unlock(&nfs_wreq_lock);
 	/*
@@ -234,7 +235,7 @@
 			break;
 	}
 
-	if (inode->u.nfs_i.nread >= NFS_SERVER(inode)->rpages ||
+	if (NFS_I(inode)->nread >= NFS_SERVER(inode)->rpages ||
 	    page_index(page) == (inode->i_size + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT)
 		nfs_pagein_inode(inode, 0, 0);
 	if (new)
@@ -372,10 +373,11 @@
 nfs_scan_read_timeout(struct inode *inode, struct list_head *dst)
 {
 	int	pages;
+	struct nfs_inode_info *nfsi = NFS_I(inode);
 	spin_lock(&nfs_wreq_lock);
-	pages = nfs_scan_list_timeout(&inode->u.nfs_i.read, dst, inode);
-	inode->u.nfs_i.nread -= pages;
-	if ((inode->u.nfs_i.nread == 0) != list_empty(&inode->u.nfs_i.read))
+	pages = nfs_scan_list_timeout(&nfsi->read, dst, inode);
+	nfsi->nread -= pages;
+	if ((nfsi->nread == 0) != list_empty(&nfsi->read))
 		printk(KERN_ERR "NFS: desynchronized value of nfs_i.nread.\n");
 	spin_unlock(&nfs_wreq_lock);
 	return pages;
@@ -385,10 +387,11 @@
 nfs_scan_read(struct inode *inode, struct list_head *dst, unsigned long idx_start, unsigned int npages)
 {
 	int	res;
+	struct nfs_inode_info *nfsi = NFS_I(inode);
 	spin_lock(&nfs_wreq_lock);
-	res = nfs_scan_list(&inode->u.nfs_i.read, dst, NULL, idx_start, npages);
-	inode->u.nfs_i.nread -= res;
-	if ((inode->u.nfs_i.nread == 0) != list_empty(&inode->u.nfs_i.read))
+	res = nfs_scan_list(&nfsi->read, dst, NULL, idx_start, npages);
+	nfsi->nread -= res;
+	if ((nfsi->nread == 0) != list_empty(&nfsi->read))
 		printk(KERN_ERR "NFS: desynchronized value of nfs_i.nread.\n");
 	spin_unlock(&nfs_wreq_lock);
 	return res;
diff -urN S4-pre6/fs/nfs/write.c S4-pre6-nfs/fs/nfs/write.c
--- S4-pre6/fs/nfs/write.c	Sat Apr 21 14:35:21 2001
+++ S4-pre6-nfs/fs/nfs/write.c	Mon Apr 23 22:15:06 2001
@@ -329,14 +329,15 @@
 static inline void
 nfs_inode_add_request(struct inode *inode, struct nfs_page *req)
 {
+	struct nfs_inode_info *nfsi = NFS_I(inode);
 	if (!list_empty(&req->wb_hash))
 		return;
 	if (!NFS_WBACK_BUSY(req))
 		printk(KERN_ERR "NFS: unlocked request attempted hashed!\n");
-	if (list_empty(&inode->u.nfs_i.writeback))
+	if (list_empty(&nfsi->writeback))
 		atomic_inc(&inode->i_count);
-	inode->u.nfs_i.npages++;
-	list_add(&req->wb_hash, &inode->u.nfs_i.writeback);
+	nfsi->npages++;
+	list_add(&req->wb_hash, &nfsi->writeback);
 	req->wb_count++;
 }
 
@@ -347,6 +348,7 @@
 nfs_inode_remove_request(struct nfs_page *req)
 {
 	struct inode *inode;
+	struct nfs_inode_info *nfsi;
 	spin_lock(&nfs_wreq_lock);
 	if (list_empty(&req->wb_hash)) {
 		spin_unlock(&nfs_wreq_lock);
@@ -355,12 +357,13 @@
 	if (!NFS_WBACK_BUSY(req))
 		printk(KERN_ERR "NFS: unlocked request attempted unhashed!\n");
 	inode = req->wb_inode;
+	nfsi = NFS_I(inode);
 	list_del(&req->wb_hash);
 	INIT_LIST_HEAD(&req->wb_hash);
-	inode->u.nfs_i.npages--;
-	if ((inode->u.nfs_i.npages == 0) != list_empty(&inode->u.nfs_i.writeback))
+	nfsi->npages--;
+	if ((nfsi->npages == 0) != list_empty(&nfsi->writeback))
 		printk(KERN_ERR "NFS: desynchronized value of nfs_i.npages.\n");
-	if (list_empty(&inode->u.nfs_i.writeback))
+	if (list_empty(&nfsi->writeback))
 		iput(inode);
 	if (!nfs_have_writebacks(inode) && !nfs_have_read(inode))
 		inode_remove_flushd(inode);
@@ -376,7 +379,7 @@
 {
 	struct list_head	*head, *next;
 
-	head = &inode->u.nfs_i.writeback;
+	head = &NFS_I(inode)->writeback;
 	next = head->next;
 	while (next != head) {
 		struct nfs_page *req = nfs_inode_wb_entry(next);
@@ -448,8 +451,9 @@
 
 	spin_lock(&nfs_wreq_lock);
 	if (list_empty(&req->wb_list)) {
-		nfs_list_add_request(req, &inode->u.nfs_i.dirty);
-		inode->u.nfs_i.ndirty++;
+		struct nfs_inode_info *nfsi = NFS_I(inode);
+		nfs_list_add_request(req, &nfsi->dirty);
+		nfsi->ndirty++;
 	}
 	spin_unlock(&nfs_wreq_lock);
 	/*
@@ -466,7 +470,7 @@
 nfs_dirty_request(struct nfs_page *req)
 {
 	struct inode *inode = req->wb_inode;
-	return !list_empty(&req->wb_list) && req->wb_list_head == &inode->u.nfs_i.dirty;
+	return !list_empty(&req->wb_list) && req->wb_list_head == &NFS_I(inode)->dirty;
 }
 
 #ifdef CONFIG_NFS_V3
@@ -480,8 +484,9 @@
 
 	spin_lock(&nfs_wreq_lock);
 	if (list_empty(&req->wb_list)) {
-		nfs_list_add_request(req, &inode->u.nfs_i.commit);
-		inode->u.nfs_i.ncommit++;
+		struct nfs_inode_info *nfsi = NFS_I(inode);
+		nfs_list_add_request(req, &nfsi->commit);
+		nfsi->ncommit++;
 	}
 	spin_unlock(&nfs_wreq_lock);
 	/*
@@ -657,7 +662,7 @@
 		idx_end = idx_start + npages - 1;
 
 	spin_lock(&nfs_wreq_lock);
-	head = &inode->u.nfs_i.writeback;
+	head = &NFS_I(inode)->writeback;
 	p = head->next;
 	while (p != head) {
 		unsigned long pg_idx;
@@ -720,10 +725,11 @@
 nfs_scan_dirty_timeout(struct inode *inode, struct list_head *dst)
 {
 	int	pages;
+	struct nfs_inode_info *nfsi = NFS_I(inode);
 	spin_lock(&nfs_wreq_lock);
-	pages = nfs_scan_list_timeout(&inode->u.nfs_i.dirty, dst, inode);
-	inode->u.nfs_i.ndirty -= pages;
-	if ((inode->u.nfs_i.ndirty == 0) != list_empty(&inode->u.nfs_i.dirty))
+	pages = nfs_scan_list_timeout(&nfsi->dirty, dst, inode);
+	nfsi->ndirty -= pages;
+	if ((nfsi->ndirty == 0) != list_empty(&nfsi->dirty))
 		printk(KERN_ERR "NFS: desynchronized value of nfs_i.ndirty.\n");
 	spin_unlock(&nfs_wreq_lock);
 	return pages;
@@ -734,10 +740,11 @@
 nfs_scan_commit_timeout(struct inode *inode, struct list_head *dst)
 {
 	int	pages;
+	struct nfs_inode_info *nfsi = NFS_I(inode);
 	spin_lock(&nfs_wreq_lock);
-	pages = nfs_scan_list_timeout(&inode->u.nfs_i.commit, dst, inode);
-	inode->u.nfs_i.ncommit -= pages;
-	if ((inode->u.nfs_i.ncommit == 0) != list_empty(&inode->u.nfs_i.commit))
+	pages = nfs_scan_list_timeout(&nfsi->commit, dst, inode);
+	nfsi->ncommit -= pages;
+	if ((nfsi->ncommit == 0) != list_empty(&nfsi->commit))
 		printk(KERN_ERR "NFS: desynchronized value of nfs_i.ncommit.\n");
 	spin_unlock(&nfs_wreq_lock);
 	return pages;
@@ -783,10 +790,11 @@
 nfs_scan_dirty(struct inode *inode, struct list_head *dst, struct file *file, unsigned long idx_start, unsigned int npages)
 {
 	int	res;
+	struct nfs_inode_info *nfsi = NFS_I(inode);
 	spin_lock(&nfs_wreq_lock);
-	res = nfs_scan_list(&inode->u.nfs_i.dirty, dst, file, idx_start, npages);
-	inode->u.nfs_i.ndirty -= res;
-	if ((inode->u.nfs_i.ndirty == 0) != list_empty(&inode->u.nfs_i.dirty))
+	res = nfs_scan_list(&nfsi->dirty, dst, file, idx_start, npages);
+	nfsi->ndirty -= res;
+	if ((nfsi->ndirty == 0) != list_empty(&nfsi->dirty))
 		printk(KERN_ERR "NFS: desynchronized value of nfs_i.ndirty.\n");
 	spin_unlock(&nfs_wreq_lock);
 	return res;
@@ -797,10 +805,11 @@
 nfs_scan_commit(struct inode *inode, struct list_head *dst, struct file *file, unsigned long idx_start, unsigned int npages)
 {
 	int	res;
+	struct nfs_inode_info *nfsi = NFS_I(inode);
 	spin_lock(&nfs_wreq_lock);
-	res = nfs_scan_list(&inode->u.nfs_i.commit, dst, file, idx_start, npages);
-	inode->u.nfs_i.ncommit -= res;
-	if ((inode->u.nfs_i.ncommit == 0) != list_empty(&inode->u.nfs_i.commit))
+	res = nfs_scan_list(&nfsi->commit, dst, file, idx_start, npages);
+	nfsi->ncommit -= res;
+	if ((nfsi->ncommit == 0) != list_empty(&nfsi->commit))
 		printk(KERN_ERR "NFS: desynchronized value of nfs_i.ncommit.\n");
 	spin_unlock(&nfs_wreq_lock);
 	return res;
@@ -885,7 +894,7 @@
 		/*
 		 * If we're over the soft limit, flush out old requests
 		 */
-		if (inode->u.nfs_i.npages >= MAX_REQUEST_SOFT)
+		if (NFS_I(inode)->npages >= MAX_REQUEST_SOFT)
 			nfs_wb_file(inode, file);
 		new = nfs_create_request(file, inode, page, offset, bytes);
 		if (!new)
@@ -952,8 +961,9 @@
 nfs_strategy(struct inode *inode)
 {
 	unsigned int	dirty, wpages;
+	struct nfs_inode_info *nfsi = NFS_I(inode);
 
-	dirty  = inode->u.nfs_i.ndirty;
+	dirty  = nfsi->ndirty;
 	wpages = NFS_SERVER(inode)->wpages;
 #ifdef CONFIG_NFS_V3
 	if (NFS_PROTO(inode)->version == 2) {
@@ -962,7 +972,7 @@
 	} else {
 		if (dirty >= wpages)
 			nfs_flush_file(inode, NULL, 0, 0, 0);
-		if (inode->u.nfs_i.ncommit > NFS_STRATEGY_PAGES * wpages &&
+		if (nfsi->ncommit > NFS_STRATEGY_PAGES * wpages &&
 		    atomic_read(&nfs_nr_requests) > MAX_REQUEST_SOFT)
 			nfs_commit_file(inode, NULL, 0, 0, 0);
 	}
@@ -974,7 +984,7 @@
 	 * If we're running out of free requests, flush out everything
 	 * in order to reduce memory useage...
 	 */
-	if (inode->u.nfs_i.npages > MAX_REQUEST_SOFT)
+	if (nfsi->npages > MAX_REQUEST_SOFT)
 		nfs_wb_all(inode);
 }
 
@@ -1141,7 +1151,7 @@
 	/* Set up the argument struct */
 	nfs_write_rpcsetup(head, data);
 	if (stable) {
-		if (!inode->u.nfs_i.ncommit)
+		if (!NFS_I(inode)->ncommit)
 			data->args.stable = NFS_FILE_SYNC;
 		else
 			data->args.stable = NFS_DATA_SYNC;
diff -urN S4-pre6/include/linux/fs.h S4-pre6-nfs/include/linux/fs.h
--- S4-pre6/include/linux/fs.h	Sat Apr 21 14:35:32 2001
+++ S4-pre6-nfs/include/linux/fs.h	Mon Apr 23 22:40:10 2001
@@ -448,7 +448,6 @@
 		struct msdos_inode_info		msdos_i;
 		struct umsdos_inode_info	umsdos_i;
 		struct iso_inode_info		isofs_i;
-		struct nfs_inode_info		nfs_i;
 		struct sysv_inode_info		sysv_i;
 		struct affs_inode_info		affs_i;
 		struct ufs_inode_info		ufs_i;
diff -urN S4-pre6/include/linux/nfs_fs.h S4-pre6-nfs/include/linux/nfs_fs.h
--- S4-pre6/include/linux/nfs_fs.h	Sat Apr 21 14:35:32 2001
+++ S4-pre6-nfs/include/linux/nfs_fs.h	Mon Apr 23 22:40:17 2001
@@ -63,39 +63,44 @@
  */
 #define NFS_SUPER_MAGIC			0x6969
 
-#define NFS_FH(inode)			(&(inode)->u.nfs_i.fh)
+static inline struct nfs_inode_info *NFS_I(struct inode *inode)
+{
+	return (struct nfs_inode_info *)inode->u.generic_ip;
+}
+
+#define NFS_FH(inode)			(&NFS_I(inode)->fh)
 #define NFS_SERVER(inode)		(&(inode)->i_sb->u.nfs_sb.s_server)
 #define NFS_CLIENT(inode)		(NFS_SERVER(inode)->client)
 #define NFS_PROTO(inode)		(NFS_SERVER(inode)->rpc_ops)
 #define NFS_REQUESTLIST(inode)		(NFS_SERVER(inode)->rw_requests)
 #define NFS_ADDR(inode)			(RPC_PEERADDR(NFS_CLIENT(inode)))
 #define NFS_CONGESTED(inode)		(RPC_CONGESTED(NFS_CLIENT(inode)))
-#define NFS_COOKIEVERF(inode)		((inode)->u.nfs_i.cookieverf)
-#define NFS_READTIME(inode)		((inode)->u.nfs_i.read_cache_jiffies)
-#define NFS_CACHE_CTIME(inode)		((inode)->u.nfs_i.read_cache_ctime)
-#define NFS_CACHE_MTIME(inode)		((inode)->u.nfs_i.read_cache_mtime)
-#define NFS_CACHE_ATIME(inode)		((inode)->u.nfs_i.read_cache_atime)
-#define NFS_CACHE_ISIZE(inode)		((inode)->u.nfs_i.read_cache_isize)
-#define NFS_NEXTSCAN(inode)		((inode)->u.nfs_i.nextscan)
+#define NFS_COOKIEVERF(inode)		(NFS_I(inode)->cookieverf)
+#define NFS_READTIME(inode)		(NFS_I(inode)->read_cache_jiffies)
+#define NFS_CACHE_CTIME(inode)		(NFS_I(inode)->read_cache_ctime)
+#define NFS_CACHE_MTIME(inode)		(NFS_I(inode)->read_cache_mtime)
+#define NFS_CACHE_ATIME(inode)		(NFS_I(inode)->read_cache_atime)
+#define NFS_CACHE_ISIZE(inode)		(NFS_I(inode)->read_cache_isize)
+#define NFS_NEXTSCAN(inode)		(NFS_I(inode)->nextscan)
 #define NFS_CACHEINV(inode) \
 do { \
 	NFS_READTIME(inode) = jiffies - NFS_MAXATTRTIMEO(inode) - 1; \
 } while (0)
-#define NFS_ATTRTIMEO(inode)		((inode)->u.nfs_i.attrtimeo)
+#define NFS_ATTRTIMEO(inode)		(NFS_I(inode)->attrtimeo)
 #define NFS_MINATTRTIMEO(inode) \
 	(S_ISDIR(inode->i_mode)? NFS_SERVER(inode)->acdirmin \
 			       : NFS_SERVER(inode)->acregmin)
 #define NFS_MAXATTRTIMEO(inode) \
 	(S_ISDIR(inode->i_mode)? NFS_SERVER(inode)->acdirmax \
 			       : NFS_SERVER(inode)->acregmax)
-#define NFS_ATTRTIMEO_UPDATE(inode)	((inode)->u.nfs_i.attrtimeo_timestamp)
+#define NFS_ATTRTIMEO_UPDATE(inode)	(NFS_I(inode)->attrtimeo_timestamp)
 
-#define NFS_FLAGS(inode)		((inode)->u.nfs_i.flags)
+#define NFS_FLAGS(inode)		(NFS_I(inode)->flags)
 #define NFS_REVALIDATING(inode)		(NFS_FLAGS(inode) & NFS_INO_REVALIDATING)
 #define NFS_STALE(inode)		(NFS_FLAGS(inode) & NFS_INO_STALE)
 
-#define NFS_FILEID(inode)		((inode)->u.nfs_i.fileid)
-#define NFS_FSID(inode)			((inode)->u.nfs_i.fsid)
+#define NFS_FILEID(inode)		(NFS_I(inode)->fileid)
+#define NFS_FSID(inode)			(NFS_I(inode)->fsid)
 
 /* Inode Flags */
 #define NFS_USE_READDIRPLUS(inode)	((NFS_FLAGS(inode) & NFS_INO_ADVISE_RDPLUS) ? 1 : 0)
@@ -212,13 +217,13 @@
 static inline int
 nfs_have_read(struct inode *inode)
 {
-	return !list_empty(&inode->u.nfs_i.read);
+	return !list_empty(&NFS_I(inode)->read);
 }
 
 static inline int
 nfs_have_writebacks(struct inode *inode)
 {
-	return !list_empty(&inode->u.nfs_i.writeback);
+	return !list_empty(&NFS_I(inode)->writeback);
 }
 
 static inline int




