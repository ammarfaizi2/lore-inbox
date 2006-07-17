Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751225AbWGQXGT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225AbWGQXGT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 19:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbWGQXGT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 19:06:19 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:43661 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751225AbWGQXGS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 19:06:18 -0400
Date: Mon, 17 Jul 2006 18:05:44 -0500
From: Jon Mason <jdmason@us.ibm.com>
To: ak@suse.de
Cc: muli@il.ibm.com, discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] x86_64: Calgary IOMMU - off by one error
Message-ID: <20060717230544.GC5363@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Andi,
Off-by-one error in detect_calgary and calgary_init which will cause
arrays to overflow.  Also, removed impossible to hit BUG_ON.

Please consider for inclusion in 2.6.18

Thanks,
Jon

Signed-Off-By: Jon Mason <jdmason@us.ibm.com>
Signed-Off-By: Muli Ben-Yehuda <muli@il.ibm.com>

diff -r 7815b0fa8a29 -r c59d0a0b1975 arch/x86_64/kernel/pci-calgary.c
--- a/arch/x86_64/kernel/pci-calgary.c	Thu Jul 13 09:57:43 2006 +0300
+++ b/arch/x86_64/kernel/pci-calgary.c	Thu Jul 13 08:50:58 2006 -0500
@@ -812,7 +812,7 @@ static int __init calgary_init(void)
 	int i, ret = -ENODEV;
 	struct pci_dev *dev = NULL;
 
-	for (i = 0; i <= num_online_nodes() * MAX_NUM_OF_PHBS; i++) {
+	for (i = 0; i < num_online_nodes() * MAX_NUM_OF_PHBS; i++) {
 		dev = pci_get_device(PCI_VENDOR_ID_IBM,
 				     PCI_DEVICE_ID_IBM_CALGARY,
 				     dev);
@@ -890,9 +890,8 @@ void __init detect_calgary(void)
 	specified_table_size = determine_tce_table_size(end_pfn * PAGE_SIZE);
 
 	for (bus = 0, table_idx = 0;
-	     bus <= num_online_nodes() * MAX_PHB_BUS_NUM;
+	     bus < num_online_nodes() * MAX_PHB_BUS_NUM;
 	     bus++) {
-		BUG_ON(bus > MAX_NUMNODES * MAX_PHB_BUS_NUM);
 		if (read_pci_config(bus, 0, 0, 0) != PCI_VENDOR_DEVICE_ID_CALGARY)
 			continue;
 		if (test_bit(bus, translation_disabled)) {
@@ -1002,7 +1001,7 @@ static int __init calgary_parse_options(
 			if (p == endp)
 				break;
 
-			if (bridge <= (num_online_nodes() * MAX_PHB_BUS_NUM)) {
+			if (bridge < (num_online_nodes() * MAX_PHB_BUS_NUM)) {
 				printk(KERN_INFO "Calgary: disabling "
 				       "translation for PHB 0x%x\n", bridge);
 				set_bit(bridge, translation_disabled);
