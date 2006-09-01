Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964779AbWIAEkM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964779AbWIAEkM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 00:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932130AbWIAEjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 00:39:44 -0400
Received: from ns1.suse.de ([195.135.220.2]:1498 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932113AbWIAEjD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 00:39:03 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 1 Sep 2006 14:38:54 +1000
Message-Id: <1060901043854.27524@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: Olaf Kirch <okir@suse.de>
Subject: [PATCH 009 of 19] knfsd: lockd: Change list of blocked list to list_node
References: <20060901141639.27206.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Olaf Kirch <okir@suse.de>

 This patch changes the nlm_blocked list to use a list_node
 instead of homegrown linked list handling.

Signed-off-by: Olaf Kirch <okir@suse.de>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/lockd/svclock.c          |  119 +++++++++++++++++++-----------------------
 ./fs/lockd/svcsubs.c          |    5 +
 ./include/linux/lockd/lockd.h |    7 +-
 3 files changed, 62 insertions(+), 69 deletions(-)

diff .prev/fs/lockd/svclock.c ./fs/lockd/svclock.c
--- .prev/fs/lockd/svclock.c	2006-09-01 10:42:31.000000000 +1000
+++ ./fs/lockd/svclock.c	2006-09-01 10:44:39.000000000 +1000
@@ -40,7 +40,7 @@
 
 static void nlmsvc_release_block(struct nlm_block *block);
 static void	nlmsvc_insert_block(struct nlm_block *block, unsigned long);
-static int	nlmsvc_remove_block(struct nlm_block *block);
+static void	nlmsvc_remove_block(struct nlm_block *block);
 
 static int nlmsvc_setgrantargs(struct nlm_rqst *call, struct nlm_lock *lock);
 static void nlmsvc_freegrantargs(struct nlm_rqst *call);
@@ -49,7 +49,7 @@ static const struct rpc_call_ops nlmsvc_
 /*
  * The list of blocked locks to retry
  */
-static struct nlm_block *	nlm_blocked;
+static LIST_HEAD(nlm_blocked);
 
 /*
  * Insert a blocked lock into the global list
@@ -57,48 +57,44 @@ static struct nlm_block *	nlm_blocked;
 static void
 nlmsvc_insert_block(struct nlm_block *block, unsigned long when)
 {
-	struct nlm_block **bp, *b;
+	struct nlm_block *b;
+	struct list_head *pos;
 
 	dprintk("lockd: nlmsvc_insert_block(%p, %ld)\n", block, when);
-	kref_get(&block->b_count);
-	if (block->b_queued)
-		nlmsvc_remove_block(block);
-	bp = &nlm_blocked;
+	if (list_empty(&block->b_list)) {
+		kref_get(&block->b_count);
+	} else {
+		list_del_init(&block->b_list);
+	}
+
+	pos = &nlm_blocked;
 	if (when != NLM_NEVER) {
 		if ((when += jiffies) == NLM_NEVER)
 			when ++;
-		while ((b = *bp) && time_before_eq(b->b_when,when) && b->b_when != NLM_NEVER)
-			bp = &b->b_next;
-	} else
-		while ((b = *bp) != 0)
-			bp = &b->b_next;
+		list_for_each(pos, &nlm_blocked) {
+			b = list_entry(pos, struct nlm_block, b_list);
+			if (time_after(b->b_when,when) || b->b_when == NLM_NEVER)
+				break;
+		}
+		/* On normal exit from the loop, pos == &nlm_blocked,
+		 * so we will be adding to the end of the list - good
+		 */
+	}
 
-	block->b_queued = 1;
+	list_add_tail(&block->b_list, pos);
 	block->b_when = when;
-	block->b_next = b;
-	*bp = block;
 }
 
 /*
  * Remove a block from the global list
  */
