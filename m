Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932402AbWAUWDl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932402AbWAUWDl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 17:03:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932401AbWAUWDk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 17:03:40 -0500
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:42845 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S932402AbWAUWDR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 17:03:17 -0500
Subject: [git patch review 3/5] IB/sa_query: Flush scheduled work before
	unloading module
From: Roland Dreier <rolandd@cisco.com>
Date: Sat, 21 Jan 2006 22:03:10 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1137880990999-449ff8b55b88bcaa@cisco.com>
In-Reply-To: <1137880990999-7ca1217bcd8a8383@cisco.com>
X-OriginalArrivalTime: 21 Jan 2006 22:03:14.0773 (UTC) FILETIME=[7A253050:01C61ED6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sa_query schedules work on IB asynchronous events.  After
unregistering the async event handler, make sure that this work has
completed before releasing the IB device (and possibly allowing the
sa_query module text to go away).

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/core/sa_query.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

0f47ae0b3ec35dc5f4723f2e0ad0f6f3f55e9bcd
diff --git a/drivers/infiniband/core/sa_query.c b/drivers/infiniband/core/sa_query.c
index acda7d6..501cc05 100644
--- a/drivers/infiniband/core/sa_query.c
+++ b/drivers/infiniband/core/sa_query.c
@@ -956,6 +956,8 @@ static void ib_sa_remove_one(struct ib_d
 
 	ib_unregister_event_handler(&sa_dev->event_handler);
 
+	flush_scheduled_work();
+
 	for (i = 0; i <= sa_dev->end_port - sa_dev->start_port; ++i) {
 		ib_unregister_mad_agent(sa_dev->port[i].agent);
 		kref_put(&sa_dev->port[i].sm_ah->ref, free_sm_ah);
-- 
1.1.3
