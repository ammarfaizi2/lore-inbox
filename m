Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932223AbWEMAC1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbWEMAC1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 20:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932302AbWEMACN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 20:02:13 -0400
Received: from mx.pathscale.com ([64.160.42.68]:58793 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932221AbWELXod (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 19:44:33 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 30 of 53] ipath - count VL15 packet drops due to bad VL or
	lack of buffers
X-Mercurial-Node: b098b021b6fd586d4a98e93229378287500ab53e
Message-Id: <b098b021b6fd586d4a98.1147477395@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1147477365@eng-12.pathscale.com>
Date: Fri, 12 May 2006 16:43:15 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r 23519e578bf0 -r b098b021b6fd drivers/infiniband/hw/ipath/ipath_ud.c
--- a/drivers/infiniband/hw/ipath/ipath_ud.c	Fri May 12 15:55:28 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_ud.c	Fri May 12 15:55:28 2006 -0700
@@ -554,11 +554,16 @@ void ipath_ud_rcv(struct ipath_ibdev *de
 	spin_lock_irqsave(&rq->lock, flags);
 	if (rq->tail == rq->head) {
 		spin_unlock_irqrestore(&rq->lock, flags);
-		/* Count VL15 packets dropped due to no receive buffer */
+		/*
+		 * Count VL15 packets dropped due to no receive buffer.
+		 * Otherwise, count them as buffer overruns since usually,
+		 * the HW will be able to receive packets even if there are
+		 * no QPs with posted receive buffers.
+		 */
 		if (qp->ibqp.qp_num == 0)
 			dev->n_vl15_dropped++;
 		else
-			dev->n_pkt_drops++;
+			dev->rcv_errors++;
 		goto bail;
 	}
 	/* Silently drop packets which are too big. */
