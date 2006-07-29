Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752074AbWG2Tni@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752074AbWG2Tni (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 15:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752084AbWG2TnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 15:43:11 -0400
Received: from cantor2.suse.de ([195.135.220.15]:58588 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1752075AbWG2Tmm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 15:42:42 -0400
Date: Sat, 29 Jul 2006 21:42:40 +0200
From: "Andi Kleen" <ak@suse.de>
To: torvalds@osdl.org
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org, muli@il.ibm.com
Subject: [PATCH for 2.6.18] [3/8] x86_64: Calgary IOMMU - fix off by one
 error
Message-ID: <44cbba30.5S7ehjoofASZQI2O%ak@suse.de>
User-Agent: nail 11.25 7/29/05
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Muli Ben-Yehuda <muli@il.ibm.com>
# HG changeset patch
# User Muli Ben-Yehuda <muli@il.ibm.com>
# Date 1153234988 -10800
# Node ID 81635ec2e677165285c2a483958899217f9631d8
# Parent  1b8d63e34819bac5b6aac0048ef79004fb243db9
x86_64: Calgary IOMMU - fix off by one error

Fixed off-by-one error in detect_calgary and calgary_init which will
cause arrays to overflow.  Also, removed impossible to hit BUG_ON.

Signed-Off-By: Jon Mason <jdmason@us.ibm.com>
Signed-Off-By: Muli Ben-Yehuda <muli@il.ibm.com>

Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/x86_64/kernel/pci-calgary.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

Index: linux-2.6.18-rc2-git7/arch/x86_64/kernel/pci-calgary.c
===================================================================
--- linux-2.6.18-rc2-git7.orig/arch/x86_64/kernel/pci-calgary.c
+++ linux-2.6.18-rc2-git7/arch/x86_64/kernel/pci-calgary.c
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
