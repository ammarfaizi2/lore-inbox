Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266254AbUBLI1P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 03:27:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266298AbUBLI1P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 03:27:15 -0500
Received: from gate.crashing.org ([63.228.1.57]:23702 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S266254AbUBLI1O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 03:27:14 -0500
Subject: [PATCH] ppc64: fix OF <-> PCI linkage for G5 AGP bus
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1076574249.874.212.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 12 Feb 2004 19:24:10 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus !

This patch fixes the failure of radeonfb to retreive the clock
and EDID data from Open Firmware. The linkage between the PCI device
and the OF node couldn't be established properly at boot because of
the renumbering we do to the G5's AGP bus.

Please apply,
Ben.

===== arch/ppc64/kernel/pmac_pci.c 1.1 vs edited =====
--- 1.1/arch/ppc64/kernel/pmac_pci.c	Thu Feb 12 14:47:58 2004
+++ edited/arch/ppc64/kernel/pmac_pci.c	Thu Feb 12 19:18:24 2004
@@ -709,10 +709,24 @@
 	 * does it only for childs of the host bridges
 	 */
 	pmac_fixup_phb_resources();
-
+	
 	/* Setup the linkage between OF nodes and PHBs */ 
 	pci_devs_phb_init();
 
+	/* We have to deal with the renumbering we do for the AGP bus and update
+	 * the device-node accordingly
+	 */
+	if (u3_agp) {
+		struct device_node *np = (struct device_node *)u3_agp->arch_data;
+		np->busno = 0xf0;
+		np = np->child;
+		while(np) {
+			np->busno = 0xf0;
+			np = np->sibling;
+		}
+	}
+	
+	/* Check HyperTransport link speed */
 	pmac_check_ht_link();
 
 	/* Tell pci.c to use the common resource allocation mecanism */


