Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423348AbWJYMBQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423348AbWJYMBQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 08:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423347AbWJYMBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 08:01:16 -0400
Received: from mtagate5.uk.ibm.com ([195.212.29.138]:37830 "EHLO
	mtagate5.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1423340AbWJYMBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 08:01:15 -0400
From: Jan-Bernd Themann <ossthema@de.ibm.com>
Subject: [PATCH 2.6.19-rc3 1/2] ehea: kzalloc GFP_ATOMIC fix
Date: Wed, 25 Oct 2006 13:11:42 +0200
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
Message-Id: <200610251311.43009.ossthema@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes kzalloc parameters (GFP_ATOMIC instead of GFP_KERNEL)

Signed-off-by: Jan-Bernd Themann <themann@de.ibm.com>
---

diff --git a/drivers/net/ehea/ehea_main.c b/drivers/net/ehea/ehea_main.c
index eb7d44d..4538c99 100644
--- a/drivers/net/ehea/ehea_main.c
+++ b/drivers/net/ehea/ehea_main.c
@@ -586,8 +586,8 @@ int ehea_sense_port_attr(struct ehea_por
 	u64 hret;
 	struct hcp_ehea_port_cb0 *cb0;
 
-	cb0 = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
-	if (!cb0) {
+	cb0 = kzalloc(H_CB_ALIGNMENT, GFP_ATOMIC);   /* May be called via */
+	if (!cb0) {                                  /* ehea_neq_tasklet() */
 		ehea_error("no mem for cb0");
 		ret = -ENOMEM;
 		goto out;
@@ -765,8 +765,7 @@ static void ehea_parse_eqe(struct ehea_a
 
 		if (EHEA_BMASK_GET(NEQE_PORT_UP, eqe)) {
 			if (!netif_carrier_ok(port->netdev)) {
-				ret = ehea_sense_port_attr(
-					port);
+				ret = ehea_sense_port_attr(port);
 				if (ret) {
 					ehea_error("failed resensing port "
 						   "attributes");
@@ -1502,7 +1501,7 @@ static void ehea_promiscuous(struct net_
 	if ((enable && port->promisc) || (!enable && !port->promisc))
 		return;
 
-	cb7 = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
+	cb7 = kzalloc(H_CB_ALIGNMENT, GFP_ATOMIC);
 	if (!cb7) {
 		ehea_error("no mem for cb7");
 		goto out;
@@ -1606,7 +1605,7 @@ static void ehea_add_multicast_entry(str
 	struct ehea_mc_list *ehea_mcl_entry;
 	u64 hret;
 
-	ehea_mcl_entry = kzalloc(sizeof(*ehea_mcl_entry), GFP_KERNEL);
+	ehea_mcl_entry = kzalloc(sizeof(*ehea_mcl_entry), GFP_ATOMIC);
 	if (!ehea_mcl_entry) {
 		ehea_error("no mem for mcl_entry");
 		return;
