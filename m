Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290974AbSBLLwh>; Tue, 12 Feb 2002 06:52:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290983AbSBLLwb>; Tue, 12 Feb 2002 06:52:31 -0500
Received: from pat.uio.no ([129.240.130.16]:12029 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S290974AbSBLLwK>;
	Tue, 12 Feb 2002 06:52:10 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15465.476.953349.720240@charged.uio.no>
Date: Tue, 12 Feb 2002 12:51:56 +0100
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Remove BKL from NFS read/write code + SunRPC...
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 The following patch strongly reduces BKL contention within the NFS
read/write code, and within the generic RPC layer. Features:

  - BKL is added explicitly where needed for list protection in the
    NLM locking code.

  - BKL added where still needed to protect the NFS_FLAGS(inode) (this
    will of course be fixed in a later patch).

  - Replace BKL with spinlock "nfs_flushd_lock" for protecting the
    read/write asynchronous flush daemon.

  - Replace BKL with spinlock "nfs_inode_lock" for protecting the
    inode attribute updates.

This also allows us to drop the BKL from the SunRPC code. For the
latter, all the internals should already be SMP safe. The global BKL
was only being maintained in order to ensure that the user callbacks
don't race with one another (and because I was nervous of removing it
in a stable series ;-).

Cheers,
  Trond

diff -u --recursive --new-file linux-2.5.4/fs/lockd/clntproc.c linux-2.5.4-rpc_bkl/fs/lockd/clntproc.c
--- linux-2.5.4/fs/lockd/clntproc.c	Mon Feb 11 02:50:08 2002
+++ linux-2.5.4-rpc_bkl/fs/lockd/clntproc.c	Tue Feb 12 09:32:18 2002
@@ -569,11 +569,15 @@
 		printk(KERN_WARNING "lockd: unexpected unlock status: %d\n", status);
 
 die:
+	lock_kernel();
 	nlm_release_host(req->a_host);
+	unlock_kernel();
 	kfree(req);
 	return;
  retry_rebind:
+	lock_kernel();
 	nlm_rebind_host(req->a_host);
+	unlock_kernel();
  retry_unlock:
 	rpc_restart_call(task);
 }
@@ -650,12 +654,16 @@
 	}
 
 die:
+	lock_kernel();
 	nlm_release_host(req->a_host);
+	unlock_kernel();
 	kfree(req);
 	return;
 
 retry_cancel:
+	lock_kernel();
 	nlm_rebind_host(req->a_host);
+	unlock_kernel();
 	rpc_restart_call(task);
 	rpc_delay(task, 30 * HZ);
 }
diff -u --recursive --new-file linux-2.5.4/fs/lockd/svc4proc.c linux-2.5.4-rpc_bkl/fs/lockd/svc4proc.c
--- linux-2.5.4/fs/lockd/svc4proc.c	Mon Feb 11 02:50:14 2002
+++ linux-2.5.4-rpc_bkl/fs/lockd/svc4proc.c	Tue Feb 12 09:32:18 2002
@@ -17,6 +17,7 @@
 #include <linux/lockd/lockd.h>
 #include <linux/lockd/share.h>
 #include <linux/lockd/sm_inter.h>
+#include <linux/smp_lock.h>
 
 
 #define NLMDBG_FACILITY		NLMDBG_CLIENT
@@ -499,7 +500,9 @@
 		dprintk("lockd: %4d callback failed (errno = %d)\n",
 					task->tk_pid, -task->tk_status);
 	}
+	lock_kernel();
 	nlm_release_host(call->a_host);
+	unlock_kernel();
 	kfree(call);
 }
 
diff -u --recursive --new-file linux-2.5.4/fs/lockd/svclock.c linux-2.5.4-rpc_bkl/fs/lockd/svclock.c
--- linux-2.5.4/fs/lockd/svclock.c	Mon Feb 11 02:50:13 2002
+++ linux-2.5.4-rpc_bkl/fs/lockd/svclock.c	Tue Feb 12 09:32:18 2002
@@ -576,9 +576,10 @@
 	dprintk("lockd: GRANT_MSG RPC callback\n");
 	dprintk("callback: looking for cookie %x \n", 
 		*(unsigned int *)(call->a_args.cookie.data));
