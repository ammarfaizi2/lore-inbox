Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965072AbWIKVY4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965072AbWIKVY4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 17:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965071AbWIKVYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 17:24:55 -0400
Received: from mga03.intel.com ([143.182.124.21]:520 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S965061AbWIKVYy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 17:24:54 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,146,1157353200"; 
   d="scan'208"; a="114892236:sNHT396870726"
From: Auke Kok <auke-jan.h.kok@intel.com>
To: torvalds@osdl.org, jgarzik@pobox.com, stable@vger.kernel.org
Cc: auke-jan.h.kok@intel.com, auke@foo-projects.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org, greg@kroah.com,
       jesse.brandeburg@intel.com, john.ronciak@intel.com,
       linville@tuxdriver.org, tony@mail.applog.com, bunk@stusta.de
Subject: [PATCH] e1000: fix TX timout hang regression for 82542rev3
Message-Id: <20060911210021.972B41AB2A1@ahkok-mobl.jf.intel.com>
Date: Mon, 11 Sep 2006 14:00:21 -0700 (PDT)
X-OriginalArrivalTime: 11 Sep 2006 21:01:49.0690 (UTC) FILETIME=[7FE9E5A0:01C6D5E5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 581d708eb47cccb5f41bc0817e50c9b004011ba8 (oct. 5 2005) introduced
partial Multiqueue support for e1000 which broke macro smartness in setting
up head/tail registers for 82542 rev3 chipsets, making these adapters
completely non-working since 2.6.15.

This commit sets the proper head and tail registers for read and write
descriptor rings. Ths fix was tested on an 82542 rev3 NIC and newer NICs.

Signed-off-by: Auke Kok <auke-jan.h.kok@intel.com>

diff --git a/drivers/net/e1000/e1000_main.c b/drivers/net/e1000/e1000_main.c
index 726f43d..98ef9f8 100644
--- a/drivers/net/e1000/e1000_main.c
+++ b/drivers/net/e1000/e1000_main.c
@@ -1433,8 +1433,8 @@ e1000_configure_tx(struct e1000_adapter
 		E1000_WRITE_REG(hw, TDBAL, (tdba & 0x00000000ffffffffULL));
 		E1000_WRITE_REG(hw, TDT, 0);
 		E1000_WRITE_REG(hw, TDH, 0);
-		adapter->tx_ring[0].tdh = E1000_TDH;
-		adapter->tx_ring[0].tdt = E1000_TDT;
+		adapter->tx_ring[0].tdh = ((hw->mac_type >= e1000_82543) ? E1000_TDH : E1000_82542_TDH);
+		adapter->tx_ring[0].tdt = ((hw->mac_type >= e1000_82543) ? E1000_TDT : E1000_82542_TDT);
 		break;
 	}
 
@@ -1840,8 +1840,8 @@ #endif
 		E1000_WRITE_REG(hw, RDBAL, (rdba & 0x00000000ffffffffULL));
 		E1000_WRITE_REG(hw, RDT, 0);
 		E1000_WRITE_REG(hw, RDH, 0);
-		adapter->rx_ring[0].rdh = E1000_RDH;
-		adapter->rx_ring[0].rdt = E1000_RDT;
+		adapter->rx_ring[0].rdh = ((hw->mac_type >= e1000_82543) ? E1000_RDH : E1000_82542_RDH);
+		adapter->rx_ring[0].rdt = ((hw->mac_type >= e1000_82543) ? E1000_RDT : E1000_82542_RDT);
 		break;
 	}
 
