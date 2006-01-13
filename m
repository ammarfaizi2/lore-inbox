Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161588AbWAMANv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161588AbWAMANv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 19:13:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161601AbWAMANv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 19:13:51 -0500
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:64036 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S1161594AbWAMAN3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 19:13:29 -0500
X-IronPort-AV: i="3.99,361,1131350400"; 
   d="scan'208"; a="391186732:sNHT1479818034"
Subject: [git patch review 4/6] IB/mthca: Fix memory leaks in error handling
From: Roland Dreier <rolandd@cisco.com>
Date: Fri, 13 Jan 2006 00:13:17 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1137111197380-64102fbf42547cb5@cisco.com>
In-Reply-To: <1137111197380-7741e9b26c0a0236@cisco.com>
X-OriginalArrivalTime: 13 Jan 2006 00:13:22.0592 (UTC) FILETIME=[2A401200:01C617D6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix memory leaks in mthca_create_qp() and mthca_create_srq()
error handling.

Signed-off-by: Jack Morgenstein <jackm@mellanox.co.il>
Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/hw/mthca/mthca_provider.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

17e2e819517d75f2f3407e59c5f7f6f0ef305d14
diff --git a/drivers/infiniband/hw/mthca/mthca_provider.c b/drivers/infiniband/hw/mthca/mthca_provider.c
index db35690..484a7e6 100644
--- a/drivers/infiniband/hw/mthca/mthca_provider.c
+++ b/drivers/infiniband/hw/mthca/mthca_provider.c
@@ -445,8 +445,10 @@ static struct ib_srq *mthca_create_srq(s
 	if (pd->uobject) {
 		context = to_mucontext(pd->uobject->context);
 
-		if (ib_copy_from_udata(&ucmd, udata, sizeof ucmd))
-			return ERR_PTR(-EFAULT);
+		if (ib_copy_from_udata(&ucmd, udata, sizeof ucmd)) {
+			err = -EFAULT;
+			goto err_free;
+		}
 
 		err = mthca_map_user_db(to_mdev(pd->device), &context->uar,
 					context->db_tab, ucmd.db_index,
@@ -522,8 +524,10 @@ static struct ib_qp *mthca_create_qp(str
 		if (pd->uobject) {
 			context = to_mucontext(pd->uobject->context);
 
-			if (ib_copy_from_udata(&ucmd, udata, sizeof ucmd))
+			if (ib_copy_from_udata(&ucmd, udata, sizeof ucmd)) {
+				kfree(qp);
 				return ERR_PTR(-EFAULT);
+			}
 
 			err = mthca_map_user_db(to_mdev(pd->device), &context->uar,
 						context->db_tab,
-- 
1.0.7
