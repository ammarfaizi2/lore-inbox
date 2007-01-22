Return-Path: <linux-kernel-owner+w=401wt.eu-S1751785AbXAVLy0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751785AbXAVLy0 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 06:54:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751740AbXAVLyZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 06:54:25 -0500
Received: from mtagate1.uk.ibm.com ([195.212.29.134]:37961 "EHLO
	mtagate1.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751731AbXAVLyX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 06:54:23 -0500
From: Thomas Klein <osstklei@de.ibm.com>
Subject: [PATCH 2.6.20-rc5 5/7] ehea: Improved logging of permission issues
Date: Mon, 22 Jan 2007 12:54:20 +0100
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 450
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
Message-Id: <200701221254.20725.osstklei@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Disabled dump of hcall regs on some permission issues and
fixed appropriate misleading logmessages

Signed-off-by: Thomas Klein <tklein@de.ibm.com>
---


 drivers/net/ehea/ehea_main.c |   16 +++++++---------
 drivers/net/ehea/ehea_phyp.c |   10 ++++++++--
 2 files changed, 15 insertions(+), 11 deletions(-)


diff -Nurp -X dontdiff linux-2.6.20-rc5/drivers/net/ehea/ehea_main.c patched_kernel/drivers/net/ehea/ehea_main.c
--- linux-2.6.20-rc5/drivers/net/ehea/ehea_main.c	2007-01-19 14:16:35.000000000 +0100
+++ patched_kernel/drivers/net/ehea/ehea_main.c	2007-01-19 14:22:42.000000000 +0100
@@ -730,10 +730,7 @@ int ehea_set_portspeed(struct ehea_port 
 		}
 	} else {
 		if (hret == H_AUTHORITY) {
-			ehea_info("Hypervisor denied setting port speed. Either"
-				  " this partition is not authorized to set "
-				  "port speed or another partition has modified"
-				  " port speed first.");
+			ehea_info("Hypervisor denied setting port speed");
 			ret = -EPERM;
 		} else {
 			ret = -EIO;
@@ -1487,11 +1484,12 @@ out:
 
 static void ehea_promiscuous_error(u64 hret, int enable)
 {
-	ehea_info("Hypervisor denied %sabling promiscuous mode.%s",
-		  enable == 1 ? "en" : "dis",
-		  hret != H_AUTHORITY ? "" : " Another partition owning a "
-		  "logical port on the same physical port might have altered "
-		  "promiscuous mode first.");
+	if (hret == H_AUTHORITY)
+		ehea_info("Hypervisor denied %sabling promiscuous mode",
+			  enable == 1 ? "en" : "dis");
+	else
+		ehea_error("failed %sabling promiscuous mode",
+			   enable == 1 ? "en" : "dis");
 }
 
 static void ehea_promiscuous(struct net_device *dev, int enable)
diff -Nurp -X dontdiff linux-2.6.20-rc5/drivers/net/ehea/ehea_phyp.c patched_kernel/drivers/net/ehea/ehea_phyp.c
--- linux-2.6.20-rc5/drivers/net/ehea/ehea_phyp.c	2007-01-12 19:54:26.000000000 +0100
+++ patched_kernel/drivers/net/ehea/ehea_phyp.c	2007-01-19 14:23:31.000000000 +0100
@@ -94,6 +94,7 @@ static long ehea_plpar_hcall9(unsigned l
 {
 	long ret;
 	int i, sleep_msecs;
+	u8 cb_cat;
 
 	for (i = 0; i < 5; i++) {
 		ret = plpar_hcall9(opcode, outs,
@@ -106,7 +107,13 @@ static long ehea_plpar_hcall9(unsigned l
 			continue;
 		}
 
-		if (ret < H_SUCCESS)
+		cb_cat = EHEA_BMASK_GET(H_MEHEAPORT_CAT, arg2);
+
+		if ((ret < H_SUCCESS) && !(((ret == H_AUTHORITY)
+		    && (opcode == H_MODIFY_HEA_PORT))
+		    && (((cb_cat == H_PORT_CB4) && ((arg3 == H_PORT_CB4_JUMBO)
+		    || (arg3 == H_PORT_CB4_SPEED))) || ((cb_cat == H_PORT_CB7)
+		    && (arg3 == H_PORT_CB7_DUCQPN)))))
 			ehea_error("opcode=%lx ret=%lx"
 				   " arg1=%lx arg2=%lx arg3=%lx arg4=%lx"
 				   " arg5=%lx arg6=%lx arg7=%lx arg8=%lx"
@@ -120,7 +127,6 @@ static long ehea_plpar_hcall9(unsigned l
 				   outs[0], outs[1], outs[2], outs[3],
 				   outs[4], outs[5], outs[6], outs[7],
 				   outs[8]);
-
 		return ret;
 	}
 

