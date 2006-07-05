Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964972AbWGES1B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964972AbWGES1B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 14:27:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964974AbWGES1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 14:27:00 -0400
Received: from pat.uio.no ([129.240.10.4]:10908 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S964972AbWGES07 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 14:26:59 -0400
Subject: [GIT] NFS client fixes for linux 2.6.17
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net,
       nfsv4@linux-nfs.org
Content-Type: text/plain
Date: Wed, 05 Jul 2006 14:26:47 -0400
Message-Id: <1152124008.14409.4.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.541, required 12,
	autolearn=disabled, AWL 1.46, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the repository at

   git pull git://git.linux-nfs.org/pub/linux/nfs-2.6.git

This will update the following files through the appended changesets.

  Cheers,
    Trond

----
 fs/lockd/clntproc.c     |   26 ++-
 fs/locks.c              |   23 ++
 fs/nfs/dir.c            |    4 
 fs/nfs/direct.c         |  435 ++++++++++++++++++++++-------------------------
 fs/nfs/nfs4proc.c       |   74 ++++----
 fs/nfs/write.c          |   20 ++
 include/linux/fs.h      |    1 
 include/linux/nfs_xdr.h |    2 
 net/sunrpc/xdr.c        |    3 
 9 files changed, 304 insertions(+), 284 deletions(-)

commit 4e0641a7ad98fca5646a6be17605bc80f6c4ebde
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Wed Jul 5 13:05:13 2006 -0400

    NFS: Optimise away an excessive GETATTR call when a file is symlinked
    
    In the case when compiling via a symlink tree, we want to ensure that the
    close-to-open GETATTR call is applied only to the final file, and not to
    the symlink.
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit bce3481c91801665e17f8daf59ede946129f3d3f
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Wed Jul 5 13:17:12 2006 -0400

    This fixes a panic doing the first READDIR or READDIRPLUS call when:
    
    * the client is ia64 or any platform that actually implements
        flush_dcache_page(), and
    
      * the server returns fsinfo.dtpref >= client's PAGE_SIZE, and
    
      * the server does *not* return post-op attributes for the directory
        in the READDIR reply.
    
    Problem diagnosed by Greg Banks <gnb@melbourne.sgi.com>
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 83715ad54fad5a7ed330110f83e31ae92630e9d9
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Wed Jul 5 13:17:12 2006 -0400

    NFS: Fix NFS page_state usage
    
    The introduction of the FLUSH_INVALIDATE argument to nfs_sync_inode_wait()
    does not clear the nr_unstable page state counter for pages that are being
    released.
    
    Also fix a longstanding similar bug when nfs_commit_list() fails.
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 01c3b861cd77b28565a2d18c7caa3ce7f938e35c
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Thu Jun 29 16:38:39 2006 -0400

    NLM,NFSv4: Wait on local locks before we put RPC calls on the wire
    
    Use FL_ACCESS flag to test and/or wait for local locks before we try
    requesting a lock from the server
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit f07f18dd6f29f11887b8d9cf7ecb736bf2f7dc62
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Thu Jun 29 16:38:37 2006 -0400

    VFS: Add support for the FL_ACCESS flag to flock_lock_file()
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 42a2d13eee3c895d22e9d1a52b96d15ca49adabc
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Thu Jun 29 16:38:36 2006 -0400

    NFSv4: Ensure nfs4_lock_expired() caches delegated locks
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 9b07357490e5c7a1c3c2b6f4679d7ee4b4185ecd
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Thu Jun 29 16:38:34 2006 -0400

    NLM,NFSv4: Don't put UNLOCK requests on the wire unless we hold a lock
    
    Use the new behaviour of {flock,posix}_file_lock(F_UNLCK) to determine if
    we held a lock, and only send the RPC request to the server if this was the
    case.
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit f475ae957db66650db66916c62604ac27409d884
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Thu Jun 29 16:38:32 2006 -0400

    VFS: Allow caller to determine if BSD or posix locks were actually freed
    
    Change posix_lock_file_conf(), and flock_lock_file() so that if called
    with an F_UNLCK argument, and the FL_EXISTS flag they will indicate
    whether or not any locks were actually freed by returning 0 or -ENOENT.
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 607f31e80b6f982d7c0dd7a5045377fc368fe507
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Wed Jun 28 16:52:45 2006 -0400

    Revert "Merge branch 'odirect'"
    
    This reverts ccf01ef7aa9c6c293a1c64c27331a2ce227916ec commit.
    
    No idea how git managed this one: when I asked it to merge the odirect
    topic branch it actually generated a patch which reverted the change.
    
    Reverting the 'merge' will once again reveal Chuck's recent NFS/O_DIRECT
    work to the world.
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

diff --git a/fs/lockd/clntproc.c b/fs/lockd/clntproc.c
index 5980c45..89ba0df 100644
--- a/fs/lockd/clntproc.c
+++ b/fs/lockd/clntproc.c
@@ -454,7 +454,7 @@ static void nlmclnt_locks_init_private(s
 	fl->fl_ops = &nlmclnt_lock_ops;
 }
 
-static void do_vfs_lock(struct file_lock *fl)
+static int do_vfs_lock(struct file_lock *fl)
 {
 	int res = 0;
 	switch (fl->fl_flags & (FL_POSIX|FL_FLOCK)) {
@@ -467,9 +467,7 @@ static void do_vfs_lock(struct file_lock
 		default:
 			BUG();
 	}
-	if (res < 0)
-		printk(KERN_WARNING "%s: VFS is out of sync with lock manager!\n",
-				__FUNCTION__);
+	return res;
 }
 
 /*
@@ -498,6 +496,7 @@ nlmclnt_lock(struct nlm_rqst *req, struc
 	struct nlm_host	*host = req->a_host;
 	struct nlm_res	*resp = &req->a_res;
 	struct nlm_wait *block = NULL;
+	unsigned char fl_flags = fl->fl_flags;
 	int status = -ENOLCK;
 
 	if (!host->h_monitored && nsm_monitor(host) < 0) {
@@ -505,6 +504,10 @@ nlmclnt_lock(struct nlm_rqst *req, struc
 					host->h_name);
 		goto out;
 	}
+	fl->fl_flags |= FL_ACCESS;
+	status = do_vfs_lock(fl);
+	if (status < 0)
+		goto out;
 
 	block = nlmclnt_prepare_block(host, fl);
 again:
@@ -539,9 +542,10 @@ again:
 			up_read(&host->h_rwsem);
 			goto again;
 		}
-		fl->fl_flags |= FL_SLEEP;
 		/* Ensure the resulting lock will get added to granted list */
-		do_vfs_lock(fl);
+		fl->fl_flags = fl_flags | FL_SLEEP;
+		if (do_vfs_lock(fl) < 0)
+			printk(KERN_WARNING "%s: VFS is out of sync with lock manager!\n", __FUNCTION__);
 		up_read(&host->h_rwsem);
 	}
 	status = nlm_stat_to_errno(resp->status);
@@ -552,6 +556,7 @@ out_unblock:
 		nlmclnt_cancel(host, req->a_args.block, fl);
 out:
 	nlm_release_call(req);
+	fl->fl_flags = fl_flags;
 	return status;
 }
 
