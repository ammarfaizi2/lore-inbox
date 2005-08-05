Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262837AbVHEDrS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262837AbVHEDrS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 23:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262842AbVHEDrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 23:47:18 -0400
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:20316 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S262837AbVHEDrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 23:47:16 -0400
To: yhlu <yhlu.kernel@gmail.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: mthca and LinuxBIOS
X-Message-Flag: Warning: May contain useful information
References: <20057281331.dR47KhjBsU48JfGE@cisco.com>
	<20057281331.7vqhiAJ1Yc0um2je@cisco.com>
	<86802c44050803175873fb0569@mail.gmail.com>
	<52u0i6b9an.fsf_-_@cisco.com>
	<86802c44050804093374aca360@mail.gmail.com> <52mznxacbp.fsf@cisco.com>
	<86802c4405080410236ba59619@mail.gmail.com>
	<86802c4405080411013b60382c@mail.gmail.com> <521x59a6tb.fsf@cisco.com>
	<86802c440508041230143354c2@mail.gmail.com>
From: Roland Dreier <rolandd@cisco.com>
Date: Thu, 04 Aug 2005 20:47:12 -0700
In-Reply-To: <86802c440508041230143354c2@mail.gmail.com> (yhlu's message of
 "Thu, 4 Aug 2005 12:30:17 -0700")
Message-ID: <52slxp6o5b.fsf@cisco.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 05 Aug 2005 03:47:12.0805 (UTC) FILETIME=[5D257550:01C59970]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm, that output all looks fine.  Can you run with the patch below to
see exactly where the QP table initialization fails?  (I haven't
actually compiled this patch so you may have to fix a typo or two)

I'm guessing that the CONF_SPECIAL_QP command is failing, but let's
make sure.

Thanks,
  Roland

diff --git a/drivers/infiniband/hw/mthca/mthca_qp.c b/drivers/infiniband/hw/mthca/mthca_qp.c
--- a/drivers/infiniband/hw/mthca/mthca_qp.c
+++ b/drivers/infiniband/hw/mthca/mthca_qp.c
@@ -2214,13 +2214,16 @@ int __devinit mthca_init_qp_table(struct
 			       (1 << 24) - 1,
 			       dev->qp_table.sqp_start +
 			       MTHCA_MAX_PORTS * 2);
-	if (err)
+	if (err) {
+		mthca_err(dev, "mthca_init_qp_table: mthca_alloc_init failed (%d)\n", err);
 		return err;
+	}
 
 	err = mthca_array_init(&dev->qp_table.qp,
 			       dev->limits.num_qps);
 	if (err) {
 		mthca_alloc_cleanup(&dev->qp_table.alloc);
+		mthca_err(dev, "mthca_init_qp_table: mthca_array_init failed (%d)\n", err);
 		return err;
 	}
 
@@ -2228,8 +2231,10 @@ int __devinit mthca_init_qp_table(struct
 		err = mthca_CONF_SPECIAL_QP(dev, i ? IB_QPT_GSI : IB_QPT_SMI,
 					    dev->qp_table.sqp_start + i * 2,
 					    &status);
-		if (err)
+		if (err) {
+			mthca_err(dev, "mthca_init_qp_table: mthca_CONF_SPECIAL_QP failed for %d/%d (%d)\n", i, dev->qp_table.sqp_start + i * 2, err);
 			goto err_out;
+		}
 		if (status) {
 			mthca_warn(dev, "CONF_SPECIAL_QP returned "
 				   "status %02x, aborting.\n",
