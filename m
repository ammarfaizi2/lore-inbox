Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271277AbUJVMkV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271277AbUJVMkV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 08:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271267AbUJVMdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 08:33:42 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:23985 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S271274AbUJVM0j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 08:26:39 -0400
Date: Fri, 22 Oct 2004 14:26:25 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 5/6] s390: qdio changes.
Message-ID: <20041022122625.GF3720@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 5/6] s390: qdio changes.

From: Utz Bacher <utz.bacher@de.ibm.com>

qdio changes:
 - Rename iqdio_is_inbound_q_done to tiqdio_is_inbound_q_done to
   keep function naming consistent.
 - Allocate qdio structures below 2GB.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 drivers/s390/cio/qdio.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff -urN linux-2.6/drivers/s390/cio/qdio.c linux-2.6-patched/drivers/s390/cio/qdio.c
--- linux-2.6/drivers/s390/cio/qdio.c	2004-10-18 23:54:37.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/qdio.c	2004-10-22 13:51:45.000000000 +0200
@@ -56,7 +56,7 @@
 #include "ioasm.h"
 #include "chsc.h"
 
-#define VERSION_QDIO_C "$Revision: 1.86 $"
+#define VERSION_QDIO_C "$Revision: 1.88 $"
 
 /****************** MODULE PARAMETER VARIABLES ********************/
 MODULE_AUTHOR("Utz Bacher <utz.bacher@de.ibm.com>");
@@ -808,7 +808,7 @@
 #endif /* QDIO_USE_PROCESSING_STATE */
 		/* 
 		 * not needed, as the inbound queue will be synced on the next
-		 * siga-r
+		 * siga-r, resp. tiqdio_is_inbound_q_done will do the siga-s
 		 */
 		/*SYNC_MEMORY;*/
 		f++;
@@ -899,7 +899,7 @@
 
 /* means, no more buffers to be filled */
 inline static int
-iqdio_is_inbound_q_done(struct qdio_q *q)
+tiqdio_is_inbound_q_done(struct qdio_q *q)
 {
 	int no_used;
 #ifdef CONFIG_QDIO_DEBUG
@@ -1139,7 +1139,7 @@
 		goto out;
 
 	qdio_kick_inbound_handler(q);
-	if (iqdio_is_inbound_q_done(q))
+	if (tiqdio_is_inbound_q_done(q))
 		if (!qdio_stop_polling(q)) {
 			/* 
 			 * we set the flags to get into the stuff next time,
@@ -1401,7 +1401,7 @@
 	int result=-ENOMEM;
 
 	for (i=0;i<no_input_qs;i++) {
-		q=kmalloc(sizeof(struct qdio_q),GFP_KERNEL);
+		q=kmalloc(sizeof(struct qdio_q),GFP_KERNEL|GFP_DMA);
 
 		if (!q) {
 			QDIO_PRINT_ERR("kmalloc of q failed!\n");
@@ -1410,7 +1410,7 @@
 
 		memset(q,0,sizeof(struct qdio_q));
 
-		q->slib=kmalloc(PAGE_SIZE,GFP_KERNEL);
+		q->slib=kmalloc(PAGE_SIZE,GFP_KERNEL|GFP_DMA);
 		if (!q->slib) {
 			QDIO_PRINT_ERR("kmalloc of slib failed!\n");
 			goto out;
@@ -1420,7 +1420,7 @@
 	}
 
 	for (i=0;i<no_output_qs;i++) {
-		q=kmalloc(sizeof(struct qdio_q),GFP_KERNEL);
+		q=kmalloc(sizeof(struct qdio_q),GFP_KERNEL|GFP_DMA);
 
 		if (!q) {
 			goto out;
@@ -1428,7 +1428,7 @@
 
 		memset(q,0,sizeof(struct qdio_q));
 
-		q->slib=kmalloc(PAGE_SIZE,GFP_KERNEL);
+		q->slib=kmalloc(PAGE_SIZE,GFP_KERNEL|GFP_DMA);
 		if (!q->slib) {
 			QDIO_PRINT_ERR("kmalloc of slib failed!\n");
 			goto out;
