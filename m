Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932344AbWAJTb3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932344AbWAJTb3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 14:31:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932471AbWAJTb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 14:31:29 -0500
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:44614 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S932344AbWAJTb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 14:31:28 -0500
X-IronPort-AV: i="3.99,351,1131350400"; 
   d="scan'208"; a="389971617:sNHT31852412"
Subject: [git patch review 2/7] IB/mthca: prevent event queue overrun
From: Roland Dreier <rolandd@cisco.com>
Date: Tue, 10 Jan 2006 19:31:23 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1136921483290-79d0774f48f3f587@cisco.com>
In-Reply-To: <1136921483290-436a68c58a7111c6@cisco.com>
X-OriginalArrivalTime: 10 Jan 2006 19:31:24.0864 (UTC) FILETIME=[71AC2400:01C6161C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am seeing EQ overruns in SDP stress tests: if the CQ completion
handler arms a CQ, this could generate more EQEs, so that EQ will
never get empty and consumer index will never get updated.

This is similiar to what we have with command interface:
		/*
		 * cmd_event() may add more commands.
		 * The card will think the queue has overflowed if
		 * we don't tell it we've been processing events.
		 */
However, for completion events, we *don't* want to update the consumer
index on each event. So, perform EQ doorbell coalescing: allocate EQs
with some spare EQEs, and update once we run out of them.

The value 0x80 was selected to avoid any performance impact.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/hw/mthca/mthca_eq.c |   28 +++++++++++++++-------------
 1 files changed, 15 insertions(+), 13 deletions(-)

92898522e3ee1a0ba54140aad1974d9e868f74ae
diff --git a/drivers/infiniband/hw/mthca/mthca_eq.c b/drivers/infiniband/hw/mthca/mthca_eq.c
index e8a948f..2eabb27 100644
--- a/drivers/infiniband/hw/mthca/mthca_eq.c
+++ b/drivers/infiniband/hw/mthca/mthca_eq.c
@@ -45,6 +45,7 @@
 enum {
 	MTHCA_NUM_ASYNC_EQE = 0x80,
 	MTHCA_NUM_CMD_EQE   = 0x80,
+	MTHCA_NUM_SPARE_EQE = 0x80,
 	MTHCA_EQ_ENTRY_SIZE = 0x20
 };
 
@@ -277,11 +278,10 @@ static int mthca_eq_int(struct mthca_dev
 {
 	struct mthca_eqe *eqe;
 	int disarm_cqn;
-	int  eqes_found = 0;
+	int eqes_found = 0;
+	int set_ci = 0;
 
 	while ((eqe = next_eqe_sw(eq))) {
-		int set_ci = 0;
-
 		/*
 		 * Make sure we read EQ entry contents after we've
 		 * checked the ownership bit.
@@ -345,12 +345,6 @@ static int mthca_eq_int(struct mthca_dev
 					be16_to_cpu(eqe->event.cmd.token),
 					eqe->event.cmd.status,
 					be64_to_cpu(eqe->event.cmd.out_param));
-			/*
-			 * cmd_event() may add more commands.
-			 * The card will think the queue has overflowed if
-			 * we don't tell it we've been processing events.
-			 */
-			set_ci = 1;
 			break;
 
 		case MTHCA_EVENT_TYPE_PORT_CHANGE:
@@ -385,8 +379,16 @@ static int mthca_eq_int(struct mthca_dev
 		set_eqe_hw(eqe);
 		++eq->cons_index;
 		eqes_found = 1;
+		++set_ci;
 
-		if (unlikely(set_ci)) {
+		/*
+		 * The HCA will think the queue has overflowed if we
+		 * don't tell it we've been processing events.  We
+		 * create our EQs with MTHCA_NUM_SPARE_EQE extra
+		 * entries, so we must update our consumer index at
+		 * least that often.
+		 */
+		if (unlikely(set_ci >= MTHCA_NUM_SPARE_EQE)) {
 			/*
 			 * Conditional on hca_type is OK here because
 			 * this is a rare case, not the fast path.
@@ -862,19 +864,19 @@ int __devinit mthca_init_eq_table(struct
 	intr = (dev->mthca_flags & MTHCA_FLAG_MSI) ?
 		128 : dev->eq_table.inta_pin;
 
-	err = mthca_create_eq(dev, dev->limits.num_cqs,
+	err = mthca_create_eq(dev, dev->limits.num_cqs + MTHCA_NUM_SPARE_EQE,
 			      (dev->mthca_flags & MTHCA_FLAG_MSI_X) ? 128 : intr,
 			      &dev->eq_table.eq[MTHCA_EQ_COMP]);
 	if (err)
 		goto err_out_unmap;
 
-	err = mthca_create_eq(dev, MTHCA_NUM_ASYNC_EQE,
+	err = mthca_create_eq(dev, MTHCA_NUM_ASYNC_EQE + MTHCA_NUM_SPARE_EQE,
 			      (dev->mthca_flags & MTHCA_FLAG_MSI_X) ? 129 : intr,
 			      &dev->eq_table.eq[MTHCA_EQ_ASYNC]);
 	if (err)
 		goto err_out_comp;
 
-	err = mthca_create_eq(dev, MTHCA_NUM_CMD_EQE,
+	err = mthca_create_eq(dev, MTHCA_NUM_CMD_EQE + MTHCA_NUM_SPARE_EQE,
 			      (dev->mthca_flags & MTHCA_FLAG_MSI_X) ? 130 : intr,
 			      &dev->eq_table.eq[MTHCA_EQ_CMD]);
 	if (err)
-- 
1.0.7
