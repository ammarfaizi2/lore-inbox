Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261404AbUCPTpQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 14:45:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261586AbUCPTmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 14:42:06 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:57251 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261404AbUCPTkR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 14:40:17 -0500
Date: Tue, 16 Mar 2004 11:39:52 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Jesse Barnes <jbarnes@sgi.com>, Robert Picco <Robert.Picco@hp.com>,
       linux-kernel@vger.kernel.org
cc: colpatch@us.ibm.com, haveblue@us.ibm.com
Subject: Re: boot time node and memory limit options
Message-ID: <34060000.1079465992@flay>
In-Reply-To: <20040316174329.GA29992@sgi.com>
References: <4057392A.8000602@hp.com> <20040316174329.GA29992@sgi.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Tuesday, March 16, 2004 09:43:29 -0800 Jesse Barnes <jbarnes@sgi.com> wrote:

> On Tue, Mar 16, 2004 at 12:28:10PM -0500, Robert Picco wrote:
>> This patch supports three boot line options.  mem_limit limits the
>> amount of physical memory.  node_mem_limit limits the amount of
>> physical memory per node on a NUMA machine.  nodes_limit reduces the
>> number of NUMA nodes to the value specified.  On a NUMA machine an
>> eliminated node's CPU(s) are removed from the cpu_possible_map.  
>> 
>> The patch has been tested on an IA64 NUMA machine and uniprocessor X86
>> machine.
> 
> I think this patch will be really useful.  Matt and Martin, does it look
> ok to you?  Given that discontiguous support is pretty platform specific
> right now, I thought it might be less code if it was done in arch/, but
> a platform independent version is awfully nice...

I haven't looked at your code yet, but I've had a similar patch in my tree
from Dave Hansen for a while you might want to look at:

diff -purN -X /home/mbligh/.diff.exclude 320-kcg/arch/i386/kernel/numaq.c 330-numa_mem_equals/arch/i386/kernel/numaq.c
--- 320-kcg/arch/i386/kernel/numaq.c	2003-10-01 11:47:33.000000000 -0700
+++ 330-numa_mem_equals/arch/i386/kernel/numaq.c	2004-03-14 09:54:00.000000000 -0800
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
diff -purN -X /home/mbligh/.diff.exclude 320-kcg/arch/i386/kernel/setup.c 330-numa_mem_equals/arch/i386/kernel/setup.c
--- 320-kcg/arch/i386/kernel/setup.c	2004-03-11 14:33:36.000000000 -0800
+++ 330-numa_mem_equals/arch/i386/kernel/setup.c	2004-03-14 09:54:00.000000000 -0800
@@ -142,7 +142,7 @@ static void __init probe_roms(void)
 	probe_extension_roms(roms);
 }
 
-static void __init limit_regions(unsigned long long size)
+void __init limit_regions(unsigned long long size)
 {
 	unsigned long long current_addr = 0;
 	int i;
@@ -478,6 +478,7 @@ static void __init setup_memory_region(v
 	print_memory_map(who);
 } /* setup_memory_region */
 
+unsigned long max_pages_per_node = 0xFFFFFFFF; 
 
 static void __init parse_cmdline_early (char ** cmdline_p)
 {
@@ -521,6 +522,14 @@ static void __init parse_cmdline_early (
 				userdef=1;
 			}
 		}
+		
+		if (c == ' ' && !memcmp(from, "memnode=", 8)) {
+			unsigned long long node_size_bytes;
+			if (to != command_line)
+				to--;
+			node_size_bytes = memparse(from+8, &from);
+			max_pages_per_node = node_size_bytes >> PAGE_SHIFT;
+		}
 
 		if (c == ' ' && !memcmp(from, "memmap=", 7)) {
 			if (to != command_line)
diff -purN -X /home/mbligh/.diff.exclude 320-kcg/arch/i386/kernel/srat.c 330-numa_mem_equals/arch/i386/kernel/srat.c
--- 320-kcg/arch/i386/kernel/srat.c	2003-10-01 11:47:33.000000000 -0700
+++ 330-numa_mem_equals/arch/i386/kernel/srat.c	2004-03-14 09:54:01.000000000 -0800
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

