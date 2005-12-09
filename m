Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964885AbVLIVwY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964885AbVLIVwY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 16:52:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964882AbVLIVwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 16:52:04 -0500
Received: from sj-iport-5.cisco.com ([171.68.10.87]:33320 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S932453AbVLIVv4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 16:51:56 -0500
X-IronPort-AV: i="3.99,235,1131350400"; 
   d="scan'208"; a="239406859:sNHT30959124"
Subject: [git patch review 4/5] IB/umad: fix memory leaks
From: Roland Dreier <rolandd@cisco.com>
Date: Fri, 09 Dec 2005 21:51:50 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1134165110301-ac635a95a66180bb@cisco.com>
In-Reply-To: <1134165110300-7535693e84cc230f@cisco.com>
X-OriginalArrivalTime: 09 Dec 2005 21:51:51.0491 (UTC) FILETIME=[C31D6130:01C5FD0A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don't leak packet if it had a timeout, and don't leak timeout struct
if queue_packet() fails.

Signed-off-by: Jack Morgenstein <jackm@mellanox.co.il>
Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/core/user_mad.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

0efc4883a6b3de12476cd7a35e638c0a9f5fd75f
diff --git a/drivers/infiniband/core/user_mad.c b/drivers/infiniband/core/user_mad.c
index eb7f525..c908de8 100644
--- a/drivers/infiniband/core/user_mad.c
+++ b/drivers/infiniband/core/user_mad.c
@@ -197,8 +197,8 @@ static void send_handler(struct ib_mad_a
 		memcpy(timeout->mad.data, packet->mad.data,
 		       sizeof (struct ib_mad_hdr));
 
-		if (!queue_packet(file, agent, timeout))
-				return;
+		if (queue_packet(file, agent, timeout))
+			kfree(timeout);
 	}
 out:
 	kfree(packet);
-- 
0.99.9l
