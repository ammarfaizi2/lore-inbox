Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751548AbWBMDZw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751548AbWBMDZw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 22:25:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751534AbWBMDZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 22:25:52 -0500
Received: from mx2.netapp.com ([216.240.18.37]:7479 "EHLO mx2.netapp.com")
	by vger.kernel.org with ESMTP id S1751096AbWBMDZv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 22:25:51 -0500
X-IronPort-AV: i="4.02,105,1139212800"; 
   d="scan'208"; a="358207472:sNHT24217572"
Subject: [PATCH] NLM: Fix the NLM_GRANTED callback checks
From: Trond Myklebust <Trond.Myklebust@netapp.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Network Appliance, Inc
Date: Sun, 12 Feb 2006 22:25:48 -0500
Message-Id: <1139801149.7916.11.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
X-OriginalArrivalTime: 13 Feb 2006 03:25:50.0784 (UTC) FILETIME=[30509400:01C6304D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently when the NLM_GRANTED callback comes in, lockd walks the list of
blocked locks in search of a match to the lock that the NLM server has
granted. Although it checks the lock pid, start and end, it fails to check
the filehandle and the server address.

Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---

 fs/lockd/clntlock.c         |   27 +++++++++++++++++----------
 fs/lockd/svc4proc.c         |    2 +-
 fs/lockd/svcproc.c          |    2 +-
 include/linux/lockd/lockd.h |    6 +++---
 4 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/fs/lockd/clntlock.c b/fs/lockd/clntlock.c
index 3eaf6e7..da6354b 100644
--- a/fs/lockd/clntlock.c
+++ b/fs/lockd/clntlock.c
@@ -111,9 +111,10 @@ long nlmclnt_block(struct nlm_rqst *req,
 /*
  * The server lockd has called us back to tell us the lock was granted
  */
-u32
-nlmclnt_grant(struct nlm_lock *lock)
+u32 nlmclnt_grant(const struct sockaddr_in *addr, const struct nlm_lock *lock)
 {
+	const struct file_lock *fl = &lock->fl;
+	const struct nfs_fh *fh = &lock->fh;
 	struct nlm_wait	*block;
 	u32 res = nlm_lck_denied;
 
@@ -122,14 +123,20 @@ nlmclnt_grant(struct nlm_lock *lock)
 	 * Warning: must not use cookie to match it!
 	 */
 	list_for_each_entry(block, &nlm_blocked, b_list) {
-		if (nlm_compare_locks(block->b_lock, &lock->fl)) {
-			/* Alright, we found a lock. Set the return status
-			 * and wake up the caller
-			 */
-			block->b_status = NLM_LCK_GRANTED;
-			wake_up(&block->b_wait);
-			res = nlm_granted;
-		}
+		struct file_lock *fl_blocked = block->b_lock;
+
+		if (!nlm_compare_locks(fl_blocked, fl))
+			continue;
+		if (!nlm_cmp_addr(&block->b_host->h_addr, addr))
+			continue;
+		if (nfs_compare_fh(NFS_FH(fl_blocked->fl_file->f_dentry->d_inode) ,fh) != 0)
+			continue;
+		/* Alright, we found a lock. Set the return status
+		 * and wake up the caller
+		 */
+		block->b_status = NLM_LCK_GRANTED;
+		wake_up(&block->b_wait);
+		res = nlm_granted;
 	}
 	return res;
 }
diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index 4063095..b10f913 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -228,7 +228,7 @@ nlm4svc_proc_granted(struct svc_rqst *rq
 	resp->cookie = argp->cookie;
 
 	dprintk("lockd: GRANTED       called\n");
-	resp->status = nlmclnt_grant(&argp->lock);
+	resp->status = nlmclnt_grant(&rqstp->rq_addr, &argp->lock);
 	dprintk("lockd: GRANTED       status %d\n", ntohl(resp->status));
 	return rpc_success;
 }
diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
index 3bc437e..35681d9 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -256,7 +256,7 @@ nlmsvc_proc_granted(struct svc_rqst *rqs
 	resp->cookie = argp->cookie;
 
 	dprintk("lockd: GRANTED       called\n");
-	resp->status = nlmclnt_grant(&argp->lock);
+	resp->status = nlmclnt_grant(&rqstp->rq_addr, &argp->lock);
 	dprintk("lockd: GRANTED       status %d\n", ntohl(resp->status));
 	return rpc_success;
 }
diff --git a/include/linux/lockd/lockd.h b/include/linux/lockd/lockd.h
index 920766c..ef21ed2 100644
--- a/include/linux/lockd/lockd.h
+++ b/include/linux/lockd/lockd.h
@@ -149,7 +149,7 @@ struct nlm_rqst * nlmclnt_alloc_call(voi
 int		  nlmclnt_prepare_block(struct nlm_rqst *req, struct nlm_host *host, struct file_lock *fl);
 void		  nlmclnt_finish_block(struct nlm_rqst *req);
 long		  nlmclnt_block(struct nlm_rqst *req, long timeout);
-u32		  nlmclnt_grant(struct nlm_lock *);
+u32		  nlmclnt_grant(const struct sockaddr_in *addr, const struct nlm_lock *);
 void		  nlmclnt_recovery(struct nlm_host *, u32);
 int		  nlmclnt_reclaim(struct nlm_host *, struct file_lock *);
 int		  nlmclnt_setgrantargs(struct nlm_rqst *, struct nlm_lock *);
@@ -204,7 +204,7 @@ nlmsvc_file_inode(struct nlm_file *file)
  * Compare two host addresses (needs modifying for ipv6)
  */
 static __inline__ int
-nlm_cmp_addr(struct sockaddr_in *sin1, struct sockaddr_in *sin2)
+nlm_cmp_addr(const struct sockaddr_in *sin1, const struct sockaddr_in *sin2)
 {
 	return sin1->sin_addr.s_addr == sin2->sin_addr.s_addr;
 }
@@ -214,7 +214,7 @@ nlm_cmp_addr(struct sockaddr_in *sin1, s
  * When the second lock is of type F_UNLCK, this acts like a wildcard.
  */
 static __inline__ int
-nlm_compare_locks(struct file_lock *fl1, struct file_lock *fl2)
+nlm_compare_locks(const struct file_lock *fl1, const struct file_lock *fl2)
 {
 	return	fl1->fl_pid   == fl2->fl_pid
 	     && fl1->fl_start == fl2->fl_start
