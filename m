Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264622AbSKIDRH>; Fri, 8 Nov 2002 22:17:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264624AbSKIDRH>; Fri, 8 Nov 2002 22:17:07 -0500
Received: from mons.uio.no ([129.240.130.14]:15333 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S264622AbSKIDQ4>;
	Fri, 8 Nov 2002 22:16:56 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15820.32696.463394.764808@charged.uio.no>
Date: Sat, 9 Nov 2002 04:23:36 +0100
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       NFS maillist <nfs@lists.sourceforge.net>
Subject: [PATCH] Lift the 256 outstanding NFS read/write request limit.
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Given the previous set of patches that integrate NFS with the VM +
pdflush memory control, and add mechanisms to cope with low memory
conditions, the time is now ripe to rip out the 256 outstanding
request limit, as well as the associated LRU list in the superblock,
and the nfs_flushd daemon.

The following patch offers a 30% speed increase on my test setup with
512MB of core memory (iozone using 4 threads each writing a 512MB file
over 100Mbit to a Solaris server). Setting mem=64m, I still see a 2-3%
speed increase.

Cheers,
  Trond

diff -u --recursive --new-file linux-2.5.46-06-rpcbuf/fs/nfs/Makefile linux-2.5.46-07-no_limit/fs/nfs/Makefile
--- linux-2.5.46-06-rpcbuf/fs/nfs/Makefile	2002-10-14 10:03:48.000000000 -0400
+++ linux-2.5.46-07-no_limit/fs/nfs/Makefile	2002-11-08 21:00:27.000000000 -0500
@@ -4,7 +4,7 @@
 
 obj-$(CONFIG_NFS_FS) += nfs.o
 
-nfs-y 			:= dir.o file.o flushd.o inode.o nfs2xdr.o pagelist.o \
+nfs-y 			:= dir.o file.o inode.o nfs2xdr.o pagelist.o \
 			   proc.o read.o symlink.o unlink.o write.o
 nfs-$(CONFIG_ROOT_NFS)	+= nfsroot.o mount_clnt.o      
 nfs-$(CONFIG_NFS_V3)	+= nfs3proc.o nfs3xdr.o
diff -u --recursive --new-file linux-2.5.46-06-rpcbuf/fs/nfs/flushd.c linux-2.5.46-07-no_limit/fs/nfs/flushd.c
--- linux-2.5.46-06-rpcbuf/fs/nfs/flushd.c	2002-11-05 07:52:59.000000000 -0500
+++ linux-2.5.46-07-no_limit/fs/nfs/flushd.c	1969-12-31 19:00:00.000000000 -0500
@@ -1,200 +0,0 @@
-/*
- * linux/fs/nfs/flushd.c
- *
- * For each NFS mount, there is a separate cache object that contains
- * a hash table of all clusters. With this cache, an async RPC task
- * (`flushd') is associated, which wakes up occasionally to inspect
- * its list of dirty buffers.
- * (Note that RPC tasks aren't kernel threads. Take a look at the
- * rpciod code to understand what they are).
- *
- * Inside the cache object, we also maintain a count of the current number
- * of dirty pages, which may not exceed a certain threshold.
- * (FIXME: This threshold should be configurable).
- *
- * The code is streamlined for what I think is the prevalent case for
- * NFS traffic, which is sequential write access without concurrent
- * access by different processes.
- *
- * Copyright (C) 1996, 1997, Olaf Kirch <okir@monad.swb.de>
- *
- * Rewritten 6/3/2000 by Trond Myklebust
- * Copyright (C) 1999, 2000, Trond Myklebust <trond.myklebust@fys.uio.no>
- */
-
-#include <linux/config.h>
-#include <linux/types.h>
-#include <linux/slab.h>
-#include <linux/pagemap.h>
-#include <linux/file.h>
-
-#include <linux/time.h>
-
-#include <linux/sunrpc/auth.h>
-#include <linux/sunrpc/clnt.h>
-#include <linux/sunrpc/sched.h>
-
-#include <linux/smp_lock.h>
-
-#include <linux/nfs.h>
-#include <linux/nfs_fs.h>
-#include <linux/nfs_page.h>
-#include <linux/nfs_fs_sb.h>
-#include <linux/nfs_flushd.h>
-
-/*
- * Various constants
- */
-#define NFSDBG_FACILITY         NFSDBG_PAGECACHE
-
-/*
- * This is the wait queue all cluster daemons sleep on
- */
-static RPC_WAITQ(flushd_queue, "nfs_flushd");
-
-/*
- * Local function declarations.
- */
-static void	nfs_flushd(struct rpc_task *);
-static void	nfs_flushd_exit(struct rpc_task *);
-
-
-int nfs_reqlist_init(struct nfs_server *server)
-{
-	struct nfs_reqlist	*cache;
-	struct rpc_task		*task;
-	int			status;
-
-	dprintk("NFS: writecache_init\n");
-
-	lock_kernel();
-	status = -ENOMEM;
-	/* Create the RPC task */
-	if (!(task = rpc_new_task(server->client, NULL, RPC_TASK_ASYNC)))
-		goto out_unlock;
-
-	cache = server->rw_requests;
-
-	status = 0;
-	if (cache->task)
-		goto out_unlock;
-
-	task->tk_calldata = server;
-
-	cache->task = task;
-
-	/* Run the task */
-	cache->runat = jiffies;
-
-	cache->auth = server->client->cl_auth;
-	task->tk_action   = nfs_flushd;
-	task->tk_exit   = nfs_flushd_exit;
-
-	rpc_execute(task);
-	unlock_kernel();
-	return 0;
- out_unlock:
-	if (task)
-		rpc_release_task(task);
-	unlock_kernel();
-	return status;
-}
-
-void nfs_reqlist_exit(struct nfs_server *server)
-{
-	struct nfs_reqlist      *cache;
-
-	lock_kernel();
-	cache = server->rw_requests;
-	if (!cache)
-		goto out;
-
-	dprintk("NFS: reqlist_exit (ptr %p rpc %p)\n", cache, cache->task);
-
-	while (cache->task) {
-		rpc_exit(cache->task, 0);
-		rpc_wake_up_task(cache->task);
-
-		interruptible_sleep_on_timeout(&cache->request_wait, 1 * HZ);
-	}
- out:
-	unlock_kernel();
-}
-
-int nfs_reqlist_alloc(struct nfs_server *server)
-{
-	struct nfs_reqlist	*cache;
-	if (server->rw_requests)
-		return 0;
-
-	cache = (struct nfs_reqlist *)kmalloc(sizeof(*cache), GFP_KERNEL);
-	if (!cache)
-		return -ENOMEM;
-
-	memset(cache, 0, sizeof(*cache));
-	atomic_set(&cache->nr_requests, 0);
-	init_waitqueue_head(&cache->request_wait);
-	server->rw_requests = cache;
-
-	return 0;
-}
-
-void nfs_reqlist_free(struct nfs_server *server)
-{
-	if (server->rw_requests) {
-		kfree(server->rw_requests);
-		server->rw_requests = NULL;
-	}
-}
-
-#define NFS_FLUSHD_TIMEOUT	(30*HZ)
-static void
-nfs_flushd(struct rpc_task *task)
-{
-	struct nfs_server	*server;
-	struct nfs_reqlist	*cache;
-	LIST_HEAD(head);
-
-        dprintk("NFS: %4d flushd starting\n", task->tk_pid);
-	server = (struct nfs_server *) task->tk_calldata;
-        cache = server->rw_requests;
-
-	for(;;) {
-		spin_lock(&nfs_wreq_lock);
-		if (nfs_scan_lru_dirty_timeout(server, &head)) {
-			spin_unlock(&nfs_wreq_lock);
-			nfs_flush_list(&head, server->wpages, FLUSH_AGING);
-			continue;
-		}
-#if defined(CONFIG_NFS_V3) || defined(CONFIG_NFS_V4)
-		if (nfs_scan_lru_commit_timeout(server, &head)) {
-			spin_unlock(&nfs_wreq_lock);
-			nfs_commit_list(&head, FLUSH_AGING);
-			continue;
-		}
-#endif
-		spin_unlock(&nfs_wreq_lock);
-		break;
-	}
-
-	dprintk("NFS: %4d flushd back to sleep\n", task->tk_pid);
-	if (task->tk_action) {
-		task->tk_timeout = NFS_FLUSHD_TIMEOUT;
-		cache->runat = jiffies + task->tk_timeout;
-		rpc_sleep_on(&flushd_queue, task, NULL, NULL);
-	}
-}
-
-static void
-nfs_flushd_exit(struct rpc_task *task)
-{
-	struct nfs_server	*server;
-	struct nfs_reqlist	*cache;
-	server = (struct nfs_server *) task->tk_calldata;
-	cache = server->rw_requests;
-
-	if (cache->task == task)
-		cache->task = NULL;
-	wake_up(&cache->request_wait);
-}
-
diff -u --recursive --new-file linux-2.5.46-06-rpcbuf/fs/nfs/inode.c linux-2.5.46-07-no_limit/fs/nfs/inode.c
--- linux-2.5.46-06-rpcbuf/fs/nfs/inode.c	2002-11-08 14:21:21.000000000 -0500
+++ linux-2.5.46-07-no_limit/fs/nfs/inode.c	2002-11-08 21:00:27.000000000 -0500
@@ -29,7 +29,6 @@
 #include <linux/nfs_fs.h>
 #include <linux/nfs_mount.h>
 #include <linux/nfs4_mount.h>
-#include <linux/nfs_flushd.h>
 #include <linux/lockd/bind.h>
 #include <linux/smp_lock.h>
 #include <linux/seq_file.h>
@@ -147,18 +146,9 @@
 	struct nfs_server *server = NFS_SB(sb);
 	struct rpc_clnt	*rpc;
 
-	/*
-	 * First get rid of the request flushing daemon.
-	 * Relies on rpc_shutdown_client() waiting on all
-	 * client tasks to finish.
-	 */
-	nfs_reqlist_exit(server);
-
 	if ((rpc = server->client) != NULL)
 		rpc_shutdown_client(rpc);
 
-	nfs_reqlist_free(server);
-
 	if (!(server->flags & NFS_MOUNT_NONLM))
 		lockd_down();	/* release rpc.lockd */
 	rpciod_down();		/* release rpciod */
@@ -262,10 +252,6 @@
 
 	sb->s_magic      = NFS_SUPER_MAGIC;
 	sb->s_op         = &nfs_sops;
-	INIT_LIST_HEAD(&server->lru_read);
-	INIT_LIST_HEAD(&server->lru_dirty);
-	INIT_LIST_HEAD(&server->lru_commit);
-	INIT_LIST_HEAD(&server->lru_busy);
 
 	/* Did getting the root inode fail? */
 	root_inode = nfs_get_root(sb, &server->fh);
@@ -333,22 +319,13 @@
 	if (sb->s_maxbytes > MAX_LFS_FILESIZE) 
 		sb->s_maxbytes = MAX_LFS_FILESIZE; 
 
-	/* Fire up the writeback cache */
-	if (nfs_reqlist_alloc(server) < 0) {
-		printk(KERN_NOTICE "NFS: cannot initialize writeback cache.\n");
-		goto failure_kill_reqlist;
-	}
-
 	/* We're airborne Set socket buffersize */
 	rpc_setbufsize(server->client, server->wsize + 100, server->rsize + 100);
 	return 0;
 	/* Yargs. It didn't work out. */
-failure_kill_reqlist:
-	nfs_reqlist_exit(server);
 out_free_all:
 	if (root_inode)
 		iput(root_inode);
-	nfs_reqlist_free(server);
 	return -EINVAL;
 out_no_root:
 	printk("nfs_read_super: get root inode failed\n");
diff -u --recursive --new-file linux-2.5.46-06-rpcbuf/fs/nfs/pagelist.c linux-2.5.46-07-no_limit/fs/nfs/pagelist.c
--- linux-2.5.46-06-rpcbuf/fs/nfs/pagelist.c	2002-11-08 14:22:53.000000000 -0500
+++ linux-2.5.46-07-no_limit/fs/nfs/pagelist.c	2002-11-08 21:03:10.000000000 -0500
@@ -17,7 +17,6 @@
 #include <linux/nfs4.h>
 #include <linux/nfs_page.h>
 #include <linux/nfs_fs.h>
-#include <linux/nfs_flushd.h>
 #include <linux/nfs_mount.h>
 
 #define NFS_PARANOIA 1
@@ -37,7 +36,6 @@
 	if (p) {
 		memset(p, 0, sizeof(*p));
 		INIT_LIST_HEAD(&p->wb_list);
-		INIT_LIST_HEAD(&p->wb_lru);
 		init_waitqueue_head(&p->wb_wait);
 	}
 	return p;
@@ -49,8 +47,6 @@
 	kmem_cache_free(nfs_page_cachep, p);
 }
 
