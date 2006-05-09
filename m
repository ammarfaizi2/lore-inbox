Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751434AbWEIHDp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434AbWEIHDp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 03:03:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751435AbWEIHDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 03:03:45 -0400
Received: from ozlabs.org ([203.10.76.45]:43757 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751434AbWEIHDo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 03:03:44 -0400
To: Andy Whitcroft <apw@shadowen.org>
CC: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       <haveblue@us.ibm.com>, <kravetz@us.ibm.com>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Tue, 09 May 2006 17:03:42 +1000
Subject: [PATCH] SPARSEMEM + NUMA can't handle unaligned memory regions?
Message-Id: <20060509070343.57853679F2@ozlabs.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can't believe I'm the first person to see this, so I imagine I'm missing
something. Perhaps it's only an issue on powerpc?

I have a machine with some memory at 0, then a hole, and then some more memory
which doesn't start on a section boundary. This is causing the following
crash:

add_region nid 1 start_pfn 0x77c0 pages 0x840
add_region nid 1 start_pfn 0x0 pages 0x6000

...

Unable to handle kernel paging request for data at address 0x00002430
Faulting instruction address: 0xc0000000004f2940
cpu 0x4: Vector: 300 (Data Access) at [c000000000737aa0]
    pc: c0000000004f2940: .__alloc_bootmem_node+0x28/0x7c
    lr: c0000000000a47a0: .sparse_init+0xa8/0x138
    sp: c000000000737d20
   msr: 8000000000001032
   dar: 2430
 dsisr: 40000000
  current = 0xc000000000538410
  paca    = 0xc000000000539780
    pid   = 0, comm = swapper
enter ? for help
4:mon> r
R00 = c0000000000a47a0   R16 = 0000000005ff5000
R01 = c000000000737d20   R17 = 0000000000000004
R02 = c0000000007331e0   R18 = 00000000100d0000
R03 = 0000000000000000   R19 = 00000000100b0000
R04 = 0000000000038000   R20 = 00000000100d0000
R05 = 0000000000000080   R21 = 0000000010070000

The root cause is that we have no memory at pfn 7000 and so early_pfn_to_nid()
is giving us back -1 in sparse_early_mem_map_alloc(). We then pass -1 to
NODE_DATA() which gets us NULL, and hence __alloc_bootmem_node() explodes.

AFAICT there's no logic to prevent us creating sections with no zeroth page,
and in fact my box is doing it. Therefore it's not valid to assume we can
get the nid from the zeroth page in a section. All we know is that there's
one or more pages in that section for which early_pfn_to_nid() will work.

So I came up with this hack. Loop through all pages in the section until
we get a valid nid, this should always work.

We also call early_pfn_to_nid() in node_memmap_size_bytes(), but I didn't
touch that because it's not used on powerpc so I can't test it.

With this patch my machine boots and seems to be happy.

cheers

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 mm/sparse.c |   18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

Index: to-merge/mm/sparse.c
===================================================================
--- to-merge.orig/mm/sparse.c
+++ to-merge/mm/sparse.c
@@ -172,10 +172,26 @@ static int sparse_init_one_section(struc
 	return 1;
 }
 
+static int sparse_section_nr_to_nid(unsigned long pnum)
+{
+	unsigned long pfn = section_nr_to_pfn(pnum);
+	int i, nid;
+
+	for (i = 0; i < PAGES_PER_SECTION; i++) {
+		nid = early_pfn_to_nid(pfn + i);
+		if (nid != -1)
+			break;
+	}
+
+	BUG_ON(nid == -1);
+
+	return nid;
+}
+
 static struct page *sparse_early_mem_map_alloc(unsigned long pnum)
 {
 	struct page *map;
-	int nid = early_pfn_to_nid(section_nr_to_pfn(pnum));
+	int nid = sparse_section_nr_to_nid(pnum);
 	struct mem_section *ms = __nr_to_section(pnum);
 
 	map = alloc_remap(nid, sizeof(struct page) * PAGES_PER_SECTION);
