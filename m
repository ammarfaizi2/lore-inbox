Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272778AbTHMNNT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 09:13:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272976AbTHMNNT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 09:13:19 -0400
Received: from [66.212.224.118] ([66.212.224.118]:1034 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S272778AbTHMNNR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 09:13:17 -0400
Date: Wed, 13 Aug 2003 09:01:26 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Andi Kleen <ak@suse.de>
Subject: [PATCH][2.6-mm] cpumask_t/x86_64 __flush_gart fix
Message-ID: <Pine.LNX.4.53.0308130852050.4078@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Index: linux-2.6.0-test3-mm2-x86_64/arch/x86_64/kernel/pci-gart.c
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test3/arch/x86_64/kernel/pci-gart.c,v
retrieving revision 1.1.1.2
diff -u -p -B -r1.1.1.2 pci-gart.c
--- linux-2.6.0-test3-mm2-x86_64/arch/x86_64/kernel/pci-gart.c	13 Aug 2003 12:10:24 -0000	1.1.1.2
+++ linux-2.6.0-test3-mm2-x86_64/arch/x86_64/kernel/pci-gart.c	13 Aug 2003 12:50:14 -0000
@@ -141,15 +141,16 @@ static void free_iommu(unsigned long off
 static void __flush_gart(struct pci_dev *dev)
 { 
 	unsigned long flags;
-	int bus = dev ? dev->bus->number : -1; 
+	int bus = dev ? dev->bus->number : -1;
+	cpumask_const_t bus_cpumask = pcibus_to_cpumask(bus);
 	int flushed = 0;
 	int i;
 
 	spin_lock_irqsave(&iommu_bitmap_lock, flags);
 	/* recheck flush count inside lock */
 	if (need_flush) { 
-		for (i = 0; northbridges[i]; i++) { 
-			if (bus >= 0 && !(pcibus_to_cpumask(bus) & (1UL << i))) 
+		for (i = 0; northbridges[i]; i++) {
+			if (bus >= 0 && !(cpu_isset_const(i, bus_cpumask))) 
 				continue;
 			pci_write_config_dword(northbridges[i], 0x9c, 
 					       northbridge_flush_word[i] | 1); 