-static int nfs_try_to_free_pages(struct nfs_server *);
-
 /**
  * nfs_create_request - Create an NFS read/write request.
  * @cred: RPC credential to use
@@ -71,29 +67,18 @@
 		   unsigned int offset, unsigned int count)
 {
 	struct nfs_server *server = NFS_SERVER(inode);
-	struct nfs_reqlist	*cache = NFS_REQUESTLIST(inode);
 	struct nfs_page		*req;
 
 	/* Deal with hard limits.  */
 	for (;;) {
-		/* Prevent races by incrementing *before* we test */
-		atomic_inc(&cache->nr_requests);
-
-		/* If we haven't reached the local hard limit yet,
-		 * try to allocate the request struct */
-		if (atomic_read(&cache->nr_requests) <= MAX_REQUEST_HARD) {
-			req = nfs_page_alloc();
-			if (req != NULL)
-				break;
-		}
-
-		atomic_dec(&cache->nr_requests);
+		/* try to allocate the request struct */
+		req = nfs_page_alloc();
+		if (req != NULL)
+			break;
 
 		/* Try to free up at least one request in order to stay
 		 * below the hard limit
 		 */
-		if (nfs_try_to_free_pages(server))
-			continue;
 		if (signalled() && (server->flags & NFS_MOUNT_INTR))
 			return ERR_PTR(-ERESTARTSYS);
 		yield();
@@ -137,7 +122,6 @@
 	if (req->wb_page) {
 		page_cache_release(req->wb_page);
 		req->wb_page = NULL;
-		atomic_dec(&NFS_REQUESTLIST(req->wb_inode)->nr_requests);
 	}
 }
 
