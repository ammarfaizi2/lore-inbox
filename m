Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932517AbWAGA25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932517AbWAGA25 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 19:28:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965381AbWAGA24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 19:28:56 -0500
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:17335 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S965383AbWAGAZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 19:25:50 -0500
Subject: [git patch review 4/8] IB/mthca: multiple fixes for multicast group
	handling
From: Roland Dreier <rolandd@cisco.com>
Date: Sat, 07 Jan 2006 00:25:42 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1136593542999-1260d5ab9345c4eb@cisco.com>
In-Reply-To: <1136593542999-f3246e38ef6bb0f5@cisco.com>
X-OriginalArrivalTime: 07 Jan 2006 00:25:47.0867 (UTC) FILETIME=[E7FD82B0:01C61320]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Multicast group management fixes:
. Fix leak of mailbox memory in error handling on multicast group operations.
. Free AMGM indices at detach and in attach error handling.
. Fix amount to shift for aligning next_gid_index in mailbox: it
  starts at bit 6, not bit 5.
. Allocate AMGM index after end of MGM table, in the range num_mgms to
  multicast table size - 1. Add some BUG_ON checks to catch cases
  where the index falls in the MGM hash area.
. Initialize the list of QPs in a newly-allocated group from AMGM to 0
  This is necessary since when a group is moved from AMGM to MGM (in the
  case where the MGM entry has been emptied of QPs), the AMGM entry is
  not reset to 0 (and we don't want an extra command to do that).

Signed-off-by: Jack Morgenstein <jackm@mellanox.co.il>
Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/hw/mthca/mthca_mcg.c |   54 ++++++++++++++++++++-----------
 1 files changed, 35 insertions(+), 19 deletions(-)

5ceb74557c71465cf8f6fda050aac00e53f9ad3d
diff --git a/drivers/infiniband/hw/mthca/mthca_mcg.c b/drivers/infiniband/hw/mthca/mthca_mcg.c
index 2fc449d..77bc6c7 100644
--- a/drivers/infiniband/hw/mthca/mthca_mcg.c
+++ b/drivers/infiniband/hw/mthca/mthca_mcg.c
@@ -111,7 +111,8 @@ static int find_mgm(struct mthca_dev *de
 			goto out;
 		if (status) {
 			mthca_err(dev, "READ_MGM returned status %02x\n", status);
-			return -EINVAL;
+			err = -EINVAL;
+			goto out;
 		}
 
 		if (!memcmp(mgm->gid, zero_gid, 16)) {
@@ -126,7 +127,7 @@ static int find_mgm(struct mthca_dev *de
 			goto out;
 
 		*prev = *index;
-		*index = be32_to_cpu(mgm->next_gid_index) >> 5;
+		*index = be32_to_cpu(mgm->next_gid_index) >> 6;
 	} while (*index);
 
 	*index = -1;
@@ -153,8 +154,10 @@ int mthca_multicast_attach(struct ib_qp 
 		return PTR_ERR(mailbox);
 	mgm = mailbox->buf;
 
-	if (down_interruptible(&dev->mcg_table.sem))
-		return -EINTR;
+	if (down_interruptible(&dev->mcg_table.sem)) {
+		err = -EINTR;
+		goto err_sem;
+	}
 
 	err = find_mgm(dev, gid->raw, mailbox, &hash, &prev, &index);
 	if (err)
@@ -181,9 +184,8 @@ int mthca_multicast_attach(struct ib_qp 
 			err = -EINVAL;
 			goto out;
 		}
-
+		memset(mgm, 0, sizeof *mgm);
 		memcpy(mgm->gid, gid->raw, 16);
-		mgm->next_gid_index = 0;
 	}
 
 	for (i = 0; i < MTHCA_QP_PER_MGM; ++i)
@@ -209,6 +211,7 @@ int mthca_multicast_attach(struct ib_qp 
 	if (status) {
 		mthca_err(dev, "WRITE_MGM returned status %02x\n", status);
 		err = -EINVAL;
+		goto out;
 	}
 
 	if (!link)
@@ -223,7 +226,7 @@ int mthca_multicast_attach(struct ib_qp 
 		goto out;
 	}
 
-	mgm->next_gid_index = cpu_to_be32(index << 5);
+	mgm->next_gid_index = cpu_to_be32(index << 6);
 
 	err = mthca_WRITE_MGM(dev, prev, mailbox, &status);
 	if (err)
@@ -234,7 +237,12 @@ int mthca_multicast_attach(struct ib_qp 
 	}
 
  out:
+	if (err && link && index != -1) {
+		BUG_ON(index < dev->limits.num_mgms);
+		mthca_free(&dev->mcg_table.alloc, index);
+	}
 	up(&dev->mcg_table.sem);
+ err_sem:
 	mthca_free_mailbox(dev, mailbox);
 	return err;
 }
@@ -255,8 +263,10 @@ int mthca_multicast_detach(struct ib_qp 
 		return PTR_ERR(mailbox);
 	mgm = mailbox->buf;
 
-	if (down_interruptible(&dev->mcg_table.sem))
-		return -EINTR;
+	if (down_interruptible(&dev->mcg_table.sem)) {
+		err = -EINTR;
+		goto err_sem;
+	}
 
 	err = find_mgm(dev, gid->raw, mailbox, &hash, &prev, &index);
 	if (err)
@@ -305,13 +315,11 @@ int mthca_multicast_detach(struct ib_qp 
 	if (i != 1)
 		goto out;
 
-	goto out;
-
 	if (prev == -1) {
 		/* Remove entry from MGM */
-		if (be32_to_cpu(mgm->next_gid_index) >> 5) {
-			err = mthca_READ_MGM(dev,
-					     be32_to_cpu(mgm->next_gid_index) >> 5,
+		int amgm_index_to_free = be32_to_cpu(mgm->next_gid_index) >> 6;
+		if (amgm_index_to_free) {
+			err = mthca_READ_MGM(dev, amgm_index_to_free,
 					     mailbox, &status);
 			if (err)
 				goto out;
@@ -332,9 +340,13 @@ int mthca_multicast_detach(struct ib_qp 
 			err = -EINVAL;
 			goto out;
 		}
+		if (amgm_index_to_free) {
+			BUG_ON(amgm_index_to_free < dev->limits.num_mgms);
+			mthca_free(&dev->mcg_table.alloc, amgm_index_to_free);
+		}
 	} else {
 		/* Remove entry from AMGM */
-		index = be32_to_cpu(mgm->next_gid_index) >> 5;
+		int curr_next_index = be32_to_cpu(mgm->next_gid_index) >> 6;
 		err = mthca_READ_MGM(dev, prev, mailbox, &status);
 		if (err)
 			goto out;
@@ -344,7 +356,7 @@ int mthca_multicast_detach(struct ib_qp 
 			goto out;
 		}
 
-		mgm->next_gid_index = cpu_to_be32(index << 5);
+		mgm->next_gid_index = cpu_to_be32(curr_next_index << 6);
 
 		err = mthca_WRITE_MGM(dev, prev, mailbox, &status);
 		if (err)
@@ -354,10 +366,13 @@ int mthca_multicast_detach(struct ib_qp 
 			err = -EINVAL;
 			goto out;
 		}
+		BUG_ON(index < dev->limits.num_mgms);
+		mthca_free(&dev->mcg_table.alloc, index);
 	}
 
  out:
 	up(&dev->mcg_table.sem);
+ err_sem:
 	mthca_free_mailbox(dev, mailbox);
 	return err;
 }
@@ -365,11 +380,12 @@ int mthca_multicast_detach(struct ib_qp 
 int __devinit mthca_init_mcg_table(struct mthca_dev *dev)
 {
 	int err;
+	int table_size = dev->limits.num_mgms + dev->limits.num_amgms;
 
 	err = mthca_alloc_init(&dev->mcg_table.alloc,
-			       dev->limits.num_amgms,
-			       dev->limits.num_amgms - 1,
-			       0);
+			       table_size,
+			       table_size - 1,
+			       dev->limits.num_mgms);
 	if (err)
 		return err;
 
-- 
0.99.9n
