Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261460AbVALWEh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261460AbVALWEh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 17:04:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261489AbVALWDC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 17:03:02 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:39078 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261460AbVALVsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 16:48:14 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <20051121347.kR765yQEXhqhoLHL@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Wed, 12 Jan 2005 13:47:48 -0800
Message-Id: <20051121347.vxtR3merv690zIQY@topspin.com>
Mime-Version: 1.0
To: akpm@osdl.org
From: Roland Dreier <roland@topspin.com>
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: roland@topspin.com
Subject: [PATCH][5/18] InfiniBand/mthca: add needed rmb() in event queue poll
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 12 Jan 2005 21:47:49.0891 (UTC) FILETIME=[5C60E530:01C4F8F0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add an rmb() between checking the ownership bit of an event queue
entry and reading the contents of the EQE.  Without this barrier, the
CPU could read stale contents of the EQE before HW writes the EQE but
have the read of the ownership bit reordered until after HW finishes
writing, which leads to the driver processing an incorrect event. This
was actually observed to happen when multiple completion queues are in
heavy use on an IBM JS20 PowerPC 970 system.

Also explain the existing rmb() in completion queue poll (there for
the same reason) and slightly improve debugging output.

Signed-off-by: Roland Dreier <roland@topspin.com>

--- linux/drivers/infiniband/hw/mthca/mthca_cq.c	(revision 1437)
+++ linux/drivers/infiniband/hw/mthca/mthca_cq.c	(revision 1439)
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2004 Topspin Communications.  All rights reserved.
+ * Copyright (c) 2004, 2005 Topspin Communications.  All rights reserved.
  *
  * This software is available to you under a choice of one of two
  * licenses.  You may choose to be licensed under the terms of the GNU
@@ -391,6 +391,10 @@
 	if (!next_cqe_sw(cq))
 		return -EAGAIN;
 
+	/*
+	 * Make sure we read CQ entry contents after we've checked the
+	 * ownership bit.
+	 */
 	rmb();
 
 	cqe = get_cqe(cq, cq->cons_index);
@@ -768,7 +772,8 @@
 		u32 *ctx = MAILBOX_ALIGN(mailbox);
 		int j;
 
-		printk(KERN_ERR "context for CQN %x\n", cq->cqn);
+		printk(KERN_ERR "context for CQN %x (cons index %x, next sw %d)\n",
+		       cq->cqn, cq->cons_index, next_cqe_sw(cq));
 		for (j = 0; j < 16; ++j)
 			printk(KERN_ERR "[%2x] %08x\n", j * 4, be32_to_cpu(ctx[j]));
 	}
--- linux/drivers/infiniband/hw/mthca/mthca_eq.c	(revision 1437)
+++ linux/drivers/infiniband/hw/mthca/mthca_eq.c	(revision 1439)
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2004 Topspin Communications.  All rights reserved.
+ * Copyright (c) 2004, 2005 Topspin Communications.  All rights reserved.
  *
  * This software is available to you under a choice of one of two
  * licenses.  You may choose to be licensed under the terms of the GNU
@@ -240,6 +240,12 @@
 		int set_ci = 0;
 		eqe = get_eqe(eq, eq->cons_index);
 
+		/*
+		 * Make sure we read EQ entry contents after we've
+		 * checked the ownership bit.
+		 */
+		rmb();
+
 		switch (eqe->type) {
 		case MTHCA_EVENT_TYPE_COMP:
 			disarm_cqn = be32_to_cpu(eqe->event.comp.cqn) & 0xffffff;

