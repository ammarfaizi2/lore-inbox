Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750807AbWCaD6Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbWCaD6Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 22:58:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbWCaD6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 22:58:24 -0500
Received: from xproxy.gmail.com ([66.249.82.199]:30608 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750807AbWCaD6X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 22:58:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:references;
        b=AIbCEB/xu1l533DDeY6bUJ1kcNAmsTqZV5Hw1AZen85uI4cuZYusQ8jDXfO48OVtRNpla4c1wjRHCykMovbx2tCvmBYDlCsD281xhfOMI1HZHudD9u26v7Nu/M/YxN1Jl+OOBEg2rYG6Y64pEiDmmu2q29LtM+Mm2ifbHDHiMAM=
Message-ID: <4745278c0603301958o4c2ed282x3513fdb459d8ec7c@mail.gmail.com>
Date: Thu, 30 Mar 2006 22:58:20 -0500
From: "Vishal Patil" <vishpat@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: CSCAN I/O scheduler for 2.6.10 kernel
In-Reply-To: <4745278c0603301955w26fea42eid6bcab91c573eaa3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_15256_5655831.1143777500638"
References: <4745278c0603301955w26fea42eid6bcab91c573eaa3@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_15256_5655831.1143777500638
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Maintain two queues which will be sorted in ascending order using Red
Black Trees. When a disk request arrives and if the block number it
refers to is greater than the block number of the current request
being served add (merge) it to the first sorted queue or else add
(merge) it to the second sorted queue. Keep on servicing the requests
from the first request queue until it is empty after which switch over
to the second queue and now reverse the roles of the two queues.
Simple and Sweet. Many thanks for the awesome block I/O layer in the
2.6 kernel.

- Vishal

PS: Please note that I have not subscribed to the LKML. For comments
please reply back to this email.

--
Every passing minute is another chance to turn it all around.

------=_Part_15256_5655831.1143777500638
Content-Type: application/octet-stream; name=linux-2.6.10-cscan.patch
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_elfyvztm
Content-Disposition: attachment; filename="linux-2.6.10-cscan.patch"

diff -urN linux-2.6.10/drivers/block/cscan.c linux-2.6.10-cscan/drivers/block/cscan.c
--- linux-2.6.10/drivers/block/cscan.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.10-cscan/drivers/block/cscan.c	2006-03-30 21:34:27.000000000 -0500
@@ -0,0 +1,512 @@
+/*
+ * CSCAN scheduler for 2.6 kernel 
+ */
+#include <linux/kernel.h>
+#include <linux/fs.h>
+#include <linux/blkdev.h>
+#include <linux/elevator.h>
+#include <linux/bio.h>
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/compiler.h>
+#include <linux/rbtree.h>
+#include <linux/hash.h>
+#include <asm/uaccess.h>
+
+static const int cscan_hash_shift = 5;
+#define DL_HASH_BLOCK(sec)      ((sec) >> 3)
+#define DL_HASH_FN(sec)         \
+        (hash_long(DL_HASH_BLOCK((sec)),cscan_hash_shift))
+#define DL_HASH_ENTRIES         (1 << cscan_hash_shift)
+#define rq_hash_key(rq)         ((rq)->sector + (rq)->nr_sectors)
+#define list_entry_hash(ptr)    list_entry((ptr), struct CSCAN_request, hash)
+#define ON_HASH(crq)            (crq)->on_hash
+
+
+#define RB_NONE         (2)
+#define RB_EMPTY(root)  ((root)->rb_node == NULL)
+#define ON_RB(node)     ((node)->rb_color != RB_NONE)
+#define RB_CLEAR(node)  ((node)->rb_color = RB_NONE)
+#define rq_rb_key(rq)   (rq)->sector
+
+struct CSCAN_data {
+        unsigned int curr;
+        struct rb_root sort_list[2]; /* Used to keep a sorted list of requests*/
+        unsigned int count[2];
+        
+        struct list_head * dispatch;
+        struct list_head * hash;
+        
+        mempool_t * crq_pool;          /* Pool of requests*/
+
+        sector_t last_sector;
+};
+
+/*
+ *      Per-request data       
+ */
+struct CSCAN_request {
+        struct rb_node rb_node;
+        sector_t rb_key;
+        struct request * request;
+        
+        struct list_head hash;
+        char on_hash;
+        
+        unsigned char queue_id; /* Which queue is this request on */
+};
+
+
+/*
+ *      Searching/Sorting routines
+ */
+static struct CSCAN_request *
+__rb_insert_request(struct rb_root * root, struct CSCAN_request * crq) {
+        struct rb_node **p = &root->rb_node;
+        struct rb_node *parent = NULL;
+        struct CSCAN_request * __crq;
+        
+         while(*p) {
+                parent = *p;
+                __crq = rb_entry(parent,struct CSCAN_request,rb_node);
+
+                if(crq->rb_key < __crq->rb_key) {
+                        p = &(*p)->rb_left;
+                } else if(crq->rb_key > __crq->rb_key) {
+                        p = &(*p)->rb_right;
+                } else {
+                        return __crq;
+                }
+        }
+        rb_link_node(&crq->rb_node,parent,p);
+        return NULL;
+} 
+
+static inline struct
+CSCAN_request * rb_insert_request(struct rb_root * root, 
+                                     struct CSCAN_request * crq)
+{
+        struct CSCAN_request * ret;
+        if((ret = __rb_insert_request(root,crq)))
+                goto out;
+        rb_insert_color(&crq->rb_node,root);
+out:
+        return ret;
+}
+
+static inline struct
+CSCAN_request * rb_find_request(struct rb_root * root, long key) {
+        struct rb_node * n = root->rb_node;
+        struct CSCAN_request * crq;
+
+        while(n) 
+        {
+                crq = rb_entry(n,struct CSCAN_request,rb_node);
+
+                if (key > crq->rb_key) {
+                        n = n->rb_right;
+                } else if (key < crq->rb_key) {
+                        n = n->rb_left;
+                } else {
+                        return crq;
+                }
+        }
+        return NULL;
+}
+
+static struct request *
+cscan_find_crq_rb(struct CSCAN_data * cd, sector_t sector) {
+        struct CSCAN_request * crq;
+        int i = 0;
+ 
+        for(i=0;i<2;i++) {
+                crq = rb_find_request(&cd->sort_list[i],sector);
+                if(crq)
+                        return crq->request;
+        }
+
+        return NULL;
+}
+
+static inline void
+cscan_del_crq_rb(struct CSCAN_data *cd, struct CSCAN_request *crq)
+{
+        rb_erase(&crq->rb_node, &cd->sort_list[crq->queue_id]);
+        RB_CLEAR(&crq->rb_node);
+        cd->count[crq->queue_id]--;
+}
+
+static inline void
+cscan_add_crq_rb(struct CSCAN_data *cd, struct CSCAN_request *crq)
+{
+        rb_insert_request(&cd->sort_list[crq->queue_id],crq);
+        cd->count[crq->queue_id]++;
+
+}
+static inline void
+cscan_del_crq_hash(struct CSCAN_request * crq) {
+        if(ON_HASH(crq)) {
+                crq->on_hash = 0;
+                list_del_init(&crq->hash);
+        }
+}
+
+static struct request * 
+cscan_find_rq_hash(struct CSCAN_data *cd, sector_t sector) {
+        struct list_head *hash_list = &cd->hash[DL_HASH_FN(sector)];
+        struct list_head *entry, *next = hash_list->next;
+
+        while ((entry = next) != hash_list) {
+                struct CSCAN_request *crq = list_entry_hash(entry);
+                struct request *__rq = crq->request;
+
+                next = entry->next;
+
+                BUG_ON(!ON_HASH(crq));
+
+                if (!rq_mergeable(__rq)) {
+                        cscan_del_crq_hash(crq);
+                        continue;
+                }
+
+                if (rq_hash_key(__rq) == sector)
+                        return __rq;
+        }
+
+        return NULL;
+
+
+}
+
+static kmem_cache_t * crq_pool;
+
+
+
+static inline void
+cscan_add_crq_hash(struct CSCAN_data * cd, struct CSCAN_request * crq) {
+        struct request *rq = crq->request;
+
+        BUG_ON(ON_HASH(crq));
+        crq->on_hash = 1;
+        list_add(&crq->hash, &cd->hash[DL_HASH_FN(rq_hash_key(rq))]);
+}
+
+static void
+cscan_remove_request(struct CSCAN_data *cd, struct CSCAN_request * crq,
+                                int queue) {
+        struct request * rq;
+        
+        cscan_del_crq_hash(crq);
+        rq = crq->request;
+        list_add_tail(&rq->queuelist, cd->dispatch);
+        cscan_del_crq_rb(cd,crq);
+}
+
+static int
+cscan_move_requests_to_dispatch_queue(struct CSCAN_data * cd,int queue) {
+        struct rb_node * node;
+        struct CSCAN_request * crq;
+        int ret = 0;
+        
+        node = rb_first(&cd->sort_list[queue]);
+                
+        while(node) {
+                crq  = rb_entry(node,struct CSCAN_request,rb_node);
+                node = rb_next(node);
+                cscan_remove_request(cd,crq,queue); 
+                ret = 1;
+        }
+
+        return ret;
+}
+
+static int 
+cscan_dispatch_requests(struct CSCAN_data * cd) {
+        int ret1,ret2;
+        
+        ret1 = cscan_move_requests_to_dispatch_queue(cd,cd->curr);
+        ret2 = cscan_move_requests_to_dispatch_queue(cd,1 - cd->curr);
+        
+        cd->curr = 1 - cd->curr;
+        // Return 1 if you have dispatched requests
+        return (ret1 || ret2);      
+}
+
+static void 
+cscan_add_request(struct request_queue *q, struct request *rq) {
+        struct CSCAN_data * cd = q->elevator->elevator_data;
+        struct CSCAN_request * crq = (struct CSCAN_request*)rq->elevator_private;
+
+        crq->rb_key = rq_rb_key(crq->request);
+        
+        if(rq->sector > cd->last_sector) {
+                crq->queue_id = cd->curr;
+                cscan_add_crq_rb(cd,crq); 
+        } else {
+                crq->queue_id = 1 - cd->curr;
+                cscan_add_crq_rb(cd,crq); 
+        }
+
+        if(rq_mergeable(rq)) {
+                cscan_add_crq_hash(cd,crq);
+
+                if(!q->last_merge)
+                        q->last_merge = rq;    
+        }                
+}
+/*
+ * See if we can find a request that this buffer can be coalesced with.
+ */
+int cscan_merge(request_queue_t *q, struct request **req,
+			struct bio *bio)
+{
+        struct CSCAN_data * cd = q->elevator->elevator_data;
+        struct request * __rq;
+        int ret;
+        sector_t rb_key;
+
+         /*
+         * try last_merge to avoid going to hash
+         */
+        ret = elv_try_last_merge(q, bio);
+        if (ret != ELEVATOR_NO_MERGE) {
+                __rq = q->last_merge;
+                goto out_insert;
+        }
+        /*
+         * see if the merge hash can satisfy a back merge
+         */
+        __rq = cscan_find_rq_hash(cd, bio->bi_sector);
+        if (__rq) {
+                BUG_ON(__rq->sector + __rq->nr_sectors != bio->bi_sector);
+
+                if (elv_rq_merge_ok(__rq, bio)) {
+                        ret = ELEVATOR_BACK_MERGE;
+                        goto out;
+                }
+        }
+
+         /*
+         * check for front merge
+         */
+         rb_key = bio->bi_sector + bio_sectors(bio);
+
+         __rq = cscan_find_crq_rb(cd, rb_key);
+         if (__rq) {
+                 BUG_ON(rb_key != rq_rb_key(__rq));
+
+                 if (elv_rq_merge_ok(__rq, bio)) {
+                         ret = ELEVATOR_FRONT_MERGE;
+                         goto out;
+                 }
+         }
+         return ELEVATOR_NO_MERGE;
+out:
+        q->last_merge = __rq;
+
+out_insert: 
+        *req = __rq;
+	return ret;
+}
+
+void cscan_merged_requests(request_queue_t *q, struct request *req,
+				  struct request *next)
+{
+        struct CSCAN_data * cd      = q->elevator->elevator_data;
+        struct CSCAN_request *crq   = 
+                        (struct CSCAN_request*)req->elevator_private;
+        struct CSCAN_request *tnext = 
+                        (struct CSCAN_request*)req->elevator_private;
+
+
+        BUG_ON(!crq);
+        BUG_ON(!tnext);
+        
+        cscan_del_crq_hash(crq);
+        cscan_add_crq_hash(cd,crq);
+        
+        if(rq_rb_key(req) |= crq->rb_key) {
+                cscan_del_crq_rb(cd,crq);
+                cscan_add_crq_rb(cd,crq);
+        }
+
+        cscan_remove_request(cd,tnext,tnext->queue_id);
+}
+
+void cscan_insert_request(request_queue_t *q, struct request *rq,
+			       int where)
+{
+        struct CSCAN_data * cd = q->elevator->elevator_data;
+
+        if (unlikely(rq->flags & (REQ_SOFTBARRIER | REQ_HARDBARRIER)
+                        && where == ELEVATOR_INSERT_SORT))
+                where = ELEVATOR_INSERT_BACK;
+
+        switch (where) {
+                case ELEVATOR_INSERT_BACK:
+                        while (cscan_dispatch_requests(cd))
+                                ;
+                        list_add_tail(&rq->queuelist, cd->dispatch);
+                        break;
+                case ELEVATOR_INSERT_FRONT:
+                        list_add(&rq->queuelist, cd->dispatch);
+                        break;
+                case ELEVATOR_INSERT_SORT:
+                        BUG_ON(!blk_fs_request(rq));
+                        cscan_add_request(q, rq);
+                        break;
+                default:
+                        printk("%s: bad insert point %d\n", __FUNCTION__,where);
+                        return;
+        }
+
+                
+}
+
+static struct request *cscan_next_request(request_queue_t *q)
+{
+        struct CSCAN_data * cd = q->elevator->elevator_data;
+        struct request * rq = NULL;        
+
+	if (!list_empty(cd->dispatch)) {
+dispatch:       rq = list_entry_rq(cd->dispatch->next);
+                cd->last_sector = rq->sector + rq->nr_sectors;
+                return rq;
+        }                
+        if(cscan_dispatch_requests(cd)) {
+                goto dispatch;
+        }
+	return NULL;
+}
+
+static void
+cscan_put_request(request_queue_t *q, struct request *rq) 
+{
+        struct CSCAN_data * cd = q->elevator->elevator_data;
+        struct CSCAN_request * crq = 
+                        (struct CSCAN_request*)rq->elevator_private;
+
+        if(crq) {
+                mempool_free(crq,cd->crq_pool);
+                rq->elevator_private = NULL;
+        }
+}
+
+static int
+cscan_set_request(request_queue_t *q, struct request *rq,int gfp_mask) 
+{
+       struct CSCAN_data *cd = q->elevator->elevator_data;
+       struct CSCAN_request * crq;
+
+       crq = mempool_alloc(cd->crq_pool, gfp_mask);
+       if(crq) {
+                memset(crq,0,sizeof(*crq));
+                RB_CLEAR(&crq->rb_node);
+                crq->request = rq;                
+                
+                INIT_LIST_HEAD(&crq->hash);
+                crq->on_hash = 0;
+
+                crq->request  = rq;
+                rq->elevator_private = crq;
+                return 0;
+       }
+       return 1;
+}
+
+static void 
+cscan_exit_queue(elevator_t * e) 
+{
+        struct CSCAN_data *cd = e->elevator_data;
+        mempool_destroy(cd->crq_pool);
+        kfree(cd->hash);
+        kfree(cd);
+}
+
+static int 
+cscan_init_queue(request_queue_t *q, elevator_t *e) 
+{
+       struct CSCAN_data * cd;
+       int i;
+
+       cd = kmalloc(sizeof(*cd),GFP_KERNEL);
+       if(!cd)
+                return -ENOMEM;
+       memset(cd,0,sizeof(*cd));
+       cd->sort_list[0] = RB_ROOT;
+       cd->sort_list[1] = RB_ROOT;
+       cd->count[0] = 0;
+       cd->count[1] = 0;
+      
+       cd->hash = kmalloc(sizeof(struct list_head)*DL_HASH_ENTRIES,GFP_KERNEL);
+
+       if(!cd->hash) {
+                kfree(cd);
+                return -ENOMEM;
+       }
+
+       for(i = 0;i< DL_HASH_ENTRIES; i++)
+                INIT_LIST_HEAD(&cd->hash[i]);
+        
+       cd->crq_pool = mempool_create(BLKDEV_MIN_RQ,mempool_alloc_slab,
+                        mempool_free_slab,crq_pool);
+       
+       if(!cd->crq_pool) {
+                kfree(cd->hash);
+                kfree(cd);
+                return -ENOMEM;
+       }
+
+       cd->dispatch = &q->queue_head;
+       cd->curr = 0;        
+       e->elevator_data = cd; 
+       return 0;
+}
+
+static struct elevator_type cscan = {
+	.ops = {
+		.elevator_merge_fn		= cscan_merge,
+		.elevator_merge_req_fn		= cscan_merged_requests,
+		.elevator_next_req_fn		= cscan_next_request,
+		.elevator_add_req_fn		= cscan_insert_request,
+                .elevator_set_req_fn            = cscan_set_request,
+                .elevator_put_req_fn            = cscan_put_request,
+                .elevator_init_fn               = cscan_init_queue,
+                .elevator_exit_fn               = cscan_exit_queue,
+	},
+	.elevator_name = "cscan",
+	.elevator_owner = THIS_MODULE,
+};
+
+int cscan_init(void)
+{
+        int ret;
+        
+        crq_pool = kmem_cache_create("t_crq",sizeof(struct CSCAN_request),0,0,
+                NULL,NULL);
+        
+        if(!crq_pool)
+                return -ENOMEM;
+        
+        ret = elv_register(&cscan);
+        if(ret)
+                kmem_cache_destroy(crq_pool);
+        
+	return ret;
+}
+
+void cscan_exit(void)
+{
+        kmem_cache_destroy(crq_pool);
+	elv_unregister(&cscan);
+}
+
+module_init(cscan_init);
+module_exit(cscan_exit);
+
+
+MODULE_AUTHOR("Vishal Patil");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("CSCAN I/O scheduler");
diff -urN linux-2.6.10/drivers/block/elevator.c linux-2.6.10-cscan/drivers/block/elevator.c
--- linux-2.6.10/drivers/block/elevator.c	2004-12-24 16:35:24.000000000 -0500
+++ linux-2.6.10-cscan/drivers/block/elevator.c	2006-03-30 21:34:33.000000000 -0500
@@ -161,6 +161,8 @@
 
 #if defined(CONFIG_IOSCHED_AS)
 	strcpy(chosen_elevator, "anticipatory");
+#elif defined(CONFIG_IOSCHED_CSCAN)
+	strcpy(chosen_elevator, "cscan");
 #elif defined(CONFIG_IOSCHED_DEADLINE)
 	strcpy(chosen_elevator, "deadline");
 #elif defined(CONFIG_IOSCHED_CFQ)
diff -urN linux-2.6.10/drivers/block/Kconfig.iosched linux-2.6.10-cscan/drivers/block/Kconfig.iosched
--- linux-2.6.10/drivers/block/Kconfig.iosched	2004-12-24 16:33:51.000000000 -0500
+++ linux-2.6.10-cscan/drivers/block/Kconfig.iosched	2006-03-30 21:34:40.000000000 -0500
@@ -11,6 +11,19 @@
 	  that do their own scheduling and require only minimal assistance from
 	  the kernel.
 
+config IOSCHED_CSCAN
+	bool
+	default y
+	---help---
+        CSCAN I/O scheduler. Maintain two queues which will be sorted in
+        ascending order using Red Black Trees. When a disk request arrives and
+        if the block number it refers to is greater than the block number of the
+        current request being served add (merge) it to the first sorted queue or
+        else add (merge) it to the second sorted queue. Keep on servicing the
+        requests from the first request queue until it is empty after which
+        switch over to the second queue and now reverse the roles of the two
+        queues
+
 config IOSCHED_AS
 	tristate "Anticipatory I/O scheduler"
 	default y
diff -urN linux-2.6.10/drivers/block/Makefile linux-2.6.10-cscan/drivers/block/Makefile
--- linux-2.6.10/drivers/block/Makefile	2004-12-24 16:35:24.000000000 -0500
+++ linux-2.6.10-cscan/drivers/block/Makefile	2006-03-30 21:34:46.000000000 -0500
@@ -16,6 +16,7 @@
 obj-y	:= elevator.o ll_rw_blk.o ioctl.o genhd.o scsi_ioctl.o
 
 obj-$(CONFIG_IOSCHED_NOOP)	+= noop-iosched.o
+obj-$(CONFIG_IOSCHED_CSCAN)	+= cscan.o
 obj-$(CONFIG_IOSCHED_AS)	+= as-iosched.o
 obj-$(CONFIG_IOSCHED_DEADLINE)	+= deadline-iosched.o
 obj-$(CONFIG_IOSCHED_CFQ)	+= cfq-iosched.o




------=_Part_15256_5655831.1143777500638--
