Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261715AbVB1S6X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261715AbVB1S6X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 13:58:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261714AbVB1S6A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 13:58:00 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:12954 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261715AbVB1Syr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 13:54:47 -0500
Subject: [PATCH 5/5] SRAT cleanup: make calculations and indenting level more sane
To: linux-mm@kvack.org
Cc: akpm@osdl.org, kmannth@us.ibm.com, linux-kernel@vger.kernel.org,
       Dave Hansen <haveblue@us.ibm.com>, ygoto@us.fujitsu.com,
       apw@shadowen.org
From: Dave Hansen <haveblue@us.ibm.com>
Date: Mon, 28 Feb 2005 10:54:44 -0800
Message-Id: <E1D5q2X-0007n9-00@kernel.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Using the assumption that all addresses in the SRAT are ascending,
the calculations can get a bit simpler, and remove the 
"been_here_before" variable.

This also breaks that calculation out into its own function, which
further simplifies the look of the code.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 sparse-dave/arch/i386/kernel/srat.c |   67 ++++++++++++++++++------------------
 1 files changed, 35 insertions(+), 32 deletions(-)

diff -puN arch/i386/kernel/srat.c~A3.3-srat-cleanup arch/i386/kernel/srat.c
--- sparse/arch/i386/kernel/srat.c~A3.3-srat-cleanup	2005-02-25 10:18:19.000000000 -0800
+++ sparse-dave/arch/i386/kernel/srat.c	2005-02-25 10:18:26.000000000 -0800
@@ -181,6 +181,38 @@ static __init void chunk_to_zones(unsign
 	}
 }
 
+/*
+ * The SRAT table always lists ascending addresses, so can always
+ * assume that the first "start" address that you see is the real
+ * start of the node, and that the current "end" address is after
+ * the previous one.
+ */
+static __init void node_read_chunk(int nid, struct node_memory_chunk_s *memory_chunk)
+{
+	/*
+	 * Only add present memory as told by the e820.
+	 * There is no guarantee from the SRAT that the memory it
+	 * enumerates is present at boot time because it represents
+	 * *possible* memory hotplug areas the same as normal RAM.
+	 */
+	if (memory_chunk->start_pfn >= max_pfn) {
+		printk (KERN_INFO "Ignoring SRAT pfns: 0x%08lx -> %08lx\n",
+			memory_chunk->start_pfn, memory_chunk->end_pfn);
+		return;
+	}
+	if (memory_chunk->nid != nid)
+		return;
+
+	if (!node_has_online_mem(nid))
+		node_start_pfn[nid] = memory_chunk->start_pfn;
+
+	if (node_start_pfn[nid] > memory_chunk->start_pfn)
+		node_start_pfn[nid] = memory_chunk->start_pfn;
+
+	if (node_end_pfn[nid] < memory_chunk->end_pfn)
+		node_end_pfn[nid] = memory_chunk->end_pfn;
+}
+
 /* Parse the ACPI Static Resource Affinity Table */
 static int __init acpi20_parse_srat(struct acpi_table_srat *sratp)
 {
@@ -261,41 +293,12 @@ static int __init acpi20_parse_srat(stru
 	printk("Number of memory chunks in system = %d\n", num_memory_chunks);
 
 	for (j = 0; j < num_memory_chunks; j++){
+		struct node_memory_chunk_s * chunk = &node_memory_chunk[j];
 		printk("chunk %d nid %d start_pfn %08lx end_pfn %08lx\n",
-		       j, node_memory_chunk[j].nid,
-		       node_memory_chunk[j].start_pfn,
-		       node_memory_chunk[j].end_pfn);
+		       j, chunk->nid, chunk->start_pfn, chunk->end_pfn);
+		node_read_chunk(chunk->nid, chunk);
 	}
  
-	/*calculate node_start_pfn/node_end_pfn arrays*/
-	for_each_online_node(nid) {
-		int been_here_before = 0;
-
-		for (j = 0; j < num_memory_chunks; j++){
-			/*
-			 * Only add present memroy to node_end/start_pfn
-			 * There is no guarantee from the srat that the memory
-			 * is present at boot time.
-			 */
-			if (node_memory_chunk[j].start_pfn >= max_pfn) {
-				printk (KERN_INFO "Ignoring chunk of memory reported in the SRAT (could be hot-add zone?)\n");
-				printk (KERN_INFO "chunk is reported from pfn %04x to %04x\n",
-					node_memory_chunk[j].start_pfn, node_memory_chunk[j].end_pfn);
-				continue;
-			}
-			if (node_memory_chunk[j].nid == nid) {
-				if (been_here_before == 0) {
-					node_start_pfn[nid] = node_memory_chunk[j].start_pfn;
-					node_end_pfn[nid] = node_memory_chunk[j].end_pfn;
-					been_here_before = 1;
-				} else { /* We've found another chunk of memory for the node */
-					if (node_start_pfn[nid] < node_memory_chunk[j].start_pfn) {
-						node_end_pfn[nid] = node_memory_chunk[j].end_pfn;
-					}
-				}
-			}
-		}
-	}
 	for_each_online_node(nid) {
 		unsigned long start = node_start_pfn[nid];
 		unsigned long end = node_end_pfn[nid];
_
