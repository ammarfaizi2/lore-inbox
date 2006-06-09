Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965094AbWFINtE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965094AbWFINtE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 09:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965187AbWFINtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 09:49:04 -0400
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:14281
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S965094AbWFINtD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 09:49:03 -0400
Date: Fri, 9 Jun 2006 14:48:50 +0100
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Chad Reese <creese@caviumnetworks.com>,
       Andy Whitcroft <apw@shadowen.org>
Subject: [PATCH] mem_map is part of the FLATMEM model
Message-ID: <20060609134850.GA20794@shadowen.org>
References: <447DCBAD.8070307@shadowen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
InReply-To: <447DCBAD.8070307@shadowen.org>
User-Agent: Mutt/1.5.11+cvs20060403
From: Andy Whitcroft <apw@shadowen.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As Ralf Baechle points out the definition and the declaration of
mem_map are made under differing config options.  This leads to
difficulty tracking errant references to mem_map when it is not
available.  Below is a patch to sort out the mem_map definition,
making the fact that it is part of the FLATMEM memory model explicit.

It builds and boots on all my test boxes.  It build tests for
all sane combinations of memory model on x86.  The most likely
architecture to have trouble with this is arm as it makes significant
use of mem_map, but as far as I know it uses FLATMEM and should
be fine.  Testing there would be helpful.

-apw

=== 8< ===
mem_map is part of the FLATMEM model

It seems that the definition and declaration of mem_map are
inconsistent meaning we get usless undirected link failures about
mem_map when its being used when it shouldn't be.

Reviewing mem_map, its actually only valid and initialised when
CONFIG_FLATMEM is defined.  Indeed in all essence it is part
of that memory model used out of FLATMEM's __pfn_to_page etc.
mem_map (and max_mapnr) should only be defined and declared when
the FLATMEM memory model is selected.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
 include/linux/mm.h     |    6 +++---
 include/linux/mmzone.h |    5 ++++-
 mm/memory.c            |    2 +-
 3 files changed, 8 insertions(+), 5 deletions(-)
diff -upN reference/include/linux/mm.h current/include/linux/mm.h
--- reference/include/linux/mm.h
+++ current/include/linux/mm.h
@@ -19,7 +19,7 @@
 struct mempolicy;
 struct anon_vma;
 
-#ifndef CONFIG_DISCONTIGMEM          /* Don't use mapnrs, do it properly */
+#ifdef CONFIG_FLATMEM          /* Don't use mapnrs, do it properly */
 extern unsigned long max_mapnr;
 #endif
 
@@ -529,8 +529,8 @@ static inline void set_page_links(struct
 	set_page_section(page, pfn_to_section_nr(pfn));
 }
 
-#ifndef CONFIG_DISCONTIGMEM
-/* The array of struct pages - for discontigmem use pgdat->lmem_map */
+#ifdef CONFIG_FLATMEM
+/* The array of struct pages, only used in FLATMEM */
 extern struct page *mem_map;
 #endif
 
diff -upN reference/include/linux/mmzone.h current/include/linux/mmzone.h
--- reference/include/linux/mmzone.h
+++ current/include/linux/mmzone.h
@@ -424,11 +424,14 @@ int percpu_pagelist_fraction_sysctl_hand
 #define numa_node_id()		(cpu_to_node(raw_smp_processor_id()))
 #endif
 
+#ifdef CONFIG_FLATMEM
+#define NODE_MEM_MAP(nid)	mem_map
+#endif
+
 #ifndef CONFIG_NEED_MULTIPLE_NODES
 
 extern struct pglist_data contig_page_data;
 #define NODE_DATA(nid)		(&contig_page_data)
-#define NODE_MEM_MAP(nid)	mem_map
 #define MAX_NODES_SHIFT		1
 
 #else /* CONFIG_NEED_MULTIPLE_NODES */
diff -upN reference/mm/memory.c current/mm/memory.c
--- reference/mm/memory.c
+++ current/mm/memory.c
@@ -59,7 +59,7 @@
 #include <linux/swapops.h>
 #include <linux/elf.h>
 
-#ifndef CONFIG_NEED_MULTIPLE_NODES
+#ifdef CONFIG_FLATMEM
 /* use the per-pgdat data instead for discontigmem - mbligh */
 unsigned long max_mapnr;
 struct page *mem_map;
