Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932378AbWDLXxR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932378AbWDLXxR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 19:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932382AbWDLXxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 19:53:17 -0400
Received: from xproxy.gmail.com ([66.249.82.207]:16607 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932378AbWDLXxQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 19:53:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=KwxhRszCRsVVCeBo/FpfDtrAOQ1GmpiuGitDQoEv8g0yRYmBUEfecGFpzHglY/OGe8c8GSvc/rebTYqMZ7vrfZkCMTekgqBr4+5IQllg9OMujCYEGb13scuqOMWIqHcSYlXdGiuIuDM64HJA8rPSMujbT4iSvWzkzGgg9C2CdBg=
Message-ID: <4745278c0604121653p68d7baf0uc3f8ebf952a4cb61@mail.gmail.com>
Date: Wed, 12 Apr 2006 19:53:16 -0400
From: "Vishal Patil" <vishpat@gmail.com>
To: "Jan Engelhardt" <jengelh@linux01.gwdg.de>
Subject: Re: CSCAN I/O scheduler for 2.6.10 kernel
Cc: "Jens Axboe" <axboe@suse.de>, "Antonio Vargas" <windenntw@gmail.com>,
       "Bill Davidsen" <davidsen@tmr.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0604111340550.928@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_9366_21520488.1144885996029"
References: <4745278c0603301955w26fea42eid6bcab91c573eaa3@mail.gmail.com>
	 <4745278c0603301958o4c2ed282x3513fdb459d8ec7c@mail.gmail.com>
	 <4432D6D4.2020102@tmr.com>
	 <4745278c0604041402n5c6329ebw71d7fdc5c3a9dd68@mail.gmail.com>
	 <69304d110604050448x60fd5bb1ub74f66b720dc7d8a@mail.gmail.com>
	 <4745278c0604050646n668bc9fy2b8c18462439ae5d@mail.gmail.com>
	 <4745278c0604090955j2841ebacka990a90ffebc7841@mail.gmail.com>
	 <Pine.LNX.4.61.0604111334150.928@yvahk01.tjqt.qr>
	 <20060411113926.GD4791@suse.de>
	 <Pine.LNX.4.61.0604111340550.928@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_9366_21520488.1144885996029
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Jan

I am attaching a final CSCAN scheduler patch for the 2.6.16.2 kernel.
The earlier patch that I had posted had a bug in the
"cscan_merged_requests" function. This has been taken care of in the
attached patch.  I would really appreciate if some one could help me
in conducting performance tests for the attached patch.

Many thanks for to all of you all for your inputs on this.

- Vishal


On 4/11/06, Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
> >> >I am attaching the CSCAN scheduler patch for 2.6.16.2 kernel.
> >>
> >> Thanks, I will try this.
> >>
> >> I have a question, why does not it use the kernel's rbtree implementat=
ion?
> >
> >It does, I dunno why you think it doesn't?
>
> My bad. I thought because a function is named
>   static struct cscan_request *__rb_insert_request
> led me to believe this is the main insert function (when in fact it
> rb_link_node is). Maybe it should be just
> called "insert_request".
>
>
>


--
Every passing minute is another chance to turn it all around.

------=_Part_9366_21520488.1144885996029
Content-Type: application/octet-stream; name=cscan-2.6.16.2-patch
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_ely8tiqu
Content-Disposition: attachment; filename="cscan-2.6.16.2-patch"

diff -urN linux-2.6.16.2/block/cscan.c linux-2.6.16.2-cscan/block/cscan.c
--- linux-2.6.16.2/block/cscan.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.16.2-cscan/block/cscan.c	2006-04-09 10:24:52.000000000 -0400
@@ -0,0 +1,338 @@
+/*
+ * elevator cscan
+ */
+#include <linux/blkdev.h>
+#include <linux/elevator.h>
+#include <linux/bio.h>
+#include <linux/module.h>
+#include <linux/init.h>
+
+#define RQ_DATA(rq) ((struct cscan_request *) (rq)->elevator_private)
+
+#define RB_NONE         (2)
+#define RB_EMPTY(root)  ((root)->rb_node == NULL)
+#define ON_RB(node)     ((node)->rb_color != RB_NONE)
+#define RB_CLEAR(node)  ((node)->rb_color = RB_NONE)
+#define rb_entry_crq(node)      rb_entry((node), struct cscan_request, rb_node)
+#define DRQ_RB_ROOT(cd, crq)    (&(cd)->sort_list[rq_data_dir((crq)->request)])
+#define rq_rb_key(rq)           (rq)->sector
+
+
+struct cscan_data {
+        struct rb_root sort_list[2];
+        unsigned int count[2];
+        
+        sector_t last_sector;
+        unsigned int first;
+        mempool_t * crq_pool;
+};
+
+struct cscan_request {
+        struct rb_node rb_node;
+        sector_t rb_key;
+        unsigned int queue_id;
+
+        struct request * request;
+};
+
+static kmem_cache_t *crq_pool;
+
+/*
+ *      Searching/Sorting routines
+ */
+static struct cscan_request *
+__rb_insert_request(struct rb_root * root, struct cscan_request * crq) 
+{
+        struct rb_node **p = &root->rb_node;
+        struct rb_node *parent = NULL;
+        struct cscan_request * __crq;
+        
+         while(*p) {
+                parent = *p;
+                __crq = rb_entry(parent,struct cscan_request,rb_node);
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
+cscan_request * rb_insert_request(struct rb_root * root, 
+                                     struct cscan_request * crq)
+{
+        struct cscan_request * ret;
+        if((ret = __rb_insert_request(root,crq)))
+                goto out;
+        rb_insert_color(&crq->rb_node,root);
+out:
+        return ret;
+}
+
+static inline struct
+cscan_request * rb_find_request(struct rb_root * root, long key) 
+{
+        struct rb_node * n = root->rb_node;
+        struct cscan_request * crq;
+
+        while(n) 
+        {
+                crq = rb_entry(n,struct cscan_request,rb_node);
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
+static void 
+cscan_remove_request(struct cscan_data * cd, struct cscan_request * crq) 
+{
+        rb_erase(&crq->rb_node, &cd->sort_list[crq->queue_id]);
+        RB_CLEAR(&crq->rb_node);
+        cd->count[crq->queue_id]--;
+}
+
+static void
+cscan_add_crq_rb(struct cscan_data * cd, struct cscan_request * crq) 
+{
+        crq->rb_key = rq_rb_key(crq->request);
+        rb_insert_request(&cd->sort_list[crq->queue_id],crq);
+        cd->count[crq->queue_id]++;
+}
+
+static void 
+cscan_merged_requests(request_queue_t *q, struct request *rq,
+				 struct request *next)
+{
+	 struct cscan_data *cd = q->elevator->elevator_data;
+        struct cscan_request * crq;        
+        crq = RQ_DATA(next);
+
+        cscan_remove_request(cd,crq);
+}
+
+static int 
+cscan_dispatch(request_queue_t *q, int force)
+{
+	struct cscan_data *cd = q->elevator->elevator_data;
+        struct rb_root * root = NULL;
+
+        if(rb_first(&cd->sort_list[cd->first])) {
+               root = &cd->sort_list[cd->first]; 
+        } else if(rb_first(&cd->sort_list[1 - cd->first])) {
+                root = &cd->sort_list[1 - cd->first]; 
+                cd->first = 1 - cd->first; 
+        }
+
+	if (root) {
+		struct cscan_request *crq;
+                struct request * rq;
+                
+		crq = rb_entry_crq(rb_first(root));
+                rq = crq->request;
+                cscan_remove_request(cd,crq);
+                cd->last_sector = rq->sector + rq->nr_sectors;
+		elv_dispatch_sort(q, rq);
+		return 1;
+	}
+	return 0;
+}
+
+static void 
+cscan_add_request(request_queue_t *q, struct request *rq)
+{
+	struct cscan_data *cd = q->elevator->elevator_data;
+        struct cscan_request * crq;        
+        
+        crq = RQ_DATA(rq);
+        if(rq->sector > cd->last_sector) 
+                crq->queue_id = cd->first;
+        else 
+                crq->queue_id = 1 - cd->first;
+        cscan_add_crq_rb(cd,crq);                                 
+}
+
+static int 
+cscan_queue_empty(request_queue_t *q)
+{
+	struct cscan_data *cd = q->elevator->elevator_data;
+
+        return ((rb_first(&cd->sort_list[cd->first]) == NULL) && 
+                (rb_first(&cd->sort_list[1 - cd->first]) == NULL));
+}
+
+static struct request *
+cscan_former_request(request_queue_t *q, struct request *rq)
+{
+	struct cscan_data *cd = q->elevator->elevator_data;
+        struct cscan_request * crq = RQ_DATA(rq); 
+       
+        if((crq->queue_id == cd->first) && (rb_prev(&crq->rb_node) == NULL))
+                return NULL;
+        
+        if( (crq->queue_id == (1 - cd->first)) && 
+                                (rb_prev(&crq->rb_node) == NULL)){
+                if(rb_last(&cd->sort_list[cd->first])){
+                	crq = rb_entry_crq(rb_last(
+                                &cd->sort_list[cd->first]));
+                        return crq->request;                                
+                } else {
+                        return NULL;
+                }
+        }            
+        
+        return rb_entry_crq(rb_prev(&crq->rb_node))->request;
+}
+
+static struct request *
+cscan_latter_request(request_queue_t *q, struct request *rq)
+{
+	struct cscan_data *cd = q->elevator->elevator_data;
+        struct cscan_request * crq = RQ_DATA(rq); 
+       
+        if((crq->queue_id == (1 - cd->first)) && 
+                                (rb_next(&crq->rb_node) == NULL))
+                return NULL;
+        
+        if( (crq->queue_id == cd->first) && 
+                                (rb_next(&crq->rb_node) == NULL)){
+                if(rb_first(&cd->sort_list[1 - cd->first])){
+                	crq = rb_entry_crq(rb_first(
+                                &cd->sort_list[1 - cd->first]));
+                        return crq->request;                                
+                } else {
+                        return NULL;
+                }
+        }            
+        
+        return rb_entry_crq(rb_next(&crq->rb_node))->request;
+
+}
+
+static void 
+cscan_put_request(request_queue_t *q, struct request * rq) 
+{
+        struct cscan_data * cd = q->elevator->elevator_data;
+        struct cscan_request *crq = RQ_DATA(rq);
+
+        mempool_free(crq,cd->crq_pool);
+        rq->elevator_private = NULL;
+}
+
+static int
+cscan_set_request(request_queue_t *q, struct request *rq, struct bio *bio,
+                     gfp_t gfp_mask)
+{
+        struct cscan_data * cd = q->elevator->elevator_data;
+        struct cscan_request * crq;
+        
+        crq = mempool_alloc(cd->crq_pool,gfp_mask);
+        if(crq) {
+                memset(crq,0,sizeof(*crq));
+                RB_CLEAR(&crq->rb_node);
+                crq->request = rq;
+                rq->elevator_private = crq;
+                return 0;
+        }
+        return 1;
+}
+
+
+static int 
+cscan_init_queue(request_queue_t *q, elevator_t *e)
+{
+	struct cscan_data *cd;
+        int i = 0;
+
+	cd = kmalloc(sizeof(*cd), GFP_KERNEL);
+	if (!cd)
+		return -ENOMEM;
+                
+        cd->first = 0;
+        cd->last_sector = 0;
+        for(i=0;i<2;i++) {
+                cd->sort_list[i] = RB_ROOT;
+                cd->count[i]     = 0;
+        }
+	e->elevator_data = cd;
+
+        cd->crq_pool = mempool_create(BLKDEV_MIN_RQ,mempool_alloc_slab,
+                        mempool_free_slab,crq_pool);
+
+       if(!cd->crq_pool) {
+                kfree(cd);
+                return -ENOMEM;
+       }
+	return 0;
+}
+
+static void 
+cscan_exit_queue(elevator_t *e)
+{
+	struct cscan_data *cd = e->elevator_data;
+
+        BUG_ON(rb_first(&cd->sort_list[cd->first]) != NULL);
+        BUG_ON(rb_first(&cd->sort_list[1 - cd->first]) != NULL);
+
+	kfree(cd);
+}
+
+static struct elevator_type elevator_cscan = {
+	.ops = {
+		.elevator_merge_req_fn		= cscan_merged_requests,
+		.elevator_dispatch_fn		= cscan_dispatch,
+		.elevator_add_req_fn		= cscan_add_request,
+		.elevator_queue_empty_fn	= cscan_queue_empty,
+		.elevator_former_req_fn		= cscan_former_request,
+		.elevator_latter_req_fn		= cscan_latter_request,
+                .elevator_set_req_fn            = cscan_set_request,
+                .elevator_put_req_fn            = cscan_put_request,
+		.elevator_init_fn		= cscan_init_queue,
+		.elevator_exit_fn		= cscan_exit_queue,
+	},
+	.elevator_name = "cscan",
+	.elevator_owner = THIS_MODULE,
+};
+
+static int __init 
+cscan_init(void)
+{
+        int ret;
+
+        crq_pool = kmem_cache_create("cscan_crq", sizeof(struct cscan_request),
+                                     0, 0, NULL, NULL);
+        if (!crq_pool)
+                 return -ENOMEM;
+
+        ret = elv_register(&elevator_cscan);
+        if(ret)
+                kmem_cache_destroy(crq_pool);
+        
+        return ret;
+}
+
+static void __exit 
+cscan_exit(void)
+{
+        kmem_cache_destroy(crq_pool);
+	elv_unregister(&elevator_cscan);
+}
+
+module_init(cscan_init);
+module_exit(cscan_exit);
+
+
+MODULE_AUTHOR("Vishal Patil");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("CSCAN I/O scheduler");
diff -urN linux-2.6.16.2/block/Kconfig.iosched linux-2.6.16.2-cscan/block/Kconfig.iosched
--- linux-2.6.16.2/block/Kconfig.iosched	2006-04-07 12:56:47.000000000 -0400
+++ linux-2.6.16.2-cscan/block/Kconfig.iosched	2006-04-09 10:25:07.000000000 -0400
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
diff -urN linux-2.6.16.2/block/Makefile linux-2.6.16.2-cscan/block/Makefile
--- linux-2.6.16.2/block/Makefile	2006-04-07 12:56:47.000000000 -0400
+++ linux-2.6.16.2-cscan/block/Makefile	2006-04-09 10:24:58.000000000 -0400
@@ -5,6 +5,7 @@
 obj-y	:= elevator.o ll_rw_blk.o ioctl.o genhd.o scsi_ioctl.o
 
 obj-$(CONFIG_IOSCHED_NOOP)	+= noop-iosched.o
+obj-$(CONFIG_IOSCHED_CSCAN)	+= cscan.o
 obj-$(CONFIG_IOSCHED_AS)	+= as-iosched.o
 obj-$(CONFIG_IOSCHED_DEADLINE)	+= deadline-iosched.o
 obj-$(CONFIG_IOSCHED_CFQ)	+= cfq-iosched.o



------=_Part_9366_21520488.1144885996029--