@@ -156,13 +140,11 @@
 		spin_unlock(&nfs_wreq_lock);
 		return;
 	}
-	__nfs_del_lru(req);
 	spin_unlock(&nfs_wreq_lock);
 
 #ifdef NFS_PARANOIA
 	BUG_ON (!list_empty(&req->wb_list));
 	BUG_ON (NFS_WBACK_BUSY(req));
-	BUG_ON (atomic_read(&NFS_REQUESTLIST(req->wb_inode)->nr_requests) < 0);
 #endif
 
 	/* Release struct file or cached credential */
@@ -310,104 +292,6 @@
 	return npages;
 }
 
-/*
- * nfs_scan_forward - Coalesce more requests
- * @req: First request to add
- * @dst: destination list
- * @nmax: maximum number of requests to coalesce
- *
- * Tries to coalesce more requests by traversing the request's wb_list.
- * Moves the resulting list into dst. Requests are guaranteed to be
- * contiguous, and have the same RPC credentials.
- */
-static int
-nfs_scan_forward(struct nfs_page *req, struct list_head *dst, int nmax)
-{
-	struct nfs_server *server = NFS_SERVER(req->wb_inode);
-	struct list_head *pos, *head = req->wb_list_head;
-	struct rpc_cred *cred = req->wb_cred;
-	unsigned long idx = req->wb_index + 1;
-	int npages = 0;
-
-	for (pos = req->wb_list.next; nfs_lock_request(req); pos = pos->next) {
-		nfs_list_remove_request(req);
-		nfs_list_add_request(req, dst);
-		__nfs_del_lru(req);
-		__nfs_add_lru(&server->lru_busy, req);
-		npages++;
-		if (npages == nmax)
-			break;
-		if (pos == head)
-			break;
-		if (req->wb_offset + req->wb_bytes != PAGE_CACHE_SIZE)
-			break;
-		req = nfs_list_entry(pos);
-		if (req->wb_index != idx++)
-			break;
-		if (req->wb_offset != 0)
-			break;
-		if (req->wb_cred != cred)
-			break;
-	}
-	return npages;
-}
-
-/**
- * nfs_scan_lru - Scan one of the least recently used list
- * @head: One of the NFS superblock lru lists
- * @dst: Destination list
- * @nmax: maximum number of requests to coalesce
- *
- * Scans one of the NFS superblock lru lists for upto nmax requests
- * and returns them on a list. The requests are all guaranteed to be
- * contiguous, originating from the same inode and the same file.
- */
-int
-nfs_scan_lru(struct list_head *head, struct list_head *dst, int nmax)
-{
-	struct list_head *pos;
-	struct nfs_page *req;
-	int npages = 0;
-
-	list_for_each(pos, head) {
-		req = nfs_lru_entry(pos);
-		npages = nfs_scan_forward(req, dst, nmax);
-		if (npages)
-			break;
-	}
-	return npages;
-}
-
-/**
- * nfs_scan_lru_timeout - Scan one of the superblock lru lists for timed out requests
- * @head: One of the NFS superblock lru lists
- * @dst: Destination list
- * @nmax: maximum number of requests to coalesce
- *
- * Scans one of the NFS superblock lru lists for upto nmax requests
- * and returns them on a list. The requests are all guaranteed to be
- * contiguous, originating from the same inode and the same file.
- * The first request on the destination list will be timed out, the
- * others are not guaranteed to be so.
- */
-int
-nfs_scan_lru_timeout(struct list_head *head, struct list_head *dst, int nmax)
-{
-	struct list_head *pos;
-	struct nfs_page *req;
-	int npages = 0;
-
-	list_for_each(pos, head) {
-		req = nfs_lru_entry(pos);
-		if (time_after(req->wb_timeout, jiffies))
-			break;
-		npages = nfs_scan_forward(req, dst, nmax);
-		if (npages)
-			break;
-	}
-	return npages;
-}
-
 /**
  * nfs_scan_list - Scan a list for matching requests
  * @head: One of the NFS inode request lists
@@ -454,76 +338,11 @@
 			continue;
 		nfs_list_remove_request(req);
 		nfs_list_add_request(req, dst);
-		__nfs_del_lru(req);
-		__nfs_add_lru(&NFS_SERVER(req->wb_inode)->lru_busy, req);
 		res++;
 	}
 	return res;
 }
 
-/*
- * nfs_try_to_free_pages - Free up NFS read/write requests
- * @server: The NFS superblock
- *
- * This function attempts to flush out NFS reads and writes in order
- * to keep the hard limit on the total number of pending requests
- * on a given NFS partition.
- * Note: we first try to commit unstable writes, then flush out pending
- *       reads, then finally the dirty pages.
- *       The assumption is that this reflects the ordering from the fastest
- *       to the slowest method for reclaiming requests.
- */
-static int
-nfs_try_to_free_pages(struct nfs_server *server)
-{
-	LIST_HEAD(head);
-	struct nfs_page *req = NULL;
-	int nreq;
-
-	for (;;) {
-		if (req) {
-			int status = nfs_wait_on_request(req);
-			nfs_release_request(req);
-			if (status)
-				break;
-			req = NULL;
-		}
-		nreq = atomic_read(&server->rw_requests->nr_requests);
-		if (nreq < MAX_REQUEST_HARD)
-			return 1;
-		spin_lock(&nfs_wreq_lock);
-		/* Are there any busy RPC calls that might free up requests? */
-		if (!list_empty(&server->lru_busy)) {
-			req = nfs_lru_entry(server->lru_busy.next);
-			req->wb_count++;
-			__nfs_del_lru(req);
-			spin_unlock(&nfs_wreq_lock);
-			continue;
-		}
-
-#if defined(CONFIG_NFS_V3) || defined(CONFIG_NFS_V4)
-		/* Let's try to free up some completed NFSv3 unstable writes */
-		nfs_scan_lru_commit(server, &head);
-		if (!list_empty(&head)) {
-			spin_unlock(&nfs_wreq_lock);
-			nfs_commit_list(&head, 0);
-			continue;
-		}
-#endif
-		/* Last resort: we try to flush out single requests */
-		nfs_scan_lru_dirty(server, &head);
-		if (!list_empty(&head)) {
-			spin_unlock(&nfs_wreq_lock);
-			nfs_flush_list(&head, server->wpages, FLUSH_STABLE);
-			continue;
-		}
-		spin_unlock(&nfs_wreq_lock);
-		break;
-	}
-	/* We failed to free up requests */
-	return 0;
-}
-
 int nfs_init_nfspagecache(void)
 {
 	nfs_page_cachep = kmem_cache_create("nfs_page",
diff -u --recursive --new-file linux-2.5.46-06-rpcbuf/fs/nfs/read.c linux-2.5.46-07-no_limit/fs/nfs/read.c
--- linux-2.5.46-06-rpcbuf/fs/nfs/read.c	2002-11-08 15:40:48.000000000 -0500
+++ linux-2.5.46-07-no_limit/fs/nfs/read.c	2002-11-08 21:00:27.000000000 -0500
@@ -28,7 +28,6 @@
 #include <linux/sunrpc/clnt.h>
 #include <linux/nfs_fs.h>
 #include <linux/nfs_page.h>
-#include <linux/nfs_flushd.h>
 #include <linux/smp_lock.h>
 
 #include <asm/system.h>
diff -u --recursive --new-file linux-2.5.46-06-rpcbuf/fs/nfs/write.c linux-2.5.46-07-no_limit/fs/nfs/write.c
--- linux-2.5.46-06-rpcbuf/fs/nfs/write.c	2002-11-08 15:40:48.000000000 -0500
+++ linux-2.5.46-07-no_limit/fs/nfs/write.c	2002-11-08 21:04:05.000000000 -0500
@@ -58,7 +58,6 @@
 #include <linux/sunrpc/clnt.h>
 #include <linux/nfs_fs.h>
 #include <linux/nfs_mount.h>
-#include <linux/nfs_flushd.h>
 #include <linux/nfs_page.h>
 #include <asm/uaccess.h>
 #include <linux/smp_lock.h>
@@ -280,33 +279,6 @@
 	return err; 
 }
 
-/*
- * Check whether the file range we want to write to is locked by
- * us.
- */
-static int
-region_locked(struct inode *inode, struct nfs_page *req)
-{
-	struct file_lock	*fl;
-	loff_t			rqstart, rqend;
-
-	/* Don't optimize writes if we don't use NLM */
-	if (NFS_SERVER(inode)->flags & NFS_MOUNT_NONLM)
-		return 0;
-
-	rqstart = req_offset(req) + req->wb_offset;
-	rqend = rqstart + req->wb_bytes;
-	for (fl = inode->i_flock; fl; fl = fl->fl_next) {
-		if (fl->fl_owner == current->files && (fl->fl_flags & FL_POSIX)
-		    && fl->fl_type == F_WRLCK
-		    && fl->fl_start <= rqstart && rqend <= fl->fl_end) {
-			return 1;
-		}
-	}
-
-	return 0;
-}
-
 int
 nfs_writepages(struct address_space *mapping, struct writeback_control *wbc)
 {
@@ -408,8 +380,6 @@
 	spin_lock(&nfs_wreq_lock);
 	nfs_list_add_request(req, &nfsi->dirty);
 	nfsi->ndirty++;
-	__nfs_del_lru(req);
-	__nfs_add_lru(&NFS_SERVER(inode)->lru_dirty, req);
 	spin_unlock(&nfs_wreq_lock);
 	mark_inode_dirty(inode);
 }
@@ -437,8 +407,6 @@
 	spin_lock(&nfs_wreq_lock);
 	nfs_list_add_request(req, &nfsi->commit);
 	nfsi->ncommit++;
-	__nfs_del_lru(req);
-	__nfs_add_lru(&NFS_SERVER(inode)->lru_commit, req);
 	spin_unlock(&nfs_wreq_lock);
 	mark_inode_dirty(inode);
 }
