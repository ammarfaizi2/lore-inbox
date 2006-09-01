Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932112AbWIAEjm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbWIAEjm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 00:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932159AbWIAEjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 00:39:40 -0400
Received: from ns2.suse.de ([195.135.220.15]:25003 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932121AbWIAEjO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 00:39:14 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 1 Sep 2006 14:39:05 +1000
Message-Id: <1060901043905.27570@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: Olaf Kirch <okir@suse.de>
Subject: [PATCH 011 of 19] knfsd: lockd: make nlm_traverse_* more flexible
References: <20060901141639.27206.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Olaf Kirch <okir@suse.de>

  This patch makes nlm_traverse{locks,blocks,shares} and friends
  use a function pointer rather than a "action" enum.

  This function pointer is given two nlm_hosts (one given by the
  caller, the other taken from the lock/block/share currently
  visited), and is free to do with them as it wants. If it returns a
  non-zero value, the lockd/block/share is released.

Signed-off-by: Olaf Kirch <okir@suse.de>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/lockd/svclock.c          |   33 +++----------
 ./fs/lockd/svcshare.c         |   20 +++-----
 ./fs/lockd/svcsubs.c          |  105 ++++++++++++++++++++++++++++++------------
 ./include/linux/lockd/lockd.h |   15 ++----
 ./include/linux/lockd/share.h |    3 -
 5 files changed, 102 insertions(+), 74 deletions(-)

diff .prev/fs/lockd/svclock.c ./fs/lockd/svclock.c
--- .prev/fs/lockd/svclock.c	2006-09-01 10:44:39.000000000 +1000
+++ ./fs/lockd/svclock.c	2006-09-01 10:59:37.000000000 +1000
@@ -265,24 +265,20 @@ static void nlmsvc_release_block(struct 
 		kref_put(&block->b_count, nlmsvc_free_block);
 }
 
-static void nlmsvc_act_mark(struct nlm_host *host, struct nlm_file *file)
-{
-	struct nlm_block *block;
-
-	down(&file->f_sema);
-	list_for_each_entry(block, &file->f_blocks, b_flist)
-		block->b_host->h_inuse = 1;
-	up(&file->f_sema);
-}
-
-static void nlmsvc_act_unlock(struct nlm_host *host, struct nlm_file *file)
+/*
+ * Loop over all blocks and delete blocks held by
+ * a matching host.
+ */
+void nlmsvc_traverse_blocks(struct nlm_host *host,
+			struct nlm_file *file,
+			nlm_host_match_fn_t match)
 {
 	struct nlm_block *block, *next;
 
 restart:
 	down(&file->f_sema);
 	list_for_each_entry_safe(block, next, &file->f_blocks, b_flist) {
-		if (host != NULL && host != block->b_host)
+		if (!match(block->b_host, host))
 			continue;
 		/* Do not destroy blocks that are not on
 		 * the global retry list - why? */
@@ -298,19 +294,6 @@ restart:
 }
 
 /*
- * Loop over all blocks and perform the action specified.
- * (NLM_ACT_CHECK handled by nlmsvc_inspect_file).
- */
-void
-nlmsvc_traverse_blocks(struct nlm_host *host, struct nlm_file *file, int action)
-{
-	if (action == NLM_ACT_MARK)
-		nlmsvc_act_mark(host, file);
-	else
-		nlmsvc_act_unlock(host, file);
-}
-
-/*
  * Initialize arguments for GRANTED call. The nlm_rqst structure
  * has been cleared already.
  */

diff .prev/fs/lockd/svcshare.c ./fs/lockd/svcshare.c
--- .prev/fs/lockd/svcshare.c	2006-09-01 10:39:06.000000000 +1000
+++ ./fs/lockd/svcshare.c	2006-09-01 10:58:38.000000000 +1000
@@ -85,24 +85,20 @@ nlmsvc_unshare_file(struct nlm_host *hos
 }
 
 /*
- * Traverse all shares for a given file (and host).
- * NLM_ACT_CHECK is handled by nlmsvc_inspect_file.
+ * Traverse all shares for a given file, and delete
+ * those owned by the given (type of) host
  */
-void
-nlmsvc_traverse_shares(struct nlm_host *host, struct nlm_file *file, int action)
+void nlmsvc_traverse_shares(struct nlm_host *host, struct nlm_file *file,
+		nlm_host_match_fn_t match)
 {
 	struct nlm_share	*share, **shpp;
 
 	shpp = &file->f_shares;
 	while ((share = *shpp) !=  NULL) {
-		if (action == NLM_ACT_MARK)
-			share->s_host->h_inuse = 1;
-		else if (action == NLM_ACT_UNLOCK) {
-			if (host == NULL || host == share->s_host) {
-				*shpp = share->s_next;
-				kfree(share);
-				continue;
-			}
+		if (match(share->s_host, host)) {
+			*shpp = share->s_next;
+			kfree(share);
+			continue;
 		}
 		shpp = &share->s_next;
 	}

diff .prev/fs/lockd/svcsubs.c ./fs/lockd/svcsubs.c
--- .prev/fs/lockd/svcsubs.c	2006-09-01 10:45:16.000000000 +1000
+++ ./fs/lockd/svcsubs.c	2006-09-01 11:06:21.000000000 +1000
@@ -165,7 +165,8 @@ nlm_delete_file(struct nlm_file *file)
  * action.
  */
 static int
-nlm_traverse_locks(struct nlm_host *host, struct nlm_file *file, int action)
+nlm_traverse_locks(struct nlm_host *host, struct nlm_file *file,
+			nlm_host_match_fn_t match)
 {
 	struct inode	 *inode = nlmsvc_file_inode(file);
 	struct file_lock *fl;
@@ -179,17 +180,11 @@ again:
 
 		/* update current lock count */
 		file->f_locks++;
+
 		lockhost = (struct nlm_host *) fl->fl_owner;
-		if (action == NLM_ACT_MARK)
-			lockhost->h_inuse = 1;
-		else if (action == NLM_ACT_CHECK)
-			return 1;
-		else if (action == NLM_ACT_UNLOCK) {
+		if (match(lockhost, host)) {
 			struct file_lock lock = *fl;
 
-			if (host && lockhost != host)
-				continue;
-
 			lock.fl_type  = F_UNLCK;
 			lock.fl_start = 0;
 			lock.fl_end   = OFFSET_MAX;
@@ -206,27 +201,42 @@ again:
 }
 
 /*
- * Operate on a single file
+ * Inspect a single file
+ */
+static inline int
+nlm_inspect_file(struct nlm_host *host, struct nlm_file *file, nlm_host_match_fn_t match)
+{
+	nlmsvc_traverse_blocks(host, file, match);
+	nlmsvc_traverse_shares(host, file, match);
+	return nlm_traverse_locks(host, file, match);
+}
+
+/*
+ * Quick check whether there are still any locks, blocks or
+ * shares on a given file.
  */
 static inline int
-nlm_inspect_file(struct nlm_host *host, struct nlm_file *file, int action)
+nlm_file_inuse(struct nlm_file *file)
 {
-	if (action == NLM_ACT_CHECK) {
-		/* Fast path for mark and sweep garbage collection */
-		if (file->f_count || list_empty(&file->f_blocks) || file->f_shares)
+	struct inode	 *inode = nlmsvc_file_inode(file);
+	struct file_lock *fl;
+
+	if (file->f_count || !list_empty(&file->f_blocks) || file->f_shares)
+		return 1;
+
+	for (fl = inode->i_flock; fl; fl = fl->fl_next) {
+		if (fl->fl_lmops == &nlmsvc_lock_operations)
 			return 1;
-	} else {
-		nlmsvc_traverse_blocks(host, file, action);
-		nlmsvc_traverse_shares(host, file, action);
 	}
-	return nlm_traverse_locks(host, file, action);
+	file->f_locks = 0;
+	return 0;
 }
 
 /*
  * Loop over all files in the file table.
  */
 static int
-nlm_traverse_files(struct nlm_host *host, int action)
+nlm_traverse_files(struct nlm_host *host, nlm_host_match_fn_t match)
 {
 	struct hlist_node *pos, *next;
 	struct nlm_file	*file;
@@ -240,7 +250,7 @@ nlm_traverse_files(struct nlm_host *host
 
 			/* Traverse locks, blocks and shares of this file
 			 * and update file->f_locks count */
-			if (nlm_inspect_file(host, file, action))
+			if (nlm_inspect_file(host, file, match))
 				ret = 1;
 
 			mutex_lock(&nlm_file_mutex);
@@ -277,23 +287,54 @@ nlm_release_file(struct nlm_file *file)
 	mutex_lock(&nlm_file_mutex);
 
 	/* If there are no more locks etc, delete the file */
-	if(--file->f_count == 0) {
-		if(!nlm_inspect_file(NULL, file, NLM_ACT_CHECK))
-			nlm_delete_file(file);
-	}
+	if (--file->f_count == 0 && !nlm_file_inuse(file))
+		nlm_delete_file(file);
 
 	mutex_unlock(&nlm_file_mutex);
 }
 
 /*
+ * Helpers function for resource traversal
+ *
+ * nlmsvc_mark_host:
+ *	used by the garbage collector; simply sets h_inuse.
+ *	Always returns 0.
+ *
+ * nlmsvc_same_host:
+ *	returns 1 iff the two hosts match. Used to release
+ *	all resources bound to a specific host.
+ *
+ * nlmsvc_is_client:
+ *	returns 1 iff the host is a client.
+ *	Used by nlmsvc_invalidate_all
+ */
+static int
+nlmsvc_mark_host(struct nlm_host *host, struct nlm_host *dummy)
+{
+	host->h_inuse = 1;
+	return 0;
+}
+
+static int
+nlmsvc_same_host(struct nlm_host *host, struct nlm_host *other)
+{
+	return host == other;
+}
+
+static int
+nlmsvc_is_client(struct nlm_host *host, struct nlm_host *dummy)
+{
+	return host->h_server;
+}
+
+/*
  * Mark all hosts that still hold resources
  */
 void
 nlmsvc_mark_resources(void)
 {
 	dprintk("lockd: nlmsvc_mark_resources\n");
-
-	nlm_traverse_files(NULL, NLM_ACT_MARK);
+	nlm_traverse_files(NULL, nlmsvc_mark_host);
 }
 
 /*
@@ -304,7 +345,7 @@ nlmsvc_free_host_resources(struct nlm_ho
 {
 	dprintk("lockd: nlmsvc_free_host_resources\n");
 
-	if (nlm_traverse_files(host, NLM_ACT_UNLOCK)) {
+	if (nlm_traverse_files(host, nlmsvc_same_host)) {
 		printk(KERN_WARNING
 			"lockd: couldn't remove all locks held by %s\n",
 			host->h_name);
@@ -319,8 +360,16 @@ void
 nlmsvc_invalidate_all(void)
 {
 	struct nlm_host *host;
+
+	/* Release all locks held by NFS clients.
+	 * Previously, the code would call
+	 * nlmsvc_free_host_resources for each client in
+	 * turn, which is about as inefficient as it gets.
+	 * Now we just do it once in nlm_traverse_files.
+	 */
+	nlm_traverse_files(NULL, nlmsvc_is_client);
+
 	while ((host = nlm_find_client()) != NULL) {
-		nlmsvc_free_host_resources(host);
 		host->h_expires = 0;
 		host->h_killed = 1;
 		nlm_release_host(host);

diff .prev/include/linux/lockd/lockd.h ./include/linux/lockd/lockd.h
--- .prev/include/linux/lockd/lockd.h	2006-09-01 10:45:16.000000000 +1000
+++ ./include/linux/lockd/lockd.h	2006-09-01 10:58:38.000000000 +1000
@@ -134,13 +134,6 @@ struct nlm_block {
 };
 
 /*
- * Valid actions for nlmsvc_traverse_files
- */
-#define NLM_ACT_CHECK		0		/* check for locks */
-#define NLM_ACT_MARK		1		/* mark & sweep */
-#define NLM_ACT_UNLOCK		2		/* release all locks */
-
-/*
  * Global variables
  */
 extern struct rpc_program	nlm_program;
@@ -183,6 +176,12 @@ void		  nsm_release(struct nsm_handle *)
 
 
 /*
+ * This is used in garbage collection and resource reclaim
+ * A return value != 0 means destroy the lock/block/share
+ */
+typedef int	  (*nlm_host_match_fn_t)(struct nlm_host *cur, struct nlm_host *ref);
+
+/*
  * Server-side lock handling
  */
 u32		  nlmsvc_lock(struct svc_rqst *, struct nlm_file *,
@@ -193,7 +192,7 @@ u32		  nlmsvc_testlock(struct nlm_file *
 u32		  nlmsvc_cancel_blocked(struct nlm_file *, struct nlm_lock *);
 unsigned long	  nlmsvc_retry_blocked(void);
 void		  nlmsvc_traverse_blocks(struct nlm_host *, struct nlm_file *,
-					int action);
+					nlm_host_match_fn_t match);
 void	  nlmsvc_grant_reply(struct svc_rqst *, struct nlm_cookie *, u32);
 
 /*

diff .prev/include/linux/lockd/share.h ./include/linux/lockd/share.h
--- .prev/include/linux/lockd/share.h	2006-09-01 10:39:06.000000000 +1000
+++ ./include/linux/lockd/share.h	2006-09-01 10:58:38.000000000 +1000
@@ -25,6 +25,7 @@ u32	nlmsvc_share_file(struct nlm_host *,
 					       struct nlm_args *);
 u32	nlmsvc_unshare_file(struct nlm_host *, struct nlm_file *,
 					       struct nlm_args *);
-void	nlmsvc_traverse_shares(struct nlm_host *, struct nlm_file *, int);
+void	nlmsvc_traverse_shares(struct nlm_host *, struct nlm_file *,
+					       nlm_host_match_fn_t);
 
 #endif /* LINUX_LOCKD_SHARE_H */
