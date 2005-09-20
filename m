Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965126AbVITWKG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965126AbVITWKG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 18:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965132AbVITWJB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 18:09:01 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:886 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S965165AbVITWI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 18:08:27 -0400
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH 05/10] IB/mthca: Initialize eq->nent before we use it
In-Reply-To: <2005920158.QCEMsU9kiixrkQEA@cisco.com>
X-Mailer: Roland's Patchbomber
Date: Tue, 20 Sep 2005 15:08:11 -0700
Message-Id: <2005920158.G3atJmbH9pmjSQjI@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <rolandd@cisco.com>
X-OriginalArrivalTime: 20 Sep 2005 22:08:12.0823 (UTC) FILETIME=[CAFCC270:01C5BE2F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In mthca_create_eq(), we call get_eqe() before setting eq->nent.  This
is wrong, because get_eqe() uses eq->nent.  Fix this, and clean up the
code a little while we're at it.  (We got lucky with the current code,
because eq->nent was cleared to 0, which get_eqe() made happen to do
the right thing)

Pointed out by Michael S. Tsirkin <mst@mellanox.co.il>

Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/hw/mthca/mthca_eq.c |   16 +++++-----------
 1 files changed, 5 insertions(+), 11 deletions(-)

8b194835d2f28c793d25d2c41753af2b7ee29f31
diff --git a/drivers/infiniband/hw/mthca/mthca_eq.c b/drivers/infiniband/hw/mthca/mthca_eq.c
--- a/drivers/infiniband/hw/mthca/mthca_eq.c
+++ b/drivers/infiniband/hw/mthca/mthca_eq.c
@@ -476,12 +476,8 @@ static int __devinit mthca_create_eq(str
 	int i;
 	u8 status;
 
-	/* Make sure EQ size is aligned to a power of 2 size. */
-	for (i = 1; i < nent; i <<= 1)
-		; /* nothing */
-	nent = i;
-
-	eq->dev = dev;
+	eq->dev  = dev;
+	eq->nent = roundup_pow_of_two(max(nent, 2));
 
 	eq->page_list = kmalloc(npages * sizeof *eq->page_list,
 				GFP_KERNEL);
@@ -512,7 +508,7 @@ static int __devinit mthca_create_eq(str
 		memset(eq->page_list[i].buf, 0, PAGE_SIZE);
 	}
 
-	for (i = 0; i < nent; ++i)
+	for (i = 0; i < eq->nent; ++i)
 		set_eqe_hw(get_eqe(eq, i));
 
 	eq->eqn = mthca_alloc(&dev->eq_table.alloc);
@@ -528,8 +524,6 @@ static int __devinit mthca_create_eq(str
 	if (err)
 		goto err_out_free_eq;
 
-	eq->nent = nent;
-
 	memset(eq_context, 0, sizeof *eq_context);
 	eq_context->flags           = cpu_to_be32(MTHCA_EQ_STATUS_OK   |
 						  MTHCA_EQ_OWNER_HW    |
@@ -538,7 +532,7 @@ static int __devinit mthca_create_eq(str
 	if (mthca_is_memfree(dev))
 		eq_context->flags  |= cpu_to_be32(MTHCA_EQ_STATE_ARBEL);
 
-	eq_context->logsize_usrpage = cpu_to_be32((ffs(nent) - 1) << 24);
+	eq_context->logsize_usrpage = cpu_to_be32((ffs(eq->nent) - 1) << 24);
 	if (mthca_is_memfree(dev)) {
 		eq_context->arbel_pd = cpu_to_be32(dev->driver_pd.pd_num);
 	} else {
@@ -569,7 +563,7 @@ static int __devinit mthca_create_eq(str
 	dev->eq_table.arm_mask |= eq->eqn_mask;
 
 	mthca_dbg(dev, "Allocated EQ %d with %d entries\n",
-		  eq->eqn, nent);
+		  eq->eqn, eq->nent);
 
 	return err;
 
