Return-Path: <linux-kernel-owner+w=401wt.eu-S1751769AbXAVLyD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751769AbXAVLyD (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 06:54:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751763AbXAVLyB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 06:54:01 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:31551 "EHLO
	mtagate4.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751769AbXAVLx7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 06:53:59 -0500
From: Thomas Klein <osstklei@de.ibm.com>
Subject: [PATCH 2.6.20-rc5 4/7] ehea: New method to determine number of available ports
Date: Mon, 22 Jan 2007 12:53:50 +0100
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 1727
To: Jeff Garzik <jeff@garzik.org>
Cc: Christoph Raisch <raisch@de.ibm.com>,
       "Jan-Bernd Themann" <ossthema@de.ibm.com>,
       "Jan-Bernd Themann" <themann@de.ibm.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       "linux-ppc" <linuxppc-dev@ozlabs.org>, Marcus Eder <meder@de.ibm.com>,
       netdev <netdev@vger.kernel.org>, Thomas Klein <tklein@de.ibm.com>,
       Stefan Roscher <roscher@de.ibm.com>,
       Stefan Roscher <ossrosch@de.ibm.com>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200701221253.50709.osstklei@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Count OFDT nodes to determine the number of available ports
instead of using the possibly outdated value from the hypervisor

Signed-off-by: Thomas Klein <tklein@de.ibm.com>
---


 drivers/net/ehea/ehea_main.c |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletion(-)


diff -Nurp -X dontdiff linux-2.6.20-rc5/drivers/net/ehea/ehea_main.c patched_kernel/drivers/net/ehea/ehea_main.c
--- linux-2.6.20-rc5/drivers/net/ehea/ehea_main.c	2007-01-19 14:12:31.000000000 +0100
+++ patched_kernel/drivers/net/ehea/ehea_main.c	2007-01-19 14:15:53.000000000 +0100
@@ -2269,6 +2269,8 @@ static void ehea_tx_watchdog(struct net_
 int ehea_sense_adapter_attr(struct ehea_adapter *adapter)
 {
 	struct hcp_query_ehea *cb;
+	struct device_node *lhea_dn = NULL;
+	struct device_node *eth_dn = NULL;
 	u64 hret;
 	int ret;
 
@@ -2285,7 +2287,18 @@ int ehea_sense_adapter_attr(struct ehea_
 		goto out_herr;
 	}
 
-	adapter->num_ports = cb->num_ports;
+	/* Determine the number of available logical ports
+	 * by counting the child nodes of the lhea OFDT entry
+	 */
+	adapter->num_ports = 0;
+	lhea_dn = of_find_node_by_name(lhea_dn, "lhea");
+	do {
+		eth_dn = of_get_next_child(lhea_dn, eth_dn);
+		if (eth_dn)
+			adapter->num_ports++;
+	} while ( eth_dn );
+	of_node_put(lhea_dn);
+
 	adapter->max_mc_mac = cb->max_mc_mac - 1;
 	ret = 0;
 

