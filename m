Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423355AbWJYMBf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423355AbWJYMBf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 08:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423356AbWJYMBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 08:01:35 -0400
Received: from mtagate1.uk.ibm.com ([195.212.29.134]:56505 "EHLO
	mtagate1.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1423355AbWJYMBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 08:01:33 -0400
From: Jan-Bernd Themann <ossthema@de.ibm.com>
Subject: [PATCH 2.6.19-rc3 2/2] ehea: 64K page support fix
Date: Wed, 25 Oct 2006 13:12:01 +0200
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Disposition: inline
To: Jeff Garzik <jeff@garzik.org>
Cc: netdev <netdev@vger.kernel.org>, Christoph Raisch <raisch@de.ibm.com>,
       "Jan-Bernd Themann" <themann@de.ibm.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       "linux-ppc" <linuxppc-dev@ozlabs.org>, Marcus Eder <meder@de.ibm.com>,
       Thomas Klein <tklein@de.ibm.com>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200610251312.01235.ossthema@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the 64K page support

Signed-off-by: Jan-Bernd Themann <themann@de.ibm.com>
---
 drivers/net/ehea/ehea.h      |    2 +-
 drivers/net/ehea/ehea_phyp.h |   14 +++++++++++++-
 drivers/net/ehea/ehea_qmr.c  |   13 +++++++------
 3 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ehea/ehea.h b/drivers/net/ehea/ehea.h
index b40724f..cd412b5 100644
--- a/drivers/net/ehea/ehea.h
+++ b/drivers/net/ehea/ehea.h
@@ -39,7 +39,7 @@ #include <asm/abs_addr.h>
 #include <asm/io.h>
 
 #define DRV_NAME	"ehea"
-#define DRV_VERSION	"EHEA_0034"
+#define DRV_VERSION	"EHEA_0040"
 
 #define EHEA_MSG_DEFAULT (NETIF_MSG_LINK | NETIF_MSG_TIMER \
 	| NETIF_MSG_RX_ERR | NETIF_MSG_TX_ERR)
diff --git a/drivers/net/ehea/ehea_phyp.h b/drivers/net/ehea/ehea_phyp.h
index fa51e3b..59ab646 100644
--- a/drivers/net/ehea/ehea_phyp.h
+++ b/drivers/net/ehea/ehea_phyp.h
@@ -81,15 +81,27 @@ #define NELR_PORTSTATE_CHG	EHEA_BMASK_IB
 static inline void hcp_epas_ctor(struct h_epas *epas, u64 paddr_kernel,
 				 u64 paddr_user)
 {
+#ifdef CONFIG_PPC_64K_PAGES
+	/* To support 64k pages we must round to 64k page boundary */
+	epas->kernel.addr =
+		ioremap((paddr_kernel & 0xFFFFFFFFFFFF0000), PAGE_SIZE) +
+		(paddr_kernel & 0xFFFF);
+#else
 	epas->kernel.addr = ioremap(paddr_kernel, PAGE_SIZE);
+#endif
 	epas->user.addr = paddr_user;
 }
 
 static inline void hcp_epas_dtor(struct h_epas *epas)
 {
+#ifdef CONFIG_PPC_64K_PAGES
+	if (epas->kernel.addr)
+		iounmap((void __iomem*)((u64)epas->kernel.addr &
+					0xFFFFFFFFFFFF0000));
+#else
 	if (epas->kernel.addr)
 		iounmap(epas->kernel.addr);
-
+#endif
 	epas->user.addr = 0;
 	epas->kernel.addr = 0;
 }
diff --git a/drivers/net/ehea/ehea_qmr.c b/drivers/net/ehea/ehea_qmr.c
index 3e18623..3daedfa 100644
--- a/drivers/net/ehea/ehea_qmr.c
+++ b/drivers/net/ehea/ehea_qmr.c
@@ -512,7 +512,7 @@ int ehea_reg_mr_adapter(struct ehea_adap
 
 	start = KERNELBASE;
 	end = (u64)high_memory;
-	nr_pages = (end - start) / PAGE_SIZE;
+	nr_pages = (end - start) / EHEA_PAGESIZE;
 
 	pt =  kzalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!pt) {
@@ -538,9 +538,9 @@ int ehea_reg_mr_adapter(struct ehea_adap
 		if (nr_pages > 1) {
 			u64 num_pages = min(nr_pages, (u64)512);
 			for (i = 0; i < num_pages; i++)
-				pt[i] = virt_to_abs((void*)(((u64)start)
-							     + ((k++) *
-								PAGE_SIZE)));
+				pt[i] = virt_to_abs((void*)(((u64)start) +
+							    ((k++) *
+							     EHEA_PAGESIZE)));
 
 			hret = ehea_h_register_rpage_mr(adapter->handle,
 							adapter->mr.handle, 0,
@@ -548,8 +548,9 @@ int ehea_reg_mr_adapter(struct ehea_adap
 							num_pages);
 			nr_pages -= num_pages;
 		} else {
-			u64 abs_adr = virt_to_abs((void*)(((u64)start)
-							   + (k * PAGE_SIZE)));
+			u64 abs_adr = virt_to_abs((void*)(((u64)start) +
+							  (k * EHEA_PAGESIZE)));
+
 			hret = ehea_h_register_rpage_mr(adapter->handle,
 							adapter->mr.handle, 0,
 							0, abs_adr,1);
