Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932271AbWGRPMj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271AbWGRPMj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 11:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932270AbWGRPMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 11:12:39 -0400
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:46584 "EHLO
	mtagate3.uk.ibm.com") by vger.kernel.org with ESMTP id S932271AbWGRPMh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 11:12:37 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 1 of 2] x86_64: Calgary IOMMU - fix off by one error
X-Mercurial-Node: 81635ec2e677165285c2a483958899217f9631d8
Message-Id: <81635ec2e677165285c2.1153235477@rhun.haifa.ibm.com>
In-Reply-To: <patchbomb.1153235476@rhun.haifa.ibm.com>
Date: Tue, 18 Jul 2006 18:11:17 +0300
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: ak@suse.de
Cc: jdmason@us.ibm.com, discuss@x86-64.org, linux-kernel@vger.kernel.org,
       konradr@redhat.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

diff -r 1b8d63e34819 -r 81635ec2e677 arch/x86_64/kernel/pci-calgary.c
--- a/arch/x86_64/kernel/pci-calgary.c	Sat Jul 15 22:03:19 2006 +0000
+++ b/arch/x86_64/kernel/pci-calgary.c	Tue Jul 18 18:03:08 2006 +0300
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
