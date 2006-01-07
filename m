Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965376AbWAGA1D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965376AbWAGA1D (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 19:27:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965372AbWAGAZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 19:25:57 -0500
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:63403 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S965381AbWAGAZt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 19:25:49 -0500
X-IronPort-AV: i="3.99,341,1131350400"; 
   d="scan'208"; a="388438784:sNHT29931748"
Subject: [git patch review 7/8] IB/uverbs: Fix reference counting on error
	paths
From: Roland Dreier <rolandd@cisco.com>
Date: Sat, 07 Jan 2006 00:25:42 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1136593543000-bf2926ca65fa9af8@cisco.com>
In-Reply-To: <1136593543000-c8b76b848fc384d6@cisco.com>
X-OriginalArrivalTime: 07 Jan 2006 00:25:46.0086 (UTC) FILETIME=[E6EDC060:01C61320]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If an operation fails after incrementing an object's reference count,
then it should decrement the reference count on the error path.

Signed-off-by: Jack Morgenstein <jackm@mellanox.co.il>
Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/core/uverbs_cmd.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

b4ca1a3f8ca24033d7b7ef595faef97d9f8b2326
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index a57d021..6985a57 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -489,6 +489,7 @@ err_idr:
 
 err_unreg:
 	ib_dereg_mr(mr);
+	atomic_dec(&pd->usecnt);
 
 err_up:
 	up(&ib_uverbs_idr_mutex);
@@ -935,6 +936,11 @@ err_idr:
 
 err_destroy:
 	ib_destroy_qp(qp);
+	atomic_dec(&pd->usecnt);
+	atomic_dec(&attr.send_cq->usecnt);
+	atomic_dec(&attr.recv_cq->usecnt);
+	if (attr.srq)
+		atomic_dec(&attr.srq->usecnt);
 
 err_up:
 	up(&ib_uverbs_idr_mutex);
@@ -1729,6 +1735,7 @@ err_idr:
 
 err_destroy:
 	ib_destroy_srq(srq);
+	atomic_dec(&pd->usecnt);
 
 err_up:
 	up(&ib_uverbs_idr_mutex);
-- 
0.99.9n
