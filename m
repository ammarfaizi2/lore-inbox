Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262905AbVDAU53@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262905AbVDAU53 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 15:57:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262920AbVDAU4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 15:56:46 -0500
Received: from webmail.topspin.com ([12.162.17.3]:35887 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S262905AbVDAUvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 15:51:14 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][14/27] IB/mthca: fix MTT allocation in mem-free mode
In-Reply-To: <2005411249.0FJpqa4lTtcUTWSU@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Fri, 1 Apr 2005 12:49:53 -0800
Message-Id: <2005411249.E7CWkenJFFkWDs2q@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 01 Apr 2005 20:49:53.0247 (UTC) FILETIME=[5AC55EF0:01C536FC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix bug in MTT allocation in mem-free mode.

I misunderstood the MTT size value returned by the firmware -- it is
really the size of a single MTT entry, since mem-free mode does not
segment the MTT as the original firmware did.  This meant that our MTT
addresses ended up being off by a factor of 8.  This meant that our
MTT allocations might overlap, and so we could overwrite and corrupt
earlier memory regions when writing new MTT entries.

We fix this by always using our 64-byte MTT segment size.  This allows
some simplification of the code as well, since there's no reason to
put the MTT segment size in a variable -- we can always use our enum
value directly.

Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_cmd.c	2005-04-01 12:38:20.843436141 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_cmd.c	2005-04-01 12:38:25.574409178 -0800
@@ -990,7 +990,6 @@
 		MTHCA_GET(field, outbox, QUERY_DEV_LIM_MAX_SG_RQ_OFFSET);
 		dev_lim->max_sg = min_t(int, field, dev_lim->max_sg);
 		MTHCA_GET(size, outbox, QUERY_DEV_LIM_MTT_ENTRY_SZ_OFFSET);
-		dev_lim->mtt_seg_sz = size;
 		MTHCA_GET(size, outbox, QUERY_DEV_LIM_MPT_ENTRY_SZ_OFFSET);
 		dev_lim->mpt_entry_sz = size;
 		MTHCA_GET(field, outbox, QUERY_DEV_LIM_PBL_SZ_OFFSET);
@@ -1018,7 +1017,6 @@
 	} else {
 		MTHCA_GET(field, outbox, QUERY_DEV_LIM_MAX_AV_OFFSET);
 		dev_lim->hca.tavor.max_avs = 1 << (field & 0x3f);
-		dev_lim->mtt_seg_sz   = MTHCA_MTT_SEG_SIZE;
 		dev_lim->mpt_entry_sz = MTHCA_MPT_ENTRY_SIZE;
 	}
 
--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_cmd.h	2005-03-31 19:06:42.000000000 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_cmd.h	2005-04-01 12:38:25.578408310 -0800
@@ -162,7 +162,6 @@
 	int cqc_entry_sz;
 	int srq_entry_sz;
 	int uar_scratch_entry_sz;
-	int mtt_seg_sz;
 	int mpt_entry_sz;
 	union {
 		struct {
--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_dev.h	2005-03-31 19:06:41.000000000 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_dev.h	2005-04-01 12:38:25.561412000 -0800
@@ -121,7 +121,6 @@
 	int      reserved_eqs;
 	int      num_mpts;
 	int      num_mtt_segs;
-	int      mtt_seg_size;
 	int      reserved_mtts;
 	int      reserved_mrws;
 	int      reserved_uars;
--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_main.c	2005-04-01 12:38:23.852782896 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_main.c	2005-04-01 12:38:25.566410914 -0800
@@ -390,7 +390,7 @@
 	}
 
 	mdev->mr_table.mtt_table = mthca_alloc_icm_table(mdev, init_hca->mtt_base,
-							 dev_lim->mtt_seg_sz,
+							 MTHCA_MTT_SEG_SIZE,
 							 mdev->limits.num_mtt_segs,
 							 mdev->limits.reserved_mtts, 1);
 	if (!mdev->mr_table.mtt_table) {
--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_mr.c	2005-04-01 12:38:22.968974746 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_mr.c	2005-04-01 12:38:25.582407442 -0800
@@ -263,7 +263,7 @@
 			goto err_out_mpt_free;
 	}
 
-	for (i = dev->limits.mtt_seg_size / 8, mr->order = 0;
+	for (i = MTHCA_MTT_SEG_SIZE / 8, mr->order = 0;
 	     i < list_len;
 	     i <<= 1, ++mr->order)
 		; /* nothing */
@@ -286,7 +286,7 @@
 	mtt_entry = MAILBOX_ALIGN(mailbox);
 
 	mtt_entry[0] = cpu_to_be64(dev->mr_table.mtt_base +
-				   mr->first_seg * dev->limits.mtt_seg_size);
+				   mr->first_seg * MTHCA_MTT_SEG_SIZE);
 	mtt_entry[1] = 0;
 	for (i = 0; i < list_len; ++i)
 		mtt_entry[i + 2] = cpu_to_be64(buffer_list[i] |
@@ -330,7 +330,7 @@
 	memset(&mpt_entry->lkey, 0,
 	       sizeof *mpt_entry - offsetof(struct mthca_mpt_entry, lkey));
 	mpt_entry->mtt_seg   = cpu_to_be64(dev->mr_table.mtt_base +
-					   mr->first_seg * dev->limits.mtt_seg_size);
+					   mr->first_seg * MTHCA_MTT_SEG_SIZE);
 
 	if (0) {
 		mthca_dbg(dev, "Dumping MPT entry %08x:\n", mr->ibmr.lkey);
--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_profile.c	2005-04-01 12:38:21.237350633 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_profile.c	2005-04-01 12:38:25.570410046 -0800
@@ -95,7 +95,7 @@
 	profile[MTHCA_RES_RDB].size  = MTHCA_RDB_ENTRY_SIZE;
 	profile[MTHCA_RES_MCG].size  = MTHCA_MGM_ENTRY_SIZE;
 	profile[MTHCA_RES_MPT].size  = dev_lim->mpt_entry_sz;
-	profile[MTHCA_RES_MTT].size  = dev_lim->mtt_seg_sz;
+	profile[MTHCA_RES_MTT].size  = MTHCA_MTT_SEG_SIZE;
 	profile[MTHCA_RES_UAR].size  = dev_lim->uar_scratch_entry_sz;
 	profile[MTHCA_RES_UDAV].size = MTHCA_AV_SIZE;
 	profile[MTHCA_RES_UARC].size = request->uarc_size;
@@ -229,10 +229,9 @@
 			break;
 		case MTHCA_RES_MTT:
 			dev->limits.num_mtt_segs = profile[i].num;
-			dev->limits.mtt_seg_size = dev_lim->mtt_seg_sz;
 			dev->mr_table.mtt_base   = profile[i].start;
 			init_hca->mtt_base       = profile[i].start;
-			init_hca->mtt_seg_sz     = ffs(dev_lim->mtt_seg_sz) - 7;
+			init_hca->mtt_seg_sz     = ffs(MTHCA_MTT_SEG_SIZE) - 7;
 			break;
 		case MTHCA_RES_UAR:
 			dev->limits.num_uars       = profile[i].num;

