Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932079AbWDXIiI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbWDXIiI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 04:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932084AbWDXIiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 04:38:07 -0400
Received: from ns.miraclelinux.com ([219.118.163.66]:26469 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S932079AbWDXIiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 04:38:06 -0400
Date: Mon, 24 Apr 2006 16:38:04 +0800
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@suse.de>, akpm@osdl.org
Subject: [PATCH] iosched: use hlist for request hashtable
Message-ID: <20060424083804.GB6227@miraclelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use hlist instead of list_head for request hashtable in deadline-iosched
and as-iosched. It also can remove the flag to know hashed or unhashed.

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
CC: Jens Axboe <axboe@suse.de>

 block/as-iosched.c       |   45 +++++++++++++++++++--------------------------
 block/deadline-iosched.c |   39 ++++++++++++++++-----------------------
 2 files changed, 35 insertions(+), 49 deletions(-)

Index: 2.6-git/block/deadline-iosched.c
===================================================================
--- 2.6-git.orig/block/deadline-iosched.c
+++ 2.6-git/block/deadline-iosched.c
@@ -30,8 +30,7 @@ static const int deadline_hash_shift = 5
 #define DL_HASH_FN(sec)		(hash_long(DL_HASH_BLOCK((sec)), deadline_hash_shift))
 #define DL_HASH_ENTRIES		(1 << deadline_hash_shift)
 #define rq_hash_key(rq)		((rq)->sector + (rq)->nr_sectors)
-#define list_entry_hash(ptr)	list_entry((ptr), struct deadline_rq, hash)
-#define ON_HASH(drq)		(drq)->on_hash
+#define ON_HASH(drq)		(!hlist_unhashed(&(drq)->hash))
 
 struct deadline_data {
 	/*
@@ -48,7 +47,7 @@ struct deadline_data {
 	 * next in sort order. read, write or both are NULL
 	 */
 	struct deadline_rq *next_drq[2];
-	struct list_head *hash;		/* request hash */
+	struct hlist_head *hash;	/* request hash */
 	unsigned int batching;		/* number of sequential requests made */
 	sector_t last_sector;		/* head position */
 	unsigned int starved;		/* times reads have starved writes */
@@ -79,8 +78,7 @@ struct deadline_rq {
 	/*
 	 * request hash, key is the ending offset (for back merge lookup)
 	 */
-	struct list_head hash;
-	char on_hash;
+	struct hlist_node hash;
 
 	/*
 	 * expire fifo
@@ -100,8 +98,7 @@ static kmem_cache_t *drq_pool;
  */
 static inline void __deadline_del_drq_hash(struct deadline_rq *drq)
 {
-	drq->on_hash = 0;
-	list_del_init(&drq->hash);
+	hlist_del_init(&drq->hash);
 }
 
 static inline void deadline_del_drq_hash(struct deadline_rq *drq)
@@ -117,8 +114,7 @@ deadline_add_drq_hash(struct deadline_da
 
 	BUG_ON(ON_HASH(drq));
 
-	drq->on_hash = 1;
-	list_add(&drq->hash, &dd->hash[DL_HASH_FN(rq_hash_key(rq))]);
+	hlist_add_head(&drq->hash, &dd->hash[DL_HASH_FN(rq_hash_key(rq))]);
 }
 
 /*
@@ -128,26 +124,24 @@ static inline void
 deadline_hot_drq_hash(struct deadline_data *dd, struct deadline_rq *drq)
 {
 	struct request *rq = drq->request;
-	struct list_head *head = &dd->hash[DL_HASH_FN(rq_hash_key(rq))];
+	struct hlist_head *head = &dd->hash[DL_HASH_FN(rq_hash_key(rq))];
 
-	if (ON_HASH(drq) && drq->hash.prev != head) {
-		list_del(&drq->hash);
-		list_add(&drq->hash, head);
+	if (ON_HASH(drq) && &drq->hash != head->first) {
+		hlist_del(&drq->hash);
+		hlist_add_head(&drq->hash, head);
 	}
 }
 
 static struct request *
 deadline_find_drq_hash(struct deadline_data *dd, sector_t offset)
 {
-	struct list_head *hash_list = &dd->hash[DL_HASH_FN(offset)];
-	struct list_head *entry, *next = hash_list->next;
+	struct hlist_head *hash_list = &dd->hash[DL_HASH_FN(offset)];
+	struct hlist_node *entry, *next;
+	struct deadline_rq *drq;
 
-	while ((entry = next) != hash_list) {
-		struct deadline_rq *drq = list_entry_hash(entry);
+	hlist_for_each_entry_safe(drq, entry, next, hash_list, hash) {
 		struct request *__rq = drq->request;
 
-		next = entry->next;
-		
 		BUG_ON(!ON_HASH(drq));
 
 		if (!rq_mergeable(__rq)) {
@@ -626,7 +620,7 @@ static int deadline_init_queue(request_q
 		return -ENOMEM;
 	memset(dd, 0, sizeof(*dd));
 
-	dd->hash = kmalloc_node(sizeof(struct list_head)*DL_HASH_ENTRIES,
+	dd->hash = kmalloc_node(sizeof(struct hlist_head)*DL_HASH_ENTRIES,
 				GFP_KERNEL, q->node);
 	if (!dd->hash) {
 		kfree(dd);
@@ -642,7 +636,7 @@ static int deadline_init_queue(request_q
 	}
 
 	for (i = 0; i < DL_HASH_ENTRIES; i++)
-		INIT_LIST_HEAD(&dd->hash[i]);
+		INIT_HLIST_HEAD(&dd->hash[i]);
 
 	INIT_LIST_HEAD(&dd->fifo_list[READ]);
 	INIT_LIST_HEAD(&dd->fifo_list[WRITE]);
@@ -679,8 +673,7 @@ deadline_set_request(request_queue_t *q,
 		RB_CLEAR(&drq->rb_node);
 		drq->request = rq;
 
-		INIT_LIST_HEAD(&drq->hash);
-		drq->on_hash = 0;
+		INIT_HLIST_NODE(&drq->hash);
 
 		INIT_LIST_HEAD(&drq->fifo);
 
Index: 2.6-git/block/as-iosched.c
===================================================================
--- 2.6-git.orig/block/as-iosched.c
+++ 2.6-git/block/as-iosched.c
@@ -96,7 +96,7 @@ struct as_data {
 
 	struct as_rq *next_arq[2];	/* next in sort order */
 	sector_t last_sector[2];	/* last REQ_SYNC & REQ_ASYNC sectors */
-	struct list_head *hash;		/* request hash */
+	struct hlist_head *hash;	/* request hash */
 
 	unsigned long exit_prob;	/* probability a task will exit while
 					   being waited on */
@@ -165,8 +165,7 @@ struct as_rq {
 	/*
 	 * request hash, key is the ending offset (for back merge lookup)
 	 */
-	struct list_head hash;
-	unsigned int on_hash;
+	struct hlist_node hash;
 
 	/*
 	 * expire fifo
@@ -282,17 +281,15 @@ static const int as_hash_shift = 6;
 #define AS_HASH_FN(sec)		(hash_long(AS_HASH_BLOCK((sec)), as_hash_shift))
 #define AS_HASH_ENTRIES		(1 << as_hash_shift)
 #define rq_hash_key(rq)		((rq)->sector + (rq)->nr_sectors)
-#define list_entry_hash(ptr)	list_entry((ptr), struct as_rq, hash)
 
 static inline void __as_del_arq_hash(struct as_rq *arq)
 {
-	arq->on_hash = 0;
-	list_del_init(&arq->hash);
+	hlist_del_init(&arq->hash);
 }
 
 static inline void as_del_arq_hash(struct as_rq *arq)
 {
-	if (arq->on_hash)
+	if (!hlist_unhashed(&arq->hash))
 		__as_del_arq_hash(arq);
 }
 
@@ -300,10 +297,9 @@ static void as_add_arq_hash(struct as_da
 {
 	struct request *rq = arq->request;
 
-	BUG_ON(arq->on_hash);
+	BUG_ON(!hlist_unhashed(&arq->hash));
 
-	arq->on_hash = 1;
-	list_add(&arq->hash, &ad->hash[AS_HASH_FN(rq_hash_key(rq))]);
+	hlist_add_head(&arq->hash, &ad->hash[AS_HASH_FN(rq_hash_key(rq))]);
 }
 
 /*
@@ -312,31 +308,29 @@ static void as_add_arq_hash(struct as_da
 static inline void as_hot_arq_hash(struct as_data *ad, struct as_rq *arq)
 {
 	struct request *rq = arq->request;
-	struct list_head *head = &ad->hash[AS_HASH_FN(rq_hash_key(rq))];
+	struct hlist_head *head = &ad->hash[AS_HASH_FN(rq_hash_key(rq))];
 
-	if (!arq->on_hash) {
+	if (hlist_unhashed(&arq->hash)) {
 		WARN_ON(1);
 		return;
 	}
 
-	if (arq->hash.prev != head) {
-		list_del(&arq->hash);
-		list_add(&arq->hash, head);
+	if (&arq->hash != head->first) {
+		hlist_del(&arq->hash);
+		hlist_add_head(&arq->hash, head);
 	}
 }
 
 static struct request *as_find_arq_hash(struct as_data *ad, sector_t offset)
 {
-	struct list_head *hash_list = &ad->hash[AS_HASH_FN(offset)];
-	struct list_head *entry, *next = hash_list->next;
+	struct hlist_head *hash_list = &ad->hash[AS_HASH_FN(offset)];
+	struct hlist_node *entry, *next;
+	struct as_rq *arq;
 
-	while ((entry = next) != hash_list) {
-		struct as_rq *arq = list_entry_hash(entry);
+	hlist_for_each_entry_safe(arq, entry, next, hash_list, hash) {
 		struct request *__rq = arq->request;
 
-		next = entry->next;
-
-		BUG_ON(!arq->on_hash);
+		BUG_ON(hlist_unhashed(&arq->hash));
 
 		if (!rq_mergeable(__rq)) {
 			as_del_arq_hash(arq);
@@ -1602,8 +1596,7 @@ static int as_set_request(request_queue_
 		arq->request = rq;
 		arq->state = AS_RQ_PRESCHED;
 		arq->io_context = NULL;
-		INIT_LIST_HEAD(&arq->hash);
-		arq->on_hash = 0;
+		INIT_HLIST_NODE(&arq->hash);
 		INIT_LIST_HEAD(&arq->fifo);
 		rq->elevator_private = arq;
 		return 0;
@@ -1663,7 +1656,7 @@ static int as_init_queue(request_queue_t
 
 	ad->q = q; /* Identify what queue the data belongs to */
 
-	ad->hash = kmalloc_node(sizeof(struct list_head)*AS_HASH_ENTRIES,
+	ad->hash = kmalloc_node(sizeof(struct hlist_head)*AS_HASH_ENTRIES,
 				GFP_KERNEL, q->node);
 	if (!ad->hash) {
 		kfree(ad);
@@ -1685,7 +1678,7 @@ static int as_init_queue(request_queue_t
 	INIT_WORK(&ad->antic_work, as_work_handler, q);
 
 	for (i = 0; i < AS_HASH_ENTRIES; i++)
-		INIT_LIST_HEAD(&ad->hash[i]);
+		INIT_HLIST_HEAD(&ad->hash[i]);
 
 	INIT_LIST_HEAD(&ad->fifo_list[REQ_SYNC]);
 	INIT_LIST_HEAD(&ad->fifo_list[REQ_ASYNC]);
