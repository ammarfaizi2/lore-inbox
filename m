Return-Path: <linux-kernel-owner+w=401wt.eu-S1753963AbWL2AwT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753963AbWL2AwT (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 19:52:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753961AbWL2AwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 19:52:19 -0500
Received: from smtp-out.google.com ([216.239.33.17]:45773 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753963AbWL2AwS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 19:52:18 -0500
X-Greylist: delayed 789 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Dec 2006 19:52:18 EST
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:content-type:
	organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=RVcjyDWhTLV8Zb0I956egxSqdlpx71xoiIBdIuvCqCf+Z1gaz8T/1SmWN1PKUvjwl
	YXzNXYVJneIOc1a9rsqMA==
Subject: [Patch]: fake numa for x86_64 machines with big IO hole.
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Mel Gorman <mel@csn.ul.ie>,
       Paul Menage <menage@google.com>,
       David Rientjes <rientjes@cs.washington.edu>,
       linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Google Inc
Date: Thu, 28 Dec 2006 16:36:59 -0800
Message-Id: <1167352619.17710.70.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch resolves the issue of running with numa=fake=X on kernel
command line on x86_64 machines that have big IO hole.  While
calculating the size of each node now we look at the total hole size in
that range.  Previously there were nodes that only had IO holes in them
causing kernel boot problems.  We now use the NODE_MIN_SIZE (64MB) as
the minimum size of memory that any node must have.  We reduce the
number of allocated nodes if the number of nodes specified on kernel
command line results in any node getting memory smaller than
NODE_MIN_SIZE.  This change allows the extra memory to be incremented in
NODE_MIN_SIZE granule and uniformly distribute among as many nodes
(called big nodes) as possible.

Signed-off-by: David Rientjes <reintjes@google.com>
Signed-off-by: Paul Menage <menage@google.com>
Signed-off-by: Rohit Seth <rohitseth@google.com>

--- linux-2.6.20-rc1-mm1.org/include/asm-x86_64/mmzone.h	2006-12-28 16:04:19.000000000 -0800
+++ linux-2.6.20-rc1-mm1/include/asm-x86_64/mmzone.h	2006-12-28 16:00:17.000000000 -0800
@@ -47,5 +47,10 @@ static inline __attribute__((pure)) int 
 extern int pfn_valid(unsigned long pfn);
 #endif
 
+#ifdef CONFIG_NUMA_EMU
+#define NODE_MIN_SIZE	(64*1024*1024)
+#define NODE_MIN_HASH_MASK	(~(NODE_MIN_SIZE - 1ul))
+#endif
+
 #endif
 #endif
--- linux-2.6.20-rc1-mm1.org/include/asm-x86_64/e820.h	2006-12-28 16:04:19.000000000 -0800
+++ linux-2.6.20-rc1-mm1/include/asm-x86_64/e820.h	2006-12-28 15:59:19.000000000 -0800
@@ -46,6 +46,7 @@ extern void e820_mark_nosave_regions(voi
 extern void e820_print_map(char *who);
 extern int e820_any_mapped(unsigned long start, unsigned long end, unsigned type);
 extern int e820_all_mapped(unsigned long start, unsigned long end, unsigned type);
+extern unsigned long e820_hole_size(unsigned long start, unsigned long end);
 
 extern void e820_setup_gap(void);
 extern void e820_register_active_regions(int nid,
--- linux-2.6.20-rc1-mm1.org/arch/x86_64/mm/numa.c	2006-12-28 16:04:19.000000000 -0800
+++ linux-2.6.20-rc1-mm1/arch/x86_64/mm/numa.c	2006-12-28 16:02:07.000000000 -0800
@@ -275,31 +275,111 @@ void __init numa_init_array(void)
 }
 
 #ifdef CONFIG_NUMA_EMU
+/* Numa emulation */
 int numa_fake __initdata = 0;
 
-/* Numa emulation */
+/*
+ * This function is used to find out if the start and end correspond to 
+ * different zones.
+ */
+int zone_cross_over(unsigned long start, unsigned long end)
+{
+	if ((start < (MAX_DMA32_PFN << PAGE_SHIFT)) &&
+			(end >= (MAX_DMA32_PFN << PAGE_SHIFT)))
+		return 1;
+	return 0;
+}
+
 static int __init numa_emulation(unsigned long start_pfn, unsigned long end_pfn)
 {
- 	int i;
+ 	int i, big;
  	struct bootnode nodes[MAX_NUMNODES];
- 	unsigned long sz = ((end_pfn - start_pfn)<<PAGE_SHIFT) / numa_fake;
+ 	unsigned long sz, old_sz;
+	unsigned long hole_size;
+	unsigned long start, end;
+	unsigned long max_addr = (end_pfn << PAGE_SHIFT);
+
+	start = (start_pfn << PAGE_SHIFT);
+	hole_size = e820_hole_size(start, max_addr);
+	sz = (max_addr - start - hole_size) / numa_fake;
 
  	/* Kludge needed for the hash function */
- 	if (hweight64(sz) > 1) {
- 		unsigned long x = 1;
- 		while ((x << 1) < sz)
- 			x <<= 1;
- 		if (x < sz/2)
- 			printk(KERN_ERR "Numa emulation unbalanced. Complain to maintainer\n");
- 		sz = x;
- 	}
 
+	old_sz = sz;
+	/*
+	 * Round down to the nearest NODE_MIN_SIZE.
+	 */
+	sz &= NODE_MIN_HASH_MASK;
+
+	/*
+	 * We ensure that each node is at least 64MB big.  Smaller than this
+	 * size can cause VM hiccups.
+	 */
+	if (sz == 0) {
+		printk(KERN_INFO"Not enough memory for %d nodes.  Reducing "
+				"the number of nodes\n", numa_fake);
+		numa_fake = (max_addr - start - hole_size) / NODE_MIN_SIZE;
+		printk(KERN_INFO"Number of fake nodes will be = %d\n", numa_fake);
+		sz = NODE_MIN_SIZE;
+	}
+	/*
+	 * Find out how many nodes can get an extra NODE_MIN_SIZE granule.
+	 * This logic ensures the extra memory gets distributed among as many
+	 * nodes as possible (as compared to one single node getting all that
+	 * extra memory.
+	 */
+	big = ((old_sz - sz) * numa_fake) / NODE_MIN_SIZE;
+	printk(KERN_INFO"Fake node Size: %luMB hole_size: %luMB big nodes: %d\n",
+			(sz >> 20), (hole_size >> 20), big);
  	memset(&nodes,0,sizeof(nodes));
+	end = start;
  	for (i = 0; i < numa_fake; i++) {
- 		nodes[i].start = (start_pfn<<PAGE_SHIFT) + i*sz;
+		/*
+		 * In case we are not able to allocate enough memory for all
+		 * the nodes, we reduce the number of fake nodes.
+		 */
+		if (end >= max_addr) {
+			numa_fake = i - 1;
+			break;
+		}
+ 		start = nodes[i].start = end;
+		/*
+		 * Final node can have all the remaining memory.
+		 */
  		if (i == numa_fake-1)
- 			sz = (end_pfn<<PAGE_SHIFT) - nodes[i].start;
- 		nodes[i].end = nodes[i].start + sz;
+ 			sz = max_addr - start;
+ 		end = nodes[i].start + sz;
+		/*
+		 * Fir "big" number of nodes get extra granule.
+		 */
+		if (i < big)
+			end += NODE_MIN_SIZE;
+		/*
+		 * Iterate over the range to ensure that this node gets at
+		 * least sz amount of RAM (excluding holes)
+		 */
+		while ((end - start - e820_hole_size(start, end)) < sz) {
+			end += NODE_MIN_SIZE;
+			if (end >= max_addr)
+				break;
+		}
+		/*
+		 * Look at the next node to make sure there is some real memory
+		 * to map.  Bad things happen when the only memory present
+		 * in a zone on a fake node is IO hole.
+		 */
+		while (e820_hole_size(end, end + NODE_MIN_SIZE) > 0) {
+			if (zone_cross_over(start, end + sz)) {
+				end = (MAX_DMA32_PFN << PAGE_SHIFT);
+				break;
+			}
+			if (end >= max_addr)
+				break;
+			end += NODE_MIN_SIZE;
+		}
+		if (end > max_addr)
+			end = max_addr;
+		nodes[i].end = end;
  		printk(KERN_INFO "Faking node %d at %016Lx-%016Lx (%LuMB)\n",
  		       i,
  		       nodes[i].start, nodes[i].end,
--- linux-2.6.20-rc1-mm1.org/arch/x86_64/kernel/e820.c	2006-12-28 16:04:19.000000000 -0800
+++ linux-2.6.20-rc1-mm1/arch/x86_64/kernel/e820.c	2006-12-21 16:50:30.000000000 -0800
@@ -191,6 +191,37 @@ unsigned long __init e820_end_of_ram(voi
 }
 
 /*
+ * Find the hole size in the range.
+ */
+unsigned long __init e820_hole_size(unsigned long start, unsigned long end)
+{
+	unsigned long ram = 0;
+	int i;
+
+	for (i = 0; i < e820.nr_map; i++) {
+		struct e820entry *ei = &e820.map[i];
+		unsigned long last, addr;
+
+		if (ei->type != E820_RAM ||
+		    ei->addr+ei->size <= start ||
+		    ei->addr >= end)
+			continue;
+
+		addr = round_up(ei->addr, PAGE_SIZE);
+		if (addr < start)
+			addr = start;
+
+		last = round_down(ei->addr + ei->size, PAGE_SIZE);
+		if (last >= end)
+			last = end;
+
+		if (last > addr)
+			ram += last - addr;
+	}
+	return ((end - start) - ram);
+}
+
+/*
  * Mark e820 reserved areas as busy for the resource manager.
  */
 void __init e820_reserve_resources(void)


