Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262900AbVDAUz3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262900AbVDAUz3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 15:55:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262899AbVDAUzD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 15:55:03 -0500
Received: from webmail.topspin.com ([12.162.17.3]:37423 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S262900AbVDAUvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 15:51:12 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][11/27] IB/mthca: only free doorbell records in mem-free mode
In-Reply-To: <2005411249.tAq0qtfjGbz3oHeg@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Fri, 1 Apr 2005 12:49:52 -0800
Message-Id: <2005411249.0RpxZQTVnbUL56cR@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 01 Apr 2005 20:49:53.0013 (UTC) FILETIME=[5AA1AA50:01C536FC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On error path, only free doorbell records if we're in mem-free mode.

Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_cq.c	2005-03-31 19:06:42.000000000 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_cq.c	2005-04-01 12:38:24.207705852 -0800
@@ -817,10 +817,12 @@
 err_out_mailbox:
 	kfree(mailbox);
 
-	mthca_free_db(dev, MTHCA_DB_TYPE_CQ_ARM, cq->arm_db_index);
+	if (dev->hca_type == ARBEL_NATIVE)
+		mthca_free_db(dev, MTHCA_DB_TYPE_CQ_ARM, cq->arm_db_index);
 
 err_out_ci:
-	mthca_free_db(dev, MTHCA_DB_TYPE_CQ_SET_CI, cq->set_ci_db_index);
+	if (dev->hca_type == ARBEL_NATIVE)
+		mthca_free_db(dev, MTHCA_DB_TYPE_CQ_SET_CI, cq->set_ci_db_index);
 
 err_out_icm:
 	mthca_table_put(dev, dev->cq_table.table, cq->cqn);

