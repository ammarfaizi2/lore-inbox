Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264524AbUGIHrY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264524AbUGIHrY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 03:47:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264540AbUGIHrY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 03:47:24 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:6591 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264524AbUGIHrS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 03:47:18 -0400
Date: Fri, 9 Jul 2004 09:46:56 +0200
From: Jens Axboe <axboe@suse.de>
To: Niels Elgaard Larsen <elgaard@agol.dk>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       nickpiggin@yahoo.com.au
Subject: Re: Kernel bug , lock_page, badblocks
Message-ID: <20040709074655.GA10114@suse.de>
References: <40ED384B.3010005@agol.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40ED384B.3010005@agol.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 08 2004, Niels Elgaard Larsen wrote:
> On Linux brodtgaard  2.6.7 #1 Thu Jul 8 00:32:54 CEST 2004 i686 GNU/Linux
> 
> I got the following when running badblocks on /dev/hdb4, hdb is a Maxtor 
> IDE disk which does have bad blocks.
> After this the badblocks process hanged in D-state in lock_page() with 
> load 1.0
> 
> Jul  8 04:55:52 brodtgaard vmunix: kernel BUG at 
> drivers/block/as-iosched.c:312!

Looks pretty bad, the hash list is corrupted. Is it easily reproducable?
If so, can you try with this applied and see if it catches anything?

--- /opt/kernel/linux-2.6.7-mm6/drivers/block/as-iosched.c	2004-06-16 07:18:38.000000000 +0200
+++ linux-2.6.7-mm6/drivers/block/as-iosched.c	2004-07-09 09:44:56.304018000 +0200
@@ -166,7 +166,6 @@
 	 * request hash, key is the ending offset (for back merge lookup)
 	 */
 	struct list_head hash;
-	unsigned int on_hash;
 
 	/*
 	 * expire fifo
@@ -249,16 +248,9 @@
 #define rq_hash_key(rq)		((rq)->sector + (rq)->nr_sectors)
 #define list_entry_hash(ptr)	list_entry((ptr), struct as_rq, hash)
 
-static inline void __as_del_arq_hash(struct as_rq *arq)
-{
-	arq->on_hash = 0;
-	list_del_init(&arq->hash);
-}
-
 static inline void as_del_arq_hash(struct as_rq *arq)
 {
-	if (arq->on_hash)
-		__as_del_arq_hash(arq);
+	list_del_init(&arq->hash);
 }
 
 static void as_remove_merge_hints(request_queue_t *q, struct as_rq *arq)
@@ -273,9 +265,8 @@
 {
 	struct request *rq = arq->request;
 
-	BUG_ON(arq->on_hash);
+	BUG_ON(!list_empty(&arq->hash));
 
-	arq->on_hash = 1;
 	list_add(&arq->hash, &ad->hash[AS_HASH_FN(rq_hash_key(rq))]);
 }
 
@@ -287,7 +278,7 @@
 	struct request *rq = arq->request;
 	struct list_head *head = &ad->hash[AS_HASH_FN(rq_hash_key(rq))];
 
-	if (!arq->on_hash) {
+	if (list_empty(&arq->hash)) {
 		WARN_ON(1);
 		return;
 	}
@@ -309,8 +300,6 @@
 
 		next = entry->next;
 
-		BUG_ON(!arq->on_hash);
-
 		if (!rq_mergeable(__rq)) {
 			as_remove_merge_hints(ad->q, arq);
 			continue;
@@ -1693,8 +1682,7 @@
 		 */
 	}
 
-	if (arq->on_hash)
-		q->last_merge = req;
+	q->last_merge = req;
 }
 
 static void
@@ -1801,6 +1789,7 @@
 		WARN_ON(1);
 	}
 
+	BUG_ON(!list_empty(&arq->hash));
 	mempool_free(arq, ad->arq_pool);
 	rq->elevator_private = NULL;
 }
@@ -1817,7 +1806,6 @@
 		arq->state = AS_RQ_PRESCHED;
 		arq->io_context = NULL;
 		INIT_LIST_HEAD(&arq->hash);
-		arq->on_hash = 0;
 		INIT_LIST_HEAD(&arq->fifo);
 		rq->elevator_private = arq;
 		return 0;

-- 
Jens Axboe

