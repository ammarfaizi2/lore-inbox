Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750913AbWHGPGm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750913AbWHGPGm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 11:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123AbWHGPGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 11:06:42 -0400
Received: from mtagate6.de.ibm.com ([195.212.29.155]:32090 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750913AbWHGPGl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 11:06:41 -0400
Date: Mon, 7 Aug 2006 17:06:39 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [patch] s390: xpram system device class.
Message-ID: <20060807150639.GD10416@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

[S390] xpram system device class.

Remove system device class for xpram. It creates the directory hierarchy
under /sys/devices/system/xpram/xpram0. The xpram0 directory is empty and
it is always created while xpram1 and following devices are always missing,
independent if the devices exist or not. Since the xpram devices are
listed in /proc/partitions and /sys/block/ as slram<x> the system device
class for xpram is meaningless.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/block/xpram.c   |   25 ---------------
 drivers/s390/net/qeth.h      |    3 +
 drivers/s390/net/qeth_main.c |   69 ++++++++++++++++++++++++++-----------------
 3 files changed, 45 insertions(+), 52 deletions(-)

diff -urpN linux-2.6/drivers/s390/block/xpram.c linux-2.6-patched/drivers/s390/block/xpram.c
--- linux-2.6/drivers/s390/block/xpram.c	2006-08-07 14:14:29.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/xpram.c	2006-08-07 14:14:45.000000000 +0200
@@ -48,15 +48,6 @@
 #define PRINT_ERR(x...)		printk(KERN_ERR XPRAM_NAME " error:" x)
 
 
-static struct sysdev_class xpram_sysclass = {
-	set_kset_name("xpram"),
-};
-
-static struct sys_device xpram_sys_device = {
-	.id	= 0,
-	.cls	= &xpram_sysclass,
-}; 
-
 typedef struct {
 	unsigned int	size;		/* size of xpram segment in pages */
 	unsigned int	offset;		/* start page of xpram segment */
@@ -451,8 +442,6 @@ static void __exit xpram_exit(void)
 	}
 	unregister_blkdev(XPRAM_MAJOR, XPRAM_NAME);
 	blk_cleanup_queue(xpram_queue);
-	sysdev_unregister(&xpram_sys_device);
-	sysdev_class_unregister(&xpram_sysclass);
 }
 
 static int __init xpram_init(void)
@@ -470,19 +459,7 @@ static int __init xpram_init(void)
 	rc = xpram_setup_sizes(xpram_pages);
 	if (rc)
 		return rc;
-	rc = sysdev_class_register(&xpram_sysclass);
-	if (rc)
-		return rc;
-
-	rc = sysdev_register(&xpram_sys_device);
-	if (rc) {
-		sysdev_class_unregister(&xpram_sysclass);
-		return rc;
-	}
-	rc = xpram_setup_blkdev();
-	if (rc)
-		sysdev_unregister(&xpram_sys_device);
-	return rc;
+	return xpram_setup_blkdev();
 }
 
 module_init(xpram_init);
