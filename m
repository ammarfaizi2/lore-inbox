Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264960AbUHNTjH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264960AbUHNTjH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 15:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265099AbUHNTiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 15:38:50 -0400
Received: from dh138.citi.umich.edu ([141.211.133.138]:52098 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S264960AbUHNTce
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 15:32:34 -0400
Subject: PATCH [5/7] Fix posix locking code
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Linux Filesystem Development <linux-fsdevel@vger.kernel.org>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092511949.4109.34.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 14 Aug 2004 15:32:29 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 NLM: Thanks to the wonder of CLONE_FILES, the value of
      file_lock->fl_owner may live for longer than the pid
      of the process that originally created it. Fix NFSv2/v3
      client locking code to map file_lock->fl_owner into
      a unique 32-bit number or "pseudo-pid".

 Signed-off-by: Trond Myklebust <trond.myklebust@fys.uio.no>


 fs/lockd/clntlock.c         |    4 +-
 fs/lockd/clntproc.c         |   79 ++++++++++++++++++++++++++++++++++++++++++--
 fs/lockd/host.c             |   18 ++++++----
 include/linux/lockd/lockd.h |   17 ++++++++-
 include/linux/nfs_fs_i.h    |    4 +-
 5 files changed, 108 insertions(+), 14 deletions(-)

diff -u --recursive --new-file --show-c-function linux-2.6.8.1-04-fix_lockd/fs/lockd/clntlock.c linux-2.6.8.1-05-nlm_lockowner/fs/lockd/clntlock.c
--- linux-2.6.8.1-04-fix_lockd/fs/lockd/clntlock.c	2004-08-14 14:27:44.000000000 -0400
+++ linux-2.6.8.1-05-nlm_lockowner/fs/lockd/clntlock.c	2004-08-14 14:29:34.000000000 -0400
@@ -146,7 +146,7 @@ void nlmclnt_mark_reclaim(struct nlm_hos
 		inode = fl->fl_file->f_dentry->d_inode;
 		if (inode->i_sb->s_magic != NFS_SUPER_MAGIC)
 			continue;
-		if (fl->fl_u.nfs_fl.host != host)
+		if (fl->fl_u.nfs_fl.owner->host != host)
 			continue;
 		if (!(fl->fl_u.nfs_fl.flags & NFS_LCK_GRANTED))
 			continue;
@@ -215,7 +215,7 @@ restart:
 		inode = fl->fl_file->f_dentry->d_inode;
 		if (inode->i_sb->s_magic != NFS_SUPER_MAGIC)
 			continue;
-		if (fl->fl_u.nfs_fl.host != host)
+		if (fl->fl_u.nfs_fl.owner->host != host)
 			continue;
 		if (!(fl->fl_u.nfs_fl.flags & NFS_LCK_RECLAIM))
 			continue;
diff -u --recursive --new-file --show-c-function linux-2.6.8.1-04-fix_lockd/fs/lockd/clntproc.c linux-2.6.8.1-05-nlm_lockowner/fs/lockd/clntproc.c
--- linux-2.6.8.1-04-fix_lockd/fs/lockd/clntproc.c	2004-08-14 14:29:27.000000000 -0400
+++ linux-2.6.8.1-05-nlm_lockowner/fs/lockd/clntproc.c	2004-08-14 14:29:34.000000000 -0400
@@ -42,6 +42,79 @@ static inline void nlmclnt_next_cookie(s
 	nlm_cookie++;
 }
 
+static struct nlm_lockowner *nlm_get_lockowner(struct nlm_lockowner *lockowner)
+{
+	atomic_inc(&lockowner->count);
+	return lockowner;
+}
+
+static void nlm_put_lockowner(struct nlm_lockowner *lockowner)
+{
+	if (!atomic_dec_and_lock(&lockowner->count, &lockowner->host->h_lock))
+		return;
+	list_del(&lockowner->list);
+	spin_unlock(&lockowner->host->h_lock);
+	nlm_release_host(lockowner->host);
+	kfree(lockowner);
+}
+
+static inline int nlm_pidbusy(struct nlm_host *host, uint32_t pid)
+{
+	struct nlm_lockowner *lockowner;
+	list_for_each_entry(lockowner, &host->h_lockowners, list) {
+		if (lockowner->pid == pid)
+			return -EBUSY;
+	}
+	return 0;
+}
+
+static inline uint32_t __nlm_alloc_pid(struct nlm_host *host)
+{
+	uint32_t res;
+	do {
+		res = host->h_pidcount++;
+	} while (nlm_pidbusy(host, res) < 0);
+	return res;
+}
+
+static struct nlm_lockowner *__nlm_find_lockowner(struct nlm_host *host, fl_owner_t owner)
+{
+	struct nlm_lockowner *lockowner;
+	list_for_each_entry(lockowner, &host->h_lockowners, list) {
+		if (lockowner->owner != owner)
+			continue;
+		return nlm_get_lockowner(lockowner);
+	}
+	return NULL;
+}
+
+static struct nlm_lockowner *nlm_find_lockowner(struct nlm_host *host, fl_owner_t owner)
+{
+	struct nlm_lockowner *res, *new = NULL;
+
+	spin_lock(&host->h_lock);
+	res = __nlm_find_lockowner(host, owner);
+	if (res == NULL) {
+		spin_unlock(&host->h_lock);
+		new = (struct nlm_lockowner *)kmalloc(sizeof(*new), GFP_KERNEL);
+		spin_lock(&host->h_lock);
+		res = __nlm_find_lockowner(host, owner);
+		if (res == NULL && new != NULL) {
+			res = new;
+			atomic_set(&new->count, 1);
+			new->owner = owner;
+			new->pid = __nlm_alloc_pid(host);
+			new->host = nlm_get_host(host);
+			list_add(&new->list, &host->h_lockowners);
+			new = NULL;
+		}
+	}
+	spin_unlock(&host->h_lock);
+	if (new != NULL)
+		kfree(new);
+	return res;
+}
+
 /*
  * Initialize arguments for TEST/LOCK/UNLOCK/CANCEL calls
  */
@@ -418,12 +491,12 @@ nlmclnt_test(struct nlm_rqst *req, struc
 static void nlmclnt_locks_copy_lock(struct file_lock *new, struct file_lock *fl)
 {
 	memcpy(&new->fl_u.nfs_fl, &fl->fl_u.nfs_fl, sizeof(new->fl_u.nfs_fl));
-	nlm_get_host(new->fl_u.nfs_fl.host);
+	nlm_get_lockowner(new->fl_u.nfs_fl.owner);
 }
 
 static void nlmclnt_locks_release_private(struct file_lock *fl)
 {
-	nlm_release_host(fl->fl_u.nfs_fl.host);
+	nlm_put_lockowner(fl->fl_u.nfs_fl.owner);
 	fl->fl_ops = NULL;
 }
 
@@ -437,7 +510,7 @@ static void nlmclnt_locks_init_private(s
 	BUG_ON(fl->fl_ops != NULL);
 	fl->fl_u.nfs_fl.state = 0;
 	fl->fl_u.nfs_fl.flags = 0;
-	fl->fl_u.nfs_fl.host = nlm_get_host(host);
+	fl->fl_u.nfs_fl.owner = nlm_find_lockowner(host, fl->fl_owner);
 	fl->fl_ops = &nlmclnt_lock_ops;
 }
 
diff -u --recursive --new-file --show-c-function linux-2.6.8.1-04-fix_lockd/fs/lockd/host.c linux-2.6.8.1-05-nlm_lockowner/fs/lockd/host.c
--- linux-2.6.8.1-04-fix_lockd/fs/lockd/host.c	2004-08-14 14:26:44.000000000 -0400
+++ linux-2.6.8.1-05-nlm_lockowner/fs/lockd/host.c	2004-08-14 14:29:34.000000000 -0400
@@ -119,13 +119,15 @@ nlm_lookup_host(int server, struct socka
 	init_MUTEX(&host->h_sema);
 	host->h_nextrebind = jiffies + NLM_HOST_REBIND;
 	host->h_expires    = jiffies + NLM_HOST_EXPIRE;
-	host->h_count      = 1;
+	atomic_set(&host->h_count, 1);
 	init_waitqueue_head(&host->h_gracewait);
 	host->h_state      = 0;			/* pseudo NSM state */
 	host->h_nsmstate   = 0;			/* real NSM state */
 	host->h_server	   = server;
 	host->h_next       = nlm_hosts[hash];
 	nlm_hosts[hash]    = host;
+	INIT_LIST_HEAD(&host->h_lockowners);
+	spin_lock_init(&host->h_lock);
 
 	if (++nrhosts > NLM_HOST_MAX)
 		next_gc = 0;
@@ -235,7 +237,7 @@ struct nlm_host * nlm_get_host(struct nl
 {
 	if (host) {
 		dprintk("lockd: get host %s\n", host->h_name);
-		host->h_count ++;
+		atomic_inc(&host->h_count);
 		host->h_expires = jiffies + NLM_HOST_EXPIRE;
 	}
 	return host;
@@ -246,9 +248,10 @@ struct nlm_host * nlm_get_host(struct nl
  */
 void nlm_release_host(struct nlm_host *host)
 {
-	if (host && host->h_count) {
+	if (host != NULL) {
 		dprintk("lockd: release host %s\n", host->h_name);
-		host->h_count --;
+		atomic_dec(&host->h_count);
+		BUG_ON(atomic_read(&host->h_count) < 0);
 	}
 }
 
@@ -283,7 +286,7 @@ nlm_shutdown_hosts(void)
 		for (i = 0; i < NLM_HOST_NRHASH; i++) {
 			for (host = nlm_hosts[i]; host; host = host->h_next) {
 				dprintk("       %s (cnt %d use %d exp %ld)\n",
-					host->h_name, host->h_count,
+					host->h_name, atomic_read(&host->h_count),
 					host->h_inuse, host->h_expires);
 			}
 		}
@@ -314,10 +317,10 @@ nlm_gc_hosts(void)
 	for (i = 0; i < NLM_HOST_NRHASH; i++) {
 		q = &nlm_hosts[i];
 		while ((host = *q) != NULL) {
-			if (host->h_count || host->h_inuse
+			if (atomic_read(&host->h_count) || host->h_inuse
 			 || time_before(jiffies, host->h_expires)) {
 				dprintk("nlm_gc_hosts skipping %s (cnt %d use %d exp %ld)\n",
-					host->h_name, host->h_count,
+					host->h_name, atomic_read(&host->h_count),
 					host->h_inuse, host->h_expires);
 				q = &host->h_next;
 				continue;
@@ -336,6 +339,7 @@ nlm_gc_hosts(void)
 					rpc_destroy_client(host->h_rpcclnt);
 				}
 			}
+			BUG_ON(!list_empty(&host->h_lockowners));
 			kfree(host);
 			nrhosts--;
 		}
diff -u --recursive --new-file --show-c-function linux-2.6.8.1-04-fix_lockd/include/linux/lockd/lockd.h linux-2.6.8.1-05-nlm_lockowner/include/linux/lockd/lockd.h
--- linux-2.6.8.1-04-fix_lockd/include/linux/lockd/lockd.h	2004-08-14 14:29:27.000000000 -0400
+++ linux-2.6.8.1-05-nlm_lockowner/include/linux/lockd/lockd.h	2004-08-14 14:29:34.000000000 -0400
@@ -52,10 +52,25 @@ struct nlm_host {
 	wait_queue_head_t	h_gracewait;	/* wait while reclaiming */
 	u32			h_state;	/* pseudo-state counter */
 	u32			h_nsmstate;	/* true remote NSM state */
-	unsigned int		h_count;	/* reference count */
+	u32			h_pidcount;	/* Pseudopids */
+	atomic_t		h_count;	/* reference count */
 	struct semaphore	h_sema;		/* mutex for pmap binding */
 	unsigned long		h_nextrebind;	/* next portmap call */
 	unsigned long		h_expires;	/* eligible for GC */
+	struct list_head	h_lockowners;	/* Lockowners for the client */
+	spinlock_t		h_lock;
+};
+
+/*
+ * Map an fl_owner_t into a unique 32-bit "pid"
+ */
+struct nlm_lockowner {
+	struct list_head list;
+	atomic_t count;
+
+	struct nlm_host *host;
+	fl_owner_t owner;
+	uint32_t pid;
 };
 
 /*
diff -u --recursive --new-file --show-c-function linux-2.6.8.1-04-fix_lockd/include/linux/nfs_fs_i.h linux-2.6.8.1-05-nlm_lockowner/include/linux/nfs_fs_i.h
--- linux-2.6.8.1-04-fix_lockd/include/linux/nfs_fs_i.h	2004-08-14 14:28:02.000000000 -0400
+++ linux-2.6.8.1-05-nlm_lockowner/include/linux/nfs_fs_i.h	2004-08-14 14:29:34.000000000 -0400
@@ -5,13 +5,15 @@
 #include <linux/list.h>
 #include <linux/nfs.h>
 
+struct nlm_lockowner;
+
 /*
  * NFS lock info
  */
 struct nfs_lock_info {
 	u32		state;
 	u32		flags;
-	struct nlm_host	*host;
+	struct nlm_lockowner *owner;
 };
 
 /*

