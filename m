Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750719AbVL2NjF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbVL2NjF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 08:39:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750722AbVL2NjF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 08:39:05 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:39951 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750719AbVL2NjE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 08:39:04 -0500
Date: Thu, 29 Dec 2005 14:39:02 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>, ak@suse.de
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       discuss@x86-64.org
Subject: [2.6.15-rc7 patch] Reject SRAT tables that don't cover all memory
Message-ID: <20051229133902.GD3811@stusta.de>
References: <Pine.LNX.4.64.0512241930370.14098@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0512241930370.14098@g5.osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Below is a patch by Andi Kleen from kernel Bugzilla #5758 fixing a 
post-2.6.14 regression.

cu
Adrian


<--  snip  -->


Reject SRAT tables that don't cover all memory

Broken BIOS on Iwill reports these and it causes the bootmem
allocator to crash. Add a sanity check if all the PXMs in the
SRAT table cover all memory as reported by e820.

This patch fixes kernel Bugzilla #5758.


From: Andi Kleen <ak@suse.de>

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux.orig/arch/x86_64/mm/srat.c
+++ linux/arch/x86_64/mm/srat.c
@@ -17,6 +17,7 @@
 #include <linux/topology.h>
 #include <asm/proto.h>
 #include <asm/numa.h>
+#include <asm/e820.h>
 
 static struct acpi_table_slit *acpi_slit;
 
@@ -196,12 +197,39 @@ acpi_numa_memory_affinity_init(struct ac
 	       nd->start, nd->end);
 }
 
+/* Sanity check to catch more bad SRATs (they are amazingly common). 
+   Make sure the PXMs cover all memory. */
+static int nodes_cover_memory(void)
+{
+	int i;
+	unsigned long pxmram, e820ram;
+	
+	pxmram = 0;
+	for_each_node_mask(i, nodes_parsed) {
+		unsigned long s = nodes[i].start >> PAGE_SHIFT;
+		unsigned long e = nodes[i].end >> PAGE_SHIFT;
+		pxmram += e - s;
+		pxmram -= e820_hole_size(s, e);
+	}
+	
+	e820ram = end_pfn - e820_hole_size(0, end_pfn);
+	if (pxmram < e820ram) {
+		printk(KERN_ERR 
+	"SRAT: PXMs only cover %luMB of your %luMB e820 RAM. Not used.\n",
+			(pxmram << PAGE_SHIFT) >> 20, 	
+			(e820ram << PAGE_SHIFT) >> 20); 
+		return 0;
+	}
+	return 1;
+}
+
 void __init acpi_numa_arch_fixup(void) {}
 
 /* Use the information discovered above to actually set up the nodes. */
 int __init acpi_scan_nodes(unsigned long start, unsigned long end)
 {
 	int i;
+
 	if (acpi_numa <= 0)
 		return -1;
 
@@ -212,6 +240,11 @@ int __init acpi_scan_nodes(unsigned long
 			node_clear(i, nodes_parsed);
 	}
 
+	if (!nodes_cover_memory()) { 
+		bad_srat();
+		return -1;
+	}
+
 	memnode_shift = compute_hash_shift(nodes, nodes_weight(nodes_parsed));
 	if (memnode_shift < 0) {
 		printk(KERN_ERR
