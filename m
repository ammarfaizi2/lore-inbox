Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261830AbUCIJ3U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 04:29:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbUCIJ3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 04:29:20 -0500
Received: from gate.crashing.org ([63.228.1.57]:62160 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261834AbUCIJ3P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 04:29:15 -0500
Subject: [PATCH] Fix PCI<->OF matching on G5 AGP bus
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1078824380.14366.239.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 09 Mar 2004 20:26:20 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Strangely, I though I fixed that a long time ago, but it was still
broken in the current tree... So drivers like radeonfb fail to
find the OF device matching a given PCI device on the G5 AGP bus
because of some bus renumbering tricks. This patch fixes the
problem by fixing the bus numbers in the OF node. This corrects
radeonfb and other drivers looking for EDID / PLL datas in the
OF node.

===== arch/ppc64/kernel/pmac_pci.c 1.3 vs edited =====
--- 1.3/arch/ppc64/kernel/pmac_pci.c	Mon Mar  1 11:50:37 2004
+++ edited/arch/ppc64/kernel/pmac_pci.c	Tue Mar  9 20:20:53 2004
@@ -719,6 +719,17 @@
 	/* Setup the linkage between OF nodes and PHBs */ 
 	pci_devs_phb_init();
 
+	/* Fixup the PCI<->OF mapping for U3 AGP due to bus renumbering. We
+	 * assume there is no P2P bridge on the AGP bus, which should be a
+	 * safe assumptions hopefully.
+	 */
+	if (u3_agp) {
+		struct device_node *np = u3_agp->arch_data;
+		np->busno = 0xf0;
+		for (np = np->child; np; np = np->sibling)
+			np->busno = 0xf0;
+	}
+
 	pmac_check_ht_link();
 
 	/* Tell pci.c to use the common resource allocation mecanism */


