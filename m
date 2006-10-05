Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932136AbWJEPkM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbWJEPkM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 11:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932137AbWJEPkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 11:40:10 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:56586 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S932136AbWJEPkG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 11:40:06 -0400
From: Jan-Bernd Themann <ossthema@de.ibm.com>
Subject: [PATCH 2.6.19-rc1 2/2] ehea: fix port state notification, default queue sizes
Date: Thu, 5 Oct 2006 16:53:14 +0200
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
Message-Id: <200610051653.15186.ossthema@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch includes a bug fix for the port state notification
and fixes the default queue sizes.


Signed-off-by: Jan-Bernd Themann <themann@de.ibm.com>
---
 drivers/net/ehea/ehea.h      |   13 +++++++------
 drivers/net/ehea/ehea_main.c |    6 +++---
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ehea/ehea.h b/drivers/net/ehea/ehea.h
index 23b451a..b40724f 100644
--- a/drivers/net/ehea/ehea.h
+++ b/drivers/net/ehea/ehea.h
@@ -39,7 +39,7 @@ #include <asm/abs_addr.h>
 #include <asm/io.h>
 
 #define DRV_NAME	"ehea"
-#define DRV_VERSION	"EHEA_0028"
+#define DRV_VERSION	"EHEA_0034"
 
 #define EHEA_MSG_DEFAULT (NETIF_MSG_LINK | NETIF_MSG_TIMER \
 	| NETIF_MSG_RX_ERR | NETIF_MSG_TX_ERR)
@@ -50,6 +50,7 @@ #define EHEA_MAX_ENTRIES_RQ3 16383
 #define EHEA_MAX_ENTRIES_SQ  32767
 #define EHEA_MIN_ENTRIES_QP  127
 
+#define EHEA_SMALL_QUEUES
 #define EHEA_NUM_TX_QP 1
 
 #ifdef EHEA_SMALL_QUEUES
@@ -59,11 +60,11 @@ #define EHEA_DEF_ENTRIES_RQ1    4095
 #define EHEA_DEF_ENTRIES_RQ2    1023
 #define EHEA_DEF_ENTRIES_RQ3    1023
 #else
-#define EHEA_MAX_CQE_COUNT     32000
-#define EHEA_DEF_ENTRIES_SQ    16000
-#define EHEA_DEF_ENTRIES_RQ1   32080
-#define EHEA_DEF_ENTRIES_RQ2    4020
-#define EHEA_DEF_ENTRIES_RQ3    4020
+#define EHEA_MAX_CQE_COUNT      4080
+#define EHEA_DEF_ENTRIES_SQ     4080
+#define EHEA_DEF_ENTRIES_RQ1    8160
+#define EHEA_DEF_ENTRIES_RQ2    2040
+#define EHEA_DEF_ENTRIES_RQ3    2040
 #endif
 
 #define EHEA_MAX_ENTRIES_EQ 20
diff --git a/drivers/net/ehea/ehea_main.c b/drivers/net/ehea/ehea_main.c
index 263d1c5..0edb2f8 100644
--- a/drivers/net/ehea/ehea_main.c
+++ b/drivers/net/ehea/ehea_main.c
@@ -769,7 +769,7 @@ static void ehea_parse_eqe(struct ehea_a
 		if (EHEA_BMASK_GET(NEQE_PORT_UP, eqe)) {
 			if (!netif_carrier_ok(port->netdev)) {
 				ret = ehea_sense_port_attr(
-					adapter->port[portnum]);
+					port);
 				if (ret) {
 					ehea_error("failed resensing port "
 						   "attributes");
@@ -821,7 +821,7 @@ static void ehea_parse_eqe(struct ehea_a
 		netif_stop_queue(port->netdev);
 		break;
 	default:
-		ehea_error("unknown event code %x", ec);
+		ehea_error("unknown event code %x, eqe=0x%lX", ec, eqe);
 		break;
 	}
 }
@@ -1845,7 +1845,7 @@ static int ehea_start_xmit(struct sk_buf
 
 	if (netif_msg_tx_queued(port)) {
 		ehea_info("post swqe on QP %d", pr->qp->init_attr.qp_nr);
-		ehea_dump(swqe, sizeof(*swqe), "swqe");
+		ehea_dump(swqe, 512, "swqe");
 	}
 
 	ehea_post_swqe(pr->qp, swqe);

