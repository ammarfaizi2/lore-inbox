Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261891AbVC3Nk4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261891AbVC3Nk4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 08:40:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261895AbVC3Nk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 08:40:56 -0500
Received: from apollo.nbase.co.il ([194.90.137.2]:2317 "EHLO
	apollo.nbase.co.il") by vger.kernel.org with ESMTP id S261891AbVC3Nko
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 08:40:44 -0500
Message-ID: <424AACB4.9040600@mrv.com>
Date: Wed, 30 Mar 2005 15:42:12 +0200
From: emann@mrv.com (Eran Mann)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Netdev <netdev@oss.sgi.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       linux.nics@intel.com, Ganesh Venkatesan <ganesh.venkatesan@intel.com>
Subject: [PATCH 2.6.11.6-bk2] e100: Use EEPROM config for Auto MDI/MDI-X
References: <4240E35C.2090203@pobox.com>
In-Reply-To: <4240E35C.2090203@pobox.com>
Content-Type: multipart/mixed;
 boundary="------------040907020301060902010002"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040907020301060902010002
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Current e100.c doesn't follow the EEPROM configuration regarding Auto 
MDI/MDI-X switching, instead it is enabled unconditionally for the 
relevant chips.
This is especially bad since according to Intel's errata this feature is 
no-longer supported.

Signed-off-by: Eran Mann <emann@mrv.com>

--------------040907020301060902010002
Content-Type: text/x-patch;
 name="e100-mdix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="e100-mdix.patch"

--- linux-2.6.11.6-bk2/drivers/net/e100.c	2005-03-29 19:57:10.000000000 +0200
+++ linux-2.6.11.6-bk2-patched/drivers/net/e100.c	2005-03-29 19:28:52.000000000 +0200
@@ -1072,13 +1072,17 @@
 		mdio_write(netdev, nic->mii.phy_id, MII_NSC_CONG, cong);
 	}
 
-	if((nic->mac >= mac_82550_D102) || ((nic->flags & ich) && 
-		(mdio_read(netdev, nic->mii.phy_id, MII_TPISTATUS) & 0x8000) && 
-		(nic->eeprom[eeprom_cnfg_mdix] & eeprom_mdix_enabled)))
-		/* enable/disable MDI/MDI-X auto-switching */
-		mdio_write(netdev, nic->mii.phy_id, MII_NCONFIG,
-			nic->mii.force_media ? 0 : NCONFIG_AUTO_SWITCH);
-
+	if(((nic->mac >= mac_82550_D102) || ((nic->flags & ich) &&
+		(mdio_read(netdev, nic->mii.phy_id, MII_TPISTATUS) &
+			0x8000)))) {
+		/* Enable/Disable Auto MDI/MDI-X Switching */
+		if ((nic->eeprom[eeprom_cnfg_mdix] & eeprom_mdix_enabled) &&
+		    !nic->mii.force_media)
+			mdio_write(netdev, nic->mii.phy_id, MII_NCONFIG,
+			   		NCONFIG_AUTO_SWITCH);
+		else
+                	mdio_write(netdev, nic->mii.phy_id, MII_NCONFIG, 0);
+		}
 	return 0;
 }
 
@@ -2245,11 +2249,11 @@
 		goto err_out_iounmap;
 	}
 
-	e100_phy_init(nic);
-
 	if((err = e100_eeprom_load(nic)))
 		goto err_out_free;
 
+	e100_phy_init(nic);
+
 	memcpy(netdev->dev_addr, nic->eeprom, ETH_ALEN);
 	if(!is_valid_ether_addr(netdev->dev_addr)) {
 		DPRINTK(PROBE, ERR, "Invalid MAC address from "

--------------040907020301060902010002--