+	lock_kernel();
 	if (!(block = nlmsvc_find_block(&call->a_args.cookie))) {
 		dprintk("lockd: no block for cookie %x\n", *(u32 *)(call->a_args.cookie.data));
-		return;
+		goto out;
 	}
 
 	/* Technically, we should down the file semaphore here. Since we
@@ -599,6 +600,8 @@
 	block->b_incall = 0;
 
 	nlm_release_host(call->a_host);
+ out:
+	unlock_kernel();
 }
 
 /*
diff -u --recursive --new-file linux-2.5.4/fs/lockd/svcproc.c linux-2.5.4-rpc_bkl/fs/lockd/svcproc.c
--- linux-2.5.4/fs/lockd/svcproc.c	Mon Feb 11 02:50:10 2002
+++ linux-2.5.4-rpc_bkl/fs/lockd/svcproc.c	Tue Feb 12 09:32:18 2002
@@ -18,6 +18,7 @@
 #include <linux/lockd/lockd.h>
 #include <linux/lockd/share.h>
 #include <linux/lockd/sm_inter.h>
+#include <linux/smp_lock.h>
 
 
 #define NLMDBG_FACILITY		NLMDBG_CLIENT
@@ -527,7 +528,9 @@
 		dprintk("lockd: %4d callback failed (errno = %d)\n",
 					task->tk_pid, -task->tk_status);
 	}
+	lock_kernel();
 	nlm_release_host(call->a_host);
+	unlock_kernel();
 	kfree(call);
 }
 
diff -u --recursive --new-file linux-2.5.4/fs/nfs/file.c linux-2.5.4-rpc_bkl/fs/nfs/file.c
--- linux-2.5.4/fs/nfs/file.c	Mon Feb 11 02:50:09 2002
+++ linux-2.5.4-rpc_bkl/fs/nfs/file.c	Tue Feb 12 09:32:18 2002
@@ -99,7 +99,9 @@
 		dentry->d_parent->d_name.name, dentry->d_name.name,
 		(unsigned long) count, (unsigned long) *ppos);
 
+	lock_kernel();
 	result = nfs_revalidate_inode(NFS_SERVER(inode), inode);
+	unlock_kernel();
 	if (!result)
 		result = generic_file_read(file, buf, count, ppos);
 	return result;
@@ -115,7 +117,9 @@
 	dfprintk(VFS, "nfs: mmap(%s/%s)\n",
 		dentry->d_parent->d_name.name, dentry->d_name.name);
 
+	lock_kernel();
 	status = nfs_revalidate_inode(NFS_SERVER(inode), inode);
+	unlock_kernel();
 	if (!status)
 		status = generic_file_mmap(file, vma);
 	return status;
@@ -134,13 +138,11 @@
 
 	dfprintk(VFS, "nfs: fsync(%s/%ld)\n", inode->i_sb->s_id, inode->i_ino);
 
-	lock_kernel();
 	status = nfs_wb_file(inode, file);
 	if (!status) {
 		status = file->f_error;
 		file->f_error = 0;
 	}
-	unlock_kernel();
 	return status;
 }
 
@@ -160,12 +162,7 @@
 
 static int nfs_commit_write(struct file *file, struct page *page, unsigned offset, unsigned to)
 {
-	long status;
-
-	lock_kernel();
-	status = nfs_updatepage(file, page, offset, to-offset);
-	unlock_kernel();
-	return status;
+	return nfs_updatepage(file, page, offset, to-offset);
 }
 
 /*
@@ -219,7 +216,9 @@
 	result = -EBUSY;
 	if (IS_SWAPFILE(inode))
 		goto out_swapfile;
+	lock_kernel();
 	result = nfs_revalidate_inode(NFS_SERVER(inode), inode);
+	unlock_kernel();
 	if (result)
 		goto out;
 
diff -u --recursive --new-file linux-2.5.4/fs/nfs/flushd.c linux-2.5.4-rpc_bkl/fs/nfs/flushd.c
--- linux-2.5.4/fs/nfs/flushd.c	Mon Feb 11 02:50:09 2002
+++ linux-2.5.4-rpc_bkl/fs/nfs/flushd.c	Tue Feb 12 09:32:18 2002
@@ -51,6 +51,19 @@
  * This is the wait queue all cluster daemons sleep on
  */
 static struct rpc_wait_queue    flushd_queue = RPC_INIT_WAITQ("nfs_flushd");
