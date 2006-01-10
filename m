Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932339AbWAJTb2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932339AbWAJTb2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 14:31:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932471AbWAJTb2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 14:31:28 -0500
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:27490 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S932339AbWAJTb1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 14:31:27 -0500
Subject: [git patch review 1/7] IB/mthca: fix page shift calculation in
	mthca_reg_phys_mr()
From: Roland Dreier <rolandd@cisco.com>
Date: Tue, 10 Jan 2006 19:31:23 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1136921483290-436a68c58a7111c6@cisco.com>
X-OriginalArrivalTime: 10 Jan 2006 19:31:23.0395 (UTC) FILETIME=[70CBFD30:01C6161C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For all pages except possibly the last one, the byte beyond the buffer
end must be page aligned.  Therefore, when computing the page shift to
use, OR the end addresses of the buffers as well as the start
addresses into the mask we check.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/hw/mthca/mthca_provider.c |   18 +++++++-----------
 1 files changed, 7 insertions(+), 11 deletions(-)

6627fa662e86c400284b64c13661fdf6bff05983
diff --git a/drivers/infiniband/hw/mthca/mthca_provider.c b/drivers/infiniband/hw/mthca/mthca_provider.c
index 4cc7e28..30b67c2 100644
--- a/drivers/infiniband/hw/mthca/mthca_provider.c
+++ b/drivers/infiniband/hw/mthca/mthca_provider.c
@@ -783,24 +783,20 @@ static struct ib_mr *mthca_reg_phys_mr(s
 	if ((*iova_start & ~PAGE_MASK) != (buffer_list[0].addr & ~PAGE_MASK))
 		return ERR_PTR(-EINVAL);
 
-	if (num_phys_buf > 1 &&
-	    ((buffer_list[0].addr + buffer_list[0].size) & ~PAGE_MASK))
-		return ERR_PTR(-EINVAL);
-
 	mask = 0;
 	total_size = 0;
 	for (i = 0; i < num_phys_buf; ++i) {
-		if (i != 0 && buffer_list[i].addr & ~PAGE_MASK)
-			return ERR_PTR(-EINVAL);
-		if (i != 0 && i != num_phys_buf - 1 &&
-		    (buffer_list[i].size & ~PAGE_MASK))
-			return ERR_PTR(-EINVAL);
+		if (i != 0)
+			mask |= buffer_list[i].addr;
+		if (i != num_phys_buf - 1)
+			mask |= buffer_list[i].addr + buffer_list[i].size;
 
 		total_size += buffer_list[i].size;
-		if (i > 0)
-			mask |= buffer_list[i].addr;
 	}
 
+	if (mask & ~PAGE_MASK)
+		return ERR_PTR(-EINVAL);
+
 	/* Find largest page shift we can use to cover buffers */
 	for (shift = PAGE_SHIFT; shift < 31; ++shift)
 		if (num_phys_buf > 1) {
-- 
1.0.7
