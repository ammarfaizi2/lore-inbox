Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946528AbWKAFlt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946528AbWKAFlt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 00:41:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946531AbWKAFls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 00:41:48 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:22162 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1946386AbWKAFlC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 00:41:02 -0500
Message-Id: <20061101054104.936599000@sous-sol.org>
References: <20061101053340.305569000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 31 Oct 2006 21:34:13 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Arthur Kepner <akepner@sgi.com>,
       Roland Dreier <rolandd@cisco.com>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 33/61] IB/mthca: Use mmiowb after doorbell ring
Content-Disposition: inline; filename=ib-mthca-use-mmiowb-after-doorbell-ring.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Arthur Kepner <akepner@sgi.com>

We discovered a problem when running IPoIB applications on multiple
CPUs on an Altix system. Many messages such as:

ib_mthca 0002:01:00.0: SQ 000014 full (19941644 head, 19941707 tail, 64 max, 0 nreq)

appear in syslog, and the driver wedges up.

Apparently this is because writes to the doorbells from different CPUs
reach the device out of order. The following patch adds mmiowb() calls
after doorbell rings to ensure the doorbell writes are ordered.

Signed-off-by: Arthur Kepner <akepner@sgi.com>
Signed-off-by: Roland Dreier <rolandd@cisco.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
 drivers/infiniband/hw/mthca/mthca_cq.c  |    7 +++++++
 drivers/infiniband/hw/mthca/mthca_qp.c  |   19 +++++++++++++++++++
 drivers/infiniband/hw/mthca/mthca_srq.c |    8 ++++++++
 3 files changed, 34 insertions(+)

--- linux-2.6.18.1.orig/drivers/infiniband/hw/mthca/mthca_cq.c
+++ linux-2.6.18.1/drivers/infiniband/hw/mthca/mthca_cq.c
@@ -39,6 +39,8 @@
 #include <linux/init.h>
 #include <linux/hardirq.h>
 
+#include <asm/io.h>
+
 #include <rdma/ib_pack.h>
 
 #include "mthca_dev.h"
@@ -210,6 +212,11 @@ static inline void update_cons_index(str
 		mthca_write64(doorbell,
 			      dev->kar + MTHCA_CQ_DOORBELL,
 			      MTHCA_GET_DOORBELL_LOCK(&dev->doorbell_lock));
+		/*
+		 * Make sure doorbells don't leak out of CQ spinlock
+		 * and reach the HCA out of order:
+		 */
+		mmiowb();
 	}
 }
 
--- linux-2.6.18.1.orig/drivers/infiniband/hw/mthca/mthca_qp.c
+++ linux-2.6.18.1/drivers/infiniband/hw/mthca/mthca_qp.c
@@ -39,6 +39,8 @@
 #include <linux/string.h>
 #include <linux/slab.h>
 
+#include <asm/io.h>
+
 #include <rdma/ib_verbs.h>
 #include <rdma/ib_cache.h>
 #include <rdma/ib_pack.h>
@@ -1730,6 +1732,11 @@ out:
 		mthca_write64(doorbell,
 			      dev->kar + MTHCA_SEND_DOORBELL,
 			      MTHCA_GET_DOORBELL_LOCK(&dev->doorbell_lock));
+		/*
+		 * Make sure doorbells don't leak out of SQ spinlock
+		 * and reach the HCA out of order:
+		 */
+		mmiowb();
 	}
 
 	qp->sq.next_ind = ind;
@@ -1849,6 +1856,12 @@ out:
 	qp->rq.next_ind = ind;
 	qp->rq.head    += nreq;
 
+	/*
+	 * Make sure doorbells don't leak out of RQ spinlock and reach
+	 * the HCA out of order:
+	 */
+	mmiowb();
+
 	spin_unlock_irqrestore(&qp->rq.lock, flags);
 	return err;
 }
@@ -2110,6 +2123,12 @@ out:
 			      MTHCA_GET_DOORBELL_LOCK(&dev->doorbell_lock));
 	}
 
+	/*
+	 * Make sure doorbells don't leak out of SQ spinlock and reach
+	 * the HCA out of order:
+	 */
+	mmiowb();
+
 	spin_unlock_irqrestore(&qp->sq.lock, flags);
 	return err;
 }
--- linux-2.6.18.1.orig/drivers/infiniband/hw/mthca/mthca_srq.c
+++ linux-2.6.18.1/drivers/infiniband/hw/mthca/mthca_srq.c
@@ -35,6 +35,8 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 
+#include <asm/io.h>
+
 #include "mthca_dev.h"
 #include "mthca_cmd.h"
 #include "mthca_memfree.h"
@@ -593,6 +595,12 @@ int mthca_tavor_post_srq_recv(struct ib_
 			      MTHCA_GET_DOORBELL_LOCK(&dev->doorbell_lock));
 	}
 
+	/*
+	 * Make sure doorbells don't leak out of SRQ spinlock and
+	 * reach the HCA out of order:
+	 */
+	mmiowb();
+
 	spin_unlock_irqrestore(&srq->lock, flags);
 	return err;
 }

--