+static spinlock_t nfs_flushd_lock = SPIN_LOCK_UNLOCKED;
+
+static inline void
+nfs_lock_flushd(void)
+{
+	spin_lock(&nfs_flushd_lock);
+}
+
+static inline void
+nfs_unlock_flushd(void)
+{
+	spin_unlock(&nfs_flushd_lock);
+}
 
 /*
  * Local function declarations.
@@ -67,12 +80,11 @@
 
 	dprintk("NFS: writecache_init\n");
 
-	lock_kernel();
-	status = -ENOMEM;
 	/* Create the RPC task */
 	if (!(task = rpc_new_task(server->client, NULL, RPC_TASK_ASYNC)))
-		goto out_unlock;
+		return -ENOMEM;
 
+	nfs_lock_flushd();
 	cache = server->rw_requests;
 
 	status = 0;
@@ -89,22 +101,21 @@
 	cache->auth = server->client->cl_auth;
 	task->tk_action   = nfs_flushd;
 	task->tk_exit   = nfs_flushd_exit;
+	nfs_unlock_flushd();
 
 	rpc_execute(task);
-	unlock_kernel();
 	return 0;
  out_unlock:
-	if (task)
-		rpc_release_task(task);
-	unlock_kernel();
-	return status;
+	nfs_unlock_flushd();
+	rpc_release_task(task);
+	return 0;
 }
 
 void nfs_reqlist_exit(struct nfs_server *server)
 {
 	struct nfs_reqlist      *cache;
 
-	lock_kernel();
+	nfs_lock_flushd();
 	cache = server->rw_requests;
 	if (!cache)
 		goto out;
@@ -114,11 +125,13 @@
 	while (cache->task) {
 		rpc_exit(cache->task, 0);
 		rpc_wake_up_task(cache->task);
+		nfs_unlock_flushd();
 
 		interruptible_sleep_on_timeout(&cache->request_wait, 1 * HZ);
+		nfs_lock_flushd();
 	}
  out:
-	unlock_kernel();
+	nfs_unlock_flushd();
 }
 
 int nfs_reqlist_alloc(struct nfs_server *server)
@@ -183,11 +196,13 @@
 	}
 
 	dprintk("NFS: %4d flushd back to sleep\n", task->tk_pid);
+	nfs_lock_flushd();
 	if (task->tk_action) {
 		task->tk_timeout = NFS_FLUSHD_TIMEOUT;
 		cache->runat = jiffies + task->tk_timeout;
 		rpc_sleep_on(&flushd_queue, task, NULL, NULL);
 	}
+	nfs_unlock_flushd();
 }
 
 static void
@@ -196,10 +211,13 @@
 	struct nfs_server	*server;
 	struct nfs_reqlist	*cache;
 	server = (struct nfs_server *) task->tk_calldata;
+
+	nfs_lock_flushd();
 	cache = server->rw_requests;
 
 	if (cache->task == task)
 		cache->task = NULL;
 	wake_up(&cache->request_wait);
+	nfs_unlock_flushd();
 }
 
