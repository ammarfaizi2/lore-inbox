Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266783AbUF3RNj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266783AbUF3RNj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 13:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266779AbUF3RNj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 13:13:39 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:42988 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S266783AbUF3RHp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 13:07:45 -0400
Date: Wed, 30 Jun 2004 19:08:10 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390: sclp console driver.
Message-ID: <20040630170810.GB3266@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] s390: sclp console driver.

From: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>

sclp console driver changes:
 - Correct handling of busy and not operational states.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 drivers/s390/char/sclp.c |   69 +++++++++++++++++++++++++++++++----------------
 1 files changed, 46 insertions(+), 23 deletions(-)

diff -urN linux-2.6/drivers/s390/char/sclp.c linux-2.6-s390/drivers/s390/char/sclp.c
--- linux-2.6/drivers/s390/char/sclp.c	Wed Jun 16 07:19:37 2004
+++ linux-2.6-s390/drivers/s390/char/sclp.c	Wed Jun 30 17:06:36 2004
@@ -52,6 +52,9 @@
 /* Timer for init mask retries. */
 static struct timer_list retry_timer;
 
+/* Timer for busy retries. */
+static struct timer_list sclp_busy_timer;
+
 static volatile unsigned long sclp_status = 0;
 /* some status flags */
 #define SCLP_INIT		0
@@ -59,6 +62,7 @@
 #define SCLP_READING		2
 
 #define SCLP_INIT_POLL_INTERVAL	1
+#define SCLP_BUSY_POLL_INTERVAL	1
 
 #define SCLP_COMMAND_INITIATED	0
 #define SCLP_BUSY		2
@@ -93,45 +97,61 @@
 	 */
 	if (cc == SCLP_NOT_OPERATIONAL)
 		return -EIO;
-	/*
-	 * We set the SCLP_RUNNING bit for cc 2 as well because if
-	 * service_call returns cc 2 some old request is running
-	 * that has to complete first
-	 */
-	set_bit(SCLP_RUNNING, &sclp_status);
 	if (cc == SCLP_BUSY)
 		return -EBUSY;
 	return 0;
 }
 
-static int
+static void
 sclp_start_request(void)
 {
 	struct sclp_req *req;
 	int rc;
 	unsigned long flags;
 
-	/* quick exit if sclp is already in use */
-	if (test_bit(SCLP_RUNNING, &sclp_status))
-		return -EBUSY;
 	spin_lock_irqsave(&sclp_lock, flags);
-	/* Get first request on queue if available */
-	req = NULL;
-	if (!list_empty(&sclp_req_queue))
+	/* quick exit if sclp is already in use */
+	if (test_bit(SCLP_RUNNING, &sclp_status)) {
+		spin_unlock_irqrestore(&sclp_lock, flags);
+		return;
+	}
+	/* Try to start requests from the request queue. */
+	while (!list_empty(&sclp_req_queue)) {
 		req = list_entry(sclp_req_queue.next, struct sclp_req, list);
-	if (req) {
 		rc = __service_call(req->command, req->sccb);
-		if (rc) {
-			req->status = SCLP_REQ_FAILED;
-			list_del(&req->list);
-		} else
+		if (rc == 0) {
+			/* Sucessfully started request. */
 			req->status = SCLP_REQ_RUNNING;
-	} else
-		rc = -EINVAL;
+			/* Request active. Set running indication. */
+			set_bit(SCLP_RUNNING, &sclp_status);
+			break;
+		}
+		if (rc == -EBUSY) {
+			/**
+			 * SCLP is busy but no request is running.
+			 * Try again later.
+			 */
+			if (!timer_pending(&sclp_busy_timer) ||
+			    !mod_timer(&sclp_busy_timer,
+				       jiffies + SCLP_BUSY_POLL_INTERVAL*HZ)) {
+				sclp_busy_timer.function =
+					(void *) sclp_start_request;
+				sclp_busy_timer.expires =
+					jiffies + SCLP_BUSY_POLL_INTERVAL*HZ;
+				add_timer(&sclp_busy_timer);
+			}
+			break;
+		}
+		/* Request failed. */
+		req->status = SCLP_REQ_FAILED;
+		list_del(&req->list);
+		if (req->callback) {
+			spin_unlock_irqrestore(&sclp_lock, flags);
+			req->callback(req, req->callback_data);
+			spin_lock_irqsave(&sclp_lock, flags);
+		}
+	}
 	spin_unlock_irqrestore(&sclp_lock, flags);
-	if (rc == -EIO && req->callback != NULL)
-		req->callback(req, req->callback_data);
-	return rc;
 }
 
 static int
@@ -613,6 +633,8 @@
 		 */
 		do {
 			rc = __service_call(req->command, req->sccb);
+			if (rc == 0)
+				set_bit(SCLP_RUNNING, &sclp_status);
 			spin_unlock_irqrestore(&sclp_lock, flags);
 			if (rc == -EIO)
 				return -ENOSYS;
@@ -685,6 +707,7 @@
 	ctl_set_bit(0, 9);
 
 	init_timer(&retry_timer);
+	init_timer(&sclp_busy_timer);
 	/* do the initial write event mask */
 	rc = sclp_init_mask();
 	if (rc == 0) {