diff -urpN linux-2.6/drivers/s390/net/qeth.h linux-2.6-patched/drivers/s390/net/qeth.h
--- linux-2.6/drivers/s390/net/qeth.h	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6-patched/drivers/s390/net/qeth.h	2006-08-07 14:14:45.000000000 +0200
@@ -462,6 +462,7 @@ enum qeth_qdio_info_states {
 	QETH_QDIO_UNINITIALIZED,
 	QETH_QDIO_ALLOCATED,
 	QETH_QDIO_ESTABLISHED,
+	QETH_QDIO_CLEANING
 };
 
 struct qeth_buffer_pool_entry {
@@ -536,7 +537,7 @@ struct qeth_qdio_out_q {
 } __attribute__ ((aligned(256)));
 
 struct qeth_qdio_info {
-	volatile enum qeth_qdio_info_states state;
+	atomic_t state;
 	/* input */
 	struct qeth_qdio_q *in_q;
 	struct qeth_qdio_buffer_pool in_buf_pool;
diff -urpN linux-2.6/drivers/s390/net/qeth_main.c linux-2.6-patched/drivers/s390/net/qeth_main.c
--- linux-2.6/drivers/s390/net/qeth_main.c	2006-08-07 14:14:29.000000000 +0200
+++ linux-2.6-patched/drivers/s390/net/qeth_main.c	2006-08-07 14:14:45.000000000 +0200
@@ -3185,13 +3185,14 @@ qeth_alloc_qdio_buffers(struct qeth_card
 
 	QETH_DBF_TEXT(setup, 2, "allcqdbf");
 
-	if (card->qdio.state == QETH_QDIO_ALLOCATED)
+	if (atomic_cmpxchg(&card->qdio.state, QETH_QDIO_UNINITIALIZED,
+		 QETH_QDIO_ALLOCATED) != QETH_QDIO_UNINITIALIZED)
 		return 0;
 
 	card->qdio.in_q = kmalloc(sizeof(struct qeth_qdio_q),
 				  GFP_KERNEL|GFP_DMA);
 	if (!card->qdio.in_q)
-		return - ENOMEM;
+		goto out_nomem;
 	QETH_DBF_TEXT(setup, 2, "inq");
 	QETH_DBF_HEX(setup, 2, &card->qdio.in_q, sizeof(void *));
 	memset(card->qdio.in_q, 0, sizeof(struct qeth_qdio_q));
@@ -3200,27 +3201,19 @@ qeth_alloc_qdio_buffers(struct qeth_card
 		card->qdio.in_q->bufs[i].buffer =
 			&card->qdio.in_q->qdio_bufs[i];
 	/* inbound buffer pool */
-	if (qeth_alloc_buffer_pool(card)){
-		kfree(card->qdio.in_q);
-		return -ENOMEM;
-	}
+	if (qeth_alloc_buffer_pool(card))
+		goto out_freeinq;
 	/* outbound */
 	card->qdio.out_qs =
 		kmalloc(card->qdio.no_out_queues *
 			sizeof(struct qeth_qdio_out_q *), GFP_KERNEL);
-	if (!card->qdio.out_qs){
-		qeth_free_buffer_pool(card);
-		return -ENOMEM;
-	}
-	for (i = 0; i < card->qdio.no_out_queues; ++i){
+	if (!card->qdio.out_qs)
+		goto out_freepool;
+	for (i = 0; i < card->qdio.no_out_queues; ++i) {
 		card->qdio.out_qs[i] = kmalloc(sizeof(struct qeth_qdio_out_q),
 					       GFP_KERNEL|GFP_DMA);
-		if (!card->qdio.out_qs[i]){
-			while (i > 0)
-				kfree(card->qdio.out_qs[--i]);
-			kfree(card->qdio.out_qs);
-			return -ENOMEM;
-		}
+		if (!card->qdio.out_qs[i])
+			goto out_freeoutq;
 		QETH_DBF_TEXT_(setup, 2, "outq %i", i);
 		QETH_DBF_HEX(setup, 2, &card->qdio.out_qs[i], sizeof(void *));
 		memset(card->qdio.out_qs[i], 0, sizeof(struct qeth_qdio_out_q));
@@ -3237,8 +3230,19 @@ qeth_alloc_qdio_buffers(struct qeth_card
 			INIT_LIST_HEAD(&card->qdio.out_qs[i]->bufs[j].ctx_list);
 		}
 	}
-	card->qdio.state = QETH_QDIO_ALLOCATED;
 	return 0;
+
+out_freeoutq:
+	while (i > 0)
+		kfree(card->qdio.out_qs[--i]);
+	kfree(card->qdio.out_qs);
+out_freepool:
+	qeth_free_buffer_pool(card);
+out_freeinq:
+	kfree(card->qdio.in_q);
+out_nomem:
+	atomic_set(&card->qdio.state, QETH_QDIO_UNINITIALIZED);
+	return -ENOMEM;
 }
 
 static void
@@ -3247,7 +3251,8 @@ qeth_free_qdio_buffers(struct qeth_card 
 	int i, j;
 
 	QETH_DBF_TEXT(trace, 2, "freeqdbf");
-	if (card->qdio.state == QETH_QDIO_UNINITIALIZED)
+	if (atomic_swap(&card->qdio.state, QETH_QDIO_UNINITIALIZED) ==
+		QETH_QDIO_UNINITIALIZED)
 		return;
 	kfree(card->qdio.in_q);
 	/* inbound buffer pool */
@@ -3260,7 +3265,6 @@ qeth_free_qdio_buffers(struct qeth_card 
 		kfree(card->qdio.out_qs[i]);
 	}
 	kfree(card->qdio.out_qs);
-	card->qdio.state = QETH_QDIO_UNINITIALIZED;
 }
 
 static void
@@ -3282,7 +3286,7 @@ static void
 qeth_init_qdio_info(struct qeth_card *card)
 {
 	QETH_DBF_TEXT(setup, 4, "intqdinf");
-	card->qdio.state = QETH_QDIO_UNINITIALIZED;
+	atomic_set(&card->qdio.state, QETH_QDIO_UNINITIALIZED);
 	/* inbound */
 	card->qdio.in_buf_size = QETH_IN_BUF_SIZE_DEFAULT;
 	card->qdio.init_pool.buf_count = QETH_IN_BUF_COUNT_DEFAULT;
@@ -3345,7 +3349,7 @@ qeth_qdio_establish(struct qeth_card *ca
 	struct qdio_buffer **in_sbal_ptrs;
 	struct qdio_buffer **out_sbal_ptrs;
 	int i, j, k;
-	int rc;
+	int rc = 0;
 
 	QETH_DBF_TEXT(setup, 2, "qdioest");
 
@@ -3404,9 +3408,11 @@ qeth_qdio_establish(struct qeth_card *ca
 	init_data.input_sbal_addr_array  = (void **) in_sbal_ptrs;
 	init_data.output_sbal_addr_array = (void **) out_sbal_ptrs;
 
-	if (!(rc = qdio_initialize(&init_data)))
-		card->qdio.state = QETH_QDIO_ESTABLISHED;
-
+	if (atomic_cmpxchg(&card->qdio.state, QETH_QDIO_ALLOCATED,
+		QETH_QDIO_ESTABLISHED) == QETH_QDIO_ALLOCATED) {
+		if ((rc = qdio_initialize(&init_data)))
+			atomic_set(&card->qdio.state, QETH_QDIO_ALLOCATED);
+	}
 	kfree(out_sbal_ptrs);
 	kfree(in_sbal_ptrs);
 	kfree(qib_param_field);
@@ -3521,13 +3527,22 @@ qeth_qdio_clear_card(struct qeth_card *c
 	int rc = 0;
 
 	QETH_DBF_TEXT(trace,3,"qdioclr");
-	if (card->qdio.state == QETH_QDIO_ESTABLISHED){
+	switch (atomic_cmpxchg(&card->qdio.state, QETH_QDIO_ESTABLISHED,
+		QETH_QDIO_CLEANING)) {
+	case QETH_QDIO_ESTABLISHED:
 		if ((rc = qdio_cleanup(CARD_DDEV(card),
 			     (card->info.type == QETH_CARD_TYPE_IQD) ?
 			     QDIO_FLAG_CLEANUP_USING_HALT :
 			     QDIO_FLAG_CLEANUP_USING_CLEAR)))
 			QETH_DBF_TEXT_(trace, 3, "1err%d", rc);
-		card->qdio.state = QETH_QDIO_ALLOCATED;
+		atomic_set(&card->qdio.state, QETH_QDIO_ALLOCATED);
+	case QETH_QDIO_ALLOCATED:
+		break;
+	case QETH_QDIO_CLEANING:
+		return rc;
+	default:
+		QETH_DBF_TEXT_(trace, 3, "2err%d", rc);
+		break;
 	}
 	if ((rc = qeth_clear_halt_card(card, use_halt)))
 		QETH_DBF_TEXT_(trace, 3, "2err%d", rc);
