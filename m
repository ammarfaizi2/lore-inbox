Return-Path: <linux-kernel-owner+w=401wt.eu-S1752817AbWLOQVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752817AbWLOQVk (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 11:21:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752825AbWLOQVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 11:21:40 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:65246 "EHLO
	mtagate1.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752822AbWLOQVf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 11:21:35 -0500
Date: Fri, 15 Dec 2006 17:21:27 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, braunu@de.ibm.com
Subject: [S390] Hipersocket multicast queue: make sure outbound handler is called
Message-ID: <20061215162127.GC4920@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ursula Braun <braunu@de.ibm.com>

[S390] Hipersocket multicast queue: make sure outbound handler is called

A HiperSocket multicast queue works asynchronously. When sending
buffers, the buffer state change from PRIMED to EMPTY may happen
delayed. Reschedule the checking for changes in the outbound queue,
if there are still PRIMED buffers.

Signed-off-by: Ursula Braun <braunu@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/qdio.c |   13 ++++++++-----
 include/asm-s390/qdio.h |    1 +
 2 files changed, 9 insertions(+), 5 deletions(-)

diff -urpN linux-2.6/drivers/s390/cio/qdio.c linux-2.6-patched/drivers/s390/cio/qdio.c
--- linux-2.6/drivers/s390/cio/qdio.c	2006-12-15 16:54:55.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/qdio.c	2006-12-15 16:55:07.000000000 +0100
@@ -979,12 +979,11 @@ __qdio_outbound_processing(struct qdio_q
 
 	if (q->is_iqdio_q) {
 		/* 
-		 * for asynchronous queues, we better check, if the fill
-		 * level is too high. for synchronous queues, the fill
-		 * level will never be that high. 
+		 * for asynchronous queues, we better check, if the sent
+		 * buffer is already switched from PRIMED to EMPTY.
 		 */
-		if (atomic_read(&q->number_of_buffers_used)>
-		    IQDIO_FILL_LEVEL_TO_POLL)
+		if ((q->queue_type == QDIO_IQDIO_QFMT_ASYNCH) &&
+		    !qdio_is_outbound_q_done(q))
 			qdio_mark_q(q);
 
 	} else if (!q->hydra_gives_outbound_pcis)
@@ -1825,6 +1824,10 @@ qdio_fill_qs(struct qdio_irq *irq_ptr, s
 			q->sbal[j]=*(outbound_sbals_array++);
 
                 q->queue_type=q_format;
+		if ((q->queue_type == QDIO_IQDIO_QFMT) &&
+		    (no_output_qs > 1) &&
+		    (i == no_output_qs-1))
+			q->queue_type = QDIO_IQDIO_QFMT_ASYNCH;
 		q->int_parm=int_parm;
 		q->is_input_q=0;
 		q->schid = irq_ptr->schid;
diff -urpN linux-2.6/include/asm-s390/qdio.h linux-2.6-patched/include/asm-s390/qdio.h
--- linux-2.6/include/asm-s390/qdio.h	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6-patched/include/asm-s390/qdio.h	2006-12-15 16:55:07.000000000 +0100
@@ -34,6 +34,7 @@
 #define QDIO_QETH_QFMT 0
 #define QDIO_ZFCP_QFMT 1
 #define QDIO_IQDIO_QFMT 2
+#define QDIO_IQDIO_QFMT_ASYNCH 3
 
 struct qdio_buffer_element{
 	unsigned int flags;