@@ -489,52 +457,6 @@
 	return res;
 }
 
-/**
- * nfs_scan_lru_dirty_timeout - Scan LRU list for timed out dirty requests
- * @server: NFS superblock data
- * @dst: destination list
- *
- * Moves a maximum of 'wpages' requests from the NFS dirty page LRU list.
- * The elements are checked to ensure that they form a contiguous set
- * of pages, and that they originated from the same file.
- */
-int
-nfs_scan_lru_dirty_timeout(struct nfs_server *server, struct list_head *dst)
-{
-	struct nfs_inode *nfsi;
-	int npages;
-
-	npages = nfs_scan_lru_timeout(&server->lru_dirty, dst, server->wpages);
-	if (npages) {
-		nfsi = NFS_I(nfs_list_entry(dst->next)->wb_inode);
-		nfsi->ndirty -= npages;
-	}
-	return npages;
-}
-
-/**
- * nfs_scan_lru_dirty - Scan LRU list for dirty requests
- * @server: NFS superblock data
- * @dst: destination list
- *
- * Moves a maximum of 'wpages' requests from the NFS dirty page LRU list.
- * The elements are checked to ensure that they form a contiguous set
- * of pages, and that they originated from the same file.
- */
-int
-nfs_scan_lru_dirty(struct nfs_server *server, struct list_head *dst)
-{
-	struct nfs_inode *nfsi;
-	int npages;
-
-	npages = nfs_scan_lru(&server->lru_dirty, dst, server->wpages);
-	if (npages) {
-		nfsi = NFS_I(nfs_list_entry(dst->next)->wb_inode);
-		nfsi->ndirty -= npages;
-	}
-	return npages;
-}
-
 /*
  * nfs_scan_dirty - Scan an inode for dirty requests
  * @inode: NFS inode to scan
@@ -559,59 +481,6 @@
 }
 
 #if defined(CONFIG_NFS_V3) || defined(CONFIG_NFS_V4)
-/**
- * nfs_scan_lru_commit_timeout - Scan LRU list for timed out commit requests
- * @server: NFS superblock data
- * @dst: destination list
- *
- * Finds the first a timed out request in the NFS commit LRU list and moves it
- * to the list dst. If such an element is found, we move all other commit
- * requests that apply to the same inode.
- * The assumption is that doing everything in a single commit-to-disk is
- * the cheaper alternative.
- */
-int
-nfs_scan_lru_commit_timeout(struct nfs_server *server, struct list_head *dst)
-{
-	struct nfs_inode *nfsi;
-	int npages;
-
-	npages = nfs_scan_lru_timeout(&server->lru_commit, dst, 1);
-	if (npages) {
-		nfsi = NFS_I(nfs_list_entry(dst->next)->wb_inode);
-		npages += nfs_scan_list(&nfsi->commit, dst, NULL, 0, 0);
-		nfsi->ncommit -= npages;
-	}
-	return npages;
-}
-
-
-/**
- * nfs_scan_lru_commit_timeout - Scan LRU list for timed out commit requests
- * @server: NFS superblock data
- * @dst: destination list
- *
- * Finds the first request in the NFS commit LRU list and moves it
- * to the list dst. If such an element is found, we move all other commit
- * requests that apply to the same inode.
- * The assumption is that doing everything in a single commit-to-disk is
- * the cheaper alternative.
- */
-int
-nfs_scan_lru_commit(struct nfs_server *server, struct list_head *dst)
-{
-	struct nfs_inode *nfsi;
-	int npages;
-
-	npages = nfs_scan_lru(&server->lru_commit, dst, 1);
-	if (npages) {
-		nfsi = NFS_I(nfs_list_entry(dst->next)->wb_inode);
-		npages += nfs_scan_list(&nfsi->commit, dst, NULL, 0, 0);
-		nfsi->ncommit -= npages;
-	}
-	return npages;
-}
-
 /*
  * nfs_scan_commit - Scan an inode for commit requests
  * @inode: NFS inode to scan
@@ -697,11 +566,6 @@
 			new->wb_file = file;
 			get_file(file);
 		}
-		/* If the region is locked, adjust the timeout */
-		if (region_locked(inode, new))
-			new->wb_timeout = jiffies + NFS_WRITEBACK_LOCKDELAY;
-		else
-			new->wb_timeout = jiffies + NFS_WRITEBACK_DELAY;
 	}
 
 	/* We have a request for our page.
@@ -1059,7 +923,6 @@
 			goto next;
 		}
 		memcpy(&req->wb_verf, &data->verf, sizeof(req->wb_verf));
-		req->wb_timeout = jiffies + NFS_COMMIT_DELAY;
 		nfs_mark_request_commit(req);
 		dprintk(" marked for commit\n");
 #else
diff -u --recursive --new-file linux-2.5.46-06-rpcbuf/include/linux/nfs_flushd.h linux-2.5.46-07-no_limit/include/linux/nfs_flushd.h
--- linux-2.5.46-06-rpcbuf/include/linux/nfs_flushd.h	2002-02-05 02:55:11.000000000 -0500
+++ linux-2.5.46-07-no_limit/include/linux/nfs_flushd.h	1969-12-31 19:00:00.000000000 -0500
@@ -1,61 +0,0 @@
-#ifndef NFS_CLUSTER_H
-#define NFS_CLUSTER_H
-
-
-
-#ifdef __KERNEL__
-#include <asm/atomic.h>
-#include <linux/nfs_fs_sb.h>
-
-/*
- * Counters of total number and pending number of requests.
- * When the total number of requests exceeds the hard limit, we stall
- * until it drops again.
- */
-#define MAX_REQUEST_HARD        256
-
-/*
- * Maximum number of requests per write cluster.
- * 32 requests per cluster account for 128K of data on an intel box.
- * Note: it's a good idea to make this number smaller than MAX_REQUEST_SOFT.
- *
- * For 100Mbps Ethernet, 128 pages (i.e. 256K) per cluster gives much
- * better performance.
- */
-#define REQUEST_HASH_SIZE	16
-#define REQUEST_NR(off)		((off) >> PAGE_CACHE_SHIFT)
-#define REQUEST_HASH(ino, off)	(((ino) ^ REQUEST_NR(off)) & (REQUEST_HASH_SIZE - 1))
-
-
-/*
- * Functions
- */
-extern int		nfs_reqlist_alloc(struct nfs_server *);
-extern void		nfs_reqlist_free(struct nfs_server *);
-extern int		nfs_reqlist_init(struct nfs_server *);
-extern void		nfs_reqlist_exit(struct nfs_server *);
-extern void		nfs_wake_flushd(void);
-
-/*
- * This is the per-mount writeback cache.
- */
-struct nfs_reqlist {
-	atomic_t		nr_requests;
-	unsigned long		runat;
-	wait_queue_head_t	request_wait;
-
-	/* The async RPC task that is responsible for scanning the
-	 * requests.
-	 */
-	struct rpc_task		*task;		/* request flush task */
-
-	/* Authentication flavor handle for this NFS client */
-	struct rpc_auth		*auth;
-
-	/* The list of all inodes with pending writebacks.  */
-	struct inode		*inodes;
-};
-
-#endif
-
-#endif
diff -u --recursive --new-file linux-2.5.46-06-rpcbuf/include/linux/nfs_fs.h linux-2.5.46-07-no_limit/include/linux/nfs_fs.h
--- linux-2.5.46-06-rpcbuf/include/linux/nfs_fs.h	2002-11-08 15:42:57.000000000 -0500
+++ linux-2.5.46-07-no_limit/include/linux/nfs_fs.h	2002-11-08 21:01:45.000000000 -0500
@@ -53,10 +53,6 @@
  * The upper limit on timeouts for the exponential backoff algorithm.
  */
 #define NFS_MAX_RPC_TIMEOUT		(6*HZ)
