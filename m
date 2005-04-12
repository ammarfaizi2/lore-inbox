Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262432AbVDLQNa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262432AbVDLQNa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 12:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262315AbVDLKoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 06:44:18 -0400
Received: from fire.osdl.org ([65.172.181.4]:57546 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262286AbVDLKdr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:33:47 -0400
Message-Id: <200504121033.j3CAXSiC005885@shell0.pdx.osdl.net>
Subject: [patch 181/198] IB/mthca: add mthca_write64_raw() for writing to MTT table directly
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mst@mellanox.co.il,
       roland@topspin.com
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:33:21 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Michael S. Tsirkin <mst@mellanox.co.il>

Add mthca_write64_raw() function, which will be used to write FMR entries that
are in ioremapped PCI memory.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Roland Dreier <roland@topspin.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/infiniband/hw/mthca/mthca_doorbell.h |   11 +++++++++++
 1 files changed, 11 insertions(+)

diff -puN drivers/infiniband/hw/mthca/mthca_doorbell.h~ib-mthca-add-mthca_write64_raw-for-writing-to-mtt-table-directly drivers/infiniband/hw/mthca/mthca_doorbell.h
--- 25/drivers/infiniband/hw/mthca/mthca_doorbell.h~ib-mthca-add-mthca_write64_raw-for-writing-to-mtt-table-directly	2005-04-12 03:21:46.492069032 -0700
+++ 25-akpm/drivers/infiniband/hw/mthca/mthca_doorbell.h	2005-04-12 03:21:46.495068576 -0700
@@ -51,6 +51,11 @@
 #define MTHCA_INIT_DOORBELL_LOCK(ptr)    do { } while (0)
 #define MTHCA_GET_DOORBELL_LOCK(ptr)      (NULL)
 
+static inline void mthca_write64_raw(__be64 val, void __iomem *dest)
+{
+	__raw_writeq((__force u64) val, dest);
+}
+
 static inline void mthca_write64(u32 val[2], void __iomem *dest,
 				 spinlock_t *doorbell_lock)
 {
@@ -74,6 +79,12 @@ static inline void mthca_write_db_rec(u3
 #define MTHCA_INIT_DOORBELL_LOCK(ptr)     spin_lock_init(ptr)
 #define MTHCA_GET_DOORBELL_LOCK(ptr)      (ptr)
 
+static inline void mthca_write64_raw(__be64 val, void __iomem *dest)
+{
+	__raw_writel(((__force u32 *) &val)[0], dest);
+	__raw_writel(((__force u32 *) &val)[1], dest + 4);
+}
+
 static inline void mthca_write64(u32 val[2], void __iomem *dest,
 				 spinlock_t *doorbell_lock)
 {
_