@@ -606,15 +611,19 @@ nlmclnt_unlock(struct nlm_rqst *req, str
 {
 	struct nlm_host	*host = req->a_host;
 	struct nlm_res	*resp = &req->a_res;
-	int		status;
+	int status = 0;
 
 	/*
 	 * Note: the server is supposed to either grant us the unlock
 	 * request, or to deny it with NLM_LCK_DENIED_GRACE_PERIOD. In either
 	 * case, we want to unlock.
 	 */
+	fl->fl_flags |= FL_EXISTS;
 	down_read(&host->h_rwsem);
-	do_vfs_lock(fl);
+	if (do_vfs_lock(fl) == -ENOENT) {
+		up_read(&host->h_rwsem);
+		goto out;
+	}
 	up_read(&host->h_rwsem);
 
 	if (req->a_flags & RPC_TASK_ASYNC)
@@ -624,7 +633,6 @@ nlmclnt_unlock(struct nlm_rqst *req, str
 	if (status < 0)
 		goto out;
 
-	status = 0;
 	if (resp->status == NLM_LCK_GRANTED)
 		goto out;
 
diff --git a/fs/locks.c b/fs/locks.c
index 1ad29c9..b0b41a6 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -725,6 +725,10 @@ next_task:
 /* Try to create a FLOCK lock on filp. We always insert new FLOCK locks
  * at the head of the list, but that's secret knowledge known only to
  * flock_lock_file and posix_lock_file.
+ *
+ * Note that if called with an FL_EXISTS argument, the caller may determine
+ * whether or not a lock was successfully freed by testing the return
+ * value for -ENOENT.
  */
 static int flock_lock_file(struct file *filp, struct file_lock *request)
 {
@@ -735,6 +739,8 @@ static int flock_lock_file(struct file *
 	int found = 0;
 
 	lock_kernel();
+	if (request->fl_flags & FL_ACCESS)
+		goto find_conflict;
 	for_each_lock(inode, before) {
 		struct file_lock *fl = *before;
 		if (IS_POSIX(fl))
@@ -750,8 +756,11 @@ static int flock_lock_file(struct file *
 		break;
 	}
 
-	if (request->fl_type == F_UNLCK)
+	if (request->fl_type == F_UNLCK) {
+		if ((request->fl_flags & FL_EXISTS) && !found)
+			error = -ENOENT;
 		goto out;
+	}
 
 	error = -ENOMEM;
 	new_fl = locks_alloc_lock();
@@ -764,6 +773,7 @@ static int flock_lock_file(struct file *
 	if (found)
 		cond_resched();
 
+find_conflict:
 	for_each_lock(inode, before) {
 		struct file_lock *fl = *before;
 		if (IS_POSIX(fl))
@@ -777,6 +787,8 @@ static int flock_lock_file(struct file *
 			locks_insert_block(fl, request);
 		goto out;
 	}
+	if (request->fl_flags & FL_ACCESS)
+		goto out;
 	locks_copy_lock(new_fl, request);
 	locks_insert_lock(&inode->i_flock, new_fl);
 	new_fl = NULL;
@@ -948,8 +960,11 @@ static int __posix_lock_file_conf(struct
 
 	error = 0;
 	if (!added) {
-		if (request->fl_type == F_UNLCK)
+		if (request->fl_type == F_UNLCK) {
+			if (request->fl_flags & FL_EXISTS)
+				error = -ENOENT;
 			goto out;
+		}
 
 		if (!new_fl) {
 			error = -ENOLCK;
@@ -996,6 +1011,10 @@ static int __posix_lock_file_conf(struct
  * Add a POSIX style lock to a file.
  * We merge adjacent & overlapping locks whenever possible.
  * POSIX locks are sorted by owner task, then by starting address
+ *
+ * Note that if called with an FL_EXISTS argument, the caller may determine
+ * whether or not a lock was successfully freed by testing the return
+ * value for -ENOENT.
  */
 int posix_lock_file(struct file *filp, struct file_lock *fl)
 {
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 3ddda6f..e7ffb4d 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -690,7 +690,9 @@ int nfs_lookup_verify_inode(struct inode
 			goto out_force;
 		/* This is an open(2) */
 		if (nfs_lookup_check_intent(nd, LOOKUP_OPEN) != 0 &&
-				!(server->flags & NFS_MOUNT_NOCTO))
+				!(server->flags & NFS_MOUNT_NOCTO) &&
+				(S_ISREG(inode->i_mode) ||
+				 S_ISDIR(inode->i_mode)))
 			goto out_force;
 	}
 	return nfs_revalidate_inode(server, inode);
diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 4cdd1b4..fecd3b0 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -67,25 +67,19 @@ struct nfs_direct_req {
 	struct kref		kref;		/* release manager */
 
 	/* I/O parameters */
-	struct list_head	list,		/* nfs_read/write_data structs */
-				rewrite_list;	/* saved nfs_write_data structs */
 	struct nfs_open_context	*ctx;		/* file open context info */
 	struct kiocb *		iocb;		/* controlling i/o request */
 	struct inode *		inode;		/* target file of i/o */
-	unsigned long		user_addr;	/* location of user's buffer */
-	size_t			user_count;	/* total bytes to move */
-	loff_t			pos;		/* starting offset in file */
-	struct page **		pages;		/* pages in our buffer */
-	unsigned int		npages;		/* count of pages */
 
 	/* completion state */
+	atomic_t		io_count;	/* i/os we're waiting for */
 	spinlock_t		lock;		/* protect completion state */
-	int			outstanding;	/* i/os we're waiting for */
 	ssize_t			count,		/* bytes actually processed */
 				error;		/* any reported error */
 	struct completion	completion;	/* wait for i/o completion */
 
 	/* commit state */
+	struct list_head	rewrite_list;	/* saved nfs_write_data structs */
 	struct nfs_write_data *	commit_data;	/* special write_data for commits */
 	int			flags;
 #define NFS_ODIRECT_DO_COMMIT		(1)	/* an unstable reply was received */
@@ -93,8 +87,37 @@ #define NFS_ODIRECT_RESCHED_WRITES	(2)	/
 	struct nfs_writeverf	verf;		/* unstable write verifier */
 };
 
-static void nfs_direct_write_schedule(struct nfs_direct_req *dreq, int sync);
 static void nfs_direct_write_complete(struct nfs_direct_req *dreq, struct inode *inode);
+static const struct rpc_call_ops nfs_write_direct_ops;
+
+static inline void get_dreq(struct nfs_direct_req *dreq)
+{
+	atomic_inc(&dreq->io_count);
+}
+
+static inline int put_dreq(struct nfs_direct_req *dreq)
+{
+	return atomic_dec_and_test(&dreq->io_count);
+}
+
+/*
+ * "size" is never larger than rsize or wsize.
+ */
+static inline int nfs_direct_count_pages(unsigned long user_addr, size_t size)
+{
+	int page_count;
+
+	page_count = (user_addr + size + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	page_count -= user_addr >> PAGE_SHIFT;
+	BUG_ON(page_count < 0);
+
+	return page_count;
+}
+
+static inline unsigned int nfs_max_pages(unsigned int size)
+{
+	return (size + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
+}
 
 /**
  * nfs_direct_IO - NFS address space operation for direct I/O
@@ -118,50 +141,21 @@ ssize_t nfs_direct_IO(int rw, struct kio
 	return -EINVAL;
 }
 
-static void nfs_free_user_pages(struct page **pages, int npages, int do_dirty)
+static void nfs_direct_dirty_pages(struct page **pages, int npages)
 {
 	int i;
 	for (i = 0; i < npages; i++) {
 		struct page *page = pages[i];
-		if (do_dirty && !PageCompound(page))
+		if (!PageCompound(page))
 			set_page_dirty_lock(page);
-		page_cache_release(page);
 	}
-	kfree(pages);
 }
 
-static inline int nfs_get_user_pages(int rw, unsigned long user_addr, size_t size, struct page ***pages)
+static void nfs_direct_release_pages(struct page **pages, int npages)
 {
-	int result = -ENOMEM;
-	unsigned long page_count;
-	size_t array_size;
-
-	page_count = (user_addr + size + PAGE_SIZE - 1) >> PAGE_SHIFT;
-	page_count -= user_addr >> PAGE_SHIFT;
-
-	array_size = (page_count * sizeof(struct page *));
-	*pages = kmalloc(array_size, GFP_KERNEL);
-	if (*pages) {
-		down_read(&current->mm->mmap_sem);
-		result = get_user_pages(current, current->mm, user_addr,
-					page_count, (rw == READ), 0,
-					*pages, NULL);
-		up_read(&current->mm->mmap_sem);
-		if (result != page_count) {
-			/*
-			 * If we got fewer pages than expected from
-			 * get_user_pages(), the user buffer runs off the
-			 * end of a mapping; return EFAULT.
-			 */
-			if (result >= 0) {
-				nfs_free_user_pages(*pages, result, 0);
-				result = -EFAULT;
-			} else
-				kfree(*pages);
-			*pages = NULL;
-		}
-	}
-	return result;
+	int i;
+	for (i = 0; i < npages; i++)
+		page_cache_release(pages[i]);
 }
 
 static inline struct nfs_direct_req *nfs_direct_req_alloc(void)
@@ -173,13 +167,13 @@ static inline struct nfs_direct_req *nfs
 		return NULL;
 
 	kref_init(&dreq->kref);
+	kref_get(&dreq->kref);
 	init_completion(&dreq->completion);
-	INIT_LIST_HEAD(&dreq->list);
 	INIT_LIST_HEAD(&dreq->rewrite_list);
 	dreq->iocb = NULL;
 	dreq->ctx = NULL;
 	spin_lock_init(&dreq->lock);
-	dreq->outstanding = 0;
+	atomic_set(&dreq->io_count, 0);
 	dreq->count = 0;
 	dreq->error = 0;
 	dreq->flags = 0;
@@ -220,18 +214,11 @@ out:
 }
 
 /*
- * We must hold a reference to all the pages in this direct read request
- * until the RPCs complete.  This could be long *after* we are woken up in
- * nfs_direct_wait (for instance, if someone hits ^C on a slow server).
- *
- * In addition, synchronous I/O uses a stack-allocated iocb.  Thus we
- * can't trust the iocb is still valid here if this is a synchronous
- * request.  If the waiter is woken prematurely, the iocb is long gone.
+ * Synchronous I/O uses a stack-allocated iocb.  Thus we can't trust
+ * the iocb is still valid here if this is a synchronous request.
  */
 static void nfs_direct_complete(struct nfs_direct_req *dreq)
 {
-	nfs_free_user_pages(dreq->pages, dreq->npages, 1);
-
 	if (dreq->iocb) {
 		long res = (long) dreq->error;
 		if (!res)
@@ -244,48 +231,10 @@ static void nfs_direct_complete(struct n
 }
 
 /*
- * Note we also set the number of requests we have in the dreq when we are
- * done.  This prevents races with I/O completion so we will always wait
- * until all requests have been dispatched and completed.
+ * We must hold a reference to all the pages in this direct read request
+ * until the RPCs complete.  This could be long *after* we are woken up in
+ * nfs_direct_wait (for instance, if someone hits ^C on a slow server).
  */
-static struct nfs_direct_req *nfs_direct_read_alloc(size_t nbytes, size_t rsize)
-{
-	struct list_head *list;
-	struct nfs_direct_req *dreq;
-	unsigned int rpages = (rsize + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
-
-	dreq = nfs_direct_req_alloc();
-	if (!dreq)
-		return NULL;
-
-	list = &dreq->list;
-	for(;;) {
-		struct nfs_read_data *data = nfs_readdata_alloc(rpages);
-
-		if (unlikely(!data)) {
-			while (!list_empty(list)) {
-				data = list_entry(list->next,
-						  struct nfs_read_data, pages);
-				list_del(&data->pages);
-				nfs_readdata_free(data);
-			}
-			kref_put(&dreq->kref, nfs_direct_req_release);
-			return NULL;
-		}
-
-		INIT_LIST_HEAD(&data->pages);
-		list_add(&data->pages, list);
-
-		data->req = (struct nfs_page *) dreq;
-		dreq->outstanding++;
-		if (nbytes <= rsize)
-			break;
-		nbytes -= rsize;
-	}
-	kref_get(&dreq->kref);
-	return dreq;
-}
-
 static void nfs_direct_read_result(struct rpc_task *task, void *calldata)
 {
 	struct nfs_read_data *data = calldata;
@@ -294,6 +243,9 @@ static void nfs_direct_read_result(struc
 	if (nfs_readpage_result(task, data) != 0)
 		return;
 
+	nfs_direct_dirty_pages(data->pagevec, data->npages);
+	nfs_direct_release_pages(data->pagevec, data->npages);
+
 	spin_lock(&dreq->lock);
 
 	if (likely(task->tk_status >= 0))
@@ -301,13 +253,10 @@ static void nfs_direct_read_result(struc
 	else
 		dreq->error = task->tk_status;
 
-	if (--dreq->outstanding) {
-		spin_unlock(&dreq->lock);
-		return;
-	}
-
 	spin_unlock(&dreq->lock);
-	nfs_direct_complete(dreq);
+
+	if (put_dreq(dreq))
+		nfs_direct_complete(dreq);
 }
 
 static const struct rpc_call_ops nfs_read_direct_ops = {
@@ -316,41 +265,60 @@ static const struct rpc_call_ops nfs_rea
 };
 
 /*
- * For each nfs_read_data struct that was allocated on the list, dispatch
- * an NFS READ operation
+ * For each rsize'd chunk of the user's buffer, dispatch an NFS READ
+ * operation.  If nfs_readdata_alloc() or get_user_pages() fails,
+ * bail and stop sending more reads.  Read length accounting is
+ * handled automatically by nfs_direct_read_result().  Otherwise, if
+ * no requests have been sent, just return an error.
  */
-static void nfs_direct_read_schedule(struct nfs_direct_req *dreq)
+static ssize_t nfs_direct_read_schedule(struct nfs_direct_req *dreq, unsigned long user_addr, size_t count, loff_t pos)
 {
 	struct nfs_open_context *ctx = dreq->ctx;
 	struct inode *inode = ctx->dentry->d_inode;
-	struct list_head *list = &dreq->list;
-	struct page **pages = dreq->pages;
-	size_t count = dreq->user_count;
-	loff_t pos = dreq->pos;
 	size_t rsize = NFS_SERVER(inode)->rsize;
-	unsigned int curpage, pgbase;
+	unsigned int rpages = nfs_max_pages(rsize);
+	unsigned int pgbase;
+	int result;
+	ssize_t started = 0;
+
+	get_dreq(dreq);
 
-	curpage = 0;
-	pgbase = dreq->user_addr & ~PAGE_MASK;
+	pgbase = user_addr & ~PAGE_MASK;
 	do {
 		struct nfs_read_data *data;
 		size_t bytes;
 
+		result = -ENOMEM;
+		data = nfs_readdata_alloc(rpages);
+		if (unlikely(!data))
+			break;
+
 		bytes = rsize;
 		if (count < rsize)
 			bytes = count;
 
-		BUG_ON(list_empty(list));
-		data = list_entry(list->next, struct nfs_read_data, pages);
-		list_del_init(&data->pages);
+		data->npages = nfs_direct_count_pages(user_addr, bytes);
+		down_read(&current->mm->mmap_sem);
+		result = get_user_pages(current, current->mm, user_addr,
+					data->npages, 1, 0, data->pagevec, NULL);
+		up_read(&current->mm->mmap_sem);
+		if (unlikely(result < data->npages)) {
+			if (result > 0)
+				nfs_direct_release_pages(data->pagevec, result);
+			nfs_readdata_release(data);
+			break;
+		}
+
+		get_dreq(dreq);
 
+		data->req = (struct nfs_page *) dreq;
 		data->inode = inode;
 		data->cred = ctx->cred;
 		data->args.fh = NFS_FH(inode);
 		data->args.context = ctx;
 		data->args.offset = pos;
 		data->args.pgbase = pgbase;
-		data->args.pages = &pages[curpage];
+		data->args.pages = data->pagevec;
 		data->args.count = bytes;
 		data->res.fattr = &data->fattr;
 		data->res.eof = 0;
@@ -373,33 +341,35 @@ static void nfs_direct_read_schedule(str
 				bytes,
 				(unsigned long long)data->args.offset);
 
+		started += bytes;
+		user_addr += bytes;
 		pos += bytes;
 		pgbase += bytes;
-		curpage += pgbase >> PAGE_SHIFT;
 		pgbase &= ~PAGE_MASK;
 
 		count -= bytes;
 	} while (count != 0);
-	BUG_ON(!list_empty(list));
+
+	if (put_dreq(dreq))
+		nfs_direct_complete(dreq);
+
+	if (started)
+		return 0;
+	return result < 0 ? (ssize_t) result : -EFAULT;
 }
 
-static ssize_t nfs_direct_read(struct kiocb *iocb, unsigned long user_addr, size_t count, loff_t pos, struct page **pages, unsigned int nr_pages)
+static ssize_t nfs_direct_read(struct kiocb *iocb, unsigned long user_addr, size_t count, loff_t pos)
 {
-	ssize_t result;
+	ssize_t result = 0;
 	sigset_t oldset;
 	struct inode *inode = iocb->ki_filp->f_mapping->host;
 	struct rpc_clnt *clnt = NFS_CLIENT(inode);
 	struct nfs_direct_req *dreq;
 
-	dreq = nfs_direct_read_alloc(count, NFS_SERVER(inode)->rsize);
+	dreq = nfs_direct_req_alloc();
 	if (!dreq)
 		return -ENOMEM;
 
-	dreq->user_addr = user_addr;
-	dreq->user_count = count;
-	dreq->pos = pos;
-	dreq->pages = pages;
-	dreq->npages = nr_pages;
 	dreq->inode = inode;
 	dreq->ctx = get_nfs_open_context((struct nfs_open_context *)iocb->ki_filp->private_data);
 	if (!is_sync_kiocb(iocb))
@@ -407,8 +377,9 @@ static ssize_t nfs_direct_read(struct ki
 
 	nfs_add_stats(inode, NFSIOS_DIRECTREADBYTES, count);
 	rpc_clnt_sigmask(clnt, &oldset);
-	nfs_direct_read_schedule(dreq);
-	result = nfs_direct_wait(dreq);
+	result = nfs_direct_read_schedule(dreq, user_addr, count, pos);
+	if (!result)
+		result = nfs_direct_wait(dreq);
 	rpc_clnt_sigunmask(clnt, &oldset);
 
 	return result;
@@ -416,10 +387,10 @@ static ssize_t nfs_direct_read(struct ki
 
 static void nfs_direct_free_writedata(struct nfs_direct_req *dreq)
 {
-	list_splice_init(&dreq->rewrite_list, &dreq->list);
-	while (!list_empty(&dreq->list)) {
-		struct nfs_write_data *data = list_entry(dreq->list.next, struct nfs_write_data, pages);
+	while (!list_empty(&dreq->rewrite_list)) {
+		struct nfs_write_data *data = list_entry(dreq->rewrite_list.next, struct nfs_write_data, pages);
 		list_del(&data->pages);
+		nfs_direct_release_pages(data->pagevec, data->npages);
 		nfs_writedata_release(data);
 	}
 }
@@ -427,14 +398,51 @@ static void nfs_direct_free_writedata(st
 #if defined(CONFIG_NFS_V3) || defined(CONFIG_NFS_V4)
 static void nfs_direct_write_reschedule(struct nfs_direct_req *dreq)
 {
-	struct list_head *pos;
+	struct inode *inode = dreq->inode;
+	struct list_head *p;
+	struct nfs_write_data *data;
 
-	list_splice_init(&dreq->rewrite_list, &dreq->list);
-	list_for_each(pos, &dreq->list)
-		dreq->outstanding++;
 	dreq->count = 0;
+	get_dreq(dreq);
+
+	list_for_each(p, &dreq->rewrite_list) {
+		data = list_entry(p, struct nfs_write_data, pages);
+
+		get_dreq(dreq);
+
+		/*
+		 * Reset data->res.
+		 */
+		nfs_fattr_init(&data->fattr);
+		data->res.count = data->args.count;
+		memset(&data->verf, 0, sizeof(data->verf));
+
+		/*
+		 * Reuse data->task; data->args should not have changed
+		 * since the original request was sent.
+		 */
+		rpc_init_task(&data->task, NFS_CLIENT(inode), RPC_TASK_ASYNC,
+				&nfs_write_direct_ops, data);
+		NFS_PROTO(inode)->write_setup(data, FLUSH_STABLE);
+
+		data->task.tk_priority = RPC_PRIORITY_NORMAL;
+		data->task.tk_cookie = (unsigned long) inode;
+
+		/*
+		 * We're called via an RPC callback, so BKL is already held.
+		 */
+		rpc_execute(&data->task);
+
+		dprintk("NFS: %5u rescheduled direct write call (req %s/%Ld, %u bytes @ offset %Lu)\n",
+				data->task.tk_pid,
+				inode->i_sb->s_id,
+				(long long)NFS_FILEID(inode),
+				data->args.count,
+				(unsigned long long)data->args.offset);
+	}
 
-	nfs_direct_write_schedule(dreq, FLUSH_STABLE);
+	if (put_dreq(dreq))
+		nfs_direct_write_complete(dreq, inode);
 }
 
 static void nfs_direct_commit_result(struct rpc_task *task, void *calldata)
@@ -471,8 +479,8 @@ static void nfs_direct_commit_schedule(s
 	data->cred = dreq->ctx->cred;
 
 	data->args.fh = NFS_FH(data->inode);
-	data->args.offset = dreq->pos;
-	data->args.count = dreq->user_count;
+	data->args.offset = 0;
+	data->args.count = 0;
 	data->res.count = 0;
 	data->res.fattr = &data->fattr;
 	data->res.verf = &data->verf;
@@ -534,47 +542,6 @@ static void nfs_direct_write_complete(st
 }
 #endif
 
-static struct nfs_direct_req *nfs_direct_write_alloc(size_t nbytes, size_t wsize)
-{
-	struct list_head *list;
-	struct nfs_direct_req *dreq;
-	unsigned int wpages = (wsize + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
-
-	dreq = nfs_direct_req_alloc();
-	if (!dreq)
-		return NULL;
-
-	list = &dreq->list;
-	for(;;) {
-		struct nfs_write_data *data = nfs_writedata_alloc(wpages);
-
-		if (unlikely(!data)) {
-			while (!list_empty(list)) {
-				data = list_entry(list->next,
-						  struct nfs_write_data, pages);
-				list_del(&data->pages);
-				nfs_writedata_free(data);
-			}
-			kref_put(&dreq->kref, nfs_direct_req_release);
-			return NULL;
-		}
-
-		INIT_LIST_HEAD(&data->pages);
-		list_add(&data->pages, list);
-
-		data->req = (struct nfs_page *) dreq;
-		dreq->outstanding++;
-		if (nbytes <= wsize)
-			break;
-		nbytes -= wsize;
-	}
-
-	nfs_alloc_commit_data(dreq);
-
-	kref_get(&dreq->kref);
-	return dreq;
-}
-
 static void nfs_direct_write_result(struct rpc_task *task, void *calldata)
 {
 	struct nfs_write_data *data = calldata;
@@ -604,8 +571,6 @@ static void nfs_direct_write_result(stru
 				}
 		}
 	}
-	/* In case we have to resend */
-	data->args.stable = NFS_FILE_SYNC;
 
 	spin_unlock(&dreq->lock);
 }
@@ -619,14 +584,8 @@ static void nfs_direct_write_release(voi
 	struct nfs_write_data *data = calldata;
 	struct nfs_direct_req *dreq = (struct nfs_direct_req *) data->req;
 
-	spin_lock(&dreq->lock);
-	if (--dreq->outstanding) {
-		spin_unlock(&dreq->lock);
-		return;
-	}
-	spin_unlock(&dreq->lock);
-
-	nfs_direct_write_complete(dreq, data->inode);
+	if (put_dreq(dreq))
+		nfs_direct_write_complete(dreq, data->inode);
 }
 
 static const struct rpc_call_ops nfs_write_direct_ops = {
@@ -635,41 +594,62 @@ static const struct rpc_call_ops nfs_wri
 };
 
 /*
- * For each nfs_write_data struct that was allocated on the list, dispatch
- * an NFS WRITE operation
+ * For each wsize'd chunk of the user's buffer, dispatch an NFS WRITE
+ * operation.  If nfs_writedata_alloc() or get_user_pages() fails,
+ * bail and stop sending more writes.  Write length accounting is
+ * handled automatically by nfs_direct_write_result().  Otherwise, if
+ * no requests have been sent, just return an error.
  */
-static void nfs_direct_write_schedule(struct nfs_direct_req *dreq, int sync)
+static ssize_t nfs_direct_write_schedule(struct nfs_direct_req *dreq, unsigned long user_addr, size_t count, loff_t pos, int sync)
 {
 	struct nfs_open_context *ctx = dreq->ctx;
 	struct inode *inode = ctx->dentry->d_inode;
-	struct list_head *list = &dreq->list;
-	struct page **pages = dreq->pages;
-	size_t count = dreq->user_count;
-	loff_t pos = dreq->pos;
 	size_t wsize = NFS_SERVER(inode)->wsize;
-	unsigned int curpage, pgbase;
+	unsigned int wpages = nfs_max_pages(wsize);
+	unsigned int pgbase;
+	int result;
+	ssize_t started = 0;
 
-	curpage = 0;
-	pgbase = dreq->user_addr & ~PAGE_MASK;
+	get_dreq(dreq);
+
+	pgbase = user_addr & ~PAGE_MASK;
 	do {
 		struct nfs_write_data *data;
 		size_t bytes;
 
+		result = -ENOMEM;
+		data = nfs_writedata_alloc(wpages);
+		if (unlikely(!data))
+			break;
+
 		bytes = wsize;
 		if (count < wsize)
 			bytes = count;
 
-		BUG_ON(list_empty(list));
-		data = list_entry(list->next, struct nfs_write_data, pages);
+		data->npages = nfs_direct_count_pages(user_addr, bytes);
+		down_read(&current->mm->mmap_sem);
+		result = get_user_pages(current, current->mm, user_addr,
+					data->npages, 0, 0, data->pagevec, NULL);
+		up_read(&current->mm->mmap_sem);
+		if (unlikely(result < data->npages)) {
+			if (result > 0)
+				nfs_direct_release_pages(data->pagevec, result);
+			nfs_writedata_release(data);
+			break;
+		}
+
+		get_dreq(dreq);
+
 		list_move_tail(&data->pages, &dreq->rewrite_list);
 
+		data->req = (struct nfs_page *) dreq;
 		data->inode = inode;
 		data->cred = ctx->cred;
 		data->args.fh = NFS_FH(inode);
 		data->args.context = ctx;
 		data->args.offset = pos;
 		data->args.pgbase = pgbase;
-		data->args.pages = &pages[curpage];
+		data->args.pages = data->pagevec;
 		data->args.count = bytes;
 		data->res.fattr = &data->fattr;
 		data->res.count = bytes;
@@ -693,19 +673,26 @@ static void nfs_direct_write_schedule(st
 				bytes,
 				(unsigned long long)data->args.offset);
 
+		started += bytes;
+		user_addr += bytes;
 		pos += bytes;
 		pgbase += bytes;
-		curpage += pgbase >> PAGE_SHIFT;
 		pgbase &= ~PAGE_MASK;
 
 		count -= bytes;
 	} while (count != 0);
-	BUG_ON(!list_empty(list));
+
+	if (put_dreq(dreq))
+		nfs_direct_write_complete(dreq, inode);
+
+	if (started)
+		return 0;
+	return result < 0 ? (ssize_t) result : -EFAULT;
 }
 
-static ssize_t nfs_direct_write(struct kiocb *iocb, unsigned long user_addr, size_t count, loff_t pos, struct page **pages, int nr_pages)
+static ssize_t nfs_direct_write(struct kiocb *iocb, unsigned long user_addr, size_t count, loff_t pos)
 {
-	ssize_t result;
+	ssize_t result = 0;
 	sigset_t oldset;
 	struct inode *inode = iocb->ki_filp->f_mapping->host;
 	struct rpc_clnt *clnt = NFS_CLIENT(inode);
@@ -713,17 +700,14 @@ static ssize_t nfs_direct_write(struct k
 	size_t wsize = NFS_SERVER(inode)->wsize;
 	int sync = 0;
 
-	dreq = nfs_direct_write_alloc(count, wsize);
+	dreq = nfs_direct_req_alloc();
 	if (!dreq)
 		return -ENOMEM;
+	nfs_alloc_commit_data(dreq);
+
 	if (dreq->commit_data == NULL || count < wsize)
 		sync = FLUSH_STABLE;
 
-	dreq->user_addr = user_addr;
-	dreq->user_count = count;
-	dreq->pos = pos;
-	dreq->pages = pages;
-	dreq->npages = nr_pages;
 	dreq->inode = inode;
 	dreq->ctx = get_nfs_open_context((struct nfs_open_context *)iocb->ki_filp->private_data);
 	if (!is_sync_kiocb(iocb))
@@ -734,8 +718,9 @@ static ssize_t nfs_direct_write(struct k
 	nfs_begin_data_update(inode);
 
 	rpc_clnt_sigmask(clnt, &oldset);
-	nfs_direct_write_schedule(dreq, sync);
-	result = nfs_direct_wait(dreq);
+	result = nfs_direct_write_schedule(dreq, user_addr, count, pos, sync);
+	if (!result)
+		result = nfs_direct_wait(dreq);
 	rpc_clnt_sigunmask(clnt, &oldset);
 
 	return result;
@@ -765,8 +750,6 @@ static ssize_t nfs_direct_write(struct k
 ssize_t nfs_file_direct_read(struct kiocb *iocb, char __user *buf, size_t count, loff_t pos)
 {
 	ssize_t retval = -EINVAL;
-	int page_count;
-	struct page **pages;
 	struct file *file = iocb->ki_filp;
 	struct address_space *mapping = file->f_mapping;
 
@@ -788,14 +771,7 @@ ssize_t nfs_file_direct_read(struct kioc
 	if (retval)
 		goto out;
 
-	retval = nfs_get_user_pages(READ, (unsigned long) buf,
-						count, &pages);
-	if (retval < 0)
-		goto out;
-	page_count = retval;
-
-	retval = nfs_direct_read(iocb, (unsigned long) buf, count, pos,
-						pages, page_count);
+	retval = nfs_direct_read(iocb, (unsigned long) buf, count, pos);
 	if (retval > 0)
 		iocb->ki_pos = pos + retval;
 
@@ -831,8 +807,6 @@ out:
 ssize_t nfs_file_direct_write(struct kiocb *iocb, const char __user *buf, size_t count, loff_t pos)
 {
 	ssize_t retval;
-	int page_count;
-	struct page **pages;
 	struct file *file = iocb->ki_filp;
 	struct address_space *mapping = file->f_mapping;
 
@@ -860,14 +834,7 @@ ssize_t nfs_file_direct_write(struct kio
 	if (retval)
 		goto out;
 
-	retval = nfs_get_user_pages(WRITE, (unsigned long) buf,
-						count, &pages);
-	if (retval < 0)
-		goto out;
-	page_count = retval;
-
-	retval = nfs_direct_write(iocb, (unsigned long) buf, count,
-					pos, pages, page_count);
+	retval = nfs_direct_write(iocb, (unsigned long) buf, count, pos);
 
 	/*
 	 * XXX: nfs_end_data_update() already ensures this file's
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index b4916b0..e6ee97f 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3144,9 +3144,6 @@ static int do_vfs_lock(struct file *file
 		default:
 			BUG();
 	}
-	if (res < 0)
-		printk(KERN_WARNING "%s: VFS is out of sync with lock manager!\n",
-				__FUNCTION__);
 	return res;
 }
 
@@ -3258,8 +3255,6 @@ static struct rpc_task *nfs4_do_unlck(st
 		return ERR_PTR(-ENOMEM);
 	}
 
-	/* Unlock _before_ we do the RPC call */
-	do_vfs_lock(fl->fl_file, fl);
 	return rpc_run_task(NFS_CLIENT(lsp->ls_state->inode), RPC_TASK_ASYNC, &nfs4_locku_ops, data);
 }
 
@@ -3270,30 +3265,28 @@ static int nfs4_proc_unlck(struct nfs4_s
 	struct rpc_task *task;
 	int status = 0;
 
-	/* Is this a delegated lock? */
-	if (test_bit(NFS_DELEGATED_STATE, &state->flags))
-		goto out_unlock;
-	/* Is this open_owner holding any locks on the server? */
-	if (test_bit(LK_STATE_IN_USE, &state->flags) == 0)
-		goto out_unlock;
-
 	status = nfs4_set_lock_state(state, request);
+	/* Unlock _before_ we do the RPC call */
+	request->fl_flags |= FL_EXISTS;
+	if (do_vfs_lock(request->fl_file, request) == -ENOENT)
+		goto out;
 	if (status != 0)
-		goto out_unlock;
+		goto out;
+	/* Is this a delegated lock? */
+	if (test_bit(NFS_DELEGATED_STATE, &state->flags))
+		goto out;
 	lsp = request->fl_u.nfs4_fl.owner;
-	status = -ENOMEM;
 	seqid = nfs_alloc_seqid(&lsp->ls_seqid);
+	status = -ENOMEM;
 	if (seqid == NULL)
-		goto out_unlock;
+		goto out;
 	task = nfs4_do_unlck(request, request->fl_file->private_data, lsp, seqid);
 	status = PTR_ERR(task);
 	if (IS_ERR(task))
-		goto out_unlock;
+		goto out;
 	status = nfs4_wait_for_completion_rpc_task(task);
 	rpc_release_task(task);
-	return status;
-out_unlock:
-	do_vfs_lock(request->fl_file, request);
+out:
 	return status;
 }
 
@@ -3461,10 +3454,10 @@ static int nfs4_lock_reclaim(struct nfs4
 	struct nfs4_exception exception = { };
 	int err;
 
-	/* Cache the lock if possible... */
-	if (test_bit(NFS_DELEGATED_STATE, &state->flags))
-		return 0;
 	do {
+		/* Cache the lock if possible... */
+		if (test_bit(NFS_DELEGATED_STATE, &state->flags) != 0)
+			return 0;
 		err = _nfs4_do_setlk(state, F_SETLK, request, 1);
 		if (err != -NFS4ERR_DELAY)
 			break;
@@ -3483,6 +3476,8 @@ static int nfs4_lock_expired(struct nfs4
 	if (err != 0)
 		return err;
 	do {
+		if (test_bit(NFS_DELEGATED_STATE, &state->flags) != 0)
+			return 0;
 		err = _nfs4_do_setlk(state, F_SETLK, request, 0);
 		if (err != -NFS4ERR_DELAY)
 			break;
@@ -3494,29 +3489,42 @@ static int nfs4_lock_expired(struct nfs4
 static int _nfs4_proc_setlk(struct nfs4_state *state, int cmd, struct file_lock *request)
 {
 	struct nfs4_client *clp = state->owner->so_client;
+	unsigned char fl_flags = request->fl_flags;
 	int status;
 
 	/* Is this a delegated open? */
-	if (NFS_I(state->inode)->delegation_state != 0) {
-		/* Yes: cache locks! */
-		status = do_vfs_lock(request->fl_file, request);
-		/* ...but avoid races with delegation recall... */
-		if (status < 0 || test_bit(NFS_DELEGATED_STATE, &state->flags))
-			return status;
-	}
-	down_read(&clp->cl_sem);
 	status = nfs4_set_lock_state(state, request);
 	if (status != 0)
 		goto out;
+	request->fl_flags |= FL_ACCESS;
+	status = do_vfs_lock(request->fl_file, request);
+	if (status < 0)
+		goto out;
+	down_read(&clp->cl_sem);
+	if (test_bit(NFS_DELEGATED_STATE, &state->flags)) {
+		struct nfs_inode *nfsi = NFS_I(state->inode);
+		/* Yes: cache locks! */
+		down_read(&nfsi->rwsem);
+		/* ...but avoid races with delegation recall... */
+		if (test_bit(NFS_DELEGATED_STATE, &state->flags)) {
+			request->fl_flags = fl_flags & ~FL_SLEEP;
+			status = do_vfs_lock(request->fl_file, request);
+			up_read(&nfsi->rwsem);
+			goto out_unlock;
+		}
+		up_read(&nfsi->rwsem);
+	}
 	status = _nfs4_do_setlk(state, cmd, request, 0);
 	if (status != 0)
-		goto out;
+		goto out_unlock;
 	/* Note: we always want to sleep here! */
-	request->fl_flags |= FL_SLEEP;
+	request->fl_flags = fl_flags | FL_SLEEP;
 	if (do_vfs_lock(request->fl_file, request) < 0)
 		printk(KERN_WARNING "%s: VFS is out of sync with lock manager!\n", __FUNCTION__);
-out:
+out_unlock:
 	up_read(&clp->cl_sem);
+out:
+	request->fl_flags = fl_flags;
 	return status;
 }
 
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index bca5734..86bac6a 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -578,7 +578,7 @@ static int nfs_wait_on_requests(struct i
 	return ret;
 }
 
-static void nfs_cancel_requests(struct list_head *head)
+static void nfs_cancel_dirty_list(struct list_head *head)
 {
 	struct nfs_page *req;
 	while(!list_empty(head)) {
@@ -589,6 +589,19 @@ static void nfs_cancel_requests(struct l
 	}
 }
 
+static void nfs_cancel_commit_list(struct list_head *head)
+{
+	struct nfs_page *req;
+
+	while(!list_empty(head)) {
+		req = nfs_list_entry(head->next);
+		nfs_list_remove_request(req);
+		nfs_inode_remove_request(req);
+		nfs_clear_page_writeback(req);
+		dec_zone_page_state(req->wb_page, NR_UNSTABLE_NFS);
+	}
+}
+
 /*
  * nfs_scan_dirty - Scan an inode for dirty requests
  * @inode: NFS inode to scan
@@ -1381,6 +1394,7 @@ nfs_commit_list(struct inode *inode, str
 		nfs_list_remove_request(req);
 		nfs_mark_request_commit(req);
 		nfs_clear_page_writeback(req);
+		dec_zone_page_state(req->wb_page, NR_UNSTABLE_NFS);
 	}
 	return -ENOMEM;
 }
@@ -1499,7 +1513,7 @@ int nfs_sync_inode_wait(struct inode *in
 		if (pages != 0) {
 			spin_unlock(&nfsi->req_lock);
 			if (how & FLUSH_INVALIDATE)
-				nfs_cancel_requests(&head);
+				nfs_cancel_dirty_list(&head);
 			else
 				ret = nfs_flush_list(inode, &head, pages, how);
 			spin_lock(&nfsi->req_lock);
@@ -1512,7 +1526,7 @@ int nfs_sync_inode_wait(struct inode *in
 			break;
 		if (how & FLUSH_INVALIDATE) {
 			spin_unlock(&nfsi->req_lock);
-			nfs_cancel_requests(&head);
+			nfs_cancel_commit_list(&head);
 			spin_lock(&nfsi->req_lock);
 			continue;
 		}
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 134b320..43aef9b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -716,6 +716,7 @@ #endif
 #define FL_POSIX	1
 #define FL_FLOCK	2
 #define FL_ACCESS	8	/* not trying to lock, just looking */
+#define FL_EXISTS	16	/* when unlocking, test for existence */
 #define FL_LEASE	32	/* lease held on this file */
 #define FL_CLOSE	64	/* unlock on close */
 #define FL_SLEEP	128	/* A blocking lock */
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 7c7320f..2d3fb64 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -729,6 +729,7 @@ struct nfs_read_data {
 	struct list_head	pages;	/* Coalesced read requests */
 	struct nfs_page		*req;	/* multi ops per nfs_page */
 	struct page		**pagevec;
+	unsigned int		npages;	/* active pages in pagevec */
 	struct nfs_readargs args;
 	struct nfs_readres  res;
 #ifdef CONFIG_NFS_V4
@@ -747,6 +748,7 @@ struct nfs_write_data {
 	struct list_head	pages;		/* Coalesced requests we wish to flush */
 	struct nfs_page		*req;		/* multi ops per nfs_page */
 	struct page		**pagevec;
+	unsigned int		npages;		/* active pages in pagevec */
 	struct nfs_writeargs	args;		/* argument struct */
 	struct nfs_writeres	res;		/* result struct */
 #ifdef CONFIG_NFS_V4
diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index 49174f0..6ac4510 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -191,7 +191,6 @@ _shift_data_right_pages(struct page **pa
 	do {
 		/* Are any pointers crossing a page boundary? */
 		if (pgto_base == 0) {
-			flush_dcache_page(*pgto);
 			pgto_base = PAGE_CACHE_SIZE;
 			pgto--;
 		}
@@ -211,11 +210,11 @@ _shift_data_right_pages(struct page **pa
 		vto = kmap_atomic(*pgto, KM_USER0);
 		vfrom = kmap_atomic(*pgfrom, KM_USER1);
 		memmove(vto + pgto_base, vfrom + pgfrom_base, copy);
+		flush_dcache_page(*pgto);
 		kunmap_atomic(vfrom, KM_USER1);
 		kunmap_atomic(vto, KM_USER0);
 
 	} while ((len -= copy) != 0);
-	flush_dcache_page(*pgto);
 }
 
 /*