-#define NFS_READ_DELAY			(2*HZ)
-#define NFS_WRITEBACK_DELAY		(5*HZ)
-#define NFS_WRITEBACK_LOCKDELAY		(60*HZ)
-#define NFS_COMMIT_DELAY		(5*HZ)
 
 /*
  * Size of the lookup cache in units of number of entries cached.
@@ -198,7 +194,6 @@
 #define NFS_SERVER(inode)		(NFS_SB(inode->i_sb))
 #define NFS_CLIENT(inode)		(NFS_SERVER(inode)->client)
 #define NFS_PROTO(inode)		(NFS_SERVER(inode)->rpc_ops)
-#define NFS_REQUESTLIST(inode)		(NFS_SERVER(inode)->rw_requests)
 #define NFS_ADDR(inode)			(RPC_PEERADDR(NFS_CLIENT(inode)))
 #define NFS_CONGESTED(inode)		(RPC_CONGESTED(NFS_CLIENT(inode)))
 #define NFS_COOKIEVERF(inode)		(NFS_I(inode)->cookieverf)
@@ -338,13 +333,9 @@
 extern int  nfs_sync_file(struct inode *, struct file *, unsigned long, unsigned int, int);
 extern int  nfs_flush_file(struct inode *, struct file *, unsigned long, unsigned int, int);
 extern int  nfs_flush_list(struct list_head *, int, int);
-extern int  nfs_scan_lru_dirty(struct nfs_server *, struct list_head *);
-extern int  nfs_scan_lru_dirty_timeout(struct nfs_server *, struct list_head *);
 #if defined(CONFIG_NFS_V3) || defined(CONFIG_NFS_V4)
 extern int  nfs_commit_file(struct inode *, struct file *, unsigned long, unsigned int, int);
 extern int  nfs_commit_list(struct list_head *, int);
-extern int  nfs_scan_lru_commit(struct nfs_server *, struct list_head *);
-extern int  nfs_scan_lru_commit_timeout(struct nfs_server *, struct list_head *);
 #else
 static inline int
 nfs_commit_file(struct inode *inode, struct file *file, unsigned long offset,
diff -u --recursive --new-file linux-2.5.46-06-rpcbuf/include/linux/nfs_fs_sb.h linux-2.5.46-07-no_limit/include/linux/nfs_fs_sb.h
--- linux-2.5.46-06-rpcbuf/include/linux/nfs_fs_sb.h	2002-11-08 14:16:27.000000000 -0500
+++ linux-2.5.46-07-no_limit/include/linux/nfs_fs_sb.h	2002-11-08 21:00:27.000000000 -0500
@@ -25,11 +25,6 @@
 	unsigned int		acdirmax;
 	unsigned int		namelen;
 	char *			hostname;	/* remote hostname */
