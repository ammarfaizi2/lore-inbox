Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932099AbWC3IRn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbWC3IRn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 03:17:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbWC3IRn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 03:17:43 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:29779 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S932099AbWC3IRl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 03:17:41 -0500
Message-Id: <20060330081730.068972000@localhost.localdomain>
References: <20060330081605.085383000@localhost.localdomain>
Date: Thu, 30 Mar 2006 16:16:08 +0800
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Karsten Keil <kkeil@suse.de>,
       Jan Harkes <jaharkes@cs.cmu.edu>, Jan Kara <jack@suse.cz>,
       David Woodhouse <dwmw2@infradead.org>,
       Sridhar Samudrala <sri@us.ibm.com>,
       Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 3/8] use list_add_tail() instead of list_add()
Content-Disposition: inline; filename=list-add-tail.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch converts list_add(A, B.prev) to list_add_tail(A, &B)
for readability.

CC: Karsten Keil <kkeil@suse.de>
CC: Jan Harkes <jaharkes@cs.cmu.edu>
CC: Jan Kara <jack@suse.cz>
CC: David Woodhouse <dwmw2@infradead.org>
CC: Sridhar Samudrala <sri@us.ibm.com>
Signed-off-by: Akinobu Mita <mita@miraclelinux.com>

 drivers/isdn/capi/capi.c |    2 +-
 fs/coda/psdev.c          |    2 +-
 fs/coda/upcall.c         |    2 +-
 fs/dcache.c              |    2 +-
 fs/dquot.c               |    4 ++--
 fs/jffs2/compr.c         |    4 ++--
 net/sctp/outqueue.c      |    2 +-
 7 files changed, 9 insertions(+), 9 deletions(-)

Index: 2.6-git/drivers/isdn/capi/capi.c
===================================================================
--- 2.6-git.orig/drivers/isdn/capi/capi.c
+++ 2.6-git/drivers/isdn/capi/capi.c
@@ -238,7 +238,7 @@ static struct capiminor *capiminor_alloc
 		
 		if (minor < capi_ttyminors) {
 			mp->minor = minor;
-			list_add(&mp->list, p->list.prev);
+			list_add_tail(&mp->list, &p->list);
 		}
 	}
 		write_unlock_irqrestore(&capiminor_list_lock, flags);
Index: 2.6-git/fs/coda/psdev.c
===================================================================
--- 2.6-git.orig/fs/coda/psdev.c
+++ 2.6-git/fs/coda/psdev.c
@@ -259,7 +259,7 @@ static ssize_t coda_psdev_read(struct fi
 	/* If request was not a signal, enqueue and don't free */
 	if (!(req->uc_flags & REQ_ASYNC)) {
 		req->uc_flags |= REQ_READ;
-		list_add(&(req->uc_chain), vcp->vc_processing.prev);
+		list_add_tail(&(req->uc_chain), &vcp->vc_processing);
 		goto out;
 	}
 
Index: 2.6-git/fs/coda/upcall.c
===================================================================
--- 2.6-git.orig/fs/coda/upcall.c
+++ 2.6-git/fs/coda/upcall.c
@@ -725,7 +725,7 @@ static int coda_upcall(struct coda_sb_in
 	((union inputArgs *)buffer)->ih.unique = req->uc_unique;
 
 	/* Append msg to pending queue and poke Venus. */
-	list_add(&(req->uc_chain), vcommp->vc_pending.prev);
+	list_add_tail(&(req->uc_chain), &vcommp->vc_pending);
         
 	wake_up_interruptible(&vcommp->vc_waitq);
 	/* We can be interrupted while we wait for Venus to process
Index: 2.6-git/fs/dcache.c
===================================================================
--- 2.6-git.orig/fs/dcache.c
+++ 2.6-git/fs/dcache.c
@@ -584,7 +584,7 @@ resume:
 		 * of the unused list for prune_dcache
 		 */
 		if (!atomic_read(&dentry->d_count)) {
-			list_add(&dentry->d_lru, dentry_unused.prev);
+			list_add_tail(&dentry->d_lru, &dentry_unused);
 			dentry_stat.nr_unused++;
 			found++;
 		}
Index: 2.6-git/fs/dquot.c
===================================================================
--- 2.6-git.orig/fs/dquot.c
+++ 2.6-git/fs/dquot.c
@@ -250,7 +250,7 @@ static inline struct dquot *find_dquot(u
 /* Add a dquot to the tail of the free list */
 static inline void put_dquot_last(struct dquot *dquot)
 {
-	list_add(&dquot->dq_free, free_dquots.prev);
+	list_add_tail(&dquot->dq_free, &free_dquots);
 	dqstats.free_dquots++;
 }
 
@@ -266,7 +266,7 @@ static inline void put_inuse(struct dquo
 {
 	/* We add to the back of inuse list so we don't have to restart
 	 * when traversing this list and we block */
-	list_add(&dquot->dq_inuse, inuse_list.prev);
+	list_add_tail(&dquot->dq_inuse, &inuse_list);
 	dqstats.allocated_dquots++;
 }
 
Index: 2.6-git/fs/jffs2/compr.c
===================================================================
--- 2.6-git.orig/fs/jffs2/compr.c
+++ 2.6-git/fs/jffs2/compr.c
@@ -231,7 +231,7 @@ int jffs2_register_compressor(struct jff
 
         list_for_each_entry(this, &jffs2_compressor_list, list) {
                 if (this->priority < comp->priority) {
-                        list_add(&comp->list, this->list.prev);
+                        list_add_tail(&comp->list, &this->list);
                         goto out;
                 }
         }
@@ -394,7 +394,7 @@ reinsert:
         list_del(&comp->list);
         list_for_each_entry(this, &jffs2_compressor_list, list) {
                 if (this->priority < comp->priority) {
-                        list_add(&comp->list, this->list.prev);
+                        list_add_tail(&comp->list, &this->list);
                         spin_unlock(&jffs2_compressor_list_lock);
                         return 0;
                 }
Index: 2.6-git/net/sctp/outqueue.c
===================================================================
--- 2.6-git.orig/net/sctp/outqueue.c
+++ 2.6-git/net/sctp/outqueue.c
@@ -370,7 +370,7 @@ static void sctp_insert_list(struct list
 		lchunk = list_entry(pos, struct sctp_chunk, transmitted_list);
 		ltsn = ntohl(lchunk->subh.data_hdr->tsn);
 		if (TSN_lt(ntsn, ltsn)) {
-			list_add(new, pos->prev);
+			list_add_tail(new, pos);
 			done = 1;
 			break;
 		}

--
