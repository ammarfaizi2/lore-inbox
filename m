Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268467AbUIQB3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268467AbUIQB3K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 21:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268483AbUIQB3C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 21:29:02 -0400
Received: from gate.crashing.org ([63.228.1.57]:38311 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S268467AbUIQB0k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 21:26:40 -0400
Subject: Re: keylargo PCI USB controller nor enabled on G4 xserve
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Thomas Unger <unger@informatik.uni-siegen.de>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <41485359.80602@informatik.uni-siegen.de>
References: <41485359.80602@informatik.uni-siegen.de>
Content-Type: text/plain
Message-Id: <1095384315.2214.21.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 17 Sep 2004 11:25:16 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can you try that workaround (quite ugly until I figure out what's
really going on in there) and let me know if it makes any difference ?

===== arch/ppc/kernel/pci.c 1.43 vs edited =====
--- 1.43/arch/ppc/kernel/pci.c	2004-08-26 16:43:07 +10:00
+++ edited/arch/ppc/kernel/pci.c	2004-09-17 11:19:10 +10:00
@@ -33,6 +33,7 @@
 unsigned long isa_io_base     = 0;
 unsigned long isa_mem_base    = 0;
 unsigned long pci_dram_offset = 0;
+int pcibios_assign_bus_offset = 1;
 
 void pcibios_make_OF_bus_map(void);
 
@@ -1263,7 +1264,7 @@
 		bus = pci_scan_bus(hose->first_busno, hose->ops, hose);
 		hose->last_busno = bus->subordinate;
 		if (pci_assign_all_busses || next_busno <= hose->last_busno)
-			next_busno = hose->last_busno+1;
+			next_busno = hose->last_busno + pcibios_assign_bus_offset;
 	}
 	pci_bus_count = next_busno;
 
===== arch/ppc/platforms/pmac_pci.c 1.22 vs edited =====
--- 1.22/arch/ppc/platforms/pmac_pci.c	2004-08-04 21:55:48 +10:00
+++ edited/arch/ppc/platforms/pmac_pci.c	2004-09-17 11:18:41 +10:00
@@ -50,6 +50,7 @@
 #endif /* CONFIG_POWER4 */
 
 extern u8 pci_cache_line_size;
+extern int pcibios_assign_bus_offset;
 
 struct pci_dev *k2_skiplist[2];
 
@@ -565,6 +566,14 @@
 
 	init_p2pbridge();
 	fixup_nec_usb2();
+	
+	/* We are still having some issues with the Xserve G4, enabling
+	 * some offset between bus number and domains for now when we
+	 * assign all busses should help for now
+	 */
+	if (pci_assign_all_busses)
+		pcibios_assign_bus_offset = 0x10;
+
 #ifdef CONFIG_POWER4 
 	/* There is something wrong with DMA on U3/HT. I haven't figured out
 	 * the details yet, but if I set the cache line size to 128 bytes like


