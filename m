Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267571AbSKSXKe>; Tue, 19 Nov 2002 18:10:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267573AbSKSXKe>; Tue, 19 Nov 2002 18:10:34 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:13838
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S267571AbSKSXKc>; Tue, 19 Nov 2002 18:10:32 -0500
Subject: Re: [patch] remove magic numbers in block queue initialization
From: Robert Love <rml@tech9.net>
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, joe@perches.com
In-Reply-To: <1037747198.1252.2259.camel@phantasy>
References: <1037747198.1252.2259.camel@phantasy>
Content-Type: text/plain
Organization: 
Message-Id: <1037747861.1253.2273.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 19 Nov 2002 18:17:41 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Perches just pointed out we can make the second `if' an `else if'. 
Probably does not affect the object code, but since we are editing this
here now, why not...

Updated patch applied.

	Robert Love


Replace magic numbers in block queue init with sexy defines.
Also change an if to an else if in the name of micro-ops.
 
 drivers/block/ll_rw_blk.c |   32 ++++++++++++++++++++++++--------
 1 files changed, 24 insertions(+), 8 deletions(-)


diff -urN linux-2.5.48/drivers/block/ll_rw_blk.c linux/drivers/block/ll_rw_blk.c
--- linux-2.5.48/drivers/block/ll_rw_blk.c	2002-11-17 23:29:22.000000000 -0500
+++ linux/drivers/block/ll_rw_blk.c	2002-11-19 17:59:07.000000000 -0500
@@ -2109,6 +2109,22 @@
 	__blk_put_request(req->q, req);
 }
 
+/*
+ * The maximum and minimum free requests slots in the queue are
+ * dynamically calculated as a function of total memory.  Below is the
+ * upper and lower bound to those calculations.  We do not want the
+ * queue too large, as more memory than desired can be under writeback.
+ */
+#define MAX_QUEUE_REQUESTS	128
+#define MIN_QUEUE_REQUESTS	16
+
+/*
+ * Number of requests to batch together is calculated as the queue size
+ * over BATCH_QUEUE_FACTOR.  This number is capped at MAX_BATCH_REQUESTS
+ */
+#define BATCH_QUEUE_FACTOR	8
+#define MAX_BATCH_REQUESTS	8
+
 int __init blk_dev_init(void)
 {
 	int total_ram = nr_free_pages() << (PAGE_SHIFT - 10);
@@ -2125,14 +2141,14 @@
 	 * We use this many requests for reads, and this many for writes.
 	 */
 	queue_nr_requests = (total_ram >> 9) & ~7;
-	if (queue_nr_requests < 16)
-		queue_nr_requests = 16;
-	if (queue_nr_requests > 128)
-		queue_nr_requests = 128;
-
-	batch_requests = queue_nr_requests / 8;
-	if (batch_requests > 8)
-		batch_requests = 8;
+	if (queue_nr_requests < MIN_QUEUE_REQUESTS)
+		queue_nr_requests = MIN_QUEUE_REQUESTS;
+	else if (queue_nr_requests > MAX_QUEUE_REQUESTS)
+		queue_nr_requests = MAX_QUEUE_REQUESTS;
+
+	batch_requests = queue_nr_requests / BATCH_QUEUE_FACTOR;
+	if (batch_requests > MAX_BATCH_REQUESTS)
+		batch_requests = MAX_BATCH_REQUESTS;
 
 	printk("block request queues:\n");
 	printk(" %d requests per read queue\n", queue_nr_requests);



