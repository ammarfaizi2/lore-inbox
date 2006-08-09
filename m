Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030600AbWHIJKF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030600AbWHIJKF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 05:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030601AbWHIJKF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 05:10:05 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:39737 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1030600AbWHIJKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 05:10:03 -0400
Date: Wed, 9 Aug 2006 11:10:01 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, horst.hummel@de.ibm.com
Subject: [patch] s390: dasd set offline kernel bug.
Message-ID: <20060809091001.GA6497@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Horst Hummel <horst.hummel@de.ibm.com>

[S390] dasd set offline kernel bug.

The request queue flush function of the dasd driver has to dequeue
the requests first and then call the end request function. Otherwise
a kernel bug in ll_rw_block.c might get triggered.

Signed-off-by: Horst Hummel <horst.hummel@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/block/dasd.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -urpN linux-2.6/drivers/s390/block/dasd.c linux-2.6-patched/drivers/s390/block/dasd.c
--- linux-2.6/drivers/s390/block/dasd.c	2006-08-09 10:25:24.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/dasd.c	2006-08-09 10:25:42.000000000 +0200
@@ -1730,8 +1730,8 @@ dasd_flush_request_queue(struct dasd_dev
 		req = elv_next_request(device->request_queue);
 		if (req == NULL)
 			break;
-		dasd_end_request(req, 0);
 		blkdev_dequeue_request(req);
+		dasd_end_request(req, 0);
 	}
 	spin_unlock_irq(&device->request_queue_lock);
 }
