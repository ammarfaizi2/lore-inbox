Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965003AbVJ0Ihf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965003AbVJ0Ihf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 04:37:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965002AbVJ0Ihf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 04:37:35 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:27294 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S965003AbVJ0Ihe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 04:37:34 -0400
From: Magnus Damm <magnus@valinux.co.jp>
To: linux-kernel@vger.kernel.org
Cc: Magnus Damm <magnus@valinux.co.jp>, ak@suse.de
Message-Id: <20051027083758.17127.10839.sendpatchset@cherry.local>
Subject: [PATCH] x86_64: NUMA range fixes
Date: Thu, 27 Oct 2005 17:37:33 +0900 (JST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The current x86_64 NUMA memory code is inconsequent when it comes to node
memory ranges. The exact behaviour varies depending on which config option
that is used.

setup_node_bootmem() has start and end as arguments and these are used to 
calculate the size of the node like this: (end - start). This is all fine
if end is pointing to the first non-available byte. The problem is that the
current x86_64 code sometimes treats it as the last present byte and sometimes
as the first non-available byte. The result is that some configurations might
lose a page at the end of the range.

This patch tries to fix CONFIG_ACPI_NUMA, CONFIG_K8_NUMA and CONFIG_NUMA_EMU
so they all treat the end variable as the first non-available byte. This is
the same way as the single node code.

The patch is boot tested on dual x86_64 hardware with the above configurations,
but maybe the removed code is needed as some workaround?

Signed-off-by: Magnus Damm <magnus@valinux.co.jp>
---

BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007fff0000 (usable)
 BIOS-e820: 000000007fff0000 - 000000007ffff000 (ACPI data)
 BIOS-e820: 000000007ffff000 - 0000000080000000 (ACPI NVS)
 BIOS-e820: 00000000ff780000 - 0000000100000000 (reserved)

CONFIG_ACPI_NUMA:
-----------------
(without patch)
Bootmem setup node 0 0000000000000000-000000003fffffff
Bootmem setup node 1 0000000040000000-000000007ffeffff
On node 0 totalpages: 262046
  DMA zone: 3999 pages, LIFO batch:1
  Normal zone: 258047 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
On node 1 totalpages: 262127
  DMA zone: 0 pages, LIFO batch:1
  Normal zone: 262127 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
...
(with patch)
Bootmem setup node 0 0000000000000000-0000000040000000
Bootmem setup node 1 0000000040000000-000000007fff0000
On node 0 totalpages: 262047
  DMA zone: 3999 pages, LIFO batch:1
  Normal zone: 258048 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
On node 1 totalpages: 262128
  DMA zone: 0 pages, LIFO batch:1
  Normal zone: 262128 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
...

CONFIG_K8_NUMA:
---------------
(without patch)
Bootmem setup node 0 0000000000000000-000000003fffffff
Bootmem setup node 1 0000000040000000-000000007fff0000
On node 0 totalpages: 262046
  DMA zone: 3999 pages, LIFO batch:1
  Normal zone: 258047 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
On node 1 totalpages: 262128
  DMA zone: 0 pages, LIFO batch:1
  Normal zone: 262128 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
...
(with patch)
Bootmem setup node 0 0000000000000000-0000000040000000
Bootmem setup node 1 0000000040000000-000000007fff0000
On node 0 totalpages: 262047
  DMA zone: 3999 pages, LIFO batch:1
  Normal zone: 258048 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
On node 1 totalpages: 262128
  DMA zone: 0 pages, LIFO batch:1
  Normal zone: 262128 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
...

CONFIG_NUMA_EMU: (passing numa=fake=4 to kernel)
----------------
(without patch)
Bootmem setup node 0 0000000000000000-000000000fffffff
Bootmem setup node 1 0000000010000000-000000001fffffff
Bootmem setup node 2 0000000020000000-000000002fffffff
Bootmem setup node 3 0000000030000000-000000007fff0000
On node 0 totalpages: 65438
  DMA zone: 3999 pages, LIFO batch:1
  Normal zone: 61439 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
On node 1 totalpages: 65535
  DMA zone: 0 pages, LIFO batch:1
  Normal zone: 65535 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
On node 2 totalpages: 65535
  DMA zone: 0 pages, LIFO batch:1
  Normal zone: 65535 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
On node 3 totalpages: 327664
  DMA zone: 0 pages, LIFO batch:1
  Normal zone: 327664 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
...
(with patch)
Bootmem setup node 0 0000000000000000-0000000010000000
Bootmem setup node 1 0000000010000000-0000000020000000
Bootmem setup node 2 0000000020000000-0000000030000000
Bootmem setup node 3 0000000030000000-000000007fff0000
On node 0 totalpages: 65439
  DMA zone: 3999 pages, LIFO batch:1
  Normal zone: 61440 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
On node 1 totalpages: 65536
  DMA zone: 0 pages, LIFO batch:1
  Normal zone: 65536 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
On node 2 totalpages: 65536
  DMA zone: 0 pages, LIFO batch:1
  Normal zone: 65536 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
On node 3 totalpages: 327664
  DMA zone: 0 pages, LIFO batch:1
  Normal zone: 327664 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
...

 k8topology.c |    1 +
 numa.c       |    2 --
 srat.c       |    4 ----
 3 files changed, 1 insertion(+), 6 deletions(-)

diff -urNp linux-2.6.14-rc5-git5/arch/x86_64/mm/k8topology.c linux-2.6.14-rc5-git5-x86_64_numa_range_fixes/arch/x86_64/mm/k8topology.c
--- linux-2.6.14-rc5-git5/arch/x86_64/mm/k8topology.c	2005-10-24 15:37:44.000000000 +0900
+++ linux-2.6.14-rc5-git5-x86_64_numa_range_fixes/arch/x86_64/mm/k8topology.c	2005-10-27 17:03:49.000000000 +0900
@@ -108,6 +108,7 @@ int __init k8_scan_nodes(unsigned long s
 		limit >>= 16; 
 		limit <<= 24; 
 		limit |= (1<<24)-1;
+		limit++;
 
 		if (limit > end_pfn << PAGE_SHIFT)
 			limit = end_pfn << PAGE_SHIFT;
diff -urNp linux-2.6.14-rc5-git5/arch/x86_64/mm/numa.c linux-2.6.14-rc5-git5-x86_64_numa_range_fixes/arch/x86_64/mm/numa.c
--- linux-2.6.14-rc5-git5/arch/x86_64/mm/numa.c	2005-10-24 15:37:44.000000000 +0900
+++ linux-2.6.14-rc5-git5-x86_64_numa_range_fixes/arch/x86_64/mm/numa.c	2005-10-27 17:03:53.000000000 +0900
@@ -205,8 +205,6 @@ static int numa_emulation(unsigned long 
  		if (i == numa_fake-1)
  			sz = (end_pfn<<PAGE_SHIFT) - nodes[i].start;
  		nodes[i].end = nodes[i].start + sz;
- 		if (i != numa_fake-1)
- 			nodes[i].end--;
  		printk(KERN_INFO "Faking node %d at %016Lx-%016Lx (%LuMB)\n",
  		       i,
  		       nodes[i].start, nodes[i].end,
diff -urNp linux-2.6.14-rc5-git5/arch/x86_64/mm/srat.c linux-2.6.14-rc5-git5-x86_64_numa_range_fixes/arch/x86_64/mm/srat.c
--- linux-2.6.14-rc5-git5/arch/x86_64/mm/srat.c	2005-10-24 15:37:44.000000000 +0900
+++ linux-2.6.14-rc5-git5-x86_64_numa_range_fixes/arch/x86_64/mm/srat.c	2005-10-27 17:03:55.000000000 +0900
@@ -71,8 +71,6 @@ static __init void cutoff_node(int i, un
 			nd->start = nd->end;
 	}
 	if (nd->end > end) {
-		if (!(end & 0xfff))
-			end--;
 		nd->end = end;
 		if (nd->start > nd->end)
 			nd->start = nd->end;
@@ -166,8 +164,6 @@ acpi_numa_memory_affinity_init(struct ac
 		if (nd->end < end)
 			nd->end = end;
 	}
-	if (!(nd->end & 0xfff))
-		nd->end--;
 	printk(KERN_INFO "SRAT: Node %u PXM %u %Lx-%Lx\n", node, pxm,
 	       nd->start, nd->end);
 }
