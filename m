Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266243AbUBGE2D (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 23:28:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266461AbUBGE2C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 23:28:02 -0500
Received: from dp.samba.org ([66.70.73.150]:6614 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S266243AbUBGE1y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 23:27:54 -0500
Date: Sat, 7 Feb 2004 15:25:59 +1100
From: Anton Blanchard <anton@samba.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Manfreds patch to distribute boot allocations across nodes
Message-ID: <20040207042559.GP19011@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Manfred had a patch to distribute kmallocs across nodes during boot.
I took it for a spin.

buddyinfo before:
Node 7, 0    2    1    1    0    2    1    2    1    2    1    2    741
Node 6, 0    0    0    2    0    2    1    1    2    2    2    2   1002
Node 5, 0    0    0    2    0    2    1    2    1    2    2    2   2006
Node 4, 0    0    0    2    0    2    1    2    1    2    2    2   2006
Node 3, 0    0    0    2    0    2    1    2    1    2    2    2   2006
Node 2, 0    0    0    2    0    2    1    2    1    2    2    2   2006
Node 1, 0    0    0    2    0    2    1    1    2    2    2    2   1002
Node 0, 0    0   38    7    0    1    1    1    0    0    0    0   1998

buddyinfo after:
Node 7, 0    1    0    1    1    1    1    0    0    0    1    2    738
Node 6, 0    1    0    1    1    1    0    1    0    0    2    2   1002
Node 5, 0    0    0    1    1    1    1    0    0    0    2    2   2006
Node 4, 0    1    0    1    0    1    1    0    0    0    2    2   2006
Node 3, 0    0    0    1    0    1    1    0    0    0    2    2   2005
Node 2, 0    1    0    0    0    0    0    1    0    0    2    2   2006
Node 1, 0    2    1    1    0    1    1    1    0    0    2    2   1002
Node 0, 0   20   45    8    3    0    1    1    1    1    0    1   2004

Change in free memory due to patch:

Node 7 -54.08 MB
Node 6  -6.33 MB
Node 5  -6.09 MB
Node 4  -6.14 MB
Node 3 -22.15 MB
Node 2  -6.05 MB
Node 1  -6.12 MB
Node 0 107.35 MB

As you can see we gained over 100MB on node 0. Spreading boot time
allocations around also helps us to avoid node 0 becoming the hot node.

--

Manfred Spraul <manfred@colorfullife.com>

Distribute the memory allocations that happen during boot to all nodes.
The memory will be touched by all cpus, binding all allocs to the boot 
node is wrong.

--

--- 2.6/mm/page_alloc.c	2003-11-29 09:46:35.000000000 +0100
+++ build-2.6/mm/page_alloc.c	2003-11-29 11:34:04.000000000 +0100
@@ -681,6 +681,42 @@
 
 EXPORT_SYMBOL(__alloc_pages);
 
+#ifdef CONFIG_NUMA
+/* Early boot: Everything is done by one cpu, but the data structures will be
+ * used by all cpus - spread them on all nodes.
+ */
+static __init unsigned long get_boot_pages(unsigned int gfp_mask, unsigned int order)
+{
+static int nodenr;
+	int i = nodenr;
+	struct page *page;
+
+	for (;;) {
+		if (i > nodenr + numnodes)
+			return 0;
+		if (node_present_pages(i%numnodes)) {
+			struct zone **z;
+			/* The node contains memory. Check that there is 
+			 * memory in the intended zonelist.
+			 */
+			z = NODE_DATA(i%numnodes)->node_zonelists[gfp_mask & GFP_ZONEMASK].zones;
+			while (*z) {
+				if ( (*z)->free_pages > (1UL<<order))
+					goto found_node;
+				z++;
+			}
+		}
+		i++;
+	}
+found_node:
+	nodenr = i+1;
+	page = alloc_pages_node(i%numnodes, gfp_mask, order);
+	if (!page)
+		return 0;
+	return (unsigned long) page_address(page);
+}
+#endif
+
 /*
  * Common helper functions.
  */
@@ -688,6 +724,10 @@
 {
 	struct page * page;
 
+#ifdef CONFIG_NUMA
+	if (unlikely(!system_running))
+		return get_boot_pages(gfp_mask, order);
+#endif
 	page = alloc_pages(gfp_mask, order);
 	if (!page)
 		return 0;
