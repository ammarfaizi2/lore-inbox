Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261359AbVDDUe3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261359AbVDDUe3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 16:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261391AbVDDUdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 16:33:46 -0400
Received: from palrel12.hp.com ([156.153.255.237]:5819 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S261380AbVDDU3u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 16:29:50 -0400
Date: Mon, 4 Apr 2005 13:29:43 -0700
From: David Mosberger <davidm@napali.hpl.hp.com>
Message-Id: <200504042029.j34KThCw012610@napali.hpl.hp.com>
To: davej@redhat.com
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: fix AGP code to work again with non-PCI AGP bridges
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Reply-To: davidm@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave,

As mentioned earlier, the current check_bridge_mode() code assumes
that AGP bridges are PCI devices.  This isn't always true.  Definitely
not for HP zx1 chipset and the same seems to be the case for SGI's AGP
bridge.

The patch below fixes the problem by picking up the AGP_MODE_3_0 bit
from bridge->mode.  I feel like I may be missing something, since I
can't see any reason why check_bridge_mode() wasn't doing that in the
first place.  According to the AGP 3.0 specs, the AGP_MODE_3_0 bit is
determined during the hardware reset and cannot be changed, so it
seems to me it should be safe to pick it up from bridge->mode.

With the patch applied, I can definitely use AGP acceleration both
with AGP 2.0 and AGP 3.0 (one with an Nvidia card, the other with an
ATI FireGL card).

Unless someone spots a problem, please apply this patch so 3d
acceleration can work on zx1 boxes again.

Thanks,

	--david

[AGPGART] Replace check_bridge_mode() with (bridge->mode & AGSTAT_MODE_3_0).

This makes AGP work again on machines with an AGP bridge that isn't a
PCI device.

Signed-off-by: David Mosberger-Tang <davidm@hpl.hp.com>

===== drivers/char/agp/generic.c 1.87 vs edited =====
--- 1.87/drivers/char/agp/generic.c	2005-03-28 14:21:41 -08:00
+++ edited/drivers/char/agp/generic.c	2005-04-04 13:16:43 -07:00
@@ -295,19 +295,6 @@
 EXPORT_SYMBOL_GPL(agp_num_entries);
 
 
-static int check_bridge_mode(struct pci_dev *dev)
-{
-	u32 agp3;
-	u8 cap_ptr;
-
-	cap_ptr = pci_find_capability(dev, PCI_CAP_ID_AGP);
-	pci_read_config_dword(dev, cap_ptr+AGPSTAT, &agp3);
-	if (agp3 & AGPSTAT_MODE_3_0)
-		return 1;
-	return 0;
-}
-
-
 /**
  *	agp_copy_info  -  copy bridge state information
  *
@@ -328,7 +315,7 @@
 	info->version.minor = bridge->version->minor;
 	info->chipset = SUPPORTED;
 	info->device = bridge->dev;
-	if (check_bridge_mode(bridge->dev))
+	if (bridge->mode & AGPSTAT_MODE_3_0)
 		info->mode = bridge->mode & ~AGP3_RESERVED_MASK;
 	else
 		info->mode = bridge->mode & ~AGP2_RESERVED_MASK;
@@ -661,7 +648,7 @@
 		bridge_agpstat &= ~AGPSTAT_FW;
 
 	/* Check to see if we are operating in 3.0 mode */
-	if (check_bridge_mode(agp_bridge->dev))
+	if (agp_bridge->mode & AGPSTAT_MODE_3_0)
 		agp_v3_parse_one(&requested_mode, &bridge_agpstat, &vga_agpstat);
 	else
 		agp_v2_parse_one(&requested_mode, &bridge_agpstat, &vga_agpstat);
@@ -732,7 +719,7 @@
 
 	/* Do AGP version specific frobbing. */
 	if (bridge->major_version >= 3) {
-		if (check_bridge_mode(bridge->dev)) {
+		if (bridge->mode & AGPSTAT_MODE_3_0) {
 			/* If we have 3.5, we can do the isoch stuff. */
 			if (bridge->minor_version >= 5)
 				agp_3_5_enable(bridge);
