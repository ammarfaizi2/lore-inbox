Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262943AbVDAVlI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262943AbVDAVlI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 16:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262924AbVDAVAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 16:00:22 -0500
Received: from webmail.topspin.com ([12.162.17.3]:37423 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S262909AbVDAUvU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 15:51:20 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][19/27] IB/mthca: add mthca_write64_raw() for writing to MTT table directly
In-Reply-To: <2005411249.Wiedh3QohPRJi9Sp@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Fri, 1 Apr 2005 12:49:53 -0800
Message-Id: <2005411249.t0DdCtarOabubO3D@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 01 Apr 2005 20:49:53.0638 (UTC) FILETIME=[5B010860:01C536FC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael S. Tsirkin <mst@mellanox.co.il>

Add mthca_write64_raw() function, which will be used to write FMR
entries that are in ioremapped PCI memory.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_doorbell.h	2005-03-31 19:06:52.000000000 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_doorbell.h	2005-04-01 12:38:27.898904595 -0800
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
@@ -74,6 +79,12 @@
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