diff -u --recursive --new-file linux-2.5.4/fs/nfs/inode.c linux-2.5.4-rpc_bkl/fs/nfs/inode.c
--- linux-2.5.4/fs/nfs/inode.c	Mon Feb 11 02:50:12 2002
+++ linux-2.5.4-rpc_bkl/fs/nfs/inode.c	Tue Feb 12 09:32:18 2002
@@ -90,6 +90,9 @@
 	&nfs_rpcstat,
 };
 
+/* Spinlock to protect the NFS inode update */
+static spinlock_t nfs_inode_lock = SPIN_LOCK_UNLOCKED;
+
 static inline unsigned long
 nfs_fattr_to_ino_t(struct nfs_fattr *fattr)
 {
@@ -586,18 +589,30 @@
 }
 
 /*
+ * Reset the read time on the local caches
+ */
+void
+nfs_invalidate_caches(struct inode *inode)
+{
+	spin_lock(&nfs_inode_lock);
+	NFS_READTIME(inode) = jiffies - NFS_MAXATTRTIMEO(inode) - 1;
+	spin_unlock(&nfs_inode_lock);
+}
+
+/*
  * Invalidate the local caches
  */
 void
 nfs_zap_caches(struct inode *inode)
 {
-	NFS_ATTRTIMEO(inode) = NFS_MINATTRTIMEO(inode);
-	NFS_ATTRTIMEO_UPDATE(inode) = jiffies;
-
 	invalidate_inode_pages(inode);
 
+	spin_lock(&nfs_inode_lock);
+	NFS_ATTRTIMEO(inode) = NFS_MINATTRTIMEO(inode);
+	NFS_ATTRTIMEO_UPDATE(inode) = jiffies;
 	memset(NFS_COOKIEVERF(inode), 0, sizeof(NFS_COOKIEVERF(inode)));
-	NFS_CACHEINV(inode);
+	NFS_READTIME(inode) = jiffies - NFS_MAXATTRTIMEO(inode) - 1;
+	spin_unlock(&nfs_inode_lock);
 }
 
 /*
@@ -838,7 +853,11 @@
 nfs_revalidate(struct dentry *dentry)
 {
 	struct inode *inode = dentry->d_inode;
-	return nfs_revalidate_inode(NFS_SERVER(inode), inode);
+	int status;
+	lock_kernel();
+	status = nfs_revalidate_inode(NFS_SERVER(inode), inode);
+	unlock_kernel();
+	return status;
 }
 
 /*
@@ -867,13 +886,11 @@
 	struct rpc_auth *auth;
 	struct rpc_cred *cred;
 
-	lock_kernel();
 	auth = NFS_CLIENT(inode)->cl_auth;
 	cred = rpcauth_lookupcred(auth, 0);
 	filp->private_data = cred;
 	if (filp->f_mode & FMODE_WRITE)
 		nfs_set_mmcred(inode, cred);
-	unlock_kernel();
 	return 0;
 }
 
@@ -881,11 +898,9 @@
 {
 	struct rpc_cred *cred;
 
-	lock_kernel();
 	cred = nfs_file_cred(filp);
 	if (cred)
 		put_rpccred(cred);
-	unlock_kernel();
 	return 0;
 }
 
@@ -902,7 +917,6 @@
 	dfprintk(PAGECACHE, "NFS: revalidating (%s/%Ld)\n",
 		inode->i_sb->s_id, (long long)NFS_FILEID(inode));
 
-	lock_kernel();
 	if (!inode || is_bad_inode(inode))
  		goto out_nowait;
 	if (NFS_STALE(inode) && inode != inode->i_sb->s_root->d_inode)
@@ -948,10 +962,22 @@
 	NFS_FLAGS(inode) &= ~NFS_INO_REVALIDATING;
 	wake_up(&inode->i_wait);
  out_nowait:
-	unlock_kernel();
 	return status;
 }
 
+/**
+ * nfs_grow_isize - Extend inode->i_size
+ * @inode: inode
+ * @size: new file size
+ */
+void nfs_grow_isize(struct inode *inode, loff_t size)
+{
+	spin_lock(&nfs_inode_lock);
+	if (inode->i_size < size)
+		inode->i_size = size;
+	spin_unlock(&nfs_inode_lock);
+}
+
 /*
  * nfs_fattr_obsolete - Test if attribute data is newer than cached data
  * @inode: inode
@@ -1024,6 +1050,7 @@
 
 	new_atime = nfs_time_to_secs(fattr->atime);
 	/* Avoid races */
