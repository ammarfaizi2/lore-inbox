Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262425AbTKPFbF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 00:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262360AbTKPFbB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 00:31:01 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:35232 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S262319AbTKPFa6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 00:30:58 -0500
Date: Sun, 16 Nov 2003 00:26:53 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP Fixes for 2.6.0-test9
Message-ID: <20031116002653.GC13220@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	linux-kernel@vger.kernel.org
References: <20031116002620.GB13220@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031116002620.GB13220@neo.rr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# --------------------------------------------
# 03/11/15	ambx1@neo.rr.com	1.1448
# [PnPBIOS] read static resources on PnPBIOS init
# 
# The PnPBIOS specifications recommend that we read static (boot time)
# resources when the PnPBIOS driver is first initialized.  Because the
# PnPBIOS driver is not modular and can not be ran more than once per
# boot, it's safe to access the static resource data.  Many buggy
# BIOSes actually expect us to read from it first.  With this patch,
# the PnPBIOS driver will read static resources initially and then
# switch to dynamic mode when allocating resources for specific nodes.
# --------------------------------------------
#
diff -Nru a/drivers/pnp/pnpbios/core.c b/drivers/pnp/pnpbios/core.c
--- a/drivers/pnp/pnpbios/core.c	Sun Nov 16 00:25:08 2003
+++ b/drivers/pnp/pnpbios/core.c	Sun Nov 16 00:25:08 2003
@@ -353,16 +353,8 @@
 
 	for(nodenum=0; nodenum<0xff; ) {
 		u8 thisnodenum = nodenum;
-		/* eventually we will want to use PNPMODE_STATIC here but for now
-		 * dynamic will help us catch buggy bioses to add to the blacklist.
-		 */
-		if (!pnpbios_dont_use_current_config) {
-			if (pnp_bios_get_dev_node(&nodenum, (char )PNPMODE_DYNAMIC, node))
-				break;
-		} else {
-			if (pnp_bios_get_dev_node(&nodenum, (char )PNPMODE_STATIC, node))
-				break;
-		}
+		if (pnp_bios_get_dev_node(&nodenum, (char )PNPMODE_STATIC, node))
+			break;
 		nodes_got++;
 		dev =  pnpbios_kmalloc(sizeof (struct pnp_dev), GFP_KERNEL);
 		if (!dev)
