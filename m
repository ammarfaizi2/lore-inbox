Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266562AbUBFHSL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 02:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266670AbUBFHSK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 02:18:10 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:10142 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S266562AbUBFHR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 02:17:58 -0500
Date: Thu, 05 Feb 2004 23:17:02 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@osdl.org>, Keith Mannthey <kmannth@us.ibm.com>
cc: Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
Subject: Re: [Bugme-new] [Bug 2019] New: Bug from the mm subsystem involving X  (fwd)
Message-ID: <98220000.1076051821@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.58.0402041800320.2086@home.osdl.org>
References: <51080000.1075936626@flay> <Pine.LNX.4.58.0402041539470.2086@home.osdl.org><60330000.1075939958@flay> <64260000.1075941399@flay><Pine.LNX.4.58.0402041639420.2086@home.osdl.org> <20040204165620.3d608798.akpm@osdl.org> <Pine.LNX.4.58.0402041719300.2086@home.osdl.org><1075946211.13163.18962.camel@dyn318004bld.beaverton.ibm.com> <Pine.LNX.4.58.0402041800320.2086@home.osdl.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Martin sent me a patch that fixed the X panics (NUMA and DISCONTIG
>> enabled).  (Thanks Martin!) I don't have the same X panics and issues I
>> had before. I don't know if this will work for the generic case. It
>> compiles with a simple memory situation just fine but I didn't boot it. 
> 
> Looks ok, but the thing should be made a function (possibly inline, 
> depending on how big the code generated ends up being). As it is, it now 
> uses its arguments several times, and while I don't see anything where 
> that could screw up, it's just a tad scary.

Yup, sorry about that. Unfortunately fixing that gets into a small problem
with the definition of pfn_to_nid. I've had a small patch pending for ages
to clean up that mess anyway, so now is probably the right time to push it. 

pfn_to_nid patch follows, and I'll send the (rejigged) original patch in
a follow-up email. Andrew - I'm pretty sure this works fine but could you
possibly test it in -mm for a bit? 

Thanks,

M.

--------------------------------

Makes sure pfn_to_nid is defined for all combinations of subarches,
and that it's defined before it's used so we don't run into implicit
declaration problems. 

diff -aurpN -X /home/fletch/.diff.exclude virgin/include/asm-i386/mmzone.h pfn_to_nid/include/asm-i386/mmzone.h
--- virgin/include/asm-i386/mmzone.h	Mon Nov 17 18:28:57 2003
+++ pfn_to_nid/include/asm-i386/mmzone.h	Thu Feb  5 20:58:00 2004
@@ -10,7 +10,49 @@
 
 #ifdef CONFIG_DISCONTIGMEM
 
+#ifdef CONFIG_NUMA
+	#ifdef CONFIG_X86_NUMAQ
+		#include <asm/numaq.h>
+	#else	/* summit or generic arch */
+		#include <asm/srat.h>
+	#endif
+#else /* !CONFIG_NUMA */
+	#define get_memcfg_numa get_memcfg_numa_flat
+	#define get_zholes_size(n) (0)
+#endif /* CONFIG_NUMA */
+
 extern struct pglist_data *node_data[];
+#define NODE_DATA(nid)		(node_data[nid])
+
+/*
+ * generic node memory support, the following assumptions apply:
+ *
+ * 1) memory comes in 256Mb contigious chunks which are either present or not
+ * 2) we will not have more than 64Gb in total
+ *
+ * for now assume that 64Gb is max amount of RAM for whole system
+ *    64Gb / 4096bytes/page = 16777216 pages
+ */
+#define MAX_NR_PAGES 16777216
+#define MAX_ELEMENTS 256
+#define PAGES_PER_ELEMENT (MAX_NR_PAGES/MAX_ELEMENTS)
+
+extern u8 physnode_map[];
+
+static inline int pfn_to_nid(unsigned long pfn)
+{
+#ifdef CONFIG_NUMA
+	return(physnode_map[(pfn) / PAGES_PER_ELEMENT]);
+#else
+	return 0;
+#endif
+}
+
+static inline struct pglist_data *pfn_to_pgdat(unsigned long pfn)
+{
+	return(NODE_DATA(pfn_to_nid(pfn)));
+}
+
 
 /*
  * Following are macros that are specific to this numa platform.
@@ -43,11 +85,6 @@ extern struct pglist_data *node_data[];
  */
 #define kvaddr_to_nid(kaddr)	pfn_to_nid(__pa(kaddr) >> PAGE_SHIFT)
 
-/*
- * Return a pointer to the node data for node n.
- */
-#define NODE_DATA(nid)		(node_data[nid])
-
 #define node_mem_map(nid)	(NODE_DATA(nid)->node_mem_map)
 #define node_start_pfn(nid)	(NODE_DATA(nid)->node_start_pfn)
 #define node_end_pfn(nid)						\
@@ -92,40 +129,6 @@ extern struct pglist_data *node_data[];
  * ( pfn_to_pgdat(pfn) && ((pfn) < node_end_pfn(pfn_to_nid(pfn))) ) 
  */ 
 #define pfn_valid(pfn)          ((pfn) < num_physpages)
-
-/*
- * generic node memory support, the following assumptions apply:
- *
- * 1) memory comes in 256Mb contigious chunks which are either present or not
- * 2) we will not have more than 64Gb in total
- *
- * for now assume that 64Gb is max amount of RAM for whole system
- *    64Gb / 4096bytes/page = 16777216 pages
- */
-#define MAX_NR_PAGES 16777216
-#define MAX_ELEMENTS 256
-#define PAGES_PER_ELEMENT (MAX_NR_PAGES/MAX_ELEMENTS)
-
-extern u8 physnode_map[];
-
-static inline int pfn_to_nid(unsigned long pfn)
-{
-	return(physnode_map[(pfn) / PAGES_PER_ELEMENT]);
-}
-static inline struct pglist_data *pfn_to_pgdat(unsigned long pfn)
-{
-	return(NODE_DATA(pfn_to_nid(pfn)));
-}
-
-#ifdef CONFIG_X86_NUMAQ
-#include <asm/numaq.h>
-#elif CONFIG_ACPI_SRAT
-#include <asm/srat.h>
-#elif CONFIG_X86_PC
-#define get_zholes_size(n) (0)
-#else
-#define pfn_to_nid(pfn)		(0)
-#endif /* CONFIG_X86_NUMAQ */
 
 extern int get_memcfg_numa_flat(void );
 /*
diff -aurpN -X /home/fletch/.diff.exclude virgin/include/linux/mmzone.h pfn_to_nid/include/linux/mmzone.h
--- virgin/include/linux/mmzone.h	Wed Feb  4 23:03:38 2004
+++ pfn_to_nid/include/linux/mmzone.h	Thu Feb  5 21:01:05 2004
@@ -311,6 +311,7 @@ extern struct pglist_data contig_page_da
 #define NODE_DATA(nid)		(&contig_page_data)
 #define NODE_MEM_MAP(nid)	mem_map
 #define MAX_NODES_SHIFT		1
+#define pfn_to_nid(pfn)		(0)
 
 #else /* CONFIG_DISCONTIGMEM */
 

