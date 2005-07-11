Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261886AbVGKOos@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261886AbVGKOos (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 10:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261882AbVGKOnS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 10:43:18 -0400
Received: from mailgw.voltaire.com ([212.143.27.70]:57798 "EHLO
	mailgw.voltaire.com") by vger.kernel.org with ESMTP id S261890AbVGKOlI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 10:41:08 -0400
Subject: [PATCH 17/27] A couple of IB core bug fixes
From: Hal Rosenstock <halr@voltaire.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Content-Type: text/plain
Organization: 
Message-Id: <1121089138.4389.4539.camel@hal.voltaire.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 11 Jul 2005 10:33:33 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace be32_to_cpup with be32_to_cpu and fix bug referencing pointer 
rather than value in ib_create_ah_from_wc().

Signed-off-by: Tom Duffy <tduffy@sun.com>
Signed-off-by: Sean Hefty <sean.hefty@intel.com>
Signed-off-by: Hal Rosenstock <halr@voltaire.com>

This patch depends on patch 16/27.

-- 
 agent.c |    8 ++++--
 verbs.c |    2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)
diff -uprN linux-2.6.13-rc2-mm1/drivers/infiniband16/core/agent.c linux-2.6.13-rc2-mm1/drivers/infiniband17/core/agent.c
-- linux-2.6.13-rc2-mm1/drivers/infiniband16/core/agent.c	2005-07-09 13:22:55.000000000 -0400
+++ linux-2.6.13-rc2-mm1/drivers/infiniband17/core/agent.c	2005-07-10 11:50:26.000000000 -0400
@@ -156,10 +156,10 @@ static int agent_mad_send(struct ib_mad_
 			/* Should sgid be looked up ? */
 			ah_attr.grh.sgid_index = 0;
 			ah_attr.grh.hop_limit = grh->hop_limit;
-			ah_attr.grh.flow_label = be32_to_cpup(
-				&grh->version_tclass_flow)  & 0xfffff;
-			ah_attr.grh.traffic_class = (be32_to_cpup(
-				&grh->version_tclass_flow) >> 20) & 0xff;
+			ah_attr.grh.flow_label = be32_to_cpu(
+				grh->version_tclass_flow)  & 0xfffff;
+			ah_attr.grh.traffic_class = (be32_to_cpu(
+				grh->version_tclass_flow) >> 20) & 0xff;
 			memcpy(ah_attr.grh.dgid.raw,
 			       grh->sgid.raw,
 			       sizeof(ah_attr.grh.dgid));
diff -uprN linux-2.6.13-rc2-mm1/drivers/infiniband16/core/verbs.c linux-2.6.13-rc2-mm1/drivers/infiniband17/core/verbs.c
-- linux-2.6.13-rc2-mm1/drivers/infiniband16/core/verbs.c	2005-07-10 11:43:44.000000000 -0400
+++ linux-2.6.13-rc2-mm1/drivers/infiniband17/core/verbs.c	2005-07-10 11:50:26.000000000 -0400
@@ -113,7 +113,7 @@ struct ib_ah *ib_create_ah_from_wc(struc
 			return ERR_PTR(ret);
 
 		ah_attr.grh.sgid_index = (u8) gid_index;
-		flow_class = be32_to_cpu(&grh->version_tclass_flow);
+		flow_class = be32_to_cpu(grh->version_tclass_flow);
 		ah_attr.grh.flow_label = flow_class & 0xFFFFF;
 		ah_attr.grh.traffic_class = (flow_class >> 20) & 0xFF;
 		ah_attr.grh.hop_limit = grh->hop_limit;


