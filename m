Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261823AbTJAAxu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 20:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261828AbTJAAxu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 20:53:50 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:43985 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261823AbTJAAxn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 20:53:43 -0400
Subject: [RFC] mem= for NUMA
From: Dave Hansen <haveblue@us.ibm.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-tJnSwWBKD0D0HzT+d4Qn"
Organization: 
Message-Id: <1064969618.5658.385.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 30 Sep 2003 17:53:39 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-tJnSwWBKD0D0HzT+d4Qn
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

We have a 64GB NUMA machine that doesn't run very well on the stock
kernel due to lack of ZONE_NORMAL.  I think it has ~150MB of free lowmem
immediately after boot, due to consumption of mem_map.

The attached patch is effectively mem= designed for NUMA.  It restricts
the total amount of memory on each NUMA node to the specified amount. 
We need this because a plain mem= on the machine will make the memory
get distributed unevenly which is very bad.

node | plain | mem=32G | memnode=8G
-----+-------+---------+-----------
   0 |   16G |     16G |        8G
   1 |   16G |     16G |        8G
   2 |   16G |      0G |        8G
   3 |   16G |      0G |        8G

Tested on 4-node 32GB NUMA-Q and 4-node 64GB x440.  

In playing with this, I also noticed that we should clean up some of
they variable names in srat.c.  They're long and if you reference 3 of
them you take up an entire 80 column line.
-- 
Dave Hansen
haveblue@us.ibm.com

--=-tJnSwWBKD0D0HzT+d4Qn
Content-Disposition: attachment; filename=mem-per-node-2.6.0-test6-2.patch
Content-Type: text/x-patch; name=mem-per-node-2.6.0-test6-2.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

diff -urp linux-2.6.0-test6-clean/arch/i386/kernel/numaq.c linux-2.6.0-test6-mempernode/arch/i386/kernel/numaq.c
--- linux-2.6.0-test6-clean/arch/i386/kernel/numaq.c	Sat Sep 27 17:50:38 2003
+++ linux-2.6.0-test6-mempernode/arch/i386/kernel/numaq.c	Tue Sep 30 16:20:35 2003
@@ -42,6 +42,10 @@ extern long node_start_pfn[], node_end_p
  * function also increments numnodes with the number of nodes (quads)
  * present.
  */
+extern unsigned long max_pages_per_node;
+extern int limit_mem_per_node;
+
+#define node_size_pages(n) (node_end_pfn[n] - node_start_pfn[n])
 static void __init smp_dump_qct(void)
 {
 	int node;
@@ -60,6 +64,8 @@ static void __init smp_dump_qct(void)
 				eq->hi_shrd_mem_start - eq->priv_mem_size);
 			node_end_pfn[node] = MB_TO_PAGES(
 				eq->hi_shrd_mem_start + eq->hi_shrd_mem_size);
+			if (node_size_pages(node) > max_pages_per_node)
+				node_end_pfn[node] = node_start_pfn[node] + max_pages_per_node;
 		}
 	}
 }
diff -urp linux-2.6.0-test6-clean/arch/i386/kernel/setup.c linux-2.6.0-test6-mempernode/arch/i386/kernel/setup.c
--- linux-2.6.0-test6-clean/arch/i386/kernel/setup.c	Sat Sep 27 17:50:20 2003
+++ linux-2.6.0-test6-mempernode/arch/i386/kernel/setup.c	Tue Sep 30 16:15:01 2003
@@ -139,7 +139,7 @@ static void __init probe_roms(void)
 	probe_extension_roms(roms);
 }
 
-static void __init limit_regions (unsigned long long size)
+void __init limit_regions (unsigned long long size)
 {
 	int i;
 	unsigned long long current_size = 0;
@@ -450,6 +450,7 @@ static void __init setup_memory_region(v
 	print_memory_map(who);
 } /* setup_memory_region */
 
+unsigned long max_pages_per_node = 0xFFFFFFFF; 
 
 static void __init parse_cmdline_early (char ** cmdline_p)
 {
@@ -492,6 +493,14 @@ static void __init parse_cmdline_early (
 				limit_regions(mem_size);
 				userdef=1;
 			}
+		}
+		
+		if (c == ' ' && !memcmp(from, "memnode=", 8)) {
+			unsigned long long node_size_bytes;
+			if (to != command_line)
+				to--;
+			node_size_bytes = memparse(from+8, &from);
+			max_pages_per_node = node_size_bytes >> PAGE_SHIFT;
 		}
 
 		if (c == ' ' && !memcmp(from, "memmap=", 7)) {
diff -urp linux-2.6.0-test6-clean/arch/i386/kernel/srat.c linux-2.6.0-test6-mempernode/arch/i386/kernel/srat.c
--- linux-2.6.0-test6-clean/arch/i386/kernel/srat.c	Sat Sep 27 17:50:11 2003
+++ linux-2.6.0-test6-mempernode/arch/i386/kernel/srat.c	Tue Sep 30 17:49:37 2003
@@ -53,6 +53,10 @@ struct node_memory_chunk_s {
 };
 static struct node_memory_chunk_s node_memory_chunk[MAXCHUNKS];
 
+#define chunk_start(i)	(node_memory_chunk[i].start_pfn)
+#define chunk_end(i)	(node_memory_chunk[i].end_pfn)
+#define chunk_size(i) 	(chunk_end(i)-chunk_start(i))
+
 static int num_memory_chunks;		/* total number of memory chunks */
 static int zholes_size_init;
 static unsigned long zholes_size[MAX_NUMNODES * MAX_NR_ZONES];
@@ -198,6 +202,9 @@ static void __init initialize_physnode_m
 	}
 }
 
+extern unsigned long max_pages_per_node;
+extern int limit_mem_per_node; 
+
 /* Parse the ACPI Static Resource Affinity Table */
 static int __init acpi20_parse_srat(struct acpi_table_srat *sratp)
 {
@@ -281,23 +288,27 @@ static int __init acpi20_parse_srat(stru
 		       node_memory_chunk[j].start_pfn,
 		       node_memory_chunk[j].end_pfn);
 	}
- 
+
 	/*calculate node_start_pfn/node_end_pfn arrays*/
 	for (nid = 0; nid < numnodes; nid++) {
-		int been_here_before = 0;
+		unsigned long node_present_pages = 0;
 
+		node_start_pfn[nid] = -1;
 		for (j = 0; j < num_memory_chunks; j++){
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
+			unsigned long proposed_size;
+
+			if (node_memory_chunk[j].nid != nid)
+				continue;
+
+			proposed_size = node_present_pages + chunk_size(j);
+			if (proposed_size > max_pages_per_node)
+				chunk_end(j) = chunk_start(j) +	
+					max_pages_per_node - node_present_pages;
+			node_present_pages += chunk_size(j);
+
+			if (node_start_pfn[nid] == -1)
+				node_start_pfn[nid] = chunk_start(j);
+			node_end_pfn[nid] = chunk_end(j);
 		}
 	}
 	return 1;

--=-tJnSwWBKD0D0HzT+d4Qn--

