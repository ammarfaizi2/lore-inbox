Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030383AbWBHMci@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030383AbWBHMci (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 07:32:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030390AbWBHMci
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 07:32:38 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:44631 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1030384AbWBHMch (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 07:32:37 -0500
Date: Wed, 8 Feb 2006 13:32:35 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org,
       Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Subject: [patch 02/10] s390: fix sclp memory corruption in tty pages list
Message-ID: <20060208123235.GC1656@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>

When the sclp interface takes very long to serve a request, the sclp core
driver will report a failed request to the sclp tty driver even though
the request is still being processed by the sclp interface.
Eventually the sclp interface completes the request and updates some fields
in the request buffer which leads to a corrupted tty pages list. The next
time function sclp_tty_write_room is called, the corrupted list will be
traversed, resulting in an oops.

To avoid this remove the busy retry limit and increase retry intervals.

Signed-off-by: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 drivers/s390/char/sclp.c |   13 +++++--------
 1 files changed, 5 insertions(+), 8 deletions(-)

diff -urpN linux-2.6/drivers/s390/char/sclp.c linux-2.6-patched/drivers/s390/char/sclp.c
--- linux-2.6/drivers/s390/char/sclp.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6-patched/drivers/s390/char/sclp.c	2006-02-08 10:48:42.000000000 +0100
@@ -85,11 +85,10 @@ static volatile enum sclp_mask_state_t {
 /* Maximum retry counts */
 #define SCLP_INIT_RETRY		3
 #define SCLP_MASK_RETRY		3
-#define SCLP_REQUEST_RETRY	3
 
 /* Timeout intervals in seconds.*/
-#define SCLP_BUSY_INTERVAL	2
-#define SCLP_RETRY_INTERVAL	5
+#define SCLP_BUSY_INTERVAL	10
+#define SCLP_RETRY_INTERVAL	15
 
 static void sclp_process_queue(void);
 static int sclp_init_mask(int calculate);
@@ -153,11 +152,9 @@ __sclp_start_request(struct sclp_req *re
 	if (sclp_running_state != sclp_running_state_idle)
 		return 0;
 	del_timer(&sclp_request_timer);
-	if (req->start_count <= SCLP_REQUEST_RETRY) {
-		rc = service_call(req->command, req->sccb);
-		req->start_count++;
-	} else
-		rc = -EIO;
+	rc = service_call(req->command, req->sccb);
+	req->start_count++;
+
 	if (rc == 0) {
 		/* Sucessfully started request */
 		req->status = SCLP_REQ_RUNNING;