-	struct nfs_reqlist *	rw_requests;	/* async read/write requests */
-	struct list_head	lru_read,
-				lru_dirty,
-				lru_commit,
-				lru_busy;
 	struct nfs_fh		fh;
 	struct sockaddr_in	addr;
 #if CONFIG_NFS_V4
diff -u --recursive --new-file linux-2.5.46-06-rpcbuf/include/linux/nfs_page.h linux-2.5.46-07-no_limit/include/linux/nfs_page.h
--- linux-2.5.46-06-rpcbuf/include/linux/nfs_page.h	2002-11-08 15:42:55.000000000 -0500
+++ linux-2.5.46-07-no_limit/include/linux/nfs_page.h	2002-11-08 21:02:26.000000000 -0500
@@ -23,15 +23,13 @@
 #define PG_BUSY			0
 
 struct nfs_page {
-	struct list_head	wb_lru,		/* superblock lru list */
-				wb_list,	/* Defines state of page: */
+	struct list_head	wb_list,	/* Defines state of page: */
 				*wb_list_head;	/*      read/write/commit */
 	struct file		*wb_file;
 	struct inode		*wb_inode;
 	struct rpc_cred		*wb_cred;
 	struct page		*wb_page;	/* page to read in/write out */
 	wait_queue_head_t	wb_wait;	/* wait queue */
-	unsigned long		wb_timeout;	/* when to read/write/commit */
 	unsigned long		wb_index;	/* Offset within mapping */
 	unsigned int		wb_offset,	/* Offset within page */
 				wb_bytes,	/* Length of request */
@@ -52,8 +50,6 @@
 
 extern	void nfs_list_add_request(struct nfs_page *, struct list_head *);
 
-extern	int nfs_scan_lru(struct list_head *, struct list_head *, int);
-extern	int nfs_scan_lru_timeout(struct list_head *, struct list_head *, int);
 extern	int nfs_scan_list(struct list_head *, struct list_head *,
 			  struct file *, unsigned long, unsigned int);
 extern	int nfs_coalesce_requests(struct list_head *, struct list_head *,
@@ -124,24 +120,4 @@
 	return list_entry(head, struct nfs_page, wb_list);
 }
 
-static inline void
-__nfs_add_lru(struct list_head *head, struct nfs_page *req)
-{
-	list_add_tail(&req->wb_lru, head);
-}
-
-static inline void
-__nfs_del_lru(struct nfs_page *req)
-{
-	if (list_empty(&req->wb_lru))
-		return;
-	list_del_init(&req->wb_lru);
-}
-
-static inline struct nfs_page *
-nfs_lru_entry(struct list_head *head)
-{
-        return list_entry(head, struct nfs_page, wb_lru);
-}
-
 #endif /* _LINUX_NFS_PAGE_H */
