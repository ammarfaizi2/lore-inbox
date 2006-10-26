Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422747AbWJZJC4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422747AbWJZJC4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 05:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752131AbWJZJC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 05:02:56 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:34597 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP
	id S1752130AbWJZJCz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 05:02:55 -0400
Date: Thu, 26 Oct 2006 11:02:53 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, rwuerthn@de.ibm.com
Subject: [S390] Improve AP bus device removal.
Message-ID: <20061026090253.GD16270@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ralph Wuerthner <rwuerthn@de.ibm.com>

[S390] Improve AP bus device removal.

Added a call to device_unregister() in ap_scan_bus() to actively
remove unavailable AP bus devices with every bus scan. Previously 
devices were only removed in ap_queue_message() or __ap_poll_all().

Signed-off-by: Ralph Wuerthner <rwuerthn@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/crypto/ap_bus.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletion(-)

diff -urpN linux-2.6/drivers/s390/crypto/ap_bus.c linux-2.6-patched/drivers/s390/crypto/ap_bus.c
--- linux-2.6/drivers/s390/crypto/ap_bus.c	2006-10-26 10:43:46.000000000 +0200
+++ linux-2.6-patched/drivers/s390/crypto/ap_bus.c	2006-10-26 10:44:05.000000000 +0200
@@ -739,11 +739,16 @@ static void ap_scan_bus(void *data)
 		dev = bus_find_device(&ap_bus_type, NULL,
 				      (void *)(unsigned long)qid,
 				      __ap_scan_bus);
+		rc = ap_query_queue(qid, &queue_depth, &device_type);
+		if (dev && rc) {
+			put_device(dev);
+			device_unregister(dev);
+			continue;
+		}
 		if (dev) {
 			put_device(dev);
 			continue;
 		}
-		rc = ap_query_queue(qid, &queue_depth, &device_type);
 		if (rc)
 			continue;
 		rc = ap_init_queue(qid);
