Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132144AbRDJPDF>; Tue, 10 Apr 2001 11:03:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132147AbRDJPCz>; Tue, 10 Apr 2001 11:02:55 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:49170 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S132144AbRDJPCp>; Tue, 10 Apr 2001 11:02:45 -0400
Message-Id: <200104101502.f3AF2hs31410@aslan.scsiguy.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix scsi_unblock_requests()
Date: Tue, 10 Apr 2001 09:02:43 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In its current implementation, scsi_unblock_requests() simply
clears host_self_blocked in the SCSI host struct.  This means
that either a transaction must complete or a new transaction
be issued before the mid-layer will recognize that it can
run the queues.  There is no guarantee that either of these
events will ever happen.

This patch attempts to run the queues manually when the host
unblocks.  scsi_queue_next_request() verifies all other state
to ensure queuing new transactions is safe prior to proceeding.

This patch is part of versions 6.1.10 and 6.1.11 of the
aic7xxx driver.  Its used, along with scsi_block_requests(), to
hold off the mid-layer during the initial bus settle delay without
resorting to a busy loop.

--
Justin

diff -u -r -N linux-2.4.3.virgin/drivers/scsi/scsi_lib.c linux-2.4.3/drivers/scsi/scsi_lib.c
--- linux-2.4.3.virgin/drivers/scsi/scsi_lib.c	Fri Mar  2 19:38:39 2001
+++ linux-2.4.3/drivers/scsi/scsi_lib.c	Thu Apr  5 14:28:17 2001
@@ -1108,9 +1108,13 @@
  */
 void scsi_unblock_requests(struct Scsi_Host * SHpnt)
 {
+	Scsi_Device *SDloop;
+
 	SHpnt->host_self_blocked = FALSE;
+	/* Now that we are unblocked, try to start the queues. */
+	for (SDloop = SHpnt->host_queue; SDloop; SDloop = SDloop->next)
+		scsi_queue_next_request(&SDloop->request_queue, NULL);
 }
-
 
 /*
  * Function:    scsi_report_bus_reset()
