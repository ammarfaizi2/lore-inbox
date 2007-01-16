Return-Path: <linux-kernel-owner+w=401wt.eu-S1751704AbXAPWJH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751704AbXAPWJH (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 17:09:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751723AbXAPWJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 17:09:06 -0500
Received: from amsfep15-int.chello.nl ([62.179.120.10]:57853 "EHLO
	amsfep15-int.chello.nl" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751704AbXAPWIt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 17:08:49 -0500
Subject: [PATCH] nfs: fix congestion control
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Trond Myklebust <trond.myklebust@fys.uio.no>
In-Reply-To: <20070116135325.3441f62b.akpm@osdl.org>
References: <20070116054743.15358.77287.sendpatchset@schroedinger.engr.sgi.com>
	 <20070116135325.3441f62b.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 16 Jan 2007 23:08:43 +0100
Message-Id: <1168985323.5975.53.camel@lappy>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: nfs: fix congestion control

The current NFS client congestion logic is severely broken, it marks the
backing device congested during each nfs_writepages() call and implements
its own waitqueue.

Replace this by a more regular congestion implementation that puts a cap
on the number of active writeback pages and uses the bdi congestion waitqueue.

NFSv[34] commit pages are allowed to go unchecked as long as we are under 
the dirty page limit and not in direct reclaim.

	A buxom young lass from Neale's Flat,
	Bore triplets, named Matt, Pat and Tat.
	"Oh Lord," she protested,
	"'Tis somewhat congested ...
	"You've given me no tit for Tat." 

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
---
 fs/inode.c                  |    1 
 fs/nfs/pagelist.c           |    8 +
 fs/nfs/write.c              |  257 +++++++++++++++++++++++++++++++++++---------
 include/linux/backing-dev.h |    1 
 include/linux/nfs_fs_sb.h   |    2 
 include/linux/nfs_page.h    |    2 
 include/linux/writeback.h   |    1 
 mm/backing-dev.c            |   16 ++
 mm/page-writeback.c         |    6 +
 9 files changed, 240 insertions(+), 54 deletions(-)

Index: linux-2.6-git/fs/nfs/write.c
===================================================================
--- linux-2.6-git.orig/fs/nfs/write.c	2007-01-12 08:03:47.000000000 +0100
+++ linux-2.6-git/fs/nfs/write.c	2007-01-12 09:31:41.000000000 +0100
@@ -89,8 +89,6 @@ static struct kmem_cache *nfs_wdata_cach
 static mempool_t *nfs_wdata_mempool;
 static mempool_t *nfs_commit_mempool;
 
-static DECLARE_WAIT_QUEUE_HEAD(nfs_write_congestion);
-
 struct nfs_write_data *nfs_commit_alloc(void)
 {
 	struct nfs_write_data *p = mempool_alloc(nfs_commit_mempool, GFP_NOFS);
@@ -245,6 +243,91 @@ static int wb_priority(struct writeback_
 }
 
 /*
+ * NFS congestion control
+ *
+ * Congestion is composed of two parts, writeback and commit pages.
+ * Writeback pages are active, that is, all that is required to get out of
+ * writeback state is sit around and wait. Commit pages on the other hand
+ * are not and they need a little nudge to go away.
+ *
+ * Normally we want to maximise the number of commit pages for it allows the
+ * server to make best use of unstable storage. However when we are running
+ * low on memory we do need to reduce the commit pages.
+ *
+ * Hence writeback pages are managed in the conventional way, but for commit
+ * pages we poll on every write.
+ *
+ * The threshold is picked so that it allows for 16M of in flight data
+ * given current transfer speeds that seems reasonable.
+ */
+
+#define NFS_CONGESTION_SIZE		16
+#define NFS_CONGESTION_ON_THRESH 	(NFS_CONGESTION_SIZE << (20 - PAGE_SHIFT))
+#define NFS_CONGESTION_OFF_THRESH	\
+	(NFS_CONGESTION_ON_THRESH - (NFS_CONGESTION_ON_THRESH >> 2))
+
+/*
+ * Include the commit pages into the congestion logic when there is either
+ * pressure from the total dirty limit or when we're in direct reclaim.
+ */
+static inline int commit_pressure(struct inode *inode)
+{
+	return dirty_pages_exceeded(inode->i_mapping) ||
+		(current->flags & PF_MEMALLOC);
+}
+
+static void nfs_congestion_on(struct inode *inode)
+{
+	struct nfs_server *nfss = NFS_SERVER(inode);
+
+	if (atomic_read(&nfss->writeback) > NFS_CONGESTION_ON_THRESH)
+		set_bdi_congested(&nfss->backing_dev_info, WRITE);
+}
+
+static void nfs_congestion_off(struct inode *inode)
+{
+	struct nfs_server *nfss = NFS_SERVER(inode);
+
+	if (atomic_read(&nfss->writeback) < NFS_CONGESTION_OFF_THRESH) {
+		clear_bdi_congested(&nfss->backing_dev_info, WRITE);
+		congestion_end(WRITE);
+	}
+}
+
+static inline void nfs_set_page_writeback(struct page *page)
+{
+	if (!test_set_page_writeback(page)) {
+		struct inode *inode = page->mapping->host;
+		atomic_inc(&NFS_SERVER(inode)->writeback);
+		nfs_congestion_on(inode);
+	}
+}
+
+static inline void nfs_end_page_writeback(struct page *page)
+{
+	struct inode *inode = page->mapping->host;
+	end_page_writeback(page);
+	atomic_dec(&NFS_SERVER(inode)->writeback);
+	nfs_congestion_off(inode);
+}
+
+static inline void nfs_set_page_commit(struct page *page)
+{
+	struct inode *inode = page->mapping->host;
+	inc_zone_page_state(page, NR_UNSTABLE_NFS);
+	atomic_inc(&NFS_SERVER(inode)->commit);
+	nfs_congestion_on(inode);
+}
+
+static inline void nfs_end_page_commit(struct page *page)
+{
+	struct inode *inode = page->mapping->host;
+	dec_zone_page_state(page, NR_UNSTABLE_NFS);
+	atomic_dec(&NFS_SERVER(inode)->commit);
+	nfs_congestion_off(inode);
+}
+
+/*
  * Find an associated nfs write request, and prepare to flush it out
  * Returns 1 if there was no write request, or if the request was
  * already tagged by nfs_set_page_dirty.Returns 0 if the request
@@ -281,7 +364,7 @@ static int nfs_page_mark_flush(struct pa
 	spin_unlock(req_lock);
 	if (test_and_set_bit(PG_FLUSHING, &req->wb_flags) == 0) {
 		nfs_mark_request_dirty(req);
-		set_page_writeback(page);
+		nfs_set_page_writeback(page);
 	}
 	ret = test_bit(PG_NEED_FLUSH, &req->wb_flags);
 	nfs_unlock_request(req);
@@ -336,13 +419,8 @@ int nfs_writepage(struct page *page, str
 	return err; 
 }
 
-/*
- * Note: causes nfs_update_request() to block on the assumption
- * 	 that the writeback is generated due to memory pressure.
- */
 int nfs_writepages(struct address_space *mapping, struct writeback_control *wbc)
 {
-	struct backing_dev_info *bdi = mapping->backing_dev_info;
 	struct inode *inode = mapping->host;
 	int err;
 
@@ -351,11 +429,6 @@ int nfs_writepages(struct address_space 
 	err = generic_writepages(mapping, wbc);
 	if (err)
 		return err;
-	while (test_and_set_bit(BDI_write_congested, &bdi->state) != 0) {
-		if (wbc->nonblocking)
-			return 0;
-		nfs_wait_on_write_congestion(mapping, 0);
-	}
 	err = nfs_flush_mapping(mapping, wbc, wb_priority(wbc));
 	if (err < 0)
 		goto out;
@@ -369,9 +442,6 @@ int nfs_writepages(struct address_space 
 	if (err > 0)
 		err = 0;
 out:
-	clear_bit(BDI_write_congested, &bdi->state);
-	wake_up_all(&nfs_write_congestion);
-	congestion_end(WRITE);
 	return err;
 }
 
@@ -401,7 +471,7 @@ static int nfs_inode_add_request(struct 
 }
 
 /*
- * Insert a write request into an inode
+ * Remove a write request from an inode
  */
 static void nfs_inode_remove_request(struct nfs_page *req)
 {
@@ -473,7 +543,7 @@ nfs_mark_request_commit(struct nfs_page 
 	nfs_list_add_request(req, &nfsi->commit);
 	nfsi->ncommit++;
 	spin_unlock(&nfsi->req_lock);
-	inc_zone_page_state(req->wb_page, NR_UNSTABLE_NFS);
+	nfs_set_page_commit(req->wb_page);
 	__mark_inode_dirty(inode, I_DIRTY_DATASYNC);
 }
 #endif
@@ -544,7 +614,7 @@ static void nfs_cancel_commit_list(struc
 
 	while(!list_empty(head)) {
 		req = nfs_list_entry(head->next);
-		dec_zone_page_state(req->wb_page, NR_UNSTABLE_NFS);
+		nfs_end_page_commit(req->wb_page);
 		nfs_list_remove_request(req);
 		nfs_inode_remove_request(req);
 		nfs_unlock_request(req);
@@ -563,13 +633,14 @@ static void nfs_cancel_commit_list(struc
  * The requests are *not* checked to ensure that they form a contiguous set.
  */
 static int
-nfs_scan_commit(struct inode *inode, struct list_head *dst, unsigned long idx_start, unsigned int npages)
+nfs_scan_commit(struct inode *inode, struct list_head *dst,
+		unsigned long idx_start, unsigned int npages, unsigned int maxpages)
 {
 	struct nfs_inode *nfsi = NFS_I(inode);
 	int res = 0;
 
 	if (nfsi->ncommit != 0) {
-		res = nfs_scan_list(nfsi, &nfsi->commit, dst, idx_start, npages);
+		res = nfs_scan_list(nfsi, &nfsi->commit, dst, idx_start, npages, maxpages);
 		nfsi->ncommit -= res;
 		if ((nfsi->ncommit == 0) != list_empty(&nfsi->commit))
 			printk(KERN_ERR "NFS: desynchronized value of nfs_i.ncommit.\n");
@@ -577,48 +648,93 @@ nfs_scan_commit(struct inode *inode, str
 	return res;
 }
 #else
-static inline int nfs_scan_commit(struct inode *inode, struct list_head *dst, unsigned long idx_start, unsigned int npages)
+static inline int nfs_scan_commit(struct inode *inode, struct list_head *dst,
+		unsigned long idx_start, unsigned int npages, unsigned int maxpages)
 {
 	return 0;
 }
 #endif
 
+static int nfs_do_commit(struct super_block *sb, int npages);
+
+static int nfs_commit_congestion(struct inode *inode)
+{
+	struct nfs_server *nfss = NFS_SERVER(inode);
+	int thresh, excess_commit;
+	int ret = 0;
+
+	if (!commit_pressure(inode))
+		goto out;
+
+	thresh = atomic_read(&nfss->writeback);
+	if (thresh < 128)
+		thresh = 128;
+	if (thresh > NFS_CONGESTION_OFF_THRESH)
+		thresh = NFS_CONGESTION_OFF_THRESH;
+
+	excess_commit = atomic_read(&nfss->commit) - thresh;
+
+	/*
+	 * limit the flush to stable storage - this should
+	 * avoid flushing most of the unstable pages when there
+	 * is not much real pressure but they just tripped the
+	 * dirty page boundary.
+	 */
+	thresh /= 2;
+	if (excess_commit > thresh)
+		excess_commit = thresh;
+
+	while (excess_commit > 0 && commit_pressure(inode)) {
+		int npages = min(16, excess_commit);
+		npages = nfs_do_commit(inode->i_sb, npages);
+		if (npages <= 0)
+			break;
+		excess_commit -= npages;
+		ret = 1;
+		cond_resched();
+	}
+out:
+	return ret;
+}
+
 static int nfs_wait_on_write_congestion(struct address_space *mapping, int intr)
 {
+	struct inode *inode = mapping->host;
 	struct backing_dev_info *bdi = mapping->backing_dev_info;
-	DEFINE_WAIT(wait);
 	int ret = 0;
 
 	might_sleep();
 
-	if (!bdi_write_congested(bdi))
+	if (!bdi_write_congested(bdi)) {
+		nfs_commit_congestion(inode);
 		return 0;
+	}
 
-	nfs_inc_stats(mapping->host, NFSIOS_CONGESTIONWAIT);
+	nfs_inc_stats(inode, NFSIOS_CONGESTIONWAIT);
 
-	if (intr) {
-		struct rpc_clnt *clnt = NFS_CLIENT(mapping->host);
-		sigset_t oldset;
-
-		rpc_clnt_sigmask(clnt, &oldset);
-		prepare_to_wait(&nfs_write_congestion, &wait, TASK_INTERRUPTIBLE);
-		if (bdi_write_congested(bdi)) {
-			if (signalled())
-				ret = -ERESTARTSYS;
-			else
-				schedule();
+	do {
+		if (nfs_commit_congestion(inode) &&
+				!bdi_write_congested(bdi))
+			break;
+
+		if (intr) {
+			struct rpc_clnt *clnt = NFS_CLIENT(inode);
+			sigset_t oldset;
+
+			rpc_clnt_sigmask(clnt, &oldset);
+			ret = congestion_wait_interruptible(WRITE, HZ/10);
+			rpc_clnt_sigunmask(clnt, &oldset);
+			if (ret == -ERESTARTSYS)
+				return ret;
+			ret = 0;
+		} else {
+			congestion_wait(WRITE, HZ/10);
 		}
-		rpc_clnt_sigunmask(clnt, &oldset);
-	} else {
-		prepare_to_wait(&nfs_write_congestion, &wait, TASK_UNINTERRUPTIBLE);
-		if (bdi_write_congested(bdi))
-			schedule();
-	}
-	finish_wait(&nfs_write_congestion, &wait);
+	} while (bdi_write_congested(bdi));
+
 	return ret;
 }
 
-
 /*
  * Try to update any existing write request, or create one if there is none.
  * In order to match, the request's credentials must match those of
@@ -779,7 +895,7 @@ int nfs_updatepage(struct file *file, st
 
 static void nfs_writepage_release(struct nfs_page *req)
 {
-	end_page_writeback(req->wb_page);
+	nfs_end_page_writeback(req->wb_page);
 
 #if defined(CONFIG_NFS_V3) || defined(CONFIG_NFS_V4)
 	if (!PageError(req->wb_page)) {
@@ -1095,12 +1211,12 @@ static void nfs_writeback_done_full(stru
 			ClearPageUptodate(page);
 			SetPageError(page);
 			req->wb_context->error = task->tk_status;
-			end_page_writeback(page);
+			nfs_end_page_writeback(page);
 			nfs_inode_remove_request(req);
 			dprintk(", error = %d\n", task->tk_status);
 			goto next;
 		}
-		end_page_writeback(page);
+		nfs_end_page_writeback(page);
 
 #if defined(CONFIG_NFS_V3) || defined(CONFIG_NFS_V4)
 		if (data->args.stable != NFS_UNSTABLE || data->verf.committed == NFS_FILE_SYNC) {
@@ -1277,7 +1393,7 @@ nfs_commit_list(struct inode *inode, str
 		req = nfs_list_entry(head->next);
 		nfs_list_remove_request(req);
 		nfs_mark_request_commit(req);
-		dec_zone_page_state(req->wb_page, NR_UNSTABLE_NFS);
+		nfs_end_page_commit(req->wb_page);
 		nfs_clear_page_writeback(req);
 	}
 	return -ENOMEM;
@@ -1301,7 +1417,7 @@ static void nfs_commit_done(struct rpc_t
 	while (!list_empty(&data->pages)) {
 		req = nfs_list_entry(data->pages.next);
 		nfs_list_remove_request(req);
-		dec_zone_page_state(req->wb_page, NR_UNSTABLE_NFS);
+		nfs_end_page_commit(req->wb_page);
 
 		dprintk("NFS: commit (%s/%Ld %d@%Ld)",
 			req->wb_context->dentry->d_inode->i_sb->s_id,
@@ -1367,7 +1483,7 @@ int nfs_commit_inode(struct inode *inode
 	int res;
 
 	spin_lock(&nfsi->req_lock);
-	res = nfs_scan_commit(inode, &head, 0, 0);
+	res = nfs_scan_commit(inode, &head, 0, 0, 0);
 	spin_unlock(&nfsi->req_lock);
 	if (res) {
 		int error = nfs_commit_list(inode, &head, how);
@@ -1378,6 +1494,43 @@ int nfs_commit_inode(struct inode *inode
 }
 #endif
 
+static int nfs_do_commit(struct super_block *sb, int npages)
+{
+	struct inode *inode;
+	int ret = 0;
+
+	down_read(&sb->s_umount);
+	spin_lock(&inode_lock);
+	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
+		struct nfs_inode *nsfi = NFS_I(inode);
+		LIST_HEAD(head);
+		int res;
+
+		if (inode->i_state & (I_FREEING|I_WILL_FREE))
+			continue;
+
+		spin_lock(&nsfi->req_lock);
+		res = nfs_scan_commit(inode, &head, 0, 0, npages);
+		spin_unlock(&nsfi->req_lock);
+		ret += res;
+		npages -= res;
+		if (res) {
+			res = nfs_commit_list(inode, &head, FLUSH_HIGHPRI);
+			if (res < 0) {
+				ret = res;
+				break;
+			}
+		}
+
+		if (npages <= 0)
+			break;
+	}
+	spin_unlock(&inode_lock);
+	up_read(&sb->s_umount);
+
+	return ret;
+}
+
 long nfs_sync_mapping_wait(struct address_space *mapping, struct writeback_control *wbc, int how)
 {
 	struct inode *inode = mapping->host;
@@ -1424,7 +1577,7 @@ long nfs_sync_mapping_wait(struct addres
 			continue;
 		if (nocommit)
 			break;
-		pages = nfs_scan_commit(inode, &head, idx_start, npages);
+		pages = nfs_scan_commit(inode, &head, idx_start, npages, 0);
 		if (pages == 0) {
 			if (wbc->pages_skipped != 0)
 				continue;
@@ -1437,7 +1590,7 @@ long nfs_sync_mapping_wait(struct addres
 			spin_lock(&nfsi->req_lock);
 			continue;
 		}
-		pages += nfs_scan_commit(inode, &head, 0, 0);
+		pages += nfs_scan_commit(inode, &head, 0, 0, 0);
 		spin_unlock(&nfsi->req_lock);
 		ret = nfs_commit_list(inode, &head, how);
 		spin_lock(&nfsi->req_lock);
Index: linux-2.6-git/mm/backing-dev.c
===================================================================
--- linux-2.6-git.orig/mm/backing-dev.c	2007-01-12 08:03:47.000000000 +0100
+++ linux-2.6-git/mm/backing-dev.c	2007-01-12 08:53:26.000000000 +0100
@@ -55,6 +55,22 @@ long congestion_wait(int rw, long timeou
 }
 EXPORT_SYMBOL(congestion_wait);
 
+long congestion_wait_interruptible(int rw, long timeout)
+{
+	long ret;
+	DEFINE_WAIT(wait);
+	wait_queue_head_t *wqh = &congestion_wqh[rw];
+
+	prepare_to_wait(wqh, &wait, TASK_INTERRUPTIBLE);
+	if (signal_pending(current))
+		ret = -ERESTARTSYS;
+	else
+		ret = io_schedule_timeout(timeout);
+	finish_wait(wqh, &wait);
+	return ret;
+}
+EXPORT_SYMBOL(congestion_wait_interruptible);
+
 /**
  * congestion_end - wake up sleepers on a congested backing_dev_info
  * @rw: READ or WRITE
Index: linux-2.6-git/include/linux/nfs_fs_sb.h
===================================================================
--- linux-2.6-git.orig/include/linux/nfs_fs_sb.h	2007-01-12 08:03:47.000000000 +0100
+++ linux-2.6-git/include/linux/nfs_fs_sb.h	2007-01-12 08:53:26.000000000 +0100
@@ -82,6 +82,8 @@ struct nfs_server {
 	struct rpc_clnt *	client_acl;	/* ACL RPC client handle */
 	struct nfs_iostats *	io_stats;	/* I/O statistics */
 	struct backing_dev_info	backing_dev_info;
+	atomic_t		writeback;	/* number of writeback pages */
+	atomic_t		commit;		/* number of commit pages */
 	int			flags;		/* various flags */
 	unsigned int		caps;		/* server capabilities */
 	unsigned int		rsize;		/* read size */
Index: linux-2.6-git/include/linux/backing-dev.h
===================================================================
--- linux-2.6-git.orig/include/linux/backing-dev.h	2007-01-12 08:03:47.000000000 +0100
+++ linux-2.6-git/include/linux/backing-dev.h	2007-01-12 08:53:26.000000000 +0100
@@ -93,6 +93,7 @@ static inline int bdi_rw_congested(struc
 void clear_bdi_congested(struct backing_dev_info *bdi, int rw);
 void set_bdi_congested(struct backing_dev_info *bdi, int rw);
 long congestion_wait(int rw, long timeout);
+long congestion_wait_interruptible(int rw, long timeout);
 void congestion_end(int rw);
 
 #define bdi_cap_writeback_dirty(bdi) \
Index: linux-2.6-git/include/linux/writeback.h
===================================================================
--- linux-2.6-git.orig/include/linux/writeback.h	2007-01-12 08:03:47.000000000 +0100
+++ linux-2.6-git/include/linux/writeback.h	2007-01-12 08:53:26.000000000 +0100
@@ -100,6 +100,7 @@ int dirty_writeback_centisecs_handler(st
 				      void __user *, size_t *, loff_t *);
 
 void page_writeback_init(void);
+int dirty_pages_exceeded(struct address_space *mapping);
 void balance_dirty_pages_ratelimited_nr(struct address_space *mapping,
 					unsigned long nr_pages_dirtied);
 
Index: linux-2.6-git/mm/page-writeback.c
===================================================================
--- linux-2.6-git.orig/mm/page-writeback.c	2007-01-12 08:03:47.000000000 +0100
+++ linux-2.6-git/mm/page-writeback.c	2007-01-12 08:53:26.000000000 +0100
@@ -167,6 +167,12 @@ get_dirty_limits(long *pbackground, long
 	*pdirty = dirty;
 }
 
+int dirty_pages_exceeded(struct address_space *mapping)
+{
+	return dirty_exceeded;
+}
+EXPORT_SYMBOL_GPL(dirty_pages_exceeded);
+
 /*
  * balance_dirty_pages() must be called by processes which are generating dirty
  * data.  It looks at the number of dirty pages in the machine and will force
Index: linux-2.6-git/fs/nfs/pagelist.c
===================================================================
--- linux-2.6-git.orig/fs/nfs/pagelist.c	2007-01-12 08:03:47.000000000 +0100
+++ linux-2.6-git/fs/nfs/pagelist.c	2007-01-12 08:53:26.000000000 +0100
@@ -356,7 +356,7 @@ out:
  */
 int nfs_scan_list(struct nfs_inode *nfsi, struct list_head *head,
 		struct list_head *dst, unsigned long idx_start,
-		unsigned int npages)
+		unsigned int npages, unsigned int maxpages)
 {
 	struct nfs_page *pgvec[NFS_SCAN_MAXENTRIES];
 	struct nfs_page *req;
@@ -370,6 +370,9 @@ int nfs_scan_list(struct nfs_inode *nfsi
 	else
 		idx_end = idx_start + npages - 1;
 
+	if (maxpages == 0)
+		maxpages = ~0;
+
 	for (;;) {
 		found = radix_tree_gang_lookup(&nfsi->nfs_page_tree,
 				(void **)&pgvec[0], idx_start,
@@ -387,7 +390,10 @@ int nfs_scan_list(struct nfs_inode *nfsi
 				nfs_list_remove_request(req);
 				nfs_list_add_request(req, dst);
 				res++;
+				maxpages--;
 			}
+			if (!maxpages)
+				goto out;
 		}
 
 	}
Index: linux-2.6-git/include/linux/nfs_page.h
===================================================================
--- linux-2.6-git.orig/include/linux/nfs_page.h	2007-01-12 08:03:47.000000000 +0100
+++ linux-2.6-git/include/linux/nfs_page.h	2007-01-12 08:53:26.000000000 +0100
@@ -66,7 +66,7 @@ extern	long nfs_scan_dirty(struct addres
 				struct writeback_control *wbc,
 				struct list_head *dst);
 extern	int nfs_scan_list(struct nfs_inode *nfsi, struct list_head *head, struct list_head *dst,
-			  unsigned long idx_start, unsigned int npages);
+			  unsigned long idx_start, unsigned int npages, unsigned int maxpages);
 extern	int nfs_coalesce_requests(struct list_head *, struct list_head *,
 				  unsigned int);
 extern  int nfs_wait_on_request(struct nfs_page *);
Index: linux-2.6-git/fs/inode.c
===================================================================
--- linux-2.6-git.orig/fs/inode.c	2007-01-12 08:03:47.000000000 +0100
+++ linux-2.6-git/fs/inode.c	2007-01-12 08:53:26.000000000 +0100
@@ -81,6 +81,7 @@ static struct hlist_head *inode_hashtabl
  * the i_state of an inode while it is in use..
  */
 DEFINE_SPINLOCK(inode_lock);
+EXPORT_SYMBOL_GPL(inode_lock);
 
 /*
  * iprune_mutex provides exclusion between the kswapd or try_to_free_pages


