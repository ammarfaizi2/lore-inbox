Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261797AbVHDE6m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261797AbVHDE6m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 00:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261816AbVHDEtB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 00:49:01 -0400
Received: from bgerelbas01.asiapac.hp.net ([15.219.201.134]:14212 "EHLO
	bgerelbas01.ind.hp.com") by vger.kernel.org with ESMTP
	id S261806AbVHDErW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 00:47:22 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [PATCH 3/3] cpqarray: per disk request queue in 2.6 kernel
Date: Thu, 4 Aug 2005 10:17:15 +0530
Message-ID: <4221C1B21C20854291E185D1243EA8F302623BDD@bgeexc04.asiapacific.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 3/3] cpqarray: per disk request queue in 2.6 kernel
Thread-Index: AcWYr5YH9CS7rrAwSqqfmULoGG1Bdg==
From: "Saripalli, Venkata Ramanamurthy (STSD)" <saripalli@hp.com>
To: <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>
Cc: <axboe@suse.de>
X-OriginalArrivalTime: 04 Aug 2005 04:47:16.0063 (UTC) FILETIME=[96713EF0:01C598AF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 3 of 3
This patch adds support for per disk request queue in 2.6 kernel. This
solves the
kernel panic while removing the cpqarray with more than one LUN
configured.

Please consider this for inclusion.

Signed-off-by: Ramanamurthy Saripalli <saripalli@hp.com>

 cpqarray.c |   51 +++++++++++++++++++++++++++++++++++++++++++++++----
 cpqarray.h |    1 +
 2 files changed, 48 insertions(+), 4 deletions(-)
------------------------------------------------------------------------
-----------
diff -burpN old/drivers/block/cpqarray.c new3/drivers/block/cpqarray.c
--- old/drivers/block/cpqarray.c	2005-06-28 23:26:06.000000000
-0400
+++ new3/drivers/block/cpqarray.c	2005-06-29 00:01:22.000000000
-0400
@@ -45,13 +45,13 @@
 
 #define SMART2_DRIVER_VERSION(maj,min,submin)
((maj<<16)|(min<<8)|(submin))
 
-#define DRIVER_NAME "Compaq SMART2 Driver (v 2.6.0)"
-#define DRIVER_VERSION SMART2_DRIVER_VERSION(2,6,0)
+#define DRIVER_NAME "Compaq SMART2 Driver (v 2.6.1)"
+#define DRIVER_VERSION SMART2_DRIVER_VERSION(2,6,1)
 
 /* Embedded module documentation macros - see modules.h */
 /* Original author Chris Frantz - Compaq Computer Corporation */
 MODULE_AUTHOR("Compaq Computer Corporation");
-MODULE_DESCRIPTION("Driver for Compaq Smart2 Array Controllers version
2.6.0");
+MODULE_DESCRIPTION("Driver for Compaq Smart2 Array Controllers version
2.6.1");
 MODULE_LICENSE("GPL");
 
 #include "cpqarray.h"
@@ -489,6 +489,22 @@ static int cpqarray_register_ctlr( int i
 		blk_queue_hardsect_size(hba[i]->queue, drv->blk_size);
 		set_capacity(disk, drv->nr_blks);
 		disk->queue = hba[i]->queue;
+
+		/*
+		 * Create request queue per logical volume
+		 */
+                if ( j )
+                        disk->queue = blk_init_queue(do_ida_request,
&hba[i]->lock);
+
+                disk->queue->queuedata = hba[i];
+
+                /* This is a hardware imposed limit. */
+                blk_queue_max_hw_segments(disk->queue, SG_MAX);
+
+                /* This is a driver limit and could be eliminated. */
+                blk_queue_max_phys_segments(disk->queue, SG_MAX);
+
+
 		disk->private_data = drv;
 		add_disk(disk);
 	}
@@ -1060,6 +1076,9 @@ static irqreturn_t do_ida_intr(int irq, 
 	unsigned long istat;
 	unsigned long flags;
 	__u32 a,a1;
+	int j;
+        int ctlr = h->ctlr;             
+        int start_queue = h->next_to_run;
 
 	istat = h->access.intr_pending(h);
 	/* Is this interrupt for us? */
@@ -1113,7 +1132,31 @@ static irqreturn_t do_ida_intr(int irq, 
 	/*
 	 * See if we can queue up some more IO
 	 */
-	do_ida_request(h->queue);
+        for(j=0; j < NWD; j++) {
+                int curr_queue = (start_queue + j) % NWD;
+
+                if (!(ida_gendisk[ctlr][curr_queue]->queue) ||
+                        !(h->drv[curr_queue].heads))
+                        continue;
+
+                blk_start_queue(ida_gendisk[ctlr][curr_queue]->queue);
+
+                if ( (find_first_zero_bit(h->cmd_pool_bits, NR_CMDS) )
== NR_CMDS)
+                {
+                        if ( curr_queue == start_queue) {
+                                h->next_to_run = (start_queue + 1) %
NWD;
+                                goto cleanup;
+                        } else {
+                                h->next_to_run = curr_queue;
+                                goto cleanup;
+                        }
+                } else {
+                        curr_queue = (curr_queue + 1) %NWD;
+                }
+        }
+
+cleanup:
+
 	spin_unlock_irqrestore(IDA_LOCK(h->ctlr), flags); 
 	return IRQ_HANDLED;
 }
diff -burpN old/drivers/block/cpqarray.h new3/drivers/block/cpqarray.h
--- old/drivers/block/cpqarray.h	2005-06-28 23:26:14.000000000
-0400
+++ new3/drivers/block/cpqarray.h	2005-06-29 00:01:31.000000000
-0400
@@ -117,6 +117,7 @@ struct ctlr_info {
 	unsigned int nr_frees;
 	struct timer_list timer;
 	unsigned int misc_tflags;
+	int next_to_run;
 };
 
 #define IDA_LOCK(i)	(&hba[i]->lock)
