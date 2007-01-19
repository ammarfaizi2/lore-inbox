Return-Path: <linux-kernel-owner+w=401wt.eu-S965121AbXASNJb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965121AbXASNJb (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 08:09:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965125AbXASNJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 08:09:31 -0500
Received: from amsfep19-int.chello.nl ([213.46.243.16]:62630 "EHLO
	amsfep11-int.chello.nl" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S965121AbXASNJa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 08:09:30 -0500
Subject: Re: [PATCH] nfs: fix congestion control
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Christoph Lameter <clameter@sgi.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <1169199234.6197.129.camel@twins>
References: <20070116054743.15358.77287.sendpatchset@schroedinger.engr.sgi.com>
	 <20070116135325.3441f62b.akpm@osdl.org> <1168985323.5975.53.camel@lappy>
	 <Pine.LNX.4.64.0701171158290.7397@schroedinger.engr.sgi.com>
	 <1169070763.5975.70.camel@lappy>
	 <1169070886.6523.8.camel@lade.trondhjem.org>
	 <1169126868.6197.55.camel@twins>
	 <1169135375.6105.15.camel@lade.trondhjem.org>
	 <1169199234.6197.129.camel@twins>
Content-Type: text/plain
Date: Fri, 19 Jan 2007 14:07:02 +0100
Message-Id: <1169212022.6197.148.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2007-01-19 at 10:34 +0100, Peter Zijlstra wrote:
> On Thu, 2007-01-18 at 10:49 -0500, Trond Myklebust wrote:
> 
> > After the dirty page has been written to unstable storage, it marks the
> > inode using I_DIRTY_DATASYNC, which should then ensure that the VFS
> > calls write_inode() on the next pass through __sync_single_inode.
> 
> > I'd rather like to see fs/fs-writeback.c do this correctly (assuming
> > that it is incorrect now).
> 
> balance_dirty_pages()
>   wbc.sync_mode = WB_SYNC_NONE;
>   writeback_inodes()
>     sync_sb_inodes()
>       __writeback_single_inode()
>         __sync_single_inode()
>           write_inode()
>             nfs_write_inode()
> 
> Ah, yes, I see. That ought to work.
> 
> /me goes verify he didn't mess it up himself...

And of course I did. This seems to work.

The problem I had was that throttle_vm_writeout() got stuck on commit
pages. But that can be solved with a much much simpler and better
solution. Force all swap traffic to be |FLUSH_STABLE, unstable swap
space doesn't make sense anyway :-)

So with that out of the way I now have this

---

Subject: nfs: fix congestion control

The current NFS client congestion logic is severly broken, it marks the backing
device congested during each nfs_writepages() call but doesn't mirror this in
nfs_writepage() which makes for deadlocks. Also it implements its own waitqueue.

Replace this by a more regular congestion implementation that puts a cap on the
number of active writeback pages and uses the bdi congestion waitqueue.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>
---
 fs/nfs/write.c              |  113 ++++++++++++++++++++++++++++----------------
 include/linux/backing-dev.h |    1 
 include/linux/nfs_fs_sb.h   |    1 
 mm/backing-dev.c            |   16 ++++++
 4 files changed, 90 insertions(+), 41 deletions(-)

Index: linux-2.6-git/fs/nfs/write.c
===================================================================
--- linux-2.6-git.orig/fs/nfs/write.c	2007-01-19 13:57:49.000000000 +0100
+++ linux-2.6-git/fs/nfs/write.c	2007-01-19 14:03:30.000000000 +0100
@@ -89,8 +89,6 @@ static struct kmem_cache *nfs_wdata_cach
 static mempool_t *nfs_wdata_mempool;
 static mempool_t *nfs_commit_mempool;
 
-static DECLARE_WAIT_QUEUE_HEAD(nfs_write_congestion);
-
 struct nfs_write_data *nfs_commit_alloc(void)
 {
 	struct nfs_write_data *p = mempool_alloc(nfs_commit_mempool, GFP_NOFS);
@@ -245,6 +243,39 @@ static int wb_priority(struct writeback_
 }
 
 /*
+ * NFS congestion control
+ */
+
+static unsigned long nfs_congestion_pages;
+
+#define NFS_CONGESTION_ON_THRESH 	nfs_congestion_pages
+#define NFS_CONGESTION_OFF_THRESH	\
+	(NFS_CONGESTION_ON_THRESH - (NFS_CONGESTION_ON_THRESH >> 2))
+
+static inline void nfs_set_page_writeback(struct page *page)
+{
+	if (!test_set_page_writeback(page)) {
+		struct inode *inode = page->mapping->host;
+		struct nfs_server *nfss = NFS_SERVER(inode);
+
+		if (atomic_inc_return(&nfss->writeback) > NFS_CONGESTION_ON_THRESH)
+			set_bdi_congested(&nfss->backing_dev_info, WRITE);
+	}
+}
+
+static inline void nfs_end_page_writeback(struct page *page)
+{
+	struct inode *inode = page->mapping->host;
+	struct nfs_server *nfss = NFS_SERVER(inode);
+
+	end_page_writeback(page);
+	if (atomic_dec_return(&nfss->writeback) < NFS_CONGESTION_OFF_THRESH) {
+		clear_bdi_congested(&nfss->backing_dev_info, WRITE);
+		congestion_end(WRITE);
+	}
+}
+
+/*
  * Find an associated nfs write request, and prepare to flush it out
  * Returns 1 if there was no write request, or if the request was
  * already tagged by nfs_set_page_dirty.Returns 0 if the request
@@ -281,7 +312,7 @@ static int nfs_page_mark_flush(struct pa
 	spin_unlock(req_lock);
 	if (test_and_set_bit(PG_FLUSHING, &req->wb_flags) == 0) {
 		nfs_mark_request_dirty(req);
-		set_page_writeback(page);
+		nfs_set_page_writeback(page);
 	}
 	ret = test_bit(PG_NEED_FLUSH, &req->wb_flags);
 	nfs_unlock_request(req);
@@ -336,13 +367,8 @@ int nfs_writepage(struct page *page, str
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
 
@@ -351,11 +377,6 @@ int nfs_writepages(struct address_space 
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
@@ -369,9 +390,6 @@ int nfs_writepages(struct address_space 
 	if (err > 0)
 		err = 0;
 out:
-	clear_bit(BDI_write_congested, &bdi->state);
-	wake_up_all(&nfs_write_congestion);
-	congestion_end(WRITE);
 	return err;
 }
 
@@ -401,7 +419,7 @@ static int nfs_inode_add_request(struct 
 }
 
 /*
- * Insert a write request into an inode
+ * Remove a write request from an inode
  */
 static void nfs_inode_remove_request(struct nfs_page *req)
 {
@@ -585,8 +603,8 @@ static inline int nfs_scan_commit(struct
 
 static int nfs_wait_on_write_congestion(struct address_space *mapping, int intr)
 {
+	struct inode *inode = mapping->host;
 	struct backing_dev_info *bdi = mapping->backing_dev_info;
-	DEFINE_WAIT(wait);
 	int ret = 0;
 
 	might_sleep();
@@ -594,31 +612,27 @@ static int nfs_wait_on_write_congestion(
 	if (!bdi_write_congested(bdi))
 		return 0;
 
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
@@ -779,7 +793,7 @@ int nfs_updatepage(struct file *file, st
 
 static void nfs_writepage_release(struct nfs_page *req)
 {
-	end_page_writeback(req->wb_page);
+	nfs_end_page_writeback(req->wb_page);
 
 #if defined(CONFIG_NFS_V3) || defined(CONFIG_NFS_V4)
 	if (!PageError(req->wb_page)) {
@@ -1095,12 +1109,12 @@ static void nfs_writeback_done_full(stru
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
@@ -1565,6 +1579,23 @@ int __init nfs_init_writepagecache(void)
 	if (nfs_commit_mempool == NULL)
 		return -ENOMEM;
 
+	/*
+	 * NFS congestion size, scale with available memory.
+	 *
+	 *  64MB:    8192k
+	 * 128MB:   11585k
+	 * 256MB:   16384k
+	 * 512MB:   23170k
+	 *   1GB:   32768k
+	 *   2GB:   46340k
+	 *   4GB:   65536k
+	 *   8GB:   92681k
+	 *  16GB:  131072k
+	 *
+	 * This allows larger machines to have larger/more transfers.
+	 */
+	nfs_congestion_size = 32*int_sqrt(totalram_pages);
+
 	return 0;
 }
 
Index: linux-2.6-git/mm/backing-dev.c
===================================================================
--- linux-2.6-git.orig/mm/backing-dev.c	2007-01-19 13:57:49.000000000 +0100
+++ linux-2.6-git/mm/backing-dev.c	2007-01-19 13:57:52.000000000 +0100
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
--- linux-2.6-git.orig/include/linux/nfs_fs_sb.h	2007-01-19 13:57:49.000000000 +0100
+++ linux-2.6-git/include/linux/nfs_fs_sb.h	2007-01-19 13:57:52.000000000 +0100
@@ -82,6 +82,7 @@ struct nfs_server {
 	struct rpc_clnt *	client_acl;	/* ACL RPC client handle */
 	struct nfs_iostats *	io_stats;	/* I/O statistics */
 	struct backing_dev_info	backing_dev_info;
+	atomic_t		writeback;	/* number of writeback pages */
 	int			flags;		/* various flags */
 	unsigned int		caps;		/* server capabilities */
 	unsigned int		rsize;		/* read size */
Index: linux-2.6-git/include/linux/backing-dev.h
===================================================================
--- linux-2.6-git.orig/include/linux/backing-dev.h	2007-01-19 13:57:49.000000000 +0100
+++ linux-2.6-git/include/linux/backing-dev.h	2007-01-19 13:57:52.000000000 +0100
@@ -93,6 +93,7 @@ static inline int bdi_rw_congested(struc
 void clear_bdi_congested(struct backing_dev_info *bdi, int rw);
 void set_bdi_congested(struct backing_dev_info *bdi, int rw);
 long congestion_wait(int rw, long timeout);
+long congestion_wait_interruptible(int rw, long timeout);
 void congestion_end(int rw);
 
 #define bdi_cap_writeback_dirty(bdi) \


