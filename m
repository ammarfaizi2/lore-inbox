Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750703AbWIAXsw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbWIAXsw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 19:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750707AbWIAXsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 19:48:52 -0400
Received: from ns2.suse.de ([195.135.220.15]:48318 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750703AbWIAXsv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 19:48:51 -0400
From: Neil Brown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Sat, 2 Sep 2006 09:48:40 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17656.50904.790639.414466@cse.unsw.edu.au>
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Olaf Kirch <okir@suse.de>
Subject: Re: [PATCH 004 of 19] knfsd: lockd: introduce nsm_handle
In-Reply-To: message from Andrew Morton on Thursday August 31
References: <20060901141639.27206.patches@notabene>
	<1060901043825.27464@suse.de>
	<20060831231703.78c99b60.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday August 31, akpm@osdl.org wrote:
> On Fri, 1 Sep 2006 14:38:25 +1000
> NeilBrown <neilb@suse.de> wrote:
> 
> > +static DECLARE_MUTEX(nsm_sema);
> > ...
> > +	down(&nsm_sema);
> 
> Next you'll all be wearing bell-bottomed jeans?

You've been peeking in my wardrobe, haven't you :-)

NeilBrown


---
Subject: Convert lockd to use the newer mutex instead of the older semaphore

Both the (recently introduces) nsm_sema and the older f_sema are
converted over.

Cc: Olaf Kirch <okir@suse.de>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/lockd/host.c             |   11 ++++++-----
 ./fs/lockd/svclock.c          |   22 +++++++++++-----------
 ./fs/lockd/svcsubs.c          |    2 +-
 ./include/linux/lockd/lockd.h |    2 +-
 4 files changed, 19 insertions(+), 18 deletions(-)

diff .prev/fs/lockd/host.c ./fs/lockd/host.c
--- .prev/fs/lockd/host.c	2006-09-01 12:26:45.000000000 +1000
+++ ./fs/lockd/host.c	2006-09-01 18:56:39.000000000 +1000
@@ -436,7 +436,7 @@ nlm_gc_hosts(void)
  * Manage NSM handles
  */
 static LIST_HEAD(nsm_handles);
-static DECLARE_MUTEX(nsm_sema);
+static DEFINE_MUTEX(nsm_mutex);
 
 static struct nsm_handle *
 __nsm_find(const struct sockaddr_in *sin,
@@ -458,7 +458,7 @@ __nsm_find(const struct sockaddr_in *sin
 		return NULL;
 	}
 
-	down(&nsm_sema);
+	mutex_lock(&nsm_mutex);
 	list_for_each(pos, &nsm_handles) {
 		nsm = list_entry(pos, struct nsm_handle, sm_link);
 
@@ -488,7 +488,8 @@ __nsm_find(const struct sockaddr_in *sin
 		list_add(&nsm->sm_link, &nsm_handles);
 	}
 
-out:	up(&nsm_sema);
+out:
+	mutex_unlock(&nsm_mutex);
 	return nsm;
 }
 
@@ -507,11 +508,11 @@ nsm_release(struct nsm_handle *nsm)
 	if (!nsm)
 		return;
 	if (atomic_read(&nsm->sm_count) == 1) {
-		down(&nsm_sema);
+		mutex_lock(&nsm_mutex);
 		if (atomic_dec_and_test(&nsm->sm_count)) {
 			list_del(&nsm->sm_link);
 			kfree(nsm);
 		}
-		up(&nsm_sema);
+		mutex_unlock(&nsm_mutex);
 	}
 }