-static int
+static inline void
 nlmsvc_remove_block(struct nlm_block *block)
 {
-	struct nlm_block **bp, *b;
-
-	if (!block->b_queued)
-		return 1;
-	for (bp = &nlm_blocked; (b = *bp) != 0; bp = &b->b_next) {
-		if (b == block) {
-			*bp = block->b_next;
-			block->b_queued = 0;
-			nlmsvc_release_block(block);
-			return 1;
-		}
+	if (!list_empty(&block->b_list)) {
+		list_del_init(&block->b_list);
+		nlmsvc_release_block(block);
 	}
-
-	return 0;
 }
 
 /*
@@ -107,14 +103,14 @@ nlmsvc_remove_block(struct nlm_block *bl
 static struct nlm_block *
 nlmsvc_lookup_block(struct nlm_file *file, struct nlm_lock *lock)
 {
-	struct nlm_block	**head, *block;
+	struct nlm_block	*block;
 	struct file_lock	*fl;
 
 	dprintk("lockd: nlmsvc_lookup_block f=%p pd=%d %Ld-%Ld ty=%d\n",
 				file, lock->fl.fl_pid,
 				(long long)lock->fl.fl_start,
 				(long long)lock->fl.fl_end, lock->fl.fl_type);
-	for (head = &nlm_blocked; (block = *head) != 0; head = &block->b_next) {
+	list_for_each_entry(block, &nlm_blocked, b_list) {
 		fl = &block->b_call->a_args.lock.fl;
 		dprintk("lockd: check f=%p pd=%d %Ld-%Ld ty=%d cookie=%s\n",
 				block->b_file, fl->fl_pid,
@@ -147,16 +143,16 @@ nlmsvc_find_block(struct nlm_cookie *coo
 {
 	struct nlm_block *block;
 
-	for (block = nlm_blocked; block; block = block->b_next) {
-		dprintk("cookie: head of blocked queue %p, block %p\n", 
-			nlm_blocked, block);
+	list_for_each_entry(block, &nlm_blocked, b_list) {
 		if (nlm_cookie_match(&block->b_call->a_args.cookie,cookie)
 				&& nlm_cmp_addr(sin, &block->b_host->h_addr))
-			break;
+			goto found;
 	}
 
-	if (block != NULL)
-		kref_get(&block->b_count);
+	return NULL;
+
+found:
+	kref_get(&block->b_count);
 	return block;
 }
 
@@ -192,6 +188,8 @@ nlmsvc_create_block(struct svc_rqst *rqs
 	if (block == NULL)
 		goto failed;
 	kref_init(&block->b_count);
+	INIT_LIST_HEAD(&block->b_list);
+	INIT_LIST_HEAD(&block->b_flist);
 
 	if (!nlmsvc_setgrantargs(call, lock))
 		goto failed_free;
@@ -210,8 +208,7 @@ nlmsvc_create_block(struct svc_rqst *rqs
 	file->f_count++;
 
 	/* Add to file's list of blocks */
-	block->b_fnext  = file->f_blocks;
-	file->f_blocks  = block;
+	list_add(&block->b_flist, &file->f_blocks);
 
 	/* Set up RPC arguments for callback */
 	block->b_call = call;
@@ -248,18 +245,12 @@ static void nlmsvc_free_block(struct kre
 {
 	struct nlm_block *block = container_of(kref, struct nlm_block, b_count);
 	struct nlm_file		*file = block->b_file;
-	struct nlm_block	**bp;
 
 	dprintk("lockd: freeing block %p...\n", block);
 
-	down(&file->f_sema);
 	/* Remove block from file's list of blocks */
-	for (bp = &file->f_blocks; *bp; bp = &(*bp)->b_fnext) {
-		if (*bp == block) {
-			*bp = block->b_fnext;
-			break;
-		}
-	}
+	down(&file->f_sema);
+	list_del_init(&block->b_flist);
 	up(&file->f_sema);
 
 	nlmsvc_freegrantargs(block->b_call);
@@ -279,21 +270,23 @@ static void nlmsvc_act_mark(struct nlm_h
 	struct nlm_block *block;
 
 	down(&file->f_sema);
-	for (block = file->f_blocks; block != NULL; block = block->b_fnext)
+	list_for_each_entry(block, &file->f_blocks, b_flist)
 		block->b_host->h_inuse = 1;
 	up(&file->f_sema);
 }
 
 static void nlmsvc_act_unlock(struct nlm_host *host, struct nlm_file *file)
 {
-	struct nlm_block *block;
+	struct nlm_block *block, *next;
 
 restart:
 	down(&file->f_sema);
-	for (block = file->f_blocks; block != NULL; block = block->b_fnext) {
+	list_for_each_entry_safe(block, next, &file->f_blocks, b_flist) {
 		if (host != NULL && host != block->b_host)
 			continue;
-		if (!block->b_queued)
+		/* Do not destroy blocks that are not on
+		 * the global retry list - why? */
+		if (list_empty(&block->b_list))
 			continue;
 		kref_get(&block->b_count);
 		up(&file->f_sema);
@@ -528,10 +521,10 @@ nlmsvc_cancel_blocked(struct nlm_file *f
 static void
 nlmsvc_notify_blocked(struct file_lock *fl)
 {
-	struct nlm_block	**bp, *block;
+	struct nlm_block	*block;
 
 	dprintk("lockd: VFS unblock notification for block %p\n", fl);
-	for (bp = &nlm_blocked; (block = *bp) != 0; bp = &block->b_next) {
+	list_for_each_entry(block, &nlm_blocked, b_list) {
 		if (nlm_compare_locks(&block->b_call->a_args.lock.fl, fl)) {
 			nlmsvc_insert_block(block, 0);
 			svc_wake_up(block->b_daemon);
@@ -697,16 +690,19 @@ nlmsvc_grant_reply(struct svc_rqst *rqst
 unsigned long
 nlmsvc_retry_blocked(void)
 {
-	struct nlm_block	*block;
+	unsigned long	timeout = MAX_SCHEDULE_TIMEOUT;
+	struct nlm_block *block;
+
+	while (!list_empty(&nlm_blocked)) {
+		block = list_entry(nlm_blocked.next, struct nlm_block, b_list);
 
-	dprintk("nlmsvc_retry_blocked(%p, when=%ld)\n",
-			nlm_blocked,
-			nlm_blocked? nlm_blocked->b_when : 0);
-	while ((block = nlm_blocked) != 0) {
 		if (block->b_when == NLM_NEVER)
 			break;
-	        if (time_after(block->b_when,jiffies))
+	        if (time_after(block->b_when,jiffies)) {
+			timeout = block->b_when - jiffies;
 			break;
+		}
+
 		dprintk("nlmsvc_retry_blocked(%p, when=%ld)\n",
 			block, block->b_when);
 		kref_get(&block->b_count);
@@ -714,8 +710,5 @@ nlmsvc_retry_blocked(void)
 		nlmsvc_release_block(block);
 	}
 
-	if ((block = nlm_blocked) && block->b_when != NLM_NEVER)
-		return (block->b_when - jiffies);
-
-	return MAX_SCHEDULE_TIMEOUT;
+	return timeout;
 }

diff .prev/fs/lockd/svcsubs.c ./fs/lockd/svcsubs.c
--- .prev/fs/lockd/svcsubs.c	2006-09-01 10:42:31.000000000 +1000
+++ ./fs/lockd/svcsubs.c	2006-09-01 10:42:51.000000000 +1000
@@ -107,6 +107,7 @@ nlm_lookup_file(struct svc_rqst *rqstp, 
 	memcpy(&file->f_handle, f, sizeof(struct nfs_fh));
 	file->f_hash = hash;
 	init_MUTEX(&file->f_sema);
+	INIT_LIST_HEAD(&file->f_blocks);
 
 	/* Open the file. Note that this must not sleep for too long, else
 	 * we would lock up lockd:-) So no NFS re-exports, folks.
@@ -220,7 +221,7 @@ nlm_inspect_file(struct nlm_host *host, 
 {
 	if (action == NLM_ACT_CHECK) {
 		/* Fast path for mark and sweep garbage collection */
-		if (file->f_count || file->f_blocks || file->f_shares)
+		if (file->f_count || list_empty(&file->f_blocks) || file->f_shares)
 			return 1;
 	} else {
 		nlmsvc_traverse_blocks(host, file, action);
@@ -253,7 +254,7 @@ nlm_traverse_files(struct nlm_host *host
 			mutex_lock(&nlm_file_mutex);
 			file->f_count--;
 			/* No more references to this file. Let go of it. */
-			if (!file->f_blocks && !file->f_locks
+			if (list_empty(&file->f_blocks) && !file->f_locks
 			 && !file->f_shares && !file->f_count) {
 				*fp = file->f_next;
 				nlmsvc_ops->fclose(file->f_file);

diff .prev/include/linux/lockd/lockd.h ./include/linux/lockd/lockd.h
--- .prev/include/linux/lockd/lockd.h	2006-09-01 10:42:31.000000000 +1000
+++ ./include/linux/lockd/lockd.h	2006-09-01 10:42:51.000000000 +1000
@@ -109,7 +109,7 @@ struct nlm_file {
 	struct nfs_fh		f_handle;	/* NFS file handle */
 	struct file *		f_file;		/* VFS file pointer */
 	struct nlm_share *	f_shares;	/* DOS shares */
-	struct nlm_block *	f_blocks;	/* blocked locks */
+	struct list_head	f_blocks;	/* blocked locks */
 	unsigned int		f_locks;	/* guesstimate # of locks */
 	unsigned int		f_count;	/* reference count */
 	struct semaphore	f_sema;		/* avoid concurrent access */
@@ -123,14 +123,13 @@ struct nlm_file {
 #define NLM_NEVER		(~(unsigned long) 0)
 struct nlm_block {
 	struct kref		b_count;	/* Reference count */
-	struct nlm_block *	b_next;		/* linked list (all blocks) */
-	struct nlm_block *	b_fnext;	/* linked list (per file) */
+	struct list_head	b_list;		/* linked list of all blocks */
+	struct list_head	b_flist;	/* linked list (per file) */
 	struct nlm_rqst	*	b_call;		/* RPC args & callback info */
 	struct svc_serv *	b_daemon;	/* NLM service */
 	struct nlm_host *	b_host;		/* host handle for RPC clnt */
 	unsigned long		b_when;		/* next re-xmit */
 	unsigned int		b_id;		/* block id */
-	unsigned char		b_queued;	/* re-queued */
 	unsigned char		b_granted;	/* VFS granted lock */
 	struct nlm_file *	b_file;		/* file in question */
 };