+	spin_lock(&nfs_inode_lock);
 	if (nfs_fattr_obsolete(inode, fattr))
 		goto out_nochange;
 
@@ -1109,6 +1136,7 @@
 			NFS_ATTRTIMEO(inode) = NFS_MAXATTRTIMEO(inode);
 		NFS_ATTRTIMEO_UPDATE(inode) = jiffies;
 	}
+	spin_unlock(&nfs_inode_lock);
 
 	if (invalid)
 		nfs_zap_caches(inode);
@@ -1116,6 +1144,7 @@
  out_nochange:
 	if (new_atime - inode->i_atime > 0)
 		inode->i_atime = new_atime;
+	spin_unlock(&nfs_inode_lock);
 	return 0;
  out_changed:
 	/*
diff -u --recursive --new-file linux-2.5.4/fs/nfs/read.c linux-2.5.4-rpc_bkl/fs/nfs/read.c
--- linux-2.5.4/fs/nfs/read.c	Mon Feb 11 02:50:06 2002
+++ linux-2.5.4-rpc_bkl/fs/nfs/read.c	Tue Feb 12 09:32:18 2002
@@ -114,11 +114,9 @@
 			(long long)NFS_FILEID(inode),
 			(long long)offset, rsize, buffer);
 
-		lock_kernel();
 		result = NFS_PROTO(inode)->read(inode, cred, &fattr, flags,
 						offset, rsize, buffer, &eof);
 		nfs_refresh_inode(inode, &fattr);
-		unlock_kernel();
 
 		/*
 		 * Even if we had a partial success we can't mark the page
@@ -277,9 +275,7 @@
 
 	rpc_clnt_sigmask(clnt, &oldset);
 	rpc_call_setup(task, &msg, 0);
-	lock_kernel();
 	rpc_execute(task);
-	unlock_kernel();
 	rpc_clnt_sigunmask(clnt, &oldset);
 	return 0;
 out_bad:
diff -u --recursive --new-file linux-2.5.4/fs/nfs/write.c linux-2.5.4-rpc_bkl/fs/nfs/write.c
--- linux-2.5.4/fs/nfs/write.c	Mon Feb 11 02:50:11 2002
+++ linux-2.5.4-rpc_bkl/fs/nfs/write.c	Tue Feb 12 09:32:18 2002
@@ -194,8 +194,7 @@
 		 * If we've extended the file, update the inode
 		 * now so we don't invalidate the cache.
 		 */
-		if (base > inode->i_size)
-			inode->i_size = base;
+		nfs_grow_isize(inode, base);
 	} while (count);
 
 	if (PageError(page))
@@ -226,9 +225,7 @@
 	nfs_unlock_request(req);
 	nfs_strategy(inode);
 	end = ((loff_t)page->index<<PAGE_CACHE_SHIFT) + (loff_t)(offset + count);
-	if (inode->i_size < end)
-		inode->i_size = end;
-
+	nfs_grow_isize(inode, end);
  out:
 	return status;
 }
@@ -260,7 +257,6 @@
 	if (page->index >= end_index+1 || !offset)
 		goto out;
 do_it:
-	lock_kernel();
 	if (NFS_SERVER(inode)->wsize >= PAGE_CACHE_SIZE && !IS_SYNC(inode)) {
 		err = nfs_writepage_async(NULL, inode, page, 0, offset);
 		if (err >= 0)
@@ -270,7 +266,6 @@
 		if (err == offset)
 			err = 0;
 	}