diff .prev/fs/lockd/svclock.c ./fs/lockd/svclock.c
--- .prev/fs/lockd/svclock.c	2006-09-01 12:17:21.000000000 +1000
+++ ./fs/lockd/svclock.c	2006-09-01 18:54:53.000000000 +1000
@@ -254,9 +254,9 @@ static void nlmsvc_free_block(struct kre
 	dprintk("lockd: freeing block %p...\n", block);
 
 	/* Remove block from file's list of blocks */
-	down(&file->f_sema);
+	mutex_lock(&file->f_mutex);
 	list_del_init(&block->b_flist);
-	up(&file->f_sema);
+	mutex_unlock(&file->f_mutex);
 
 	nlmsvc_freegrantargs(block->b_call);
 	nlm_release_call(block->b_call);
@@ -281,7 +281,7 @@ void nlmsvc_traverse_blocks(struct nlm_h
 	struct nlm_block *block, *next;
 
 restart:
-	down(&file->f_sema);
+	mutex_lock(&file->f_mutex);
 	list_for_each_entry_safe(block, next, &file->f_blocks, b_flist) {
 		if (!match(block->b_host, host))
 			continue;
@@ -290,12 +290,12 @@ restart:
 		if (list_empty(&block->b_list))
 			continue;
 		kref_get(&block->b_count);
-		up(&file->f_sema);
+		mutex_unlock(&file->f_mutex);
 		nlmsvc_unlink_block(block);
 		nlmsvc_release_block(block);
 		goto restart;
 	}
-	up(&file->f_sema);
+	mutex_unlock(&file->f_mutex);
 }
 
 /*
@@ -354,7 +354,7 @@ nlmsvc_lock(struct svc_rqst *rqstp, stru
 	lock->fl.fl_flags &= ~FL_SLEEP;
 again:
 	/* Lock file against concurrent access */
-	down(&file->f_sema);
+	mutex_lock(&file->f_mutex);
 	/* Get existing block (in case client is busy-waiting) */
 	block = nlmsvc_lookup_block(file, lock);
 	if (block == NULL) {
@@ -392,10 +392,10 @@ again:
 
 	/* If we don't have a block, create and initialize it. Then
 	 * retry because we may have slept in kmalloc. */
-	/* We have to release f_sema as nlmsvc_create_block may try to
+	/* We have to release f_mutex as nlmsvc_create_block may try to
 	 * to claim it while doing host garbage collection */
 	if (newblock == NULL) {
-		up(&file->f_sema);
+		mutex_unlock(&file->f_mutex);
 		dprintk("lockd: blocking on this lock (allocating).\n");
 		if (!(newblock = nlmsvc_create_block(rqstp, file, lock, cookie)))
 			return nlm_lck_denied_nolocks;
@@ -405,7 +405,7 @@ again:
 	/* Append to list of blocked */
 	nlmsvc_insert_block(newblock, NLM_NEVER);
 out:
-	up(&file->f_sema);
+	mutex_unlock(&file->f_mutex);
 	nlmsvc_release_block(newblock);
 	nlmsvc_release_block(block);
 	dprintk("lockd: nlmsvc_lock returned %u\n", ret);
@@ -489,9 +489,9 @@ nlmsvc_cancel_blocked(struct nlm_file *f
 				(long long)lock->fl.fl_start,
 				(long long)lock->fl.fl_end);
 
-	down(&file->f_sema);
+	mutex_lock(&file->f_mutex);
 	block = nlmsvc_lookup_block(file, lock);
-	up(&file->f_sema);
+	mutex_unlock(&file->f_mutex);
 	if (block != NULL) {
 		status = nlmsvc_unlink_block(block);
 		nlmsvc_release_block(block);

diff .prev/fs/lockd/svcsubs.c ./fs/lockd/svcsubs.c
--- .prev/fs/lockd/svcsubs.c	2006-09-01 11:38:14.000000000 +1000
+++ ./fs/lockd/svcsubs.c	2006-09-01 18:55:56.000000000 +1000
@@ -106,7 +106,7 @@ nlm_lookup_file(struct svc_rqst *rqstp, 
 		goto out_unlock;
 
 	memcpy(&file->f_handle, f, sizeof(struct nfs_fh));
-	init_MUTEX(&file->f_sema);
+	mutex_init(&file->f_mutex);
 	INIT_HLIST_NODE(&file->f_list);
 	INIT_LIST_HEAD(&file->f_blocks);
 

diff .prev/include/linux/lockd/lockd.h ./include/linux/lockd/lockd.h
--- .prev/include/linux/lockd/lockd.h	2006-09-01 12:26:43.000000000 +1000
+++ ./include/linux/lockd/lockd.h	2006-09-01 18:50:32.000000000 +1000
@@ -111,7 +111,7 @@ struct nlm_file {
 	struct list_head	f_blocks;	/* blocked locks */
 	unsigned int		f_locks;	/* guesstimate # of locks */
 	unsigned int		f_count;	/* reference count */
-	struct semaphore	f_sema;		/* avoid concurrent access */
+	struct mutex		f_mutex;	/* avoid concurrent access */
 };
 
 /*

-- 
VGER BF report: H 2.88825e-13
