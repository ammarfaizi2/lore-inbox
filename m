Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267338AbUIXADs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267338AbUIXADs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 20:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267558AbUIXADU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 20:03:20 -0400
Received: from gate.crashing.org ([63.228.1.57]:38112 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S267338AbUIWXz1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 19:55:27 -0400
Subject: [PATCH] ppc32: Fix Apple Xserve G4 PCI probing
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1095983708.3832.14.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 24 Sep 2004 09:55:09 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

When pci_assign_all_busses is set, the common code will re-assign all
the bus numbers, which we still need to do one various pmacs, at least
until XFree/XOrg understands PCI domains properly. However, this process
triggers a bug if during this renumbering, on a given segment, a P2P
bridge not yet renumbered has conflicting downstream bus range with
a P2P bridge just renumbered. The probing will just behave randomly
and either miss devices, show duplicates, or just lockup in some
circumstances. This is typically triggered on Apple Xserve G4s who
have at least 2 P2P bridges built-in on the same segment of the
first PCI (non-AGP) domain

The "workaround" we use on pmac that was in my tree for a while but
got "lost" during the big merge a while ago is to offset the bus numbers
between domains by 16. This avoids the above collision scenario in all
practical cases.

The long term solution of course is to stop renumbering and make sure
that all drivers are domain safe (there may be a couple issue remaining
in the code that matches PCI / OF devices on ppc32) and XFree/XOrg has
to be fixed.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

diff -urN linux-2.5/arch/ppc/kernel/pci.c linux-prom-clean/arch/ppc/kernel/pci.c
--- linux-2.5/arch/ppc/kernel/pci.c	2004-08-27 15:44:34.000000000 +1000
+++ linux-prom-clean/arch/ppc/kernel/pci.c	2004-09-21 11:17:40.000000000 +1000
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
 
diff -urN linux-2.5/arch/ppc/platforms/pmac_pci.c linux-prom-clean/arch/ppc/platforms/pmac_pci.c
--- linux-2.5/arch/ppc/platforms/pmac_pci.c	2004-08-26 16:27:17.000000000 +1000
+++ linux-prom-clean/arch/ppc/platforms/pmac_pci.c	2004-09-21 11:17:40.000000000 +1000
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


