Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261513AbVCaPNt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261513AbVCaPNt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 10:13:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261494AbVCaPMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 10:12:30 -0500
Received: from mx2.elte.hu ([157.181.151.9]:22978 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261499AbVCaPKw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 10:10:52 -0500
Date: Thu, 31 Mar 2005 17:10:21 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Andrew Morton <akpm@osdl.org>, rlrevell@joe-job.com,
       linux-kernel@vger.kernel.org
Subject: Re: NFS client latencies
Message-ID: <20050331151021.GA5457@elte.hu>
References: <20050331065942.GA14952@elte.hu> <20050330231801.129b0715.akpm@osdl.org> <20050331073017.GA16577@elte.hu> <1112270304.10975.41.camel@lade.trondhjem.org> <1112272451.10975.72.camel@lade.trondhjem.org> <20050331135825.GA2214@elte.hu> <1112279522.20211.8.camel@lade.trondhjem.org> <20050331143930.GA4032@elte.hu> <1112280891.20211.29.camel@lade.trondhjem.org> <20050331145825.GA5107@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050331145825.GA5107@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> > The good news, though, is that because requests on the "commit" list 
> > do not remain locked for long without being removed from the list, you 
> > should rarely have to skip them. IOW restarting from the head of the 
> > list is pretty much the same as starting from where you left off.
> 
> as we've learned it through painful experience on the ext3 side, 
> restarting scans where 'skipping' has to be done is unhealthy.
> 
> would it be safe to collect locked entries into a separate, local 
> list, so that the restart would only see newly added entries? Then 
> once the moving of all entries has been done, all the locked entries 
> could be added back to the commit_list via one list_add. (can anything 
> happen to those locked entries that would break this method?)

i.e. like the patch below (compiles and is lightly tested). It's a 
pretty straightforward technique when dealing with latencies, and lets 
us sleep for sure. We dont have to know whether massive amounts of 
locked entries ever queue up or not.

(thanks go to Arjan for noticing that it has to be list_splice() not 
list_add() :-| )

	Ingo

--- linux/fs/nfs/pagelist.c.orig3	
+++ linux/fs/nfs/pagelist.c	
@@ -311,10 +311,12 @@ out:
  * You must be holding the inode's req_lock when calling this function
  */
 int
-nfs_scan_list(struct list_head *head, struct list_head *dst,
-	      unsigned long idx_start, unsigned int npages)
+nfs_scan_list(struct nfs_inode *nfsi, struct list_head *head,
+	      struct list_head *dst, unsigned long idx_start,
+	      unsigned int npages)
 {
-	struct list_head	*pos, *tmp;
+	LIST_HEAD(locked);
+	struct list_head	*pos;
 	struct nfs_page		*req;
 	unsigned long		idx_end;
 	int			res;
@@ -325,21 +327,22 @@ nfs_scan_list(struct list_head *head, st
 	else
 		idx_end = idx_start + npages - 1;
 
-	list_for_each_safe(pos, tmp, head) {
+	while (!list_empty(head)) {
 
+		pos = head->next;
 		req = nfs_list_entry(pos);
 
-		if (req->wb_index < idx_start)
-			continue;
-		if (req->wb_index > idx_end)
-			break;
-
-		if (!nfs_set_page_writeback_locked(req))
-			continue;
-		nfs_list_remove_request(req);
-		nfs_list_add_request(req, dst);
-		res++;
+		if (!nfs_set_page_writeback_locked(req)) {
+			list_del(pos);
+			list_add(&req->wb_list, &locked);
+		} else {
+			nfs_list_remove_request(req);
+			nfs_list_add_request(req, dst);
+			res++;
+		}
+		cond_resched_lock(&nfsi->req_lock);
 	}
+	list_splice(&locked, head);
 	return res;
 }
 
--- linux/fs/nfs/write.c.orig3	
+++ linux/fs/nfs/write.c	
@@ -569,7 +569,7 @@ nfs_scan_commit(struct inode *inode, str
 	int res = 0;
 
 	if (nfsi->ncommit != 0) {
-		res = nfs_scan_list(&nfsi->commit, dst, idx_start, npages);
+		res = nfs_scan_list(nfsi, &nfsi->commit, dst, idx_start, npages);
 		nfsi->ncommit -= res;
 		if ((nfsi->ncommit == 0) != list_empty(&nfsi->commit))
 			printk(KERN_ERR "NFS: desynchronized value of nfs_i.ncommit.\n");
--- linux/include/linux/nfs_page.h.orig3	
+++ linux/include/linux/nfs_page.h	
@@ -63,8 +63,8 @@ extern	void nfs_release_request(struct n
 
 extern  int nfs_scan_lock_dirty(struct nfs_inode *nfsi, struct list_head *dst,
 				unsigned long idx_start, unsigned int npages);
-extern	int nfs_scan_list(struct list_head *, struct list_head *,
-			  unsigned long, unsigned int);
+extern	int nfs_scan_list(struct nfs_inode *nfsi, struct list_head *,
+			  struct list_head *, unsigned long, unsigned int);
 extern	int nfs_coalesce_requests(struct list_head *, struct list_head *,
 				  unsigned int);
 extern  int nfs_wait_on_request(struct nfs_page *);
