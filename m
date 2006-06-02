Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932557AbWFBUZw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932557AbWFBUZw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 16:25:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932562AbWFBUZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 16:25:52 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:64978 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S932557AbWFBUZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 16:25:51 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Fri, 2 Jun 2006 22:24:14 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 2.6.17-rc5-mm2 15/18] sbp2: fix S800 transfers if phys_dma is
 off
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
       Jody McIntyre <scjody@modernduck.com>,
       Ben Collins <bcollins@ubuntu.com>
In-Reply-To: <tkrat.8f06b4d6dec62d08@s5r6.in-berlin.de>
Message-ID: <tkrat.8a65694fd3ed4036@s5r6.in-berlin.de>
References: <tkrat.10011841414bfa88@s5r6.in-berlin.de>
 <tkrat.31172d1c0b7ae8e8@s5r6.in-berlin.de>
 <tkrat.51c50df7e692bbfa@s5r6.in-berlin.de>
 <tkrat.f22d0694697e6d7a@s5r6.in-berlin.de>
 <tkrat.ecb0be3f1632e232@s5r6.in-berlin.de>
 <tkrat.687a0a2c67fa40c6@s5r6.in-berlin.de>
 <tkrat.f35772c971022262@s5r6.in-berlin.de>
 <tkrat.df7a29e56d67dd0a@s5r6.in-berlin.de>
 <tkrat.29d9bcd5406eb937@s5r6.in-berlin.de>
 <tkrat.9a30b61b3f17e5ac@s5r6.in-berlin.de>
 <tkrat.5222feb4e2593ac0@s5r6.in-berlin.de>
 <tkrat.5fcbbb70f827a5c2@s5r6.in-berlin.de>
 <tkrat.39c0a660f27b4e91@s5r6.in-berlin.de>
 <tkrat.4daedad8356d5ae7@s5r6.in-berlin.de>
 <tkrat.8f06b4d6dec62d08@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (-0.036) AWL,BAYES_40
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If sbp2 is forced to move data via ARM handler, the maximum packet size
allowed for S800 transfers exceeds ohci1394's buffer size on platforms
where PAGE_SIZE is 4096.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>

Index: linux-2.6.17-rc5-mm2/drivers/ieee1394/sbp2.c
===================================================================
--- linux-2.6.17-rc5-mm2.orig/drivers/ieee1394/sbp2.c	2006-06-01 20:55:46.000000000 +0200
+++ linux-2.6.17-rc5-mm2/drivers/ieee1394/sbp2.c	2006-06-01 20:55:47.000000000 +0200
@@ -1649,6 +1649,8 @@ static void sbp2_parse_unit_directory(st
 	}
 }
 
+#define SBP2_PAYLOAD_TO_BYTES(p) (1 << ((p) + 2))
+
 /*
  * This function is called in order to determine the max speed and packet
  * size we can use in our ORBs. Note, that we (the driver and host) only
@@ -1661,6 +1663,7 @@ static void sbp2_parse_unit_directory(st
 static int sbp2_max_speed_and_size(struct scsi_id_instance_data *scsi_id)
 {
 	struct sbp2scsi_host_info *hi = scsi_id->hi;
+	u8 payload;
 
 	SBP2_DEBUG_ENTER();
 
@@ -1676,15 +1679,22 @@ static int sbp2_max_speed_and_size(struc
 
 	/* Payload size is the lesser of what our speed supports and what
 	 * our host supports.  */
-	scsi_id->max_payload_size =
-	    min(sbp2_speedto_max_payload[scsi_id->speed_code],
-		(u8) (hi->host->csr.max_rec - 1));
+	payload = min(sbp2_speedto_max_payload[scsi_id->speed_code],
+		      (u8) (hi->host->csr.max_rec - 1));
+
+	/* If physical DMA is off, work around limitation in ohci1394:
+	 * packet size must not exceed PAGE_SIZE */
+	if (scsi_id->ne->host->low_addr_space < (1ULL << 32))
+		while (SBP2_PAYLOAD_TO_BYTES(payload) + 24 > PAGE_SIZE &&
+		       payload)
+			payload--;
 
 	HPSB_DEBUG("Node " NODE_BUS_FMT ": Max speed [%s] - Max payload [%u]",
 		   NODE_BUS_ARGS(hi->host, scsi_id->ne->nodeid),
 		   hpsb_speedto_str[scsi_id->speed_code],
-		   1 << ((u32) scsi_id->max_payload_size + 2));
+		   SBP2_PAYLOAD_TO_BYTES(payload));
 
+	scsi_id->max_payload_size = payload;
 	return 0;
 }
 