-	unlock_kernel();
 out:
 	UnlockPage(page);
 	return err; 
@@ -828,8 +823,7 @@
 
 	status = 0;
 	end = ((loff_t)page->index<<PAGE_CACHE_SHIFT) + (loff_t)(offset + count);
-	if (inode->i_size < end)
-		inode->i_size = end;
+	nfs_grow_isize(inode, end);
 
 	/* If we wrote past the end of the page.
 	 * Call the strategy routine so it can send out a bunch
@@ -952,9 +946,7 @@
 
 	rpc_clnt_sigmask(clnt, &oldset);
 	rpc_call_setup(task, &msg, 0);
-	lock_kernel();
 	rpc_execute(task);
-	unlock_kernel();
 	rpc_clnt_sigunmask(clnt, &oldset);
 	return 0;
  out_bad:
@@ -1175,9 +1167,7 @@
 	dprintk("NFS: %4d initiated commit call\n", task->tk_pid);
 	rpc_clnt_sigmask(clnt, &oldset);
 	rpc_call_setup(task, &msg, 0);
-	lock_kernel();
 	rpc_execute(task);
-	unlock_kernel();
 	rpc_clnt_sigunmask(clnt, &oldset);
 	return 0;
  out_bad:
diff -u --recursive --new-file linux-2.5.4/include/linux/nfs_fs.h linux-2.5.4-rpc_bkl/include/linux/nfs_fs.h
--- linux-2.5.4/include/linux/nfs_fs.h	Mon Feb 11 02:50:14 2002
+++ linux-2.5.4-rpc_bkl/include/linux/nfs_fs.h	Tue Feb 12 11:14:21 2002
@@ -188,10 +188,7 @@
 #define NFS_CACHE_MTIME(inode)		(NFS_I(inode)->read_cache_mtime)
 #define NFS_CACHE_ISIZE(inode)		(NFS_I(inode)->read_cache_isize)
 #define NFS_NEXTSCAN(inode)		(NFS_I(inode)->nextscan)
-#define NFS_CACHEINV(inode) \
-do { \
-	NFS_READTIME(inode) = jiffies - NFS_MAXATTRTIMEO(inode) - 1; \
-} while (0)
+#define NFS_CACHEINV(inode)		nfs_invalidate_caches(inode)
 #define NFS_ATTRTIMEO(inode)		(NFS_I(inode)->attrtimeo)
 #define NFS_MINATTRTIMEO(inode) \
 	(S_ISDIR(inode->i_mode)? NFS_SERVER(inode)->acdirmin \
@@ -227,11 +224,13 @@
  * linux/fs/nfs/inode.c
  */
 extern void nfs_zap_caches(struct inode *);
+extern void nfs_invalidate_caches(struct inode *);
 extern int nfs_inode_is_stale(struct inode *, struct nfs_fh *,
 				struct nfs_fattr *);
 extern struct inode *nfs_fhget(struct dentry *, struct nfs_fh *,
 				struct nfs_fattr *);
 extern int __nfs_refresh_inode(struct inode *, struct nfs_fattr *);
+extern void nfs_grow_isize(struct inode *, loff_t);
 extern int nfs_revalidate(struct dentry *);
 extern int nfs_permission(struct inode *, int);
 extern int nfs_open(struct inode *, struct file *);
diff -u --recursive --new-file linux-2.5.4/net/sunrpc/sched.c linux-2.5.4-rpc_bkl/net/sunrpc/sched.c
--- linux-2.5.4/net/sunrpc/sched.c	Mon Feb 11 02:50:07 2002
+++ linux-2.5.4-rpc_bkl/net/sunrpc/sched.c	Tue Feb 12 09:32:18 2002
@@ -1052,7 +1052,6 @@
 	int		rounds = 0;
 
 	MOD_INC_USE_COUNT;
-	lock_kernel();
 	/*
 	 * Let our maker know we're running ...
 	 */
