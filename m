Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262784AbVCCXuY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262784AbVCCXuY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 18:50:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262739AbVCCXsA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 18:48:00 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:53494 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262740AbVCCXWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 18:22:24 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][16/26] IB/mthca: mem-free doorbell record writing
In-Reply-To: <2005331520.dH2BeQ6Ko7h8SaKM@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Thu, 3 Mar 2005 15:20:27 -0800
Message-Id: <2005331520.WW3zbnVIUjZ4q0Ov@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 03 Mar 2005 23:20:28.0003 (UTC) FILETIME=[95ECFB30:01C52047]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a mthca_write_db_rec() to wrap writing doorbell records.  On
64-bit archs, this is just a 64-bit write, while on 32-bit archs it
splits the write into two 32-bit writes with a memory barrier to make
sure the two halves of the record are written in the correct order.

Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_doorbell.h	2005-01-25 20:49:05.000000000 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_doorbell.h	2005-03-03 14:12:59.570990692 -0800
@@ -57,6 +57,11 @@
 	__raw_writeq(*(u64 *) val, dest);
 }
 
+static inline void mthca_write_db_rec(u32 val[2], u32 *db)
+{
+	*(u64 *) db = *(u64 *) val;
+}
+
 #else
 
 /*
@@ -80,4 +85,11 @@
 	spin_unlock_irqrestore(doorbell_lock, flags);
 }
 
+static inline void mthca_write_db_rec(u32 val[2], u32 *db)
+{
+	db[0] = val[0];
+	wmb();
+	db[1] = val[1];
+}
+
 #endif

